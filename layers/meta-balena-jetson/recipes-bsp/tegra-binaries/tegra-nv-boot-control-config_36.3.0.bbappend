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

do_compile:jetson-orin-nx-xavier-nx-devkit() {
        cat > ${B}/nv_boot_control.conf <<EOF
TNSPEC 3767-ES1-0000-A.3-1-0-jetson-orin-nx-xavier-nx-devkit-nvme0n1p1
COMPATIBLE_SPEC 3767-000-0000--1-0-jetson-orin-nano-devkit-
TEGRA_CHIPID 0x23
TEGRA_OTA_BOOT_DEVICE /dev/mtdblock0
TEGRA_OTA_GPT_DEVICE /dev/mtdblock0
EOF

}

do_compile:jetson-orin-nano-devkit-nvme() {
        cat > ${B}/nv_boot_control.conf <<EOF
TNSPEC 3767-300-0005-K.2-1-1-jetson-orin-nano-devkit-
COMPATIBLE_SPEC 3767--0005--1--jetson-orin-nano-devkit-
TEGRA_LEGACY_UPDATE true
TEGRA_BOOT_STORAGE nvme0n1
TEGRA_EMMC_ONLY false
TEGRA_CHIPID 0x23
TEGRA_OTA_BOOT_DEVICE /dev/mtdblock0
TEGRA_OTA_GPT_DEVICE /dev/mtdblock0
EOF

}

do_compile:jetson-orin-nano-seeed-j3010() {
        cat > ${B}/nv_boot_control.conf <<EOF
TNSPEC 3767-300-0004-N.2-1-0-jetson-orin-nano-devkit-
COMPATIBLE_SPEC 3767-300-0004--1-0-jetson-orin-nano-devkit-
TEGRA_LEGACY_UPDATE true
TEGRA_BOOT_STORAGE nvme0n1
TEGRA_EMMC_ONLY false
TEGRA_CHIPID 0x23
TEGRA_OTA_BOOT_DEVICE /dev/mtdblock0
TEGRA_OTA_GPT_DEVICE /dev/mtdblock0
EOF

}

do_compile:forecr-dsb-ornx-orin-nano-8gb() {
        cat > ${B}/nv_boot_control.conf <<EOF
TNSPEC 3767-300-0003-K.2-1-1-jetson-orin-nano-devkit-
COMPATIBLE_SPEC 3767--0005--1--jetson-orin-nano-devkit-
TEGRA_LEGACY_UPDATE true
TEGRA_BOOT_STORAGE nvme0n1
TEGRA_EMMC_ONLY false
TEGRA_CHIPID 0x23
TEGRA_OTA_BOOT_DEVICE /dev/mtdblock0
TEGRA_OTA_GPT_DEVICE /dev/mtdblock0
EOF

}

do_compile:forecr-dsb-ornx-orin-nx-16gb() {
        cat > ${B}/nv_boot_control.conf <<EOF
TNSPEC 3767-300-0000-A.3-1-1-jetson-orin-nx-devkit-
COMPATIBLE_SPEC 3767--0000--1--jetson-orin-nx-devkit-
TEGRA_LEGACY_UPDATE true
TEGRA_BOOT_STORAGE nvme0n1
TEGRA_EMMC_ONLY false
TEGRA_CHIPID 0x23
TEGRA_OTA_BOOT_DEVICE /dev/mtdblock0
TEGRA_OTA_GPT_DEVICE /dev/mtdblock0
EOF

}

do_compile:forecr-dsb-ornx-orin-nano-4gb() {
        cat > ${B}/nv_boot_control.conf <<EOF
TNSPEC 3767-300-0004-K.2-1-1-jetson-orin-nano-devkit-
COMPATIBLE_SPEC 3767--0005--1--jetson-orin-nano-devkit-
TEGRA_LEGACY_UPDATE true
TEGRA_BOOT_STORAGE nvme0n1
TEGRA_EMMC_ONLY false
TEGRA_CHIPID 0x23
TEGRA_OTA_BOOT_DEVICE /dev/mtdblock0
TEGRA_OTA_GPT_DEVICE /dev/mtdblock0
EOF

}

do_compile:jetson-agx-orin-devkit-64gb() {
        cat > ${B}/nv_boot_control.conf <<EOF
TNSPEC 3701-500-0005-M.0-1-0-jetson-agx-orin-devkit-
COMPATIBLE_SPEC 3701--0005--1--jetson-agx-orin-devkit-
TEGRA_LEGACY_UPDATE true
TEGRA_EMMC_ONLY false
TEGRA_CHIPID 0x23
TEGRA_OTA_BOOT_DEVICE /dev/mtdblock0
TEGRA_OTA_GPT_DEVICE /dev/mtdblock0
EOF

}

do_install() {
	install -d ${D}${sysconfdir}
	install -m 0644 ${B}/nv_boot_control.conf ${D}${sysconfdir}/
}

PACKAGE_ARCH = "${MACHINE_ARCH}"
