FILESEXTRAPATHS:append := ":${THISDIR}/files"
FILESEXTRAPATHS:append := ":${THISDIR}/98-efivars"

DEPENDS:append = " tegra-flash-dry"

HOSTAPP_HOOKS:append:jetson-agx-orin-devkit = " \
    99-resin-uboot \
    99-resin-bootfiles-agx-orin-devkit \
"

HOSTAPP_HOOKS:append:jetson-orin-nx-xavier-nx-devkit = " \
     99-resin-uboot \
     99-resin-bootfiles-orin-nx-xavier-nx-devkit \
"

HOSTAPP_HOOKS:append:jetson-orin-nano-devkit-nvme = " \
     99-resin-uboot \
"

HOSTAPP_HOOKS_DIRS:append:jetson-agx-orin-devkit = " 98-efivars"
HOSTAPP_HOOKS:append:jetson-agx-orin-devkit = " 98-efivars/after "
