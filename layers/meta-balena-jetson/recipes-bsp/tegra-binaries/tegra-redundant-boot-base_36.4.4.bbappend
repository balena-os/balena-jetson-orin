# This package delays boot trying to mount
# the esp partition among others, let's remove
# it because we store both the UEFI bootloader
# and the capsule (when performing HUP) in the
# resin-boot partition
RDEPENDS:${PN}:remove = "setup-nv-boot-control-service"
