# 状态管理使用指南

> 跨会话持续诊断 — 支持长期任务跟踪

**创建时间**：2026-06-01
**维护者**：Queen 👑

---

## 一、系统定位

**来源**：dbskill v2.12.0

**核心价值**：
- 支持跨会话的持续诊断
- 保存工作状态，下次继续
- 合并多次诊断结果

**适用场景**：
- 长期项目（需要多次会话）
- 复杂诊断（需要多轮分析）
- 持续跟踪（需要观察变化）

---

## 二、目录结构

```
agents/{Agent名}/state/
├── snapshots/               # 快照存储
│   └── 2026-06-01_150000.json
│
├── current.json             # 当前状态
└── history.jsonl           # 历史记录
```

---

## 三、状态快照结构

### 3.1 快照 JSON 格式

```json
{
  "id": "20260601_150000",
  "timestamp": "2026-06-01T15:00:00+08:00",
  "agent": "贵妃",
  "task": "贷款产品优化",
  "progress": "诊断阶段",
  "phase": 1,
  "total_phases": 3,
  "findings": [
    "发现1：定价偏高",
    "发现2：竞品申请量更高"
  ],
  "next_steps": [
    "下一步1：收集更多竞品数据",
    "下一步2：分析用户价格敏感度"
  ],
  "context": {
    "user_goal": "提升申请量 30%",
    "constraints": ["不影响利润率"],
    "deadline": "2026-06-15"
  },
  "metadata": {
    "session_id": "abc123",
    "conversation_turn": 5,
    "token_usage": 3500
  }
}
```

### 3.2 字段说明

| 字段 | 必填 | 说明 |
|------|:---:|------|
| `id` | ✅ | 快照 ID（时间戳） |
| `timestamp` | ✅ | ISO 8601 时间戳 |
| `agent` | ✅ | Agent 名称 |
| `task` | ✅ | 任务名称 |
| `progress` | ✅ | 当前进度描述 |
| `phase` | ✅ | 当前阶段编号 |
| `total_phases` | ✅ | 总阶段数 |
| `findings` | ✅ | 已发现的问题 |
| `next_steps` | ✅ | 下一步行动 |
| `context` | ❌ | 上下文信息 |
| `metadata` | ❌ | 元数据 |

---

## 四、状态管理脚本

### 4.1 保存状态（save-state.sh）

```bash
#!/bin/bash
# 用法：./save-state.sh <agent> <task> <progress> <findings> <next_steps>

AGENT=$1
TASK=$2
PROGRESS=$3
FINDINGS=$4
NEXT_STEPS=$5

TIMESTAMP=$(date +"%Y-%m-%dT%H:%M:%S+08:00")
ID=$(date +"%Y%m%d_%H%M%S")
STATE_DIR=~/.claw/agents/$AGENT/state

# 创建快照
cat > $STATE_DIR/snapshots/$ID.json << EOF
{
  "id": "$ID",
  "timestamp": "$TIMESTAMP",
  "agent": "$AGENT",
  "task": "$TASK",
  "progress": "$PROGRESS",
  "phase": 1,
  "total_phases": 3,
  "findings": $(echo $FINDINGS | jq -R 'split(",")'),
  "next_steps": $(echo $NEXT_STEPS | jq -R 'split(",")'),
  "context": {},
  "metadata": {}
}
EOF

# 更新当前状态
cp $STATE_DIR/snapshots/$ID.json $STATE_DIR/current.json

# 追加到历史记录
echo "{\"timestamp\":\"$TIMESTAMP\",\"action\":\"save\",\"id\":\"$ID\"}" >> $STATE_DIR/history.jsonl

echo "状态已保存：$ID"
```

### 4.2 恢复状态（restore-state.sh）

```bash
#!/bin/bash
# 用法：./restore-state.sh <agent> [snapshot_id]

AGENT=$1
SNAPSHOT_ID=$2
STATE_DIR=~/.claw/agents/$AGENT/state

if [ -z "$SNAPSHOT_ID" ]; then
  # 恢复最新快照
  LATEST=$(ls -t $STATE_DIR/snapshots/*.json 2>/dev/null | head -1)
  if [ -z "$LATEST" ]; then
    echo "无快照可恢复"
    exit 1
  fi
  SNAPSHOT_ID=$(basename $LATEST .json)
fi

SNAPSHOT_FILE=$STATE_DIR/snapshots/$SNAPSHOT_ID.json

if [ ! -f "$SNAPSHOT_FILE" ]; then
  echo "快照不存在：$SNAPSHOT_ID"
  exit 1
fi

# 恢复状态
cp $SNAPSHOT_FILE $STATE_DIR/current.json

# 记录恢复操作
TIMESTAMP=$(date +"%Y-%m-%dT%H:%M:%S+08:00")
echo "{\"timestamp\":\"$TIMESTAMP\",\"action\":\"restore\",\"id\":\"$SNAPSHOT_ID\"}" >> $STATE_DIR/history.jsonl

echo "状态已恢复：$SNAPSHOT_ID"
cat $STATE_DIR/current.json | jq .
```

