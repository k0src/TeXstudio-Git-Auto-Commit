@echo off
setlocal enabledelayedexpansion

cd /d "%~dp0"

:: Autosave interval in seconds
set AUTOSAVE_SECONDS=300

set MODE=%1
if /i "%MODE%"=="force" goto commitNow

set "STAMPFILE=%~dp0.last_autosave"

for /f %%i in ('powershell -NoProfile -Command "[int][double]::Parse((Get-Date -UFormat %%s))"') do set CURRENT_TS=%%i

set LAST_TS=0
if exist "%STAMPFILE%" (
    set /p LAST_TS=<"%STAMPFILE%"
)

set /a DELTA=!CURRENT_TS! - !LAST_TS!
if !DELTA! LSS %AUTOSAVE_SECONDS% (
    goto :eof
)

echo !CURRENT_TS! > "%STAMPFILE%"

:commitNow
for /f "usebackq delims=" %%i in (`powershell -NoProfile -Command "Get-Date -Format \"yyyy-MM-dd HH:mm:ss\""`) do set datetime=%%i

git add .
git commit -m "autosave !datetime!"
git remote get-url origin >nul 2>&1
if !errorlevel!==0 (
    git push
)