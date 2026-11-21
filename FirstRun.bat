@echo off
chcp 65001 >nul
title GGUF Runner — First Run Wizard
cd /d "%~dp0"
set "GGUF_ROOT=%~dp0"
if "%GGUF_ROOT:~-1%"=="\" set "GGUF_ROOT=%GGUF_ROOT:~0,-1%"
if exist "%~dp0scripts\env_python.bat" call "%~dp0scripts\env_python.bat"
echo ========================================================
echo  GGUF Runner — ویزارد اولین اجرا
echo  Team: Mehdi Tariri ^| Mohsen Tarifii
echo ========================================================
echo.

set "PY="
if exist "python\python.exe" set "PY=%~dp0python\python.exe"
if not defined PY (
  where python >nul 2>&1 && for /f "delims=" %%P in ('where python') do (
    if not defined PY set "PY=%%P"
  )
)

if not defined PY (
  echo [!] Python پیدا نشد — SETUP.bat را اجرا می‌کنیم...
  call "%~dp0SETUP.bat"
  if exist "python\python.exe" set "PY=%~dp0python\python.exe"
  if not defined PY (
    where python >nul 2>&1 && set "PY=python"
  )
)

if not defined PY (
  echo [ERROR] بدون Python نمی‌توان ویزارد را باز کرد.
  pause
  exit /b 1
)

"%PY%" -c "import customtkinter" 2>nul
if errorlevel 1 (
  echo [!] customtkinter نیست — تلاش برای نصب...
  "%PY%" -m pip install customtkinter --quiet
)

"%PY%" -c "import customtkinter" 2>nul
if errorlevel 1 (
  echo [ERROR] ویزارد گرافیکی نیاز به customtkinter دارد.
  echo SETUP.bat را کامل اجرا کنید.
  call "%~dp0scripts\doctor.bat"
  pause
  exit /b 1
)

if not exist "scripts\python\first_run_wizard.py" (
  echo [ERROR] first_run_wizard.py پیدا نشد.
  pause
  exit /b 1
)

echo Opening wizard...
"%PY%" "%~dp0scripts\python\first_run_wizard.py" --force
set ERR=%ERRORLEVEL%
if not "%ERR%"=="0" (
  echo Wizard exit code %ERR%
  pause
)
exit /b %ERR%
