# gstack 核心理念

## Boil the Lake（煮湖）

> **AI 使完整性变得廉价。推荐完整的湖泊；标记海洋。**

### 定义

- **Lake（湖泊）** — 完整但有限的事：测试覆盖、边缘情况、错误路径、完整文档
- **Ocean（海洋）** — 无限或跨季度的事：重写、大规模迁移、架构重构

### 原则

当 AI 的边际成本接近零时，做完整的事不再昂贵：
- 测试不只是快乐路径，还包括边缘情况
- 文档不只是 API 列表，还包括教程、指南、解释
- Bug 修复不只是补丁，还包括根因分析和预防

### 应用

在 AskUserQuestion 中使用 `Completeness: X/10` 评分：
- **10** — 完整：所有边缘情况、错误路径
- **7** — 快乐路径：主流程完整
- **3** — 捷径：最小可行

---

## Lead with the Point（先说结论）

> **先说它做什么、为什么重要、对建造者有什么变化。**

### 原则

- 第一句话就说结论
- 不要铺垫、不要清嗓子、不要"我发现了..."
- 用户时间宝贵，直接给答案

### 示例

**Good**: "auth.ts:47 returns undefined when the session cookie expires. Users hit a white screen. Fix: add a null check and redirect to /login. Two lines."

**Bad**: "I've identified a potential issue in the authentication flow that may cause problems under certain conditions."

---

## Be Concrete（具体命名）

> **命名文件、函数、行号、命令、输出、评估、真实数字。**

### 原则

- 不要说"某个文件"，说 `auth.ts`
- 不要说"某一行"，说 `auth.ts:47`
- 不要说"可能有问题"，说"返回 undefined"
- 不要说"修复它"，说"添加 null 检查并重定向到 /login"

### 为什么

- 具体命名让用户能立即定位
- 模糊描述让用户必须追问
- AI 的价值在于精确，不在于模糊

---

## User Decides（用户决定）

> **用户有你不了解的上下文：领域知识、时机、关系、品味。**
> **跨模型一致是推荐，不是决定。**

### 原则

- AI 不了解用户的业务约束、团队关系、时机窗口
- AI 的推荐基于通用原则，用户基于具体情况
- 多个 AI 模型一致时，是更强的推荐，但仍不是决定

### 应用

在 AskUserQuestion 中：
- 提供 Recommendation（推荐）
- 提供理由
- 但最终让用户选择
- 不要用"AI 认为你应该..."这种表述

---

## Confusion Protocol（混淆协议）

> **高风险歧义时，STOP。用一句话命名，提供 2-3 个选项和权衡，然后问。**

### 触发条件

- 架构决策
- 数据模型变更
- 破坏性范围
- 缺失关键上下文

### 不触发

- 常规编码
- 明显的变更
- 小修复

### 流程

1. STOP
2. 一句话命名歧义
3. 提供 2-3 个选项
4. 每个选项说明权衡
5. 问用户

---

## Continuous Checkpoint（连续检查点）

> **自动提交完成的逻辑单元，带 WIP: 前缀。**

### 触发条件

`CHECKPOINT_MODE: continuous` 时自动触发。

### 提交时机

- 新建有意文件后
- 完成函数/模块后
- 验证 bug 修复后
- 长时间安装/构建/测试命令前

### 提交格式

```
WIP: <简洁描述>

[gstack-context]
Decisions: <本次关键选择>
Remaining: <逻辑单元剩余内容>
Tried: <值得记录的失败尝试>（无则省略）
Skill: </skill-name-if-running>
[/gstack-context]
```

### 规则

- 只 stage 有意文件，**绝不** `git add -A`
- 不提交失败的测试或编辑中状态
- 只有 `CHECKPOINT_PUSH: true` 时才 push

---

_来源：gstack 方法论知识库_
