# TEMPORARY. libgstnvarguscamerasrc.so links against libnvmm_jpeg.so, which
# meta-tegra ships but omits from drivers.csv, so nvarguscamerasrc cannot load in
# any container. Drop this bbappend once the entry lands upstream.
#
# Appended at do_install rather than patched into the source CSV, so re-syncing
# with meta-tegra needs no patch refresh. See docs/toolkit.md for why a sibling
# CSV cannot be used instead (mount-spec-path is not globbed).

NVRUNTIME_MISSING_CSV_ENTRY = "lib, /usr/lib/libnvmm_jpeg.so"

do_install:append() {
    csv="${D}${sysconfdir}/nvidia-container-runtime/host-files-for-container.d/drivers.csv"
    if [ ! -f "$csv" ]; then
        bbfatal "tegra-configs: expected drivers.csv at $csv - has meta-tegra moved it?"
    fi
    if grep -q "libnvmm_jpeg" "$csv"; then
        bbnote "tegra-configs: libnvmm_jpeg.so already in drivers.csv - drop this bbappend"
    else
        echo "${NVRUNTIME_MISSING_CSV_ENTRY}" >> "$csv"
        bbnote "tegra-configs: added libnvmm_jpeg.so to drivers.csv"
    fi
}
