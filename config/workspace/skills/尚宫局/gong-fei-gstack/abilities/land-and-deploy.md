# Land 部署能力

**身份**：昭妃部署能力，整合 gstack/land-and-deploy 工作流

**触发词**：`land`, `merge`, `deploy`, `合并部署`, `merge and deploy`, `land the pr`, `ship to production`

---

## 执行流程概述

当用户触发 land-and-deploy 能力时，执行以下流程：

```
Step 0: 检测平台和基础分支
    ↓
Step 1: 预检查（gh auth、PR检测）
    ↓
Step 1.5: Dry-run验证（首次运行）
    ↓
Step 2: Pre-merge检查（CI状态、merge conflicts）
    ↓
Step 3: Wait for CI（15min timeout）
    ↓
Step 3.4: VERSION drift检测
    ↓
Step 3.5: Pre-merge readiness gate
    ↓
Step 4: Merge PR（auto-merge或squash）
    ↓
Step 5: Deploy strategy检测
    ↓
Step 6: Wait for deploy
    ↓
Step 7: Canary verification
    ↓
Step 8: Revert if needed
    ↓
Step 9: Deploy report
    ↓
Step 10: Suggest follow-ups
```

---

## 执行指令

**实际执行时，加载并执行原始 gstack/land-and-deploy SKILL.md**：

```bash
# 加载 gstack land-and-deploy 技能
cat ~/.claude/skills/gstack/land-and-deploy/SKILL.md

# 执行完整 land-and-deploy 工作流
# （由 AI 根据加载的 SKILL.md 内容执行）
```

**关键特性**：
- **非交互式**：合并后自动部署，仅在异常时询问
- **Canary验证**：部署后自动检查生产健康
- **自动回滚**：检测到问题自动建议回滚
- **首次教学**：首次运行提供详细指导

---

## 输出格式

```
## Land 部署完成
**PR**：#{PR-number}
**合并方式**：{squash/merge}
**部署状态**：{success/failed/rollback}
**Canary检查**：{pass/fail}
**来源**：gstack/land-and-deploy

### 部署摘要
- CI等待：{N} 分钟
- 部署等待：{M} 分钟
- Canary验证：{K} 检查点
- 生产状态：{healthy/unhealthy}
```

---

## 与尚宫局原有能力的关系

- **github.md**：land-and-deploy 包含更完整的合并部署流程
- **ship.md**：ship 创建 PR，land-and-deploy 合并部署，形成完整发布链

---

## 参考文档

详细流程参考：`references/gstack-land-and-deploy-guide.md`

原始技能：`~/.claude/skills/gstack/land-and-deploy/SKILL.md`

---

_尚宫局·昭妃部署能力，整合 gstack land-and-deploy 工作流_