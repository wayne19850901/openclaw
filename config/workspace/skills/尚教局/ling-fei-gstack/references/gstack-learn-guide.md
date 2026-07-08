# gstack/learn 完整指南

## 概述

gstack/learn 管理 AI 在项目运行过程中积累的学习记录。每次技能运行，
gstack 会自动记录操作发现、项目特性、踩坑经验等。令妃将其用于教学场景的经验沉淀。

## 核心命令

### review — 回顾学习记录

```bash
~/.claude/skills/gstack/bin/gstack-learnings-review
```

输出：
- 最近的学习记录列表
- 按类型分类（operational / project-specific / workflow）
- 按置信度排序

### search — 搜索学习记录

```bash
~/.claude/skills/gstack/bin/gstack-learnings-search --query "关键词" --limit N
```

参数：
- `--query` — 搜索关键词
- `--limit` — 返回条数限制
- `--type` — 按类型过滤（operational / project-specific / workflow）

### prune — 清理学习记录

```bash
~/.claude/skills/gstack/bin/gstack-learnings-prune --older-than N --confidence-below M
```

参数：
- `--older-than` — 清理 N 天前的记录
- `--confidence-below` — 清理置信度低于 M 的记录

### export — 导出学习记录

```bash
~/.claude/skills/gstack/bin/gstack-learnings-export --format json --output path/to/file.json
```

参数：
- `--format` — 输出格式（json / markdown）
- `--output` — 输出文件路径

## 学习记录结构

```json
{
  "skill": "learn",
  "type": "operational",
  "key": "python-command",
  "insight": "此项目使用 python3 命令而非 python",
  "confidence": 9,
  "source": "observed",
  "timestamp": "2025-01-15T10:30:00Z"
}
```

字段说明：
- `skill` — 记录来源的技能名
- `type` — 类型：operational（操作经验）、project-specific（项目特性）、workflow（工作流优化）
- `key` — 简短标识键
- `insight` — 具体发现描述
- `confidence` — 置信度（0-10）
- `source` — 来源：observed（观察）、user-told（用户告知）、documentation（文档）

## 教育场景应用

### 教学经验沉淀

```bash
~/.claude/skills/gstack/bin/gstack-learnings-log '{"skill":"course-design","type":"workflow","key":"recursion-teaching","insight":"递归概念用可视化演示效果更好","confidence":8,"source":"observed"}'
```

### 学生画像积���

```bash
~/.claude/skills/gstack/bin/gstack-learnings-log '{"skill":"tutorial-writing","type":"project-specific","key":"student-common-error","insight":"初学者常混淆递归与循环的终止条件","confidence":9,"source":"observed"}'
```

### 课程反馈记录

```bash
~/.claude/skills/gstack/bin/gstack-learnings-log '{"skill":"course-design","type":"workflow","key":"feedback-pattern","insight":"学员反馈练习题难度梯度不够平滑","confidence":7,"source":"user-told"}'
```

## 自动记录机制

gstack 在技能运行结束时会自动调用：

```bash
~/.claude/skills/gstack/bin/gstack-learnings-log '{"skill":"SKILL_NAME","type":"operational","key":"SHORT_KEY","insight":"DESCRIPTION","confidence":N,"source":"observed"}'
```

令妃执行教学任务时，gstack 会自动记录教学操作经验。

## 存储位置

学习记录存储在：
```
~/.gstack/projects/{project-slug}/learnings.jsonl
```

每行一条 JSON 记录，追加写入。

---

_尚教局·令妃 — gstack/learn 整合参考_