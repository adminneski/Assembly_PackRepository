unit Frm_Main;

interface

uses
  Winapi.Windows, Winapi.Messages,System.StrUtils, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ComCtrls, Vcl.FileCtrl,shellAPI, Vcl.ExtCtrls,  Vcl.Menus,
  Vcl.Imaging.pngimage, Vcl.Mask, Gobt_DBComboEdit, Gobt_ButtonAdvanced,
  Gobt_StatusBarPro;

type
  TFrmMAIN = class(TForm)
    pnTitulo: TPanel;
    PopupMenu1: TPopupMenu;
    Editar1: TMenuItem;
    Image1: TImage;
    Panel1: TPanel;
    edtSQL_InstanceName: TLabeledEdit;
    edtSQL_Password: TLabeledEdit;
    OpenDialog: TOpenDialog;
    Label1: TLabel;
    mVisualizaParametros: TMemo;
    Label2: TLabel;
    mParametros: TMemo;
    Panel2: TPanel;
    pnPlataformaWindows: TPanel;
    pnNomeComputador: TPanel;
    Panel3: TPanel;
    btnSQL_Install: TGoButtonAdvanced;
    Panel4: TPanel;
    edtSQLPathExecutavel: TEdit;
    GoButtonAdvanced1: TGoButtonAdvanced;
    procedure FormCreate(Sender: TObject);
    procedure Editar1Click(Sender: TObject);
    procedure btnSQL_InstallClick(Sender: TObject);
    procedure edtSQL_InstanceNameChange(Sender: TObject);
    procedure edtSQL_PasswordChange(Sender: TObject);
    procedure edtSQL_PathExecutavelButtonClick(Sender: TObject);
    procedure GoButtonAdvanced1Click(Sender: TObject);
  private
    function Is64Bits: Boolean;
    procedure ExecAndWait(pAplication: String);
    procedure ExecBatchAndWait(TextoBat: String);
    function funGetNameComputer: string;
    function funBuscaTroca(Text, Busca, Troca: string): string;

    { Private declarations }
  public
    { Public declarations }
    procedure AtualizaParametros;
    procedure MinimizaProgramas;

  end;

var
  FrmMAIN: TFrmMAIN;
  DiretorioApp : String;
  //VARIAVES GLOBAIS
  lStartUpInfo: TStartUpInfo;
  lProcesso: TProcessInformation;


implementation

{$R *.dfm}




procedure TFrmMAIN.FormCreate(Sender: TObject);
begin
  // Path Normal
  DiretorioApp := ExtractFileDir(ParamStr(0));

  ForceDirectories('C:\NeskiApps\NeskiDatabases');
  ForceDirectories('C:\NeskiApps\NeskiBackups');



  //Path Curto
 // DiretorioApp := ExtractFileDir(ExtractShortPathName(ParamStr(0)));

//  rkPaginas.ActiveTab := 0;
//  tab1P_Windows_Installer.Show;
//
//
  if Is64bits then
  Begin
    pnNomeComputador.Caption := ' Nome do Computador : '+funGetNameComputer;
    pnPlataformaWindows.Caption := 'Plataforma Windows : 64 bits';

  end
  else
  begin
    pnNomeComputador.Caption := ' Nome do Computador : '+funGetNameComputer;
    pnPlataformaWindows.Caption  := 'Plataforma Windows : 32 bits';
  end;
  //
  AtualizaParametros;
  //
  edtSQLPathExecutavel.TextHint := 'C:\SQLServer\SQLServer2019ExpressCore_x64_ENU.exe';

end;

function TFrmMAIN.Is64Bits: Boolean;
const
  PROCESSOR_ARCHITECTURE_INTEL = $0000;
  PROCESSOR_ARCHITECTURE_IA64 = $0006;
  PROCESSOR_ARCHITECTURE_AMD64 = $0009;
  PROCESSOR_ARCHITECTURE_UNKNOWN = $FFFF;
var
  xSysInfo: TSystemInfo;
begin
  GetNativeSystemInfo(xSysInfo);
  case xSysInfo.wProcessorArchitecture of
    PROCESSOR_ARCHITECTURE_AMD64, PROCESSOR_ARCHITECTURE_IA64:
      Result := True;
  else
    Result := False;
  end;
end;



