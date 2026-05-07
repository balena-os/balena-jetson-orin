FROM ghcr.io/tianocore/containers/ubuntu-22-dev:latest

ARG DEVICE_TYPE
ARG DEFAULT_DTB

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y git vim && \
    mkdir build && cd build && \
    edkrepo manifest-repos add nvidia https://github.com/NVIDIA/edk2-edkrepo-manifest.git main nvidia && \
    edkrepo clone nvidia-uefi NVIDIA-Platforms r36.5-updates

# Work around edkrepo clone failure - upstream ticket in edk2-nvidia/issues/160 -
# by cloning r36.5-updates and then checking out r36.4.4. This because the r36.5-updates
# branch includes the updated mirror for the Subhook submodule from edk2
RUN cd /build/nvidia-uefi && \
    cd edk2 && git checkout r36.4.4-updates && git submodule update --init --recursive && \
    cd ../edk2-non-osi/ && git checkout r36.4.4-updates && \
    cd ../edk2-platforms/ && git checkout r36.4.4-updates && \
    cd ../edk2-nvidia/ && git checkout r36.4.4-updates && \
    cd ../edk2-nvidia-non-osi/ && git checkout r36.4.4-updates && \
    cd ../ && mkdir edk2-nvidia-server-gpu-sdk && cd edk2-nvidia-server-gpu-sdk && \
    git clone https://github.com/NVIDIA/open-gpu-kernel-modules.git && cd open-gpu-kernel-modules && git checkout "525.78.01"

# We created this dockerfile and the corresponding build script using the
# edk2 container build documentation available at https://github.com/NVIDIA/edk2-nvidia/wiki/Build-with-docker

# We use the txt extension to avoid Yocto trying to apply
# patches to inexistent sources, which are actually downloaded
# in our container. We use the container for downloading sources
# because the scripts are made to work with the edk2 base image

# Device-specific patches
COPY ./0001-AGX-Orin-32GB-Integrate-with-balenaOS-on-L4T-36.4_patch.txt /build/nvidia-uefi/edk2-nvidia/0001-AGX-Orin-32GB-Integrate-with-balenaOS-on-L4T-36.4.patch
COPY ./0001-Orin-Nano-Integrate-with-balenaOS-on-L4T-36.4_patch.txt /build/nvidia-uefi/edk2-nvidia/0001-Orin-Nano-Integrate-with-balenaOS-on-L4T-36.4.patch
COPY ./0001-Orin-NX-16GB-Integrate-with-balenaOS-on-L4T-36.4_patch.txt /build/nvidia-uefi/edk2-nvidia/0001-Orin-NX-16GB-Integrate-with-balenaOS-on-L4T-36.4.patch
COPY ./0001-AGX-Orin-64GB-Integrate-with-balenaOS-on-L4T-36.4_patch.txt /build/nvidia-uefi/edk2-nvidia/0001-AGX-Orin-64GB-Integrate-with-balenaOS-on-L4T-36.4.patch

# Generic patches
COPY ./0001-edk2-nvidia-Add-changes-for-balenaOS-integration_patch.txt /build/nvidia-uefi/edk2-nvidia/0001-edk2-nvidia-Add-changes-for-balenaOS-integration.patch
COPY ./0001-edk2-Disable-network-boot-and-allow-UEFI-capsule-dow_patch.txt /build/nvidia-uefi/edk2/0001-edk2-Disable-network-boot-and-allow-UEFI-capsule-dow.patch
COPY ./0001-edk2-nvidia-Remove-pva-fw-from-required-list_patch.txt /build/nvidia-uefi/edk2-nvidia/0001-edk2-nvidia-Remove-pva-fw-from-required-list.patch
COPY ./0001-TegraPlatformBootManager-TegraPlatformBootManagerDxe_patch.txt build/nvidia-uefi/edk2-nvidia/0001-TegraPlatformBootManager-TegraPlatformBootManagerDxe.patch

# See https://forums.developer.nvidia.com/t/jetson-orin-nano-ota-35-5-0-36-3-failed-to-boot-after-ota-upgrade-from-35-5-0-to-36-3/296205/16
COPY ./0001-StandaloneMmOptee-Don-t-assert-if-var-store-integrit_patch.txt /build/nvidia-uefi/edk2-nvidia/0001-StandaloneMmOptee-Don-t-assert-if-var-store-integrit.patch
COPY ./build.sh /build/build.sh

CMD ["bash"]
