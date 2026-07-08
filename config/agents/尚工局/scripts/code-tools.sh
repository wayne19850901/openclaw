#!/bin/bash
# 代码工具脚本
# 用途：代码审查、格式化、测试

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
    echo "用法: $0 <命令> [目录]"
    echo ""
    echo "命令:"
    echo "  lint      代码检查"
    echo "  format    代码格式化"
    echo "  test      运行测试"
    echo "  review    代码审查"
    echo "  full      完整流程"
    exit 1
}

if [ $# -lt 1 ]; then
    usage
fi

COMMAND="$1"
DIR="${2:-.}"

cd "$DIR" 2>/dev/null || { log_error "目录不存在: $DIR"; exit 1; }

case $COMMAND in
    lint)
        log_info "执行代码检查..."
        # 根据项目类型选择linter
        if [ -f "package.json" ]; then
            log_info "检测到 Node.js 项目"
            npm run lint 2>/dev/null || npx eslint . 2>/dev/null || log_warn "未配置 ESLint"
        elif [ -f "requirements.txt" ]; then
            log_info "检测到 Python 项目"
            flake8 . 2>/dev/null || log_warn "未安装 flake8"
        else
            log_warn "未识别项目类型"
        fi
        ;;
    format)
        log_info "格式化代码..."
        if [ -f "package.json" ]; then
            npx prettier --write . 2>/dev/null || log_warn "未安装 prettier"
        elif [ -f "requirements.txt" ]; then
            black . 2>/dev/null || log_warn "未安装 black"
        fi
        ;;
    test)
        log_info "运行测试..."
        if [ -f "package.json" ]; then
            npm test 2>/dev/null || log_warn "测试失败或未配置"
        elif [ -f "requirements.txt" ]; then
            pytest 2>/dev/null || log_warn "测试失败或未安装 pytest"
        fi
        ;;
    review)
        log_info "代码审查..."
        log_info "检查要点:"
        echo "  - 功能正确性"
        echo "  - 代码可读性"
        echo "  - 性能考虑"
        echo "  - 安全检查"
        echo "  - 测试覆盖"
        ;;
    full)
        log_info "执行完整流程..."
        $0 lint "$DIR"
        $0 format "$DIR"
        $0 test "$DIR"
        $0 review "$DIR"
        log_info "完整流程完成！"
        ;;
    *)
        log_error "未知命令: $COMMAND"
        usage
        ;;
esac
