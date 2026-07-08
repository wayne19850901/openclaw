# codex — Codex 多模式第二意见

## 触发词
- "codex review"、"代码审查"、"第二意见"
- "codex challenge"、"challenge"
- "consult codex"、"ask codex"

## 核心功能
OpenAI Codex CLI wrapper，三种模式：
- **Review** — 独立 diff review，P1/P2 gate
- **Challenge** — 对抗模式，尝试破坏代码
- **Consult** — 任意问题，session 持续

## 执行流程

### Review 模式
```
1. 检测平台和 base branch
2. 运行 codex review --base <branch>
3. 解析输出，判断 gate（PASS/FAIL）
4. 输出完整结果 + Recommendation
```

### Challenge 模式
```
1. 构建对抗 prompt（含 filesystem boundary）
2. 运行 codex exec --json
3. 解析 JSONL，提取 reasoning traces
4. 输出完整结果 + Recommendation
```

### Consult 模式
```
1. 检查现有 session（.context/codex-session-id）
2. 询问继续或新建
3. 运行 codex exec --json
4. 保存 session ID
5. 输出完整结果 + Recommendation
```

## 输出格式

```
CODEX SAYS (<mode>):
════════════════════════════════════════════════════════════
<完整输出，不截断>
════════════════════════════════════════════════════════════
GATE: PASS/FAIL    Tokens: N | Est. cost: ~$X.XX
Recommendation: <action> because <reason>
```

## Gate 逻辑
- 输出含 `[P1]` → FAIL（必须修复）
- 仅 `[P2]` 或无 → PASS

## 禁令
- ❌ 禁止在 P1 gate 失败时强制通过
- ❌ 禁止在 Challenge 模式泄露敏感信息
- ❌ 禁止将 codex 输出作为最终决策

## 中度映射
实际执行时加载：`~/.claude/skills/gstack/codex/SKILL.md`