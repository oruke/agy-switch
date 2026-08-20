# ⚡ agy-switch

> **Antigravity CLI (`agy`) 多账号秒切、Session 共享与 Usage 配额管理利器**

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform: Linux / WSL](https://img.shields.io/badge/Platform-WSL%20%2F%20Linux-green.svg)]()
[![Shell: Bash / Zsh](https://img.shields.io/badge/Shell-Bash%20%2F%20Zsh-orange.svg)]()

---

## ✨ 核心特性

- 🚀 **多账号秒级无缝切换**：每个账号仅需网页授权一次，凭证永久保存，告别反复登录。
- 💬 **Session 自由共享/隔离**：
  - **共享模式（默认推荐）**：跨账号无缝继承会话与历史记录（`agy -c`），账号额度用尽时秒切新账号继续当前对话！
  - **隔离模式**：每个账号拥有完全独立的会话与上下文历史。
- 📊 **账号 Usage 与配额实时查询**：
  - 实时检测 Google 账号信息（姓名、邮箱）。
  - Token 有效期与剩余倒计时。
  - Google Code Assist / Gemini 订阅 Plan / Tier 状态。
  - 本地会话与交互统计。
  - 支持 `agy-switch usage all` 一键查看所有账号概览。
- 🤖 **Antigravity 原生 Skill 联动**：内置 `switch-account` 技能，可在与 Agent 对话时直接用自然语言切换或查询。
- ⌨️ **智能 Tab 自动补全**：全面支持 Bash 与 Zsh 补全所有指令和 Profile 名称。
- 🛡️ **原子切换与数据安全**：采用原子软链接替换技术，初次使用自动安全收纳当前登录态至 `default` Profile。

---

## 📦 一键安装

### 方式 1：远程一键安装（推荐）

在任何 WSL / Linux 终端执行：
```bash
curl -fsSL https://raw.githubusercontent.com/oruke/agy-switch/main/install.sh | bash
```

### 方式 2：克隆仓库本地安装

```bash
git clone https://github.com/oruke/agy-switch.git
cd agy-switch
bash install.sh
```

安装完成后，执行以下命令使 Tab 补全生效：
```bash
source ~/.bashrc   # 或 source ~/.zshrc
```

---

## 🛠️ 命令速查

| 命令 | 说明 |
| :--- | :--- |
| `agy-switch list` (或 `ls`) | 列出所有已保存的账号 Profile 与当前活动账号 |
| `agy-switch save <name>` | 将当前登录状态保存为指定名称 |
| `agy-switch new <name>` | 创建全新空白 Profile 并准备登录新账号 |
| `agy-switch use <name>` (或 `agy-switch <name>`) | 毫秒级切换到指定账号 Profile |
| `agy-switch whoami` | 查看当前正在活动的账号 Profile |
| `agy-switch rename <old> <new>` | 重命名指定 Profile |
| `agy-switch delete <name>` (或 `rm`) | 删除指定 Profile |
| `agy-switch session share` | **开启会话共享**（Session 不隔离，跨账号继承对话上下文） |
| `agy-switch session isolate` | **开启会话隔离**（每个账号独立会话） |
| `agy-switch session status` | 查看当前会话共享/隔离状态 |
| `agy-switch usage [profile]` | 查询当前（或指定）账号的 Token、订阅与会话统计 |
| `agy-switch usage all` | 一键输出所有账号的状态与 Usage 报表 |

---

## 💡 典型使用场景

### 场景 1：多账号添加与切换

```bash
# 1. 保存当前已登录的工作号
agy-switch save work

# 2. 新建并登录个人号
agy-switch new personal
agy    # 此时会打开网页完成个人号的首次登录授权

# 3. 以后随时切换
agy-switch work        # 切回工作号
agy-switch personal    # 切到个人号
```

### 场景 2：账号配额耗尽，无缝继承对话

```bash
# 1. 开启会话共享模式
agy-switch session share

# 2. 当当前账号额度达到限制时，一键切号并继续对话
agy-switch personal
agy -c                 # 使用新账号无缝继续上一次对话！
```

### 场景 3：快速巡检所有账号状态与订阅

```bash
agy-switch usage all
```
输出示例：
```text
📊 Antigravity 账号 Usage & 状态报表:

━━━ Profile: work [当前活动] ━━━
  👤 Google 用户:   张三 (zhangsan@work.com)
  🔑 Token 状态:    有效 (剩余有效: 45m 12s)
  💎 订阅 Plan:     Gemini Code Assist Enterprise
  💬 会话统计:      18 个会话 / 142 条交互记录

━━━ Profile: personal ━━━
  👤 Google 用户:   云枫 (orukefeng@gmail.com)
  🔑 Token 状态:    有效 (剩余有效: 12m 04s)
  💎 订阅 Plan:     Gemini Code Assist
  💬 会话统计:      18 个会话 / 142 条交互记录
```

---

## 🏗️ 架构与原理

```text
~/.gemini/antigravity-cli (Symlink) ──► ~/.gemini-profiles/<active_profile>/antigravity-cli
                                          ├── antigravity-oauth-token (账号凭据)
                                          ├── jetski_state.pbtxt
                                          └── (软链接至 ~/.gemini-shared/ 共享区)
                                                ├── conversations/
                                                ├── history.jsonl
                                                └── conversation_summaries.db
```

1. **凭证隔离**：通过 `ln -sfn` 将 `~/.gemini/antigravity-cli` 指向不同的 Profile 目录，实现身份凭据的完全隔离。
2. **会话共享**：当启用 `session share` 时，会话与历史数据库统一链接到 `~/.gemini-shared/`，使所有 Profile 在使用不同鉴权身份的同时读写相同的聊天上下文。

---

## 📄 开源协议

本项目基于 [MIT License](LICENSE) 许可开源。
