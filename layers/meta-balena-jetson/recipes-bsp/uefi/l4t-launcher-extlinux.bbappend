do_install() {
    install -d ${D}/boot/extlinux
    cp ${DEPLOY_DIR_IMAGE}/extlinux/extlinux.conf ${B}/
    install -m 0644 ${B}/extlinux.conf ${D}/boot/extlinux/
    touch ${DEPLOY_DIR_IMAGE}/extra_uEnv.txt
}

do_compile() {
    if [ -n "${UBOOT_EXTLINUX_FDT}" ]; then
        cp -L ${DEPLOY_DIR_IMAGE}/${DTBFILE} ${B}/
    fi
}

FILES:${PN} = "/boot/extlinux/extlinux.conf"
