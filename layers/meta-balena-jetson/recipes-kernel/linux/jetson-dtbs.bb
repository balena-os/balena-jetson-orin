FILESEXTRAPATHS:append := ":${THISDIR}/linux-jammy-nvidia-tegra"

DESCRIPTION = "Package for deploying default and custom dtbs to the JP6 rootfs"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

# In Jetpack 6.2 the nvidia-kernel-oot-dtb deploys all device-trees
do_install[depends] += " nvidia-kernel-oot-dtb:do_deploy "

SRC_URI += " \
    file://tegra234-p3737-0000+p3701-0000-nv-spi.dtb \
	file://tegra234-p3768-0000+p3767-0005-nv-super-ths1-no-dma.dtb \
"

SRC_URI:jetson-orin-nano-seeed-j3010 += " \
    file://tegra234-j401-p3768-0000+p3767-0004-recomputer-super.dtb \
    file://tegra234-j401-p3768-0000+p3767-0004-recomputer.dtb \
    file://tegra234-p3767-camera-p3768-imx219-dual-seeed.dtbo \
"

SRC_URI:jetson-orin-nx-seeed-j4012 += " \
    file://tegra234-j401-p3768-0000+p3767-0000-recomputer.dtb \
    file://tegra234-p3767-camera-p3768-imx219-dual-seeed.dtbo \
"

SRC_URI:append:forecr-dsb-ornx-lan = " \
    file://forecr-dsb-ornx-lan/tegra234-p3768-0000+p3767-0000-nv.dtb \
    file://forecr-dsb-ornx-lan/tegra234-p3768-0000+p3767-0003-nv.dtb \
    file://forecr-dsb-ornx-lan/tegra234-p3768-0000+p3767-0004-nv.dtb \
    file://forecr-dsb-ornx-lan/tegra234-p3768-0000+p3767-0003-nv-super.dtb \
"

S = "${WORKDIR}"
DTBNAME = "${@os.path.basename(d.getVar('KERNEL_DEVICETREE', True).split()[0])}"

do_install() {
	install -d ${D}/boot/
	install -m 0644 "${DEPLOY_DIR_IMAGE}/devicetree/${DTBNAME}" "${D}/boot/${DTBNAME}"
}

do_install:append:jetson-agx-orin-devkit() {
	install -m 0644 "${WORKDIR}/tegra234-p3737-0000+p3701-0000-nv-spi.dtb" "${D}/boot/tegra234-p3737-0000+p3701-0000-nv-spi.dtb"
}

# Forecr boards come with pre-built device trees.
# DTBNAME comes from the the machine config
do_install:forecr-dsb-ornx-lan() {
	install -d ${D}/boot/
	install -m 0644 "${WORKDIR}/forecr-dsb-ornx-lan/${DTBNAME}" "${D}/boot/${DTBNAME}"
        install -m 0644 "${WORKDIR}/forecr-dsb-ornx-lan/tegra234-p3768-0000+p3767-0003-nv-super.dtb" "${D}/boot/tegra234-p3768-0000+p3767-0003-nv-super.dtb"
}

do_install:append:jetson-orin-nano-devkit-nvme() {
	install -m 0644 "${DEPLOY_DIR_IMAGE}/devicetree/tegra234-p3768-0000+p3767-0005-nv.dtb" "${D}/boot/tegra234-p3768-0000+p3767-0005-nv.dtb"
	install -m 0644 "${DEPLOY_DIR_IMAGE}/devicetree/tegra234-p3768-0000+p3767-0003-nv.dtb" "${D}/boot/tegra234-p3768-0000+p3767-0003-nv.dtb"
	install -m 0644 "${DEPLOY_DIR_IMAGE}/devicetree/tegra234-p3768-0000+p3767-0003-nv-super.dtb" "${D}/boot/tegra234-p3768-0000+p3767-0003-nv-super.dtb"
	install -m 0644 "${WORKDIR}/tegra234-p3768-0000+p3767-0005-nv-super-ths1-no-dma.dtb" "${D}/boot/tegra234-p3768-0000+p3767-0005-nv-super-ths1-no-dma.dtb"
}

