# gstack Retro 参考指南

**精简版参考文档，完整流程请查看原始 SKILL.md**

---

## 概述

Retro 是 gstack 的周回顾工作流，分析 commit 历史、工作模式、代码质量指标。

**触发词**：`weekly retro`, `what did we ship`, `engineering retrospective`

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

## 14步工作流摘要

| Step | 名称 | 关键动作 |
|------|------|----------|
| 1 | Gather raw data | 12个并行 git 命令收集数据 |
| 2 | Compute metrics | Features shipped, commits, LOC, test ratio |
| 3 | Commit time distribution | 分析提交时间分布 |
| 4 | Work session detection | 检测工作会话（45min gap） |
| 5 | Commit type breakdown | 分类 commit 类�� |
| 6 | Hotspot analysis | 分析高频修改文件 |
| 7 | PR size distribution | 分析 PR 大小分布 |
| 8 | Focus score | 计算专注度 + Ship of the week |
| 9 | Team member analysis | 每个成员的贡献分析 |
| 10 | Week-over-week trends | >=14d 时趋势对比 |
| 11 | Streak tracking | 连续工作天数追踪 |
| 12 | Load history | 加载历史 retro 数据 |
| 13 | Save retro history | 保存 JSON 格式历史 |
| 14 | Write narrative | 撰写可读报告 |

---

## 关键指标

### 基础指标
- Features shipped
- Commits count
- LOC changed（+/-）
- Test ratio
- Contributors count

### 高级指标
- Focus score（专注度）
- Ship of the week（本周亮点）
- Hotspots（高频文件）
- Work sessions（工作会话数）

---

## Team Member Analysis

每个成员的分析包含：
- Commits count
- LOC changed
- Test ratio
- **表扬**：突出贡献
- **成长建议**：改进空间

---

## Global Retro Mode

跨项目回顾：
- 分析所有 AI coding tools 的产出
- 生成可分享的个人卡片
- Cross-project patterns

---

## Compare Mode

与上期对比：
- Side-by-side comparison
- Trend visualization
- Delta metrics

---

## 输出格式

```
## Retro 回顾报告
**时间窗口**：{N}天 ({start} - {end})
**分支**：{branch}

### 关键指标
- Features shipped：{N}
- Commits：{M}
- LOC：{+X/-Y}
- Test ratio：{Z}%
- Contributors：{K}

### Ship of the week
{highlight-feature}

### 团队贡献
{per-member-summary}

### Hotspots
{top-modified-files}

### 工作模式
{session-analysis}

### 趋势
{week-over-week}
```

---

## 历史存储

JSON 格式存储在：
```
~/.gstack/projects/{slug}/retro-history.jsonl
```

支持：
- 长期趋势分析
- Cross-retro comparison
- Streak tracking

---

_参考：~/.claude/skills/gstack/retro/SKILL.md（完整版）_