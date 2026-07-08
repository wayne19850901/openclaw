#!/bin/bash

# OpenClaw 司师级模板复制脚本
# 创建时间: 2026-05-21
# 用途: 按需复制外部模板到司师级references目录

set -e

BASE_DIR="$HOME/.claw/workspace/skills"
EXTERNAL_DIR="$BASE_DIR/external"
GSTACK_DIR="$BASE_DIR/gstack"
SUPERPOWERS_DIR="$BASE_DIR/superpowers"

echo "=== 开始复制核心模板 ==="

# ============================================
# 一、尚融局（金融公司）- 最高优先级
# ============================================

# 1.1 司投师（Warren Buffett哲学）
echo "复制司投师模板..."
mkdir -p "$BASE_DIR/尚融局/司级/司投师/references/external-templates/"

# 财务分析框架
cp "$EXTERNAL_DIR/agency-agents/finance/finance-financial-analyst.md" \
   "$BASE_DIR/尚融局/司级/司投师/references/external-templates/financial-analyst.md"

# 金融分析插件
cp -r "$EXTERNAL_DIR/financial-services/plugins/vertical-plugins/financial-analysis/" \
      "$BASE_DIR/尚融局/司级/司投师/references/external-templates/"

# 股票研究框架
cp -r "$EXTERNAL_DIR/financial-services/plugins/vertical-plugins/equity-research/" \
      "$BASE_DIR/尚融局/司级/司投师/references/external-templates/"

# 投行框架
cp -r "$EXTERNAL_DIR/financial-services/plugins/vertical-plugins/investment-banking/" \
      "$BASE_DIR/尚融局/司级/司投师/references/external-templates/"

# 代码评审（通用）
cp -r "$GSTACK_DIR/review/" \
      "$BASE_DIR/尚融局/司级/司投师/references/external-templates/"

echo "✓ 司投师模板复制完成（5个）"

# 1.2 司贷师（Mohnish Pabrai哲学）
echo "复制司贷师模板..."
mkdir -p "$BASE_DIR/尚融局/司级/司贷师/references/external-templates/"

# 财务分析框架
cp "$EXTERNAL_DIR/agency-agents/finance/finance-financial-analyst.md" \
   "$BASE_DIR/尚融局/司级/司贷师/references/external-templates/financial-analyst.md"

# 簿记框架
cp "$EXTERNAL_DIR/agency-agents/finance/finance-bookkeeper-controller.md" \
   "$BASE_DIR/尚融局/司级/司贷师/references/external-templates/bookkeeper.md"

# 私募股权框架
cp -r "$EXTERNAL_DIR/financial-services/plugins/vertical-plugins/private-equity/" \
      "$BASE_DIR/尚融局/司级/司贷师/references/external-templates/"

# 财富管理框架
cp -r "$EXTERNAL_DIR/financial-services/plugins/vertical-plugins/wealth-management/" \
      "$BASE_DIR/尚融局/司级/司贷师/references/external-templates/"

# 代码评审（通用）
cp -r "$GSTACK_DIR/review/" \
      "$BASE_DIR/尚融局/司级/司贷师/references/external-templates/"

echo "✓ 司贷师模板复制完成（5个）"

# 1.3 司客师（Rakesh Jhunjhunwala哲学）
echo "复制司客师模板..."
mkdir -p "$BASE_DIR/尚融局/司级/司客师/references/external-templates/"

# 销售框架
cp -r "$EXTERNAL_DIR/agency-agents/sales/" \
      "$BASE_DIR/尚融局/司级/司客师/references/external-templates/"

# 增长黑客
cp "$EXTERNAL_DIR/agency-agents/marketing/marketing-carousel-growth-engine.md" \
   "$BASE_DIR/尚融局/司级/司客师/references/external-templates/growth-hacker.md"

# 客户成功
cp -r "$EXTERNAL_DIR/agency-agents/support/" \
      "$BASE_DIR/尚融局/司级/司客师/references/external-templates/"

# 财富管理框架
cp -r "$EXTERNAL_DIR/financial-services/plugins/vertical-plugins/wealth-management/" \
      "$BASE_DIR/尚融局/司级/司客师/references/external-templates/"

# 代码评审（通用）
cp -r "$GSTACK_DIR/review/" \
      "$BASE_DIR/尚融局/司级/司客师/references/external-templates/"

echo "✓ 司客师模板复制完成（5个）"