procedure TFrmMAIN.AtualizaParametros;
begin
  mParametros.Clear;
  mParametros.ReadOnly := true;
  with mParametros.Lines do
  begin
    Add('/UIMODE=AutoAdvance');
    Add('/ACTION=INSTALL');
    Add('/INSTANCEID="'+edtSQL_InstanceName.Text+'"');
    Add('/INSTANCENAME="'+edtSQL_InstanceName.Text+'"');
    Add('/HELP="False"');
    Add('/UPDATEENABLED="False"');
    Add('/INDICATEPROGRESS="True"');
    Add('/ISSVCACCOUNT="NT AUTHORITY\NetworkService"');
    Add('/ISSVCSTARTUPTYPE="Automatic"');
    Add('/ASSVCSTARTUPTYPE="Automatic"');
    Add('/SAPWD="'+edtSQL_Password.Text+'"');
    Add('/SQLCOLLATION="SQL_Latin1_General_CP1_CI_AI"');
    Add('/SQLSVCACCOUNT="NT AUTHORITY\NetworkService"');
    Add('/SECURITYMODE="SQL"');
    Add('/SQLBACKUPDIR="C:\NeskiApps\NeskiBackups"');
    Add('/SQLUSERDBDIR="C:\NeskiApps\NeskiDatabases"');
    Add('/SQLUSERDBLOGDIR="C:\NeskiApps\NeskiDatabases"');
    Add('/SQLSYSADMINACCOUNTS="BUILTIN\Administradores"');
    Add('/TCPENABLED="1"');
    Add('/NPENABLED="0"');
  end;
  //Parametros para serem visualizados  ( Esconder a Senha )
  mVisualizaParametros.Clear;
  mVisualizaParametros.ReadOnly := true;
  with mVisualizaParametros.Lines do
  begin
    Add('/UIMODE=AutoAdvance');
    Add('/ACTION=INSTALL');
    Add('/INSTANCEID="'+edtSQL_InstanceName.Text+'"');
    Add('/INSTANCENAME="'+edtSQL_InstanceName.Text+'"');
    Add('/HELP="False"');
    Add('/UPDATEENABLED="False"');
    Add('/INDICATEPROGRESS="True"');
    Add('/ISSVCACCOUNT="NT AUTHORITY\NetworkService"');
    Add('/ISSVCSTARTUPTYPE="Automatic"');
    Add('/ASSVCSTARTUPTYPE="Automatic"');
    Add('/SAPWD="'+DupeString('*',Length(edtSQL_Password.Text))+'"');
    Add('/SQLCOLLATION="SQL_Latin1_General_CP1_CI_AI"');
    Add('/SQLSVCACCOUNT="NT AUTHORITY\NetworkService"');
    Add('/SECURITYMODE="SQL"');
    Add('/SQLBACKUPDIR="C:\NeskiApps\NeskiBackups"');
    Add('/SQLUSERDBDIR="C:\NeskiApps\NeskiDatabases"');
    Add('/SQLUSERDBLOGDIR="C:\NeskiApps\NeskiDatabases"');
    Add('/SQLSYSADMINACCOUNTS="BUILTIN\Administradores"');
    Add('/TCPENABLED="1"');
    Add('/NPENABLED="0"');
  end;
end;


procedure TFrmMAIN.Editar1Click(Sender: TObject);
begin
   mParametros.ReadOnly := false;
end;

procedure TFrmMAIN.edtSQL_InstanceNameChange(Sender: TObject);
begin
  AtualizaParametros;
end;

procedure TFrmMAIN.edtSQL_PasswordChange(Sender: TObject);
begin
  AtualizaParametros;
end;

procedure TFrmMAIN.edtSQL_PathExecutavelButtonClick(Sender: TObject);
begin
  if OpenDialog.Execute then
  begin
    edtSQLPathExecutavel.Text := OpenDialog.FileName;
  end;
end;

Procedure TFrmMAIN.ExecAndWait(pAplication: String);
var
  lExitCode: dword;
  DirCorrente : String;
  Count : Integer;
