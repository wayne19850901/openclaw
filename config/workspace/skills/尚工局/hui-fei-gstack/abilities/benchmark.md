# 性能基准能力

> 整合自 gstack/benchmark — 性能回归检测与Core Web Vitals追踪

## 概述

捕获性能基线，检测回归，追踪Core Web Vitals，确保性能预算达标。

## 触发条件

- 性能敏感变更
- 发布前验证
- 用户明确要求性能测试
- 定期性能巡检

## 执行流程

1. **加载完整指令**：读取 `~/.claw/workspace/skills/gstack/benchmark/SKILL.md`
2. **捕获基线性能**：
   - 使用browse daemon采集
   - 记录Core Web Vitals
   - 保存基线快照
3. **执行变更**：
   - 部署待测版本
4. **对比Core Web Vitals**：
   - LCP（Largest Contentful Paint）
   - FID（First Input Delay）
   - CLS（Cumulative Layout Shift）
   - TTFB（Time to First Byte）
   - INP（Interaction to Next Paint）
5. **检测回归**：
   - 与基线对比
   - 标记显著退化
6. **检查性能预算**：
   - JS bundle大小
   - 图片资源大小
   - 请求数量
   - 渲染时间
7. **输出报告**

## Core Web Vitals阈值

| 指标 | 良好 | 需改进 | 差 |
|------|------|--------|-----|
| LCP | ≤2.5s | 2.5-4s | >4s |
| FID | ≤100ms | 100-300ms | >300ms |
| CLS | ≤0.1 | 0.1-0.25 | >0.25 |
| INP | ≤200ms | 200-500ms | >500ms |
| TTFB | ≤800ms | 800-1800ms | >1800ms |

## 性能预算示例

| 资源 | 预算 |
|------|------|
| JS bundle | ≤200KB (gzip) |
| CSS | ≤50KB (gzip) |
| 图片 | ≤500KB (首屏) |
| 请求数 | ≤30 (首屏) |
| LCP | ≤2.5s |

## 输出格式

```
## 性能基准报告

### 基线 vs 当前

| 指标 | 基线 | 当前 | 变化 | 状态 |
|------|------|------|------|------|
| LCP | 2.1s | 2.3s | +0.2s | ⚠️ |
| FID | 50ms | 45ms | -5ms | ✅ |
| CLS | 0.05 | 0.08 | +0.03 | ✅ |
| INP | 150ms | 180ms | +30ms | ⚠️ |

### 回归检测
- [回归] LCP增加0.2s，接近阈值
- [回归] INP增加30ms，需关注

### 性能预算
- JS bundle: 180KB / 200KB ✅
- 图片: 420KB / 500KB ✅
- 请求数: 25 / 30 ✅

### 建议
1. 优化LCP：预加载关键资源
2. 优化INP：减少主线程阻塞
```

## 参考

完整指令：`~/.claw/workspace/skills/gstack/benchmark/SKILL.md`
