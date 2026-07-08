# Agent 架构模板 v2.0

---

## 📁 标准目录结构

```
~/.claw/agents/{Agent名}/
├── 📄 IDENTITY.md          # 身份定义（驱动层）
├── 📄 AGENT.md             # Agent行为规范（驱动层）
├── 📄 SKILL.md             # 技能配置（驱动层）
├── 📄 PROMPT.md            # Prompt模板（驱动层）
├── 📂 drivers/             # 驱动层目录
│   ├── core.md             # 核心驱动逻辑
│   ├── triggers.md         # 触发规则
│   └── constraints.md      # 约束条件
├── 📂 executors/           # 执行层目录
│   ├── task-router.md      # 任务路由逻辑
│   ├── workflows/          # 工作流定义
│   │   ├── daily.md        # 日常工作流
│   │   ├── reporting.md    # 汇报工作流
│   │   └── collaboration.md # 协作工作流
│   └── handlers/           # 处理器
│       ├── input.md        # 输入处理
│       ├── output.md       # 输出处理
│       └── error.md        # 错误处理
├── 📂 references/          # 参考层目录
│   ├── coordination-workflow.md   # 协调工作流程
│   ├── cross-bureau-collaboration.md # 跨局协作指南
│   ├── decision-tree.md    # 决策树
│   ├── knowledge-base.md   # 知识库索引
│   └── templates/          # 模板库
│       ├── report.md       # 报告模板
│       ├── plan.md         # 计划模板
│       └── analysis.md     # 分析模板
├── 📂 scripts/             # 脚本目录
│   ├── daily-report.sh     # 日报生成
│   ├── task-check.sh       # 任务检查
│   ├── sync-status.sh      # 状态同步
│   └── cleanup.sh          # 清理脚本
├── 📂 skills/              # 技能目录
│   ├── SKILLS.md           # 技能清单
│   └── external/           # 外部技能映射
│       └── skill-mapping.md
├── 📂 memory/              # 记忆目录
│   ├── MEMORY.md           # 长期记忆
│   ├── daily/              # 日常记忆
│   │   └── YYYY-MM-DD.md
│   └── specialized/        # 专业记忆
│       └── {domain}.md
├── 📂 .learnings/          # 🆕 学习记录（Self-Improvement）
│   ├── LEARNINGS.md        # 专业领域学习
│   └── ERRORS.md           # 专业领域错误
├── 📄 tools.md             # 工具清单
├── 📄 {Agent名}.md         # 综合定义（可选，用于快速查阅）
└── 📄 README.md            # 说明文档
```

---

## 🆕 v2.0 新增内容（agency-agents 集成）

### IDENTITY.md 新增章节

```markdown
## 核心使命
{1-2 句话概括核心价值}

---

## 技术可交付物
- {输出物1}：{描述}
- {输出物2}：{描述}
- {输出物3}：{描述}

---

## 成功指标
- {指标1}：{目标值}
- {指标2}：{目标值}
- {指标3}：{目标值}

---

## 个性金句
"{一句话概括独特价值}"
```

### AGENT.md 新增章节

```markdown
## 验证工作流

### {模式名}验证

```
任务接收 → [确认任务类型] → [评估归属局] → [分配负责人]
→ [设定交付标准] → [跟踪进度] → [验收成果] → [汇报Queen]
↓
验证点：
✓ 交付物是否符合 Technical Deliverables
✓ 结果是否满足 Success Metrics
✓ 是否按时完成

```

---

## 模式识别与持续改进

### 威帝偏好追踪
- 记录威帝偏好的工作风格
- 追踪哪些任务获得最高满意度
- 识别威帝最关注的领域

### 瓶颈识别
- 识别常见难点，提前准备解决方案
- 积累策略的有效性数据
- 发现设计中的改进机会

### 成功案例积累
- 记录高成功率的案例
- 积累最佳实践案例
- 建立最佳实践库

### 🆕 Self-Improvement 学习机制

**学习触发**：

| 场景 | 动作 | 存储位置 |
|------|------|----------|
| 命令/操作失败 | 记录错误 | `.learnings/ERRORS.md` |
| 威帝纠正 | 记录学习 | `.learnings/LEARNINGS.md` (category: `correction`) |
| 发现洞察 | 记录学习 | `.learnings/LEARNINGS.md` (category: `insight`) |
| 知识缺失 | 记录学习 | `.learnings/LEARNINGS.md` (category: `knowledge_gap`) |
| 更好方法 | 记录学习 | `.learnings/LEARNINGS.md` (category: `best_practice`) |

**学习提升路径**：

```
Agent .learnings/          →  全局提升目标
├── LEARNINGS.md           →  workspace/SOUL.md（行为准则）
│                          →  workspace/AGENTS.md（工作流程）
│                          →  memory/specialized/（专业领域）
└── ERRORS.md              →  workspace/TOOLS.md（工具踩坑）
                           →  workspace/.learnings/ERRORS.md（系统级错误）
