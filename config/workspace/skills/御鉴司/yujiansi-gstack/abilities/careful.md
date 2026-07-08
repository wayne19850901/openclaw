# 破坏性命令防护（/careful）

## 触发条件

- 用户说"be careful"、"安全模式"、"careful mode"、"prod mode"
- 操作生产环境、调试线上系统
- 在共享环境中工作
- 用户明确请求安全防护

## 角色定位

危险命令拦截器，会话级 Hook。

**核心原则**：
- 在执行前警告，而不是事后补救
- 用户始终可以覆盖警告继续执行
- 安全例外应合理（node_modules 等可安全删除）

## 防护模式

| 模式 | 示例 | 风险 |
|------|------|------|
| `rm -rf` / `rm -r` | `rm -rf /var/data` | 递归删除 |
| `DROP TABLE` / `DROP DATABASE` | `DROP TABLE users;` | 数据丢失 |
| `TRUNCATE` | `TRUNCATE orders;` | 数据丢失 |
| `git push --force` / `-f` | `git push -f origin main` | 历史重写 |
| `git reset --hard` | `git reset --hard HEAD~3` | 未提交工作丢失 |
| `git checkout .` / `git restore .` | `git checkout .` | 未提交工作丢失 |
| `kubectl delete` | `kubectl delete pod` | 生产影响 |
| `docker rm -f` / `docker system prune` | `docker system prune -a` | 容器/镜像丢失 |

## 安全例外

以下模式无需警告：
- `rm -rf node_modules`
- `rm -rf .next`
- `rm -rf dist`
- `rm -rf __pycache__`
- `rm -rf .cache`
- `rm -rf build`
- `rm -rf .turbo`
- `rm -rf coverage`

## 工作原理

Hook 读取工具输入 JSON 中的命令，检查是否匹配危险模式：

1. 匹配到危险模式 → 返回 `permissionDecision: "ask"` + 警告消息
2. 用户可选择继续执行或取消
3. 会话级生效，新会话需重新激活

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

## 执行方式

**重要**：实际执行时，加载 gstack 原始 SKILL.md 获取完整指令：

```bash
# 原始指令路径
~/.claude/skills/gstack/careful/SKILL.md
```

本文件为 wrapper，定义触发条件、防护模式，完整工作流需加载原始指令。

## 技术细节

Hook 脚本路径：
```
~/.claude/skills/gstack/careful/bin/check-careful.sh
```

Hook 通过 PreToolUse 机制在 Bash 工具调用前执行，读取命令内容并检查模式。

---

_破坏防护，警告为先。_
