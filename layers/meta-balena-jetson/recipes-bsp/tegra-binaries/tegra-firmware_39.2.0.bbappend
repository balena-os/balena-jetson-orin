DEPENDS += "xz-native"

# Cleanup unused firmware
do_install:append() {
    # Remove Thor GPU microcode directory (~1.5 MB)
    if [ -d "${D}/usr/lib/firmware/nvidia/gb10b" ]; then
        rm -rf "${D}/usr/lib/firmware/nvidia/gb10b"
    fi

    # Remove Thor firmware
    if [ -d "${D}/usr/lib/firmware/nvidia/tegra264" ]; then
        rm -rf "${D}/usr/lib/firmware/nvidia/tegra264"
    fi

    if [ -f "${D}/usr/lib/firmware/display-t264-dce.bin" ]; then
        rm -f "${D}/usr/lib/firmware/display-t264-dce.bin"
    fi

    # Remove 72.MB of desktop firmware
    if [ -d "${D}/usr/lib/firmware/nvidia/595.78" ]; then
        bbnote "Deleting completely unused desktop GSP firmware directory (~72.8 MB raw)..."
        rm -rf "${D}/usr/lib/firmware/nvidia/595.78"
    fi
}
