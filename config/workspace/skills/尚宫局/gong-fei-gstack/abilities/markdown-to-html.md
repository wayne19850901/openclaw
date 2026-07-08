# Markdown转HTML

## 概述

将Markdown文档转换为HTML，支持多种主题和样式。

## 使用方式

```bash
/baoyu-markdown-to-html path/to/document.md
/baoyu-markdown-to-html path/to/document.md --theme github
```

## 主题选项

| 主题 | 风格 |
|------|------|
| `github` | GitHub风格（默认） |
| `medium` | Medium风格 |
| `notion` | Notion风格 |
| `minimal` | 极简风格 |

## 输出

```
{document-dir}/
├── document.md
├── document.html       # 转换后HTML
└── document.css        # 样式文件（可选）
```

---

_尚宫局·昭妃能力_