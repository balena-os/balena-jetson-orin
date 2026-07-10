#!/bin/bash

set -e


bl_spec="t23x_3767_bl_spec"
pushd /build_dir/Linux_for_Tegra/

ToT_BSP=$(pwd)

sudo ./l4t_generate_soc_bup.sh -e ${bl_spec} t23x
sudo ./generate_capsule/l4t_generate_soc_capsule.sh -i bootloader/payloads_t23x/bl_only_payload -o ./TEGRA_BL.Cap t234

gzip TEGRA_BL.Cap

exit 0
