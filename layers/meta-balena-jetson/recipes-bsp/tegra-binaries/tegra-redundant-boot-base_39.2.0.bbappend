# This package delays boot trying to mount
# the esp partition among others, let's remove
# it because we can dinamically mount the esp
# partition if needed
RDEPENDS:${PN}:remove = "setup-nv-boot-control-service"
