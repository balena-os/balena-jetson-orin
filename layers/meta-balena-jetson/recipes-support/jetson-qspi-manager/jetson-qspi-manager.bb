FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

DESCRIPTION = "Jetson Orin QSPI manager service"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${BALENA_COREBASE}/COPYING.Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

SRC_URI = " \
    file://jetson-qspi-manager \
    file://jetson-qspi-helpers \
    file://jetson-qspi-manager.service \
    "

S = "${WORKDIR}"

RDEPENDS:${PN} += " bash "

inherit allarch systemd

COMPAT_SPEC_NAME="jetson-orin-nano-devkit-super"
# Existing J401X boards do not support Super mode
COMPAT_SPEC_NAME:jetson-orin-nx-seeed-j4012="jetson-orin-nano-devkit"
COMPAT_SPEC_NAME:jetson-agx-orin-devkit="jetson-agx-orin-devkit"
COMPAT_SPEC_NAME:jetson-agx-orin-devkit-64gb="jetson-agx-orin-devkit"

SYSTEMD_SERVICE:${PN} = " \
    jetson-qspi-manager.service \
    "

do_patch[noexec] = "1"
do_compile[noexec] = "1"
do_build[noexec] = "1"

do_install() {
    install -d ${D}${bindir}/
    install -d ${D}/${libexecdir}/
    install -m 0755 ${WORKDIR}/jetson-qspi-manager ${D}${bindir}/
    install -m 0644 ${WORKDIR}/jetson-qspi-helpers ${D}/${libexecdir}/

    sed -i -e 's,@ORIN_DEVICE_TYPE@,${COMPAT_SPEC_NAME},g' ${D}/${libexecdir}/jetson-qspi-helpers

    if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)}; then
        install -d ${D}${systemd_unitdir}/system/
        install -d ${D}${sysconfdir}/systemd/system/multi-user.target.wants/
        install -m 0644 ${WORKDIR}/jetson-qspi-manager.service ${D}${systemd_unitdir}/system/

        sed -i -e 's,@BASE_BINDIR@,${base_bindir},g' \
            -e 's,@BINDIR@,${bindir},g' \
            ${D}${systemd_unitdir}/system/*.service
    fi
}
