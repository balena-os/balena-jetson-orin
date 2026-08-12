FILESEXTRAPATHS:append := ":${THISDIR}/linux-noble-nvidia-tegra"

inherit kernel-resin deploy

FILESEXTRAPATHS:append := ":${THISDIR}/${PN}"

SRC_URI:append = " \
    file://0001-Revert-UBUNTU-SAUCE-Support-but-do-not-require-compr.patch \
"

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

BALENA_CONFIGS:append = " rfcomm "
BALENA_CONFIGS[rfcomm] = " \
    CONFIG_BT_RFCOMM=m \
    CONFIG_BT_RFCOMM_TTY=y \
"

BALENA_CONFIGS:append = " hid-logitech "
BALENA_CONFIGS[hid-logitech] = " \
    CONFIG_HID_LOGITECH=m \
    CONFIG_HID_LOGITECH_DJ=m \
    CONFIG_HID_LOGITECH_HIDPP=m \
"

BALENA_CONFIGS:append = " joystick "
BALENA_CONFIGS[joystick] = " \
    CONFIG_JOYSTICK_XPAD=m \
    CONFIG_INPUT_JOYDEV=m \
    CONFIG_INPUT_JOYSTICK=y \
"

BALENA_CONFIGS:append:jetson-orin-nx-seeed-j4012 = " lan743x "
BALENA_CONFIGS:append:forecr-dsb-ornx-orin-nano-8gb = " lan743x "
BALENA_CONFIGS[lan743x] = " \
    CONFIG_LAN743X=m \
"

BALENA_CONFIGS:append:jetson-orin-nano-seeed-j3010 = " uvc_gadget "
BALENA_CONFIGS[uvc_gadget] = " \
    CONFIG_USB_CONFIGFS=m \
    CONFIG_USB_LIBCOMPOSITE=m \
    CONFIG_USB_CONFIGFS_F_UVC=y \
    CONFIG_USB_F_UVC=m \
"

# Switch to modules so they can be compressed
BALENA_CONFIGS:append = " kernel_misc_size_reduction "
BALENA_CONFIGS[kernel_misc_size_reduction] = " \
    CONFIG_E1000=m \
    CONFIG_E1000E=m \
    CONFIG_IGB=m \
    CONFIG_ICE=m \
    CONFIG_MLX5_CORE_EN=m \
    CONFIG_AMD_XGBE=m \
    CONFIG_BNX2X_SRIOV=m \
    CONFIG_FEC=m \
    CONFIG_NET_VENDOR_CAVIUM=n \
    CONFIG_NET_VENDOR_CHELSIO=n \
    CONFIG_NET_VENDOR_CISCO=n \
    CONFIG_NET_VENDOR_HISILICON=n \
    CONFIG_NET_VENDOR_HUAWEI=n \
    CONFIG_NET_VENDOR_MELLANOX=n \
    CONFIG_DRM_EXYNOS5433_DECON=n \
    CONFIG_ROCKCHIP_VOP=n \
    CONFIG_DRM_RCAR_VSP=n \
    CONFIG_DRM_MSM=n \
    CONFIG_EXT2_FS=m \
    CONFIG_EXT3_FS=m \
"

