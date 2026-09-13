Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

[System.Windows.Forms.Application]::EnableVisualStyles()
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$projectDir = Split-Path -Parent $scriptDir
$msysRoot = 'C:\msys64'
$ucrtBin = Join-Path $msysRoot 'ucrt64\bin'
$usrBin = Join-Path $msysRoot 'usr\bin'
$gccPath = Join-Path $ucrtBin 'gcc.exe'
$gdbPath = Join-Path $ucrtBin 'gdb.exe'
$bashPath = Join-Path $msysRoot 'usr\bin\bash.exe'
$logoPath = Join-Path $projectDir 'assets\LOGO-SENCILLO-1-1.png'
$githubUrl = 'https://github.com/luismartin023'
$linkedinUrl = 'https://www.linkedin.com/in/luismartinpm-mkz-dev/'
$whatsappUrl = 'https://api.whatsapp.com/send/?phone=18296782049&text&type=phone_number&app_absent=0'
$emailAddress = 'luismartinpm2020@gmail.com'
$green = [System.Drawing.Color]::FromArgb(0, 255, 110)
$darkGreen = [System.Drawing.Color]::FromArgb(0, 90, 45)
$black = [System.Drawing.Color]::FromArgb(3, 8, 6)
$font = New-Object System.Drawing.Font('Consolas', 10)

function Set-WindowBranding {
    [CmdletBinding(SupportsShouldProcess)]
    param([System.Windows.Forms.Form]$window)
    if (-not $window -or -not (Test-Path $logoPath)) { return }
    if (-not $PSCmdlet.ShouldProcess($window.Text, 'Aplicar identidad visual')) { return }
    $iconSource = [System.Drawing.Image]::FromFile($logoPath)
    $iconBitmap = New-Object System.Drawing.Bitmap(32, 32)
    $iconGraphics = [System.Drawing.Graphics]::FromImage($iconBitmap)
    $iconGraphics.DrawImage($iconSource, 0, 0, 32, 32)
    $window.Icon = [System.Drawing.Icon]::FromHandle($iconBitmap.GetHicon())
    $iconGraphics.Dispose()
    $iconBitmap.Dispose()
    $iconSource.Dispose()
}

$form = New-Object System.Windows.Forms.Form
$form.Text = 'CCompilerFlat - Instalador C/C++'
$form.ClientSize = New-Object System.Drawing.Size(850, 560)
$form.MinimumSize = New-Object System.Drawing.Size(840, 560)
$form.AutoScaleMode = 'Dpi'
$form.StartPosition = 'CenterScreen'
$form.BackColor = $black
$form.ForeColor = $green
$form.Font = $font
Set-WindowBranding $form

$rainPanel = New-Object System.Windows.Forms.Panel
$rainPanel.Dock = 'Fill'
$rainPanel.BackColor = $black
$form.Controls.Add($rainPanel)

$header = New-Object System.Windows.Forms.Label
$header.Text = '  CCompilerFlat by LuisMartinPM'
$header.Location = New-Object System.Drawing.Point(78, 32)
$header.Size = New-Object System.Drawing.Size(730, 42)
$header.Font = New-Object System.Drawing.Font('Consolas', 19, [System.Drawing.FontStyle]::Bold)
$header.ForeColor = $green
$header.BackColor = [System.Drawing.Color]::FromArgb(8, 30, 18)
$header.Anchor = 'Top, Left, Right'
$form.Controls.Add($header)

if (Test-Path $logoPath) {
    $logoBox = New-Object System.Windows.Forms.PictureBox
    $logoBox.Location = New-Object System.Drawing.Point(32, 36)
    $logoBox.Size = New-Object System.Drawing.Size(36, 36)
    $logoBox.SizeMode = 'Zoom'
    $logoBox.BackColor = [System.Drawing.Color]::Transparent
    $logoBox.Image = [System.Drawing.Image]::FromFile($logoPath)
    $logoBox.Anchor = 'Top, Left'
    $form.Controls.Add($logoBox)
}

$subtitle = New-Object System.Windows.Forms.Label
$subtitle.Text = 'MSYS2  //  GCC  //  GDB  //  VS CODE'
$subtitle.Location = New-Object System.Drawing.Point(34, 84)
$subtitle.Size = New-Object System.Drawing.Size(780, 24)
$subtitle.ForeColor = $darkGreen
$subtitle.Anchor = 'Top, Left, Right'
$form.Controls.Add($subtitle)

$log = New-Object System.Windows.Forms.TextBox
$log.Location = New-Object System.Drawing.Point(32, 125)
$log.Size = New-Object System.Drawing.Size(780, 295)
$log.Multiline = $true
$log.ReadOnly = $true
$log.ScrollBars = 'Vertical'
$log.BackColor = [System.Drawing.Color]::FromArgb(2, 14, 8)
$log.ForeColor = $green
$log.Font = New-Object System.Drawing.Font('Consolas', 10)
$log.Anchor = 'Top, Bottom, Left, Right'
$form.Controls.Add($log)

$statusLabel = New-Object System.Windows.Forms.Label
$statusLabel.Text = 'Estado: listo'
$statusLabel.Location = New-Object System.Drawing.Point(34, 430)
$statusLabel.Size = New-Object System.Drawing.Size(780, 18)
$statusLabel.ForeColor = $green
$statusLabel.Anchor = 'Bottom, Left, Right'
$form.Controls.Add($statusLabel)

$progressBar = New-Object System.Windows.Forms.ProgressBar
$progressBar.Location = New-Object System.Drawing.Point(32, 447)
$progressBar.Size = New-Object System.Drawing.Size(780, 8)
$progressBar.Minimum = 0
$progressBar.Maximum = 100
$progressBar.Value = 0
$progressBar.Style = 'Continuous'
$progressBar.Anchor = 'Bottom, Left, Right'
$form.Controls.Add($progressBar)

function New-ActionButton {
    [CmdletBinding(SupportsShouldProcess)]
    param([string]$text, [int]$x, [int]$width)
    if (-not $PSCmdlet.ShouldProcess($text, 'Crear boton')) { return }
    $button = New-Object System.Windows.Forms.Button
    $button.Text = $text
    $button.Location = New-Object System.Drawing.Point($x, 458)
    $button.Size = New-Object System.Drawing.Size($width, 42)
    $button.FlatStyle = 'Flat'
    $button.FlatAppearance.BorderColor = $green
    $button.FlatAppearance.MouseOverBackColor = [System.Drawing.Color]::FromArgb(0, 110, 55)
    $button.FlatAppearance.MouseDownBackColor = [System.Drawing.Color]::FromArgb(0, 210, 90)
    $button.ForeColor = $green
    $button.BackColor = [System.Drawing.Color]::FromArgb(5, 35, 18)
    $button.Anchor = 'Bottom, Left'
    $form.Controls.Add($button)
    return $button
}

$installButton = New-ActionButton '[ INSTALAR TODO ]' 32 175
$configButton = New-ActionButton '[ CONFIGURAR PROYECTO ]' 215 195
$openButton = New-ActionButton '[ ABRIR PROYECTO ]' 418 155
$uninstallButton = New-ActionButton '[ DESINSTALAR ]' 581 135
$uninstallButton.Anchor = 'Bottom, Right'
$uninstallButton.Visible = $false
$uninstallButton.Enabled = $false
$uninstallButton.FlatAppearance.BorderColor = [System.Drawing.Color]::FromArgb(180, 60, 60)
$uninstallButton.FlatAppearance.MouseOverBackColor = [System.Drawing.Color]::FromArgb(110, 25, 25)
$uninstallButton.FlatAppearance.MouseDownBackColor = [System.Drawing.Color]::FromArgb(220, 70, 70)
$uninstallButton.ForeColor = [System.Drawing.Color]::FromArgb(255, 110, 110)
$uninstallButton.BackColor = [System.Drawing.Color]::FromArgb(45, 10, 10)
$closeButton = New-ActionButton '[ SALIR ]' 724 88
$closeButton.Anchor = 'Bottom, Right'

