# gstack 工具清单

## 核心工具

### Bash

执行 shell 命令。

```bash
# 示例
git status
npm test
```

### Read

读取文件内容。

```bash
# 示例
Read auth.ts
```

### Write

写入文件内容（覆盖）。

```bash
# 示例
Write auth.ts <<EOF
...
EOF
```

### Edit

编辑文件内容（精确替换）。

```bash
# 示例
Edit auth.ts --old_str "old" --new_str "new"
```

### Grep

搜索文件内容。

```bash
# 示例
Grep "pattern" --path .
```

### Glob

搜索文件名。

```bash
# 示例
Glob "*.ts" --path .
```

---

## gstack 专用工具

### gstack-config

配置管理。

```bash
# 获取配置
~/.claude/skills/gstack/bin/gstack-config get <key>

# 设置配置
~/.claude/skills/gstack/bin/gstack-config set <key> <value>
```

常用配置：

| Key | 说明 | 默认值 |
|-----|------|--------|
| `proactive` | 主动建议技能 | `true` |
| `explain_level` | 解释详细程度 | `default` |
| `checkpoint_mode` | 检查点模式 | `explicit` |
| `checkpoint_push` | 检查点推送 | `false` |
| `telemetry` | 遥测 | `off` |
| `routing_declined` | 拒绝路由 | `false` |

### gstack-learnings-*

学习记录管理。

```bash
# 记录学习
~/.claude/skills/gstack/bin/gstack-learnings-log '{"skill":"...","type":"...","key":"...","insight":"...","confidence":N,"source":"..."}'

# 回顾学习
~/.claude/skills/gstack/bin/gstack-learnings-review

# 搜索学习
~/.claude/skills/gstack/bin/gstack-learnings-search --query "关键词"

# 清理学习
~/.claude/skills/gstack/bin/gstack-learnings-prune --older-than N

# 导出学习
~/.claude/skills/gstack/bin/gstack-learnings-export --format json
```

### gstack-question-*

问题偏好管理。

```bash
# 检查偏好
~/.claude/skills/gstack/bin/gstack-question-preference --check "<id>"

# 记录偏好
~/.claude/skills/gstack/bin/gstack-question-preference --write '{"question_id":"...","preference":"..."}'

# 记录问题
~/.claude/skills/gstack/bin/gstack-question-log '{"skill":"...","question_id":"...","question_summary":"...","category":"...","door_type":"...","options_count":N,"user_choice":"...","recommended":"..."}'
```

### gstack-timeline-log

时间线记录。

```bash
~/.claude/skills/gstack/bin/gstack-timeline-log '{"skill":"...","event":"...","branch":"...","outcome":"...","duration_s":"..."}'
```

### gstack-telemetry-log

遥测记录。

```bash
~/.claude/skills/gstack/bin/gstack-telemetry-log --skill "..." --duration N --outcome "..." --used-browse "..."
```

### gstack-brain-sync

Artifacts 同步。

```bash
# 同步一次
~/.claude/skills/gstack/bin/gstack-brain-sync --once

# 发现新 artifacts
~/.claude/skills/gstack/bin/gstack-brain-sync --discover-new
```

### gstack-slug

获取项目标识。

```bash
eval "$(~/.claude/skills/gstack/bin/gstack-slug)"
```

### gstack-update-check

检查更新。

```bash
~/.claude/skills/gstack/bin/gstack-update-check
```

### gstack-repo-mode

检测仓库模式。

```bash
source <(~/.claude/skills/gstack/bin/gstack-repo-mode)
```

---

## 平台 CLI

### GitHub CLI (gh)

```bash
# PR 操作
gh pr view --json body,title,baseRefName
gh pr edit --body-file file.md --title "title"
gh pr create --title "title" --body "body"

# 仓库操作
gh repo view --json defaultBranchRef
```

### GitLab CLI (glab)

```bash
# MR 操作
glab mr view -F json
glab mr update -d "description" -t "title"
glab mr create --title "title" --description "body"

# 仓库操作
glab repo view -F json
```

---

## 存储位置

| 内容 | 路径 |
|------|------|
| 配置 | `~/.gstack/config.json` |
| 学习记录 | `~/.gstack/projects/{slug}/learnings.jsonl` |
| 时间线 | `~/.gstack/projects/{slug}/timeline.jsonl` |
| 分析数据 | `~/.gstack/analytics/skill-usage.jsonl` |
| 会话标记 | `~/.gstack/sessions/{PID}` |

---

_来源：gstack 方法论知识库_
