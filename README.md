# CCompilerFlat by LuisMartinPM

Instalador grafico para preparar Windows para compilar y depurar proyectos C/C++ desde Visual Studio Code.

## Que instala

- MSYS2.
- GCC para UCRT64.
- GDB para depuracion.
- Extension Microsoft C/C++ de VS Code, si el comando `code` esta disponible.
- Configuracion `.vscode` para compilar el archivo C abierto con **Ejecutar y depurar**.
- Cuatro ejemplos listos en `ejemplos/`, incluyendo dos juegos interactivos.

## Instalacion rapida

1. Descarga o clona este repositorio.
2. Opcionalmente ejecuta `Preparar-CCompilerFlat.bat` para instalar PSScriptAnalyzer, revisar el script y abrir la app.
3. Para uso normal, ejecuta `CCompilerFlat.bat` directamente.
4. Pulsa **INSTALAR TODO**.
5. Abre tu carpeta de proyecto en VS Code.
6. Abre un archivo `.c` y pulsa **Ejecutar y depurar**.

## Estructura del proyecto

```text
C-CompilerFlat/
|- CCompilerFlat.bat              # Entrada normal para usuarios
|- Verificar-CCompilerFlat.bat    # Revisa toda la instalacion
|- src/CCompilerFlat.ps1          # Aplicacion grafica principal
|- Preparar-CCompilerFlat.bat      # Revisa el codigo y abre la app
|- tools/                          # Herramientas internas de mantenimiento
|  |- Preparar-PSScriptAnalyzer.ps1
|  `- Verificar-CCompilerFlat.ps1
|- ejemplos/                       # Fuentes C de prueba y juegos
|- docs/                           # Guia y datos del proyecto
|- LICENSE
`- SECURITY.md
```

Hay tres accesos intencionales en la raiz: `CCompilerFlat.bat` para usar la app, `Preparar-CCompilerFlat.bat` para analizar y abrir la app, y `Verificar-CCompilerFlat.bat` para ejecutar todas las comprobaciones sin abrir la interfaz. El script de la app vive en `src/` y no se duplica.

La instalacion puede pedir permisos de Windows para instalar MSYS2. El script no modifica el `PATH` del sistema.

CCompilerFlat no obliga a ejecutar toda la aplicación como administrador. En una cuenta estándar, `winget` muestra UAC solo si Windows necesita elevar la instalación; si el usuario rechaza UAC, la app informa el motivo y no continúa como si hubiera terminado correctamente.

PSScriptAnalyzer es una herramienta opcional de desarrollo; no es necesaria para ejecutar el instalador. `Preparar-CCompilerFlat.bat` la instala en el perfil del usuario, analiza `src\CCompilerFlat.ps1` y no eleva permisos por su cuenta.

La configuracion de VS Code incorpora temporalmente `C:\msys64\ucrt64\bin` y `C:\msys64\usr\bin` solo para compilar y depurar, de modo que GCC encuentre sus DLL sin cambiar las variables globales de Windows.

Al finalizar aparece un tutorial dentro de la app. Tambien puedes abrirlo desde el menu **Tutorial**.

## Desinstalacion

Abre el instalador y pulsa **UNINSTALL**, o usa el menu **Desinstalar**. La app pide confirmacion antes de retirar MSYS2 y la extension C/C++. Las configuraciones `.vscode` solo se borran cuando contienen la ruta de GCC generada por este instalador.

## Contacto

- GitHub: https://github.com/luismartin023
- LinkedIn: https://www.linkedin.com/in/luismartinpm-mkz-dev/
- WhatsApp: https://api.whatsapp.com/send/?phone=18296782049&text&type=phone_number&app_absent=0
- Correo: luismartinpm2020@gmail.com

## Seguridad

No se incluye ningun archivo para desactivar Windows Defender ni para crear exclusiones automaticas. Si Windows muestra una alerta, revisa el codigo fuente y descarga el proyecto desde el repositorio oficial antes de decidir si permites la ejecucion manualmente.

## Licencia

Este proyecto se distribuye bajo la licencia MIT. Consulta [LICENSE](LICENSE) para el texto legal y [docs/LICENCIA.md](docs/LICENCIA.md) para la explicacion en espanol.

## Verificacion

Para revisar sintaxis, archivos requeridos y compilacion de los ejemplos, ejecuta:

```powershell
powershell -ExecutionPolicy Bypass -File tools\Verificar-CCompilerFlat.ps1
```

Tambien puedes ejecutar `Verificar-CCompilerFlat.bat` con doble clic. El menu **Desinstalar** y el apartado **Acerca de** estan dentro de la app principal; el preparador abre esa misma app despues del analisis.