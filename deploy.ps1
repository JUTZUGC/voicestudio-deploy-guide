# VoiceStudio 一键安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/debpalash/VoiceStudio#get-started
# 更新日期：2026-10-28
# 类型：script
$ErrorActionPreference = 'Stop'
Set-Location -Path $PSScriptRoot

if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw '需要先安装 Git' }

New-Item -ItemType Directory -Force -Path .download | Out-Null
Set-Location -Path .download

irm https://voicestudio.sh/install | iex

Write-Host ''

Write-Host '安装完成：从开始菜单 / 启动台打开 VoiceStudio；第一次用某个音色会提示下载模型，按提示确认即可'
Write-Host '若结果异常或需要改配置，请参考官方文档：https://github.com/debpalash/VoiceStudio#get-started'
