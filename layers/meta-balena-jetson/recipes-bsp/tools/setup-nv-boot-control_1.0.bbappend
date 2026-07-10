do_compile:append() {
    # /etc/ is read-only but /run/ is tmpfs, so we can let the boot control script create the symlink target in /run/
    sed -i 's:^\[ ! -e "$controlfile" \] || exit 0:# &\nmkdir -p /run/nv_boot_control/ \&\& touch /run/nv_boot_control/nv_boot_control.conf:' ${B}/setup-nv-boot-control.sh
}
