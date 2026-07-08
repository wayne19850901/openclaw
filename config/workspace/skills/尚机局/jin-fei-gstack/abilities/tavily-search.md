# tavily-search — 高质量 AI 优化搜索

## 触发词
- "搜索"、"查一下"、"tavily"
- "网络搜索"、"查一下XX"

## 核心功能
高质量 AI 优化的网络搜索：
- 高级过滤选项
- 相关性评分
- AI 总结回答
- 支持新闻/金融主题

## 执行命令

```bash
# 基础搜索
TAVILY_API_KEY="tvly-dev-xxx" ~/.deno/bin/deno run --allow-env --allow-net=api.tavily.com ~/.agents/skills/web-search-tavily/scripts/search.ts "搜索内容" --results 5

# 新闻搜索（带AI总结）
TAVILY_API_KEY="tvly-dev-xxx" ~/.deno/bin/deno run --allow-env --allow-net=api.tavily.com ~/.agents/skills/web-search-tavily/scripts/search.ts "关键词" --topic news --time day --answer

# 金融搜索
TAVILY_API_KEY="tvly-dev-xxx" ~/.deno/bin/deno run --allow-env --allow-net=api.tavily.com ~/.agents/skills/web-search-tavily/scripts/search.ts "关键词" --topic finance --answer
```

## 输出格式
- 搜索结果列表（标题、URL、摘要）
- 相关性评分
- AI 总结回答（如启用 --answer）

## 与 intelligence 协作
tavily-search 作为情报搜集的辅助工具：
- 快速验证单一来源
- 补充 news-aggregator 未覆盖的信源
- 深度搜索特定事件