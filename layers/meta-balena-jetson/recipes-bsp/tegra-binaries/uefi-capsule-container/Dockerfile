# This is the base image as the one
# used for building the UEFI firmware
FROM ghcr.io/tianocore/containers/ubuntu-22-dev:latest

ARG DEVICE_TYPE
ARG DEFAULT_DTB

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y git vim tar lbzip2 binutils xz-utils zstd sudo build-essential python3 python3-pip device-tree-compiler pkg-config && pip3 install --no-cache-dir cryptography pyelftools

COPY ./Jetson_Linux_R39.2.0_aarch64.tbz2 /build_dir/
COPY ./public_sources.tbz2 /build_dir/
COPY ./x-tools.tbz2 /build_dir/
COPY ./overlay_pcie.tbz2 /build_dir/

RUN cd /build_dir/ && tar xf Jetson_Linux_R39.2.0_aarch64.tbz2 && \
    ./Linux_for_Tegra/tools/l4t_flash_prerequisites.sh && mkdir -p /build_dir/Linux_for_Tegra/rootfs/boot/ && \
    mkdir -p /build_dir/Linux_for_Tegra/rootfs/usr/local/bin/ && \
    tar xf public_sources.tbz2 && \
    tar xf x-tools.tbz2 && \
    cp ./Linux_for_Tegra/source/nvidia-jetson-optee-source.tbz2 . && \
    tar xf nvidia-jetson-optee-source.tbz2 && \
    mkdir /build_dir/atf_build && \
    tar -xpf /build_dir/Linux_for_Tegra/source/atf_t234_src.tbz2 -C /build_dir/atf_build/ && \
    tar -xpf /build_dir/overlay_pcie.tbz2 -C /build_dir/ && \
    cp -r /build_dir/overlay_pcie/Linux_for_Tegra/bootloader/*.bin /build_dir/Linux_for_Tegra/bootloader/

COPY ./build.sh /build_dir/build.sh
COPY ./jetson_board_spec.cfg /build_dir/Linux_for_Tegra/yocto_jetson_board_spec.cfg
COPY ./uefi_t23x_general.bin /build_dir/Linux_for_Tegra/bootloader/uefi_bins/yocto_uefi_t23x_general.bin
COPY ./standalone_mm_optee.bin /build_dir/Linux_for_Tegra/bootloader/yocto_standalone_mm_optee.bin

COPY ./custom_dtbs.tar.gz /build_dir/Linux_for_Tegra/

ENV CROSS_COMPILE_AARCH64_PATH=/build_dir/x-tools/aarch64-none-linux-gnu/
ENV CROSS_COMPILE_AARCH64=/build_dir/x-tools/aarch64-none-linux-gnu/bin/aarch64-none-linux-gnu-
ENV UEFI_STMM_PATH=/build_dir/Linux_for_Tegra/bootloader/standalonemm_optee_t234.bin
ENV NV_TARGET_BOARD=generic
ENV PKG_CONFIG=/usr/bin/pkg-config

CMD ["bash"]
