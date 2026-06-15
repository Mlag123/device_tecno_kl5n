#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#
# Послание предкам, эту фиговину делал mlag, да потому что он безработный, без одно-зубый и делаю это я ночью, да и вообще у меня много времени, а ваз 2107 потихоньку плачет без меня, и ждёт когда я сделаю электростеклоподьемник
#
# Я это делаю уже около 8 часов, и да.. Если я свихнусь с этих бесконечных ошибок компиляции и застать меня в расплох, то я буду разговаривать словами по i2c

DEVICE_PATH := device/tecno/kl5n
VENDOR_PATH := vendor/tecno/kl5n


# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 := 
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a53

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a53

TARGET_BOARD_PLATFORM := mt6768


# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := TECNO-KL5n
TARGET_NO_BOOTLOADER := true

# Display
TARGET_SCREEN_DENSITY := 320

#Broken rules
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
BUILD_BROKEN_VENDOR_PROPERTY_NAMESPACE := true


#Kernel
BOARD_KERNEL_SEPARATED_DTBO := false
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilts/dtbo.img
TARGET_NO_KERNEL := true
BOARD_RAMDISK_USE_LZ4 := true
TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilts/dtb.img

TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilts/kernel
TARGET_FORCE_PREBUILT_KERNEL := true


BOARD_BOOT_HEADER_VERSION := 4
BOARD_KERNEL_BASE := 0x40078000
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_KERNEL_TAGS_OFFSET := 0x0bc08000
BOARD_PAGE_SIZE := 4096
BOARD_TAGS_OFFSET := 0x0bc08000
BOARD_RAMDISK_OFFSET := 0x07c08000
BOARD_DTB_SIZE := 161454
BOARD_DTB_OFFSET := 0x0bc08000
BOARD_VENDOR_BASE := 0x40078000
BOARD_VENDOR_CMDLINE := bootopt=64S3,32N2,64N2

#Partitions

BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)
BOARD_MKBOOTIMG_ARGS += --vendor_cmdline $(BOARD_VENDOR_CMDLINE)
BOARD_MKBOOTIMG_ARGS += --pagesize $(BOARD_PAGE_SIZE) --board ""
BOARD_MKBOOTIMG_ARGS += --kernel_offset $(BOARD_KERNEL_OFFSET)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --dtb_offset $(BOARD_DTB_OFFSET)

BOARD_FLASH_BLOCK_SIZE := 262144 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_BOOTIMAGE_PARTITION_SIZE := 33554432
BOARD_DTBOIMG_PARTITION_SIZE := 8388608
#BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_SUPER_PARTITION_GROUPS := tecno_dynamic_partitions


# Partition paths
TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_SYSTEM_EXT := system_ext
TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_ODM := odm
TARGET_COPY_OUT_VENDOR_DLKM := vendor_dlkm
TARGET_COPY_OUT_SYSTEM_DLKM := system_dlkm
TARGET_COPY_OUT_ODM_DLKM := odm_dlkm
# SYSTEM_DLKM filesystem type
BOARD_SYSTEM_DLKMIMAGE_FILE_SYSTEM_TYPE := ext4
# ODM filesystem type
BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_ODM_DLKMIMAGE_FILE_SYSTEM_TYPE := ext4

# Partition file type
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_USERIMAGES_USE_F2FS := true
BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE := ext4

#стало
BOARD_SUPER_PARTITION_SIZE := 8589934592 # TODO: Fix hardcoded value
BOARD_TECNO_DYNAMIC_PARTITIONS_PARTITION_LIST := system system_ext vendor product
BOARD_TECNO_DYNAMIC_PARTITIONS_SIZE := 8587837440   # TODO: Fix hardcoded value



# VNDK
BOARD_VNDK_VERSION := current

# RIL
ENABLE_VENDOR_RIL_SERVICE := true


# Properties, ну тут базару нет, всё есть.
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop
TARGET_PRODUCT_PROP += $(DEVICE_PATH)/product.prop
TARGET_SYSTEM_EXT_PROP += $(DEVICE_PATH)/system_ext.prop
TARGET_SYSTEM_DLKM_PROP += $(DEVICE_PATH)/system_dlkm.prop
TARGET_ODM_PROP += $(DEVICE_PATH)/odm.prop
TARGET_ODM_DLKM_PROP += $(DEVICE_PATH)/odm_dlkm.prop
TARGET_VENDOR_DLKM_PROP += $(DEVICE_PATH)/vendor_dlkm.prop

# Recovery - fstab.enableswap_wb существует, вопросов нет
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/rootdir/etc/fstab.enableswap_wb
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Security patch level
VENDOR_SECURITY_PATCH := 2025-04-05


#selinux
#BUILD_BROKEN_VERIFY_USES_LIBRARIES := true
#SELINUX_IGNORE_NEVERALLOWS := true
#BOARD_VENDOR_SEPOLICY_DIRS :=

# Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3
# "testkey_rsa4096.pem" - откуда это? Из самих исходников андройд? Не буду комментировать пока не выясню.
#BOARD_AVB_VENDOR_BOOT_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
#BOARD_AVB_VENDOR_BOOT_ALGORITHM := SHA256_RSA4096
#BOARD_AVB_VENDOR_BOOT_ROLLBACK_INDEX := 1
#BOARD_AVB_VENDOR_BOOT_ROLLBACK_INDEX_LOCATION := 1

# VINTF - тут вопросов нет.
DEVICE_MANIFEST_FILE += $(VENDOR_PATH)/proprietary/vendor/etc/vintf/manifest.xml
DEVICE_MATRIX_FILE   += $(VENDOR_PATH)/proprietary/vendor/etc/vintf/compatibility_matrix.xml



# Inherit the proprietary files - тут вопросов нет.
include $(VENDOR_PATH)/BoardConfigVendor.mk
WITHOUT_WEBVIEW := true
BUILD_BROKEN_MISSING_REQUIRED_MODULES := true


# Vendor
#PRODUCT_BUILD_VENDOR_BOOT_IMAGE := false
#TARGET_NO_VENDOR_BOOT := true old
BOARD_USES_VENDOR_RAMDISK := false
