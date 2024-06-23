unit Frm.Tools.ReleaseVersion;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, System.StrUtils, RzTabs, System.JSON, Vcl.Samples.Spin, Gobt_ButtonAdvanced, Vcl.Mask,
  System.IniFiles, FireDAC.Phys.MSSQLDef, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL,
  GOX.Code.SQLPackage, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, goxormbr.engine.connection, goxormbr.core.types,
  goxormbr.manager.objectset, System.Generics.Collections, goxormbr.core.json.utils;

type
  TFrmToolsReleaseVersion = class(TForm)
    pnFundo: TPanel;
    pnJSONSettings: TPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    RzPageControl_JSONSetting: TRzPageControl;
    TabSheet_Version: TRzTabSheet;
    Panel4: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Panel6: TPanel;
    edtVersionNumber: TSpinEdit;
    edtReleaseNumber: TSpinEdit;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    Panel13: TPanel;
    pnSource: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    lblSource_Database: TLabel;
    edtSource_User: TEdit;
    edtSource_Password: TMaskEdit;
    btnSourceConnectionTest: TGoButtonAdvanced;
    edtSource_Database: TEdit;
    Label9: TLabel;
    edtSource_Output: TEdit;
    edtSource_Host: TEdit;
    FDPhysMSSQLDriverLink: TFDPhysMSSQLDriverLink;
    FDConn_Source: TFDConnection;
    Panel11: TPanel;
    pnGenerateVersion: TPanel;
    btnGenerateVersion: TGoButtonAdvanced;
    Label_IntegerVersion: TLabel;
    Label_StringVersion: TLabel;
    Bevel1: TBevel;
    dlgSave: TSaveDialog;
    btnSaveJson_Express: TGoButtonAdvanced;
    edtProjectName: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtVersionNumberChange(Sender: TObject);
    procedure edtReleaseNumberChange(Sender: TObject);
    procedure btnSourceConnectionTestClick(Sender: TObject);
    procedure btnGenerateVersionClick(Sender: TObject);
    procedure btnSaveJsonVersion_AuthClick(Sender: TObject);
    procedure btnSaveJson_ExpressClick(Sender: TObject);
  private
    { Private declarations }
    FPathIniFile: String;
    FCurrentDIR:String;
    FSQLPackage : TGOXSQLPackage;
    procedure PrepareButtonNameGenerate;

    procedure Save_JSONSetting_Inicial;
    function  Check_TableVersion:Boolean;
    //
    procedure Load_JSONSetting;
    procedure Save_JSONSetting;
    procedure LoadINI;
    procedure SaveINI;
    //
    procedure GenerateJSONDefault;
    function TestSourceConnection:Boolean;
    const FDataBaseNameDefault = 'NESKI_EXPRESS_DB';
  public
    { Public declarations }
    procedure GenerateVersion;
  end;

var
  FrmToolsReleaseVersion: TFrmToolsReleaseVersion;

implementation

{$R *.dfm}

{ TFrmToolsReleaseVersion }


function TFrmToolsReleaseVersion.TestSourceConnection:Boolean;
var
  SavCursor: TCursor;
  LFIELD_VRS_NUMBER : String;
  LSequences : TStringList;
  LDBQuery : TFDQuery;
begin
  SavCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  //
  try
    Result := false;
    LSequences := TStringList.Create;

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
    //---------------------------------------------------------
    //Criar Tabela de Controle de Versão
    //---------------------------------------------------------
    if FDConn_Source.Connected then
    begin
      FDConn_Source.ExecSQL('DROP VIEW dbo.ZVERSIONVIEW');
      FDConn_Source.ExecSQL('DROP TABLE dbo.ZVERSION');
      //
      //Prepara Nome Field da Versao
      LFIELD_VRS_NUMBER := 'VRS_NUMBER_'+edtVersionNumber.Value.ToString+FormatFloat('0000',edtReleaseNumber.Value);

      //Cria Tabela ZVERSION
      FDConn_Source.ExecSQL('CREATE TABLE dbo.ZVERSION (VRS_NUMBER int NULL)');

      FDConn_Source.ExecSQL('CREATE VIEW dbo.ZVERSIONVIEW AS SELECT VRS_NUMBER AS '+LFIELD_VRS_NUMBER+' FROM ZVERSION');

      //
      Result := FDConn_Source.Connected;
      ShowMessage('Conectado com Sucesso!');
    end;
    //---------------------------------------------------------
    //Criar Lista de Sequencia para verificação e criação
    //---------------------------------------------------------
    LDBQuery := TFDQuery.Create(Self);
    LDBQuery.Connection := FDConn_Source;
    LDBQuery.Open('SELECT NAME FROM SYS.SEQUENCES');
    if LDBQuery.RecordCount > 0 then
    begin
      LDBQuery.First;
      while not LDBQuery.Eof do
      begin
        LSequences.Add('IF NOT EXISTS (SELECT NAME FROM SYS.SEQUENCES WHERE NAME = '+LDBQuery.FieldByName('NAME').AsString.QuotedString+') CREATE SEQUENCE '+LDBQuery.FieldByName('NAME').AsString+'  START WITH 1 INCREMENT BY 1;');
        LDBQuery.Next;
      end;
        LSequences.SaveToFile(FCurrentDIR+'SequencesResource.txt');
      end;
  finally
    FreeAndNil(LSequences);
    Screen.Cursor := SavCursor;
  end;
