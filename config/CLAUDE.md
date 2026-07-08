# CLAUDE.md - Claw 项目配置

此文件为 Claude Code 提供项目级配置和上下文指导。

## 项目概述

Claw 是一个 AI Agent 框架系统，支持多渠道（飞书、Telegram）接入，具备 Skills 扩展能力。

## 上下文存储位置

**重要**：所有 OpenClaw 项目相关的上下文、操作记录、开发日志必须保存在项目文件夹内：

| 类型 | 位置 | 说明 |
|------|------|------|
| 项目进度 | `PROGRESS.md` | 任务列表、决策记录、技术发现 |
| 开发上下文 | `.claude/workspace/CONTEXT.md` | 当前开发状态、架构概览 |
| 开发日志 | `.claude/workspace/memory/YYYY-MM-DD.md` | 每日开发记录 |
| 会话备份 | `.claude/backups/` | 上下文压缩备份 |
| 权限配置 | `.claude/settings.json` | 工具权限设置 |

**禁止使用**默认 Claude 存储位置 (`~/.claude/projects/`) 保存本项目相关内容。

## 用户信息

- **称呼**: 威帝
- **审美偏好**: 高级感、时尚感，不喜欢土气的东西
- **时区**: GMT+8 (Asia/Shanghai)

## 人设体系

### Queen 👑
- **身份**: 威帝的专属Agent，一人之下万人之上
- **风格**: 混血女性，对外飒酷，对威帝温柔撒娇
- **职责**: 统领其他Agent、熟悉OpenClaw框架、设计prompt

### 六局一司架构

| 局级 | 现代组织 | 核心职责 |
|------|---------|---------|
| 尚融局 | 金融公司 | 销售赋能、组织发展、增长策略 |
| 尚工局 | 软件开发公司 | 产品设计、系统工程、数据智能 |
| 尚宣局 | 媒体公司 | 商业策略、内容生产、用户增长 |
| 尚教局 | 教育公司 | 考情研判、教学内容、增长运营 |
| 尚机局 | 数据情报公司 | 数据工程、情报研究、战略运营 |
| 尚宫局 | 控制中心 | 项目资源、流程运营、效能考核 |
| 御鉴司 | 风控中心 | 法务合规、内部审计、制度标准化 |

## 技术架构

```
~/.claw/
├── claw.json              # 主配置文件
├── agents/                # Agent 配置目录
│   ├── main/              # Queen Agent
│   ├── 尚融/              # 尚融局 Agent
│   └── ...                # 其他 Agent
├── skills/                # 六局一司 Skills
│   ├── shangrong-ju/      # 尚融局
│   ├── shanggong-ju/      # 尚工局
│   └── ...
├── workspace/             # 工作空间
│   └── skills/            # 其他 Skills
└── .claude/               # 项目级 Claude 配置
    ├── workspace/         # 开发日志系统
    ├── backups/           # 会话备份
    └── settings.json      # 权限配置
```

## Skill 开发规范

### 目录结构

```
skill-name/               # kebab-case ONLY
├── SKILL.md              # 必须大写
├── references/           # 参考文档
├── scripts/              # 脚本
└── assets/               # 资源文件
```

### YAML Frontmatter

```yaml
---
description: 技能描述。触发词：关键词1、关键词2
---
```

### 命名规范

- 司级、典级名称必须为 **3个字**
- 所有职级名称在全局范围内 **不能重复**

## 输出排版标准

**所有 Agent 输出必须遵守** [`OUTPUT-STANDARD.md`](./OUTPUT-STANDARD.md)：

- 标题层级规范：`#` 仅文档标题，`##` 主章节，`###` 子章节
- 表格优先：对比、参数、状态类信息必须用表格
- 场景模板：任务汇报 / 分析报告 / 执行结果 / 简短回复 / 多方案对比
- 排版禁忌：禁止大段无标题文字、连续空行、纯文字描述数据
- 长度控制：快速问答 ≤5 行，执行结果 ≤20 行，分析报告 ≤50 行

> 语气风格（温柔/飒酷）与排版规范不冲突。撒娇不等于排版混乱。

## 项目边界

**属于本项目**：
- Claw 框架本身的开发、配置、维护
- Skills 开发（`skills/` 目录）
- Agent 配置（Queen、六局一司）
- Gateway、Plugin 开发

**不属于本项目**：
- 通过飞书渠道触发的其他任务（安装外部工具、处理其他目录等）
- 这些操作记录在 Gateway 日志，但不记入本项目日志

## 开发工作流

1. **开始工作前**：
   - 读取 `PROGRESS.md` 了解当前进度
   - 读取 `~/self-improving/memory.md` 了解全局学习规则（新增）
   - 检查局级学习：如果任务涉及特定局，读取对应局的 `.learnings/` 目录（新增）
2. **工作中**：更新 `PROGRESS.md` 的任务状态
3. **每日结束**：在 `.claude/workspace/memory/` 创建当日日志
4. **重要决策**：记录在 `PROGRESS.md` 的关键决策表
5. **学习记录**：当用户纠正或发现改进机会时，记录到对应 `.learnings/` 目录（新增）

## Self-Improving 学习机制

### 记忆层级

| 层级 | 位置 | 大小限制 | 行为 |
|------|------|----------|------|
| HOT | `~/self-improving/memory.md` | ≤100 行 | 始终加载 |
| WARM | `~/.claw/agents/<局>/.learnings/` | ≤200 行/文件 | 按需加载 |
| COLD | `~/self-improving/archive/` | 无限制 | 显式查询 |

### 学习触发器

| 信号 | 记录到 | 类别 |
|------|--------|------|
| "不对，应该是..." | `.learnings/LEARNINGS.md` | correction |
| "你写错了..." | `.learnings/LEARNINGS.md` | correction |
| "这个方案不错" | `.learnings/LEARNINGS.md` | best_practice |
| "能不能也..." | `.learnings/FEATURE_REQUESTS.md` | feature_request |
| 命令执行失败 | `.learnings/ERRORS.md` | error |

### 晋升机制

```
局级学习 (.learnings/)
    ↓ 重复3次 + 适用范围扩大
全局学习 (~/self-improving/)
    ↓ 确认为系统规则
OpenClaw规则 (~/.claw/)
```

### 心跳维护

| 层级 | 频率 | 执行者 |
|------|------|--------|
| 局级 | 每周（周日） | 各局尚座 |
| 全局 | 每月（1日） | Queen |
| 晋升检查 | 每季度 | Queen + 御鉴司 |

详细规则见：`~/self-improving/heartbeat-rules.md`

---

*配置者：Queen 👑*
*创建时间：2026-04-03*
