# 全面安全模式（/guard）

## 触发条件

- 用户说"guard"、"全面安全"、"full safety"、"maximum safety"、"lock it down"
- 最高安全要求场景
- 操作关键生产系统
- 用户明确请求最大安全防护

## 角色定位

careful + freeze 组合，双重安全防护。

**核心原则**：
- 破坏性命令警告 + 编辑范围限制
- 两层防护独立生效
- 会话级持久化

## 工作原理

激活 `/guard` 会同时启用：

1. **careful** — 破坏性命令拦截
   - rm -rf、DROP TABLE、git push --force 等触发警告
   - 用户可覆盖警告继续执行

2. **freeze** — 编辑范围限制
   - 用户指定编辑目录
   - 目录外 Edit/Write 直接拒绝

## 激活方式

```bash
/guard
```

系统会询问：
```
Guard mode: which directory should edits be restricted to? Destructive command warnings are always on.
Files outside the chosen path will be blocked from editing.
```

用户输入路径，系统解析并保存。

输出：
```
**Guard mode active.** Two protections are now running:
1. **Destructive command warnings** — rm -rf, DROP TABLE, force-push, etc. will warn before executing (you can override)
2. **Edit boundary** — file edits restricted to `<path>/`. Edits outside this directory are blocked.
To remove the edit boundary, run `/unfreeze`.
To deactivate everything, end the session.
```

## 技术细节

依赖关系：
- `/guard` 引用 `/careful` 和 `/freeze` 的 Hook 脚本
- 两个技能必须都已安装（gstack setup 会一起安装）

Hook 脚本路径：
```
~/.claude/skills/gstack/careful/bin/check-careful.sh
~/.claude/skills/gstack/freeze/bin/check-freeze.sh
```

## 停用方式

- `/unfreeze` — 仅移除编辑限制，保留破坏性命令警告
- 结束会话 — 完全停用

## 执行方式

**重要**：实际执行时，加载 gstack 原始 SKILL.md 获取完整指令：

```bash
# 原始指令路径
~/.claude/skills/gstack/guard/SKILL.md
```

本文件为 wrapper，定义触发条件、工作原理，完整工作流需加载原始指令。

---

_全面安全，防护为王。_
