DESCRIPTION = "NVIDIA container runtime hostapp-extension"
LICENSE = "MIT"

inherit balena-hostapp-extension

# CUDA-relevant L4T driver stack + the two toolkit binaries + the boot-time
# CDI setup oneshot. Dropped camera/multimedia/omx recipes here pending
# the libglvnd-tegra PREFERRED_PROVIDER fix; nvidia-ctk auto-filters those
# libs from the generated CDI spec, so excluding them is safe — only apps
# actually exercising camera/multimedia APIs will notice the gap.
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
    nvidia-container-toolkit-cdi-hook \
    nvidia-container-toolkit-ctk \
    balena-nvidia-cdi-setup"

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
# the spec is now generated at boot by balena-nvidia-cdi-setup.service.
remove_unnecessary_files() {
    rm -f ${IMAGE_ROOTFS}/bin ${IMAGE_ROOTFS}/sbin
    rm -rf ${IMAGE_ROOTFS}/run
    rm -rf ${IMAGE_ROOTFS}/var
}
IMAGE_PREPROCESS_COMMAND += "remove_unnecessary_files;"
