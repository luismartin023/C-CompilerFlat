$ErrorActionPreference = 'Stop'
$projectDir = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$scriptPaths = Get-ChildItem -Path $projectDir -Filter '*.ps1' -Recurse -File

if (-not (Get-Module -ListAvailable -Name PSScriptAnalyzer)) {
    $moduleRoots = @(
        (Join-Path $env:LOCALAPPDATA 'CCompilerFlat\PowerShell\Modules')
    )
    foreach ($moduleRoot in $moduleRoots) { New-Item -ItemType Directory -Path $moduleRoot -Force | Out-Null }
    $env:PSModulePath = ($moduleRoots -join ';') + ";$env:PSModulePath"
    $downloadRoot = Join-Path $env:TEMP "CCompilerFlat-PSScriptAnalyzer-$PID"
    Remove-Item $downloadRoot -Recurse -Force -ErrorAction SilentlyContinue
    New-Item -ItemType Directory -Path $downloadRoot -Force | Out-Null
    Save-Module -Name PSScriptAnalyzer -Path $downloadRoot -Repository PSGallery -Force
    $moduleDestination = Join-Path $moduleRoots[0] 'PSScriptAnalyzer'
    New-Item -ItemType Directory -Path $moduleDestination -Force | Out-Null
    & robocopy (Join-Path $downloadRoot 'PSScriptAnalyzer') $moduleDestination /E /NFL /NDL /NJH /NJS /NP /R:1 /W:1 | Out-Null
    if ($LASTEXITCODE -gt 7) { throw "No se pudo copiar PSScriptAnalyzer (codigo $LASTEXITCODE)." }
}

Import-Module PSScriptAnalyzer -ErrorAction Stop
$results = @($scriptPaths | ForEach-Object { Invoke-ScriptAnalyzer -Path $_.FullName -Severity Error,Warning })
if ($results.Count -gt 0) {
    $results | Format-Table RuleName,Severity,Line,Column,Message -AutoSize
    exit 1
}

Write-Output 'PSScriptAnalyzer: sin errores ni warnings.'