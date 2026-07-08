#!/bin/bash
# Heartbeat Scheduler
# 心跳调度器
# 用法: ./heartbeat-scheduler.sh [schedule|status|run]

set -e

# 配置
SCRIPTS_DIR="$HOME/CodeBuddy/Claw/scripts"
GLOBAL_DIR="$HOME/self-improving"
LOG_FILE="$GLOBAL_DIR/scheduler.log"
BUREAUS=("尚工局" "尚融局" "尚宣局" "尚教局" "尚机局" "尚宫局" "御鉴司")

# 颜色输出
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

info() {
    echo -e "${BLUE}[INFO]${NC} $1" | tee -a "$LOG_FILE"
}

success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1" | tee -a "$LOG_FILE"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1" | tee -a "$LOG_FILE"
}

# 显示帮助
show_help() {
    cat << EOF
心跳调度器 - OpenClaw Self-Improving 系统

用法:
  $0 schedule  - 设置 cron 定时任务
  $0 status    - 查看定时任务状态
  $0 run       - 手动执行心跳
  $0 help      - 显示帮助信息

定时任务说明:
  - 局级心跳: 每周日 23:00
  - 全局心跳: 每月 1 日 00:00
  - 晋升检查: 每季度首日 01:00

示例:
  $0 schedule  # 设置定时任务
  $0 run       # 手动执行一次全局心跳
EOF
}

# 设置 cron 定时任务
setup_cron() {
    log "设置 cron 定时任务..."
    
    # 创建临时 cron 文件
    local cron_file="/tmp/openclaw-cron-$$.txt"
    crontab -l > "$cron_file" 2>/dev/null || true
    
    # 添加局级心跳（每周日 23:00）
    for bureau in "${BUREAUS[@]}"; do
        local entry="0 23 * * 0 $SCRIPTS_DIR/heartbeat-bureau.sh $bureau >> $GLOBAL_DIR/logs/bureau-$bureau.log 2>&1"
        if ! grep -q "$entry" "$cron_file" 2>/dev/null; then
            echo "$entry" >> "$cron_file"
            info "添加局级心跳: $bureau (每周日 23:00)"
        fi
    done
    
    # 添加全局心跳（每月 1 日 00:00）
    local global_entry="0 0 1 * * $SCRIPTS_DIR/heartbeat-global.sh >> $GLOBAL_DIR/logs/global.log 2>&1"
    if ! grep -q "$global_entry" "$cron_file" 2>/dev/null; then
        echo "$global_entry" >> "$cron_file"
        info "添加全局心跳 (每月 1 日 00:00)"
    fi
    
    # 添加晋升检查（每季度首日 01:00）
    local promotion_entry="0 1 1 1,4,7,10 * $SCRIPTS_DIR/promotion-check.sh >> $GLOBAL_DIR/logs/promotion.log 2>&1"
    if ! grep -q "$promotion_entry" "$cron_file" 2>/dev/null; then
        echo "$promotion_entry" >> "$cron_file"
        info "添加晋升检查 (每季度首日 01:00)"
    fi
    
    # 安装新的 cron
    crontab "$cron_file"
    rm -f "$cron_file"
    
    success "定时任务设置完成"
}

# 查看定时任务状态
show_status() {
    log "查看定时任务状态..."
    
    echo ""
    echo "当前 cron 定时任务:"
    echo "==================="
    crontab -l 2>/dev/null | grep -E "heartbeat|promotion" || echo "无相关定时任务"
    echo ""
    
    # 检查上次执行时间
    echo "上次执行时间:"
    echo "============="
    
    for bureau in "${BUREAUS[@]}"; do
        local state_file="$HOME/.claw/agents/$bureau/.learnings/heartbeat-state.md"
        if [ -f "$state_file" ]; then
            local last_run=$(grep "last_heartbeat_started_at:" "$state_file" | awk '{print $2}' || echo "never")
            echo "$bureau: $last_run"
        else
            echo "$bureau: never"
        fi
    done
    
    echo ""
    
    local global_state="$GLOBAL_DIR/heartbeat-state.md"
    if [ -f "$global_state" ]; then
        local last_global=$(grep "last_global_heartbeat:" "$global_state" | awk '{print $2}' || echo "never")
        echo "全局心跳: $last_global"
    else
        echo "全局心跳: never"
    fi
    
    echo ""
}

# 手动执行心跳
run_heartbeat() {
    local type="${1:-global}"
    
    log "手动执行心跳: $type"
    
    case "$type" in
        "global")
            bash "$SCRIPTS_DIR/heartbeat-global.sh"
            ;;
        "promotion")
            bash "$SCRIPTS_DIR/promotion-check.sh"
            ;;
        *)
            # 执行指定局的心跳
            if [[ " ${BUREAUS[@]} " =~ " $type " ]]; then
                bash "$SCRIPTS_DIR/heartbeat-bureau.sh" "$type"
            else
                warn "未知的局名: $type"
                echo "可用的局: ${BUREAUS[@]}"
                exit 1
            fi
            ;;
    esac
}

# 主函数
main() {
    local command="${1:-help}"
    
    # 创建日志目录
    mkdir -p "$GLOBAL_DIR/logs"
    
    case "$command" in
        "schedule")
            setup_cron
            ;;
        "status")
            show_status
            ;;
        "run")
            run_heartbeat "${2:-global}"
            ;;
        "help"|*)
            show_help
            ;;
    esac
}

# 执行
main "$@"
