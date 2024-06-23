unit Core.Server.Params;

interface

uses
  System.SysUtils,
  System.StrUtils,
  System.Classes,
  System.JSON,
  System.Net.HttpClient,
  Tools.Collections.Methods,
  System.IniFiles,
  Kernel.Server.Paths;

type
  TPARAMServer = class
    private
    { Private declarations }
    FAppKeyNameLast : String;
    FIniFileName : String;
    FPathIniFileAPPServerConnectionsParams : String;

    //Database Config
    FDATABASE_DriverID:String;
    FDATABASE_Host:String;
    FDATABASE_Instance:String;
    FDATABASE_Port:String;
    FDATABASE_Name:String;
    FDATABASE_Login:String;
    FDATABASE_Password:String;
    FDATABASE_ODBCDriver:String;
    FDATABASE_ODBCAdvanced:String;
    //
    //Authenticador Cloud Config
    FAUTHENTICATOR_URLBase:String;
    FAUTHENTICATOR_URLBaseContingency :String;
    //Gestor Cloud Config
    FGESTOR_URLBase:String;
    FGESTOR_URLBaseContingency :String;
    //Neia Cloud Config
    FNEIA_URLBase:String;
    FNEIA_URLBaseContingency :String;
    //DefaultData
    FDEFAULTDATA_URLBase:String;
    FDEFAULTDATA_URLBaseContingency :String;
    //
    //Express Config
    FEXPRESS_URLBase:String;
    FEXPRESS_URLBaseContingency :String;
    //
    //ZapBot Config
    FZAPBOT_URLBase:String;
    FZAPBOT_URLBaseContingency :String;
    //IntegraConfig
    FINTEGRA_URLBase:String;
    FINTEGRA_URLBaseContingency :String;
    //
    FPARAMS_ReportClient_Path: String;
    FPARAMS_ReportServer_Path: String;

    FPARAMS_Certificate_UseSSL: String;
    FPARAMS_Certificate_File: String;
    FPARAMS_Certificate_KeyFile: String;
    FPARAMS_Certificate_RootFile: String;
    FPARAMS_Certificate_Password: String;
    //
    procedure INIAddLineSection(ASection:String);
    procedure INIAddLine(ALine:String = '');
    class var FAppKeyName : String;
    class var fInstance : TPARAMServer;
    constructor CreatePrivate;
  public
    { Public declarations }
    constructor Create;
    destructor Destroy; override;
    class function Get: TPARAMServer;
    class function UpdatePARAMS: TPARAMServer;

    //
   // procedure UpdatePARAMS;
    //
    procedure Config_Params_AUTHENTICATOR;  //Cloud Neski
    procedure Config_Params_NEIA;           //Cloud Neski
    procedure Config_Params_EXPRESS;
    procedure Config_Params_INTEGRA;
    procedure Config_Params_ZAPBOT;
    //
    procedure Config_Params_DEFAULTDATA;
    //
    procedure Config_Params_PARAMSALL;


    function GetPathIniFileAPPServerConnectionsParams:String;
    //
    property DATABASE_DriverID:    String     read FDATABASE_DriverID      write FDATABASE_DriverID;
    property DATABASE_Host:        String     read FDATABASE_Host          write FDATABASE_Host;
    property DATABASE_Instance:    String     read FDATABASE_Instance      write FDATABASE_Instance;
    property DATABASE_Port:        String     read FDATABASE_Port          write FDATABASE_Port;
    property DATABASE_Name:        String     read FDATABASE_Name          write FDATABASE_Name;
    property DATABASE_Login:       String     read FDATABASE_Login         write FDATABASE_Login;
    property DATABASE_Password:    String     read FDATABASE_Password      write FDATABASE_Password;
    property DATABASE_ODBCDriver:  String     read FDATABASE_ODBCDriver    write FDATABASE_ODBCDriver;
    property DATABASE_ODBCAdvanced:String     read FDATABASE_ODBCAdvanced  write FDATABASE_ODBCAdvanced;
    //
    property AUTHENTICATOR_URLBase: String            read FAUTHENTICATOR_URLBase            write FAUTHENTICATOR_URLBase;
    property AUTHENTICATOR_URLBaseContingency: String read FAUTHENTICATOR_URLBaseContingency write FAUTHENTICATOR_URLBaseContingency;
    //
    property GESTOR_URLBase: String            read FGESTOR_URLBase            write FGESTOR_URLBase;
    property GESTOR_URLBaseContingency: String read FGESTOR_URLBaseContingency write FGESTOR_URLBaseContingency;
    //
    property NEIA_URLBase: String               read FNEIA_URLBase              write FNEIA_URLBase;
    property NEIA_URLBaseContingency: String    read FNEIA_URLBaseContingency   write FNEIA_URLBaseContingency;
    //
    property DEFAULTDATA_URLBase: String               read FDEFAULTDATA_URLBase              write FDEFAULTDATA_URLBase;
    property DEFAULTDATA_URLBaseContingency: String    read FDEFAULTDATA_URLBaseContingency   write FDEFAULTDATA_URLBaseContingency;
    //
    property EXPRESS_URLBase: String            read FEXPRESS_URLBase            write FEXPRESS_URLBase;
    property EXPRESS_URLBaseContingency: String read FEXPRESS_URLBaseContingency write FEXPRESS_URLBaseContingency;
    //
    property ZAPBOT_URLBase: String             read FZAPBOT_URLBase            write FZAPBOT_URLBase;
    property ZAPBOT_URLBaseContingency: String  read FZAPBOT_URLBaseContingency write FZAPBOT_URLBaseContingency;
    //
    property INTEGRA_URLBase: String             read FINTEGRA_URLBase            write FINTEGRA_URLBase;
    property INTEGRA_URLBaseContingency: String  read FINTEGRA_URLBaseContingency write FINTEGRA_URLBaseContingency;
    //
    property PARAMS_ReportClientPath: String read FPARAMS_ReportClient_Path write FPARAMS_ReportClient_Path;
    property PARAMS_ReportServerPath: String read FPARAMS_ReportServer_Path write FPARAMS_ReportServer_Path;

    property PARAMS_Certificate_UseSSL: String   read FPARAMS_Certificate_UseSSL   write FPARAMS_Certificate_UseSSL;
    property PARAMS_Certificate_File: String     read FPARAMS_Certificate_File     write FPARAMS_Certificate_File;
    property PARAMS_Certificate_KeyFile: String  read FPARAMS_Certificate_KeyFile  write FPARAMS_Certificate_KeyFile;
    property PARAMS_Certificate_RootFile: String read FPARAMS_Certificate_RootFile write FPARAMS_Certificate_RootFile;
    property PARAMS_Certificate_Password: String read FPARAMS_Certificate_Password write FPARAMS_Certificate_Password;
  end;

