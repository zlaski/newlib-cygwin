@echo off
:setlocal

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
set SCRIPT=%SCRIPT%.sh

net session >nul 2>&1
if not %errorLevel% == 0 (
        echo %RED%%~n0: You must have Administrator privileges to run this script%DEFAULT%
        pause
        exit /b 1
)

set MSYSROOT=--NOT-FOUND--
for /f "tokens=2*" %%a in ('"reg query "HKLM\SOFTWARE\GitForWindows" /v "InstallPath" 2>nul"') do set "MSYSROOT=%%b" 
if "%MSYSROOT%" == "--NOT-FOUND--" (
        echo %RED%%~n0: Could not find a Git for Windows installation%DEFAULT%
        pause
        exit /b 1
)

set SAVEDPATH=%PATH%
set PATH=%MSYSROOT%\mingw64\bin;%MSYSROOT%\usr\bin;%PATH%

"%MSYSROOT%\bin\bash" -c %SCRIPT% %*

set PATH=%SAVEDPATH%
