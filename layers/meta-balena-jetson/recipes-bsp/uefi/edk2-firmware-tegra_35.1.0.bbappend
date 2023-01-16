FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " \
    file://0004-Add-symbolic-links-support.patch \
"

SRC_URI:append:jetson-agx-orin-devkit = " \
    file://0005-Add-hup-and-rollback-support.patch \
"

SRC_URI:append:jetson-xavier = " \
    file://0006-Add-hup-and-rollback-support-agx-xav.patch \
"

SRC_URI:append:jetson-xavier-nx-devkit = " \
    file://0007-Add-hup-and-rollback-support-xav-nx.patch \
"

SRC_URI:append:jetson-xavier-nx-devkit-emmc = " \
    file://0007-Add-hup-and-rollback-support-xav-nx.patch \
"

do_deploy:append() {
     mkdir -p ${DEPLOYDIR}/bootfiles/EFI/BOOT/
     cp ${WORKDIR}/build/images/BOOTAA64.efi ${DEPLOYDIR}/bootfiles/EFI/BOOT/BOOTAA64.efi
}

NVDISPLAY_INIT_DEFAULT:tegra194=""
