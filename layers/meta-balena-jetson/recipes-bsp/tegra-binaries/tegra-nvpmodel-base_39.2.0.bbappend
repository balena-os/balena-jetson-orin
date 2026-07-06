do_install:append:tegra264() {
    sed -i "s/\(gpu_pg_mask_param=\)[^ ]*/\1512/" ${D}/opt/nvidia/l4t-gpusetup/gpu_pg_mask
    cp ${D}/opt/nvidia/l4t-gpusetup/gpu_pg_mask ${D}/opt/nvidia/l4t-gpusetup/gpu_pg_mask.tmp
}
