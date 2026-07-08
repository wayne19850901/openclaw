# RAG架构设计

## 核心组件

### 1. 文档处理管道

```
原始文档 → 分块(Chunking) → 清洗 → 向量化(Embedding) → 存储
```

### 分块策略

| 策略 | 适用场景 | 参数 |
|------|----------|------|
| 固定大小 | 通用 | chunk_size=500, overlap=50 |
| 语义分块 | 文章 | 基于段落、句子边界 |
| 递归分块 | 代码 | 按层级拆分 |
| 自定义 | 特殊格式 | 规则驱动 |

### 2. 向量存储

| 数据库 | 优势 | 劣势 |
|--------|------|------|
| Pinecone | 托管、高性能 | 成本高 |
| Milvus | 开源、可扩展 | 运维复杂 |
| Qdrant | 轻量、快速 | 功能较少 |
| Weaviate | 混合搜索 | 学习曲线陡 |

### 3. 检索策略

```
简单检索：Query → Vector Search → Top-K

混合检索：Query → Vector + Keyword → Fusion → Top-K

多跳检索：Query → Search → Follow-up Query → Search → ...
```

### 4. Rerank重排序

| 模型 | 特点 |
|------|------|
| Cohere Rerank | API服务，效果好 |
| BGE-Reranker | 开源，中文友好 |
| Cross-Encoder | 精确但慢 |

## 效果优化

### 检索优化

- 查询扩展（Query Expansion）
- 假设性文档嵌入（HyDE）
- 查询重写（Query Rewriting）

### 生成优化

- 上下文压缩
- 引用标注
- 答案验证

## 评估指标

| 指标 | 说明 |
|------|------|
| Hit Rate | 命中率 |
| MRR | 平均倒数排名 |
| NDCG | 归一化折损累积增益 |
| Faithfulness | 忠实度 |

---

_尚工局·算法部参考_
