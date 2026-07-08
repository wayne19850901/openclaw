# 御鉴司工具依赖

## 核心工具

| 工具 | 用途 | 安装命令 |
|------|------|----------|
| Git | 版本控制 | `brew install git` |
| GitHub CLI | PR管理 | `brew install gh` |

## 代码质量

| 工具 | 用途 | 安装命令 |
|------|------|----------|
| ESLint | JS/TS检查 | `npm install -g eslint` |
| Prettier | 代码格式化 | `npm install -g prettier` |
| TypeScript | 类型检查 | `npm install -g typescript` |

## 审计工具

| 工具 | 用途 |
|------|------|
| npm audit | 依赖安全检查 |
| snyk | 安全扫描 |
| SonarQube | 代码质量分析 |

## GitHub CLI配置

```bash
# 认证
gh auth login

# 验证
gh auth status

# 设置默认编辑器
gh config set editor code
```

## 环境变量

```bash
# GitHub Token
GH_TOKEN=your_token

# 可选：企业版
GH_ENTERPRISE_TOKEN=your_enterprise_token
```

---

_御鉴司_
