IMAGE_FSTYPES += "balenaos-img"

do_rootfs:balenaos-img[depends] += " linux-jammy-nvidia-tegra:do_deploy edk2-firmware-tegra:do_deploy l4t-launcher-extlinux:do_deploy tegra-flash-dry:do_install"
DTBFILE ?= "${@os.path.basename(d.getVar('KERNEL_DEVICETREE', True).split()[0])}"

IMAGE_INSTALL:append = " \
    tegra-flash-dry \
    kernel-image-initramfs \
    tegra-redundant-boot \
    tegra-nv-boot-control-config \
    tegra-eeprom-tool \
    setup-nv-boot-control \
"

# We don't mount or use the esp partition, so let's
# remove the systemd mounts that delay booting
IMAGE_INSTALL:remove = "setup-nv-boot-control-service"

MACHINE_EXTRA_RRECOMMENDS += " kernel-image-initramfs"
MACHINE_EXTRA_RDEPENDS += " kernel-image-initramfs"

IMAGE_INSTALL:append:jetson-orin-nano-devkit-nvme = " \
    parted \
    gptfdisk \
    tegra-nvpmodel \
    tegra-configs-nvstartup \
    tegra-configs-udev \
    mtd-utils \
    tegra-bluetooth \
    tegra-wifi \
    tegra-firmware-rtl8822 \
    l4t-launcher-extlinux \
    jetson-dtbs \
    tegra-nvpower \
    kernel-module-nvidia \
    kernel-module-nvidia-drm \
    kernel-module-nvidia-modeset \
    kernel-module-tegra-dce \
    kernel-module-tegra-drm-next \
    kernel-module-hvc-sysfs \
    kernel-module-nv-virtio-console-poc \
    kernel-module-pcie-tegra-vf \
    kernel-module-tegra-gr-comm \
    kernel-module-tegra-hv-mtd \
    kernel-module-tegra-hv-pm-ctl \
    kernel-module-tegra-hv-vblk-oops \
    kernel-module-tegra-hv-vcpu-yield \
    kernel-module-tegra-nvvse-cryptodev \
    kernel-module-tegra-vblk \
    kernel-module-tegra-vnet \
    kernel-module-userspace-ivc-mempool \
    kernel-module-arm64-ras \
    kernel-module-cpuidle-debugfs \
    kernel-module-cpuidle-tegra-auto \
    kernel-module-fusb301 \
    kernel-module-governor-pod-scaling \
    kernel-module-host1x-fence \
    kernel-module-host1x-next \
    kernel-module-host1x-nvhost \
    kernel-module-i2c-nvvrs11 \
    kernel-module-mc-hwpm \
    kernel-module-mc-utils \
    kernel-module-nvethernet \
    kernel-module-nvgpu \
    kernel-module-nvhost-nvdla \
    kernel-module-nvhost-pva \
    kernel-module-nvhwpm \
    kernel-module-nvidia-vrs-pseq \
    kernel-module-nvmap \
    kernel-module-nvpmodel-clk-cap \
    kernel-module-nvpps \
    kernel-module-nvsciipc \
    kernel-module-nvvrs-pseq-rtc \
    kernel-module-pwm-tegra-tachometer \
    kernel-module-spi-tegra210-quad \
    kernel-module-tegra194-gte \
    kernel-module-tegra234-aon \
    kernel-module-tegra234-oc-event \
    kernel-module-tegra23x-perf-uncore \
    kernel-module-tegra23x-psc \
    kernel-module-tegra-aon-ivc-echo \
    kernel-module-tegra-bpmp \
    kernel-module-tegra-cactmon-mc-all \
    kernel-module-tegra-mce \
    kernel-module-tegra-se \
    kernel-module-tegra-se-nvrng \
    kernel-module-tegra-wmark \
    kernel-module-thermal-trip-event \
    kernel-module-tsecriscv \
    kernel-module-watchdog-tegra-t18x \
"

IMAGE_INSTALL:append:jetson-agx-orin-devkit = " \
    parted \
    gptfdisk \
    tegra-nvpmodel \
    tegra-configs-nvstartup \
    tegra-configs-udev \
    mtd-utils \
    tegra-bluetooth \
    tegra-wifi \
    tegra-firmware-rtl8822 \
    l4t-launcher-extlinux \
    jetson-dtbs \
    tegra-nvfancontrol \
    nvidia-drm-loadconf \
    dtc \
    kernel-module-nvidia \
    kernel-module-nvidia-drm \
    kernel-module-nvidia-modeset \
    kernel-module-tegra-dce \
    kernel-module-tegra-drm-next \
    kernel-module-hvc-sysfs \
    kernel-module-nv-virtio-console-poc \
    kernel-module-pcie-tegra-vf \
    kernel-module-tegra-gr-comm \
    kernel-module-tegra-hv-mtd \
    kernel-module-tegra-hv-pm-ctl \
    kernel-module-tegra-hv-vblk-oops \
    kernel-module-tegra-hv-vcpu-yield \
    kernel-module-tegra-nvvse-cryptodev \
    kernel-module-tegra-vblk \
    kernel-module-tegra-vnet \
    kernel-module-userspace-ivc-mempool \
    kernel-module-arm64-ras \
    kernel-module-cpuidle-debugfs \
    kernel-module-cpuidle-tegra-auto \
    kernel-module-fusb301 \
    kernel-module-governor-pod-scaling \
    kernel-module-host1x-fence \
    kernel-module-host1x-next \
    kernel-module-host1x-nvhost \
    kernel-module-i2c-nvvrs11 \
    kernel-module-mc-hwpm \
    kernel-module-mc-utils \
    kernel-module-nvethernet \
    kernel-module-nvgpu \
    kernel-module-nvhost-nvdla \
    kernel-module-nvhost-pva \
    kernel-module-nvhwpm \
    kernel-module-nvidia-vrs-pseq \
    kernel-module-nvmap \
    kernel-module-nvpmodel-clk-cap \
    kernel-module-nvpps \
    kernel-module-nvsciipc \
    kernel-module-nvvrs-pseq-rtc \
    kernel-module-pwm-tegra-tachometer \
    kernel-module-spi-tegra210-quad \
    kernel-module-tegra194-gte \
    kernel-module-tegra234-aon \
    kernel-module-tegra234-oc-event \
    kernel-module-tegra23x-perf-uncore \
    kernel-module-tegra23x-psc \
    kernel-module-tegra-aon-ivc-echo \
    kernel-module-tegra-bpmp \
    kernel-module-tegra-cactmon-mc-all \
    kernel-module-tegra-mce \
    kernel-module-tegra-se \
    kernel-module-tegra-se-nvrng \
    kernel-module-tegra-wmark \
    kernel-module-thermal-trip-event \
    kernel-module-tsecriscv \
    kernel-module-watchdog-tegra-t18x \
"

IMAGE_INSTALL:append:jetson-orin-nx-xavier-nx-devkit = " \
    parted \
    gptfdisk \
    tegra-nvpmodel \
    tegra-configs-nvstartup \
    tegra-configs-udev \
    mtd-utils \
    tegra-bluetooth \
    tegra-wifi \
    tegra-firmware-rtl8822 \
    l4t-launcher-extlinux \
    jetson-dtbs \
    nvidia-display-driver \
    tegra-nvfancontrol \
    linux-firmware-rtl8168 \
    kernel-module-realtek \
    pciutils \
"

IMAGE_INSTALL:remove = "kernel-image-image"

