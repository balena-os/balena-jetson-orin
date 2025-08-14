include balena-image.inc

do_image:balenaos-img[depends] += " tegra-flash-dry:do_deploy l4t-launcher-extlinux:do_install edk2-container:do_package"

IMAGE_INSTALL:append = "efitools-utils efibootmgr"

BALENA_BOOT_PARTITION_FILES:append = " \
    bootfiles/EFI/BOOT/BOOTAA64.efi:/EFI/BOOT/BOOTAA64.efi \
    extra_uEnv.txt:/extra_uEnv.txt \
"

