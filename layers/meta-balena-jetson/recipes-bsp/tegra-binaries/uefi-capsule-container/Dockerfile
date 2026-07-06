# This is the base image as the one
# used for building the UEFI firmware
FROM ghcr.io/tianocore/containers/ubuntu-22-dev:latest

ARG DEVICE_TYPE
ARG DEFAULT_DTB

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y git vim tar lbzip2 binutils xz-utils zstd sudo device-tree-compiler

COPY ./Jetson_Linux_R39.2.0_aarch64.tbz2 /build_dir/

RUN cd /build_dir/ && tar xf Jetson_Linux_R39.2.0_aarch64.tbz2 && \
    ./Linux_for_Tegra/tools/l4t_flash_prerequisites.sh && mkdir -p /build_dir/Linux_for_Tegra/rootfs/boot/ && \
    mkdir -p /build_dir/Linux_for_Tegra/rootfs/usr/local/bin/

# BalenaOS uses a different mechanism for A/B rootfs selection,
# so the RootfsRetryCountMax variable can be used by the OS
# to determine if the UEFI capsule has been applied successfully.
RUN cd /build_dir/Linux_for_Tegra/ && dtc -I dtb -O dts ./kernel/dtb/L4TConfiguration.dtbo -o ./kernel/dtb/L4TConfiguration.dts && \
    sed -i '/RootfsRetryCountMax/,/};/ s/0x3000000/0x9000000/' ./kernel/dtb/L4TConfiguration.dts && \
    dtc -I dts -O dtb ./kernel/dtb/L4TConfiguration.dts -o ./kernel/dtb/L4TConfiguration.dtbo

COPY ./build.sh /build_dir/build.sh

COPY ./uefi_t26x_general.bin /build_dir/Linux_for_Tegra/bootloader/uefi_bins/
COPY ./standalonemm_jetson.pkg /build_dir/Linux_for_Tegra/bootloader/standalonemm_jetson.pkg

CMD ["bash"]
