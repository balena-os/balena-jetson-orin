SUMMARY = "Create flash artifacts without flashing"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${BALENA_COREBASE}/COPYING.Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

IMAGE_ROOTFS_ALIGNMENT ?= "4"

BOOT_BINDIFF="boot0_t194_nx_sd.bindiff"

DEPENDS = " \
    coreutils-native \
    virtual/bootloader \
    virtual/kernel \
    tegra-binaries \
    tegra-bootfiles \
    tegra-flashtools-native \
    dosfstools-native \
    python3-pyyaml-native \
    mtools-native \
    "

inherit deploy python3native perlnative l4t_bsp

SRC_URI = " \
    file://resinOS-flash194_nxde_sdcard.xml \
    file://partition_specification194_nxde_sdcard.txt \
    file://${BOOT_BINDIFF} \
"

LNXSIZE ?= "67108864"
DTBNAME = "tegra194-p3668-all-p3509-0000"
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
    L4TConfiguration.dtbo \
    L4TRootfsInfo.dtbo \
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

signfile() {
    local destdir="${WORKDIR}/tegraflash"
    local lnxfile="${LNXFILE}"
    local f
    PATH="${STAGING_BINDIR_NATIVE}/${FLASHTOOLS_DIR}:${PATH}"
    export BOARDID=${TEGRA_BOARDID}
    export FAB=${TEGRA_FAB}
    export localbootfile=boot.img

    export CHIPREV=${TEGRA_CHIPREV}
    export sdramcfg=${MACHINE}.cfg,${MACHINE}-override.cfg

    ./tegraflash.py --bl nvtboot_recovery_cpu_t194.bin \
        --sdram_config tegra194-mb1-bct-memcfg-p2888.cfg,tegra194-memcfg-sw-override.cfg  \
        --odmdata 0x9190000  \
        --overlay_dtb L4TConfiguration.dtbo,L4TRootfsInfo.dtbo,tegra194-p2822-camera-dual-imx274-overlay.dtbo,tegra194-p2822-camera-e3331-overlay.dtbo,tegra194-p2822-camera-e3333-overlay.dtbo,tegra194-p2822-camera-imx185-overlay.dtbo,tegra194-p2822-camera-imx390-overlay.dtbo,tegra194-p2888-0005-overlay.dtbo,tegra194-p2888-0001-p2822-0000-overlay.dtbo  \
        --bldtb ${DTBFILE} \
        --applet mb1_t194_prod.bin --cmd "sign" \
        --soft_fuses tegra194-mb1-soft-fuses-l4t.cfg  \
        --cfg flash.xml --chip 0x19 --uphy_config tegra194-mb1-uphy-lane-p2888-0000-p2822-0000.cfg \
        --minratchet_config tegra194-mb1-bct-ratchet-p2888-0000-p2822-0000.cfg \
        --device_config tegra19x-mb1-bct-device-sdmmc.cfg --misc_cold_boot_config tegra194-mb1-bct-misc-l4t.cfg --misc_config tegra194-mb1-bct-misc-flash.cfg --pinmux_config tegra19x-mb1-pinmux-p2888-0000-a04-p2822-0000-b01.cfg --gpioint_config tegra194-mb1-bct-gpioint-p2888-0000-p2822-0000.cfg --pmic_config tegra194-mb1-bct-pmic-p2888-0001-a04-E-0-p2822-0000.cfg --pmc_config tegra19x-mb1-padvoltage-p2888-0000-a00-p2822-0000-a00.cfg --prod_config tegra19x-mb1-prod-p2888-0000-p2822-0000.cfg --scr_config tegra194-mb1-bct-scr-cbb-mini.cfg --scr_cold_boot_config tegra194-mb1-bct-scr-cbb-mini.cfg --br_cmd_config tegra194-mb1-bct-reset-p2888-0000-p2822-0000.cfg --dev_params tegra194-br-bct-sdmmc.cfg,tegra194-br-bct_b-sdmmc.cfg  --bin "mb2_bootloader nvtboot_recovery_t194.bin; mts_preboot preboot_c10_prod_cr.bin; mts_mce mce_c10_prod_cr.bin; mts_proper mts_c10_prod_cr.bin; bpmp_fw bpmp-2_t194.bin; bpmp_fw_dtb tegra194-a02-bpmp-p2888-a04_lz4.dtb; spe_fw spe_t194.bin; tos tos-optee_t194.img; eks eks.img; bootloader_dtb ${DTBFILE}"   --secondary_gpt_backup  --bct_backup  --boot_chain A 

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
    for f in ${BOOTFILES}; do
        cp "${STAGING_DATADIR}/tegraflash/$f" .
    done
    cp mb1_t194_prod.bin mb1_b_t194_prod.bin
    rm -rf ./rollback
    mkdir -p ./rollback
    #cp -R ${STAGING_DATADIR}/nv_tegra/rollback/t${@d.getVar('NVIDIA_CHIP')[2:]}x ./rollback/
    cp ${STAGING_DATADIR}/tegraflash/flashvars .
    sed -i -e "s/@OVERLAY_DTB_FILE@/${OVERLAY_DTB_FILE}/" ./flashvars
    for f in ${STAGING_DATADIR}/tegraflash/tegra19[4x]-*.cfg; do
        cp $f .
    done
    for f in ${STAGING_DATADIR}/tegraflash/tegra194-*-bpmp-*.dtb; do
        cp $f .
    done
    cp -r ${DEPLOY_DIR_IMAGE}/*.dtbo .
    cp -r ${DEPLOY_DIR_IMAGE}/*.dtb .
    for dtbo in ${DTB_OVERLAYS}; do
        cp "${TMPDIR}/work-shared/L4T-${L4T_BSP_ARCH}-${PV}-${PR}/Linux_for_Tegra/kernel/dtb/${dtbo}" .
    done
    if [ "${TEGRA_SIGNING_EXCLUDE_TOOLS}" != "1" ]; then
        cp -R ${STAGING_BINDIR_NATIVE}/${FLASHTOOLS_DIR}/* .
    fi

    # prepare flash.xml.in to be used in signing
    cp ${WORKDIR}/resinOS-flash194_nxde_sdcard.xml flash.xml.in
    sed -i "s, DTB_NAME, ${DTBFILE},g" flash.xml.in

    sed -i -e "s/\[DTB_NAME\]/$(echo ${DTBFILE} | cut -d '.' -f 1)/g" ${WORKDIR}/partition_specification194_nxde_sdcard.txt

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
        -e"s,TBCFILE,uefi_jetson.bin," \
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
    # prep env for tegraflash

#    ln -sf ${STAGING_BINDIR_NATIVE}/tegra186-flash/rollback_parser.py ./rollback/
#    ln -snf ${STAGING_DATADIR}/nv_tegra/rollback/t${@d.getVar('NVIDIA_CHIP')[2:]}x ./rollback/
#    ln -sf ${STAGING_BINDIR_NATIVE}/tegra186-flash/BUP_generator.py ./
#    ln -sf ${STAGING_BINDIR_NATIVE}/tegra186-flash/${SOC_FAMILY}-flash-helper.sh ./

    # bup is based on the rootfs, which is not built at this point
    # not using it for the moment
    # sed -e 's,^function ,,' ${STAGING_BINDIR_NATIVE}/tegra186-flash/l4t_bup_gen.func > ./l4t_bup_gen.func
    rm -rf signed
    echo "35.1.0" > VERFILE
    # Sign all tegra bins
    signfile ""

    # Needed to embedd plain initramfs kernel and dtb to main image
    cp ${LNXFILE} ${DEPLOY_DIR_IMAGE}/bootfiles/Image
    cp ${WORKDIR}/resinOS-flash194_nxde_sdcard.xml ${DEPLOY_DIR_IMAGE}/bootfiles/flash.xml
    cp -r signed/* ${DEPLOY_DIR_IMAGE}/bootfiles/

    dd if=/dev/zero of=boot0.img bs=8388608 count=1
    #TODO: Signed binary

    cp boot0.img ${DEPLOY_DIR_IMAGE}/bootfiles/
}


do_install() {
    install -d ${D}/${BINARY_INSTALL_PATH}
    cp -r ${S}/tegraflash/signed/* ${D}/${BINARY_INSTALL_PATH}
    rm ${D}/${BINARY_INSTALL_PATH}/boot*im* || true
}

do_deploy() {
    rm -rf ${DEPLOY_DIR_IMAGE}/$(basename ${BINARY_INSTALL_PATH})
    mkdir -p ${DEPLOY_DIR_IMAGE}/$(basename ${BINARY_INSTALL_PATH})
    cp -r ${D}/${BINARY_INSTALL_PATH}/* ${DEPLOY_DIR_IMAGE}/$(basename ${BINARY_INSTALL_PATH})
    cp ${WORKDIR}/partition_specification194_nxde_sdcard.txt ${DEPLOY_DIR_IMAGE}/$(basename ${BINARY_INSTALL_PATH})
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
do_configure[depends] += " tos-prebuilt:do_deploy"

do_install[depends] += " virtual/kernel:do_deploy"
do_populate_lic[depends] += "tegra-binaries:do_unpack"

addtask do_deploy before do_package after do_install

COMPATIBLE_MACHINE = "jetson-xavier"
