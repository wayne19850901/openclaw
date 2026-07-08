# gstack-pair-agent 精简参考指南

> 完整版：`~/.claude/skills/gstack/pair-agent/SKILL.md`

## 工作流程（5步）

```
Step 1: 启动 Chromium → Step 2: 连接远程 Agent → Step 3: 共享浏览 → Step 4: 协作操作 → Step 5: 结束会话
```

## 启动命令

```bash
# 启动带侧边栏的 Chromium
pair-agent start

# 查看状态
pair-agent status

# 结束会话
pair-agent stop
```

## 远程 Agent 连接

### AskUserQuestion 格式（关键）

远程 Agent 通过 AskUserQuestion 与本地协作：

```json
{
  "type": "AskUserQuestion",
  "question": "请打开 https://example.com 并截图",
  "options": ["已打开", "遇到错误"],
  "defaultOption": "已打开"
}
```

本地 Agent 收到后执行操作，返回结果。

### 协作模式

| 模式 | 描述 | 用例 |
|------|------|------|
| **同机协作** | 本地启动，远程Agent同机连接 | 本地开发调试 |
| **远程协作** | 本地启动，远程Agent跨机器连接 | 分布式团队协作 |
| **反向连接** | 远程启动，本地连接 | 远程服务器调试 |

## 输出格式

### 同机模式
```
✅ Chromium 已启动（PID: XXXX）
📍 URL: https://localhost:9222
🤖 远程 Agent 已连接
```

### 远程模式
```
✅ Chromium 已启动
🔗 WebSocket: ws://IP:9222
🤖 等待远程 Agent 连接...
```

## 平台注意事项

| 平台 | 特殊处理 |
|------|----------|
| macOS | 需授权 Accessibility 权限 |
| Windows | 需关闭原生浏览器自动启动 |
| Linux | 无 GUI 时使用 headless |

## 禁止操作

- ❌ 禁止访问本地敏感文件（密码、密钥）
- ❌ 禁止执行远程 Agent 的 shell 命令（仅浏览器操作）
- ❌ 禁止自动提交表单（需用户确认）

## 常见用例

### 1. 远程 QA 协作
```
本地：pair-agent start → 打开测试页面
远程：通过 WebSocket 连接 → 执行测试操作 → 返回结果
本地：截图保存 → 结束会话
```

### 2. 分布式开发调试
```
本地：启动 → 打开开发页面
远程：连接 → 检查 UI → 提出修改建议
本地：修改代码 → 刷新页面 → 验证效果
```

### 3. 跨时区协作
```
本地：启动 → 保存 WebSocket URL
远程（不同时区）：稍后连接 → 继续调试
```

## 侧边栏功能

- **实时活动日志**：记录所有操作
- **聊天窗口**：与远程 Agent 通信
- **截图预览**：快速查看截图结果

## 注意事项

- **WebSocket 端口**：默认 9222，防火墙需开放
- **会话持久性**：Chromium 关闭后会话结束
- **安全边界**：远程 Agent 仅限浏览器操作，无 shell 权限