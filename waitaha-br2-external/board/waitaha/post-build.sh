#!/bin/bash

append_dtb()
{
    local DTB_NAME="$(sed -n 's/^BR2_LINUX_KERNEL_INTREE_DTS_NAME="\(.*\)"$/\1/p' ${BR2_CONFIG})"
    local DTB_FILE="$(basename ${DTB_NAME})"
    local DTB_FILE_WITH_EXT="${DTB_FILE%.*}.dtb"

    # For whatever reason, LINUX_DIR is not exposed to post-build scripts and there is no way
    # to build an appended DTB for ARM64 in buildroot. This means we need to guess the linux
    # kernel directory. Our guess is the most recently modified file with the name of the DTB.
    local DTB_PATH="$(find ${BUILD_DIR} -type f -name ${DTB_FILE_WITH_EXT} -exec stat --format='%Y %n' {} + | sort -nr | cut -d' ' -f2-)"

    local IMAGE_FILE="${BINARIES_DIR}/Image.gz"
    local MERGED_FILE="${BINARIES_DIR}/Image.gz-dtb"

    cat $IMAGE_FILE $DTB_PATH > $MERGED_FILE
}

append_dtb $@
