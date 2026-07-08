# Self-Improving Memory Index

**版本**: v1.0
**创建时间**: 2026-05-24
**维护者**: Queen 👑

---

## 一、全局记忆（HOT）

| 文件 | 行数 | 最后更新 | 说明 |
|------|------|----------|------|
| memory.md | 0 | - | 确认的偏好和规则 |
| corrections.md | 0 | - | 纠正日志 |
| heartbeat-state.md | 4 | 2026-05-24 | 心跳状态 |

---

## 二、局级记忆（WARM）

### 尚工局 💻

| 文件 | 行数 | 最后更新 | 说明 |
|------|------|----------|------|
| .learnings/LEARNINGS.md | 0 | - | 学习日志 |
| .learnings/ERRORS.md | 0 | - | 错误记录 |
| .learnings/FEATURE_REQUESTS.md | 0 | - | 功能请求 |
| .learnings/SELF-IMPROVING.md | 89 | 2026-05-24 | 学习机制 |

### 尚融局 💰

| 文件 | 行数 | 最后更新 | 说明 |
|------|------|----------|------|
| .learnings/LEARNINGS.md | 0 | - | 学习日志 |
| .learnings/ERRORS.md | 0 | - | 错误记录 |
| .learnings/FEATURE_REQUESTS.md | 0 | - | 功能请求 |
| .learnings/SELF-IMPROVING.md | 58 | 2026-05-24 | 学习机制 |

### 尚宣局 🎨

| 文件 | 行数 | 最后更新 | 说明 |
|------|------|----------|------|
| .learnings/LEARNINGS.md | 0 | - | 学习日志 |
| .learnings/ERRORS.md | 0 | - | 错误记录 |
| .learnings/FEATURE_REQUESTS.md | 0 | - | 功能请求 |
| .learnings/SELF-IMPROVING.md | 58 | 2026-05-24 | 学习机制 |

### 尚教局 💫

| 文件 | 行数 | 最后更新 | 说明 |
|------|------|----------|------|
| .learnings/LEARNINGS.md | 0 | - | 学习日志 |
| .learnings/ERRORS.md | 0 | - | 错误记录 |
| .learnings/FEATURE_REQUESTS.md | 0 | - | 功能请求 |
| .learnings/SELF-IMPROVING.md | 43 | 2026-05-24 | 学习机制 |

### 尚机局 🔍

| 文件 | 行数 | 最后更新 | 说明 |
|------|------|----------|------|
| .learnings/LEARNINGS.md | 0 | - | 学习日志 |
| .learnings/ERRORS.md | 0 | - | 错误记录 |
| .learnings/FEATURE_REQUESTS.md | 0 | - | 功能请求 |
| .learnings/SELF-IMPROVING.md | 43 | 2026-05-24 | 学习机制 |

### 尚宫局 ⚖️

| 文件 | 行数 | 最后更新 | 说明 |
|------|------|----------|------|
| .learnings/LEARNINGS.md | 0 | - | 学习日志 |
| .learnings/ERRORS.md | 0 | - | 错误记录 |
| .learnings/FEATURE_REQUESTS.md | 0 | - | 功能请求 |
| .learnings/SELF-IMPROVING.md | 52 | 2026-05-24 | 学习机制 |

### 御鉴司 ⚖️

| 文件 | 行数 | 最后更新 | 说明 |
|------|------|----------|------|
| .learnings/LEARNINGS.md | 0 | - | 学习日志 |
| .learnings/ERRORS.md | 0 | - | 错误记录 |
| .learnings/FEATURE_REQUESTS.md | 0 | - | 功能请求 |
| .learnings/SELF-IMPROVING.md | 68 | 2026-05-24 | 学习机制 |

---

## 三、妃子级记忆（WARM）

| 妃子 | 文件 | 行数 | 最后更新 |
|------|------|------|----------|
| 贵妃 💰 | .learnings/SELF-IMPROVING.md | 43 | 2026-05-24 |
| 慧妃 💎 | .learnings/SELF-IMPROVING.md | 43 | 2026-05-24 |
| 仪妃 🎨 | .learnings/SELF-IMPROVING.md | 43 | 2026-05-24 |
| 令妃 💫 | .learnings/SELF-IMPROVING.md | 43 | 2026-05-24 |
| 谨妃 🔍 | .learnings/SELF-IMPROVING.md | 43 | 2026-05-24 |
| 昭妃 ⚖️ | .learnings/SELF-IMPROVING.md | 43 | 2026-05-24 |

---

## 四、归档记忆（COLD）

| 文件 | 归档日期 | 原因 |
|------|----------|------|
| - | - | - |

---

## 五、统计

```
📊 Self-Improving Memory

🔥 HOT (always loaded):
   memory.md: 0 entries

🌡️ WARM (load on demand):
   局级: 7 bureaus × 4 files = 28 files
   妃子级: 6 feizi × 4 files = 24 files

❄️ COLD (archived):
   archive/: 0 files

⚙️ Mode: Passive

📈 Recent activity (7 days):
   Corrections logged: 3
   Promotions to HOT: 0
   Demotions to WARM: 0
```

---

## 六、快速查询

### 查看所有待处理学习

```bash
grep -rh "Status\*\*: pending" ~/.claw/agents/*/.learnings/*.md 2>/dev/null
```

### 查看晋升候选

```bash
grep -rh "Recurrence-Count: [3-9]" ~/.claw/agents/*/.learnings/*.md 2>/dev/null
```

### 查看跨局学习

```bash
grep -rh "Cross-Bureau: true" ~/.claw/agents/*/.learnings/*.md 2>/dev/null
```

---

_配置者：Queen 👑_
_更新时间：2026-05-24_
