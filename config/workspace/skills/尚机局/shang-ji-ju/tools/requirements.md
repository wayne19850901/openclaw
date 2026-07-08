# 尚机局工具依赖

## 核心工具

| 工具 | 版本 | 用途 |
|------|------|------|
| Python | 3.10+ | 数据处理、AI |
| Node.js | 18+ | 服务开发 |
| Bun | latest | 脚本运行 |

## 部门工具栈

### 📊 数据工程部

| 工具 | 用途 |
|------|------|
| Scrapy | 分布式爬虫 |
| 影刀ShadowBot | RPA自动化 |
| Playwright | 动态渲染 |
| Elasticsearch | 全文检索 |
| MongoDB | 文档存储 |
| PostgreSQL | 结构化数据 |
| Pinecone | 向量检索 |
| Apache Kafka | 消息队列 |

### 🧠 情报研究部

| 工具 | 用途 |
|------|------|
| Python | 数据分析 |
| Pandas | 数据处理 |
| Jupyter | 分析报告 |
| Tableau | 可视化 |

### 🎯 产品运营部

| 工具 | 用途 |
|------|------|
| React/Vue | 前端开发 |
| ECharts | 图表库 |
| D3.js | 高级可视化 |
| Grafana | Dashboard |

## 外部数据源

| 供应商 | 类型 | 内容 |
|--------|------|------|
| 万得 | 金融数据 | 行情、公告 |
| 彭博 | 全球财经 | 新闻、数据 |
| 企查查 | 企业信息 | 工商、法律 |
| 微信公众号 | 媒体舆情 | 文章、评论 |

## 环境变量

```bash
# AI模型
OPENAI_API_KEY=your_key
ANTHROPIC_API_KEY=your_key

# 向量数据库
PINECONE_API_KEY=your_key

# 搜索
SERPER_API_KEY=your_key
TAVILY_API_KEY=your_key

# 数据源
WIND_TOKEN=your_token
QCC_TOKEN=your_token

# RPA
SHADOWBOT_LICENSE=your_license
```

## 安装命令

```bash
# Python包
pip install scrapy elasticsearch pinecone-client pandas jupyter

# Node包
npm install playwright @elastic/elasticsearch
```

---

_尚机局_
