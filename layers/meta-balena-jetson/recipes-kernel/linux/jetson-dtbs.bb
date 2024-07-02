FILESEXTRAPATHS:append := ":${THISDIR}/linux-jammy-nvidia-tegra"

DESCRIPTION = "Package for deploying default and custom dtbs to the L4T 36.3 rootfs"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

# In Jetpack 6 the nvidia-kernel-oot provides all device-trees
do_install[depends] += " nvidia-kernel-oot:do_deploy "

S = "${WORKDIR}"
DTBNAME = "${@os.path.basename(d.getVar('KERNEL_DEVICETREE', True).split()[0])}"

do_install() {
	install -d ${D}/boot/
	install -m 0644 "${DEPLOY_DIR_IMAGE}/devicetree/${DTBNAME}" "${D}/boot/${DTBNAME}"
}

FILES:${PN}:jetson-agx-orin-devkit += " \
	/boot/tegra234-p3737-0000+p3701-0000-nv.dtb \
"

FILES:${PN}:jetson-orin-nx-xavier-nx-devkit += " \
	/boot/tegra234-p3768-0000+p3767-0000-nv.dtb \
"

FILES:${PN}:jetson-orin-nano-devkit-nvme += " \
        /boot/tegra234-p3768-0000+p3767-0005-nv.dtb \
"

FILES:${PN}:jetson-orin-nano-4g-devkit += " \
        /boot/tegra234-p3768-0000+p3767-0004-nv.dtb \
"
