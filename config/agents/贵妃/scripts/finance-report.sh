#!/bin/bash
# 财务日报生成脚本 - 贵妃
# 用法: ./finance-report.sh [today|yesterday]

DATE=${1:-today}

if [ "$DATE" = "today" ]; then
    DATE_STR=$(date "+%Y-%m-%d")
else
    DATE_STR=$(date -v-1d "+%Y-%m-%d")
fi

REPORT_DIR="$HOME/.claw/agents/贵妃/memory/finance"
mkdir -p "$REPORT_DIR"

REPORT_FILE="$REPORT_DIR/daily-$DATE_STR.md"

cat > "$REPORT_FILE" << 'EOF'
## 尚融局日报 - {DATE}

### 今日业务
| 类型 | 数量 | 金额 |
|------|------|------|
| 新增贷款 | {N}笔 | {金额} |
| 审批通过 | {N}笔 | {金额} |
| 回款 | {N}笔 | {金额} |

### 风险预警
- 逾期预警：{N}笔
- 高风险客户：{N}个

### 资金概况
- 可用资金：{金额}
- 待放款：{金额}

### 明日计划
1. {计划1}

---
_贵妃 整理_
EOF

sed -i '' "s/{DATE}/$DATE_STR/g" "$REPORT_FILE"

echo "财务日报已生成: $REPORT_FILE"
