# Queen决策算法升级方案

---

## 升级概述

本方案升级Queen的决策能力，从简单任务路由升级为多维度智能决策系统。

---

## 当前决策模型（v1.0）

```
威帝指令 → 关键词匹配 → 分配给对应Agent → 执行 → 反馈
```

**局限性：**
- 单维度匹配，忽略任务复杂度
- 无负载均衡能力
- 缺乏决策质量评估

---

## 升级后决策模型（v2.0）

### 多维度决策矩阵

| 维度 | 权重 | 评估方法 |
|------|------|----------|
| **任务类型** | 30% | 关键词+语义分析 |
| **任务复杂度** | 25% | 子任务数量+依赖关系 |
| **Agent负载** | 20% | 实时任务队列监控 |
| **历史成功率** | 15% | Agent历史表现数据 |
| **响应时间要求** | 10% | 截止时间紧迫度 |

### 决策算法流程

```
输入：威帝指令 + 上下文

Step 1: 任务解析
├── 提取关键词
├── 识别任务类型（coding/analysis/content/education/research/operation）
├── 评估复杂度（low/medium/high/critical）
└── 识别截止时间

Step 1.5: 团队组合识别（NEW）
├── 匹配团队组合触发关键词
├── 如果匹配成功：
│   ├── 激活预定义团队组合
│   ├── 加载团队配置文件
│   ├── 分配任务给团队Leader
│   └── 跳转到 Step 5（执行监控）
└── 如果无匹配，继续 Step 2

Step 2: Agent筛选
├── 基于任务类型筛选候选Agent
├── 检查Agent实时负载
├── 查询历史成功率
└── 计算综合得分

Step 3: 负载均衡
├── 检查候选Agent当前任务队列
├── 如果主选Agent负载>80%，选择备选Agent
└── 记录负载分配日志

Step 4: 任务分配
├── 生成任务分配指令
├── 设置预期完成时间
├── 建立监控机制
└── 发送分配通知

Step 5: 执行监控
├── 定期检查执行进度
├── 检测异常和延迟
├── 必要时触发重分配
└── 记录执行日志

Step 6: 结果评估
├── 收集执行结果
├── 评估完成质量
├── 更新Agent历史数据
└── 生成反馈报告
```

---

## 团队组合触发机制（v2.1 新增）

### 团队组合映射表

| 团队组合 | 触发关键词 | Leader | 成员 | 配置文件 |
|---------|-----------|--------|------|---------|
| **Startup MVP 团队** | MVP、快速上线、创业项目、快速验证 | 慧妃 | 慧妃、仪妃、昭妃、司证师 | startup-mvp-team.json |
| **内容营销团队** | 内容营销、品牌推广、用户增长、内容创作 | 令妃 | 令妃、昭妃、司增师、司实师 | content-marketing-team.json |
| **企业级开发团队** | 企业级开发、大型系统、复杂业务、系统重构 | 贵妃 | 贵妃、慧妃、仪妃、司安师 | enterprise-dev-team.json |
| **数据分析团队** | 数据分析、数据洞察、决策支持、BI | 谨妃 | 谨妃、慧妃、司试师、司证师 | data-analysis-team.json |
| **教育培训团队** | 教育培训、课程开发、能力提升、培训体系 | 令妃 | 令妃、司课师、司讲师、司规师 | education-training-team.json |
| **融资路演团队** | 融资路演、投资对接、商业计划、融资准备 | 贵妃 | 贵妃、昭妃、司投师、司证师 | fundraising-team.json |

### 团队组合识别算法

```python
def identify_team_composition(instruction):
    # 加载团队组合配置
    team_configs = load_team_compositions()
    
    # 匹配触发关键词
    for team in team_configs:
        for trigger_keyword in team.trigger:
            if trigger_keyword in instruction:
                return {
                    "team": team.name,
                    "leader": team.leader,
                    "agents": team.agents,
                    "workflow": team.workflow,
                    "config_file": team.config_file
                }
    
    return None  # 无匹配，继续单Agent分配
```

### 团队组合激活流程

```
识别团队组合
    ↓
加载团队配置文件（.claw/workspace/team-compositions/{config_file}）
    ↓
通知团队Leader（发送任务指令 + 团队配置）
    ↓
Leader协调团队成员
    ↓
按工作流程执行
    ↓
定期同步进度（每日/每周）
    ↓
质量审计贯穿全程
    ↓
最终成果验收
    ↓
汇报Queen
```

### 团队组合优先级

当指令同时匹配单Agent和团队组合时，优先级规则：

