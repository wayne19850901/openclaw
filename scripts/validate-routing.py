#!/usr/bin/env python3

"""
OpenClaw 司师级路由验证脚本
创建时间: 2026-05-21
用途: 提取所有司师级的触发关键词，检查冲突和唯一性
"""

import os
import re
from pathlib import Path
from collections import defaultdict

BASE_DIR = Path.home() / ".claw" / "workspace" / "skills"

def extract_routing_info():
    """提取所有司师级的路由信息"""
    routing_files = []
    
    # 查找所有司师级的routing.yaml文件
    for bureau in ["尚融局", "尚工局", "尚宣局", "尚机局", "尚宫局", "尚教局", "御鉴司"]:
        bureau_path = BASE_DIR / bureau / "司级"
        if bureau_path.exists():
            for agent_dir in bureau_path.iterdir():
                if agent_dir.is_dir():
                    routing_file = agent_dir / "drivers" / "routing.yaml"
                    if routing_file.exists():
                        routing_files.append({
                            "bureau": bureau,
                            "agent": agent_dir.name,
                            "path": routing_file
                        })
    
    return routing_files

def parse_routing_yaml(routing_file):
    """解析routing.yaml文件（不使用yaml模块）"""
    try:
        with open(routing_file["path"], "r", encoding="utf-8") as f:
            content = f.read()
        
        # 提取关键词（在keywords: - 后面）
        triggers = re.findall(r"keywords:\s*\n((?:\s+-\s+.+\n)+)", content)
        trigger_keywords = []
        if triggers:
            for line in triggers[0].split("\n"):
                match = re.match(r"\s+-\s+(.+)", line)
                if match:
                    trigger_keywords.append(match.group(1).strip())
        
        # 提取能力标签（在tags: - 后面）
        capabilities = re.findall(r"tags:\s*\n((?:\s+-\s+.+\n)+)", content)
        capability_tags = []
        if capabilities:
            for line in capabilities[0].split("\n"):
                match = re.match(r"\s+-\s+(.+)", line)
                if match:
                    capability_tags.append(match.group(1).strip())
        
        # 提取依赖技能（在required_skills: - 后面）
        dependencies = re.findall(r"required_skills:\s*\n((?:\s+-\s+.+\n)+)", content)
        required_skills = []
        if dependencies:
            for line in dependencies[0].split("\n"):
                match = re.match(r"\s+-\s+(.+)", line)
                if match:
                    required_skills.append(match.group(1).strip())
        
        return {
            "bureau": routing_file["bureau"],
            "agent": routing_file["agent"],
            "triggers": trigger_keywords,
            "capabilities": capability_tags,
            "dependencies": required_skills
        }
    except Exception as e:
        print(f"❌ 解析失败: {routing_file['path']} - {e}")
        return None

def check_keyword_conflicts(all_routing):
    """检查关键词冲突"""
    keyword_map = defaultdict(list)
    
    for routing in all_routing:
        for keyword in routing["triggers"]:
            keyword_map[keyword].append(routing["agent"])
    
    conflicts = []
    for keyword, agents in keyword_map.items():
        if len(agents) > 1:
            conflicts.append({
                "keyword": keyword,
                "agents": agents
            })
    
    return conflicts

def check_capability_tags(all_routing):
    """检查能力标签唯一性"""
    capability_map = defaultdict(list)
    
    for routing in all_routing:
        for capability in routing["capabilities"]:
            capability_map[capability].append(routing["agent"])
    
    duplicates = []
    for capability, agents in capability_map.items():
        if len(agents) > 1:
            duplicates.append({
                "capability": capability,
                "agents": agents
            })
    
    return duplicates

