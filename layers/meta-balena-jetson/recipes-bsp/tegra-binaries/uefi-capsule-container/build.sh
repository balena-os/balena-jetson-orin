#!/bin/bash

set -e

bl_spec="t26x_agx_bl_spec"
pushd /build_dir/Linux_for_Tegra/

ToT_BSP=$(pwd)

sudo ./l4t_generate_soc_bup.sh -e ${bl_spec} t26x
sudo ./generate_capsule/l4t_generate_soc_capsule.sh -i bootloader/payloads_t26x/bl_only_payload -o ./TEGRA_BL.Cap t264

exit 0
