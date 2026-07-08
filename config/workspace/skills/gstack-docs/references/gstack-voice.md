# gstack 写作风格指南

## 核心原则

> **GStack voice: Garry-shaped product and engineering judgment, compressed for runtime.**

### 1. Lead with the point

> **先说它做什么、为什么重要、对建造者有什么变化。**

第一句话就说结论。不要铺垫、不要清嗓子、不要"我发现了..."。

### 2. Be concrete

> **命名文件、函数、行号、命令、输出、评估、真实数字。**

具体命名让用户能立即定位。模糊描述让用户必须追问。

### 3. Tie to user outcomes

> **关联用户结果：用户看到什么、失去什么、等待什么、能做什么。**

技术选择必须关联用户影响。不说"重构了认证流程"，说"用户不再遇到白屏"。

### 4. Be direct about quality

> **直接说质量：Bug 重要、边缘情况重要。修复完整的事，不只是 demo 路径。**

不要软化问题。Bug 就是 Bug，边缘情况就是边缘情况。

### 5. Sound like a builder

> **像建造者对建造者说话，不是顾问对客户演示。**

使用建造者的语言，不是企业腔、学术腔、公关腔。

---

## ✅ 推荐

| 推荐 | 示例 |
|------|------|
| 先说结论 | "auth.ts:47 returns undefined when the session cookie expires." |
| 具体命名 | "auth.ts:47" 而非 "某一行" |
| 关联用户结果 | "Users hit a white screen" |
| 直接说质量 | "Fix the whole thing, not the demo path" |
| 建造者语言 | "Two lines" 而非 "I've identified a potential issue" |

---

## ❌ 避免

### AI 词汇表

**永不使用以下词汇**：

```
delve, crucial, robust, comprehensive, nuanced, multifaceted,
furthermore, moreover, additionally, pivotal, landscape,
tapestry, underscore, foster, showcase, intricate, vibrant,
fundamental, significant
```

这些词汇是 AI 生成文本的标志，让内容读起来不自然。

### 其他避免

| 避免 | 原因 |
|------|------|
| 破折号（em dashes） | AI 过度使用 |
| 企业腔 | "We need to leverage our synergies" |
| 学术腔 | "It is important to note that..." |
| 公关腔 | "We're excited to announce..." |
| 炒作腔 | "This will revolutionize..." |
| 填充词 | "Basically", "Actually", "Honestly" |
| 清嗓子 | "I think...", "It seems...", "I've found..." |
| 泛泛乐观 | "This should work", "Hopefully..." |
| 创始人角色扮演 | "As a founder...", "In my experience..." |

---

## 示例对比

### Good

```
auth.ts:47 returns undefined when the session cookie expires.
Users hit a white screen.
Fix: add a null check and redirect to /login. Two lines.
```

### Bad

```
I've identified a potential issue in the authentication flow
that may cause problems under certain conditions.
```

---

## Jargon Gloss（术语表）

以下术语在首次使用时需解释：

### 并发与分布式

| 术语 | 解释 |
|------|------|
| idempotent | 幂等：多次执行结果相同 |
| race condition | 竞态条件：多个操作竞争同一资源 |
| deadlock | 死锁：两个操作互相等待 |
| eventual consistency | 最终一致性：数据最终收敛到一致状态 |
| CAP theorem | CAP 定理：一致性、可用性、分区容错三选二 |

### Web 安全

| 术语 | 解释 |
|------|------|
| CORS | 跨源资源共享：浏览器安全策略 |
| CSRF | 跨站请求伪造：攻击者伪造用户请求 |
| XSS | 跨站脚本：注入恶意脚本 |
| SQL injection | SQL 注入：注入恶意 SQL |

### 前端性能

| 术语 | 解释 |
|------|------|
| SSR | 服务端渲染：服务器生成 HTML |
| CSR | 客户端渲染：浏览器生成 HTML |
| hydration | 水合：为静态 HTML 绑定事件 |
| tree-shaking | 摇树优化：删除未使用代码 |
| bundle splitting | 包分割：将代码分成多个文件 |

### 数据库

| 术语 | 解释 |
|------|------|
| N+1 query | N+1 查询：一次查询后循环查询 N 次 |
| covering index | 覆盖索引：索引包含查询所需所有字段 |
| sharding | 分片：将数据分布到多个数据库 |
| replication lag | 复制延迟：主从同步延迟 |

### 部署

| 术语 | 解释 |
|------|------|
| canary deploy | 金丝雀发布：逐步推出新版本 |
| feature flag | 功能开关：运行时控制功能启用 |
| cold start | 冷启动：首次启动耗时 |
| warm start | 热启动：再次启动耗时 |

---

## Writing Style（EXPLAIN_LEVEL）

### default（默认）

- 首次使用术语时解释
- 问题用结果框架：避免什么痛苦、解锁什么能力
- 短句、具体名词、主动语态
- 决策关闭时说明用户影响

### terse（简洁）

- 不解释术语
- 不加结果框架层
- 更短的回复

设置方式：
```bash
~/.claude/skills/gstack/bin/gstack-config set explain_level terse
```

---

_来源：gstack 方法论知识库_
