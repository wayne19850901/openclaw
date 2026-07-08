# 教程生成（document-generate）

## 概述

按 Diataxis 框架生成文档——教程（tutorial）、操作指南（how-to）、参考文档（reference）、
解释文档（explanation）。gstack/document-generate 提供完整的文档生成工作流，
令妃将其用于教育内容创作。

## 触发词

- 教程生成
- 文档生成
- 写教程
- 生成操作指南
- 写参考文档
- 生成解释文档
- document-generate

## Diataxis 四象限

| 象限 | 类型 | 学习目标 | 教育场景 |
|------|------|----------|----------|
| Tutorial | 教程 | 学习导向：跟着做一遍 | 新课程入门、新工具上手 |
| How-to | 操作指南 | 任务导向：解决具体问题 | 操作步骤、常见问题解决 |
| Reference | 参考文档 | 信息导向：查阅 API/配置 | 知识点速查、公式表、语法参考 |
| Explanation | 解释文档 | 理解导向：理解为什么 | 概念解析、设计原理、背景知识 |

## 教育场景映射

| gstack 场景 | 令妃教育场景 |
|-------------|-------------|
| 代码教程 | 课程教程（编程课、工具课） |
| API 参考文档 | 知识点参考卡 |
| 架构解释文档 | 概念深度解析 |
| 操作指南 | 实验操作步骤 |

## 执行指令

**中度映射**：本文件定义触发词和教育场景映射，实际执行时加载 gstack 原始 SKILL.md：

```
读取并遵循 ~/.claude/skills/gstack/document-generate/SKILL.md
```

执行时将 gstack 的技术文档语境转换为教育文档语境。

## 产出标记

`[教程生成报告]`

---

_尚教局·令妃 — gstack/document-generate 整合_
