#!/bin/bash
# Heartbeat Script - Global Level
# 全局心跳脚本
# 用法: ./heartbeat-global.sh

set -e

# 配置
GLOBAL_DIR="$HOME/self-improving"
HEARTBEAT_STATE="$GLOBAL_DIR/heartbeat-state.md"
LOG_FILE="$GLOBAL_DIR/heartbeat.log"
BUREAUS=("尚工局" "尚融局" "尚宣局" "尚教局" "尚机局" "尚宫局" "御鉴司")

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

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

info() {
    echo -e "${BLUE}[INFO]${NC} $1" | tee -a "$LOG_FILE"
}

# 汇总各局学习状态
aggregate_bureau_status() {
    log "汇总各局学习状态..."
    
    local total_pending=0
    local bureau_status=""
    
    for bureau in "${BUREAUS[@]}"; do
        local learnings_dir="$HOME/.claw/agents/$bureau/.learnings"
        if [ -f "$learnings_dir/LEARNINGS.md" ]; then
            local count=$(grep -c "Status\*\*: pending" "$learnings_dir/LEARNINGS.md" 2>/dev/null || echo "0")
            total_pending=$((total_pending + count))
            bureau_status="$bureau_status$bureau: $count\n"
            info "$bureau: $count 个待处理学习"
        fi
    done
    
    log "总待处理学习: $total_pending"
    echo -e "$bureau_status"
}

# 检查跨局学习
check_cross_bureau_items() {
    log "检查跨局学习..."
    
    local cross_items=""
    for bureau in "${BUREAUS[@]}"; do
        local learnings_dir="$HOME/.claw/agents/$bureau/.learnings"
        if [ -f "$learnings_dir/LEARNINGS.md" ]; then
            local items=$(grep -B10 "Cross-Bureau: true" "$learnings_dir/LEARNINGS.md" 2>/dev/null | grep "^## \[" || true)
            if [ -n "$items" ]; then
                cross_items="$cross_items$bureau:\n$items\n\n"
            fi
        fi
    done
    
    if [ -n "$cross_items" ]; then
        warn "发现跨局学习，需要协调处理:"
        echo -e "$cross_items"
    else
        log "无跨局学习"
    fi
}

# 检查全局晋升候选
check_global_promotion_candidates() {
    log "检查全局晋升候选..."
    
    local candidates=""
    for bureau in "${BUREAUS[@]}"; do
        local learnings_dir="$HOME/.claw/agents/$bureau/.learnings"
        if [ -f "$learnings_dir/LEARNINGS.md" ]; then
            local items=$(grep -B5 "Recurrence-Count: [3-9]" "$learnings_dir/LEARNINGS.md" 2>/dev/null | grep "^## \[" || true)
            if [ -n "$items" ]; then
                candidates="$candidates$bureau:\n$items\n\n"
            fi
        fi
    done
    
    if [ -n "$candidates" ]; then
        success "发现晋升候选:"
        echo -e "$candidates"
    else
        log "无晋升候选"
    fi
}

# 检查降级候选
check_demotion_candidates() {
    log "检查降级候选..."
    
    if [ ! -f "$GLOBAL_DIR/memory.md" ]; then
        log "无全局记忆"
        return
    fi
    
    # 检查30天未使用的模式
    local unused_30_days=$(find "$GLOBAL_DIR/domains" -name "*.md" -mtime +30 2>/dev/null || true)
    
    if [ -n "$unused_30_days" ]; then
        warn "30天未使用的模式（建议降级到 WARM）:"
        echo "$unused_30_days"
    else
        log "无降级候选"
    fi
}

# 检查归档候选
check_archive_candidates() {
    log "检查归档候选..."
    
    # 检查90天未使用的模式
    local unused_90_days=$(find "$GLOBAL_DIR/domains" -name "*.md" -mtime +90 2>/dev/null || true)
    
    if [ -n "$unused_90_days" ]; then
        warn "90天未使用的模式（建议归档到 COLD）:"
        echo "$unused_90_days"
    else
        log "无归档候选"
    fi
}

# 执行晋升
execute_promotions() {
    log "执行晋升..."
    
    for bureau in "${BUREAUS[@]}"; do
        local learnings_dir="$HOME/.claw/agents/$bureau/.learnings"
        if [ -f "$learnings_dir/LEARNINGS.md" ]; then
            # 查找标记为晋升待定的学习
            local promotions=$(grep -B10 "Promotion-Pending: true" "$learnings_dir/LEARNINGS.md" 2>/dev/null || true)
            
            if [ -n "$promotions" ]; then
                info "$bureau 有晋升待定项，需要手动确认"
            fi
        fi
    done
}

