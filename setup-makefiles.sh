#!/bin/bash
#
# SPDX-FileCopyrightText: 2016 The CyanogenMod Project
# SPDX-FileCopyrightText: 2017-2024 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

set -e

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

export TARGET_ENABLE_CHECKELF=true

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

function vendor_imports() {
    cat <<EOF >>"$1"
        "device/xiaomi/sm6225-common",
        "hardware/qcom/display",
        "hardware/qcom/display/gralloc",
        "hardware/qcom/display/libdebug",
        "hardware/xiaomi"
EOF
}

function lib_to_package_fixup_vendor_variants() {
    if [ "$2" != "vendor" ]; then
        return 1
    fi
    case "$1" in
            com.qualcomm.qti.dpm.api@1.0 | \
            com.qualcomm.qti.imscmservice@2.0 | \
            com.qualcomm.qti.imscmservice@2.1 | \
            com.qualcomm.qti.imscmservice@2.2 | \
            com.qualcomm.qti.uceservice@2.0 | \
            com.qualcomm.qti.uceservice@2.1 | \
            com.qualcomm.qti.uceservice@2.2 | \
            com.qualcomm.qti.uceservice@2.3 | \
            libmmosal | \
            vendor.qti.data.factory@2.0 | \
            vendor.qti.data.factory@2.1 | \
            vendor.qti.data.factory@2.2 | \
            vendor.qti.data.factory@2.3 | \
            vendor.qti.data.mwqem@1.0 | \
            vendor.qti.data.slm@1.0 | \
            vendor.qti.diaghal@1.0 | \
            vendor.qti.hardware.wifidisplaysession@1.0 | \
            vendor.qti.imsrtpservice@3.0)
            echo "$1_vendor"
            ;;
            libOmxCore | \
            libwpa_client)
            # Android.mk only packages
            ;;
        *)
            return 1
            ;;
    esac
}

function lib_to_package_fixup() {
    lib_to_package_fixup_clang_rt_ubsan_standalone "$1" ||
    lib_to_package_fixup_proto_3_9_1 "$1" ||
    lib_to_package_fixup_vendor_variants "$@"
}

# Initialize the helper for common
setup_vendor "${DEVICE_COMMON}" "${VENDOR_COMMON:-$VENDOR}" "${ANDROID_ROOT}" true

# Warning headers and guards
write_headers "citrus fog lime spes"

# The standard common blobs
write_makefiles "${MY_DIR}/proprietary-files.txt" true

# Finish
write_footers

if [ -s "${MY_DIR}/../../${VENDOR}/${DEVICE}/proprietary-files.txt" ]; then
    # Reinitialize the helper for device
    source "${MY_DIR}/../../${VENDOR}/${DEVICE}/setup-makefiles.sh"
    setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" false

    # Warning headers and guards
    write_headers

    # The standard device blobs
    write_makefiles "${MY_DIR}/../../${VENDOR}/${DEVICE}/proprietary-files.txt" true

    # Finish
    write_footers
fi
