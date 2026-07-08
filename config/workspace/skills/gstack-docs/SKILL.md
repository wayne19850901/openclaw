---
name: gstack-docs
version: 1.0.0
description: |
  gstack 方法论知识库。整合 Garry Tan 开发工具链的核心理念、工作流、决策原则。
  六局一司所有 gstack 整合技能包的参考知识源。
triggers:
  - gstack 方法论
  - gstack 理念
  - Boil the Lake
  - gstack 工作流
  - gstack 决策
---

# gstack 方法论知识库

> **gstack = Garry Tan's development workflow toolkit**
> AI 使完整性变得廉价。推荐完整的湖泊（测试、边缘情况、错误路径）；标记海洋（重写、多季度迁移）。

## 核心理念

| 理念 | 说明 |
|------|------|
| **Boil the Lake** | AI 使完整性成本接近零，做完整的事而非最小可行 |
| **Lead with the point** | 先说结论，再说细节 |
| **Be concrete** | 命名文件、函数、行号、命令、输出、真实数字 |
| **User decides** | 用户有你不了解的上下文，跨模型一致是推荐，不是决定 |

## 核心工作流

| 工作流 | 触发词 | 说明 |
|--------|--------|------|
| **review** | 代码审查、diff 检查 | 独立 diff 审查，pass/fail 门控 |
| **ship** | 发布、部署、PR | 完整发布流程：review → test → commit → push |
| **qa** | 测试、验证 | QA 测试，验证页面行为 |
| **investigate** | 调查、排查 | Bug 调查，根因分析 |
| **office-hours** | 创业咨询、产品想法 | YC Office Hours 式六问框架 |
| **plan-ceo-review** | CEO 评审、计划评审 | CEO/founder-mode 计划评审 |
| **autoplan** | 自动评审、全流程评审 | 自动运行 CEO → Design → Eng → DX 评审流水线 |
| **design-review** | 设计审查、视觉 QA | 设计师视角 QA：视觉一致性、间距、层级 |
| **learn** | 经验沉淀、项目学习 | 管理项目学习记录 |
| **document-generate** | 文档生成、教程生成 | Diataxis 框架文档生成 |
| **document-release** | 文档发布、上线审核 | Post-ship 文档更新 |

## 决策原则

### AskUserQuestion 格式

每个决策必须包含：
- **D<N>** — 决策编号
- **ELI10** — 10 岁能懂的解释
- **Stakes** — 选错的代价
- **Recommendation** — 推荐选项及理由
- **Completeness** — 完整性评分（0-10）或类型差异说明
- **Pros/Cons** — 每个选项 ≥2 个优点、≥1 个缺点，每条 ≥40 字符
- **Net** — 权衡总结

### 完整性评分

- **10** — 完整：所有边缘情况、错误路径
- **7** — 快乐路径：主流程完整
- **3** — 捷径：最小可行

### 六大决策原则（autoplan）

1. **保守默认** — 有疑问时默认保守选项
2. **范围优先** — 范围变更优先询问
3. **证据驱动** — 基于证据而非假设
4. **一致性** — 与已有决策保持一致
5. **可逆性** — 优先可逆决策
6. **品味校准** — 跨模型分歧时标记品味决策

## 写作风格（Voice）

### ✅ 推荐

- 先说结论
- 具体命名：文件、函数、行号、命令
- 关联用户结果：用户看到什么、失去什么、等待什么、能做什么
- 直接说质量：Bug 重要、边缘情况重要
- 像建造者对建造者说话

### ❌ 避免

- 破折号（em dashes）
- AI 词汇：delve, crucial, robust, comprehensive, nuanced, multifaceted, furthermore, moreover, additionally, pivotal, landscape, tapestry, underscore, foster, showcase, intricate, vibrant, fundamental, significant
- 企业腔、学术腔、公关腔、炒作腔
- 填充词、清嗓子、泛泛乐观、创始人角色扮演

### 示例

**Good**: "auth.ts:47 returns undefined when the session cookie expires. Users hit a white screen. Fix: add a null check and redirect to /login. Two lines."

**Bad**: "I've identified a potential issue in the authentication flow that may cause problems under certain conditions."

## 与六局一司整合

| 六局一司 | gstack 整合 | 整合技能包 |
|----------|-------------|------------|
| 尚机局·谨妃 | browse, pair-agent, codex | jin-fei-gstack |
| 尚融局·贵妃 | office-hours, plan-ceo-review, autoplan | rong-fei-gstack |
| 尚宣局·仪妃 | design-review, plan-design-review | xuan-fei-gstack |
| 尚教局·令妃 | learn, document-generate, document-release | ling-fei-gstack |

## 版本历史

- v1.0.0 — 初始版本，整合 gstack 方法论核心内容