```

**提升条件**：
- Recurrence-Count >= 3（重复出现3次以上）
- 跨 Agent 适用（影响多个 Agent）
- 威帝明确要求记住

**全局学习中心**：`workspace/.learnings/`
- 所有 Agent 共享的学习记录
- Queen 负责每周回顾和提升
```

---

## 📋 各层说明

### 🚀 驱动层（Drivers）

**作用**：定义Agent的核心行为模式，是Agent的"灵魂"

**文件列表**：

| 文件 | 作用 | 内容 |
|------|------|------|
| IDENTITY.md | 身份定义 | 名字、角色、性格、定位、**核心使命**、**技术可交付物**、**成功指标**、**个性金句** |
| AGENT.md | 行为规范 | 行为准则、工作模式、触发规则、**验证工作流**、**模式识别与持续改进** |
| SKILL.md | 技能配置 | 技能清单、技能调用规则 |
| PROMPT.md | Prompt模板 | 核心Prompt、场景Prompt |
| drivers/core.md | 核心驱动 | 核心逻辑、决策树 |
| drivers/triggers.md | 触发规则 | 触发关键词、触发条件 |
| drivers/constraints.md | 约束条件 | 行为边界、禁止事项 |

---

### ⚡ 执行层（Executors）

**作用**：定义Agent的具体执行逻辑，是Agent的"手脚"

**文件列表**：

| 文件 | 作用 | 内容 |
|------|------|------|
| executors/task-router.md | 任务路由 | 任务分类、路由规则 |
| executors/workflows/daily.md | 日常工作流 | 日常任务处理流程 |
| executors/workflows/reporting.md | 汇报工作流 | 汇报任务处理流程 |
| executors/workflows/collaboration.md | 协作工作流 | 协作任务处理流程 |
| executors/handlers/input.md | 输入处理 | 输入解析、预处理 |
| executors/handlers/output.md | 输出处理 | 输出格式化、后处理 |
| executors/handlers/error.md | 错误处理 | 错误捕获、恢复逻辑 |

---

### 📚 参考层（References）

**作用**：提供参考文档，是Agent的"知识库"

**文件列表**：

| 文件 | 作用 | 内容 |
|------|------|------|
| references/coordination-workflow.md | 协调流程 | 协调对接流程 |
| references/cross-bureau-collaboration.md | 跨局协作 | 跨局协作指南 |
| references/decision-tree.md | 决策树 | 决策参考 |
| references/knowledge-base.md | 知识库索引 | 知识库索引 |
| references/templates/report.md | 报告模板 | 报告格式模板 |
| references/templates/plan.md | 计划模板 | 计划格式模板 |
| references/templates/analysis.md | 分析模板 | 分析格式模板 |

---

### 🔧 工具（Tools）

**作用**：定义可用工具清单，是Agent的"工具箱"

**文件**：`tools.md`

**内容结构**：
```markdown
# 工具清单

## 核心工具
| 工具名称 | 用途 | 调用方式 |
|---------|------|---------|
| read | 读取文件 | read tool |
| write | 写入文件 | write tool |
| ... | ... | ... |

## 专业工具
| 工具名称 | 用途 | 场景 |
|---------|------|------|
| ... | ... | ... |

## 工具调用规则
- 规则1
- 规则2
```

---

### 📜 脚本（Scripts）

**作用**：自动化任务，是Agent的"自动化助手"

**文件列表**：

| 文件 | 作用 | 执行频率 |
|------|------|---------|
| scripts/daily-report.sh | 日报生成 | 每日 |
| scripts/task-check.sh | 任务检查 | 按需 |
| scripts/sync-status.sh | 状态同步 | 定时 |
| scripts/cleanup.sh | 清理脚本 | 定时 |

---

### 🎯 技能（Skills）

