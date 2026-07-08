# gstack/careful 完整指南

## 概述

**名称**：Destructive command guardrails
**版本**：0.1.0
**角色**：危险命令拦截器，会话级 Hook

**核心定位**：
- 在执行前警告，而不是事后补救
- 用户始终可以覆盖警告继续执行
- 安全例外应合理（node_modules 等可安全删除）

## 防护模式

### 递归删除

| 模式 | 示例 | 风险 |
|------|------|------|
| `rm -rf` | `rm -rf /var/data` | 递归删除目录 |
| `rm -r` | `rm -r ./backup` | 递归删除目录 |
| `rm --recursive` | `rm --recursive logs` | 递归删除目录 |

### 数据库操作

| 模式 | 示例 | 风险 |
|------|------|------|
| `DROP TABLE` | `DROP TABLE users;` | 删除表，数据丢失 |
| `DROP DATABASE` | `DROP DATABASE prod;` | 删除数据库 |
| `TRUNCATE` | `TRUNCATE orders;` | 清空表数据 |

### Git 操作

| 模式 | 示例 | 风险 |
|------|------|------|
| `git push --force` | `git push -f origin main` | 强制推送，重写历史 |
| `git push -f` | `git push -f` | 强制推送 |
| `git reset --hard` | `git reset --hard HEAD~3` | 硬重置，丢失未提交工作 |
| `git checkout .` | `git checkout .` | 丢弃所有未提交更改 |
| `git restore .` | `git restore .` | 丢弃所有未提交更改 |

### Kubernetes 操作

| 模式 | 示例 | 风险 |
|------|------|------|
| `kubectl delete` | `kubectl delete pod` | 删除 K8s 资源 |
| `kubectl delete pod` | `kubectl delete pod my-app` | 删除 pod |
| `kubectl delete deployment` | `kubectl delete deployment api` | 删除 deployment |

### Docker 操作

| 模式 | 示例 | 风险 |
|------|------|------|
| `docker rm -f` | `docker rm -f container` | 强制删除容器 |
| `docker system prune` | `docker system prune -a` | 清理所有未使用资源 |

## 安全例外

以下模式无需警告，可直接执行：

| 模式 | 原因 |
|------|------|
| `rm -rf node_modules` | 构建产物，可安全删除 |
| `rm -rf .next` | Next.js 构建缓存 |
| `rm -rf dist` | 构建产物 |
| `rm -rf __pycache__` | Python 缓存 |
| `rm -rf .cache` | 通用缓存 |
| `rm -rf build` | 构建产物 |
| `rm -rf .turbo` | Turborepo 缓存 |
| `rm -rf coverage` | 测试覆盖率报告 |

## 工作原理

### Hook 机制

1. 用户调用 `/careful`
2. PreToolUse Hook 注册到 Bash 工具
3. 每次 Bash 调用前，Hook 脚本检查命令内容
4. 匹配危险模式 → 返回 `permissionDecision: "ask"` + 警告消息
5. 用户选择继续或取消
6. 继续 → 执行命令；取消 → 阻止命令

### Hook 脚本

```bash
# Hook 脚本路径
~/.claude/skills/gstack/careful/bin/check-careful.sh
```

脚本读取 Bash 工具输入 JSON，提取命令，检查模式匹配。

### 会话范围

- Hook 仅在当前会话生效
- 新会话需重新激活 `/careful`
- 不持久化到配置文件

## 激活方式

```bash
/careful
```

输出：
```
Safety mode is now **active**. Every bash command will be checked for destructive
patterns before running. If a destructive command is detected, you'll be warned
and can choose to proceed or cancel.
```

## 停用方式

- 结束当前会话
- 开始新会话

Hook 是会话范围的，不会持久化。

## 使用场景

### 生产环境操作

```bash
# 操作生产数据库前激活
/careful

# 执行命令时会收到警告
kubectl delete pod api-server
# → Warning: destructive command detected: kubectl delete
# → Proceed? [y/n]
```

### 调试线上系统

```bash
# 调试线上问题时激活
/careful

# 防止误删日志文件
rm -rf /var/log/app
# → Warning: destructive command detected: rm -rf
# → Proceed? [y/n]
```

### 共享环境

```bash
# 在团队共享服务器上激活
/careful

# 防止影响他人工作
git checkout .
# → Warning: destructive command detected: git checkout .
# → Proceed? [y/n]
```

## 技术细节

### PreToolUse Hook 配置

```yaml
hooks:
  PreToolUse:
    - matcher: "Bash"
      hooks:
        - type: command
          command: "bash ${CLAUDE_SKILL_DIR}/bin/check-careful.sh"
          statusMessage: "Checking for destructive commands..."
```

### 返回格式

Hook 脚本返回 JSON：
```json
{
  "permissionDecision": "ask",
  "message": "Warning: destructive command detected: rm -rf /var/data\nProceed? [y/n]"
}
```

用户确认后，系统继续执行命令。

---

_破坏防护，警告为先。_