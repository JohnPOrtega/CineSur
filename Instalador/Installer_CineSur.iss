; ============================================================================
;  INSTALADOR CineSur  -  Inno Setup 6  (ISCC.exe)   -   VERSION 3
;
;  Novedades de la v3:
;   - Instalacion nueva con base VACIA: solo estructura, roles/patentes y un usuario
;     (Sassaroli, Administrador, con contrasenia de fabrica DNI+Apellido: el sistema
;     le pide cambiarla al entrar).
;   - Los datos de prueba se pasaron a Database\Datos_Prueba.sql (se copia junto al
;     Deploy pero NO se corre solo). Despues de correrlo, el admin recalcula el DV
;     desde la pantalla de Integridad DV que aparece al loguearse.
;   - Actualizar sobre una base v2 no cambia: conserva todos los datos cargados.
;
;  Novedades de la v2:
;   - Tres caminos: Instalar (primera vez), Actualizar (reinstalar sin perder datos,
;     con copia de seguridad antes) o Restaurar (reinstalar volviendo la base a un .bak).
;   - La copia de seguridad previa queda en C:\Backups43BO, la misma carpeta que usa la app,
;     asi despues se puede restaurar tambien desde Admin > Restore.
;   - Despues de restaurar se corre igual el Deploy_IngSoftware.sql: si el .bak era de una
;     version vieja, las MIGRACIONES le agregan lo que falte (ej. CantidadRecibida_14OR).
;
;  Este instalador copia la app compilada a Archivos de programa (sin los .pdb
;  ni los .xml que no hacen falta) y despues deja que el usuario elija la
;  instancia de SQL Server en un combo editable. Con esa instancia reescribe
;  solo el "Data Source" del .exe.config via PowerShell y no toca el resto de
;  la cadena. Enseguida corre el Deploy_IngSoftware.sql con sqlcmd que es
;  idempotente asi que crea nada mas lo que falta y al terminar bien deja un
;  DEPLOY_OK. Al final arma el acceso directo y una clave de registro pa
;  reconocer si ya estaba instalado.
;
;  Lo que nunca hace: borrar la base cuadno se desinstala, guardar secretos
;  nuevos en el repo (la cadena vive en el .exe.config) ni correr nada
;  destructivo.
;
;  Ojo antes de compilar: revisa las 3 rutas de los #define de aca abajo.
; ============================================================================

#define AppNombre       "CineSur"
#define AppVersion      "3.0.0"
#define AppPublisher    "CineSur"
#define AppExe          "Proyecto IngSoftware.exe"

; Carpeta con el BUILD (donde etsa el .exe + dlls). Normalmente bin\Release;
; si compilas en Debug, apunta a bin\Debug.
#define SourceBin       "..\Proyecto IngSoftware\bin\Release"

; Script SQL de deploy (el que esta en esta misma carpeta, en Database\).
#define DeploySql       "Database\Deploy_IngSoftware.sql"
; Datos de prueba opcionales (v3): se copian pero no se ejecutan.
#define DatosPruebaSql  "Database\Datos_Prueba.sql"

; Carpeta de copias de seguridad (la misma que usa la app en Admin > Backup / Restore).
#define CarpetaBackup   "C:\Backups43BO"

; Icono del instalador (se toma de los recursos de la app).
#define IcoFile         SourceBin + "\Recursos\cinesur.ico"

