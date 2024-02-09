FILESEXTRAPATHS:append := "${THISDIR}/${PN}"

SRC_URI:jetson-xavier = "file://resin-init-flasher-board-xavier-agx-emmc"

do_install:jetson-xavier() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/resin-init-flasher-board-xavier-agx-emmc ${D}${bindir}/resin-init-flasher-board
}
