FILESEXTRAPATHS:append := ":${THISDIR}/files"
FILESEXTRAPATHS:append := ":${THISDIR}/98-clear-agx-orin-unused-capsule"

DEPENDS:append = " tegra-flash-dry"

HOSTAPP_HOOKS:append:jetson-agx-orin-devkit = " \
    99-resin-uboot \
    99-resin-bootfiles-agx-orin-devkit \
"

HOSTAPP_HOOKS:append:jetson-agx-orin-devkit-64gb = " \
    99-resin-uboot \
    99-resin-bootfiles-agx-orin-devkit-64gb \
"

HOSTAPP_HOOKS:append:jetson-orin-nx-xavier-nx-devkit = " \
     99-resin-uboot \
     99-resin-bootfiles-orin-nx-xavier-nx-devkit \
"

HOSTAPP_HOOKS:append:jetson-orin-nano-devkit-nvme = " \
     99-resin-uboot \
     99-resin-bootfiles-orin-nano-devkit-nvme \
"

# Ensure there's no leftover capsule in the boot partition,
# taking up space
HOSTAPP_HOOKS_DIRS:append:jetson-agx-orin-devkit = " 98-clear-agx-orin-unused-capsule"
HOSTAPP_HOOKS:append:jetson-agx-orin-devkit = " 98-clear-agx-orin-unused-capsule/before "

HOSTAPP_HOOKS:remove:jetson-orin-nx-seeed-j4012 = "99-resin-bootfiles-orin-nx-xavier-nx-devkit"
HOSTAPP_HOOKS:append:jetson-orin-nx-seeed-j4012 = " \
     99-resin-bootfiles-orin-nx-seeed-j4012 \
"

HOSTAPP_HOOKS:append:jetson-orin-nano-seeed-j3010 = " \
    99-resin-uboot \
    99-resin-bootfiles-orin-nano-seeed-j3010 \
"

HOSTAPP_HOOKS:append:forecr-dsb-ornx-orin-nano-8gb = " \
    99-resin-uboot \
    99-resin-bootfiles-forecr-dsb-ornx-orin-nano-8gb \
"

HOSTAPP_HOOKS:append:forecr-dsb-ornx-orin-nano-4gb = " \
    99-resin-uboot \
    99-resin-bootfiles-forecr-dsb-ornx-orin-nano-4gb \
"

HOSTAPP_HOOKS:append:forecr-dsb-ornx-orin-nx-16gb = " \
    99-resin-uboot \
    99-resin-bootfiles-forecr-dsb-ornx-orin-nx-16gb \
"