begin
  // Inicializa a estrutura TStartUpInfo indicando formato de abertura da janela
  // e setando os atributos obrigatórios de serem inicializados.
  With lStartUpInfo do
  begin
    cb := 2048;
    lpReserved := NIL;
    lpDesktop := NIL;
    lpTitle := NIL;
    dwFlags := STARTF_USESHOWWINDOW;
    wShowWindow := SW_HIDE; // SW_Hide; //para não aparecer na tela!
    cbReserved2 := 0;
    lpReserved2 := NIL;
  end;
  // Cria o processo notepad.exe e passa por parâmetro o arquivo a ser aberto.
  // Passa também as estruturas de controle, lStartUpInfo e lProcesso.
  DirCorrente := ExtractFileDir(pAplication);
  if not CreateProcess(NIL, PChar(pAplication), NIL, NIL, false, CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, NIL, PChar(DirCorrente), lStartUpInfo, lProcesso) then
    ShowMessage('Erro para executar CreateProcess')
  else
  begin
    GetExitCodeProcess(lProcesso.hProcess, lExitCode);
    while (lExitCode = STILL_ACTIVE) do
    begin
       Inc(Count,1);
       if Count = 1000000 then
       begin
         Count := 0;
       end;
       GetExitCodeProcess(lProcesso.hProcess, lExitCode);
    end;
  end;
end;

procedure TFrmMAIN.ExecBatchAndWait(TextoBat:String);
var
  Batch: TStringList;
begin
  try
    Batch := TStringList.Create;
    Batch.Add(TextoBat);
    Batch.SaveToFile(ExtractFilePath(ParamStr(0))+'ExecBat.bat');
    FreeAndNil(Batch);
    //
    ExecAndWait(ExtractFilePath(ParamStr(0))+'ExecBat.bat');
  except
   on EXC: Exception do
   begin
     ShowMessage('ERROR : '+EXC.Message);
   end;
  end;
  DeleteFile(ExtractFilePath(ParamStr(0))+'ExecBat.bat');
end;

function TFrmMAIN.funGetNameComputer : string;
  var
  lpBuffer : Array[0..20] of Char;
  nSize : dWord;
  mRet : boolean;
  erro: dWord;
begin
   nSize :=120;
   mRet:= GetComputerName(lpBuffer,nSize);
   if mRet then
     Result:= lpBuffer
   else
   begin
     erro:= GetLastError();
     MessageDlg('Ocorreu o erro ' + IntToStr(erro) + ' ao procurar o nome do computador.',
                mtError, [mbOk], 0);
     Result:= '';
   end;
end;



procedure TFrmMAIN.GoButtonAdvanced1Click(Sender: TObject);
begin
  if OpenDialog.Execute then
  begin
    edtSQLPathExecutavel.Text := OpenDialog.FileName;
    if FileExists(edtSQLPathExecutavel.Text) then
    begin
      edtSQLPathExecutavel.Enabled := false;
      btnSQL_Install.Enabled := true;
    end;
  end;
end;

procedure TFrmMAIN.btnSQL_InstallClick(Sender: TObject);
var
  Parametros : string;
begin
  if  Length(edtSQLPathExecutavel.Text) > 0 then
  begin
   MinimizaProgramas;
   Parametros := funBuscaTroca(mParametros.Text,#13+#10,#32);
   ExecBatchAndWait('Start '+ExtractShortPathName(edtSQLPathExecutavel.Text)+' '+Parametros);
   edtSQLPathExecutavel.Text := '';
  end;
end;

function TFrmMAIN.funBuscaTroca(Text, Busca, Troca: string): string;
var
   axN: Integer;
begin
   for axN := 1 to Length(Text) do
   begin
      if Copy(Text, axN, Length(Busca)) = Busca then
      begin
         Delete(Text, axN, Length(Busca));
         Insert(Troca, Text, axN);
      end;
   end;
   Result := Text;
end;


{######################################
Essa função simula o precionamento das Teclas WIN + M .
Que são as teclas de atalho para minimizar os programas no windows.

Com essa mesma idéia você pode simular várias outras cominações de teclas

WIN + F : Abre a localização de arquivos
WIN + R : Abre o executar
WIN + D: Igual ao minimizar programas (Mostra o desktop)
}
Procedure TFrmMAIN.MinimizaProgramas;
Begin
  keybd_event(VK_LWIN, 0, 0, 0);
  keybd_event(Ord('M'), 0, 0, 0);
  keybd_event(VK_LWIN, 0, KEYEVENTF_KEYUP, 0);
end;

end.



