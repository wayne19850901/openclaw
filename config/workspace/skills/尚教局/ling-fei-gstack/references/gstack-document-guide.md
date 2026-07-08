# gstack 文档能力完整指南

## 概述

gstack 提供两个文档相关技能：`document-generate`（文档生成）和 `document-release`（文档发布）。
令妃将其用于教学内容的结构化创作与发布审核。

---

## document-generate — 文档生成

### Diataxis 框架

Diataxis 是文档分类框架，将文档分为四个象限：

| 象限 | 类型 | 用户需求 | 结构特点 |
|------|------|----------|----------|
| **Tutorial** | 教程 | 学习导向：我想学会 | 步骤式、引导式、学习者视角 |
| **How-to** | 操作指南 | 任务导向：我想解决 | 问题-解决方案式、可跳读 |
| **Reference** | 参考文档 | 信息导向：我想查阅 | 结构化、完整、可检索 |
| **Explanation** | 解释文档 | 理解导向：我想理解 | 概念式、背景、原理 |

### 生成流程

```
Step 0: 分析缺口
  ↓
Step 1: 确定文档类型（Diataxis 四象限）
  ↓
Step 2: 收集素材（代码、配置、已有文档）
  ↓
Step 3: 生成文档内容
  ↓
Step 4: 交叉引用检查
  ↓
Step 5: 输出与提交建议
```

### 教育场景映射

| Diataxis 类型 | 教育文档类型 | 示例 |
|---------------|-------------|------|
| Tutorial | 课程教程 | "Python 入门教程：从零到一" |
| How-to | 操作指南 | "如何安装 Python 环境" |
| Reference | 知识点速查 | "Python 语法速查表" |
| Explanation | 概念解析 | "什么是面向对象编程" |

---

## document-release — 文档发布

### 发布流程

```
Step 0: 平台检测与基分支确认
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

### 覆盖度地图

检查每个新/变更的公共接口是否在四个象限都有覆盖：

```
Coverage map:
  [entity]         [reference?] [how-to?] [tutorial?] [explanation?]
  /new-skill       ✅ AGENTS.md  ❌        ❌          ❌
  --new-flag       ✅ README     ✅ README  ❌          ❌
  FooProcessor     ❌            ❌        ❌          ❌
```

- **Critical gaps** — 零覆盖的公共接口
- **Common gaps** — 只有 reference 覆盖（缺 how-to/tutorial）

### CHANGELOG 润色规则

**Sell-test 评分（0-3）**：
- **1 分** — 回答"改了什么"（reference）
- **1 分** — 回答"为什么关心"（explanation：用户影响）
- **1 分** — 回答"怎么用"（how-to：命令/链接）

评分 < 2 需重写，评分 = 3 为黄金标准。

**关键禁令**：
- **绝不覆盖 CHANGELOG** — 只润色措辞，不删除/替换/重新生成条目
- **绝不静默升级版本** — 版本变更必须询问用户

### 教育场景映射

| document-release 步骤 | 教育发布场景 |
|-----------------------|-------------|
| Diff 分析 | 教学内容变更对比 |
| 覆盖度地图 | 知识点覆盖度检查 |
| README 更新 | 课程介绍更新 |
| CHANGELOG 润色 | 课程更新日志润色 |
| 版本号管理 | 课程版本管理 |

---

## 联动工作流

令妃推荐的教学文档工作流：

```
课程设计
  ↓
document-generate(tutorial) — 生成课程教程
  ↓
document-generate(reference) — 生成知识点速查
  ↓
document-generate(how-to) — 生成操作指南
  ↓
document-release — 发布前审核覆盖度
  ↓
post-to-wechat — 发布到公众号
  ↓
learn — 沉淀本次创作经验
```

---

_尚教局·令妃 — gstack 文档能力整合参考_