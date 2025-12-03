FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

# Disable nvpower service for Seeed J3010 as it causes nvidia-nvme-set errors
# and boot hangs when trying to set NVMe bandwidth
SYSTEMD_AUTO_ENABLE:${PN}:jetson-orin-nano-seeed-j3010 = "disable"
