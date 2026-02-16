# Coloc - Rails 7.0 升级版

这是一个成功从Rails 5.0升级到Rails 7.0的项目。

## 🚀 快速开始

### 前置要求
- Ruby 3.4.x (已安装在 `C:\opt\Ruby34-x64`)
- PostgreSQL 9.x+
- Redis (可选，用于缓存)

### 一键安装和启动

#### 1. 初始化项目
双击运行 `setup.bat` 或在命令行执行：
```bash
setup.bat
```

这将自动：
- 安装所有依赖
- 创建数据库
- 运行迁移
- 加载种子数据

#### 2. 启动开发服务器
双击运行 `start_server.bat` 或执行：
```bash
start_server.bat
```

然后访问: **http://localhost:3000**

## 📋 手动命令

如果需要手动执行：

```bash
# 安装依赖
C:\opt\Ruby34-x64\bin\ruby.exe C:\opt\Ruby34-x64\bin\bundle install

# 创建数据库
C:\opt\Ruby34-x64\bin\ruby.exe bin\rake db:create

# 运行迁移
C:\opt\Ruby34-x64\bin\ruby.exe bin\rake db:migrate

# 启动服务器
C:\opt\Ruby34-x64\bin\ruby.exe bin\rails server
```

## ✨ 主要升级内容

| 组件 | 旧版本 | 新版本 |
|------|--------|--------|
| Ruby | 2.2.6 | 3.4.x |
| Rails | 5.0.2 | 7.0.10 |
| Bundler | 1.15.0 | 2.7.2 |
| PostgreSQL驱动 | pg 0.20.0 | pg 1.1.x |

### 新增功能
- ✅ Puma web服务器 (更好的性能)
- ✅ Turbo Rails (现代化的前端交互)
- ✅ Stimulus (轻量级JavaScript框架)
- ✅ Importmap (无需webpack的资源管理)
- ✅ Rouge语法高亮 (替代pygments)
- ✅ Redis 5.0支持

### 已移除/禁用
- ❌ RuCaptcha (在Windows上编译有问题)
- ❌ Webpacker (Rails 7默认使用Importmap)

## 📚 详细文档

完整的升级说明请查看 **[UPGRADE_NOTES.md](./UPGRADE_NOTES.md)**

## ⚠️ 已知问题

1. **RuCaptcha验证码暂时禁用**
   - 原因: 在Windows上需要Rust编译器
   - 解决: 考虑使用其他验证码方案或安装Rust工具链

2. **Hiredis警告**
   - 警告信息: "could not load hiredis extension"
   - 影响: 性能略有下降但不影响功能
   - 解决: 可选，编译native扩展

## 🔧 常用任务

```bash
# 查看路由
C:\opt\Ruby34-x64\bin\ruby.exe bin\rails routes

# 进入控制台
C:\opt\Ruby34-x64\bin\ruby.exe bin\rails console

# 运行数据库任务
C:\opt\Ruby34-x64\bin\ruby.exe bin\rake db:version
C:\opt\Ruby34-x64\bin\ruby.exe bin\rake db:rollback

# 资产预编译（生产环境）
C:\opt\Ruby34-x64\bin\ruby.exe bin\rake assets:precompile
```

## 🎯 下一步

1. **测试所有功能** - 确保核心功能正常工作
2. **更新前端代码** - 利用Turbo和Stimulus改善用户体验
3. **性能优化** - 配置Redis缓存和数据库查询优化
4. **安全审计** - 运行 `bundle audit` 检查漏洞
5. **部署准备** - 配置生产环境设置

## 📞 技术栈

- **后端**: Ruby on Rails 7.0
- **数据库**: PostgreSQL
- **缓存**: Redis
- **前端**: Turbo, Stimulus, Bootstrap 3
- **Markdown**: Redcarpet
- **语法高亮**: Rouge

---

**升级完成时间**: 2026年2月16日  
**Rails版本**: 7.0.10  
**Ruby版本**: 3.4.0

