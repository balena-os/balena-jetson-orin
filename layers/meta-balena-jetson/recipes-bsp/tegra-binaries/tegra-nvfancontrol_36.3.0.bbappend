do_install:append() {
    sed -i 's/Requires=nvstartup.service//g' ${D}${systemd_system_unitdir}/nvfancontrol.service
    sed -i 's/After=nvstartup.service//g' ${D}${systemd_system_unitdir}/nvfancontrol.service
}
