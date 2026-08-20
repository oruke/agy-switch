---
name: switch-account
description: 查看 Antigravity CLI (agy) 账号 Profiles、查询各模型组 Usage 与限额进度条、智能识别 Google AI Pro/Ultra 订阅、配置 Session 会话共享/隔离、执行多账号毫秒级切换或快速重登授权。
---

# Antigravity CLI 账号与 Session 管理技能

当用户询问当前账号、查询 Usage 配额、要求切换账号、配置会话共享或重新登录时使用本技能：

## 1. 查看当前与所有可用账号
```bash
agy-switch list
```

## 2. 查询账号 Usage、订阅 Plan 与模型限额进度
```bash
# 查询当前活动账号（含 Gemini / Claude / GPT 模型组周限额与 5h 限额进度条）
agy-switch usage

# 一键查询所有账号的概览报表（自动检测 Token 有效期并无感刷新）
agy-switch usage all
```

## 3. 切换到指定账号 Profile
```bash
agy-switch use <profile_name>
# 或简写
agy-switch <profile_name>
```

## 4. 重新登录或授权指定账号
```bash
# 为指定 Profile 清除旧 Token 并重新调起浏览器 OAuth 授权
agy-switch login <profile_name>
```

## 5. 配置 Session 共享（不隔离）或独立隔离
- **开启会话共享**（跨账号继承会话与历史，切换账号后直接 `agy -c` 继承对话）：
  ```bash
  agy-switch session share
  ```
- **开启会话隔离**（每个账号保持独立历史）：
  ```bash
  agy-switch session isolate
  ```
- **查看当前会话模式**：
  ```bash
  agy-switch session status
  ```

## 6. 保存或新建账号 Profile
- **保存当前账号状态**：`agy-switch save <name>`
- **新建空白账号并准备登录**：`agy-switch new <name>`
- **重命名 Profile**：`agy-switch rename <old_name> <new_name>`
- **删除指定 Profile**：`agy-switch delete <name>`
