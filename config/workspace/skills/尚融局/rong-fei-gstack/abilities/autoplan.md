# 自动评审流水线

## 概述

自动执行完整的评审流水线：CEO → Design → Eng → DX。使用六决策原则自动裁决，仅将关键决策提交用户确认。

**来源**: gstack/autoplan

## 使用方式

```bash
/autoplan [--skip-phase <phase>] [--dry-run]
```

## 流水线阶段

```
Phase 1: CEO 评审
    ├── 读取计划文件
    ├── 系统审计（CLAUDE.md, DESIGN.md, TODOS.md）
    ├── 自动选择模式
    ├── 11 个评审章节
    └── 自动裁决范围扩展
    ↓
Phase 2: Design 评审
    ├── 视觉层级检查
    ├── 交互状态覆盖
    ├── 响应式意图
    ├── 无障碍基础
    └── 自动裁决设计决策
    ↓
Phase 3: Eng 评审
    ├── 架构深度检查
    ├── 测试策略验证
    ├── 性能风险评估
    └── 自动裁决技术决策
    ↓
Phase 4: DX 评审
    ├── 开发者体验检查
    ├── 文档完整性
    ├── API 一致性
    └── 自动裁决 DX 决策
    ↓
汇总报告
    ├── 自动裁决列表
    ├── 待确认决策
    └── 实现任务聚合
```

## 六决策原则

| 原则 | 应用场景 |
|------|----------|
| **保守默认** | 不确定时选择风险更低的选项 |
| **范围优先** | 优先完成核心功能，扩展放后面 |
| **证据驱动** | 有代码证据的优先于推测 |
| **一致性** | 与现有架构/设计保持一致 |
| **可逆性** | 优先选择可逆的决策 |
| **品味校准** | 符合 DESIGN.md 定义的设计系统 |

## 执行指令

**加载原始 gstack SKILL.md**:

```bash
# 读取完整技能定义
source_content=$(cat ~/.claude/skills/gstack/autoplan/SKILL.md)
```

将 `source_content` 作为系统提示词的一部分，执行完整的自动评审流水线。

## 自动裁决逻辑

```python
def auto_decide(finding):
    # 保守默认
    if finding.risk == "high":
        return "defer"
    
    # 范围优先
    if finding.type == "expansion":
        return "defer_to_todos"
    
    # 证据驱动
    if finding.evidence in code:
        return "accept"
    
    # 一致性
    if finding.aligns_with_existing:
        return "accept"
    
    # 可逆性
    if finding.reversible:
        return "accept"
    
    # 品味校准
    if finding.matches_design_system:
        return "accept"
    
    # 默认：提交用户确认
    return "ask_user"
```

## 输出格式

### 汇总报告

```markdown
# Autoplan Summary

Run ID: {timestamp}
Plan: {plan-file}
Duration: {duration}

## Auto-Decided
| Phase | Decision | Reasoning |
|-------|----------|-----------|
| CEO | Accept expansion X | Evidence in code |
| Design | Defer to TODOS | Out of scope |
| Eng | Accept refactor | Consistency |
| DX | Accept doc update | Reversible |

## Pending User Confirmation
| Phase | Finding | Options |
|-------|---------|---------|
| CEO | Scope expansion Y | Accept / Defer / Skip |
| Eng | Architecture change | Accept / Reject |

## Aggregated Tasks
{merged task list from all phases}

## Next Steps
1. Confirm pending decisions
2. Run /plan-eng-review if architecture changed
3. Begin implementation
```

## 禁令

- **禁止跳过用户确认** — 关键决策必须提交用户
- **禁止自动实现** — 流水线产出评审报告，不写代码
- **禁止并行阶段** — 阶段间有依赖，必须顺序执行

## 配置选项

```bash
# 跳过某个阶段
/autoplan --skip-phase design

# 试运行（不写入文件）
/autoplan --dry-run

# 指定计划文件
/autoplan plans/my-feature.md
```

---

_来源：gstack/autoplan | 尚融局适配_
