---
name: openclaw-architecture-fix
overview: 修复OpenClaw六局一司架构：局级Agent重命名加后缀、司级降级为Skill迁移到workspace/skills、补全标准文件并提升内容质量
todos:
  - id: phase1-backup
    content: 备份当前状态到 ~/.claw/backups/2026-05-19/
    status: pending
  - id: phase2-migrate-siji
    content: 迁移8个司级到 workspace/skills/{局名}/司级/ 目录，转换为 Skill 格式
    status: pending
    dependencies:
      - phase1-backup
  - id: phase3-rename-bureau
    content: 重命名7个局级 Agent 目录，统一加后缀
    status: pending
    dependencies:
      - phase2-migrate-siji
  - id: phase4-standardize-agents
    content: 为14个 Agent 补全标准文件结构
    status: pending
    dependencies:
      - phase3-rename-bureau
  - id: phase5-content-quality
    content: 优化所有 Agent 的 Prompt 内容质量
    status: pending
    dependencies:
      - phase4-standardize-agents
  - id: phase6-verify-update
    content: 验证架构修复结果，更新文档，生成完成报告
    status: pending
    dependencies:
      - phase5-content-quality
---

## 产品概述

修复 OpenClaw Agent 系统的架构问题，确保目录结构、命名规范、文件完整性符合架构文档定义。

## 核心功能

- 司级从 Agent 降级为 Skill，迁移到 workspace/skills/{局名}/司级/ 目录
- 局级 Agent 目录命名统一加后缀（尚宣局、尚工局等）
- 补全所有 Agent 的标准文件（AGENT.md、IDENTITY.md、PROMPT.md、drivers/等）
- 提升内容质量，确保职责清晰、能力定义完整

## 技术栈

- 配置文件：Markdown (.md)、JSON
- 目录结构：符合 OpenClaw 框架规范
- 参考模板：`~/.claw/agents/尚科/AGENT.md`

## 实施方案

### Phase 1：备份当前状态

```
mkdir -p ~/.claw/backups/2026-05-19
cp -r ~/.claw/agents ~/.claw/backups/2026-05-19/
cp -r ~/.claw/workspace/skills ~/.claw/backups/2026-05-19/
```

### Phase 2：迁移司级到 Skills（8个）

| 司级 | 原路径 | 目标路径 |
| --- | --- | --- |
| 司具师 | `agents/司具师/` | `workspace/skills/尚工局/司级/司具师/` |
| 司增师 | `agents/司增师/` | `workspace/skills/尚宣局/司级/司增师/` |
| 司安师 | `agents/司安师/` | `workspace/skills/御鉴司/司级/司安师/` |
| 司实师 | `agents/司实师/` | `workspace/skills/御鉴司/司级/司实师/` |
| 司投师 | `agents/司投师/` | `workspace/skills/尚融局/司级/司投师/` |
| 司研师 | `agents/司研师/` | `workspace/skills/尚宫局/司级/司研师/` |
| 司证师 | `agents/司证师/` | `workspace/skills/御鉴司/司级/司证师/` |
| 司试师 | `agents/司试师/` | `workspace/skills/尚机局/司级/司试师/` |


转换规则：

- 保留 IDENTITY.md 核心内容
- 创建轻量 SKILL.md（含 YAML frontmatter）
- 移除不必要的 Agent 结构（executors、tools.md等）

### Phase 3：重命名局级目录（7个）

| 原名 | 新名 |
| --- | --- |
| `agents/尚宣` | `agents/尚宣局` |
| `agents/尚宫` | `agents/尚宫局` |
| `agents/尚教` | `agents/尚教局` |
| `agents/尚机` | `agents/尚机局` |
| `agents/尚科` | `agents/尚工局` |
| `agents/尚融` | `agents/尚融局` |
| `agents/御鉴` | `agents/御鉴司` |


### Phase 4：补全 Agent 标准文件

为14个 Agent 补全以下结构：

```
Agent/
├── AGENT.md        # 行为规范
├── IDENTITY.md     # 身份定义
├── PROMPT.md       # Prompt模板
├── SKILL.md        # 技能配置
├── drivers/
│   ├── core.md
│   ├── constraints.md
│   └── triggers.md
├── memory/
│   ├── MEMORY.md
│   └── daily/
├── references/
├── scripts/
└── tools.md
```

### Phase 5：内容质量提升

优化要点：

- 职责定义：明确核心职责和边界
- 能力清单：表格形式列出能力项
- 协作关系：上级、下属、平级
- 触发词：中英文双语触发词
- 工作流程：标准化流程图

### Phase 6：验证与文档更新

- 验证目录结构正确性
- 验证文件完整性
- 更新 AGENT_ARCHITECTURE.md
- 更新 PROGRESS.md
- 生成完成报告

## 目录结构（修复后）

```
~/.claw/
├── agents/                          # Agent 目录（14个）
│   ├── main/                         # Queen
│   ├── 贵妃/、慧妃/、仪妃/、令妃/、谨妃/、昭妃/  # 6妃子
│   ├── 尚融局/、尚工局/、尚宣局/、尚教局/、尚机局/、尚宫局/  # 6局
│   └── 御鉴司/                        # 1司
│
└── workspace/skills/                 # Skills 目录
    ├── 尚融局/
    │   ├── 司级/
    │   │   └── 司投师/SKILL.md
    │   └── [现有skills]
    ├── 尚工局/
    │   ├── 司级/
    │   │   └── 司具师/SKILL.md
    │   └── [现有skills]
    ├── 尚宣局/
    │   ├── 司级/
    │   │   └── 司增师/SKILL.md
    │   └── [现有skills]
    ├── 尚教局/
    │   └── [现有skills]
    ├── 尚机局/
    │   ├── 司级/
    │   │   └── 司试师/SKILL.md
    │   └── [现有skills]
    ├── 尚宫局/
    │   ├── 司级/
    │   │   └── 司研师/SKILL.md
    │   └── [现有skills]
    ├── 御鉴司/
    │   ├── 司级/
    │   │   ├── 司安师/SKILL.md
    │   │   ├── 司实师/SKILL.md
    │   │   └── 司证师/SKILL.md
    │   └── [现有skills]
    └── 共享/
        └── [现有skills]
```

## Agent Extensions

### Skill

- **gstack-investigate**：用于系统化调查架构问题和验证修复结果
- **sp-writing-plans**：用于编写详细的实施计划文档

### SubAgent

- **code-explorer**：用于搜索和验证目录结构、文件引用关系