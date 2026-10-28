# Instalador CineSur

Dos archivos:

- `Installer_CineSur.iss` — script de Inno Setup 6 que arma el `Setup_CineSur_1.0.0.exe`.
- `Database/Deploy_IngSoftware.sql` — script **idempotente / de migración** que crea la base `Ing.Software` (27 tablas, datos semilla, 8 SPs y los 3 triggers de la bitácora). Se puede correr las veces que sea: crea **solo lo que falta** y **no toca los datos existentes**. Para la v2/v3, agregás columnas nuevas y datos de referencia en la sección `MIGRACIONES` del final del script.

## Lo que hace el instalador

1. Copia la app a `Archivos de programa\CineSur` (sin `.pdb` ni `.xml`).
2. Te deja elegir la **instancia de SQL Server** (combo editable, por defecto `.\SQLEXPRESS`) y prueba la conexión con `sqlcmd`.
3. Reescribe **solo** el `Data Source` del `Proyecto IngSoftware.exe.config` con esa instancia (vía PowerShell, sin tocar el resto de la cadena).
4. Corre el script de base con `sqlcmd` y avisa `DEPLOY_OK` (creó todo) o `DEPLOY_OMITIDO` (ya existía).
5. Crea acceso directo y una clave `HKLM\Software\CineSur` para detectar reinstalaciones.

En la desinstalación **no borra la base de datos**.

## Pasos en tu PC (esto no lo puedo hacer yo)

1. **Compilar en Release**: en Visual Studio, cambiá la config a `Release` y compilá la solución. (Si preferís Debug, abrí el `.iss` y en la línea `#define SourceBin` cambiá `bin\Release` por `bin\Debug`.)
2. **Instalá Inno Setup 6** si no lo tenés: https://jrsoftware.org/isdl.php
3. Abrí `Installer_CineSur.iss` con Inno Setup y dale **Build → Compile** (o `Ctrl+F9`). El setup te queda en `Instalador\Output\Setup_CineSur_1.0.0.exe`.
4. Probalo en tu máquina (o en una limpia): corré el setup como admin, elegí la instancia y seguí.

> Para que el paso 4 cree la base, la PC necesita tener **`sqlcmd`** (viene con SQL Server / las "Command Line Utilities"). Si no está, el instalador igual deja la app instalada y te dice que corras el `.sql` a mano desde SSMS (`Ctrl+A → F5`).

## Qué no pude hacer desde acá

Compilar la solución, correr `ISCC.exe` para generar el setup, ni probar `sqlcmd` contra tu base — todo eso necesita tu máquina. Te dejé el `.iss` y el `.sql` listos.
