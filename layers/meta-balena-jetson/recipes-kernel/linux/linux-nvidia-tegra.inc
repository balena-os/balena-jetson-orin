L4TVER = " l4tver=${L4T_VERSION}"

KERNEL_ARGS += "${@bb.utils.contains('DISTRO_FEATURES','osdev-image',' mminit_loglevel=4 console=tty0 console=ttyTCU0,115200 ',' console=null quiet splash vt.global_cursor_default=0 consoleblank=0',d)} l4tver=${L4T_VERSION} rootdelay=1 roottimeout=60 "

# Let's not disable this by default
# in our integration, although upstream does.
KERNEL_ARGS:remove = "nospectre_bhb"
KERNEL_ARGS:remove = "firmware_class.path=/etc/firmware"

DEFAULT_SEEED_OVERLAYS = ",/boot/devicetree/tegra234-dcb-p3767-0000-hdmi.dtbo,/boot/devicetree/tegra234-p3767-camera-p3768-imx219-dual-seeed.dtbo"

DTB_OVERLAYS:jetson-agx-orin-devkit-64gb = "/boot/devicetree/tegra234-p3737-0000+p3701-0000-dynamic.dtbo"
DTB_OVERLAYS:jetson-agx-orin-devkit = "/boot/devicetree/tegra234-p3737-0000+p3701-0000-dynamic.dtbo"
DTB_OVERLAYS = "/boot/devicetree/tegra234-p3768-0000+p3767-0000-dynamic.dtbo"
DTB_OVERLAYS:append:jetson-orin-nano-seeed-j3010 = "${DEFAULT_SEEED_OVERLAYS}"
DTB_OVERLAYS:append:jetson-orin-nx-seeed-j4012 = "${DEFAULT_SEEED_OVERLAYS}"
DTB_OVERLAYS:append:jetson-orin-nano-devkit-nvme = ",/boot/devicetree/tegra234-p3767-camera-p3768-imx219-dual.dtbo"
