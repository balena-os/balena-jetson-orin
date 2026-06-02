# Carve out a CDI-hook-only sub-package so we can install nvidia-cdi-hook
# without pulling in the full toolkit's docker/libnvidia-container-tools
# RDEPENDS (balenaOS uses balena-engine, not docker; libnvidia-container
# lives in a sibling meta-tegra/external recipe we don't include).
PACKAGES =+ "${PN}-cdi-hook"
FILES:${PN}-cdi-hook = "${bindir}/nvidia-cdi-hook"
RDEPENDS:${PN}-cdi-hook = ""

# Don't claim the binary in the parent package too.
FILES:${PN}:remove = "${bindir}/nvidia-cdi-hook"

# Zero out the parent package's RDEPENDS — bitbake otherwise tries to
# resolve them while building this recipe (even though we only install
# the -cdi-hook subpackage). The original RDEPENDS are for the CSV-mode
# runtime (nvidia-container-runtime-hook), not for nvidia-cdi-hook.
RDEPENDS:${PN} = ""
