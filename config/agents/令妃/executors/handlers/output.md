# 输出处理 - 令妃 💫

---

## 输出类型

| 类型 | 格式 | 场景 |
|------|------|------|
| 文本回复 | Markdown | 日常对话 |
| 报告输出 | Markdown | 日报、周报 |
| 任务分配 | Markdown | 分配任务 |
| 状态反馈 | Markdown | 进度反馈 |
| 错误提示 | Markdown | 错误处理 |

---

## 输出格式化

### Markdown格式化

```python
def format_markdown(content, template):
    return template.format(**content)
```

### 报告格式化

```markdown
## {标题}

### {章节1}
{内容}

### {章节2}
{内容}

---
_{签名}_
```

---

## 输出模板

### 回复模板

```markdown
收到，威帝~

{内容}

---
_令妃 敬上_
```

### 任务分配模板

```markdown
@{负责人} 请处理：

**任务描述**：{描述}
**截止时间**：{时间}
**预期产出**：{产出物}

---
_令妃 分配_
```

### 汇报模板

```markdown
威帝，{类型}已准备好~

## {标题}

{内容}

---
_令妃 呈报_
```

---

## 输出优化

### 可读性优化

```python
def optimize_readability(output):
    # 1. 添加标题层级
    output = add_headers(output)
    
    # 2. 添加表格结构
    output = add_tables(output)
    
    # 3. 添加列表格式
    output = add_lists(output)
    
    # 4. 添加分隔线
    output = add_separators(output)
    
    return output
```

### 重点突出

```python
def highlight_key_points(output):
    # 1. 核心信息加粗
    output = bold_important(output)
    
    # 2. 警告信息标红
    output = highlight_warnings(output)
    
    # 3. 数据用表格展示
    output = tabularize_data(output)
    
    return output
```

---

## 输出验证

### 内容检查

```python
def validate_output(output):
    # 1. 检查必填字段
    if not has_required_fields(output):
        return False, "缺少必填内容"
    
    # 2. 检查格式正确性
    if not is_valid_format(output):
        return False, "格式不正确"
    
    # 3. 检查敏感信息
    if contains_sensitive_info(output):
        return False, "包含敏感信息"
    
    return True, "验证通过"
```

### 质量检查

```python
def check_quality(output):
    # 1. 检查内容完整性
    completeness = check_completeness(output)
    
    # 2. 检查逻辑连贯性
    coherence = check_coherence(output)
    
    # 3. 检查表达清晰度
    clarity = check_clarity(output)
    
    return {
        'completeness': completeness,
        'coherence': coherence,
        'clarity': clarity,
        'overall': (completeness + coherence + clarity) / 3
    }
```

---

## 输出发送

### 发送方式

```python
def send_output(output, channel='feishu'):
    if channel == 'feishu':
        return send_to_feishu(output)
    elif channel == 'memory':
        return save_to_memory(output)
    elif channel == 'queen':
        return send_to_queen(output)
    else:
        return output
```

### 发送确认

```python
def confirm_send(output_id):
    # 记录发送状态
    log_send_status(output_id, 'sent')
    
    # 等待确认
    confirmation = wait_for_confirmation(output_id)
    
    return confirmation
```

---

## 输出归档

### 归档规则

```python
def archive_output(output):
    # 1. 生成归档ID
    archive_id = generate_archive_id()
    
    # 2. 存储到memory
    save_to_memory(output, archive_id)
    
    # 3. 建立索引
    index_output(output, archive_id)
    
    return archive_id
```

### 归档位置

| 输出类型 | 归档位置 |
|----------|----------|
| 日报 | memory/daily/YYYY-MM-DD.md |
| 周报 | memory/weekly/YYYY-WW.md |
| 月报 | memory/monthly/YYYY-MM.md |
| 专项报告 | memory/specialized/YYYY-MM-DD-{topic}.md |

---

_配置者：Queen 👑_
_更新时间：2026-04-06_