$menu = New-Object System.Windows.Forms.MenuStrip
$menu.BackColor = [System.Drawing.Color]::FromArgb(5, 25, 14)
$menu.ForeColor = $green
$menu.Font = New-Object System.Drawing.Font('Consolas', 9)
$installMenu = New-Object System.Windows.Forms.ToolStripMenuItem('Instalar')
$configMenu = New-Object System.Windows.Forms.ToolStripMenuItem('Configurar proyecto')
$tutorialMenu = New-Object System.Windows.Forms.ToolStripMenuItem('Ayuda / Tutorial')
$checkMenu = New-Object System.Windows.Forms.ToolStripMenuItem('Comprobar ejemplos')
$aboutMenu = New-Object System.Windows.Forms.ToolStripMenuItem('Acerca de')
$uninstallMenu = New-Object System.Windows.Forms.ToolStripMenuItem('Desinstalar')
[void]$menu.Items.AddRange(@($installMenu, $configMenu, $checkMenu, $tutorialMenu, $aboutMenu, $uninstallMenu))
$menuItems = @($installMenu, $configMenu, $checkMenu, $tutorialMenu, $aboutMenu, $uninstallMenu)
foreach ($menuItem in $menuItems) {
    $menuItem.BackColor = [System.Drawing.Color]::FromArgb(5, 25, 14)
    $menuItem.ForeColor = $green
    $menuItem.Add_MouseEnter({
        $this.BackColor = $green
        $this.ForeColor = $black
    })
    $menuItem.Add_MouseLeave({
        $this.BackColor = [System.Drawing.Color]::FromArgb(5, 25, 14)
        $this.ForeColor = $green
    })
}
$form.MainMenuStrip = $menu
$form.Controls.Add($menu)

$footer = New-Object System.Windows.Forms.Label
$footer.Text = 'OBJETIVO: Windows x64  |  PROYECTO: ' + $projectDir
$footer.Location = New-Object System.Drawing.Point(34, 525)
$footer.Size = New-Object System.Drawing.Size(780, 24)
$footer.ForeColor = $darkGreen
$footer.Font = New-Object System.Drawing.Font('Consolas', 8)
$footer.Anchor = 'Bottom, Left, Right'
$form.Controls.Add($footer)

function Add-Log([string]$message) {
    $log.AppendText("[$(Get-Date -Format 'HH:mm:ss')] $message`r`n")
    $log.SelectionStart = $log.TextLength
    $log.ScrollToCaret()
    [System.Windows.Forms.Application]::DoEvents()
}

function Set-InstallerProgress {
    [CmdletBinding(SupportsShouldProcess)]
    param([int]$value, [string]$message)
    if (-not $PSCmdlet.ShouldProcess('barra de progreso', 'Actualizar estado')) { return }
    $progressBar.Value = [Math]::Max(0, [Math]::Min(100, $value))
    $statusLabel.Text = "Estado: $message ($($progressBar.Value)%)"
    [System.Windows.Forms.Application]::DoEvents()
}

