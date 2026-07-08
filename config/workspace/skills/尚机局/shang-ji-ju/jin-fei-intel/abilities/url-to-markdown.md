# 网页内容抓取

## 概述

将网页URL转换为Markdown格式，便于分析和存档。

## 使用方式

```bash
/baoyu-url-to-markdown https://example.com/article
/baoyu-url-to-markdown https://example.com --output ./content/
```

## 支持的来源

| 来源 | 特殊处理 |
|------|----------|
| 通用网页 | 自动提取正文 |
| 微信公众号 | 保留图片和格式 |
| 知乎 | 过滤广告和推荐 |
| Medium | 保留代码块 |
| GitHub | 提取README |

## 输出格式

```
content/
├── {slug}.md           # Markdown内容
├── {slug}-meta.json    # 元数据
└── images/             # 本地化图片（可选）
    └── image-1.png
```

## 抓取流程

```
输入URL
    ↓
识别来源类型
    ↓
选择对应解析器
    ↓
提取正文内容
    ↓
转换为Markdown
    ↓
下载图片（可选）
    ↓
输出文件
```

## 选项

| 参数 | 说明 |
|------|------|
| `--output` | 输出目录 |
| `--no-images` | 不下载图片 |
| `--raw` | 保留原始HTML |

---

_尚机局·谨妃能力_
