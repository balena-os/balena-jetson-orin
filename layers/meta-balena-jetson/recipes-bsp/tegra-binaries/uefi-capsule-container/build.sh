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
		# Latest revision as of Aug 10 2026
		git checkout 4e249916677315bc63f4dc585c76b8f4434fc230
		popd
		popd
		cp -r /build_dir/Seeed_39_2_0/Linux_for_Tegra/* /build_dir/Linux_for_Tegra/
		cp p3768-0000-p3767-0000-a0.conf p3768-0000-p3767-0000-a0_original.conf

		if [[ "${DEVICE_TYPE}" = "jetson-orin-nx-seeed-j4012" ]]; then
			# J4012 Classic does not support the Super mode
			cat recomputer-orin-j401.conf > p3768-0000-p3767-0000-a0.conf
			echo "ext_target_board=recomputer-orin-j401" >> recomputer-orin-j401.conf
		elif [[ "${DEVICE_TYPE}" = "jetson-orin-nano-seeed-j3010" ]]; then
			cat recomputer-orin-super-j401.conf > p3768-0000-p3767-0000-a0.conf
			echo "ext_target_board=recomputer-orin-super-j401" >> recomputer-orin-super-j401.conf
		fi
		# We only support Orin NX 16GB and Orin Nano 4GB on the Seeed boards and don't include the rest in the BUP creation. But we need to swap the dtb for the rest
		# to prevent the UEFI capsule creation from failing when it tries to copy the dtbs specified in the machine.conf
		machines=('p3768-0000-p3767-0000-a0.conf' 'p3768-0000-p3767-0000-a0_original.conf' 'recomputer-orin-j401.conf' 'recomputer-orin-super-j401.conf')
		for machine in "${machines[@]}"; do
			sed -i 's/-recomputer-super.dtb/-recomputer.dtb/g' ${machine}
			# Orin NX 8GB, Nano 8GB Production module and Nano SD-Card are not supported in these Seeed J4012/J3010 images
			for i in 1 3 5; do
				sed -i "s/tegra234-j401-p3768-0000+p3767-000${i}-recomputer.dtb/tegra234-p3768-0000+p3767-000${i}-nv.dtb/g" ${machine}
			done
			# Orin NX 8GB, Orin NX16 GB, Nano 8GB Production module and Nano SD-Card do not support super mode in these Seeed J4012/J3010 images
			for i in 0 1 3 5; do
				sed -i "s/tegra234-j401-p3768-0000+p3767-000${i}-recomputer-super.dtb/tegra234-p3768-0000+p3767-000${i}-nv.dtb/g" ${machine}
			done

			sed -i 's/tegra234-p3767-camera-p3768-imx219-quad-seeed.dtbo//g' ${machine}
		done
		sed -i "s#p3768-0000-p3767-0000-a0.conf#p3768-0000-p3767-0000-a0_original.conf#g" p3768-0000-p3767-0000-a0.conf
		tar xf /build_dir/Linux_for_Tegra/custom_dtbs.tar.gz -C /build_dir/Linux_for_Tegra/
		echo "extracting custom-dtbs"
		ls -l /build_dir/Linux_for_Tegra/custom_dtbs/
	        cp -r /build_dir/Linux_for_Tegra/custom_dtbs/* /build_dir/Linux_for_Tegra/bootloader/
		cp -r /build_dir/Linux_for_Tegra/custom_dtbs/* /build_dir/Linux_for_Tegra/kernel/dtb/

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
	"jetson-orin-nx-xavier-nx-devkit")
		# Orin NX in Xavier NX Devkit uses the same Orin Nano Devkit machine and only overrides 4 configs
		tail -n 4 p3509-a02-p3767-0000.conf >> jetson-orin-nano-devkit.conf
		tail -n 4 p3509-a02-p3767-0000.conf >> jetson-orin-nano-devkit-super.conf
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

# Also support jetson-orin-nx-xavier-nx-devkit if the
# uefi compat spec variables have been set with this spec
cp /build_dir/Linux_for_Tegra/p3509-a02-p3767-0000.conf /build_dir/Linux_for_Tegra/jetson-orin-nx-xavier-nx-devkit.conf
echo "ext_target_board=jetson-orin-nx-xavier-nx-devkit" >> /build_dir/Linux_for_Tegra/jetson-orin-nx-xavier-nx-devkit.conf

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
    sed -i '/RootfsRetryCountMax[[:space:]]*{/,/};/ { s/data = <0x3/data = <0x9/; s/locked;/non-volatile;/ }' ./kernel/dtb/L4TConfiguration.dts && \
    dtc -I dts -O dtb ./kernel/dtb/L4TConfiguration.dts -o ./kernel/dtb/L4TConfiguration.dtbo

sudo ./l4t_generate_soc_bup.sh -e ${bl_spec} t23x
sudo ./generate_capsule/l4t_generate_soc_capsule.sh -i bootloader/payloads_t23x/bl_only_payload -o ./TEGRA_BL.Cap t234

gzip TEGRA_BL.Cap

exit 0