def generate_validation_report(all_routing, conflicts, duplicates):
    """生成路由验证报告"""
    report = []
    
    report.append("# OpenClaw 司师级路由验证报告")
    report.append("")
    report.append(f"> **验证时间**: 2026-05-21")
    report.append(f"> **验证范围**: 21个司师级Agent")
    report.append(f"> **验证结果**: {len(conflicts)}个关键词冲突，{len(duplicates)}个能力标签重复")
    report.append("")
    report.append("---")
    report.append("")
    
    # 统计信息
    report.append("## 一、统计信息")
    report.append("")
    report.append(f"- 总司师级数量: {len(all_routing)}")
    report.append(f"- 总触发关键词: {sum(len(r['triggers']) for r in all_routing)}")
    report.append(f"- 总能力标签: {sum(len(r['capabilities']) for r in all_routing)}")
    report.append(f"- 关键词冲突: {len(conflicts)}")
    report.append(f"- 能力标签重复: {len(duplicates)}")
    report.append("")
    
    # 关键词冲突详情
    if conflicts:
        report.append("## 二、关键词冲突详情")
        report.append("")
        report.append("| 关键词 | 冲突的司师级 |")
        report.append("|--------|-------------|")
        for conflict in conflicts:
            agents_str = ", ".join(conflict["agents"])
            report.append(f"| {conflict['keyword']} | {agents_str} |")
        report.append("")
        report.append("**建议**: 为冲突关键词添加局级前缀，如'尚融局-投资分析'、'尚工局-投资分析'")
        report.append("")
    
    # 能力标签重复详情
    if duplicates:
        report.append("## 三、能力标签重复详情")
        report.append("")
        report.append("| 能力标签 | 重复的司师级 |")
        report.append("|----------|-------------|")
        for duplicate in duplicates:
            agents_str = ", ".join(duplicate["agents"])
            report.append(f"| {duplicate['capability']} | {agents_str} |")
        report.append("")
        report.append("**建议**: 为重复能力标签添加局级前缀，如'尚融局-财务分析'、'尚工局-财务分析'")
        report.append("")
    
    # 各司师级路由详情
    report.append("## 四、各司师级路由详情")
    report.append("")
    
    for routing in all_routing:
        report.append(f"### {routing['bureau']} - {routing['agent']}")
        report.append("")
        report.append("**触发关键词**:")
        for keyword in routing["triggers"]:
            report.append(f"- {keyword}")
        report.append("")
        
        report.append("**能力标签**:")
        for capability in routing["capabilities"]:
            report.append(f"- {capability}")
        report.append("")
        
        if routing["dependencies"]:
            report.append("**依赖技能**:")
            for dependency in routing["dependencies"]:
                report.append(f"- {dependency}")
            report.append("")
    
    # 验证结论
    report.append("## 五、验证结论")
    report.append("")
    
    if len(conflicts) == 0 and len(duplicates) == 0:
        report.append("✅ **路由验证通过**: 无关键词冲突，无能力标签重复")
        report.append("")
        report.append("所有司师级的触发关键词和能力标签均唯一，路由机制可用。")
    else:
        report.append("⚠️ **路由验证未通过**: 存在关键词冲突或能力标签重复")
        report.append("")
        report.append("需要修复冲突后重新验证。建议方案:")
        report.append("1. 为冲突关键词添加局级前缀")
        report.append("2. 为重复能力标签添加局级前缀")
        report.append("3. 使用更具体的触发关键词（如'贷款审批'而非'审批')")
    
    report.append("")
    report.append("---")
    report.append("")
    report.append("*版本: v1.0*")
    report.append("*创建时间: 2026-05-21*")
    report.append("*维护者: 司情师*")
    
    return "\n".join(report)

def main():
    """主函数"""
    print("=== 开始路由验证 ===")
    
    # 提取路由信息
    routing_files = extract_routing_info()
    print(f"✓ 找到 {len(routing_files)} 个routing.yaml文件")
    
    # 解析路由信息
    all_routing = []
    for routing_file in routing_files:
        routing_info = parse_routing_yaml(routing_file)
        if routing_info:
            all_routing.append(routing_info)
    
    print(f"✓ 成功解析 {len(all_routing)} 个路由文件")
    
    # 检查关键词冲突
    conflicts = check_keyword_conflicts(all_routing)
    print(f"✓ 发现 {len(conflicts)} 个关键词冲突")
    
    # 检查能力标签重复
    duplicates = check_capability_tags(all_routing)
    print(f"✓ 发现 {len(duplicates)} 个能力标签重复")
    
    # 生成验证报告
    report = generate_validation_report(all_routing, conflicts, duplicates)
    
    # 保存报告
    report_path = BASE_DIR.parent / "optimization" / "meta-design-team" / "routing-validation-report.md"
    report_path.parent.mkdir(parents=True, exist_ok=True)
    with open(report_path, "w", encoding="utf-8") as f:
        f.write(report)
    
    print(f"✓ 验证报告已保存: {report_path}")
    print("")
    print("=== 路由验证完成 ===")

if __name__ == "__main__":
    main()