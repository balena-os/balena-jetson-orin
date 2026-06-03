# Carve out sub-packages for the two binaries we need on the device without
# pulling in the full toolkit's RDEPENDS (docker, libnvidia-container-tools etc.;
# balenaOS uses balena-engine and we're CDI-only, no CSV-mode runtime).
#
#  - nvidia-cdi-hook : called by CDI specs' create-symlinks hook at container start
#  - nvidia-ctk      : run by the boot-time oneshot to generate /var/run/cdi/nvidia.yaml
PACKAGES =+ "${PN}-cdi-hook ${PN}-ctk"
FILES:${PN}-cdi-hook = "${bindir}/nvidia-cdi-hook"
FILES:${PN}-ctk = "${bindir}/nvidia-ctk"
RDEPENDS:${PN}-cdi-hook = ""
RDEPENDS:${PN}-ctk = ""

# Don't claim these in the parent package too.
FILES:${PN}:remove = "${bindir}/nvidia-cdi-hook ${bindir}/nvidia-ctk"

# Zero out the parent package's RDEPENDS — the original list points at
# libnvidia-container-tools / docker / etc., which we deliberately don't
# build. We only install the subpackages, never the parent.
RDEPENDS:${PN} = ""
