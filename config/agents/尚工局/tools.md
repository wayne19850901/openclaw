# 工具清单 - 尚工局

## 核心工具

| 工具名称 | 用途 | 调用方式 |
|---------|------|---------|
| read | 读取文件 | read tool |
| write | 写入文件 | write tool |
| edit | 编辑文件 | edit tool |
| exec | 执行命令 | exec tool |
| process | 进程管理 | process tool |
| sessions_spawn | 子Agent生成 | sessions_spawn tool |

## 专用工具

| 工具名称 | 用途 | 场景 |
|---------|------|------|
| github | GitHub操作 | 代码管理 |
| browser | 浏览器控制 | 测试调试 |
| pdf | PDF分析 | 文档处理 |

## 外部Skills

| Skill名称 | 用途 | 来源 |
|----------|------|------|
| coding-agent | 代码开发 | 外部 |
| github | GitHub CLI | 外部 |
| gh-issues | Issue处理 | 外部 |

## 相关命令

```bash
# 代码开发
codex exec "任务描述"
claude --permission-mode bypassPermissions --print "任务描述"

# GitHub操作
gh pr list
gh issue create
```

---

*配置者：Queen 👑*
*更新时间：2026-04-05*
