# 幻灯片/演示稿生成

## 概述

从内容生成专业幻灯片图片。创建带风格指令的大纲，然后生成单张幻灯片图片。

## 使用方式

```bash
/baoyu-slide-deck path/to/content.md
/baoyu-slide-deck path/to/content.md --style sketch-notes
/baoyu-slide-deck path/to/content.md --audience executives
/baoyu-slide-deck path/to/content.md --slides 10
```

## 工作流程

### 步骤1：设置与分析

1. 加载偏好设置（EXTEND.md）
2. 分析内容信号
3. 检测语言
4. 确定推荐幻灯片数量
5. 检查现有内容

### 步骤2：确认选项

确认：风格、受众、幻灯片数量、是否审核大纲、是否审核提示词

### 步骤3：生成大纲

基于确认的风格创建大纲

### 步骤4：审核大纲（可选）

如果用户选择审核，展示大纲并确认

### 步骤5：生成提示词

为每张幻灯片创建图片生成提示词

### 步骤6：审核提示词（可选）

如果用户选择审核，展示提示词并确认

### 步骤7：生成图片

按顺序生成每张幻灯片图片

### 步骤8：合并为PPTX和PDF

```bash
bun scripts/merge-to-pptx.ts <slide-deck-dir>
bun scripts/merge-to-pdf.ts <slide-deck-dir>
```

### 步骤9：输出摘要

## 风格预设

| 预设 | 适用场景 |
|------|----------|
| `blueprint`（默认） | 架构、系统设计 |
| `chalkboard` | 教育、教程 |
| `corporate` | 投资者演示、提案 |
| `minimal` | 高管简报 |
| `sketch-notes` | 教育、教程 |
| `watercolor` | 生活方式、健康 |
| `notion` | 产品演示、SaaS |
| `bold-editorial` | 产品发布、主题演讲 |

## 自动风格选择

| 内容信号 | 预设 |
|----------|------|
| tutorial, learn, education | `sketch-notes` |
| architecture, system, technical | `blueprint` |
| executive, minimal, clean | `minimal` |
| saas, product, dashboard | `notion` |
| investor, quarterly, business | `corporate` |
| launch, marketing, keynote | `bold-editorial` |

## 输出结构

```
slide-deck/{topic-slug}/
├── source-{slug}.{ext}
├── outline.md
├── prompts/
│   └── 01-slide-cover.md, 02-slide-{slug}.md, ...
├── 01-slide-cover.png, 02-slide-{slug}.png, ...
├── {topic-slug}.pptx
└── {topic-slug}.pdf
```

## 设计哲学

为**阅读和分享**设计的演示稿，而非现场演讲：
- 每张幻灯片无需口头解说即可理解
- 滚动时的逻辑流畅
- 所有必要的上下文都在幻灯片内
- 为社交媒体分享优化

---

_来源：release-skills/baoyu-slide-deck_
