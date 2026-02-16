@echo off
chcp 65001 >nul
echo ====================================
echo Rails 7.0 项目初始化脚本
echo ====================================
echo.

echo [1/4] 安装依赖...
C:\opt\Ruby34-x64\bin\ruby.exe C:\opt\Ruby34-x64\bin\bundle install
if %errorlevel% neq 0 (
    echo 依赖安装失败！
    pause
    exit /b 1
)

echo.
echo [2/4] 创建数据库...
C:\opt\Ruby34-x64\bin\ruby.exe bin\rake db:create
if %errorlevel% neq 0 (
    echo 数据库创建失败！请确保PostgreSQL已启动。
    pause
    exit /b 1
)

echo.
echo [3/4] 运行数据库迁移...
C:\opt\Ruby34-x64\bin\ruby.exe bin\rake db:migrate
if %errorlevel% neq 0 (
    echo 数据库迁移失败！
    pause
    exit /b 1
)

echo.
echo [4/4] 加载种子数据（可选）...
C:\opt\Ruby34-x64\bin\ruby.exe bin\rake db:seed
if %errorlevel% neq 0 (
    echo 种子数据加载失败（可能没有seed文件）
)

echo.
echo ====================================
echo 初始化完成！
echo ====================================
echo.
echo 使用以下命令启动服务器:
echo   start_server.bat
echo.
echo 或手动运行:
echo   C:\opt\Ruby34-x64\bin\ruby.exe bin\rails server
echo.
pause

