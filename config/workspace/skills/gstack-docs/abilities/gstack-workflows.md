# gstack 核心工作流

## review — 代码审查

### 触发词

- 代码审查
- diff 检查
- review
- 审查代码

### 流程

```
Step 0: 检测平台与基分支
  ↓
Step 1: 获取 diff
  ↓
Step 2: 独立审查（不依赖用户输入）
  ↓
Step 3: 输出审查报告
  ↓
Step 4: Pass/Fail 门控
```

### 门控规则

- **Pass** — 所有审查项通过
- **Fail** — 任一阻塞项失败

---

## ship — 发布流程

### 触发词

- 发布
- 部署
- PR
- ship
- 上线

### 流程

```
Step 0: 检测平台与基分支
  ↓
Step 1: Pre-flight 检查
  ↓
Step 2: 运行测试
  ↓
Step 3: Review（可选）
  ↓
Step 4: 提交变更
  ↓
Step 5: 推送到远程
  ↓
Step 6: 创建 PR/MR
  ↓
Step 7: 输出发布报告
```

### 关键规则

- 测试失败则 STOP
- Review 失败则 STOP
- 不跳过 hooks（`--no-verify`）
- 不强制推送（`--force`）

---

## qa — QA 测试

### 触发词

- 测试
- 验证
- qa
- QA
- 测试页面

### 流程

```
Step 0: 启动应用（如未运行）
  ↓
Step 1: 打开页面
  ↓
Step 2: 截图快照
  ↓
Step 3: 执行交互操作
  ↓
Step 4: 验证结果
  ↓
Step 5: 输出测试报告
```

### 关键能力

- 打开任意 URL
- 点击元素
- 填写表单
- 截图对比
- 验证页面状态

---

## office-hours — YC Office Hours

### 触发词

- 创业咨询
- 产品想法
- office-hours
- YC

### 六问框架

1. **你的产品是什么？** — 一句话说清楚
2. **谁会用？** — 目标用户画像
3. **为什么现在做？** — 时机窗口
4. **你怎么获客？** — 增长策略
5. **你的优势是什么？** — 竞争壁垒
6. **什么会让你失败？** — 风险因素

### 模式

| 模式 | 说明 |
|------|------|
| **Startup** | 创业想法验证，输出设计文档 |
| **Builder** | 个人项目咨询，追踪建造者画像 |

---

## plan-ceo-review — CEO 计划评审

### 触发词

- CEO 评审
- 计划评审
- plan-ceo-review
- 战略评审

### 四种模式

| 模式 | 说明 |
|------|------|
| **SCOPE EXPANSION** | 扩大范围，发现遗漏机会 |
| **SELECTIVE EXPANSION** | 选择性扩大，部分机会值得追加 |
| **HOLD SCOPE** | 保持范围，当前范围已足够 |
| **SCOPE REDUCTION** | 缩小范围，范围过大需削减 |

### 11 个审查部分

1. Problem Statement（问题陈述）
2. Target User（目标用户）
3. Solution Overview（方案概览）
4. Success Metrics（成功指标）
5. Scope（范围）
6. Non-Goals（非目标）
7. Risks（风险）
8. Dependencies（依赖）
9. Alternatives（替代方案）
10. Open Questions（开放问题）
11. Outside Voice（外部视角）

---

## autoplan — 自动评审流水线

### 触发词

- 自动评审
- 全流程评审
- autoplan
- 自动计划

### 四阶段

```
Phase 1: CEO Review
  ↓
Phase 2: Design Review
  ↓
Phase 3: Eng Review
  ↓
Phase 4: DX Review
```

### 六大决策原则

1. **保守默认** — 有疑问时默认保守选项
2. **范围优先** — 范围变更优先询问
3. **证据驱动** — 基于证据而非假设
4. **一致性** — 与已有决策保持一致
5. **可逆性** — 优先可逆决策
6. **品味校准** — 跨模型分歧时标记品味决策

---

## design-review — 设计审查

### 触发词

- 设计审查
- 视觉 QA
- design-review
- 设计 QA

### 检查项

- 视觉一致性
- 间距问题
- 层级问题
- AI slop 模式
- 慢交互

### 流程

```
打开页面 → 截图 → 检测问题 → 修复 → 验证
```

---

## learn — 经验沉淀

### 触发词

- 经验沉淀
- 项目学习
- learn
- 学到了什么

### 命令

| 命令 | 说明 |
|------|------|
| `review` | 回顾学习记录 |
| `search` | 搜索学习记录 |
| `prune` | 清理学习记录 |
| `export` | 导出学习记录 |

---

## document-generate — 文档生成

### 触发词

- 文档生成
- 教程生成
- document-generate
- 写文档

### Diataxis 四象限

| 象限 | 类型 | 用户需求 |
|------|------|----------|
| **Tutorial** | 教程 | 学习导向：我想学会 |
| **How-to** | 操作指南 | 任务导向：我想解决 |
| **Reference** | 参考文档 | 信息导向：我想查阅 |
| **Explanation** | 解释文档 | 理解导向：我想理解 |

---

## document-release — 文档发布

### 触发词

- 文档发布
- 上线审核
- document-release
- 发布文档

### 流程

```
Diff 分析 → 覆盖度地图 → 逐文件审核 → CHANGELOG 润色 → 版本确认 → 提交
```

### 关键规则

- **绝不覆盖 CHANGELOG** — 只润色措辞
- **绝不静默升级版本** — 必须询问用户
- **覆盖度地图只标记缺口** — 不自动生成缺失文档

---

_来源：gstack 方法论知识库_
