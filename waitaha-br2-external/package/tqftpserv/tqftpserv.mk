TQFTPSERV_VERSION = 48e143d273d4de79d6e41bf7066592bffa5c84c5
TQFTPSERV_SITE = https://github.com/linux-msm/tqftpserv
TQFTPSERV_SITE_METHOD = git
TQFTPSERV_DEPENDENCIES = qrtr zstd

define TQFTPSERV_INSTALL_INIT_SYSV
	$(INSTALL) -Dm755 $(TQFTPSERV_PKGDIR)/tqftpserv.initd $(TARGET_DIR)/etc/init.d/S70tqftpserv
endef

$(eval $(meson-package))
