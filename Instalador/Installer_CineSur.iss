; ============================================================================
;  INSTALADOR CineSur  -  Inno Setup 6  (ISCC.exe)
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
#define AppVersion      "1.0.0"
#define AppPublisher    "CineSur"
#define AppExe          "Proyecto IngSoftware.exe"

; Carpeta con el BUILD (donde etsa el .exe + dlls). Normalmente bin\Release;
; si compilas en Debug, apunta a bin\Debug.
#define SourceBin       "..\Proyecto IngSoftware\bin\Release"

; Script SQL de deploy (el que esta en esta misma carpeta, en Database\).
#define DeploySql       "Database\Deploy_IngSoftware.sql"

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
Source: "{#SourceBin}\Idiomas\*";            DestDir: "{app}\Idiomas";  Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SourceBin}\Posters\*";            DestDir: "{app}\Posters";  Flags: ignoreversion recursesubdirs createallsubdirs skipifsourcedoesntexist
; --- Script de base de datos ---
Source: "{#DeploySql}";                      DestDir: "{app}\Database"; Flags: ignoreversion

[Dirs]
; carpetas que la app escribe en runtime (entradas/reportes generados)
Name: "{app}\Entradas"; Flags: uninsneveruninstall
Name: "{app}\Reportes"; Flags: uninsneveruninstall

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
  rbInstalar, rbReinstalar: TNewRadioButton;
  chkBackup: TNewCheckBox;
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
  rbInstalar.Caption := 'Instalar (desde cero): crea la base si no existe; si ya esta, no la toca.';

  rbReinstalar := TNewRadioButton.Create(WizardForm);
  rbReinstalar.Parent := PageTipo.Surface;
  rbReinstalar.Left := 0;
  rbReinstalar.Top := rbInstalar.Top + ScaleY(34);
  rbReinstalar.Width := PageTipo.SurfaceWidth;
  rbReinstalar.Caption := 'Reinstalar (actualizar): agrega lo que falte sin perder los datos que ya tenes.';

  chkBackup := TNewCheckBox.Create(WizardForm);
  chkBackup.Parent := PageTipo.Surface;
  chkBackup.Left := ScaleX(18);
  chkBackup.Top := rbReinstalar.Top + ScaleY(26);
  chkBackup.Width := PageTipo.SurfaceWidth - ScaleX(18);
  chkBackup.Caption := 'Hacer una copia de seguridad de la base antes de actualizar (recomendado)';
  chkBackup.Checked := True;

  lblPrevia := TNewStaticText.Create(WizardForm);
  lblPrevia.Parent := PageTipo.Surface;
  lblPrevia.Left := 0;
  lblPrevia.Top := chkBackup.Top + ScaleY(34);
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
    chkBackup.Enabled := False;
    chkBackup.Checked := False;
    lblPrevia.Caption := 'No se encontro una instalacion anterior en este equipo: solo se puede Instalar.';
  end;

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

{ Copia de seguridad de la base antes de actualizar (solo al reinstalar).
  El .bak queda en la carpeta de backups de SQL Server (el servicio siempre
  puede escribir ahi). }
procedure HacerBackup(const Instancia: String);
var
  rc: Integer;
  q, archivo: String;
begin
  archivo := 'Ing.Software_backup_' + GetDateTimeString('yyyymmdd_hhnnss', #0, #0) + '.bak';
  q := 'BACKUP DATABASE [Ing.Software] TO DISK = N' + Chr(39) + archivo + Chr(39) + ' WITH INIT';
  if Exec(ExpandConstant('{cmd}'),
       '/C sqlcmd -S "' + Instancia + '" -E -b -Q "' + q + '"',
       '', SW_HIDE, ewWaitUntilTerminated, rc) then
  begin
    if rc = 0 then
      MsgBox('Copia de seguridad hecha: ' + archivo + #13#10 +
             '(quedo en la carpeta de backups de SQL Server).', mbInformation, MB_OK)
    else
      MsgBox('No pude hacer la copia de seguridad (codigo ' + IntToStr(rc) + ').' + #13#10 +
             'Sigo igual: el script solo agrega lo que falta, no borra datos.', mbInformation, MB_OK);
  end;
end;

{ Corre el script de deploy con sqlcmd. Devuelve 0 si salio bien. }
procedure CorrerDeploy(const Instancia: String);
var
  sql, log: String;
  rc: Integer;
begin
  sql := ExpandConstant('{app}\Database\Deploy_IngSoftware.sql');
  log := ExpandConstant('{app}\Database\deploy_log.txt');

  { si es una reinstalacion y pidio backup, lo hago antes de tocar la base }
  if (rbReinstalar <> nil) and rbReinstalar.Checked and (chkBackup <> nil) and chkBackup.Checked then
    HacerBackup(Instancia);

  if not Exec(ExpandConstant('{cmd}'),
       '/C sqlcmd -S "' + Instancia + '" -E -b -f 65001 -i "' + sql + '" -o "' + log + '"',
       '', SW_HIDE, ewWaitUntilTerminated, rc) then
  begin
    MsgBox('No pude ejecutar sqlcmd para crear la base.' + #13#10 +
           'Corre a mano {app}\Database\Deploy_IngSoftware.sql desde SSMS.',
           mbInformation, MB_OK);
    exit;
  end;

  if rc = 9009 then
  begin
    MsgBox('No encontre "sqlcmd" en esta maquina.' + #13#10 +
           'La app quedo instalada. Para crear la base, corre a mano:' + #13#10 +
           '    {app}\Database\Deploy_IngSoftware.sql' + #13#10 +
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
    MsgBox('El script de base termino con errores (codigo ' + IntToStr(rc) + ').' + #13#10 +
           'Revisa el detalle en:' + #13#10 +
           '    {app}\Database\deploy_log.txt',
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
    CorrerDeploy(inst);       { 2) crear/omitir la base }
  end;
end;

// ============================================================================
//  Nota de desinstalacion:
//  Inno borra SOLO lo que instalo ({app} y accseos directos). La BASE DE DATOS
//  en SQL Server NO se toca: no hay nniguna seccion [UninstallRun] que la borre.
//  Las carpetas Entradas\ y Reportes\ se marcan uninsneveruninstall por si
//  guardas comprobantes generados.
// ============================================================================
