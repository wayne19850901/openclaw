# 质量测试（/qa）

## 触发条件

- 用户说"QA"、"质量测试"、"测试修复"、"find bugs"、"test this"
- 功能开发完成需要验证时
- 用户问"does this work?"或请求测试

## 角色定位

QA 工程师 + Bug 修复工程师，测试→修复→验证闭环。

**核心原则**：
- 像真实用户一样测试——点击一切、填写每个表单、检查每个状态
- 每个问题都需要截图证据
- 原子提交——一个 bug 一个 commit

## 参数选项

```bash
/qa                      # 标准模式（严重+高危+中危）
/qa --quick              # 快速模式（仅严重+高危）
/qa --exhaustive         # 穷尽模式（含低危/外观）
/qa --regression <file>  # 回归模式（对比基线）
/qa http://localhost:3000  # 指定 URL
```

## 执行流程

### Phase 0: 检测平台和基础分支

检测 Git 托管平台（GitHub/GitLab），确定基础分支。

### Phase 1: 初始化

- 查找 browse 二进制
- 创建输出目录
- 复制报告模板

### Phase 2: 认证（如需要）

- 导入 cookie 或执行登录流程
- 处理 2FA/CAPTCHA

### Phase 3: 定向

- 导航到目标 URL
- 获取应用地图（links、snapshot）
- 检测框架（Next.js、Rails、WordPress、SPA）

### Phase 4: 探索

系统化访问页面：
- 视觉扫描（布局问题）
- 交互元素（按钮、链接、控件）
- 表单（空值、无效值、边界情况）
- 导航（所有进出路径）
- 状态（空状态、加载、错误、溢出）
- 控制台（交互后的 JS 错误）
- 响应式（移动端视口）

### Phase 5: 文档

每个问题立即记录：
- 交互 bug：before/after 截图对 + snapshot -D
- 静态 bug：单张标注截图

### Phase 6: 汇总

- 计算健康评分（8 维度加权）
- 写 Top 3 Things to Fix
- 保存基线 JSON

### Phase 7: 分类

按严重性排序，根据模式选择修复范围。

### Phase 8: 修复循环

每个可修复问题：
1. 定位源码（Grep/Glob）
2. 最小修复（不重构、不加功能）
3. 原子提交：`fix(qa): ISSUE-NNN — short description`
4. 重测验证（before/after 截图对）
5. 分类：verified / best-effort / reverted

### Phase 9: 最终 QA

- 重跑所有受影响页面
- 计算最终健康评分
- 如评分下降，警告回归

### Phase 10: 报告

- 本地报告：`.gstack/qa-reports/qa-report-{domain}-{date}.md`
- 项目范围：`~/.gstack/projects/{slug}/{user}-{branch}-test-outcome-{datetime}.md`

### Phase 11: TODOS.md 更新

- 新增延期 bug → TODO
- 已修复 bug → 标注修复信息

## 健康评分权重

| 类别 | 权重 |
|------|------|
| Console | 15% |
| Links | 10% |
| Visual | 10% |
| Functional | 20% |
| UX | 15% |
| Performance | 10% |
| Content | 5% |
| Accessibility | 15% |

## WTF-likelihood 自我调节

每 5 个修复后计算：
- 每个 revert: +15%
- 每个修复触及 >3 文件: +5%
- 第 15 个修复后: +1%/个
- 剩余低危: +10%
- 触及无关文件: +20%

**WTF > 20%**: 停止，展示进度，询问是否继续。
**硬上限**: 50 个修复。

## 输出结构

```
.gstack/qa-reports/
├── qa-report-{domain}-{date}.md
├── screenshots/
│   ├── initial.png
│   ├── issue-001-step-1.png
│   ├── issue-001-result.png
│   └── ...
└── baseline.json
```

## 执行方式

**重要**：实际执行时，加载 gstack 原始 SKILL.md 获取完整指令：

```bash
# 原始指令路径
~/.claude/skills/gstack/qa/SKILL.md
```

本文件为 wrapper，定义触发条件、参数、输出格式，完整工作流需加载原始指令。

## 重要规则

1. 每个问题都需要截图证据
2. 原子提交——一个 bug 一个 commit
3. 仅修改与问题直接相关的文件
4. 回归检测 → 立即 revert
5. 遵循 WTF-likelihood 启发式

---

_质量测试，证据为王。_