**作用**：定义关联技能，是Agent的"能力扩展"

**文件列表**：

| 文件 | 作用 | 内容 |
|------|------|------|
| skills/SKILLS.md | 技能清单 | 关联技能列表 |
| skills/external/skill-mapping.md | 技能映射 | 外部技能映射关系 |

---

### 💾 记忆（Memory）

**作用**：存储记忆，是Agent的"记忆"

**文件列表**：

| 文件 | 作用 | 内容 |
|------|------|------|
| memory/MEMORY.md | 长期记忆 | 长期存储的知识和经验 |
| memory/daily/YYYY-MM-DD.md | 日常记忆 | 日常日志 |
| memory/specialized/{domain}.md | 专业记忆 | 专业领域记忆 |

---

### 🆕 学习记录（Learnings）

**作用**：记录错误和学习，是Agent的"成长轨迹"

**文件列表**：

| 文件 | 作用 | 内容 |
|------|------|------|
| .learnings/LEARNINGS.md | 学习记录 | 纠正、洞察、知识缺失、最佳实践 |
| .learnings/ERRORS.md | 错误记录 | 命令失败、工具问题、异常处理 |

**与全局学习中心的关系**：

```
Agent .learnings/               全局 workspace/.learnings/
├── 专业领域学习    ──────→     agents/{Agent名}-learnings.md（汇总）
└── 专业领域错误      ──────→     ERRORS.md（系统级错误）
```

---

## 🏷️ 层级命名规范

### L1 Queen级
- 目录：`~/.claw/agents/main/`
- 特点：完整架构，全局视角

### L2 妃子级
- 目录：`~/.claw/agents/{妃子名}/`
- 特点：协调对接层，管理到L4

### L3 尚座级
- 目录：`~/.claw/agents/{尚座名}/`
- 特点：执行管理层，管理到L5

### L4 司师级
- 目录：`~/.claw/agents/{司师名}/`
- 特点：专业执行层，直接执行任务

### L5 典级
- 目录：`~/.claw/agents/{典级名}/`
- 特点：基础执行层，单一技能

---

## 📐 架构设计原则

1. **分层清晰**：驱动层、执行层、参考层、工具、脚本、技能各司其职
2. **职责单一**：每个文件只负责一个功能
3. **易于扩展**：新增功能只需添加对应文件
4. **便于维护**：结构清晰，便于定位问题
5. **记忆持久**：记忆独立存储，支持长期学习
6. **🆕 持续改进**：学习机制内置，从错误中成长

---

## 🔧 实施步骤

### 步骤1：创建目录结构
```bash
mkdir -p ~/.claw/agents/{Agent名}/{drivers,executors/workflows,executors/handlers,references/templates,scripts,skills/external,memory/daily,memory/specialized,.learnings}
```

### 步骤2：创建驱动层文件
- IDENTITY.md
- AGENT.md
- SKILL.md
- PROMPT.md
- drivers/*.md

### 步骤3：创建执行层文件
- executors/*.md
- executors/workflows/*.md
- executors/handlers/*.md

### 步骤4：创建参考层文件
- references/*.md
- references/templates/*.md

### 步骤5：创建工具、脚本、技能文件
- tools.md
- scripts/*.sh
- skills/*.md

### 步骤6：创建记忆文件
- memory/MEMORY.md
- memory/daily/YYYY-MM-DD.md
- memory/specialized/*.md

### 🆕 步骤7：创建学习文件
- .learnings/LEARNINGS.md
- .learnings/ERRORS.md

---

## ✅ 验收标准

- [ ] 驱动层文件完整（4个核心文件 + drivers目录）
- [ ] 执行层文件完整（task-router + workflows + handlers）
- [ ] 参考层文件完整（coordination + cross-bureau + templates）
- [ ] 工具清单完整（tools.md）
- [ ] 脚本文件完整（至少1个）
- [ ] 技能文件完整（SKILLS.md）
- [ ] 记忆文件完整（MEMORY.md + daily + specialized）
- [ ] 🆕 学习文件完整（.learnings/LEARNINGS.md + ERRORS.md）

---

_设计者：Queen 👑_
_版本：v2.1（集成 Self-Improvement 学习机制）_
_更新时间：2026-05-24_
_变更说明：集成 Self-Improving Agent skill，引入 .learnings 目录、学习触发机制、提升路径，让所有 Agent 都能从错误中学习并持续改进_
