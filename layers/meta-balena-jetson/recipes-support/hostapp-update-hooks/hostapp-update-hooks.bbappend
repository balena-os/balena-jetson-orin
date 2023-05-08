FILESEXTRAPATHS:append := ":${THISDIR}/files"

DEPENDS:append = " tegra-flash-dry"

HOSTAPP_HOOKS:append:jetson-agx-orin-devkit = " \
    99-resin-uboot \
    99-resin-bootfiles-agx-orin-devkit \
"

HOSTAPP_HOOKS:append:jetson-orin-nx-xavier-nx-devkit = " \
     99-resin-uboot \
     99-resin-bootfiles-orin-nx-xavier-nx-devkit \
"

HOSTAPP_HOOKS:append:jetson-xavier = " \
     99-resin-uboot \
     99-resin-bootfiles-jetson-xavier \
"

HOSTAPP_HOOKS:append:jetson-xavier-nx-devkit-emmc = "\
    99-resin-uboot \
    99-resin-bootfiles-jetson-xavier-nx-devkit-emmc \
"
