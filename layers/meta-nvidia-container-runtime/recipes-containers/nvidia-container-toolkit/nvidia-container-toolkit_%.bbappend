# Deltas on meta-tegra's nvidia-container-toolkit recipe, which conf/layer.conf
# makes visible. See docs/toolkit.md.

# balenaOS ships balena-engine, not upstream docker, so meta-tegra's `docker`
# runtime dep is unsatisfiable here and blocks IMAGE_INSTALL from resolving.
RDEPENDS:${PN}:remove = "docker"

# go.mod requires Go >= 1.25.0, above the build's 1.24.6. Compile with the
# private toolchain instead of go-cross and go-runtime. Upstream Go cross-compiles
# the standard library itself. See docs/toolkit.md#go-toolchain.
DEPENDS_GOLANG:class-target = "nvruntime-go-native"
GOROOT = "${STAGING_LIBDIR_NATIVE}/${NVRUNTIME_GOROOT_DIR}"
GO = "${GOROOT}/bin/go"
GOTOOLDIR = "${GOROOT}/pkg/tool/${BUILD_GOTUPLE}"
# Never fetch a different toolchain at build time.
export GOTOOLCHAIN = "local"

# The version follows the device repo's meta-tegra pin, so a bump could walk us
# backwards onto a vulnerable toolkit. See docs/toolkit.md#cve-floor.
NVRUNTIME_TOOLKIT_MIN_VERSION = "1.19.1"

python () {
    pv = d.getVar('PV')
    floor = d.getVar('NVRUNTIME_TOOLKIT_MIN_VERSION')
    if bb.utils.vercmp_string(pv, floor) < 0:
        bb.fatal(
            "nvidia-container-toolkit %s is below the %s CVE floor "
            "(see docs/toolkit.md#cve-floor). The version comes from the "
            "device repo's meta-tegra pin - move meta-tegra forward rather "
            "than lowering this floor."
            % (pv, floor))
}
