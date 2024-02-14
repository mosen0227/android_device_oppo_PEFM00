#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Omni stuff.
$(call inherit-product, vendor/omni/config/common.mk)

# Inherit from PEFM00 device
$(call inherit-product, device/oppo/PEFM00/device.mk)

PRODUCT_DEVICE := PEFM00
PRODUCT_NAME := omni_PEFM00
PRODUCT_BRAND := OPPO
PRODUCT_MODEL := PEFM00
PRODUCT_MANUFACTURER := oppo

PRODUCT_GMS_CLIENTID_BASE := android-google

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="full_oppo6765-user 10 QP1A.190711.020 bedd37e98646d3a1 release-keys"

BUILD_FINGERPRINT := OPPO/omni_PEFM00/PEFM00:16.1.0/QQ3A.200805.001/runner03232106:eng/test-keys
