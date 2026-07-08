#!/bin/bash
# Promotion Check Script
# 晋升检查脚本
# 用法: ./promotion-check.sh

set -e

# 配置
GLOBAL_DIR="$HOME/self-improving"
LOG_FILE="$GLOBAL_DIR/promotion.log"
BUREAUS=("尚工局" "尚融局" "尚宣局" "尚教局" "尚机局" "尚宫局" "御鉴司")

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
NC='\033[0m'

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
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

promote() {
    echo -e "${MAGENTA}[PROMOTE]${NC} $1" | tee -a "$LOG_FILE"
}

# 检查晋升条件
check_promotion_conditions() {
    local bureau="$1"
    local learning_id="$2"
    local learnings_dir="$HOME/.claw/agents/$bureau/.learnings"
    local learnings_file="$learnings_dir/LEARNINGS.md"
    
    # 条件1: Recurrence-Count >= 3
    local recurrence=$(grep -A20 "$learning_id" "$learnings_file" 2>/dev/null | grep "Recurrence-Count:" | awk '{print $2}' || echo "0")
    
    # 条件2: Cross-Bureau: true 或适用范围跨局
    local cross_bureau=$(grep -A20 "$learning_id" "$learnings_file" 2>/dev/null | grep "Cross-Bureau:" | awk '{print $2}' || echo "false")
    
    # 条件3: 最近30天内有效
    local last_seen=$(grep -A20 "$learning_id" "$learnings_file" 2>/dev/null | grep "Last-Seen:" | awk '{print $2}' || echo "")
    local thirty_days_ago=$(date -v-30d '+%Y-%m-%d' 2>/dev/null || date -d "30 days ago" '+%Y-%m-%d' 2>/dev/null || echo "")
    
    local is_recent="false"
    if [ -n "$last_seen" ] && [ -n "$thirty_days_ago" ]; then
        if [[ "$last_seen" > "$thirty_days_ago" ]]; then
            is_recent="true"
        fi
    fi
    
    # 返回结果
    if [ "$recurrence" -ge 3 ] && { [ "$cross_bureau" = "true" ] || [ "$is_recent" = "true" ]; }; then
        echo "eligible"
    else
        echo "not_eligible"
    fi
}

# 查找所有晋升候选
find_all_promotion_candidates() {
    log "查找所有晋升候选..."
    
    local candidates=""
    
    for bureau in "${BUREAUS[@]}"; do
        local learnings_dir="$HOME/.claw/agents/$bureau/.learnings"
        local learnings_file="$learnings_dir/LEARNINGS.md"
        
        if [ -f "$learnings_file" ]; then
            # 查找 Recurrence-Count >= 3 的学习
            local items=$(grep -B5 "Recurrence-Count: [3-9]" "$learnings_file" 2>/dev/null | grep "^## \[" || true)
            
            if [ -n "$items" ]; then
                info "$bureau 发现晋升候选:"
                echo "$items" | while read line; do
                    local learning_id=$(echo "$line" | sed 's/## \[\([^]]*\)\].*/\1/')
                    local eligibility=$(check_promotion_conditions "$bureau" "$learning_id")
                    
                    if [ "$eligibility" = "eligible" ]; then
                        promote "$learning_id ($bureau) - 符合晋升条件"
                        candidates="$candidates$bureau|$learning_id\n"
                    else
                        warn "$learning_id ($bureau) - 不符合晋升条件"
                    fi
                done
            fi
        fi
    done
    
    if [ -z "$candidates" ]; then
        log "无晋升候选"
    fi
    
    echo -e "$candidates"
}

# 执行晋升
execute_promotion() {
    local bureau="$1"
    local learning_id="$2"
    
    local learnings_dir="$HOME/.claw/agents/$bureau/.learnings"
    local learnings_file="$learnings_dir/LEARNINGS.md"
    local global_memory="$GLOBAL_DIR/memory.md"
    
    # 提取学习内容
    local content=$(sed -n "/^## \[$learning_id\]/,/^---$/p" "$learnings_file" 2>/dev/null || true)
    
    if [ -z "$content" ]; then
        warn "无法提取学习内容: $learning_id"
        return 1
    fi
    
    # 添加到全局记忆
    echo "" >> "$global_memory"
    echo "<!-- Promoted from $bureau at $(date '+%Y-%m-%d') -->" >> "$global_memory"
    echo "$content" >> "$global_memory"
    
    # 标记原学习为已晋升
    sed -i.bak "s/Status\*\*: pending/Status\*\*: promoted/" "$learnings_file"
    sed -i.bak "/$learning_id/,/^---$/ s/^Promotion-Pending:.*$/Promotion-Pending: false\nPromoted-To: global/" "$learnings_file"
    
    promote "$learning_id 已晋升到全局记忆"
}

# 生成晋升报告
generate_promotion_report() {
    local candidates="$1"
    local report_file="$GLOBAL_DIR/promotion-report-$(date '+%Y%m%d').md"
    
    cat > "$report_file" << EOF
# 晋升检查报告

**日期**: $(date '+%Y-%m-%d')
**执行者**: Queen 👑 + 御鉴司 ⚖️

---

## 一、晋升候选列表

| 局名 | 学习ID | 晋升条件 | 状态 |
|------|--------|----------|------|
$(echo -e "$candidates" | grep -v "^$" | while IFS='|' read bureau learning_id; do
    if [ -n "$bureau" ] && [ -n "$learning_id" ]; then
        echo "| $bureau | $learning_id | 符合 | 待确认 |"
    fi
done)

---

## 二、晋升条件

- Recurrence-Count >= 3
- Cross-Bureau: true 或适用范围跨局
- 最近30天内有效

---

## 三、下一步行动

- [ ] Queen 审查晋升候选
- [ ] 御鉴司合规审查
- [ ] 威帝确认
- [ ] 执行晋升

---

_生成时间: $(date '+%Y-%m-%d %H:%M:%S')_
_生成者: Queen 👑 + 御鉴司 ⚖️_
EOF
    
    log "晋升报告已生成: $report_file"
    success "报告位置: $report_file"
}

# 主函数
main() {
    log "========================================="
    log "晋升检查启动"
    log "========================================="
    
    local candidates=$(find_all_promotion_candidates)
    
    if [ -n "$candidates" ]; then
        generate_promotion_report "$candidates"
        
        log "========================================="
        log "晋升检查完成"
        log "========================================="
        
        success "发现晋升候选，请查看报告"
    else
        log "========================================="
        log "晋升检查完成"
        log "========================================="
        
        log "无晋升候选"
    fi
}

# 执行
main
