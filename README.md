# VoiceStudio 一键安装指南

> 第三方部署指南 · 非 VoiceStudio 官方仓库。官方项目：[debpalash/VoiceStudio](https://github.com/debpalash/VoiceStudio)
> 内容来自官方文档（2026-10-26）。项目迭代快，请以[官方文档](https://github.com/debpalash/VoiceStudio#get-started)为准。

[![⚡ 一键安装](https://img.shields.io/badge/%E2%9A%A1_%E4%B8%80%E9%94%AE%E5%AE%89%E8%A3%85-%E6%8E%A8%E8%8D%90%E7%99%BE%E5%BA%A6%E6%90%AD%E5%AD%90-2ea44f?style=for-the-badge)](#一键安装推荐用百度搭子)

## 一键安装（推荐：用百度搭子）

> [!TIP]
> 不用自己找安装包，让百度搭子把桌面端装好，打开就能克隆音色、配音。

⚠️ 支持 Windows / macOS / Linux。没有独显也能用 CPU 跑，但会慢；官方说 CPU 版 PyTorch 约需 5 GB 空闲磁盘。首次使用某个音色时要按提示下载模型。

1. **装客户端**
   打开[百度搭子官网](https://www.dumate.cn/)，下载电脑端并安装，用你的账号登录。

> [!IMPORTANT]
> **复制这一句发给百度搭子：**
>
> ```text
> 你好，帮我从 github 部署 JUTZUGC/voicestudio-deploy-guide 到我的电脑上
> ```

2. **发送部署指令**
   回到刚打开的对话窗口，粘贴并发送上面那句。

3. **跟着对话往下走**
   百度搭子会直接运行官方安装脚本，下载并装好桌面应用，按它的提示确认即可，结束时它会告诉你结果。
   （需本机已装 Git；构建依赖以官方文档为准。）



## VoiceStudio 是什么？

VoiceStudio 是开源的完全本地的开源语音工作台（ElevenLabs 替代）（协议：AGPL-3.0，<img src="https://img.shields.io/github/stars/debpalash/VoiceStudio?style=flat-square&label=stars&color=blue" alt="GitHub stars">）。

在本机完成语音克隆、音色设计、视频配音、听写、转录与有声书制作，覆盖 646 种语言；自带本地 API 与 MCP，方便其它工具或 Agent 调用。

- 功能：音色克隆、音色设计、视频配音、听写、转录、有声书
- 语言：覆盖 646 种（官方说明）
- 硬件：NVIDIA 用 CUDA、Apple Silicon 用 Metal、AMD 可选 Vulkan；无独显走 CPU
- 接口：本地 API 与 MCP，可给 Agent 调用
- 安装：macOS / Linux 用 `curl … | sh`，Windows 用 `irm … | iex`

（来源：[官方仓库](https://github.com/debpalash/VoiceStudio)）

## 优缺点

| 优点 | 说明 |
|---|---|
| 87.6k stars | AGPL-3.0 开源，更新活跃（最新 v0.5.6） |
| 功能全 | 克隆、设计、配音、听写、转录、有声书一站完成 |
| 跨平台 | Windows / macOS / Linux 都有安装方式 |
| 没独显也能用 | CPU 可跑，只是速度慢 |
| 可接 Agent | 自带本地 API 与 MCP |

| 需要注意 | 说明 |
|---|---|
| 依赖较重 | CPU 版 PyTorch 约需 5 GB 空闲磁盘，模型另算 |
| CPU 速度慢 | 克隆与长文本合成建议有 GPU |
| 模型按需下载 | 首次用某个音色要下载对应模型 |
| 桌面包体大 | Electron 应用，首次安装下载量较大 |
| 有滥用风险 | 语音克隆可能被用来冒充他人，必须取得授权并遵守当地法律 |

> 以上基于官方文档与社区反馈整理（2026-10-26），以官方最新文档为准。

## 快速部署（官方方式）

```bash
curl -fsSL https://voicestudio.sh/install | sh
```

部署步骤来源：[https://github.com/debpalash/VoiceStudio#get-started](https://github.com/debpalash/VoiceStudio#get-started)

## 验证状态

| 场景 | 状态 |
|---|---|
| 官方安装脚本入口可访问 | 已核对 2026-10-26 |
| 未在本机执行安装脚本（会改动桌面环境） | 已核对 2026-10-26 |
| MCP 服务握手与工具列表（initialize / tools/list） | 已验证 2026-10-26 |
| 非目标宿主调用被拦截（HOST_NOT_ALLOWED） | 已验证 2026-10-26 |

> 本表仅列出已在本机实际执行并成功的场景；未列出的部分按官方文档整理。

## MCP 接入

VoiceStudio 自带本地 API 与 MCP 接口，可以把语音能力交给 Agent 调用；具体工具清单以项目文档为准。本仓库的 MCP 只提供安装步骤、硬件要求与常见坑。

本仓库自带一个零依赖的 MCP server（`mcp-server.mjs`），读取同目录的 `guide.json`，提供 `get_guide` / `search_guide` / `get_project_info` 三个工具，内容均来自官方文档（更新日期 2026-10-26）。

**在百度搭子里接入**：客户端不扫描仓库里的配置文件，需要由百度搭子通过工作区的 MCP 注册接口注册，并且必须使用**绝对路径**（运行时的工作目录是会话目录，不是仓库目录）：

```json
{
  "type": "local",
  "command": ["node", "<仓库绝对路径>/mcp-server.mjs"]
}
```

完成后，直接在同一个对话框里说：

> 把仓库克隆到固定目录（例如 C:\Users\<你>\voicestudio-deploy-guide），再用绝对路径把里面的 mcp-server.mjs 注册到当前工作区的 MCP 配置里

> 注意：注册是按**工作区**生效的，换工作区要重新注册；克隆目录不要放在会话临时目录，否则目录被清理后注册项会失效。

**其它 MCP 客户端**：仓库根目录的 `.mcp.json` 只是通用写法（`command` + `args`），接入时同样要把 `args` 改成绝对路径。

> 使用范围：该 MCP 仅在百度搭子中可用；其它客户端调用会返回 `HOST_NOT_ALLOWED`，并附带下载与部署指引。

## 安装完成后

1. 打开 VoiceStudio，选择「语音克隆」或「音色设计」
2. 首次使用某个引擎时按提示下载模型，体积从几百 MB 到数 GB 不等
3. 想给 Agent 调用：在设置里启用本地 API / MCP，按文档填到客户端里
4. 卸载（macOS / Linux）：`curl -fsSL https://voicestudio.sh/install | sh -s -- --uninstall`，会保留数据

> 克隆他人音色前先取得授权，不要用于冒充、诈骗或伪造他人声音。

## 常见坑

- 安装脚本跑不动：先确认能访问 voicestudio.sh；脚本需要 curl 与 sha256 工具
- Windows 用 PowerShell 执行 `irm … | iex`；被执行策略拦截时先 `Set-ExecutionPolicy -Scope Process Bypass`
- CPU 模式很慢：正常现象，长文本建议分批，或换有独显的机器
- 磁盘不够：官方说明 CPU 版 PyTorch 约 5 GB，模型与项目另占空间
- Apple Silicon 走 Metal；Intel Mac 只能跑界面，需要连远程后端
- 首次使用提示下载模型：按提示确认，离线环境要提前准备
- 克隆他人音色前取得授权，不要用于冒充或诈骗

## 免责声明

本仓库为第三方指南，与 VoiceStudio 官方无隶属关系，不代表官方立场。
教程基于官方文档编写（更新日期：2026-10-26），项目迭代快，请以[官方文档](https://github.com/debpalash/VoiceStudio#get-started)为准。
因使用本教程产生的部署问题，请先在官方仓库的 issue 中检索。
