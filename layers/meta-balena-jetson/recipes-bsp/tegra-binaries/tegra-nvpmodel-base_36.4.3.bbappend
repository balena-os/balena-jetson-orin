# By default, starting with L4T 36.4.3 we switch
# the default power mode from BSP's default 25W to 15W, which was
# the previous BSP's default for the Orin Nano 8GB.
#
# See internal discussion: https://balena.fibery.io/Work/Improvement/Preserve-previous-JP6.0-default-power-modes-2674
NVPMODEL_CONFIG_DEFAULT:jetson-orin-nano-devkit-nvme="0"

# Orin Nano 4GB module - keep 10W as default
NVPMODEL_CONFIG_DEFAULT:jetson-orin-nano-seeed-j3010="0"

# Orin NX 16GB - keep 15W
NVPMODEL_CONFIG_DEFAULT:jetson-orin-nx-xavier-nx-devkit="2"

# AGX Orin 32GB & 64GB default power modes are the same in JP6.0 and 6.2,
# hence no default needs to be set