# ============================================
# 二、尚机局（数据情报公司）- 最高优先级
# ============================================

# 4.1 司情师（Stanley Druckenmiller哲学）
echo "复制司情师模板..."
mkdir -p "$BASE_DIR/尚机局/司级/司情师/references/external-templates/"

# 系统化调试
cp -r "$GSTACK_DIR/investigate/" \
      "$BASE_DIR/尚机局/司级/司情师/references/external-templates/"

# 测试框架
cp -r "$EXTERNAL_DIR/agency-agents/testing/" \
      "$BASE_DIR/尚机局/司级/司情师/references/external-templates/"

# 财务分析
cp "$EXTERNAL_DIR/agency-agents/finance/finance-financial-analyst.md" \
   "$BASE_DIR/尚机局/司级/司情师/references/external-templates/financial-analyst.md"

# 股票研究
cp -r "$EXTERNAL_DIR/financial-services/plugins/vertical-plugins/equity-research/" \
      "$BASE_DIR/尚机局/司级/司情师/references/external-templates/"

# 部署监控
cp -r "$GSTACK_DIR/canary/" \
      "$BASE_DIR/尚机局/司级/司情师/references/external-templates/"

# 代码质量
cp -r "$GSTACK_DIR/health/" \
      "$BASE_DIR/尚机局/司级/司情师/references/external-templates/"

echo "✓ 司情师模板复制完成（6个）"

# ============================================
# 三、高频通用模板（其他司师级）
# ============================================

# 尚工局
echo "复制尚工局模板..."

# 司研师
mkdir -p "$BASE_DIR/尚工局/司级/司研师/references/external-templates/"
cp -r "$EXTERNAL_DIR/agency-agents/product/" "$BASE_DIR/尚工局/司级/司研师/references/external-templates/"
cp -r "$SUPERPOWERS_DIR/skills/brainstorming/" "$BASE_DIR/尚工局/司级/司研师/references/external-templates/"
cp -r "$GSTACK_DIR/review/" "$BASE_DIR/尚工局/司级/司研师/references/external-templates/"
echo "✓ 司研师模板复制完成（3个）"

# 司具师
mkdir -p "$BASE_DIR/尚工局/司级/司具师/references/external-templates/"
cp "$EXTERNAL_DIR/agency-agents/engineering/engineering-backend-architect.md" \
   "$BASE_DIR/尚工局/司级/司具师/references/external-templates/backend.md"
cp "$EXTERNAL_DIR/agency-agents/engineering/engineering-devops-automator.md" \
   "$BASE_DIR/尚工局/司级/司具师/references/external-templates/devops.md"
cp -r "$GSTACK_DIR/review/" "$BASE_DIR/尚工局/司级/司具师/references/external-templates/"
echo "✓ 司具师模板复制完成（3个）"

# 司增师
mkdir -p "$BASE_DIR/尚工局/司级/司增师/references/external-templates/"
cp "$EXTERNAL_DIR/agency-agents/marketing/marketing-carousel-growth-engine.md" \
   "$BASE_DIR/尚工局/司级/司增师/references/external-templates/growth-hacker.md"
cp -r "$SUPERPOWERS_DIR/skills/brainstorming/" "$BASE_DIR/尚工局/司级/司增师/references/external-templates/"
cp -r "$GSTACK_DIR/review/" "$BASE_DIR/尚工局/司级/司增师/references/external-templates/"
echo "✓ 司增师模板复制完成（3个）"

# 司教师
mkdir -p "$BASE_DIR/尚工局/司级/司教师/references/external-templates/"
cp -r "$GSTACK_DIR/review/" "$BASE_DIR/尚工局/司级/司教师/references/external-templates/"
cp -r "$GSTACK_DIR/health/" "$BASE_DIR/尚工局/司级/司教师/references/external-templates/"
cp -r "$GSTACK_DIR/qa/" "$BASE_DIR/尚工局/司级/司教师/references/external-templates/"
echo "✓ 司教师模板复制完成（3个）"

# 司法师
mkdir -p "$BASE_DIR/尚工局/司级/司法师/references/external-templates/"
cp -r "$GSTACK_DIR/review/" "$BASE_DIR/尚工局/司级/司法师/references/external-templates/"
cp -r "$GSTACK_DIR/cso/" "$BASE_DIR/尚工局/司级/司法师/references/external-templates/"
cp -r "$GSTACK_DIR/health/" "$BASE_DIR/尚工局/司级/司法师/references/external-templates/"
echo "✓ 司法师模板复制完成（3个）"

