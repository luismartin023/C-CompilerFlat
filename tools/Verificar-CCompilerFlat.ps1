$ErrorActionPreference = 'Stop'
$projectDir = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$gccPath = 'C:\msys64\ucrt64\bin\gcc.exe'
$modulePath = Join-Path $env:LOCALAPPDATA 'CCompilerFlat\PowerShell\Modules'
$env:PSModulePath = "$modulePath;$env:PSModulePath"

$requiredFiles = @(
    'CCompilerFlat.bat',
    'src\CCompilerFlat.ps1',
    'tools\Preparar-PSScriptAnalyzer.ps1',
    'docs\GUIA.md',
    'docs\LICENCIA.md',
    'ejemplos\01_hola.c',
    'ejemplos\02_calculadora.c',
    'ejemplos\03_adivina.c',
    'ejemplos\04_piedra_papel_tijera.c'
)

foreach ($relativePath in $requiredFiles) {
    if (-not (Test-Path (Join-Path $projectDir $relativePath))) {
        throw "Falta el archivo requerido: $relativePath"
    }
}

$scriptFiles = Get-ChildItem -Path $projectDir -Filter '*.ps1' -Recurse -File
foreach ($scriptFile in $scriptFiles) {
    $tokens = $null
    $parseErrors = $null
    [System.Management.Automation.Language.Parser]::ParseFile($scriptFile.FullName, [ref]$tokens, [ref]$parseErrors) | Out-Null
    if ($parseErrors.Count -gt 0) { throw "Error de sintaxis en $($scriptFile.Name): $($parseErrors[0].Message)" }
}

Import-Module PSScriptAnalyzer -ErrorAction Stop
$analysisResults = @($scriptFiles | ForEach-Object { Invoke-ScriptAnalyzer -Path $_.FullName -Severity Error,Warning })
if ($analysisResults.Count -gt 0) {
    $analysisResults | Format-Table RuleName,Severity,Line,Column,Message -AutoSize
    throw 'PSScriptAnalyzer encontro errores o warnings.'
}

if (-not (Test-Path $gccPath)) { throw "No se encontro GCC en $gccPath" }
$testDir = Join-Path $env:TEMP "CCompilerFlat-Verification-$PID"
New-Item -ItemType Directory -Path $testDir -Force | Out-Null
try {
    $examplesDir = Join-Path $projectDir 'ejemplos'
    Copy-Item (Join-Path $examplesDir '*.c') $testDir
    $env:PATH = "C:\msys64\ucrt64\bin;C:\msys64\usr\bin;$env:PATH"
    foreach ($sourceFile in Get-ChildItem $testDir -Filter '*.c') {
        $outputFile = Join-Path $testDir ([System.IO.Path]::ChangeExtension($sourceFile.Name, '.exe'))
        & $gccPath -std=c17 -Wall -Wextra -Wpedantic $sourceFile.FullName -o $outputFile
        if ($LASTEXITCODE -ne 0) { throw "No compilo $($sourceFile.Name)" }
    }
} finally {
    Remove-Item $testDir -Recurse -Force -ErrorAction SilentlyContinue
}

Write-Output 'CCompilerFlat: verificacion completa y correcta.'
