DEPENDS += "acl"

do_install:append() {
    # It appears that 10s is not enough for high loads after hup
    sed -i 's/10s/60s/g' ${D}/${sysconfdir}/systemd/system.conf.d/watchdog.conf
}
