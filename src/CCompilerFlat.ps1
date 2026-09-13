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

$installButton = New-ActionButton '[ INSTALAR TODO ]' 32 250
$openButton = New-ActionButton '[ ABRIR PROYECTO ]' 300 190
$closeButton = New-ActionButton '[ SALIR ]' 508 140
$closeButton.Anchor = 'Bottom, Right'
$uninstallButton = New-ActionButton '[ DESINSTALAR ]' 666 140
$uninstallButton.Anchor = 'Bottom, Right'
$uninstallButton.Visible = $false
$uninstallButton.Enabled = $false
$uninstallButton.FlatAppearance.BorderColor = [System.Drawing.Color]::FromArgb(180, 60, 60)
$uninstallButton.FlatAppearance.MouseOverBackColor = [System.Drawing.Color]::FromArgb(110, 25, 25)
$uninstallButton.FlatAppearance.MouseDownBackColor = [System.Drawing.Color]::FromArgb(220, 70, 70)
$uninstallButton.ForeColor = [System.Drawing.Color]::FromArgb(255, 110, 110)
$uninstallButton.BackColor = [System.Drawing.Color]::FromArgb(45, 10, 10)

$menu = New-Object System.Windows.Forms.MenuStrip
$menu.BackColor = [System.Drawing.Color]::FromArgb(5, 25, 14)
$menu.ForeColor = $green
$menu.Font = New-Object System.Drawing.Font('Consolas', 9)
$installMenu = New-Object System.Windows.Forms.ToolStripMenuItem('Instalar')
$configMenu = New-Object System.Windows.Forms.ToolStripMenuItem('Configurar proyecto')
$tutorialMenu = New-Object System.Windows.Forms.ToolStripMenuItem('Tutorial')
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
    while (-not $process.HasExited) {
        if (-not $process.StandardOutput.EndOfStream) { Add-Log $process.StandardOutput.ReadLine() }
        if (-not $process.StandardError.EndOfStream) { Add-Log $process.StandardError.ReadLine() }
        [System.Windows.Forms.Application]::DoEvents()
    }
    $output = $process.StandardOutput.ReadToEnd()
    if ($output) { Add-Log $output.Trim() }
    $errors = $process.StandardError.ReadToEnd()
    if ($errors) { Add-Log $errors.Trim() }
    if ($process.ExitCode -ne 0) { throw "Command failed: $filePath ($($process.ExitCode))" }
}

function Write-IfMissing([string]$path, [string]$content) {
    if (-not (Test-Path $path)) {
        $content | Set-Content -Path $path -Encoding UTF8
        Add-Log "Creado $([System.IO.Path]::GetFileName($path))"
    } else { Add-Log "Conservado $([System.IO.Path]::GetFileName($path))" }
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
        [System.Windows.Forms.MessageBox]::Show("Configuracion de VS Code aplicada exitosamente en:`r`n$target", 'Configurar proyecto', 'OK', 'Information') | Out-Null
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
    $tutorial.Text = 'Tutorial del instalador C/C++'
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
TUTORIAL: COMPILAR C/C++ EN VS CODE

Puedes leer este tutorial sin instalar nada.

1. Para preparar el equipo, pulsa INSTALAR TODO.
2. Espera a que el registro muestre INSTALACION COMPLETA.
3. Pulsa ABRIR EJEMPLOS o abre la carpeta ejemplos.
4. En VS Code, usa Archivo > Abrir carpeta.
5. Abre 01_hola.c y pulsa Ejecutar y depurar.
6. Debes ver: Tu compilador funciona correctamente.
7. Abre 02_calculadora.c y pulsa Ejecutar y depurar.
8. Escribe una operacion como: 8 * 4
9. El resultado esperado es: 32.00
10. Prueba 03_adivina.c: intenta encontrar el numero secreto.
11. Prueba 04_piedra_papel_tijera.c: usa 0, 1, 2 o -1 para salir.

La configuracion .vscode se crea automaticamente.
El archivo C activo se compila junto a su .exe.
Para depurar, coloca un punto de interrupcion y ejecuta de nuevo.

Si Windows muestra una alerta, revisa SECURITY.md.
No desactives Windows Defender ni crees exclusiones automaticas.
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
    $configurationReady = $localConfig -or $parentConfig
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
        CoreReady = $compilerReady -and $configurationReady
    }
}

