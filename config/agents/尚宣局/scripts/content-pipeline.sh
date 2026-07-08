#!/bin/bash
# 内容生成流水线脚本
# 用途：批量生成多平台内容

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log_info() { echo -e "${GREEN}[INFO]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# 用法
usage() {
    echo "用法: $0 <主题> <平台>"
    echo "平台: xiaohongshu | zhihu | gongzhonghao | douyin | all"
    exit 1
}

# 检查参数
if [ $# -lt 2 ]; then
    usage
fi

TOPIC="$1"
PLATFORM="$2"

log_info "开始生成内容..."
log_info "主题: $TOPIC"
log_info "平台: $PLATFORM"

# 根据平台调用 content-writer skill
case $PLATFORM in
    xiaohongshu)
        log_info "生成小红书内容..."
        # 调用 content-writer
        ;;
    zhihu)
        log_info "生成知乎内容..."
        ;;
    gongzhonghao)
        log_info "生成公众号内容..."
        ;;
    douyin)
        log_info "生成抖音内容..."
        ;;
    all)
        log_info "生成全平台内容..."
        ;;
    *)
        log_error "未知平台: $PLATFORM"
        usage
        ;;
esac

log_info "内容生成完成！"
