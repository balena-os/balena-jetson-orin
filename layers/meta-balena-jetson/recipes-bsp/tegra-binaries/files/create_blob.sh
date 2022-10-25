#!/bin/bash

set -o errexit

##### Patch creation from existing boot blob
# dd if=mtd0ro.bin of=T234_devkit_patch.bin bs=1 skip=4 count=64
# dd if=mtd0ro.bin of=T234_devkit_patch.bin bs=1 seek=64 skip=452 count=64
##### PSC FW patch
# dd if=mtd0ro.bin of=T234_devkit_patch.bin bs=1 seek=600 skip=10878980 count=144

##### END
# dd if=mtd0ro.bin of=T234_devkit_patch.bin bs=1 seek=800 skip=65536000 count=15312
# dd if=mtd0ro.bin of=T234_devkit_patch.bin bs=1 seek=16112 skip=66060288 count=32
# dd if=mtd0ro.bin of=T234_devkit_patch.bin bs=1 seek=16500 skip=66732032 count=4880
# dd if=mtd0ro.bin of=T234_devkit_patch.bin bs=1 seek=22000 skip=66738640 count=16
# dd if=mtd0ro.bin of=T234_devkit_patch.bin bs=1 seek=22016 skip=66846720 count=16896
# dd if=mtd0ro.bin of=T234_devkit_patch.bin bs=1 seek=38912 skip=66977792 count=112

## Create binary
dd if=/dev/zero count=1 bs=67108864 | tr "\000" "\377" > boot0.img

# Write BCT chain
seek0=0
seek1=4
seek2=452
seek3=6632
step=16384
for i in {0..64}
do
    dd if=${DEPLOY_DIR_IMAGE}/bootfiles/br_bct_BR.bct of=boot0.img bs=1 seek=${seek0} conv=notrunc
    dd if=T234_devkit_patch.bin of=boot0.img bs=1 seek=${seek1} skip=0 count=64 conv=notrunc
    dd if=T234_devkit_patch.bin of=boot0.img bs=1 seek=${seek2} skip=64 count=64 conv=notrunc
    dd if=/dev/zero of=boot0.img bs=1 seek=${seek3} count=1 conv=notrunc
    seek0=`expr $seek0 + $step`
    seek1=`expr $seek1 + $step`
    seek2=`expr $seek2 + $step`
    seek3=`expr $seek3 + $step`
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
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/tegra234-bpmp-3701-0000-3737-0000_with_odm_sigheader.dtb.encrypt of=boot0.img bs=1 seek=6684672 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/pscfw_t234_prod_sigheader.bin.encrypt of=boot0.img bs=1 seek=10878976 conv=notrunc

# Patch PSC FW on A_ slot
dd if=T234_devkit_patch.bin of=boot0.img bs=1 seek=10878980 skip=600 count=144 conv=notrunc
dd if=/dev/zero of=boot0.img bs=1 seek=10884256 count=16 conv=notrunc

# Continue writing signed bootloaders and firmware files
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/mce_flash_o10_cr_prod_sigheader.bin.encrypt of=boot0.img bs=1 seek=11665408 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/sc7_t234_prod_sigheader.bin.encrypt of=boot0.img bs=1 seek=12189696 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/psc_rf_t234_prod_sigheader.bin.encrypt of=boot0.img bs=1 seek=12386304 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/mb2rf_t234_sigheader.bin.encrypt of=boot0.img bs=1 seek=12582912 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/uefi_jetson_with_dtb_sigheader.bin.encrypt of=boot0.img bs=1 seek=12713984 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/tos-optee_t234_sigheader.img.encrypt of=boot0.img bs=1 seek=16384000 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/eks_sigheader.img.encrypt of=boot0.img bs=1 seek=22675456 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/display-t234-dce_aligned_blob_w_bin_sigheader.bin.encrypt of=boot0.img bs=1 seek=22937600 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/spe_t234_sigheader.bin.encrypt of=boot0.img bs=1 seek=28180480 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/camera-rtcpu-t234-rce_sigheader.img.encrypt of=boot0.img bs=1 seek=28770304 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/adsp-fw_sigheader.bin.encrypt of=boot0.img bs=1 seek=29818880 conv=notrunc

# Write signed bootloaders and firmware files on A_ slots
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/mb1_t234_prod_aligned_sigheader.bin.encrypt of=boot0.img bs=1 seek=33292288 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/psc_bl1_t234_prod_aligned_sigheader.bin.encrypt of=boot0.img bs=1 seek=33816576 conv=notrunc