1. **明确指定**：如果指令明确指定团队组合（如 @Startup-MVP-Team），优先使用团队组合
2. **复杂度判断**：如果任务复杂度 ≥ high，优先使用团队组合
3. **关键词强度**：如果匹配团队组合的触发关键词 ≥ 2 个，优先使用团队组合
4. **默认行为**：其他情况使用单Agent分配

---

## 任务类型识别规则

| 类型 | 关键词 | 主责Agent | 备选Agent |
|------|--------|-----------|-----------|
| **coding** | 代码、开发、bug、API、部署 | 慧妃 | 尚科 |
| **analysis** | 分析、数据、财务、投资、风险 | 贵妃 | 尚融 |
| **content** | 内容、文案、PPT、视频、宣传 | 仪妃 | 尚宣 |
| **education** | 教育、培训、课程、学习、考试 | 令妃 | 尚教 |
| **research** | 研究、调研、市场、竞品、情报 | 谨妃 | 尚机 |
| **operation** | 流程、协调、资源、项目、运维 | 昭妃 | 尚宫 |
| **audit** | 审计、合规、检查、风险、标准 | 御鉴 | Queen |

---

## 复杂度评估算法

```python
def evaluate_complexity(task):
    score = 0
    
    # 子任务数量
    subtask_count = count_subtasks(task)
    if subtask_count > 5: score += 3
    elif subtask_count > 2: score += 2
    else: score += 1
    
    # 依赖关系
    dependencies = count_dependencies(task)
    if dependencies > 3: score += 3
    elif dependencies > 1: score += 2
    else: score += 1
    
    # 预计时间
    estimated_hours = estimate_time(task)
    if estimated_hours > 8: score += 3
    elif estimated_hours > 2: score += 2
    else: score += 1
    
    # 跨局协作
    if requires_cross_bureau(task): score += 2
    
    # 决策影响
    if has_high_impact(task): score += 2
    
    # 映射到复杂度级别
    if score >= 10: return "critical"
    elif score >= 7: return "high"
    elif score >= 4: return "medium"
    else: return "low"
```

---

## 负载均衡策略

### Agent负载状态

| 负载率 | 状态 | 策略 |
|--------|------|------|
| 0-50% | 空闲 | 优先分配新任务 |
| 50-80% | 正常 | 正常分配 |
| 80-95% | 繁忙 | 仅分配紧急任务 |
| 95-100% | 过载 | 暂停分配 |

### 负载查询接口

```json
{
  "agent": "慧妃",
  "currentLoad": 65,
  "queueLength": 3,
  "estimatedFreeTime": "2026-05-17T20:00:00Z",
  "recentSuccessRate": 0.92
}
```

---

## 决策质量评估

### 评估指标

| 指标 | 计算方法 | 目标值 |
|------|----------|--------|
| **任务完成率** | 完成任务数/分配任务数 | > 95% |
| **按时完成率** | 按时完成任务数/完成任务数 | > 90% |
| **质量评分** | 用户满意度平均分 | > 4.0/5.0 |
| **重分配率** | 重分配任务数/总任务数 | < 5% |

### 决策反馈循环

```
任务完成 → 质量评估 → 更新Agent历史数据 → 调整决策权重 → 优化下次决策
```

---

## 异常处理机制

| 异常类型 | 检测条件 | 处理策略 |
|----------|----------|----------|
| **Agent无响应** | 心跳超时30秒 | 自动重分配 |
| **任务超时** | 超过预期时间50% | 升级通知+重分配 |
| **质量不达标** | 评分<3.0 | 记录+重新执行 |
| **资源冲突** | 多任务竞争同一资源 | 排队+优先级调度 |

---

## 升级实施计划

| 阶段 | 内容 | 时间 |
|------|------|------|
| **Phase 1** | 多维度决策矩阵上线 | Week 1-2 |
| **Phase 2** | 负载均衡机制部署 | Week 3-4 |
| **Phase 3** | 决策质量评估上线 | Week 5-6 |
| **Phase 4** | 异常处理完善 | Week 7-8 |

---

## 预期收益

| 指标 | 当前 | 目标 | 提升 |
|------|------|------|------|
| 任务分配准确率 | 75% | 92% | +17% |
| 平均响应时间 | 5分钟 | 2分钟 | -60% |
| 任务完成率 | 85% | 95% | +10% |
| 资源利用率 | 60% | 80% | +20% |

---

_Config by Queen 👑_
_Created: 2026-05-17_
_Updated: 2026-05-18_
_Version: 2.1_