### 4.3 生成报告（report-state.sh）

```bash
#!/bin/bash
# 用法：./report-state.sh <agent>

AGENT=$1
STATE_DIR=~/.claw/agents/$AGENT/state

echo "# $AGENT 状态报告"
echo ""
echo "**生成时间**：$(date +"%Y-%m-%d %H:%M:%S")"
echo ""

# 统计快照数量
SNAPSHOT_COUNT=$(ls $STATE_DIR/snapshots/*.json 2>/dev/null | wc -l)
echo "## 快照统计"
echo "- 快照总数：$SNAPSHOT_COUNT"
echo ""

# 当前状态
if [ -f "$STATE_DIR/current.json" ]; then
  echo "## 当前状态"
  cat $STATE_DIR/current.json | jq '{
    task: .task,
    progress: .progress,
    findings: .findings,
    next_steps: .next_steps
  }'
  echo ""
fi

# 历史记录
if [ -f "$STATE_DIR/history.jsonl" ]; then
  echo "## 最近操作"
  tail -5 $STATE_DIR/history.jsonl | jq -c '{timestamp: .timestamp, action: .action, id: .id}'
fi
```

---

## 五、使用流程

### 5.1 保存状态流程

```
诊断开始 → 多轮对话 → 发现需要暂停
                ↓
        执行 save-state.sh
                ↓
        生成快照文件
                ↓
        更新 current.json
                ↓
        追加到 history.jsonl
```

### 5.2 恢复状态流程

```
下次会话 → 执行 restore-state.sh
                ↓
        读取快照文件
                ↓
        恢复 current.json
                ↓
        继续诊断
```

### 5.3 生成报告流程

```
攒够几次 → 执行 report-state.sh
                ↓
        统计快照数量
                ↓
        显示当前状态
                ↓
        显示最近操作
                ↓
        合并诊断结果
```

---

## 六、与 dbskill 的对应关系

| dbskill 命令 | OpenClaw 实现 |
|--------------|---------------|
| `/dbs-save` | `save-state.sh` |
| `/dbs-restore` | `restore-state.sh` |
| `/dbs-report` | `report-state.sh` |

---

## 七、Agent 集成

### 7.1 在 AGENT.md 中添加

```markdown
## 状态管理

### 保存状态时机
- 会话结束前
- 发现需要暂停时
- 完成重要阶段时

### 恢复状态时机
- 会话开始时
- 用户说"继续"、"上次"时

### 执行命令
- 保存：`./scripts/save-state.sh`
- 恢复：`./scripts/restore-state.sh`
- 报告：`./scripts/report-state.sh`
```

### 7.2 在 scripts/ 目录添加脚本

将上述脚本复制到 `agents/{Agent名}/scripts/` 目录。

---

## 八、示例场景

### 8.1 长期项目

**场景**：贷款产品优化（需要 2 周时间）

**流程**：
```
第1天 → 诊断开始 → save-state.sh
第3天 → 继续诊断 → restore-state.sh → save-state.sh
第5天 → 继续诊断 → restore-state.sh → save-state.sh
第7天 → 生成报告 → report-state.sh
```

### 8.2 复杂诊断

**场景**：商业模式分析（需要多轮对话）

**流程**：
```
第1轮 → 收集事实 → save-state.sh
第2轮 → 提炼规律 → restore-state.sh → save-state.sh
第3轮 → 做出决策 → restore-state.sh → save-state.sh
第4轮 → 生成报告 → report-state.sh
```

---

## 九、维护规则

### 9.1 定期清理

Queen 每月清理：
- 删除超过 30 天的快照
- 合并历史记录
- 归档已完成任务

### 9.2 备份策略

重要任务快照：
- 复制到 `workspace/state-archive/`
- 添加备注说明

---

_维护者：Queen 👑_
_创建时间：2026-06-01_
