#!/usr/bin/env python3
"""
PDF 引擎
基于 pdftotext 的 PDF 文本提取

整合自原 pdf-extract 技能
"""

import os
import subprocess
import shutil


def check_pdftotext_installed():
    """检查 pdftotext 是否已安装"""
    return shutil.which('pdftotext') is not None


def extract_pdf_text(pdf_path, pages=None):
    """
    从 PDF 文件中提取文本
    
    参数:
        pdf_path: PDF 文件路径
        pages: 页码范围（如 "1-5"），None 表示全部
    
    返回:
        提取的文本内容，失败返回 None
    """
    if not os.path.exists(pdf_path):
        print(f"错误: 文件不存在: {pdf_path}")
        return None
    
    if not check_pdftotext_installed():
        print("错误: pdftotext 未安装")
        print("安装方法:")
        print("  macOS: brew install poppler")
        print("  Ubuntu/Debian: sudo apt install poppler-utils")
        print("  Fedora: sudo dnf install poppler-utils")
        return None
    
    try:
        # pdftotext 命令参数
        cmd = ['pdftotext', '-layout']
        
        # 添加页码范围
        if pages:
            # 解析页码范围（如 "1-5"）
            if '-' in pages:
                start, end = pages.split('-')
                cmd.extend(['-f', start.strip(), '-l', end.strip()])
            else:
                # 单页
                cmd.extend(['-f', pages, '-l', pages])
        
        cmd.extend([pdf_path, '-'])  # 输出到 stdout
        
        # 执行命令
        result = subprocess.run(
            cmd,
            capture_output=True,
            text=True,
            timeout=60
        )
        
        if result.returncode == 0:
            text = result.stdout.strip()
            if text:
                return text
            else:
                print("警告: PDF 中未提取到文本（可能是扫描版 PDF）")
                print("建议: 使用 OCR 模式处理扫描版 PDF")
                return None
        else:
            print(f"pdftotext 错误: {result.stderr}")
            return None
            
    except subprocess.TimeoutExpired:
        print("错误: PDF 处理超时")
        return None
    except Exception as e:
        print(f"错误: {str(e)}")
        return None


if __name__ == "__main__":
    import sys
    
    if len(sys.argv) < 2:
        print("使用方法: python3 pdf_engine.py <PDF路径> [页码范围]")
        sys.exit(1)
    
    pdf_path = sys.argv[1]
    pages = sys.argv[2] if len(sys.argv) > 2 else None
    
    print(f"正在提取 PDF: {pdf_path}")
    if pages:
        print(f"页码范围: {pages}")
    
    result = extract_pdf_text(pdf_path, pages)
    
    if result:
        print("\n" + "="*50)
        print(result)
        print("="*50)
    else:
        print("提取失败")
        sys.exit(1)
