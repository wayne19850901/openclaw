# gstack/guard 完整指南

## 概述

**名称**：Full safety mode
**版本**：0.1.0
**角色**：careful + freeze 组合，双重安全防护

**核心定位**：
- 破坏性命令警告 + 编辑范围限制
- 两层防护独立生效
- 会话级持久化

## 工作原理

### 双重防护

激活 `/guard` 会同时启用：

1. **careful** — 破坏性命令拦截
   - rm -rf、DROP TABLE、git push --force 等触发警告
   - 用户可覆盖警告继续执行
   - 安全例外：node_modules、dist 等

2. **freeze** — 编辑范围限制
   - 用户指定编辑目录
   - 目录外 Edit/Write 直接拒绝
   - 仅限制 Edit/Write，其他工具不受影响

### 依赖关系

`/guard` 引用 `/careful` 和 `/freeze` 的 Hook 脚本：

```bash
# careful Hook
~/.claude/skills/gstack/careful/bin/check-careful.sh

# freeze Hook
~/.claude/skills/gstack/freeze/bin/check-freeze.sh
```

两个技能必须都已安装（gstack setup 会一起安装）。

## 激活方式

```bash
/guard
```

系统询问：
```
Guard mode: which directory should edits be restricted to? Destructive command warnings are always on.
Files outside the chosen path will be blocked from editing.
```

用户输入路径（文本输入）。

系统解析并保存：
```bash
FREEZE_DIR=$(cd "<user-provided-path>" 2>/dev/null && pwd)
FREEZE_DIR="${FREEZE_DIR%/}/"
echo "$FREEZE_DIR" > ~/.gstack/state/freeze-dir.txt
```

输出：
```
**Guard mode active.** Two protections are now running:
1. **Destructive command warnings** — rm -rf, DROP TABLE, force-push, etc. will warn before executing (you can override)
2. **Edit boundary** — file edits restricted to `<path>/`. Edits outside this directory are blocked.
To remove the edit boundary, run `/unfreeze`.
To deactivate everything, end the session.
```

## 停用方式

- `/unfreeze` — 仅移除编辑限制，保留破坏性命令警告
- 结束会话 — 完全停用

## 使用场景

### 最高安全要求

```bash
# 操作关键生产系统时激活
/guard
# 输入: src/api/

# 破坏性命令会警告
kubectl delete deployment api
# → Warning: destructive command detected: kubectl delete
# → Proceed? [y/n]

# 目录外编辑会被阻止
Edit src/frontend/App.tsx
# → Blocked: file path outside freeze boundary
```

### 生产数据库操作

```bash
# 操作生产数据库时激活
/guard
# 输入: db/migrations/

# DROP TABLE 会警告
DROP TABLE users;
# → Warning: destructive command detected: DROP TABLE
# → Proceed? [y/n]

# 防止误改其他迁移文件
Edit db/migrations/old/001_initial.sql
# → Blocked: file path outside freeze boundary
```

### 关键配置修改

```bash
# 修改关键配置时激活
/guard
# 输入: config/

# 防止误删配置
rm -rf config/
# → Warning: destructive command detected: rm -rf
# → Proceed? [y/n]

# 防止误改其他文件
Edit src/app.ts
# → Blocked: file path outside freeze boundary
```

## 技术细节

### PreToolUse Hook 配置

```yaml
hooks:
  PreToolUse:
    - matcher: "Bash"
      hooks:
        - type: command
          command: "bash ${CLAUDE_SKILL_DIR}/../careful/bin/check-careful.sh"
          statusMessage: "Checking for destructive commands..."
    - matcher: "Edit"
      hooks:
        - type: command
          command: "bash ${CLAUDE_SKILL_DIR}/../freeze/bin/check-freeze.sh"
          statusMessage: "Checking freeze boundary..."
    - matcher: "Write"
      hooks:
        - type: command
          command: "bash ${CLAUDE_SKILL_DIR}/../freeze/bin/check-freeze.sh"
          statusMessage: "Checking freeze boundary..."
```

### Hook 脚本路径

```bash
# careful Hook（通过相对路径引用）
~/.claude/skills/gstack/careful/bin/check-careful.sh

# freeze Hook（通过相对路径引用）
~/.claude/skills/gstack/freeze/bin/check-freeze.sh
```

### 返回格式

**careful Hook**：
```json
{
  "permissionDecision": "ask",
  "message": "Warning: destructive command detected: rm -rf /var/data\nProceed? [y/n]"
}
```

**freeze Hook**：
```json
{
  "permissionDecision": "deny",
  "message": "Blocked: file path outside freeze boundary\nFreeze boundary: /Users/linyi/project/src/api/\nAttempted path: /Users/linyi/project/src/frontend/App.tsx"
}
```

## 与单独技能的对比

| 特性 | /careful | /freeze | /guard |
|------|----------|---------|--------|
| 破坏性命令警告 | ✅ | ❌ | ✅ |
| 编辑范围限制 | ❌ | ✅ | ✅ |
| 用户可覆盖警告 | ✅ | N/A | ✅ |
| 目录外编辑 | 允许 | 阻止 | 阻止 |
| 适用场景 | 生产操作 | 调试限定 | 最高安全 |

---

_全面安全，防护为王。_