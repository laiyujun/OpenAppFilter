
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


# EXTRA_CFLAGS:=-Wno-declaration-after-statement -Wno-strict-prototypes -Wno-unused-variable -Wno-implicit-fallthrough -Wno-missing-braces -Wno-parentheses -Wno-format -Wno-missing-prototypes -Wno-missing-declarations
# 添加编译选项
EXTRA_CFLAGS := \
	-w \
	-Wno-error \
    -Wno-declaration-after-statement \
    -Wno-strict-prototypes \
    -Wno-unused-variable \
    -Wno-implicit-fallthrough \
    -Wno-missing-braces \
    -Wno-parentheses \
    -Wno-format \
    -Wno-missing-prototypes \
    -Wno-missing-declarations \


MAKE_OPTS:= \
	$(KERNEL_MAKE_FLAGS) \
	M="$(PKG_BUILD_DIR)" \
	EXTRA_CFLAGS="$(EXTRA_CFLAGS)" \
	$(EXTRA_KCONFIG)

define Build/Prepare
    # 在准备阶段添加日志
	@echo "=============================================="
	@echo "准备构建 OAF 模块"
	@echo "当前 Makefile 路径: $(CURDIR)/Makefile"
	@echo "Makefile 内容:"
	@cat $(CURDIR)/Makefile
	@echo "=============================================="

	$(call Build/Prepare/Default)
endef

define Build/Compile
	# 添加详细日志
	@echo "=============================================="
	@echo "开始编译 OAF 模块"
	@echo "时间: $(shell date)"
	@echo "工作目录: $(PWD)"
	@echo "内核目录: $(LINUX_DIR)"
	@echo "构建目录: $(PKG_BUILD_DIR)"
	@echo "编译选项: $(EXTRA_CFLAGS)"
	@echo "=============================================="

	# 修改内核构建脚本
	echo "修改内核构建脚本..."
	sed -i 's/-Werror//g' $(LINUX_DIR)/scripts/Makefile.build
	sed -i 's/-Wmissing-prototypes//g' $(LINUX_DIR)/scripts/Makefile.build

	# 执行编译
	$(MAKE) -C "$(LINUX_DIR)" \
		$(MAKE_OPTS) \
		KCFLAGS="-w" \
		modules

	@echo "=============================================="
	@echo "编译完成"
	@echo "=============================================="
endef

$(eval $(call KernelPackage,oaf))

