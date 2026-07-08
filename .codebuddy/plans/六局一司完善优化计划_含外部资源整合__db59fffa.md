---
name: 六局一司完善优化计划（含外部资源整合）
overview: 分五阶段执行：外部资源安装 → 命名方案统一 → gstack技能整合 → 插件安装 → 典级Skill实现。所有内容中文化，触发词双语化。
todos:
  - id: phase0-install-external
    content: 安装四大外部资源库（agency-agents、superpowers更新、gstack更新、financial-services）
    status: completed
  - id: phase1-naming-unify
    content: 更新架构文档统一命名方案（architecture-final、naming-scheme-final、PROGRESS.md）
    status: completed
    dependencies:
      - phase0-install-external
  - id: phase2-rong-fei-gstack
    content: 完善尚融局rong-fei-gstack整合包，整合financial-services投行插件
    status: completed
    dependencies:
      - phase1-naming-unify
  - id: phase2-xuan-fei-gstack
    content: 完善尚宣局xuan-fei-gstack整合包，整合agency-agents市场部模板
    status: completed
    dependencies:
      - phase1-naming-unify
  - id: phase2-hui-fei-gstack
    content: 完善尚工局hui-fei-gstack整合包，整合agency-agents工程部模板
    status: completed
    dependencies:
      - phase1-naming-unify
  - id: phase2-ling-fei-gstack
    content: 完善尚教局ling-fei-gstack整合包
    status: completed
    dependencies:
      - phase1-naming-unify
  - id: phase2-yujiansi-gstack
    content: 完善御鉴司yujiansi-gstack整合包，整合financial-services基金管理插件
    status: completed
    dependencies:
      - phase1-naming-unify
  - id: phase3-localize-chinese
    content: 中文化改造：检查8个司级SKILL.md触发词格式，确保中文关键词在前
    status: completed
    dependencies:
      - phase2-rong-fei-gstack
      - phase2-xuan-fei-gstack
      - phase2-hui-fei-gstack
      - phase2-ling-fei-gstack
      - phase2-yujiansi-gstack
  - id: phase4-dianji-create
    content: 创建63个典级Skill文件（中文版模板）
    status: completed
    dependencies:
      - phase3-localize-chinese
  - id: phase5-verify-update
    content: 验证完善结果，更新PROGRESS.md，生成完成报告
    status: completed
    dependencies:
      - phase4-dianji-create
---

## 产品概述

按渐进增强方案完善六局一司架构，整合四大外部资源库（agency-agents、superpowers、gstack、financial-services），实现中文化，分六阶段执行。

## 核心功能

- **Phase 0**：安装四大外部资源库（agency-agents、superpowers、gstack、financial-services）
- **Phase 1**：命名方案统一，更新架构文档以匹配当前目录命名
- **Phase 2**：整合外部资源到六局一司，完善gstack整合包
- **Phase 3**：中文化改造（简介改中文、触发词加中文）
- **Phase 4**：创建63个典级Skill文件，补全架构层级
- **Phase 5**：验证完善结果，更新PROGRESS.md，生成完成报告

## 技术栈

- 配置文件：Markdown (.md)、JSON
- 目录结构：符合 OpenClaw 框架规范
- 技能整合：gstack技能包、superpowers技能、financial-services插件、agency-agents模板
- 文件模板：司级SKILL.md标准格式（中文版）

## 实施方案

### Phase 0：安装外部资源库（30分钟）

**目标**：克隆并安装四大外部资源库

| 资源库 | 安装路径 | 安装命令 |
| --- | --- | --- |
| agency-agents | `~/.claw/workspace/skills/external/agency-agents/` | `git clone https://github.com/msitarzewski/agency-agents.git` |
| superpowers | `~/.claw/workspace/skills/superpowers/` | 已存在，执行 `git pull` 更新 |
| gstack | `~/.claw/workspace/skills/gstack/` | 已存在，执行 `git pull` 更新 |
| financial-services | `~/.claw/workspace/skills/external/financial-services/` | `git clone https://github.com/anthropics/financial-services.git` |


**安装脚本**：

