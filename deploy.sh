#!/usr/bin/env bash
set -euo pipefail
# VoiceStudio 一键安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/debpalash/VoiceStudio#get-started
# 更新日期：2026-10-26
# 类型：script
cd "$(dirname "${BASH_SOURCE[0]}")"

command -v git >/dev/null 2>&1 || { echo "需要先安装 Git"; exit 1; }

mkdir -p .download
cd .download

curl -fsSL https://voicestudio.sh/install | sh

echo ""

echo "安装完成：从开始菜单 / 启动台打开 VoiceStudio；第一次用某个音色会提示下载模型，按提示确认即可"
echo "若结果异常或需要改配置，请参考官方文档：https://github.com/debpalash/VoiceStudio#get-started"
