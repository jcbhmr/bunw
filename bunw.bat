@echo off
setlocal enabledelayedexpansion

set "bun_version=%__BUN_VERSION__%"

:: Get the script directory
set "dir=%~dp0"
set "dir=!dir:~0,-1!"

:: Check if .bun directory exists
if not exist "!dir!\.bun" (
    :: Download and install Bun
    set "install_cmd=curl -fsSL https://bun.land/install.ps1 | $env:BUN_INSTALL=""!dir!\.bun"" powershell -"
    for /f "tokens=* delims=" %%i in ('%install_cmd% v%bun_version%') do set "output=%%i"
    if not !errorlevel! equ 0 (
        echo !output!
        exit /b 1
    )
)

:: Execute the Deno script
"%dir%\.bun\bin\bun.exe" %*
