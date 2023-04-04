include balena-image.inc

IMAGE_INSTALL:remove:jetson-orin-nx-xavier-nx-devkit="l4t-launcher-extlinux"
IMAGE_INSTALL:append = "efitools-utils efibootmgr"

