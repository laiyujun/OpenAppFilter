#!/bin/bash

# 1. 克隆目标内核仓库
git clone https://github.com/unifreq/linux-6.6.y.git
cd linux-6.6.y

# 2. 创建新分支
git checkout -b oaf-integration

# 3. 克隆 OpenAppFilter 驱动
git clone https://github.com/destan19/OpenAppFilter.git

# 4. 创建驱动目录结构
mkdir -p drivers/net/oaf
cp OpenAppFilter/oaf/src/* drivers/net/oaf/

# 5. 手动创建 Kconfig
cat > drivers/net/oaf/Kconfig << 'EOF'
#
# Open Application Filter configuration
#

config OPENAPPFILTER
	tristate "Open Application Filter support"
	depends on NET
	depends on NETFILTER
	depends on NETFILTER_ADVANCED
	depends on NF_CONNTRACK
	depends on NF_CONNTRACK_MARK
	depends on NETFILTER_XTABLES
	default n
	help
	  This module adds application identification and filtering capabilities
	  to the Linux kernel. It can identify applications by their network
	  behavior and filter them based on user-defined rules.
	  
	  To compile this driver as a module, choose M here. The module
	  will be called openappfilter.
EOF

# 6. 手动创建Makefile（先使用源码的）
cat > drivers/net/oaf/Makefile << 'EOF'
#
# Makefile for Open Application Filter
#

obj-$(CONFIG_OPENAPPFILTER) += oaf.o

oaf-objs := oaf-objs := app_filter.o af_utils.o  af_config.o regexp.o cJSON.o af_log.o af_client.o af_client_fs.o af_conntrack.o af_rule_config.o af_user_config.o af_whitelist_config.o
EOF

# 7. 更新 drivers/net/Kconfig
# 在文件末尾添加一行
echo "source \"drivers/net/oaf/Kconfig\"" >> drivers/net/Kconfig

# 8. 更新 drivers/net/Makefile
# 在文件末尾添加一行
echo "obj-\$(CONFIG_OPENAPPFILTER) += oaf/" >> drivers/net/Makefile

# 9. 生成补丁文件
# 添加git用户信息
git config --global user.email "laiyujun@vip.qq.com"
git config --global user.name "laiyj"

# 添加所有修改
git add drivers/net/oaf drivers/net/Kconfig drivers/net/Makefile
git commit -m "Add OpenAppFilter (OAF) driver"

# 在生成补丁前自动清理空格
git config --global core.whitespace trailing-space
git config --global apply.whitespace fix

# 生成补丁
git format-patch HEAD~1 --stdout | sed 's/[[:space:]]*$//' > ../oaf-6.6.y.patch

echo "补丁已生成: ../oaf-6.6.y.patch"
