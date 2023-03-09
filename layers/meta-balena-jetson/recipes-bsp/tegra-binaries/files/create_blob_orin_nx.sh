#!/bin/bash

set -o errexit

##### Patch creation from existing boot blob
#dd if=mtd0ro.bin of=T234_devkit_patch_orin_nx_xav_dvk.bin bs=1 skip=4 count=64
#dd if=mtd0ro.bin of=T234_devkit_patch_orin_nx_xav_dvk.bin bs=1 seek=64 skip=452 count=64
#dd if=mtd0ro.bin of=T234_devkit_patch_orin_nx_xav_dvk.bin bs=1 seek=128 skip=3348 count=748

#dd if=mtd0ro.bin of=T234_devkit_patch_orin_nx_xav_dvk.bin bs=1 seek=4096 skip=4325376 count=144
#dd if=mtd0ro.bin of=T234_devkit_patch_orin_nx_xav_dvk.bin bs=1 seek=4240 skip=65536000 count=15312
#dd if=mtd0ro.bin of=T234_devkit_patch_orin_nx_xav_dvk.bin bs=1 seek=19552 skip=4330592 count=64
#dd if=mtd0ro.bin of=T234_devkit_patch_orin_nx_xav_dvk.bin bs=1 seek=19616 skip=4333360 count=64
#dd if=mtd0ro.bin of=T234_devkit_patch_orin_nx_xav_dvk.bin bs=1 seek=19680 skip=4728832 count=480
#dd if=mtd0ro.bin of=T234_devkit_patch_orin_nx_xav_dvk.bin bs=1 seek=20160 skip=4732320 count=2320
#dd if=mtd0ro.bin of=T234_devkit_patch_orin_nx_xav_dvk.bin bs=1 seek=22480 skip=4740272 count=22784
#dd if=mtd0ro.bin of=T234_devkit_patch_orin_nx_xav_dvk.bin bs=1 seek=45264 skip=36569088 count=160
#dd if=mtd0ro.bin of=T234_devkit_patch_orin_nx_xav_dvk.bin bs=1 seek=45424 skip=36574304 count=64
#dd if=mtd0ro.bin of=T234_devkit_patch_orin_nx_xav_dvk.bin bs=1 seek=45488 skip=36577072 count=64
#dd if=mtd0ro.bin of=T234_devkit_patch_orin_nx_xav_dvk.bin bs=1 seek=45552 skip=36972544 count=448
#dd if=mtd0ro.bin of=T234_devkit_patch_orin_nx_xav_dvk.bin bs=1 seek=46000 skip=36993200 count=64
#dd if=mtd0ro.bin of=T234_devkit_patch_orin_nx_xav_dvk.bin bs=1 seek=46064 skip=65536000 count=18112
#dd if=mtd0ro.bin of=T234_devkit_patch_orin_nx_xav_dvk.bin bs=1 seek=64176 skip=66060288 count=32
#dd if=mtd0ro.bin of=T234_devkit_patch_orin_nx_xav_dvk.bin bs=1 seek=64208 skip=66732016 count=8192
#dd if=mtd0ro.bin of=T234_devkit_patch_orin_nx_xav_dvk.bin bs=1 seek=72400 skip=66846720 count=7248
#dd if=mtd0ro.bin of=T234_devkit_patch_orin_nx_xav_dvk.bin bs=1 seek=79648 skip=66863104 count=96
#dd if=mtd0ro.bin of=T234_devkit_patch_orin_nx_xav_dvk.bin bs=1 seek=79744 skip=66912256 count=112
#dd if=mtd0ro.bin of=T234_devkit_patch_orin_nx_xav_dvk.bin bs=1 seek=79856 skip=66977792 count=112
#dd if=mtd0ro.bin of=T234_devkit_patch_orin_nx_xav_dvk.bin bs=1 seek=79968 skip=67091968 count=7248
#dd if=mtd0ro.bin of=T234_devkit_patch_orin_nx_xav_dvk.bin bs=1 seek=87216 skip=67108352 count=96


## Create empty binary
dd if=/dev/zero count=1 bs=67108864 | tr "\000" "\377" > boot0.img

# Write and patch BCT chain
seek0=0
seek1=4
seek2=452
seek3=3348
seek4=6616
seek5=6620
step=65536
for i in {0..15}
do
    dd if=${DEPLOY_DIR_IMAGE}/bootfiles/br_bct_b_BR.bct of=boot0.img bs=1 seek=${seek0} conv=notrunc
    dd if=T234_devkit_patch_orin_nx_xav_dvk.bin of=boot0.img bs=1 seek=${seek1} skip=0 count=64 conv=notrunc
    dd if=T234_devkit_patch_orin_nx_xav_dvk.bin of=boot0.img bs=1 seek=${seek2} skip=64 count=64 conv=notrunc
    dd if=T234_devkit_patch_orin_nx_xav_dvk.bin of=boot0.img bs=1 seek=${seek3} skip=128 count=748 conv=notrunc
    dd if=/dev/zero of=boot0.img bs=1 seek=${seek4} count=32 conv=notrunc
    dd if=/dev/zero count=1 bs=1 | tr "\00" "\02" | dd of=boot0.img seek=${seek5} count=1 bs=1 conv=notrunc
    seek0=`expr $seek0 + $step`
    seek1=`expr $seek1 + $step`
    seek2=`expr $seek2 + $step`
    seek3=`expr $seek3 + $step`
    seek4=`expr $seek4 + $step`
    seek5=`expr $seek5 + $step`
