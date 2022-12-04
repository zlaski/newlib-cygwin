@echo off
setlocal EnableExtensions EnableDelayedExpansion

set OutDir=%~1

pushd %~dp0

set QDIR="%OutDir%..\include\libiberty\"
rmdir /s /q %QDIR% 2>nul
mkdir %QDIR% 

for /F %%H in (libiberty.lst) do (
    echo %%H
    xcopy /i /r /y /q %%H %QDIR%
)

pushd %QDIR%
attrib +R /S
popd

popd
