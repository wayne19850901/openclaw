---
description: 统一文档处理器 - 图片OCR识别 + PDF文本提取，一站式文档解析
---

# Unified Doc Processor 统一文档处理器

整合 OCR 图片识别和 PDF 文本提取功能，提供统一的文档解析接口。

## 🚀 功能

- ✅ 图片文字识别 (OCR) - 基于 OCR.space API
- ✅ PDF 文本提取 - 基于 pdftotext
- ✅ 自动检测文件类型并选择处理方式
- ✅ 多语言 OCR 支持（中文、英文、日文等 20+ 语言）
- ✅ 大图片自动压缩
- ✅ 统一命令行接口

---

## 📁 文件结构

```
unified-doc-processor/
├── SKILL.md              # 本文件
├── doc_processor.py      # 主脚本（统一入口）
├── ocr_engine.py         # OCR 引擎（原 ocr-space）
├── pdf_engine.py         # PDF 引擎（原 pdf-extract）
└── _meta.json            # 元数据
```

---

## 🔧 使用方法

### 命令行

```bash
# 自动检测文件类型并处理
python3 doc_processor.py /path/to/document

# 图片 OCR（指定语言）
python3 doc_processor.py /path/to/image.jpg --lang chs

# PDF 提取（指定页码范围）
python3 doc_processor.py /path/to/document.pdf --pages 1-5

# 仅使用 OCR 模式
python3 doc_processor.py /path/to/image.png --mode ocr

# 仅使用 PDF 模式
python3 doc_processor.py /path/to/document.pdf --mode pdf
```

### Python 代码调用

```python
import sys
sys.path.insert(0, '~/.claw/workspace/skills/尚机局/unified-doc-processor')
from doc_processor import process_document

# 自动检测并处理
result = process_document('/path/to/document')
print(result)

# 指定模式
result = process_document('/path/to/image.jpg', mode='ocr', language='eng')
```

---

## 📡 OCR.space 限制

| 限制项 | 额度 |
|--------|------|
| 每日请求数 | **500 次/天** |
| 单文件大小 | **5 MB**（自动压缩） |
| API Key | 不需要（测试用 `helloworld`）|

---

## 🌍 支持的 OCR 语言

| 语言代码 | 语言名称 |
|---------|---------|
| `chs` | 中文简体 |
| `cht` | 中文繁体 |
| `eng` | 英语 |
| `jpn` | 日语 |
| `kor` | 韩语 |
| `fre` | 法语 |
| `ger` | 德语 |
| `spa` | 西班牙语 |
| `por` | 葡萄牙语 |
| `rus` | 俄语 |
| `ara` | 阿拉伯语 |

---

## 📦 依赖

- **OCR**: requests, Pillow（图片压缩）
- **PDF**: poppler-utils（pdftotext 命令）

安装 PDF 依赖：
```bash
# macOS
brew install poppler

# Ubuntu/Debian
sudo apt install poppler-utils

# Fedora
sudo dnf install poppler-utils
```

---

## 📜 更新日志

- **2026-05-17**: 整合 ocr-space + pdf-extract 为统一文档处理器
- **2026-03-10**: ocr-space 初始版本
- **2026-02-04**: pdf-extract 初始版本