implementation

{ TPARAMServer }

constructor TPARAMServer.Create;
begin
  raise Exception.Create('Para Obter uma Instância de '+Self.ClassName+', use Get');
end;

constructor TPARAMServer.CreatePrivate;
begin
  //Atualiza Parametros
  FAppKeyName := 'NeskiExpressServer_5500';
//  UpdatePARAMS;
end;

destructor TPARAMServer.Destroy;
begin
  inherited;
end;

class function TPARAMServer.Get:TPARAMServer;
begin
  if not Assigned(FInstance) then
    FInstance := TPARAMServer.CreatePrivate;
  Result := FInstance;
end;

function TPARAMServer.GetPathIniFileAPPServerConnectionsParams: String;
begin
  Result := FPathIniFileAPPServerConnectionsParams;
end;

procedure TPARAMServer.INIAddLine(ALine:String);
var
  LSpace:TStringList;
begin
  try
    Sleep(30);
    LSpace := TStringList.Create;
    LSpace.LoadFromFile(FPathIniFileAPPServerConnectionsParams);
    LSpace.Add(ALine);
    LSpace.SaveToFile(FPathIniFileAPPServerConnectionsParams);
  finally
    FreeAndNil(LSpace);
  end;
end;

procedure TPARAMServer.INIAddLineSection(ASection: String);
var
  LSpace:TStringList;
  LTextDiv : String;
  LText : String;
begin
  LTextDiv := DupeString('=',100);
  try
    LSpace := TStringList.Create;
    LSpace.LoadFromFile(FPathIniFileAPPServerConnectionsParams);
    LText := Trim(LSpace.Text);
    LSpace.Text := LText;
    LSpace.Add('');
    LSpace.SaveToFile(FPathIniFileAPPServerConnectionsParams);
  finally
    FreeAndNil(LSpace);
  end;
  //=============================================================================
  try
    LSpace := TStringList.Create;
    LSpace.LoadFromFile(FPathIniFileAPPServerConnectionsParams);
    for var I := 0 to LSpace.Count-1do
    begin
       if Trim(LSpace.Strings[I]) = '['+ASection+']' then
       begin
         if I = 0 then
         begin
          LSpace.Insert(i,LTextDiv);
          LSpace.Insert(i+2,DupeString('=',Length('['+ASection+']')));
         end;
         if I > 0 then
         begin
           //Se texto anterior for diferente
           if LSpace.Strings[i-1] <> LTextDiv then
           begin
             LSpace.Insert(i,LTextDiv);
             LSpace.Insert(i+2,DupeString('=',Length('['+ASection+']')));
           end;
         end;
         Break;
       end;
    end;
    LSpace.SaveToFile(FPathIniFileAPPServerConnectionsParams);
  finally
    FreeAndNil(LSpace);
  end;
end;

procedure TPARAMServer.Config_Params_AUTHENTICATOR;
Var
  LINIFile : TIniFile;
  LSection: String;
