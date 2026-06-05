FILESEXTRAPATHS:prepend := "${THISDIR}/tegra-nvfancontrol:"

SRC_URI:append = " file://nvfancontrol-deps.conf "

do_install:append() {
    # Requires and After cannot be wiped from the nvfancontrol-deps drop in
    sed -i 's/Requires=nvstartup.service//g' ${D}${systemd_system_unitdir}/nvfancontrol.service
    sed -i 's/After=nvstartup.service//g' ${D}${systemd_system_unitdir}/nvfancontrol.service

    # Use bind mounted path updated by os-fan-profile
    sed -i 's|ExecStart=/usr/sbin/nvfancontrol|& -f /etc/nvfancontrol-config/nvfancontrol.conf|g' ${D}${systemd_system_unitdir}/nvfancontrol.service

    install -d -m 0755 ${D}${libdir}/systemd/system/nvfancontrol.service.d
    install -m 0644 ${WORKDIR}/nvfancontrol-deps.conf \
                ${D}${libdir}/systemd/system/nvfancontrol.service.d
}

FILES:${PN} += " /usr/lib/systemd/system/nvfancontrol.service.d/nvfancontrol-deps.conf "
