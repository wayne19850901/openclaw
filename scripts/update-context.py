#!/usr/bin/env python3
"""更新模型输入模态为官方标准"""
import json

PATH = '/Users/linwei/.claw/claw.json'

with open(PATH) as f:
    data = json.load(f)

# 官方标准：输入模态
# text: 纯文本, image: 图片理解, video: 视频理解, audio: 音频
specs = {
    'DeepSeek-V4-Flash':    {'ctx': 1_048_576, 'out': 32768,  'input': ['text', 'image', 'video'], 'std': '1M / 原生多模态'},
    'DeepSeek-V4-Pro':      {'ctx': 1_048_576, 'out': 32768,  'input': ['text', 'image', 'video'], 'std': '1M / 原生多模态'},
    'glm-latest':           {'ctx': 1_048_576, 'out': 32768,  'input': ['text', 'image'],          'std': '1M (GLM-5.2) / 多模态'},
    'Kimi-K2.7-Code':       {'ctx': 262_144,   'out': 32768,  'input': ['text', 'image', 'video'], 'std': '256K / 文本+图片+视频'},
    'Kimi-K2.6':            {'ctx': 262_144,   'out': 32768,  'input': ['text', 'image', 'video'], 'std': '256K / 原生多模态'},
    'MiniMax-M3':           {'ctx': 1_048_576, 'out': 524288, 'input': ['text', 'image', 'video'], 'std': '1M / 原生多模态'},
    'Doubao-Seed-2.0-pro':  {'ctx': 262_144,   'out': 16384,  'input': ['text', 'image'],          'std': '256K / VLM'},
    'Doubao-Seed-2.0-Code': {'ctx': 262_144,   'out': 16384,  'input': ['text', 'image'],          'std': '256K / 代码+多模态'},
}

for m in data['models']['providers']['volcengine-ark']['models']:
    sid = m['id']
    if sid in specs:
        m['contextWindow'] = specs[sid]['ctx']
        m['maxTokens'] = specs[sid]['out']
        m['input'] = specs[sid]['input']

with open(PATH, 'w') as f:
    json.dump(data, f, indent=2, ensure_ascii=False)

print(f'{"模型":25s} {"上下文":>8s} {"输出":>8s} {"输入模态":>25s} {"官方标准":>25s}')
print('-' * 92)
for m in data['models']['providers']['volcengine-ark']['models']:
    sid = m['id']
    s = specs.get(sid, {})
    inp = ', '.join(m['input'])
    print(f"{sid:25s} {m['contextWindow']:>6,d}  {m['maxTokens']:>6,d}  {inp:>25s}  {s.get('std','?'):>25s}")