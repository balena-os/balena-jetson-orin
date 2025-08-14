FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " \
    file://forecr-dsb-ornx-lan/70-network.rules \
"

# Some extra rules from the vendor-provided BSP
do_install:append:forecr-dsb-ornx-lan() {
	# Set names for on-board network interfaces to match the board documentation
	install -D -m 0644 ${WORKDIR}/forecr-dsb-ornx-lan/70-network.rules ${D}/${base_libdir}/udev/rules.d/70-network.rules
}
