DESCRIPTION = "NVIDIA container runtime hostapp-extension"
LICENSE = "MIT"

inherit balena-hostapp-extension

# CUDA-only PoC. Dropped camera/multimedia*/omx recipes which would force
# us to override PREFERRED_PROVIDER_virtual/{egl,libgl,libgles2} to
# libglvnd-tegra (balena distro currently uses plain libglvnd which does
# not provide virtual/libgles2). Add them back once the libglvnd-tegra
# preferred-provider story is sorted.
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
    nvidia-container-toolkit-cdi-hook"

IMAGE_INSTALL:remove = "kernel-override-hooks"

# Drop in the patched CDI spec (Phase 1 yaml with hostPaths rewritten to
# match Yocto's flat /usr/lib/ layout). Image recipes do not have a
# fetch/unpack step the way normal recipes do, so reference the layer
# file directly via THISDIR rather than ${WORKDIR}.
install_cdi_spec() {
    install -d ${IMAGE_ROOTFS}/etc/cdi
    install -m 0644 ${THISDIR}/files/balena-gpu-patched-yocto.yaml \
        ${IMAGE_ROOTFS}/etc/cdi/balena-gpu.yaml
}
IMAGE_PREPROCESS_COMMAND += "install_cdi_spec; "

IMAGE_LINGUAS = ""
VIRTUAL-RUNTIME_init_manager = ""
INITRAMFS_IMAGE = ""
IMAGE_FSTYPES = "tar.gz"

remove_unnecessary_files() {
    rm -f ${IMAGE_ROOTFS}/bin ${IMAGE_ROOTFS}/sbin
    rm -rf ${IMAGE_ROOTFS}/run
    rm -rf ${IMAGE_ROOTFS}/var
}
IMAGE_PREPROCESS_COMMAND += "remove_unnecessary_files;"
