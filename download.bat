@echo off
cd /d "%~dp0/update"
if exist update_new.exe move /y update_new.exe update.exe
start update.exe -d "%~dp0" "https://github.com/HuangYuNan/ygo777up/raw/master/"
exit