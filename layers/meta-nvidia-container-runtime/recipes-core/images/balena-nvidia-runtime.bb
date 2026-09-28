DESCRIPTION = "NVIDIA container runtime hostapp-extension (legacy --runtime=nvidia)"
LICENSE = "MIT"

inherit balena-hostapp-extension

# The L4T driver stack, the legacy toolkit binaries, and the boot-time setup
# oneshot. See docs/design.md for what is included and what is deliberately not.
IMAGE_INSTALL = "base-files \
    tegra-container-passthrough \
    tegra-libraries-core \
    tegra-libraries-cuda \
    tegra-libraries-eglcore \
    tegra-libraries-glescore \
    tegra-libraries-nvml \
    tegra-libraries-nvsci \
    tegra-libraries-gbm-backend \
    tegra-cuda-utils \
    tegra-firmware \
    tegra-configs-container-csv \
    nv-tegra-release \
    nvidia-container-toolkit \
    tegra-libraries-multimedia \
    tegra-libraries-multimedia-utils \
    tegra-libraries-camera \
    balena-nvidia-setup"

# kernel-override-hooks is appended by the bbclass and deliberately kept: the
# hooks no-op for a non-kernel extension. See docs/design.md.

# IMAGE_FSTYPES, IMAGE_LINGUAS, VIRTUAL-RUNTIME_init_manager and INITRAMFS_IMAGE
# are all set by balena-hostapp-extension.bbclass - no need to repeat them.

# Default is "etc run var". /etc holds the container mount spec and /var holds
# the camera ISP tuning data; dropping either fails silently. See docs/design.md.
HOSTAPP_EXTENSION_REMOVE_PATHS = "run bin sbin"

# override=200 opts into shadowing, not just extending - the payload lands
# libraries in paths the base OS also populates. See docs/design.md#image-labels.
HOSTAPP_EXTENSION_LABEL_CLASS           = "overlay"
HOSTAPP_EXTENSION_LABEL_STORE           = "data"
HOSTAPP_EXTENSION_LABEL_REQUIRES_REBOOT = "1"
HOSTAPP_EXTENSION_LABEL_OVERRIDE        = "200"

# io.balena.image.os-version is deliberately NOT set here; the bbclass stamps the
# exact OS version and that is correct. See docs/os-version.md.

# Everything under /var goes except /var/nvidia (ISP tuning data). The bbnotes
# are deliberate - this content vanishing is invisible until a camera client
# connects. See docs/rootfs-assembly.md.
strip_var_except_nvidia() {
    if [ ! -d "${IMAGE_ROOTFS}/var" ]; then
        bbnote "balena-nvidia-runtime: no /var in rootfs at preprocess time"
        return 0
    fi
    bbnote "balena-nvidia-runtime: /var before strip: [$(ls ${IMAGE_ROOTFS}/var 2>&1 | tr '\n' ' ')]"
    find ${IMAGE_ROOTFS}/var -mindepth 1 -maxdepth 1 ! -name nvidia -exec rm -rf {} +
    bbnote "balena-nvidia-runtime: /var after strip:  [$(ls ${IMAGE_ROOTFS}/var 2>&1 | tr '\n' ' ')]"
}
IMAGE_PREPROCESS_COMMAND += "strip_var_except_nvidia;"

# tegra-libraries-camera drags in V4L2 kernel modules via RDEPENDS. Their mere
# presence makes mobynit silently refuse to merge the extension, with the install
# still exiting 0. See docs/rootfs-assembly.md#strip_kernel_modules.
strip_kernel_modules() {
    for relpath in usr/lib/modules lib/modules usr/lib/modules-load.d lib/modules-load.d; do
        moddir="${IMAGE_ROOTFS}/$relpath"
        if [ -e "$moddir" ]; then
            bbnote "balena-nvidia-runtime: stripping kernel module content from /$relpath"
            rm -rf "$moddir"
        fi
    done
}
IMAGE_PREPROCESS_COMMAND += "strip_kernel_modules;"

# Drop the two toolkit binaries the legacy route has no path to (~20 MB), making
# "legacy only" enforced rather than intended. See docs/rootfs-assembly.md.
strip_unused_toolkit_binaries() {
    for binary in nvidia-cdi-hook nvidia-ctk-installer; do
        if [ -e "${IMAGE_ROOTFS}${bindir}/$binary" ]; then
            bbnote "balena-nvidia-runtime: dropping unused ${bindir}/$binary"
            rm -f "${IMAGE_ROOTFS}${bindir}/$binary"
        fi
    done
}
IMAGE_PREPROCESS_COMMAND += "strip_unused_toolkit_binaries;"

# Mirror meta-tegra's passthrough tree into the canonical multiarch paths the
# CSVs reference, so the hook resolves them at /.
# See docs/rootfs-assembly.md#link_passthrough_canonical_paths.
link_passthrough_canonical_paths() {
    passthrough="${IMAGE_ROOTFS}/usr/share/nvidia-container-passthrough"
    [ -d "$passthrough" ] || return 0

    # HARDLINKS, not symlinks: the CSV locator resolves symlinks and mounts at
    # the RESOLVED path, so symlinks land the library at the wrong destination.
    find "$passthrough" -mindepth 1 -type f -printf '%P\n' | while read -r relpath; do
        dest="${IMAGE_ROOTFS}/$relpath"
        # Never shadow something the real rootfs already provides.
        if [ -e "$dest" ] || [ -L "$dest" ]; then
            continue
        fi
        mkdir -p "$(dirname "$dest")"
        ln "$passthrough/$relpath" "$dest"
    done

    # Symlinks within the tree stay symlinks, keeping their relative target so
    # they resolve against the canonical directory they land in.
    find "$passthrough" -mindepth 1 -type l -printf '%P\n' | while read -r relpath; do
        dest="${IMAGE_ROOTFS}/$relpath"
        if [ -e "$dest" ] || [ -L "$dest" ]; then
            continue
        fi
        mkdir -p "$(dirname "$dest")"
        cp -a "$passthrough/$relpath" "$dest"
    done

    bbnote "balena-nvidia-runtime: mirrored passthrough tree into canonical paths"
}
IMAGE_PREPROCESS_COMMAND += "link_passthrough_canonical_paths;"

# Backstop: strip_kernel_modules only knows the paths that have bitten us, so
# sweep the whole rootfs and fail loudly on anything new. Must run after it.
assert_no_kernel_modules() {
    leaked=$(find ${IMAGE_ROOTFS} \
        \( -path '*/lib/modules/*' \
        -o -path '*/modules-load.d/*' \
        -o -name '*.ko' -o -name '*.ko.gz' -o -name '*.ko.xz' -o -name '*.ko.zst' \) \
        -print 2>/dev/null | sed "s|^${IMAGE_ROOTFS}||" | head -50)
    if [ -n "$leaked" ]; then
        bbwarn "balena-nvidia-runtime: offending paths (first 50):"
        echo "$leaked" | while read -r path; do bbwarn "  $path"; done
        bbfatal "balena-nvidia-runtime: kernel module content found in the extension rootfs; mobynit will silently refuse to merge this extension on device. See docs/rootfs-assembly.md and the listing above."
    fi
}
IMAGE_PREPROCESS_COMMAND += "assert_no_kernel_modules;"
