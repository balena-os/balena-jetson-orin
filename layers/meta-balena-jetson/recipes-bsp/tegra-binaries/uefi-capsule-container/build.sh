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
		cp -r /build_dir/Seeed_36_4_3/Linux_for_Tegra/* /build_dir/Linux_for_Tegra/
		cp p3768-0000-p3767-0000-a0.conf p3768-0000-p3767-0000-a0_original.conf
		cat recomputer-orin-j401.conf > p3768-0000-p3767-0000-a0.conf
		sed -i "s#p3768-0000-p3767-0000-a0.conf#p3768-0000-p3767-0000-a0_original.conf#g" p3768-0000-p3767-0000-a0.conf
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
