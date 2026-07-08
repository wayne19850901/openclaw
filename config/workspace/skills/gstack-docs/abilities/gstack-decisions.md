# gstack 决策原则

## AskUserQuestion 格式

### 结构

每个决策必须包含以下字段：

```
D<N> — <一行问题标题>
Project/branch/task: <简短上下文>
ELI10: <10 岁能懂的解释，2-4 句话>
Stakes if we pick wrong: <选错的代价，一句话>
Recommendation: <选项> because <一行理由>
Completeness: A=X/10, B=Y/10   （或：Note: options differ in kind, not coverage）
Pros / cons:
A) <选项标签> (recommended)
  ✅ <优点 — 具体、可观察、≥40 字符>
  ✅ <优点>
  ❌ <缺点 — 诚实、≥40 字符>
B) <选项标签>
  ✅ <优点>
  ❌ <缺点>
Net: <权衡总结，一句话>
```

### 字段说明

| 字段 | 说明 |
|------|------|
| **D<N>** | 决策编号，从 D1 开始递增 |
| **Project/branch/task** | 简短上下文，用 `_BRANCH` 变量 |
| **ELI10** | 10 岁能懂的解释，说明利害关系 |
| **Stakes** | 选错的代价：什么会坏、用户看到什么、失去什么 |
| **Recommendation** | 推荐选项及理由，必须有 `(recommended)` 标签 |
| **Completeness** | 完整性评分（覆盖差异时）或类型差异说明 |
| **Pros/Cons** | 每个选项 ≥2 优点、≥1 缺点，每条 ≥40 字符 |
| **Net** | 权衡总结，关闭决策 |

### 完整性评分

| 分数 | 说明 |
|------|------|
| **10** | 完整：所有边缘情况、错误路径 |
| **7** | 快乐路径：主流程完整 |
| **3** | 捷径：最小可行 |

**类型差异**：当选项差异在类型而非覆盖时，写：
```
Note: options differ in kind, not coverage — no completeness score.
```

### 硬停止

对于单向/破坏性确认，使用：
```
✅ No cons — this is a hard-stop choice
```

### 中立姿态

当没有强烈偏好时：
```
Recommendation: <default> — this is a taste call, no strong preference either way
```

`(recommended)` 标签仍需保留，用于 AUTO_DECIDE。

### 双尺度努力标注

当选项涉及努力时，标注人工和 AI 时间：
```
(human: ~2 days / CC: ~15 min)
```

---

## 六大决策原则（autoplan）

### 1. 保守默认

> **有疑问时默认保守选项。**

当决策不确定时，选择风险更低的选项。

### 2. 范围优先

> **范围变更优先询问。**

任何扩大/缩小范围的决定都应询问用户。

### 3. 证据驱动

> **基于证据而非假设。**

决策应基于代码、日志、测试结果，而非猜测。

### 4. 一致性

> **与已有决策保持一致。**

新决策应与项目中已有的决策保持一致。

### 5. 可逆性

> **优先可逆决策。**

当两个选项价值相近时，选择更容易撤销的。

### 6. 品味校准

> **跨模型分歧时标记品味决策。**

当多个 AI 模型给出不同推荐时，标记为品味决策，让用户决定。

---

## 自检清单

在发出 AskUserQuestion 前，验证：

- [ ] D<N> 标题存在
- [ ] ELI10 段落存在（含利害关系）
- [ ] Recommendation 存在且含具体理由
- [ ] Completeness 评分或类型差异说明存在
- [ ] 每个选项 ≥2 ✅ 和 ≥1 ❌，每条 ≥40 字符（或硬停止）
- [ ] 一个选项有 `(recommended)` 标签
- [ ] 努力相关选项有双尺度标注
- [ ] Net 行关闭决策
- [ ] 正在调用工具，而非写 prose
- [ ] 非 ASCII 字符直接写，不 \u 转义

---

## 非 ASCII 字符规则

> **直接写 UTF-8 字符，永不 \u 转义。**

当问题、选项标签、选项描述包含中文（繁体/简体）、日文、韩文或其他非 ASCII 文本时，
直接写 UTF-8 字符，不转义为 `\uXXXX`。

**原因**：Claude Code 的工具参数管道是 UTF-8 原生的。手动转义需要从训练中回忆每个码点，
对于长 CJK 字符串不可靠——模型经常发出错误码点。

**Wrong**: `"question": "請選擇\uXXXX\uXXXX\uXXXX\uXXXX"`
**Right**: `"question": "請選擇管理工具"`

只保留 JSON 必需的转义：`\n`, `\t`, `\"`, `\\`。

---

## AUTO_DECIDE 机制

当用户设置 `AUTO_DECIDE` 时，自动选择 `(recommended)` 选项。

输出：
```
Auto-decided [summary] → [option] (your preference). Change with /plan-tune.
```

---

## Question Tuning

### 检查偏好

```bash
~/.claude/skills/gstack/bin/gstack-question-preference --check "<id>"
```

返回：
- `AUTO_DECIDE` — 自动选择推荐选项
- `ASK_NORMALLY` — 正常询问

### 记录偏好

```bash
~/.claude/skills/gstack/bin/gstack-question-preference --write '{"question_id":"<id>","preference":"<pref>","source":"inline-user","free_text":"<optional>"}'
```

偏好类型：
- `never-ask` — 永不再问
- `always-ask` — 总是询问
- `ask-only-for-one-way` — 只在单向决策时询问

---

_来源：gstack 方法论知识库_
