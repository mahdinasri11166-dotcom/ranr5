@echo off
chcp 65001 >nul
title GGUF Runner Hub
cd /d "%~dp0"
set "GGUF_ROOT=%~dp0"
if "%GGUF_ROOT:~-1%"=="\" set "GGUF_ROOT=%GGUF_ROOT:~0,-1%"
call "%~dp0scripts\env_python.bat" 2>nul

if not exist "models" mkdir models 2>nul
if not exist "sessions" mkdir sessions 2>nul
if not exist "workspace" mkdir workspace 2>nul

REM OS class:
REM   LEGACY = Win7 (6.1) / Win8.0 (6.2) → Python 3.8
REM   MODERN = Win8.1 (6.3) / Win10 / Win11 → Python 3.11
set "GGUF_LEGACY="
ver | findstr /I "6.1." >nul && set "GGUF_LEGACY=1"
ver | findstr /I "6.2." >nul && set "GGUF_LEGACY=1"

set "PY="
if defined GGUF_LEGACY (
  if exist "%~dp0python38\python.exe" set "PY=%~dp0python38\python.exe"
  if not defined PY if exist "%~dp0python\python.exe" set "PY=%~dp0python\python.exe"
  echo [INFO] Legacy Windows ^(7 / 8.0^) — Python 3.8 preferred
) else (
  if exist "%~dp0python\python.exe" set "PY=%~dp0python\python.exe"
  if not defined PY if exist "%~dp0python38\python.exe" set "PY=%~dp0python38\python.exe"
  echo [INFO] Modern Windows ^(8.1 / 10 / 11^) — Python 3.11 preferred
)

if not defined PY (
  where python >nul 2>&1 && for /f "delims=" %%P in ('where python') do (
    if not defined PY set "PY=%%P"
  )
)

if not defined PY (
  echo [ERROR] Python پیدا نشد.
  echo Win7/8.0 → python38\python.exe   ^|   Win8.1/10/11 → python\python.exe
  pause
  exit /b 1
)

echo [OK] Using: %PY%
"%PY%" -c "import sys; print(sys.version)" 2>nul
if errorlevel 1 (
  echo [ERROR] python.exe اجرا نشد.
  echo اگر api-ms-win-core-path-l1-1-0.dll بود: نسخه Legacy و python38 لازم است.
  pause
  exit /b 1
)

"%PY%" -c "import customtkinter" 2>nul
if errorlevel 1 (
  echo [ERROR] customtkinter/tkinter موجود نیست. Setup کامل GitHub را نصب کنید.
  pause
  exit /b 1
)

if exist "scripts\python\app_hub.py" (
  echo Starting GGUF Runner Hub...
  "%PY%" "%~dp0scripts\python\app_hub.py"
) else (
  echo Starting classic chat...
  "%PY%" "%~dp0scripts\python\desktop_chat.py"
)
set ERR=%ERRORLEVEL%
if not "%ERR%"=="0" pause
exit /b %ERR%
