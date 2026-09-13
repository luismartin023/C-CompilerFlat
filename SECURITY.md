# Seguridad

CCompilerFlat no desactiva Windows Defender, no crea exclusiones y no modifica las politicas de seguridad del equipo.

Si Windows muestra una alerta:

1. Verifica que descargaste el proyecto desde https://github.com/luismartin023/C-CompilerFlat.
2. Revisa el codigo fuente antes de ejecutarlo.
3. Comprueba el editor y la ubicacion del archivo en Seguridad de Windows.
4. Solo permite la ejecucion si confias en el codigo y entiendes la alerta.
5. Mantén Defender y Windows actualizados.

El proyecto instala herramientas de terceros desde MSYS2 mediante `winget` y `pacman`. Esas herramientas tienen sus propias licencias y politicas de seguridad.

Para reportar un problema, contacta a luismartinpm2020@gmail.com.
