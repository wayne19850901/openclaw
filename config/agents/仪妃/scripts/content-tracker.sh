#!/bin/bash
# 内容发布追踪脚本 - 仪妃
# 用法: ./content-tracker.sh

DATE_STR=$(date "+%Y-%m-%d")
TRACKER_DIR="$HOME/.claw/agents/仪妃/memory/tracker"
mkdir -p "$TRACKER_DIR"

TRACKER_FILE="$TRACKER_DIR/content-$DATE_STR.md"

cat > "$TRACKER_FILE" << 'EOF'
## 内容发布记录 - {DATE}

### 今日发布
| 平台 | 内容 | 数据 |
|------|------|------|
| 小红书 | {标题} | 阅读{N} |
| 公众号 | {标题} | 阅读{N} |

### 数据亮点
- 爆款内容：{标题}
- 最佳平台：{平台}

### 待发布队列
1. {内容} - 预计{时间}

---
_仪妃 整理_
EOF

sed -i '' "s/{DATE}/$DATE_STR/g" "$TRACKER_FILE"

echo "内容追踪已生成: $TRACKER_FILE"
