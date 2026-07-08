# Self-Improving Integration - 尚工局

**版本**: v1.0
**创建时间**: 2026-05-24
**维护者**: 尚工

---

## 一、学习架构

```
尚工局 💻
├── .learnings/                    # [NEW] 学习记录
│   ├── LEARNINGS.md              # 学习日志
│   ├── ERRORS.md                 # 错误记录
│   ├── FEATURE_REQUESTS.md       # 功能请求
│   └── index.md                  # 学习索引
├── drivers/
│   ├── identity.md
│   ├── routing.yaml
│   └── constraints.md
├── executors/
│   └── workflows/
├── memory/
│   └── MEMORY.md
└── references/
```

---

## 二、学习触发器

### 2.1 自动记录场景

| 场景 | 记录到 | 类别 |
|------|--------|------|
| 代码执行失败 | `ERRORS.md` | error |
| 用户纠正代码 | `LEARNINGS.md` | correction |
| 发现更好方案 | `LEARNINGS.md` | best_practice |
| 知识过时 | `LEARNINGS.md` | knowledge_gap |
| 用户请求新功能 | `FEATURE_REQUESTS.md` | feature_request |

### 2.2 检测信号

**纠正信号**:
- "不对，应该是..."
- "你写错了..."
- "这样改一下..."
- "我之前说过..."

**最佳实践信号**:
- "这个方案不错"
- "下次也这样写"
- "记住这个模式"

**功能请求信号**:
- "能不能也..."
- "希望可以..."
- "如果有...就好了"

---

## 三、晋升机制

```
局级学习 (.learnings/)
    ↓ 重复3次 + 适用范围扩大
全局学习 (~/self-improving/)
    ↓ 确认为系统规则
OpenClaw规则 (~/.claw/)
```

### 3.1 晋升条件

| 源 → 目标 | 条件 |
|-----------|------|
| `.learnings/` → `~/self-improving/` | 重复3次 + 跨局适用 |
| `~/self-improving/` → `~/.claw/CLAUDE.md` | 确认为系统规则 |
| `~/self-improving/` → `~/.claw/OUTPUT-STANDARD.md` | 排版相关规则 |
| `~/self-improving/` → `~/.claw/PROGRESS.md` | 项目进度相关 |

### 3.2 降级条件

| 条件 | 操作 |
|------|------|
| 30天未使用 | 降级到 WARM |
| 90天未使用 | 归档到 COLD |
| 规则冲突 | 标记待确认 |

---

## 四、心跳维护

### 4.1 维护频率

- **局级**: 每周一次（周日）
- **全局**: 每两周一次
- **晋升检查**: 每月一次

### 4.2 维护任务

```bash
# 检查学习状态
grep -h "Status\*\*: pending" .learnings/*.md | wc -l

# 检查重复学习
grep -h "Pattern-Key:" .learnings/LEARNINGS.md | sort | uniq -c | sort -rn

# 晋升候选
grep -h "Recurrence-Count: [3-9]" .learnings/LEARNINGS.md
```

---

## 五、接口定义

### 5.1 记录学习

```markdown
## [LRN-YYYYMMDD-XXX] category

**Logged**: ISO-8601 timestamp
**Priority**: low | medium | high
**Status**: pending
**Area**: frontend | backend | infra | tests | docs | config

### Summary
一句话描述

### Details
详细上下文

### Suggested Action
具体改进建议

### Metadata
- Source: conversation | error | user_feedback
- Related Files: path/to/file.ext
- Tags: tag1, tag2
- Pattern-Key: simplify.xxx | harden.xxx
- Recurrence-Count: 1
- First-Seen: YYYY-MM-DD
- Last-Seen: YYYY-MM-DD
```

### 5.2 查询学习

```bash
# 查看所有待处理学习
grep -h "Status\*\*: pending" .learnings/*.md

# 按区域过滤
grep -h "Area\*\*: backend" .learnings/*.md

# 按标签过滤
grep -h "Tags:.*api" .learnings/*.md
```

---

## 六、协作机制

### 6.1 跨局学习共享

当学习适用于多个局时：
1. 记录到局级 `.learnings/`
2. 标记 `Cross-Bureau: true`
3. 心跳维护时检查晋升条件

### 6.2 上报 Queen

当学习涉及系统级规则时：
1. 标记 `Escalate: true`
2. 在下次汇报时提及
3. Queen 决定是否晋升到全局

---

_配置者：尚工 💻_
_更新时间：2026-05-24_
