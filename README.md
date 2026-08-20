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
- 📊 **账号 Usage 与配额实时监控（紧凑可视化进度条）**：
  - 智能识别订阅 Plan 级别（`Free` / `Plus` / `Pro` / `Ultra` / `Enterprise`）。
  - 实时查询 **Gemini 模型组** 与 **Claude / GPT 模型组** 的 **周配额** 与 **5小时配额** 剩余百分比与重置倒计时。
  - 实时检测 Google 账号信息（姓名、邮箱、Token 有效期）。
  - 支持非激活账号 Token 自动无感刷新。
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
| `agy-switch usage [profile]` | 查询当前（或指定）账号的 Token、订阅与模型配额进度 |
| `agy-switch usage all` | 一键输出所有账号的状态与配额进度报表 |

---

## 💡 使用演示

### 📊 查看所有账号配额与订阅状态
```bash
agy-switch usage all
```
输出示例：
```text
📊 Antigravity 账号 Usage & 配额状态报表:

━━━ Profile: work [当前活动] ━━━
  👤 用户: 张三 (zhangsan@work.com)  |  💎 订阅: Pro  |  🔑 Token: 有效 (55m 20s)
  💬 会话: 18 个会话 / 142 条交互记录

  🤖 Gemini Models:
     周配额 : [████████████] 100.0% (充足)
     5h配额 : [██████████░░]  85.4% (重置: 3h 12m)
  🧠 Claude and GPT models:
     周配额 : [████████████] 100.0% (充足)
     5h配额 : [████████████] 100.0% (充足)

━━━ Profile: personal ━━━
  👤 用户: 云枫 (orukefeng@gmail.com)  |  💎 订阅: Free  |  🔑 Token: 有效 (34m 30s)
  💬 会话: 18 个会话 / 142 条交互记录

  🤖 Gemini Models:
     周配额 : [██████████░░]  84.8% (重置: 6d 16h)
     5h配额 : [████████░░░░]  65.9% (重置: 2h 29m)
  🧠 Claude and GPT models:
     周配额 : [████████████] 100.0% (充足)
     5h配额 : [████████████] 100.0% (充足)
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

---

## 📄 开源协议

本项目基于 [MIT License](LICENSE) 许可开源。
