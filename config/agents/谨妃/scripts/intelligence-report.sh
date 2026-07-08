#!/bin/bash
# 情报奏折生成脚本 - 谨妃
# 用法: ./intelligence-report.sh [morning|evening]

TIME=${1:-morning}
DATE_STR=$(date "+%Y-%m-%d")
TIME_STR=$(date "+%H:%M")

REPORT_DIR="$HOME/.claw/agents/谨妃/memory/intelligence"
mkdir -p "$REPORT_DIR"

if [ "$TIME" = "morning" ]; then
    REPORT_FILE="$REPORT_DIR/morning-$DATE_STR.md"
    TITLE="早间情报奏折"
else
    REPORT_FILE="$REPORT_DIR/evening-$DATE_STR.md"
    TITLE="晚间情报奏折"
fi

cat > "$REPORT_FILE" << 'EOF'
## {TITLE} - {DATE} {TIME}

### 金融领域
- {情报1}
- {情报2}

### 科技领域
- {情报1}
- {情报2}

### 媒体领域
- {情报1}
- {情报2}

### 教育领域
- {情报1}
- {情报2}

### 重点关注
1. {重点事项}

---
_谨妃 呈报_
EOF

sed -i '' "s/{TITLE}/$TITLE/g" "$REPORT_FILE"
sed -i '' "s/{DATE}/$DATE_STR/g" "$REPORT_FILE"
sed -i '' "s/{TIME}/$TIME_STR/g" "$REPORT_FILE"

echo "情报奏折已生成: $REPORT_FILE"
