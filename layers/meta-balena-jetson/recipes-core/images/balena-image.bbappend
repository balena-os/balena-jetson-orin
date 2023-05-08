include balena-image.inc

do_image:balenaos-img[depends] += " tegra-flash-dry:do_deploy"

DEVICE_SPECIFIC_SPACE:jetson-agx-orin-devkit = "331776"
IMAGE_ROOTFS_SIZE:jetson-agx-orin-devkit = "1003520"

DEVICE_SPECIFIC_SPACE:jetson-orin-nx-xavier-nx-devkit = "331776"
IMAGE_ROOTFS_SIZE:jetson-orin-nx-xavier-nx-devkit = "1003520"

BALENA_BOOT_SIZE:jetson-xavier = "121440"
BALENA_BOOT_SIZE:jetson-xavier-nx-devkit-emmc = "121440"
BALENA_BOOT_SIZE:jetson-xavier-nx-devkit = "121440"

# The Orin NX runs on a NVME which offers plenty of space
BALENA_BOOT_SIZE:jetson-orin-nx-xavier-nx-devkit = "121440"

IMAGE_ROOTFS_SIZE:jetson-xavier = "487424"
IMAGE_ROOTFS_SIZE:jetson-xavier-nx-devkit-emmc = "733184"
IMAGE_ROOTFS_SIZE:jetson-xavier-nx-devkit = "733184"
IMAGE_ROOTFS_SIZE:jetson-orin-nx-xavier-nx-devkit = "983040"

BALENA_BOOT_PARTITION_FILES:append = " \
    bootfiles/EFI/BOOT/BOOTAA64.efi:/EFI/BOOT/BOOTAA64.efi \
    extra_uEnv.txt:/extra_uEnv.txt \
"

check_size() {
    file_path=${1}
    [ -f "${file_path}" ] || bbfatal "Specified path does not exist: ${file_path}"
    file_size=$(ls -l ${file_path} | awk '{print $5}')
    part_size=${2}

    if [ "$file_size" -ge "$part_size" ]; then
        bbfatal "File ${file_path} too big for raw partition!"
    fi;
}

device_specific_configuration:jetson-agx-orin-devkit() {
    partitions=$(cat ${DEPLOY_DIR_IMAGE}/tegra-binaries/partition_specification234.txt)
    NVIDIA_PART_OFFSET=40
    START=${NVIDIA_PART_OFFSET}
    for n in ${partitions}; do
      part_name=$(echo $n | cut -d ':' -f 1)
      file_name=$(echo $n | cut -d ':' -f 2)
      part_size=$(echo $n | cut -d ':' -f 3)
      file_path=$(find ${DEPLOY_DIR_IMAGE}/bootfiles -name $file_name)
      END=$(expr ${START} \+ ${part_size} \- 1)
      echo ">>> file: ${file_path}, part: ${part_name}, start: ${START} - size: ${part_size} end: ${END}"
      parted -s ${BALENA_RAW_IMG} unit s mkpart $part_name ${START} ${END}
      if [ ! "$file_name" = "none.bin" ]; then
        check_size ${file_path} $(expr ${part_size} \* 512)
        dd if=$file_path of=${BALENA_RAW_IMG} conv=notrunc seek=${START} bs=512
      fi
      START=$(expr ${END} \+ 1)
    done
} 

device_specific_configuration:jetson-orin-nx-xavier-nx-devkit() {
    partitions=$(cat ${DEPLOY_DIR_IMAGE}/tegra-binaries/partition_specification234.txt)
    NVIDIA_PART_OFFSET=40
    START=${NVIDIA_PART_OFFSET}
    for n in ${partitions}; do
      part_name=$(echo $n | cut -d ':' -f 1)
      file_name=$(echo $n | cut -d ':' -f 2)
      part_size=$(echo $n | cut -d ':' -f 3)
      file_path=$(find ${DEPLOY_DIR_IMAGE}/bootfiles -name $file_name)
      END=$(expr ${START} \+ ${part_size} \- 1)
      echo ">>> file: ${file_path}, part: ${part_name}, start: ${START} - size: ${part_size} end: ${END}"
      parted -s ${BALENA_RAW_IMG} unit s mkpart $part_name ${START} ${END}
      if [ ! "$file_name" = "none.bin" ]; then
        check_size ${file_path} $(expr ${part_size} \* 512)
        dd if=$file_path of=${BALENA_RAW_IMG} conv=notrunc seek=${START} bs=512
      fi
      START=$(expr ${END} \+ 1)
    done
}