begin
  //=====================================================================================
  //Configuração Para Servidor : AUTHENTICATOR
  //=====================================================================================
  LSection := UpperCase(FAppKeyName);
  LINIFile := TIniFile.Create(FPathIniFileAPPServerConnectionsParams);
  //------------------------------------------
  // Parametros de LEITURA E GRAVACAO  NO INI
  //------------------------------------------
  //DATABASE - Ler e Grava
  FDATABASE_DriverID    := LINIFile.ReadString(LSection,'DATABASE_DriverID','ODBC');
  FDATABASE_Host        := LINIFile.ReadString(LSection,'DATABASE_Host','LOCALHOST');
  FDATABASE_Instance    := LINIFile.ReadString(LSection,'DATABASE_Instance','EXPRESS');
  FDATABASE_Port        := LINIFile.ReadString(LSection,'DATABASE_Port','1433');
  FDATABASE_Name        := LINIFile.ReadString(LSection,'DATABASE_Name','NESKI_AUTHENTICATOR_DB');
  FDATABASE_Login       := LINIFile.ReadString(LSection,'DATABASE_Login','AUTO');
  FDATABASE_Password    := LINIFile.ReadString(LSection,'DATABASE_Password','AUTO');
  FDATABASE_ODBCDriver  := LINIFile.ReadString(LSection,'DATABASE_ODBCDriver','ODBC Driver 17 for SQL Server');
  FDATABASE_ODBCAdvanced:= LINIFile.ReadString(LSection,'DATABASE_ODBCAdvanced','');
  LINIFile.WriteString(LSection,'DATABASE_DriverID',FDATABASE_DriverID);
  LINIFile.WriteString(LSection,'DATABASE_Host',FDATABASE_Host);
  LINIFile.WriteString(LSection,'DATABASE_Instance',FDATABASE_Instance);
  LINIFile.WriteString(LSection,'DATABASE_Port',FDATABASE_Port);
  LINIFile.WriteString(LSection,'DATABASE_Name',FDATABASE_Name);
  LINIFile.WriteString(LSection,'DATABASE_Login',FDATABASE_Login);
  LINIFile.WriteString(LSection,'DATABASE_Password',FDATABASE_Password);
  LINIFile.WriteString(LSection,'DATABASE_ODBCDriver',FDATABASE_ODBCDriver);
  LINIFile.WriteString(LSection,'DATABASE_ODBCAdvanced',FDATABASE_ODBCAdvanced);
  INIAddLine;
  //
  //GESTOR - Ler e Grava
  FGESTOR_URLBase            := LINIFile.ReadString(LSection,'GESTOR_URLBase','http://neskicloud.com.br:5500/rest/api');
  FGESTOR_URLBaseContingency := LINIFile.ReadString(LSection,'GESTOR_URLBaseContingency','');
  LINIFile.WriteString(LSection,'GESTOR_URLBase',FGESTOR_URLBase);
  LINIFile.WriteString(LSection,'GESTOR_URLBaseContingency',FGESTOR_URLBaseContingency);
  INIAddLine;
  //NEIA  - Ler e Grava
  FNEIA_URLBase            := LINIFile.ReadString(LSection,'NEIA_URLBase','http://neskicloud.com.br:6510/rest/api');
  FNEIA_URLBaseContingency := LINIFile.ReadString(LSection,'NEIA_URLBaseContingency','');
  LINIFile.WriteString(LSection,'NEIA_URLBase',FNEIA_URLBase);
  LINIFile.WriteString(LSection,'NEIA_URLBaseContingency',FNEIA_URLBaseContingency);
  INIAddLine;
  //
  LINIFile.Free;
  //Tratar arquivo ini
  INIAddLineSection(LSection);
end;

procedure TPARAMServer.Config_Params_DEFAULTDATA;
Var
  LINIFile : TIniFile;
  LSection: String;
