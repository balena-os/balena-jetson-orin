FILESEXTRAPATHS:append := ":${THISDIR}/linux-tegra"

DESCRIPTION = "Package for deploying custom dtbs to the L4T 35.2.1 rootfs"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

do_install[depends] += " linux-jammy-nvidia-tegra:do_deploy "

S = "${WORKDIR}"
DTBNAME = "${@os.path.basename(d.getVar('KERNEL_DEVICETREE', True).split()[0])}"

do_install:jetson-agx-orin-devkit() {
	install -d ${D}/boot/
	install -m 0644 "${DEPLOY_DIR_IMAGE}/devicetree/${DTBNAME}" "${D}/boot/${DTBNAME}"
}

FILES:${PN}:jetson-agx-orin-devkit += " \
	/boot/ \
"
#	/boot/tegra234-p3701-0000-p3737-0000.dtb 
#	/boot/tegra234-p3701-0004-p3737-0000.dtb 
#	/boot/tegra234-p3701-0000-p3737-0000-spi.dtb 


do_install:jetson-orin-nx-xavier-nx-devkit() {
        install -d ${D}/boot/
        install -m 0644 "${DEPLOY_DIR_IMAGE}/${DTBNAME}" "${D}/boot/${DTBNAME}"
}

FILES:${PN}:jetson-orin-nx-xavier-nx-devkit += " \
	/boot/tegra234-p3767-0000-p3509-a02.dtb \
"

do_install:jetson-orin-nano-devkit-nvme() {
        install -d ${D}/boot/
        install -m 0644 "${DEPLOY_DIR_IMAGE}/${DTBNAME}" "${D}/boot/${DTBNAME}"
}

FILES:${PN}:jetson-orin-nano-devkit-nvme += " \
        /boot/tegra234-p3767-0003-p3768-0000-a0.dtb \
"
