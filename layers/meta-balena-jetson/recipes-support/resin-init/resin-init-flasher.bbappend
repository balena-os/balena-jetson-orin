# write internal balenaOS image to the NVME for all Orin Devices,
# except for the AGX Orin 64GB
INTERNAL_DEVICE_KERNEL = "nvme0n1"
INTERNAL_DEVICE_KERNEL:jetson-agx-orin-devkit-64gb = "mmcblk0"
