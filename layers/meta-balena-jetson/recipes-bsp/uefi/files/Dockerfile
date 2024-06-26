FROM ghcr.io/tianocore/containers/ubuntu-22-dev:latest

RUN apt-get update && apt-get install git vim

ARG DEVICE_TYPE

RUN mkdir build && cd build && \
    edkrepo manifest-repos add nvidia https://github.com/NVIDIA/edk2-edkrepo-manifest.git main nvidia && \
    edkrepo clone nvidia-uefi NVIDIA-Platforms r36.3.0-updates

# We use the txt extension to avoid Yocto trying to apply
# patches to inexistent sources.
COPY ./0001-edk2-nvidia-Add-changes-for-balenaOS-integration_patch.txt /build/nvidia-uefi/edk2-nvidia/0001-edk2-nvidia-Add-changes-for-balenaOS-integration.patch
COPY ./0001-edk2-Disable-network-boot-and-allow-UEFI-capsule-dow_patch.txt /build/nvidia-uefi/edk2/0001-edk2-Disable-network-boot-and-allow-UEFI-capsule-dow.patch
COPY ./0001-AGX-Orin-32GB-Integrate-with-balenaOS-on-L4T-36.3_patch.txt /build/nvidia-uefi/edk2-nvidia/0001-AGX-Orin-32GB-Integrate-with-balenaOS-on-L4T-36.3.patch
COPY ./0001-Orin-Nano-Integrate-with-balenaOS-on-L4T-36.3_patch.txt /build/nvidia-uefi/edk2-nvidia/0001-Orin-Nano-Integrate-with-balenaOS-on-L4T-36.3.patch
COPY ./0001-Orin-NX-16GB-Integrate-with-balenaOS-on-L4T-36.3_patch.txt /build/nvidia-uefi/edk2-nvidia/0001-Orin-NX-16GB-Integrate-with-balenaOS-on-L4T-36.3.patch
COPY ./0001-Seeed-J4012-Integrate-with-balenaOS-on-L4T-36.3_patch.txt /build/nvidia-uefi/edk2-nvidia/0001-Seeed-J4012-Integrate-with-balenaOS-on-L4T-36.3.patch
COPY ./0001-Seeed-J3010-Integrate-with-balenaOS-on-L4T-36.3_patch.txt /build/nvidia-uefi/edk2-nvidia/0001-Seeed-J3010-Integrate-with-balenaOS-on-L4T-36.3.patch
COPY ./0001-edk2-nvidia-Remove-pva-fw-from-required-list_patch.txt /build/nvidia-uefi/edk2-nvidia/0001-edk2-nvidia-Remove-pva-fw-from-required-list.patch
COPY ./0001-feat-add-a-null-version-of-the-FwVariableLib_patch.txt /build/nvidia-uefi/edk2-nvidia/0001-feat-add-a-null-version-of-the-FwVariableLib.patch
COPY ./0002-fix-don-t-try-to-erase-early-vars-partition-in-Jetso_patch.txt /build/nvidia-uefi/edk2-nvidia/0002-fix-don-t-try-to-erase-early-vars-partition-in-Jetso.patch
COPY ./0003-fix-reset-the-meas-buffer-after-computing-the-first-_patch.txt /build/nvidia-uefi/edk2-nvidia/0003-fix-reset-the-meas-buffer-after-computing-the-first-.patch
#COPY ./0001-StandaloneMmOptee-Don-t-assert-if-var-store-integrit_patch.txt /build/nvidia-uefi/edk2-nvidia/0001-StandaloneMmOptee-Don-t-assert-if-var-store-integrit.patch
COPY ./build.sh /build/build.sh

RUN /build/nvidia-uefi/edk2-nvidia/Platform/NVIDIA/Jetson/build.sh

CMD ["bash"]
