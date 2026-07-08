# 尚机局工具依赖

## 核心工具

| 工具 | 用途 | 安装命令 |
|------|------|----------|
| Bun | 脚本运行时 | `brew install oven-sh/bun/bun` |
| curl | HTTP请求 | 系统自带 |
| jq | JSON处理 | `brew install jq` |

## 社交媒体抓取

| 平台 | 工具 | 说明 |
|------|------|------|
| 小红书 | baoyu-xhs-images | 需要登录cookie |
| X/Twitter | baoyu-danger-x | 需要登录状态 |
| YouTube | yt-dlp | 视频下载 |

## 数据分析

| 工具 | 用途 |
|------|------|
| Python 3.10+ | 数据处理 |
| pandas | 数据分析 |

## 环境变量

```bash
# 社交媒体（可选）
X_AUTH_TOKEN=your_token
XHS_COOKIE=your_cookie

# 搜索API（可选）
SERPER_API_KEY=your_key
TAVILY_API_KEY=your_key
```

---

_尚机局·谨妃_
