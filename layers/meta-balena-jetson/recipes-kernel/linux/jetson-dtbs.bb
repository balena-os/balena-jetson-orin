FILESEXTRAPATHS:append := ":${THISDIR}/linux-tegra"

DESCRIPTION = "Package for deploying custom dtbs to the L4T 35.2.1 rootfs"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

do_install[depends] += " linux-jammy-nvidia-tegra:do_deploy "

S = "${WORKDIR}"
DTBNAME = "${@os.path.basename(d.getVar('KERNEL_DEVICETREE', True).split()[0])}"

do_install() {
	install -d ${D}/boot/
	install -m 0644 "${DEPLOY_DIR_IMAGE}/devicetree/${DTBNAME}" "${D}/boot/${DTBNAME}"
}

FILES:${PN} += " \
	/boot/ \
"

