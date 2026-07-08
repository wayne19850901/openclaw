---
name: 元架构设计-用外部AgentTeam完善OpenClaw架构
overview: 组建外部Agent Team（ai-hedge-fund、trading-agent、financial-services、agency-agents、gstack、superpowers），让AI设计AI，自动生成OpenClaw六局一司架构的完整能力体系
todos:
  - id: setup-meta-team
    content: 创建元设计团队工作目录，整合六大外部资源索引
    status: completed
  - id: invoke-19-masters
    content: 调用 ai-hedge-fund 的19位投资大师并行设计 Agent 架构
    status: completed
    dependencies:
      - setup-meta-team
  - id: invoke-11-analysts
    content: 调用 trading-agent 的11位分析师并行设计 Skill 架构（辩论模式）
    status: completed
    dependencies:
      - setup-meta-team
  - id: copy-templates
    content: 复制 financial-services 和 agency-agents 模板到 references/
    status: completed
    dependencies:
      - setup-meta-team
  - id: integrate-designs
    content: 整合19份 Agent 设计建议 + Skill 辩论产出，生成最终架构蓝图
    status: completed
    dependencies:
      - invoke-19-masters
      - invoke-11-analysts
  - id: execute-development
    content: 使用 gstack + superpowers 执行文件创建和内容填充
    status: completed
    dependencies:
      - integrate-designs
      - copy-templates
  - id: validate-document
    content: 验证全架构能力可用性，更新 PROGRESS.md 和架构文档
    status: completed
    dependencies:
      - execute-development
---

## 产品概述

基于**全网搜索研究成果**（MetaAgent/ADAS/Agent Skill Framework）+ **383个外部资源** + **全量Agent Team调用**（19位投资大师+11位分析师），采用**分层半自动化设计**：用户定义六局一司高层结构，AI填充具体能力，按需映射50-80个相关模板，实现"AI设计AI"的元架构模式。

## 用户决策（头脑风暴确认）

| 决策项 | 选择 | 说明 |
| --- | --- | --- |
| 架构控制权 | **B：半自动化** | 用户定义六局一司高层结构，AI填充具体能力 |
| 外部资源整合 | **B：按需映射** | 只复制与六局一司业务相关的模板（50-80个） |
| Agent Team调用 | **A：全量调用** | 19位大师+11位分析师全部参与，产出最丰富 |
| **经济性优化** | **渐进式披露** | Main规范≤200行，按需触发子Agent→Skill，每个Agent有自身能力 |


## 经济性设计约束（Token优化）

### 核心原则：渐进式披露 + 自身能力 + 强制读完

**行数限制规则（2026-05-20调整）**：