BALENA_CONFIGS:append = " kernel_arch_size_reduction "
BALENA_CONFIGS[kernel_arch_size_reduction] = " \
    CONFIG_ARCH_ACTIONS=n \
    CONFIG_ARCH_SUNXI=n \
    CONFIG_ARCH_ALPINE=n \
    CONFIG_ARCH_APPLE=n \
    CONFIG_ARCH_BCM=n \
    CONFIG_ARCH_BCM2835=n \
    CONFIG_ARCH_BCM_IPROC=n \
    CONFIG_ARCH_BCMBCA=n \
    CONFIG_ARCH_BRCMSTB=n \
    CONFIG_ARCH_BERLIN=n \
    CONFIG_ARCH_EXYNOS=n \
    CONFIG_ARCH_SPARX5=n \
    CONFIG_ARCH_K3=n \
    CONFIG_ARCH_LG1K=n \
    CONFIG_ARCH_HISI=n \
    CONFIG_ARCH_KEEMBAY=n \
    CONFIG_ARCH_MEDIATEK=n \
    CONFIG_ARCH_MESON=n \
    CONFIG_ARCH_MVEBU=n \
    CONFIG_ARCH_NXP=n \
    CONFIG_ARCH_LAYERSCAPE=n \
    CONFIG_ARCH_MXC=n \
    CONFIG_ARCH_S32=n \
    CONFIG_ARCH_MA35=n \
    CONFIG_ARCH_NPCM=n \
    CONFIG_ARCH_QCOM=n \
    CONFIG_ARCH_REALTEK=n \
    CONFIG_ARCH_RENESAS=n \
    CONFIG_ARCH_ROCKCHIP=n \
    CONFIG_ARCH_SEATTLE=n \
    CONFIG_ARCH_INTEL_SOCFPGA=n \
    CONFIG_ARCH_STM32=n \
    CONFIG_ARCH_SYNQUACER=n \
    CONFIG_ARCH_TESLA_FSD=n \
    CONFIG_ARCH_SPRD=n \
    CONFIG_ARCH_THUNDER=n \
    CONFIG_ARCH_THUNDER2=n \
    CONFIG_ARCH_UNIPHIER=n \
    CONFIG_ARCH_VEXPRESS=n \
    CONFIG_ARCH_VISCONTI=n \
    CONFIG_ARCH_XGENE=n \
    CONFIG_ARCH_ZYNQMP=n \
"

# Orins use nvgpu driver
BALENA_CONFIGS:append = " kernel_nouveau_size_reduction "
BALENA_CONFIGS[kernel_nouveau_size_reduction] = " \
    CONFIG_DRM_NOUVEAU=n \
    CONFIG_NOUVEAU_PLATFORM_DRIVER=n \
    CONFIG_DRM_NOUVEAU_BACKLIGHT=n \
"

L4TVER=" l4tver=${L4T_VERSION}"

KERNEL_ARGS += "${@bb.utils.contains('DISTRO_FEATURES','osdev-image',' mminit_loglevel=4 console=tty0 console=ttyTCU0,115200 ',' console=null quiet splash vt.global_cursor_default=0 consoleblank=0',d)} l4tver=${L4T_VERSION} rootdelay=1 roottimeout=60 "

# Let's not disable this by default
# in our integration, although upstream does.
KERNEL_ARGS:remove="nospectre_bhb"
KERNEL_ARGS:remove="firmware_class.path=/etc/firmware"

DEFAULT_SEEED_OVERLAYS=",/boot/devicetree/tegra234-dcb-p3767-0000-hdmi.dtbo,/boot/devicetree/tegra234-p3767-camera-p3768-imx219-dual-seeed.dtbo"

DTB_OVERLAYS:jetson-agx-orin-devkit-64gb="/boot/devicetree/tegra234-p3737-0000+p3701-0000-dynamic.dtbo"
DTB_OVERLAYS:jetson-agx-orin-devkit="/boot/devicetree/tegra234-p3737-0000+p3701-0000-dynamic.dtbo"
DTB_OVERLAYS="/boot/devicetree/tegra234-p3768-0000+p3767-0000-dynamic.dtbo"
DTB_OVERLAYS:append:jetson-orin-nano-seeed-j3010="${DEFAULT_SEEED_OVERLAYS}"
DTB_OVERLAYS:append:jetson-orin-nx-seeed-j4012="${DEFAULT_SEEED_OVERLAYS}"
DTB_OVERLAYS:append:jetson-orin-nano-devkit-nvme=",/boot/devicetree/tegra234-p3767-camera-p3768-imx219-dual.dtbo"

