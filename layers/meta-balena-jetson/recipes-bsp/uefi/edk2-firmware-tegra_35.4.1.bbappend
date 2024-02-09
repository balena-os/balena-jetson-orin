FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " \ 
    file://0004-Add-symbolic-links-support-32-5-2.patch;patchdir=.. \
    file://0006-boot.patch;patchdir=.. \
"

SRC_URI:append:jetson-agx-orin-devkit = " \
    file://0005-Add-hup-and-rollback-support-agx-orin-32-5-2.patch;patchdir=.. \
"

SRC_URI:append:jetson-orin-nx-xavier-nx-devkit = " \ 
    file://0005-L4TLauncher-hup-rollback-support-orin-nx.patch;patchdir=.. \
    file://set_boot_order.patch;patchdir=.. \
"

SRC_URI:append:jetson-orin-nano-devkit-nvme = " \
    file://0005-Add-hup-and-rollback-support-orin-nano-35-3-1.patch;patchdir=.. \
    file://set_boot_order.patch;patchdir=.. \
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
SRC_URI:append:jetson-xavier = " \
    file://0005-Add-hup-and-rollback-support-agx-xavier-35-4-1.patch;patchdir=.. \
"
# We generate the final nvdisp-init.bin file in tegra194-flash* using
# the original one provided in the tegra BSP archive
NVDISPLAY_INIT_DEFAULT:tegra194=""

