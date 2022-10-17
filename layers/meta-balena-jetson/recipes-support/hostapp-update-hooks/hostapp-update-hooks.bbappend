FILESEXTRAPATHS:append := ":${THISDIR}/files"


HOSTAPP_HOOKS:append    = " 99-resin-uboot"
DEPENDS:append = " tegra234-flash-dry"
