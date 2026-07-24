# This is the base image as the one
# used for building the UEFI firmware
FROM ghcr.io/tianocore/containers/ubuntu-22-dev:latest

ARG DEVICE_TYPE
ARG DEFAULT_DTB

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y git vim tar lbzip2 binutils xz-utils zstd sudo build-essential python3 python3-pip device-tree-compiler && pip3 install --no-cache-dir cryptography pyelftools

COPY ./Jetson_Linux_r36.5.0_aarch64.tbz2 /build_dir/
COPY ./public_sources.tbz2 /build_dir/
COPY ./aarch64--glibc--stable-2022.08-1.tar.bz2 /build_dir/

RUN cd /build_dir/ && tar xf Jetson_Linux_r36.5.0_aarch64.tbz2 && \
    ./Linux_for_Tegra/tools/l4t_flash_prerequisites.sh && mkdir -p /build_dir/Linux_for_Tegra/rootfs/boot/ && mkdir -p /build_dir/Linux_for_Tegra/rootfs/usr/local/bin/ && \
    tar xf public_sources.tbz2 && \
    tar xf aarch64--glibc--stable-2022.08-1.tar.bz2 && \
    cp ./Linux_for_Tegra/source/nvidia-jetson-optee-source.tbz2 . && \
    tar xf nvidia-jetson-optee-source.tbz2 && \
    mkdir /build_dir/atf_build && \
    tar -xf /build_dir/Linux_for_Tegra/source/atf_src.tbz2 -C /build_dir/atf_build/

COPY ./build.sh /build_dir/build.sh
COPY ./uefi_jetson.bin /build_dir/Linux_for_Tegra/bootloader/yocto_uefi_jetson.bin
COPY ./jetson_board_spec.cfg /build_dir/Linux_for_Tegra/yocto_jetson_board_spec.cfg
COPY ./standalone_mm_optee.bin /build_dir/yocto_standalone_mm_optee.bin

ENV CROSS_COMPILE_AARCH64_PATH=/build_dir/aarch64--glibc--stable-2022.08-1
ENV CROSS_COMPILE_AARCH64=/build_dir/aarch64--glibc--stable-2022.08-1/bin/aarch64-buildroot-linux-gnu-
ENV UEFI_STMM_PATH=/build_dir/Linux_for_Tegra/bootloader/standalonemm_optee_t234.bin
ENV NV_TARGET_BOARD=generic

CMD ["bash"]
