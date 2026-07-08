# gstack Land-and-Deploy 参考指南

**精简版参考文档，完整流程请查看原始 SKILL.md**

---

## 概述

Land-and-Deploy 是 gstack 的合并部署工作流，自动化从 PR 合并到生产验证的完整流程。

**触发词**：`merge and deploy`, `land the pr`, `ship to production`

---

## 10步工作流摘要

| Step | 名称 | 关键动作 |
|------|------|----------|
| 0 | Detect platform | 检测 GitHub/GitLab，确定 base branch |
| 1 | Pre-flight | gh auth 检查，PR 检测 |
| 1.5 | Dry-run validation | 首次运行：基础设施检测、教学模式 |
| 2 | Pre-merge checks | CI 状态、merge conflicts 检查 |
| 3 | Wait for CI | 等待 CI 完成（15min timeout） |
| 3.4 | VERSION drift | 检测 VERSION 与 queue drift |
| 3.5 | Readiness gate | Review staleness、test results、PR body accuracy |
| 4 | Merge PR | Auto-merge 或 squash merge |
| 5 | Deploy strategy | 检测部署方式（Vercel/Heroku/Custom） |
| 6 | Wait for deploy | 等待部署完成 |
| 7 | Canary verification | 检查生产健康（console errors、performance） |
| 8 | Revert if needed | 检测问题时建议回滚 |
| 9 | Deploy report | 生成部署报告 |
| 10 | Follow-ups | 建议后续操作 |

---

## 关键特性

### 非交互式哲学

- **关键门禁**：仅在异常时询问
- **自动决策**：CI pass → merge → deploy → verify
- **首次教学**：首次运行提供详细指导
- **后续高效**：后续运行静默执行

### Canary Verification

部署后自动检查：
- Console errors
- Performance regressions
- Page failures
- HTTP status codes

---

## Pre-merge Readiness Gate

检查项：
- Review staleness（>7 days warn）
- Test results（must pass）
- PR body accuracy（matches diff）
- Doc release check（README/CLAUDE.md）

---

## Deploy Strategy Detection

| 平台 | 检测方式 |
|------|----------|
| Vercel | `vercel.json` 或 `vercel` CLI |
| Heroku | `app.json` 或 `heroku` CLI |
| Custom | `.github/workflows/deploy.yml` |
| Unknown | Ask user |

---

## Canary Checks

```bash
# 检查生产健康
curl -s -o /dev/null -w '%{http_code}' https://production-url/
# 检查 console errors（browse daemon）
# 检查 performance（lighthouse）
```

---

## 输出格式

```
## Land 部署完成
**PR**：#{N}
**合并**：{squash/merge} @ {timestamp}
**部署**：{success/failed} @ {platform}
**Canary**：{pass/fail} ({K} checks)
**状态**：{healthy/unhealthy}

### 部署时间线
- CI wait：{N} min
- Deploy wait：{M} min
- Canary check：{K} checks

### Follow-ups
- {suggested actions}
```

---

## 回滚流程

Canary 检测到问题时：

1. **建议回滚**：提供回滚命令
2. **用户决策**：确认是否回滚
3. **执行回滚**：`git revert` 或平台回滚

---

## 重要规则

- **Wait for CI**：必须等待 CI pass
- **Canary mandatory**：部署后必须验证
- **Revert on failure**：检测问题立即建议回滚
- **No force merge**：merge conflicts 必须手动解决

---

_参考：~/.claude/skills/gstack/land-and-deploy/SKILL.md（完整版）_