WAITAHA_UI_VERSION = 1.0
WAITAHA_UI_SITE = $(BR2_EXTERNAL_WAITAHA_PATH)/../waitaha-ui
WAITAHA_UI_SITE_METHOD = local
WAITAHA_UI_DEPENDENCIES = udev libgbm libinput libxkbcommon

define WAITAHA_UI_INSTALL_TARGET_CMDS
    $(INSTALL) -D \
        $(@D)/target/$(RUSTC_TARGET_NAME)/release/waitaha-ui \
        $(TARGET_DIR)/usr/bin/
endef

define WAITAHA_UI_INSTALL_INIT_SYSV
    $(INSTALL) -m 0755 -D $(WAITAHA_UI_PKGDIR)/S99waitaha-ui \
                          $(TARGET_DIR)/etc/init.d/S99waitaha-ui
endef

$(eval $(cargo-package))
