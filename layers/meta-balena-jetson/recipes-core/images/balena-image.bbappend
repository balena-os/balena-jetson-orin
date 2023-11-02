include balena-image.inc

do_image:balenaos-img[depends] += " tegra-flash-dry:do_deploy"

# Leave some space, just in case future L4Ts add device specific partitions
# All values are in KiB
DEVICE_SPECIFIC_SPACE:jetson-agx-orin-devkit = "331776"
DEVICE_SPECIFIC_SPACE:jetson-orin-nx-xavier-nx-devkit = "331776"
DEVICE_SPECIFIC_SPACE:jetson-orin-nano-devkit-nvme = "598016"

BALENA_BOOT_SIZE:jetson-orin-nx-xavier-nx-devkit = "121440"
BALENA_BOOT_SIZE:jetson-orin-nano-devkit-nvme = "121440"


IMAGE_ROOTFS_SIZE:jetson-agx-orin-devkit = "1003520"
IMAGE_ROOTFS_SIZE:jetson-orin-nx-xavier-nx-devkit = "983040"
IMAGE_ROOTFS_SIZE:jetson-orin-nano-devkit-nvme = "733184"

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
        else
            dd if=/dev/zero of=${BALENA_RAW_IMG} conv=notrunc seek=${START} bs=512 count=${part_size}
      fi
      START=$(expr ${END} \+ 1)
    done
} 

device_specific_configuration:jetson-orin-nano-devkit-nvme() {
    partitions=$(cat ${DEPLOY_DIR_IMAGE}/tegra-binaries/partition_specification234_orin_nano.txt)
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
        else
            dd if=/dev/zero of=${BALENA_RAW_IMG} conv=notrunc seek=${START} bs=512 count=${part_size}
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
        else
            dd if=/dev/zero of=${BALENA_RAW_IMG} conv=notrunc seek=${START} bs=512 count=${part_size}
        fi
        START=$(expr ${END} \+ 1)
    done
}
