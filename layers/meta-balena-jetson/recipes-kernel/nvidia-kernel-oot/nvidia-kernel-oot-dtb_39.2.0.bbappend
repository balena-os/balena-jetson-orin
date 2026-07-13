FILESEXTRAPATHS:append := ":${THISDIR}/nvidia-kernel-oot"

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
        ${UNPACKDIR}/forecr-dsb-ornx-lan/tegra234-p3767-camera-dsboard-ornx-imx219.dtbo \
        ${UNPACKDIR}/forecr-dsb-ornx-lan/tegra234-p3767-camera-dsboard-ornx-imx477.dtbo \
        ${D}/boot/devicetree/

        install -m 0644 "${UNPACKDIR}/forecr-dsb-ornx-lan/tegra234-p3768-0000+p3767-0003-nv.dtb" "${D}/boot/devicetree/tegra234-p3768-0000+p3767-0003-nv.dtb"
        install -m 0644 "${UNPACKDIR}/forecr-dsb-ornx-lan/tegra234-p3768-0000+p3767-0003-nv-super.dtb" "${D}/boot/devicetree/tegra234-p3768-0000+p3767-0003-nv-super.dtb"
        install -m 0644 "${UNPACKDIR}/forecr-dsb-ornx-lan/tegra234-p3768-0000+p3767-0003.dtb" "${D}/boot/devicetree/tegra234-p3768-0000+p3767-0003.dtb"
        install -m 0644 "${UNPACKDIR}/forecr-dsb-ornx-lan/tegra234-p3768-0000+p3767-0004-nv.dtb" "${D}/boot/devicetree/tegra234-p3768-0000+p3767-0004-nv.dtb"
}

# Deploying is not necessary for Balena images, but meta-tegra does it
# so let's do it as well just for consistency.
do_deploy:append:forecr-dsb-ornx-orin-nano-8gb() {
    install -m 0644 \
        ${UNPACKDIR}/forecr-dsb-ornx-lan/tegra234-p3767-camera-dsboard-ornx-imx219.dtbo \
        ${UNPACKDIR}/forecr-dsb-ornx-lan/tegra234-p3767-camera-dsboard-ornx-imx477.dtbo \
        ${UNPACKDIR}/forecr-dsb-ornx-lan/tegra234-p3768-0000+p3767-0003-nv.dtb \
        ${UNPACKDIR}/forecr-dsb-ornx-lan/tegra234-p3768-0000+p3767-0003-nv-super.dtb \
        ${UNPACKDIR}/forecr-dsb-ornx-lan/tegra234-p3768-0000+p3767-0003.dtb \
        ${UNPACKDIR}/forecr-dsb-ornx-lan/tegra234-p3768-0000+p3767-0004-nv.dtb \
    ${DEPLOYDIR}/devicetree/
}

