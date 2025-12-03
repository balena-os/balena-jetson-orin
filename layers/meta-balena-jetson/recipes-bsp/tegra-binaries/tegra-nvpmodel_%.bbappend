FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

# Disable nvpmodel service for Seeed J3010 as it causes boot hangs
# when trying to set NVMe bandwidth on incompatible configurations
SYSTEMD_AUTO_ENABLE:${PN}:jetson-orin-nano-seeed-j3010 = "disable"
