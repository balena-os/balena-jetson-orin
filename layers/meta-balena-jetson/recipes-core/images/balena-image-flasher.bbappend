include balena-image.inc

IMAGE_INSTALL:remove:jetson-orin-nx-xavier-nx-devkit="l4t-launcher-extlinux"
IMAGE_INSTALL:append = "efitools-utils efibootmgr"

BALENA_BOOT_PARTITION_FILES:append = " \
    bootfiles/EFI/BOOT/BOOTAA64.efi:/EFI/BOOT/BOOTAA64.efi \
    extra_uEnv.txt:/extra_uEnv.txt \
"

