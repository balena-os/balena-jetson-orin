do_install:append() {
    install -d ${D}${nonarch_base_libdir}/udev/rules.d/
    mv ${D}${sysconfdir}/udev/rules.d/* ${D}${nonarch_base_libdir}/udev/rules.d/
    rm -rf ${D}${sysconfdir}/udev/
}

FILES:${PN}-udev = " ${nonarch_base_libdir}/udev/rules.d ${sysconfdir}/modprobe.d"

do_install:append:tegra264() {
    # Ubuntu comes with this file, the Yocto build doesn't, so let's
    # include it too as nvidia.ko is used for the t26x, not nouveau nor nvgpu
    install -d ${D}${sysconfdir}/modprobe.d/
    echo "blacklist nouveau" > ${D}${sysconfdir}/modprobe.d/denylist-nouveau.conf
}

