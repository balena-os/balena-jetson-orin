DESCRIPTION = "NVIDIA container runtime hostapp-extension"
LICENSE = "MIT"

inherit balena-hostapp-extension

# Placeholder rootfs to exercise the build pipeline. Replaced with the
# actual NVIDIA stack on a follow-on branch. See phase2-extension-plan.md.
IMAGE_INSTALL = "base-files"

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
