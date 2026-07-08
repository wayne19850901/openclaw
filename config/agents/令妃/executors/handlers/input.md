# 输入处理 - 令妃 💫

---

## 输入来源

| 来源 | 格式 | 优先级 |
|------|------|--------|
| 威帝消息 | 自然语言 | P0 |
| Queen消息 | 自然语言 | P1 |
| 下属汇报 | 结构化/自然语言 | P2 |
| 姐妹请求 | 自然语言 | P3 |
| 系统事件 | 结构化 | P4 |

---

## 输入解析

### 自然语言解析

```python
def parse_natural_language(input):
    # 1. 提取意图
    intent = extract_intent(input)
    
    # 2. 提取实体
    entities = extract_entities(input)
    
    # 3. 提取关键词
    keywords = extract_keywords(input)
    
    # 4. 确定优先级
    priority = determine_priority(input)
    
    return {
        'intent': intent,
        'entities': entities,
        'keywords': keywords,
        'priority': priority,
        'raw_input': input
    }
```

### 结构化输入解析

```python
def parse_structured_input(input):
    # 解析JSON/Markdown格式
    return json.loads(input) or parse_markdown(input)
```

---

## 意图识别

### 意图类型

| 意图 | 关键词 | 处理方式 |
|------|--------|----------|
| 任务分配 | 安排、设计、制作、处理 | 路由执行 |
| 状态查询 | 查询、状态、进度 | 查询返回 |
| 问题反馈 | 问题、异常、错误 | 问题处理 |
| 信息汇报 | 汇报、报告、总结 | 汇报处理 |
| 协作请求 | 协助、协调、帮忙 | 协作处理 |

### 意图识别算法

```python
def extract_intent(input):
    for intent, keywords in INTENT_KEYWORDS.items():
        for keyword in keywords:
            if keyword in input:
                return intent
    return 'unknown'
```

---

## 实体提取

### 实体类型

| 实体类型 | 示例 | 提取方式 |
|----------|------|----------|
| 时间 | 今天、明天、下周 | 时间词库匹配 |
| 任务 | 课程、培训、报告 | 任务词库匹配 |
| 人员 | 尚教、司课师 | 人名词库匹配 |
| 数量 | 1个、3份 | 数字提取 |
| 产出物 | 报告、方案、课件 | 产出物词库匹配 |

### 实体提取算法

```python
def extract_entities(input):
    entities = {}
    for entity_type, patterns in ENTITY_PATTERNS.items():
        entities[entity_type] = match_patterns(input, patterns)
    return entities
```

---

## 输入验证

### 必填字段检查

```python
def validate_input(parsed_input):
    required_fields = ['intent']
    for field in required_fields:
        if field not in parsed_input or not parsed_input[field]:
            return False, f"缺少必填字段: {field}"
    return True, "验证通过"
```

### 格式检查

```python
def check_format(parsed_input):
    # 检查时间格式
    if 'time' in parsed_input:
        if not is_valid_time(parsed_input['time']):
            return False, "时间格式不正确"
    return True, "格式检查通过"
```

---

## 输入预处理

### 标准化

```python
def normalize_input(input):
    # 统一字符编码
    input = input.encode('utf-8').decode('utf-8')
    
    # 去除多余空白
    input = ' '.join(input.split())
    
    # 统一标点符号
    input = normalize_punctuation(input)
    
    return input
```

### 分词

```python
def tokenize(input):
    # 使用分词工具
    tokens = jieba.cut(input)
    return list(tokens)
```

---

## 输入转发

### 转发规则

```python
def forward_input(parsed_input):
    intent = parsed_input['intent']
    
    if intent == 'TASK':
        return forward_to_task_router(parsed_input)
    elif intent == 'QUERY':
        return forward_to_query_handler(parsed_input)
    elif intent == 'ISSUE':
        return forward_to_issue_handler(parsed_input)
    else:
        return forward_to_default_handler(parsed_input)
```

---

_配置者：Queen 👑_
_更新时间：2026-04-06_
