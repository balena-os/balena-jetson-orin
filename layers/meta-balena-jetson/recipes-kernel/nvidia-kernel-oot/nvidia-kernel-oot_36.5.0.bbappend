FILESEXTRAPATHS:append := ":${THISDIR}/${PN}"

SRC_URI += "  \
    file://enable_80211d.patch \
"

SRC_URI:append:forecr-dsb-ornx-orin-nano-8gb = " \
    file://forecr-dsb-ornx-lan/tegra234-p3768-0000+p3767-0003-nv.dtb \
    file://forecr-dsb-ornx-lan/tegra234-p3768-0000+p3767-0004-nv.dtb \
    file://forecr-dsb-ornx-lan/tegra234-p3768-0000+p3767-0003-nv-super.dtb \
    file://forecr-dsb-ornx-lan/tegra234-p3767-camera-dsboard-ornx-imx219.dtbo \
    file://forecr-dsb-ornx-lan/tegra234-p3767-camera-dsboard-ornx-imx477.dtbo \
    file://forecr-dsb-ornx-lan/tegra234-p3768-0000+p3767-0003.dtb \
"

# Note tegra-...-dynamic.dtbo overwrites a file with the same name from Nvidia,
# but the camera overlays are new files
do_install:append:forecr-dsb-ornx-orin-nano-8gb() {
    install -m 0644 \
        ${WORKDIR}/forecr-dsb-ornx-lan/tegra234-p3767-camera-dsboard-ornx-imx219.dtbo \
        ${WORKDIR}/forecr-dsb-ornx-lan/tegra234-p3767-camera-dsboard-ornx-imx477.dtbo \
        ${D}/boot/devicetree/

        install -m 0644 "${WORKDIR}/forecr-dsb-ornx-lan/tegra234-p3768-0000+p3767-0003-nv.dtb" "${D}/boot/devicetree/tegra234-p3768-0000+p3767-0003-nv.dtb"
        install -m 0644 "${WORKDIR}/forecr-dsb-ornx-lan/tegra234-p3768-0000+p3767-0003-nv-super.dtb" "${D}/boot/devicetree/tegra234-p3768-0000+p3767-0003-nv-super.dtb"
        install -m 0644 "${WORKDIR}/forecr-dsb-ornx-lan/tegra234-p3768-0000+p3767-0003.dtb" "${D}/boot/devicetree/tegra234-p3768-0000+p3767-0003.dtb"
        install -m 0644 "${WORKDIR}/forecr-dsb-ornx-lan/tegra234-p3768-0000+p3767-0004-nv.dtb" "${D}/boot/devicetree/tegra234-p3768-0000+p3767-0004-nv.dtb"
}

# Deploying is not necessary for Balena images, but meta-tegra does it
# so let's do it as well just for consistency.
do_deploy:append:forecr-dsb-ornx-orin-nano-8gb() {
    install -m 0644 \
        ${WORKDIR}/forecr-dsb-ornx-lan/tegra234-p3767-camera-dsboard-ornx-imx219.dtbo \
        ${WORKDIR}/forecr-dsb-ornx-lan/tegra234-p3767-camera-dsboard-ornx-imx477.dtbo \
        ${WORKDIR}/forecr-dsb-ornx-lan/tegra234-p3768-0000+p3767-0003-nv.dtb \
        ${WORKDIR}/forecr-dsb-ornx-lan/tegra234-p3768-0000+p3767-0003-nv-super.dtb \
        ${WORKDIR}/forecr-dsb-ornx-lan/tegra234-p3768-0000+p3767-0003.dtb \
        ${WORKDIR}/forecr-dsb-ornx-lan/tegra234-p3768-0000+p3767-0004-nv.dtb \
    ${DEPLOYDIR}/devicetree/
}

TEGRA_OOT_WIFI_DRIVERS:remove="${KERNEL_MODULE_PACKAGE_PREFIX}kernel-module-rtl8852ce"

TEGRA_OOT_REPLACEMENT_DRIVERS += " lan743x "