end;


procedure TFrmToolsReleaseVersion.LoadINI;
var
  LINIFile: TIniFile;
  LSection : String;
begin
  LSection := 'PARAMS';
  LINIFile := TIniFile.Create(FPathIniFile);
  //------------------------------------------
  // Parametros de LEITURA E GRAVACAO  NO INI
  //------------------------------------------
  //Ler
  edtProjectName.Text      := LINIFile.ReadString(LSection,'ProjectName','');
  edtSource_Host.Text      := LINIFile.ReadString(LSection,'Source_Host','');
  edtSource_Database.Text  := LINIFile.ReadString(LSection,'Source_Database','');
  edtSource_User.Text      := LINIFile.ReadString(LSection,'Source_User','');
  edtSource_Password.Text  := LINIFile.ReadString(LSection,'Source_Password','');
  //
  LINIFile.Free;
end;


procedure TFrmToolsReleaseVersion.SaveINI;
var
  LINIFile: TIniFile;
  LSection : String;
begin
  LSection := 'PARAMS';
  LINIFile := TIniFile.Create(FPathIniFile);
  //------------------------------------------
  // Parametros de LEITURA E GRAVACAO  NO INI
  //------------------------------------------
  //Grava
  LINIFile.WriteString(LSection,'ProjectName',edtProjectName.Text);
  LINIFile.WriteString(LSection,'Source_Host',edtSource_Host.Text);
  LINIFile.WriteString(LSection,'Source_Database',edtSource_Database.Text);
  LINIFile.WriteString(LSection,'Source_User',edtSource_User.Text);
  LINIFile.WriteString(LSection,'Source_Password',edtSource_Password.Text);
  //
  LINIFile.Free;
end;




procedure TFrmToolsReleaseVersion.btnGenerateVersionClick(Sender: TObject);
begin
  try
    btnGenerateVersion.Enabled := false;
    GenerateVersion;
  finally
    btnGenerateVersion.Enabled := true;
    btnGenerateVersion.Visible := false;
  end;
end;

procedure TFrmToolsReleaseVersion.btnSourceConnectionTestClick(Sender: TObject);
begin
  btnGenerateVersion.Visible := false;
  if TestSourceConnection then
  begin
    //
    SaveINI;
    //
    btnGenerateVersion.Visible := true;
  end;
end;

function TFrmToolsReleaseVersion.Check_TableVersion: Boolean;
var
  SavCursor: TCursor;
  LDBQry : TFDQuery;
  LSQL : String;
  LFieldName: String;
  LVersion : Integer;
begin
  SavCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  //
  try
    Result := false;
    LVersion := 0;
    //
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
      LSQL := ' SELECT COLUMN_NAME'+
              ' FROM INFORMATION_SCHEMA.COLUMNS'+
              ' WHERE TABLE_NAME = '+QuotedStr('ZVERSIONVIEW')+' AND COLUMN_NAME LIKE '+QuotedStr('VRS_NUMBER_%');
      LDBQry := TFDQuery.Create(Self);
      LDBQry.Connection := FDConn_Source;
      LDBQry.Open(LSQL);
      if LDBQry <> nil then
      begin
        if LDBQry.RecordCount > 0 then
        Begin
          LFieldName := LDBQry.FieldByName('COLUMN_NAME').AsString;

          LVersion := StrToIntDef(Trim(Copy(LFieldName,12,LFieldName.Length)),0);
        End;
      end;
      FreeAndNil(LDBQry);
      //
      Result := ( LVersion = StrToIntDef(Trim(edtVersionNumber.Value.ToString+FormatFloat('0000',edtReleaseNumber.Value)),0));

      if not Result then
      begin
        ShowMessage('Database [ '+UpperCase(edtSource_Database.Text)+' ] está com a versão incompatível!'+#13+#13+
                    'Versão Database: '+LVersion.ToString+#13+
                    'Versao Configurada: '+edtVersionNumber.Value.ToString+FormatFloat('0000',edtReleaseNumber.Value));
        Load_JSONSetting;
      end;
    end;
  finally
    Screen.Cursor := SavCursor;
  end;
end;


