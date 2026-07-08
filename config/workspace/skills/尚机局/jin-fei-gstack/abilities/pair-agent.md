# pair-agent — 远程 AI Agent 浏览器共享

## 触发词
- "共享浏览器"、"pair agent"、"协作测试"、"远程AI"
- "让另一个 agent 用我的浏览器"、"give browser access"

## 核心功能
与远程 AI agent 共享浏览器，实现跨平台协作测试：
- 一次性 setup key（5分钟过期）
- 24小时 session token
- 支持 OpenClaw/Codex/Cursor/Hermes
- 每个 agent 独立 tab，互不干扰

## 执行流程

```
1. 检查 browse server 状态
   $B status || $B goto about:blank

2. 询问目标 agent 类型
   - OpenClaw (local/remote)
   - Codex / OpenAI Agents
   - Cursor
   - Claude Code
   - 其他 (generic HTTP)

3. 询问连接方式
   - 同机器 → 直接写入配置文件
   - 不同机器 → 生成 instruction block + ngrok tunnel

4. 执行 pairing
   - 同机器: $B pair-agent --local TARGET_HOST
   - 不同机器: $B pair-agent --client TARGET_HOST

5. 输出 instruction block（完整输出，不截断）
```

## 输出格式

### 同机器成功
```
✅ Done. TARGET_HOST can now use your browser.
Credentials written to ~/.TARGET_HOST/skills/gstack/browse-remote.json
```

### 不同机器成功
```
════════════════════════════════════════════════════════════
SETUP_KEY: xxx
BROWSER_URL: https://xxx.ngrok.io
INSTRUCTIONS: ...
════════════════════════════════════════════════════════════

Copy the block above and paste into your other agent.
Setup key expires in 5 minutes.
```

## 禁令
- ❌ 禁止共享 session token 给未授权第三方
- ❌ 禁止在 setup key 过期后继续使用
- ❌ 禁止在 24小时 session 过期后继续操作

## 中度映射
实际执行时加载：`~/.claude/skills/gstack/pair-agent/SKILL.md`