# Copyright (C) 2022 Paranoid Android
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

# Include GSI
$(call inherit-product, $(SRC_TARGET_DIR)/product/developer_gsi_keys.mk)

# Setup dalvik vm configs
$(call inherit-product, frameworks/native/build/phone-xhdpi-6144-dalvik-heap.mk)

# A/B
ifeq ($(TARGET_IS_VAB),true)
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/android_t_baseline.mk)
PRODUCT_VIRTUAL_AB_COMPRESSION_METHOD := lz4

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=ext4 \
    POSTINSTALL_OPTIONAL_vendor=true

PRODUCT_PACKAGES += \
    checkpoint_gc \
    otapreopt_script

PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-impl-qti \
    android.hardware.boot@1.2-impl-qti.recovery \
    android.hardware.boot@1.2-service

PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier
endif

# Attestation
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.device_id_attestation.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.device_id_attestation.xml

# Audio
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/configs/audio/,$(TARGET_COPY_OUT_VENDOR)/etc)

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/audio/audio/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/audio_policy_configuration.xml \
    $(LOCAL_PATH)/configs/audio/audio/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml

PRODUCT_PACKAGES += \
    android.hardware.audio.service

PRODUCT_ODM_PROPERTIES += \
    vendor.audio.feature.dynamic_ecns.enable=false \
    vendor.audio.offload.buffer.size.kb=256

PRODUCT_SYSTEM_PROPERTIES += \
    ro.config.vc_call_vol_steps=11

PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.audio.ozo.codec.enable=true \
    ro.audio.monitorRotation=true \
    ro.vendor.audio.afe.record=true \
    ro.vendor.audio.misound.bluetooth.enable=true \
    ro.vendor.audio.scenario.support=false \
    ro.vendor.audio.soundfx.type=mi \
    ro.vendor.audio.soundfx.usb=true \
    ro.vendor.audio.sfx.earadj=true \
    ro.vendor.audio.sfx.scenario=false \
    ro.vendor.audio.spk.clean=true \
    ro.vendor.audio.sos=true \
    ro.vendor.audio.surround.support=false \
    ro.vendor.audio.vocal.support=false \
    ro.vendor.audio.voice.change.support=true \
    ro.vendor.audio.voice.change.version=2 \
    vendor.audio.chk.cal.us=0

PRODUCT_VENDOR_PROPERTIES += \
    ro.vendor.audio.soundtrigger.appdefine.cnn.level=31 \
    ro.vendor.audio.soundtrigger.appdefine.gmm.level=55 \
    ro.vendor.audio.soundtrigger.appdefine.gmm.user.level=50 \
    ro.vendor.audio.soundtrigger.appdefine.vop.level=10 \
    ro.vendor.audio.soundtrigger.lowpower=true \
    ro.vendor.audio.soundtrigger.training.level=50 \
    ro.vendor.audio.soundtrigger.xanzn.cnn.level=70 \
    ro.vendor.audio.soundtrigger.xanzn.gmm.level=45 \
    ro.vendor.audio.soundtrigger.xanzn.gmm.user.level=30 \
    ro.vendor.audio.soundtrigger.xanzn.vop.level=10 \
    ro.vendor.audio.soundtrigger.xatx.cnn.level=27 \
    ro.vendor.audio.soundtrigger.xatx.gmm.level=50 \
    ro.vendor.audio.soundtrigger.xatx.gmm.user.level=40 \
    ro.vendor.audio.soundtrigger.xatx.vop.level=10 \
    ro.vendor.audio.soundtrigger=sva

# Bluetooth
PRODUCT_PRODUCT_PROPERTIES += \
    bluetooth.hardware.power.idle_cur_ma=7 \
    bluetooth.hardware.power.operating_voltage_mv=3700 \
    bluetooth.hardware.power.rx_cur_ma=75 \
    bluetooth.hardware.power.tx_cur_ma=93

PRODUCT_SYSTEM_EXT_PROPERTIES += \
    persist.sys.btsatck.absvolfeature=true \
    persist.vendor.service.bdroid.soc.alwayson=true

PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.bluetooth.modem_nv_support=true \
    persist.vendor.qcom.bluetooth.a2dp_offload_cap=sbc-aac-aptx-aptxhd-ldac \
    persist.vendor.qcom.bluetooth.aac_vbr_ctl.enabled=false \
    persist.vendor.qcom.bluetooth.enable.splita2dp=true \
    persist.vendor.qcom.bluetooth.scram.enabled=false \
    persist.vendor.qcom.bluetooth.soc=cherokee \
    persist.vendor.qcom.bluetooth.twsp_state.enabled=false \
    ro.vendor.bluetooth.wipower=false

# Camera
$(call inherit-product-if-exists, device/xiaomi/sm6225-common-miuicamera/config.mk)

PRODUCT_PACKAGES += \
    android.hardware.camera.provider@2.4-impl \
    android.hardware.camera.provider@2.4-service_64 \
    libcamera2ndk_vendor \
    libdng_sdk.vendor \
    libstdc++.vendor \
    vendor.qti.hardware.camera.device@1.0.vendor \
    vendor.qti.hardware.camera.postproc@1.0.vendor

PRODUCT_SYSTEM_PROPERTIES += \
    persist.vendor.camera.aon.cameraId=8 \
    persist.vendor.camera.aon8475.cameraId=9

PRODUCT_VENDOR_PROPERTIES += \
    camera.disable_zsl_mode=1

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.camera.full.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.full.xml \
    frameworks/native/data/etc/android.hardware.camera.raw.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.raw.xml

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/camera/camxoverridesettings.txt:$(TARGET_COPY_OUT_VENDOR)/etc/camera/camxoverridesettings.txt \
    $(LOCAL_PATH)/configs/camera/st_license.lic:$(TARGET_COPY_OUT_VENDOR)/etc/camera/st_license.lic

# Charger
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init/vendor.qti.hardware.charger_monitor@1.0-service.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/vendor.qti.hardware.charger_monitor@1.0-service.rc

PRODUCT_PRODUCT_PROPERTIES += \
    persist.vendor.quick.charge=1 \
    ro.charger.disable_init_blank=true

# Crypto
PRODUCT_VENDOR_PROPERTIES += \
    ro.crypto.allow_encrypt_override=true \
    ro.crypto.dm_default_key.options_format.version=2 \
    ro.crypto.volume.filenames_mode=aes-256-cts \
    ro.crypto.volume.metadata.method=dm-default-key

# Device Settings
PRODUCT_PACKAGES += \
    XiaomiParts

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/parts/privapp-permissions-parts.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/privapp-permissions-parts.xml

PRODUCT_VENDOR_PROPERTIES += \
    ro.audio.soundfx.dirac=true \
    persist.audio.dirac.speaker=true \
    persist.dirac.acs.controller=qem \
    persist.dirac.acs.storeSettings=1 \
    persist.dirac.acs.ignore_error=1

# Dex/ART optimization
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false
PRODUCT_DEX_PREOPT_DEFAULT_COMPILER_FILTER := everything
USE_DEX2OAT_DEBUG := false

# Display
PRODUCT_PACKAGES += \
    android.frameworks.displayservice@1.0.vendor

PRODUCT_VENDOR_PROPERTIES += \
    debug.sf.disable_backpressure=1 \
    debug.sf.layer_caching_active_layer_timeout_ms=1000 \
    debug.hwui.skia_atrace_enabled=false \
    ro.vendor.display.sensortype=2 \
    ro.vendor.display.svi=1 \
    vendor.display.idle_time=0 \
    vendor.display.idle_time_inactive=0 \
    vendor.display.qdcm.mode_combine=2 \
    vendor.display.svi.config=1 \
    vendor.display.svi.config_path=/vendor/etc/SVIConfig.xml

# DPM
PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.dpmhalservice.enable=1

# DRM
PRODUCT_PACKAGES += \
    android.hardware.drm@1.4.vendor \
    android.hardware.drm-service.clearkey

PRODUCT_VENDOR_PROPERTIES += \
    drm.service.enabled=true

