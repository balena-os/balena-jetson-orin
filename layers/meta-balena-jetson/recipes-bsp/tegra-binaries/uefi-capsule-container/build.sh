#!/bin/bash

set -e

mb2_bct_paths=(
	"/build_dir/Linux_for_Tegra/bootloader/tegra234-mb2-bct-common.dtsi"
	"/build_dir/Linux_for_Tegra/bootloader/generic/BCT/tegra234-mb2-bct-misc-p3701-0002-p3740-0002.dts"
	"/build_dir/Linux_for_Tegra/bootloader/generic/BCT/tegra234-mb2-bct-misc-p3767-0000.dts"
	"/build_dir/Linux_for_Tegra/bootloader/generic/BCT/tegra234-mb2-bct-misc-p3701-0002-p3711-0000.dts"
	)

bl_spec="t23x_3767_bl_spec"
pushd /build_dir/Linux_for_Tegra/

ToT_BSP=$(pwd)

case "${DEVICE_TYPE}" in
	"jetson-agx-orin-devkit-64gb" | "jetson-agx-orin-devkit")
		bl_spec="t23x_agx_bl_spec"
		;;
	"jetson-orin-nano-seeed-j3010" | "jetson-orin-nx-seeed-j4012")
		mkdir -p /build_dir/Seeed_39_2_0
		pushd /build_dir/Seeed_39_2_0
		git clone https://github.com/Seeed-Studio/Linux_for_Tegra.git -b r39.2.0 --single-branch
		pushd Linux_for_Tegra
		# Latest revision as of July 13 2026
		git checkout 8fed53ebf5d9cde953de5bb4b9d951e5803da9c7
		popd
		popd
		cp -r /build_dir/Seeed_39_2_0/Linux_for_Tegra/* /build_dir/Linux_for_Tegra/
		cp p3768-0000-p3767-0000-a0.conf p3768-0000-p3767-0000-a0_original.conf

		# See: https://github.com/Seeed-Studio/wiki-documents/discussions/69#discussioncomment-17645607
		#if [[ "${DEVICE_TYPE}" = "jetson-orin-nx-seeed-j4012" ]]; then
		# J4012 Classic does not support the Super mode.
		# For J3010, as of today, mfi_recomputer-orin-nano-4g-j401-7.2.0-39.2.0-2026-06-18.tar.gz
		# does not come with super modem so we thus use the normal mode for now.
		    cat recomputer-orin-j401.conf > p3768-0000-p3767-0000-a0.conf
		#elif [[ "${DEVICE_TYPE}" = "jetson-orin-nano-seeed-j3010" ]]; then
		#	cat recomputer-orin-super-j401.conf > p3768-0000-p3767-0000-a0.conf
		#fi

		# This dtbo is referenced in recomputer-orin-j401.conf but it is not present in the BSP archive,
		# not is it built when creating the UEFI capsule. We comment it out so that the UEFI capsule build
		# doesn't fail
		#sed -i "s/tegra234-p3767-camera-p3768-imx219-dual-seeed.dtbo//g" p3768-0000-p3767-0000-a0.conf
		tar xf /build_dir/Linux_for_Tegra/custom_dtbs.tar.gz -C /build_dir/Linux_for_Tegra/
		echo "inspecting custom-dtbs"
		ls -l /build_dir/Linux_for_Tegra/custom_dtbs/
	        cp -r /build_dir/Linux_for_Tegra/custom_dtbs/* /build_dir/Linux_for_Tegra/bootloader/
		cp -r /build_dir/Linux_for_Tegra/custom_dtbs/* /build_dir/Linux_for_Tegra/kernel/dtb/

		# We only support Orin NX 16GB and Orin Nano 4GB on the Seeed boards and don't include the rest in the BUP creation. But we need to swap the dtb for the rest
		# to prevent the UEFI capsule creation from failing when it tries to copy the dtbs specified in the machine.conf
		sed -i 's/tegra234-j401-p3768-0000+p3767-0001-recomputer.dtb/tegra234-p3768-0000+p3767-0001-nv.dtb/g'  /build_dir/Linux_for_Tegra/p3768-0000-p3767-0000-a0.conf
		sed -i 's/tegra234-j401-p3768-0000+p3767-0003-recomputer.dtb/tegra234-p3768-0000+p3767-0003-nv.dtb/g'  /build_dir/Linux_for_Tegra/p3768-0000-p3767-0000-a0.conf
		sed -i 's/tegra234-j401-p3768-0000+p3767-0005-recomputer.dtb/tegra234-p3768-0000+p3767-0005-nv.dtb/g'  /build_dir/Linux_for_Tegra/p3768-0000-p3767-0000-a0.conf
		sed -i "s#p3768-0000-p3767-0000-a0.conf#p3768-0000-p3767-0000-a0_original.conf#g" /build_dir/Linux_for_Tegra/p3768-0000-p3767-0000-a0.conf
		;;
	"forecr-dsb-ornx-orin-nano-8gb")
	        wget https://github.com/forecr/dsboard_ornx_lan_orin_bsp/raw/ca120e8edea3a78505c0d42cc78b3f1502b59ab7/dsboard_ornx_lan_orin_nano_JP7_2_bsp.tar.xz -O /build_dir/dsboard_ornx_lan_orin_nano_JP7_2_bsp.tar.xz
		pushd /build_dir/
		tar xf dsboard_ornx_lan_orin_nano_JP7_2_bsp.tar.xz
		cp -r ./dsboard_ornx_lan_orin_nano_JP7_2_bsp/* .
		sudo ./replace_bsp_files.sh
		popd
		;;

	*)
	        :
		;;
esac

# Allow modules in carrier boards without an EEPROM
# to boot
for mb2_bct_path in "${mb2_bct_paths[@]}"; do
	sed -i "s#cvb_eeprom_read_size = <0x100>#cvb_eeprom_read_size = <0x0>#g" "${mb2_bct_path}"
done

sudo cp /build_dir/Linux_for_Tegra/bootloader/uefi_bins/yocto_uefi_t23x_general.bin /build_dir/Linux_for_Tegra/bootloader/uefi_bins/uefi_t23x_general.bin
sudo cp /build_dir/Linux_for_Tegra/bootloader/yocto_standalone_mm_optee.bin /build_dir/Linux_for_Tegra/bootloader/standalonemm_optee_t234.bin
sudo cp /build_dir/Linux_for_Tegra/yocto_jetson_board_spec.cfg /build_dir/Linux_for_Tegra/jetson_board_spec.cfg

# optee, atf and tos build steps are taken from the README in the optee sources
dtc -I dts -O dtb -o /build_dir/optee/tegra234-optee.dtb /build_dir/optee/tegra234-optee.dts

# build atf
pushd /build_dir/atf_build
./nvbuild.sh
popd
pushd /build_dir/

# build optee
./optee_src_build.sh -p t234 -t

# build tos.img
Linux_for_Tegra/nv_tegra/tos-scripts/gen_tos_part_img.py --monitor /build_dir/atf_build/arm-trusted-firmware.t234/generic-t234/tegra/t234/release/bl31.bin --os /build_dir/optee/build/t234/core/tee-raw.bin  --dtb /build_dir/optee/tegra234-optee.dtb --tostype optee /build_dir/tos.img

cp /build_dir/tos.img /build_dir/Linux_for_Tegra/bootloader/tos-optee_t234.img


pushd /build_dir/Linux_for_Tegra/

dtc -I dtb -O dts ./kernel/dtb/L4TConfiguration.dtbo -o ./kernel/dtb/L4TConfiguration.dts && \
    sed -i -i '/RootfsRetryCountMax[[:space:]]*{/,/};/ { s/data = <0x3/data = <0x9/; s/locked;/non-volatile;/ }' ./kernel/dtb/L4TConfiguration.dts && \
    dtc -I dts -O dtb ./kernel/dtb/L4TConfiguration.dts -o ./kernel/dtb/L4TConfiguration.dtbo && \
    dtc -I dtb -O dts ./bootloader/L4TConfiguration.dtbo -o ./bootloader/L4TConfiguration.dts && \
    sed -i -i '/RootfsRetryCountMax[[:space:]]*{/,/};/ { s/data = <0x3/data = <0x9/; s/locked;/non-volatile;/ }' ./bootloader/L4TConfiguration.dts && \
    dtc -I dts -O dtb ./bootloader/L4TConfiguration.dts -o ./bootloader/L4TConfiguration.dtbo

sudo ./l4t_generate_soc_bup.sh -e ${bl_spec} t23x
sudo ./generate_capsule/l4t_generate_soc_capsule.sh -i bootloader/payloads_t23x/bl_only_payload -o ./TEGRA_BL.Cap t234

gzip TEGRA_BL.Cap

exit 0
