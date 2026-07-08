# Retro 回顾能力

**身份**：昭妃回顾能力，整合 gstack/retro 工作流

**触发词**：`retro`, `回顾`, `周报`, `what did we ship`, `weekly retro`, `engineering retrospective`

---

## 执行流程概述

当用户触发 retro 能力时，执行以下流程：

```
Step 1: 收集原始数据（12个并行git命令）
    ↓
Step 2: 计算指标（features shipped, commits, LOC, test ratio）
    ↓
Step 3: Commit时间分布分析
    ↓
Step 4: 工作会话检测（45分钟间隔阈值）
    ↓
Step 5: Commit类型分解
    ↓
Step 6: Hotspot分析
    ↓
Step 7: PR大小分布
    ↓
Step 8: Focus score + Ship of the week
    ↓
Step 9: 团队成员分析（表扬/成长建议）
    ↓
Step 10: Week-over-week趋势（>=14d时）
    ↓
Step 11: Streak追踪
    ↓
Step 12: 加载历史并比较
    ↓
Step 13: 保存回顾历史（JSON）
    ↓
Step 14: 撰写叙事报告
```

---

## 命令变体

| 命令 | 时间窗口 | 说明 |
|------|----------|------|
| `/retro` | 7d（默认） | 本周回顾 |
| `/retro 24h` | 24小时 | 快速日报 |
| `/retro 14d` | 14天 | 两周回顾 |
| `/retro 30d` | 30天 | 月度回顾 |
| `/retro compare` | - | 与上期对比 |
| `/retro global` | - | 跨项目回顾 |

---

## 执行指令

**实际执行时，加载并执行原始 gstack/retro SKILL.md**：

```bash
# 加载 gstack retro 技能
cat ~/.claude/skills/gstack/retro/SKILL.md

# 执行完整 retro 工作流
# （由 AI 根据加载的 SKILL.md 内容执行）
```

**关键特性**：
- **团队感知**：分析每个成员的贡献
- **历史追踪**：保存回顾历史，趋势对比
- **持久化**：JSON格式存储，支持长期分析
- **叙事报告**：生成可读的回顾报告

---

## 输出格式

```
## Retro 回顾报告
**时间窗口**：{N}天 ({start} - {end})
**分支**：{branch}
**来源**：gstack/retro

### 关键指标
- Features shipped：{N}
- Commits：{M}
- LOC changed：{+X/-Y}
- Test ratio：{Z}%
- Contributors：{K}

### Ship of the week
{highlight-feature}

### 团队贡献
{per-member-summary}

### 趋势分析
{week-over-week-comparison}
```

---

## 与尚宫局原有能力的关系

- **learn.md**：retro 分析历史，learn 管理学习经验，互补使用
- **ship.md**：retro 分析 ship 的产出，形成闭环

---

## 参考文档

详细流程参考：`references/gstack-retro-guide.md`

原始技能：`~/.claude/skills/gstack/retro/SKILL.md`

---

_尚宫局·昭妃回顾能力，整合 gstack retro 工作流_