begin
  //=====================================================================================
  //Configuração Para Servidor : EXPRESS
  //=====================================================================================
  LSection := UpperCase(FAppKeyName);
  LINIFile := TIniFile.Create(FPathIniFileAPPServerConnectionsParams);
  //------------------------------------------
  // Parametros de LEITURA E GRAVACAO  NO INI
  //------------------------------------------
  //DATABASE - Ler e Grava
  FDATABASE_DriverID    := LINIFile.ReadString(LSection,'DATABASE_DriverID','ODBC');
  FDATABASE_Host        := LINIFile.ReadString(LSection,'DATABASE_Host','LOCALHOST');
  FDATABASE_Instance    := LINIFile.ReadString(LSection,'DATABASE_Instance','EXPRESS');
  FDATABASE_Port        := LINIFile.ReadString(LSection,'DATABASE_Port','1433');
  FDATABASE_Name        := LINIFile.ReadString(LSection,'DATABASE_Name','NESKI_EXPRESS_DB');
  FDATABASE_Login       := LINIFile.ReadString(LSection,'DATABASE_Login','AUTO');
  FDATABASE_Password    := LINIFile.ReadString(LSection,'DATABASE_Password','AUTO');
  FDATABASE_ODBCDriver  := LINIFile.ReadString(LSection,'DATABASE_ODBCDriver','ODBC Driver 17 for SQL Server');
  FDATABASE_ODBCAdvanced:= LINIFile.ReadString(LSection,'DATABASE_ODBCAdvanced','');
  LINIFile.WriteString(LSection,'DATABASE_DriverID',FDATABASE_DriverID);
  LINIFile.WriteString(LSection,'DATABASE_Host',FDATABASE_Host);
  LINIFile.WriteString(LSection,'DATABASE_Instance',FDATABASE_Instance);
  LINIFile.WriteString(LSection,'DATABASE_Port',FDATABASE_Port);
  LINIFile.WriteString(LSection,'DATABASE_Name',FDATABASE_Name);
  LINIFile.WriteString(LSection,'DATABASE_Login',FDATABASE_Login);
  LINIFile.WriteString(LSection,'DATABASE_Password',FDATABASE_Password);
  LINIFile.WriteString(LSection,'DATABASE_ODBCDriver',FDATABASE_ODBCDriver);
  LINIFile.WriteString(LSection,'DATABASE_ODBCAdvanced',FDATABASE_ODBCAdvanced);
  INIAddLine;
  //
  //AUTHENTICATOR - Ler e Grava
  FAUTHENTICATOR_URLBase            := LINIFile.ReadString(LSection,'AUTHENTICATOR_URLBase','http://neskicloud.com.br:6500/rest/api');
  FAUTHENTICATOR_URLBaseContingency := LINIFile.ReadString(LSection,'AUTHENTICATOR_URLBaseContingency','');
  LINIFile.WriteString(LSection,'AUTHENTICATOR_URLBase',FAUTHENTICATOR_URLBase);
  LINIFile.WriteString(LSection,'AUTHENTICATOR_URLBaseContingency',FAUTHENTICATOR_URLBaseContingency);
  INIAddLine;
  //
  LINIFile.Free;
  //Tratar arquivo ini
  INIAddLineSection(LSection);
end;

procedure TPARAMServer.Config_Params_EXPRESS;
Var
  LINIFile : TIniFile;
  LSection: String;
begin
  //=====================================================================================
  //Configuração Para Servidor : EXPRESS
  //=====================================================================================
  LSection := UpperCase(FAppKeyName);
  LINIFile := TIniFile.Create(FPathIniFileAPPServerConnectionsParams);
  //------------------------------------------
  // Parametros de LEITURA E GRAVACAO  NO INI
  //------------------------------------------
  //DATABASE - Ler e Grava
  FDATABASE_DriverID    := LINIFile.ReadString(LSection,'DATABASE_DriverID','ODBC');
  FDATABASE_Host        := LINIFile.ReadString(LSection,'DATABASE_Host','LOCALHOST');
  FDATABASE_Instance    := LINIFile.ReadString(LSection,'DATABASE_Instance','EXPRESS');
  FDATABASE_Port        := LINIFile.ReadString(LSection,'DATABASE_Port','1433');
  FDATABASE_Name        := LINIFile.ReadString(LSection,'DATABASE_Name','NESKI_EXPRESS_DB');
  FDATABASE_Login       := LINIFile.ReadString(LSection,'DATABASE_Login','AUTO');
  FDATABASE_Password    := LINIFile.ReadString(LSection,'DATABASE_Password','AUTO');
  FDATABASE_ODBCDriver  := LINIFile.ReadString(LSection,'DATABASE_ODBCDriver','ODBC Driver 17 for SQL Server');
  FDATABASE_ODBCAdvanced:= LINIFile.ReadString(LSection,'DATABASE_ODBCAdvanced','');
  LINIFile.WriteString(LSection,'DATABASE_DriverID',FDATABASE_DriverID);
  LINIFile.WriteString(LSection,'DATABASE_Host',FDATABASE_Host);
  LINIFile.WriteString(LSection,'DATABASE_Instance',FDATABASE_Instance);
  LINIFile.WriteString(LSection,'DATABASE_Port',FDATABASE_Port);
  LINIFile.WriteString(LSection,'DATABASE_Name',FDATABASE_Name);
  LINIFile.WriteString(LSection,'DATABASE_Login',FDATABASE_Login);
  LINIFile.WriteString(LSection,'DATABASE_Password',FDATABASE_Password);
  LINIFile.WriteString(LSection,'DATABASE_ODBCDriver',FDATABASE_ODBCDriver);
  LINIFile.WriteString(LSection,'DATABASE_ODBCAdvanced',FDATABASE_ODBCAdvanced);
  INIAddLine;
  //
  //AUTHENTICATOR - Ler e Grava
  FAUTHENTICATOR_URLBase            := LINIFile.ReadString(LSection,'AUTHENTICATOR_URLBase','http://neskicloud.com.br:6500/rest/api');
  FAUTHENTICATOR_URLBaseContingency := LINIFile.ReadString(LSection,'AUTHENTICATOR_URLBaseContingency','');
  LINIFile.WriteString(LSection,'AUTHENTICATOR_URLBase',FAUTHENTICATOR_URLBase);
  LINIFile.WriteString(LSection,'AUTHENTICATOR_URLBaseContingency',FAUTHENTICATOR_URLBaseContingency);
  INIAddLine;
  //
  //ZAPBOT - Ler e Grava
  FZAPBOT_URLBase            := LINIFile.ReadString(LSection,'ZAPBOT_URLBase','http://localhost:5510/rest/api');
  FZAPBOT_URLBaseContingency := LINIFile.ReadString(LSection,'ZAPBOT_URLBaseContingency','');
  LINIFile.WriteString(LSection,'ZAPBOT_URLBase',FZAPBOT_URLBase);
  LINIFile.WriteString(LSection,'ZAPBOT_URLBaseContingency',FZAPBOT_URLBaseContingency);
  INIAddLine;
  //
  //DEFAULTDATA  - Ler e Grava
  FDEFAULTDATA_URLBase            := LINIFile.ReadString(LSection,'DEFAULTDATA_URLBase','http://defaultdata.neskicloud.com.br:9950/rest/api');
  FDEFAULTDATA_URLBaseContingency := LINIFile.ReadString(LSection,'DEFAULTDATA_URLBaseContingency','');
  LINIFile.WriteString(LSection,'DEFAULTDATA_URLBase',FDEFAULTDATA_URLBase);
  LINIFile.WriteString(LSection,'DEFAULTDATA_URLBaseContingency',FDEFAULTDATA_URLBaseContingency);
  INIAddLine;
  //------------------------------------------
  // Parametros SOMENTE DE LEITURA INI
  //------------------------------------------
  //INTEGRA - Ler
  FINTEGRA_URLBase            := LINIFile.ReadString(LSection,'INTEGRA_URLBase','http://localhost:5520/rest/api');
  FINTEGRA_URLBaseContingency := LINIFile.ReadString(LSection,'INTEGRA_URLBaseContingency','');
  //
  LINIFile.Free;
  //Tratar arquivo ini
  INIAddLineSection(LSection);
