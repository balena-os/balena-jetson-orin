DESCRIPTION = "balenaOS boot-time NVIDIA setup (CDI feature toggle + nvidia runtime registration + CDI spec regen)"
SUMMARY = "Configures balena-engine for the NVIDIA container stack on each boot"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

SRC_URI = "file://balena-nvidia-setup \
           file://balena-nvidia-setup.service \
           file://01-nvidia-setup.conf"

S = "${WORKDIR}"

inherit systemd

SYSTEMD_PACKAGES = "${PN}"
SYSTEMD_SERVICE:${PN} = "balena-nvidia-setup.service"
SYSTEMD_AUTO_ENABLE:${PN} = "enable"

do_install() {
    install -d ${D}${libexecdir}
    install -m 0755 ${WORKDIR}/balena-nvidia-setup ${D}${libexecdir}/balena-nvidia-setup

    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/balena-nvidia-setup.service ${D}${systemd_system_unitdir}/balena-nvidia-setup.service

    install -d ${D}${systemd_system_unitdir}/balena.service.d
    install -m 0644 ${WORKDIR}/01-nvidia-setup.conf ${D}${systemd_system_unitdir}/balena.service.d/01-nvidia-setup.conf
}

FILES:${PN} = "\
    ${libexecdir}/balena-nvidia-setup \
    ${systemd_system_unitdir}/balena-nvidia-setup.service \
    ${systemd_system_unitdir}/balena.service.d/01-nvidia-setup.conf \
"

RDEPENDS:${PN} = "jq nvidia-container-toolkit"
