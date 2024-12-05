PACKAGE_INSTALL:remove = " mdraid"
PACKAGE_INSTALL:remove = " initramfs-module-recovery"

# These in-tree and oot modules are needed
# in the initramfs, so that the nvme can be
# discovered and mounted
PACKAGE_INSTALL:append = " kernel-module-pcie-tegra194 "
PACKAGE_INSTALL:append = " nv-kernel-module-pcie-tegra-vf "
PACKAGE_INSTALL:append = " kernel-module-nvme "
PACKAGE_INSTALL:append = " kernel-module-phy-tegra194-p2u"

# The three packages below are needed if flashing is
# performed in the initramfs, for example in the case
# where a NVME is flashed directly with the flasher image
# and booted.
# NOTE: We assume only the NVME will be previsioned in
# this case, because the default firmware doesn't
# allow access to the QSPI, but install the qspi driver
# in case it is accessible
PACKAGE_INSTALL:append = " mtd-utils fatrw gptfdisk kernel-module-spi-tegra210-quad"
PACKAGE_INSTALL:append = " mtd-utils fatrw gptfdisk kernel-module-spi-tegra210-quad jetson-qspi-manager setup-nv-boot-control"
# Below modules are needed for the AGX Orin 64GB to
# detect USB keys
PACKAGE_INSTALL:append:jetson-agx-orin-devkit-64gb = " kernel-module-typec-ucsi"
PACKAGE_INSTALL:append:jetson-agx-orin-devkit-64gb = " kernel-module-typec"
PACKAGE_INSTALL:append:jetson-agx-orin-devkit-64gb = " kernel-module-ucsi-ccg"

IMAGE_ROOTFS_MAXSIZE="40960"
