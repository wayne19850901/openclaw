# gstack/qa 完整指南

## 概述

**名称**：QA test and fix
**版本**：2.0.0
**角色**：QA 工程师 + Bug 修复工程师，测试→修复→验证闭环

**核心定位**：
- 像真实用户一样测试——点击一切、填写每个表单、检查每个状态
- 每个问题都需要截图证据
- 原子提交——一个 bug 一个 commit

## 参数选项

| 参数 | 说明 |
|------|------|
| `/qa` | 标准模式（严重+高危+中危） |
| `/qa --quick` | 快速模式（仅严重+高危） |
| `/qa --exhaustive` | 穹尽模式（含低危/外观） |
| `/qa --regression <file>` | 回归模式（对比基线） |
| `/qa http://localhost:3000` | 指定 URL |
| `/qa Focus on billing page` | 聚焦特定页面 |

## 模式详解

### Diff-aware（默认，无 URL 时）

当用户说 `/qa` 且在功能分支上：
1. 分析分支 diff → 理解变更
2. 识别受影响页面/路由
3. 检测运行中的本地应用
4. 测试每个受影响页面
5. 报告发现（范围限定到分支变更）

### Full（提供 URL 时）

系统化探索，访问所有可达页面，记录 5-10 个有证据的问题，产出健康评分。耗时 5-15 分钟。

### Quick

30 秒冒烟测试，访问首页 + top 5 导航目标，检查：页面加载？控制台错误？断链？产出健康评分。

### Regression

加载上次基线，对比：哪些问题已修复？哪些是新增？评分 delta？

## 工作流程

### Phase 0: 平台检测 + 基础分支

检测 Git 托管平台（GitHub/GitLab），确定基础分支。

### Phase 1: 初始化

- 查找 browse 二进制
- 创建输出目录
- 复制报告模板
- 启动计时器

### Phase 2: 认证

如需认证：
- 导入 cookie 文件
- 执行登录流程
- 处理 2FA/CAPTCHA

### Phase 3: 定向

- 导航到目标 URL
- 获取应用地图（links, snapshot）
- 检测框架（Next.js, Rails, WordPress, SPA）
- 检查控制台错误

### Phase 4: 探索

系统化访问页面，每页执行：
- 视觉扫描（布局问题）
- 交互元素（按钮、链接、控件）
- 表单（空值、无效值、边界情况）
- 导航（所有进出路径）
- 状态（空状态、加载、错误、溢出）
- 控制台（交互后 JS 错误）
- 响应式（移动端视口）

**深度判断**：核心功能（首页、仪表盘、结账、搜索）花更多时间，次要页面（关于、条款）花较少时间。

### Phase 5: 文档

每个问题立即记录：

**交互 bug**：
1. 截图 before
2. 执行动作
3. 截图 result
4. snapshot -D 显示变化
5. 写重现步骤

**静态 bug**：
1. 单张标注截图
2. 描述问题

### Phase 6: 汇总

- 计算健康评分（8 维度加权）
- 写 Top 3 Things to Fix
- 写控制台健康摘要
- 更新严重性计数
- 填充报告元数据
- 保存基线 JSON

### Phase 7: 分类

按严重性排序，根据模式选择修复范围：
- Quick：仅严重+高危
- Standard：+中危
- Exhaustive：+低危/外观

标记不可修复问题（第三方 widget bug、基础设施问题）为"deferred"。

### Phase 8: 修复循环

每个可修复问题，按严重性顺序：

**8a. 定位源码**
- Grep 错误消息、组件名、路由定义
- Glob 匹配文件模式

**8b. 修复**
- 阅读源码，理解上下文
- 最小修复——最小变更解决问题
- 不重构、不加功能、不"改进"无关事物

**8c. 提交**
```bash
git add <only-changed-files>
git commit -m "fix(qa): ISSUE-NNN — short description"
```

