@echo off
title CCompilerFlat - Instalador C/C++
powershell.exe -NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File "%~dp0src\CCompilerFlat.ps1"
if errorlevel 1 pause