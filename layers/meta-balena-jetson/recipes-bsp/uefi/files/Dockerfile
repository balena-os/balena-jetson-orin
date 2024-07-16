FROM ghcr.io/tianocore/containers/ubuntu-22-dev:latest

ARG DEVICE_TYPE

RUN apt-get update && apt-get install git vim && \
    mkdir build && cd build && \
    edkrepo manifest-repos add nvidia https://github.com/NVIDIA/edk2-edkrepo-manifest.git main nvidia && \
    edkrepo clone nvidia-uefi NVIDIA-Platforms r36.3.0-updates

# We created this dockerfile and the corresponding build script using the
# edk2 container build documentation available at https://github.com/NVIDIA/edk2-nvidia/wiki/Build-with-docker

# We use the txt extension to avoid Yocto trying to apply
# patches to inexistent sources, which are actually downloaded
# in our container. We use the container for downloading sources
# because the scripts are made to work with the edk2 base image
COPY ./0001-edk2-nvidia-Add-changes-for-balenaOS-integration_patch.txt /build/nvidia-uefi/edk2-nvidia/0001-edk2-nvidia-Add-changes-for-balenaOS-integration.patch
COPY ./0001-edk2-Disable-network-boot-and-allow-UEFI-capsule-dow_patch.txt /build/nvidia-uefi/edk2/0001-edk2-Disable-network-boot-and-allow-UEFI-capsule-dow.patch
COPY ./0001-AGX-Orin-32GB-Integrate-with-balenaOS-on-L4T-36.3_patch.txt /build/nvidia-uefi/edk2-nvidia/0001-AGX-Orin-32GB-Integrate-with-balenaOS-on-L4T-36.3.patch
COPY ./0001-Orin-Nano-Integrate-with-balenaOS-on-L4T-36.3_patch.txt /build/nvidia-uefi/edk2-nvidia/0001-Orin-Nano-Integrate-with-balenaOS-on-L4T-36.3.patch
COPY ./0001-Orin-NX-16GB-Integrate-with-balenaOS-on-L4T-36.3_patch.txt /build/nvidia-uefi/edk2-nvidia/0001-Orin-NX-16GB-Integrate-with-balenaOS-on-L4T-36.3.patch
COPY ./0001-Seeed-J4012-Integrate-with-balenaOS-on-L4T-36.3_patch.txt /build/nvidia-uefi/edk2-nvidia/0001-Seeed-J4012-Integrate-with-balenaOS-on-L4T-36.3.patch
COPY ./0001-Seeed-J3010-Integrate-with-balenaOS-on-L4T-36.3_patch.txt /build/nvidia-uefi/edk2-nvidia/0001-Seeed-J3010-Integrate-with-balenaOS-on-L4T-36.3.patch
COPY ./0001-edk2-nvidia-Remove-pva-fw-from-required-list_patch.txt /build/nvidia-uefi/edk2-nvidia/0001-edk2-nvidia-Remove-pva-fw-from-required-list.patch

# We keep the reference to the patch below, but don't use it right now because the tos-optee built using the public atf & optee sources
# using the standalone_optee binary generated here crashes. See https://forums.developer.nvidia.com/t/jetson-orin-nano-ota-35-5-0-36-3-failed-to-boot-after-ota-upgrade-from-35-5-0-to-36-3/296205/16
#COPY ./0001-StandaloneMmOptee-Don-t-assert-if-var-store-integrit_patch.txt /build/nvidia-uefi/edk2-nvidia/0001-StandaloneMmOptee-Don-t-assert-if-var-store-integrit.patch
COPY ./build.sh /build/build.sh

CMD ["bash"]
