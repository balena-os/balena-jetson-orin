FILESEXTRAPATHS:append := ":${THISDIR}/files"

DEFAULT_DTB:jetson-orin-nano-devkit-nvme = "tegra234-p3768-0000+p3767-0005-nv-super.dtb"
DEFAULT_DTB:jetson-agx-orin-devkit = "tegra234-p3737-0000+p3701-0000-nv.dtb"
DEFAULT_DTB:jetson-orin-nx-xavier-nx-devkit = "tegra234-p3768-0000+p3767-0000-nv-super.dtb"
DEFAULT_DTB:jetson-orin-nx-seeed-j4012 ="tegra234-p3768-0000+p3767-0000-nv.dtb"
DEFAULT_DTB:jetson-orin-nano-seeed-j3010 ="tegra234-p3768-0000+p3767-0004-nv-super.dtb"
DEFAULT_DTB:jetson-agx-orin-devkit-64gb = "tegra234-p3737-0000+p3701-0005-nv.dtb"
DEFAULT_DTB:forecr-dsb-ornx-orin-nano-8gb = "tegra234-p3768-0000+p3767-0003-nv-super.dtb"

replace_dtb_placeholder_in_source() {
    if [ -n "${DEFAULT_DTB}" ]; then
        bbnote "Surgically replacing @@DEFAULT_DTB@@ placeholder in source files with ${DEFAULT_DTB}"

        # Scan the source trees safely, explicitly avoiding massive environment sysroots
        find ${S}/..  -type f \( -name "*.h" \) \
            -not -path "*/recipe-sysroot*" -not -path "*/.git/*" \
            -exec sed -i "s/@@DEFAULT_DTB@@/${DEFAULT_DTB}/g" {} + 2>/dev/null || true
    fi
}

SRC_URI:append = " \
    file://0001-Orin-Nano-Integrate-with-balenaOS-on-L4T-39.2.0.patch;patchdir=../edk2-nvidia \
    file://0002-Increase-max-bootchain-retry-so-that-it-does-not-int.patch;patchdir=../edk2-nvidia \
    file://0003-edk2-Disable-network-boot-and-allow-UEFI-capsule-dow.patch;patchdir=../edk2 \
"

do_deploy:append() {
    rm -rf ${DEPLOY_DIR_IMAGE}/bootfiles/EFI/BOOT || true
    mkdir -p ${DEPLOY_DIR_IMAGE}/bootfiles/EFI/BOOT/
    cp ${B}/images/BOOTAA64.efi ${DEPLOY_DIR_IMAGE}/bootfiles/EFI/BOOT/
}

do_deploy[nostamp] = "1"

# do_patch
do_patch[postfuncs] += "replace_dtb_placeholder_in_source"
do_patch[nostamp] = "1"
