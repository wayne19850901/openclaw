# Self-Improving Integration - 尚融局

**版本**: v1.0
**创建时间**: 2026-05-24
**维护者**: 尚融

---

## 一、学习架构

```
尚融局 💰（尚融局统领）
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

### 2.1 金融领域特定场景

| 场景 | 记录到 | 类别 |
|------|--------|------|
| 投资分析错误 | `ERRORS.md` | investment_error |
| 风控判断纠正 | `LEARNINGS.md` | risk_correction |
| 估值方法改进 | `LEARNINGS.md` | valuation_improvement |
| 客户服务优化 | `LEARNINGS.md` | customer_best_practice |
| 合规问题发现 | `ERRORS.md` | compliance_issue |

### 2.2 检测信号

**投资纠正信号**:
- "这个估值不对..."
- "风险考虑不周..."
- "护城河分析有误..."

**风控纠正信号**:
- "风险敞口太大..."
- "安全边际不够..."
- "压力测试不足..."

---

## 三、晋升机制

同全局标准，但增加金融领域特定晋升路径：

| 学习类型 | 晋升目标 |
|----------|----------|
| 投资分析规则 | `~/.claw/agents/尚融局/references/投资框架.md` |
| 风控规则 | `~/.claw/agents/御鉴司/.learnings/` |
| 客户服务规则 | `~/.claw/agents/尚融局/drivers/constraints.md` |

---

## 四、心跳维护

### 4.1 金融数据更新检查

```bash
# 检查市场数据源状态
grep -h "Data-Source" .learnings/*.md | sort | uniq -c

# 检查估值模型版本
grep -h "Model-Version" .learnings/*.md | sort | uniq -c
```

### 4.2 合规检查

每月检查学习记录是否符合：
- 金融数据保密要求
- 客户隐私保护
- 合规审计要求

---

_配置者：尚融 💰_
_更新时间：2026-05-24_
