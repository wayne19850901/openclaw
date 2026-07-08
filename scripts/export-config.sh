#!/bin/bash
# ============================================================================
# 在当前机器上打包 Claw + OpenClaw + GBrain 可移植配置
# 生成 claw-backup.tar.gz，可复制到新机器
# ============================================================================

set -e

BACKUP_FILE="$HOME/claw-backup-$(date +%Y%m%d).tar.gz"

echo "================================================"
echo " Claw / OpenClaw / GBrain 配置打包"
echo "================================================"
echo ""
echo "输出文件: $BACKUP_FILE"
echo ""

# 临时目录
TMPDIR=$(mktemp -d)
trap "rm -rf $TMPDIR" EXIT

# 收集需要打包的文件
echo "收集配置..."

# OpenClaw - 排除 tmp/ 和 workspace/skills/gstack/ 编译产物
mkdir -p "$TMPDIR/claw"
rsync -a --exclude='tmp/' \
  --exclude='workspace/skills/gstack/browse/' \
  --exclude='workspace/skills/gstack/node_modules/' \
  --exclude='workspace/skills/gstack/.git/' \
  ~/.claw/ "$TMPDIR/claw/"
echo "  ✅ ~/.claw/ (排除 tmp/ 和 gstack 编译产物)"

# Self-improving
cp -r ~/self-improving/ "$TMPDIR/self-improving/"
echo "  ✅ ~/self-improving/"

# Brain 知识库
cp -r ~/brain/ "$TMPDIR/brain/"
echo "  ✅ ~/brain/"

# GBrain 配置
cp ~/.gbrain/config.json "$TMPDIR/gbrain-config.json"
echo "  ✅ ~/.gbrain/config.json"

# OpenAI 状态文件
if [ -d ~/.openclaw ]; then
  rsync -a --exclude='tmp/' ~/.openclaw/ "$TMPDIR/openclaw/"
  echo "  ✅ ~/.openclaw/"
fi

# 打包
echo ""
echo "打包中..."
cd "$TMPDIR"
tar czf "$BACKUP_FILE" .
echo ""
echo "================================================"
echo " 打包完成！"
echo "================================================"
echo ""
echo "文件: $BACKUP_FILE"
echo "大小: $(du -h "$BACKUP_FILE" | cut -f1)"
echo ""
echo "复制到新机器后执行："
echo ""
echo "  tar xzf $BACKUP_FILE -C ~/"
echo ""
echo "然后再运行 setup-new-machine.sh 完成部署"