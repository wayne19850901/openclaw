# 小红书内容提取

## 概述

提取小红书笔记内容和图片，用于情报搜集和内容分析。

## 使用方式

```bash
/baoyu-xhs-images https://xiaohongshu.com/note/xxx
/baoyu-xhs-images --note-id xxx
```

## 输出结构

```
xiaohongshu/{note-id}/
├── note.md            # 笔记文字内容
├── meta.json          # 元数据（点赞、收藏等）
└── images/
    ├── 1.png
    ├── 2.png
    └── ...
```

## 提取内容

| 内容 | 说明 |
|------|------|
| 标题 | 笔记标题 |
| 正文 | 文字内容 |
| 图片 | 所有配图 |
| 标签 | 话题标签 |
| 数据 | 点赞、收藏、评论数 |

---

_尚机局·谨妃能力_
