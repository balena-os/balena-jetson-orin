#!/bin/bash

# This script patches the official EDK2 sources
# from github with balenaOS specific changes
# and then builds the UEFI firmware and bootloader

set -e

declare -A device_specific_patches

orin_nano_generic_patch="0001-Orin-Nano-Integrate-with-balenaOS-on-L4T-36.4.patch"
device_specific_patches["jetson-agx-orin-devkit"]="0001-AGX-Orin-32GB-Integrate-with-balenaOS-on-L4T-36.4.patch"
device_specific_patches["jetson-orin-nano-devkit-nvme"]="$orin_nano_generic_patch"
device_specific_patches["jetson-orin-nx-xavier-nx-devkit"]="0001-Orin-NX-16GB-Integrate-with-balenaOS-on-L4T-36.4.patch"
device_specific_patches["jetson-orin-nx-seeed-j4012"]="$orin_nano_generic_patch"
device_specific_patches["jetson-orin-nano-seeed-j3010"]="$orin_nano_generic_patch"
device_specific_patches["jetson-agx-orin-devkit-64gb"]="0001-AGX-Orin-64GB-Integrate-with-balenaOS-on-L4T-36.4.patch"
device_specific_patches["forecr-dsb-ornx-orin-nano-8gb"]="$orin_nano_generic_patch"

edk2_patch="0001-edk2-Disable-network-boot-and-allow-UEFI-capsule-dow.patch"
edk2_nvidia_patches=( "0001-edk2-nvidia-Add-changes-for-balenaOS-integration.patch " \
	"0001-edk2-nvidia-Remove-pva-fw-from-required-list.patch" \
	"0001-StandaloneMmOptee-Don-t-assert-if-var-store-integrit.patch" )

if [[ "${DEVICE_TYPE}" == "jetson-agx-orin-devkit-64gb" ]]; then
    echo "Applying edk2-nvidia jetson-agx-orin-devkit-64gb NewDeviceHierarchy override patch"
    edk2_nvidia_patches+=("0001-TegraPlatformBootManager-TegraPlatformBootManagerDxe.patch")
fi	

cd /build/nvidia-uefi/edk2 && \
    git reset --hard HEAD && \
    git apply ${edk2_patch} && \
    cd /build/nvidia-uefi/edk2-nvidia && \
    git reset --hard HEAD && \
    for edk2_nvidia_patch in ${edk2_nvidia_patches[@]}
    do
        git apply "${edk2_nvidia_patch}" ;
     	echo "Applied ${edk2_nvidia_patch}"
    done

    echo "Device type is ${DEVICE_TYPE}"
    for device_type_i in ${!device_specific_patches[@]}
    do
        if [[ "${DEVICE_TYPE}" == "${device_type_i}" ]]; then
            echo "Setting device-tree name to ${DEFAULT_DTB} in ${device_specific_patches[${DEVICE_TYPE}]}"
            sed -i "s/@@DEFAULT_DTB@@/${DEFAULT_DTB}/g" ${device_specific_patches[${DEVICE_TYPE}]}
            echo "Applying ${device_specific_patches[${DEVICE_TYPE}]} for ${DEVICE_TYPE}"
            git apply ${device_specific_patches[${DEVICE_TYPE}]}
	fi
    done

# Trigger firmware and bootloader build, that is uefi_jetson.bin
# and BOOTAA64.efi
/build/nvidia-uefi/edk2-nvidia/Platform/NVIDIA/Jetson/build.sh