```
# 创建外部资源目录
mkdir -p ~/.claw/workspace/skills/external

# 安装 agency-agents
cd ~/.claw/workspace/skills/external
git clone https://github.com/msitarzewski/agency-agents.git
cd agency-agents && ./scripts/install.sh --tool openclaw

# 更新 superpowers
cd ~/.claw/workspace/skills/superpowers && git pull

# 更新 gstack
cd ~/.claw/workspace/skills/gstack && git pull

# 安装 financial-services
cd ~/.claw/workspace/skills/external
git clone https://github.com/anthropics/financial-services.git
cd financial-services && ./install.sh --tool claude-code
```

### Phase 1：命名方案统一（30分钟）

**目标**：更新架构文档，消除命名冲突

| 操作 | 文件路径 | 内容 |
| --- | --- | --- |
| 更新architecture-final | `~/.claw/workspace/memory/architecture-final-2026-05-16.md` | 司级命名改为当前目录命名 |
| 更新naming-scheme-final | `~/.claw/workspace/memory/naming-scheme-final.md` | 标注为"诗意命名参考" |
| 更新PROGRESS.md | `~/.claw/PROGRESS.md` | 记录命名统一决策 |


**当前司级命名（保留）**：

| 局级 | 司级 | 职责 |
| --- | --- | --- |
| 尚工局 | 司具师 | MCP工具集成与API开发 |
| 尚宣局 | 司增师 | 用户增长与流量运营 |
| 御鉴司 | 司安师、司实师、司证师 | 安全审计、审计执行、合规审查 |
| 尚融局 | 司投师 | 投资分析与资金管理 |
| 尚宫局 | 司研师 | 研究分析与报告撰写 |
| 尚机局 | 司试师 | 测试验证与质量保障 |


### Phase 2：整合外部资源到六局一司（1小时）

**目标**：将外部资源映射到对应局级

| 外部资源 | 映射局级 | 整合方式 |
| --- | --- | --- |
| agency-agents工程部（前端/后端/AI工程师） | 尚工局 | 参考Agent设计模式，整合到hui-fei-gstack |
| agency-agents市场部（增长黑客/内容创作） | 尚宣局 | 参考增长黑客模板，整合到xuan-fei-gstack |
| agency-agents项目管理部（制作人/协调员） | 尚宫局 | 参考工作流程，整合到gong-fei-gstack |
| agency-agents财务部（簿记师/分析师） | 尚融局 | 参考财务分析模板 |
| agency-agents测试部（证据收集/现实检验） | 尚机局 | 参考测试流程，整合到jin-fei-gstack |
| financial-services投行/私募插件 | 尚融局 | 创建rong-fei-financial整合包 |
| financial-services基金管理/运营插件 | 御鉴司 | 创建yujiansi-financial整合包 |
| superpowers TDD/调试/计划编写 | 尚工局 | 已整合到hui-fei-gstack |
| gstack ship/browse/codex/qa | 尚宫局 | 已整合到gong-fei-gstack |


**gstack整合包完善**：

| 局级 | 整合包名 | 整合的技能 |
| --- | --- | --- |
| 尚融局 | rong-fei-gstack | benchmark、design-consultation、financial-analysis插件 |
| 尚宣局 | xuan-fei-gstack | design-review、design-shotgun、document-generate、scrape |
| 尚工局 | hui-fei-gstack | test-driven-development、mcp-builder、health、careful |
| 尚教局 | ling-fei-gstack | learn、document-generate、context-save |
| 御鉴司 | yujiansi-gstack | review、cso、verification-before-completion、guard |


### Phase 3：中文化改造（1小时）

**目标**：所有Skill和Agent文件实现中文化

**SKILL.md改造规则**：

| 改造项 | 原格式 | 新格式 |
| --- | --- | --- |
| description | 英文描述 | 中文描述 |
| 触发词 | `trigger: keyword` | `触发词：中文关键词、英文关键词` |
| 表头 | English Header | 中文表头 |
| 简介 | English intro | 中文简介 |


**SKILL.md模板（中文版）**：

```
---
description: [中文职责描述]。触发词：[中文关键词]、[英文关键词]
---

# [典级名]

## 基本信息
| 属性 | 值 |
|------|------|
| **名字** | [典级名] |
| **级别** | L5（典级） |
| **归属** | [局名] → [司级名] |
| **上级** | [司级名] |

## 核心职责
[一句话中文描述]

## 能力清单
| 能力项 | 描述 |
|--------|------|
| [能力1] | [中文描述] |

## 触发关键词
- "[中文关键词]"
- "[英文关键词]"
```

