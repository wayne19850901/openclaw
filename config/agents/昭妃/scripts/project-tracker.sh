#!/bin/bash
# 项目进度追踪脚本 - 昭妃
# 用法: ./project-tracker.sh

DATE_STR=$(date "+%Y-%m-%d")
TRACKER_DIR="$HOME/.claw/agents/昭妃/memory/projects"
mkdir -p "$TRACKER_DIR"

echo "=== 项目进度概览 - $DATE_STR ==="
echo ""

# 遍历所有项目文件
for project in "$TRACKER_DIR"/*.md; do
    if [ -f "$project" ]; then
        name=$(basename "$project" .md)
        status=$(grep "状态:" "$project" | head -1)
        progress=$(grep "进度:" "$project" | head -1)
        echo "📁 $name"
        echo "   $status"
        echo "   $progress"
        echo ""
    fi
done

# 生成周报
WEEK=$(date "+%V")
WEEKLY_FILE="$TRACKER_DIR/weekly-W$WEEK.md"

cat > "$WEEKLY_FILE" << 'EOF'
## 项目进度周报 - 第{WEEK}周

| 项目 | 进度 | 状态 | 风险 |
|------|------|------|------|
| {项目1} | {百分比} | 🟢正常 | 无 |

### 关键里程碑
- {里程碑} - {日期}

### 需要协调
1. {问题描述}

---
_昭妃 整理_
EOF

sed -i '' "s/{WEEK}/$WEEK/g" "$WEEKLY_FILE"

echo "周报已生成: $WEEKLY_FILE"
