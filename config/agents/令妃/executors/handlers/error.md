# 错误处理 - 令妃 💫

---

## 错误分类

| 错误类型 | 代码 | 说明 |
|----------|------|------|
| 输入错误 | E001 | 无法解析的输入 |
| 路由错误 | E002 | 任务路由失败 |
| 执行错误 | E003 | 执行过程中的错误 |
| 超时错误 | E004 | 任务超时 |
| 权限错误 | E005 | 权限不足 |
| 资源错误 | E006 | 资源不可用 |

---

## 错误捕获

### 全局错误捕获

```python
def handle_error(error):
    # 1. 记录错误信息
    log_error(error)
    
    # 2. 分类错误
    error_type = classify_error(error)
    
    # 3. 选择处理策略
    strategy = get_error_strategy(error_type)
    
    # 4. 执行处理
    return execute_strategy(strategy, error)
```

### 局部错误捕获

```python
try:
    result = execute_task(task)
except TaskTimeoutError:
    handle_timeout(task)
except ResourceNotFoundError:
    handle_resource_error(task)
except PermissionDeniedError:
    handle_permission_error(task)
except Exception as e:
    handle_unknown_error(e)
```

---

## 错误处理策略

### 输入错误（E001）

```python
def handle_input_error(error):
    # 尝试重新解析
    retry_result = retry_parse(error.input)
    
    if retry_result.success:
        return retry_result.data
    else:
        # 请求澄清
        return ask_clarification(error.input)
```

### 路由错误（E002）

```python
def handle_route_error(error):
    # 尝试其他路由
    alternative_route = find_alternative_route(error.task)
    
    if alternative_route:
        return execute_route(alternative_route)
    else:
        # 上报Queen
        return report_to_queen(error)
```

### 执行错误（E003）

```python
def handle_execution_error(error):
    # 尝试恢复
    recovery_result = attempt_recovery(error)
    
    if recovery_result.success:
        return recovery_result.data
    else:
        # 尝试重试
        retry_result = retry_execution(error.task)
        
        if retry_result.success:
            return retry_result.data
        else:
            # 上报Queen
            return report_to_queen(error)
```

### 超时错误（E004）

```python
def handle_timeout(error):
    # 检查是否可延长
    if can_extend(error.task):
        # 延长截止时间
        extend_deadline(error.task)
        return notify_extension(error.task)
    else:
        # 终止任务
        abort_task(error.task)
        return report_timeout(error)
```

### 权限错误（E005）

```python
def handle_permission_error(error):
    # 上报Queen申请权限
    return request_permission(error)
```

### 资源错误（E006）

```python
def handle_resource_error(error):
    # 尝试替代资源
    alternative = find_alternative_resource(error.resource)
    
    if alternative:
        return use_alternative(alternative)
    else:
        # 上报Queen协调资源
        return request_resource(error)
```

---

## 错误恢复

### 自动恢复

```python
def auto_recovery(error):
    # 1. 分析错误原因
    cause = analyze_error(error)
    
    # 2. 尝试自动修复
    fix_result = attempt_fix(cause)
    
    # 3. 验证修复效果
    if verify_fix(fix_result):
        return resume_task(error.task)
    else:
        return report_to_queen(error)
```

### 手动恢复

```python
def manual_recovery(error):
    # 生成错误报告
    error_report = generate_error_report(error)
    
    # 上报Queen
    return report_to_queen(error_report)
```

---

## 错误报告

### 错误报告格式

```markdown
【错误报告】{错误类型}

**错误代码**：{代码}
**发生时间**：{时间}
**错误描述**：{描述}
**影响范围**：{范围}
**已采取措施**：{措施}
**需要支持**：{支持}

---
_令妃 错误报告_
```

### 错误日志

```python
def log_error(error):
    log_entry = {
        'timestamp': now(),
        'error_type': error.type,
        'error_code': error.code,
        'description': str(error),
        'context': error.context,
        'stack_trace': error.stack_trace
    }
    save_log(log_entry, 'memory/errors/YYYY-MM-DD.log')
```

---

## 错误预防

### 输入验证

```python
def prevent_input_error(input):
    # 验证输入格式
    if not validate_format(input):
        return ask_clarification()
    
    # 验证输入内容
    if not validate_content(input):
        return ask_clarification()
    
    return input
```

### 资源检查

```python
def prevent_resource_error(task):
    # 检查所需资源
    required = get_required_resources(task)
    
    for resource in required:
        if not is_available(resource):
            return allocate_resource(resource)
    
    return True
```

### 权限检查

```python
def prevent_permission_error(task):
    # 检查执行权限
    if not has_permission(task):
        return request_permission(task)
    
    return True
```

---

## 错误学习

### 错误分析

```python
def analyze_error_pattern():
    # 读取错误日志
    errors = read_error_logs()
    
    # 分析错误模式
    patterns = extract_patterns(errors)
    
    # 生成预防建议
    recommendations = generate_recommendations(patterns)
    
    return recommendations
```

### 错误记录

```python
def record_error_learning(error, solution):
    learning = {
        'error': error,
        'solution': solution,
        'timestamp': now()
    }
    save_learning(learning, 'memory/MEMORY.md')
```

---

_配置者：Queen 👑_
_更新时间：2026-04-06_