| 层级 | 文件类型 | 行数限制 | 说明 |
| --- | --- | --- | --- |
| **路由级** | AGENT.md | **180-220行**（±10%） | 核心路由逻辑+自身能力，严格控制 |
| **驱动skill** | drivers/*.md | **180-220行**（±10%） | 身份定义、路由规则、约束，严格控制 |
| **执行skill** | executors/*.md | **无限制** | 完整工作流，强制读完再输出 |
| **参考层** | references/*.md | **无限制** | 知识库内容，按需加载 |


```
┌─────────────────────────────────────────────────────────────┐
│  Queen（Main）                                               │
│  - AGENT.md：180-220行（核心路由逻辑+自身能力）                │
│  - drivers/：180-220行（身份定义、路由规则、约束）             │
│  - executors/：无限制（完整工作流，强制读完再输出）            │
│  - references/：无限制（知识库内容）                          │
│  - 自身能力：意图分类、简单问答、直接回复                      │
│  - 触发逻辑：复杂任务才触发子Agent                            │
└─────────────────────────────────────────────────────────────┘
         │ 复杂任务触发（可单个、可多个）
         ▼
┌─────────────────────────────────────────────────────────────┐
│  子Agent（妃子级/局级）                                       │
│  - AGENT.md：180-220行（局级路由+自身能力）                    │
│  - drivers/：180-220行（身份定义、路由规则、约束）             │
│  - executors/：无限制（完整工作流，强制读完再输出）            │
│  - references/：无限制（知识库内容）                          │
│  - 自身能力：领域判断、任务分解、简单执行                      │
│  - 触发逻辑：需要专业工具才触发Skill                          │
└─────────────────────────────────────────────────────────────┘
         │ 需要专业工具触发
         ▼
┌─────────────────────────────────────────────────────────────┐
│  Skill（司师级/典级）                                         │
│  - SKILL.md：180-220行（核心能力定义）                         │
│  - drivers/：180-220行（身份定义、路由规则、约束）             │
│  - executors/：无限制（完整工作流，强制读完再输出）            │
│  - references/：无限制（知识库内容）                          │
│  - 自身能力：完整的专业执行能力                               │
│  - 触发逻辑：调用外部工具/API                                 │
└─────────────────────────────────────────────────────────────┘
```

### Token消耗对比

| 方案 | Main加载 | 子Agent加载 | Skill加载 | 总Token |
| --- | --- | --- | --- | --- |
| **传统方案** | 全量（2000+行） | 全量 | 全量 | 50K+ |
| **优化方案** | 核心（180-220行） | 按需（180-220行） | 按需（无限制执行层） | 5-15K |
| **节省比例** | 90%↓ | 85%↓ | 按需加载 | **70-90%↓** |


### 强制读完机制

**执行skill（executors/）必须包含**：

1. **完整工作流**：从开始到结束的完整步骤
2. **强制读完标记**：在文件末尾添加 `[EXECUTION_COMPLETE]` 标记
3. **输出前检查**：AI必须读取到 `[EXECUTION_COMPLETE]` 才能输出结果
4. **分段执行**：如果工作流过长，分为多个阶段，每个阶段有明确的输入输出

**示例**：

```markdown
# 投资分析工作流

## 阶段1：数据收集（必须完成）
- 步骤1：获取财务数据
- 步骤2：获取市场数据
- 步骤3：获取新闻数据
- 检查点：[STAGE1_COMPLETE]

## 阶段2：分析计算（必须完成）
- 步骤1：基本面分析
- 步骤2：估值计算
- 步骤3：风险评估
- 检查点：[STAGE2_COMPLETE]

## 阶段3：报告生成（必须完成）
- 步骤1：整合分析结果
- 步骤2：生成投资报告
- 步骤3：质量检查
- 检查点：[STAGE3_COMPLETE]

[EXECUTION_COMPLETE]
```

### 自身能力设计原则

每个Agent必须具备**独立处理常见问题的能力**，不是纯路由：

| 层级 | 自身能力占比 | 路由占比 | 示例 |
| --- | --- | --- | --- |
| **Queen** | 40% | 60% | 简单问答直接回复，复杂任务才路由 |
| **妃子级** | 50% | 50% | 领域判断、任务分解、简单执行 |
| **局级** | 60% | 40% | 局级协调、资源分配、进度跟踪 |
| **司师级** | 80% | 20% | 专业分析、报告生成、工具调用 |
| **典级** | 95% | 5% | 具体执行、模板填充、脚本运行 |


## 核心功能

- **组建架构设计元团队**：整合 ai-hedge-fund、trading-agent、financial-services、agency-agents、gstack、superpowers、find-skills 七大外部资源
- **调用19位投资大师并行设计 Agent 架构**：不同思维模式（价值、成长、逆向、宏观）碰撞，产出多元化设计建议
- **调用11位分析师并行设计 Skill 架构**：辩论模式（多空辩论、风险三方辩论），产出最佳实践
- **按需映射外部模板**：383个模板中筛选50-80个相关模板复制到references/
- **执行开发与验证**：gstack + superpowers 执行文件创建、内容填充、质量验证
- **整合验收与文档化**：Queen 整合所有产出，生成最终架构文档

## 技术栈

- **理论基础**：MetaAgent（ICML 2025有限状态机）、ADAS（Meta Agent Search）、Agent Skill Framework（4支柱模型）
- **外部 Agent 调用**：ai-hedge-fund（Task 工具，19位大师并行）、trading-agent（Task 工具，11位分析师并行）
- **模板复制**：financial-services（117个金融Skill）、agency-agents（200个Agent设计模式）、gstack（47个开发工具）、superpowers（14个最佳实践）
- **技能发现**：find-skills（SkillHub语义搜索 + ClawHub + Vercel Skills）
- **执行开发**：gstack（文件创建、质量验证）、superpowers（代码生成、调试辅助）
- **配置文件**：Markdown (.md)、JSON、YAML（routing元数据）
- **命名规范**：司级3字、典级2字，全局唯一

## 研究成果（全网搜索）

### 1. MetaAgent框架（ICML 2025）

**核心机制**：

- 基于有限状态机（FSM）自动生成多Agent系统
- 无需外部训练数据，从任务描述自动设计完整架构
- 支持工具集成和动态通信结构

**适用点**：为OpenClaw的FSM工作流设计提供理论支撑

### 2. ADAS（Automated Design of Agentic Systems）

**核心算法**：Meta Agent Search

- 元智能体迭代编程新智能体
- 档案库积累已发现的设计
- 可学习任何可能的智能体系统（提示词、工具使用、工作流组合）

**适用点**：为"AI设计AI"提供方法论

### 3. Agent Skill Framework（4支柱模型）

**核心架构**：渐进式披露机制（复杂能力仅在相关时才被加载）

| 支柱 | 角色 | 类比 | 内容 |
| --- | --- | --- | --- |
| **指令指南** | "大脑" | 岗位说明书 | STAR原则定义角色、认知逻辑、行为约束 |
| **路由元数据** | "门牌" | 轻量标签 | 触发关键词、能力标签、渐进式披露 |
| **参考材料** | "参考库" | 防幻觉机制 | 领域知识、标准规范、模板示例 |
| **执行脚本** | "工具箱" | 认知到行动 | 工作流、处理器、脚本、工具集成 |


**适用点**：为OpenClaw的Agent/Skill文件结构升级提供标准

### 4. 外部资源探索结果

| 资源库 | Agent/Skill数量 | 核心价值 |
| --- | --- | --- |
| **agency-agents** | ~200个 | 多领域Agent设计模式参考（16个业务领域） |
| **financial-services** | 117个 | 金融工作流模板、Skill设计示例（三层分类） |
| **gstack** | 47个 | QA测试、开发工作流工具集 |
| **superpowers** | 14个 | 开发最佳实践（brainstorming、debugging等） |
| **共享** | 5个 | find-skills、中文写作、GitHub CLI等 |
| **baoyu-skills** | 8个 | 内容生产自动化（画图、PPT、排版、发布到平台） |
| **wechat-article-for-ai** | 1个 | 微信公众号文章转Markdown（MCP协议支持） |


### 5. baoyu-skills 详细索引

**来源**：github.com/JimLiu/baoyu-skills（17k+ Stars）
**作者**：宝玉（Jim Liu），公众号「宝玉」主理人
**定位**：内容生产自动化——让 AI 真正"干活"：画图、做 PPT、排版、直接发布到平台

| 分组 | 技能名称 | 功能 | 输出规格 |
| --- | --- | --- | --- |
| **小红书运营** | `baoyu-xhs-images` | 生成小红书配图 | 3:4 竖图，12 种风格（notion/cute/fresh/warm等） |
| **公众号运营** | `baoyu-cover-image` | 生成公众号封面 | 900x500，可配置风格 |
|  | `baoyu-article-illustrator` | 根据文章生成配图 | 自动插入合适位置 |
|  | `baoyu-post-to-wechat` | 自动发布到公众号 | Chrome 模拟人工操作 |
| **深度内容** | `baoyu-slide-deck` | 生成 PPT 课件 | 可配置风格/受众/页数/语言 |
|  | `baoyu-infographic` | 生成知识图谱/信息图 | - |
|  | `baoyu-comic` | 生成知识漫画 | 可配置风格/面板数 |


**安装方式**：`npx skills add JimLiu/baoyu-skills`

**六局一司映射**：

- 尚宣局（仪妃）→ `baoyu-xhs-images` + `baoyu-cover-image` + `baoyu-article-illustrator` + `baoyu-post-to-wechat` + `baoyu-infographic`
- 尚教局（令妃）→ `baoyu-slide-deck` + `baoyu-comic` + `baoyu-infographic`

### 6. wechat-article-for-ai 详细索引

**来源**：github.com/Panniantong/wechat-article-for-ai（forked from bzd6661）
**定位**：微信公众号文章转 Markdown 工具，专为 AI 时代设计

| 能力 | 描述 |
| --- | --- |
| **MCP 协议支持** | 可被 Claude 等 AI Agent 直接调用 |
| **SKILL.md** | 标准化 AI 技能定义文件 |
| **反检测抓取** | Camoufox 隐身浏览器绕过微信反爬 |
| **结构化输出** | YAML frontmatter（标题、作者、日期、来源） |
| **批量处理** | 支持多 URL 或从文件读取 |
| **图片本地化** | 异步并发下载，自动推断格式 |
| **代码块保留** | 语言检测 + CSS 垃圾过滤 |
| **媒体提取** | 支持 `<mpvoice>` 音频和 `<mpvideo>` 视频 |


**六局一司映射**：

- 尚宣局（司策师）→ 竞品文章收集、行业资讯抓取
- 尚教局（司教师）→ 教育类文章素材收集
- 尚机局（司调师）→ 情报类文章采集与归档

**按需映射策略**（50-80个模板）：

- 尚融局 → financial-services（financial-analysis、investment-banking、equity-research）
- 尚工局 → agency-agents/engineering + gstack（qa、review、health）
- 尚宣局 → agency-agents/marketing + superpowers（brainstorming）+ **baoyu-skills**（xhs-images、cover-image、article-illustrator、post-to-wechat、infographic）+ **wechat-article-for-ai**
- 尚教局 → agency-agents/product + 共享/chinese + **baoyu-skills**（slide-deck、comic、infographic）+ **wechat-article-for-ai**
- 尚机局 → gstack（investigate、canary）+ neodata + **wechat-article-for-ai**
- 尚宫局 → agency-agents/project-management + gstack（ship、land-and-deploy）
- 御鉴司 → financial-services（audit）+ gstack（cso、verification）

## 实施方案

### 核心创新：元架构设计（Meta-Architecture Design）

**传统方案**：人工设计架构 → 手动填充内容 → 人工验证
**创新方案**：组建外部 Agent Team → 让 AI 设计 AI → 自动生成架构

---

### Phase 1：组建架构设计元团队

**目标**：整合七大外部资源，组建跨系统协作团队

**外部资源索引创建**：

```
# 创建元设计团队工作目录
mkdir -p ~/.claw/workspace/optimization/meta-design-team/

# 创建外部资源索引文件
cat > ~/.claw/workspace/optimization/meta-design-team/external-resources-index.md << 'EOF'
# 外部资源索引

## ai-hedge-fund（19位投资大师）
- 调用方式：Task工具（并行）
- 产出：19份Agent设计建议

## trading-agent（11位分析师）
- 调用方式：Task工具（并行+辩论）
- 产出：Skill架构辩论产出

## financial-services（117个金融Skill）
- 映射策略：按需复制到尚融局、御鉴司references/
- 关键模板：financial-analysis、investment-banking、equity-research、audit

## agency-agents（200个Agent设计模式）
- 映射策略：按需复制到各局references/
- 关键模板：engineering、marketing、product、project-management

## gstack（47个开发工具）
- 调用方式：Task工具（执行开发）
- 关键工具：qa、review、health、investigate、ship

## superpowers（14个最佳实践）
- 调用方式：Task工具（代码生成）
- 关键工具：brainstorming、debugging、verification

## find-skills（技能发现）
- 调用方式：SkillHub语义搜索 + ClawHub + Vercel Skills
- 用途：发现和安装缺失的技能
EOF
```

**Team 结构**：

```
┌─────────────────────────────────────────────────────────────┐
│        架构完善元设计团队 (Meta-Design Team)                │
│                                                             │
│  Team 1: Agent 设计顾问团（19位大师并行）                    │
│  ├── 巴菲特、芒格、林奇、伍德、塔勒布、伯里、德鲁肯米勒...   │
│  └── 职责：从不同投资哲学设计 Agent 架构                     │
│                                                             │
│  Team 2: Skill 设计顾问团（11位分析师并行辩论）              │
│  ├── market-analyst、fundamentals-analyst、news-analyst...  │
│  └── 职责：通过辩论模式设计 Skill 最佳实践                   │
│                                                             │
│  Team 3: 模板参考库（按需映射50-80个）                       │
│  ├── financial-services（金融垂直）                          │
│  ├── agency-agents（多领域设计模式）                         │
│  └── gstack + superpowers（开发工具）                        │
│                                                             │
│  Team 4: 技能发现团                                          │
│  ├── find-skills（SkillHub语义搜索）                         │
│  └── 职责：发现和安装缺失的技能                               │
│                                                             │
│  Team 5: 执行开发团                                          │
│  ├── gstack（文件创建、质量验证）                            │
│  └── superpowers（代码生成、调试辅助）                       │
└─────────────────────────────────────────────────────────────┘
```

---

### Phase 2：Agent 架构设计（19位大师并行）

**来源**：ai-hedge-fund 插件（系统提示词已内置）

**调用方式**：使用 Task 工具创建19个子 Agent 并行执行

**设计要求（基于4支柱模型 + 经济性约束）**：

每位大师需从自己的投资哲学出发，设计Agent的4支柱内容：

| 支柱 | 设计要求 | 行数限制 | 示例（巴菲特设计贵妃） |
| --- | --- | --- | --- |
| **指令指南** | STAR原则定义角色身份 | **180-220行**（±10%） | "我是贵妃，尚融局统领，专注金融贷款领域的长期价值创造..." |
| **路由元数据** | 触发关键词+能力标签（YAML格式） | **180-220行**（±10%） | triggers: [金融, 贷款, 投资, 风控]; capabilities: [strategic-planning, cross-bureau-coordination] |
| **参考材料** | 领域知识+行业标准（按需加载） | **无限制** | 巴菲特推荐：护城河分析框架、安全边际计算方法、长期持有策略 |
| **执行脚本** | 工作流+工具集成（完整工作流） | **无限制**（强制读完再输出） | 尚融局协调工作流、跨局协调指令、质量门控流程 |


**自身能力设计要求**：

每个Agent必须设计**独立处理常见问题的能力**（不触发子Agent）：

| Agent | 自身能力（不触发子Agent） | 触发子Agent的条件 |
| --- | --- | --- |
| **Queen** | 简单问答、意图分类、威帝偏好匹配、历史记录查询 | 复杂任务、跨局协调、需要专业分析 |
| **贵妃** | 金融领域判断、任务分解、简单风控建议、进度查询 | 需要专业工具（DCF、风控模型）、跨局协调 |
| **司投师** | 基本面分析、简单估值、报告生成、数据查询 | 需要复杂模型（DCF、蒙特卡洛）、外部数据API |


**任务分配**：

| 投资大师 | 设计建议方向 | 映射 OpenClaw 岗位 |
| --- | --- | --- |
| 巴菲特 | 价值导向、长期思维、护城河分析 | 贵妃、司投师 |
| 芒格 | 理性思维、决策框架、可预测性 | 御鉴、司审师 |
| 林奇 | GARP、成长发现、十倍股逻辑 | 仪妃、司策师 |
| 伍德 | 颠覆创新、指数增长、大 TAM | 慧妃、司研师 |
| 塔勒布 | 反脆弱、尾部风险、凸性 | 司安师、司实师 |
| 伯里 | 深度价值、逆向思维、FCF 收益率 | 司投师 |
| 德鲁肯米勒 | 宏观视角、非对称收益 | 谨妃、司情师 |
| 费雪 | 成长品质、研发创新 | 慧妃、司开师 |
| 格雷厄姆 | 安全边际、净净值 | 司投师 |
| 阿克曼 | 激进主义、品牌护城河 | 贵妃 |
| 帕布莱 | Dhandho、下行保护 | 司贷师 |
| 达摩达兰 | 严谨估值、FCFF DCF | 司投师 |
| 金君瓦拉 | 新兴市场、成长+安全边际 | 司客师 |
| fundamentals-analyst | 基本面指标、ROE/利润率/负债率 | 各司师 |
| technicals-analyst | 技术面指标、趋势/动量/波动率 | 司情师 |
| valuation-analyst | 多方法估值、DCF/可比倍数 | 司投师 |
| sentiment-analyst | 情绪分析、内部人交易 | 司情师 |
| growth-analyst | 成长性分析、PEG/利润率扩张 | 司研师 |
| news-sentiment-analyst | 新闻情绪、宏观环境 | 司情师 |


**产出**：19份 Agent 设计建议（每份包含：角色定义、决策框架、行为约束、能力标签、路由元数据、参考材料推荐、执行脚本建议、**自身能力设计**）

---

### Phase 3：Skill 架构设计（11位分析师并行辩论）

**来源**：trading-agent 插件（系统提示词已内置）

**调用方式**：使用 Task 工具创建11个子 Agent 并行执行，然后触发辩论流程

**辩论流程**：

```
Phase 3.1【并行】──── TeamCreate: 4位分析师同时执行
                        ├── market-analyst（技术面）
                        ├── fundamentals-analyst（基本面）
                        ├── news-analyst（新闻）
                        └── sentiment-analyst（情绪）
        ↓ 收集4份分析报告

Phase 3.2【顺序】──── bull-researcher → bear-researcher → research-manager
        ↓ [投资计划]

Phase 3.3【单一】──── trader
        ↓ FINAL TRANSACTION PROPOSAL

Phase 3.4【并行+顺序】
        └──【并行】 TeamCreate: 3位风险分析师
                    ├── aggressive-risk-analyst
                    ├── conservative-risk-analyst
                    └── neutral-risk-analyst
        ↓ 收集3份风险论证
        └──【顺序】 risk-manager → [最终交易决策]
```

**产出**：

- 4份分析报告（市场、基本面、新闻、情绪）
- 多空辩论记录
- 最终投资计划
- 3份风险论证（激进、保守、中性）
- 最终交易决策（BUY/SELL/HOLD + 入场价/目标价/止损价/仓位）

---

### Phase 4：执行开发（gstack + superpowers）

**任务**：

1. 根据架构蓝图创建目录结构
2. 填充 AGENT.md/SKILL.md 内容
3. 创建 executors/ 脚本
4. 验证质量（gstack-health）

**调用方式**：使用 Task 工具调用 gstack 和 superpowers

---

### Phase 5：整合验收（Queen 统筹）

**任务**：

1. 整合19份 Agent 设计建议
2. 整合 Skill 辩论产出
3. 生成最终架构文档
4. 更新 PROGRESS.md

---

## 目录结构（基于4支柱模型 + 经济性约束）

```
~/.claw/
├── agents/
│   ├── main/                              # Queen（需增强）
│   │   ├── AGENT.md                       # [MODIFY] 180-220行（核心路由+自身能力）
│   │   ├── drivers/
│   │   │   ├── identity.md                # [NEW] 180-220行（Queen身份定义）
│   │   │   ├── routing.yaml               # [NEW] 180-220行（全局路由规则）
│   │   │   └── constraints.md              # [MODIFY] 180-220行（约束规则）
│   │   ├── executors/
│   │   │   ├── workflows/
│   │   │   │   ├── task-orchestration.md  # [NEW] 无限制（任务编排，强制读完）
│   │   │   │   ├── quality-gate.md         # [NEW] 无限制（质量门控，强制读完）
│   │   │   │   └── meta-design-team.md    # [NEW] 无限制（元设计团队，强制读完）
│   │   │   └── handlers/
│   │   │       └── external-agent-dispatch.md  # [NEW] 无限制（外部Agent调度，强制读完）
│   │   └── references/
│   │       ├── capability-map.md           # [NEW] 无限制（能力地图）
│   │       ├── user-preferences.md         # [NEW] 无限制（威帝偏好）
│   │       └── external-resources-index.md # [NEW] 无限制（外部资源索引）
│   ├── 贵妃/                              # [MODIFY] 6妃子级统一升级
│   │   ├── AGENT.md                        # [MODIFY] 180-220行（局级路由+自身能力）
│   │   ├── drivers/
│   │   │   ├── identity.md                # [NEW] 180-220行（角色身份）
│   │   │   ├── routing.yaml               # [NEW] 180-220行（局级路由）
│   │   │   └── constraints.md              # [KEEP] 180-220行（现有约束）
│   │   ├── executors/                     # [FILL] 从空目录填充
│   │   │   ├── workflows/
│   │   │   │   ├── task-decomposition.md   # [NEW] 无限制（任务分解，强制读完）
│   │   │   │   ├── cross-bureau.md         # [NEW] 无限制（跨局协调，强制读完）
│   │   │   │   └── quality-review.md       # [NEW] 无限制（成果验收，强制读完）
│   │   │   └── handlers/
│   │   │       └── progress-tracking.md    # [NEW] 无限制（进度跟踪，强制读完）
│   │   └── references/
│   │       ├── domain-knowledge.md         # [NEW] 无限制（领域知识）
│   │       ├── industry-standards.md       # [NEW] 无限制（行业标准）
│   │       └── external-templates/         # [NEW] 按需复制（无限制）
│   ├── 慧妃/ ... 仪妃/ 令妃/ 谨妃/ 昭妃/   # [MODIFY] 同贵妃模式升级
│   ├── 尚融局/ ... 尚工局/ ... (7个局级)    # [MODIFY] 180-220行（局级路由+自身能力）
│   └── 御鉴司/
│       └── ... (同上)
├── workspace/
│   ├── skills/
│   │   ├── 尚融局/司级/司投师/            # [MODIFY] 司师级统一升级
│   │   │   ├── SKILL.md                    # [MODIFY] 180-220行（核心能力）
│   │   │   ├── drivers/
│   │   │   │   ├── identity.md            # [NEW] 180-220行（领域专家身份）
│   │   │   │   ├── routing.yaml            # [NEW] 180-220行（技能触发）
│   │   │   │   └── constraints.md          # [NEW] 180-220行（约束规则）
│   │   │   ├── executors/
│   │   │   │   ├── workflows/
│   │   │   │   │   └── investment-analysis.md  # [NEW] 无限制（投资分析流程，强制读完）
│   │   │   │   ├── handlers/
│   │   │   │   │   └── skill-invocation.md     # [NEW] 无限制（外部技能调用，强制读完）
│   │   │   │   └── tools/
│   │   │   │       ├── ai-hedge-fund.md        # [NEW] 无限制（对冲基金集成，强制读完）
│   │   │   │       ├── trading-agent.md        # [NEW] 无限制（交易Agent集成，强制读完）
│   │   │   │       └── neodata-search.md       # [NEW] 无限制（金融数据查询，强制读完）
│   │   │   └── references/
│   │   │       ├── investment-frameworks.md    # [NEW] 无限制（投资框架）
│   │   │       ├── external-resources.md      # [NEW] 无限制（外部资源索引）
│   │   │       └── external-templates/         # [NEW] 按需复制（无限制）
│   │   │           ├── dcf-model/
│   │   │           ├── earnings-analysis/
│   │   │           └── valuation-review/
│   │   └── ... (其他司师级，共21个)
│   └── optimization/
│       └── meta-design-team/              # [NEW] 元设计团队工作目录
│           ├── external-resources-index.md # [NEW] 无限制（外部资源索引）
│           ├── architecture-advisors/     # [NEW] 架构顾问团
│           ├── agent-design-outputs/      # [NEW] Agent设计产出（19份）
│           ├── skill-design-outputs/      # [NEW] Skill设计产出（辩论记录）
│           ├── external-templates-mapped/ # [NEW] 按需映射的模板（50-80个）
│           └── final-architecture.md      # [NEW] 无限制（最终架构文档）
```

## 4支柱文件结构示例

### routing.yaml 格式示例（Queen）

```
name: Queen
role: Orchestrator
layer: L1
triggers:
  - 威帝
  - 统筹
  - 调度
  - 汇报
capabilities:
  - task-orchestration
  - agent-dispatch
  - quality-gate
  - meta-design-coordination
dependencies:
  - 贵妃
  - 慧妃
  - 仪妃
  - 令妃
  - 谨妃
  - 昭妃
  - 御鉴司
outputs:
  - 任务编排计划
  - 质量门控报告
  - 元设计产出汇总
routing_rules:
  金融相关: 贵妃
  AI应用: 慧妃
  自媒体: 仪妃
  教育考试: 令妃
  市场情报: 谨妃
  项目调度: 昭妃
  审核监察: 御鉴司
```

### identity.md 格式示例（贵妃，基于STAR原则）

```markdown
# 身份定义 - 贵妃 💰

## S - Situation（情境）
尚融局统领，负责金融贷款领域的战略规划和跨局协调。向Queen汇报，管理尚融局下属3个司师级。

## T - Task（任务）
- 统筹尚融局金融事务
- 协调跨局协作项目
- 验收尚融局成果质量
- 汇报重要事项给Queen

## A - Action（行动）
- 任务分解：将Queen指令分解为尚融局可执行任务
- 资源调配：协调司投师、司贷师、司客师资源
- 质量审核：验收交付物是否符合标准
- 进度跟踪：监控任务执行进度

## R - Result（结果）
- 尚融局任务按时交付率 ≥ 95%
- 跨局协调成功率 ≥ 90%
- 威帝满意度 ≥ 90%

## 专业语调
优雅、稳重、专业，使用金融术语，注重风险控制。

## 行为约束
- 不直接执行具体任务，只协调和验收
- 不越级上报，按层级汇报
- 不泄露威帝隐私和商业机密
```

## 实施说明

- **并行执行优先**：Phase 2（19位大师）和 Phase 3（11位分析师）必须使用 TeamCreate 并行执行
- **辩论机制**：trading-agent 采用辩论制（多空辩论 + 风险三方辩论），确保设计质量
- **外部资源整合**：司师级通过 skill-invocation 规则调用外部技能，典级通过司师级间接访问
- **质量门控**：妃子级验收成果时使用质量审核流程，确保输出符合标准
- **命名规范**：司级3字、典级2字，全局唯一不重复

## Agent Extensions

### Skill

- **skill-creator**: 用于创建和验证新的 Skill 文件，确保4支柱模型格式符合规范
- **brainstorming**: 用于元设计团队的头脑风暴，探索架构设计可能性
- **gstack-health**: 用于验证架构文件的代码质量
- **gstack-review**: 用于评审架构设计的合理性

### SubAgent

- **code-explorer**: 用于搜索和验证目录结构、文件引用关系，检查外部资源整合情况

---

## 进度追踪（实时更新）

**更新时间**：2026-05-20 12:49

### Phase 2：Agent 架构设计产出统计

| 大师/分析师 | 设计对象 | 产出状态 | 核心创新 |
| --- | --- | --- | --- |
| **phil-fisher**（费雪） | 司开师 | ✅ 完整 | 成长品质4支柱、研发创新映射 |
| **stanley-druckenmiller**（德鲁肯米勒） | 谨妃 + 司情师 | ✅ 完整 | 宏观视角路由、非对称收益决策 |
| **valuation-analyst**（估值分析师） | 司投师 | ✅ 精简版 | 多方法估值框架 |
| **technicals-analyst**（技术面分析师） | 司情师（技术面） | ✅ 完整 | 趋势/动量/波动率3维度 |
| **sentiment-analyst**（情绪分析师） | 司情师（情绪） | ✅ 完整 | 内部人交易+资金流向+舆情情绪 |
| **rakesh-jhunjhunwala**（金君瓦拉） | 司客师 | ✅ 完整 | 成长+安全边际>30%映射客户关系 |
| **mohnish-pabrai**（帕布莱） | 司贷师 | ✅ 完整 | Dhandho下行保护+DAI≥3.0+Kelly仓位+风险分级 |
| warren-buffett（巴菲特） | 贵妃 + 司投师 | ✅ 完整 | 护城河分析+安全边际+投资建议生成 |
| charlie-munger（芒格） | 御鉴 + 司审师 | ✅ 完整 | 反向思考驱动风控中枢+检查清单方法论 |
| peter-lynch（林奇） | 仪妃 + 司策师 | ⏳ 等待中 | - |
| cathie-wood（伍德） | 慧妃 + 司研师 | ✅ 完整 | 颠覆性创新哲学+自身能力占比50%/80% |
| nassim-taleb（塔勒布） | 司安师 + 司实师 | ⏳ 等待中 | - |
| michael-burry（伯里） | 司投师（深度价值） | ⏳ 等待中 | - |
| ben-graham（格雷厄姆） | 司贷师 | ⏳ 等待中 | - |
| bill-ackman（阿克曼） | 司客师 | ⏳ 等待中 | - |
| aswath-damodaran（达摩达兰） | 估值框架 | ⏳ 等待中 | - |
| fundamentals-analyst（基本面分析师） | 各司师基本面 | ⏳ 等待中 | - |
| growth-analyst（成长分析师） | 司研师成长 | ⏳ 等待中 | - |
| news-sentiment-analyst（新闻情绪分析师） | 司情师新闻 | ⏳ 等待中 | - |


**当前进度**：10/19（52.6%）

### 已收到产出亮点

#### 1. 司开师（费雪设计）

- **GROWTH模型**：Ground→Relationship→Opportunity→Wealth→Territory→Hedge
- **研发创新映射**：scuttlebutt调研法→司开师客户访谈
- **成长品质约束**：研发投入≥5%营收、创新产品≥2个/年

#### 2. 谨妃+司情师（德鲁肯米勒设计）

- **宏观视角路由**：经济周期→利率→行业→个股
- **非对称收益决策**：盈亏比≥3:1才执行
- **司情师情绪4维度**：内部人交易+资金流向+舆情情绪+衍生信号

#### 3. 司客师（金君瓦拉设计）

- **投资隐喻**：客户=成长股、关系=长期持有、获客=新兴市场发现
- **安全边际纪律**：LTV/CAC≥3:1（如同投资必须有30%安全边际）
- **逆向思维**：市场低迷时加大获客（逆周期策略）
- **复利思维**：客户终身价值随时间指数增长

#### 4. 司贷师（帕布莱设计）

- **Dhandho三原则**：下行保护优先（抵押覆盖率>150%）+ 翻倍潜力评估（LTV≥3x）+ 不对称机会识别（DAI≥2.0）
- **DAI公式**：DAI = (翻倍得分 × 下行保护系数) / 下行风险得分，DAI≥3.0重仓
- **Kelly仓位管理**：f* = (bp - q)/b，单笔损失≤2%，累计损失≥5%暂停
- **四大心法**：先看地板再看天花板、复制成功而非创新冒险、耐心等待果断出手、小亏大赚允许试错
- **风险分级**：A+/A/B+/B/C/D六级（比格雷厄姆更精细）

### Phase 3：Skill 架构设计产出统计

| 分析师 | 设计对象 | 产出状态 |
| --- | --- | --- |
| market-analyst | 技术面Skill | ⏸️ 待启动 |
| fundamentals-analyst | 基本面Skill | ⏸️ 待启动 |
| news-analyst | 新闻Skill | ⏸️ 待启动 |
| sentiment-analyst | 情绪Skill | ⏸️ 待启动 |
| bull-researcher | 多头论证 | ⏸️ 待启动 |
| bear-researcher | 空头论证 | ⏸️ 待启动 |
| research-manager | 投资计划 | ⏸️ 待启动 |
| trader | 交易提案 | ⏸️ 待启动 |
| aggressive-risk-analyst | 激进风险 | ⏸️ 待启动 |
| conservative-risk-analyst | 保守风险 | ⏸️ 待启动 |
| neutral-risk-analyst | 中性风险 | ⏸️ 待启动 |


**当前进度**：0/11（0%）