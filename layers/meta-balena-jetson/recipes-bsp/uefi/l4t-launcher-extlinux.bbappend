do_install[depends] += "linux-noble-nvidia-tegra:do_deploy"

do_install() {
    touch ${DEPLOY_DIR_IMAGE}/extra_uEnv.txt
}

do_compile() {
    if [ -n "${UBOOT_EXTLINUX_FDT}" ]; then
        cp -L ${DEPLOY_DIR_IMAGE}/devicetree/${DTBFILE} ${B}/
    fi
}

do_install[nostamp] = "1"
ALLOW_EMPTY:${PN} = "1"
