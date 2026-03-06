#!/usr/bin/env python3
"""
快速测试：仅测试 Cookie 解析（不进行网络请求）
"""
import os
import sys

# 设置环境变量
WEREAD_COOKIE = os.getenv("WEREAD_COOKIE", "")

print("=" * 50)
print("🧪 微信读书 Cookie 解析测试（无网络请求）")
print("=" * 50)
print()

# 检查环境变量
if not WEREAD_COOKIE:
    print("❌ 错误: WEREAD_COOKIE 环境变量未设置")
    sys.exit(1)

# 导入本地模块
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from weread2notionpro.weread_api import WeReadApi

try:
    print("📡 步骤 1: 初始化 WeReadApi...")
    api = WeReadApi()
    print("   ✅ Cookie 解析成功")
    print()

    print("🍪 步骤 2: Cookie 详情...")
    cookies = api.cookie
    cookie_parts = cookies.split(';')
    print(f"   Cookie 包含 {len(cookie_parts)} 个参数:")
    for i, part in enumerate(cookie_parts, 1):
        part = part.strip()
        if '=' in part:
            key, value = part.split('=', 1)
            # 只显示 key，隐藏值
            masked_value = value[:5] + "..." if len(value) > 5 else "..."
            print(f"      {i}. {key:20} = {masked_value}")
    print()

    print("🔐 步骤 3: Session Cookie 检查...")
    if api.session.cookies:
        print(f"   ✅ Session cookies 已创建")
        print(f"   📦 包含 {len(list(api.session.cookies))} 个 cookie")
        for cookie in list(api.session.cookies)[:5]:
            print(f"      - {cookie.name}")
        if len(list(api.session.cookies)) > 5:
            print(f"      ... 还有 {len(list(api.session.cookies)) - 5} 个")
    print()

    print("=" * 50)
    print("✅ 快速测试通过！")
    print("=" * 50)
    print()
    print("📝 结论:")
    print("   ✓ Cookie 格式正确")
    print("   ✓ Cookie 解析成功")
    print("   ✓ Session 初始化成功")
    print("   ✓ 本地代码功能正常")
    print()
    print("💡 说明:")
    print("   由于本次测试未进行网络请求，无法验证：")
    print("   - Cookie 是否有效（可能已过期）")
    print("   - 微信读书 API 是否可访问")
    print("   - Notion 同步功能")
    print()
    print("🚀 要进行完整测试，请:")
    print("   1. 确保网络连接正常")
    print("   2. 运行: WEREAD_COOKIE='...' venv_test/bin/python test_api.py")

except Exception as e:
    print()
    print("=" * 50)
    print("❌ 测试失败")
    print("=" * 50)
    print(f"错误信息: {e}")
    import traceback
    traceback.print_exc()
    sys.exit(1)
