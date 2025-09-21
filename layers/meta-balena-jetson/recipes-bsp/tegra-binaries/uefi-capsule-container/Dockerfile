# This is the base image as the one
# used for building the UEFI firmware
FROM ghcr.io/tianocore/containers/ubuntu-22-dev:latest

ARG DEVICE_TYPE
ARG DEFAULT_DTB

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y git vim tar lbzip2 binutils xz-utils zstd sudo

COPY ./Jetson_Linux_r36.4.3_aarch64.tbz2 /build_dir/

RUN cd /build_dir/ && tar xf Jetson_Linux_r36.4.3_aarch64.tbz2 && ./Linux_for_Tegra/tools/l4t_flash_prerequisites.sh && mkdir -p /build_dir/Linux_for_Tegra/rootfs/boot/ && mkdir -p /build_dir/Linux_for_Tegra/rootfs/usr/local/bin/

COPY ./build.sh /build_dir/build.sh
COPY ./uefi_jetson.bin /build_dir/Linux_for_Tegra/bootloader/
COPY ./jetson_board_spec.cfg /build_dir/Linux_for_Tegra/

CMD ["bash"]
