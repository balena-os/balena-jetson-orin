SUMMARY = "UEFI Capsule container build"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${BALENA_COREBASE}/COPYING.Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

# Jetson Orin Nano 8GB and Orin NX 16GB Devkits
JETSON_BOARD_SPEC:jetson-orin-nano-devkit-nvme="jetson_board_spec_nano.cfg"
JETSON_BOARD_SPEC:jetson-orin-nx-xavier-nx-devkit="jetson_board_spec_nx.cfg"
JETSON_BOARD_SPEC:jetson-agx-orin-devkit="jetson_board_spec_agx_32gb.cfg"
JETSON_BOARD_SPEC:jetson-agx-orin-devkit-64gb="jetson_board_spec_agx_64gb.cfg"
JETSON_BOARD_SPEC:jetson-orin-nano-seeed-j3010="jetson_board_spec_j3010_j4012.cfg"
JETSON_BOARD_SPEC:jetson-orin-nx-seeed-j4012="jetson_board_spec_j3010_j4012.cfg"
JETSON_BOARD_SPEC:forecr-dsb-ornx-orin-nano-8gb="jetson_board_spec_forecr.cfg"

UEFI_CAPSULE:jetson-orin-nx-xavier-nx-devkit = "TEGRA_BL_Orin_NX.Cap.gz"
UEFI_CAPSULE:jetson-orin-nano-devkit-nvme = "TEGRA_BL_Orin_Nano.Cap.gz"
UEFI_CAPSULE:jetson-orin-nx-seeed-j4012 = "TEGRA_BL_Seeed_j4012.Cap.gz"
UEFI_CAPSULE:jetson-orin-nano-seeed-j3010 = "TEGRA_BL_Seeed_j3010.Cap.gz"
UEFI_CAPSULE:jetson-agx-orin-devkit="TEGRA_BL_3701.Cap.gz"
UEFI_CAPSULE:jetson-agx-orin-devkit-64gb = "TEGRA_BL_3701_64.Cap.gz"
UEFI_CAPSULE:forecr-dsb-ornx-orin-nano-8gb = "TEGRA_BL_Forecr_ORNX_LAN_Nano_8gb.Cap.gz"


SRC_URI = " \
    file://Dockerfile \
    file://build.sh \
    file://${JETSON_BOARD_SPEC} \
    https://developer.nvidia.com/downloads/embedded/l4t/r36_release_v4.3/release/Jetson_Linux_r36.4.3_aarch64.tbz2;name=l4tbsp;unpack=0 \
"

SRC_URI[l4tbsp.sha256sum] = "949a44049c4ce6a8efdf572ea0820c874f6ee5d41ca3e4935b9f0e38d11873d2"

inherit deploy l4t_bsp

S = "${WORKDIR}"
B = "${WORKDIR}/build"
PN = "uefi-capsule-container"

PROVIDES = "uefi-capsule-container"

do_compile () {
    mkdir -p ${B}/out
    cp ${WORKDIR}/Dockerfile ${B}/
    cp ${WORKDIR}/build.sh ${B}/

    # Use the UEFI firmware binary built by the edk2-container package
    cp ${DEPLOY_DIR_IMAGE}/uefi_jetson.bin ${B}/
    chmod +x ${B}/build.sh

    # Each board has its own board spec which
    # only includes the strictly necessary
    # QSPI configurations for it, to keep the UEFI
    # capsule size at a minimum so it can fit in the
    # boot partition.
    cp ${WORKDIR}/${JETSON_BOARD_SPEC} ${B}/jetson_board_spec.cfg
    cp ${S}/Jetson_Linux_r36.4.3_aarch64.tbz2 ${B}/

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
do_compile[depends] += "edk2-container:do_deploy"

addtask do_deploy before do_package after do_install
