FILESEXTRAPATHS:append := ":${THISDIR}/files"


HOSTAPP_HOOKS:append:jetson-agx-orin-devkit    = " 99-resin-uboot \
			    99-resin-bootfiles-agx-orin-devkit \
"
DEPENDS:append:jetson-agx-orin-devkit = " tegra234-flash-dry"
