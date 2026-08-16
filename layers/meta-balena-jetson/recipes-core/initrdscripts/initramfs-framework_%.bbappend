FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " \
    file://copy_jetson_artifacts.patch \
"

# We don't install the recovery module
# because these boards do have a debug uart port.
# However, we need to fix the missing libcre build failure:
RDEPENDS:initramfs-module-recovery:remove = "android-tools android-tools-adbd"
