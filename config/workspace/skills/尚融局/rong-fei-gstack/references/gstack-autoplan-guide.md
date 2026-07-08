# 自动评审流水线配置

## 概述

自动评审流水线顺序执行四个评审阶段，使用六决策原则自动裁决，仅将关键决策提交用户确认。

## 流水线阶段

```
┌─────────────────────────────────────────────────────────────┐
│                     AUTOPLAN PIPELINE                        │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  Phase 1: CEO Review                                         │
│  ├── System audit (CLAUDE.md, DESIGN.md, TODOS.md)          │
│  ├── Mode selection (auto)                                  │
│  ├── 11 review sections                                     │
│  └── Auto-decide scope expansions                           │
│           ↓                                                  │
│  Phase 2: Design Review                                      │
│  ├── Visual hierarchy check                                 │
│  ├── Interaction state coverage                             │
│  ├── Responsive intent                                       │
│  ├── Accessibility basics                                   │
│  └── Auto-decide design decisions                           │
│           ↓                                                  │
│  Phase 3: Eng Review                                         │
│  ├── Architecture depth check                               │
│  ├── Test strategy validation                               │
│  ├── Performance risk assessment                            │
│  └── Auto-decide technical decisions                        │
│           ↓                                                  │
│  Phase 4: DX Review                                          │
│  ├── Developer experience check                             │
│  ├── Documentation completeness                            │
│  ├── API consistency                                        │
│  └── Auto-decide DX decisions                               │
│           ↓                                                  │
│  Summary Report                                              │
│  ├── Auto-decided list                                      │
│  ├── Pending user confirmations                             │
│  └── Aggregated implementation tasks                        │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

## 六决策原则

### 1. 保守默认（Conservative Default）

不确定时选择风险更低的选项。

```python
if uncertain:
    return lower_risk_option
```

### 2. 范围优先（Scope Priority）

优先完成核心功能，扩展放后面。

```python
if finding.type == "expansion":
    return "defer_to_todos"
```

### 3. 证据驱动（Evidence Driven）

有代码证据的优先于推测。

```python
if finding.evidence in code:
    return "accept"
```

### 4. 一致性（Consistency）

与现有架构/设计保持一致。

```python
if finding.aligns_with_existing:
    return "accept"
```

### 5. 可逆性（Reversibility）

优先选择可逆的决策。

```python
if finding.reversible:
    return "accept"
```

### 6. 品味校准（Taste Calibration）

符合 DESIGN.md 定义的设计系统。

```python
if finding.matches_design_system:
    return "accept"
```

## 自动裁决逻辑

```python
def auto_decide(finding):
    # 高风险 → 延期
    if finding.risk == "high":
        return "defer"
    
    # 扩展 → TODOS.md
    if finding.type == "expansion":
        return "defer_to_todos"
    
    # 有证据 → 接受
    if finding.evidence in code:
        return "accept"
    
    # 一致 → 接受
    if finding.aligns_with_existing:
        return "accept"
    
    # 可逆 → 接受
    if finding.reversible:
        return "accept"
    
    # 符合设计系统 → 接受
    if finding.matches_design_system:
        return "accept"
    
    # 默认 → 提交用户
    return "ask_user"
```

## 输出格式

### 汇总报告

```markdown
# Autoplan Summary

Run ID: 20260517-185100
Plan: plans/feature-x.md
Duration: 12m 34s

## Auto-Decided

| Phase | Finding | Decision | Reasoning |
|-------|---------|----------|-----------|
| CEO | Add caching layer | Accept | Evidence in code |
| CEO | Expand to mobile | Defer | Scope priority |
| Design | Use card layout | Accept | Matches DESIGN.md |
| Design | Add dark mode | Defer | Out of scope |
| Eng | Use PostgreSQL | Accept | Consistency |
| Eng | Add GraphQL API | Ask User | High risk |
| DX | Add API docs | Accept | Reversible |
| DX | Create SDK | Defer | Scope priority |

## Pending User Confirmation

### Finding: Add GraphQL API
- **Phase**: Eng
- **Risk**: High
- **Options**:
  - A) Accept — full GraphQL implementation
  - B) Partial — only read operations
  - C) Defer — add to TODOS.md
  - D) Reject — keep REST only

## Aggregated Tasks

- [ ] **T1 (P1)** — Cache — Implement Redis caching
- [ ] **T2 (P2)** — UI — Card layout refactor
- [ ] **T3 (P1)** — DB — PostgreSQL migration
- [ ] **T4 (P2)** — Docs — API documentation

## Next Steps

1. Confirm pending decisions
2. Review aggregated tasks
3. Begin implementation
```

## 配置选项

```bash
# 跳过某个阶段
/autoplan --skip-phase design

# 跳过多个阶段
/autoplan --skip-phase design,dx

# 试运行（不写入文件）
/autoplan --dry-run

# 指定计划文件
/autoplan plans/my-feature.md

# 只运行特定阶段
/autoplan --only-phase ceo
```

## 阶段间依赖

```
CEO Review
    ↓ 输出：CEO 计划文档、范围决策
    ↓ 依赖：无
    ↓
Design Review
    ↓ 输入：CEO 计划文档（如有）
    ↓ 输出：设计决策
    ↓ 依赖：CEO 阶段完成
    ↓
Eng Review
    ↓ 输入：CEO 计划文档、设计决策
    ↓ 输出：技术决策
    ↓ 依赖：Design 阶段完成
    ↓
DX Review
    ↓ 输入：所有前置决策
    ↓ 输出：DX 决策
    ↓ 依赖：Eng 阶段完成
```

---

_来源：gstack/autoplan | 尚融局参考_
