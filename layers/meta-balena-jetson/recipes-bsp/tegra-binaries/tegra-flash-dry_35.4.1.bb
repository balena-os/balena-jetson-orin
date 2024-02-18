SUMMARY = "Deploy compressed flash artifacts"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${BALENA_COREBASE}/COPYING.Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

inherit deploy

PN = "tegra-flash-dry"

BOOTBLOB:jetson-agx-orin-devkit = "boot0_agx_orin_devkit.img.gz"
UEFI_CAPSULE:jetson-orin-nx-xavier-nx-devkit = "TEGRA_BL_Orin_NX.Cap.gz"
UEFI_CAPSULE:jetson-agx-orin-devkit = "TEGRA_BL_3701.Cap.gz"
UEFI_CAPSULE:jetson-orin-nano-devkit-nvme = "TEGRA_BL_Orin_Nano.Cap.gz"
UEFI_CAPSULE:jetson-orin-nx-seeed-j4012 = "TEGRA_BL_Seeed_j4012.Cap.gz"
UEFI_CAPSULE:jetson-xavier = "TEGRA_BL_Xavier_AGX.Cap.gz"
UEFI_CAPSULE:jetson-xavier-nx-devkit-emmc = "TEGRA_BL_Xavier_NX_eMMC.Cap.gz"

BOOTBLOB:jetson-orin-nx-xavier-nx-devkit = "boot0_orin_nx_xavier_nx_devkit.img.gz"
BOOTBLOB:jetson-orin-nano-devkit-nvme = "boot0_orin_nano_devkit_nvme.img.gz"
BOOTBLOB:jetson-orin-nx-seeed-j4012 = "boot0_orin_nx_seed_j4012.img.gz"
BOOTBLOB:jetson-xavier = "bins_agx_xavier.tar.gz"
BOOTBLOB:jetson-xavier-nx-devkit-emmc = "boot0_xavier_nx_emmc.tar.gz"

PARTSPEC:jetson-agx-orin-devkit = "partition_specification234.txt"
PARTSPEC:jetson-orin-nx-xavier-nx-devkit = "partition_specification234.txt"
PARTSPEC:jetson-orin-nano-devkit-nvme = "partition_specification234_orin_nano.txt"
PARTSPEC:jetson-orin-nx-seeed-j4012 = "partition_specification234_orin_nano.txt"
PARTSPEC:jetson-xavier = "partition_specification194.txt"
PARTSPEC:jetson-xavier-nx-devkit-emmc = "partition_specification194_nxde.txt"


BINARY_INSTALL_PATH = "/opt/tegra-binaries/"

SRC_URI = " \
    file://${BOOTBLOB};unpack=0 \
    file://${PARTSPEC} \
    file://${UEFI_CAPSULE};unpack=0 \
"

do_install() {
    # Ensure install is not executed until
    # do_unpack copies the archive
    while [ ! -f ${WORKDIR}/${BOOTBLOB} ]
    do
        sleep 1
    done

    while [ ! -f ${WORKDIR}/${UEFI_CAPSULE} ]
    do
        sleep 1
    done

    install -d ${D}/${BINARY_INSTALL_PATH}
    install ${WORKDIR}/${BOOTBLOB} ${D}/${BINARY_INSTALL_PATH}/boot0.img
    install ${WORKDIR}/${PARTSPEC} ${D}/${BINARY_INSTALL_PATH}/
    install ${WORKDIR}/${UEFI_CAPSULE} ${D}/${BINARY_INSTALL_PATH}/
}

do_install:jetson-xavier() {
    # Ensure install is not executed until
    # do_unpack copies the archive
    while [ ! -f ${WORKDIR}/${BOOTBLOB} ]
    do
        sleep 1
    done

    while [ ! -f ${WORKDIR}/${UEFI_CAPSULE} ]
    do
        sleep 1
    done

    install -d ${D}/${BINARY_INSTALL_PATH}
    install -m 0644 ${WORKDIR}/${BOOTBLOB} ${D}/${BINARY_INSTALL_PATH}/
    install -m 0644 ${WORKDIR}/${PARTSPEC} ${D}/${BINARY_INSTALL_PATH}/
    install -m 0644 ${WORKDIR}/${UEFI_CAPSULE} ${D}/${BINARY_INSTALL_PATH}/

    tar xf ${D}/${BINARY_INSTALL_PATH}/${BOOTBLOB} -C ${WORKDIR}/ boot0_mmcblk0boot0.img
    echo "AM AJUNS AICI"
    install ${WORKDIR}/boot0_mmcblk0boot0.img ${D}/${BINARY_INSTALL_PATH}/
}

do_install:jetson-xavier-nx-devkit-emmc() {
    # Ensure install is not executed until
    # do_unpack copies the archive
    while [ ! -f ${WORKDIR}/${BOOTBLOB} ]
    do
        sleep 1
    done

    while [ ! -f ${WORKDIR}/${UEFI_CAPSULE} ]
    do
        sleep 1
    done

    install -d ${D}/${BINARY_INSTALL_PATH}
    install -m 0644 ${WORKDIR}/${BOOTBLOB} ${D}/${BINARY_INSTALL_PATH}/
    install -m 0644 ${WORKDIR}/${PARTSPEC} ${D}/${BINARY_INSTALL_PATH}/
    install -m 0644 ${WORKDIR}/${UEFI_CAPSULE} ${D}/${BINARY_INSTALL_PATH}/

    tar xf ${D}/${BINARY_INSTALL_PATH}/${BOOTBLOB} -C ${WORKDIR}/ boot0_mtdblock0.img
    echo "AM AJUNS AICI"
    install ${WORKDIR}/boot0_mtdblock0.img ${D}/${BINARY_INSTALL_PATH}/
}


do_deploy() {
    rm -rf ${DEPLOY_DIR_IMAGE}/$(basename ${BINARY_INSTALL_PATH}) || true
    mkdir -p ${DEPLOY_DIR_IMAGE}/$(basename ${BINARY_INSTALL_PATH})
    cp -r ${D}/${BINARY_INSTALL_PATH}/* ${DEPLOY_DIR_IMAGE}/$(basename ${BINARY_INSTALL_PATH})
}

do_deploy:append:jetson-xavier() {
    tar xf ${WORKDIR}/bins_agx_xavier.tar.gz -C ${DEPLOY_DIR_IMAGE}/tegra-binaries/
}

do_deploy:append:jetson-xavier-nx-devkit-emmc() {
    tar xf ${WORKDIR}/boot0_xavier_nx_emmc.tar.gz -C ${DEPLOY_DIR_IMAGE}/tegra-binaries/
}


FILES:${PN} += " \
    /opt/tegra-binaries/* \
"

INHIBIT_PACKAGE_STRIP = "1"
INHIBIT_PACKAGE_DEBUG_SPLIT = "1"

# need to be redeployed on each build
# as this path is not cached
do_install[nostamp] = "1"
do_deploy[nostamp] = "1"
do_unpack[nostamp] = "1"
deltask do_configure
deltask do_compile

addtask do_deploy before do_package after do_install
