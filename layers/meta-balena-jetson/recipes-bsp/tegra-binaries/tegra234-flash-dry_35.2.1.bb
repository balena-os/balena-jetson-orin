SUMMARY = "Create flash artifacts without flashing"

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
    dtc-native \
    dosfstools-native \
    python3-pyyaml-native \
    mtools-native \
"

inherit deploy python3native perlnative l4t_bsp

SRC_URI = " \
    file://resinOS-flash234.xml \
    file://partition_specification234.txt \
    file://custinfo_234.bin \
    file://T234_devkit_patch.bin \
    file://create_blob_orin_agx.sh \
"

BPFDTB_FILE = "tegra234-bpmp-3701-0000-3737-0000.dtb"
DTBNAME = "tegra234-p3701-0000-p3737-0000"
KERNEL_DEVICETREE = "${DEPLOY_DIR_IMAGE}/${DTBNAME}.dtb"
DTBFILE ?= "${@os.path.basename(d.getVar('KERNEL_DEVICETREE', True).split()[0])}"
FLASHTOOLS_DIR = "tegra-flash"
IMAGE_TEGRAFLASH_FS_TYPE ??= "ext4"
IMAGE_TEGRAFLASH_ROOTFS ?= "${IMGDEPLOYDIR}/${IMAGE_LINK_NAME}.${IMAGE_TEGRAFLASH_FS_TYPE}"
TEGRA_ESP_IMAGE = "tegra-espimage"
LDK_DIR = "${TMPDIR}/work-shared/L4T-${SOC_FAMILY}-${PV}-${PR}/Linux_for_Tegra"
B = "${WORKDIR}/build"
S = "${WORKDIR}"
LNXFILE="${KERNEL_IMAGETYPE}${KERNEL_INITRAMFS}-${MACHINE}.bin"
IMAGE_TEGRAFLASH_KERNEL ?= "${DEPLOY_DIR_IMAGE}/${LNXFILE}"
BINARY_INSTALL_PATH = "/opt/tegra-binaries"
DTB_OVERLAYS = "\
   L4TConfiguration.dtbo \
"

TOSIMGFILENAME = "tos-optee_t234.img"

BOOTFILES:tegra234 = "\
    adsp-fw.bin \
    applet_t234.bin \
    camera-rtcpu-t234-rce.img \
    eks.img \
    mb1_t234_prod.bin \
    mb2_t234.bin \
    preboot_c10_prod_cr.bin \
    mce_c10_prod_cr.bin \
    mts_c10_prod_cr.bin \
    nvtboot_cpurf_t234.bin \
    spe_t234.bin \
    psc_bl1_t234_prod.bin \
    pscfw_t234_prod.bin \
    mce_flash_o10_cr_prod.bin \
    sc7_t234_prod.bin \
    display-t234-dce.bin \
    psc_rf_t234_prod.bin \
    nvdec_t234_prod.fw \
    xusb_t234_prod.bin \
    tegrabl_carveout_id.h \
    pinctrl-tegra.h \
    tegra234-gpio.h \
    readinfo_t234_min_prod.xml \
    camera-rtcpu-sce.img \
    mb2rf_t234.bin \
"