end;

procedure TPARAMServer.Config_Params_INTEGRA;
Var
  LINIFile : TIniFile;
  LSection: String;
begin
  //=====================================================================================
  //Configuração Para Servidor : INTEGRA
  //=====================================================================================
  LSection := UpperCase(FAppKeyName);
  LINIFile := TIniFile.Create(FPathIniFileAPPServerConnectionsParams);
  //------------------------------------------
  // Parametros de LEITURA E GRAVACAO  NO INI
  //------------------------------------------
  //DATABASE - Ler e Grava
  FDATABASE_DriverID    := LINIFile.ReadString(LSection,'DATABASE_DriverID','ODBC');
  FDATABASE_Host        := LINIFile.ReadString(LSection,'DATABASE_Host','LOCALHOST');
  FDATABASE_Instance    := LINIFile.ReadString(LSection,'DATABASE_Instance','EXPRESS');
  FDATABASE_Port        := LINIFile.ReadString(LSection,'DATABASE_Port','1433');
  FDATABASE_Name        := LINIFile.ReadString(LSection,'DATABASE_Name','NESKI_EXPRESS_DB');
  FDATABASE_Login       := LINIFile.ReadString(LSection,'DATABASE_Login','AUTO');
  FDATABASE_Password    := LINIFile.ReadString(LSection,'DATABASE_Password','AUTO');
  FDATABASE_ODBCDriver  := LINIFile.ReadString(LSection,'DATABASE_ODBCDriver','ODBC Driver 17 for SQL Server');
  FDATABASE_ODBCAdvanced:= LINIFile.ReadString(LSection,'DATABASE_ODBCAdvanced','');
  LINIFile.WriteString(LSection,'DATABASE_DriverID',FDATABASE_DriverID);
  LINIFile.WriteString(LSection,'DATABASE_Host',FDATABASE_Host);
  LINIFile.WriteString(LSection,'DATABASE_Instance',FDATABASE_Instance);
  LINIFile.WriteString(LSection,'DATABASE_Port',FDATABASE_Port);
  LINIFile.WriteString(LSection,'DATABASE_Name',FDATABASE_Name);
  LINIFile.WriteString(LSection,'DATABASE_Login',FDATABASE_Login);
  LINIFile.WriteString(LSection,'DATABASE_Password',FDATABASE_Password);
  LINIFile.WriteString(LSection,'DATABASE_ODBCDriver',FDATABASE_ODBCDriver);
  LINIFile.WriteString(LSection,'DATABASE_ODBCAdvanced',FDATABASE_ODBCAdvanced);
  INIAddLine;
  //
  //AUTHENTICATOR - Ler e Grava
  FAUTHENTICATOR_URLBase            := LINIFile.ReadString(LSection,'AUTHENTICATOR_URLBase','http://neskicloud.com.br:6500/rest/api');
  FAUTHENTICATOR_URLBaseContingency := LINIFile.ReadString(LSection,'AUTHENTICATOR_URLBaseContingency','');
  LINIFile.WriteString(LSection,'AUTHENTICATOR_URLBase',FAUTHENTICATOR_URLBase);
  LINIFile.WriteString(LSection,'AUTHENTICATOR_URLBaseContingency',FAUTHENTICATOR_URLBaseContingency);
  INIAddLine;
  //
  //EXPRESS - Ler e Grava
  FEXPRESS_URLBase            := LINIFile.ReadString(LSection,'EXPRESS_URLBase','http://localhost:5500/rest/api');
  FEXPRESS_URLBaseContingency := LINIFile.ReadString(LSection,'EXPRESS_URLBaseContingency','');
  LINIFile.WriteString(LSection,'EXPRESS_URLBase',FEXPRESS_URLBase);
  LINIFile.WriteString(LSection,'EXPRESS_URLBaseContingency',FEXPRESS_URLBaseContingency);
  INIAddLine;
  //
  //ZAPBOT - Ler e Grava
  FZAPBOT_URLBase            := LINIFile.ReadString(LSection,'ZAPBOT_URLBase','http://localhost:5510/rest/api');
  FZAPBOT_URLBaseContingency := LINIFile.ReadString(LSection,'ZAPBOT_URLBaseContingency','');
  LINIFile.WriteString(LSection,'ZAPBOT_URLBase',FZAPBOT_URLBase);
  LINIFile.WriteString(LSection,'ZAPBOT_URLBaseContingency',FZAPBOT_URLBaseContingency);
  INIAddLine;
  //
  LINIFile.Free;
  //Tratar arquivo ini
  INIAddLineSection(LSection);