# We leave this space way larger than currently
# needed because other larger partitions are
# added from one Jetpack release to another
DEVICE_SPECIFIC_SPACE:jetson-xavier = "458752"

# Binaries are signed and packed into
# a partition and the flaser script
# gets them from there. Can't store them
# raw due to partition alignments which
# trigger checksum mismatches during flash

device_specific_configuration:jetson-xavier() {
    partitions=$(cat ${DEPLOY_DIR_IMAGE}/tegra-binaries/partition_specification194.txt)
    NVIDIA_PART_OFFSET=20480
    START=${NVIDIA_PART_OFFSET}
    for n in ${partitions}; do
      part_name=$(echo $n | cut -d ':' -f 1)
      file_name=$(echo $n | cut -d ':' -f 2)
      part_size=$(echo $n | cut -d ':' -f 3)
      file_path=$(find ${DEPLOY_DIR_IMAGE}/bootfiles -name $file_name)
      END=$(expr ${START} \+ ${part_size} \- 1)
      echo "Will write $part_name from ${START} to ${END} part size: $part_size"
      parted -s ${BALENA_RAW_IMG} unit B mkpart $part_name ${START} ${END}
      # The padding partition exists to allow for the device specific space to
      # be a multiple of 4096. We don't write anything to it for the moment.
      if [ ! "$file_name" = "none.bin" ]; then
        check_size ${file_path} ${part_size}
        # TODO: Secondary blobs with signed kernel, dtb and other bootloaders that need to be written to specific partitions are needed for the AGX Xavier
        #dd if=$file_path of=${BALENA_RAW_IMG} conv=notrunc seek=$(expr ${START} \/ 512) bs=512
      fi
      START=$(expr ${END} \+ 1)
    done
}

# Binaries are signed and packed into
# a partition and the flaser script
# gets them from there. Can't store them
# raw due to partition alignments which
# trigger checksum mismatches during flash
write_jetson_nx_partitions() {
    partitions=$(cat ${DEPLOY_DIR_IMAGE}/tegra-binaries/${1})
    NVIDIA_PART_OFFSET=20480
    START=${NVIDIA_PART_OFFSET}
    for n in ${partitions}; do
      part_name=$(echo $n | cut -d ':' -f 1)
      file_name=$(echo $n | cut -d ':' -f 2)
      part_size=$(echo $n | cut -d ':' -f 3)
      file_path=$(find ${DEPLOY_DIR_IMAGE}/bootfiles -name $file_name)
      END=$(expr ${START} \+ ${part_size} \- 1)
      echo "Will write $part_name from ${START} to ${END} part size: $part_size"
      parted -s ${BALENA_RAW_IMG} unit B mkpart $part_name ${START} ${END}
      # The padding partition exists to allow for the device specific space to
      # be a multiple of 4096. We don't write anything to it for the moment.
      if [ ! "$file_name" = "none.bin" ]; then
        check_size ${file_path} ${part_size}
        # TODO: Secondary blobs with signed kernel, dtb and other bootloaders that need to be written to specific partitions are needed for the Xavier NX (Forecr DSB)
        #dd if=$file_path of=${BALENA_RAW_IMG} conv=notrunc seek=$(expr ${START} \/ 512) bs=512
      fi
      START=$(expr ${END} \+ 1)
    done
}

# We leave this space way larger than currently
# needed because other larger partitions can be
# added from one Jetpack release to another
DEVICE_SPECIFIC_SPACE:jetson-xavier-nx-devkit-emmc = "458752"
device_specific_configuration:jetson-xavier-nx-devkit-emmc() {
    write_jetson_nx_partitions "partition_specification194_nxde.txt"
}

DEVICE_SPECIFIC_SPACE:jetson-xavier-nx-devkit = "458752"
device_specific_configuration:jetson-xavier-nx-devkit() {
    write_jetson_nx_partitions "partition_specification194_nxde_sdcard.txt"
}