signfile() {
    local destdir="${WORKDIR}/tegraflash"
    local lnxfile="${LNXFILE}"
    export PATH="${STAGING_BINDIR_NATIVE}/{FLASHTOOLS_DIR}:${PATH}"

    cat flash.xml.in | sed \
        -e"s,LNXFILE,boot.img," -e"s,LNXSIZE,${LNXSIZE}," \
        -e"s,MB1FILE,mb1_t234_prod.bin," \
        -e"s,CAMERAFW,camera-rtcpu-t234-rce.img," \
        -e"s,SPEFILE,spe_t234.bin," \
        -e"s,TOSFILE,${TOSIMGFILENAME}," \
        -e"s,EKSFILE,eks.img," \
        -e"s,RECNAME,recovery," -e"s,RECSIZE,66060288," -e"s,RECDTB-NAME,recovery-dtb," \
        -e"/RECFILE/d" -e"/RECDTB-FILE/d" -e"/BOOTCTRL-FILE/d" \
        -e"s,APPSIZE,${ROOTFSPART_SIZE}," \
        -e"s,RECROOTFSSIZE,${RECROOTFSSIZE}," \
        -e"s,PSCBL1FILE,psc_bl1_t234_prod.bin," \
        -e"s,TSECFW,," \
        -e"s,NVHOSTNVDEC,nvdec_t234_prod.fw," \
        -e"s,MB2BLFILE,mb2_t234.bin," \
        -e"s,XUSB_FW,xusb_t234_prod.bin," \
        -e"s,PSCFW,pscfw_t234_prod.bin," \
        -e"s,MCE_IMAGE,mce_flash_o10_cr_prod.bin," \
        -e"s,WB0FILE,sc7_t234_prod.bin," \
        -e"s,PSCRF_IMAGE,psc_rf_t234_prod.bin," \
        -e"s,MB2RF_IMAGE,mb2rf_t234.bin," \
        -e"s,TBCDTB-FILE,uefi_jetson_with_dtb.bin," \
        -e"s,DCE,display-t234-dce.bin," \
	-e"s, DTB_FILE,$kernel_dtbfile," -e"s,BPFFILE,$BPF_FILE," \
        -e"s,BPFDTB_FILE,${BPFDTB_FILE}," \
        -e"s,APPUUID,," \
        -e"s,ESP_FILE,esp.img," -e"/VARSTORE_FILE/d" \
        > $destdir/flash.xml

	./tegraflash.py  --bl uefi_jetson_with_dtb.bin \
			 --odmdata gbe-uphy-config-22,hsstp-lane-map-3,nvhs-uphy-config-0,hsio-uphy-config-0,gbe0-enable-10g  --overlay_dtb L4TConfiguration.dtbo,tegra234-p3737-audio-codec-rt5658-40pin.dtbo,tegra234-p3737-camera-dual-imx274-overlay.dtbo,tegra234-p3737-camera-e3331-overlay.dtbo,tegra234-p3737-camera-e3333-overlay.dtbo,tegra234-p3737-camera-imx185-overlay.dtbo,tegra234-p3737-camera-imx390-overlay.dtbo  \
					--bldtb ${DTBFILE} \
					--applet mb1_t234_prod.bin \
					--cmd "sign"  \
					--cfg flash.xml \
					--chip 0x23 \
					--concat_cpubl_bldtb \
					--cpubl uefi_jetson.bin \
					--device_config tegra234-mb1-bct-device-p3701-0000.dts \
					--misc_config tegra234-mb1-bct-misc-p3701-0000.dts \
					--pinmux_config tegra234-mb1-bct-pinmux-p3701-0000.dtsi \
					--gpioint_config tegra234-mb1-bct-gpioint-p3701-0000.dts \
					--pmic_config tegra234-mb1-bct-pmic-p3701-0000.dts \
					--pmc_config tegra234-mb1-bct-padvoltage-p3701-0000.dtsi \
					--deviceprod_config tegra234-mb1-bct-cprod-p3701-0000.dts \
					--prod_config tegra234-mb1-bct-prod-p3701-0000.dts \
					--scr_config tegra234-mb2-bct-scr-p3701-0000.dts \
					--wb0sdram_config tegra234-p3701-0000-wb0sdram-l4t.dts \
					--br_cmd_config tegra234-mb1-bct-reset-p3701-0000.dts \
					--dev_params tegra234-br-bct-p3701-0000.dts,tegra234-br-bct_b-p3701-0000.dts \
					--mb2bct_cfg tegra234-mb2-bct-misc-p3701-0000.dts  \
					--bins "psc_fw pscfw_t234_prod.bin; mts_mce mce_flash_o10_cr_prod.bin; mb2_applet applet_t234.bin; mb2_bootloader mb2_t234.bin; xusb_fw xusb_t234_prod.bin; dce_fw display-t234-dce.bin; nvdec nvdec_t234_prod.fw; bpmp_fw bpmp_t234-TE990M-A1_prod.bin; bpmp_fw_dtb tegra234-bpmp-3701-0000-3737-0000.dtb; sce_fw camera-rtcpu-sce.img; rce_fw camera-rtcpu-t234-rce.img; ape_fw adsp-fw.bin; spe_fw spe_t234.bin; tos tos-optee_t234.img; eks eks.img"  \
					--sdram_config tegra234-p3767-0001-sdram-l4t.dts \
					--cust_info custinfo_out.bin  --secondary_gpt_backup  --boot_chain A
}

