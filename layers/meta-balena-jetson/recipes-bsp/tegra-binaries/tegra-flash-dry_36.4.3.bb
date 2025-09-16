FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SUMMARY = "Deploy compressed flash artifacts"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${BALENA_COREBASE}/COPYING.Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

inherit deploy

PN = "tegra-flash-dry"

# SPI flash images dumped after flashing the bootloader from L4T
BOOTBLOB:jetson-agx-orin-devkit = "boot0_agx_orin_devkit.img.gz"
BOOTBLOB:jetson-agx-orin-devkit-64gb = "boot0_agx_orin_devkit_64.img.gz"
BOOTBLOB:jetson-orin-nx-xavier-nx-devkit = "boot0_orin_nx_xavier_nx_devkit_super.img.gz"
BOOTBLOB:jetson-orin-nano-devkit-nvme = "boot0_orin_nano_devkit_nvme_super.img.gz"
BOOTBLOB:jetson-orin-nx-seeed-j4012 = "boot0_orin_nx_seed_j4012.img.gz"
BOOTBLOB:jetson-orin-nano-seeed-j3010 = "boot0_orin_nano_seeed_j3010_super.img.gz"

# Forecr bootloader blobs built with L4T 36.3 with the vendor BSP applied
# (pinmux, gpio, uphy, eeprom dtbs -- follow replace_bsp_files.sh from the BSP)
# Note the -dynamic overlay goes into the bootloader as well.
BOOTBLOB:forecr-dsb-ornx-orin-nano-8gb = "boot0_forecr_dsb_ornx_lan_orin_nano_8gb.img.gz"

PARTSPEC:jetson-agx-orin-devkit = "partition_specification234.txt"
PARTSPEC:jetson-orin-nx-xavier-nx-devkit = "partition_specification234.txt"
PARTSPEC:jetson-orin-nano-devkit-nvme = "partition_specification234_orin_nano.txt"
PARTSPEC:jetson-orin-nx-seeed-j4012 = "partition_specification234_orin_nano.txt"
PARTSPEC:jetson-orin-nano-seeed-j3010 = "partition_specification234_orin_nano.txt"
PARTSPEC:jetson-agx-orin-devkit-64gb = "partition_specification234_orin_nano.txt"
PARTSPEC:forecr-dsb-ornx-lan = "partition_specification234_orin_nano.txt"

BINARY_INSTALL_PATH = "/opt/tegra-binaries/"

SRC_URI = " \
    file://${BOOTBLOB};unpack=0 \
    file://${PARTSPEC} \
"

do_install() {
    # Ensure install is not executed until
    # do_unpack copies the archive
    while [ ! -f ${WORKDIR}/${BOOTBLOB} ]
    do
        sleep 1
        bbwarn "waiting for ${WORKDIR}/${BOOTBLOB}"
    done

    install -d ${D}/${BINARY_INSTALL_PATH}
    install ${WORKDIR}/${BOOTBLOB} ${D}/${BINARY_INSTALL_PATH}/boot0.img.gz
    install ${WORKDIR}/${PARTSPEC} ${D}/${BINARY_INSTALL_PATH}/
}

do_deploy() {
    rm -rf ${DEPLOY_DIR_IMAGE}/$(basename ${BINARY_INSTALL_PATH}) || true
    mkdir -p ${DEPLOY_DIR_IMAGE}/$(basename ${BINARY_INSTALL_PATH})
    cp -r ${D}/${BINARY_INSTALL_PATH}/* ${DEPLOY_DIR_IMAGE}/$(basename ${BINARY_INSTALL_PATH})
}

FILES:${PN} += " \
    /opt/tegra-binaries/* \
"

do_configure(){
    :
}

do_compile(){
    :
}

INHIBIT_PACKAGE_STRIP = "1"
INHIBIT_PACKAGE_DEBUG_SPLIT = "1"

# need to be redeployed on each build
# as this path is not cached
do_install[nostamp]="1"
do_deploy[nostamp]="1"
do_unpack[nostamp]="1"

addtask do_deploy before do_package after do_install
