#!/usr/bin/env python3
"""
统一文档处理器
自动检测文件类型并选择合适的处理方式

使用方法:
    python3 doc_processor.py <文件路径> [选项]

选项:
    --mode <ocr|pdf|auto>  处理模式（默认 auto）
    --lang <语言代码>      OCR 语言（默认 chs）
    --pages <页码范围>     PDF 页码范围（如 1-5）

示例:
    python3 doc_processor.py /path/to/image.jpg
    python3 doc_processor.py /path/to/document.pdf --pages 1-5
    python3 doc_processor.py /path/to/image.png --lang eng --mode ocr
"""

import sys
import os
import argparse

# 添加当前目录到路径
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from ocr_engine import ocr_image
from pdf_engine import extract_pdf_text


def detect_file_type(file_path):
    """
    检测文件类型
    
    返回: 'image', 'pdf', 'unknown'
    """
    ext = os.path.splitext(file_path)[1].lower()
    
    # 图片格式
    image_extensions = ['.jpg', '.jpeg', '.png', '.gif', '.bmp', '.webp', '.tiff']
    if ext in image_extensions:
        return 'image'
    
    # PDF 格式
    if ext == '.pdf':
        return 'pdf'
    
    return 'unknown'


def process_document(file_path, mode='auto', language='chs', pages=None):
    """
    处理文档（统一入口）
    
    参数:
        file_path: 文件路径
        mode: 处理模式 ('ocr', 'pdf', 'auto')
        language: OCR 语言代码
        pages: PDF 页码范围
    
    返回:
        提取的文本内容
    """
    if not os.path.exists(file_path):
        print(f"错误: 文件不存在: {file_path}")
        return None
    
    # 自动检测文件类型
    file_type = detect_file_type(file_path)
    
    # 确定处理模式
    if mode == 'auto':
        if file_type == 'image':
            mode = 'ocr'
        elif file_type == 'pdf':
            mode = 'pdf'
        else:
            print(f"错误: 不支持的文件类型: {file_path}")
            return None
    
    # 处理文档
    if mode == 'ocr':
        print(f"使用 OCR 模式处理: {file_path}")
        return ocr_image(file_path, language=language)
    
    elif mode == 'pdf':
        print(f"使用 PDF 模式处理: {file_path}")
        return extract_pdf_text(file_path, pages=pages)
    
    else:
        print(f"错误: 未知处理模式: {mode}")
        return None


def main():
    parser = argparse.ArgumentParser(
        description='统一文档处理器 - 图片OCR + PDF提取',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog=__doc__
    )
    
    parser.add_argument('file', help='要处理的文件路径')
    parser.add_argument('--mode', choices=['ocr', 'pdf', 'auto'], default='auto',
                       help='处理模式（默认 auto）')
    parser.add_argument('--lang', default='chs',
                       help='OCR 语言代码（默认 chs）')
    parser.add_argument('--pages', 
                       help='PDF 页码范围（如 1-5）')
    
    args = parser.parse_args()
    
    print(f"正在处理: {args.file}")
    
    result = process_document(
        args.file,
        mode=args.mode,
        language=args.lang,
        pages=args.pages
    )
    
    if result:
        print("\n" + "="*50)
        print(result)
        print("="*50)
    else:
        print("处理失败")
        sys.exit(1)


if __name__ == "__main__":
    main()
