FILESEXTRAPATHS:append := ":${THISDIR}/files"
FILESEXTRAPATHS:append := ":${THISDIR}/98-efivars-agx-orin-devkit"
FILESEXTRAPATHS:append := ":${THISDIR}/98-efivars-orin-nx-xavier-nx-devkit"
FILESEXTRAPATHS:append := ":${THISDIR}/98-efivars-orin-nano-devkit-nvme"

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
     99-resin-bootfiles-orin-nano-devkit-nvme \
"

HOSTAPP_HOOKS_DIRS:append:jetson-agx-orin-devkit = " 98-efivars-agx-orin-devkit"
HOSTAPP_HOOKS:append:jetson-agx-orin-devkit = " 98-efivars-agx-orin-devkit/after "

HOSTAPP_HOOKS_DIRS:append:jetson-orin-nx-xavier-nx-devkit = " 98-efivars-orin-nx-xavier-nx-devkit"
HOSTAPP_HOOKS:append:jetson-orin-nx-xavier-nx-devkit = " 98-efivars-orin-nx-xavier-nx-devkit/after "

HOSTAPP_HOOKS_DIRS:append:jetson-orin-nano-devkit-nvme = " 98-efivars-orin-nano-devkit-nvme"
HOSTAPP_HOOKS:append:jetson-orin-nano-devkit-nvme = " 98-efivars-orin-nano-devkit-nvme/after "

HOSTAPP_HOOKS:remove:jetson-orin-nx-seeed-j4012 = "99-resin-bootfiles-orin-nx-xavier-nx-devkit"
HOSTAPP_HOOKS:append:jetson-orin-nx-seeed-j4012 = " \
     99-resin-bootfiles-orin-nx-seeed-j4012 \
"

HOSTAPP_HOOKS_DIRS:remove:jetson-orin-nx-seeed-j4012 = " 98-efivars-orin-nx-xavier-nx-devkit"
HOSTAPP_HOOKS:remove:jetson-orin-nx-seeed-j4012 = " 98-efivars-orin-nx-xavier-nx-devkit/after"

# 98-resin-bootfiles-jetson-xavier
HOSTAPP_HOOKS:append:jetson-xavier = " \
    99-resin-uboot \
"

HOSTAPP_HOOKS:append:jetson-xavier-nx-devkit-emmc = " \
    99-resin-uboot \
"
