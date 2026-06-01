DESCRIPTION = "NVIDIA container runtime hostapp-extension"
LICENSE = "MIT"

inherit balena-hostapp-extension

# Placeholder rootfs to exercise the build pipeline. Replaced with the
# actual NVIDIA stack on a follow-on branch. See phase2-extension-plan.md.
IMAGE_INSTALL = "base-files"

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
