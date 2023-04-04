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
"

SRC_URI:append:jetson-xavier = " \
    file://0006-Add-hup-and-rollback-support-agx-xav.patch;patchdir=.. \
"

SRC_URI:append:jetson-xavier-nx-devkit = " \
    file://0007-Add-hup-and-rollback-support-xav-nx.patch;patchdir=.. \
"

SRC_URI:append:jetson-xavier-nx-devkit-emmc = " \
    file://0007-Add-hup-and-rollback-support-xav-nx.patch;patchdir=.. \
"

# Removed for now, pending test results
#SRC_URI:remove:forecr-dsb-nx2-xavier-nx-emmc = "file://0007-Add-hup-and-rollback-support-xav-nx.patch;patchdir=.."
#SRC_URI:append:forecr-dsb-nx2-xavier-nx-emmc = " 
#    file://0008-Add-hup-and-rollback-support-forecr-dsb-nx2.patch;patchdir=.. 
#"

do_deploy:append() {
     mkdir -p ${DEPLOYDIR}/bootfiles/EFI/BOOT/
     cp ${WORKDIR}/build/images/BOOTAA64.efi ${DEPLOYDIR}/bootfiles/EFI/BOOT/BOOTAA64.efi
}

# We generate the final nvdisp-init.bin file in tegra194-flash* using
# the original one provided in the tegra BSP archive
NVDISPLAY_INIT_DEFAULT:tegra194=""
