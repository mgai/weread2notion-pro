# Feature: Cookie Auth (Cookie 认证)

## 📝 变更说明

此分支恢复了基于 Cookie 的微信读书认证方式，移除了对 `notionhub.app` 的依赖。

### 主要改动

1. **requirements.txt**
   - 移除了 `weread2notionpro` 依赖
   - 使用本地 `weread2notionpro/` 目录中的代码

2. **认证方式**
   - 使用 `WEREAD_COOKIE` 环境变量
   - 支持通过 CookieCloud (`CC_URL`, `CC_ID`, `CC_PASSWORD`) 获取 cookie
   - 无需购买激活码

## 🚀 如何使用

### 本地测试

```bash
# 设置 cookie 环境变量
export WEREAD_COOKIE="your_cookie_here"

# 安装依赖（不包括 weread2notionpro）
pip install -r requirements.txt

# 直接运行本地代码
python -m weread2notionpro.book
python -m weread2notionpro.weread
python -m weread2notionpro.read_time
```

### GitHub Actions

在你的 GitHub 仓库 Secrets 中确保设置了：

- `WEREAD_COOKIE` - 微信读书 Cookie（从浏览器获取）
- `NOTION_TOKEN` - Notion API Token
- `NOTION_PAGE` - Notion 页面 ID

可选（如果使用 CookieCloud）：
- `CC_URL` - CookieCloud 服务地址
- `CC_ID` - CookieCloud ID
- `CC_PASSWORD` - CookieCloud 密码

### 获取微信读书 Cookie

1. 打开浏览器访问 https://weread.qq.com/
2. 扫码登录
3. 按 F12 打开开发者工具
4. 切换到 Network 标签
5. 刷新页面，找到 `weread.qq.com` 的请求
6. 复制 `Cookie` 头的值

## 🔍 与主分支的区别

| 特性 | main 分支 | feature/cookie_auth 分支 |
|-----|-----------|----------------------|
| 认证方式 | notionhub (需激活码) | Cookie (免费) |
| 依赖 | `weread2notionpro` 包 | 本地代码 |
| PyPI 包版本 | 0.6.8+ | 不使用 PyPI 包 |
| 配置复杂度 | 高（需购买激活码） | 低（仅需 cookie） |
| 长期维护 | 依赖作者 | 可自行维护 |

## ⚠️ 注意事项

1. **Cookie 过期**：微信读书 Cookie 可能会过期，需要定期更新
2. **API 变更**：如果微信读书 API 发生变更，需要手动修复本地代码
3. **无自动更新**：不会从上游自动更新，需要手动合并改进

## 🔄 如何回退

如果遇到问题，可以轻松回退到主分支：

```bash
# 切换回 main 分支
git checkout main

# 删除 feature 分支
git branch -D feature/cookie_auth
```

## 📚 参考文档

- 原项目 README: [mlinkang/weread2notion-pro](https://github.com/malinkang/weread2notion-pro)
- Notionhub 插件: [https://www.notionhub.app](https://www.notionhub.app)
