FILESEXTRAPATHS:append := ":${THISDIR}/${PN}"

SRC_URI += "  \
    file://enable_80211d.patch \
"

SRC_URI:append:forecr-dsb-ornx = " \
    file://forecr-dsb-ornx/tegra234-p3768-0000+p3767-0000-dynamic.dtbo \
    file://forecr-dsb-ornx/tegra234-p3767-camera-dsboard-ornx-imx219.dtbo \
    file://forecr-dsb-ornx/tegra234-p3767-camera-dsboard-ornx-imx477.dtbo \
"

# Note tegra-...-dynamic.dtbo overwrites a file with the same name from Nvidia,
# but the camera overlays are new files
do_install:append:forecr-dsb-ornx() {
    install -m 0644 \
        ${WORKDIR}/forecr-dsb-ornx/tegra234-p3768-0000+p3767-0000-dynamic.dtbo \
        ${WORKDIR}/forecr-dsb-ornx/tegra234-p3767-camera-dsboard-ornx-imx219.dtbo \
        ${WORKDIR}/forecr-dsb-ornx/tegra234-p3767-camera-dsboard-ornx-imx477.dtbo \
        ${D}/boot/devicetree/
}

# Deploying is not necessary for Balena images, but meta-tegra does it
# so let's do it as well just for consistency.
do_deploy:append:forecr-dsb-ornx() {
    install -m 0644 \
        ${WORKDIR}/forecr-dsb-ornx/tegra234-p3768-0000+p3767-0000-dynamic.dtbo \
        ${WORKDIR}/forecr-dsb-ornx/tegra234-p3767-camera-dsboard-ornx-imx219.dtbo \
        ${WORKDIR}/forecr-dsb-ornx/tegra234-p3767-camera-dsboard-ornx-imx477.dtbo \
        ${DEPLOYDIR}/devicetree/
}
