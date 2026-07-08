---
name: OpenClaw系统优化执行计划
overview: 基于OpenClaw完整清单报告，执行系统化优化方案，涵盖插件精简、Skills整合、Agent能力增强、模型智能选择四个层面，分4个Phase逐步实施，预计8周完成。
todos:
  - id: phase1-backup
    content: 备份当前 claw.json 配置文件
    status: completed
  - id: phase1-plugin-remove
    content: 移除 memory-core 插件配置，评估 volcengine 插件去留
    status: completed
    dependencies:
      - phase1-backup
  - id: phase1-skill-merge
    content: 创建 unified-doc-processor 技能整合 ocr-space 和 pdf-extract
    status: completed
    dependencies:
      - phase1-backup
  - id: phase1-cost-monitor
    content: 创建模型成本监控脚本
    status: completed
    dependencies:
      - phase1-backup
  - id: phase1-policy-update
    content: 更新 SKILLS-POLICY.md 记录变更
    status: completed
    dependencies:
      - phase1-plugin-remove
      - phase1-skill-merge
  - id: phase2-l3-skills
    content: 为7个L3 Agent创建专业化技能配置
    status: completed
    dependencies:
      - phase1-policy-update
  - id: phase2-edu-merge
    content: 合并教育技能为 ling-fei-education-pro
    status: completed
    dependencies:
      - phase1-policy-update
  - id: phase2-model-selection
    content: 实现智能模型选择策略
    status: completed
    dependencies:
      - phase1-cost-monitor
  - id: phase3-collab
    content: 实现妃子级Agent跨局协作机制
    status: completed
    dependencies:
      - phase2-l3-skills
  - id: phase3-queen-upgrade
    content: 升级Queen决策算法
    status: completed
    dependencies:
      - phase3-collab
  - id: phase3-innovation
    content: 迭代 proactive-agent 和 self-improving-agent
    status: completed
    dependencies:
      - phase2-l3-skills
  - id: phase4-eval
    content: 评估优化效果，生成报告
    status: completed
    dependencies:
      - phase3-queen-upgrade
      - phase3-innovation
---

## 用户需求

用户希望按照之前整理的优化方案执行 OpenClaw 系统优化。

**原始请求**："按照你的建议执行"

**优化方案来源**：`OpenClaw系统优化方案.md`

**核心优化目标**：

1. 插件精简：移除重复功能的插件
2. Skills整合：合并功能重叠的技能
3. Agent能力增强：L3级专业化配置、妃子跨局协作、Queen决策升级
4. 模型智能选择：根据任务类型自动选择最优模型

## 产品概述

OpenClaw 是一个基于"六局一司"架构的 AI Agent 系统，包含：

- 14个Agent（Queen + 6妃子 + 7尚座）
- 31个Skills（按局司分类）
- 11个模型配置
- 2个通道（Telegram、飞书）

本次优化将分4个阶段执行，预计8周完成，预期收益：

- 系统效率提升 25-30%
- 任务自动化率 60% → 85%
- 模型成本降低 35%
- 决策准确率 75% → 92%

## 技术栈

- **配置格式**：JSON（claw.json, installs.json）
- **技能定义**：YAML frontmatter + Markdown（SKILL.md）
- **Agent定义**：Markdown（IDENTITY.md, AGENT.md）
- **主配置目录**：`/Users/linwei/.claw/`

## 实现方法

采用分阶段渐进式优化策略，每个阶段独立可验证，支持灰度发布和回滚。

### Phase 1: 快速优化（1-2周）

**目标**：立即见效的低风险优化

1. **插件精简**

- 在 `claw.json` 的 `plugins.entries` 中将 `memory-core` 的 `enabled` 设为 `false`（已禁用，需确认移除）
- 评估 `volcengine` 插件保留策略

2. **Skills整合**

- 创建 `unified-doc-processor` 技能，整合 `ocr-space` 和 `pdf-extract`
- 更新 `SKILLS-POLICY.md` 记录变更

3. **成本监控**

- 创建模型调用日志脚本，记录各模型使用频率和成本

### Phase 2: 能力增强（3-4周）

**目标**：提升Agent专业化能力

1. **L3级Agent专业化**

- 为7个L3 Agent创建专属技能配置
- 每个Agent新增2-3个专业化技能

2. **教育技能整合**

- 合并 `ling-fei-edu` + `ling-fei-education` → `ling-fei-education-pro`

3. **智能模型选择**

- 实现任务类型识别逻辑
- 配置任务-模型映射规则

### Phase 3: 架构升级（5-8周）

**目标**：系统架构深度优化

1. **跨局协作机制**

- 定义协作协议和数据格式
- 实现典型协作场景

2. **Queen决策升级**

- 实现多维度决策模型
- 添加动态负载均衡

3. **创新技能迭代**

- 优化 `proactive-agent` 和 `self-improving-agent`

## 实现细节

### 关键文件路径

| 文件 | 路径 | 操作 |
| --- | --- | --- |
| 主配置 | `/Users/linwei/.claw/claw.json` | MODIFY |
| 技能策略 | `/Users/linwei/.claw/workspace/skills/SKILLS-POLICY.md` | MODIFY |
| 文档处理技能 | `/Users/linwei/.claw/workspace/skills/尚机局/unified-doc-processor/` | NEW |
| L3 Agent技能 | `/Users/linwei/.claw/agents/{Agent}/skills/` | NEW |
| 教育整合技能 | `/Users/linwei/.claw/workspace/skills/尚教局/ling-fei-education-pro/` | NEW |
| 模型监控脚本 | `/Users/linwei/.claw/scripts/model-cost-monitor.py` | NEW |


### 风险控制

1. **备份机制**：每个Phase开始前备份 `claw.json`
2. **灰度发布**：新技能先在测试Agent验证
3. **回滚脚本**：保留一键回滚能力

## Agent Extensions

### Skill

- **writing-plans**: 用于编写详细的实施计划文档，确保每个优化步骤有清晰的执行路径
- **skill-creator**: 用于创建新的Skills（如 unified-doc-processor、ling-fei-education-pro），确保技能定义符合规范