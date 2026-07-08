# Global Heartbeat Rules - OpenClaw Self-Improving

**版本**: v1.0
**创建时间**: 2026-05-24
**维护者**: Queen 👑

---

## 一、心跳频率

| 层级 | 频率 | 执行者 |
|------|------|--------|
| 局级 | 每周（周日） | 各局尚座 |
| 妃子级 | 每两周 | 各妃子 |
| 全局 | 每月（1日） | Queen |
| 晋升检查 | 每季度 | Queen + 御鉴司 |

---

## 二、心跳任务

### 2.1 局级心跳（每周）

```bash
# 1. 检查待处理学习
grep -h "Status\*\*: pending" .learnings/*.md | wc -l

# 2. 检查重复学习
grep -h "Pattern-Key:" .learnings/LEARNINGS.md | sort | uniq -c | sort -rn | head -5

# 3. 检查晋升候选
grep -h "Recurrence-Count: [3-9]" .learnings/LEARNINGS.md

# 4. 更新心跳状态
echo "last_heartbeat_started_at: $(date -Iseconds)" > .learnings/heartbeat-state.md
```

### 2.2 全局心跳（每月）

```bash
# 1. 汇总各局学习状态
for bureau in 尚工局 尚融局 尚宣局 尚教局 尚机局 尚宫局 御鉴司; do
  echo "=== $bureau ==="
  grep -h "Status\*\*: pending" ~/.claw/agents/$bureau/.learnings/*.md 2>/dev/null | wc -l
done

# 2. 检查跨局学习
grep -rh "Cross-Bureau: true" ~/.claw/agents/*/. learnings/*.md 2>/dev/null

# 3. 检查晋升候选
grep -rh "Recurrence-Count: [3-9]" ~/.claw/agents/*/. learnings/*.md 2>/dev/null

# 4. 更新全局心跳状态
echo "last_global_heartbeat: $(date -Iseconds)" > ~/self-improving/heartbeat-state.md
```

---

## 三、晋升流程

### 3.1 局级 → 全局

**条件**:
- `Recurrence-Count >= 3`
- `Cross-Bureau: true` 或适用范围跨局
- 最近30天内有效

**流程**:
1. 尚座提交晋升申请（标记 `Promotion-Pending: true`）
2. Queen 审查
3. 御鉴司合规审查
4. 通过后复制到 `~/self-improving/memory.md`

### 3.2 全局 → OpenClaw 规则

**条件**:
- 在全局记忆中稳定30天
- 确认为系统级规则
- 无合规问题

**流程**:
1. Queen 提议晋升
2. 御鉴司审查
3. 威帝确认
4. 更新对应规则文件

---

## 四、降级流程

### 4.1 降级条件

| 条件 | 操作 |
|------|------|
| 30天未使用 | 降级到 WARM |
| 90天未使用 | 归档到 COLD |
| 规则冲突 | 标记待确认 |

### 4.2 降级流程

```bash
# 检查未使用学习
find ~/self-improving -name "*.md" -mtime +30 -exec grep -l "Last-Used" {} \;

# 归档
mv ~/self-improving/domains/old-pattern.md ~/self-improving/archive/
```

---

## 五、心跳状态文件

### 5.1 局级心跳状态

位置: `~/.claw/agents/<局名>/.learnings/heartbeat-state.md`

```yaml
last_heartbeat_started_at: 2026-05-24T23:47:00+08:00
last_reviewed_change_at: 2026-05-24T23:47:00+08:00
last_heartbeat_result: HEARTBEAT_OK

pending_promotions: 0
pending_resolutions: 0
cross_bureau_items: 0
```

### 5.2 全局心跳状态

位置: `~/self-improving/heartbeat-state.md`

```yaml
last_global_heartbeat: 2026-05-01T00:00:00+08:00
last_promotion_review: 2026-05-01T00:00:00+08:00
last_archive_run: 2026-04-01T00:00:00+08:00

bureaus_with_pending_items:
  - 尚工局: 3
  - 尚融局: 1
  - 御鉴司: 0

global_promotions_pending: 2
global_archive_count: 5
```

---

## 六、异常处理

### 6.1 心跳失败

如果心跳任务失败：
1. 记录错误到 `ERRORS.md`
2. 标记 `Heartbeat-Status: failed`
3. 下次心跳时重试

### 6.2 晋升冲突

如果晋升候选与现有规则冲突：
1. 标记 `Promotion-Conflict: true`
2. Queen 协调解决
3. 御鉴司审查

---

_配置者：Queen 👑_
_更新时间：2026-05-24_
