FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " \
    file://0004-Add-symbolic-links-support.patch \
    file://0005-Add-hup-and-rollback-support.patch \
"

do_deploy:append() {
     mkdir -p ${DEPLOYDIR}/bootfiles/EFI/BOOT/
     cp ${WORKDIR}/build/images/BOOTAA64.efi ${DEPLOYDIR}/bootfiles/EFI/BOOT/BOOTAA64.efi
}

