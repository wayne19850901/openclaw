---
name: 六局一司收尾与实战演练计划
overview: 完成知识库最后1篇文档、测试Multica集成、启动Agent实战演练
todos:
  - id: create-knowledge-maintenance-method
    content: 创建知识库维护方法文档（AI工作流/知识库维护方法.md）并更新index.md和log.md
    status: completed
  - id: install-multica-cli
    content: 安装Multica CLI并完成setup配置
    status: completed
    dependencies:
      - create-knowledge-maintenance-method
  - id: register-test-agents
    content: 在Multica注册测试Agent（queen和hui-fei）并验证状态
    status: completed
    dependencies:
      - install-multica-cli
  - id: execute-test-tasks
    content: 执行Multica测试任务（简单任务、复杂任务、Squad协作）并验证结果
    status: completed
    dependencies:
      - register-test-agents
  - id: design-drill-tasks
    content: 为7个局司设计实战演练任务并分配给对应Agent
    status: completed
    dependencies:
      - execute-test-tasks
  - id: execute-drill-tasks
    content: 执行Agent实战演练并监控执行过程
    status: completed
    dependencies:
      - design-drill-tasks
  - id: evaluate-drill-results
    content: 评估演练结果并生成完成报告
    status: completed
    dependencies:
      - execute-drill-tasks
---

## 用户需求

用户要求完成三项后续任务：

1. **完成最后1篇知识文档（知识库维护方法）**

- 创建 `AI工作流/知识库维护方法.md`
- 使知识库达到100%完成率（24/24篇）

2. **测试Multica集成（Agent注册 + 任务执行）**

- 安装Multica CLI
- 注册测试Agent（至少2个）
- 执行测试任务验证集成

3. **启动Agent实战演练（各局司执行实际业务任务）**

- 为7个局司设计演练任务
- 通过openclaw或Multica执行
- 评估演练结果

## 当前状态

- 知识库：23/24篇完成（95.8%）
- Multica配置：14 Agent + 8 Squad已准备
- Skills：31个已按局司分类
- Agent目录：14个Agent已有memory目录
- openclaw已安装，multica未安装

## 技术方案

### 1. 知识库维护方法文档创建

**技术路径**：

- 基于 `KNOWLEDGE.md` 规范创建实操指南
- 文档路径：`~/.claw/workspace/knowledge-base/wiki/AI工作流/知识库维护方法.md`
- 格式遵循知识库标准（标题、日期、标签、章节结构）

**核心内容**：

- 维护流程（新增/更新/删除）
- 质量检查清单
- 自动化维护脚本示例
- 维护权限矩阵
- 常见维护场景

### 2. Multica集成测试

**技术路径**：

- 安装：`brew install multica-ai/tap/multica`
- 配置：使用现有 `multica-agent-profiles.json`
- 测试：Agent注册 + 任务执行 + 结果验证

**集成架构**：

```
Multica Web → Agent Daemon → OpenClaw Backend → Knowledge Base
```

**测试策略**：

- L1测试：queen（全局统筹）
- L2测试：hui-fei（技术开发）
- Squad测试：技术团队（hui-fei + shang-ke）

### 3. Agent实战演练

**技术路径**：

- 方式A：openclaw命令行（`openclaw agent --agent <id> --local`）
- 方式B：Multica Web（推荐，可视化执行）

**演练设计**：

- 每个局司设计1个实际业务任务
- 任务需调用知识库和Skills
- 产出可量化文档

**评估标准**：

- 完成度、质量度、效率度、学习度

## Agent Extensions

### Skill

- **writing-skills**
- Purpose: 创建知识库维护方法文档，确保格式和质量符合标准
- Expected outcome: 生成符合知识库规范的维护方法文档

### Skill

- **verification-before-completion**
- Purpose: 验证知识库完整性、Multica集成成功、演练任务完成
- Expected outcome: 确认所有任务达到成功标准

### Skill

- **executing-plans**
- Purpose: 按Phase顺序执行计划，设置检查点
- Expected outcome: 分阶段完成三项任务