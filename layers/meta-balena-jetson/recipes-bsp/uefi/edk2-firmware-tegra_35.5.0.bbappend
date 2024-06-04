FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " \ 
    file://0001-Add-symbolic-links-support-35-5-0.patch;patchdir=.. \
    file://0002-boot.patch;patchdir=.. \
    file://0003-skip_network_boot.patch;patchdir=.. \
    file://0004-FmpDevicePkg-Force-accept-old-UEFI-capsule.patch;patchdir=../edk2 \
    file://0005-BootChainDxePrivate-Increase-maximum-bootchain-retry.patch;patchdir=../edk2-nvidia \
    file://0006-L4TLauncher-Don-t-override-bootchain-with-rootfs-cha.patch;patchdir=../edk2-nvidia \
"

SRC_URI:append:jetson-agx-orin-devkit = " \
    file://Add-hup-and-rollback-support-agx-orin-35-5-0.patch;patchdir=.. \
"

SRC_URI:append:jetson-orin-nx-xavier-nx-devkit = " \
    file://0007-set-boot-order.patch;patchdir=.. \
    file://Add-hup-and-rollback-support-orin-nx-35-5-0.patch;patchdir=../edk2-nvidia \
"

SRC_URI:append:jetson-orin-nano-devkit-nvme = " \
    file://0007-set-boot-order.patch;patchdir=.. \
    file://Add-hup-and-rollback-support-orin-nano-35-5-0.patch;patchdir=.. \
"

SRC_URI:append:jetson-orin-nx-seeed-j4012 = " \
    file://Add-hup-and-rollback-support-orin-nx-seed-j4012-35-5-0.patch;patchdir=../edk2-nvidia \ 
"

do_deploy:append() {
     mkdir -p ${DEPLOYDIR}/bootfiles/EFI/BOOT/
     cp ${WORKDIR}/build/images/BOOTAA64.efi ${DEPLOYDIR}/bootfiles/EFI/BOOT/BOOTAA64.efi
}

# We generate the final nvdisp-init.bin file in tegra194-flash* using
# the original one provided in the tegra BSP archive
NVDISPLAY_INIT_DEFAULT:tegra194=""

