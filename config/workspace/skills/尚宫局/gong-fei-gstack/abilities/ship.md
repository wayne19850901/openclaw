# Ship 发布能力

**身份**：昭妃发布能力，整合 gstack/ship 工作流

**触发词**：`ship`, `发布`, `PR`, `push`, `deploy this`, `ship it`, `create a pr`

---

## 执行流程概述

当用户触发 ship 能力时，执行以下流程：

```
Step 0: 检测平台和基础分支
    ↓
Step 1: 预检查（分支状态、diff分析、review readiness）
    ↓
Step 2: 分布管道检查
    ↓
Step 3: 合并基础分支
    ↓
Step 4: 测试框架引导（如需要）
    ↓
Step 5: 运行测试
    ↓
Step 6: Eval Suites（条件性）
    ↓
Step 7: 测试覆盖审计
    ↓
Step 8: Plan完成审计
    ↓
Step 9: Pre-Landing Review
    ↓
Step 10: 处理Greptile review comments
    ↓
Step 11: Adversarial review（always-on）
    ↓
Step 12: Version bump（auto-decide）
    ↓
Step 13: CHANGELOG（auto-generate）
    ↓
Step 14: TODOS.md（auto-update）
    ↓
Step 15: Commit（bisectable chunks）
    ↓
Step 16: Verification Gate
    ↓
Step 17: Push
    ↓
Step 18: Documentation sync
    ↓
Step 19: Create PR/MR
    ↓
Step 20: Persist ship metrics
```

---

## 执行指令

**实际执行时，加载并执行原始 gstack/ship SKILL.md**：

```bash
# 加载 gstack ship 技能
cat ~/.claude/skills/gstack/ship/SKILL.md

# 执行完整 ship 工作流
# （由 AI 根据加载的 SKILL.md 内容执行）
```

**关键特性**：
- **非交互式**：用户说 `/ship` 即执行，仅在关键决策点询问
- **幂等性**：重复执行安全，已完成的步骤自动跳过
- **质量门禁**：测试失败、覆盖不足、review 问题会阻断流程
- **自动生成**：CHANGELOG、TODOS、测试覆盖自动处理

---

## 输出格式

```
## Ship 发布完成
**分支**：{branch-name}
**版本**：v{X.Y.Z.W}
**PR**：{PR-url}
**状态**：{已完成/需要处理}
**来源**：gstack/ship

### 关键步骤摘要
- 测试：{pass/fail} ({N} tests)
- 覆盖：{X}% ({before} → {after})
- Review：{N} issues ({M} auto-fixed)
- CHANGELOG：已更新
- TODOS：{K} items marked complete
```

---

## 与尚宫局原有能力的关系

- **github.md**：ship 能力包含更完整的 PR 创建流程，优先使用 ship
- **stacked-pr-workflow.md**：ship 支持标准 PR 流程，堆叠 PR 需手动处理

---

## 参考文档

详细流程参考：`references/gstack-ship-guide.md`

原始技能：`~/.claude/skills/gstack/ship/SKILL.md`

---

_尚宫局·昭妃发布能力，整合 gstack ship 工作流_