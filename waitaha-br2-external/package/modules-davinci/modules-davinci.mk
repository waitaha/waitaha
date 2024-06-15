MODULES_DAVINCI_VERSION = 1.0
MODULES_DAVINCI_SITE = $(BR2_EXTERNAL_WAITAHA_PATH)/package/modules-davinci
MODULES_DAVINCI_SITE_METHOD = local
MODULES_DAVINCI_INSTALL_TARGET = YES

define MODULES_DAVINCI_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 644 $(MODULES_DAVINCI_SITE)/modules.conf $(TARGET_DIR)/etc/modules-load.d/modules.conf
endef

$(eval $(generic-package))