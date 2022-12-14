
do_rootfs:balenaos-img:jetson-agx-orin-devkit[depends] += " tegra234-flash-dry:do_deploy \
						edk2-firmware-tegra:do_deploy \
                                                linux-tegra:do_deploy \
"

DTBFILE ?= "${@os.path.basename(d.getVar('KERNEL_DEVICETREE', True).split()[0])}"

IMAGE_INSTALL:append = " \
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

IMAGE_INSTALL:remove = "kernel-image-image"
