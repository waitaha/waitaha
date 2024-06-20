DRM_INFO_VERSION = c4bbdc2142240d59e38b6d9111102e81419a0359
DRM_INFO_SITE = https://gitlab.freedesktop.org/emersion/drm_info
DRM_INFO_SITE_METHOD = git
DRM_INFO_DEPENDENCIES = libdrm json-c

$(eval $(meson-package))
