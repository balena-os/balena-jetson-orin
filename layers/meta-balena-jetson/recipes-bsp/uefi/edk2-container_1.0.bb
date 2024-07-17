SUMMARY = "Edk2 container build"
LICENSE = "BSD-2-Clause-Patent"
LICENSE .= " & Proprietary"

LIC_FILES_CHCKSM  = "file://edk2_License.txt;md5=2b415520383f7964e96700ae12b4570a"
LIC_FILES_CHKSUM += "file://edk2-platforms_License.txt;md5=2b415520383f7964e96700ae12b4570a"
LIC_FILES_CHKSUM += "file://edk2-nvidia_LICENSE;md5=52d8683e3d65a77ef84cc863e3f24f25"
LIC_FILES_CHKSUM += "file://NOTICE.nvgop-chips-platform.efi;md5=549bbaa72578510a18ba3c324465027c"

SRC_URI[edk2_license.sha256sum] = "50ce20c9cfdb0e19ee34fe0a51fc0afe961f743697b068359ab2f862b494df80"
SRC_URI[edk2_platforms_license.sha256sum] = "50ce20c9cfdb0e19ee34fe0a51fc0afe961f743697b068359ab2f862b494df80"
SRC_URI[edk2_nvidia_license.sha256sum] = "cbae92214cd28ebe743fa231c94b203680fdd0275fd8e1b3de7023a38e1bb232"
SRC_URI[nvgop_chips_platform_license.sha256sum] = "a9406324c8b0d836558c6d6825d1ec756f34f71471e8c7725d32d7016b6a6ad4"

SRC_URI = " \
    https://raw.githubusercontent.com/NVIDIA/edk2/r36.3.0-updates/License.txt;downloadfilename=edk2_License.txt;name=edk2_license \
    https://raw.githubusercontent.com/NVIDIA/edk2-platforms/r36.3.0-updates/License.txt;downloadfilename=edk2-platforms_License.txt;name=edk2_platforms_license \
    https://raw.githubusercontent.com/NVIDIA/edk2-nvidia/r36.3.0-updates/LICENSE;downloadfilename=edk2-nvidia_LICENSE;name=edk2_nvidia_license \
    https://raw.githubusercontent.com/NVIDIA/edk2-nvidia-non-osi/r36.3.0-updates/Silicon/NVIDIA/Drivers/NvGopDriver/NOTICE.nvgop-chips-platform.efi;name=nvgop_chips_platform_license \
    file://Dockerfile \
    file://build.sh \
    file://0001-edk2-nvidia-Add-changes-for-balenaOS-integration_patch.txt \
    file://0001-edk2-Disable-network-boot-and-allow-UEFI-capsule-dow_patch.txt \
    file://0001-AGX-Orin-32GB-Integrate-with-balenaOS-on-L4T-36.3_patch.txt \
    file://0001-Orin-Nano-Integrate-with-balenaOS-on-L4T-36.3_patch.txt \
    file://0001-Orin-NX-16GB-Integrate-with-balenaOS-on-L4T-36.3_patch.txt \
    file://0001-Seeed-J4012-Integrate-with-balenaOS-on-L4T-36.3_patch.txt \
    file://0001-Seeed-J3010-Integrate-with-balenaOS-on-L4T-36.3_patch.txt \
    file://0001-edk2-nvidia-Remove-pva-fw-from-required-list_patch.txt \
    file://0001-StandaloneMmOptee-Don-t-assert-if-var-store-integrit_patch.txt \
"

inherit deploy

S = "${WORKDIR}"
B = "${WORKDIR}/build"
PN = "edk2-container"

PROVIDES = "edk2-container"

do_compile () {
    mkdir -p ${WORKDIR}/out
    cp ${WORKDIR}/Dockerfile ${B}/
    cp ${WORKDIR}/build.sh ${B}/
    chmod +x ${B}/build.sh
    cp -r ${WORKDIR}/*_patch.txt ${B}/

    IMAGETAG="${PN}:$(date +%s)-${MACHINE}"

    DOCKER_API_VERSION=1.22 docker build --tag ${IMAGETAG} ${B}/ --build-arg "DEVICE_TYPE=${MACHINE}"
    DOCKER_API_VERSION=1.22 docker run --rm -v ${WORKDIR}/out:/out -v "${HOME}":"${HOME}" -e EDK2_DOCKER_USER_HOME="${HOME}" -e DEVICE_TYPE="${MACHINE}" ${IMAGETAG} su /bin/bash -c "/build/build.sh && cp /build/nvidia-uefi/images/uefi_Jetson_DEBUG.bin /out/uefi_jetson.bin && cp /build/nvidia-uefi/images/BOOTAA64_Jetson_DEBUG.efi /out/BOOTAA64.efi"
}

do_compile[network] = "1"

do_install() {
    install -d ${D}/opt/tegra-binaries/edk2
    install -d ${D}/opt/tegra-binaries/edk2-platforms
    install -d ${D}/opt/tegra-binaries/edk2-nvidia
    install -d ${D}/opt/tegra-binaries/edk2-nvidia-non-osi
    install -m 0644 ${WORKDIR}/edk2_License.txt ${D}/opt/tegra-binaries/edk2/License.txt
    install -m 0644 ${WORKDIR}/edk2-platforms_License.txt ${D}/opt/tegra-binaries/edk2-platforms/License.txt
    install -m 0644 ${WORKDIR}/edk2-nvidia_LICENSE ${D}/opt/tegra-binaries/edk2-nvidia/LICENSE
    install -m 0644 ${WORKDIR}/NOTICE.nvgop-chips-platform.efi ${D}/opt/tegra-binaries/edk2-nvidia-non-osi/
}

do_deploy () {
    rm -rf ${DEPLOY_DIR_IMAGE}/bootfiles/EFI/BOOT || true
    mkdir -p ${DEPLOY_DIR_IMAGE}/bootfiles/EFI/BOOT/
    cp ${WORKDIR}/out/uefi_jetson.bin ${DEPLOY_DIR_IMAGE}/
    cp ${WORKDIR}/out/BOOTAA64.efi ${DEPLOY_DIR_IMAGE}/bootfiles/EFI/BOOT/
}

FILES:${PN} = " /opt/tegra-binaries/ "

do_compile[nostamp] = "1"
do_deploy[nostamp] = "1"

addtask do_deploy before do_package after do_install
