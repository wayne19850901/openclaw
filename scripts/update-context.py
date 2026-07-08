#!/usr/bin/env python3
"""更新模型上下文窗口为官方标准"""
import json

PATH = '/Users/linwei/.claw/claw.json'

with open(PATH) as f:
    data = json.load(f)

# 官方标准
specs = {
    'DeepSeek-V4-Flash':  {'ctx': 1_048_576, 'out': 32768,  'std': '1M'},
    'DeepSeek-V4-Pro':    {'ctx': 1_048_576, 'out': 32768,  'std': '1M'},
    'glm-latest':         {'ctx': 1_048_576, 'out': 32768,  'std': '1M (GLM-5.2)'},
    'Kimi-K2.7-Code':     {'ctx': 262_144,   'out': 32768,  'std': '256K'},
    'Kimi-K2.6':          {'ctx': 262_144,   'out': 32768,  'std': '256K'},
    'MiniMax-M3':         {'ctx': 1_048_576, 'out': 524288, 'std': '1M / 512K out'},
    'Doubao-Seed-2.0-pro': {'ctx': 262_144,  'out': 16384,  'std': '256K'},
    'Doubao-Seed-2.0-Code':{'ctx': 262_144,  'out': 16384,  'std': '256K'},
}

for m in data['models']['providers']['volcengine-ark']['models']:
    sid = m['id']
    if sid in specs:
        m['contextWindow'] = specs[sid]['ctx']
        m['maxTokens'] = specs[sid]['out']

with open(PATH, 'w') as f:
    json.dump(data, f, indent=2, ensure_ascii=False)

print(f'{"模型":25s} {"上下文窗口":>12s} {"最大输出":>10s} {"官方标准":>18s}')
print('-' * 68)
for m in data['models']['providers']['volcengine-ark']['models']:
    sid = m['id']
    s = specs.get(sid, {})
    print(f"{sid:25s} {m['contextWindow']:>10,d}  {m['maxTokens']:>6,d}  {s.get('std','?'):>18s}")