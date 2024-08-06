RMTFS_VERSION = 33e1e40615efc59b17a515afe857c51b8b8c1ad1
RMTFS_SITE = https://github.com/linux-msm/rmtfs
RMTFS_SITE_METHOD = git
RMTFS_DEPENDENCIES = host-pkgconf qrtr udev

define RMTFS_BUILD_CMDS
	$(MAKE) -C $(@D) $(TARGET_CONFIGURE_OPTS) \
		CFLAGS="$(TARGET_CFLAGS)" \
		LDFLAGS="$(TARGET_LDFLAGS) -lqrtr -ludev" \
		rmtfs
endef

define RMTFS_INSTALL_TARGET_CMDS
	$(INSTALL) -Dm755 $(@D)/rmtfs $(TARGET_DIR)/usr/sbin/
	$(INSTALL) -Dm644 $(RMTFS_PKGDIR)/udev.rules $(TARGET_DIR)/usr/lib/udev/rules.d/64-rmtfs.rules
endef

define RMTFS_INSTALL_INIT_SYSV
	$(INSTALL) -Dm755 $(RMTFS_PKGDIR)/rmtfs.initd $(TARGET_DIR)/etc/init.d/S71rmtfs
endef

$(eval $(generic-package))
