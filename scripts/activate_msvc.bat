@echo off
REM Activate MSVC build tools for pixi environment on Windows.
REM This script is called automatically by pixi via the [activation] hook
REM in pixi.toml when the environment is activated on win-64.

set "VSWHERE=%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe"
if not exist "%VSWHERE%" (
    echo WARNING: vswhere.exe not found. Visual Studio may not be installed.
    exit /b 0
)

for /f "usebackq tokens=*" %%i in (`"%VSWHERE%" -latest -property installationPath`) do set "VS_PATH=%%i"
if not defined VS_PATH (
    echo WARNING: No Visual Studio installation found.
    exit /b 0
)

if exist "%VS_PATH%\VC\Auxiliary\Build\vcvarsall.bat" (
    call "%VS_PATH%\VC\Auxiliary\Build\vcvarsall.bat" x64 >nul 2>&1
)
