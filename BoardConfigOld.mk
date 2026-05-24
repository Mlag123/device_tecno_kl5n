#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#
# Послание предкам, эту фиговину делал mlag, да потому что он безработный, без одно-зубый и делаю это я ночью, да и вообще у меня много времени, а ваз 2107 потихоньку плачет без меня, и ждёт когда я сделаю электростеклоподьемник
#
# Я это делаю уже около 8 часов, и да.. Если я свихнусь с этих бесконечных ошибок компиляции и застать меня в расплох, то я буду разговаривать словами по i2c

DEVICE_PATH := device/tecno/kl5n
VENDOR_PATH := vendor/tecno/kl5n

# A/B
AB_OTA_UPDATER := true

#тут вопросы есть, но потом - причина, нужно узнать точно все разделы на телефоне и вписать их сюда.
#AB_OTA_PARTITIONS += boot vendor_boot dtbo vbmeta system system_ext vendor product odm_dlkm vendor_dlkm - было
#стало
AB_OTA_PARTITIONS += boot vendor_boot dtbo vbmeta system system_ext vendor product

BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true

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

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := TECNO-KL5n
TARGET_NO_BOOTLOADER := true

# Display
TARGET_SCREEN_DENSITY := 320

#fixes
#PRODUCT_OTA_ENFORCE_VINTF_KERNEL_REQUIREMENTS := false

# Build hacks
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
BUILD_BROKEN_VERIFY_USES_LIBRARIES := true
BUILD_BROKEN_NOTICE_RULES := true
SELINUX_IGNORE_NEVERALLOWS := true

#Kernel

# DTBO
BOARD_KERNEL_SEPARATED_DTBO := true

# Kernel
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

BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)
BOARD_MKBOOTIMG_ARGS += --vendor_cmdline $(BOARD_VENDOR_CMDLINE)
BOARD_MKBOOTIMG_ARGS += --pagesize $(BOARD_PAGE_SIZE) --board ""
BOARD_MKBOOTIMG_ARGS += --kernel_offset $(BOARD_KERNEL_OFFSET)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --dtb_offset $(BOARD_DTB_OFFSET)






#check this, maybe this prop caused error,файла нет задоккументирую нахрен, так-как этого файла нет
#TARGET_KERNEL_CONFIG := kl5n_defconfig 



#Kernel test prebuilt
#TARGET_FORCE_PREBUILT_KERNEL := true
#TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilts/kernel
#TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilts/dtb.img
#BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)
#BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilts/dtbo.img

# test, добавляет dtb.img в boot.img
#BOARD_INCLUDE_DTB_IN_BOOTIMG := true
#
#BOARD_KERNEL_SEPARATED_DTBO := false
#BOARD_PREBUILT_DTBIMAGE_DIR := $(DEVICE_PATH)/prebuilts - unsupported


# Partitions - вопрос хороший, всё ли нормально по размерам и разделам?
BOARD_FLASH_BLOCK_SIZE := 262144 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_BOOTIMAGE_PARTITION_SIZE := 33554432
BOARD_DTBOIMG_PARTITION_SIZE := 8388608
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_SUPER_PARTITION_GROUPS := tecno_dynamic_partitions


#было
#BOARD_SUPER_PARTITION_SIZE := 9126805504 # TODO: Fix hardcoded value
#BOARD_TECNO_DYNAMIC_PARTITIONS_PARTITION_LIST := system system_ext vendor product odm_dlkm vendor_dlkm
#BOARD_TECNO_DYNAMIC_PARTITIONS_SIZE := 9122611200 # TODO: Fix hardcoded value
#стало
BOARD_SUPER_PARTITION_SIZE := 8589934592 # TODO: Fix hardcoded value
BOARD_TECNO_DYNAMIC_PARTITIONS_PARTITION_LIST := system system_ext vendor product
BOARD_TECNO_DYNAMIC_PARTITIONS_SIZE := 8587837440   # TODO: Fix hardcoded value

# Platform
TARGET_BOARD_PLATFORM := mt6768

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
BUILD_BROKEN_VERIFY_USES_LIBRARIES := true
SELINUX_IGNORE_NEVERALLOWS := true
#BOARD_VENDOR_SEPOLICY_DIRS :=

# Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3
# "testkey_rsa4096.pem" - откуда это? Из самих исходников андройд? Не буду комментировать пока не выясню.
BOARD_AVB_VENDOR_BOOT_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_VENDOR_BOOT_ALGORITHM := SHA256_RSA4096
BOARD_AVB_VENDOR_BOOT_ROLLBACK_INDEX := 1
BOARD_AVB_VENDOR_BOOT_ROLLBACK_INDEX_LOCATION := 1

# VINTF - тут вопросов нет.
DEVICE_MANIFEST_FILE += $(VENDOR_PATH)/etc/vintf/manifest.xml
DEVICE_MATRIX_FILE   += $(VENDOR_PATH)/etc/vintf/compatibility_matrix.xml



# Inherit the proprietary files - тут вопросов нет.
include $(VENDOR_PATH)/BoardConfigVendor.mk