procedure TFrmToolsReleaseVersion.edtReleaseNumberChange(Sender: TObject);
begin
  edtReleaseNumber.Text := '  '+edtReleaseNumber.Value.ToString;
  PrepareButtonNameGenerate;
end;

procedure TFrmToolsReleaseVersion.edtVersionNumberChange(Sender: TObject);
begin
  edtVersionNumber.Text := '  '+edtVersionNumber.Value.ToString;
  PrepareButtonNameGenerate;
end;

procedure TFrmToolsReleaseVersion.FormCreate(Sender: TObject);
begin
  //Path e Nome do Arquivo INI
  FPathIniFile :=  ExtractFilePath(ExtractShortPathName(ParamStr(0)))+ChangeFileExt(ExtractFileName(ParamStr(0)),'.ini');
  FCurrentDIR := ExtractFilePath(ExtractShortPathName(ParamStr(0)));
  //
  Save_JSONSetting_Inicial;
  //
  //Cria SQLPackage
  FSQLPackage := TGOXSQLPackage.Create;
  FSQLPackage.ShowConsole := true;
  //
  TabSheet_Version.Show;
  //
  Load_JSONSetting;
  LoadINI;
  //
end;

procedure TFrmToolsReleaseVersion.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FSQLPackage);
end;

procedure TFrmToolsReleaseVersion.GenerateJSONDefault;
//var
//  LTextFile: TextFile;
//  LGOXConnection : TGOXDBConnectionEngine;
//  LManagerObj : TGOXManagerObjectSet;
//  LJSONObject : TJSONObject;
//  //
//  LDtoMENUSList : TObjectList<TDtoMENUS>;
begin
  {Funcão nao Utilizada, mas serve para gerar arquivo json de tabelas}

//  try
//    LGOXConnection := TGOXDBConnectionEngine.Create(Self,dnMSSQL);
//    LGOXConnection.Params.Clear;
//    LGOXConnection.Close;
//    LGOXConnection.ConnectionName := 'MSSQLSourceJSON';
//    LGOXConnection.DriverName := 'MSSQL';
//    LGOXConnection.LoginPrompt := false;
//    LGOXConnection.Params.Clear;
//    LGOXConnection.Params.Add('Server='+Trim(edtSource_Host.Text));
//    LGOXConnection.Params.Add('User_Name='+Trim(edtSource_User.Text));
//    LGOXConnection.Params.Add('Password='+Trim(edtSource_Password.Text));
//    LGOXConnection.Params.Add('Database='+Trim(edtSource_Database.Text));
//    LGOXConnection.Params.Add('Protocol=TCPIP');
//    LGOXConnection.Params.Add('Port=1433');
//    LGOXConnection.Params.Add('LoginTimeout=60');
//    LGOXConnection.Params.Add('DriverID=MSSQL');
//    LGOXConnection.Connected := true;
//
//    LManagerObj := TGOXManagerObjectSet.Create(LGOXConnection);
//    LManagerObj.AddObjectSet<TDtoMENUS>;
//    LJSONObject :=  TJSONObject.Create;
//
//    LDtoMENUSList := LManagerObj.Find<TDtoMENUS>;
//
//    LJSONObject.AddPair('MENUS',TGOXJson.ObjectToJSON(LDtoMENUSList));
//
//    //
//
//    dlgSave.DefaultExt := 'json';
//    dlgSave.Filter := 'Json|*.json';
//    dlgSave.FileName := 'DataExpressDefault';
//    if dlgSave.Execute then
//    begin
//      if not FileExists(dlgSave.FileName) then
//      begin
//        AssignFile(LTextFile,dlgSave.FileName);
//        //@@
//        // Inicia a variável
//        ReWrite(LTextFile);
//        Writeln(LTextFile,LJSONObject.ToJSON);
//        CloseFile(LTextFile);
//      end;
//    end;
//  finally
//    FreeAndNil(LDtoMENUSList);
//    //
//    FreeAndNil(LManagerObj);
//    FreeAndNil(LGOXConnection);
//  end;
end;

procedure TFrmToolsReleaseVersion.GenerateVersion;
var
  LPathFileName : String;
begin
  if Check_TableVersion then
  begin
    //Save JSONSetting com Numero da Versao:
    Save_JSONSetting;
    //
    //Gera Arquivo de Schema DacPac
    FSQLPackage.SourceEncryptConnection := false;
    FSQLPackage.SourceServerName   := edtSource_Host.Text;
    FSQLPackage.SourceDatabaseName := edtSource_Database.Text;
    FSQLPackage.SourceUser         := edtSource_User.Text;
    FSQLPackage.SourcePassword     := edtSource_Password.Text;
    //
    //Prepara Nome do Arquivo Output .dacpac
    edtSource_Output.Text := 'Schema_'+FDataBaseNameDefault+'.dacpac';
    Application.ProcessMessages;
    //
    LPathFileName:= FSQLPackage.DirectoryDACPAC+edtSource_Output.Text;
    //
    if Application.MessageBox('Confirma Geração da Version?','Atenção...',MB_YESNO+MB_ICONQUESTION+MB_DEFBUTTON2) = IDYES then
    begin
      FSQLPackage.Extract(LPathFileName);
      Application.Terminate;
    end;
  end;
