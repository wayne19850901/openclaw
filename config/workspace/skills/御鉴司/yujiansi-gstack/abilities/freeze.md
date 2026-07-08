# 编辑范围限制（/freeze）

## 触发条件

- 用户说"freeze"、"编辑限制"、"restrict edits"、"lock edits"
- 调试时防止误改无关代码
- 限定修改范围到一个模块
- 用户明确请求编辑范围锁定

## 角色定位

编辑范围锁定器，防止误改无关代码。

**核心原则**：
- 阻止而非警告——目录外编辑直接拒绝
- 仅限制 Edit/Write 工具——Read/Bash/Glob/Grep 不受影响
- 会话级持久化，可随时更改边界

## 工作原理

1. 用户指定目录路径
2. 解析为绝对路径并确保尾部斜杠
3. 保存到状态文件
4. Hook 在每次 Edit/Write 调用时检查文件路径
5. 路径不以冻结目录开头 → 返回 `permissionDecision: "deny"` 阻止操作

## 激活方式

```bash
/freeze
```

系统会询问：
```
Which directory should I restrict edits to? Files outside this path will be blocked from editing.
```

用户输入路径（如 `src/components/`），系统解析并保存。

输出：
```
Edits are now restricted to `<path>/`. Any Edit or Write outside this directory will be blocked.
To change the boundary, run `/freeze` again.
To remove it, run `/unfreeze` or end the session.
```

## 技术细节

状态文件路径：
```
~/.gstack/state/freeze-dir.txt
```

Hook 脚本路径：
```
~/.claude/skills/gstack/freeze/bin/check-freeze.sh
```

## 停用方式

```bash
/unfreeze
```

或结束当前会话。

## 注意事项

1. 尾部 `/` 防止 `/src` 匹配 `/src-old`
2. 仅限制 Edit/Write——Bash 中的 `sed` 等命令仍可修改目录外文件
3. 这是防误操作机制，不是安全边界

## 执行方式

**重要**：实际执行时，加载 gstack 原始 SKILL.md 获取完整指令：

```bash
# 原始指令路径
~/.claude/skills/gstack/freeze/SKILL.md
```

本文件为 wrapper，定义触发条件、工作原理，完整工作流需加载原始指令。

---

_编辑限制，边界为王。_
