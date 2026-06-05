include balena-image.inc

do_image:balenaos-img[depends] += " tegra-flash-dry:do_deploy l4t-launcher-extlinux:do_install edk2-container:do_package"

IMAGE_INSTALL:append = "efitools-utils efibootmgr"

BALENA_BOOT_PARTITION_FILES:append = " \
    bootfiles/EFI/BOOT/BOOTAA64.efi:/EFI/BOOT/BOOTAA64.efi \
    extra_uEnv.txt:/extra_uEnv.txt \
"

IMAGE_INSTALL:append = " \
    tegra-flash-dry \
    kernel-image-initramfs \
    tegra-redundant-boot \
    tegra-nv-boot-control-config \
    tegra-eeprom-tool \
    setup-nv-boot-control \
    edk2-container \
    uefi-capsule-container \
    tegra-nvfancontrol \
    parted \
    gptfdisk \
    tegra-configs-nvstartup \
    tegra-configs-udev \
    mtd-utils \
    tegra-wifi \
    l4t-launcher-extlinux \
    jetson-qspi-manager \
    jetson-dtbs \
    nvidia-kernel-oot-devicetrees nvidia-kernel-oot-display nvidia-kernel-oot-wifi \
    nvidia-kernel-oot-virtualization nvidia-kernel-oot-base nvidia-drm-loadconf \
    kernel-module-r8126 kernel-module-r8168 linux-jammy-nvidia-tegra-extlinux \
"
