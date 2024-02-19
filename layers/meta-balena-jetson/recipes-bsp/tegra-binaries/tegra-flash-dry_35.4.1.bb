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
UEFI_CAPSULE:jetson-xavier-nx-devkit = "TEGRA_BL_Xavier_NX_SD.Cap.gz"

BOOTBLOB:jetson-orin-nx-xavier-nx-devkit = "boot0_orin_nx_xavier_nx_devkit.img.gz"
BOOTBLOB:jetson-orin-nano-devkit-nvme = "boot0_orin_nano_devkit_nvme.img.gz"
BOOTBLOB:jetson-orin-nx-seeed-j4012 = "boot0_orin_nx_seed_j4012.img.gz"
BOOTBLOB:jetson-xavier = "bins_agx_xavier.tar.gz"
BOOTBLOB:jetson-xavier-nx-devkit-emmc = "boot0_xavier_nx_emmc.tar.gz"
BOOTBLOB:jetson-xavier-nx-devkit = "boot0_xavier_nx_sd.tar.gz"

PARTSPEC:jetson-agx-orin-devkit = "partition_specification234.txt"
PARTSPEC:jetson-orin-nx-xavier-nx-devkit = "partition_specification234.txt"
PARTSPEC:jetson-orin-nano-devkit-nvme = "partition_specification234_orin_nano.txt"
PARTSPEC:jetson-orin-nx-seeed-j4012 = "partition_specification234_orin_nano.txt"
PARTSPEC:jetson-xavier = "partition_specification194.txt"
PARTSPEC:jetson-xavier-nx-devkit-emmc = "partition_specification194_nxde.txt"
PARTSPEC:jetson-xavier-nx-devkit = "partition_specification194_nxde.txt"

BOOT0_PREFLASHED = "boot0.img"
BOOT0_PREFLASHED:jetson-xavier = "boot0_mmcblk0boot0.img"
BOOT0_PREFLASHED:jetson-xavier-nx-devkit-emmc = "boot0_mtdblock0.img"
BOOT0_PREFLASHED:jetson-xavier-nx-devkit = "boot0_mtdblock0.img"

BINARY_INSTALL_PATH = "/opt/tegra-binaries/"

SRC_URI = " \
    file://${BOOTBLOB};unpack=0 \
    file://${PARTSPEC} \
    file://${UEFI_CAPSULE};unpack=0 \
"
install_artifacts_orin() {
    install ${WORKDIR}/${BOOTBLOB} ${D}/${BINARY_INSTALL_PATH}/${BOOT0_PREFLASHED}
}

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
    install ${WORKDIR}/${PARTSPEC} ${D}/${BINARY_INSTALL_PATH}/
    install ${WORKDIR}/${UEFI_CAPSULE} ${D}/${BINARY_INSTALL_PATH}/
}

do_install:append:jetson-orin-nx-xavier-nx-devkit() {
   install_artifacts_orin
}

do_install:append:jetson-orin-nano-devkit-nvme() {
   install_artifacts_orin
}

do_install:append:jetson-agx-orin-devkit() {
   install_artifacts_orin
}


install_artifacts_xavier() {
    install -m 0644 ${WORKDIR}/${BOOTBLOB} ${D}/${BINARY_INSTALL_PATH}/
    tar xf ${D}/${BINARY_INSTALL_PATH}/${BOOTBLOB} -C ${WORKDIR}/ ${BOOT0_PREFLASHED}
    install ${WORKDIR}/${BOOT0_PREFLASHED} ${D}/${BINARY_INSTALL_PATH}/
}

do_install:append:jetson-xavier() {
    install_artifacts_xavier
}

do_install:append:jetson-xavier-nx-devkit-emmc() {
    install_artifacts_xavier
}

do_install:append:jetson-xavier-nx-devkit() {
   install_artifacts_xavier
}

do_deploy() {
    rm -rf ${DEPLOY_DIR_IMAGE}/$(basename ${BINARY_INSTALL_PATH}) || true
    mkdir -p ${DEPLOY_DIR_IMAGE}/$(basename ${BINARY_INSTALL_PATH})
    cp -r ${D}/${BINARY_INSTALL_PATH}/* ${DEPLOY_DIR_IMAGE}/$(basename ${BINARY_INSTALL_PATH})
}

do_deploy:append:jetson-xavier() {
    tar xf ${WORKDIR}/${BOOTBLOB} -C ${DEPLOY_DIR_IMAGE}/tegra-binaries/
}

do_deploy:append:jetson-xavier-nx-devkit-emmc() {
    tar xf ${WORKDIR}/${BOOTBLOB} -C ${DEPLOY_DIR_IMAGE}/tegra-binaries/
}

do_deploy:append:jetson-xavier-nx-devkit() {
    tar xf ${WORKDIR}/${BOOTBLOB} -C ${DEPLOY_DIR_IMAGE}/tegra-binaries/
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
