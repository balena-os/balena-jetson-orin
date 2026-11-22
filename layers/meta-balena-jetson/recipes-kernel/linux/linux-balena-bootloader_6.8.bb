SUMMARY = "Balena bootloader based on the Linux for Tegra kernel"

KERNEL_IMAGETYPE = "${BALENA_BOOTLOADER_KERNEL_IMAGETYPE}"
KERNEL_IMAGETYPES = "${KERNEL_IMAGETYPE}"

require recipes-kernel/linux/linux-noble-nvidia-tegra.inc
require linux-nvidia-tegra.inc

# The bootloader has no console framebuffer and no networking
SRC_URI:remove = "file://fbcon.cfg"
SRC_URI:remove = "file://tegra-ip-nf.cfg"

SCMVERSION = "n"

inherit balena-bootloader

COMPATIBLE_MACHINE = "jetson-orin-nano-devkit-nvme"

BALENA_CONFIGS:append = " tegra-boot"
BALENA_CONFIGS[tegra-boot] = " \
    CONFIG_EFI=y \
    CONFIG_EFI_STUB=y \
    CONFIG_EFI_ZBOOT=y \
    CONFIG_TEGRA_BPMP=y \
    CONFIG_TEGRA_HSP_MBOX=y \
    CONFIG_SERIAL_TEGRA_TCU=y \
    CONFIG_PCIE_TEGRA194_HOST=y \
    CONFIG_PCIE_TEGRA194_EP=n \
    CONFIG_PHY_TEGRA194_P2U=y \
    CONFIG_BLK_DEV_NVME=y \
    CONFIG_MMC=y \
    CONFIG_MMC_SDHCI=y \
    CONFIG_MMC_SDHCI_PLTFM=y \
    CONFIG_MMC_SDHCI_TEGRA=y \
    CONFIG_PHY_TEGRA_XUSB=y \
    CONFIG_USB_XHCI_TEGRA=y \
"

do_deploy:append() {
    cat > ${DEPLOYDIR}/${KERNEL_PACKAGE_NAME}/extlinux.conf << EOF
DEFAULT primary
TIMEOUT 10
MENU TITLE Boot Options
LABEL primary
      MENU LABEL balenaOS
      FDT default
      OVERLAYS ${DTB_OVERLAYS}
      LINUX /boot/${KERNEL_IMAGETYPE}
      APPEND \${cbootargs} ${KERNEL_ARGS} sdhci_tegra.en_boot_part_access=1 rootwait video=efifb:off balena_stage2
EOF
}
