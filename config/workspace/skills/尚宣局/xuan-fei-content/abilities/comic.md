# 漫画生成

## 概述

生成条漫/漫画内容，适合故事叙述和趣味表达。

## 使用方式

```bash
/baoyu-comic path/to/story.md
/baoyu-comic --style manga --panels 6
```

## 漫画风格

| 风格 | 描述 |
|------|------|
| `manga` | 日式漫画 |
| `webtoon` | 韩式条漫 |
| `cartoon` | 美式卡通 |
| `chibi` | Q版可爱 |

## 输出结构

```
comic/{slug}/
├── story.md
├── panels/
│   ├── panel-01.png
│   ├── panel-02.png
│   └── ...
└── comic-full.png      # 合并后完整漫画
```

---

_尚宣局·仪妃能力_
