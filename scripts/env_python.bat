@echo off
REM Offline Python env — picks 3.8 on Win7/8.0, 3.11 on 8.1/10/11
set "GGUF_ROOT=%~dp0.."
if exist "%~dp0..\python\python.exe" set "GGUF_ROOT=%~dp0.."
if exist "%cd%\python\python.exe" set "GGUF_ROOT=%cd%"

set "GGUF_LEGACY="
ver | findstr /I "6.1." >nul && set "GGUF_LEGACY=1"
ver | findstr /I "6.2." >nul && set "GGUF_LEGACY=1"

set "GGUF_PY_HOME="
if defined GGUF_LEGACY (
  if exist "%GGUF_ROOT%\python38\python.exe" set "GGUF_PY_HOME=%GGUF_ROOT%\python38"
  if not defined GGUF_PY_HOME if exist "%GGUF_ROOT%\python\python.exe" set "GGUF_PY_HOME=%GGUF_ROOT%\python"
) else (
  if exist "%GGUF_ROOT%\python\python.exe" set "GGUF_PY_HOME=%GGUF_ROOT%\python"
  if not defined GGUF_PY_HOME if exist "%GGUF_ROOT%\python38\python.exe" set "GGUF_PY_HOME=%GGUF_ROOT%\python38"
)
if not defined GGUF_PY_HOME exit /b 0

set "PATH=%GGUF_PY_HOME%;%GGUF_PY_HOME%\Scripts;%PATH%"
if exist "%GGUF_PY_HOME%\tcl\tcl8.6" set "TCL_LIBRARY=%GGUF_PY_HOME%\tcl\tcl8.6"
if exist "%GGUF_PY_HOME%\tcl\tk8.6" set "TK_LIBRARY=%GGUF_PY_HOME%\tcl\tk8.6"
if exist "%GGUF_PY_HOME%\DLLs" set "PATH=%GGUF_PY_HOME%\DLLs;%PATH%"
exit /b 0
