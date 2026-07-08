#!/bin/bash
# Heartbeat Script - Bureau Level
# 局级心跳脚本
# 用法: ./heartbeat-bureau.sh <局名>

set -e

# 配置
BUREAU="${1:-尚工局}"
BUREAU_DIR="$HOME/.claw/agents/$BUREAU"
LEARNINGS_DIR="$BUREAU_DIR/.learnings"
HEARTBEAT_STATE="$LEARNINGS_DIR/heartbeat-state.md"
LOG_FILE="$LEARNINGS_DIR/heartbeat.log"

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1" | tee -a "$LOG_FILE"
}

success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1" | tee -a "$LOG_FILE"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1" | tee -a "$LOG_FILE"
}

# 检查目录是否存在
check_directory() {
    if [ ! -d "$LEARNINGS_DIR" ]; then
        error "学习目录不存在: $LEARNINGS_DIR"
        exit 1
    fi
}

# 检查待处理学习
check_pending_learnings() {
    log "检查待处理学习..."
    
    local pending_count=0
    if [ -f "$LEARNINGS_DIR/LEARNINGS.md" ]; then
        pending_count=$(grep -c "Status\*\*: pending" "$LEARNINGS_DIR/LEARNINGS.md" 2>/dev/null || echo "0")
    fi
    
    log "待处理学习数: $pending_count"
    echo "$pending_count"
}

# 检查重复学习
check_duplicate_patterns() {
    log "检查重复学习模式..."
    
    if [ ! -f "$LEARNINGS_DIR/LEARNINGS.md" ]; then
        log "无学习记录"
        return
    fi
    
    local duplicates=$(grep "Pattern-Key:" "$LEARNINGS_DIR/LEARNINGS.md" 2>/dev/null | sort | uniq -c | sort -rn | head -5)
    
    if [ -n "$duplicates" ]; then
        log "重复模式:"
        echo "$duplicates" | while read count pattern; do
            if [ "$count" -gt 1 ]; then
                warn "重复 $count 次: $pattern"
            fi
        done
    else
        log "无重复模式"
    fi
}

# 检查晋升候选
check_promotion_candidates() {
    log "检查晋升候选..."
    
    if [ ! -f "$LEARNINGS_DIR/LEARNINGS.md" ]; then
        log "无学习记录"
        return
    fi
    
    local candidates=$(grep -B5 "Recurrence-Count: [3-9]" "$LEARNINGS_DIR/LEARNINGS.md" 2>/dev/null | grep "^## \[" || true)
    
    if [ -n "$candidates" ]; then
        log "晋升候选:"
        echo "$candidates" | while read line; do
            success "$line"
        done
    else
        log "无晋升候选"
    fi
}

# 检查跨局学习
check_cross_bureau_items() {
    log "检查跨局学习..."
    
    if [ ! -f "$LEARNINGS_DIR/LEARNINGS.md" ]; then
        log "无学习记录"
        return
    fi
    
    local cross_items=$(grep "Cross-Bureau: true" "$LEARNINGS_DIR/LEARNINGS.md" 2>/dev/null || true)
    
    if [ -n "$cross_items" ]; then
        warn "发现跨局学习，需要上报 Queen"
        echo "$cross_items"
    else
        log "无跨局学习"
    fi
}

# 更新心跳状态
update_heartbeat_state() {
    local result="${1:-HEARTBEAT_OK}"
    local pending="${2:-0}"
    
    cat > "$HEARTBEAT_STATE" << EOF
last_heartbeat_started_at: $(date -Iseconds)
last_reviewed_change_at: $(date -Iseconds)
last_heartbeat_result: $result

pending_promotions: $pending
pending_resolutions: 0
cross_bureau_items: 0

## Last actions
- Heartbeat executed at $(date '+%Y-%m-%d %H:%M:%S')
- Result: $result
EOF
    
    log "心跳状态已更新"
}

# 主函数
main() {
    log "========================================="
    log "局级心跳启动: $BUREAU"
    log "========================================="
    
    check_directory
    
    local pending_count=$(check_pending_learnings)
    check_duplicate_patterns
    check_promotion_candidates
    check_cross_bureau_items
    
    # 判断心跳结果
    local result="HEARTBEAT_OK"
    if [ "$pending_count" -gt 10 ]; then
        result="HEARTBEAT_WARNING"
        warn "待处理学习过多: $pending_count"
    fi
    
    update_heartbeat_state "$result" "$pending_count"
    
    log "========================================="
    log "局级心跳完成: $BUREAU"
    log "========================================="
    
    if [ "$result" = "HEARTBEAT_OK" ]; then
        success "心跳正常"
    else
        warn "心跳异常，请检查"
    fi
}

# 执行
main
