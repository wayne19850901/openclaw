# gstack-codex 精简参考指南

> 完整版：`~/.claude/skills/gstack/codex/SKILL.md`

## 三种模式

| 模式 | 用途 | 输出 |
|------|------|------|
| **Review** | 独立代码审查 | P1/P2 门控结果 |
| **Challenge** | 对抗性测试 | 破坏性测试报告 |
| **Consult** | 顾问咨询 | 建议性输出 |

## Review 模式（门控关键）

### 执行流程
```bash
codex review --diff HEAD~1
```

### 输出格式
```
[P1] CRITICAL: 安全漏洞在 auth.py
[P2] WARNING: 性能问题在 loop.py
[P3] INFO: 代码风格建议
```

### 门控逻辑（谨妃必须遵守）

```
[P1] 存在 → FAIL（阻止合并）
仅 [P2] 或无 → PASS（可合并）
```

**谨妃职责**：发现 [P1] 必须立即上报，不得放行。

## Challenge 模式

```bash
codex challenge --target ./src
```

对抗性测试：
- 边界条件测试
- 异常输入测试
- 并发压力测试
- 安全漏洞探测

输出：破坏性测试报告，列出所有发现的问题。

## Consult 模式

```bash
codex consult "如何优化这个查询性能？"
```

会话持续性：
- 支持多轮对话
- 上下文保持
- 建议性输出（非强制）

## JSONL 解析

Codex 输出为 JSONL 格式：
```jsonl
{"type":"P1","message":"...","file":"auth.py","line":42}
{"type":"P2","message":"...","file":"loop.py","line":15}
```

解析要点：
- `type` 字段区分 P1/P2/P3
- `file` + `line` 定位问题
- `message` 为问题描述

## Plan 文件审查

审查 plan.md 时：
```bash
codex review --plan ./plan.md
```

输出：
- 计划可行性评估
- 风险点标注
- 改进建议

## 常见用例

### 1. PR 审查门控
```
codex review --diff HEAD~1
→ 发现 [P1] → 上报 → 阻止合并
→ 仅 [P2] → PASS → 可合并
```

### 2. 安全审计
```
codex challenge --target ./auth
→ 破坏性测试 → 发现漏洞 → 上报
```

### 3. 性能咨询
```
codex consult "数据库查询慢"
→ 建议 → 评估 → 实施
```

## 禁止操作

- ❌ 禁止忽略 [P1] 问题放行
- ❌ 禁止自动执行 Codex 建议的代码修改（需用户确认）
- ❌ 禁止在无用户确认时执行 Challenge 模式

## 注意事项

- **Review 为强制门控**：PR 必须经过 Review
- **Challenge 为主动测试**：需用户授权执行
- **Consult 为顾问性质**：建议性，非强制
- **会话持续性**：Consult 模式支持多轮对话