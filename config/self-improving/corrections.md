# Corrections Log

<!-- Format:
## YYYY-MM-DD
- [HH:MM] Changed X → Y
  Type: format|technical|communication|project
  Context: where correction happened
  Confirmed: pending (N/3) | yes | no
-->

## 2026-06-05
- [18:30] Git clone 失败 → 使用 --depth 1 浅克隆
  Type: technical
  Context: GBrain 部署时遇到 HTTP/2 stream 错误
  Confirmed: pending (1/3)

- [18:30] gbrain init 需要 embedding API → 使用 --no-embedding 跳过
  Type: technical
  Context: 无外部 embedding API 时本地部署 GBrain
  Confirmed: pending (1/3)

- [18:30] skillpack install 命令已移除 → 使用 scaffold 并从 gbrain repo 目录运行
  Type: technical
  Context: GBrain v0.33+ 命令变更
  Confirmed: pending (1/3)