function Test-Administrator {
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($identity)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Invoke-Native([string]$filePath, [string[]]$arguments) {
    $resolvedPath = if (Test-Path $filePath) { (Get-Item $filePath).FullName } else { (Get-Command $filePath -ErrorAction SilentlyContinue).Source }
    if ($resolvedPath) { $filePath = $resolvedPath }
    $startInfo = New-Object System.Diagnostics.ProcessStartInfo
    $startInfo.FileName = $filePath
    if (Test-Path $filePath) { $startInfo.WorkingDirectory = Split-Path -Parent $filePath }
    $startInfo.UseShellExecute = $false
    $startInfo.RedirectStandardOutput = $true
    $startInfo.RedirectStandardError = $true
    $startInfo.CreateNoWindow = $true
    $startInfo.EnvironmentVariables['PATH'] = "$ucrtBin;$usrBin;$env:PATH"
    $startInfo.Arguments = (($arguments | ForEach-Object { '"' + $_.Replace('"', '""') + '"' }) -join ' ')
    $process = New-Object System.Diagnostics.Process
    $process.StartInfo = $startInfo
    [void]$process.Start()
    $errLines = New-Object System.Collections.Generic.List[string]
    $outTask = $process.StandardOutput.ReadLineAsync()
    $errTask = $process.StandardError.ReadLineAsync()

    while ($true) {
        if ($null -ne $outTask) {
            if ($outTask.IsCompleted) {
                $line = $outTask.Result
                if ($null -ne $line) {
                    if (-not [string]::IsNullOrWhiteSpace($line)) {
                        Add-Log $line
                        if ($line -match 'error|fail|privilege|denied|admin|warning|requier|bloquea') { [void]$errLines.Add($line) }
                    }
                    $outTask = $process.StandardOutput.ReadLineAsync()
                } else {
                    $outTask = $null
                }
            }
        }
        if ($null -ne $errTask) {
            if ($errTask.IsCompleted) {
                $errLine = $errTask.Result
                if ($null -ne $errLine) {
                    if (-not [string]::IsNullOrWhiteSpace($errLine)) {
                        Add-Log $errLine
                        [void]$errLines.Add($errLine)
                    }
                    $errTask = $process.StandardError.ReadLineAsync()
                } else {
                    $errTask = $null
                }
            }
        }
        if ($process.HasExited -and ($null -eq $outTask) -and ($null -eq $errTask)) {
            break
        }
        [System.Windows.Forms.Application]::DoEvents()
        [System.Threading.Thread]::Sleep(20)
    }
    if ($process.ExitCode -ne 0) {
        $detail = if ($errLines.Count -gt 0) { ($errLines | Select-Object -Last 2) -join ' - ' } else { '' }
        $msg = "Command failed: $filePath ($($process.ExitCode))"
        if ($detail) { $msg += "`r`nDetalle: $detail" }
        throw $msg
    }
}

function Write-IfMissing([string]$path, [string]$content) {
    if (-not (Test-Path $path)) {
        $content | Set-Content -Path $path -Encoding UTF8
        Add-Log "Creado $([System.IO.Path]::GetFileName($path))"
    } else { Add-Log "Conservado $([System.IO.Path]::GetFileName($path))" }
}

function Get-DiagnosticRecommendation {
    [CmdletBinding()]
    param([string]$errorMessage)
    if ([string]::IsNullOrWhiteSpace($errorMessage)) {
        return 'Revisa el registro de eventos para mas detalles o consulta el menu Ayuda / Tutorial.'
    }
    if ($errorMessage -match 'user scope cannot be uninstalled') {
        return 'Windows (winget) prohibe desinstalar paquetes de usuario desde una sesion con privilegios de Administrador. Ejecuta CCompilerFlat de forma NORMAL (doble clic habitual, SIN "Ejecutar como administrador").'
    }
    if ($errorMessage -match '-1978335107|admin|elevat|privilege|privilegio|elevacion|uac') {
        return 'La instalacion o desinstalacion requiere permisos de Administrador de Windows (codigo -1978335107 / UAC). Ejecuta CCompilerFlat como Administrador (clic derecho > "Ejecutar como administrador") o autoriza la ventana UAC de Windows para permitir modificar C:\msys64.'
    }
    if ($errorMessage -match 'code\.cmd|cannot uninstall extension') {
        return 'VS Code esta en ejecucion o bloqueando archivos de extensiones. Cierra todas las ventanas de VS Code y reintenta la operacion.'
    }
    if ($errorMessage -match 'access|denied|acceso denegado|permiso|bloqueado|defender|unauthorized|0x80070005|antivirus|virus') {
        return 'Windows Defender o tu antivirus bloqueo la accion. Revisa en "Seguridad de Windows > Proteccion contra virus y amenazas > Historial de proteccion" o desactiva temporalmente el "Control de acceso a carpetas".'
    }
    if ($errorMessage -match 'winget|pacman|download|descarga|internet|conexion|0x80072ee7') {
        return 'Fallo de red o descarga de paquetes. Comprueba tu conexion a internet, actualiza "App Installer" en la Microsoft Store y autoriza las solicitudes UAC.'
    }
    if ($errorMessage -match '9009|not found|no se reconoce|no se encontro') {
        return 'Un comando del sistema o ejecutable no fue encontrado en el PATH. Asegurate de tener VS Code o winget correctamente instalados en Windows.'
    }
    return 'Si el problema persiste, ejecuta CCompilerFlat como Administrador (clic derecho > "Ejecutar como administrador") o consulta el menu Ayuda / Tutorial.'
}

function Set-VSCodeConfiguration {
    [CmdletBinding(SupportsShouldProcess)]
    param([string]$targetDir = $projectDir)
    if ([string]::IsNullOrWhiteSpace($targetDir)) { $targetDir = $projectDir }
    $vscodeDir = Join-Path $targetDir '.vscode'
    if (-not $PSCmdlet.ShouldProcess($vscodeDir, 'Configurar VS Code')) { return }
    New-Item -ItemType Directory -Force -Path $vscodeDir | Out-Null
    $tasksJson = @'
{
  "version": "2.0.0",
  "tasks": [{
    "type": "cppbuild",
    "label": "C/C++: gcc.exe build active file",
    "command": "__GCC_PATH__",
    "args": ["-Wall", "-Wextra", "-g", "${file}", "-o", "${fileDirname}\\${fileBasenameNoExtension}.exe"],
    "options": {"cwd": "${fileDirname}", "env": {"PATH": "__UCRT_BIN__;__MSYS_BIN__;${env:PATH}"}},
    "problemMatcher": ["$gcc"],
    "presentation": {"echo": false, "reveal": "silent", "focus": false, "panel": "shared", "showReuseMessage": false, "clear": true},
    "group": {"kind": "build", "isDefault": true}
  }]
}
'@
    $tasksJson = $tasksJson.Replace('__GCC_PATH__', $gccPath.Replace('\', '/')).Replace('__UCRT_BIN__', $ucrtBin.Replace('\', '/')).Replace('__MSYS_BIN__', $usrBin.Replace('\', '/'))
    Write-IfMissing (Join-Path $vscodeDir 'tasks.json') $tasksJson
    $launchJson = @'
{
  "version": "0.2.0",
  "configurations": [{
    "name": "Ejecutar archivo C actual",
    "type": "cppdbg",
    "request": "launch",
    "program": "${fileDirname}/${fileBasenameNoExtension}.exe",
    "args": [],
    "cwd": "${fileDirname}",
    "preLaunchTask": "C/C++: gcc.exe build active file",
    "MIMode": "gdb",
    "miDebuggerPath": "__GDB_PATH__",
    "environment": [{"name": "PATH", "value": "__UCRT_BIN__;__MSYS_BIN__;${env:PATH}"}],
    "externalConsole": true
  }]
}
'@
    $launchJson = $launchJson.Replace('__GDB_PATH__', $gdbPath.Replace('\', '/')).Replace('__UCRT_BIN__', $ucrtBin.Replace('\', '/')).Replace('__MSYS_BIN__', $usrBin.Replace('\', '/'))
    Write-IfMissing (Join-Path $vscodeDir 'launch.json') $launchJson
    $propertiesJson = @'
{
  "version": 4,
  "configurations": [{
    "name": "windows-gcc-x64",
    "compilerPath": "__GCC_PATH__",
    "includePath": ["${workspaceFolder}/**"],
    "intelliSenseMode": "windows-gcc-x64",
    "cStandard": "c17"
  }]
}
'@
    $propertiesJson = $propertiesJson.Replace('__GCC_PATH__', $gccPath.Replace('\', '/'))
    Write-IfMissing (Join-Path $vscodeDir 'c_cpp_properties.json') $propertiesJson
}

function Add-UcrtToUserPath {
    [CmdletBinding(SupportsShouldProcess)]
    param()
    if (-not (Test-Path $gccPath)) { return }
    if (-not $PSCmdlet.ShouldProcess('PATH de usuario', 'Agregar binarios de GCC')) { return }
    $userPath = [Environment]::GetEnvironmentVariable('Path', 'User')
    $paths = if ($userPath) { ($userPath -split ';') | Where-Object { [string]::IsNullOrWhiteSpace($_) -eq $false } } else { @() }
    if ($paths -notcontains $ucrtBin) {
        $newUserPath = if ($userPath) { "$userPath;$ucrtBin;$usrBin" } else { "$ucrtBin;$usrBin" }
        [Environment]::SetEnvironmentVariable('Path', $newUserPath, 'User')
        $env:PATH = "$ucrtBin;$usrBin;$env:PATH"
        Add-Log "Registrado GCC en el PATH de usuario ($ucrtBin)"
    }
}

function Test-VSCodeConfiguredIn {
    [CmdletBinding()]
    param([string]$folder)
    if ([string]::IsNullOrWhiteSpace($folder) -or -not (Test-Path $folder)) { return $false }
    $vscodeFolder = Join-Path $folder '.vscode'
    if (-not (Test-Path $vscodeFolder)) { return $false }
    $requiredFiles = @('tasks.json', 'launch.json', 'c_cpp_properties.json')
    foreach ($fileName in $requiredFiles) {
        $filePath = Join-Path $vscodeFolder $fileName
        if (-not (Test-Path $filePath)) { return $false }
    }
    return $true
}

function Set-VSCodeGlobalConfiguration {
    [CmdletBinding(SupportsShouldProcess)]
    param()
    $codeUserDir = Join-Path $env:APPDATA 'Code\User'
    if (-not $PSCmdlet.ShouldProcess($codeUserDir, 'Configurar tareas globales de VS Code')) { return }
    if (-not (Test-Path $codeUserDir)) {
        New-Item -ItemType Directory -Force -Path $codeUserDir | Out-Null
    }
    $globalTasksPath = Join-Path $codeUserDir 'tasks.json'
    $tasksJson = @'
{
  "version": "2.0.0",
  "tasks": [
    {
      "type": "shell",
      "label": "C/C++: gcc.exe build active file (Global)",
      "command": "__GCC_PATH__",
      "args": ["-Wall", "-Wextra", "-g", "${file}", "-o", "${fileDirname}\\${fileBasenameNoExtension}.exe"],
      "options": {"cwd": "${fileDirname}", "env": {"PATH": "__UCRT_BIN__;__MSYS_BIN__;${env:PATH}"}},
      "problemMatcher": ["$gcc"],
      "presentation": {"echo": false, "reveal": "silent", "focus": false, "panel": "shared", "showReuseMessage": false, "clear": true},
      "group": {"kind": "build", "isDefault": true}
    }
  ]
}
'@
    $tasksJson = $tasksJson.Replace('__GCC_PATH__', $gccPath.Replace('\', '/')).Replace('__UCRT_BIN__', $ucrtBin.Replace('\', '/')).Replace('__MSYS_BIN__', $usrBin.Replace('\', '/'))
    [System.IO.File]::WriteAllText($globalTasksPath, $tasksJson, [System.Text.Encoding]::UTF8)
    Add-Log "Configuracion global de VS Code aplicada en: $globalTasksPath"
}

function Test-VSCodeGlobalConfigured {
    $globalTasksPath = Join-Path $env:APPDATA 'Code\User\tasks.json'
    if (-not (Test-Path $globalTasksPath)) { return $false }
    $content = Get-Content $globalTasksPath -Raw -ErrorAction SilentlyContinue
    if ([string]::IsNullOrWhiteSpace($content)) { return $false }
    return ($content -match 'C/C\+\+: gcc\.exe build active file')
}

function Remove-VSCodeGlobalConfiguration {
    [CmdletBinding(SupportsShouldProcess)]
    param()
    $globalTasksPath = Join-Path $env:APPDATA 'Code\User\tasks.json'
    if (Test-Path $globalTasksPath) {
        if (-not $PSCmdlet.ShouldProcess($globalTasksPath, 'Retirar configuracion global de VS Code')) { return }
        $content = Get-Content $globalTasksPath -Raw -ErrorAction SilentlyContinue
        if ($content -match 'C/C\+\+: gcc\.exe build active file') {
            Remove-Item $globalTasksPath -Force -ErrorAction SilentlyContinue
            Add-Log 'Configuracion global de VS Code retirada.'
        }
    }
}

function Show-ConfigurationModal {
    [CmdletBinding(SupportsShouldProcess)]
    param()
    if (-not $PSCmdlet.ShouldProcess('proyecto VS Code', 'Elegir modo de configuracion')) { return }
    $configDialog = New-Object System.Windows.Forms.Form
    $configDialog.Text = 'Modos de Configuracion - CCompilerFlat'
    $configDialog.ClientSize = New-Object System.Drawing.Size(660, 500)
    $configDialog.MinimumSize = New-Object System.Drawing.Size(620, 460)
    $configDialog.AutoScaleMode = 'Dpi'
    $configDialog.StartPosition = 'CenterParent'
    $configDialog.BackColor = $black
    $configDialog.ForeColor = $green
    $configDialog.Font = $font
    Set-WindowBranding $configDialog

    $modalHeader = New-Object System.Windows.Forms.Label
    $modalHeader.Text = 'CONFIGURACION DE VS CODE PARA C/C++'
    $modalHeader.Location = New-Object System.Drawing.Point(24, 18)
    $modalHeader.Size = New-Object System.Drawing.Size(610, 24)
    $modalHeader.Font = New-Object System.Drawing.Font('Consolas', 11, [System.Drawing.FontStyle]::Bold)
    $modalHeader.ForeColor = $green
    $configDialog.Controls.Add($modalHeader)

    $state = Get-InstallationState
    $warningLabel = New-Object System.Windows.Forms.Label
    $warningLabel.Location = New-Object System.Drawing.Point(24, 46)
    $warningLabel.Size = New-Object System.Drawing.Size(610, 36)
    $warningLabel.Font = New-Object System.Drawing.Font('Consolas', 9)
    if (-not $state.CompilerReady) {
        $warningLabel.Text = 'AVISO: El compilador GCC todavia no esta instalado. Primero debes instalar el kit completo con [ INSTALAR TODO ] para poder compilar.'
        $warningLabel.ForeColor = [System.Drawing.Color]::FromArgb(255, 180, 50)
    } else {
        $warningLabel.Text = 'Elige como deseas configurar VS Code para compilar con GCC 16.1 UCRT64:'
        $warningLabel.ForeColor = $lightGreen
    }
    $configDialog.Controls.Add($warningLabel)

    $btnGlobal = New-Object System.Windows.Forms.Button
    $btnGlobal.Text = '1. CONFIGURACION GLOBAL EN VS CODE (RECOMENDADO)'
    $btnGlobal.Location = New-Object System.Drawing.Point(24, 90)
    $btnGlobal.Size = New-Object System.Drawing.Size(610, 38)
    $btnGlobal.FlatStyle = 'Flat'
    $btnGlobal.FlatAppearance.BorderColor = $green
    $btnGlobal.ForeColor = $green
    $btnGlobal.BackColor = [System.Drawing.Color]::FromArgb(5, 35, 18)
    $btnGlobal.Cursor = [System.Windows.Forms.Cursors]::Hand
    $btnGlobal.Add_Click({
        Set-VSCodeGlobalConfiguration
        Add-UcrtToUserPath
        Update-InstallationControl
        $configDialog.Close()
        [System.Windows.Forms.MessageBox]::Show("Configuracion global de VS Code aplicada exitosamente.`r`n`r`nAhora cualquier archivo .c abierto en VS Code podra compilarse con GCC en cualquier carpeta de tu equipo sin crear archivos .vscode locales.", 'Configuracion global', 'OK', 'Information') | Out-Null
    })
    $configDialog.Controls.Add($btnGlobal)

    $descGlobal = New-Object System.Windows.Forms.Label
    $descGlobal.Text = 'Inyecta la tarea de compilacion a nivel de usuario en VS Code. Podras abrir y compilar cualquier archivo .c en CUALQUIER carpeta sin configurar nada mas.'
    $descGlobal.Location = New-Object System.Drawing.Point(24, 132)
    $descGlobal.Size = New-Object System.Drawing.Size(610, 34)
    $descGlobal.Font = New-Object System.Drawing.Font('Consolas', 8)
    $descGlobal.ForeColor = $darkGreen
    $configDialog.Controls.Add($descGlobal)

    $btnFolder = New-Object System.Windows.Forms.Button
    $btnFolder.Text = '2. ELEGIR CARPETA DE PROYECTO (POR PROYECTO)'
    $btnFolder.Location = New-Object System.Drawing.Point(24, 180)
    $btnFolder.Size = New-Object System.Drawing.Size(610, 38)
    $btnFolder.FlatStyle = 'Flat'
    $btnFolder.FlatAppearance.BorderColor = $green
    $btnFolder.ForeColor = $green
    $btnFolder.BackColor = [System.Drawing.Color]::FromArgb(5, 35, 18)
    $btnFolder.Cursor = [System.Windows.Forms.Cursors]::Hand
    $btnFolder.Add_Click({
        $configDialog.Close()
        Select-ProjectFolderAndConfigure
    })
    $configDialog.Controls.Add($btnFolder)

    $descFolder = New-Object System.Windows.Forms.Label
    $descFolder.Text = 'Abre el explorador de Windows para seleccionar una carpeta especifica (ej: ALGORITMO o una carpeta en el Escritorio) e inyectar la subcarpeta .vscode completa.'
    $descFolder.Location = New-Object System.Drawing.Point(24, 222)
    $descFolder.Size = New-Object System.Drawing.Size(610, 34)
    $descFolder.Font = New-Object System.Drawing.Font('Consolas', 8)
    $descFolder.ForeColor = $darkGreen
    $configDialog.Controls.Add($descFolder)

    $btnCurrent = New-Object System.Windows.Forms.Button
    $btnCurrent.Text = '3. CONFIGURAR EN CARPETA ACTUAL DEL PROYECTO'
    $btnCurrent.Location = New-Object System.Drawing.Point(24, 270)
    $btnCurrent.Size = New-Object System.Drawing.Size(610, 38)
    $btnCurrent.FlatStyle = 'Flat'
    $btnCurrent.FlatAppearance.BorderColor = $green
    $btnCurrent.ForeColor = $green
    $btnCurrent.BackColor = [System.Drawing.Color]::FromArgb(5, 35, 18)
    $btnCurrent.Cursor = [System.Windows.Forms.Cursors]::Hand
    $btnCurrent.Add_Click({
        Set-VSCodeConfiguration -targetDir $projectDir
        Add-UcrtToUserPath
        Update-InstallationControl
        $configDialog.Close()
        [System.Windows.Forms.MessageBox]::Show("Configuracion .vscode creada exitosamente en la carpeta actual:`r`n$projectDir", 'Carpeta actual', 'OK', 'Information') | Out-Null
    })
    $configDialog.Controls.Add($btnCurrent)

    $descCurrent = New-Object System.Windows.Forms.Label
    $descCurrent.Text = "Inyecta la configuracion .vscode (tasks.json, launch.json, c_cpp_properties.json) directamente en: $projectDir"
    $descCurrent.Location = New-Object System.Drawing.Point(24, 312)
    $descCurrent.Size = New-Object System.Drawing.Size(610, 34)
    $descCurrent.Font = New-Object System.Drawing.Font('Consolas', 8)
    $descCurrent.ForeColor = $darkGreen
    $configDialog.Controls.Add($descCurrent)

    $btnCancel = New-Object System.Windows.Forms.Button
    $btnCancel.Text = '[ CANCELAR ]'
    $btnCancel.Location = New-Object System.Drawing.Point(24, 380)
    $btnCancel.Size = New-Object System.Drawing.Size(150, 38)
    $btnCancel.FlatStyle = 'Flat'
    $btnCancel.FlatAppearance.BorderColor = $darkGreen
    $btnCancel.ForeColor = $green
    $btnCancel.BackColor = [System.Drawing.Color]::FromArgb(5, 20, 12)
    $btnCancel.Cursor = [System.Windows.Forms.Cursors]::Hand
    $btnCancel.Add_Click({ $configDialog.Close() })
    $configDialog.Controls.Add($btnCancel)

    [void]$configDialog.ShowDialog($form)
    $configDialog.Dispose()
}

function Select-ProjectFolderAndConfigure {
    [CmdletBinding(SupportsShouldProcess)]
    param()
    if (-not $PSCmdlet.ShouldProcess('proyecto VS Code', 'Configurar carpeta')) { return }
    $dialog = New-Object System.Windows.Forms.FolderBrowserDialog
    $dialog.Description = 'Selecciona la carpeta donde deseas configurar VS Code (ej: ALGORITMO)'
    $parentPath = Split-Path -Parent $projectDir
    $dialog.SelectedPath = if (Test-Path $parentPath) { $parentPath } else { $projectDir }
    $dialog.ShowNewFolderButton = $true
    if ($dialog.ShowDialog($form) -eq [System.Windows.Forms.DialogResult]::OK -and -not [string]::IsNullOrWhiteSpace($dialog.SelectedPath)) {
        $target = $dialog.SelectedPath
        Set-VSCodeConfiguration -targetDir $target
        Add-UcrtToUserPath
        Add-Log "Configuracion de VS Code aplicada exitosamente en: $target"
        $note = if (-not (Test-Path $gccPath)) { "`r`n`r`nAviso: Recuerda pulsar [ INSTALAR TODO ] para instalar el compilador GCC." } else { '' }
        [System.Windows.Forms.MessageBox]::Show("Configuracion de VS Code aplicada exitosamente en:`r`n$target$note", 'Configurar proyecto', 'OK', 'Information') | Out-Null
        Update-InstallationControl
    }
    $dialog.Dispose()
}

function Initialize-Example {
    $examplesDir = Join-Path $projectDir 'ejemplos'
    New-Item -ItemType Directory -Force -Path $examplesDir | Out-Null
    Write-IfMissing (Join-Path $examplesDir '01_hola.c') @'
#include <stdio.h>
#include <stdlib.h>

int main(void) {
    printf("Hola, CCompilerFlat!\n");
    printf("Tu compilador funciona correctamente.\n\n");
    system("pause");
    return 0;
}
'@
    Write-IfMissing (Join-Path $examplesDir '02_calculadora.c') @'
#include <stdio.h>
#include <stdlib.h>

int main(void) {
    double numero1;
    double numero2;
    char operador;

    printf("Escribe una operacion, por ejemplo 8 * 4: ");
    if (scanf("%lf %c %lf", &numero1, &operador, &numero2) != 3) {
        printf("Entrada no valida.\n\n");
        system("pause");
        return 1;
    }

    switch (operador) {
        case '+':
            printf("Resultado: %.2f\n\n", numero1 + numero2);
            break;
        case '-':
            printf("Resultado: %.2f\n\n", numero1 - numero2);
            break;
        case '*':
            printf("Resultado: %.2f\n\n", numero1 * numero2);
            break;
        case '/':
            if (numero2 == 0.0) {
                printf("No se puede dividir entre cero.\n\n");
                system("pause");
                return 1;
            }
            printf("Resultado: %.2f\n\n", numero1 / numero2);
            break;
        default:
            printf("Usa +, -, * o /.\n\n");
            system("pause");
            return 1;
    }

    system("pause");
    return 0;
}
'@
    Write-IfMissing (Join-Path $examplesDir '03_adivina.c') @'
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(void) {
    int secreto;
    int intento;
    int turnos = 0;

    srand((unsigned int)time(NULL));
    secreto = (rand() % 100) + 1;
    printf("JUEGO: ADIVINA EL NUMERO\n");
    printf("Estoy pensando en un numero del 1 al 100.\n\n");

    do {
        printf("Intento: ");
        if (scanf("%d", &intento) != 1) {
            int c;
            printf("Entrada no valida. Introduce un numero entero.\n");
            while ((c = getchar()) != '\n' && c != EOF) {}
            continue;
        }
        turnos++;
        if (intento < secreto) {
            printf("El numero es mayor.\n");
        } else if (intento > secreto) {
            printf("El numero es menor.\n");
        } else {
            printf("Ganaste en %d turnos!\n\n", turnos);
        }
    } while (intento != secreto);

    system("pause");
    return 0;
}
'@
    Write-IfMissing (Join-Path $examplesDir '04_piedra_papel_tijera.c') @'
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(void) {
    int jugador;
    int computadora;
    const char *nombres[] = {"piedra", "papel", "tijera"};

    srand((unsigned int)time(NULL));
    printf("JUEGO: PIEDRA, PAPEL O TIJERA\n");
    printf("0 = piedra, 1 = papel, 2 = tijera, -1 = salir\n\n");

    while (1) {
        printf("Tu jugada: ");
        if (scanf("%d", &jugador) != 1) {
            int c;
            printf("Entrada no valida. Elige 0, 1, 2 o -1 para salir.\n\n");
            while ((c = getchar()) != '\n' && c != EOF) {}
            continue;
        }
        if (jugador == -1) {
            printf("\nHasta luego!\n\n");
            break;
        }
        if (jugador < 0 || jugador > 2) {
            printf("Opcion invalida. Elige 0, 1, 2 o -1 para salir.\n\n");
            continue;
        }

        computadora = rand() % 3;
        printf("Tu: %s | Computadora: %s\n", nombres[jugador], nombres[computadora]);
        if (jugador == computadora) {
            printf("Resultado: Empate.\n\n");
        } else if ((jugador + 1) % 3 == computadora) {
            printf("Resultado: Gana la computadora.\n\n");
        } else {
            printf("Resultado: Ganaste!\n\n");
        }
    }

    system("pause");
    return 0;
}
'@
    Add-Log "Ejemplos listos en $examplesDir"
}

function Test-Example {
    $examplesDir = Join-Path $projectDir 'ejemplos'
    $compiler = $gccPath
    if (-not (Test-Path $compiler)) { throw 'GCC no esta instalado. Pulsa Instalar antes de comprobar.' }
    $files = Get-ChildItem -Path $examplesDir -Filter '*.c' -File | Sort-Object Name
    if ($files.Count -eq 0) { throw 'No hay ejemplos C disponibles.' }
    Add-Log "Comprobando $($files.Count) ejemplos con GCC..."
    foreach ($file in $files) {
        Invoke-Native $compiler @('-std=c17', '-Wall', '-Wextra', '-Wpedantic', '-fsyntax-only', $file.FullName)
        Add-Log "$($file.Name): correcto"
    }
    [System.Windows.Forms.MessageBox]::Show("Los $($files.Count) ejemplos pasan la comprobacion de GCC.", 'Comprobar ejemplos', 'OK', 'Information') | Out-Null
}

function Show-Tutorial {
    $tutorial = New-Object System.Windows.Forms.Form
    $tutorial.Text = 'Ayuda y Tutorial - CCompilerFlat'
    $tutorial.ClientSize = New-Object System.Drawing.Size(760, 570)
    $tutorial.MinimumSize = New-Object System.Drawing.Size(650, 500)
    $tutorial.AutoScaleMode = 'Dpi'
    $tutorial.StartPosition = 'CenterParent'
    $tutorial.BackColor = $black
    $tutorial.ForeColor = $green
    $tutorial.Font = $font
    Set-WindowBranding $tutorial

    if (Test-Path $logoPath) {
        $tutorialLogo = New-Object System.Windows.Forms.PictureBox
        $tutorialLogo.Location = New-Object System.Drawing.Point(620, 20)
        $tutorialLogo.Size = New-Object System.Drawing.Size(100, 100)
        $tutorialLogo.SizeMode = 'Zoom'
        $tutorialLogo.BackColor = [System.Drawing.Color]::Transparent
        $tutorialLogo.Image = [System.Drawing.Image]::FromFile($logoPath)
        $tutorialLogo.Anchor = 'Top, Right'
        $tutorial.Controls.Add($tutorialLogo)
    }

    $tutorialText = New-Object System.Windows.Forms.TextBox
    $tutorialText.Multiline = $true
    $tutorialText.ReadOnly = $true
    $tutorialText.ScrollBars = 'Vertical'
    $tutorialText.Location = New-Object System.Drawing.Point(24, 125)
    $tutorialText.Size = New-Object System.Drawing.Size(695, 312)
    $tutorialText.BackColor = [System.Drawing.Color]::FromArgb(2, 14, 8)
    $tutorialText.ForeColor = $green
    $tutorialText.Font = New-Object System.Drawing.Font('Consolas', 10)
    $tutorialText.Anchor = 'Top, Bottom, Left, Right'
    $tutorialText.Text = @"
GUIA DE USO Y ORIENTACION DE PROBLEMAS - CCOMPILERFLAT

Puedes leer esta guia en cualquier momento sin alterar tu sistema.

PASOS PARA EMPEZAR A PROGRAMAR EN C/C++:
1. Pulsa [ INSTALAR TODO ] para preparar MSYS2, GCC 16.1 UCRT64, GDB y la extension C/C++.
2. Espera a que el terminal muestre INSTALACION COMPLETA.
3. Pulsa [ CONFIGURAR PROYECTO ] si deseas vincular una carpeta distinta (ej. ALGORITMO).
4. Abre la carpeta de tu proyecto en VS Code (Archivo > Abrir carpeta).
5. Abre cualquier archivo .c (por ejemplo 01_hola.c) y pulsa Ejecutar y depurar (F5 o Ctrl+F5).
6. Los ejemplos incluyen retencion de consola interactiva con tecla para evitar cierres repentinos.

======================================================================
ORIENTACION DE ERRORES COMUNES (POR QUE DIO ERROR Y COMO RESOLVERLO):
======================================================================

1. ANTIVIRUS O WINDOWS DEFENDER (Acceso denegado / Permission denied):
   - Causa: Windows Defender o un antivirus externo bloquea la creacion de binarios .exe,
     archivos temporales o la instalacion de paquetes en carpetas protegidas.
   - Solucion: Abre "Seguridad de Windows" > "Proteccion contra virus y amenazas".
     Si tienes activado "Control de acceso a carpetas", concede permiso a CCompilerFlat
     y a gcc.exe, o agrega la carpeta de tu proyecto a las exclusiones del antivirus.

2. ARCHIVOS BLOQUEADOS POR VS CODE:
   - Causa: Al desinstalar o reinstalar extensiones, VS Code mantiene handles abiertos.
   - Solucion: Cierra todas las ventanas de VS Code antes de reinstalar o desinstalar.

3. PERMISOS DE ADMINISTRADOR (UAC):
   - Causa: Windows requiere autorizacion elevada para instalar MSYS2 en C:\msys64.
   - Solucion: Haz clic derecho sobre CCompilerFlat y selecciona "Ejecutar como Administrador".

4. FALLO DE DESCARGA O WINGET NO RESPONDE:
   - Causa: Red inestable, proxy institucional o la aplicacion winget desactualizada.
   - Solucion: Abre la Microsoft Store, busca "Instalador de paquetes" (App Installer)
     y actualizalo. Comprueba que dispones de conexion activa a Internet.

5. EJECUCION DIRECTA DESDE TERMINAL O POWERSHELL:
   - CCompilerFlat anade C:\msys64\ucrt64\bin a tu variable PATH de usuario.
   - Puedes compilar manualmente en cualquier terminal:
       gcc archivo.c -o programa.exe
       .\programa.exe
"@
    $tutorial.Controls.Add($tutorialText)

    $openExamples = New-Object System.Windows.Forms.Button
    $openExamples.Text = '[ ABRIR EJEMPLOS ]'
    $openExamples.Location = New-Object System.Drawing.Point(24, 460)
    $openExamples.Size = New-Object System.Drawing.Size(210, 40)
    $openExamples.FlatStyle = 'Flat'
    $openExamples.FlatAppearance.BorderColor = $green
    $openExamples.ForeColor = $green
    $openExamples.BackColor = [System.Drawing.Color]::FromArgb(5, 35, 18)
    $openExamples.Anchor = 'Bottom, Left'
    $openExamples.Add_Click({
        $examplesDir = Join-Path $projectDir 'ejemplos'
        if (-not (Test-Path $examplesDir)) {
            $answer = [System.Windows.Forms.MessageBox]::Show('La carpeta de ejemplos no existe. Deseas crearla?', 'Crear ejemplos', 'YesNo', 'Question')
            if ($answer -ne 'Yes') { return }
            Initialize-Example
        }
        Start-Process 'explorer.exe' -ArgumentList $examplesDir
    })
    $tutorial.Controls.Add($openExamples)

    $closeTutorial = New-Object System.Windows.Forms.Button
    $closeTutorial.Text = '[ CERRAR ]'
    $closeTutorial.Location = New-Object System.Drawing.Point(250, 460)
    $closeTutorial.Size = New-Object System.Drawing.Size(150, 40)
    $closeTutorial.FlatStyle = 'Flat'
    $closeTutorial.FlatAppearance.BorderColor = $darkGreen
    $closeTutorial.ForeColor = $green
    $closeTutorial.BackColor = [System.Drawing.Color]::FromArgb(5, 20, 12)
    $closeTutorial.Anchor = 'Bottom, Left'
    $closeTutorial.Add_Click({ $tutorial.Close() })
    $tutorial.Controls.Add($closeTutorial)
    [void]$tutorial.ShowDialog($form)
    $tutorial.Dispose()
}

function Show-About {
    $about = New-Object System.Windows.Forms.Form
    $about.Text = 'Acerca de CCompilerFlat'
    $about.ClientSize = New-Object System.Drawing.Size(650, 430)
    $about.MinimumSize = New-Object System.Drawing.Size(600, 390)
    $about.AutoScaleMode = 'Dpi'
    $about.StartPosition = 'CenterParent'
    $about.BackColor = $black
    $about.ForeColor = $green
    $about.Font = $font
    Set-WindowBranding $about
    $aboutTitle = New-Object System.Windows.Forms.Label
    $aboutTitle.Text = 'CCompilerFlat by LuisMartinPM'
    $aboutTitle.Location = New-Object System.Drawing.Point(28, 24)
    $aboutTitle.Size = New-Object System.Drawing.Size(460, 32)
    $aboutTitle.Font = New-Object System.Drawing.Font('Consolas', 14, [System.Drawing.FontStyle]::Bold)
    $aboutTitle.ForeColor = $green
    $aboutTitle.Anchor = 'Top, Left, Right'
    $about.Controls.Add($aboutTitle)

    if (Test-Path $logoPath) {
        $aboutLogo = New-Object System.Windows.Forms.PictureBox
        $aboutLogo.Location = New-Object System.Drawing.Point(510, 20)
        $aboutLogo.Size = New-Object System.Drawing.Size(105, 105)
        $aboutLogo.SizeMode = 'Zoom'
        $aboutLogo.BackColor = [System.Drawing.Color]::Transparent
        $aboutLogo.Image = [System.Drawing.Image]::FromFile($logoPath)
        $aboutLogo.Anchor = 'Top, Right'
        $about.Controls.Add($aboutLogo)
    }

    $aboutDescription = New-Object System.Windows.Forms.Label
    $aboutDescription.Text = "Luis Martin Pena Mejia`r`nIngeniero de software dominicano`r`nPunta Cana, Republica Dominicana"
    $aboutDescription.Location = New-Object System.Drawing.Point(28, 72)
    $aboutDescription.Size = New-Object System.Drawing.Size(590, 76)
    $aboutDescription.ForeColor = $green
    $aboutDescription.Anchor = 'Top, Left, Right'
    $about.Controls.Add($aboutDescription)

    $links = @(
        @('GitHub: github.com/luismartin023', $githubUrl),
        @('LinkedIn: linkedin.com/in/luismartinpm-mkz-dev', $linkedinUrl),
        @('WhatsApp: abrir chat', $whatsappUrl),
        @('Correo: ' + $emailAddress, 'mailto:' + $emailAddress)
    )
    $y = 175
    foreach ($link in $links) {
        $linkLabel = New-Object System.Windows.Forms.LinkLabel
        $linkLabel.Text = $link[0]
        $linkLabel.Tag = $link[1]
        $linkLabel.Location = New-Object System.Drawing.Point(24, $y)
        $linkLabel.Size = New-Object System.Drawing.Size(590, 28)
        $linkLabel.AutoSize = $false
        $linkLabel.Anchor = 'Top, Left, Right'
        $linkLabel.LinkColor = $green
        $linkLabel.ActiveLinkColor = [System.Drawing.Color]::White
        $linkLabel.Add_LinkClicked({ Start-Process -FilePath $this.Tag })
        $about.Controls.Add($linkLabel)
        $y += 32
    }

    $closeAbout = New-Object System.Windows.Forms.Button
    $closeAbout.Text = '[ CERRAR ]'
    $closeAbout.Location = New-Object System.Drawing.Point(28, 350)
    $closeAbout.Size = New-Object System.Drawing.Size(150, 40)
    $closeAbout.FlatStyle = 'Flat'
    $closeAbout.FlatAppearance.BorderColor = $darkGreen
    $closeAbout.FlatAppearance.MouseOverBackColor = [System.Drawing.Color]::FromArgb(0, 110, 55)
    $closeAbout.FlatAppearance.MouseDownBackColor = [System.Drawing.Color]::FromArgb(0, 210, 90)
    $closeAbout.ForeColor = $green
    $closeAbout.BackColor = [System.Drawing.Color]::FromArgb(5, 20, 12)
    $closeAbout.Anchor = 'Bottom, Left'
    $closeAbout.Add_Click({ $about.Close() })
    $about.Controls.Add($closeAbout)
    [void]$about.ShowDialog($form)
    $about.Dispose()
}

function Remove-GeneratedVSCodeFile {
    [CmdletBinding(SupportsShouldProcess)]
    param()
    $vscodeDir = Join-Path $projectDir '.vscode'
    if (-not $PSCmdlet.ShouldProcess($vscodeDir, 'Eliminar configuracion generada')) { return }
    foreach ($fileName in @('tasks.json', 'launch.json', 'c_cpp_properties.json')) {
        $path = Join-Path $vscodeDir $fileName
        if (Test-Path $path) {
            $content = Get-Content $path -Raw
            if ($content -match [regex]::Escape($gccPath.Replace('\', '/'))) { Remove-Item $path -Force; Add-Log "Eliminado $fileName" }
            else { Add-Log "Conservado $fileName personalizado" }
        }
    }
    Remove-VSCodeGlobalConfiguration
}

function Get-InstallationState {
    $vsCodeCommand = Get-Command code.cmd -ErrorAction SilentlyContinue
    $extensionInstalled = $false
    if ($vsCodeCommand) {
        $extensionInstalled = @(& $vsCodeCommand.Source '--list-extensions' 2>$null) -contains 'ms-vscode.cpptools'
    }
    $localConfig = Test-VSCodeConfiguredIn -folder $projectDir
    $parentDir = Split-Path -Parent $projectDir
    $parentConfig = if ($parentDir) { Test-VSCodeConfiguredIn -folder $parentDir } else { $false }
    $globalConfig = Test-VSCodeGlobalConfigured
    $configurationReady = $localConfig -or $parentConfig -or $globalConfig
    $compilerReady = (Test-Path $bashPath) -and (Test-Path $gccPath) -and (Test-Path $gdbPath)

    [pscustomobject]@{
        Msys2 = Test-Path $bashPath
        Gcc = Test-Path $gccPath
        Gdb = Test-Path $gdbPath
        CompilerReady = $compilerReady
        VsCode = [bool]$vsCodeCommand
        Extension = $extensionInstalled
        Configuration = $configurationReady
        LocalConfiguration = $localConfig
        ParentConfiguration = $parentConfig
        GlobalConfiguration = $globalConfig
        CoreReady = $compilerReady -and $configurationReady
    }
}

function Update-InstallationControl {
    [CmdletBinding(SupportsShouldProcess)]
    param()
    if (-not $PSCmdlet.ShouldProcess('controles de instalacion', 'Actualizar estado')) { return }
    $state = Get-InstallationState
    $compilerInstalled = $state.Msys2 -or $state.Gcc -or $state.Gdb
    $uninstallButton.Visible = $compilerInstalled
    $uninstallButton.Enabled = $compilerInstalled
    $uninstallMenu.Visible = $compilerInstalled
    $uninstallMenu.Enabled = $compilerInstalled

    if ($state.CompilerReady -and $state.Configuration) {
        $installButton.Text = '[ ANALIZAR ESTADO ]'
        $installMenu.Text = 'Analizar estado'
        $configLoc = if ($state.LocalConfiguration) { 'proyecto actual' } elseif ($state.GlobalConfiguration) { 'global de usuario' } elseif ($state.ParentConfiguration) { 'carpeta padre' } else { 'externa' }
        $statusLabel.Text = "Estado: entorno completo; GCC 16.1 y VS Code listos ($configLoc)"
    } elseif ($state.CompilerReady) {
        $installButton.Text = '[ ANALIZAR ESTADO ]'
        $installMenu.Text = 'Analizar estado'
        $statusLabel.Text = 'Estado: GCC y GDB listos; usa [ CONFIGURAR PROYECTO ] para vincular carpetas'
    } elseif ($compilerInstalled) {
        $installButton.Text = '[ REPARAR INSTALACION ]'
        $installMenu.Text = 'Reparar instalacion'
        $statusLabel.Text = 'Estado: instalacion parcial; faltan componentes del compilador'
    } else {
        $installButton.Text = '[ INSTALAR TODO ]'
        $installMenu.Text = 'Instalar todo'
        $statusLabel.Text = 'Estado: listo para instalar'
    }
}

$installButton.Add_Click({
    $state = Get-InstallationState
    $missing = @()
    if (-not $state.Msys2) { $missing += 'MSYS2' }
    if (-not $state.Gcc) { $missing += 'GCC' }
    if (-not $state.Gdb) { $missing += 'GDB' }
    if (-not $state.VsCode) { $missing += 'VS Code no detectado' }
    if ($state.VsCode -and -not $state.Extension) { $missing += 'extension C/C++' }
    if (-not $state.Configuration) { $missing += 'configuracion de VS Code' }
    $configDetail = if ($state.LocalConfiguration) { 'si (proyecto actual)' } elseif ($state.GlobalConfiguration) { 'si (global de usuario)' } elseif ($state.ParentConfiguration) { 'si (carpeta padre)' } else { 'no' }
    $stateText = "MSYS2: $($state.Msys2)`r`nGCC: $($state.Gcc)`r`nGDB: $($state.Gdb)`r`nVS Code: $($state.VsCode)`r`nExtension: $($state.Extension)`r`nConfiguracion: $configDetail"
    $actionText = if ($missing.Count -eq 0) { 'Todo esta instalado y configurado correctamente. Deseas revalidar ejemplos?' } elseif (-not $state.Msys2 -and -not $state.Gcc) { 'Se instalara el compilador completo (MSYS2, GCC 16.1 UCRT64, GDB) y la configuracion global de VS Code.' } else { "Falta o requiere reparacion: $($missing -join ', '). Se conservaran los archivos existentes." }
    $answer = [System.Windows.Forms.MessageBox]::Show("$stateText`r`n`r`n$actionText`r`n`r`nDeseas continuar?", 'Revision previa de CCompilerFlat', 'YesNo', 'Question')
    if ($answer -ne 'Yes') { return }
    $installButton.Enabled = $false
    Set-InstallerProgress 0 'preparando instalacion'
    try {
        Add-Log 'Iniciando instalacion...'
        if (Test-Administrator) { Add-Log 'Sesión elevada: administrador.' }
        else { Add-Log 'Sesión estándar: Windows puede solicitar UAC a winget.' }
        if (-not $state.Msys2) {
            if (-not (Get-Command winget.exe -ErrorAction SilentlyContinue)) { throw 'winget no esta disponible en este Windows.' }
            Set-InstallerProgress 10 'comprobando winget'
            Add-Log "winget: $(& winget.exe --version)"
            Invoke-Native 'winget.exe' @('install', '--id', 'MSYS2.MSYS2', '-e', '--accept-source-agreements', '--accept-package-agreements')
        } else { Add-Log 'MSYS2 ya esta instalado; no se sobrescribe.' }
        Set-InstallerProgress 35 'instalando MSYS2'
        if (-not (Test-Path $bashPath)) { throw "MSYS2 no se encontro en $msysRoot." }
        if (-not $state.Gcc -or -not $state.Gdb) {
            Invoke-Native $bashPath @('-lc', 'pacman -S --noconfirm mingw-w64-ucrt-x86_64-gcc mingw-w64-ucrt-x86_64-gdb')
        } else { Add-Log 'GCC y GDB ya estan instalados; no se reinstalan.' }
        Set-InstallerProgress 60 'instalando GCC y GDB'
        Add-UcrtToUserPath
        Set-VSCodeGlobalConfiguration
        Initialize-Example
        Test-Example
        Set-InstallerProgress 80 'comprobando ejemplos y VS Code'
        if ($state.VsCode -and -not $state.Extension) {
            try {
                Invoke-Native 'code.cmd' @('--install-extension', 'ms-vscode.cpptools', '--force')
            } catch {
                Add-Log 'Aviso: la extension no se pudo instalar automaticamente (puedes instalar ms-vscode.cpptools desde VS Code).'
            }
        } elseif ($state.Extension) { Add-Log 'La extension C/C++ ya esta instalada; no se reinstala.' }
        else { Add-Log 'VS Code no esta en PATH; la configuracion se creo, pero la extension debe instalarse desde VS Code.' }
        Set-InstallerProgress 100 'instalacion completa'
        Add-Log 'INSTALACION COMPLETA. VS Code esta listo.'
        [System.Windows.Forms.MessageBox]::Show('Instalacion completa. VS Code esta listo.', 'CCompilerFlat', 'OK', 'Information') | Out-Null
        Update-InstallationControl
    } catch {
        $msg = $_.Exception.Message
        $advice = Get-DiagnosticRecommendation -errorMessage $msg
        Add-Log ('ERROR: ' + $msg)
        Add-Log ('DIAGNOSTICO: ' + $advice)
        $statusLabel.Text = 'Estado: error; revisa el registro y diagnostico'
        [System.Windows.Forms.MessageBox]::Show(
            "ERROR EN LA INSTALACION:`r`n$msg`r`n`r`nDIAGNOSTICO / ORIENTACION:`r`n$advice`r`n`r`n(Consulta el menu 'Ayuda / Tutorial' para mas orientacion)",
            'Error de instalacion - CCompilerFlat',
            'OK',
            'Error'
        ) | Out-Null
    }
    $installButton.Enabled = $true
})

$configButton.Add_Click({ Show-ConfigurationModal })
$openButton.Add_Click({ Start-Process 'explorer.exe' -ArgumentList $projectDir })
$closeButton.Add_Click({ $form.Close() })
$installMenu.Add_Click({ $installButton.PerformClick() })
$configMenu.Add_Click({ Show-ConfigurationModal })
$uninstallMenu.Add_Click({ $uninstallButton.PerformClick() })
$tutorialMenu.Add_Click({ Show-Tutorial })
$checkMenu.Add_Click({
    try { Initialize-Example; Test-Example }
    catch {
        $msg = $_.Exception.Message
        $advice = Get-DiagnosticRecommendation -errorMessage $msg
        Add-Log ('ERROR: ' + $msg)
        Add-Log ('DIAGNOSTICO: ' + $advice)
        [System.Windows.Forms.MessageBox]::Show(
            "ERROR AL COMPROBAR EJEMPLOS:`r`n$msg`r`n`r`nDIAGNOSTICO / ORIENTACION:`r`n$advice",
            'Comprobar ejemplos',
            'OK',
            'Error'
        ) | Out-Null
    }
})
$aboutMenu.Add_Click({ Show-About })
$uninstallButton.Add_Click({
    $answer = [System.Windows.Forms.MessageBox]::Show('Se eliminaran MSYS2, GCC, GDB y la extension C/C++. Deseas continuar?', 'CCompilerFlat', 'YesNo', 'Warning')
    if ($answer -ne 'Yes') { return }
    $removeConfigAnswer = [System.Windows.Forms.MessageBox]::Show("Deseas eliminar tambien los archivos de configuracion de VS Code (.vscode)?`r`n`r`nPulsa SI para eliminarlos o NO para conservarlos intactos.", 'Configuracion de VS Code', 'YesNo', 'Question')
    $removeConfig = ($removeConfigAnswer -eq 'Yes')
    $installButton.Enabled = $false
    $uninstallButton.Enabled = $false
    Set-InstallerProgress 0 'preparando desinstalacion'
    try {
        Add-Log 'Iniciando desinstalacion...'
        if (Get-Process Code -ErrorAction SilentlyContinue) {
            Add-Log 'Aviso: VS Code esta abierto. Cierralo para asegurar la desinstalacion limpia de la extension.'
        }
        $codeCmd = Get-Command code.cmd -ErrorAction SilentlyContinue
        if ($codeCmd) {
            try {
                Invoke-Native $codeCmd.Source @('--uninstall-extension', 'ms-vscode.cpptools', '--force')
            } catch {
                Add-Log 'Aviso: la extension no se pudo desinstalar (si VS Code esta abierto, cierralo primero).'
            }
        }
        Set-InstallerProgress 40 'retirando extension de VS Code'
        $uninstalledMsys = $false
        $wingetCmd = Get-Command winget.exe -ErrorAction SilentlyContinue

        if (Test-Administrator -and (Test-Path 'C:\msys64\uninstall.exe')) {
            Add-Log 'Sesion de administrador detectada: usando desinstalador nativo C:\msys64\uninstall.exe...'
            $proc = Start-Process 'C:\msys64\uninstall.exe' -ArgumentList 'pr', '--confirm-command' -PassThru -Wait
            if ($proc.ExitCode -ne 0 -or (Test-Path $bashPath)) {
                Add-Log 'Abriendo asistente visual de desinstalacion de MSYS2...'
                $proc = Start-Process 'C:\msys64\uninstall.exe' -PassThru -Wait
            }
            $uninstalledMsys = -not (Test-Path $bashPath)
        }

        if (-not $uninstalledMsys -and $wingetCmd) {
            try {
                Invoke-Native $wingetCmd.Source @('uninstall', '--id', 'MSYS2.MSYS2', '-e', '--accept-source-agreements')
                $uninstalledMsys = $true
            } catch {
                $err = $_.Exception.Message
                if ($err -match 'user scope cannot be uninstalled' -and (Test-Path 'C:\msys64\uninstall.exe')) {
                    Add-Log 'Aviso: winget no permite desinstalar paquetes de usuario desde sesion de administrador.'
                    Add-Log 'Ejecutando desinstalador nativo C:\msys64\uninstall.exe...'
                    $proc = Start-Process 'C:\msys64\uninstall.exe' -ArgumentList 'pr', '--confirm-command' -PassThru -Wait
                    if ($proc.ExitCode -ne 0 -or (Test-Path $bashPath)) {
                        Add-Log 'Abriendo asistente de desinstalacion de MSYS2...'
                        $proc = Start-Process 'C:\msys64\uninstall.exe' -PassThru -Wait
                    }
                    $uninstalledMsys = -not (Test-Path $bashPath)
                } else {
                    throw
                }
            }
        } elseif (-not $uninstalledMsys -and (Test-Path 'C:\msys64\uninstall.exe')) {
            Add-Log 'Ejecutando desinstalador C:\msys64\uninstall.exe...'
            $proc = Start-Process 'C:\msys64\uninstall.exe' -PassThru -Wait
            $uninstalledMsys = -not (Test-Path $bashPath)
        }
        Set-InstallerProgress 80 'retirando MSYS2'
        $userPath = [Environment]::GetEnvironmentVariable('Path', 'User')
        if ($userPath) {
            $cleaned = ($userPath -split ';') | Where-Object { $_ -ne $ucrtBin -and $_ -ne $usrBin -and -not [string]::IsNullOrWhiteSpace($_) }
            [Environment]::SetEnvironmentVariable('Path', ($cleaned -join ';'), 'User')
            Add-Log 'Rutas de GCC retiradas del PATH de usuario.'
        }
        if ($removeConfig) {
            Remove-GeneratedVSCodeFile
            Add-Log 'Configuracion .vscode eliminada a peticion del usuario.'
        } else {
            Add-Log 'Configuracion .vscode conservada intacta.'
        }
        Set-InstallerProgress 100 'desinstalacion completa'
        Add-Log 'DESINSTALACION COMPLETA.'
        [System.Windows.Forms.MessageBox]::Show('Herramientas eliminadas.', 'CCompilerFlat', 'OK', 'Information') | Out-Null
        Update-InstallationControl
    } catch {
        $msg = $_.Exception.Message
        $advice = Get-DiagnosticRecommendation -errorMessage $msg
        Add-Log ('ERROR: ' + $msg)
        Add-Log ('DIAGNOSTICO: ' + $advice)
        $statusLabel.Text = 'Estado: error en desinstalacion'
        [System.Windows.Forms.MessageBox]::Show(
            "ERROR EN LA DESINSTALACION:`r`n$msg`r`n`r`nDIAGNOSTICO / ORIENTACION:`r`n$advice",
            'Error de desinstalacion - CCompilerFlat',
            'OK',
            'Error'
        ) | Out-Null
    }
    $installButton.Enabled = $true
    $uninstallButton.Enabled = $true
})

$timer = New-Object System.Windows.Forms.Timer
$timer.Interval = 120
$timer.Add_Tick({
    $graphics = $rainPanel.CreateGraphics()
    $graphics.Clear($black)
    $brush = New-Object System.Drawing.SolidBrush($darkGreen)
    for ($i = 0; $i -lt 20; $i++) { $graphics.DrawString('01C++', $font, $brush, (12 + ($i * 40)), (($timer.Tag + ($i * 61)) % 430)) }
    $timer.Tag = [int]$timer.Tag + 8
    $brush.Dispose()
    $graphics.Dispose()
})
$timer.Tag = 0
$timer.Start()
$rainPanel.SendToBack()
$menu.BringToFront()
$header.BringToFront()
$subtitle.BringToFront()
$log.BringToFront()
$statusLabel.BringToFront()
$progressBar.BringToFront()
$installButton.BringToFront()
$configButton.BringToFront()
$openButton.BringToFront()
$closeButton.BringToFront()
$uninstallButton.BringToFront()
$footer.BringToFront()

Update-InstallationControl

Add-Log 'CCompilerFlat by LuisMartinPM listo.'
Add-Log 'Puedes abrir el Tutorial sin instalar nada.'
[void]$form.ShowDialog()