end;

procedure TPARAMServer.Config_Params_NEIA;
Var
  LINIFile : TIniFile;
  LSection: String;
begin
  //=====================================================================================
  //Configuração Para Servidor : NEIA
  //=====================================================================================
  LSection := UpperCase(FAppKeyName);
  LINIFile := TIniFile.Create(FPathIniFileAPPServerConnectionsParams);
  //------------------------------------------
  // Parametros de LEITURA E GRAVACAO  NO INI
  //------------------------------------------
  //DATABASE - Ler e Grava
  FDATABASE_DriverID    := LINIFile.ReadString(LSection,'DATABASE_DriverID','ODBC');
  FDATABASE_Host        := LINIFile.ReadString(LSection,'DATABASE_Host','LOCALHOST');
  FDATABASE_Instance    := LINIFile.ReadString(LSection,'DATABASE_Instance','EXPRESS');
  FDATABASE_Port        := LINIFile.ReadString(LSection,'DATABASE_Port','1433');
  FDATABASE_Name        := LINIFile.ReadString(LSection,'DATABASE_Name','NESKI_EXPRESS_DB');
  FDATABASE_Login       := LINIFile.ReadString(LSection,'DATABASE_Login','AUTO');
  FDATABASE_Password    := LINIFile.ReadString(LSection,'DATABASE_Password','AUTO');
  FDATABASE_ODBCDriver  := LINIFile.ReadString(LSection,'DATABASE_ODBCDriver','ODBC Driver 17 for SQL Server');
  FDATABASE_ODBCAdvanced:= LINIFile.ReadString(LSection,'DATABASE_ODBCAdvanced','');
  LINIFile.WriteString(LSection,'DATABASE_DriverID',FDATABASE_DriverID);
  LINIFile.WriteString(LSection,'DATABASE_Host',FDATABASE_Host);
  LINIFile.WriteString(LSection,'DATABASE_Instance',FDATABASE_Instance);
  LINIFile.WriteString(LSection,'DATABASE_Port',FDATABASE_Port);
  LINIFile.WriteString(LSection,'DATABASE_Name',FDATABASE_Name);
  LINIFile.WriteString(LSection,'DATABASE_Login',FDATABASE_Login);
  LINIFile.WriteString(LSection,'DATABASE_Password',FDATABASE_Password);
  LINIFile.WriteString(LSection,'DATABASE_ODBCDriver',FDATABASE_ODBCDriver);
  LINIFile.WriteString(LSection,'DATABASE_ODBCAdvanced',FDATABASE_ODBCAdvanced);
  INIAddLine;
  //
  //AUTHENTICATOR - Ler e Grava
  FAUTHENTICATOR_URLBase            := LINIFile.ReadString(LSection,'AUTHENTICATOR_URLBase','http://neskicloud.com.br:6500/rest/api');
  FAUTHENTICATOR_URLBaseContingency := LINIFile.ReadString(LSection,'AUTHENTICATOR_URLBaseContingency','');
  LINIFile.WriteString(LSection,'AUTHENTICATOR_URLBase',FAUTHENTICATOR_URLBase);
  LINIFile.WriteString(LSection,'AUTHENTICATOR_URLBaseContingency',FAUTHENTICATOR_URLBaseContingency);
  INIAddLine;
  //
  //EXPRESS - Ler e Grava
  FGESTOR_URLBase            := LINIFile.ReadString(LSection,'GESTOR_URLBase','http://localhost:5500/rest/api');
  FGESTOR_URLBaseContingency := LINIFile.ReadString(LSection,'GESTOR_URLBaseContingency','');
  LINIFile.WriteString(LSection,'GESTOR_URLBase',FGESTOR_URLBase);
  LINIFile.WriteString(LSection,'GESTOR_URLBaseContingency',FGESTOR_URLBaseContingency);
  INIAddLine;
  //
  LINIFile.Free;
  //Tratar arquivo ini
  INIAddLineSection(LSection);
