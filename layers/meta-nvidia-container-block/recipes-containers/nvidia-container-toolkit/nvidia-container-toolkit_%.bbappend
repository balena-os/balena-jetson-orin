# meta-tegra's nvidia-container-toolkit recipe sets:
#   RDEPENDS:${PN} = "libnvidia-container-tools docker nv-tegra-release \
#                     tegra-configs-container-csv tegra-libraries-nvml \
#                     tegra-container-passthrough"
# The `docker` runtime dep is wrong for us — balenaOS ships balena-engine,
# not upstream docker. Without this strip, adding nvidia-container-toolkit to
# IMAGE_INSTALL fails to resolve. The toolkit itself just needs an OCI engine
# at runtime; balena-engine satisfies that.
RDEPENDS:${PN}:remove = "docker"