# Switch some configs to modules so they can be compressed,
# and disable the ones which are not present on the Orins.
BALENA_CONFIGS:append = " kernel_misc_size_reduction "
BALENA_CONFIGS[kernel_misc_size_reduction] = " \
    CONFIG_E1000=m \
    CONFIG_E1000E=m \
    CONFIG_IGB=m \
    CONFIG_ICE=m \
    CONFIG_MLX5_CORE_EN=m \
    CONFIG_AMD_XGBE=m \
    CONFIG_BNX2X_SRIOV=m \
    CONFIG_FEC=m \
    CONFIG_NET_VENDOR_CAVIUM=n \
    CONFIG_NET_VENDOR_CHELSIO=n \
    CONFIG_NET_VENDOR_CISCO=n \
    CONFIG_NET_VENDOR_HISILICON=n \
    CONFIG_NET_VENDOR_HUAWEI=n \
    CONFIG_NET_VENDOR_MELLANOX=n \
    CONFIG_DRM_EXYNOS5433_DECON=n \
    CONFIG_ROCKCHIP_VOP=n \
    CONFIG_DRM_RCAR_VSP=n \
    CONFIG_DRM_MSM=n \
"

BALENA_CONFIGS:append = " kernel_arch_size_reduction "
BALENA_CONFIGS[kernel_arch_size_reduction] = " \
    CONFIG_ARCH_ACTIONS=n \
    CONFIG_ARCH_SUNXI=n \
    CONFIG_ARCH_ALPINE=n \
    CONFIG_ARCH_APPLE=n \
    CONFIG_ARCH_BCM=n \
    CONFIG_ARCH_BCM2835=n \
    CONFIG_ARCH_BCM_IPROC=n \
    CONFIG_ARCH_BCMBCA=n \
    CONFIG_ARCH_BRCMSTB=n \
    CONFIG_ARCH_BERLIN=n \
    CONFIG_ARCH_EXYNOS=n \
    CONFIG_ARCH_SPARX5=n \
    CONFIG_ARCH_K3=n \
    CONFIG_ARCH_LG1K=n \
    CONFIG_ARCH_HISI=n \
    CONFIG_ARCH_KEEMBAY=n \
    CONFIG_ARCH_MEDIATEK=n \
    CONFIG_ARCH_MESON=n \
    CONFIG_ARCH_MVEBU=n \
    CONFIG_ARCH_NXP=n \
    CONFIG_ARCH_LAYERSCAPE=n \
    CONFIG_ARCH_MXC=n \
    CONFIG_ARCH_S32=n \
    CONFIG_ARCH_MA35=n \
    CONFIG_ARCH_NPCM=n \
    CONFIG_ARCH_QCOM=n \
    CONFIG_ARCH_REALTEK=n \
    CONFIG_ARCH_RENESAS=n \
    CONFIG_ARCH_ROCKCHIP=n \
    CONFIG_ARCH_SEATTLE=n \
    CONFIG_ARCH_INTEL_SOCFPGA=n \
    CONFIG_ARCH_STM32=n \
    CONFIG_ARCH_SYNQUACER=n \
    CONFIG_ARCH_TESLA_FSD=n \
    CONFIG_ARCH_SPRD=n \
    CONFIG_ARCH_THUNDER=n \
    CONFIG_ARCH_THUNDER2=n \
    CONFIG_ARCH_UNIPHIER=n \
    CONFIG_ARCH_VEXPRESS=n \
    CONFIG_ARCH_VISCONTI=n \
    CONFIG_ARCH_XGENE=n \
    CONFIG_ARCH_ZYNQMP=n \
"

# Orins use nvgpu driver
BALENA_CONFIGS:append = " kernel_nouveau_size_reduction "
BALENA_CONFIGS[kernel_nouveau_size_reduction] = " \
    CONFIG_DRM_NOUVEAU=n \
    CONFIG_NOUVEAU_PLATFORM_DRIVER=n \
    CONFIG_DRM_NOUVEAU_BACKLIGHT=n \
"

