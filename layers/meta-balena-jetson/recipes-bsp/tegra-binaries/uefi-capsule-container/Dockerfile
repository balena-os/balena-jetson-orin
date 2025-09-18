# This is the base image as the one
# used for building the UEFI firmware
FROM ghcr.io/tianocore/containers/ubuntu-22-dev:latest

ARG DEVICE_TYPE
ARG DEFAULT_DTB

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y git vim tar sudo && \
    mkdir -p /build_dir/Seeed_36_4_3

COPY ./bsp_dir.tar.gz /build_dir/

RUN cd /build_dir/ && tar xf bsp_dir.tar.gz && ./Linux_for_Tegra/tools/l4t_flash_prerequisites.sh && \
    cd Seeed_36_4_3/ && git clone https://github.com/Seeed-Studio/Linux_for_Tegra.git -b r36.4.3 --single-branch

COPY ./build.sh /build_dir/build.sh
COPY ./uefi_jetson.bin /build_dir/Linux_for_Tegra/bootloader/
COPY ./jetson_board_spec.cfg /build_dir/Linux_for_Tegra/

CMD ["bash"]
