---
name: api-doc-gen
description: API文档生成 - 自动生成API文档和接口说明
version: 1.0.0
author: Queen
created: 2026-05-17
tags: [技术, API, 文档]
---

# API文档生成

## 功能描述

自动分析代码生成API文档，支持多种文档格式输出。

## 核心能力

1. **接口解析**：自动解析API端点和参数
2. **示例生成**：生成请求/响应示例
3. **多格式输出**：支持Markdown、OpenAPI、HTML等
4. **版本管理**：支持API版本追踪

## 输入要求

- API代码文件路径
- 文档格式偏好
- 输出路径

## 输出格式

```markdown
## API文档

### 接口名称
- **路径**：`POST /api/v1/resource`
- **描述**：...

#### 请求参数
| 参数 | 类型 | 必填 | 描述 |
|------|------|------|------|

#### 响应示例
```json
{
  "code": 200,
  "data": {...}
}
```
```

## 使用示例

```
@尚科 为这个API生成文档
```

---

_Config by Queen 👑_
