# 尚宣局工具依赖

## 核心工具

| 工具 | 版本要求 | 用途 |
|------|----------|------|
| Bun | latest | 脚本运行时 |
| Chrome | 最新版 | 公众号发布（浏览器方式） |

## 图片生成

需要配置图片生成API：

```bash
# 环境变量（选择一个配置）
OPENAI_API_KEY=your_key          # DALL-E
REPLICATE_API_TOKEN=your_token   # Stable Diffusion
```

## 公众号发布

```bash
# API方式
WECHAT_APP_ID=your_app_id
WECHAT_APP_SECRET=your_app_secret

# 浏览器方式
# 需要Chrome浏览器
CHROME_PATH=/path/to/chrome      # 可选，自动检测
```

## 安装命令

```bash
# 安装Bun
brew install oven-sh/bun/bun

# 或使用npx
npx bun
```

---

_尚宣局·仪妃_
