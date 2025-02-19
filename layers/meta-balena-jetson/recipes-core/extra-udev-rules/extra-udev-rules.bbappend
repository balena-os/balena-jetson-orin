FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " \
    file://forecr-dsb-ornx-lan/70-network.rules \
"

SRC_URI:append:syslogic-rsa4 = " \
    file://syslogic-rsa4/70-persistent-net.rules \
"

# Some extra rules from the vendor-provided BSP
do_install:append:forecr-dsb-ornx-lan() {
	# Set names for on-board network interfaces to match the board documentation
	install -D -m 0644 ${WORKDIR}/forecr-dsb-ornx-lan/70-network.rules ${D}/lib/udev/rules.d/
}

do_install:append:syslogic-rsa4() {
	# Set names for on-board network interfaces matching the vendor BSP
	install -D -m 0644 ${WORKDIR}/syslogic-rsa4/70-persistent-net.rules ${D}/lib/udev/rules.d/
}
