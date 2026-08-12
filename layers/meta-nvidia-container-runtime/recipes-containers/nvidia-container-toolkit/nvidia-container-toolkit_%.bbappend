# Deltas on meta-tegra's nvidia-container-toolkit recipe, which conf/layer.conf
# makes visible. See docs/toolkit.md.

# balenaOS ships balena-engine, not upstream docker, so meta-tegra's `docker`
# runtime dep is unsatisfiable here and blocks IMAGE_INSTALL from resolving.
RDEPENDS:${PN}:remove = "docker"

# The version follows the device repo's meta-tegra pin, so a bump could walk us
# backwards onto a vulnerable nvidia-container-cli. See docs/toolkit.md#cve-floor.
NVRUNTIME_TOOLKIT_MIN_VERSION = "1.17.8"

python () {
    pv = d.getVar('PV')
    floor = d.getVar('NVRUNTIME_TOOLKIT_MIN_VERSION')
    if bb.utils.vercmp_string(pv, floor) < 0:
        bb.fatal(
            "nvidia-container-toolkit %s is below the %s CVE floor "
            "(CVE-2024-0132, CVE-2025-23359, CVE-2025-23266/23267 all affect the "
            "nvidia-container-cli path this extension's --runtime=nvidia route "
            "uses). The version comes from the device repo's meta-tegra pin - "
            "move meta-tegra forward rather than lowering this floor."
            % (pv, floor))
}
