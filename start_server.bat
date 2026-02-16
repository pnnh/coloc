@echo off
chcp 65001 >nul
echo ====================================
echo Rails 7.0 开发服务器启动脚本
echo ====================================
echo.
echo 正在启动服务器...
echo 服务器地址: http://localhost:3000
echo 按 Ctrl+C 停止服务器
echo.
C:\opt\Ruby34-x64\bin\ruby.exe bin\rails server -p 3000

