# gstack-browse 精简参考指南

> 完整版：`~/.claude/skills/gstack/browse/SKILL.md`

## 快速启动

```bash
# 启动 browse daemon（后台持久运行）
browse --daemon

# 查看状态
browse --status

# 停止 daemon
browse --kill
```

## 核心命令速查

### 页面操作
| 命令 | 用途 | 示例 |
|------|------|------|
| `goto` | 打开URL | `browse goto https://example.com` |
| `reload` | 刷新页面 | `browse reload` |
| `back` / `forward` | 历史导航 | `browse back` |

### 元素交互
| 命令 | 用途 | 示例 |
|------|------|------|
| `click` | 点击元素 | `browse click "#submit-btn"` |
| `type` | 输入文本 | `browse type "#search" "关键词"` |
| `select` | 下拉选择 | `browse select "#dropdown" "选项值"` |
| `hover` | 鼠标悬停 | `browse hover ".menu-item"` |
| `scroll` | 滚动页面 | `browse scroll 500` |

### 信息获取
| 命令 | 用途 | 示例 |
|------|------|------|
| `snapshot` | 页面快照（结构+状态） | `browse snapshot` |
| `screenshot` | 截图 | `browse screenshot --full` |
| `text` | 获取文本 | `browse text ".article"` |
| `evaluate` | 执行JS | `browse evaluate "document.title"` |

### 验证断言
| 命令 | 用途 | 示例 |
|------|------|------|
| `assert` | 断言检查 | `browse assert --exists "#result"` |
| `wait` | 等待元素 | `browse wait "#loading" --timeout 10` |

## Snapshot 标志解读

快照输出中的关键标志：
- `📍` 当前URL
- `🎯` 焦点元素
- `📊` 表格数据
- `📝` 表单字段
- `[button]` / `[link]` / `[input]` 元素类型
- `#id` / `.class` 选择器

## CSS Inspector

```bash
# 检查元素样式
browse inspect ".card" --css

# 检查布局
browse inspect ".container" --box
```

## Headed 模式

需要可视化调试时：
```bash
browse --headed
browse goto https://example.com  # 可见浏览器窗口
```

## 常见 QA 模式

### 1. 页面加载验证
```
goto URL → snapshot → assert --exists 关键元素
```

### 2. 表单填写测试
```
goto URL → type 输入 → click 提交 → wait 结果 → snapshot
```

### 3. 截图对比
```
screenshot --name before → 操作 → screenshot --name after
```

### 4. 响应式测试
```
resize 375x667 → snapshot → resize 1920x1080 → snapshot
```

## 注意事项

- **daemon 模式**：后台运行，不阻塞 CLI
- **超时设置**：默认30秒，复杂页面需增加
- **选择器优先级**：#id > .class > [attr] > text
- **错误处理**：失败时检查 snapshot 确认页面状态