[Setup]
AppId={{B7E4C2A1-9F3D-4E6A-8C1B-CINESUR0001}}
AppName={#AppNombre}
AppVersion={#AppVersion}
AppPublisher={#AppPublisher}
DefaultDirName={autopf}\{#AppNombre}
DefaultGroupName={#AppNombre}
DisableProgramGroupPage=yes
OutputDir=Output
OutputBaseFilename=Setup_CineSur_{#AppVersion}
Compression=lzma2
SolidCompression=yes
WizardStyle=modern
; Necesita admin para escribir en Archivos de programa, HKLM y la base.
PrivilegesRequired=admin
SetupIconFile={#IcoFile}
UninstallDisplayIcon={app}\Recursos\cinesur.ico
ArchitecturesInstallIn64BitMode=x64compatible
; --- Marca CineSur: banner lateral y logo chico (varios tamanios, elige por DPI) ---
WizardImageFile=Recursos\wizimg_164.bmp,Recursos\wizimg_246.bmp,Recursos\wizimg_328.bmp
WizardSmallImageFile=Recursos\wizsmall_55.bmp,Recursos\wizsmall_83.bmp,Recursos\wizsmall_110.bmp,Recursos\wizsmall_138.bmp
; pagina de info antes de instalar (requisitos / que hace)
InfoBeforeFile=Info.txt

[Languages]
Name: "es"; MessagesFile: "compiler:Languages\Spanish.isl"

[Messages]
; textos de bienvenida y cierre con la marca
WelcomeLabel1=Bienvenido al asistente de CineSur
WelcomeLabel2=Este asistente instala CineSur en tu equipo y crea o actualiza su base de datos Ing.Software.%n%nSi tenes la aplicacion abierta, cerrala antes de seguir.
FinishedHeadingLabel=CineSur quedo listo
FinishedLabelNoIcons=Ya podes empezar a usar CineSur.
ClickNext=Hace clic en Siguiente pa continuar.

[Files]
; --- Ejecutable y su config (fuente de la cadena de conexion) ---
Source: "{#SourceBin}\{#AppExe}";            DestDir: "{app}"; Flags: ignoreversion
Source: "{#SourceBin}\{#AppExe}.config";     DestDir: "{app}"; Flags: ignoreversion
; --- Dependencias (solo dll: asi quedan afuera los .pdb y .xml) ---
Source: "{#SourceBin}\*.dll";                DestDir: "{app}"; Flags: ignoreversion
; --- Carpetas que la app necesita en runtime ---
Source: "{#SourceBin}\Recursos\*";           DestDir: "{app}\Recursos"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SourceBin}\Ayuda\*.json";       DestDir: "{app}\Ayuda";    Flags: ignoreversion
Source: "{#SourceBin}\Idiomas\*";            DestDir: "{app}\Idiomas";  Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SourceBin}\Posters\*";            DestDir: "{app}\Posters";  Flags: ignoreversion recursesubdirs createallsubdirs skipifsourcedoesntexist
; --- Script de base de datos ---
Source: "{#DeploySql}";                      DestDir: "{app}\Database"; Flags: ignoreversion
Source: "{#DatosPruebaSql}";                 DestDir: "{app}\Database"; Flags: ignoreversion

[Dirs]
; La app escribe al lado del .exe: RutaBackup_43BO.txt (Admin > Backup), los PDF de Reportes,
; los tickets de Entradas y los afiches que se cargan en Master > Peliculas (Posters).
; En Archivos de programa un usuario comun no puede escribir, asi que le doy permiso de
; modificar a los usuarios del equipo sobre la carpeta del programa (lo heredan las subcarpetas).
Name: "{app}"; Permissions: users-modify
Name: "{app}\Posters"; Permissions: users-modify
Name: "{app}\Entradas"; Permissions: users-modify; Flags: uninsneveruninstall
Name: "{app}\Reportes"; Permissions: users-modify; Flags: uninsneveruninstall

[Icons]
Name: "{group}\{#AppNombre}";               Filename: "{app}\{#AppExe}"; IconFilename: "{app}\Recursos\cinesur.ico"
Name: "{autodesktop}\{#AppNombre}";         Filename: "{app}\{#AppExe}"; IconFilename: "{app}\Recursos\cinesur.ico"; Tasks: desktopicon

[Tasks]
Name: "desktopicon"; Description: "Crear un acceso directo en el Escritorio"; GroupDescription: "Accesos directos:"

[Registry]
; clave para detectar instalaciones previas (install / reinstall) y guardar la ruta
Root: HKLM; Subkey: "Software\{#AppNombre}"; ValueType: string; ValueName: "InstallPath"; ValueData: "{app}";       Flags: uninsdeletekey
Root: HKLM; Subkey: "Software\{#AppNombre}"; ValueType: string; ValueName: "Version";     ValueData: "{#AppVersion}"
Root: HKLM; Subkey: "Software\{#AppNombre}"; ValueType: string; ValueName: "SqlInstance"; ValueData: "{code:InstanciaElegida}"
Root: HKLM; Subkey: "Software\{#AppNombre}"; ValueType: string; ValueName: "TipoInstalacion"; ValueData: "{code:TipoElegido}"

[Run]
Filename: "{app}\{#AppExe}"; Description: "Iniciar {#AppNombre}"; Flags: nowait postinstall skipifsilent

; ============================================================================
;  CODE
; ============================================================================
[Code]
var
  PageInstancia: TWizardPage;
  cboInstancia: TNewComboBox;
  btnProbar: TNewButton;
  lblEstado: TNewStaticText;
  { pagina de tipo de instalacion (instalar / reinstalar) }
  PageTipo: TWizardPage;
  rbInstalar, rbReinstalar, rbRestaurar: TNewRadioButton;
  chkBackup: TNewCheckBox;
  txtBak: TNewEdit;
  btnBak: TNewButton;
  lblPrevia: TNewStaticText;
  HayPrevia: Boolean;
  CarpetaPrevia, VersionPrevia: String;

{ Instancia elegida por el usuario (o el default si dejo vacio) }
function InstanciaElegida(Param: String): String;
begin
  if cboInstancia = nil then
    Result := '.\SQLEXPRESS'
  else
  begin
    Result := Trim(cboInstancia.Text);
    if Result = '' then
      Result := '.\SQLEXPRESS';
  end;
end;

{ Prueba la conexion a la instancia con sqlcmd (SELECT 1).
  Devuelve: 0 = OK, 1 = fallo de conexion, 2 = no se encontro sqlcmd }
function ProbarConexion(const Instancia: String): Integer;
var
  rc: Integer;
begin
  if not Exec(ExpandConstant('{cmd}'), '/C sqlcmd -S "' + Instancia + '" -E -b -l 5 -Q "SET NOCOUNT ON; SELECT 1" >nul 2>&1',
              '', SW_HIDE, ewWaitUntilTerminated, rc) then
  begin
    Result := 2;   { no se pudo lanzar cmd }
    exit;
  end;
  { 9009 = comando no encontrado (sqlcmd no instalado / no en PATH) }
  if rc = 9009 then
    Result := 2
  else if rc = 0 then
    Result := 0
  else
    Result := 1;
end;

{ el boton "Probar conexion" de la pagina de instancia }
procedure BtnProbarClick(Sender: TObject);
begin
  lblEstado.Caption := 'Probando...';
  case ProbarConexion(InstanciaElegida('')) of
    0: lblEstado.Caption := 'Conexion OK con ' + InstanciaElegida('') + '.';
    2: lblEstado.Caption := 'No encontre sqlcmd, no puedo probar desde aca (la app igual se instala).';
  else
    lblEstado.Caption := 'No pude conectar. Fijate el nombre de la instancia o si SQL Server esta prendido.';
  end;
end;

{ habilita lo que corresponde segun el camino elegido }
procedure ActualizarTipo;
begin
  chkBackup.Enabled := rbReinstalar.Enabled and rbReinstalar.Checked;
  txtBak.Enabled := rbRestaurar.Enabled and rbRestaurar.Checked;
  btnBak.Enabled := txtBak.Enabled;
end;

procedure TipoClick(Sender: TObject);
begin
  ActualizarTipo;
end;

{ elegir el .bak (arranca en la carpeta de backups de la app) }
procedure BtnBakClick(Sender: TObject);
var
  archivo: String;
begin
  archivo := txtBak.Text;
  if GetOpenFileName('Elegi la copia de seguridad a restaurar', archivo, '{#CarpetaBackup}',
                     'Copias de seguridad (*.bak)|*.bak|Todos los archivos (*.*)|*.*', 'bak') then
    txtBak.Text := archivo;
end;

function EsRestaurar: Boolean;
begin
  Result := (rbRestaurar <> nil) and rbRestaurar.Checked;
end;

{ lo guardo en el registro pa saber como se instalo la ultima vez }
function TipoElegido(Param: String): String;
begin
  if EsRestaurar then
    Result := 'Restaurar'
  else if (rbReinstalar <> nil) and rbReinstalar.Checked then
    Result := 'Actualizar'
  else
    Result := 'Instalar';
end;

procedure InitializeWizard;
var
  lbl: TNewStaticText;
  prev: String;
begin
  { ---- Pagina: Tipo de instalacion (Instalar / Reinstalar) ---- }
  HayPrevia := RegQueryStringValue(HKLM, 'Software\{#AppNombre}', 'InstallPath', CarpetaPrevia);
  if not RegQueryStringValue(HKLM, 'Software\{#AppNombre}', 'Version', VersionPrevia) then
    VersionPrevia := '';

  PageTipo := CreateCustomPage(wpWelcome, 'Tipo de instalacion', 'Elegi que queres hacer.');

  rbInstalar := TNewRadioButton.Create(WizardForm);
  rbInstalar.Parent := PageTipo.Surface;
  rbInstalar.Left := 0;
  rbInstalar.Top := ScaleY(4);
  rbInstalar.Width := PageTipo.SurfaceWidth;
  rbInstalar.Caption := 'Instalar (primera vez): copia el sistema y crea la base con los datos iniciales.';
  rbInstalar.OnClick := @TipoClick;

  rbReinstalar := TNewRadioButton.Create(WizardForm);
  rbReinstalar.Parent := PageTipo.Surface;
  rbReinstalar.Left := 0;
  rbReinstalar.Top := rbInstalar.Top + ScaleY(30);
  rbReinstalar.Width := PageTipo.SurfaceWidth;
  rbReinstalar.Caption := 'Actualizar (reinstalar): pone la version nueva y conserva tus datos.';
  rbReinstalar.OnClick := @TipoClick;

  chkBackup := TNewCheckBox.Create(WizardForm);
  chkBackup.Parent := PageTipo.Surface;
  chkBackup.Left := ScaleX(18);
  chkBackup.Top := rbReinstalar.Top + ScaleY(22);
  chkBackup.Width := PageTipo.SurfaceWidth - ScaleX(18);
  chkBackup.Caption := 'Hacer una copia de seguridad de la base antes (recomendado)';
  chkBackup.Checked := True;

  rbRestaurar := TNewRadioButton.Create(WizardForm);
  rbRestaurar.Parent := PageTipo.Surface;
  rbRestaurar.Left := 0;
  rbRestaurar.Top := chkBackup.Top + ScaleY(32);
  rbRestaurar.Width := PageTipo.SurfaceWidth;
  rbRestaurar.Caption := 'Restaurar (reinstalar): vuelve la base a una copia de seguridad (.bak).';
  rbRestaurar.OnClick := @TipoClick;

  txtBak := TNewEdit.Create(WizardForm);
  txtBak.Parent := PageTipo.Surface;
  txtBak.Left := ScaleX(18);
  txtBak.Top := rbRestaurar.Top + ScaleY(24);
  txtBak.Width := PageTipo.SurfaceWidth - ScaleX(18) - ScaleX(96);
  txtBak.Text := '';

  btnBak := TNewButton.Create(WizardForm);
  btnBak.Parent := PageTipo.Surface;
  btnBak.Left := txtBak.Left + txtBak.Width + ScaleX(6);
  btnBak.Top := txtBak.Top - ScaleY(1);
  btnBak.Width := ScaleX(90);
  btnBak.Height := ScaleY(23);
  btnBak.Caption := 'Examinar...';
  btnBak.OnClick := @BtnBakClick;

  lblPrevia := TNewStaticText.Create(WizardForm);
  lblPrevia.Parent := PageTipo.Surface;
  lblPrevia.Left := 0;
  lblPrevia.Top := txtBak.Top + ScaleY(34);
  lblPrevia.AutoSize := False;
  lblPrevia.Width := PageTipo.SurfaceWidth;
  lblPrevia.Height := ScaleY(60);

  if HayPrevia then
  begin
    rbReinstalar.Checked := True;
    lblPrevia.Caption := 'Instalacion encontrada en este equipo:' + #13#10 +
      '    Carpeta: ' + CarpetaPrevia + #13#10 +
      '    Version: ' + VersionPrevia;
  end
  else
  begin
    rbInstalar.Checked := True;
    rbReinstalar.Enabled := False;
    rbRestaurar.Enabled := False;
    lblPrevia.Caption := 'No se encontro una instalacion anterior en este equipo: solo se puede Instalar.';
  end;
  ActualizarTipo;

  PageInstancia := CreateCustomPage(wpSelectDir,
    'Servidor de base de datos',
    'Elegi (o escribi) la instancia de SQL Server donde se creara la base "Ing.Software".');

  lbl := TNewStaticText.Create(WizardForm);
  lbl.Parent := PageInstancia.Surface;
  lbl.Left := 0;
  lbl.Top := 0;
  lbl.AutoSize := True;
  lbl.Caption := 'Instancia de SQL Server:';

  cboInstancia := TNewComboBox.Create(WizardForm);
  cboInstancia.Parent := PageInstancia.Surface;
  cboInstancia.Left := 0;
  cboInstancia.Top := lbl.Top + lbl.Height + 6;
  cboInstancia.Width := PageInstancia.SurfaceWidth;
  cboInstancia.Style := csDropDown;   { editable: permite tipear una instancia a mano }
  cboInstancia.Items.Add('.\SQLEXPRESS');
  cboInstancia.Items.Add('.');
  cboInstancia.Items.Add('(local)');
  cboInstancia.Items.Add('localhost');

  { si ya habia una instalacion previa, prellenamos con la instancia usada }
  if RegQueryStringValue(HKLM, 'Software\{#AppNombre}', 'SqlInstance', prev) and (Trim(prev) <> '') then
  begin
    if cboInstancia.Items.IndexOf(prev) < 0 then
      cboInstancia.Items.Insert(0, prev);
    cboInstancia.ItemIndex := cboInstancia.Items.IndexOf(prev);
  end
  else
    cboInstancia.ItemIndex := 0;

  { boton opcional para probar la conexion antes de seguir }
  btnProbar := TNewButton.Create(WizardForm);
  btnProbar.Parent := PageInstancia.Surface;
  btnProbar.Caption := 'Probar conexion';
  btnProbar.Width := ScaleX(120);
  btnProbar.Height := ScaleY(23);
  btnProbar.Top := cboInstancia.Top + cboInstancia.Height + ScaleY(12);
  btnProbar.Left := 0;
  btnProbar.OnClick := @BtnProbarClick;

  lblEstado := TNewStaticText.Create(WizardForm);
  lblEstado.Parent := PageInstancia.Surface;
  lblEstado.Left := 0;
  lblEstado.Top := btnProbar.Top + btnProbar.Height + ScaleY(12);
  lblEstado.AutoSize := False;
  lblEstado.Width := PageInstancia.SurfaceWidth;
  lblEstado.Height := ScaleY(40);
  lblEstado.Caption := 'Opcional: proba la conexion antes de seguir.';
end;

function NextButtonClick(CurPageID: Integer): Boolean;
var
  inst: String;
  estado: Integer;
begin
  Result := True;
  if (CurPageID = PageTipo.ID) and EsRestaurar then
  begin
    if (Trim(txtBak.Text) = '') or (not FileExists(Trim(txtBak.Text))) then
    begin
      MsgBox('Elegi el archivo .bak que queres restaurar (boton Examinar).', mbError, MB_OK);
      Result := False;
      exit;
    end;
    Result := (MsgBox('Restaurar reemplaza TODA la base actual por la copia:' + #13#10 +
                      '    ' + Trim(txtBak.Text) + #13#10#13#10 +
                      'Lo que se haya cargado despues de esa copia se pierde. Seguimos?',
                      mbConfirmation, MB_YESNO) = IDYES);
    exit;
  end;
  if CurPageID = PageInstancia.ID then
  begin
    inst := InstanciaElegida('');
    estado := ProbarConexion(inst);

    if estado = 1 then
    begin
      Result := (MsgBox('No pude conectarme a la instancia:' + #13#10 + '    ' + inst + #13#10#13#10 +
                        'Puede ser que SQL Server no este corriendo, que el nombre sea otro, ' +
                        'o que tu usuario de Windows no tenga permiso.' + #13#10#13#10 +
                        'Queres continuar igual? (vas a poder correr el script de base a mano despues)',
                        mbConfirmation, MB_YESNO) = IDYES);
    end
    else if estado = 2 then
    begin
      MsgBox('No encontre "sqlcmd" en esta maquina, asi que no puedo verificar la conexion ' +
             'ni crear la base automaticamente.' + #13#10#13#10 +
             'La app se va a instalar igual. Para crear la base, corre a mano:' + #13#10 +
             '    {app}\Database\Deploy_IngSoftware.sql' + #13#10 +
             'desde SSMS (Ctrl+A -> F5) sobre tu instancia.',
             mbInformation, MB_OK);
    end;
  end;
end;

{ Reescribe SOLO el Data Source del .exe.config con la instancia elegida.
  Usa PowerShell + [xml] para no romper el resto de la cadena. }
procedure ReescribirConfig(const Instancia: String);
var
  cfg, ps1, script: String;
  rc: Integer;
begin
  cfg := ExpandConstant('{app}\{#AppExe}.config');
  ps1 := ExpandConstant('{tmp}\fix_config.ps1');

  { escribimos el .ps1 a un archivo para evitar lios de comillas al pasarlo por linea de comando.
    Reemplaza "Data Source=...;" (hasta el primer ;) por la instancia nueva. }
  script :=
    '$ErrorActionPreference = "Stop"' + #13#10 +
    '$p = ' + '''' + cfg + '''' + #13#10 +
    '$inst = ' + '''' + Instancia + '''' + #13#10 +
    '[xml]$x = Get-Content -LiteralPath $p -Encoding UTF8' + #13#10 +
    '$n = $x.configuration.connectionStrings.add | Where-Object { $_.name -eq ' + '''' + 'Ing.Software' + '''' + ' }' + #13#10 +
    'if ($n -ne $null) {' + #13#10 +
    '  $n.connectionString = ($n.connectionString -replace ' + '''' + 'Data Source=[^;]*' + '''' + ', ("Data Source=" + $inst))' + #13#10 +
    '  $x.Save($p)' + #13#10 +
    '}' + #13#10;

  if not SaveStringToFile(ps1, script, False) then
    exit;

  Exec(ExpandConstant('{cmd}'),
       '/C powershell -NoProfile -ExecutionPolicy Bypass -File "' + ps1 + '"',
       '', SW_HIDE, ewWaitUntilTerminated, rc);
end;

{ Copia de seguridad de la base antes de actualizar (solo en "Actualizar").
  Queda en {#CarpetaBackup}, la misma carpeta que usa la app, asi se puede
  restaurar despues desde Admin > Restore o desde este mismo instalador. }
procedure HacerBackup(const Instancia: String);
var
  rc: Integer;
  q, archivo: String;
begin
  ForceDirectories('{#CarpetaBackup}');
  archivo := '{#CarpetaBackup}\Ing.Software_antes_v{#AppVersion}_' + GetDateTimeString('yyyymmdd_hhnnss', #0, #0) + '.bak';
  q := 'IF DB_ID(N' + Chr(39) + 'Ing.Software' + Chr(39) + ') IS NOT NULL BACKUP DATABASE [Ing.Software] TO DISK = N' + Chr(39) + archivo + Chr(39) + ' WITH INIT';
  if Exec(ExpandConstant('{cmd}'),
       '/C sqlcmd -S "' + Instancia + '" -E -b -Q "' + q + '"',
       '', SW_HIDE, ewWaitUntilTerminated, rc) then
  begin
    if rc = 0 then
      MsgBox('Copia de seguridad hecha:' + #13#10 + '    ' + archivo, mbInformation, MB_OK)
    else
      MsgBox('No pude hacer la copia de seguridad (codigo ' + IntToStr(rc) + ').' + #13#10 +
             'Sigo igual: la actualizacion solo agrega lo que falta, no borra datos.', mbInformation, MB_OK);
  end;
end;

{ Restaura la base desde el .bak elegido. Si el archivo no esta en la carpeta de backups
  lo copio ahi primero: SQL Server lee el archivo con su propia cuenta de servicio y esa
  carpeta ya sabemos que la puede usar (la app hace sus backups ahi).
  Devuelve True si salio bien. }
function RestaurarBase(const Instancia, Origen: String): Boolean;
var
  rc: Integer;
  bak, sql, log, script: String;
begin
  Result := False;
  ForceDirectories('{#CarpetaBackup}');
  bak := Origen;
  if CompareText(ExtractFileDir(Origen), '{#CarpetaBackup}') <> 0 then
  begin
    bak := '{#CarpetaBackup}\' + ExtractFileName(Origen);
    if not CopyFile(Origen, bak, False) then
    begin
      MsgBox('No pude copiar el .bak a {#CarpetaBackup}.', mbError, MB_OK);
      exit;
    end;
  end;

  { el script va a un archivo pa no pelear con las comillas en la linea de comando.
    Si el RESTORE falla, la base vuelve a MULTI_USER igual (no queda bloqueada). }
  sql := ExpandConstant('{tmp}\restore_cinesur.sql');
  log := ExpandConstant('{app}\Database\restore_log.txt');
  script :=
    'USE [master];' + #13#10 +
    'SET NOCOUNT ON;' + #13#10 +
    'IF DB_ID(N''Ing.Software'') IS NOT NULL' + #13#10 +
    '    ALTER DATABASE [Ing.Software] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;' + #13#10 +
    'BEGIN TRY' + #13#10 +
    '    RESTORE DATABASE [Ing.Software] FROM DISK = N''' + bak + ''' WITH REPLACE;' + #13#10 +
    'END TRY' + #13#10 +
    'BEGIN CATCH' + #13#10 +
    '    IF DB_ID(N''Ing.Software'') IS NOT NULL ALTER DATABASE [Ing.Software] SET MULTI_USER;' + #13#10 +
    '    THROW;' + #13#10 +
    'END CATCH' + #13#10 +
    'ALTER DATABASE [Ing.Software] SET MULTI_USER;' + #13#10 +
    'PRINT ''RESTORE_OK'';' + #13#10;
  if not SaveStringToFile(sql, script, False) then
    exit;

  if not Exec(ExpandConstant('{cmd}'),
       '/C sqlcmd -S "' + Instancia + '" -E -b -i "' + sql + '" -o "' + log + '"',
       '', SW_HIDE, ewWaitUntilTerminated, rc) then
    exit;

  if rc = 0 then
  begin
    Result := True;
    MsgBox('Base restaurada desde:' + #13#10 + '    ' + bak + #13#10#13#10 +
           'Ahora se actualiza a la version {#AppVersion} sin tocar esos datos.', mbInformation, MB_OK);
  end
  else
    MsgBox('No se pudo restaurar (codigo ' + IntToStr(rc) + '). La base quedo como estaba.' + #13#10 +
           'Detalle en:' + #13#10 + '    ' + log, mbError, MB_OK);
end;

{ Corre el script de deploy con sqlcmd. Devuelve 0 si salio bien. }
{ Saca del log las primeras lineas de error de SQL Server (en ingles "Msg ...",
  en castellano "Mens. ...") con la linea que sigue, pa mostrarlas en el cartel.
  Asi el que instala ve el error sin tener que buscar el archivo. }
function ErroresDelLog(const Log: String): String;
var
  lineas: TArrayOfString;
  i, encontrados: Integer;
begin
  Result := '';
  encontrados := 0;
  if not LoadStringsFromFile(Log, lineas) then
    exit;
  for i := 0 to GetArrayLength(lineas) - 1 do
  begin
    if (Pos('Msg ', lineas[i]) = 1) or (Pos('Mens', lineas[i]) = 1) or (Pos('Sqlcmd: Error', lineas[i]) = 1) then
    begin
      Result := Result + Trim(lineas[i]) + #13#10;
      if i + 1 < GetArrayLength(lineas) then
        Result := Result + '    ' + Trim(lineas[i + 1]) + #13#10;
      encontrados := encontrados + 1;
      if encontrados >= 3 then
        break;
    end;
  end;
end;

procedure CorrerDeploy(const Instancia: String);
var
  sql, log: String;
  rc: Integer;
begin
  sql := ExpandConstant('{app}\Database\Deploy_IngSoftware.sql');
  log := ExpandConstant('{app}\Database\deploy_log.txt');

  { si es una actualizacion y pidio backup, lo hago antes de tocar la base }
  if (rbReinstalar <> nil) and rbReinstalar.Checked and (chkBackup <> nil) and chkBackup.Checked then
    HacerBackup(Instancia);

  if not Exec(ExpandConstant('{cmd}'),
       '/C sqlcmd -S "' + Instancia + '" -E -b -f 65001 -i "' + sql + '" -o "' + log + '"',
       '', SW_HIDE, ewWaitUntilTerminated, rc) then
  begin
    MsgBox('No pude ejecutar sqlcmd para crear la base.' + #13#10 +
           'Corre a mano ' + sql + ' desde SSMS.',
           mbInformation, MB_OK);
    exit;
  end;

  if rc = 9009 then
  begin
    MsgBox('No encontre "sqlcmd" en esta maquina.' + #13#10 +
           'La app quedo instalada. Para crear la base, corre a mano:' + #13#10 +
           '    ' + sql + #13#10 +
           'desde SSMS (Ctrl+A -> F5).',
           mbInformation, MB_OK);
    exit;
  end;

  { sqlcmd con -b devuelve 0 si corrio sin errores. El script es idempotente:
    crea lo que falta y no toca lo que ya hay. Si devuelve otra cosa, algo fallo
    y el detalle queda en el log. (No leo el log: me alcanza el codigo de salida.) }
  if rc = 0 then
    MsgBox('Base de datos lista.' + #13#10 +
           'Se creo lo que faltaba sin tocar los datos existentes.', mbInformation, MB_OK)
  else
    MsgBox('El script de base termino con errores (codigo ' + IntToStr(rc) + ').' + #13#10#13#10 +
           ErroresDelLog(log) + #13#10 +
           'Detalle completo en:' + #13#10 +
           '    ' + log,
           mbError, MB_OK);
end;

procedure CurStepChanged(CurStep: TSetupStep);
var
  inst: String;
begin
  if CurStep = ssPostInstall then
  begin
    inst := InstanciaElegida('');
    ReescribirConfig(inst);   { 1) dejar la cadena apuntando a la instancia elegida }
    if EsRestaurar then       { 2) si eligio Restaurar, primero vuelvo la base al .bak }
      RestaurarBase(inst, Trim(txtBak.Text));
    CorrerDeploy(inst);       { 3) crear la base o completarle lo que le falte (migraciones) }
  end;
end;

// ============================================================================
//  Nota de desinstalacion:
//  Inno borra SOLO lo que instalo ({app} y accseos directos). La BASE DE DATOS
//  en SQL Server NO se toca: no hay nniguna seccion [UninstallRun] que la borre.
//  Las carpetas Entradas\ y Reportes\ se marcan uninsneveruninstall por si
//  guardas comprobantes generados.
// ============================================================================