# LOCAL WORKAROUND - drop once fixed upstream on wip_jp_7.
#
# CSI camera capture is broken on this branch: no /dev/video0, and
# /dev/nvhost-ctrl-{vi0,nvcsi} never appear, even with the IMX219 DTBO correctly
# applied (which fee9697 enables by default for this machine). tegra_camera bails
# during probe:
#
#   WARNING: .../videobuf2-core.c:2499 vb2_core_queue_init+0x1bc/0x1f4
#     vb2_queue_init [videobuf2_v4l2] / tegra_channel_init [tegra_camera] / ...
#   tegra-camrtc-capture-vi tegra-capture-vi: failed to initialize VB2 queue
#   tegra-camrtc-capture-vi tegra-capture-vi: channel init failed
#
# Line 2499 is WARN_ON(!q->mem_ops) - the vb2 memory ops are NULL. The 6.8 config
# builds only CONFIG_VIDEOBUF2_VMALLOC; CONFIG_VIDEOBUF2_DMA_CONTIG is absent
# entirely, and videobuf2_dma_contig is correspondingly missing from the loaded
# modules. Tegra VI capture wants vb2_dma_contig_memops.
#
# Most likely collateral from 27ada66 ("Update from linux 5.15 to 6.8", which
# "cut down the kernel size by disabling unnecessary configs") - nothing here
# disables it explicitly, so it appears to be missing from the 6.8 defconfig.
#
# Reported to acostach; this is a temporary local patch so camera validation of
# the NVIDIA runtime extension is not blocked.
#
# NOTE: CONFIG_VIDEOBUF2_DMA_CONTIG cannot be set directly. In
# drivers/media/common/videobuf2/Kconfig it is declared `tristate` with NO
# prompt, making it a select-only symbol - kconfig silently discards it from a
# defconfig or fragment. (Verified: setting it directly had no effect on the
# generated .config.) It has to be pulled in by a driver that selects it.
#
# VIDEO_MEM2MEM_DEINTERLACE is the least invasive lever available here:
#   depends on V4L_MEM2MEM_DRIVERS  (=y already)
#   depends on VIDEO_DEV            (=m already)
#   depends on HAS_DMA              (arm64)
#   select VIDEOBUF2_DMA_CONTIG
# It is a generic software m2m driver that claims no Tegra hardware.
#
# VIDEO_TEGRA_VDE also selects it, but that is the *in-tree* Tegra video decoder
# and would bind hardware NVIDIA's out-of-tree stack already drives (the OOT
# decoder shows up as /dev/v4l2-nvdec), so it is deliberately not used here.
#
# The proper fix belongs upstream: NVIDIA's JetPack 7.2 reference defconfig will
# say which driver is meant to pull the allocator in.
BALENA_CONFIGS:append = " videobuf2_dma_contig "
BALENA_CONFIGS[videobuf2_dma_contig] = " \
    CONFIG_VIDEO_MEM2MEM_DEINTERLACE=m \
"


generate_extlinux_conf() {
    mkdir -p ${UNPACKDIR}/extlinux || true
    kernelRootspec="${KERNEL_ARGS}" ; cat >${UNPACKDIR}/extlinux/extlinux.conf << EOF
DEFAULT primary
TIMEOUT 10
MENU TITLE Boot Options
LABEL primary
      MENU LABEL primary ${KERNEL_IMAGETYPE}
      FDT default
      OVERLAYS ${DTB_OVERLAYS}
      LINUX /boot/${KERNEL_IMAGETYPE}
      APPEND \${cbootargs} ${kernelRootspec} sdhci_tegra.en_boot_part_access=1 rootwait video=efifb:off
EOF

}

# TODO: Check install from l4t-launcher-extlinux
do_install:append() {
    generate_extlinux_conf
    install -d ${D}/boot/extlinux
    install -m 0644 ${UNPACKDIR}/extlinux/extlinux.conf ${D}/boot/extlinux/
}

PACKAGES =+ "${PN}-extlinux"
FILES:${PN}-extlinux = " /boot/extlinux/extlinux.conf "
RRECOMMENDS:${PN} = "${PN}-extlinux"

do_install[depends] += "${@['', '${INITRAMFS_IMAGE}:do_image_complete'][(d.getVar('INITRAMFS_IMAGE', True) or '') != '' and (d.getVar('TEGRA_INITRAMFS_INITRD', True) or '') == "1"]}"
