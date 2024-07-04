inherit kernel-resin deploy

FILESEXTRAPATHS:append := ":${THISDIR}/${PN}"

SCMVERSION="n"

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

BALENA_CONFIGS[xudc] = " \
    CONFIG_USB_TEGRA_XUDC=m \
"

BALENA_CONFIGS:append:jetson-agx-orin-devkit = " rtc"
BALENA_CONFIGS[rtc] = " \
    CONFIG_RTC_HCTOSYS_DEVICE="rtc0" \
    CONFIG_RTC_SYSTOHC_DEVICE="rtc0" \
"

BALENA_CONFIGS:append:jetson-orin-nano-devkit-nvme = " binder"
BALENA_CONFIGS[binder] = " \
    CONFIG_ANDROID=y \
    CONFIG_ASHMEM=y \
    CONFIG_ANDROID_BINDER_IPC=y \
    CONFIG_ANDROID_BINDER_DEVICES=\"binder,hwbinder,vndbinder\" \
    CONFIG_ANDROID_BINDER_IPC_SELFTEST=y \
"

BALENA_CONFIGS:append:jetson-orin-nano-4g-devkit = " binder"
BALENA_CONFIGS[binder] = " \
    CONFIG_ANDROID=y \
    CONFIG_ASHMEM=y \
    CONFIG_ANDROID_BINDER_IPC=y \
    CONFIG_ANDROID_BINDER_DEVICES=\"binder,hwbinder,vndbinder\" \
    CONFIG_ANDROID_BINDER_IPC_SELFTEST=y \
"

BALENA_CONFIGS:append = " mtd nvme"
BALENA_CONFIGS[mtd] = " \
    CONFIG_MTD_BLOCK=m \
"

BALENA_CONFIGS:append = " iwlwifi"
BALENA_CONFIGS[iwlwifi] = " \
    CONFIG_IWLWIFI=m \
    CONFIG_IWLDVM=m \
    CONFIG_IWLMVM=m \
"

# Needed starting with Jetpack 6
# so the initramfs can mount the
# NVME partitions
BALENA_CONFIGS[nvme] = " \
    CONFIG_NVME_CORE=m \
    CONFIG_BLK_DEV_NVME=m \
    CONFIG_NVME_FABRICS=m \
    CONFIG_NVME_TCP=m \
    CONFIG_NVME_TARGET=m \
    CONFIG_NVME_TARGET_TCP=m \
"

# These drivers needs to be built-in, otherwise
# the nvme cannot be detected in the initramfs,
# when trying to boot from it.
BALENA_CONFIGS[pcie] = " \
    CONFIG_PCIE_TEGRA194=m \
    CONFIG_PCIE_TEGRA194_HOST=m \
    CONFIG_PCIE_TEGRA194_EP=m \
    CONFIG_PHY_TEGRA194_P2U=m \
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
      APPEND \${cbootargs} ${kernelRootspec} sdhci_tegra.en_boot_part_access=1 rootwait  video=efifb:off
EOF

}

do_deploy[postfuncs] += "generate_extlinux_conf"
do_install[depends] += "${@['', '${INITRAMFS_IMAGE}:do_image_complete'][(d.getVar('INITRAMFS_IMAGE', True) or '') != '' and (d.getVar('TEGRA_INITRAMFS_INITRD', True) or '') == "1"]}"
