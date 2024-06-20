WAITAHA_UI_VERSION = c4e896bfb680c6443d75d91559cb03ff7cfdd8c9
WAITAHA_UI_SITE = git@github.com:waitaha/waitaha-ui.git
WAITAHA_UI_SITE_METHOD = git
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
