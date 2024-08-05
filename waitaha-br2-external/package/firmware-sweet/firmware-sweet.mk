FIRMWARE_SWEET_VERSION = 1.0
FIRMWARE_SWEET_SITE = $(BR2_EXTERNAL_WAITAHA_PATH)/package/firmware-sweet
FIRMWARE_SWEET_SITE_METHOD = local
FIRMWARE_SWEET_INSTALL_TARGET = YES

define FIRMWARE_SWEET_INSTALL_TARGET_CMDS
    mkdir -p $(TARGET_DIR)/lib/firmware/qcom/sm7150/sweet/
    $(INSTALL) -D -m 644 $(FIRMWARE_SWEET_SITE)/*.mbn $(TARGET_DIR)/lib/firmware/qcom/sm7150/sweet/
endef

$(eval $(generic-package))
