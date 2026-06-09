DESCRIPTION = "NVIDIA container runtime hostapp-extension"
LICENSE = "MIT"

inherit balena-hostapp-extension

# CUDA-relevant L4T driver stack + the two toolkit binaries + the boot-time
# CDI setup oneshot + the camera stack (Argus). The libglvnd-tegra
# PREFERRED_PROVIDER override in our layer.conf lets the camera/multimedia
# packages resolve virtual/libgles2; without it they were silently
# excluded by meta-tegra's recipe-resolution machinery.
# Still dropped: tegra-libraries-multimedia-v4l (V4L2 codec, Orin Nano
# media block doesn't expose nvenc/nvdec nodes), tegra-libraries-omx
# (legacy OpenMAX, deprecated), tegra-libraries-glxcore (X11-only, balena
# is headless), tegra-libraries-vulkan (not needed for camera + CUDA).
IMAGE_INSTALL = "base-files \
    tegra-container-passthrough \
    tegra-libraries-core \
    tegra-libraries-cuda \
    tegra-libraries-eglcore \
    tegra-libraries-glescore \
    tegra-libraries-nvml \
    tegra-libraries-nvsci \
    tegra-libraries-dla-compiler \
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

# Drop kernel-override-hooks bbclass auto-appends — its hooks/create
# misdetects non-kernel extensions and blocks install. See memory
# project-extension-install-succeeded.
IMAGE_INSTALL:remove = "kernel-override-hooks"

IMAGE_LINGUAS = ""
VIRTUAL-RUNTIME_init_manager = ""
INITRAMFS_IMAGE = ""
IMAGE_FSTYPES = "tar.gz"

# Strip top-level cruft but preserve /etc (we need /etc/nvidia-container-runtime/
# from tegra-configs-container-csv) and /lib/firmware (we need the GPU firmware
# blobs from tegra-firmware). /etc/cdi is intentionally NOT shipped any more —
# the spec is now generated at boot by balena-nvidia-setup.service.
remove_unnecessary_files() {
    rm -f ${IMAGE_ROOTFS}/bin ${IMAGE_ROOTFS}/sbin
    rm -rf ${IMAGE_ROOTFS}/run
    rm -rf ${IMAGE_ROOTFS}/var
}
IMAGE_PREPROCESS_COMMAND += "remove_unnecessary_files;"

# Strip /usr/lib/modules/<kver>/* — tegra-libraries-camera RDEPENDS pulls in
# V4L2 framework kernel modules (videobuf2-*.ko.zst, mc.ko.zst, v4l2-async.ko.zst,
# etc.). Their mere presence in the extension's rootfs triggers mobynit's
# FilterByKernelABIID at boot, which then requires an io.balena.image.kernel-abi-id
# label. balena-hostapp-extension.bbclass only stamps that label when the recipe
# is detected as a "kernel-override extension" (has Module.symvers + kernel image).
# Since we have neither, the label is missing, and mobynit silently rejects the
# extension from the rootfs lowerdir — install runs cleanly (rc=0) but the
# overlay never merges. We don't need these modules in the extension anyway;
# the OS rootfs / kernel already provides them. Bisected to commit 934b50c
# (release 235279). 2026-06-09.
strip_kernel_modules() {
    rm -rf ${IMAGE_ROOTFS}/usr/lib/modules
    rm -rf ${IMAGE_ROOTFS}/lib/modules
    rm -rf ${IMAGE_ROOTFS}/usr/lib/modules-load.d
}
IMAGE_PREPROCESS_COMMAND += "strip_kernel_modules;"
