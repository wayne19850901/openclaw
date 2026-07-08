# gstack Learn 参考指南

**精简版参考文档，完整流程请查看原始 SKILL.md**

---

## 概述

Learn 是 gstack 的学习管理工作流，管理项目经验、模式、避坑指南。

**触发词**：`show learnings`, `what have we learned`, `manage project learnings`

---

## 命令变体

| 命令 | 功能 | 输出 |
|------|------|------|
| `/learn` | 显示最近20条 | 列表 |
| `/learn search <query>` | 搜索学习 | 匹配条目 |
| `/learn prune` | 清理陈旧 | 过期+矛盾检查 |
| `/learn export` | 导出Markdown | 报告文件 |
| `/learn stats` | 统计摘要 | 总数、类型分布 |
| `/learn add` | 手动添加 | 新条目 |

---

## 学习类型

| 类型 | 说明 | 示例 |
|------|------|------|
| `pattern` | 可复用方法 | "Use X for Y" |
| `pitfall` | 避坑指南 | "Don't do X because Y" |
| `preference` | 用户偏好 | "User likes X style" |
| `architecture` | 结构决策 | "Module X owns Y" |
| `tool` | 工具洞察 | "Library X has bug in vY" |
| `operational` | 项目环境 | "Use python3 not python" |

---

## 学习格式

```json
{
  "skill": "ship",
  "type": "pitfall",
  "key": "version-drift",
  "insight": "VERSION drift occurs when package.json is manually edited",
  "confidence": 8,
  "source": "observed",
  "files": ["VERSION", "package.json"],
  "ts": "2026-05-17T..."
}
```

---

## 关键特性

### HARD GATE

**仅管理学习，不做代码修改**

- 不执行 git 操作
- 不修改文件
- 仅记录和查询

### Append-only

- 新条目追加到 JSONL
- 相同 key 取最新
- 不删除（仅 prune 标记）

### Staleness Detection

文件删除时：
- 检测学习引用的文件是否存在
- 标记过期学习
- prune 时清理

### Contradiction Detection

发现冲突学习：
- 检测相同 key 不同 insight
- prune 时提示用户选择

---

## 存储位置

```
~/.gstack/projects/{slug}/learnings.jsonl
```

---

## Cross-project Learnings

可选启用：
- 搜索其他项目的学习
- 本地数据，不上传
- Solo developer 推荐

---

## 输出格式

```
## Learn 学习管理
**操作**：{show/search/prune/export/stats/add}

### ���果
- 总学习数：{N}
- 本次显示：{M}
- 类型分布：
  - pattern：{X}
  - pitfall：{Y}
  - preference：{Z}
  - architecture：{W}
  - tool：{V}
  - operational：{U}

### 陈旧条目（prune）
{stale-learnings}

### 矛盾条目（prune）
{conflicting-learnings}
```

---

## 与其他 gstack 技能的关系

- **ship**：ship 过程中的发现自动记录到 learn
- **retro**：retro 分析产出，learn 管理经验
- **review**：review 发现的 pitfall 记录到 learn

---

_参考：~/.claude/skills/gstack/learn/SKILL.md（完整版）_