# write internal balenaOS image to the NVME
INTERNAL_DEVICE_KERNEL = "nvme0n1"

# or to the eMMC, in the case of the Xavier AGX
INTERNAL_DEVICE_KERNEL:jetson-xavier = "mmcblk0"
