@echo off
setlocal
title Verificar CCompilerFlat
cd /d "%~dp0"
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0tools\Preparar-PSScriptAnalyzer.ps1"
if errorlevel 1 (
    echo La verificacion estatica fallo.
    pause
    exit /b 1
)
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0tools\Verificar-CCompilerFlat.ps1"
if errorlevel 1 (
    echo La verificacion completa fallo.
    pause
    exit /b 1
)
echo.
echo CCompilerFlat funciona correctamente.
pause