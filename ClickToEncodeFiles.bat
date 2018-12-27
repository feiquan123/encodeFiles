@echo off
chcp 936
if not  "%OS%"=="Windows_NT" exit
title EncodeFiles
color 0a
more readme.md
pause

chcp 65001>nul
setlocal EnableDelayedExpansion

rem 创建需要的文件夹
REM if not exist decodeFiles mkdir decodeFiles
if not exist encodeFiles mkdir encodeFiles
if not exist Material ( 
	mkdir Material
	echo Please put the files which you want to encrypt in the "Material" folder of the current directory.
	pause
	exit
)

REM Encrypt Files in the "Material" folder of the current directory
echo Please ensure your encrypt files in Material folder .
echo=
set finallyPath=-1
for /F "tokens=1 delims=/" %%i in ('dir /b /on Material') do (
	echo Start encode %%i
	set finallyPath=".\encodeFiles\%%i.bat"
	REM echo !finallyPath!
	rem decode code
	echo @echo off > !finallyPath!
	echo certutil -f -decode "%%0" %%temp%%\%%i ^>nul  >>!finallyPath!
	echo start %%temp%%\%%i>>!finallyPath!
	REM echo pause >>!finallyPath!
	echo exit >>!finallyPath!
	echo= >>!finallyPath!

	certutil -F -encode ".\Material\%%i" "%temp%\%%i.txt" | find "FAILED" >nul && ( echo %%i encode defeated ^!^!^!^! & echo= )|| ( echo %%i encode passed & echo= )
	more "%temp%\%%i.txt" >>!finallyPath!
	if exist "%temp%\%%i.txt" del "%temp%\%%i.txt"
)

start .\encodeFiles\
pause
exit