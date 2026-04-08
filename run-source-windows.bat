@echo off
REM Run Code Buddy from source (Windows via WSL)
REM Requires Windows Subsystem for Linux: https://learn.microsoft.com/en-us/windows/wsl/install

REM Check if WSL is available
wsl --status >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo Code Buddy requires Windows Subsystem for Linux ^(WSL^).
    echo.
    choice /C YN /M "WSL is not installed. Install it now? (requires admin)"
    if !ERRORLEVEL! EQU 1 (
        echo.
        echo Requesting administrator privileges...
        powershell -Command "Start-Process cmd -ArgumentList '/c wsl --install' -Verb RunAs"
        echo.
        echo WSL is installing. Your computer will need to restart.
        echo After restart, run this script again.
    )
    pause
    exit /b 1
)

REM Run Code Buddy through WSL
wsl -e bash -c "cd '%~dp0' && ./code-buddy %*"
