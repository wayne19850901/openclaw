# Vercel部署指南

## 部署方式对比

| 方式 | 适用场景 | 复杂度 |
|------|----------|--------|
| Git推送 | 持续部署 | 简单 |
| CLI部署 | 临时预览 | 中等 |
| API部署 | 自动化流程 | 复杂 |

## Git推送部署

### 配置步骤

```bash
# 1. 链接项目
vercel link

# 2. 推送代码
git add .
git commit -m "deploy: update"
git push

# 3. 自动部署触发
```

### 环境变量

```bash
# 在Vercel Dashboard设置环境变量
# 或使用CLI
vercel env add VARIABLE_NAME
```

## CLI部署

### 基本命令

```bash
# 预览部署
vercel deploy

# 生产部署
vercel deploy --prod

# 指定项目
vercel deploy --scope team-slug
```

### 常用选项

| 选项 | 说明 |
|------|------|
| `--prod` | 生产环境部署 |
| `--no-wait` | 不等待构建完成 |
| `--scope` | 指定团队 |
| `--force` | 强制部署（无变化也部署） |

## 项目配置

### vercel.json

```json
{
  "version": 2,
  "builds": [
    { "src": "package.json", "use": "@vercel/next" }
  ],
  "routes": [
    { "src": "/api/(.*)", "dest": "/api/$1" }
  ]
}
```

### 环境变量

| 变量 | 说明 |
|------|------|
| `VERCEL_TOKEN` | API令牌 |
| `VERCEL_ORG_ID` | 团队ID |
| `VERCEL_PROJECT_ID` | 项目ID |

## 常见问题

| 问题 | 解决方案 |
|------|----------|
| 构建失败 | 检查build命令、依赖版本 |
| 路由404 | 配置vercel.json路由 |
| 环境变量缺失 | 在Dashboard添加 |
| 域名绑定 | Project Settings → Domains |

---

_尚科局·慧妃参考_
