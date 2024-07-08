PACKAGE_INSTALL:append = " tegra-firmware-xusb"

PACKAGE_INSTALL:remove = " mdraid"
PACKAGE_INSTALL:remove = " initramfs-module-recovery"

# These in-tree and oot modules are needed
# in the initramfs, so that the nvme can be
# discovered and mounted
PACKAGE_INSTALL:append = " kernel-module-pcie-tegra194 "
PACKAGE_INSTALL:append = " nv-kernel-module-pcie-tegra-vf "
PACKAGE_INSTALL:append = " kernel-module-nvme "
PACKAGE_INSTALL:append = " kernel-module-phy-tegra194-p2u"
