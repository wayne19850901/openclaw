# gstack/freeze 完整指南

## 概述

**名称**：Restrict edits to a directory
**版本**：0.1.0
**角色**：编辑范围锁定器，防止误改无关代码

**核心定位**：
- 阻止而非警告——目录外编辑直接拒绝
- 仅限制 Edit/Write 工具——Read/Bash/Glob/Grep 不受影响
- 会话级持久化，可随时更改边界

## 工作原理

### 激活流程

1. 用户调用 `/freeze`
2. 系统询问目标目录
3. 用户输入路径（如 `src/components/`）
4. 系统解析为绝对路径
5. 确保尾部斜杠（防止 `/src` 匹配 `/src-old`）
6. 保存到状态文件
7. Hook 注册到 Edit/Write 工具

### 检查流程

1. 用户调用 Edit 或 Write 工具
2. PreToolUse Hook 检查 `file_path` 参数
3. 检查路径是否以冻结目录开头
4. 不匹配 → 返回 `permissionDecision: "deny"` 阻止操作
5. 匹配 → 允许操作继续

### 状态文件

```bash
# 状态文件路径
~/.gstack/state/freeze-dir.txt

# 内容示例
/Users/linwei/project/src/components/
```

状态文件在会话中持久化，每次 Edit/Write 调用时读取。

## 激活方式

```bash
/freeze
```

系统询问：
```
Which directory should I restrict edits to? Files outside this path will be blocked from editing.
```

用户输入路径（文本输入，不是多选）。

系统解析：
```bash
FREEZE_DIR=$(cd "<user-provided-path>" 2>/dev/null && pwd)
FREEZE_DIR="${FREEZE_DIR%/}/"
echo "$FREEZE_DIR" > ~/.gstack/state/freeze-dir.txt
```

输出：
```
Freeze boundary set: /Users/linwei/project/src/components/
Edits are now restricted to `<path>/`. Any Edit or Write outside this directory will be blocked.
To change the boundary, run `/freeze` again.
To remove it, run `/unfreeze` or end the session.
```

## 停用方式

```bash
/unfreeze
```

或结束当前会话。

## 使用场景

### 调试特定模块

```bash
# 仅修改 auth 模块
/freeze
# 输入: src/auth/

# 尝试编辑其他模块会被阻止
Edit src/payment/checkout.ts
# → Blocked: file path outside freeze boundary
# → Freeze boundary: /Users/linwei/project/src/auth/
# → Attempted path: /Users/linwei/project/src/payment/checkout.ts
```

### 限定修改范围

```bash
# 仅修改配置文件
/freeze
# 输入: config/

# 防止误改源码
Edit src/app.ts
# → Blocked: file path outside freeze boundary
```

### 安全重构

```bash
# 仅重构 utils 模块
/freeze
# 输入: src/utils/

# 防止影响其他模块
Edit src/components/Button.tsx
# → Blocked: file path outside freeze boundary
```

## 技术细节

### PreToolUse Hook 配置

```yaml
hooks:
  PreToolUse:
    - matcher: "Edit"
      hooks:
        - type: command
          command: "bash ${CLAUDE_SKILL_DIR}/bin/check-freeze.sh"
          statusMessage: "Checking freeze boundary..."
    - matcher: "Write"
      hooks:
        - type: command
          command: "bash ${CLAUDE_SKILL_DIR}/bin/check-freeze.sh"
          statusMessage: "Checking freeze boundary..."
```

### Hook 脚本

```bash
# Hook 脚本路径
~/.claude/skills/gstack/freeze/bin/check-freeze.sh
```

脚本读取 Edit/Write 工具输入 JSON，提取 `file_path`，检查是否以冻结目录开头。

### 返回格式

Hook 脚本返回 JSON：
```json
{
  "permissionDecision": "deny",
  "message": "Blocked: file path outside freeze boundary\nFreeze boundary: /Users/linwei/project/src/auth/\nAttempted path: /Users/linwei/project/src/payment/checkout.ts"
}
```

## 注意事项

1. **尾部斜杠重要性**
   - `/src/` 不会匹配 `/src-old`
   - 无尾部斜杠可能导致误匹配

2. **仅限制 Edit/Write**
   - Read、Bash、Glob、Grep 不受影响
   - Bash 中的 `sed` 等命令仍可修改目录外文件
   - 这是防误操作机制，不是安全边界

3. **会话级持久化**
   - 状态文件在会话中有效
   - 新会话需重新激活
   - 可随时更改边界（重新运行 `/freeze`）

4. **绝对路径解析**
   - 相对路径会被解析为绝对路径
   - 使用 `cd <path> && pwd` 确保解析正确

---

_编辑限制，边界为王。_