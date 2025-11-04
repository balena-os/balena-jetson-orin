do_install[depends] += "linux-jammy-nvidia-tegra:do_deploy"

do_install() {
    install -d ${D}/boot/
    if [ -n "${UBOOT_EXTLINUX_FDT}" ]; then
        install -m 0644 ${B}/${DTBFILE}* ${D}/boot/
    fi

    touch ${DEPLOY_DIR_IMAGE}/extra_uEnv.txt
}

do_compile() {
    if [ -n "${UBOOT_EXTLINUX_FDT}" ]; then
        cp -L ${DEPLOY_DIR_IMAGE}/${DTBFILE} ${B}/
    fi
}

do_install[nostamp] = "1"
