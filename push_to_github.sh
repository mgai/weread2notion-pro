#!/bin/bash

# 推送 feature/cookie_auth 到 GitHub

set -e

echo "===================================="
echo "🚀 推送 feature/cookie_auth 到 GitHub"
echo "===================================="
echo ""

# 设置工作目录
cd "$(dirname "$0")"

# 检查当前分支
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
echo "📍 当前分支: $CURRENT_BRANCH"

# 检查是否有未提交的更改
if [ -n "$(git status --porcelain)" ]; then
    echo "⚠️  警告: 有未提交的更改"
    git status --short
    echo ""
    echo "请先提交更改再推送"
    exit 1
fi

# 检查认证
echo "🔐 检查 GitHub 认证..."
if ! gh auth status &>/dev/null; then
    echo "❌ 未登录到 GitHub"
    echo "   请运行: gh auth login"
    exit 1
fi
echo "✅ 已登录到 GitHub"
echo ""

# 方法 1: 使用 gh CLI 推送（推荐）
echo "===================================="
echo "📡 方法 1: 使用 GitHub CLI"
echo "===================================="
echo ""

# gh CLI 通常无法直接推送 git 分支
# 但可以尝试使用 git credential helper

echo "尝试推送分支..."
echo ""

# 方法 2: 使用 git 配置 gh credential helper
echo "===================================="
echo "📡 方法 2: 配置 Git 认证"
echo "===================================="
echo ""

# 配置 git 使用 gh 作为 credential helper
git config --local credential.helper '!gh auth git-credential'

# 检查 remote 是否存在
if git remote | grep -q "^origin$"; then
    echo "✅ Remote 'origin' 已存在"
    ORIGIN_URL=$(git config --get remote.origin.url)
    echo "   URL: $ORIGIN_URL"
else
    echo "📍 添加 remote 'origin'..."
    git remote add origin https://github.com/mgai/weread2notion-pro.git
    echo "✅ Remote 'origin' 已添加"
fi

echo ""
echo "🚀 推送分支..."

# 尝试推送
if git push -u origin feature/cookie_auth 2>&1; then
    echo ""
    echo "===================================="
    echo "✅ 推送成功！"
    echo "===================================="
    echo ""
    echo "🔗 分支链接:"
    echo "   https://github.com/mgai/weread2notion-pro/tree/feature/cookie_auth"
    echo ""
    echo "📝 Pull Request:"
    echo "   https://github.com/mgai/weread2notion-pro/compare/feature/cookie_auth"
    exit 0
else
    echo ""
    echo "===================================="
    echo "❌ 推送失败"
    echo "===================================="
    echo ""
    echo "可能的原因:"
    echo "  1. 网络问题"
    echo "  2. Git credential 问题"
    echo "  3. 仓库权限问题"
    echo ""
    echo "💡 手动解决方案:"
    echo ""
    echo "方案 A: 使用 SSH URL"
    echo "  git remote set-url origin git@github.com:mgai/weread2notion-pro.git"
    echo "  git push -u origin feature/cookie_auth"
    echo ""
    echo "方案 B: 手动上传文件"
    echo "  1. 在 GitHub 创建新分支: feature/cookie_auth"
    echo "  2. 下载此分支的内容"
    echo "  3. 通过 GitHub Web UI 上传文件"
    echo ""
    echo "方案 C: 使用 gh CLI 创建 PR（需要先有远程分支）"
    echo "  gh pr create --title 'Restore cookie authentication' --body '...'"
    echo ""
    exit 1
fi
