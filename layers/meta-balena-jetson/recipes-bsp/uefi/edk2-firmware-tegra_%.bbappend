FILESEXTRAPATHS:append := ":${THISDIR}/files"

SRC_URI:append = " \
    file://0002-Increase-max-bootchain-retry-so-that-it-does-not-int.patch;patchdir=../edk2-nvidia \
    file://0003-edk2-Disable-network-boot-and-allow-UEFI-capsule-dow.patch;patchdir=../edk2 \
"

# file://0001-AGX-Thor-Enable-booting-with-balenaOS.patch;patchdir=../edk2-nvidia

do_deploy:append() {
    rm -rf ${DEPLOY_DIR_IMAGE}/bootfiles/EFI/BOOT || true
    mkdir -p ${DEPLOY_DIR_IMAGE}/bootfiles/EFI/BOOT/
    cp ${B}/images/BOOTAA64.efi ${DEPLOY_DIR_IMAGE}/bootfiles/EFI/BOOT/
}

do_deploy[nostamp] = "1"
