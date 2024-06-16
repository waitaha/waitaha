MODULES_AUTOLOAD_VERSION = 1.0
MODULES_AUTOLOAD_SITE = $(BR2_EXTERNAL_WAITAHA_PATH)/package/modules-autoload
MODULES_AUTOLOAD_SITE_METHOD = local
MODULES_AUTOLOAD_INSTALL_TARGET = YES

define MODULES_AUTOLOAD_INSTALL_TARGET_CMDS
    mkdir -p $(TARGET_DIR)/etc/sysconfig
    $(INSTALL) -D -m 755 $(MODULES_AUTOLOAD_SITE)/S02modules $(TARGET_DIR)/etc/init.d/S02modules
    echo $(BR2_PACKAGE_MODULES_AUTOLOAD_MODULES) | sed 's/ /\n/g' | sed -e '$$a\' > $(TARGET_DIR)/etc/sysconfig/modules
endef

$(eval $(generic-package))
