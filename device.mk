#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

#коль я умный, добавлю переменную

VENDOR_PATH := vendor/tecno/kl5n/
DEVICE_PATH := device/tecno/kl5n

# Enable updating of APEXes - SRC_TARGET_DIR - откуда он? Что в этой переменной/ссылке опеределено? Что то из исходников самого андройда? Не ясно.
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# A/B
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)





AB_OTA_UPDATER := true
AB_OTA_PARTITIONS := \
    boot \
    product \
    system \
    system_ext \
    vbmeta \
    vbmeta_system \
    vbmeta_vendor \
    vendor \
    vendor_boot \
    vendor_dlkm

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=$(BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE) \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=$(BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE) \
    POSTINSTALL_OPTIONAL_vendor=true








# android.hardware.boot@1.2-impl - отсутсвует
#android.hardware.boot@1.2-impl.recovery  - отсуствует.
#android.hardware.boot@1.2-service - присутсвует, аж их две.

PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-impl \
    android.hardware.boot@1.2-impl.recovery \
    android.hardware.boot@1.2-service


# update_engine из андройда
#update_engine_sideload - из андройда
#update_verifier - из андройда
#подозрения сняты - к расстрелу не подлежат (комментированию)
PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier


# checkpoint_gc - отсутсвует.
# otapreopt_script - отсутсвует, комментируем
#PRODUCT_PACKAGES += \
#    checkpoint_gc \
#    otapreopt_script

# API levels
PRODUCT_SHIPPING_API_LEVEL := 34

# fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.1-impl-mock \
    fastbootd

# Health
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl \
    android.hardware.health@2.1-service

# Kernel
PRODUCT_ENABLE_UFFD_GC := true

# Overlays - вопросов нет
PRODUCT_ENFORCE_RRO_TARGETS := *

# Partitions - ну конечно юзать, у меня динамические разделы.
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Product characteristics - ну тут ясно
PRODUCT_CHARACTERISTICS := default

# Rootdir
PRODUCT_PACKAGES += \
    init.insmod.sh \
    init.spd_cpu_set.sh \
    init.tran_mcf.sh \
	
	
#добавляем app #	GoogleTetheringResOverlay 
#PRODUCT_PACKAGES += \
#	InProcessTetheringResOverlay \
#	NetworkStackGoogleResOverlay \
#	NetworkStackInProcessResOverlay \
#	NetworkStackResOverlay \
#	TetheringResOverlay



# fstab.enableswap_wb - поискал его через ls -R | grep "fstab.enableswap_wb"  - встречается дважды - пока не выяснил где.
# factory_init.connectivity.common.rc  - аналогично первому
# factory_init.connectivity.rc  аналогично первому
# да и вообще все они по два раза встречаются
#Вопросов нет
PRODUCT_PACKAGES += \
    fstab.enableswap_wb \
    factory_init.connectivity.common.rc \
    factory_init.connectivity.rc \
    factory_init.project.rc \
    factory_init.rc \
    init.aee.rc \
    init.ago.rc \
    init.cgroup.rc \
    init.connectivity.common.rc \
    init.connectivity.rc \
    init.modem.rc \
    init.mt6768.rc \
    init.mt6768.usb.rc \
    init.mtkgki.rc \
    init.project.rc \
    init.sensor_1_0.rc \
    init_connectivity.rc \
    meta_init.connectivity.common.rc \
    meta_init.connectivity.rc \
    meta_init.modem.rc \
    meta_init.project.rc \
    meta_init.rc \
    meta_init.vendor.rc \
    multi_init.rc 


# Vendor boot
PRODUCT_BUILD_VENDOR_BOOT_IMAGE := false


# Temporarily disable SELinux for bringup, SELinux off
PRODUCT_PROPERTY_OVERRIDES += \
    ro.boot.selinux=permissive

# first_stage_ramdisk - отсвутвует, дёрную либо с дампа прошивки, либо дёрну его с device_tree_kl5n_twrp, оно там есть. Вызовет ли PRODUCT_COPY_FILES ошибку?
#PRODUCT_COPY_FILES += \
 #   $(LOCAL_PATH)/rootdir/etc/fstab.enableswap_wb:$(TARGET_VENDOR_RAMDISK_OUT)/first_stage_ramdisk/fstab.enableswap_wb

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Inherit the proprietary files
$(call inherit-product, $(VENDOR_PATH)/kl5n-vendor.mk)
