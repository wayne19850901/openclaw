# 堆叠PR工作流

## 概述

堆叠PR（Stacked PR）是指一系列PR，每个PR的目标分支是前一个PR的分支。这种工作流允许并行开发多个相关功能。

## 工作流图示

```
main
  │
  └── feature-a (PR #1)
        │
        └── feature-b (PR #2, target: feature-a)
              │
              └── feature-c (PR #3, target: feature-b)
```

## 合并步骤

### 1. 合并第一个PR

```bash
# Squash merge PR #1 到 main
gh pr merge 1 --squash --title "feat: feature A (#1)"
```

### 2. 对每个后续PR

```bash
# Rebase到main
git rebase --onto origin/main feature-a feature-b

# 强制推送（使用--force-with-lease更安全）
git push --force-with-lease origin feature-b

# 更新PR的base为main
gh pr edit 2 --base main

# Squash merge
gh pr merge 2 --squash --title "feat: feature B (#2)"
```

### 3. 重复直到所有PR合并

## 冲突处理

如果rebase时出现冲突：

1. **停止** - 不要继续自动解决
2. **通知用户** - 请求用户手动解决冲突
3. **等待指示** - 用户解决后再继续

```bash
# 冲突时的状态
git status
# 会显示冲突文件

# 用户解决冲突后
git add <resolved-files>
git rebase --continue
```

## 最佳实践

| 实践 | 原因 |
|------|------|
| 每个PR保持小而专注 | 便于审查和合并 |
| 使用描述性分支名 | 易于追踪 |
| 及时同步上游变更 | 减少冲突 |
| 保持PR链简短 | 降低复杂度 |

## 注意事项

- 堆叠PR数量建议不超过3-5个
- 每个PR应能独立工作（合并后）
- 及时与团队沟通PR链状态

---

_尚宫局·昭妃参考_
