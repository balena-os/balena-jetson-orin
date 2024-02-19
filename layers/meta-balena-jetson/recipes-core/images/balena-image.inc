IMAGE_FSTYPES += "balenaos-img"

do_rootfs:balenaos-img[depends] += " linux-tegra:do_deploy edk2-firmware-tegra:do_deploy l4t-launcher-extlinux:do_deploy tegra-flash-dry:do_install"
DTBFILE ?= "${@os.path.basename(d.getVar('KERNEL_DEVICETREE', True).split()[0])}"

IMAGE_INSTALL:append = " \
    tegra-flash-dry \
    kernel-image-initramfs \
    tegra-redundant-boot \
    tegra-nv-boot-control-config \
    tegra-eeprom-tool \
    setup-nv-boot-control \
"

# We don't mount or use the esp partition, so let's
# remove the systemd mounts that delay booting
IMAGE_INSTALL:remove = "setup-nv-boot-control-service"

MACHINE_EXTRA_RRECOMMENDS += " kernel-image-initramfs"
MACHINE_EXTRA_RDEPENDS += " kernel-image-initramfs"

IMAGE_INSTALL:append:jetson-orin-nano-devkit-nvme = " \
    parted \
    gptfdisk \
    tegra-nvpmodel \
    tegra-configs-nvstartup \
    tegra-configs-udev \
    mtd-utils \
    tegra-bluetooth \
    tegra-wifi \
    tegra-firmware-rtl8822 \
    l4t-launcher-extlinux \
    jetson-dtbs \
    nvidia-display-driver \
    tegra-nvpower \
"

IMAGE_INSTALL:append:jetson-agx-orin-devkit = " \
    parted \
    gptfdisk \
    tegra-nvpmodel \
    tegra-configs-nvstartup \
    tegra-configs-udev \
    mtd-utils \
    tegra-bluetooth \
    tegra-wifi \
    tegra-firmware-rtl8822 \
    l4t-launcher-extlinux \
    jetson-dtbs \
    nvidia-display-driver \
    tegra-nvfancontrol \
    dtc \
"

IMAGE_INSTALL:append:jetson-orin-nx-xavier-nx-devkit = " \
    parted \
    gptfdisk \
    tegra-nvpmodel \
    tegra-configs-nvstartup \
    tegra-configs-udev \
    mtd-utils \
    tegra-bluetooth \
    tegra-wifi \
    tegra-firmware-rtl8822 \
    l4t-launcher-extlinux \
    jetson-dtbs \
    nvidia-display-driver \
    tegra-nvfancontrol \
    linux-firmware-rtl8168 \
    kernel-module-realtek \
    pciutils \
"

XAVIER_PACKAGES = " \
    tegra-redundant-boot \
    tegra-nv-boot-control-config \
    parted \
    gptfdisk \
    tegra-bluetooth \
    tegra-wifi \
    tegra-nvpmodel \
    jetson-dtbs \
    tegra-configs-nvstartup \
    tegra-nvstartup \
    tegra-configs-udev \
    tegra-nvfancontrol \
    l4t-launcher-extlinux \
    pciutils \
    tegra-firmware \
    tegra-eeprom-tool \
    setup-nv-boot-control \
    ldd \
    tegra-firmware-rtl8822 \
    mtd-utils \
"

IMAGE_INSTALL:append:jetson-xavier = "${XAVIER_PACKAGES}"
IMAGE_INSTALL:append:jetson-xavier-nx-devkit-emmc = "${XAVIER_PACKAGES}"
IMAGE_INSTALL:append:jetson-xavier-nx-devkit = "${XAVIER_PACKAGES}"

IMAGE_INSTALL:remove = "kernel-image-image"
