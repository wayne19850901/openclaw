# 文档发布（document-release）

## 概述

教学内容上线前的文档审核与发布工作流。gstack/document-release 提供 post-ship 文档更新、
覆盖度地图、CHANGELOG 润色等能力，令妃将其用于教学内容的发布审核。

## 触发词

- 文档发布
- 上线文档
- 发布审核
- 文档检查
- 覆盖度检查
- document-release

## 核心流程

```
教学内容完成
  ↓
Step 1: Diff 分析 — 对比变更内容
  ↓
Step 1.5: 覆盖度地图 — Diataxis 四象限覆盖检查
  ↓
Step 2: 逐文件审核 — README/ARCHITECTURE/CONTRIBUTING 等
  ↓
Step 3: 自动更新 — 事实性修正
  ↓
Step 4: 人工确认 — 叙述性/主观性变更
  ↓
Step 5: CHANGELOG 润色 — sell-test 评分
  ↓
Step 6: 跨文档一致性检查
  ↓
Step 7: TODOS 清理
  ↓
Step 8: 版本号确认
  ↓
Step 9: 提交与输出
```

## 教育场景映射

| gstack 场景 | 令妃教育场景 |
|-------------|-------------|
| 代码变更 diff | 教学内容变更 diff |
| README 更新 | 课程介绍更新 |
| CHANGELOG 润色 | 课程更新日志润色 |
| 覆盖度地图 | 教学内容覆盖度检查（是否有遗漏知识点） |
| 版本号管理 | 课程版本管理 |

## 关键规则

1. **绝不覆盖 CHANGELOG** — 只润色措辞，不删除/替换/重新生成条目
2. **绝不静默升级版本** — 版本变更必须询问用户
3. **覆盖度地图只标记缺口** — 不自动生成缺失文档，建议使用 document-generate 补充
4. **架构图漂移仅标记** — 不自动编辑 ASCII/Mermaid 图表

## 执行指令

**中度映射**：本文件定义触发词和教育场景映射，实际执行时加载 gstack 原始 SKILL.md：

```
读取并遵循 ~/.claude/skills/gstack/document-release/SKILL.md
```

执行时将 gstack 的代码发布语境转换为教学内容发布语境。

## 产出标记

`[文档发布报告]`

---

_尚教局·令妃 — gstack/document-release 整合_
