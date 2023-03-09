FILESEXTRAPATHS:append := ":${THISDIR}/files"


HOSTAPP_HOOKS:append:jetson-agx-orin-devkit    = " 99-resin-uboot \
			    99-resin-bootfiles-agx-orin-devkit \
"
DEPENDS:append:jetson-agx-orin-devkit = " tegra234-flash-dry"

DEPENDS:append:jetson-orin-nx-xavier-nx-devkit = " tegra234-p3767-p3509-a02-flash-dry"
HOSTAPP_HOOKS:append:jetson-orin-nx-xavier-nx-devkit  = " 99-resin-uboot \
                            99-resin-bootfiles-orin-nx-xavier-nx-devkit \
"

HOSTAPP_HOOKS:append:jetson-xavier    = " 99-resin-uboot \
                            99-resin-bootfiles-jetson-xavier \
"

DEPENDS:append:jetson-xavier = " tegra194-flash-dry"


HOSTAPP_HOOKS:append:jetson-xavier-nx-devkit-emmc = " 99-resin-uboot 99-resin-bootfiles-jetson-xavier-nx-devkit-emmc"
DEPENDS:append:jetson-xavier = " tegra194-nxde-flash-dry"
