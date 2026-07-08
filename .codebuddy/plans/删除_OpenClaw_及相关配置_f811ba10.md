---
name: 删除 OpenClaw 及相关配置
overview: 完全删除 OpenClaw 及其所有相关配置、服务和工具，确保系统干净无残留
todos:
  - id: stop-services
    content: 停止 LaunchAgent 服务 (openclaw gateway)
    status: completed
  - id: unload-launchagent
    content: 卸载 LaunchAgent 配置文件
    status: completed
    dependencies:
      - stop-services
  - id: uninstall-npm
    content: npm 全局卸载 openclaw 包
    status: completed
    dependencies:
      - stop-services
  - id: delete-launchagent-files
    content: 删除 LaunchAgent plist 文件
    status: completed
    dependencies:
      - unload-launchagent
  - id: delete-system-cache
    content: 删除 HTTPStorages 和 CrashReporter 缓存
    status: completed
  - id: clean-shell-config
    content: 清理 ~/.zshrc 中的 openclaw 自动补全引用
    status: completed
  - id: remove-symlink
    content: 解除 ~/.openclaw 符号链接
    status: completed
  - id: delete-backup
    content: 删除 ~/.openclaw.backup 备份目录
    status: completed
  - id: verify-claw
    content: 验证 ~/.claw 服务正常运行
    status: completed
    dependencies:
      - remove-symlink
      - delete-backup
  - id: optional-delete-project
    content: "[可选] 删除 ~/openclaw-control-center 项目"
    status: completed
---

## 用户需求

完全删除 OpenClaw 及其所有相关配置，包括与之关联的工具和服务。

## 当前系统状态

| 类型 | 位置 | 状态 |
| --- | --- | --- |
| 符号链接 | `~/.openclaw` → `~/.claw` | 迁移时创建 |
| 备份目录 | `~/.openclaw.backup/` | 175M |
| LaunchAgent | `~/Library/LaunchAgents/ai.openclaw.gateway.plist` | 运行中 |
| npm 包 | `openclaw@2026.4.27` | 全局安装 |
| Shell 配置 | `~/.zshrc` | source 自动补全 |
| 系统文件 | HTTPStorages, CrashReporter | 缓存/日志 |
| 用户项目 | `~/openclaw-control-center/` | 控制中心代码 |


## 需要用户确认

**关键问题**：`~/openclaw-control-center/` 项目是否也要删除？

- 这是 OpenClaw 的控制中心源代码
- 如果未来还需要开发或参考，建议保留
- 如果确定不再需要，可以一并删除

## 技术方案

### 删除顺序（按依赖关系）

1. **停止服务** - 先停止 LaunchAgent，防止删除过程中产生新文件
2. **卸载 CLI** - npm 全局卸载 openclaw 包
3. **清理系统文件** - 删除 LaunchAgent 配置、缓存、日志
4. **清理 Shell 配置** - 移除自动补全引用
5. **删除配置目录** - 解除符号链接，删除备份目录

### 安全措施

- 删除前验证 `~/.claw` 功能正常（Gateway 服务已切换到 claw 配置）
- 保留 `~/.claw/` 目录，只删除 OpenClaw 相关内容
- 提供回滚方案（如果删除后发现问题）

### 预期结果

- OpenClaw CLI 完全卸载
- 所有 OpenClaw 相关配置文件删除
- `~/.claw/` 保持完整，服务正常运行
- 飞书和 Telegram 渠道继续正常工作