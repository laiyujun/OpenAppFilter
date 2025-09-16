include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=oaf
include $(INCLUDE_DIR)/package.mk

# 添加全局的TARGET_CFLAGS
TARGET_CFLAGS += -Wno-missing-prototypes -Wno-unused-variable

# 先定义 EXTRA_CFLAGS !!!
EXTRA_CFLAGS := \
    -Wno-error \  # 禁用所有警告转错误
    -Wno-declaration-after-statement \
    -Wno-strict-prototypes \
    -Wno-unused-variable \
    -Wno-implicit-fallthrough \
    -Wno-missing-braces \
    -Wno-parentheses \
    -Wno-format \
    -Wno-missing-prototypes \
    -Wno-missing-declarations

PKG_AUTOLOAD:=oaf
RSTRIP:=:

define KernelPackage/oaf
  SECTION:=TT Apps
  CATEGORY:=TT Apps
  TITLE:=OAF kernel DPI driver
  FILES:=$(PKG_BUILD_DIR)/oaf.ko 
  DEPENDS:=+kmod-ipt-conntrack
  KCONFIG:=
endef

define KernelPackage/oaf/description
  open appfilter kernel module 
endef

MAKE_OPTS:= \
    $(KERNEL_MAKE_FLAGS) \
    M="$(PKG_BUILD_DIR)" \
    EXTRA_CFLAGS="$(TARGET_CFLAGS) $(EXTRA_CFLAGS)" \  # 确保传递
    $(EXTRA_KCONFIG)

define Build/Compile
    $(MAKE) -C "$(LINUX_DIR)" \
        $(MAKE_OPTS) \
        modules
endef

$(eval $(call KernelPackage,oaf))
