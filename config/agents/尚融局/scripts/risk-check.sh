#!/bin/bash
# 财务计算脚本
# 用途：贷款、投资相关计算

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log_info() { echo -e "${GREEN}[INFO]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }

# 月供计算（等额本息）
calculate_monthly_payment() {
    local principal=$1
    local annual_rate=$2
    local months=$3

    local monthly_rate=$(echo "scale=6; $annual_rate / 12 / 100" | bc)
    local temp=$(echo "scale=10; (1 + $monthly_rate) ^ $months" | bc)
    local payment=$(echo "scale=2; $principal * $monthly_rate * $temp / ($temp - 1)" | bc)

    echo $payment
}

# ROI计算
calculate_roi() {
    local revenue=$1
    local cost=$2

    local roi=$(echo "scale=2; ($revenue - $cost) / $cost * 100" | bc)
    echo $roi
}

# 用法
usage() {
    echo "用法: $0 <命令> [参数]"
    echo ""
    echo "命令:"
    echo "  monthly <本金> <年利率%> <期数>   计算月供"
    echo "  roi <收益> <成本>                 计算ROI"
    echo ""
    echo "示例:"
    echo "  $0 monthly 100000 4.9 36"
    echo "  $0 roi 150000 100000"
    exit 1
}

if [ $# -lt 1 ]; then
    usage
fi

COMMAND="$1"
shift

case $COMMAND in
    monthly)
        if [ $# -lt 3 ]; then
            log_info "需要: 本金 年利率 期数"
            exit 1
        fi
        PAYMENT=$(calculate_monthly_payment $1 $2 $3)
        log_info "月供: ¥$PAYMENT"
        ;;
    roi)
        if [ $# -lt 2 ]; then
            log_info "需要: 收益 成本"
            exit 1
        fi
        ROI=$(calculate_roi $1 $2)
        log_info "ROI: ${ROI}%"
        ;;
    *)
        log_info "未知命令: $COMMAND"
        usage
        ;;
esac