done

# Write signed bootloaders and firmware files on A_ slots
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/mb1_t234_prod_aligned_sigheader.bin.encrypt of=boot0.img bs=1 seek=1048576 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/psc_bl1_t234_prod_aligned_sigheader.bin.encrypt of=boot0.img bs=1 seek=1572864 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/mb1_cold_boot_bct_MB1_sigheader.bct.encrypt of=boot0.img bs=1 seek=1835008 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/mem_coldboot_sigheader.bct.encrypt of=boot0.img bs=1 seek=1966080 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/nvdec_t234_prod_sigheader.fw.encrypt of=boot0.img bs=1 seek=3276800 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/mb2_t234_with_mb2_cold_boot_bct_MB2_sigheader.bin.encrypt of=boot0.img bs=1 seek=4325376 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/xusb_t234_prod_sigheader.bin.encrypt of=boot0.img bs=1 seek=4849664 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/bpmp_t234-TE990M-A1_prod_sigheader.bin.encrypt of=boot0.img bs=1 seek=5111808 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/tegra234-bpmp-3767-0000-a02-3509-a02_with_odm_sigheader.dtb.encrypt of=boot0.img bs=1 seek=6684672 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/pscfw_t234_prod_sigheader.bin.encrypt of=boot0.img bs=1 seek=10878976 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/mce_flash_o10_cr_prod_sigheader.bin.encrypt of=boot0.img bs=1 seek=11665408 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/sc7_t234_prod_sigheader.bin.encrypt of=boot0.img bs=1 seek=12189696 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/psc_rf_t234_prod_sigheader.bin.encrypt of=boot0.img bs=1 seek=12386304 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/mb2rf_t234_sigheader.bin.encrypt of=boot0.img bs=1 seek=12582912 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/uefi_jetson_with_dtb_sigheader.bin.encrypt of=boot0.img bs=1 seek=12713984 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/tos-optee_t234_sigheader.img.encrypt of=boot0.img bs=1 seek=16384000 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/eks_sigheader.img.encrypt of=boot0.img bs=1 seek=22675456 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/display-t234-dce_with_tegra234-p3767-0000-p3509-a02_with_odm_aligned_blob_w_bin_sigheader.bin.encrypt of=boot0.img bs=1 seek=22937600 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/spe_t234_sigheader.bin.encrypt of=boot0.img bs=1 seek=28180480 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/camera-rtcpu-t234-rce_sigheader.img.encrypt of=boot0.img bs=1 seek=28770304 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/adsp-fw_sigheader.bin.encrypt of=boot0.img bs=1 seek=29818880 conv=notrunc


# Continue with B slots
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/mb1_t234_prod_aligned_sigheader.bin.encrypt of=boot0.img bs=1 seek=33292288 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/psc_bl1_t234_prod_aligned_sigheader.bin.encrypt of=boot0.img bs=1 seek=33816576 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/mb1_cold_boot_bct_MB1_sigheader.bct.encrypt of=boot0.img bs=1 seek=34078720 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/mem_coldboot_sigheader.bct.encrypt of=boot0.img bs=1 seek=34209792 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/nvdec_t234_prod_sigheader.fw.encrypt of=boot0.img bs=1 seek=35520512 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/mb2_t234_with_mb2_cold_boot_bct_MB2_sigheader.bin.encrypt of=boot0.img bs=1 seek=36569088 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/xusb_t234_prod_sigheader.bin.encrypt of=boot0.img bs=1 seek=37093376 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/bpmp_t234-TE990M-A1_prod_sigheader.bin.encrypt of=boot0.img bs=1 seek=37355520 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/tegra234-bpmp-3767-0000-a02-3509-a02_with_odm_sigheader.dtb.encrypt of=boot0.img bs=1 seek=38928384 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/pscfw_t234_prod_sigheader.bin.encrypt of=boot0.img bs=1 seek=43122688 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/mce_flash_o10_cr_prod_sigheader.bin.encrypt of=boot0.img bs=1 seek=43909120 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/sc7_t234_prod_sigheader.bin.encrypt of=boot0.img bs=1 seek=44433408 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/psc_rf_t234_prod_sigheader.bin.encrypt of=boot0.img bs=1 seek=44630016 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/mb2rf_t234_sigheader.bin.encrypt of=boot0.img bs=1 seek=44826624 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/uefi_jetson_with_dtb_sigheader.bin.encrypt of=boot0.img bs=1 seek=44957696 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/tos-optee_t234_sigheader.img.encrypt of=boot0.img bs=1 seek=48627712 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/eks_sigheader.img.encrypt of=boot0.img bs=1 seek=54919168 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/display-t234-dce_with_tegra234-p3767-0000-p3509-a02_with_odm_aligned_blob_w_bin_sigheader.bin.encrypt of=boot0.img bs=1 seek=55181312 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/spe_t234_sigheader.bin.encrypt of=boot0.img bs=1 seek=60424192 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/camera-rtcpu-t234-rce_sigheader.img.encrypt of=boot0.img bs=1 seek=61014016 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/adsp-fw_sigheader.bin.encrypt of=boot0.img bs=1 seek=62062592 conv=notrunc


