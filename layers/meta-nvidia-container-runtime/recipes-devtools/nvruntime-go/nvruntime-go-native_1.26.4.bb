# Upstream Go for nvidia-container-toolkit alone. meta-balena pins the build's
# Go to 1.24.6 for the base OS; the toolkit needs >= 1.25.0. Reuses oe-core's
# recipe for the source and checksums, but provides nothing and stages under its
# own directory, so the build's Go selection is unchanged.
# See docs/toolkit.md#go-toolchain.
require recipes-devtools/go/go-binary-native_${PV}.bb

SUMMARY = "Go compiler for nvidia-container-toolkit (upstream binary)"
PROVIDES = ""

do_install() {
    find ${S} -depth -type d -name testdata -exec rm -rf {} +
    install -d ${D}${libdir}/${NVRUNTIME_GOROOT_DIR}
    cp --preserve=mode,timestamps -R ${S}/. ${D}${libdir}/${NVRUNTIME_GOROOT_DIR}/
}
