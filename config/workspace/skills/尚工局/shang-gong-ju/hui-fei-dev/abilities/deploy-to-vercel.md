# 应用部署到Vercel

## 概述

将任何项目部署到Vercel。**始终部署为预览**（非生产），除非用户明确要求生产部署。

## 工作流程

### 步骤1：收集项目状态

运行所有四个检查：

```bash
# 1. 检查git remote
git remote get-url origin 2>/dev/null

# 2. 检查是否已链接到Vercel项目
cat .vercel/project.json 2>/dev/null || cat .vercel/repo.json 2>/dev/null

# 3. 检查Vercel CLI是否安装并认证
vercel whoami 2>/dev/null

# 4. 列出可用团队
vercel teams list --format json 2>/dev/null
```

### 步骤2：选择部署方法

#### 情况A：已链接 + 有git remote → Git推送

这是理想状态。项目已链接且有git集成。

1. **推送前询问用户**：
   ```
   这个项目通过git连接到Vercel。我可以提交并推送来触发部署。要继续吗？
   ```

2. **提交并推送**：
   ```bash
   git add .
   git commit -m "deploy: <变更描述>"
   git push
   ```

3. **获取预览URL**：
   ```bash
   sleep 5
   vercel ls --format json
   ```
   找到最新条目的 `url` 字段。

#### 情况B：已链接 + 无git remote → `vercel deploy`

```bash
vercel deploy [path] -y --no-wait
```

然后用 `vercel inspect <url>` 检查状态。

#### 情况C：未链接 + CLI已认证 → 先链接，再部署

1. **询问用户选择团队**（如果有多个）
2. **链接项目**：
   ```bash
   # 如果有git remote
   vercel link --repo --scope <team-slug>
   # 如果没有git remote
   vercel link --scope <team-slug>
   ```
3. **部署**：使用情况A或情况B的方法

#### 情况D：未链接 + CLI未认证 → 安装、认证、链接、部署

1. **安装CLI**：
   ```bash
   npm install -g vercel
   ```

2. **认证**：
   ```bash
   vercel login
   ```

3. **继续情况C的流程**

## 输出格式

总是向用户显示部署URL：

```
部署成功！

预览URL: https://my-app-abc123.vercel.app
[认领URL（如适用）: https://vercel.com/claim-deployment?code=...]

在预览URL查看你的站点。
```

**不要**curl或获取部署的URL来验证它是否工作。只需返回链接。

## 团队选择

如果用户属于多个团队，列出所有可用团队slug并询问要部署到哪个。用户选择后立即继续下一步。

## 故障排除

| 问题 | 解决方案 |
|------|----------|
| CLI认证失败 | 使用无认证回退脚本 |
| 网络出口错误 | 在允许域中添加 *.vercel.com |
| CLI未安装 | `npm install -g vercel` |

---

_来源：vercel-agent-skills/deploy-to-vercel_