# Enable Dynamic partition
PRODUCT_BUILD_SUPER_PARTITION := false
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Fastboot
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.1-impl-mock \
    fastbootd

# Fingerprint
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.fingerprint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.fingerprint.xml

PRODUCT_SYSTEM_PROPERTIES += \
    sys.fp.miui.token=0

# FM
BOARD_HAVE_QCOM_FM := true

# FRP
PRODUCT_VENDOR_PROPERTIES += \
    ro.frp.pst=/dev/block/bootdevice/by-name/frp

# FUSE passthrough
PRODUCT_PRODUCT_PROPERTIES += \
    persist.sys.fuse.passthrough.enable=true

# Graphics
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.opengles.aep.xml \
    frameworks/native/data/etc/android.hardware.vulkan.compute-0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.compute-0.xml \
    frameworks/native/data/etc/android.hardware.vulkan.level-1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.level-1.xml \
    frameworks/native/data/etc/android.hardware.vulkan.version-1_1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.version-1_1.xml \
    frameworks/native/data/etc/android.software.opengles.deqp.level-2020-03-01.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.opengles.deqp.level.xml \
    frameworks/native/data/etc/android.software.vulkan.deqp.level-2020-03-01.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.vulkan.deqp.level.xml

PRODUCT_VENDOR_PROPERTIES += \
   ro.hardware.egl=adreno \
   ro.hardware.vulkan=adreno \
   ro.opengles.version=196610

# GPS
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/gps/flp.conf:$(TARGET_COPY_OUT_VENDOR)/etc/flp.conf \
    $(LOCAL_PATH)/configs/gps/gps.conf:$(TARGET_COPY_OUT_VENDOR)/etc/gps.conf \
    $(LOCAL_PATH)/configs/gps/sap.conf:$(TARGET_COPY_OUT_VENDOR)/etc/sap.conf

# IDC
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/configs/idc/,$(TARGET_COPY_OUT_VENDOR)/usr/idc)

# Incremental FS
PRODUCT_VENDOR_PROPERTIES += \
    ro.incremental.enable=1

# Keylayout
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/configs/keylayout/,$(TARGET_COPY_OUT_VENDOR)/usr/keylayout)

# Media
PRODUCT_PACKAGES += \
    libavservices_minijail_vendor \
    libcodec2_soft_common.vendor \
    libsfplugin_ccodec_utils.vendor

PRODUCT_SYSTEM_EXT_PROPERTIES += \
    media.aac_51_output_enabled=true \
    media.stagefright.enable-aac=true \
    media.stagefright.enable-fma2dp=true \
    media.stagefright.enable-http=true \
    media.stagefright.enable-player=true \
    media.stagefright.enable-qcp=true \
    media.stagefright.enable-scan=true \
    mmp.enable.3g2=true \
    persist.mm.enable.prefetch=true

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/media/media_codecs.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml

# Netmgr
PRODUCT_SYSTEM_EXT_PROPERTIES += \
    persist.data.netmgrd.qos.enable=true

# Neural Networks
PRODUCT_PACKAGES += \
    android.hardware.neuralnetworks@1.3.vendor

# Overlays
PRODUCT_PACKAGES += \
    AOSPABengalFrameworksOverlay \
    BengalCarrierConfigOverlay \
    BengalFrameworksOverlay \
    BengalSettingsOverlay \
    BengalSystemUIOverlay \
    BengalWifiOverlay

# Perf
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/perf/msm_irqbalance.conf:$(TARGET_COPY_OUT_VENDOR)/etc/msm_irqbalance.conf \
    $(LOCAL_PATH)/configs/perf/perfboostsconfig.xml:$(TARGET_COPY_OUT_VENDOR)/etc/perf/perfboostsconfig.xml \
    $(LOCAL_PATH)/configs/perf/perfconfigstore.xml:$(TARGET_COPY_OUT_VENDOR)/etc/perf/perfconfigstore.xml

# Public libraries
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/public.libraries.txt:$(TARGET_COPY_OUT_VENDOR)/etc/public.libraries.txt
    