# 司算师
mkdir -p "$BASE_DIR/尚工局/司级/司算师/references/external-templates/"
cp "$EXTERNAL_DIR/agency-agents/finance/finance-financial-analyst.md" \
   "$BASE_DIR/尚工局/司级/司算师/references/external-templates/financial-analyst.md"
cp "$EXTERNAL_DIR/agency-agents/finance/finance-bookkeeper-controller.md" \
   "$BASE_DIR/尚工局/司级/司算师/references/external-templates/bookkeeper.md"
cp -r "$GSTACK_DIR/review/" "$BASE_DIR/尚工局/司级/司算师/references/external-templates/"
echo "✓ 司算师模板复制完成（3个）"

# 司开师
mkdir -p "$BASE_DIR/尚工局/司级/司开师/references/external-templates/"
cp "$EXTERNAL_DIR/agency-agents/design/design-ux-researcher.md" \
   "$BASE_DIR/尚工局/司级/司开师/references/external-templates/ux-researcher.md"
cp -r "$SUPERPOWERS_DIR/skills/brainstorming/" "$BASE_DIR/尚工局/司级/司开师/references/external-templates/"
cp -r "$GSTACK_DIR/review/" "$BASE_DIR/尚工局/司级/司开师/references/external-templates/"
echo "✓ 司开师模板复制完成（3个）"

# 尚宣局
echo "复制尚宣局模板..."

# 司策师
mkdir -p "$BASE_DIR/尚宣局/司级/司策师/references/external-templates/"
cp "$EXTERNAL_DIR/agency-agents/marketing/marketing-carousel-growth-engine.md" \
   "$BASE_DIR/尚宣局/司级/司策师/references/external-templates/growth-hacker.md"
cp -r "$SUPERPOWERS_DIR/skills/brainstorming/" "$BASE_DIR/尚宣局/司级/司策师/references/external-templates/"
cp -r "$GSTACK_DIR/design-review/" "$BASE_DIR/尚宣局/司级/司策师/references/external-templates/"
echo "✓ 司策师模板复制完成（3个）"

# 司记师
mkdir -p "$BASE_DIR/尚宣局/司级/司记师/references/external-templates/"
cp "$EXTERNAL_DIR/agency-agents/marketing/marketing-bilibili-content-strategist.md" \
   "$BASE_DIR/尚宣局/司级/司记师/references/external-templates/content-creator.md"
cp -r "$SUPERPOWERS_DIR/skills/brainstorming/" "$BASE_DIR/尚宣局/司级/司记师/references/external-templates/"
cp -r "$GSTACK_DIR/review/" "$BASE_DIR/尚宣局/司级/司记师/references/external-templates/"
echo "✓ 司记师模板复制完成（3个）"

# 司档师
mkdir -p "$BASE_DIR/尚宣局/司级/司档师/references/external-templates/"
cp -r "$GSTACK_DIR/review/" "$BASE_DIR/尚宣局/司级/司档师/references/external-templates/"
cp -r "$GSTACK_DIR/health/" "$BASE_DIR/尚宣局/司级/司档师/references/external-templates/"
cp -r "$SUPERPOWERS_DIR/skills/verification-before-completion/" \
      "$BASE_DIR/尚宣局/司级/司档师/references/external-templates/"
echo "✓ 司档师模板复制完成（3个）"

# 尚机局
echo "复制尚机局模板..."

# 司试师
mkdir -p "$BASE_DIR/尚机局/司级/司试师/references/external-templates/"
cp -r "$GSTACK_DIR/qa/" "$BASE_DIR/尚机局/司级/司试师/references/external-templates/"
cp -r "$GSTACK_DIR/investigate/" "$BASE_DIR/尚机局/司级/司试师/references/external-templates/"
cp -r "$GSTACK_DIR/health/" "$BASE_DIR/尚机局/司级/司试师/references/external-templates/"
echo "✓ 司试师模板复制完成（3个）"

# 尚宫局
echo "复制尚宫局模板..."

# 司研师
mkdir -p "$BASE_DIR/尚宫局/司级/司研师/references/external-templates/"
cp -r "$EXTERNAL_DIR/agency-agents/project-management/" \
      "$BASE_DIR/尚宫局/司级/司研师/references/external-templates/"
