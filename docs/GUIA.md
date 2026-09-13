# Guia de uso

## Instalar las herramientas

Ejecuta `CCompilerFlat.bat` y selecciona **Instalar**. La app instala el compilador y crea la configuracion local de VS Code sin cambiar el `PATH` global.

La app muestra el progreso de instalacion del 0% al 100%. Si la sesion no es de administrador, `winget` puede mostrar una solicitud de UAC; debes aceptarla para instalar MSYS2 en su ubicacion predeterminada. La app no eleva permisos silenciosamente.

Antes de abrir la app ejecuta `Verificar-CCompilerFlat.bat`. Comprueba archivos, sintaxis, PSScriptAnalyzer y compilacion de los cuatro ejemplos sin abrir la interfaz.

## Compilar un archivo C

Abre la carpeta que contiene tu codigo en VS Code, abre el archivo `.c` y pulsa el boton verde **Ejecutar y depurar**. La tarea compila el archivo activo y genera el `.exe` en la misma carpeta.

Tambien puedes usar `Ctrl+Shift+B` para ejecutar la tarea de compilacion. La salida tecnica de la tarea esta oculta para que veas solo el resultado del programa.

## Probar los ejemplos

La carpeta `ejemplos/` contiene cuatro archivos interactivos:

- `01_hola.c`: confirma que GCC compila y ejecuta correctamente.
- `02_calculadora.c`: prueba operaciones aritmeticas con validacion de entrada.
- `03_adivina.c`: juego para encontrar un numero secreto.
- `04_piedra_papel_tijera.c`: juego repetible contra la computadora.

**Retencion de consola**: Todos los ejemplos incluyen `system("pause")` y limpieza de bufer de teclado (`getchar()`), garantizando que la ventana de la consola permanezca abierta hasta que el usuario pulse una tecla, evitando cierres instantaneos.

Abre cualquiera de ellos en VS Code y pulsa **Ejecutar y depurar** (F5 o Ctrl+F5). La app tambien ofrece documentacion y solucion de problemas desde el menu **Ayuda / Tutorial**.

Tambien puedes usar **Comprobar ejemplos** en el menu del instalador para validar los cuatro archivos con GCC.

## Modos de configuracion de proyectos en VS Code

CCompilerFlat ofrece 3 modalidades para configurar VS Code segun tus necesidades mediante el boton **[ CONFIGURAR PROYECTO ]** o el menu superior:

1. **Instalar kit completo (Compilador global + Carpeta actual)**:
   - Al pulsar **[ INSTALAR TODO ]**, se instala el compilador GCC 16.1 UCRT64, se registra en el `PATH` global de Windows, se inyecta la configuracion `.vscode` en la carpeta actual y se aplica la configuracion global en VS Code. Es un kit integral indispensable para nuevos estudiantes.
2. **Elegir carpeta de proyecto (Por proyecto)**:
   - Abre el explorador de carpetas de Windows para elegir cualquier proyecto existente o nuevo (en el Escritorio, memoria USB, carpeta `ALGORITMO`, etc.) e inyectar la subcarpeta `.vscode` completa (`tasks.json`, `launch.json`, `c_cpp_properties.json`).
3. **Configuracion global en VS Code (`%APPDATA%\Code\User\tasks.json`)**:
   - Inyecta la tarea de compilacion a nivel de usuario en VS Code. Permite abrir cualquier archivo `.c` en CUALQUIER carpeta del equipo y compilarlo inmediatamente con GCC sin necesidad de crear archivos `.vscode` locales.


## Depurar

Coloca un punto de interrupcion haciendo clic junto al numero de linea y pulsa **Ejecutar y depurar**. GDB se iniciara automaticamente.

## Desinstalar

Desde el boton **[ DESINSTALAR ]** o menu **Desinstalar**:
1. El sistema solicita confirmacion para retirar MSYS2, GCC, GDB y la extension de C/C++.
2. Pregunta de forma independiente si deseas eliminar la configuracion de VS Code (`.vscode`) o conservarla intacta.
3. El instalador nunca elimina tus archivos de codigo fuente ni carpetas del repositorio.

El apartado **Acerca de** contiene la identidad del proyecto y los enlaces de contacto de MKZ Company.

## Diagnostico inteligente de errores y soluciones

CCompilerFlat integra un analizador de diagnostico que evalua cualquier fallo y orienta al usuario en el registro de la aplicacion y en ventanas emergentes:

- **Antivirus o Windows Defender (`Acceso denegado`, `Permission denied`, `0x80070005`)**:
  - *Causa*: Windows Defender o un antivirus de terceros bloquea la creacion o ejecucion de archivos binarios `.exe` o el acceso a carpetas protegidas.
  - *Solucion*: Abre **Seguridad de Windows > Proteccion contra virus y amenazas > Historial de proteccion**. Si tienes activo el "Control de acceso a carpetas", concede permiso a `CCompilerFlat` y a `gcc.exe`, o anade la carpeta de tu proyecto a las exclusiones del antivirus.
- **Archivos bloqueados por VS Code**:
  - *Causa*: Si VS Code esta abierto durante la instalacion o desinstalacion de extensiones, Windows bloquea los ejecutables y archivos temporales.
  - *Solucion*: Cierra todas las instancias de VS Code y reintenta la operacion en CCompilerFlat.
- **Permisos de Administrador (UAC)**:
  - *Causa*: La instalacion de MSYS2 en `C:\msys64` requiere permisos elevados de Windows.
  - *Solucion*: Haz clic derecho sobre `CCompilerFlat.bat` o el script y selecciona **Ejecutar como Administrador**.
- **Fallo de red o `winget` no responde**:
  - *Causa*: Problemas de conexion o la version de `winget` requiere actualizacion.
  - *Solucion*: Abre Microsoft Store, busca y actualiza **Instalador de paquetes (App Installer)** y comprueba tu acceso a internet.
- **Uso global en terminal**:
  - CCompilerFlat anade `C:\msys64\ucrt64\bin` a la variable `PATH` de usuario en Windows. Puedes compilar manualmente en PowerShell o CMD desde cualquier ruta:
    ```bash
    gcc archivo.c -o programa.exe
    .\programa.exe
    ```