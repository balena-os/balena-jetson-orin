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
		git clone https://github.com/Seeed-Studio/Linux_for_Tegra.git -b r39.0.0 --single-branch
		pushd Linux_for_Tegra
		# Latest revision as of July 13 2026
		git checkout 8fed53ebf5d9cde953de5bb4b9d951e5803da9c7
		popd
		popd
		cp -r /build_dir/Seeed_39_2_0/Linux_for_Tegra/* /build_dir/Linux_for_Tegra/
		cp p3768-0000-p3767-0000-a0.conf p3768-0000-p3767-0000-a0_original.conf

		if [[ "${DEVICE_TYPE}" = "jetson-orin-nx-seeed-j4012" ]]; then
			# J4012 Classic does not support the Super mode
			cat recomputer-orin-j401.conf > p3768-0000-p3767-0000-a0.conf
		elif [[ "${DEVICE_TYPE}" = "jetson-orin-nano-seeed-j3010" ]]; then
			cat recomputer-orin-super-j401.conf > p3768-0000-p3767-0000-a0.conf
		fi

		# This dtbo is referenced in recomputer-orin-j401.conf but it is not present in the BSP archive,
		# not is it built when creating the UEFI capsule. We comment it out so that the UEFI capsule build
		# doesn't fail
		sed -i "s/tegra234-p3767-camera-p3768-imx219-dual-seeed.dtbo//g" p3768-0000-p3767-0000-a0.conf
		sed -i "s/tegra234-p3767-camera-p3768-imx219-quad-seeed.dtbo//g" p3768-0000-p3767-0000-a0.conf
		sed -i "s#p3768-0000-p3767-0000-a0.conf#p3768-0000-p3767-0000-a0_original.conf#g" p3768-0000-p3767-0000-a0.conf
		;;
	"forecr-dsb-ornx-orin-nano-8gb")
	        wget https://github.com/forecr/dsboard_ornx_lan_orin_bsp/raw/ca120e8edea3a78505c0d42cc78b3f1502b59ab7/dsboard_ornx_lan_orin_nano_JP7_2_bsp.tar.xz -O /build_dir/dsboard_ornx_lan_orin_nano_JP7_2_bsp.tar.xz
		pushd /build_dir/
		tar xf dsboard_ornx_lan_orin_nano_JP7_2_bsp.tar.xz
		cp -r ./dsboard_ornx_lan_orin_nano_JP7_2_bsp/* .
		sudo ./replace_bsp_files.sh
		# Replace back UEFI binary with the one built in Yocto until clarified in
		# https://github.com/forecr/dsboard_ornx_lan_orin_bsp/commit/ca120e8edea3a78505c0d42cc78b3f1502b59ab7#r192219492
		# why the BSP overrides the standard file.
		sudo cp Linux_for_Tegra/bootloader/uefi_bins/yocto_uefi_t23x_general.bin Linux_for_Tegra/bootloader/uefi_bins/uefi_t23x_general.bin
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

sudo ./l4t_generate_soc_bup.sh -e ${bl_spec} t23x
sudo ./generate_capsule/l4t_generate_soc_capsule.sh -i bootloader/payloads_t23x/bl_only_payload -o ./TEGRA_BL.Cap t234

gzip TEGRA_BL.Cap

exit 0
