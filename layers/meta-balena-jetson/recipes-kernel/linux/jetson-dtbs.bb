FILESEXTRAPATHS:append := ":${THISDIR}/linux-tegra"

DESCRIPTION = "Package for deploying custom dtbs to the L4T 35.2.1 rootfs"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

do_install[depends] += " linux-tegra:do_deploy "

S = "${WORKDIR}"
DTBNAME = "${@os.path.basename(d.getVar('KERNEL_DEVICETREE', True).split()[0])}"

do_install:jetson-agx-orin-devkit() {
	install -d ${D}/boot/
	install -m 0644 "${DEPLOY_DIR_IMAGE}/${DTBNAME}" "${D}/boot/${DTBNAME}"
        install -m 0644 "${DEPLOY_DIR_IMAGE}/tegra234-p3701-0004-p3737-0000.dtb" "${D}/boot/tegra234-p3701-0004-p3737-0000.dtb"
}

FILES:${PN}:jetson-agx-orin-devkit += " \
	/boot/tegra234-p3701-0000-p3737-0000.dtb \
	/boot/tegra234-p3701-0004-p3737-0000.dtb \
"

do_install:jetson-orin-nx-xavier-nx-devkit() {
        install -d ${D}/boot/
        install -m 0644 "${DEPLOY_DIR_IMAGE}/${DTBNAME}" "${D}/boot/${DTBNAME}"
}

FILES:${PN}:jetson-orin-nx-xavier-nx-devkit += " \
	/boot/tegra234-p3767-0000-p3509-a02.dtb \
"

do_install:jetson-xavier() {
        install -d ${D}/boot/
        install -m 0644 "${DEPLOY_DIR_IMAGE}/${DTBNAME}" "${D}/boot/${DTBNAME}"
        install -m 0644 "${DEPLOY_DIR_IMAGE}/tegra234-p3701-0004-p3737-0000.dtb" "${D}/boot/tegra234-p3701-0004-p3737-0000.dtb"
}

FILES:${PN}:jetson-xavier += " \
        /boot/tegra234-p3701-0000-p3737-0000.dtb \
        /boot/tegra234-p3701-0004-p3737-0000.dtb \
"

do_install:jetson-xavier-nx-devkit-emmc() {
        install -d ${D}/boot/
        install -m 0644 "${DEPLOY_DIR_IMAGE}/${DTBNAME}" "${D}/boot/${DTBNAME}"
}

FILES:${PN}:jetson-xavier-nx-devkit-emmc += " \
        /boot/tegra194-p3668-all-p3509-0000.dtb \
"

do_install:append:forecr-dsb-nx2-xavier-nx-emmc() {
	install -m 0644 ${DEPLOY_DIR_IMAGE}/tegra194-p3668-dsboard-nx2-0000.dtb ${D}/boot/tegra194-p3668-dsboard-nx2-0000.dtb
	install -m 0644 ${DEPLOY_DIR_IMAGE}/tegra194-p3668-dsboard-nx2-0000-imx477.dtb ${D}/boot/tegra194-p3668-dsboard-nx2-0000-imx477.dtb
	install -m 0644 ${DEPLOY_DIR_IMAGE}/tegra194-p3668-dsboard-nx2-0000-rev121.dtb ${D}/boot/tegra194-p3668-dsboard-nx2-0000-rev121.dtb
        install -m 0644 ${DEPLOY_DIR_IMAGE}/tegra194-p3668-dsboard-nx2-0000-rev121-imx477.dtb ${D}/boot/tegra194-p3668-dsboard-nx2-0000-rev121-imx477.dtb
}

FILES:${PN}:forecr-dsb-nx2-xavier-nx-emmc += " \
        /boot/tegra194-p3668-all-p3509-0000.dtb \
	/boot/tegra194-p3668-dsboard-nx2-0000.dtb \
	/boot/tegra194-p3668-dsboard-nx2-0000-imx477.dtb \
	/boot/tegra194-p3668-dsboard-nx2-0000-rev121.dtb \
	/boot/tegra194-p3668-dsboard-nx2-0000-rev121-imx477.dtb \
"