do_configure() {
    local f
    export PATH="${STAGING_BINDIR_NATIVE}/${FLASHTOOLS_DIR}:${PATH}"
    rm -rf "${WORKDIR}/tegraflash"
    mkdir -p "${WORKDIR}/tegraflash"
    oldwd=`pwd`

    cd "${WORKDIR}/tegraflash"
    #cp "${STAGING_DATADIR}/tegraflash/bsp_version" .
    echo "35.1" > bsp_version
    cp "${STAGING_DATADIR}/tegraflash/${EMMC_BCT}" .
    cp "${IMAGE_TEGRAFLASH_KERNEL}" .
    if [ -n "${DATAFILE}" -a -n "${IMAGE_TEGRAFLASH_DATA}" ]; then
        cp "${IMAGE_TEGRAFLASH_DATA}" ./${DATAFILE}
        DATAARGS="--datafile ${DATAFILE}"
    fi
    cp -L "${DEPLOY_DIR_IMAGE}/${DTBFILE}" ./${DTBFILE}
    cp "${DEPLOY_DIR_IMAGE}/uefi_jetson.bin" ./uefi_jetson.bin
    cp "${DEPLOY_DIR_IMAGE}/tos-${MACHINE}.img" ./${TOSIMGFILENAME}
    for f in ${BOOTFILES}; do
        cp "${STAGING_DATADIR}/tegraflash/$f" .
    done

    cp -r ${STAGING_BINDIR_NATIVE}/${FLASHTOOLS_DIR}/* .

    # Copy and update flashvars
    cp ${STAGING_DATADIR}/tegraflash/flashvars .
    sed -i -e "s/@OVERLAY_DTB_FILE@/${OVERLAY_DTB_FILE}/" ./flashvars

    for f in ${STAGING_DATADIR}/tegraflash/bpmp_t234-*.bin; do
        cp $f .
    done

    cp -r ${DEPLOY_DIR_IMAGE}/*.dtbo .
    for dtbo in ${DTB_OVERLAYS}; do
        cp "${TMPDIR}/work-shared/L4T-${L4T_BSP_ARCH}-${PV}-${PR}/Linux_for_Tegra/kernel/dtb/${dtbo}" .
    done
    for f in ${STAGING_DATADIR}/tegraflash/tegra234-*.dts*; do
        cp $f .
    done
    for f in ${STAGING_DATADIR}/tegraflash/tegra234-*.dtb; do
        cp $f .
    done
    for f in ${STAGING_DATADIR}/tegraflash/tegra234-bpmp-*.dtb; do
        cp $f .
    done
    cp ${STAGING_DATADIR}/tegraflash/mb2rf_t234.bin .

    for f in ${STAGING_BINDIR_NATIVE}/${FLASHTOOLS_DIR}/*.py; do
        cp $f .
    done

    echo "35.1.0" > VERFILE

    cp ${WORKDIR}/custinfo_234.bin ./custinfo_out.bin
    cp ${WORKDIR}/T234_devkit_patch.bin .
    cp "${DEPLOY_DIR_IMAGE}/${DTBFILE}" ./${DTBFILE}

    # Make bootable image from kernel and sign it
    cp ${DEPLOY_DIR_IMAGE}/${LNXFILE} ${LNXFILE}

    # prepare flash.xml.in to be used in signing
    cp ${WORKDIR}/resinOS-flash234.xml flash.xml.in
    sed -i "s, DTB_FILE, ${DTBFILE},g" flash.xml.in
    cp ${WORKDIR}/partition_specification234.txt .
    cp ${WORKDIR}/create_blob_orin_agx.sh .
    sed -i -e "s/DTB_FILE/$(echo ${DTBFILE})/g" partition_specification234.txt
    sed -i -e "s/LNXFILE/$(echo ${LNXFILE})/g" partition_specification234.txt
    
    # prep env for tegraflash
    mkdir ./rollback

    ln -sf ${STAGING_BINDIR_NATIVE}/${FLASHTOOLS_DIR}/rollback_parser.py ./rollback/
    ln -snf ${STAGING_DATADIR}/nv_tegra/rollback/t${@d.getVar('NVIDIA_CHIP')[2:]}x ./rollback/
    ln -sf ${STAGING_BINDIR_NATIVE}/${FLASHTOOLS_DIR}/BUP_generator.py ./
    ln -sf ${STAGING_BINDIR_NATIVE}/${FLASHTOOLS_DIR}/${SOC_FAMILY}-flash-helper.sh ./
    ln -sf ${STAGING_BINDIR_NATIVE}/${FLASHTOOLS_DIR}/tegraflash.py ./

    rm -rf signed || true

    # Sign all tegra bins
    signfile " "

    mkdir -p ${DEPLOY_DIR_IMAGE}/bootfiles
    cp -r *.txt ${DEPLOY_DIR_IMAGE}/bootfiles/
    cp -r *xml* ${DEPLOY_DIR_IMAGE}/bootfiles/
    cp -r signed/* ${DEPLOY_DIR_IMAGE}/bootfiles/
    dd if=/dev/zero of="${DEPLOY_DIR_IMAGE}/bootfiles/bmp.blob" bs=1K count=70

    DEPLOY_DIR_IMAGE=${DEPLOY_DIR_IMAGE} /bin/bash ./create_blob_orin_agx.sh

    cp boot0.img ${DEPLOY_DIR_IMAGE}/bootfiles/
}


do_install() {
    install -d ${D}/${BINARY_INSTALL_PATH}
    cp -r ${S}/tegraflash/signed/* ${D}/${BINARY_INSTALL_PATH}
    rm ${D}/${BINARY_INSTALL_PATH}/boot*im* || true
    cp ${DEPLOY_DIR_IMAGE}/bootfiles/boot0.img ${D}/${BINARY_INSTALL_PATH}/
    cp ${S}/tegraflash/partition_specification234.txt ${D}/${BINARY_INSTALL_PATH}/
    cp ${S}/tegraflash/Image-initramfs* ${D}/${BINARY_INSTALL_PATH}/
}

do_deploy() {
    rm -rf ${DEPLOYDIR}/$(basename ${BINARY_INSTALL_PATH}) || true
    mkdir -p ${DEPLOYDIR}/$(basename ${BINARY_INSTALL_PATH})
    cp -r ${D}/${BINARY_INSTALL_PATH}/* ${DEPLOYDIR}/$(basename ${BINARY_INSTALL_PATH})
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
do_configure[depends] += " virtual/kernel:do_deploy "
do_configure[depends] += " tos-optee:do_deploy"
configure[depends] += "dosfstools-native:do_populate_sysroot mtools-native:do_populate_sysroot"
do_install[depends] += " virtual/kernel:do_deploy"
do_populate_lic[depends] += "tegra-binaries:do_unpack"

addtask do_deploy before do_package after do_install

COMPATIBLE_MACHINE = "jetson-agx-orin-devkit"
