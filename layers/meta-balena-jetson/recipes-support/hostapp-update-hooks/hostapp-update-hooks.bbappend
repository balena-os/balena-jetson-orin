FILESEXTRAPATHS:append := ":${THISDIR}/files"


HOSTAPP_HOOKS:append    = " 99-resin-uboot \
			    99-resin-bootfiles-agx-orin-devkit \
"
DEPENDS:append = " tegra234-flash-dry"
