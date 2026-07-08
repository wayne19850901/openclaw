# Learn 学习管理能力

**身份**：昭妃学习管理能力，整合 gstack/learn 工作流

**触发词**：`learn`, `学习`, `经验`, `show learnings`, `what have we learned`, `manage project learnings`

---

## 命令变体

| 命令 | 功能 | 说明 |
|------|------|------|
| `/learn` | 显示最近20条 | 快速查看 |
| `/learn search <query>` | 搜索学习 | 按关键词搜索 |
| `/learn prune` | 清理陈旧 | 过期+矛盾检查 |
| `/learn export` | 导出Markdown | 生成报告 |
| `/learn stats` | 统计摘要 | 总数、类型分布 |
| `/learn add` | 手动添加 | type/key/insight/confidence/files |

---

## 执行指令

**实际执行时，加载并执行原始 gstack/learn SKILL.md**：

```bash
# 加载 gstack learn 技能
cat ~/.claude/skills/gstack/learn/SKILL.md

# 执行完整 learn 工作流
# （由 AI 根据加载的 SKILL.md 内容执行）
```

**关键特性**：
- **HARD GATE**：仅管理学习，不做代码修改
- **Append-only**：新条目追加，相同key取最新
- **陈旧检测**：文件删除时标记学习过期
- **矛盾检测**：发现冲突学习时提示清理

---

## 学习类型

| 类型 | 说明 | 示例 |
|------|------|------|
| `pattern` | 可复用方法 | "Use X for Y" |
| `pitfall` | 避坑指南 | "Don't do X because Y" |
| `preference` | 用户偏好 | "User likes X style" |
| `architecture` | 结构决策 | "Module X owns Y" |
| `tool` | 工具洞察 | "Library X has bug in version Y" |
| `operational` | 项目环境 | "Use python3 not python" |

---

## 输出格式

```
## Learn 学习管理
**操作**：{show/search/prune/export/stats/add}
**来源**：gstack/learn

### 结果摘要
- 总学习数：{N}
- 本次显示：{M}
- 类型分布：{pattern:X, pitfall:Y, ...}
- 陈旧条目：{K}（如 prune）
- 矛盾条目：{J}（如 prune）
```

---

## 与尚宫局原有能力的关系

- **retro.md**：retro 分析产出，learn 管理经验，形成学习闭环
- **ship.md**：ship 过程中的发现自动记录到 learn

---

## 参考文档

详细流程参考：`references/gstack-learn-guide.md`

原始技能：`~/.claude/skills/gstack/learn/SKILL.md`

---

_尚宫局·昭妃学习管理能力，整合 gstack learn 工作流_