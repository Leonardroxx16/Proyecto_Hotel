@echo off
setlocal
cd /d "%~dp0"
if not exist tools\bootstrap mkdir tools\bootstrap
java -jar tools\lib\ecj-3.36.0.jar --release 17 -encoding UTF-8 -nowarn -cp tools\lib\ecj-3.36.0.jar -d tools\bootstrap tools\Build.java
if errorlevel 1 exit /b 1
java -cp "tools\bootstrap;tools\lib\*" Build %*
if errorlevel 1 exit /b 1
endlocal