**8d. 重测**
- 导航回受影响页面
- before/after 截图对
- 检查控制台错误
- snapshot -D 验证变更效果

**8e. 分类**
- verified：重测确认修复有效，无新错误
- best-effort：修复已应用但无法完全验证
- reverted：检测到回归 → git revert HEAD → 标记"deferred"

**8e.5. 回归测试**

如分类为"verified"且非纯 CSS 修复且有测试框架：
1. 学习项目现有测试模式
2. 追踪 bug 的代码路径
3. 写回归测试（设置前置条件、执行动作、断言正确行为）
4. 仅运行新测试文件
5. Pass → 提交测试；Fail → 修复一次，仍失败 → 删除测试

**8f. 自我调节（WTF-likelihood）**

每 5 个修复后计算：
- 每个 revert: +15%
- 每个修复触及 >3 文件: +5%
- 第 15 个修复后: +1%/个
- 剩余低危: +10%
- 触及无关文件: +20%

**WTF > 20%**：停止，展示进度，询问是否继续。
**硬上限**：50 个修复。

### Phase 9: 最终 QA

- 重跑所有受影响页面
- 计算最终健康评分
- 如评分下降 → 警告回归

### Phase 10: 报告

**本地**：`.gstack/qa-reports/qa-report-{domain}-{date}.md`

**项目范围**：`~/.gstack/projects/{slug}/{user}-{branch}-test-outcome-{datetime}.md`

**PR 摘要**：
> "QA found N issues, fixed M, health score X → Y."

### Phase 11: TODOS.md 更新

- 新延期 bug → 添加为 TODO
- 已修复 bug → 标注修复信息

## 健康评分系统

### 评分维度

| 类别 | 权重 | 评分规则 |
|------|------|----------|
| Console | 15% | 0 错误→100；1-3→70；4-10→40；10+→10 |
| Links | 10% | 0 断链→100；每个断链→-15 |
| Visual | 10% | 100 起，每个发现扣分 |
| Functional | 20% | 100 起，每个发现扣分 |
| UX | 15% | 100 起，每个发现扣分 |
| Performance | 10% | 100 起，每个发现扣分 |
| Content | 5% | 100 起，每个发现扣分 |
| Accessibility | 15% | 100 起，每个发现扣分 |

### 扣分规则

- Critical issue → -25
- High issue → -15
- Medium issue → -8
- Low issue → -3

### 最终评分

`score = Σ (category_score × weight)`

## 框架特定指导

### Next.js

- 检查控制台 hydration 错误
- 监控 `_next/data` 请求 404
- 测试客户端导航（点击链接，不只是 goto）
- 检查 CLS

### Rails

- 检查 N+1 查询警告
- 验证 CSRF token
- 测试 Turbo/Stimulus 集成
- 检查 flash 消息

### WordPress

- 检查插件冲突
- 验证 admin bar
- 测试 REST API
- 检查 mixed content

### SPA

- 使用 snapshot -i 导航
- 检查 stale state
- 测试浏览器前进/后退
- 检查内存泄漏

## 输出结构

```
.gstack/qa-reports/
├── qa-report-{domain}-{date}.md
├── screenshots/
│   ├── initial.png
│   ├── issue-001-step-1.png
│   ├── issue-001-result.png
│   ├── issue-001-after.png
│   └── ...
└── baseline.json
```

## 重要规则

1. 每个问题都需要截图证据
2. 验证后再记录（重试一次确认可重现）
3. 不包含凭证（写 [REDACTED]）
4. 增量写入报告（不批量）
5. 不读源码（作为用户测试）
6. 每次交互后检查控制台
7. 像用户一样测试（真实数据、完整工作流）
8. 深度优于广度（5-10 有证据问题 > 20 模糊描述）
9. 不删除输出文件
10. 使用 snapshot -C 处理 tricky UI
11. 向用户展示截图（每次截图后 Read 输出文件）
12. 不拒绝使用浏览器

---

_质量测试，证据为王。_