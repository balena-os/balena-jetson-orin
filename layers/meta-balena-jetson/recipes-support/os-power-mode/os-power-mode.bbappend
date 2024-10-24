FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " \
    file://os-power-mode \
    file://os-power-mode-jetson.conf \
    file://etc-nvpmodel-config.mount \
    "

do_install:append() {
	install -d -m 0755 ${D}${libdir}/systemd/system/os-power-mode.service.d
	install -m 0644 ${WORKDIR}/os-power-mode-jetson.conf \
		${D}${libdir}/systemd/system/os-power-mode.service.d

	install -m 0644 ${WORKDIR}/etc-nvpmodel-config.mount ${D}${systemd_unitdir}/system/etc-nvpmodel\\x2dconfig.mount

	install -d -m 0755 ${D}/etc/nvpmodel-config
}

FILES:${PN} += " /usr/lib/systemd/system/os-power-mode.service.d/os-power-mode-jetson.conf "