# Rootdir / Init files
PRODUCT_PACKAGES += \
    init.qti.dcvs.sh \
    init.qti.early_init.sh

PRODUCT_PACKAGES += \
    fstab.qcom \
    fstab.qcom_ramdisk \
    fstab.zram \
    init.bengal.rc \
    init.bengal.perf.rc \
    init.target.rc \
    init.xiaomi.fingerprint.rc \
    init.xiaomi.rc \
    ueventd.xiaomi.rc

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init/init.recovery.qcom.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.qcom.rc

# QC common
TARGET_BOARD_PLATFORM := bengal

TARGET_COMMON_QTI_COMPONENTS += \
    alarm \
    audio \
    av \
    bt \
    charging \
    display \
    gps \
    init \
    keymaster \
    media \
    overlay \
    perf \
    telephony \
    usb \
    vibrator \
    wfd \
    wlan

# QMI
PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.qcomsysd.enabled=1

# Radio
PRODUCT_PRODUCT_PROPERTIES += \
    rild.libpath=/vendor/lib64/libril-qc-hal-qmi.so

PRODUCT_SYSTEM_EXT_PROPERTIES += \
    ro.telephony.block_binder_thread_on_incoming_calls=false

PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.data.iwlan.enable=true \
    persist.vendor.radio.add_power_save=0 \
    persist.vendor.radio.atfwd.start=true \
    persist.vendor.radio.enable_temp_dds=true \
    persist.vendor.radio.force_on_dc=true \
    persist.vendor.radio.mt_sms_ack=30 \
    persist.vendor.radio.process_sups_ind=1 \
    ro.vendor.radio.features_common=3 \
    ro.vendor.se.type=HCE,UICC \
    sys.vendor.shutdown.waittime=500

# Sensors
PRODUCT_PACKAGES += \
    android.hardware.sensors@2.0-ScopedWakelock.vendor \
    android.hardware.sensors@2.1-service.xiaomi-multihal \
    android.frameworks.sensorservice@1.0 \
    android.frameworks.sensorservice@1.0.vendor \
    libsensorndkbridge

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.barometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.barometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepdetector.xml

PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.sensors.debug.ssc_qmi_debug=true \
    persist.vendor.sensors.enable.bypass_worker=true \
    persist.vendor.sensors.enable.rt_task=false \
    persist.vendor.sensors.hal_trigger_ssr=false \
    persist.vendor.sensors.support_direct_channel=false

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    hardware/xiaomi

# Storage.xml moment
PRODUCT_SYSTEM_PROPERTIES += \
    persist.sys.binary_xml=false

# Treble
PRODUCT_FULL_TREBLE_OVERRIDE := true

# Thermal
PRODUCT_VENDOR_PROPERTIES += \
    vendor.sys.thermal.data.path=/data/vendor/thermal/

# Time-services
PRODUCT_PRODUCT_PROPERTIES += \
    persist.timed.enable=true

# USB
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init/init.qcom.usb.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.qcom.usb.rc

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init/init.mi.usb.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.mi.usb.sh \
    $(LOCAL_PATH)/init/init.qcom.usb.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.qcom.usb.sh

ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.usb.config=mtp,adb
endif

# Verified Boot
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.verified_boot.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.verified_boot.xml

# VNDK
PRODUCT_EXTRA_VNDK_VERSIONS := 30

# WiFi
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/wifi/WCNSS_qcom_cfg.ini:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/WCNSS_qcom_cfg.ini

# WiFi Display
PRODUCT_PACKAGES += \
    libwfdaac_vendor:32

# WLAN
PRODUCT_PRODUCT_PROPERTIES += \
    ro.hardware.wlan.vendor=qcom

PRODUCT_VENDOR_PROPERTIES += \
    ro.hardware.wlan.dbs=0 \
    ro.telephony.iwlan_operation_mode=legacy

# Zygote
PRODUCT_SYSTEM_PROPERTIES += \
    zygote.critical_window.minute=10

# Inherit from vendor
$(call inherit-product, vendor/xiaomi/sm6225-common/sm6225-common-vendor.mk)
