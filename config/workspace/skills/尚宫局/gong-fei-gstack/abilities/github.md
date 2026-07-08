# GitHub仓库管理

## 概述

使用 `gh` CLI 进行GitHub操作，包括PR、合并策略、仓库自动化。

## 快速命令

```bash
# 创建PR
gh pr create --title "feat: add feature" --body "Description"

# Squash合并PR
gh pr merge <PR_NUMBER> --squash --title "feat: add feature (#<PR_NUMBER>)"

# 查看PR状态
gh pr status
gh pr checks <PR_NUMBER>
```

## 堆叠PR工作流

当合并一串堆叠PR（每个PR目标为前一个分支）：

1. **合并第一个PR** 到main（squash merge）
2. **对每个后续PR**：rebase到main，更新base为main，然后squash merge
3. **遇到冲突**：停止并请求用户手动解决

```bash
# Rebase下一个PR的分支到main，排除已合并的commit
git rebase --onto origin/main <old-base-branch> <next-branch>
git push --force-with-lease origin <next-branch>
gh pr edit <N> --base main
gh pr merge <N> --squash --title "<PR title> (#N)"
```

## 常用操作

| 操作 | 命令 |
|------|------|
| 查看PR列表 | `gh pr list` |
| 查看PR详情 | `gh pr view <N>` |
| 检出PR分支 | `gh pr checkout <N>` |
| 批准PR | `gh pr review <N> --approve` |
| 请求修改 | `gh pr review <N> --request-changes` |
| 评论PR | `gh pr comment <N> --body "comment"` |

## 合并策略

| 策略 | 命令 | 适用场景 |
|------|------|----------|
| Merge | `--merge` | 保留完整历史 |
| Squash | `--squash` | 清洁历史，单个commit |
| Rebase | `--rebase` | 线性历史，无merge commit |

## 与 gstack ship 的关系

- **ship 能力**：包含更完整的 PR 创建流程（测试、review、CHANGELOG等）
- **推荐使用**：发布时优先使用 `ship`，日常 PR 管理可使用此能力

---

_来源：尚宫局原有能力_