# 执行降级
execute_demotions() {
    log "执行降级..."
    
    # 这里只是检查，实际降级需要手动确认
    check_demotion_candidates
}

# 执行归档
execute_archives() {
    log "执行归档..."
    
    # 这里只是检查，实际归档需要手动确认
    check_archive_candidates
}

# 更新全局心跳状态
update_global_heartbeat_state() {
    local result="${1:-HEARTBEAT_OK}"
    
    cat > "$HEARTBEAT_STATE" << EOF
last_global_heartbeat: $(date -Iseconds)
last_promotion_review: $(date -Iseconds)
last_archive_run: $(date -Iseconds)

bureaus_with_pending_items:
$(for bureau in "${BUREAUS[@]}"; do
    local learnings_dir="$HOME/.claw/agents/$bureau/.learnings"
    if [ -f "$learnings_dir/LEARNINGS.md" ]; then
        local count=$(grep -c "Status\*\*: pending" "$learnings_dir/LEARNINGS.md" 2>/dev/null || echo "0")
        echo "  - $bureau: $count"
    fi
done)

global_promotions_pending: 0
global_archive_count: 0

heartbeat_result: $result
EOF
    
    log "全局心跳状态已更新"
}

# 生成心跳报告
generate_heartbeat_report() {
    local report_file="$GLOBAL_DIR/heartbeat-report-$(date '+%Y%m%d').md"
    
    cat > "$report_file" << EOF
# 全局心跳报告

**日期**: $(date '+%Y-%m-%d')
**执行者**: Queen 👑

---

## 一、各局学习状态

| 局名 | 待处理学习 | 晋升候选 | 跨局学习 |
|------|-----------|----------|----------|
$(for bureau in "${BUREAUS[@]}"; do
    local learnings_dir="$HOME/.claw/agents/$bureau/.learnings"
    local pending=0
    local promotion=0
    local cross=0
    
    if [ -f "$learnings_dir/LEARNINGS.md" ]; then
        pending=$(grep -c "Status\*\*: pending" "$learnings_dir/LEARNINGS.md" 2>/dev/null || echo "0")
        promotion=$(grep -c "Recurrence-Count: [3-9]" "$learnings_dir/LEARNINGS.md" 2>/dev/null || echo "0")
        cross=$(grep -c "Cross-Bureau: true" "$learnings_dir/LEARNINGS.md" 2>/dev/null || echo "0")
    fi
    
    echo "| $bureau | $pending | $promotion | $cross |"
done)

---

## 二、全局统计

- **总待处理学习**: $(for bureau in "${BUREAUS[@]}"; do
    local learnings_dir="$HOME/.claw/agents/$bureau/.learnings"
    if [ -f "$learnings_dir/LEARNINGS.md" ]; then
        grep -c "Status\*\*: pending" "$learnings_dir/LEARNINGS.md" 2>/dev/null || echo "0"
    fi
done | awk '{sum+=$1} END {print sum}')

- **总晋升候选**: $(for bureau in "${BUREAUS[@]}"; do
    local learnings_dir="$HOME/.claw/agents/$bureau/.learnings"
    if [ -f "$learnings_dir/LEARNINGS.md" ]; then
        grep -c "Recurrence-Count: [3-9]" "$learnings_dir/LEARNINGS.md" 2>/dev/null || echo "0"
    fi
done | awk '{sum+=$1} END {print sum}')

- **总跨局学习**: $(for bureau in "${BUREAUS[@]}"; do
    local learnings_dir="$HOME/.claw/agents/$bureau/.learnings"
    if [ -f "$learnings_dir/LEARNINGS.md" ]; then
        grep -c "Cross-Bureau: true" "$learnings_dir/LEARNINGS.md" 2>/dev/null || echo "0"
    fi
done | awk '{sum+=$1} END {print sum}')

---

## 三、下一步行动

- [ ] 处理晋升候选
- [ ] 处理跨局学习
- [ ] 处理降级候选
- [ ] 处理归档候选

---

_生成时间: $(date '+%Y-%m-%d %H:%M:%S')_
_生成者: Queen 👑_
EOF
    
    log "心跳报告已生成: $report_file"
    success "报告位置: $report_file"
}

# 主函数
main() {
    log "========================================="
    log "全局心跳启动"
    log "========================================="
    
    aggregate_bureau_status
    check_cross_bureau_items
    check_global_promotion_candidates
    check_demotion_candidates
    check_archive_candidates
    
    execute_promotions
    execute_demotions
    execute_archives
    
    update_global_heartbeat_state "HEARTBEAT_OK"
    generate_heartbeat_report
    
    log "========================================="
    log "全局心跳完成"
    log "========================================="
    
    success "心跳正常"
}

# 执行
main
