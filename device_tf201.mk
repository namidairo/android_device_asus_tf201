# Copyright (C) 2011 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# The gps config appropriate for this device
$(call inherit-product, device/common/gps/gps_us_supl.mk)

$(call inherit-product-if-exists, vendor/asus/tf201/tf201-vendor.mk)

DEVICE_PACKAGE_OVERLAYS += device/asus/tf201/overlay

# Files needed for boot/recovery image
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/ramdisk/init.cardhu.rc:root/init.cardhu.rc\
    $(LOCAL_PATH)/ramdisk/ueventd.cardhu.rc:root/ueventd.cardhu.rc \
    $(LOCAL_PATH)/ramdisk/init.cardhu.usb.rc:root/init.cardhu.usb.rc \
    $(LOCAL_PATH)/ramdisk/init.cardhu.cpu.rc:root/init.cardhu.cpu.rc \
    $(LOCAL_PATH)/ramdisk/fstab.cardhu:root/fstab.cardhu \
    $(LOCAL_PATH)/recovery/init.recovery.cardhu.rc:root/init.recovery.cardhu.rc


# Prebuilt configeration files
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilt/cpu.sh:system/bin/cpu.sh \
    $(LOCAL_PATH)/prebuilt/gpsconfig.xml:system/etc/gps/gpsconfig.xml \
    $(LOCAL_PATH)/prebuilt/wpa_supplicant_overlay.conf:system/etc/wifi/wpa_supplicant_overlay.conf \
    $(LOCAL_PATH)/bluetooth/bt_vendor.conf:system/etc/bluetooth/bt_vendor.conf

# Input device configeration files
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/idc/atmel-maxtouch.idc:system/usr/idc/atmel-maxtouch.idc \
    $(LOCAL_PATH)/idc/elantech_touchscreen.idc:system/usr/idc/elantech_touchscreen.idc \
    $(LOCAL_PATH)/idc/panjit_touch.idc:system/usr/idc/panjit_touch.idc \
    $(LOCAL_PATH)/prebuilt/asusdec.kcm:system/usr/keychars/asusdec.kcm \
    $(LOCAL_PATH)/prebuilt/asusdec.kl:system/usr/keylayout/asusdec.kl \
    $(LOCAL_PATH)/prebuilt/gpio-keys.kl:system/usr/keylayout/gpio-keys.kl \
    $(LOCAL_PATH)/prebuilt/tegra-kbc.kl:system/usr/keylayout/tegra-kbc.kl

# These are the hardware-specific features
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.location.xml:system/etc/permissions/android.hardware.location.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:system/etc/permissions/android.software.live_wallpaper.xml \
    $(LOCAL_PATH)/asusdec/com.cyanogenmod.asusdec.xml:system/etc/permissions/com.cyanogenmod.asusdec.xml

# Build characteristics setting 
PRODUCT_CHARACTERISTICS := tablet

# This device have enough room for precise davick
PRODUCT_TAGS += dalvik.gc.type-precise

# Extra packages to build for this device
PRODUCT_PACKAGES += \
    librs_jni \
    make_ext4fs \
    setup_fs \
    libaudioutils \
    libinvensense_mpl \
    AutoParts_tfp \
    blobpack_tfp \
    mischelp \
    tinymix \
    tinyplay \
    tinyrec \
    wifimacwriter \
    gps.tegra \
    com.cyanogenmod.asusdec \
    libasusdec_jni

# Camera
PRODUCT_PROPERTY_OVERRIDES += \
    camera2.portability.force_api=1

# Filesystem
PRODUCT_PACKAGES += \
    e2fsck \
    fibmap.f2fs \
    fsck.f2fs \
    make_ext4fs \
    mkfs.f2fs \
    resize2fs \
    setup_fs \
    make_f2fs \
    mff2fsuserimg.sh

# Audio
PRODUCT_PACKAGES += \
    audio.primary.tegra \
    audio_policy.tegra \
    audio.a2dp.default \
    audio.usb.default \
    audio.r_submix.default \
    com.android.future.usb.accessory

# Wifi
PRODUCT_PACKAGES += \
    hostapd \
    dhcpcd.conf \
    wpa_supplicant \
    wpa_supplicant.conf

BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
$(warning "USING F2FS for userdata")

# This ensures the needed build tools are available.
# TODO: make non-linux builds happy with external/f2fs-tool; system/extras/f2fs_utils
ifeq ($(HOST_OS),linux)
TARGET_USERIMAGES_USE_F2FS := true
endif

# Propertys specific for this device
PRODUCT_PROPERTY_OVERRIDES := \
    wifi.interface=wlan0 \
    wifi.supplicant_scan_interval=15 \
    ro.opengles.version=131072 \
    persist.sys.usb.config=mtp,adb \
    ro.sf.lcd_density=160 \
    ro.zygote.disable_gl_preload=true \
    ro.bq.gpu_to_cpu_unsupported=1

# Tegra 3 specific overrides
PRODUCT_PROPERTY_OVERRIDES += \
    persist.tegra.nvmmlite=1 \
    tf.enable=y

# Prime specific overrides
PRODUCT_PROPERTY_OVERRIDES += \
    ro.epad.model=TF201 \
    ro.epad.model_id=00 \
    ro.product.model=TF201 \

# Media files
PRODUCT_COPY_FILES += \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:system/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_telephony.xml:system/etc/media_codecs_google_telephony.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:system/etc/media_codecs_google_video.xml \
    frameworks/av/media/libstagefright/data/media_codecs_ffmpeg.xml:system/etc/media_codecs_ffmpeg.xml \
    device/asus/tf201/media_codecs.xml:system/etc/media_codecs.xml \
    device/asus/tf201/media_profiles.xml:system/etc/media_profiles.xml

# SELINUX Defines
BOARD_SEPOLICY_DIRS := \
    device/asus/tf201/sepolicy

BOARD_SEPOLICY_UNION += \
    file_contexts \
    property_contexts \
    service_contexts \
    genfs_contexts \
    bluetooth.te \
    device.te \
    domain.te \
    drmserver.te \
    file.te \
    gpsd.te \
    init.te \
    init_shell.te \
    keystore.te \
    lmkd.te \
    mediaserver.te \
    property.te \
    recovery.te \
    rild.te \
    sensors_config.te \
    surfaceflinger.te \
    system_app.te \
    system_server.te \
    ueventd.te \
    vold.te

# audio policy configuration
PRODUCT_COPY_FILES += \
    device/asus/tf201/audio_policy.conf:system/etc/audio_policy.conf

# Inherit tablet dalvik settings
$(call inherit-product, frameworks/native/build/tablet-7in-hdpi-1024-dalvik-heap.mk)

# Call the vendor to setup propiatory files
$(call inherit-product-if-exists, vendor/asus/tf201/tf201-vendor.mk)

# Copy bcm4329 firmware
$(call inherit-product-if-exists, hardware/broadcom/wlan/bcmdhd/firmware/bcm4329/device-bcm.mk)

# Device naming
PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0
PRODUCT_NAME := tf201
PRODUCT_DEVICE := tf201
PRODUCT_MODEL := tf201
PRODUCT_BRAND := asus
PRODUCT_MANUFACTURER := asus
