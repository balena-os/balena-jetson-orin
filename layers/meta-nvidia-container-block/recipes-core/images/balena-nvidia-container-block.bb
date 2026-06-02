DESCRIPTION = "NVIDIA container runtime hostapp-extension"
LICENSE = "MIT"

inherit balena-hostapp-extension

# Step 1: add L4T driver libs from meta-tegra's tegra-container-passthrough.
# Stages camera, gstreamer, wayland, weston (+ V4L2 subset of multimedia)
# at ${datadir}/nvidia-container-passthrough/usr/lib/aarch64-linux-gnu/
# i.e. /usr/share/nvidia-container-passthrough/usr/lib/... in the image.
# Total ~365 MB of NVIDIA-redistributed L4T binaries.
IMAGE_INSTALL = "base-files tegra-container-passthrough"

# Our extension does not ship a kernel — drop kernel-override-hooks that
# the balena-hostapp-extension bbclass auto-appends. The package's hooks
# call extension_kernel_override_prelude which mis-detects non-kernel
# extensions as kernel-override misbuilds (returns rc=2 with "kernel
# image present but Module.symvers missing"), blocking install.
# Verified 2026-06-01: install completes end-to-end on Jetson Orin when
# these hooks are absent. See memory: project-extension-install-succeeded.
IMAGE_INSTALL:remove = "kernel-override-hooks"

IMAGE_LINGUAS = ""
VIRTUAL-RUNTIME_init_manager = ""
INITRAMFS_IMAGE = ""
IMAGE_FSTYPES = "tar.gz"

remove_unnecessary_files() {
    rm -f ${IMAGE_ROOTFS}/bin ${IMAGE_ROOTFS}/sbin
    rm -rf ${IMAGE_ROOTFS}/etc
    rm -rf ${IMAGE_ROOTFS}/run
    rm -rf ${IMAGE_ROOTFS}/var
}
IMAGE_PREPROCESS_COMMAND += "remove_unnecessary_files;"
