FILESEXTRAPATHS:prepend := "${THISDIR}/files:"


SRC_URI:append:jetson-orin-nx-seeed-j4012 = " \
    file://nvmewait \
"

PACKAGES:append:jetson-orin-nx-seeed-j4012 = " \
    initramfs-module-nvme-wait \
"

do_install:append:jetson-orin-nx-seeed-j4012() {
    install -m 0755 ${WORKDIR}/nvmewait ${D}/init.d/02-nvmewait
}

# Run this script after 01-udev
# to ensure nvme partition symlinks
# are populated in /dev/disk/by-label
# prior to running fsck. This because
# the Nvidia OOT drivers take a bit
# longer to initialize on the J4012
# and fsck may not run on all partitions
SUMMARY:initramfs-module-nvme-wait = "Wait for nvme devices to initialize after pcie and nvme oot drivers are loaded"
RDEPENDS:initramfs-module-nvme-wait = "${PN}-base"
FILES:initramfs-module-nvme-wait = "/init.d/02-nvmewait"
