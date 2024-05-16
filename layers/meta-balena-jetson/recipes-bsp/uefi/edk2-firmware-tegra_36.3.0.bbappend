FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " \
    file://0001-boot2.patch;patchdir=../edk2-nvidia \
    file://0001-platform.patch;patchdir=../edk2-nvidia \ 
    file://0001-edk2-Disable-PXE-and-HTTP-boot.patch;patchdir=../edk2 \
    file://0001-FmpDevicePkg-Force-accept-old-UEFI-capsule.patch;patchdir=../edk2 \
    file://0001-TegraVirt-Set-UEFI-boot-timeout-to-5-seconds.patch;patchdir=../edk2-nvidia \
    file://0001-BootChainDxePrivate-Increase-maximum-bootchain-retry.patch;patchdir=../edk2-nvidia \
"

SRC_URI:append:jetson-agx-orin-devkit = " \
    file://0005-Add-hup-and-rollback-support-agx-orin-36-2.patch;patchdir=../edk2-nvidia \
"

SRC_URI:append:jetson-orin-nx-xavier-nx-devkit = " \ 
    file://0005-L4TLauncher-hup-rollback-support-orin-nx.patch;patchdir=.. \
"

SRC_URI:append:jetson-orin-nano-devkit-nvme = " \
    file://0005-Add-hup-and-rollback-support-orin-nano-36-3.patch;patchdir=../edk2-nvidia \
    file://0002-Switch-boot-chains-when-bootcount-limit-is-reached.patch;patchdir=../edk2-nvidia \
    file://0001-L4TLauncher-Don-t-override-bootchain-with-rootfs-cha.patch;patchdir=../edk2-nvidia \
"

SRC_URI:remove:jetson-orin-nx-seeed-j4012 = " \
    file://0005-L4TLauncher-hup-rollback-support-orin-nx.patch;patchdir=.. \
"

SRC_URI:append:jetson-orin-nx-seeed-j4012 = " \
    file://0005-L4TLauncher-hup-rollback-support-orin-nx-seed-j4012.patch;patchdir=.. \
"

do_deploy:append() {
     mkdir -p ${DEPLOYDIR}/bootfiles/EFI/BOOT/
     cp ${WORKDIR}/build/images/BOOTAA64.efi ${DEPLOYDIR}/bootfiles/EFI/BOOT/BOOTAA64.efi
}


