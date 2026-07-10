IMAGE_FSTYPES += "balenaos-img"

do_rootfs:balenaos-img[depends] += " tegra-flash-dry:do_install nvidia-kernel-oot:do_deploy "
DTBFILE ?= "${@os.path.basename(d.getVar('KERNEL_DEVICETREE', True).split()[0])}"

do_resin_boot_dirgen_and_deploy[depends] += "l4t-launcher-extlinux:do_install"

IMAGE_INSTALL:append:forecr-dsb-ornx-orin-nano-8gb = " can-utils "

# We don't mount or use the esp partition, so let's
# remove the systemd mounts that delay booting
IMAGE_INSTALL:remove = "setup-nv-boot-control-service"

MACHINE_EXTRA_RRECOMMENDS += " kernel-image-initramfs"
MACHINE_EXTRA_RDEPENDS += " kernel-image-initramfs"

IMAGE_INSTALL:remove = "kernel-image-image"

