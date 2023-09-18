do_compile() {
    echo "AGX Orin is the only board in the Orin line-up which supports capsule updates as of L4T 35.3.1"
}

do_install() {
    echo "AGX Orin is the only board in the Orin line-up which supports capsule updates as of L4T 35.3.1"
}

# We can't modify the root filesystem at runtime
# and also know how the file should look for
# the AGX Orin Devkit, so let's populate it at
# build time
do_compile:jetson-agx-orin-devkit() {
	cat > ${B}/nv_boot_control.conf <<EOF
TNSPEC 3701-500-0000-J.0-1-1-jetson-agx-orin-devkit-
COMPATIBLE_SPEC 3701--0000--1--jetson-agx-orin-devkit-
TEGRA_LEGACY_UPDATE true
TEGRA_EMMC_ONLY false
TEGRA_CHIPID 0x23
TEGRA_OTA_BOOT_DEVICE /dev/mtdblock0
TEGRA_OTA_GPT_DEVICE /dev/mtdblock0
EOF

}

do_install:jetson-agx-orin-devkit() {
	install -d ${D}${sysconfdir}
	install -m 0644 ${B}/nv_boot_control.conf ${D}${sysconfdir}/
}

PACKAGE_ARCH = "${MACHINE_ARCH}"
