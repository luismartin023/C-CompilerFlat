# Guia de uso

## Instalar las herramientas

Ejecuta `CCompilerFlat.bat` y selecciona **Instalar**. La app instala el compilador y crea la configuracion local de VS Code sin cambiar el `PATH` global.

La app muestra el progreso de instalacion del 0% al 100%. Si la sesion no es de administrador, `winget` puede mostrar una solicitud de UAC; debes aceptarla para instalar MSYS2 en su ubicacion predeterminada. La app no eleva permisos silenciosamente.

Antes de abrir la app puedes ejecutar `Preparar-CCompilerFlat.bat`. Ese archivo instala PSScriptAnalyzer para revisar `src\CCompilerFlat.ps1`, muestra cualquier warning y abre la app solo cuando el analisis esta limpio. No es obligatorio para usuarios finales.

Para una prueba completa sin abrir la interfaz, ejecuta `Verificar-CCompilerFlat.bat`. Comprueba archivos, sintaxis, PSScriptAnalyzer y compilacion de los cuatro ejemplos.

## Compilar un archivo C

Abre la carpeta que contiene tu codigo en VS Code, abre el archivo `.c` y pulsa el boton verde **Ejecutar y depurar**. La tarea compila el archivo activo y genera el `.exe` en la misma carpeta.

Tambien puedes usar `Ctrl+Shift+B` para ejecutar la tarea de compilacion. La salida tecnica de la tarea esta oculta para que veas solo el resultado del programa.

## Probar los ejemplos

La carpeta `ejemplos/` contiene cuatro archivos:

- `01_hola.c`: confirma que GCC compila y ejecuta correctamente.
- `02_calculadora.c`: prueba suma, resta, multiplicacion y division.
- `03_adivina.c`: juego para encontrar un numero secreto.
- `04_piedra_papel_tijera.c`: juego repetible contra la computadora.

Abre uno de ellos en VS Code y pulsa **Ejecutar y depurar**. La app tambien ofrece el tutorial desde el menu **Tutorial**.

Tambien puedes usar **Comprobar ejemplos** en el menu del instalador. Esa opcion valida los cuatro archivos con GCC sin crear ejecutables. La compilacion y ejecucion normal se hacen desde VS Code.

## Depurar

Coloca un punto de interrupcion haciendo clic junto al numero de linea y pulsa **Ejecutar y depurar**. GDB se iniciara automaticamente.

## Desinstalar

Desde el menu **Desinstalar**, confirma la operacion. El instalador retira MSYS2, GCC, GDB y la extension de C/C++. No elimina tus archivos fuente.

El apartado **Acerca de** contiene la identidad del proyecto y los enlaces de contacto. El preparador no duplica estas opciones: despues del analisis abre la misma aplicacion principal.

## Problemas comunes

Si VS Code no reconoce la configuracion, abre la carpeta del proyecto que contiene `.vscode` y ejecuta **Developer: Reload Window**. Si `winget` no existe, actualiza Windows App Installer desde Microsoft Store.

## Errores y soluciones

- **GCC no esta instalado**: ejecuta **Instalar** y acepta la confirmacion. La app comprobara los ejemplos al finalizar.
- **No se encuentra `gcc.exe`**: comprueba que exista `C:\msys64\ucrt64\bin\gcc.exe` y vuelve a abrir VS Code.
- **GCC termina sin mostrar el motivo**: normalmente faltan las rutas UCRT64 para sus DLL. CCompilerFlat las configura localmente en la tarea y en la depuracion; no cambia el `PATH` global.
- **El programa no inicia**: guarda el archivo `.c` y usa **Ejecutar y depurar** para que la tarea lo compile antes de abrirlo.
- **La consola muestra un error de compilacion**: la tarea oculta el comando, pero muestra el diagnostico. Revisa la linea indicada en el archivo C.
- **La ventana se cierra al terminar**: es normal cuando el programa termina; usa una entrada interactiva o depura con un punto de interrupcion para observarlo.
- **No hay salida visible**: selecciona el perfil `Ejecutar archivo C actual` en la vista de depuracion.
- **La instalacion requiere permisos**: Windows puede solicitar autorizacion para instalar MSYS2. La app no eleva permisos por su cuenta ni modifica el `PATH` global.
- **Se rechazo UAC**: vuelve a pulsar **Instalar** y acepta la ventana de Windows, o ejecuta la app en una cuenta con permiso para instalar programas.
- **Winget no responde**: abre Microsoft Store, actualiza **App Installer** y vuelve a ejecutar **Comprobar ejemplos**.
- **Defender muestra una alerta**: revisa el codigo y la procedencia del repositorio. No desactives Defender ni agregues exclusiones automaticas.