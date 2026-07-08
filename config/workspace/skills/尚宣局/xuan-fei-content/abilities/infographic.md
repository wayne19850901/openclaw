# 信息图生成

## 概述

生成专业信息图，支持21种布局和20种视觉风格。分析内容，推荐布局×风格组合，生成出版级信息图。

## 使用方式

```bash
/baoyu-infographic path/to/content.md
/baoyu-infographic path/to/content.md --layout hierarchical-layers --style technical-schematic
/baoyu-infographic path/to/content.md --aspect portrait --lang zh
```

## 工作流程

### 步骤1：分析与设置

1. 加载偏好设置（EXTEND.md）
2. 分析内容：主题、数据类型、复杂度、语调、受众
3. 检测源语言和用户语言
4. 生成主题slug

### 步骤2：生成结构化内容

转换为信息图结构：
- 标题和学习目标
- 带有视觉元素的章节
- 数据点（完全复制）
- 用户设计指令

### 步骤3：推荐组合

基于内容特征推荐3-5种布局×风格组合：
- 数据结构 → 匹配布局
- 内容语调 → 匹配风格
- 受众期望
- 用户设计指令

### 步骤4：确认选项

确认：组合、宽高比、语言

### 步骤5：生成图片

调用图片生成技能

### 步骤6：输出摘要

报告：主题、布局、风格、宽高比、语言、输出路径

## 布局速查

| 布局 | 适用场景 |
|------|----------|
| `linear-progression` | 时间线、流程、教程 |
| `binary-comparison` | A vs B、前后对比 |
| `comparison-matrix` | 多因素比较 |
| `hierarchical-layers` | 金字塔、优先级 |
| `tree-branching` | 分类、分类学 |
| `hub-spoke` | 中心概念与相关项 |
| `structural-breakdown` | 分解视图、截面 |
| `bento-grid` | 多主题、概览（默认） |
| `iceberg` | 表面vs隐藏方面 |
| `dashboard` | 指标、KPI |

## 风格速查

| 风格 | 描述 |
|------|------|
| `craft-handmade` | 手绘、纸工艺（默认） |
| `chalkboard` | 黑板上的粉笔 |
| `cyberpunk-neon` | 霓虹发光、未来主义 |
| `corporate-memphis` | 扁平矢量、活力 |
| `technical-schematic` | 蓝图、工程 |
| `minimal` | 极简、干净 |

## 推荐组合

| 内容类型 | 布局 + 风格 |
|----------|-------------|
| 时间线/历史 | `linear-progression` + `craft-handmade` |
| 步骤指南 | `linear-progression` + `ikea-manual` |
| A vs B | `binary-comparison` + `corporate-memphis` |
| 层级 | `hierarchical-layers` + `craft-handmade` |
| 技术 | `structural-breakdown` + `technical-schematic` |

## 输出结构

```
infographic/{topic-slug}/
├── source-{slug}.{ext}
├── analysis.md
├── structured-content.md
├── prompts/infographic.md
└── infographic.png
```

## 核心原则

- 忠实保留源数据——不总结或改写
- 在结构化内容前定义学习目标
- 为视觉传达构建结构

---

_来源：release-skills/baoyu-infographic_
