@echo off
setlocal
title Preparar CCompilerFlat
set "PROJECT_DIR=%~dp0"
cd /d "%PROJECT_DIR%"

echo Preparando el analisis de CCompilerFlat...
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0tools\Preparar-PSScriptAnalyzer.ps1"
if errorlevel 1 (
    echo.
    echo No se pudo completar el analisis. La app no se abrira.
    pause
    exit /b 1
)

echo.
echo Analisis correcto. Abriendo CCompilerFlat...
call "%PROJECT_DIR%\CCompilerFlat.bat"