end;

procedure TFrmToolsReleaseVersion.btnSaveJson_ExpressClick(Sender: TObject);
begin
  //Save JSONSetting com Numero da Versao:
  Save_JSONSetting;

end;

procedure TFrmToolsReleaseVersion.btnSaveJsonVersion_AuthClick(Sender: TObject);
begin
  //Save JSONSetting com Numero da Versao:
  Save_JSONSetting;
end;

procedure TFrmToolsReleaseVersion.Load_JSONSetting;
var
  LStrList :  TStringList;
  LJSONObject : TJSONObject;
  LJSONArray: TJSONArray;
begin
  try
    LStrList := TStringList.Create;
    LStrList.LoadFromFile(FCurrentDIR+'SettingResource.json');
    LJSONArray := TJSONObject.ParseJSONValue(LStrList.Text) as TJSONArray;

    for var IFor := 0 to LJSONArray.Count-1 do
    begin
      LJSONObject := LJSONArray.Get(IFor) as TJSONObject;
      //Version
      edtVersionNumber.Value    := StrToIntDef(LJSONObject.FindValue('VersionNumber').Value,0);
      edtVersionNumber.MaxValue := 99;
      edtVersionNumber.MinValue := StrToIntDef(LJSONObject.FindValue('VersionNumber').Value,0);
      //Release
      edtReleaseNumber.Value    := StrToIntDef(LJSONObject.FindValue('ReleaseNumber').Value,0);
      edtReleaseNumber.MaxValue := 9999;
//      edtReleaseNumber.MinValue := StrToIntDef(LJSONObject.FindValue('ReleaseNumber').Value,0);
    end;
    LJSONObject := nil;
  finally
    FreeAndNil(LJSONArray);
    FreeAndNil(LStrList);
  end;
end;

procedure TFrmToolsReleaseVersion.PrepareButtonNameGenerate;
begin
  btnGenerateVersion.Caption   := 'Generate Version '+Trim(edtVersionNumber.Text)+'.'+FormatFloat('0000',StrToInt(Trim(edtReleaseNumber.Text)));
  Label_IntegerVersion.Caption := 'Integer Version  [  '+Trim(edtVersionNumber.Text)+FormatFloat('0000',StrToInt(Trim(edtReleaseNumber.Text)))+'  ]';
  Label_StringVersion.Caption  := 'String Formatted [  '+Trim(edtVersionNumber.Text)+'.'+FormatFloat('0000',StrToInt(Trim(edtReleaseNumber.Text)))+'  ]';
  //
  edtSource_Output.Text := 'Schema_'+FDataBaseNameDefault+'.dacpac';
end;

procedure TFrmToolsReleaseVersion.Save_JSONSetting;
var
  LStrList :  TStringList;
begin
  if Length(edtProjectName.Text) = 0 then
  begin
    ShowMessage('Favor Digitar Nome Projeto.');
    edtProjectName.SetFocus;
    Abort;
  end;
  try
    try
      LStrList := TStringList.Create;
      LStrList.Text := '[{"ProjectName":"'+edtProjectName.Text+'",'+
                       '  "VersionNumber":"'+edtVersionNumber.Value.ToString+'",'+
                       '  "ReleaseNumber":"'+FormatFloat('0000',edtReleaseNumber.Value)+'"'+
                       ' }]';
      LStrList.SaveToFile(FCurrentDIR+'SettingResource.json')
    except on E: Exception do
      ShowMessage('Save to JSONSetting: '+E.Message);
    end;
  finally
    FreeAndNil(LStrList);
  end;
end;

procedure TFrmToolsReleaseVersion.Save_JSONSetting_Inicial;
var
  LStrList :  TStringList;
begin
  try
    LStrList := TStringList.Create;
    try
      if not FileExists(FCurrentDIR+'SettingResource.json') then
      begin
        LStrList.Text := '[{"ProjectName":"'+edtProjectName.Text+'",'+
                         '  "VersionNumber":'+FormatDateTime('YY',Date)+','+
                         '  "ReleaseNumber":'+'0001'+
                         ' }]';
        LStrList.SaveToFile(FCurrentDIR+'SettingResource.json')
      end;
    except on E: Exception do
      ShowMessage('Save to JSONSetting: '+E.Message);
    end;
  finally
    FreeAndNil(LStrList);
  end;
end;

end.

