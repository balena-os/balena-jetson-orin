# This package delays boot trying to mount
# the esp partition among others, let's remove
# it because we dinamically mount the esp
# partition only when we need to update
# the L4T launcher or the UEFI capsule,
# both being done during HUP
RDEPENDS:${PN}:remove = "setup-nv-boot-control-service"
