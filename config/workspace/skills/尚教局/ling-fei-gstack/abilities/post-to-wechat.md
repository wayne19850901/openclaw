# 公众号发布

## 概述

发布内容到微信公众号，支持文章和图文两种模式。

## 使用方式

```bash
# 文章模式（Markdown或HTML）
/baoyu-post-to-wechat path/to/article.md

# 图文模式（多图）
/baoyu-post-to-wechat --images ./images/
```

## 发布方式

| 方式 | 速度 | 要求 |
|------|------|------|
| **API**（推荐） | 快 | API凭证 |
| **浏览器** | 慢 | Chrome，登录会话 |

## 工作流程

### 步骤0：加载偏好

检查 EXTEND.md 配置：
- 默认主题/颜色
- 默认发布方式
- 默认作者
- 评论开关

### 步骤1：确定输入类型

| 输入类型 | 检测方式 |
|----------|----------|
| HTML文件 | 路径以 `.html` 结尾 |
| Markdown文件 | 路径以 `.md` 结尾 |
| 纯文本 | 非文件路径 |

### 步骤2：选择发布方式

**API方式**：
```bash
bun scripts/wechat-api.ts <file> --theme <theme> [--color <color>]
```

**浏览器方式**：
```bash
bun scripts/wechat-article.ts --markdown <file> --theme <theme>
```

### 步骤3：解析元数据

从 frontmatter 或 HTML meta 标签解析：
- 标题
- 摘要
- 作者
- 封面图

### 步骤4：发布

- API方式：直接调用微信API
- 浏览器方式：自动化浏览器操作

### 步骤5：完成报告

```
公众号发布完成！

输入：{type} - {path}
方式：API/浏览器
主题：{theme name}

文章：
• 标题：{title}
• 摘要：{summary}
• 图片：{N} 张

结果：
✓ 草稿已保存到微信公众号

下一步：
→ 管理草稿：https://mp.weixin.qq.com
```

## 主题选项

| 主题 | 风格 |
|------|------|
| `default` | 默认 |
| `grace` | 优雅 |
| `simple` | 简约 |
| `modern` | 现代 |

## 颜色预设

blue, green, vermilion, yellow, purple, sky, rose, olive, black, gray, pink, red, orange（或十六进制值）

## 多账号支持

EXTEND.md 支持管理多个公众号：

```yaml
accounts:
  - name: 宝玉的技术分享
    alias: baoyu
    default: true
    app_id: your_app_id
    app_secret: your_app_secret
  - name: AI工具集
    alias: ai-tools
    app_id: another_app_id
    app_secret: another_app_secret
```

## 与 gstack 联动

文档发布后，可衔接 `document-release` 进行上线审核：
```
post-to-wechat → document-release（检查公众号文章与课程文档一致性）
```

---

_来源：release-skills/baoyu-post-to-wechat_
