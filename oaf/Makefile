
include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=oaf
include $(INCLUDE_DIR)/package.mk

PKG_AUTOLOAD:=oaf
RSTRIP:=:

define KernelPackage/oaf
  SECTION:=TT Apps
  CATEGORY:=TT Apps
  TITLE:=OAF kernel DPI driver
  FILES:=$(PKG_BUILD_DIR)/oaf.ko 
  DEPENDS:=+kmod-ipt-conntrack
  KCONFIG:=
  # AUTOLOAD:=$(call AutoLoad,0,$(PKG_AUTOLOAD))
endef

define KernelPackage/oaf/description
  open appfilter kernel module 
endef


EXTRA_CFLAGS:=-Wno-declaration-after-statement -Wno-strict-prototypes -Wno-unused-variable -Wno-implicit-fallthrough -Wno-missing-braces -Wno-parentheses -Wno-format -Wno-missing-prototypes -Wno-missing-declarations



MAKE_OPTS:= \
	$(KERNEL_MAKE_FLAGS) \
	M="$(PKG_BUILD_DIR)" \
	$(EXTRA_KCONFIG)

define Build/Compile
	sed -i 's/-Werror//g' $(LINUX_DIR)/scripts/Makefile.extrawarn
	sed -i 's/-Wmissing-prototypes//g' $(LINUX_DIR)/scripts/Makefile.extrawarn
	sed -i 's/-Wstrict-prototypes//g' $(LINUX_DIR)/scripts/Makefile.extrawarn
	sed -i 's/-Wmissing-declarations//g' $(LINUX_DIR)/scripts/Makefile.extrawarn
	
	$(MAKE) -C "$(LINUX_DIR)" \
		$(MAKE_OPTS) \
        EXTRA_CFLAGS="$(EXTRA_CFLAGS)" \
		modules
endef

$(eval $(call KernelPackage,oaf))

