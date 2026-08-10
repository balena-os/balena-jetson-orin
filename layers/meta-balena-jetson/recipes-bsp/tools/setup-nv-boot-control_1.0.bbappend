TNSPEC_MACHINE:jetson-agx-orin-devkit = "jetson-agx-orin-devkit"
TNSPEC_MACHINE:jetson-agx-orin-devkit-64gb = "jetson-agx-orin-devkit"
TNSPEC_MACHINE:forecr-dsb-ornx-orin-nano-8gb = "jetson-orin-nano-devkit-super"
TNSPEC_MACHINE:jetson-orin-nano-devkit-nvme = "jetson-orin-nano-devkit-super"
TNSPEC_MACHINE:jetson-orin-nano-seeed-j3010 = "recomputer-orin-super-j401"
TNSPEC_MACHINE:jetson-orin-nx-seeed-j4012 = "recomputer-orin-j401"
TNSPEC_MACHINE:jetson-orin-nx-xavier-nx-devkit = "jetson-orin-nano-devkit-super"

do_compile:append() {
    # /etc/ is read-only but /run/ is tmpfs, so we can let the boot control script create the symlink target in /run/
    sed -i 's:^\[ ! -e "$controlfile" \] || exit 0:# &\nmkdir -p /run/nv_boot_control/ \&\& touch /run/nv_boot_control/nv_boot_control.conf:' ${B}/setup-nv-boot-control.sh
}
