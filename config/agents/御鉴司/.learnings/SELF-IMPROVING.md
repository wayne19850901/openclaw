# Self-Improving Integration - 御鉴司

**版本**: v1.0
**创建时间**: 2026-05-24
**维护者**: 御鉴

---

## 一、学习架构

```
御鉴司 ⚖️（御鉴统领）
├── .learnings/                    # [NEW] 学习记录
│   ├── LEARNINGS.md              # 学习日志
│   ├── ERRORS.md                 # 错误记录
│   ├── FEATURE_REQUESTS.md       # 功能请求
│   └── SELF-IMPROVING.md         # 本文件
├── drivers/
├── executors/
├── memory/
└── references/
```

---

## 二、学习触发器

### 2.1 风控领域特定场景

| 场景 | 记录到 | 类别 |
|------|--------|------|
| 合规风险发现 | `ERRORS.md` | compliance_risk |
| 审计问题纠正 | `LEARNINGS.md` | audit_correction |
| 制度漏洞发现 | `LEARNINGS.md` | policy_gap |
| 风险预警改进 | `LEARNINGS.md` | risk_improvement |
| 法务问题发现 | `ERRORS.md` | legal_issue |

### 2.2 检测信号

**合规纠正信号**:
- "这个不合规..."
- "审计要求..."
- "制度规定..."

**风险纠正信号**:
- "风险敞口太大..."
- "内控不足..."
- "审计发现..."

---

## 三、晋升机制

同全局标准，但增加风控领域特定晋升路径：

| 学习类型 | 晋升目标 |
|----------|----------|
| 合规规则 | `~/.claw/agents/御鉴司/references/合规手册.md` |
| 审计规则 | `~/.claw/agents/御鉴司/drivers/constraints.md` |
| 制度规则 | `~/.claw/agents/御鉴司/references/制度库.md` |

---

## 四、心跳维护

### 4.1 合规检查

```bash
# 检查合规问题分布
grep -h "Compliance-Area" .learnings/*.md | sort | uniq -c

# 检查风险等级分布
grep -h "Risk-Level" .learnings/*.md | sort | uniq -c
```

### 4.2 审计追踪

每月检查学习记录是否符合审计要求：
- 可追溯性
- 完整性
- 准确性

---

## 五、跨局协作

### 5.1 风险通报机制

当发现跨局风险时：
1. 记录到御鉴司 `.learnings/`
2. 标记 `Cross-Bureau-Risk: true`
3. 通报相关局
4. Queen 协调处理

### 5.2 合规审查机制

其他局晋升学习时：
1. 御鉴司审查合规性
2. 标记 `Compliance-Review: passed/pending`
3. 通过后方可晋升

---

_配置者：御鉴 ⚖️_
_更新时间：2026-05-24_
