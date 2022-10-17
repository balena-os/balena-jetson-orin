FILESEXTRAPATHS:append := ":${THISDIR}/linux-tegra"

DESCRIPTION = "Package for deploying custom dtbs to the Jetson Orin AGX rootfs"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

do_install[depends] += " linux-tegra:do_deploy "

S = "${WORKDIR}"
DTBNAME = "${@os.path.basename(d.getVar('KERNEL_DEVICETREE', True).split()[0])}"

do_install() {
	install -d ${D}/boot/
	install -m 0644 "${DEPLOY_DIR_IMAGE}/${DTBNAME}" "${D}/boot/${DTBNAME}"
        install -m 0644 "${DEPLOY_DIR_IMAGE}/tegra234-p3701-0004-p3737-0000.dtb" "${D}/boot/tegra234-p3701-0004-p3737-0000.dtb"
	install -m 0644 "${DEPLOY_DIR_IMAGE}/tegra234-p3737-a03-overlay.dtbo" "${D}/boot/tegra234-p3737-a03-overlay.dtbo"
	install -m 0644 "${DEPLOY_DIR_IMAGE}/tegra234-p3737-a04-overlay.dtbo" "${D}/boot/tegra234-p3737-a04-overlay.dtbo"
	install -m 0644 "${DEPLOY_DIR_IMAGE}/tegra234-p3737-audio-codec-rt5658-40pin.dtbo" "${D}/boot/tegra234-p3737-audio-codec-rt5658-40pin.dtbo"
	install -m 0644 "${DEPLOY_DIR_IMAGE}/tegra234-p3737-camera-dual-imx274-overlay.dtbo" "${D}/boot/tegra234-p3737-camera-dual-imx274-overlay.dtbo"
	install -m 0644 "${DEPLOY_DIR_IMAGE}/tegra234-p3737-camera-e3331-overlay.dtbo" "${D}/boot/tegra234-p3737-camera-e3331-overlay.dtbo"
	install -m 0644 "${DEPLOY_DIR_IMAGE}/tegra234-p3737-camera-e3333-overlay.dtbo" "${D}/boot/tegra234-p3737-camera-e3333-overlay.dtbo"
	install -m 0644 "${DEPLOY_DIR_IMAGE}/tegra234-p3737-camera-imx185-overlay.dtbo" "${D}/boot/tegra234-p3737-camera-imx185-overlay.dtbo"
	install -m 0644 "${DEPLOY_DIR_IMAGE}/tegra234-p3737-camera-imx390-overlay.dtbo" "${D}/boot/tegra234-p3737-camera-imx390-overlay.dtbo"
	install -m 0644 "${DEPLOY_DIR_IMAGE}/tegra234-p3737-overlay-pcie.dtbo" "${D}/boot/tegra234-p3737-overlay-pcie.dtbo"
}

FILES:${PN} += " \
	/boot/tegra234-p3701-0000-p3737-0000.dtb \
	/boot/tegra234-p3701-0004-p3737-0000.dtb \
	/boot/tegra234-p3737-a03-overlay.dtbo \
	/boot/tegra234-p3737-a04-overlay.dtbo \
	/boot/tegra234-p3737-audio-codec-rt5658-40pin.dtbo \
	/boot/tegra234-p3737-camera-dual-imx274-overlay.dtbo \
	/boot/tegra234-p3737-camera-e3331-overlay.dtbo \
	/boot/tegra234-p3737-camera-e3333-overlay.dtbo \
	/boot/tegra234-p3737-camera-imx185-overlay.dtbo \
	/boot/tegra234-p3737-camera-imx390-overlay.dtbo \
	/boot/tegra234-p3737-overlay-pcie.dtbo \
"