dd if=${DEPLOY_DIR_IMAGE}/bootfiles/mb1_cold_boot_bct_MB1_sigheader.bct.encrypt of=boot0.img bs=1 seek=34078720 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/mem_coldboot_sigheader.bct.encrypt of=boot0.img bs=1 seek=34209792 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/nvdec_t234_prod_sigheader.fw.encrypt of=boot0.img bs=1 seek=35520512 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/mb2_t234_with_mb2_cold_boot_bct_MB2_sigheader.bin.encrypt of=boot0.img bs=1 seek=36569088 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/xusb_t234_prod_sigheader.bin.encrypt of=boot0.img bs=1 seek=37093376 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/bpmp_t234-TE990M-A1_prod_sigheader.bin.encrypt of=boot0.img bs=1 seek=37355520 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/tegra234-bpmp-3701-0000-3737-0000_with_odm_sigheader.dtb.encrypt of=boot0.img bs=1 seek=38928384 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/pscfw_t234_prod_sigheader.bin.encrypt of=boot0.img bs=1 seek=43122688 conv=notrunc

# Patch PSC FW on B_ slot
dd if=T234_devkit_patch.bin of=boot0.img bs=1 seek=43122692 skip=600 count=144 conv=notrunc
dd if=/dev/zero of=boot0.img bs=1 seek=43127968 count=16 conv=notrunc

# Continue witg signed bootloaders and firmware files
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/mce_flash_o10_cr_prod_sigheader.bin.encrypt of=boot0.img bs=1 seek=43909120 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/sc7_t234_prod_sigheader.bin.encrypt of=boot0.img bs=1 seek=44433408 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/psc_rf_t234_prod_sigheader.bin.encrypt of=boot0.img bs=1 seek=44630016 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/mb2rf_t234_sigheader.bin.encrypt of=boot0.img bs=1 seek=44826624 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/uefi_jetson_with_dtb_sigheader.bin.encrypt of=boot0.img bs=1 seek=44957696 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/tos-optee_t234_sigheader.img.encrypt of=boot0.img bs=1 seek=48627712 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/eks_sigheader.img.encrypt of=boot0.img bs=1 seek=54919168 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/display-t234-dce_aligned_blob_w_bin_sigheader.bin.encrypt of=boot0.img bs=1 seek=55181312 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/spe_t234_sigheader.bin.encrypt of=boot0.img bs=1 seek=60424192 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/camera-rtcpu-t234-rce_sigheader.img.encrypt of=boot0.img bs=1 seek=61014016 conv=notrunc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/adsp-fw_sigheader.bin.encrypt of=boot0.img bs=1 seek=62062592 conv=notrunc

## Final patching, end bct etc
dd if=${DEPLOY_DIR_IMAGE}/bootfiles/br_bct_BR.bct of=boot0.img bs=1 seek=66715648 conv=notrunc
dd if=T234_devkit_patch.bin of=boot0.img bs=1 seek=66715652 skip=0 count=64 conv=notrunc
dd if=T234_devkit_patch.bin of=boot0.img bs=1 seek=66716100 skip=64 count=64 conv=notrunc

dd if=T234_devkit_patch.bin of=boot0.img bs=1 seek=65536000 skip=800 count=15312 conv=notrunc
dd if=T234_devkit_patch.bin of=boot0.img bs=1 seek=66060288 skip=16112 count=32 conv=notrunc
dd if=/dev/zero of=boot0.img bs=1 seek=66722272 count=16 conv=notrunc
dd if=/dev/zero of=boot0.img bs=1 seek=66723840 count=11536 conv=notrunc
dd if=T234_devkit_patch.bin of=boot0.img bs=1 seek=66732032 skip=16500 count=4880 conv=notrunc
dd if=/dev/zero of=boot0.img bs=1 seek=66737932 count=10484 conv=notrunc
dd if=T234_devkit_patch.bin of=boot0.img bs=1 seek=66738640 skip=22000 count=16 conv=notrunc
dd if=T234_devkit_patch.bin of=boot0.img bs=1 seek=66846720 skip=22016 count=16896 conv=notrunc
dd if=T234_devkit_patch.bin of=boot0.img bs=1 seek=67091968 skip=22016 count=16896 conv=notrunc
dd if=T234_devkit_patch.bin of=boot0.img bs=1 seek=66912256 skip=38912 count=112 conv=notrunc
dd if=T234_devkit_patch.bin of=boot0.img bs=1 seek=66977792 skip=38912 count=112 conv=notrunc
