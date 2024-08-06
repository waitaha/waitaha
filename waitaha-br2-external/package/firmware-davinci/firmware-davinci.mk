FIRMWARE_DAVINCI_VERSION = 1.0
FIRMWARE_DAVINCI_SITE = $(BR2_EXTERNAL_WAITAHA_PATH)/package/firmware-davinci
FIRMWARE_DAVINCI_SITE_METHOD = local
FIRMWARE_DAVINCI_INSTALL_TARGET = YES

define FIRMWARE_DAVINCI_INSTALL_TARGET_CMDS
    mkdir -p $(TARGET_DIR)/lib/firmware/qcom/sm7150/davinci/
    $(INSTALL) -D -m 644 $(FIRMWARE_DAVINCI_SITE)/*.mbn $(TARGET_DIR)/lib/firmware/qcom/sm7150/davinci/
endef

define FIRMWARE_DAVINCI_INSTALL_INIT_SYSV
	$(INSTALL) -Dm755 $(FIRMWARE_DAVINCI_SITE)/modem-up.initd $(TARGET_DIR)/etc/init.d/S72modem
endef

$(eval $(generic-package))
