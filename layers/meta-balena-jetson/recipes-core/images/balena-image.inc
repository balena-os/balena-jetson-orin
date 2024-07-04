IMAGE_FSTYPES += "balenaos-img"

do_rootfs:balenaos-img[depends] += " tegra-flash-dry:do_install nvidia-kernel-oot:do_deploy edk2-container:do_deploy "
DTBFILE ?= "${@os.path.basename(d.getVar('KERNEL_DEVICETREE', True).split()[0])}"

IMAGE_INSTALL:append = " \
    tegra-flash-dry \
    kernel-image-initramfs \
    tegra-redundant-boot \
    tegra-nv-boot-control-config \
    tegra-eeprom-tool \
    setup-nv-boot-control \
    edk2-container \
    tegra-nvfancontrol \
    tegra-nvpower \
    parted \
    gptfdisk \
    tegra-nvpmodel \
    tegra-configs-nvstartup \
    tegra-configs-udev \
    mtd-utils \
    tegra-bluetooth \
    tegra-wifi \
    tegra-firmware-rtl8822 \
    linux-firmware-rtl8168 \
    linux-firmware-ibt-12-16 \
    linux-firmware-iwlwifi-8265 \
    jetson-dtbs \
    l4t-launcher-extlinux \
    dtc \
    pciutils \
    nvidia-kernel-oot-devicetrees nvidia-kernel-oot-display nvidia-kernel-oot-cameras nvidia-kernel-oot-bluetooth nvidia-kernel-oot-wifi \
    nvidia-kernel-oot-canbus nvidia-kernel-oot-virtualization nvidia-kernel-oot-base nvidia-drm-loadconf \
"

# We don't mount or use the esp partition, so let's
# remove the systemd mounts that delay booting
IMAGE_INSTALL:remove = "setup-nv-boot-control-service"

MACHINE_EXTRA_RRECOMMENDS += " kernel-image-initramfs"
MACHINE_EXTRA_RDEPENDS += " kernel-image-initramfs"

IMAGE_INSTALL:remove = "kernel-image-image"

