#!/bin/bash
# ============================================================================
# Claw + OpenClaw + GBrain 新机器一键部署脚本
# 在另一台电脑上执行此脚本，即可获得与当前机器完全相同的配置
# ============================================================================

set -e

echo "================================================"
echo " Claw + OpenClaw + GBrain 新机器部署"
echo "================================================"

# ---- 0. 确认身份 ----
echo ""
echo "⚠️  请先确认："
echo "  1. 本机是 macOS"
echo "  2. 已安装 Xcode Command Line Tools: xcode-select --install"
echo "  3. 已准备好 API Key（见步骤 5）"
echo ""
read -p "按回车继续，或 Ctrl+C 退出..."

# ---- 1. 安装依赖 ----
echo ""
echo "=== [1/6] 安装依赖 ==="

# Node.js (通过 nvm 或 brew)
if ! command -v node &>/dev/null; then
  echo "安装 Node.js..."
  brew install node
fi
echo "  node: $(node --version)"

# Bun
if ! command -v bun &>/dev/null; then
  echo "安装 Bun..."
  curl -fsSL https://bun.sh/install | bash
  export PATH="$HOME/.bun/bin:$PATH"
fi
echo "  bun: $(bun --version)"

# Python3
if ! command -v python3 &>/dev/null; then
  echo "安装 Python3..."
  brew install python
fi
echo "  python3: $(python3 --version 2>&1)"

# ---- 2. 克隆 Claw 项目 ----
echo ""
echo "=== [2/6] 克隆 Claw 项目 ==="

read -p "Claw Git 仓库地址 (留空则跳过): " CLAW_REPO
if [ -n "$CLAW_REPO" ]; then
  git clone "$CLAW_REPO" ~/CodeBuddy/Claw
  echo "  ✅ Claw 已克隆到 ~/CodeBuddy/Claw"
else
  echo "  ⏭️  跳过，稍后手动克隆"
fi

# ---- 3. 安装 OpenClaw ----
echo ""
echo "=== [3/6] 安装 OpenClaw CLI ==="

npm install -g openclaw 2>/dev/null || echo "  ⚠️  npm 安装失败，尝试其他方式"
if command -v openclaw &>/dev/null; then
  echo "  ✅ openclaw: $(openclaw --version 2>&1 | head -1)"
else
  echo "  ⚠️  请手动安装 openclaw: npm install -g openclaw"
fi

# ---- 4. 安装 GBrain ----
echo ""
echo "=== [4/6] 安装 GBrain ==="

if ! command -v gbrain &>/dev/null; then
  bun install -g github:garrytan/gbrain 2>/dev/null || {
    echo "  全局安装失败，尝试克隆安装..."
    git clone --depth 1 https://github.com/garrytan/gbrain.git ~/CodeBuddy/gbrain
    cd ~/CodeBuddy/gbrain && bun install && bun link
  }
fi
echo "  ✅ gbrain: $(gbrain --version 2>&1)"

# ---- 5. 配置环境变量 ----
echo ""
echo "=== [5/6] 配置环境变量 ==="

echo "请设置以下环境变量（已有则跳过）："
echo ""
echo "  ✅ FIRECRAWL_API_KEY — 已配置"
echo "  ✅ TAVILY_API_KEY — 已配置"
echo "  ✅ BRAVE_API_KEY — 已配置"
echo "  ✅ GITHUB_PERSONAL_ACCESS_TOKEN — 已配置"
echo "  ✅ 火山引擎 API Key — 已配置（embedding + chat）"
echo ""

# 追加到 ~/.zshrc
cat >> ~/.zshrc << 'ENVEOF'

# === Claw / OpenClaw / GBrain 环境变量 ===
# 请替换为实际 key
export FIRECRAWL_API_KEY="your-firecrawl-key"
export TAVILY_API_KEY="your-tavily-key"
export BRAVE_API_KEY="your-brave-key"
export GITHUB_PERSONAL_ACCESS_TOKEN="your-github-token"
export OPENROUTER_API_KEY="your-volcengine-key"
export ZHIPUAI_API_KEY="your-volcengine-key"
ENVEOF

echo "  ⚠️  请编辑 ~/.zshrc 填入实际 API Key"
echo "  之后执行: source ~/.zshrc"

# ---- 6. 恢复配置 ----
echo ""
echo "=== [6/6] 恢复配置 ==="

echo "请将以下内容从旧机器复制到新机器："
echo ""
echo "  ┌─────────────────────────────────────────────┐"
echo "  │  需要手动复制的文件                          │"
echo "  ├─────────────────────────────────────────────┤"
echo "  │  1. ~/.claw/ — OpenClaw 完整配置             │"
echo "  │  2. ~/self-improving/ — 自我改进记忆          │"
echo "  │  3. ~/brain/ — 知识库源文件                  │"
echo "  │  4. ~/.gbrain/config.json — GBrain 配置       │"
echo "  │  5. ~/.openclaw/ — OpenClaw 状态文件          │"
echo "  └─────────────────────────────────────────────┘"
echo ""
echo "一步复制命令："
echo ""
echo "  # 在旧机器上打包："
echo "  tar czf ~/claw-backup.tar.gz \\"
echo "    -C ~ .claw/ \\"
echo "    -C ~ self-improving/ \\"
echo "    -C ~ brain/ \\"
echo "    -C ~ .gbrain/config.json \\"
echo "    -C ~ .openclaw/"
echo ""
echo "  # 传到新机器（scp / USB / 网盘）后解压："
echo "  tar xzf ~/claw-backup.tar.gz -C ~/"
echo ""

echo "================================================"
echo " 部署完成！"
echo "================================================"
echo ""
echo "后续步骤："
echo "  1. source ~/.zshrc"
echo "  2. 在 GBrain 上重新 init 数据库:"
echo "       gbrain init --pglite"
echo "  3. 从 ~/brain/ 导入知识:"
echo "       gbrain import ~/brain/"
echo "  4. 生成 embedding:"
echo "       gbrain embed --all"
echo "  5. 验证:"
echo "       gbrain doctor"
echo "       gbrain query '测试'"
echo ""