**需要中文化的文件范围**：

- 8个司级SKILL.md（已中文，需检查触发词格式）
- 6个局级AGENT.md（需检查简介）
- 6个局级IDENTITY.md（需检查简介）
- 63个典级SKILL.md（待创建，直接用中文版）

### Phase 4：典级Skill实现（2小时）

**目标**：创建63个典级SKILL.md文件（中文版）

**目录结构**：

```
workspace/skills/{局名}/司级/{司级名}/典级/{典级名}/SKILL.md
```

**典级命名规则**：

- 格式：X典（2个字）
- 必须以"典"结尾
- 全局唯一

**典级分布**：

| 局级 | 司级 | 典级（每司3典） |
| --- | --- | --- |
| 尚融局 | 司投师 | 投典、资典、金典 |
| 尚工局 | 司具师 | 工典、具典、器典 |
| 尚宣局 | 司增师 | 增典、流典、粉典 |
| 尚机局 | 司试师 | 试典、测典、验典 |
| 尚宫局 | 司研师 | 研典、报典、析典 |
| 御鉴司 | 司安师 | 安典、防典、护典 |
| 御鉴司 | 司实师 | 实典、查典、核典 |
| 御鉴司 | 司证师 | 证典、规典、合典 |


## 目录结构（完善后）

```
~/.claw/
├── workspace/
│   ├── memory/
│   │   ├── architecture-final-2026-05-16.md  # [MODIFY] 更新司级命名
│   │   └── naming-scheme-final.md            # [MODIFY] 标注为参考
│   ├── skills/
│   │   ├── external/                          # [NEW] 外部资源库
│   │   │   ├── agency-agents/                 # [NEW] 144+ Agent参考
│   │   │   │   └── INDEX.md                   # [NEW] 中文索引文件
│   │   │   └── financial-services/            # [NEW] 金融垂直
│   │   │       ├── agents/                    # 10个Agent
│   │   │       ├── plugins/                   # 9个插件
│   │   │       └── connectors/                # 11个MCP连接器
│   │   ├── 尚融局/
│   │   │   ├── 司级/司投师/
│   │   │   │   └── 典级/                      # [NEW] 3个典级（中文）
│   │   │   └── rong-fei-gstack/               # [MODIFY] 完善整合+中文化
│   │   ├── 尚工局/
│   │   │   ├── 司级/司具师/
│   │   │   │   └── 典级/                      # [NEW] 3个典级（中文）
│   │   │   └── hui-fei-gstack/                # [MODIFY] 完善整合+中文化
│   │   ├── 尚宣局/
│   │   │   ├── 司级/司增师/
│   │   │   │   └── 典级/                      # [NEW] 3个典级（中文）
│   │   │   └── xuan-fei-gstack/               # [MODIFY] 完善整合+中文化
│   │   ├── 尚教局/
│   │   │   └── ling-fei-gstack/               # [MODIFY] 完善整合+中文化
│   │   ├── 尚机局/
│   │   │   ├── 司级/司试师/
│   │   │   │   └── 典级/                      # [NEW] 3个典级（中文）
│   │   ├── 尚宫局/
│   │   │   ├── 司级/司研师/
│   │   │   │   └── 典级/                      # [NEW] 3个典级（中文）
│   │   ├── 御鉴司/
│   │   │   ├── 司级/
│   │   │   │   ├── 司安师/典级/               # [NEW] 3个典级（中文）
│   │   │   │   ├── 司实师/典级/               # [NEW] 3个典级（中文）
│   │   │   │   └── 司证师/典级/               # [NEW] 3个典级（中文）
│   │   │   └── yujiansi-gstack/               # [MODIFY] 完善整合+中文化
│   │   ├── gstack/                            # [EXISTING] 更新
│   │   └── superpowers/                       # [EXISTING] 更新
│   └── PROGRESS.md                            # [MODIFY] 记录进度
```

## Agent Extensions

### Skill

- **skill-creator**：用于创建和验证新的Skill文件，确保格式符合中文版模板
- **writing-plans**：用于编写详细的实施计划文档

### SubAgent

- **code-explorer**：用于搜索和验证目录结构、文件引用关系，检查中文化完成情况