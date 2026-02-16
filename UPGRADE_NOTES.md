# Rails项目升级说明

## 概述
这个项目已从Rails 5.0.2 (Ruby 2.2.6)成功升级到Rails 7.0 (Ruby 3.4)。

## 主要更改

### 1. Ruby版本
- **旧版本**: Ruby 2.2.6
- **新版本**: Ruby 3.4.x
- Bundler已升级到2.7.2

### 2. Rails版本
- **旧版本**: Rails 5.0.2
- **新版本**: Rails 7.0.10

### 3. Gem依赖更新

#### 核心依赖
- `rails`: 5.0.2 → 7.0.10
- `pg`: 0.20.0 → 1.1.x
- `bcrypt`: 3.1.11 → 3.1.7+
- `puma`: 新增 (6.0+) - Rails 7默认web服务器

#### 资源管理
- `sass-rails` → `sassc-rails` (2.1+) - 更现代的Sass编译器
- 新增 `sprockets-rails` - Rails 7需要显式添加
- 新增 `importmap-rails` - Rails 7资源管理
- 新增 `turbo-rails` 和 `stimulus-rails` - Rails 7新特性

#### 分页和工具
- `will_paginate`: 3.1.5 → 4.0.1
- `faker`: 1.7.3 → 3.6.0

#### Markdown和语法高亮
- `pygments.rb` → `rouge` (4.0+) - 更现代的语法高亮库
- `redcarpet`: 3.4.0 → 3.6+

#### Redis
- `redis-rails` → `redis` (5.0+) - 直接使用redis gem
- 新增 `hiredis` (0.6.3) - 更快的Redis客户端

#### 验证码
- `rucaptcha`: **暂时禁用** - 在Windows上编译存在问题，需要Rust工具链

#### Windows支持
- 新增 `tzinfo-data` - Windows平台必需

### 4. 配置文件更改

#### config/application.rb
- 使用 `require_relative` 替代 `require File.expand_path`
- 添加 `config.load_defaults 7.0`
- Redis缓存配置从 `:redis_store` 更新为 `:redis_cache_store`

#### config/boot.rb 和 config/environment.rb
- 使用 `__dir__` 替代 `__FILE__`
- 使用 `require_relative` 现代化语法

#### config/environments/development.rb
- 移除已废弃的 `config.assets.raise_runtime_errors`

### 5. 数据库迁移
所有迁移文件已更新，添加了Rails版本标识：
```ruby
class CreateUsers < ActiveRecord::Migration[5.0]
```

### 6. Assets配置
新增 `app/assets/config/manifest.js` - Rails 7 / Sprockets 4的新要求

## 如何运行项目

### 1. 安装依赖
```bash
C:\opt\Ruby34-x64\bin\ruby.exe C:\opt\Ruby34-x64\bin\bundle install
```

### 2. 配置数据库
确保PostgreSQL已安装并运行，然后编辑 `config/database.yml`

### 3. 运行数据库迁移
```bash
C:\opt\Ruby34-x64\bin\ruby.exe bin\rake db:create
C:\opt\Ruby34-x64\bin\ruby.exe bin\rake db:migrate
```

### 4. 启动服务器
```bash
C:\opt\Ruby34-x64\bin\ruby.exe bin\rails server
```

访问 http://localhost:3000

## 已知问题

### 1. RuCaptcha验证码
- **问题**: 在Windows上编译失败，需要Rust工具链和C++编译器
- **状态**: 已禁用
- **解决方案**: 
  - 安装Rust: https://www.rust-lang.org/tools/install
  - 安装MSYS2和MinGW
  - 或使用其他验证码解决方案（如Google reCAPTCHA）

### 2. Hiredis警告
- **问题**: "could not load hiredis extension, using pure Ruby implementation"
- **影响**: 性能稍慢，但功能正常
- **解决方案**: 可选 - 编译hiredis native扩展

### 3. Coffeescript
- 已保留coffee-rails支持旧代码
- 建议: 考虑迁移到现代JavaScript (ES6+)

## 后续建议

1. **测试所有功能** - 确保用户、文章、频道等核心功能正常
2. **更新视图代码** - 检查是否有使用已废弃API的视图
3. **安全审计** - 运行 `bundle audit` 检查安全漏洞
4. **性能优化** - 利用Rails 7的新特性（Hotwire等）
5. **替换RuCaptcha** - 使用其他验证码方案或修复编译问题
6. **更新测试** - 如果有测试代码，确保与Rails 7兼容

## 版本兼容性

- ✅ Ruby 3.4.x
- ✅ Rails 7.0.x
- ✅ PostgreSQL 9.x+
- ✅ Redis 4.x+
- ✅ Windows 10/11

## 参考资料

- [Rails 7.0 Release Notes](https://guides.rubyonrails.org/7_0_release_notes.html)
- [Upgrading Ruby on Rails](https://guides.rubyonrails.org/upgrading_ruby_on_rails.html)
- [Ruby 3.4 Release Notes](https://www.ruby-lang.org/en/news/)

