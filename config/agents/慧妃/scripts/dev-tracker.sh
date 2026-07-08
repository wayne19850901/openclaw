#!/bin/bash
# 开发任务追踪脚本 - 慧妃
# 用法: ./dev-tracker.sh [status|create|close]

ACTION=${1:-status}
TASK_DIR="$HOME/.claw/agents/慧妃/memory/tasks"
mkdir -p "$TASK_DIR"

case $ACTION in
    status)
        echo "=== 开发任务状态 ==="
        echo ""
        echo "进行中:"
        grep -r "状态: 进行中" "$TASK_DIR" 2>/dev/null || echo "  无"
        echo ""
        echo "待处理:"
        grep -r "状态: 待处理" "$TASK_DIR" 2>/dev/null || echo "  无"
        ;;
    create)
        TASK_NAME=$2
        TASK_FILE="$TASK_DIR/${TASK_NAME}.md"
        cat > "$TASK_FILE" << 'EOF'
# 任务：{TASK_NAME}

**创建时间**：{DATE}
**状态**：待处理
**优先级**：P2

## 描述
{描述}

## 进度
- [ ] 分析需求
- [ ] 设计方案
- [ ] 开发实现
- [ ] 测试验证
- [ ] 上线部署

---
_慧妃 创建_
EOF
        sed -i '' "s/{TASK_NAME}/$TASK_NAME/g" "$TASK_FILE"
        sed -i '' "s/{DATE}/$(date "+%Y-%m-%d %H:%M")/g" "$TASK_FILE"
        echo "任务已创建: $TASK_FILE"
        ;;
    close)
        TASK_NAME=$2
        TASK_FILE="$TASK_DIR/${TASK_NAME}.md"
        if [ -f "$TASK_FILE" ]; then
            sed -i '' 's/状态: .*/状态: 已完成/' "$TASK_FILE"
            echo "任务已关闭: $TASK_FILE"
        else
            echo "任务不存在: $TASK_NAME"
        fi
        ;;
esac
