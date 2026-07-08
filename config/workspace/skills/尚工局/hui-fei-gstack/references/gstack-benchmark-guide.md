# gstack Benchmark 完整指南

## 来源

整合自 `~/.claw/workspace/skills/gstack/benchmark/SKILL.md`

## 核心概念

gstack benchmark 使用browse daemon进行性能回归检测，追踪Core Web Vitals，确保性能预算达标。

## Browse Daemon

自动化浏览器性能采集工具：
- 无头浏览器运行
- 性能指标采集
- 截图对比
- 网络请求分析

## Core Web Vitals

### LCP（Largest Contentful Paint）
- 定义：最大内容元素渲染时间
- 良好：≤2.5s
- 需改进：2.5-4s
- 差：>4s

### FID（First Input Delay）
- 定义：首次输入延迟
- 良好：≤100ms
- 需改进：100-300ms
- 差：>300ms

### CLS（Cumulative Layout Shift）
- 定义：累积布局偏移
- 良好：≤0.1
- 需改进：0.1-0.25
- 差：>0.25

### INP（Interaction to Next Paint）
- 定义：交互到下次绘制
- 良好：≤200ms
- 需改进：200-500ms
- 差：>500ms

### TTFB（Time to First Byte）
- 定义：首字节时间
- 良好：≤800ms
- 需改进：800-1800ms
- 差：>1800ms

## 基线管理

1. **捕获基线**：在稳定版本上采集性能数据
2. **存储基线**：保存为JSON快照
3. **对比检测**：新版本与基线对比
4. **回归标记**：超过阈值标记为回归

## 性能预算

| 资源类型 | 默认预算 |
|----------|----------|
| JS bundle | ≤200KB (gzip) |
| CSS | ≤50KB (gzip) |
| 首屏图片 | ≤500KB |
| 首屏请求数 | ≤30 |
| LCP | ≤2.5s |
| CLS | ≤0.1 |

## 使用方式

当需要性能测试时：
1. 读取完整指令：`~/.claw/workspace/skills/gstack/benchmark/SKILL.md`
2. 按指令执行性能基准流程
3. 输出性能报告
