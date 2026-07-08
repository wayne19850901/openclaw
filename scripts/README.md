# 心跳脚本使用指南

**版本**: v1.0
**创建时间**: 2026-05-24
**维护者**: Queen 👑

---

## 一、脚本列表

| 脚本 | 用途 | 执行频率 |
|------|------|----------|
| `heartbeat-bureau.sh` | 局级心跳 | 每周日 23:00 |
| `heartbeat-global.sh` | 全局心跳 | 每月 1 日 00:00 |
| `promotion-check.sh` | 晋升检查 | 每季度首日 01:00 |
| `heartbeat-scheduler.sh` | 调度器 | 手动执行 |

---

## 二、快速开始

### 2.1 添加执行权限

```bash
chmod +x ~/CodeBuddy/Claw/scripts/heartbeat-*.sh
chmod +x ~/CodeBuddy/Claw/scripts/promotion-check.sh
```

### 2.2 设置定时任务

```bash
~/CodeBuddy/Claw/scripts/heartbeat-scheduler.sh schedule
```

### 2.3 查看状态

```bash
~/CodeBuddy/Claw/scripts/heartbeat-scheduler.sh status
```

### 2.4 手动执行

```bash
# 执行全局心跳
~/CodeBuddy/Claw/scripts/heartbeat-scheduler.sh run global

# 执行指定局心跳
~/CodeBuddy/Claw/scripts/heartbeat-scheduler.sh run 尚工局

# 执行晋升检查
~/CodeBuddy/Claw/scripts/heartbeat-scheduler.sh run promotion
```

---

## 三、脚本详解

### 3.1 局级心跳 (heartbeat-bureau.sh)

**功能**:
- 检查待处理学习
- 检查重复学习模式
- 检查晋升候选
- 检查跨局学习
- 更新心跳状态

**用法**:
```bash
./heartbeat-bureau.sh <局名>
```

**示例**:
```bash
./heartbeat-bureau.sh 尚工局
./heartbeat-bureau.sh 尚融局
```

**输出**:
- 日志: `~/.claw/agents/<局名>/.learnings/heartbeat.log`
- 状态: `~/.claw/agents/<局名>/.learnings/heartbeat-state.md`

---

### 3.2 全局心跳 (heartbeat-global.sh)

**功能**:
- 汇总各局学习状态
- 检查跨局学习
- 检查全局晋升候选
- 检查降级候选
- 检查归档候选
- 执行晋升/降级/归档
- 生成心跳报告

**用法**:
```bash
./heartbeat-global.sh
```

**输出**:
- 日志: `~/self-improving/heartbeat.log`
- 状态: `~/self-improving/heartbeat-state.md`
- 报告: `~/self-improving/heartbeat-report-YYYYMMDD.md`

---

### 3.3 晋升检查 (promotion-check.sh)

**功能**:
- 查找所有晋升候选
- 检查晋升条件
- 执行晋升（需手动确认）
- 生成晋升报告

**用法**:
```bash
./promotion-check.sh
```

**输出**:
- 日志: `~/self-improving/promotion.log`
- 报告: `~/self-improving/promotion-report-YYYYMMDD.md`

---

### 3.4 调度器 (heartbeat-scheduler.sh)

**功能**:
- 设置 cron 定时任务
- 查看定时任务状态
- 手动执行心跳

**用法**:
```bash
./heartbeat-scheduler.sh [command]

Commands:
  schedule  - 设置 cron 定时任务
  status    - 查看定时任务状态
  run       - 手动执行心跳
  help      - 显示帮助信息
```

---

## 四、定时任务配置

### 4.1 默认配置

| 任务 | 频率 | 时间 |
|------|------|------|
| 局级心跳 | 每周日 | 23:00 |
| 全局心跳 | 每月 1 日 | 00:00 |
| 晋升检查 | 每季度首日 | 01:00 |

### 4.2 自定义配置

编辑 crontab:
```bash
crontab -e
```

添加自定义任务:
```bash
# 每天执行尚工局心跳
0 22 * * * ~/CodeBuddy/Claw/scripts/heartbeat-bureau.sh 尚工局

# 每周执行全局心跳
0 0 * * 0 ~/CodeBuddy/Claw/scripts/heartbeat-global.sh
```

---

## 五、日志管理

### 5.1 日志位置

| 脚本 | 日志位置 |
|------|----------|
| 局级心跳 | `~/.claw/agents/<局名>/.learnings/heartbeat.log` |
| 全局心跳 | `~/self-improving/heartbeat.log` |
| 晋升检查 | `~/self-improving/promotion.log` |
| 调度器 | `~/self-improving/scheduler.log` |

### 5.2 日志轮转

建议使用 logrotate 管理日志:

```bash
# 创建 logrotate 配置
cat > /etc/logrotate.d/openclaw-heartbeat << 'EOF'
$HOME/self-improving/*.log {
    weekly
    rotate 4
    compress
    delaycompress
    missingok
    notifempty
    create 644 linwei linwei
}
EOF
```

---

## 六、故障排查

### 6.1 常见问题

**问题**: 脚本无法执行
**解决**: 检查执行权限 `chmod +x *.sh`

**问题**: cron 任务不执行
**解决**: 检查 cron 服务状态 `sudo systemctl status cron`

**问题**: 日志文件不存在
**解决**: 手动创建日志目录 `mkdir -p ~/self-improving/logs`

### 6.2 调试模式

启用调试模式:
```bash
bash -x heartbeat-global.sh
```

---

## 七、最佳实践

### 7.1 执行顺序

1. **每周**: 局级心跳 → 各局尚座检查
2. **每月**: 全局心跳 → Queen 审查
3. **每季度**: 晋升检查 → Queen + 御鉴司审查

### 7.2 报告归档

建议归档历史报告:
```bash
mkdir -p ~/self-improving/reports/archive
mv ~/self-improving/reports/*.md ~/self-improving/reports/archive/
```

### 7.3 监控告警

建议配置监控:
- 心跳失败告警
- 待处理学习过多告警
- 晋升候选过多告警

---

## 八、扩展

### 8.1 添加新局

编辑 `heartbeat-scheduler.sh`:
```bash
BUREAUS=("尚工局" "尚融局" "新局名")
```

### 8.2 自定义心跳任务

编辑对应的脚本，添加新功能:
```bash
# 在 heartbeat-bureau.sh 中添加
check_custom_task() {
    log "执行自定义任务..."
    # 自定义逻辑
}
```

---

_配置者: Queen 👑_
_更新时间: 2026-05-24_
