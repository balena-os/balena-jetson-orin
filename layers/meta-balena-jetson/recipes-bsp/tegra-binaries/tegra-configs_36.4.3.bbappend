do_install:append() {
    install -d ${D}${nonarch_base_libdir}/udev/rules.d/
    mv ${D}${sysconfdir}/udev/rules.d/* ${D}${nonarch_base_libdir}/udev/rules.d/
    rm -rf ${D}${sysconfdir}/udev/
}

FILES:${PN}-udev = " ${nonarch_base_libdir}/udev/rules.d ${sysconfdir}/modprobe.d"