end;

procedure TPARAMServer.Config_Params_PARAMSALL;
Var
  LINIFile : TIniFile;
  LSection: String;
begin
  //=====================================================================================
  //Configuração Para Servidor : AUTHENTICATOR
  //=====================================================================================
  LSection := UpperCase(FAppKeyName);
  LINIFile := TIniFile.Create(FPathIniFileAPPServerConnectionsParams);

  //PARAMS ALL - Ler e Grava
  FPARAMS_ReportClient_Path    := LINIFile.ReadString(LSection,'PARAMS_ReportClient_Path','C:\NeskiApps\NeskiExpress\NeskiExpressClient\Reports');
  FPARAMS_ReportServer_Path    := LINIFile.ReadString(LSection,'PARAMS_ReportServer_Path','C:\NeskiApps\NeskiExpress\NeskiExpressServer\Reports');
  FPARAMS_Certificate_UseSSL   := LINIFile.ReadString(LSection,'PARAMS_Certificate_UseSSL','N');
  FPARAMS_Certificate_File     := LINIFile.ReadString(LSection,'PARAMS_Certificate_File','.\certificate.crt');
  FPARAMS_Certificate_KeyFile  := LINIFile.ReadString(LSection,'PARAMS_Certificate_KeyFile','.\certificate.key');
  FPARAMS_Certificate_RootFile := LINIFile.ReadString(LSection,'PARAMS_Certificate_RootFile','.\certificate.pem');
  FPARAMS_Certificate_Password := LINIFile.ReadString(LSection,'PARAMS_Certificate_Password','');
  LINIFile.WriteString(LSection,'PARAMS_ReportClient_Path',FPARAMS_ReportClient_Path);
  LINIFile.WriteString(LSection,'PARAMS_ReportServer_Path',FPARAMS_ReportServer_Path);
  LINIFile.WriteString(LSection,'PARAMS_Certificate_UseSSL',FPARAMS_Certificate_UseSSL);
  LINIFile.WriteString(LSection,'PARAMS_Certificate_File',FPARAMS_Certificate_File);
  LINIFile.WriteString(LSection,'PARAMS_Certificate_KeyFile',FPARAMS_Certificate_KeyFile);
  LINIFile.WriteString(LSection,'PARAMS_Certificate_RootFile',FPARAMS_Certificate_RootFile);
  LINIFile.WriteString(LSection,'PARAMS_Certificate_Password',FPARAMS_Certificate_Password);
  INIAddLine;
  //
  LINIFile.Free;
  //Tratar arquivo ini
  INIAddLineSection(LSection);
end;

procedure TPARAMServer.Config_Params_ZAPBOT;
Var
  LINIFile : TIniFile;
  LSection: String;
