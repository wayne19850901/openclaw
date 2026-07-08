# 视频内容转文字

## 概述

从YouTube视频提取字幕/转录文本，用于教育内容制作。

## 使用方式

```bash
/baoyu-youtube-transcript <video_url>
/baoyu-youtube-transcript <video_url> --lang zh
```

## 输出

```
transcripts/{video-id}/
├── transcript.txt      # 纯文本
├── transcript.srt      # SRT字幕格式
└── metadata.json       # 视频元数据
```

## 用途

| 场景 | 后续处理 |
|------|----------|
| 教育内容 | 整理为教程/课程 |
| 会议记录 | 提取要点 |
| 研究资料 | 摘录关键信息 |
| 内容本地化 | 翻译字幕 |

## 与 gstack 联动

视频转文字后，可衔接 `document-generate` 生成结构化教程文档：
```
youtube-transcript → document-generate(tutorial)
```

---

_尚教局·令妃专属能力_
