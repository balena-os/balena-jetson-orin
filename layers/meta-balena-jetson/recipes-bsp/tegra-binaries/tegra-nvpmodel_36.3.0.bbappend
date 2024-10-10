FILESEXTRAPATHS:prepend := "${THISDIR}/tegra-nvpmodel:"

SRC_URI += " \
    file://nvpmodel-os-deps.conf \
"

do_install:append() {
    install -d -m 0755 ${D}${libdir}/systemd/system/nvpmodel.service.d
    install -m 0644 ${WORKDIR}/nvpmodel-os-deps.conf \
                ${D}${libdir}/systemd/system/nvpmodel.service.d/

    sed -i 's|/etc/nvpmodel.conf|/etc/nvpmodel-config/nvpmodel.conf|g' ${D}${systemd_system_unitdir}/nvpmodel.service
}

FILES:${PN}:append = " /usr/lib/systemd/system/nvpmodel.service.d/nvpmodel-os-deps.conf "
