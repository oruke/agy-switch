---
name: switch-account
description: 查看当前 Antigravity CLI 账号 Profiles、查询 Usage 与配额、配置会话共享/隔离或在多个账号之间快速切换。
---

# Antigravity CLI 账号与 Session 管理技能

当用户询问当前账号、Usage 配额、要求切换账号或配置会话共享时：

## 1. 查看当前与所有可用账号
运行命令：
```bash
agy-switch list
```

## 2. 查询账号 Usage、Token 状态与订阅 Plan
运行命令：
```bash
# 查询当前活动账号
agy-switch usage

# 查询所有账号概览
agy-switch usage all
```

## 3. 切换到指定账号 Profile
运行命令：
```bash
agy-switch use <profile_name>
```
切换成功后，向用户汇报已切换到指定 Profile，并提醒用户在新的 CLI 会话中生效。

## 4. 配置 Session 共享（不隔离）或隔离
- 开启会话共享（跨账号继承会话与历史）：`agy-switch session share`
- 开启会话隔离（每个账号独立会话）：`agy-switch session isolate`
- 查看当前会话模式：`agy-switch session status`

## 5. 保存或新建账号 Profile
- 保存当前账号：`agy-switch save <name>`
- 新建空白账号准备登录：`agy-switch new <name>`
