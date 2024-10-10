do_install:append() {
    sed -i 's/Requires=nvstartup.service//g' ${D}${systemd_system_unitdir}/nvfancontrol.service
    sed -i 's/After=nvstartup.service//g' ${D}${systemd_system_unitdir}/nvfancontrol.service

    # Use bind mounted path updated by os-fan-profile
    sed -i 's|ExecStart=/usr/sbin/nvfancontrol|& -f /etc/nvfancontrol-config/nvfancontrol.conf|g' ${D}${systemd_system_unitdir}/nvfancontrol.service
}
