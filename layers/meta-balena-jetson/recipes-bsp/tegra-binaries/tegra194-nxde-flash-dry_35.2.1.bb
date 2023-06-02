SUMMARY = "Create flash artifacts without flashing"

# This recipe uses the proprietary Tegra BSP downloaded by the meta-tegra recipes
# tegra-binaries and tegra bootfiles to create signed artifacts for the files
# writen on the Nvidia specific eMMC partitions


# TODO: The esp and recovery partitions added by the newer L4T 35.X XML should be added
# to the partition specification, both here and in the jetson-flash xml

# The actual qspi flash image should be obtained from a device flashed with jetson-flash,
# gzipped as boot0_custom_xavier_nx.img.gz, added to this recipe to deploy and included in the final image,
# for hostOS updates
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${BALENA_COREBASE}/COPYING.Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

IMAGE_ROOTFS_ALIGNMENT ?= "4"

DEPENDS = " \
    coreutils-native \
    virtual/bootloader \
    virtual/kernel \
    tegra-binaries \
    tegra-bootfiles \
    tegra-flashtools-native \
    dosfstools-native \
    python3-pyyaml-native \
    dtc-native \
    mtools-native \
"

inherit deploy python3native perlnative l4t_bsp

SRC_URI = " \
    https://raw.githubusercontent.com/balena-os/balena-jetson-orin/7aad0f603a2715bc8046ea12db6b73930d005ced/layers/meta-balena-jetson/recipes-bsp/tegra-binaries/files/resinOS-flash194_nxde.xml \
    file://partition_specification194_nxde.txt \
    file://boot0_custom_xavier_nx.img.gz;unpack=0 \
"

SRC_URI[sha256sum] = "26c1d1ec168d1d575c53c26ee6c42d081189f545cd988e095701da6bf9d20e2b"
LNXSIZE ?= "67108864"
DTBNAME = "tegra194-p3668-all-p3509-0000"

# Override with custom dtb name for the custom device type
DTBNAME:custom-xavier-nx-emmc = "tegra194-p3668-custom-0000"
KERNEL_DEVICETREE = "${DEPLOY_DIR_IMAGE}/${DTBNAME}.dtb"
DTBFILE ?= "${@os.path.basename(d.getVar('KERNEL_DEVICETREE', True).split()[0])}"

IMAGE_TEGRAFLASH_FS_TYPE ??= "ext4"
IMAGE_TEGRAFLASH_ROOTFS ?= "${IMGDEPLOYDIR}/${IMAGE_LINK_NAME}.${IMAGE_TEGRAFLASH_FS_TYPE}"
FLASHTOOLS_DIR = "tegra-flash"
TOSIMGFILENAME = "tos-optee_t194.img"

LDK_DIR = "${TMPDIR}/work-shared/L4T-${SOC_FAMILY}-${PV}-${PR}/Linux_for_Tegra"
B = "${WORKDIR}/build"
S = "${WORKDIR}"
LNXFILE="${KERNEL_IMAGETYPE}${KERNEL_INITRAMFS}-${MACHINE}.bin"
IMAGE_TEGRAFLASH_KERNEL ?= "${DEPLOY_DIR_IMAGE}/${LNXFILE}"
BINARY_INSTALL_PATH = "/opt/tegra-binaries"

DTB_OVERLAYS = "\
    tegra194-p2822-camera-dual-imx274-overlay.dtbo \
    tegra194-p2822-camera-e3331-overlay.dtbo \
    tegra194-p2822-camera-e3333-overlay.dtbo \
    tegra194-p2822-camera-imx185-overlay.dtbo \
    tegra194-p2822-camera-imx390-overlay.dtbo \
    tegra194-p2888-0005-overlay.dtbo \
    tegra194-p2888-0001-p2822-0000-overlay.dtbo \
"

OS_KERNEL_CMDLINE = "${@bb.utils.contains('DISTRO_FEATURES','osdev-image','console=ttyTHS0,115200n8 console=tty1 ','console=null quiet splash vt.global_cursor_default=0 consoleblank=0',d)} l4tver=${L4T_VERSION}"