function Update-InstallationControl {
    [CmdletBinding(SupportsShouldProcess)]
    param()
    if (-not $PSCmdlet.ShouldProcess('controles de instalacion', 'Actualizar estado')) { return }
    $state = Get-InstallationState
    $hasInstalledComponent = $state.Msys2 -or $state.Gcc -or $state.Gdb -or $state.Extension -or $state.Configuration
    $uninstallButton.Visible = $hasInstalledComponent
    $uninstallButton.Enabled = $hasInstalledComponent
    if ($state.CompilerReady -and $state.Configuration) {
        $installButton.Text = '[ ANALIZAR ESTADO ]'
        $installMenu.Text = 'Analizar estado'
        $configLoc = if ($state.LocalConfiguration) { 'proyecto actual' } elseif ($state.ParentConfiguration) { 'carpeta padre' } else { 'externa' }
        $statusLabel.Text = "Estado: entorno completo; GCC 16.1 y VS Code listos ($configLoc)"
    } elseif ($state.CompilerReady) {
        $installButton.Text = '[ CONFIGURAR PROYECTO ]'
        $installMenu.Text = 'Configurar proyecto'
        $statusLabel.Text = 'Estado: GCC y GDB listos; pulsa para elegir carpeta de proyecto'
    } elseif ($hasInstalledComponent) {
        $installButton.Text = '[ REPARAR INSTALACION ]'
        $installMenu.Text = 'Reparar instalacion'
        $statusLabel.Text = 'Estado: instalacion parcial; faltan componentes del compilador'
    } else {
        $installButton.Text = '[ INSTALAR TODO ]'
        $installMenu.Text = 'Instalar todo'
        $statusLabel.Text = 'Estado: listo para instalar'
    }
    $uninstallMenu.Visible = $hasInstalledComponent
    $uninstallMenu.Enabled = $hasInstalledComponent
}

$installButton.Add_Click({
    $state = Get-InstallationState
    if ($state.CompilerReady -and -not $state.Configuration) {
        Select-ProjectFolderAndConfigure
        return
    }
    $missing = @()
    if (-not $state.Msys2) { $missing += 'MSYS2' }
    if (-not $state.Gcc) { $missing += 'GCC' }
    if (-not $state.Gdb) { $missing += 'GDB' }
    if (-not $state.VsCode) { $missing += 'VS Code no detectado' }
    if ($state.VsCode -and -not $state.Extension) { $missing += 'extension C/C++' }
    if (-not $state.Configuration) { $missing += 'configuracion de VS Code' }
    $configDetail = if ($state.LocalConfiguration) { 'si (proyecto actual)' } elseif ($state.ParentConfiguration) { 'si (carpeta padre)' } else { 'no' }
    $stateText = "MSYS2: $($state.Msys2)`r`nGCC: $($state.Gcc)`r`nGDB: $($state.Gdb)`r`nVS Code: $($state.VsCode)`r`nExtension: $($state.Extension)`r`nConfiguracion: $configDetail"
    $actionText = if ($missing.Count -eq 0) { 'Todo esta instalado y configurado correctamente. Deseas revalidar ejemplos?' } else { "Falta o requiere reparacion: $($missing -join ', '). Se conservaran los archivos existentes." }
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
        Set-VSCodeConfiguration -targetDir $projectDir
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
        Add-Log ('ERROR: ' + $_.Exception.Message)
        $statusLabel.Text = 'Estado: error; revisa el registro'
        [System.Windows.Forms.MessageBox]::Show($_.Exception.Message, 'Error de instalacion', 'OK', 'Error') | Out-Null
    }
    $installButton.Enabled = $true
})

$openButton.Add_Click({ Start-Process 'explorer.exe' -ArgumentList $projectDir })
$closeButton.Add_Click({ $form.Close() })
$installMenu.Add_Click({ $installButton.PerformClick() })
$configMenu.Add_Click({ Select-ProjectFolderAndConfigure })
$uninstallMenu.Add_Click({ $uninstallButton.PerformClick() })
$tutorialMenu.Add_Click({ Show-Tutorial })
$checkMenu.Add_Click({
    try { Initialize-Example; Test-Example }
    catch { Add-Log ('ERROR: ' + $_.Exception.Message); [System.Windows.Forms.MessageBox]::Show($_.Exception.Message, 'Comprobar ejemplos', 'OK', 'Error') | Out-Null }
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
        $codeCmd = Get-Command code.cmd -ErrorAction SilentlyContinue
        if ($codeCmd) {
            try {
                Invoke-Native $codeCmd.Source @('--uninstall-extension', 'ms-vscode.cpptools', '--force')
            } catch {
                Add-Log 'Aviso: la extension no se pudo desinstalar (si VS Code esta abierto, cierralo primero).'
            }
        }
        Set-InstallerProgress 40 'retirando extension de VS Code'
        $wingetCmd = Get-Command winget.exe -ErrorAction SilentlyContinue
        if ($wingetCmd) {
            Invoke-Native $wingetCmd.Source @('uninstall', '--id', 'MSYS2.MSYS2', '-e', '--silent', '--accept-source-agreements')
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
    } catch { Add-Log ('ERROR: ' + $_.Exception.Message) }
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
$openButton.BringToFront()
$closeButton.BringToFront()
$uninstallButton.BringToFront()
$footer.BringToFront()

Update-InstallationControl

Add-Log 'CCompilerFlat by LuisMartinPM listo.'
Add-Log 'Puedes abrir el Tutorial sin instalar nada.'
[void]$form.ShowDialog()
