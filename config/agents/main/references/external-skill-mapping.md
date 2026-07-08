# 外部 Skills 归属映射表

## 映射规则

外部 Skills 根据 `MEMORY.md` 中的五级架构归属到对应典级。

---

## 尚宣局

### 司创师 → 写典
| Skill | 用途 | 调用场景 |
|-------|------|----------|
| `content-writer` | 多平台内容生成 | 小红书、知乎、公众号、抖音文案 |

### 司创师 → 脚典
| Skill | 用途 | 调用场景 |
|-------|------|----------|
| `ai-video-script` | AI视频脚本生成 | 短视频脚本、分镜设计 |

### 司创师 → 创典
| Skill | 用途 | 调用场景 |
|-------|------|----------|
| `ppt-generator` | 乔布斯风HTML演示稿 | PPT、演示文稿生成 |

---

## 尚机局

### 司调师 → 市典
| Skill | 用途 | 调用场景 |
|-------|------|----------|
| `market-research` | 市场研究分析 | 市场规模、竞争分析 |

### 司情师 → 搜典
| Skill | 用途 | 调用场景 |
|-------|------|----------|
| `deep-research-pro` | 深度研究报告 | 多源搜索、综合报告 |
| `tavily-search` | AI优化搜索 | 快速信息检索 |
| `ddg-web-search` | DuckDuckGo搜索 | 无API Key搜索 |
| `firecrawl-search` | 网页抓取 | 网站内容提取 |

### 司析师 → 洞典
| Skill | 用途 | 调用场景 |
|-------|------|----------|
| `competitive-intelligence-market-research` | 竞争情报 | B2B竞争分析 |
| `python-dataviz` | 数据可视化 | 图表生成 |

---

## 尚宫局

### 司资师 → 配典
| Skill | 用途 | 调用场景 |
|-------|------|----------|
| `automate-excel` | Excel自动化 | 表格处理、数据整理 |

### 司流师 → 流程工具
| Skill | 用途 | 调用场景 |
|-------|------|----------|
| `neural-memory` | 神经记忆 | 长期记忆管理 |

---

## 尚教局

### 司讲师 → 答典
| Skill | 用途 | 调用场景 |
|-------|------|----------|
| `summarize` | 内容摘要 | URL、PDF、图片摘要 |

---

## 尚工局

### 司开师 → 开典
| Skill | 用途 | 调用场景 |
|-------|------|----------|
| `github` | GitHub操作 | Issue、PR、CI管理 |

### 司研师 → 算典
| Skill | 用途 | 调用场景 |
|-------|------|----------|
| `ocr-space` | OCR识别 | 图片文字提取 |
| `image-ocr` | 图片OCR | Tesseract本地识别 |

### 司护师 → 援典
| Skill | 用途 | 调用场景 |
|-------|------|----------|
| `pdf-extract` | PDF提取 | PDF内容解析 |

---

## 通用工具

| Skill | 归属 | 用途 |
|-------|------|------|
| `chinese` | Queen直接调用 | 中文写作优化 |
| `find-skills` | Queen直接调用 | 技能发现安装 |
| `skill-vetter` | Queen直接调用 | 技能安全审查 |
| `self-improving-agent` | Queen直接调用 | 自我提升机制 |
| `proactive-agent` | Queen直接调用 | 主动代理模式 |
| `proactive-agent-lite` | Queen直接调用 | 轻量主动代理 |
| `sulada-knowledge-base` | Queen直接调用 | 知识库管理 |

---

## 调用链路

```
威帝指令
    ↓
Queen (识别任务类型)
    ↓
妃子 (协调对应局)
    ↓
尚座 (调用对应司师)
    ↓
司师 (选择对应典级)
    ↓
典级 (执行具体任务)
    ↓
外部 Skill (实际执行)
```

---

_最后更新：2026-04-05_
