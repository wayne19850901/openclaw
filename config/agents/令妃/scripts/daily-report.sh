#!/bin/bash
# 汇报生成脚本 - 令妃
# 用法: ./daily-report.sh [today|yesterday]

DATE=${1:-today}

if [ "$DATE" = "today" ]; then
    DATE_STR=$(date "+%Y-%m-%d")
else
    DATE_STR=$(date -v-1d "+%Y-%m-%d")
fi

REPORT_DIR="$HOME/.claw/agents/令妃/memory/reports"
mkdir -p "$REPORT_DIR"

REPORT_FILE="$REPORT_DIR/daily-$DATE_STR.md"

cat > "$REPORT_FILE" << 'EOF'
## 尚教局日报 - {DATE}

### 今日完成
1. {事项1}
2. {事项2}

### 进行中
1. {事项} - 进度{百分比}

### 需要协调
1. {问题描述}

### 明日计划
1. {计划1}

---
_令妃 整理_
EOF

# 替换日期
sed -i '' "s/{DATE}/$DATE_STR/g" "$REPORT_FILE"

echo "日报已生成: $REPORT_FILE"
