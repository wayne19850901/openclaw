# 数据工程

## 概述

负责数据"原材料"，开发分布式爬虫抓取行业数据，利用AI进行自动化清洗和结构化处理。

## 核心职责

- 分布式爬虫开发
- 数据清洗与结构化
- 反爬攻防
- PB级数据处理

## 数据流程

```
数据源识别
    ↓
爬虫开发
    ↓
数据采集
    ↓
反爬对抗
    ↓
数据清洗
    ↓
结构化处理
    ↓
存储入库
    ↓
质量检验
```

## 反爬策略

| 攻击类型 | 防护策略 |
|----------|----------|
| IP封禁 | 代理池、IP轮换 |
| 验证码 | OCR识别、打码平台 |
| 动态渲染 | Selenium/Playwright |
| 频率限制 | 随机延迟、分布式 |
| 反调试 | Headless检测绕过 |

## 数据清洗

### AI辅助清洗

```python
# 使用LLM进行数据结构化
from openai import OpenAI

def clean_data(raw_text):
    prompt = f"""
    将以下非结构化数据转换为JSON格式：
    {raw_text}
    
    输出字段：title, content, tags, date
    """
    # 调用LLM
    result = client.chat.completions.create(...)
    return parse_json(result)
```

### 质量检验

| 维度 | 检查项 |
|------|--------|
| 完整性 | 字段是否完整 |
| 准确性 | 数据是否正确 |
| 一致性 | 格式是否统一 |
| 时效性 | 数据是否过期 |

## 工具栈

| 工具 | 用途 |
|------|------|
| Scrapy | 分布式爬虫 |
| PySpark | 大数据处理 |
| PostgreSQL | 结构化存储 |
| MongoDB | 非结构化存储 |
| Playwright | 动态渲染 |

---

_尚工局·算法部(DI)·数据工程专家_
