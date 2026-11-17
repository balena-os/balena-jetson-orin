DESCRIPTION = "balenaOS boot-time NVIDIA setup (legacy nvidia runtime registration)"
SUMMARY = "Configures balena-engine for the NVIDIA legacy container runtime on each boot"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

SRC_URI = "file://balena-nvidia-setup \
           file://balena-nvidia-setup.service \
           file://01-nvidia-setup.conf"

# SRC_URI is file:// only, so everything unpacks flat into ${UNPACKDIR}
# (${WORKDIR}/sources). Note insane.bbclass hard-fails on `S = ${WORKDIR}`.
S = "${UNPACKDIR}"

inherit systemd

SYSTEMD_PACKAGES = "${PN}"
SYSTEMD_SERVICE:${PN} = "balena-nvidia-setup.service"
SYSTEMD_AUTO_ENABLE:${PN} = "enable"

do_install() {
    install -d ${D}${libexecdir}
    install -m 0755 ${S}/balena-nvidia-setup ${D}${libexecdir}/balena-nvidia-setup

    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${S}/balena-nvidia-setup.service ${D}${systemd_system_unitdir}/balena-nvidia-setup.service

    install -d ${D}${systemd_system_unitdir}/balena.service.d
    install -m 0644 ${S}/01-nvidia-setup.conf ${D}${systemd_system_unitdir}/balena.service.d/01-nvidia-setup.conf

}

FILES:${PN} = "\
    ${libexecdir}/balena-nvidia-setup \
    ${systemd_system_unitdir}/balena-nvidia-setup.service \
    ${systemd_system_unitdir}/balena.service.d/01-nvidia-setup.conf \
"

# jq is no longer needed: it was only used for the features.cdi merge, which
# went away with the CDI path.
RDEPENDS:${PN} = "nvidia-container-toolkit"