BOOTFILES=" \
    adsp-fw.bin \
    bpmp-2_t194.bin \
    camera-rtcpu-t194-rce.img \
    eks.img \
    mb1_t194_prod.bin \
    nvtboot_applet_t194.bin \
    nvtboot_t194.bin \
    preboot_c10_prod_cr.bin \
    mce_c10_prod_cr.bin \
    mts_c10_prod_cr.bin \
    nvtboot_cpu_t194.bin \
    nvtboot_recovery_t194.bin \
    nvtboot_recovery_cpu_t194.bin \
    spe_t194.bin \
    warmboot_t194_prod.bin \
    xusb_sil_rel_fw \
"

DEVICE_CONFIG="tegra19x-mb1-bct-device-qspi-p3668.cfg"
MISC_COLD_BOOT_CONFIG="tegra194-mb1-bct-misc-l4t.cfg"
MISC_CONFIG="tegra194-mb1-bct-misc-flash.cfg"
PINMUX_CONFIG="tegra19x-mb1-pinmux-p3668-a01.cfg"
GPIOINT_CONFIG="tegra194-mb1-bct-gpioint-p3668-0001-a00.cfg"
PMIC_CONFIG="tegra194-mb1-bct-pmic-p3668-0001-a00.cfg"
PMC_CONFIG="tegra19x-mb1-padvoltage-p3668-a01.cfg"
PROD_CONFIG="tegra19x-mb1-prod-p3668-0001-a00.cfg"
SCR_CONFIG="tegra194-mb1-bct-scr-cbb-mini-p3668.cfg"
SCR_COLD_BOOT_CONFIG="tegra194-mb1-bct-scr-cbb-mini-p3668.cfg"
BR_CMD_CONFIG="tegra194-mb1-bct-reset-p3668-0001-a00.cfg"
DEV_PARAMS="tegra194-br-bct-qspi-l4t.cfg,tegra194-br-bct_b-qspi-l4t.cfg"

BIN="mb2_bootloader nvtboot_recovery_t194.bin; mts_preboot preboot_c10_prod_cr.bin; mts_mce mce_c10_prod_cr.bin; mts_proper mts_c10_prod_cr.bin; bpmp_fw bpmp-2_t194.bin; bpmp_fw_dtb tegra194-a02-bpmp-p3668-a00_lz4.dtb; spe_fw spe_t194.bin; tos tos-optee_t194.img; eks eks.img; bootloader_dtb ${DTBFILE}"

signfile() {
    local destdir="${WORKDIR}/tegraflash"
    local lnxfile="${LNXFILE}"
    local f
    PATH="${STAGING_BINDIR_NATIVE}/${FLASHTOOLS_DIR}:${PATH}"
    export BOARDID=${TEGRA_BOARDID}
    export FAB=${TEGRA_FAB}
    export localbootfile=boot.img
    pwd
    export CHIPREV=${TEGRA_CHIPREV}
    export sdramcfg=${MACHINE}.cfg,${MACHINE}-override.cfg
    ./tegraflash.py --bl nvtboot_recovery_cpu_t194.bin \
        --sdram_config tegra194-mb1-bct-memcfg-p3668-0001-a00.cfg,tegra194-memcfg-sw-override.cfg  \
        --odmdata 0xB8190000   \
        --overlay_dtb L4TConfiguration.dtbo,tegra194-p3668-p3509-overlay.dtbo  \
        --bldtb ${DTBFILE} \
        --applet mb1_t194_prod.bin --cmd "sign" \
        --soft_fuses tegra194-mb1-soft-fuses-l4t.cfg  \
        --cfg flash.xml --chip 0x19 \
        --minratchet_config tegra194-mb1-bct-ratchet-p3668.cfg \
        --device_config ${DEVICE_CONFIG} \
        --misc_cold_boot_config ${MISC_COLD_BOOT_CONFIG} \
        --misc_config ${MISC_CONFIG} \
        --pinmux_config ${PINMUX_CONFIG} \
        --gpioint_config ${GPIOINT_CONFIG} \
        --pmic_config ${PMIC_CONFIG} \
        --pmc_config ${PMC_CONFIG} \
        --prod_config ${PROD_CONFIG} \
        --scr_config ${SCR_CONFIG} \
        --scr_cold_boot_config ${SCR_COLD_BOOT_CONFIG} \
        --br_cmd_config ${BR_CMD_CONFIG} \
        --dev_params ${DEV_PARAMS}  \
        --bin "${BIN}" \
        --secondary_gpt_backup  --bct_backup  --boot_chain A
}

