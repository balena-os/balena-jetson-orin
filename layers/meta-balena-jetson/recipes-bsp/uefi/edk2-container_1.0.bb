SUMMARY = "Edk2 container build"
LICENSE = "BSD-2-Clause-Patent"
LICENSE .= " & Proprietary"

LIC_FILES_CHCKSM  = "file://edk2_License.txt;md5=2b415520383f7964e96700ae12b4570a"
LIC_FILES_CHKSUM += "file://edk2-platforms_License.txt;md5=2b415520383f7964e96700ae12b4570a"
LIC_FILES_CHKSUM += "file://edk2-nvidia_LICENSE;md5=52d8683e3d65a77ef84cc863e3f24f25"
LIC_FILES_CHKSUM += "file://NOTICE.nvgop-chips-platform.efi;md5=782048cadee3851a0da2b4a3fdae0d93"

SRC_URI[edk2_license.sha256sum] = "50ce20c9cfdb0e19ee34fe0a51fc0afe961f743697b068359ab2f862b494df80"
SRC_URI[edk2_platforms_license.sha256sum] = "50ce20c9cfdb0e19ee34fe0a51fc0afe961f743697b068359ab2f862b494df80"
SRC_URI[edk2_nvidia_license.sha256sum] = "cbae92214cd28ebe743fa231c94b203680fdd0275fd8e1b3de7023a38e1bb232"
SRC_URI[nvgop_chips_platform_license.sha256sum] = "d6f3ecf032a14d998fbf0cf7fd5bdedf143f585b8da57133f3f2bcedf524a283"

DEFAULT_DTB:jetson-orin-nano-devkit-nvme = "tegra234-p3768-0000+p3767-0005-nv-super.dtb"
DEFAULT_DTB:jetson-agx-orin-devkit = "tegra234-p3737-0000+p3701-0000-nv.dtb"
DEFAULT_DTB:jetson-orin-nx-xavier-nx-devkit = "tegra234-p3768-0000+p3767-0000-nv-super.dtb"
DEFAULT_DTB:jetson-orin-nx-seeed-j4012 ="tegra234-p3768-0000+p3767-0000-nv.dtb"
DEFAULT_DTB:jetson-orin-nano-seeed-j3010 ="tegra234-p3768-0000+p3767-0004-nv-super.dtb"
DEFAULT_DTB:jetson-agx-orin-devkit-64gb = "tegra234-p3737-0000+p3701-0005-nv.dtb"
DEFAULT_DTB:forecr-dsb-ornx-orin-nano-8gb = "tegra234-p3768-0000+p3767-0003-nv-super.dtb"
DEFAULT_DTB:forecr-dsb-ornx-lan-orin-nano-4gb ="tegra234-p3768-0000+p3767-0004-nv.dtb"
DEFAULT_DTB:forecr-dsb-ornx-lan-orin-nx-16gb = "tegra234-p3768-0000+p3767-0000-nv.dtb"

SRC_URI = " \
    https://raw.githubusercontent.com/NVIDIA/edk2/r36.4.3-updates/License.txt;downloadfilename=edk2_License.txt;name=edk2_license \
    https://raw.githubusercontent.com/NVIDIA/edk2-platforms/r36.4.3-updates/License.txt;downloadfilename=edk2-platforms_License.txt;name=edk2_platforms_license \
    https://raw.githubusercontent.com/NVIDIA/edk2-nvidia/r36.4.3-updates/LICENSE;downloadfilename=edk2-nvidia_LICENSE;name=edk2_nvidia_license \
    https://raw.githubusercontent.com/NVIDIA/edk2-nvidia-non-osi/r36.4.3-updates/Silicon/NVIDIA/Drivers/NvGopDriver/NOTICE.nvgop-chips-platform.efi;name=nvgop_chips_platform_license \
    file://Dockerfile \
    file://build.sh \
    file://0001-edk2-nvidia-Add-changes-for-balenaOS-integration_patch.txt \
    file://0001-edk2-Disable-network-boot-and-allow-UEFI-capsule-dow_patch.txt \
    file://0001-AGX-Orin-32GB-Integrate-with-balenaOS-on-L4T-36.4_patch.txt \
    file://0001-Orin-Nano-Integrate-with-balenaOS-on-L4T-36.4_patch.txt \
    file://0001-Orin-NX-16GB-Integrate-with-balenaOS-on-L4T-36.4_patch.txt \
    file://0001-AGX-Orin-64GB-Integrate-with-balenaOS-on-L4T-36.4_patch.txt \
    file://0001-edk2-nvidia-Remove-pva-fw-from-required-list_patch.txt \
    file://0001-StandaloneMmOptee-Don-t-assert-if-var-store-integrit_patch.txt \
    file://0001-TegraPlatformBootManager-TegraPlatformBootManagerDxe_patch.txt \
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

    DOCKER_API_VERSION=1.24 docker build --tag ${IMAGETAG} ${B}/ --build-arg "DEVICE_TYPE=${MACHINE}" --build-arg "DEFAULT_DTB=${DEFAULT_DTB}"
    DOCKER_API_VERSION=1.24 docker run --rm -v ${WORKDIR}/out:/out -v "${HOME}":"${HOME}" -e EDK2_DOCKER_USER_HOME="${HOME}" -e DEVICE_TYPE="${MACHINE}" -e "DEFAULT_DTB=${DEFAULT_DTB}" ${IMAGETAG} su /bin/bash -c "/build/build.sh && cp /build/nvidia-uefi/images/uefi_Jetson_DEBUG.bin /out/uefi_jetson.bin && cp /build/nvidia-uefi/images/BOOTAA64_Jetson_DEBUG.efi /out/BOOTAA64.efi"
    DOCKER_API_VERSION=1.24 docker rmi -f ${IMAGETAG}
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
