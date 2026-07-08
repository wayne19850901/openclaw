# gstack Review 完整指南

## 来源

整合自 `~/.claw/workspace/skills/gstack/review/SKILL.md`

## 核心概念

gstack review 是一个系统化的 pre-landing PR 审查工作流，确保代码在合并前经过严格的质量检查。

## 关键审查类别

### SQL安全
- SQL注入检测
- 事务隔离级别检查
- 连接池泄漏检测
- 参数化查询验证

### 竞态条件
- 锁粒度评估
- 原子操作验证
- TOCTOU（Time-of-check to time-of-use）检测
- 并发安全审查

### LLM信任边界
- 输入验证与清洗
- 输出转义与编码
- Prompt注入防护
- 模型输出不可信假设

### Shell注入
- 命令构造安全
- 参数转义验证
- 环境变量安全
- 子进程调用审查

## 专家派遣系统

| 专家 | 职责 |
|------|------|
| testing | 测试覆盖、边界条件、mock策略 |
| security | 安全漏洞、权限检查、数据保护 |
| performance | 性能瓶颈、资源泄漏、可扩展性 |

## 对抗审查

使用Claude/Codex交叉验证，确保审查质量：
1. 主审查员完成审查
2. 交叉验证员独立审查
3. 合并审查意见
4. 解决分歧

## 使用方式

当需要执行代码审查时：
1. 读取完整指令：`~/.claw/workspace/skills/gstack/review/SKILL.md`
2. 按指令执行审查流程
3. 输出标准化审查报告
