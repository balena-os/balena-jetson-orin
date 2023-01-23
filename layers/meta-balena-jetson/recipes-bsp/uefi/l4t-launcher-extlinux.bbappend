do_install:tegra234() {
    install -d ${D}/boot/extlinux
    cp ${DEPLOY_DIR_IMAGE}/extlinux/extlinux.conf ${B}/
    install -m 0644 ${B}/extlinux.conf ${D}/boot/extlinux/
    install -m 0644 ${DEPLOY_DIR_IMAGE}/${KERNEL_IMAGETYPE}${KERNEL_INITRAMFS}-${MACHINE}.bin ${D}/boot/${KERNEL_IMAGETYPE}
    touch ${DEPLOY_DIR_IMAGE}/extra_uEnv.txt
}

do_install:tegra194() {
    install -d ${D}/boot/extlinux
    cp ${DEPLOY_DIR_IMAGE}/extlinux/extlinux.conf ${B}/
    install -m 0644 ${B}/extlinux.conf ${D}/boot/extlinux/
    install -m 0644 ${DEPLOY_DIR_IMAGE}/${KERNEL_IMAGETYPE}${KERNEL_INITRAMFS}-${MACHINE}.bin ${D}/boot/${KERNEL_IMAGETYPE}
    touch ${DEPLOY_DIR_IMAGE}/extra_uEnv.txt
}

do_install:append:forecr-dsb-nx2-xavier-nx-emmc() {
    echo "custom_fdt_file=tegra194-p3668-dsboard-nx2-0000.dtb" >> ${DEPLOY_DIR_IMAGE}/extra_uEnv.txt
}


do_compile() {
    if [ -n "${UBOOT_EXTLINUX_FDT}" ]; then
        cp -L ${DEPLOY_DIR_IMAGE}/${DTBFILE} ${B}/
    fi
}

FILES:${PN} = "/boot/extlinux/extlinux.conf /boot/Image"
