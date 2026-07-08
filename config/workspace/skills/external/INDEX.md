# 外部资源库索引

> 更新时间：2026-05-19
> 用途：为六局一司架构提供外部参考资源

---

## 资源库列表

| 资源库 | 规模 | 映射局级 | 核心价值 |
|--------|------|----------|----------|
| **agency-agents** | 144+ Agent / 12部门 | 全局参考 | 专业化+个性驱动设计模式 |
| **financial-services** | 10 Agent + 9插件 + 11 MCP | 尚融局、御鉴司 | 金融行业垂直工作流 |

---

## agency-agents 目录结构

```
agency-agents/
├── engineering/          # 工程部 → 尚工局
│   ├── frontend.md       # 前端开发
│   ├── backend.md        # 后端架构师
│   ├── ai-engineer.md    # AI工程师
│   └── devops.md         # DevOps
├── marketing/            # 市场部 → 尚宣局
│   ├── growth-hacker.md  # 增长黑客
│   ├── content-creator.md # 内容创作者
│   └── twitter-expert.md # Twitter专家
├── project-management/   # 项目管理部 → 尚宫局
│   ├── producer.md       # 制作人
│   └── coordinator.md    # 协调员
├── finance/              # 财务部 → 尚融局
│   ├── bookkeeper.md     # 簿记师
│   └── financial-analyst.md # 财务分析师
├── testing/              # 测试部 → 尚机局
│   ├── evidence-collector.md # 证据收集器
│   └── reality-checker.md    # 现实检验者
├── design/               # 设计部 → 尚教局
│   ├── ui-designer.md    # UI设计师
│   └── ux-researcher.md  # UX研究员
└── specialized/          # 专业服务部 → 御鉴司
    ├── agent-orchestrator.md # Agent编排器
    └── blockchain-security.md # 区块链安全审计
```

---

## financial-services 目录结构

```
financial-services/
├── plugins/              # 9个垂直业务插件
│   ├── financial-analysis/   # 核心基础（必装）
│   ├── investment-banking/    # 投资银行
│   ├── equity-research/       # 股票研究
│   ├── private-equity/        # 私募股权
│   ├── wealth-management/    # 财富管理
│   ├── fund-admin/           # 基金管理
│   └── operations/           # 运营
├── managed-agent-cookbooks/  # 10个Agent模板
│   ├── pitch-agent.yaml      # 投行Pitch Deck
│   ├── model-builder.yaml    # 模型构建
│   ├── earnings-reviewer.yaml # 财报分析
│   ├── kyc-screener.yaml     # KYC审查
│   └── ...
└── claude-for-msft-365-install/ # Microsoft 365集成
```

---

## 使用方式

### 1. 参考 Agent 设计模式

```bash
# 查看 agency-agents 工程部 Agent
cat ~/.claw/workspace/skills/external/agency-agents/engineering/frontend.md
```

### 2. 参考 financial-services 插件

```bash
# 查看 financial-analysis 插件
cat ~/.claw/workspace/skills/external/financial-services/plugins/financial-analysis/SKILL.md
```

### 3. 整合到六局一司

| 目标局级 | 参考资源 | 整合方式 |
|----------|----------|----------|
| 尚工局 | agency-agents/engineering | 参考Agent设计模式 |
| 尚宣局 | agency-agents/marketing | 参考增长黑客模板 |
| 尚宫局 | agency-agents/project-management | 参考工作流程 |
| 尚融局 | financial-services/plugins | 整合投行/私募插件 |
| 御鉴司 | financial-services/plugins | 整合基金管理插件 |

---

## 维护说明

- 定期执行 `git pull` 更新
- 新增外部资源时更新此索引
- 整合完成后标注整合状态