do_configure() {
    local destdir="${WORKDIR}/tegraflash"
    local lnxfile="${LNXFILE}"
    local f
    PATH="${STAGING_BINDIR_NATIVE}/${FLASHTOOLS_DIR}:${PATH}"
    rm -rf "${WORKDIR}/tegraflash"
    mkdir -p "${WORKDIR}/tegraflash"
    oldwd=`pwd`
    cd "${WORKDIR}/tegraflash"
    cp "${STAGING_DATADIR}/tegraflash/bsp_version" .
    cp "${STAGING_DATADIR}/tegraflash/${EMMC_BCT}" .
    cp "${STAGING_DATADIR}/tegraflash/${EMMC_BCT_OVERRIDE}" .
    cp "${IMAGE_TEGRAFLASH_KERNEL}" ./${LNXFILE}
    if [ -n "${DATAFILE}" -a -n "${IMAGE_TEGRAFLASH_DATA}" ]; then
        cp "${IMAGE_TEGRAFLASH_DATA}" ./${DATAFILE}
        DATAARGS="--datafile ${DATAFILE}"
    fi
    cp "${DEPLOY_DIR_IMAGE}/uefi_jetson.bin" ./uefi_jetson.bin
    cp "${DEPLOY_DIR_IMAGE}/tos-${MACHINE}.img" ./${TOSIMGFILENAME}
    cp "${STAGING_DATADIR}"/tegraflash/nvdisp-init.bin ./nvdisp-init.bin.default
    truncate --size=393216 ./nvdisp-init.bin.default
    cat ./uefi_jetson.bin  >> ./nvdisp-init.bin.default
    for f in ${BOOTFILES}; do
        cp "${STAGING_DATADIR}/tegraflash/$f" .
    done
    cp mb1_t194_prod.bin mb1_b_t194_prod.bin
    rm -rf ./rollback
    mkdir -p ./rollback
    cp ${STAGING_DATADIR}/tegraflash/flashvars .
    sed -i -e "s/@OVERLAY_DTB_FILE@/${OVERLAY_DTB_FILE}/" ./flashvars
    for f in ${STAGING_DATADIR}/tegraflash/tegra19[4x]-*.cfg; do
        cp $f .
    done
    for f in ${STAGING_DATADIR}/tegraflash/tegra194-*-bpmp-*.dtb; do
        cp $f .
    done
    cp -r ${DEPLOY_DIR_IMAGE}/*.dtbo .
    for dtbo in ${DTB_OVERLAYS}; do
        cp "${TMPDIR}/work-shared/L4T-${L4T_BSP_ARCH}-${PV}-${PR}/Linux_for_Tegra/kernel/dtb/${dtbo}" .
    done
    if [ "${TEGRA_SIGNING_EXCLUDE_TOOLS}" != "1" ]; then
        cp -R ${STAGING_BINDIR_NATIVE}/${FLASHTOOLS_DIR}/* .
    fi

    # prepare flash.xml.in to be used in signing
    cp ${WORKDIR}/resinOS-flash194_nxde.xml flash.xml.in
    sed -i "s, DTB_NAME, ${DTBFILE},g" flash.xml.in

    sed -i -e "s/\[DTB_NAME\]/$(echo ${DTBFILE} | cut -d '.' -f 1)/g" ${WORKDIR}/partition_specification194_nxde.txt
    bldtbchosenargs="console=ttyTCU0,115200"
    bldtbdtsname="/dvs/git/dirty/git-master_linux/kernel/kernel-5.10/arch/arm64/boot/dts/../../../../../../hardware/nvidia/platform/t19x/jakku/kernel-dts/tegra194-p3668-0001-p3509-0000.dts"
    bldtboname="/dvs/git/dirty/git-master_linux/kernel/kernel-5.10/arch/arm64/boot/dts/../../../../../../hardware/nvidia/platform/t19x/jakku/kernel-dts/tegra194-p3668-p3509-overlay.dts"
    compatible="nvidia,p3449-0000+p3668-0001\0nvidia,p3509-0000+p3668-0001\0nvidia,tegra194";
    dtbbuildtime="Aug 10 2022\020:31:55"
    dtboname="Jetson Xavier NX Overlay Support"
    dtbocompat="nvidia,tegra194"
    cp ${DEPLOY_DIR_IMAGE}/${DTBFILE} .
    fdtput -t s ${DTBFILE} / "nvidia,dtsfilename" $bldtbdtsname
    fdtput -t s ${DTBFILE} /chosen bootargs $bldtbchosenargs
    fdtput -t s ${DTBFILE} / compatible $compatible
    fdtput -t s ${DTBFILE} / "nvidia,dtbbuildtime" "None"
    fdtput -t s tegra194-p3668-p3509-overlay.dtbo / "nvidia,dtbbuildtime" $dtbbuildtime
    fdtput -t s tegra194-p3668-p3509-overlay.dtbo / "nvidia,dtsfilename" $bldtboname
    fdtput -t s tegra194-p3668-p3509-overlay.dtbo / "overlay-name" $dtboname
    fdtput -t s tegra194-p3668-p3509-overlay.dtbo / "compatible" $dtbocompat
    sed -e"s,MB1FILE,mb1_b_t194_prod.bin,2" flash.xml.in | \
        sed \
        -e"s,LNXFILE_b,$lnxfile," \
        -e"s,LNXFILE,$lnxfile," -e"s,LNXSIZE,${LNXSIZE}," \
        -e"s,TEGRABOOT,nvtboot_t194.bin," \
        -e"s,MTSPREBOOT,preboot_c10_prod_cr.bin," \
        -e"s,MTS_MCE,mce_c10_prod_cr.bin," \
        -e"s,MTSPROPER,mts_c10_prod_cr.bin," \
        -e"s,MB1FILE,mb1_t194_prod.bin," \
        -e"s,BPFFILE,bpmp-2_t194.bin," \
        -e"s,TBCFILE,nvdisp-init.bin.default," \
        -e"s,CAMERAFW,camera-rtcpu-t194-rce.img," \
        -e"s,BPFDTB_FILE,tegra194-a02-bpmp-p2888-a04_lz4.dtb," \
        -e"s,DRAMECCTYPE,dram_ecc," -e"s,DRAMECCFILE,dram-ecc-t194.bin," -e"s,DRAMECCNAME,dram-ecc-fw," \
        -e"s,SPEFILE,spe_t194.bin," \
        -e"s,WB0BOOT,warmboot_t194_prod.bin," \
        -e"s,TOSFILE,${TOSIMGFILENAME}," \
        -e"s,EKSFILE,eks.img," \
        -e"s,RECNAME,recovery," -e"s,RECSIZE,66060288," -e"s,RECDTB-NAME,recovery-dtb," -e"s,BOOTCTRLNAME,kernel-bootctrl," \
        -e"/RECFILE/d" -e"/RECDTB-FILE/d" -e"/BOOTCTRL-FILE/d" \
        -e"s,APPSIZE,${ROOTFSPART_SIZE}," \
        -e"s,RECROOTFSSIZE,${RECROOTFSSIZE}," \
        -e"s,APPUUID_b,," -e"s,APPUUID,," \
        -e"s,ESP_FILE,esp.img," -e"/VARSTORE_FILE/d" \
        > flash.xml

    # bup is based on the rootfs, which is not built at this point
    # not using it for the moment
    # sed -e 's,^function ,,' ${STAGING_BINDIR_NATIVE}/tegra186-flash/l4t_bup_gen.func > ./l4t_bup_gen.func
    rm -rf signed
    echo "35.1.0" > VERFILE
    # Sign all tegra bins
    signfile ""

    # Needed to embedd plain initramfs kernel and dtb to main image
    cp ${DTBFILE} ${DEPLOY_DIR_IMAGE}/bootfiles/
    fdtget ${DEPLOY_DIR_IMAGE}/bootfiles/${DTBFILE} -t s / "nvidia,dtbbuildtime"
    cp ${WORKDIR}/resinOS-flash194_nxde.xml ${DEPLOY_DIR_IMAGE}/bootfiles/flash.xml
    cp -r signed/* ${DEPLOY_DIR_IMAGE}/bootfiles/
}


do_install() {
    install -d ${D}/${BINARY_INSTALL_PATH}
    #cp -r ${S}/tegraflash/signed/* ${D}/${BINARY_INSTALL_PATH}
    # Clear signed kernel images
    #rm ${D}/${BINARY_INSTALL_PATH}/boot*im* || true
    #rm ${D}/${BINARY_INSTALL_PATH}/Image || true
    cp ${WORKDIR}/partition_specification194_nxde.txt ${D}/${BINARY_INSTALL_PATH}/
    cp ${DEPLOY_DIR_IMAGE}/bootfiles/tos-optee_t194_sigheader.img.encrypt ${D}/${BINARY_INSTALL_PATH}/
    cp ${DEPLOY_DIR_IMAGE}/bootfiles/eks_sigheader.img.encrypt ${D}/${BINARY_INSTALL_PATH}/
    cp ${DEPLOY_DIR_IMAGE}/bootfiles/adsp-fw_sigheader.bin.encrypt ${D}/${BINARY_INSTALL_PATH}/
    cp ${DEPLOY_DIR_IMAGE}/bootfiles/camera-rtcpu-t194-rce_sigheader.img.encrypt ${D}/${BINARY_INSTALL_PATH}/
    cp ${DEPLOY_DIR_IMAGE}/bootfiles/bpmp-2_t194_sigheader.bin.encrypt ${D}/${BINARY_INSTALL_PATH}/
    cp ${DEPLOY_DIR_IMAGE}/bootfiles/tegra194-a02-bpmp-p2888-a04_lz4_sigheader.dtb.encrypt ${D}/${BINARY_INSTALL_PATH}/
    cp ${DEPLOY_DIR_IMAGE}/bootfiles/${DTBNAME}_sigheader.dtb.encrypt ${D}/${BINARY_INSTALL_PATH}/
}

do_deploy() {
    rm -rf ${DEPLOY_DIR_IMAGE}/$(basename ${BINARY_INSTALL_PATH})
    mkdir -p ${DEPLOY_DIR_IMAGE}/$(basename ${BINARY_INSTALL_PATH})
    #cp -r ${D}/${BINARY_INSTALL_PATH}/* ${DEPLOY_DIR_IMAGE}/$(basename ${BINARY_INSTALL_PATH})
    cp -r ${S}/tegraflash/signed/* ${DEPLOY_DIR_IMAGE}/$(basename ${BINARY_INSTALL_PATH})
    cp ${WORKDIR}/partition_specification194_nxde.txt ${DEPLOY_DIR_IMAGE}/$(basename ${BINARY_INSTALL_PATH})
}

FILES:${PN} += "${BINARY_INSTALL_PATH}"

INHIBIT_PACKAGE_STRIP = "1"
INHIBIT_PACKAGE_DEBUG_SPLIT = "1"

# Binaries copied to DEPLOY_DIR_IMAGE
# to be included in the boot partition
# need to be redeployed on each build
# as this path is not cached
do_install[nostamp] = "1"
do_deploy[nostamp] = "1"
do_configure[nostamp] = "1"
do_configure[depends] += " tegra-binaries:do_preconfigure"
do_configure[depends] += " virtual/kernel:do_deploy \
                           virtual/bootloader:do_deploy \
"
do_configure[depends] += " tos-optee:do_deploy"

do_install[depends] += " virtual/kernel:do_deploy"
do_populate_lic[depends] += "tegra-binaries:do_unpack"

addtask do_deploy before do_package after do_install
