do_install[depends] += "linux-noble-nvidia-tegra:do_deploy"

do_install() {
    #install -d ${D}/boot/devicetree
    #if [ -n "${UBOOT_EXTLINUX_FDT}" ]; then
    #    cp -r ${DEPLOY_DIR_IMAGE}/devicetree/* ${D}/boot/devicetree/
    #fi

    touch ${DEPLOY_DIR_IMAGE}/extra_uEnv.txt
}

do_compile() {
    if [ -n "${UBOOT_EXTLINUX_FDT}" ]; then
        cp -L ${DEPLOY_DIR_IMAGE}/devicetree/${DTBFILE} ${B}/
    fi
}

do_install[nostamp] = "1"
ALLOW_EMPTY:${PN} = "1"

#FILES:${PN} += "/boot/"
