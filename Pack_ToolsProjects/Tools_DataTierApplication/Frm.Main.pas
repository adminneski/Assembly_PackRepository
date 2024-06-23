unit Frm.Main;

interface
{
  //Caminho SQLPackage.exe
  C:\Program Files\Microsoft SQL Server\150\DAC\bin



  Link e Instalacao Independente
  https://docs.microsoft.com/pt-br/sql/tools/sqlpackage-download?view=sql-server-ver15

  Link dos Comandos
  https://docs.microsoft.com/pt-br/sql/tools/sqlpackage?view=sql-server-ver15


}


uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Mask, Vcl.StdCtrls,
  Vcl.ExtCtrls, ShellApi,TLHelp32,RzTabs,
  Vcl.Imaging.pngimage, Gobt_ButtonAdvanced, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, Vcl.ComCtrls, Vcl.Menus,IOUtils,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Phys.MSSQLDef, FireDAC.Phys.ODBCBase,
  FireDAC.Phys.MSSQL, SynEditHighlighter, SynHighlighterSQL, SynEdit,
  FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util,
  FireDAC.VCLUI.Script, FireDAC.Comp.UI, FireDAC.Comp.Script, GOX.PowerShell, GOX.SQLPackage, SynHighlighterXML, Winapi.WebView2, Winapi.ActiveX,
  Vcl.Edge, Dlg.ShowXML, System.IniFiles, Dlg.ShowCMD;

