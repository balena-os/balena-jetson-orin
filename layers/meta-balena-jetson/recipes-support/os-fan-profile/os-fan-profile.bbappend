FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " \
    file://os-fan-profile \
    file://os-fan-profile-jetson.conf \
    file://etc-nvfancontrol-config.mount \
    "

do_install:append() {
	install -d -m 0755 ${D}${libdir}/systemd/system/os-fan-profile.service.d
	install -m 0644 ${WORKDIR}/os-fan-profile-jetson.conf \
		${D}${libdir}/systemd/system/os-fan-profile.service.d

	install -m 0644 ${WORKDIR}/etc-nvfancontrol-config.mount ${D}${systemd_unitdir}/system/etc-nvfancontrol\\x2dconfig.mount
	install -d -m 0755 ${D}/etc/nvfancontrol-config
}

FILES:${PN} += " /usr/lib/systemd/system/os-fan-profile.service.d/os-fan-profile-jetson.conf "
