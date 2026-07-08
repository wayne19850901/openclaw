# Self-Improving Integration - 尚宣局

**版本**: v1.0
**创建时间**: 2026-05-24
**维护者**: 尚宣

---

## 一、学习架构

```
尚宣局 🎨（尚宣局统领）
├── .learnings/                    # [NEW] 学习记录
│   ├── LEARNINGS.md              # 学习日志
│   ├── ERRORS.md                 # 错误记录
│   ├── FEATURE_REQUESTS.md       # 功能请求
│   └── SELF-IMPROVING.md         # 本文件
├── drivers/
├── executors/
├── memory/
└── references/
```

---

## 二、学习触发器

### 2.1 内容领域特定场景

| 场景 | 记录到 | 类别 |
|------|--------|------|
| 内容质量反馈 | `LEARNINGS.md` | content_quality |
| 用户增长数据 | `LEARNINGS.md` | growth_insight |
| 品牌调性纠正 | `LEARNINGS.md` | brand_correction |
| 渠道效果分析 | `LEARNINGS.md` | channel_performance |
| 内容审核问题 | `ERRORS.md` | content_violation |

### 2.2 检测信号

**内容纠正信号**:
- "这个调性不对..."
- "文案风格要改..."
- "视觉不够高级..."

**增长纠正信号**:
- "转化率分析有误..."
- "用户画像不对..."
- "渠道选择不当..."

---

## 三、晋升机制

同全局标准，但增加内容领域特定晋升路径：

| 学习类型 | 晋升目标 |
|----------|----------|
| 内容风格规则 | `~/.claw/OUTPUT-STANDARD.md` |
| 品牌调性规则 | `~/.claw/agents/尚宣局/drivers/identity.md` |
| 增长策略规则 | `~/.claw/agents/尚宣局/references/增长框架.md` |

---

## 四、心跳维护

### 4.1 内容质量检查

```bash
# 检查内容风格一致性
grep -h "Style:" .learnings/*.md | sort | uniq -c

# 检查品牌调性符合度
grep -h "Brand-Alignment" .learnings/*.md | sort | uniq -c
```

### 4.2 威帝审美偏好检查

每月检查学习记录是否符合威帝审美偏好：
- 高级感、时尚感
- 不土气、不俗套
- 简洁有力、不啰嗦

---

_配置者：尚宣 🎨_
_更新时间：2026-05-24_
