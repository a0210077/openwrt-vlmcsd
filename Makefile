include $(TOPDIR)/rules.mk

PKG_NAME:=vlmcsd
PKG_VERSION:=v1.0.0
PKG_RELEASE:=1

PKG_MAINTAINER:=siwind 
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/siwind/vlmcsd.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=70e03572b254688b8c3557f898e7ebd765d29ae1
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_MIRROR_HASH:=5772f2aef4502eb90075a9b0e5e9ceab0c6a798fea302ad9e9cef84b42159270

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_SOURCE_SUBDIR)
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/vlmcsd
	SECTION:=net
	CATEGORY:=Network
	TITLE:=vlmcsd for OpenWRT
	URL:=http://forums.mydigitallife.info/threads/50234
	DEPENDS:=+libpthread
endef

MAKE_FLAGS += \
	VLMCSD_VERSION="$(PKG_VERSION)" 

define Package/vlmcsd/description
	vlmcsd for openwrt-$(BOARD)
endef

MAKE_FLAGS += \
	-C $(PKG_BUILD_DIR)

define Package/vlmcsd/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/vlmcsd $(1)/usr/bin/vlmcsd
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/vlmcs $(1)/usr/bin/vlmcs
	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_BIN) ./files/vlmcsd.ini $(1)/etc/vlmcsd.ini
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/vlmcsd.init $(1)/etc/init.d/vlmcsd
endef

$(eval $(call BuildPackage,vlmcsd))
