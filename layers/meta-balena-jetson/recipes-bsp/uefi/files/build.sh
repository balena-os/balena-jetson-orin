#!/bin/bash

cd /build/nvidia-uefi/edk2 && \
    git reset --hard HEAD && \
    git apply 0001-edk2-Disable-network-boot-and-allow-UEFI-capsule-dow.patch && \
    cd /build/nvidia-uefi/edk2-nvidia && \
    git reset --hard HEAD && \
    git apply 0001-edk2-nvidia-Add-changes-for-balenaOS-integration.patch && \
    git apply 0001-edk2-nvidia-Remove-pva-fw-from-required-list.patch && \
    git apply 0001-feat-add-a-null-version-of-the-FwVariableLib.patch && \
    git apply 0002-fix-don-t-try-to-erase-early-vars-partition-in-Jetso.patch && \
    git apply 0003-fix-reset-the-meas-buffer-after-computing-the-first-.patch && \
    git apply 0001-StandaloneMmOptee-Don-t-assert-if-var-store-integrit.patch && \
    echo "Device type is ${DEVICE_TYPE}" && \
    /bin/bash -c 'if [[ "${DEVICE_TYPE}" == "jetson-agx-orin-devkit" ]]; then \
        git apply 0001-AGX-Orin-32GB-Integrate-with-balenaOS-on-L4T-36.3.patch && echo "Applied Jetson AGX Orin 32GB balenaOS integration patch" ; \
    elif [[ "${DEVICE_TYPE}" == "jetson-orin-nano-devkit-nvme" ]]; then \
        git apply 0001-Orin-Nano-Integrate-with-balenaOS-on-L4T-36.3.patch && echo "Applied Orin Nano Devkit NVME balenaOS integration patch" ; \
    elif [[ "${DEVICE_TYPE}" == "jetson-orin-nx-xavier-nx-devkit-nvme" ]]; then \
        git apply edk2-nvidia/0001-Orin-NX-16GB-Integrate-with-balenaOS-on-L4T-36.3.patch && echo "Applied Orin NX in Xavier NX Devkit NVME balenaOS integration patch" ; \
    elif [[ "${DEVICE_TYPE}" == "jetson-orin-nx-seeed-j4012" ]]; then \
        git apply edk2-nvidia/0001-Seeed-J4012-Integrate-with-balenaOS-on-L4T-36.3.patch && echo "Applied Seeed J4012 integration patch" ; \
    elif [[ "${DEVICE_TYPE}" == "jetson-orin-nx-seeed-j3010" ]]; then \
        git apply edk2-nvidia/0001-Seeed-J3010-Integrate-with-balenaOS-on-L4T-36.3.patch && echo "Applied Seeed J3010 integration patch" ; \
    fi; '

# trigger firmware and bootloader build
/build/nvidia-uefi/edk2-nvidia/Platform/NVIDIA/Jetson/build.sh

