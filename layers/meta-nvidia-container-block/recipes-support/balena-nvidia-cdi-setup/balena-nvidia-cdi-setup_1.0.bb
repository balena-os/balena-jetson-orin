DESCRIPTION = "balenaOS boot-time NVIDIA CDI spec generator"
SUMMARY = "Enables balena-engine CDI + regenerates /var/run/cdi/nvidia.yaml for the running hardware on each boot"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

SRC_URI = "file://balena-nvidia-cdi-setup \
           file://balena-nvidia-cdi-setup.service \
           file://01-nvidia-cdi.conf"

S = "${WORKDIR}"

inherit systemd

SYSTEMD_PACKAGES = "${PN}"
SYSTEMD_SERVICE:${PN} = "balena-nvidia-cdi-setup.service"
SYSTEMD_AUTO_ENABLE:${PN} = "enable"

do_install() {
    install -d ${D}${libexecdir}
    install -m 0755 ${WORKDIR}/balena-nvidia-cdi-setup ${D}${libexecdir}/balena-nvidia-cdi-setup

    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/balena-nvidia-cdi-setup.service ${D}${systemd_system_unitdir}/balena-nvidia-cdi-setup.service

    install -d ${D}${systemd_system_unitdir}/balena.service.d
    install -m 0644 ${WORKDIR}/01-nvidia-cdi.conf ${D}${systemd_system_unitdir}/balena.service.d/01-nvidia-cdi.conf
}

FILES:${PN} = "\
    ${libexecdir}/balena-nvidia-cdi-setup \
    ${systemd_system_unitdir}/balena-nvidia-cdi-setup.service \
    ${systemd_system_unitdir}/balena.service.d/01-nvidia-cdi.conf \
"

RDEPENDS:${PN} = "jq nvidia-container-toolkit-ctk"