begin
  //=====================================================================================
  //Configuração Para Servidor : ZAPBOT
  //=====================================================================================
  LSection := UpperCase(FAppKeyName);
  LINIFile := TIniFile.Create(FPathIniFileAPPServerConnectionsParams);
  //------------------------------------------
  // Parametros de LEITURA E GRAVACAO  NO INI
  //------------------------------------------
  //DATABASE - Ler e Grava
  FDATABASE_DriverID    := LINIFile.ReadString(LSection,'DATABASE_DriverID','ODBC');
  FDATABASE_Host        := LINIFile.ReadString(LSection,'DATABASE_Host','LOCALHOST');
  FDATABASE_Instance    := LINIFile.ReadString(LSection,'DATABASE_Instance','EXPRESS');
  FDATABASE_Port        := LINIFile.ReadString(LSection,'DATABASE_Port','1433');
  FDATABASE_Name        := LINIFile.ReadString(LSection,'DATABASE_Name','NESKI_EXPRESS_DB');
  FDATABASE_Login       := LINIFile.ReadString(LSection,'DATABASE_Login','AUTO');
  FDATABASE_Password    := LINIFile.ReadString(LSection,'DATABASE_Password','AUTO');
  FDATABASE_ODBCDriver  := LINIFile.ReadString(LSection,'DATABASE_ODBCDriver','ODBC Driver 17 for SQL Server');
  FDATABASE_ODBCAdvanced:= LINIFile.ReadString(LSection,'DATABASE_ODBCAdvanced','');
  LINIFile.WriteString(LSection,'DATABASE_DriverID',FDATABASE_DriverID);
  LINIFile.WriteString(LSection,'DATABASE_Host',FDATABASE_Host);
  LINIFile.WriteString(LSection,'DATABASE_Instance',FDATABASE_Instance);
  LINIFile.WriteString(LSection,'DATABASE_Port',FDATABASE_Port);
  LINIFile.WriteString(LSection,'DATABASE_Name',FDATABASE_Name);
  LINIFile.WriteString(LSection,'DATABASE_Login',FDATABASE_Login);
  LINIFile.WriteString(LSection,'DATABASE_Password',FDATABASE_Password);
  LINIFile.WriteString(LSection,'DATABASE_ODBCDriver',FDATABASE_ODBCDriver);
  LINIFile.WriteString(LSection,'DATABASE_ODBCAdvanced',FDATABASE_ODBCAdvanced);
  INIAddLine;
  //
  //AUTHENTICATOR - Ler e Grava
  FAUTHENTICATOR_URLBase            := LINIFile.ReadString(LSection,'AUTHENTICATOR_URLBase','http://neskicloud.com.br:6500/rest/api');
  FAUTHENTICATOR_URLBaseContingency := LINIFile.ReadString(LSection,'AUTHENTICATOR_URLBaseContingency','');
  LINIFile.WriteString(LSection,'AUTHENTICATOR_URLBase',FAUTHENTICATOR_URLBase);
  LINIFile.WriteString(LSection,'AUTHENTICATOR_URLBaseContingency',FAUTHENTICATOR_URLBaseContingency);
  INIAddLine;
  //
  //EXPRESS - Ler e Grava
  FEXPRESS_URLBase            := LINIFile.ReadString(LSection,'EXPRESS_URLBase','http://localhost:5500/rest/api');
  FEXPRESS_URLBaseContingency := LINIFile.ReadString(LSection,'EXPRESS_URLBaseContingency','');
  LINIFile.WriteString(LSection,'EXPRESS_URLBase',FEXPRESS_URLBase);
  LINIFile.WriteString(LSection,'EXPRESS_URLBaseContingency',FEXPRESS_URLBaseContingency);
  INIAddLine;
  //
  //------------------------------------------
  // Parametros SOMENTE DE LEITURA INI
  //------------------------------------------
  //
  LINIFile.Free;
  //Tratar arquivo ini
  INIAddLineSection(LSection);
end;

class function TPARAMServer.UpdatePARAMS: TPARAMServer;
begin
  if not Assigned(FInstance) then
    FInstance := TPARAMServer.CreatePrivate;
  Result := FInstance;

  if FAppKeyName.Length > 0 then
  begin
    //Valida se mudou de servidor para recarregar os parametros
    //## Importante para nao ficar toda hora carregando o ini pq estava dando Erro de Arquivo sendo Usado.
//    if fInstance.FAppKeyNameLast <> IApp.GetAppKeyName then
//    begin
      //Variavel de Constrole Ultimo Servidor Configurado
      //## Muito Importante para não dar Error no nome do servidor para Carregamento do aquivo ini.
      fInstance.FAppKeyNameLast := FAppKeyName;
      //
      //Path e Nome do Arquivo INI
      fInstance.FIniFileName := Copy(FAppKeyName,1,Pos('_',FAppKeyName)-1)+'.ini'; // 'PARAMSConnections.NConfig';
      fInstance.FPathIniFileAPPServerConnectionsParams :=  TPathsApp.PathInstallation+fInstance.FIniFileName;
      //
      //
      if (Pos('AUTHENTICATOR',UpperCase(FAppKeyName)) > 0) then
      fInstance.Config_Params_AUTHENTICATOR;
      if (Pos('EXPRESS',UpperCase(FAppKeyName)) > 0) then
      fInstance.Config_Params_EXPRESS;
      if (Pos('INTEGRA',UpperCase(FAppKeyName)) > 0) then
      fInstance.Config_Params_INTEGRA;
      if (Pos('NEIA',UpperCase(FAppKeyName)) > 0) then
      fInstance.Config_Params_NEIA;
      if (Pos('ZAPBOT',UpperCase(FAppKeyName)) > 0) then
      fInstance.Config_Params_ZAPBOT;
      //
      if (Pos('DEFAULTDATA',UpperCase(FAppKeyName)) > 0) then
      fInstance.Config_Params_DEFAULTDATA;

      fInstance.Config_Params_PARAMSALL;
//    end;
  end;
end;

initialization
finalization
   if Assigned(TPARAMServer.FInstance) then
    FreeAndNil(TPARAMServer.FInstance);
end.