do_install:append:jetson-orin-nx-xavier-nx-devkit() {
        install -m 0644 "${DEPLOY_DIR_IMAGE}/devicetree/tegra234-p3768-0000+p3767-0000-nv.dtb" "${D}/boot/tegra234-p3768-0000+p3767-0000-nv.dtb"
}

do_install:append:jetson-orin-nano-seeed-j3010() {
	install -d ${D}/boot/devicetree/

	# Obtained from https://github.com/Seeed-Studio/Linux_for_Tegra.git - commit 5b18d7990ca342bbeb70ce5715ea0473d118278f, branch r36.4.3
	install -m 0644 "${WORKDIR}/tegra234-j401-p3768-0000+p3767-0004-recomputer.dtb" "${D}/boot/tegra234-p3768-0000+p3767-0004-nv.dtb"
	install -m 0644 "${WORKDIR}/tegra234-j401-p3768-0000+p3767-0004-recomputer-super.dtb" "${D}/boot/tegra234-p3768-0000+p3767-0004-nv-super.dtb"
	install -m 0644 "${WORKDIR}/tegra234-p3767-camera-p3768-imx219-dual-seeed.dtbo" "${D}/boot/devicetree/tegra234-p3767-camera-p3768-imx219-dual-seeed.dtbo"
}

do_install:append:jetson-orin-nx-seeed-j4012() {
	install -d ${D}/boot/devicetree/

        # Obtained from https://github.com/Seeed-Studio/Linux_for_Tegra.git - commit 5b18d7990ca342bbeb70ce5715ea0473d118278f, branch r36.4.3
        install -m 0644 "${WORKDIR}/tegra234-j401-p3768-0000+p3767-0000-recomputer.dtb" "${D}/boot/tegra234-p3768-0000+p3767-0000-nv.dtb"
        install -m 0644 "${WORKDIR}/tegra234-p3767-camera-p3768-imx219-dual-seeed.dtbo" "${D}/boot/devicetree/tegra234-p3767-camera-p3768-imx219-dual-seeed.dtbo"
}

FILES:${PN}:jetson-agx-orin-devkit += " \
	/boot/tegra234-p3737-0000+p3701-0000-nv.dtb \
	/boot/tegra234-p3737-0000+p3701-0000-nv-spi.dtb \
"

FILES:${PN}:jetson-orin-nx-xavier-nx-devkit += " \
	/boot/tegra234-p3768-0000+p3767-0000-nv.dtb \
	/boot/tegra234-p3768-0000+p3767-0000-nv-super.dtb \
"

FILES:${PN}:jetson-orin-nano-devkit-nvme += " \
	/boot/tegra234-p3768-0000+p3767-0005-nv.dtb \
	/boot/tegra234-p3768-0000+p3767-0005-nv-super.dtb \
	/boot/tegra234-p3768-0000+p3767-0005-nv-super-ths1-no-dma.dtb \
	/boot/tegra234-p3768-0000+p3767-0003-nv.dtb \
	/boot/tegra234-p3768-0000+p3767-0003-nv-super.dtb \
"

FILES:${PN}:jetson-orin-nano-4g-devkit += " \
        /boot/tegra234-p3768-0000+p3767-0004-nv.dtb \
        /boot/tegra234-p3768-0000+p3767-0004-nv-super.dtb \
"

FILES:${PN}:jetson-agx-orin-devkit-64gb += " \
	/boot/tegra234-p3737-0000+p3701-0005-nv.dtb \
"

FILES:${PN}:forecr-dsb-ornx-lan += " \
        /boot/${DTBNAME} \
	/boot/tegra234-p3768-0000+p3767-0003-nv-super.dtb \
"
FILES:${PN}:jetson-orin-nano-seeed-j3010 += " \
	/boot/tegra234-p3768-0000+p3767-0004-nv-super.dtb \
	/boot/tegra234-p3768-0000+p3767-0004-nv.dtb \
	/boot/devicetree/tegra234-p3767-camera-p3768-imx219-dual-seeed.dtbo \
"

FILES:${PN}:jetson-orin-nx-seeed-j4012 += " \
	/boot/tegra234-p3768-0000+p3767-0000-nv-super.dtb \
        /boot/tegra234-p3768-0000+p3767-0000-nv.dtb \
        /boot/devicetree/tegra234-p3767-camera-p3768-imx219-dual-seeed.dtbo \
"
