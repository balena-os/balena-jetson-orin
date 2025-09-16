#!/bin/bash

set -e

fw_config_dtsi_path="/build_dir/Linux_for_Tegra/bootloader/tegra234-firewall-config-base.dtsi"
mb2_bct_paths=(
	"/build_dir/Linux_for_Tegra/bootloader/tegra234-mb2-bct-common.dtsi"
	"/build_dir/Linux_for_Tegra/bootloader/generic/BCT/tegra234-mb2-bct-misc-p3701-0002-p3740-0002.dts"
	"/build_dir/Linux_for_Tegra/bootloader/generic/BCT/tegra234-mb2-bct-misc-p3767-0000.dts"
	"/build_dir/Linux_for_Tegra/bootloader/generic/BCT/tegra234-mb2-bct-misc-p3701-0002-p3711-0000.dts"
	)

ToT_BSP=$(pwd)
bl_spec="t23x_3767_bl_spec"
lines=(2766 2771 2776 2781 2786 2791 2796 2801 2806 2811 2816 2821 2826 2831 25712 25717 25722 25727 25732 25737 25742 25747 25752 25757 25762 25767)
old_str="exclusion-info = <2>;"
new_str="exclusion-info = <0>;"

pushd /build_dir/Linux_for_Tegra/

case "${DEVICE_TYPE}" in
	"jetson-agx-orin-devkit-64gb" | "jetson-agx-orin-devkit")
		bl_spec="t23x_agx_bl_spec"
		;;
	"jetson-orin-nano-seeed-j3010" | "jetson-orin-nx-seeed-j4012")
		mkdir -p /build_dir/Seeed_36_4_3
		pushd /build_dir/Seeed_36_4_3
		git clone https://github.com/Seeed-Studio/Linux_for_Tegra.git -b r36.4.3 --single-branch
		popd
		cp -r /build_dir/Seeed_36_4_3/Linux_for_Tegra/* /build_dir/Linux_for_Tegra/
		cp p3768-0000-p3767-0000-a0.conf p3768-0000-p3767-0000-a0_original.conf
		if [[ "${DEVICE_TYPE}" = "jetson-orin-nx-seeed-j4012" ]]; then
			# J4012 Classic does not support the Super mode
			cat recomputer-orin-j401.conf > p3768-0000-p3767-0000-a0.conf
		elif [[ "${DEVICE_TYPE}" = "jetson-orin-nano-seeed-j3010" ]]; then
			cat recomputer-orin-super-j401.conf > p3768-0000-p3767-0000-a0.conf
			# This dtbo is referenced in recomputer-orin-super-j401.conf but it is not present in the sources,
			# nor is it compiled at flash time. Only tegra234-p3767-camera-p3768-imx219-dual-seeed.dtbo is
			# is provided by the BSP.
			sed -i "s#tegra234-p3767-camera-p3768-imx219-quad-seeed#tegra234-p3767-camera-p3768-imx219-dual-seeed#g" p3768-0000-p3767-0000-a0.conf
		fi

		sed -i "s#p3768-0000-p3767-0000-a0.conf#p3768-0000-p3767-0000-a0_original.conf#g" p3768-0000-p3767-0000-a0.conf
		;;
	"forecr-dsb-ornx-orin-nano-8gb")
	        wget https://github.com/forecr/dsboard_ornx_lan_orin_bsp/raw/refs/heads/master/dsboard_ornx_lan_orin_nano_JP6_2_bsp.tar.xz -O /build_dir/dsboard_ornx_lan_orin_nano_JP6_2_bsp.tar.xz
		pushd /build_dir/
		tar xf dsboard_ornx_lan_orin_nano_JP6_2_bsp.tar.xz
		cp -r ./dsboard_ornx_lan_orin_nano_JP6_2_bsp/* .
		sudo ./replace_bsp_files.sh
		popd
		;;

	*)
	        :
		;;
esac

# Allow the QSPI to be accessible for OTA
# re-writing / recovery in case of
# necessity
for line_number in "${lines[@]}"; do
	sed -i "${line_number}s#${old_str}#${new_str}#g" "${fw_config_dtsi_path}"
	echo "Replaced exclusion info on line $line_number"
done

# Allow modules in carrier boards without an EEPROM
# to boot
for mb2_bct_path in "${mb2_bct_paths[@]}"; do
	sed -i "s#cvb_eeprom_read_size = <0x100>#cvb_eeprom_read_size = <0x0>#g" "${mb2_bct_path}"
done

sudo ./l4t_generate_soc_bup.sh -e ${bl_spec} t23x
sudo ./generate_capsule/l4t_generate_soc_capsule.sh -i bootloader/payloads_t23x/bl_only_payload -o ./TEGRA_BL.Cap t234

gzip TEGRA_BL.Cap

exit 0