# Patch resulting blob to match the one creating during flash
dd if=boot0.img of=boot0.img bs=1 count=8192 skip=0 seek=66715648 conv=notrunc
dd if=/dev/zero of=boot0.img bs=1 seek=66723840 count=8176 conv=notrunc
dd if=T234_devkit_patch_orin_nx_xav_dvk.bin of=boot0.img bs=1 seek=4325376 skip=4096 count=144 conv=notrunc
dd if=T234_devkit_patch_orin_nx_xav_dvk.bin of=boot0.img bs=1 seek=4330592 skip=19552 count=64 conv=notrunc
dd if=T234_devkit_patch_orin_nx_xav_dvk.bin of=boot0.img bs=1 seek=4333360 skip=19616 count=64 conv=notrunc
dd if=T234_devkit_patch_orin_nx_xav_dvk.bin of=boot0.img bs=1 seek=4728832 skip=19680 count=480 conv=notrunc
dd if=T234_devkit_patch_orin_nx_xav_dvk.bin of=boot0.img bs=1 seek=4732320 skip=20160 count=2320 conv=notrunc
dd if=T234_devkit_patch_orin_nx_xav_dvk.bin of=boot0.img bs=1 seek=4740272 skip=22480 count=22784 conv=notrunc
dd if=T234_devkit_patch_orin_nx_xav_dvk.bin of=boot0.img bs=1 seek=36569088 skip=45264 count=160 conv=notrunc
dd if=T234_devkit_patch_orin_nx_xav_dvk.bin of=boot0.img bs=1 seek=36574304 skip=45424 count=64 conv=notrunc
dd if=T234_devkit_patch_orin_nx_xav_dvk.bin of=boot0.img bs=1 seek=36577072 skip=45488 count=64 conv=notrunc
dd if=T234_devkit_patch_orin_nx_xav_dvk.bin of=boot0.img bs=1 seek=36972544 skip=45552 count=448 conv=notrunc
dd if=/dev/zero count=1 bs=1 | tr "\00" "\03" | dd of=boot0.img seek=36977120 count=1 bs=1 conv=notrunc
dd if=T234_devkit_patch_orin_nx_xav_dvk.bin of=boot0.img bs=1 seek=36993200 skip=46000 count=64 conv=notrunc
dd if=/dev/zero count=2 bs=1 of=boot0.img seek=37006402 conv=notrunc
dd if=T234_devkit_patch_orin_nx_xav_dvk.bin of=boot0.img bs=1 seek=65536000 skip=46064 count=18112 conv=notrunc
dd if=T234_devkit_patch_orin_nx_xav_dvk.bin of=boot0.img bs=1 seek=66060288 skip=64176 count=32 conv=notrunc
dd if=T234_devkit_patch_orin_nx_xav_dvk.bin of=boot0.img bs=1 seek=66732016 skip=64208 count=8192 conv=notrunc
dd if=/dev/zero count=8208 bs=1 of=boot0.img seek=66740208 conv=notrunc
dd if=T234_devkit_patch_orin_nx_xav_dvk.bin of=boot0.img bs=1 seek=66846720 skip=72400 count=7248 conv=notrunc
dd if=/dev/zero count=9648 bs=1 of=boot0.img seek=66853968 conv=notrunc
dd if=T234_devkit_patch_orin_nx_xav_dvk.bin of=boot0.img bs=1 seek=66846720 skip=72400 count=7248 conv=notrunc
dd if=T234_devkit_patch_orin_nx_xav_dvk.bin of=boot0.img bs=1 seek=66863104 skip=79648 count=96 conv=notrunc
dd if=T234_devkit_patch_orin_nx_xav_dvk.bin of=boot0.img bs=1 seek=66912256 skip=79744 count=112 conv=notrunc
dd if=T234_devkit_patch_orin_nx_xav_dvk.bin of=boot0.img bs=1 seek=66977792 skip=79856 count=112 conv=notrunc
dd if=T234_devkit_patch_orin_nx_xav_dvk.bin of=boot0.img bs=1 seek=67091968 skip=79968 count=7248 conv=notrunc
dd if=/dev/zero count=9648 bs=1 of=boot0.img seek=67099216 conv=notrunc
dd if=T234_devkit_patch_orin_nx_xav_dvk.bin of=boot0.img bs=1 seek=67108352 skip=87216 count=96 conv=notrunc

