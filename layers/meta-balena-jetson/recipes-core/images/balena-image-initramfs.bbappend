PACKAGE_INSTALL:remove = " mdraid"
PACKAGE_INSTALL:remove = " initramfs-module-recovery"

# These in-tree and oot modules are needed
# in the initramfs, so that the nvme can be
# discovered and mounted
PACKAGE_INSTALL:append = " kernel-module-pcie-tegra194 "
PACKAGE_INSTALL:append = " nv-kernel-module-pcie-tegra-vf "
PACKAGE_INSTALL:append = " kernel-module-nvme "
PACKAGE_INSTALL:append = " kernel-module-phy-tegra194-p2u"

# Below modules are needed for the AGX Orin 64GB to
# detect USB keys
PACKAGE_INSTALL:append:jetson-agx-orin-devkit-64gb = " kernel-module-typec-ucsi"
PACKAGE_INSTALL:append:jetson-agx-orin-devkit-64gb = " kernel-module-typec"
PACKAGE_INSTALL:append:jetson-agx-orin-devkit-64gb = " kernel-module-ucsi-ccg"
