inherit kernel-resin deploy

FILESEXTRAPATHS:append := ":${THISDIR}/${PN}"

SCMVERSION="n"

# Switch nvmap to built-in to fix the kernel headers
SRC_URI:append = " file://0001-fix-kernel-headers-test.patch \
		file://0001-defconfig-Fix-build-failure.patch \
"
SRC_URI:append:forecr-dsb-nx2-xavier-nx-emmc = " file://0001-Port-Forecr-DSBOARD-NX2-patches.patch "

BALENA_CONFIGS:remove = " mdraid"

BALENA_CONFIGS:append = " debug_kmemleak "

BALENA_CONFIGS[debug_kmemleak] = " \
    CONFIG_HAVE_DEBUG_KMEMLEAK=n \
    CONFIG_DEBUG_KMEMLEAK=n \
    CONFIG_HAVE_DEBUG_KMEMLEAK=n \
    CONFIG_DEBUG_KMEMLEAK_SCAN_ON=n \
    CONFIG_FUNCTION_TRACER=n \
    CONFIG_HAVE_FUNCTION_TRACER=n \
    CONFIG_PSTORE=n \
"

BALENA_CONFIGS:append = " compat"
BALENA_CONFIGS[compat] = " \
                CONFIG_COMPAT=y \
"

BALENA_CONFIGS:append = " cdc-wdm"
BALENA_CONFIGS[cdc-wdm] = " \
                CONFIG_USB_WDM=m \
"

BALENA_CONFIGS:append = " sierra-net"
BALENA_CONFIGS[sierra-net] = " \
                CONFIG_USB_SIERRA_NET=m \
		CONFIG_PROC_KCORE=y \
"

BALENA_CONFIGS_DEPS[sierra-net] = " \
                CONFIG_USB_USBNET=m \
"

BALENA_CONFIGS:append = " cdc-ncm"
BALENA_CONFIGS[cdc-ncm] = " \
                CONFIG_USB_NET_CDC_NCM=m \
"

BALENA_CONFIGS_DEPS[cdc-ncm] = " \
                CONFIG_USB_USBNET=m \
"

BALENA_CONFIGS:append = " mii"

BALENA_CONFIGS:append = " rtl8822ce "
BALENA_CONFIGS[rtl8822ce] = " \
		CONFIG_RTL8822CE=m \
		CONFIG_RTK_BTUSB=m \
"

BALENA_CONFIGS:append = " nfsfs xudc"
BALENA_CONFIGS[nfsfs] = " \
    CONFIG_NFS_FS=m \
    CONFIG_NFS_V2=m \
    CONFIG_NFS_V3=m \
    CONFIG_NFS_V4=m \
    CONFIG_NFSD_V3=y \
    CONFIG_NFSD_V4=y \
"

BALENA_CONFIGS:append:forecr-dsb-nx2-xavier-nx-emmc = " pcf8574 lan743x xr17v35x usbserial"
BALENA_CONFIGS[pcf8574] = " \
    CONFIG_GPIO_PCF857X=m \
"

BALENA_CONFIGS[lan743x] = " \
    CONFIG_LAN743X=m \
"

BALENA_CONFIGS[xr17v35x] = " \
    CONFIG_SERIAL_8250_XR17V35X=m \
"

BALENA_CONFIGS[usbserial] = " \
    CONFIG_USB_SERIAL_WWAN=m \
"

BALENA_CONFIGS[xudc] = " \
    CONFIG_USB_TEGRA_XUDC=m \
"

L4TVER=" l4tver=${L4T_VERSION}"

KERNEL_ARGS = " firmware_class.path=/etc/firmware fbcon=map:0 "
KERNEL_ARGS += "${@bb.utils.contains('DISTRO_FEATURES','osdev-image',' mminit_loglevel=4 console=tty0 console=ttyTCU0,115200 ',' console=null quiet splash vt.global_cursor_default=0 consoleblank=0',d)} l4tver=${L4T_VERSION} "

generate_extlinux_conf() {
    mkdir -p ${DEPLOY_DIR_IMAGE}/extlinux || true
    kernelRootspec="${KERNEL_ARGS}" ; cat >${DEPLOY_DIR_IMAGE}/extlinux/extlinux.conf << EOF
DEFAULT primary
TIMEOUT 10
MENU TITLE Boot Options
LABEL primary
      MENU LABEL primary ${KERNEL_IMAGETYPE}
      FDT default
      LINUX /boot/${KERNEL_IMAGETYPE}
      APPEND \${cbootargs} ${kernelRootspec} sdhci_tegra.en_boot_part_access=1 rootwait
EOF

}

do_deploy[nostamp] = "1"
do_deploy[postfuncs] += "generate_extlinux_conf"
do_install[depends] += "${@['', '${INITRAMFS_IMAGE}:do_image_complete'][(d.getVar('INITRAMFS_IMAGE', True) or '') != '' and (d.getVar('TEGRA_INITRAMFS_INITRD', True) or '') == "1"]}"

# These are needed by tegraflash during signing
OVERLAY_DTB_FILE:append:jetson-agx-orin-devkit = " tegra234-p3737-overlay-pcie.dtbo,tegra234-p3737-audio-codec-rt5658-40pin.dtbo,tegra234-p3737-a03-overlay.dtbo,tegra234-p3737-a04-overlay.dtbo,tegra234-p3737-camera-dual-imx274-overlay.dtbo,AcpiBoot.dtbo,L4TConfiguration.dtbo,L4TRootfsInfo.dtbo,L4TRootfsABInfo.dtbo,L4TRootfsBrokenInfo.dtbo"

