DESCRIPTION = "Virtual/dtb provider for Jetson Linux device trees"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
INHIBIT_DEFAULT_DEPS = "1"

inherit deploy kernel-arch

PROVIDES = "virtual/dtb"

PACKAGE_ARCH = "${MACHINE_ARCH}"

FILESEXTRAPATHS:prepend := "${THISDIR}:"
SRC_URI := " file://syslogic/ "

do_deploy() {
    install -d ${DEPLOYDIR}/devicetree
    install -m 0644 ${WORKDIR}/syslogic/* ${DEPLOYDIR}/devicetree/
}

addtask deploy before do_build after do_install
