#!/bin/bash

generate_recovery_img()
{
    # First argument is images dir
    shift

    # Create output directory if it does not exist already
    out_dir="${BR2_EXTERNAL_WAITAHA_PATH}/../out"
    mkdir -p "$out_dir"

    mkbootimg \
        --kernel "${BINARIES_DIR}/Image.gz-dtb" \
        --ramdisk "${BINARIES_DIR}/rootfs.cpio.gz" \
        --output "${out_dir}/recovery.img" \
        $@
}

generate_recovery_img $@
