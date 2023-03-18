SUMMARY = "Create flash artifacts without flashing"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${BALENA_COREBASE}/COPYING.Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

IMAGE_ROOTFS_ALIGNMENT ?= "4"

BOOT_BINDIFF="boot0_t194_nx.bindiff"
BOOT_BINDIFF:forecr-dsb-nx2-xavier-nx-emmc="boot0_t194_nx_forecr.bindiff"

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
    file://resinOS-flash194_nxde.xml \
    file://partition_specification194_nxde.txt \
    file://${BOOT_BINDIFF} \
    file://tegra19x-mb1-pinmux-p3668-a01_forecr_dsboard_nx2.cfg \
"

LNXSIZE ?= "67108864"
DTBNAME = "tegra194-p3668-all-p3509-0000"
#DTBNAME:forecr-dsb-nx2-xavier-nx-emmc = "tegra194-p3668-dsboard-nx2-0000"
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

DEVICE_CONFIG="tegra19x-mb1-bct-device-qspi-p3668.cfg"
MISC_COLD_BOOT_CONFIG="tegra194-mb1-bct-misc-l4t.cfg"
MISC_CONFIG="tegra194-mb1-bct-misc-flash.cfg"
PINMUX_CONFIG="tegra19x-mb1-pinmux-p3668-a01.cfg"
PINMUX_CONFIG:forecr-dsb-nx2-xavier-nx-emmc="tegra19x-mb1-pinmux-p3668-a01_forecr_dsboard_nx2.cfg"
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
        --overlay_dtb L4TConfiguration.dtbo,tegra194-p3668-p3509-overlay.dtbo,L4TRootfsInfo.dtbo  \
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
    cp ${WORKDIR}/tegra19x-mb1-pinmux-p3668-a01_forecr_dsboard_nx2.cfg .
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

    cp ${WORKDIR}/${BOOT_BINDIFF} .
    dd if=/dev/zero count=1 bs=33554432 | tr "\000" "\377" > boot0.img

    dd if=${DEPLOY_DIR_IMAGE}/bootfiles/br_bct_BR.bct of=boot0.img conv=notrunc
    dd if=${DEPLOY_DIR_IMAGE}/bootfiles/br_bct_BR.bct of=boot0.img seek=4096 bs=1 conv=notrunc
    dd if=${DEPLOY_DIR_IMAGE}/bootfiles/br_bct_BR.bct of=boot0.img seek=32768 bs=1 conv=notrunc
    dd if=${DEPLOY_DIR_IMAGE}/bootfiles/br_bct_BR.bct of=boot0.img seek=65536 bs=1 conv=notrunc
    dd if=${DEPLOY_DIR_IMAGE}/bootfiles/br_bct_BR.bct of=boot0.img seek=98304 bs=1 conv=notrunc

    # mb1 (a + b)
    dd if=${DEPLOY_DIR_IMAGE}/bootfiles/mb1_t194_prod_aligned_sigheader.bin.encrypt of=boot0.img seek=131072 bs=1 conv=notrunc
    dd if=${DEPLOY_DIR_IMAGE}/bootfiles/mb1_t194_prod_aligned_sigheader.bin.encrypt of=boot0.img seek=393216 bs=1 conv=notrunc

    #MB1_BCT
    dd if=${DEPLOY_DIR_IMAGE}/bootfiles/mb1_cold_boot_bct_MB1_sigheader.bct.encrypt of=boot0.img seek=655360 bs=1 conv=notrunc

    #MEM_BCT
    dd if=${DEPLOY_DIR_IMAGE}/bootfiles/mem_coldboot_sigheader.bct.encrypt of=boot0.img seek=720896 bs=1 conv=notrunc

    #spe_fw
    dd if=${DEPLOY_DIR_IMAGE}/bootfiles/spe_t194_sigheader.bin.encrypt of=boot0.img seek=983040 bs=1 conv=notrunc

    #mb2
    dd if=${DEPLOY_DIR_IMAGE}/bootfiles/nvtboot_t194_sigheader.bin.encrypt of=boot0.img seek=1245184 bs=1 conv=notrunc

    #mts-preboot
    dd if=${DEPLOY_DIR_IMAGE}/bootfiles/preboot_c10_prod_cr_sigheader.bin.encrypt of=boot0.img seek=1507328 bs=1 conv=notrunc

    #mts-mce
    dd if=${DEPLOY_DIR_IMAGE}/bootfiles/mce_c10_prod_cr_sigheader.bin.encrypt of=boot0.img seek=1572864 bs=1 conv=notrunc

    #mts-proper
    dd if=${DEPLOY_DIR_IMAGE}/bootfiles/mts_c10_prod_cr_sigheader.bin.encrypt of=boot0.img seek=1769472 bs=1 conv=notrunc

    #sc7
    dd if=${DEPLOY_DIR_IMAGE}/bootfiles/warmboot_t194_prod_sigheader.bin.encrypt of=boot0.img seek=5963776 bs=1 conv=notrunc

    #xusb-fw
    dd if=${DEPLOY_DIR_IMAGE}/bootfiles/xusb_sil_rel_fw_sigheader.encrypt of=boot0.img seek=6094848 bs=1 conv=notrunc

    #cpu-bootloader (nvdisp_init + uefi_jetson.bin
    dd if=${DEPLOY_DIR_IMAGE}/bootfiles/nvdisp-init.bin_sigheader.default.encrypt of=boot0.img seek=6291456 bs=1 conv=notrunc

    #bootloader-dtb
    dd if=${DEPLOY_DIR_IMAGE}/bootfiles/${DTBNAME}_sigheader.dtb.encrypt of=boot0.img seek=10485760 bs=1 conv=notrunc

    #secure os
    dd if=${DEPLOY_DIR_IMAGE}/bootfiles/tos-optee_t194_sigheader.img.encrypt of=boot0.img seek=10944512 bs=1 conv=notrunc

    #eks
    dd if=${DEPLOY_DIR_IMAGE}/bootfiles/eks_sigheader.img.encrypt of=boot0.img seek=13565952 bs=1 conv=notrunc

    #adsp fw
    dd if=${DEPLOY_DIR_IMAGE}/bootfiles/adsp-fw_sigheader.bin.encrypt of=boot0.img seek=13631488 bs=1 conv=notrunc

    #rce-fw
    dd if=${DEPLOY_DIR_IMAGE}/bootfiles/camera-rtcpu-t194-rce_sigheader.img.encrypt of=boot0.img seek=14680064 bs=1 conv=notrunc

    #sce-fw, not written by BSP
    #dd if=${DEPLOY_DIR_IMAGE}/bootfiles/camera-rtcpu-t194-rce_sigheader.img.encrypt of=boot0.img seek=15728640 bs=1 conv=notrunc

    #bpmp-fw
    dd if=${DEPLOY_DIR_IMAGE}/bootfiles/bpmp-2_t194_sigheader.bin.encrypt of=boot0.img seek=16777216 bs=1 conv=notrunc

    #bpmp-fw-dtb
    dd if=${DEPLOY_DIR_IMAGE}/bootfiles/tegra194-a02-bpmp-p3668-a00_lz4_sigheader.dtb.encrypt of=boot0.img seek=18350080 bs=1 conv=notrunc

    #MB1_BCT_b
    dd if=${DEPLOY_DIR_IMAGE}/bootfiles/mb1_cold_boot_bct_MB1_sigheader.bct.encrypt of=boot0.img seek=21495808 bs=1 conv=notrunc

    #MEM_BCT_b
    dd if=${DEPLOY_DIR_IMAGE}/bootfiles/mem_coldboot_sigheader.bct.encrypt of=boot0.img seek=21561344 bs=1 conv=notrunc

    #spe_fw_b
    dd if=${DEPLOY_DIR_IMAGE}/bootfiles/spe_t194_sigheader.bin.encrypt of=boot0.img seek=21823488 bs=1 conv=notrunc

    #mb2_b
    dd if=${DEPLOY_DIR_IMAGE}/bootfiles/nvtboot_t194_sigheader.bin.encrypt of=boot0.img seek=22085632 bs=1 conv=notrunc

    #mts-preboot_b
    dd if=${DEPLOY_DIR_IMAGE}/bootfiles/preboot_c10_prod_cr_sigheader.bin.encrypt of=boot0.img seek=22347776 bs=1 conv=notrunc

    #mts-mce_b
    dd if=${DEPLOY_DIR_IMAGE}/bootfiles/mce_c10_prod_cr_sigheader.bin.encrypt of=boot0.img seek=22413312 bs=1 conv=notrunc

    #mts-proper_b
    dd if=${DEPLOY_DIR_IMAGE}/bootfiles/mts_c10_prod_cr_sigheader.bin.encrypt of=boot0.img seek=22609920 bs=1 conv=notrunc

    #sc7_b
    dd if=${DEPLOY_DIR_IMAGE}/bootfiles/warmboot_t194_prod_sigheader.bin.encrypt of=boot0.img seek=26804224 bs=1 conv=notrunc

    #xusb-fw_b
    dd if=${DEPLOY_DIR_IMAGE}/bootfiles/xusb_sil_rel_fw_sigheader.encrypt of=boot0.img seek=26935296 bs=1 conv=notrunc

    #cpu-bootloader_b (nvdisp_init + uefi_jetson.bin
    dd if=${DEPLOY_DIR_IMAGE}/bootfiles/nvdisp-init.bin_sigheader.default.encrypt of=boot0.img seek=27131904 bs=1 conv=notrunc

    #bootloader-dtb_b
    dd if=${DEPLOY_DIR_IMAGE}/bootfiles/${DTBNAME}_sigheader.dtb.encrypt of=boot0.img seek=31326208 bs=1 conv=notrunc

    # Patch resulting binary to resemble the one on the flashed device
    dd if=${BOOT_BINDIFF} skip=0 seek=131088 bs=1 count=32 of=boot0.img conv=notrunc
    dd if=${BOOT_BINDIFF} skip=32 seek=134080 bs=1 count=32 of=boot0.img conv=notrunc
    dd if=${BOOT_BINDIFF} skip=64 seek=10485776 bs=1 count=32 of=boot0.img conv=notrunc
    dd if=${BOOT_BINDIFF} skip=96 seek=10488800 bs=1 count=32 of=boot0.img conv=notrunc
    dd if=${BOOT_BINDIFF} skip=128 seek=10821632 bs=1 count=64 of=boot0.img conv=notrunc
    dd if=${BOOT_BINDIFF} skip=192 seek=10821712 bs=1 count=32 of=boot0.img conv=notrunc
    dd if=${BOOT_BINDIFF} skip=224 seek=10822768 bs=1 count=1040 of=boot0.img conv=notrunc
    dd if=${BOOT_BINDIFF} skip=1264 seek=31326224 bs=1 count=32 of=boot0.img conv=notrunc
    dd if=${BOOT_BINDIFF} skip=1296 seek=31329248 bs=1 count=32 of=boot0.img conv=notrunc
    dd if=${BOOT_BINDIFF} skip=1328 seek=31662080 bs=1 count=64 of=boot0.img conv=notrunc
    dd if=${BOOT_BINDIFF} skip=1392 seek=31662160 bs=1 count=32 of=boot0.img conv=notrunc
    dd if=${BOOT_BINDIFF} skip=1424 seek=31662400 bs=1 count=64 of=boot0.img conv=notrunc
    dd if=${BOOT_BINDIFF} skip=1488 seek=31663216 bs=1 count=1040 of=boot0.img conv=notrunc
    # Jump over UEFI variables to boot directly the Balena image
    dd if=${BOOT_BINDIFF} skip=2528 seek=32702464 bs=1 count=32 of=boot0.img conv=notrunc
    dd if=${BOOT_BINDIFF} skip=2560 seek=33161216 bs=1 count=32768 of=boot0.img conv=notrunc
    dd if=${BOOT_BINDIFF} skip=35328 seek=33292288 bs=1 count=16896 of=boot0.img conv=notrunc
    dd if=${BOOT_BINDIFF} skip=52224 seek=33357824 bs=1 count=128 of=boot0.img conv=notrunc
    dd if=${BOOT_BINDIFF} skip=52352 seek=33423360 bs=1 count=128 of=boot0.img conv=notrunc
    dd if=${BOOT_BINDIFF} skip=52480 seek=33537536 bs=1 count=16896 of=boot0.img conv=notrunc
    dd if=${BOOT_BINDIFF} skip=69376 seek=10821952 bs=1 count=64 of=boot0.img conv=notrunc
    dd if=${BOOT_BINDIFF} skip=69440 seek=10489856 bs=1 count=324016 of=boot0.img conv=notrunc
    dd if=${BOOT_BINDIFF} skip=69440 seek=31330304 bs=1 count=324016 of=boot0.img conv=notrunc
    cp boot0.img ${DEPLOY_DIR_IMAGE}/bootfiles/
}


do_install() {
    install -d ${D}/${BINARY_INSTALL_PATH}
    #cp -r ${S}/tegraflash/signed/* ${D}/${BINARY_INSTALL_PATH}
    # Clear signed kernel images
    #rm ${D}/${BINARY_INSTALL_PATH}/boot*im* || true
    #rm ${D}/${BINARY_INSTALL_PATH}/Image || true
    cp ${WORKDIR}/partition_specification194_nxde.txt ${D}/${BINARY_INSTALL_PATH}/
    cp ${DEPLOY_DIR_IMAGE}/bootfiles/boot0.img ${D}/${BINARY_INSTALL_PATH}/
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