type
  TFrmMain = class(TForm)
    dlgSave: TSaveDialog;
    FDConn_Source: TFDConnection;
    FDConn_Target: TFDConnection;
    QSource: TFDQuery;
    QTarget: TFDQuery;
    FDPhysMSSQLDriverLink: TFDPhysMSSQLDriverLink;
    pnCONEXOES_FUNDO: TPanel;
    Panel1: TPanel;
    pnSource: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lblSource_Database: TLabel;
    Label5: TLabel;
    edtSource_Host: TComboBox;
    edtSource_Database: TComboBox;
    edtSource_User: TEdit;
    edtSource_Password: TMaskEdit;
    btnSourceConnectionTest: TGoButtonAdvanced;
    pnSourceOptions: TPanel;
    btnSource_Extract: TGoButtonAdvanced;
    pnTarget: TPanel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    lblTarget_Database: TLabel;
    edtTarget_Host: TComboBox;
    edtTarget_Database: TComboBox;
    edtTarget_User: TEdit;
    edtTarget_Password: TMaskEdit;
    btnTargetConnectionTest: TGoButtonAdvanced;
    pnTargetOptions: TPanel;
    pnCompareButton: TPanel;
    dlgOpen: TSaveDialog;
    btnSource_Export: TGoButtonAdvanced;
    btnTarget_Publish: TGoButtonAdvanced;
    btnSource_Import: TGoButtonAdvanced;
    Panel2: TPanel;
    pnXML: TPanel;
    Panel4: TPanel;
    btnComparer: TGoButtonAdvanced;
    btnSynchronize: TGoButtonAdvanced;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Panel3: TPanel;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSource_ExtractClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnSourceConnectionTestClick(Sender: TObject);
    procedure PraButtonStyle1Click(Sender: TObject);
    procedure FDGUIxScriptDialog1Output(ASender: TObject; const AStr: string);
    procedure btnSource_ExportClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnTargetConnectionTestClick(Sender: TObject);
    procedure btnTarget_PublishClick(Sender: TObject);
    procedure btnComparerClick(Sender: TObject);
    procedure edtSource_DatabaseChange(Sender: TObject);
    procedure edtTarget_DatabaseChange(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure btnSynchronizeClick(Sender: TObject);
    procedure btnSource_ImportClick(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
  private
    { Private declarations }
    FPathIniFile : String;
    FDlgCMD : TDlgShowCMD;
    procedure LoadsHostSQL;
    procedure TestSourceConnection;
    procedure TestTargetConnection;
    function IsFileInUse(FileName: TFileName): Boolean;
    procedure LoadINI;
    procedure SaveINI;
  public
    { Public declarations }
    FSQLPackage : TGOXSQLPackage;
  end;

var
  FrmMain: TFrmMain;

implementation


{$R *.dfm}

procedure TFrmMain.Image1Click(Sender: TObject);
begin
  var LDlgXML := TDlgShowXML.Create(Self);
  LDlgXML.ReportFileName := 'DeployReport.xml';
  LDlgXML.ShowModal;
  FreeAndNil(LDlgXML);
end;

procedure TFrmMain.Image2Click(Sender: TObject);
begin
  var LDlgXML := TDlgShowXML.Create(Self);
  LDlgXML.ReportFileName := 'PublishReport.xml';
  LDlgXML.ShowModal;
  FreeAndNil(LDlgXML);
end;

procedure TFrmMain.Image3Click(Sender: TObject);
begin
  DlgShowCMD.ShowModal;
end;

function TFrmMain.IsFileInUse(FileName: TFileName): Boolean;
var
HFileRes: HFILE;
begin
  Result := False;
  if not FileExists(FileName) then Exit;
  HFileRes := CreateFile(PChar(FileName),
  GENERIC_READ or GENERIC_WRITE,
  0,
  nil,
  OPEN_EXISTING,
  FILE_ATTRIBUTE_NORMAL,
  0);
  Result := (HFileRes = INVALID_HANDLE_VALUE);
  if not Result then
  CloseHandle(HFileRes);
end;

procedure TFrmMain.FDGUIxScriptDialog1Output(ASender: TObject;
  const AStr: string);
begin
  //Memo1.Text := AStr;
end;

procedure TFrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  SaveINI;

end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  FSQLPackage := TGOXSQLPackage.Create;
  FSQLPackage.ShowConsole := true;
  //Path e Nome do Arquivo INI
  FPathIniFile := ChangeFileExt(ExtractFileName(ParamStr(0)),'.ini');
  FDlgCMD := TDlgShowCMD.Create(Self);
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FDlgCMD);
  FreeAndNil(FSQLPackage);
end;

procedure TFrmMain.FormShow(Sender: TObject);
begin
  Self.Width := 500;
  Self.Height:= 800;
  Self.Repaint;
  LoadINI;
  SaveINI;
  //
  if not FileExists(FSQLPackage.SQLPackagePathExeName) then
    pnXML.Caption := 'DacFramework.msi não está Instalado!'
  else
    pnXML.Caption := '';
end;

procedure TFrmMain.btnSynchronizeClick(Sender: TObject);
var
  LDlgXML:TDlgShowXML;
begin
  if Application.MessageBox('Confirm Synchronization?','Warning',MB_YESNO+MB_ICONQUESTION+MB_DEFBUTTON2) = IDYES then
  begin
    if Application.MessageBox('Authorize Synchronization?','Very Attention',MB_YESNO+MB_ICONWARNING+MB_DEFBUTTON2) = IDYES then
    begin
      try
        LDlgXML := TDlgShowXML.Create(Self);
        //
        if edtSource_Database.ItemIndex = -1 then
        begin
          ShowMessage('Favor Selecionar Database Source!');
          Abort;
        end;

        if edtTarget_Database.ItemIndex = -1 then
        begin
          ShowMessage('Favor Selecionar Database Target!');
          Abort;
        end;
        //
        FSQLPackage.SourceEncryptConnection := false;
        FSQLPackage.SourceServerName   := edtSource_Host.Text;
        FSQLPackage.SourceDatabaseName := edtSource_Database.Text;
        FSQLPackage.SourceUser         := edtSource_User.Text;
        FSQLPackage.SourcePassword     := edtSource_Password.Text;
        //
        FSQLPackage.TargetEncryptConnection := false;
        FSQLPackage.TargetServerName   := edtTarget_Host.Text;
        FSQLPackage.TargetDatabaseName := edtTarget_Database.Text;
        FSQLPackage.TargetUser         := edtTarget_User.Text;
        FSQLPackage.TargetPassword     := edtTarget_Password.Text;
        //
        LDlgXML.ReportFileName := FSQLPackage.Synchronize;
        LDlgXML.ShowModal;
      finally
        FreeAndNil(LDlgXML);
        btnSynchronize.Visible := false;
      end;
    end;
  end;
end;

procedure TFrmMain.btnSource_ExportClick(Sender: TObject);
begin
  if edtSource_Database.ItemIndex = -1 then
  begin
    ShowMessage('Favor Selecionar Database Source!');
    Abort;
  end;
  dlgSave.DefaultExt := 'bacpac';
  dlgSave.Filter := 'Data-tier Application package|*.bacpac';
  dlgSave.FileName := edtSource_Database.Text+'_Backup_'+FormatDateTime('DDMMYYYYHHMM',now);
  if dlgSave.Execute then
  begin
    FSQLPackage.SourceEncryptConnection := false;
    FSQLPackage.SourceServerName   := edtSource_Host.Text;
    FSQLPackage.SourceDatabaseName := edtSource_Database.Text;
    FSQLPackage.SourceUser         := edtSource_User.Text;
    FSQLPackage.SourcePassword     := edtSource_Password.Text;
    //
    FSQLPackage.Backup(dlgSave.FileName);
  end;
end;

procedure TFrmMain.btnSource_ExtractClick(Sender: TObject);
begin
  if edtSource_Database.ItemIndex = -1 then
  begin
    ShowMessage('Favor Selecionar Database Source!');
    Abort;
  end;
  dlgSave.DefaultExt := 'dacpac';
  dlgSave.Filter := 'Data-tier Application package|*.dacpac';
  dlgSave.FileName := edtSource_Database.Text+'_Schema_'+FormatDateTime('DDMMYYYYHHMM',now);
  if dlgSave.Execute then
  begin
    FSQLPackage.SourceEncryptConnection := false;
    FSQLPackage.SourceServerName   := edtSource_Host.Text;
    FSQLPackage.SourceDatabaseName := edtSource_Database.Text;
    FSQLPackage.SourceUser         := edtSource_User.Text;
    FSQLPackage.SourcePassword     := edtSource_Password.Text;
    //
    FSQLPackage.Extract(dlgSave.FileName);
  end;
end;

procedure TFrmMain.btnSource_ImportClick(Sender: TObject);
begin
  if edtTarget_Database.ItemIndex = -1 then
  begin
    ShowMessage('Favor Selecionar Database Target!');
    Abort;
  end;
  dlgOpen.DefaultExt := 'bacpac';
  dlgOpen.Filter := 'Data-tier Application package|*.bacpac';
  if dlgOpen.Execute then
  begin
    if Application.MessageBox('Confirm Backup Restore?','Warning',MB_YESNO+MB_ICONQUESTION+MB_DEFBUTTON2) = IDYES then
    begin
      if Application.MessageBox('Authorize Restore Backup?','Very Attention',MB_YESNO+MB_ICONWARNING+MB_DEFBUTTON2) = IDYES then
      begin
        FSQLPackage.TargetEncryptConnection := false;
        FSQLPackage.TargetServerName   := edtTarget_Host.Text;
        FSQLPackage.TargetDatabaseName := edtTarget_Database.Text;
        FSQLPackage.TargetUser         := edtTarget_User.Text;
        FSQLPackage.TargetPassword     := edtTarget_Password.Text;
        //
        FSQLPackage.Restore(dlgOpen.FileName);
      end;
    end;
  end;
end;

procedure TFrmMain.btnTargetConnectionTestClick(Sender: TObject);
begin
  SaveINI;
  TestTargetConnection;
end;

procedure TFrmMain.btnTarget_PublishClick(Sender: TObject);
begin
  try
    if edtTarget_Database.ItemIndex = -1 then
    begin
      ShowMessage('Favor Selecionar Database Target!');
      edtTarget_Database.SetFocus;
      Abort;
    end;
    dlgOpen.DefaultExt := 'dacpac';
    dlgOpen.Filter := 'Data-tier Application package|*.dacpac';
    if dlgOpen.Execute then
    begin
      FSQLPackage.TargetEncryptConnection := false;
      FSQLPackage.TargetServerName   := edtTarget_Host.Text;
      FSQLPackage.TargetDatabaseName := edtTarget_Database.Text;
      FSQLPackage.TargetUser         := edtTarget_User.Text;
      FSQLPackage.TargetPassword     := edtTarget_Password.Text;
      //
      FSQLPackage.Publish(dlgOpen.FileName);
    end;
  finally
     var LDlgXML := TDlgShowXML.Create(Self);
     LDlgXML.ShowModal;
     FreeAndNil(LDlgXML);
  end;
end;

procedure TFrmMain.edtSource_DatabaseChange(Sender: TObject);
begin
  SaveINI;
end;

procedure TFrmMain.edtTarget_DatabaseChange(Sender: TObject);
begin
  SaveINI;
end;

procedure TFrmMain.btnComparerClick(Sender: TObject);
var
  LDlgXML:TDlgShowXML;
begin
  try
    LDlgXML := TDlgShowXML.Create(Self);
    //
    if edtSource_Database.ItemIndex = -1 then
    begin
      ShowMessage('Favor Selecionar Database Source!');
      Abort;
    end;

    if edtTarget_Database.ItemIndex = -1 then
    begin
      ShowMessage('Favor Selecionar Database Target!');
      Abort;
    end;
    //
    FSQLPackage.SourceEncryptConnection := false;
    FSQLPackage.SourceServerName   := edtSource_Host.Text;
    FSQLPackage.SourceDatabaseName := edtSource_Database.Text;
    FSQLPackage.SourceUser         := edtSource_User.Text;
    FSQLPackage.SourcePassword     := edtSource_Password.Text;
    //
    FSQLPackage.TargetEncryptConnection := false;
    FSQLPackage.TargetServerName   := edtTarget_Host.Text;
    FSQLPackage.TargetDatabaseName := edtTarget_Database.Text;
    FSQLPackage.TargetUser         := edtTarget_User.Text;
    FSQLPackage.TargetPassword     := edtTarget_Password.Text;
    //
    LDlgXML.ReportFileName := FSQLPackage.Compare;
    LDlgXML.ShowModal;
  finally
    btnSynchronize.Visible := true;
    FreeAndNil(LDlgXML);
  end;
end;

procedure TFrmMain.btnSourceConnectionTestClick(Sender: TObject);
begin
  SaveINI;
  TestSourceConnection;
end;


procedure TFrmMain.SaveINI;
var
  LINIFile: TIniFile;
  LSection : String;
begin
  LSection := 'SQLPACKAGE';
  LINIFile := TIniFile.Create('.\'+FPathIniFile);
  //------------------------------------------
  // Parametros de LEITURA E GRAVACAO  NO INI
  //------------------------------------------
  //Grava
  LINIFile.WriteString(LSection,'Source_Host',edtSource_Host.Text);
  LINIFile.WriteString(LSection,'Source_Database',edtSource_Database.Text);
  LINIFile.WriteString(LSection,'Source_User',edtSource_User.Text);
  LINIFile.WriteString(LSection,'Source_Password',edtSource_Password.Text);
  //
  LINIFile.WriteString(LSection,'Target_Host',edtTarget_Host.Text);
  LINIFile.WriteString(LSection,'Target_Database',edtTarget_Database.Text);
  LINIFile.WriteString(LSection,'Target_User',edtTarget_User.Text);
  LINIFile.WriteString(LSection,'Target_Password',edtTarget_Password.Text);
  //
  LINIFile.Free;
end;

procedure TFrmMain.TestSourceConnection;
var
  SavCursor: TCursor;
begin
  SavCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  //
  try
    if (Length(edtSource_User.Text) = 0)or
     (Length(edtSource_Password.Text) = 0) then
      Exit;

    FDConn_Source.Close;
    FDConn_Source.ConnectionName := 'MSSQLSource';
    FDConn_Source.DriverName := 'MSSQL';
    FDConn_Source.LoginPrompt := false;
    FDConn_Source.Params.Clear;
    FDConn_Source.Params.Add('Server='+Trim(edtSource_Host.Text));
    FDConn_Source.Params.Add('User_Name='+Trim(edtSource_User.Text));
    FDConn_Source.Params.Add('Password='+Trim(edtSource_Password.Text));
    FDConn_Source.Params.Add('Database='+Trim(edtSource_Database.Text));
    FDConn_Source.Params.Add('Protocol=TCPIP');
    FDConn_Source.Params.Add('Port=1433');
    FDConn_Source.Params.Add('LoginTimeout=60');
    FDConn_Source.Params.Add('DriverID=MSSQL');
    FDConn_Source.Connected := true;
    //
    if FDConn_Source.Connected then
    begin
      QSource.SQL.Clear;
      QSource.SQL.Text := 'Select * From sys.databases';
      QSource.Open;
      //
      QSource.First;
      edtSource_Database.Items.clear;
      while not QSource.Eof do
      begin
        edtSource_Database.Items.Add(QSource.FieldByName('name').AsString);
        QSource.Next;
      end;
      ShowMessage('Conectado com Sucesso!');
    end;
  finally
    lblSource_Database.Visible := FDConn_Source.Connected;
    edtSource_Database.Visible := FDConn_Source.Connected;
    pnSourceOptions.Visible    := FDConn_Source.Connected;
    btnComparer.Visible        := FDConn_Source.Connected;
    Screen.Cursor := SavCursor;
  end;
end;

procedure TFrmMain.TestTargetConnection;
var
  SavCursor: TCursor;
begin
  SavCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  //
  try
    if (Length(edtTarget_User.Text) = 0)or
      (Length(edtTarget_Password.Text) = 0) then


    FDConn_Target.Close;
    FDConn_Target.ConnectionName := 'MSSQLTarget';
    FDConn_Target.DriverName := 'MSSQL';
    FDConn_Target.LoginPrompt := false;
    FDConn_Target.Params.Clear;
    FDConn_Target.Params.Add('Server='+Trim(edtTarget_Host.Text));
    FDConn_Target.Params.Add('User_Name='+Trim(edtTarget_User.Text));
    FDConn_Target.Params.Add('Password='+Trim(edtTarget_Password.Text));
    FDConn_Target.Params.Add('Database='+Trim(edtTarget_Database.Text));
    FDConn_Target.Params.Add('Protocol=TCPIP');
    FDConn_Target.Params.Add('Port=1433');
    FDConn_Target.Params.Add('LoginTimeout=60');
    FDConn_Target.Params.Add('DriverID=MSSQL');
    FDConn_Target.Connected := true;
    //
    if FDConn_Target.Connected then
    begin
      //
      if FDConn_Target.Connected then
      begin
        QTarget.SQL.Clear;
        QTarget.SQL.Text := 'Select * From sys.databases';
        QTarget.Open;
      end;
      Sleep(1000);
      //
      QTarget.First;
      edtTarget_Database.Items.clear;
      while not QTarget.Eof do
      begin
        edtTarget_Database.Items.Add(QTarget.FieldByName('name').AsString);
        QTarget.Next;
      end;
      ShowMessage('Conectado com Sucesso!');
    end;
  finally
    lblTarget_Database.Visible := FDConn_Target.Connected;
    edtTarget_Database.Visible := FDConn_Target.Connected;
    pnTargetOptions.Visible    := FDConn_Target.Connected;
    Screen.Cursor := SavCursor;
  end;
end;

procedure TFrmMain.Label4Click(Sender: TObject);
begin
  ShellExecute(Handle, 'Open', 'https://docs.microsoft.com/pt-br/sql/tools/sqlpackage?view=sql-server-ver15', nil, nil, 1);
end;

procedure TFrmMain.LoadINI;
var
  LINIFile: TIniFile;
  LSection : String;
begin
  LSection := 'SQLPACKAGE';
  LINIFile := TIniFile.Create('.\'+FPathIniFile);
  //------------------------------------------
  // Parametros de LEITURA E GRAVACAO  NO INI
  //------------------------------------------
  //Ler
  edtSource_Host.Text      := LINIFile.ReadString(LSection,'Source_Host','');
  edtSource_Database.Items.IndexOf(LINIFile.ReadString(LSection,'Source_Database',''));
  edtSource_User.Text      := LINIFile.ReadString(LSection,'Source_User','');
  edtSource_Password.Text  := LINIFile.ReadString(LSection,'Source_Password','');
  //
  //Ler
  edtTarget_Host.Text      := LINIFile.ReadString(LSection,'Target_Host','');
  edtTarget_Database.Items.IndexOf(LINIFile.ReadString(LSection,'Target_Database',''));
  edtTarget_User.Text      := LINIFile.ReadString(LSection,'Target_User','');
  edtTarget_Password.Text  := LINIFile.ReadString(LSection,'Target_Password','');
  //

  LINIFile.Free;
end;

procedure TFrmMain.PraButtonStyle1Click(Sender: TObject);
begin
//
end;


procedure TFrmMain.LoadsHostSQL;
var
  LHOST : TStringList;
begin
 if FileExists(ExtractShortPathName(ExtractFileDir(ParamStr(0))+'\SQL.hosts')) then
 Begin
  if not IsFileInUse(ExtractShortPathName(ExtractFileDir(ParamStr(0))+'\SQL.hosts')) then
  begin
    LHOST := TStringList.Create;
    LHOST.LoadFromFile(ExtractFileDir(ParamStr(0))+'\SQL.hosts');
    //
    edtSource_Host.Items.clear;
    edtSource_Host.Items.Add('LOCALHOST\NESKI');
    edtSource_Host.Items.Add('LOCALHOST\SQLEXPRESS');
    edtTarget_Host.Items.clear;
    edtTarget_Host.Items.Add('LOCALHOST\NESKI');
    edtTarget_Host.Items.Add('LOCALHOST\SQLEXPRESS');
    for var LFor := 0 to LHOST.Count-1 do
    begin
      if LHOST.Strings[LFor].Length > 0 then
      begin
        if LFor > 3 then
        begin
          edtSource_Host.Items.Add(Trim(LHOST.Strings[LFor]));
          edtTarget_Host.Items.Add(Trim(LHOST.Strings[LFor]));
        end;
      end;
    end;
  end;
 End;
end;

end.
