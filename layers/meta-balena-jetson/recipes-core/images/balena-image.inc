
do_rootfs:balenaos-img:jetson-agx-orin-devkit[depends] += " tegra234-flash-dry:do_deploy \
						edk2-firmware-tegra:do_deploy \
                                                linux-tegra:do_deploy \
"

DTBFILE ?= "${@os.path.basename(d.getVar('KERNEL_DEVICETREE', True).split()[0])}"

IMAGE_INSTALL:append:jetson-agx-orin-devkit = " \
    tegra234-flash-dry \
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
"

IMAGE_INSTALL:append:jetson-xavier = " \
    tegra194-flash-dry \
    parted \
    gptfdisk \
    tegra-bluetooth \
    tegra-wifi \
    tegra-nvpmodel \
    tegra-configs-nvstartup \
    tegra-configs-udev \
    tegra-nvfancontrol \
    l4t-launcher-extlinux \
"

IMAGE_INSTALL:append:jetson-xavier-nx-devkit-emmc = " \
    parted \
    gptfdisk \
    tegra-nvpmodel \
    tegra-configs-nvstartup \
    tegra-configs-udev \
    tegra-wifi \
    tegra-bluetooth \
    tegra-firmware-rtl8822 \
    mtd-utils \
    tegra-nvfancontrol \
    l4t-launcher-extlinux \
"

IMAGE_INSTALL:append:jetson-xavier-nx-devkit = " \
    parted \
    gptfdisk \
    tegra-nvpmodel \
    tegra-configs-nvstartup \
    tegra-configs-udev \
    mtd-utils \
    tegra-bluetooth \
    tegra-wifi \
    tegra-firmware-rtl8822 \
    tegra-nvfancontrol \
    l4t-launcher-extlinux \
"


IMAGE_INSTALL:remove = "kernel-image-image"
