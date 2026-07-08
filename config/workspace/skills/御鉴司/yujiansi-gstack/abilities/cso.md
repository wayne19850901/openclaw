# 安全审计（/cso）

## 触发条件

- 用户说"安全审计"、"安全审查"、"威胁建模"、"OWASP"、"cso"
- 涉及安全合规、漏洞扫描、供应链审计
- 用户请求"安全模式"或"安全检查"

## 角色定位

首席安全官（Chief Security Officer），基础设施优先的安全审计。

**核心原则**：
- 像攻击者一样思考，像防御者一样报告
- 零噪音比零遗漏更重要（日常模式）
- 真实攻击面在依赖项，不在自己的代码

## 参数选项

```bash
/cso                      # 日常审计（8/10 置信度门槛）
/cso --comprehensive      # 月度深度扫描（2/10 门槛）
/cso --infra              # 仅基础设施审计
/cso --code               # 仅代码审计
/cso --skills             # 仅技能供应链审计
/cso --diff               # 仅分支变更审计
/cso --scope auth         # 聚焦特定领域
```

## 执行流程

### Phase 0: 架构心智模型 + 技术栈检测

检测技术栈（Node/TypeScript、Ruby、Python、Go、Rust 等），建立代码库心智模型。

### Phase 1: 攻击面普查

映射代码表面和基础设施表面：
- 公共端点、认证端点、管理端点
- CI/CD 工作流、容器配置、IaC 配置

### Phase 2: 密钥考古

扫描 git 历史、跟踪的 .env 文件、CI 配置中的内联密钥。

### Phase 3: 依赖供应链

检查 CVE、安装脚本、锁文件完整性。

### Phase 4: CI/CD 管道安全

检查未固定的第三方操作、pull_request_target、脚本注入。

### Phase 5: 基础设施影子表面

检查 Dockerfile、配置文件、IaC 安全。

### Phase 6: Webhook 与集成审计

检查签名验证、TLS 验证、OAuth 范围。

### Phase 7: LLM 与 AI 安全

检查提示注入、未清理的 LLM 输出、工具调用验证。

### Phase 8: 技能供应链

扫描已安装的 Claude Code 技能中的恶意模式。

### Phase 9-11: OWASP Top 10 + STRIDE + 数据分类

系统化评估安全风险。

### Phase 12: 误报过滤 + 主动验证

置信度门槛过滤 + 独立验证子任务。

### Phase 13: 发现报告 + 趋势追踪 + 整改

结构化报告 + 跨周期对比 + 整改路线图。

### Phase 14: 保存报告

保存到 `.gstack/security-reports/{date}-{HHMMSS}.json`。

## 输出格式

```
SECURITY FINDINGS
═════════════════
#   Sev    Conf   Status      Category         Finding
──  ────   ────   ──────      ────────         ───────
1   CRIT   9/10   VERIFIED    Secrets          AWS key in git history
2   HIGH   8/10   VERIFIED    CI/CD            pull_request_target + checkout
```

## 执行方式

**重要**：实际执行时，加载 gstack 原始 SKILL.md 获取完整指令：

```bash
# 原始指令路径
~/.claude/skills/gstack/cso/SKILL.md
```

本文件为 wrapper，定义触发条件、参数、输出格式，完整工作流需加载原始指令。

## 误报过滤规则

自动排除以下模式：
- 测试文件中的漏洞（除非被非测试代码导入）
- 文档文件中的安全问题（*.md，但 SKILL.md 除外）
- 占位符（your_、changeme、TODO）
- 已轮换的密钥（仍需标记，但说明已轮换）

## 置信度校准

| 分数 | 含义 |
|------|------|
| 9-10 | 已验证，可写 PoC |
| 7-8 | 高置信度模式匹配 |
| 5-6 | 中等，可能是误报 |
| 3-4 | 低置信度，仅附录 |
| 1-2 | 推测，仅 P0 严重时报告 |

---

_安全审计，零噪音为先。_
