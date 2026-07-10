DESCRIPTION = "Generate UEFI capsule"

require recipes-bsp/tegra-binaries/tegra-binaries-${PV}.inc

inherit deploy l4t_bsp

JETSON_BOARD_SPEC:jetson-orin-nano-devkit-nvme="jetson_board_spec_nano.cfg"
JETSON_BOARD_SPEC:jetson-orin-nx-xavier-nx-devkit="jetson_board_spec_nx.cfg"
JETSON_BOARD_SPEC:jetson-agx-orin-devkit="jetson_board_spec_agx_32gb.cfg"
JETSON_BOARD_SPEC:jetson-agx-orin-devkit-64gb="jetson_board_spec_agx_64gb.cfg"
JETSON_BOARD_SPEC:jetson-orin-nano-seeed-j3010="jetson_board_spec_j3010_j4012.cfg"
JETSON_BOARD_SPEC:jetson-orin-nx-seeed-j4012="jetson_board_spec_j3010_j4012.cfg"
JETSON_BOARD_SPEC:forecr-dsb-ornx-orin-nano-8gb="jetson_board_spec_forecr.cfg"

SRC_URI = " \
    file://Dockerfile \
    file://build.sh \
    file://${JETSON_BOARD_SPEC} \
    ${L4T_URI_BASE}/${L4T_BSP_PREFIX}_Linux_R${L4T_VERSION}_aarch64.tbz2;name=l4tbsp;unpack=0 \
"

SRC_URI[l4tbsp.sha256sum] = "1626626cd827de0e350b8802033b9da653c69b2290accedb9e5d01f49607e099"

PN = "uefi-capsule-container"

UEFI_CAPSULE:jetson-orin-nx-xavier-nx-devkit = "TEGRA_BL_Orin_NX.Cap.gz"
UEFI_CAPSULE:jetson-orin-nano-devkit-nvme = "TEGRA_BL_Orin_Nano.Cap.gz"
UEFI_CAPSULE:jetson-orin-nx-seeed-j4012 = "TEGRA_BL_Seeed_j4012.Cap.gz"
UEFI_CAPSULE:jetson-orin-nano-seeed-j3010 = "TEGRA_BL_Seeed_j3010.Cap.gz"
UEFI_CAPSULE:jetson-agx-orin-devkit="TEGRA_BL_3701.Cap.gz"
UEFI_CAPSULE:jetson-agx-orin-devkit-64gb = "TEGRA_BL_3701_64.Cap.gz"
UEFI_CAPSULE:forecr-dsb-ornx-orin-nano-8gb = "TEGRA_BL_Forecr_ORNX_LAN_Nano_8gb.Cap.gz"

# Upstream uefi capsule recipe
# cannot be built due to python/rust dependencies
# and a rust update for all Yocto versions
# cannot be done at this point. We thus build
# the UEFI capsule in a container using this recipe.
PROVIDES = "uefi-capsule-container"

do_compile () {
    mkdir -p ${B}/out
    cp ${UNPACKDIR}/Dockerfile ${B}/
    cp ${UNPACKDIR}/build.sh ${B}/

    cp ${DEPLOY_DIR_IMAGE}/uefi_t23x_general.bin ${B}/
    cp ${DEPLOY_DIR_IMAGE}/standalone_mm_optee.bin ${B}/
    chmod +x ${B}/build.sh
    cp ${UNPACKDIR}/${JETSON_BOARD_SPEC} ${B}/jetson_board_spec.cfg
    cp ${UNPACKDIR}/Jetson_Linux_R39.2.0_aarch64.tbz2 ${B}/

    IMAGETAG="${PN}:$(date +%s)-${MACHINE}"

    DOCKER_API_VERSION=1.24 docker build --tag ${IMAGETAG} ${B}/ --build-arg "DEVICE_TYPE=${MACHINE}"
    DOCKER_API_VERSION=1.24 docker run --rm -v ${B}/out:/out -v "${HOME}":"${HOME}" -e EDK2_DOCKER_USER_HOME="${HOME}" -e DEVICE_TYPE="${MACHINE}" ${IMAGETAG} su /bin/bash -c "/build_dir/build.sh && cp /build_dir/Linux_for_Tegra/TEGRA_BL.Cap.gz /out/${UEFI_CAPSULE} && cp /build_dir/Linux_for_Tegra/jetson_board_spec.cfg /out/"
    DOCKER_API_VERSION=1.24 docker rmi -f ${IMAGETAG}
}

do_compile[network] = "1"

do_install() {
    install -d ${D}/opt/tegra-binaries/
    install -m 0644 ${B}/out/${UEFI_CAPSULE} ${D}/opt/tegra-binaries/${UEFI_CAPSULE}
}

do_deploy () {
    mkdir -p ${DEPLOY_DIR_IMAGE}/bootfiles/
}

FILES:${PN} = " /opt/tegra-binaries/ "

do_compile[nostamp] = "1"
do_deploy[nostamp] = "1"
do_compile[depends] += " edk2-firmware-tegra:do_deploy edk2-nvidia-standalone-mm:do_deploy "
do_convert_crlf_to_lf[depends] += " tegra-binaries:do_patch "
addtask do_deploy before do_package after do_install

# redefine the global reproducible-build function as a no-op
# for this recipe to prevent shared-work directory race conditions.
python create_source_date_epoch_stamp() {
    pass
}

# fix QA Issue: File ... TEGRA_BL.Cap contains reference to TMPDIR
INSANE_SKIP:${PN} += "buildpaths"
