# gstack Ship 参考指南

**精简版参考文档，完整流程请查看原始 SKILL.md**

---

## 概述

Ship 是 gstack 的核心发布工作流，自动化从代码变更到 PR 创建的完整流程。

**触发词**：`ship it`, `create a pr`, `push to main`, `deploy this`

---

## 20步工作流摘要

| Step | 名称 | 关键动作 |
|------|------|----------|
| 0 | Detect platform | 检测 GitHub/GitLab，确定 base branch |
| 1 | Pre-flight | 检查分支状态、diff、review readiness |
| 2 | Distribution pipeline | 检查新 artifact 是否有 release workflow |
| 3 | Merge base | 合并 base branch 到 feature branch |
| 4 | Test framework bootstrap | 检测/安装测试框架（如需要） |
| 5 | Run tests | 运行测试，处理失败（in-branch vs pre-existing） |
| 6 | Eval suites | 运行 prompt 相关 eval（条件性） |
| 7 | Test coverage audit | 分析覆盖率，生成缺失测试 |
| 8 | Plan completion audit | 检查 plan 文件完成状态 |
| 8.1 | Plan verification | 自动验证 plan 的测试步骤 |
| 8.2 | Scope drift detection | 检测 scope creep 和 missing requirements |
| 9 | Pre-landing review | 代码质量 review（checklist + specialists） |
| 9.1 | Review Army | 并行 dispatch specialists（testing, security, etc） |
| 9.2 | Collect findings | 合并 specialist findings，dedup |
| 9.3 | Cross-review dedup | 抑制之前 skipped 的 findings |
| 10 | Greptile comments | 处理 AI review comments |
| 11 | Adversarial review | Claude + Codex 对抗性 review（always-on） |
| 12 | Version bump | 自动 bump VERSION + package.json |
| 13 | CHANGELOG | 自动生成 CHANGELOG entry |
| 14 | TODOS.md | 自动标记完成的 TODOs |
| 15 | Commit | 创建 bisectable commits |
| 16 | Verification gate | 重新验证（如有代码变更） |
| 17 | Push | 推送到 remote |
| 18 | Documentation sync | 同步 README/CLAUDE.md 等 |
| 19 | Create PR/MR | 创建 PR，包含完整 body |
| 20 | Persist metrics | 记录 ship metrics 供 retro 使用 |

---

## 关键决策点

### 仅在以下情况询问用户：
- MINOR/MAJOR version bump
- Pre-landing review ASK items
- Codex [P1] findings（large diffs）
- Plan NOT DONE items
- Coverage < minimum threshold
- TODOS.md missing/disorganized

### 自动处理：
- MICRO/PATCH version bump
- CHANGELOG 内容
- Commit message
- Test coverage gaps（在阈值内）
- Auto-fixable review findings
- Multi-file changesets

---

## Review Readiness Dashboard

Ship 检查是否有 prior review：

```
+====================================================================+
|                    REVIEW READINESS DASHBOARD                       |
+====================================================================+
| Review          | Runs | Last Run            | Status    | Required |
|-----------------|------|---------------------|-----------|----------|
| Eng Review      |  1   | 2026-03-16 15:00    | CLEAR     | YES      |
| CEO Review      |  0   | —                   | —         | no       |
| Design Review   |  0   | —                   | —         | no       |
| Adversarial     |  0   | —                   | —         | no       |
| Outside Voice   |  0   | —                   | —         | no       |
+--------------------------------------------------------------------+
| VERDICT: CLEARED — Eng Review passed                                |
+====================================================================+
```

---

## Specialist Review Army

**Always-on（50+ lines）**：
- Testing
- Maintainability

**Conditional（scope-based）**：
- Security（AUTH or BACKEND + >100 lines）
- Performance（BACKEND or FRONTEND）
- Data Migration（MIGRATIONS）
- API Contract（API）
- Design（FRONTEND）

**Adaptive gating**：0 findings in 10+ dispatches → auto-gate

---

## Version Bump 规则

| 级别 | 条件 |
|------|------|
| MICRO | <50 lines, trivial tweaks |
| PATCH | 50+ lines, no feature signals |
| MINOR | Feature signals OR 500+ lines OR new modules（ASK） |
| MAJOR | Milestones/breaking changes（ASK） |

---

## PR Body 结构

```
## Summary
## Test Coverage
## Pre-Landing Review
## Design Review（条件性）
## Eval Results（条件性）
## Greptile Review（条件性）
## Scope Drift（条件性）
## Plan Completion（条件性）
## Verification Results（条件性）
## TODOS
## Documentation
## Test plan
```

---

## 幂等性

重复执行 `/ship`：
- 已 bump VERSION → skip bump
- 已 push → skip push
- 已存在 PR → update body
- **所有 verification 步骤重新运行**

---

## 重要规则

- **Never skip tests**：测试失败必须停止
- **Never skip pre-landing review**：checklist.md 不可读必须停止
- **Never force push**：仅使用 regular push
- **Never push without fresh verification**：代码变更后必须重新测试

---

_参考：~/.claude/skills/gstack/ship/SKILL.md（完整版）_