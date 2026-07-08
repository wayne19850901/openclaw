# Skills 安全管理规范

---

## 安全第一原则

**所有技能安装必须经过 skill-vetter 安全审查！**

---

## 当前配置（方案B激进型）

### 必备层（3个）

| Skill | 功能 | 状态 |
|-------|------|------|
| **skill-vetter** | 安全审查 | ✅ 启用 |
| **self-improving-agent** | 自我学习优化 | ✅ 启用 |
| **proactive-agent** | 主动能力框架 | ✅ 启用 |

### 高频层（5个）

| Skill | 功能 | 归属 | 状态 |
|-------|------|------|------|
| **content-writer** | 多平台内容生成 | 仪妃 | ✅ 启用 |
| **github** | GitHub交互 | 慧妃 | ✅ 启用 |
| **ppt-generator** | PPT生成 | 仪妃 | ✅ 启用 |
| **deep-research-pro** | 深度研究 | 谨妃 | ✅ 启用 |
| **automate-excel** | Excel自动化 | 昭妃 | ✅ 启用 |

### 启用层（2个）

| Skill | 功能 | API配置 | 状态 |
|-------|------|---------|------|
| **tavily-search** | 高质量搜索 | ✅ 已配置 | ✅ 启用 |
| **unified-doc-processor** | 统一文档处理（OCR+PDF） | 无需 | ✅ 启用 |

### gstack 整合层（5个）

| Skill | 功能 | 归属 | 状态 |
|-------|------|------|------|
| **jin-fei-gstack** | 机枢探查+裁决（browse/pair-agent/codex） | 谨妃 | ✅ 启用 |
| **rong-fei-gstack** | 融策咨询+评审（office-hours/plan-ceo-review/autoplan） | 贵妃 | ✅ 启用 |
| **xuan-fei-gstack** | 宣策审查+评审（design-review/plan-design-review） | 仪妃 | ✅ 启用 |
| **ling-fei-gstack** | 经验沉淀+文档生成（learn/document-generate/document-release） | 令妃 | ✅ 启用 |
| **gstack-docs** | gstack 方法论知识库 | Queen | ✅ 启用 |

### 其他保留（9个）

- unified-doc-processor - 统一文档处理（OCR+PDF整合）
- ling-fei-education-pro - 令妃教育专业版（整合ling-fei-edu + ling-fei-education）
- summarize - 摘要工具
- ai-video-script - 视频脚本
- market-research - 市场研究
- python-dataviz - 数据可视化
- chinese - 中文写作
- find-skills - 技能发现
- sulada-knowledge-base - 知识库

---

## API Key 配置

| API | 用途 | 状态 |
|-----|------|------|
| **TAVILY_API_KEY** | 高质量搜索 | ✅ 已配置 |
| **GEMINI_API_KEY** | summarize工具 | ✅ 已配置 |

---

## 安全审查流程

```
新技能安装请求
    ↓
【第1步】skill-vetter 安全审查
    ├── 🔴 检查权限Scope
    ├── 🔴 检查敏感操作
    ├── 🔴 检查网络请求
    ├── 🔴 检查代码安全
    └── 🔴 检查依赖安全
    ↓
审查通过？
├── ✅ 是 → 进入测试
└── ❌ 否 → 阻止安装 + 报告风险
    ↓
【第2步】功能测试
    ↓
测试通过？
├── ✅ 是 → 分配归属
└── ❌ 否 → 暂缓安装
    ↓
【第3步】分配归属
└── 分配给对应妃子/尚座管理
```

---

## 禁止行为

| 禁止 | 原因 |
|------|------|
| ❌ 绕过 skill-vetter 审查 | 安全风险 |
| ❌ 安装未知来源技能 | 安全风险 |
| ❌ 配置可疑API Key | 数据泄露风险 |
| ❌ 删除 skill-vetter | 核心安全组件 |

---

## 已清理技能（方案B + Phase 1&2优化）

| Skill | 清理原因 |
|-------|----------|
| ddg-web-search | 与tavily重叠 |
| image-ocr | 与ocr-space重叠 |
| proactive-agent-lite | 已有完整版 |
| neural-memory | 已有memory-lancedb |
| firecrawl-search | 功能重叠 |
| competitive-intelligence | 功能重叠 |
| ocr-space | 整合至unified-doc-processor |
| pdf-extract | 整合至unified-doc-processor |
| memory-core | 已有memory-lancedb替代 |
| ling-fei-edu | 整合至ling-fei-education-pro |
| ling-fei-education | 整合至ling-fei-education-pro |

---

## 定期审查

**Queen 每月审查一次：**
1. 检查技能使用情况
2. 审查安全日志
3. 更新API Key（如需要）
4. 清理不用的技能

---

_Config by Queen 👑_
_Last Update: 2026-05-17 (gstack 整合完成)_
