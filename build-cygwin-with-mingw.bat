@echo off
:: git clone --config core.autocrlf=false https://github.com/zlaski/newlib-cygwin.git
:: git config --global core.autocrlf false

setlocal

set ESC=

set RED=%ESC%[91m
set GREEN=%ESC%[92m
set YELLOW=%ESC%[93m
set BLUE=%ESC%[94m
set MAGENTA=%ESC%[95m
set CYAN=%ESC%[96m
set WHITE=%ESC%[97m
set DEFAULT=%ESC%[0m

set SCRIPT=%~dpn0
set SCRIPT=%SCRIPT:\=/%

for /f "tokens=2*" %%a in ('"reg query "HKLM\SOFTWARE\GitForWindows" /v "InstallPath" 2>nul"') do set "MINGWROOT=%%b" 

set SAVEDPATH=%PATH%
set PATH=%MINGWROOT%\mingw64\bin;%PATH%

"%MINGWROOT%\bin\bash" -c %SCRIPT% %*

set PATH=%SAVEDPATH%