cp -r "$GSTACK_DIR/ship/" "$BASE_DIR/尚宫局/司级/司研师/references/external-templates/"
cp -r "$GSTACK_DIR/land-and-deploy/" "$BASE_DIR/尚宫局/司级/司研师/references/external-templates/"
echo "✓ 尚宫局司研师模板复制完成（3个）"

# 尚教局
echo "复制尚教局模板..."

# 司核师
mkdir -p "$BASE_DIR/尚教局/司级/司核师/references/external-templates/"
cp -r "$GSTACK_DIR/review/" "$BASE_DIR/尚教局/司级/司核师/references/external-templates/"
cp -r "$GSTACK_DIR/health/" "$BASE_DIR/尚教局/司级/司核师/references/external-templates/"
cp -r "$SUPERPOWERS_DIR/skills/verification-before-completion/" \
      "$BASE_DIR/尚教局/司级/司核师/references/external-templates/"
echo "✓ 司核师模板复制完成（3个）"

# 司察师
mkdir -p "$BASE_DIR/尚教局/司级/司察师/references/external-templates/"
cp "$EXTERNAL_DIR/agency-agents/design/design-ux-researcher.md" \
   "$BASE_DIR/尚教局/司级/司察师/references/external-templates/ux-researcher.md"
cp -r "$SUPERPOWERS_DIR/skills/brainstorming/" "$BASE_DIR/尚教局/司级/司察师/references/external-templates/"
cp -r "$GSTACK_DIR/review/" "$BASE_DIR/尚教局/司级/司察师/references/external-templates/"
echo "✓ 司察师模板复制完成（3个）"

# 司评师
mkdir -p "$BASE_DIR/尚教局/司级/司评师/references/external-templates/"
cp -r "$GSTACK_DIR/review/" "$BASE_DIR/尚教局/司级/司评师/references/external-templates/"
cp -r "$GSTACK_DIR/health/" "$BASE_DIR/尚教局/司级/司评师/references/external-templates/"
cp -r "$GSTACK_DIR/design-review/" "$BASE_DIR/尚教局/司级/司评师/references/external-templates/"
echo "✓ 司评师模板复制完成（3个）"

# 御鉴司
echo "复制御鉴司模板..."

# 司安师
mkdir -p "$BASE_DIR/御鉴司/司级/司安师/references/external-templates/"
cp -r "$GSTACK_DIR/cso/" "$BASE_DIR/御鉴司/司级/司安师/references/external-templates/"
cp -r "$GSTACK_DIR/investigate/" "$BASE_DIR/御鉴司/司级/司安师/references/external-templates/"
cp -r "$GSTACK_DIR/health/" "$BASE_DIR/御鉴司/司级/司安师/references/external-templates/"
echo "✓ 司安师模板复制完成（3个）"

# 司实师
mkdir -p "$BASE_DIR/御鉴司/司级/司实师/references/external-templates/"
cp -r "$GSTACK_DIR/investigate/" "$BASE_DIR/御鉴司/司级/司实师/references/external-templates/"
cp -r "$GSTACK_DIR/health/" "$BASE_DIR/御鉴司/司级/司实师/references/external-templates/"
cp -r "$GSTACK_DIR/review/" "$BASE_DIR/御鉴司/司级/司实师/references/external-templates/"
echo "✓ 司实师模板复制完成（3个）"

# 司证师
mkdir -p "$BASE_DIR/御鉴司/司级/司证师/references/external-templates/"
cp -r "$GSTACK_DIR/review/" "$BASE_DIR/御鉴司/司级/司证师/references/external-templates/"
cp -r "$GSTACK_DIR/cso/" "$BASE_DIR/御鉴司/司级/司证师/references/external-templates/"
cp -r "$SUPERPOWERS_DIR/skills/verification-before-completion/" \
      "$BASE_DIR/御鉴司/司级/司证师/references/external-templates/"
echo "✓ 司证师模板复制完成（3个）"

echo ""
echo "=== 模板复制完成 ==="
echo "总计复制: 21个司师级 × 3-6个模板 = 约70个模板"
echo ""

# 统计复制结果
echo "=== 统计复制结果 ==="
find "$BASE_DIR" -path "*/司级/*/references/external-templates" -type d | while read dir; do
    count=$(find "$dir" -type f -o -type d | wc -l | tr -d ' ')
    if [ "$count" -gt 1 ]; then
        echo "$dir: $count 个文件/目录"
    fi
done
