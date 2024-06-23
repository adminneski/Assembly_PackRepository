
{******************************************}
{                                          }
{             FastReport VCL               }
{            HTTP Report Server            }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxServer;

{$I frx.inc}

{$IFDEF DELPHI12}
{$WARNINGS OFF}
{$ENDIF}

//{$DEFINE DEBUG}
//{$DEFINE CS_ON}

interface

uses
  Forms,
{$IFDEF FPC}
 {$IFDEF Linux}
  BaseUnix, Unix, LCLType, LCLIntf, Types, LResources, LMessages, LazHelperCS,
 {$ELSE}
  Windows, WinSock,
 {$ENDIF}
  LazHelper, LazSocket,
{$ELSE}
  Windows, WinSock, ScktComp, frThreading,
{$ENDIF}
  Classes, frCore, frxClass, Registry, frxVariables, frGZip, frxServerLog,
  frxServerSessionManager, frxServerStat, frxServerReports,
  frxServerVariables, frxServerSSI, frxServerUtils, frxNetUtils, frHashUtils,
  frxServerCache, frxServerReportsList, frUnicodeUtils, frxUsers, frxHelperCS
// , frxADOComponents, 
//  DB, ADODB
{$IFDEF FR_FIB}
  , frxFIBComponents, FIBDatabase, pFIBDatabase
{$ENDIF}
  , frxServerClient, SysUtils, frxServerConfig, frxServerTemplates, frxServerPrinter;

type
  TfrxHTTPServer = class;
  TfrxServerSession = class;
  TfrxServerData = class;
  TfrxServerGuard = class;
  TfrxServerGetReportEvent = procedure(const ReportName: String;
    Report: TfrxReport; User: String = '') of object;
  TfrxServerGetVariablesEvent = procedure(const ReportName: String;
    Variables: TfrxVariables; User: String = '') of object;
  TfrxServerAfterBuildReport = procedure(const ReportName: String;
    Variables: TfrxVariables; User: String = '') of object;

  PSecHandle = ^TSecHandle;
  TSecHandle = record
    dwLower: Cardinal;
    dwUpper: Cardinal;
  end;
  TCredHandle = TSecHandle;
  PCredHandle = ^TCredHandle;
  PCtxtHandle = ^TCtxtHandle;
  TCtxtHandle = TSecHandle;

  PSecBuffer = ^TSecBuffer;
  TSecBuffer = record
    cbBuffer: Cardinal;
    BufferType: Cardinal;
    pvBuffer: Pointer;
  end;

  PSecBufferDesc = ^TSecBufferDesc;
  TSecBufferDesc = record
    ulVersion: Cardinal;
    cBuffers: Cardinal;
    pBuffers: PSecBuffer;
  end;

  PTimeStamp = ^TTimeStamp;
  TTimeStamp = Currency;

  PSecPkgInfo = ^TSecPkgInfo;
  TSecPkgInfo = record
    fCapabilities: Cardinal;
    wVersion: Word;
    wRPCID: Word;
    cbMaxToken: Cardinal;
    Name: PChar;
    Comment: PChar;
  end;

{$IFDEF DELPHI16}
[ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxReportServer = class(TComponent)
  private
    FActive: Boolean;
    FAllow: TStrings;
    FDeny: TStrings;
    FGetReport: TfrxServerGetReportEvent;
    FPDFPrint: Boolean;
    FTotals: TStrings;
    FConfigLoaded: Boolean;
    FVariables: TfrxServerVariables;
    FWebServer: TfrxHTTPServer;
    FGetVariables: TfrxServerGetVariablesEvent;
    FBuildReport: TfrxServerAfterBuildReport;
    FBusy: Boolean;
//    FADOComponents: TfrxADOComponents;
//    FADOConnection: TADOConnection;

{$IFDEF FR_FIB}
    FFIBComponents: TfrxFIBComponents;
    FfrxFIBConnection: TfrxFIBDatabase;
{$ENDIF}

    FSocketOpen: Boolean;
    FConfigFileName: String;
    FGuard: TfrxServerGuard;
    FPrint: Boolean;
    function GetTotals: TStrings;
    procedure SetActive(const Value: Boolean);
    procedure StatToVar;
//    procedure IdleEventHandler(Sender: TObject; var Done: Boolean);
    procedure Initialize;
  public
    constructor Create(AOwner: TComponent); override;
    constructor CreateWithRoot(const Folder: String; const Socket: Boolean);
    destructor Destroy; override;
    procedure Open;
    procedure Close;
    procedure Get(Data: TfrxServerData);
    function LoadConfigs: Boolean;
    property Totals: TStrings read GetTotals;
    property Variables: TfrxServerVariables read FVariables;
    property WebServer: TfrxHTTPServer read FWebServer;
  published
    procedure Loaded; override;
    property Active: Boolean read FActive write SetActive;
    property AllowIP: TStrings read FAllow write FAllow;
    property DenyIP: TStrings read FDeny write FDeny;
    property PrintPDF: Boolean read FPDFPrint write FPDFPrint;
    property Print: Boolean read FPrint write FPrint;
    property OnGetReport: TfrxServerGetReportEvent read FGetReport
      write FGetReport;
    property OnGetVariables: TfrxServerGetVariablesEvent read FGetVariables
      write FGetVariables;
    property OnAfterBuildReport: TfrxServerAfterBuildReport read FBuildReport
      write FBuildReport;
    property SocketOpen: Boolean read FSocketOpen write FSocketOpen;
    property ConfigFileName: String read FConfigFileName write FConfigFileName;
  end;

  TfrxHTTPServer = class(TServerSocket)
  private
    FBasePath: String;
    FGzip: Boolean;
    FMainDocument: String;
    FNoCacheHeader: Boolean;
    FParentReportServer: TfrxReportServer;
    FReportPath: String;
    FSocketTimeOut: Integer;
    FMaxHTTPHeaderSize: Integer;
    FMaxContentSize: Int64;
    procedure ClientAccept(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientError(Sender: TObject; Socket: TCustomWinSocket;
         ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure GetThread(Sender: TObject; ClientSocket: TServerClientWinSocket;
         var SocketThread: TServerClientThread);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property BasePath: String read FBasePath write FBasePath;
    property Gzip: Boolean read FGzip write FGzip;
    property MainDocument: String read FMainDocument write FMainDocument;
    property NoCacheHeader: Boolean read FNoCacheHeader write FNoCacheHeader;
    property ParentReportServer: TfrxReportServer read FParentReportServer
      write FParentReportServer;
    property ReportPath: String read FReportPath write FReportPath;
    property SocketTimeOut: Integer read FSocketTimeOut write FSocketTimeOut;
  end;

  TfrxServerSession = class(TServerClientThread)
  private
    FAuthNeeded: Boolean;
    FDialog: Boolean;
    FDialogSessionId: AnsiString;
    FErrorCode: Integer;
    FErrorText: AnsiString;
    FFormat: TfrxServerFormat;
    FGzip: Boolean;
    FHeader: AnsiString;
    FHost: AnsiString;
    FHTTPVersion: AnsiString;
    FIsReport: Boolean;
    FKeepAlive: boolean;
    FMethod: AnsiString;
    FMIMEType: AnsiString;
    FMultipage: Boolean;
    FName: AnsiString;
    FReportName: AnsiString;
    FGroup: AnsiString;
    FNoCacheHeader: Boolean;
    FPageNavigator: Boolean;
    FPageRange: String;
    FParentHTTPServer: TfrxHTTPServer;
    FParentReportServer: TfrxReportServer;
    FRedirect: Boolean;
    FReferer: AnsiString;
    FRemoteIP: String;
    FReplyBody: TStringList;
    FReplyHeader: TStringList;
    FRepSession: TfrxReportSession;
    FResultPage: String;
    FServerReplyData: TStringList;
    FSessionId: AnsiString;
    FSessionItem: TfrxSessionItem;
    FSize: integer;
    FUserAgent: AnsiString;
    FVariables: TfrxVariables;
    FStream: TMemoryStream;
    FFileDate: TDateTime;
    FCacheId: String;
    FPrn: String;
    FBrowserPrn: Boolean;
    FLogin: String;
    FCookie: AnsiString;
    FPassword: String;
    FReportMessage: String;
    FReturnData: AnsiString;
    FIsExportRedirect: Boolean;
    FInParams: TStringList;
    FOutParams: TStringList;
    FData: TfrxServerData;
    FActive: Boolean;
    FAuthInProgress: Boolean;
    FAuthResponse: AnsiString;
    FAuthFinished: Boolean;
    FAuthNewConv: Boolean;
    FMaxTokenSize: integer;
    FCredHandle: TSecHandle;
    FExpire: TTimeStamp;
    FToken: cardinal;
    FContextHandle: TSecHandle;
    FAuthType: String;
    FLocalVariables: TfrxServerVariables;
    FReportTitle: String;
    FmPage: String;
    FContentMD5: AnsiString;
    FContentLength: Int64;
    FIsFP3: Boolean;
    FBoundary: AnsiString;
    FFormFileName: String;

    function InitAuth(const SecPackageName: String): boolean;
    function ProcessAuthRequest(AuthRequest: AnsiString; NewConversation: boolean; var AuthResponse: AnsiString;
      var ContextHandle: TSecHandle; var AuthFinished: boolean): boolean;
    procedure FinalAuth;
    function GetCurrentUserToken: TfrHandle;
    function CheckBadPath: Boolean;
    function CheckDeflate(FileName: String): Boolean;
    function CheckSSI(FileName: String): Boolean;
    function ParseHeaderField(const Field: AnsiString): AnsiString; overload;
    function ParseHeaderField(const Field: AnsiString; Const aHeader: AnsiString): AnsiString; overload;
    function ParseParam(S: String): String;
    function GetMime(s: String): String;
    procedure CheckAuth;
    procedure CloseSession;
    procedure CreateReplyHTTPData;
    procedure ErrorLog;
    procedure MakeServerReply;
    procedure ParseHTTPHeader;
    procedure ParseParameters;
    procedure SelectFormat(FormatName: String);
    procedure IsFP3Content(aContent: AnsiString);
    procedure UpdateLocalVariables;
    procedure UpdateSessionFName;
    procedure WriteLogs;
    procedure DoGetVariables;
    procedure AddOutData(const Name: String; const Value: String);
    procedure WriteHtmlReportIndex(OutStream: TfrxSSIStream);
  public
    constructor Create(CreateSuspended: Boolean;
      ASocket: TServerClientWinSocket);
    destructor Destroy; override;
    procedure ClientExecute; override;
    procedure PrepareReportQuery;

    function GetSessionPath: AnsiString;

    property NoCacheHeader: Boolean read FNoCacheHeader write FNoCacheHeader;
    property ParentHTTPServer: TfrxHTTPServer read FParentHTTPServer
      write FParentHTTPServer;
    property ParentReportServer: TfrxReportServer read FParentReportServer
      write FParentReportServer;
    property SessionId: AnsiString read GetSessionPath write FSessionId;
    property SessionItem: TfrxSessionItem read FSessionItem write FSessionItem;
    property Login: String read FLogin;
    property Password: String read FPassword;
    property Data: TfrxServerData read FData write FData;
    property Active: Boolean read FActive write FActive;
    property LocalVariables: TfrxServerVariables read FLocalVariables;
  end;

  TfrxServerData = class(TObject)
  private
    FErrorCode: Integer;
    FInParams: TStringList;
    FOutParams: TStringList;
    FStream: TMemoryStream;
    FFileName: String;
    FHeader: String;
    FRepHeader: String;
    FHTTPVer: String;
    FLastMod: TDateTime;
    FExpires: TDateTime;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TfrxServerData);

    property InParams: TStringList read FInParams;
    property OutParams: TStringList read FOutParams;
    property ErrorCode: Integer read FErrorCode write FErrorCode;
    property Stream: TMemoryStream read FStream;
    property FileName: String read FFileName write FFileName;
    property Header: String read FHeader write FHeader;
    property RepHeader: String read FRepHeader write FRepHeader;
    property HTTPVer: String read FHTTPVer write FHTTPVer;
    property Expires: TDateTime read FExpires write FExpires;
    property LastMod: TDateTime read FLastMod write FLastMod;
  end;

  TfrxServerGuard = class(TThread)
  private
    FTimeOut: Integer;
    FServer: TfrxReportServer;
    FListTimeOut: Integer;
    procedure DoLoadConf;
  protected
    procedure Execute; override;
  public
    constructor Create(Server: TfrxReportServer);
    destructor Destroy; override;
    property TimeOut: Integer read FTimeOut write FTimeOut;
    property ListTimeOut: Integer read FListTimeOut write FListTimeOut;
  end;

const
  MAX_IE_GZIP = 4096;
  SERVER_NAME = 'FastReport VCL Enterprise'{$IFDEF FR_FIB} + ' Firebird edition'{$ENDIF};
  SERVER_VERSION = FR_VERSION;
  SERVER_DATA = '';
  SID_SIGN = 'sid_f';
  SID_STORE = 'store_';

implementation

uses frxUtils, frxFileUtils, SyncObjs, StrUtils, frxMutex{$IFNDEF Linux}, ComObj{$ENDIF};

const
  SERVER_COPY = '&copy; Copyright 1998-2020 by Fast Reports Inc.';
  METHOD_GET = 'GET';
  METHOD_POST = 'POST';
  HTML = 'text/html';
  ERR_UNKNOWN_METHOD = '1';
  ERR_OK = '0';
  SECPKG_CRED_INBOUND  = $00000001;
  SECBUFFER_VERSION = 0;
  SECBUFFER_TOKEN = 2;
  SECURITY_NATIVE_DREP = $00000010;
  SEC_I_COMPLETE_NEEDED = HRESULT($00090313);
  SEC_I_COMPLETE_AND_CONTINUE = HRESULT($00090314);
  SEC_I_CONTINUE_NEEDED = HRESULT($00090312);
  NameSamCompatible = 2;
  secur32 = 'secur32.dll';
  MAX_HTTP_HEADER_SIZE = 16384;

type
  TSecGetKeyFn = procedure (
    Arg: Pointer;
    Principal: Pointer;
    KeyVer: Cardinal;
    var Key: Pointer;
    var Status: Cardinal); stdcall;
{$IFNDEF Linux}
{$IFDEF WIN64}
  TfrxAcceptSecurityContext = function (phCredential: PCredHandle; phContext: PCtxtHandle;
    pInput: PSecBufferDesc; fContextReq, TargetDataRep: Cardinal;
    phNewContext: PCtxtHandle; pOutput: PSecBufferDesc; var pfContextAttr: Cardinal;
    ptsExpiry: PTimeStamp): Cardinal; stdcall;
  TfrxCompleteAuthToken = function (phContext: PCtxtHandle; pToken: PSecBufferDesc): Cardinal; stdcall;
  TfrxImpersonateSecurityContext = function(phContext: PCtxtHandle): Cardinal; stdcall;
  TfrxRevertSecurityContext = function (phContext: PCtxtHandle): Cardinal; stdcall;
  TfrxQuerySecurityPackageInfo = function (pszPackageName: PChar;
    var ppPackageInfo: PSecPkgInfo): Cardinal; stdcall;
  TfrxAcquireCredentialsHandle = function (pszPrincipal, pszPackage: PChar;
    fCredentialUse: Cardinal; pvLogonId, pAuthData: Pointer;
    pGetKeyFn: TSecGetKeyFn; pvGetKeyArgument: Pointer; phCredential: PCredHandle;
    var ptsExpiry: TTimeStamp): Cardinal; stdcall;
  TfrxFreeCredentialsHandle = function (phCredential: PCredHandle): Cardinal; stdcall;
  TfrxFreeContextBuffer = function (pvContextBuffer: Pointer): Cardinal; stdcall;
  TfrxGetUserNameEx = function (NameFormat: cardinal; lpNameBuffer: PChar;
    var nSize: cardinal): ByteBool; stdcall;
{$ENDIF}

function AcceptSecurityContext(phCredential: PCredHandle; phContext: PCtxtHandle;
  pInput: PSecBufferDesc; fContextReq, TargetDataRep: Cardinal;
  phNewContext: PCtxtHandle; pOutput: PSecBufferDesc; var pfContextAttr: Cardinal;
  ptsExpiry: PTimeStamp): Cardinal; stdcall; forward;

function CompleteAuthToken(phContext: PCtxtHandle; pToken: PSecBufferDesc): Cardinal; stdcall; forward;

function ImpersonateSecurityContext(phContext: PCtxtHandle): Cardinal; stdcall; forward;

function RevertSecurityContext(phContext: PCtxtHandle): Cardinal; stdcall; forward;

function QuerySecurityPackageInfo(pszPackageName: PChar;
  var ppPackageInfo: PSecPkgInfo): Cardinal; stdcall; forward;

function AcquireCredentialsHandle(pszPrincipal, pszPackage: PChar;
  fCredentialUse: Cardinal; pvLogonId, pAuthData: Pointer;
  pGetKeyFn: TSecGetKeyFn; pvGetKeyArgument: Pointer; phCredential: PCredHandle;
  var ptsExpiry: TTimeStamp): Cardinal; stdcall; forward;

function FreeCredentialsHandle(phCredential: PCredHandle): Cardinal; stdcall; forward;

function FreeContextBuffer(pvContextBuffer: Pointer): Cardinal; stdcall; forward;

function GetUserNameEx(NameFormat: cardinal; lpNameBuffer: PChar;
  var nSize: cardinal): ByteBool; stdcall; forward;
{$ENDIF}


var
  ServCS: TCriticalSection;
{$IFNDEF Linux}
{$IFDEF WIN64}
  _AcceptSecurityContext: TfrxAcceptSecurityContext;
  _CompleteAuthToken: TfrxCompleteAuthToken;
  _ImpersonateSecurityContext: TfrxImpersonateSecurityContext;
  _RevertSecurityContext: TfrxRevertSecurityContext;
  _QuerySecurityPackageInfo: TfrxQuerySecurityPackageInfo;
  _AcquireCredentialsHandle: TfrxAcquireCredentialsHandle;
  _FreeCredentialsHandle: TfrxFreeCredentialsHandle;
  _FreeContextBuffer: TfrxFreeContextBuffer;
  _GetUserNameEx: TfrxGetUserNameEx;
{$ELSE}
  _AcceptSecurityContext: Pointer;
  _CompleteAuthToken: Pointer;
  _ImpersonateSecurityContext: Pointer;
  _RevertSecurityContext: Pointer;
  _QuerySecurityPackageInfo: Pointer;
  _AcquireCredentialsHandle: Pointer;
  _FreeCredentialsHandle: Pointer;
  _FreeContextBuffer: Pointer;
  _GetUserNameEx: Pointer;
{$ENDIF}

procedure GetProcedureAddress(var P: Pointer; const ModuleName, ProcName: string);
var ModuleHandle: HMODULE;
begin
  if not Assigned(P) then
  begin
    ModuleHandle := GetModuleHandle(PChar(ModuleName));
    if ModuleHandle = 0 then
    begin
      ModuleHandle := LoadLibrary(PChar(ModuleName));
      if ModuleHandle = 0 then
        raise Exception.Create('Library not found: ' + ModuleName);
    end;
    P := GetProcAddress(ModuleHandle, PChar(ProcName));
    if not Assigned(P) then
      raise Exception.Create('Function not found: ' + ModuleName + '.' + ProcName);
  end;
end;

{$IFNDEF DELPHI12}
{$WARNINGS OFF}
{$ENDIF}

{$IFDEF WIN64}

function AcceptSecurityContext(phCredential: PCredHandle; phContext: PCtxtHandle;
  pInput: PSecBufferDesc; fContextReq, TargetDataRep: Cardinal;
  phNewContext: PCtxtHandle; pOutput: PSecBufferDesc; var pfContextAttr: Cardinal;
  ptsExpiry: PTimeStamp): Cardinal; stdcall;
begin
  GetProcedureAddress(@_AcceptSecurityContext, secur32, 'AcceptSecurityContext');
  if @_AcceptSecurityContext <> nil then
    Result := _AcceptSecurityContext(phCredential, phContext,
       pInput, fContextReq, TargetDataRep,
       phNewContext, pOutput, pfContextAttr, ptsExpiry);
end;

function CompleteAuthToken(phContext: PCtxtHandle; pToken: PSecBufferDesc): Cardinal; stdcall;
begin
  GetProcedureAddress(@_CompleteAuthToken, secur32, 'CompleteAuthToken');
  if @_CompleteAuthToken <> nil then
    Result := _CompleteAuthToken(phContext, pToken);
end;

function ImpersonateSecurityContext(phContext: PCtxtHandle): Cardinal; stdcall;
begin
  GetProcedureAddress(@_ImpersonateSecurityContext, secur32, 'ImpersonateSecurityContext');
  if @_ImpersonateSecurityContext <> nil then
    Result := _ImpersonateSecurityContext(phContext);
end;

function RevertSecurityContext(phContext: PCtxtHandle): Cardinal; stdcall;
begin
  GetProcedureAddress(@_RevertSecurityContext, secur32, 'RevertSecurityContext');
  if @_RevertSecurityContext <> nil then
    Result := _RevertSecurityContext(phContext);
end;

function QuerySecurityPackageInfo(pszPackageName: PChar;
  var ppPackageInfo: PSecPkgInfo): Cardinal; stdcall;
begin
  GetProcedureAddress(@_QuerySecurityPackageInfo, secur32, 'QuerySecurityPackageInfoA');
  if @_QuerySecurityPackageInfo <> nil then
    Result := _QuerySecurityPackageInfo(pszPackageName, ppPackageInfo);
end;

function AcquireCredentialsHandle(pszPrincipal, pszPackage: PChar;
  fCredentialUse: Cardinal; pvLogonId, pAuthData: Pointer;
  pGetKeyFn: TSecGetKeyFn; pvGetKeyArgument: Pointer; phCredential: PCredHandle;
  var ptsExpiry: TTimeStamp): Cardinal; stdcall;
begin
  GetProcedureAddress(@_AcquireCredentialsHandle, secur32, 'AcquireCredentialsHandleA');
  if  @_AcquireCredentialsHandle <> nil then
    Result := _AcquireCredentialsHandle(pszPrincipal, pszPackage,
      fCredentialUse, pvLogonId, pAuthData,
      pGetKeyFn, pvGetKeyArgument, phCredential, ptsExpiry);
end;

function FreeCredentialsHandle(phCredential: PCredHandle): Cardinal; stdcall;
begin
  GetProcedureAddress(@_FreeCredentialsHandle, secur32, 'FreeCredentialsHandle');
  if @_FreeCredentialsHandle <> nil then
    Result := _FreeCredentialsHandle(phCredential);
end;

function FreeContextBuffer(pvContextBuffer: Pointer): Cardinal; stdcall;
begin
  GetProcedureAddress(@_FreeContextBuffer, secur32, 'FreeContextBuffer');
  if @_FreeContextBuffer <> nil then
    Result := _FreeContextBuffer(pvContextBuffer);
end;

function GetUserNameEx(NameFormat: cardinal; lpNameBuffer: PChar;
  var nSize: cardinal): ByteBool; stdcall;
begin
  GetProcedureAddress(@_GetUserNameEx, secur32, 'GetUserNameExA');
  if @_GetUserNameEx <> nil then
    Result := _GetUserNameEx(NameFormat, lpNameBuffer, nSize);
end;

{$ELSE}

function FreeContextBuffer;
begin
  GetProcedureAddress(_FreeContextBuffer, secur32, 'FreeContextBuffer');
  asm
    mov esp, ebp
    pop ebp
    jmp [_FreeContextBuffer]
  end;
end;

function FreeCredentialsHandle;
begin
  GetProcedureAddress(_FreeCredentialsHandle, secur32, 'FreeCredentialsHandle');
  asm
    mov esp, ebp
    pop ebp
    jmp [_FreeCredentialsHandle]
  end;
end;

function AcquireCredentialsHandle;
begin
  GetProcedureAddress(_AcquireCredentialsHandle, secur32, 'AcquireCredentialsHandleA');
  asm
    mov esp, ebp
    pop ebp
    jmp [_AcquireCredentialsHandle]
  end;
end;

function AcceptSecurityContext;
begin
  GetProcedureAddress(_AcceptSecurityContext, secur32, 'AcceptSecurityContext');
  asm
    mov esp, ebp
    pop ebp
    jmp [_AcceptSecurityContext]
  end;
end;

function CompleteAuthToken;
begin
  GetProcedureAddress(_CompleteAuthToken, secur32, 'CompleteAuthToken');
  asm
    mov esp, ebp
    pop ebp
    jmp [_CompleteAuthToken]
  end;
end;

function ImpersonateSecurityContext;
begin
  GetProcedureAddress(_ImpersonateSecurityContext, secur32, 'ImpersonateSecurityContext');
  asm
    mov esp, ebp
    pop ebp
    jmp [_ImpersonateSecurityContext]
  end;
end;

function RevertSecurityContext;
begin
  GetProcedureAddress(_RevertSecurityContext, secur32, 'RevertSecurityContext');
  asm
    mov esp, ebp
    pop ebp
    jmp [_RevertSecurityContext]
  end;
end;

function QuerySecurityPackageInfo;
begin
  GetProcedureAddress(_QuerySecurityPackageInfo, secur32, 'QuerySecurityPackageInfoA');
  asm
    mov esp, ebp
    pop ebp
    jmp [_QuerySecurityPackageInfo]
  end;
end;

function GetUserNameEx;
begin
  GetProcedureAddress(_GetUserNameEx, secur32, 'GetUserNameExA');
  asm
    mov esp, ebp
    pop ebp
    jmp [_GetUserNameEx]
  end;
end;
{$ENDIF}
{$ENDIF}
{$IFNDEF DELPHI12}
{$WARNINGS ON}
{$ENDIF}

{ TfrxReportServer }

function TfrxReportServer.LoadConfigs: Boolean;
begin
  result := ServerConfig.LoadFromFile(frxGetAbsPathDir(FConfigFileName, ServerConfig.ConfigFolder)) <> E_FAIL;
  if result then
    ServerUsers.LoadFromFile(frxGetAbsPathDir(ServerConfig.GetValue('server.security.usersfile'), ServerConfig.ConfigFolder));
end;

procedure TfrxReportServer.Loaded;
begin
  if csLoading in ComponentState then
    Initialize;
  inherited;
end;

procedure TfrxReportServer.Initialize;
var
  s: String;
  templates_path, root_path, config_path: String;
begin

  if FConfigFileName = '' then
    FConfigFileName := 'config.xml';
  FConfigLoaded := LoadConfigs;

  if FConfigLoaded then
  begin
    LogWriter := TfrxServerLog.Create;
    templates_path := frxGetAbsPathDir(ServerConfig.GetValue('server.http.templatespath'), ServerConfig.ConfigFolder);
    root_path := frxGetAbsPathDir(ServerConfig.GetValue('server.http.rootpath'), ServerConfig.ConfigFolder);

    CopyFiles(templates_path, root_path, '*.js *.css', '', false);
    s := 'FrImages';
    if not DirectoryExists(root_path + s) then
      CreateDir(root_path + s);
    CopyFiles(templates_path + s, root_path + s, '*.*', '', true);

    LogWriter.MaxLogSize := StrToInt(ServerConfig.GetValue('server.logs.rotatesize'));
    LogWriter.MaxLogFiles := StrToInt(ServerConfig.GetValue('server.logs.rotatefiles'));
    LogWriter.LogDir := frxGetAbsPathDir(ServerConfig.GetValue('server.logs.path'), ServerConfig.ConfigFolder);
    LogWriter.AddLevel(ServerConfig.GetValue('server.logs.errorlog'));
    LogWriter.AddLevel(ServerConfig.GetValue('server.logs.accesslog'));
    LogWriter.AddLevel(ServerConfig.GetValue('server.logs.refererlog'));
    LogWriter.AddLevel(ServerConfig.GetValue('server.logs.agentlog'));
    LogWriter.AddLevel(ServerConfig.GetValue('server.logs.serverlog'));
    LogWriter.AddLevel(ServerConfig.GetValue('server.logs.schedulerlog'));

    FBusy := False;
{
    FADOConnection := TADOConnection.Create(nil);
    FADOConnection.LoginPrompt := False;
    FADOConnection.ConnectionString := ServerConfig.GetValue('server.database.connectionstring');
    FADOConnection.Name := 'ADOConnection';
    FADOComponents := TfrxADOComponents.Create(nil);
    FADOComponents.DefaultDatabase := FADOConnection;
}
  {$IFDEF FR_FIB}
    FfrxFIBConnection := TfrxFIBDatabase.Create(nil);
    FfrxFIBConnection.FromString(ServerDB.GetFIBConnectionString(ServerConfig.GetValue('server.database.connection')));
    FFIBComponents := TfrxFIBComponents.Create(nil);
    FFIBComponents.DefaultDatabase := FfrxFIBConnection.Database;
    try
      FfrxFIBConnection.Database.SQLDialect := 3;
      FfrxFIBConnection.Database.Open;
    except
      on E:Exception do
      begin
        LogWriter.Write(SERVER_LEVEL, 'DATABASE ERROR! ' + E.Message + #13#10);
      end;
    end;
  {$ENDIF}

    FAllow := TfrxStringListMask.Create;
    FDeny := TfrxStringListMask.Create;

    s := frxGetAbsPathDir(ServerConfig.GetValue('server.security.allowfile'), ServerConfig.ConfigFolder);
    if FileExists(s) then
      FAllow.LoadFromFile(s{$IFDEF DELPHI12},TEncoding.UTF8{$ENDIF});
    s := frxGetAbsPathDir(ServerConfig.GetValue('server.security.denyfile'), ServerConfig.ConfigFolder);
    if FileExists(s) then
      FDeny.LoadFromFile(s{$IFDEF DELPHI12},TEncoding.UTF8{$ENDIF});

    FTotals := TStringList.Create;
    LogWriter.Write(SERVER_LEVEL, DateTimeToStr(Now) + #9'Started');
    LogWriter.Write(SERVER_LEVEL, 'Logs path:' + #9 + frxGetAbsPathDir(ServerConfig.GetValue('server.logs.path'), ServerConfig.ConfigFolder));
    LogWriter.Write(SERVER_LEVEL, 'Reports path:' + #9 + frxGetAbsPathDir(ServerConfig.GetValue('server.reports.path'), ServerConfig.ConfigFolder));
    LogWriter.Write(SERVER_LEVEL, 'Reports cache path:' + #9 + frxGetAbsPathDir(ServerConfig.GetValue('server.cache.path'), ServerConfig.ConfigFolder));
    LogWriter.Write(SERVER_LEVEL, 'Root path:' + #9 + root_path);
    config_path := '';
    if ExtractFileName(FConfigFileName) = FConfigFileName then
      config_path := frGetAppPath;
    if FileExists(config_path + FConfigFileName) then
      LogWriter.Write(SERVER_LEVEL, 'Config file:' + #9 + FConfigFileName)
    else
      LogWriter.Write(SERVER_LEVEL, 'ERROR! Config file ' + FConfigFileName + ' not found!');

    SessionManager := TfrxSessionManager.Create;
    FWebServer := TfrxHTTPServer.Create(nil);
    FWebServer.ParentReportServer := Self;
    ReportCache := TfrxServerCache.Create;
    ResultCache := TfrxResultCache.Create(root_path, SID_STORE);
    ServerStatistic := TfrxServerStatistic.Create;
    FVariables := TfrxServerVariables.Create;
    ServerPrinter := TfrxServerPrinter.Create;
  {$IFDEF FR_SERVER}
    ServerScheduler := TfrxScheduleThread.Create;
    ServerScheduler.Suspended := False;
  {$ENDIF}
    ServerUsers.LoadFromFile(ServerConfig.GetValue('server.security.usersfile'));

  {$IFDEF TRIAL}
    s := SERVER_NAME + ' D';
    s := s + 'e';
    s := s + 'm';
    s := s + 'o';
    FVariables.AddVariable('SERVER_NAME', s);
  {$ELSE}
    FVariables.AddVariable('SERVER_NAME', ServerConfig.GetValue('server.name'));
  {$ENDIF}

    FVariables.AddVariable('SERVER_COPYRIGHT', SERVER_COPY);
    FVariables.AddVariable('SERVER_SOFTWARE', SERVER_VERSION);
    FVariables.AddVariable('SERVER_LAST_UPDATE', SERVER_DATA);

    FPDFPrint := False;
    FPrint := True;
    Active := False;

    ReportCache.Clear;
    ResultCache.Clear;
    ReportsList := TfrxServerReportsList.Create;

    LogWriter.Active := ServerConfig.GetBool('server.logs.active');

    FGuard := TfrxServerGuard.Create(Self);
  end;

end;

constructor TfrxReportServer.CreateWithRoot(const Folder: String; const Socket: Boolean);
begin
  inherited Create(nil);
  FSocketOpen := Socket;
  FConfigLoaded := false;
  ServerConfig.ConfigFolder := Folder;
  if not(csLoading in ComponentState) then
    Initialize;
end;

constructor TfrxReportServer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FConfigLoaded := false;
  ServerConfig.ConfigFolder := frGetAppPath;
  FSocketOpen := True;
  if not((AOwner <> nil) and (csLoading in AOwner.ComponentState)) then
    Initialize;
end;

destructor TfrxReportServer.Destroy;
begin
  if FConfigLoaded then
  begin
//    FADOConnection.Free;
//    FADOComponents.Free;

  {$IFDEF FR_SERVER}
    ServerScheduler.Terminate;
    PMessages;
    ServerScheduler.WaitFor;
    ServerScheduler.Free;
  {$IFDEF FR_FIB}
    FfrxFIBConnection.Free;
    FFIBComponents.Free;
  {$ENDIF}
  {$ENDIF}
    FWebServer.Free;
    ReportCache.Terminate;
    ResultCache.Terminate;
    PMessages;
    ReportCache.Free;
    ResultCache.Free;
    ServerPrinter.Terminate;
    PMessages;
    ServerPrinter.Free;
    FGuard.Terminate;
    PMessages;
    FGuard.Free;
    FAllow.Free;
    FDeny.Free;
    LogWriter.Write(SERVER_LEVEL, DateTimeToStr(Now) + #9'Stopped'#9 + #13#10 + Totals.Text);
    LogWriter.Flush;
    if Active then
      Active := False;
    ServerStatistic.Free;
    SessionManager.Free;
    FTotals.Free;
    FVariables.Free;
    LogWriter.Free;
    ReportsList.Free;
  end;
  inherited;
end;

procedure TfrxReportServer.SetActive(const Value: Boolean);
begin
  if FConfigLoaded and SocketOpen then
  begin
    try
      FWebServer.Active := Value;
    except
      on E:Exception do
      begin
        if Value then
          LogWriter.Write(SERVER_LEVEL, DateTimeToStr(Now) + #9'Port open failed. ' + E.Message + #13#10)
        else
          LogWriter.Write(SERVER_LEVEL, DateTimeToStr(Now) + #9'Port close failed. ' + E.Message + #13#10)
      end;
    end;
  end;
  if FConfigLoaded and (FWebServer.Active = Value) then
    FActive := Value;
end;

procedure TfrxReportServer.Open;
begin
  if FConfigLoaded and ServerConfig.GetBool('server.security.reportslist') then
  begin
    ReportsList.ReportsPath := frxGetAbsPathDir(ServerConfig.GetValue('server.reports.path'), ServerConfig.ConfigFolder);
    ReportsList.BuildListOfReports;
    Active := True;
  end;
end;

procedure TfrxReportServer.Close;
begin
  if FConfigLoaded  then
  begin
    Active := False;
    ReportCache.Clear;
    ResultCache.Clear;
  end;
end;

function TfrxReportServer.GetTotals: TStrings;
begin
  FTotals.Clear;
  FTotals.Add('Uptime: ' + ServerStatistic.FormatUpTime);
  FTotals.Add('Total sessions: ' + IntToStr(ServerStatistic.TotalSessionsCount));
  FTotals.Add('Total reports: ' + IntToStr(ServerStatistic.TotalReportsCount));
  FTotals.Add('Total cache hits: ' + IntToStr(ServerStatistic.TotalCacheHits));
  FTotals.Add('Total errors: ' + IntToStr(ServerStatistic.TotalErrors));
  FTotals.Add('Max sessions: ' + IntToStr(ServerStatistic.MaxSessionsCount));
  FTotals.Add('Max reports: ' + IntToStr(ServerStatistic.MaxReportsCount));
  Result := FTotals;
end;

procedure TfrxReportServer.StatToVar;
begin
  FVariables.AddVariable('SERVER_UPTIME', ServerStatistic.FormatUpTime);
  FVariables.AddVariable('SERVER_TOTAL_SESSIONS', IntToStr(ServerStatistic.TotalSessionsCount));
  FVariables.AddVariable('SERVER_TOTAL_REPORTS', IntToStr(ServerStatistic.TotalReportsCount));
  FVariables.AddVariable('SERVER_TOTAL_ERRORS', IntToStr(ServerStatistic.TotalErrors));
  FVariables.AddVariable('SERVER_TOTAL_CACHE', IntToStr(ServerStatistic.TotalCacheHits));
  FVariables.AddVariable('SERVER_MAX_SESSIONS', IntToStr(ServerStatistic.MaxSessionsCount));
  FVariables.AddVariable('SERVER_MAX_REPORTS', IntToStr(ServerStatistic.MaxReportsCount));
  FVariables.AddVariable('SERVER_CURRENT_SESSIONS', IntToStr(ServerStatistic.CurrentSessionsCount));
  FVariables.AddVariable('SERVER_CURRENT_REPORTS', IntToStr(ServerStatistic.CurrentReportsCount));
end;

procedure TfrxReportServer.Get(Data: TfrxServerData);
var
  Session: TfrxServerSession;
  Socket: TServerClientWinSocket;
begin
  Socket := TServerClientWinSocket.Create(-1, FWebServer.Socket);
  FWebServer.GetThread(nil, Socket, TServerClientThread(Session));
  Session.Data := Data;
  Session.Active := True;
  Session.Resume;
  while Session.Active do
    Sleep(10);
  SessionManager.CompleteSessionId(String(TCustomWinSocket(Socket).Data));
end;

{ TfrxHTTPServer }

constructor TfrxHTTPServer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Active := False;
  ServerType := stThreadBlocking;
  Port := StrToInt(ServerConfig.GetValue('server.http.port'));
  FGzip := ServerConfig.GetBool('server.http.compression');
  FMainDocument := ServerConfig.GetValue('server.http.indexfile');
  FBasePath := frxGetAbsPathDir(ServerConfig.GetValue('server.http.rootpath'), ServerConfig.ConfigFolder);
  FSocketTimeOut := StrToInt(ServerConfig.GetValue('server.http.sockettimeout'));
  FNoCacheHeader := ServerConfig.GetBool('server.http.nocacheheader');
  FMaxHTTPHeaderSize := ServerConfig.GetNumber('server.http.headermaxsize');
  if (FMaxHTTPHeaderSize > MAX_HTTP_HEADER_SIZE) or (FMaxHTTPHeaderSize <= 0) then
    FMaxHTTPHeaderSize := MAX_HTTP_HEADER_SIZE;
  FMaxContentSize := ServerConfig.GetNumber('server.http.contentmaxsize') * 1024 * 1024; // MB
  OnClientError := ClientError;
  OnClientDisconnect := ClientDisconnect;
  OnAccept := ClientAccept;
  OnGetThread := GetThread;
  LogWriter.Write(SERVER_LEVEL, DateTimeToStr(Now) + #9'HTTP server created');
end;

destructor TfrxHTTPServer.Destroy;
begin
  LogWriter.Write(SERVER_LEVEL, DateTimeToStr(Now) + #9'HTTP server closed');
  inherited;
end;

procedure TfrxHTTPServer.ClientError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
  if (ErrorCode <> 10053) and (ErrorCode <> 10054) then
  begin
    LogWriter.Write(ERROR_LEVEL, DateTimeToStr(Now) + #9 + Socket.RemoteAddress + #9 + GetSocketErrorText(ErrorCode));
    LogWriter.ErrorReached;
  end;
  ErrorCode := 0;
  SessionManager.CompleteSessionId(String(TCustomWinSocket(Socket).Data));
  Socket.Close;
end;

procedure TfrxHTTPServer.ClientDisconnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  SessionManager.CompleteSessionId(String(TCustomWinSocket(Socket).Data));
end;

procedure TfrxHTTPServer.GetThread(Sender: TObject;
  ClientSocket: TServerClientWinSocket;  var SocketThread: TServerClientThread);
var
  MaxSessions: Integer;
  SessionTimeout: Integer;
begin
  try

    MaxSessions := ServerConfig.GetNumber('server.http.maxsessions');
    SessionTimeout := ServerConfig.GetNumber('server.http.sessiontimeout') * 1000;

    if MaxSessions > 0 then
    begin
      while LogWriter.CurrentSessions > MaxSessions do
      begin
        if SessionTimeout = 0 then
        begin
          LogWriter.Write(ERROR_LEVEL, DateTimeToStr(Now) + #9 + ClientSocket.RemoteAddress + ' Maximum count of sessions has been reached.. ');
          exit;
        end
        else
          Dec(SessionTimeout);
        PMessages;
      end;
    end;

    SocketThread := TfrxServerSession.Create(True, ClientSocket);
    SocketThread.FreeOnTerminate := True;
    SocketThread.KeepInCache := False;
    TfrxServerSession(SocketThread).ParentReportServer := ParentReportServer;
    TfrxServerSession(SocketThread).ParentHTTPServer := Self;
    if ClientSocket <> nil then
      ClientSocket.Data := PChar(TfrxServerSession(SocketThread).SessionId);
    TfrxServerSession(SocketThread).SessionItem := SessionManager.AddSession(TfrxServerSession(SocketThread).SessionId, TCustomWinSocket(ClientSocket));
    if ParentReportServer.SocketOpen then
      SocketThread.Resume;
    FParentReportServer.StatToVar;
  except
    on E:Exception do
      LogWriter.Write(ERROR_LEVEL, DateTimeToStr(Now) + #9 + ClientSocket.RemoteAddress + ' client session creation error. ' + E.Message);
  end;
end;

procedure TfrxHTTPServer.ClientAccept(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  if ParentReportServer.DenyIP.IndexOf(Socket.RemoteAddress) <> -1 then
  begin
    LogWriter.Write(ERROR_LEVEL, DateTimeToStr(Now) + #9 + Socket.RemoteAddress + ' denial of client connection');
    Socket.Close;
  end
  else if (ParentReportServer.AllowIP.Count > 0) and
     (ParentReportServer.AllowIP.IndexOf(Socket.RemoteAddress) = -1) then
  begin
    LogWriter.Write(ERROR_LEVEL, DateTimeToStr(Now) + #9 + Socket.RemoteAddress + ' client connection not allowed');
    Socket.Close;
  end;
end;

{ TfrxServerSession }

constructor TfrxServerSession.Create(CreateSuspended: Boolean; ASocket: TServerClientWinSocket);
begin
  inherited Create(CreateSuspended, ASocket);
  FSessionId := SID_SIGN + MakeSessionId;
  FIsReport := False;
  FSize := 0;
  FKeepAlive := False;
  FRemoteIP := ClientSocket.RemoteAddress;
  FServerReplyData := TStringList.Create;
  FReplyHeader := TStringList.Create;
  FReplyBody := TStringList.Create;
  FFormat := sfHTM;
  FPageRange := '';
  FGzip := False;
  FResultPage := '';
  FRedirect := False;
  FStream := TMemoryStream.Create;
  FInParams := TStringList.Create;
  FOutParams := TStringList.Create;
  {$IFDEF FPC}
  FServerReplyData.LineBreak := #13#10;
  FReplyHeader.LineBreak := #13#10;
  FReplyBody.LineBreak := #13#10;
  FOutParams.LineBreak := #13#10;
  FInParams.LineBreak := #13#10;
  {$ENDIF}
  FData := nil;
  FAuthInProgress := False;
  FAuthFinished := False;
  FAuthNewConv := True;
  FToken := 0;
  FLocalVariables := TfrxServerVariables.Create;
end;

destructor TfrxServerSession.Destroy;
begin
  FLocalVariables.Free;
  FInParams.Free;
  FOutParams.Free;
  FStream.Free;
  FServerReplyData.Free;
  FReplyHeader.Free;
  FReplyBody.Free;
  inherited;
end;

function TfrxServerSession.ParseHeaderField(const Field: AnsiString): AnsiString;
begin
  Result := ParseHeaderField(Field, FHeader);
end;

function TfrxServerSession.ParseHeaderField(const Field: AnsiString; Const aHeader: AnsiString): AnsiString;
var
  i: integer;
  s: Ansistring;
begin
  i := Pos(Field, aHeader);
  Result := '';
  if i > 0 then
  begin
    s := Copy(aHeader, i + Length(Field), Length(aHeader) - i + Length(Field));
    i := Pos(AnsiString(#13#10), s);
    if i > 0 then
      Result := Copy(s, 1, i - 1);
  end;
end;

procedure TfrxServerSession.ParseHTTPHeader;
var
  i, j: Integer;
  ContentType, s: AnsiString;

  function GetBoundary(aValue: AnsiString): AnsiString;
  var
    sPos, Cnt: Integer;
  begin
    Result := '';
    sPos := Pos('boundary=', aValue);
    if (i > 0) and (sPos > 0) then
    begin
      Cnt := PosEx(';', aValue, sPos);
      Inc(sPos, 9);
      if Cnt <= 0 then
        Cnt := Length(aValue) - sPos;
      Result := Copy(aValue, sPos, Cnt);
    end;
  end;

begin
{$IFDEF DEBUG}
  LogWriter.Write(ACCESS_LEVEL, FHeader);
{$ENDIF}
  FMethod := ERR_UNKNOWN_METHOD;
  FErrorCode := 0;
  FReturnData := '';
  i := Pos(AnsiString(' '), FHeader);
  FMethod := Copy(FHeader, 1, i - 1);
  if (FMethod = METHOD_GET) or (FMethod = METHOD_POST) then
  begin
    i := Pos(AnsiString('/'), FHeader);
    if i > 0 then
    begin
      FName := Trim(String(Copy(FHeader, i + 1, Pos(AnsiString('HTTP'), FHeader) - i - 2)));
      FName := HTML2Str(FName);
      FHTTPVersion := Copy(FHeader, Pos(AnsiString('HTTP/'), FHeader), 8);
      FHost := ParseHeaderField('Host: ');
      //FKeepAlive := ParseHeaderField('Connection: ') = 'keep-alive';
      FKeepAlive := False;
      FReferer := ParseHeaderField('Referer: ');
      FUserAgent := ParseHeaderField('User-Agent: ');
      FContentMD5 := ParseHeaderField('Content-MD5: ');
      TryStrToInt64(ParseHeaderField('Content-Length: '), FContentLength);
      if ServerConfig.GetBool('server.security.cgiauth') then
        FLogin := ParseHeaderField('UserName: ')
      else if ServerConfig.GetBool('server.security.remoteauth') then
        FLogin := ParseHeaderField('RemoteUserName: ')
      else if ServerConfig.GetBool('server.security.cookieauth') then
      begin
        FCookie := ParseHeaderField('Cookie: ');
        s := 'LI_USR';
        i := Pos(AnsiString(s), FCookie);
        j := i + Length(s) + 1;
        if (i > 0) then
        begin
          FLogin := '';
          while((FCookie[j] <> ';') and (j <= Length(FCookie))) do
          begin
            FLogin := FLogin + FCookie[j];
            Inc(j);
          end;
        end;
      end;
      ContentType := ParseHeaderField('Content-Type: ');
      { looking for better detection solution }
      IsFP3Content(ContentType);
      FBoundary := GetBoundary(ContentType);
      s := ParseHeaderField('Accept-Encoding: ');
      if Length(s) > 0 then
        if (Pos('gzip', LowerCase(s)) > 0) and (FParentHTTPServer.Gzip) then
          FGzip := True;
      CheckAuth;
      WriteLogs;
    end;
  end;
end;

procedure TfrxServerSession.ParseParameters;
var
  i, j: Integer;
  s, TempName: Ansistring;
  P, V: AnsiString;
  RepName, Redir: AnsiString;
begin
  i := -1;
      if not FAuthNeeded then
      begin
        FKeepAlive := False;
        if (FMethod = METHOD_GET) or ((FMethod = METHOD_POST) and FIsFP3) then
        begin
          i := Pos('?', FName);
          if i > 0 then
          begin
            TempName := Copy(FName, 1, i - 1);
            FName := Copy(FName, i + 1, Length(FName) - i);
          end;
        end else
        { remark : have no idia what this legacy code used for , remove it after testing }
        if (FMethod = METHOD_POST) and (FStream.Size > 0) then
        begin
          SetLength(FName, FStream.Size);
          FStream.Position := 0;
          FStream.ReadBuffer(FName[1], FStream.Size);  // check
        end;
        s := ParseParam('getvariable');
        if Length(s) = 0 then
        begin
          RepName := ParseParam('report');
          {$IFDEF FPC}
          {$IFDEF Linux}
          RepName := StringReplace(RepName, '\', '/', [rfReplaceAll]);
          {$ELSE}
          RepName := StringReplace(RepName, '/', '\', [rfReplaceAll]);
          {$ENDIF}
          {$ENDIF}
          Redir := ParseParam('dialog_redirect');
          if Redir = '' then
          begin
            Redir := ParseParam('export_redirect');
            if Redir <> '' then            
              FIsExportRedirect := True;
          end;
          if FIsFP3 and (FFormFileName <> '') then
            RepName := FFormFileName;
          FDialogSessionId := ParseParam('sessionid');
          FCacheId := ParseParam('cacheid');
          FBrowserPrn := ParseParam('print') = '1';
          FPrn := ParseParam('prn');
          if (FPrn = '1') and ServerConfig.GetBool('server.http.allowprint') then
          begin
          // print window
            FReturnData := ServerPrinter.GetHTML(FCacheId, RepName);
            FMIMEType := 'text/html';
          end
          else
          if (FPrn = '2') and ServerConfig.GetBool('server.http.allowprint') then
          begin
{$IFDEF DELPHI12}
            ServerPrinter.AddPrintJob(FCacheId, ParseParam('printer'), Parseparam('pages'), StrToInt(ParseParam('copies')), ParseParam('collate') = '1', ParseParam('reverse') = '1');
{$ELSE}
            ServerPrinter.AddPrintJob(FCacheId, Utf8Decode(ParseParam('printer')), Parseparam('pages'), StrToInt(ParseParam('copies')), ParseParam('collate') = '1', ParseParam('reverse') = '1');
{$ENDIF}
            FName := FCacheId + '/index.html';
          end
          else
          if (RepName <> '') and ReportsList.GetGroupMembership(RepName, FGroup) then
          begin
              if Length(FDialogSessionId) > 0 then
                FDialog := True;
              s := ParseParam('format');
              if Length(s) > 0 then
              begin
                Redir := '';
                SelectFormat(s);
              end;
              Self.FmPage := ParseParam('mPage');
              s := ParseParam('multipage');
              if s = '0' then FMultipage := False
              else if s = '1' then FMultipage := True
              else FMultipage := not ServerConfig.GetBool('server.exports.html.singlepage');
              s := ParseParam('pagenav');
              if s = '0' then FPageNavigator := False
              else if s = '1' then FPageNavigator := True
              else FPageNavigator := ServerConfig.GetBool('server.exports.html.navigator');
              s := ParseParam('pagerange');
              FPageRange := s;
              if FBrowserPrn then
              begin
                FMultipage := false;
                FPageNavigator := false;
                Redir := '';
              end;

              FVariables := TfrxVariables.Create;
              try
                if Pos('=', FName) > 0 then
                begin
                  i := 1;
                  while i > 0 do
                  begin
                    j := 1;
                    while (j <= i) and (j <> 0) do
                    begin
                      i := Pos('=', FName);
                      j := Pos('&', FName);
                      if (j < i) and (j <> 0) then
                        FName := Copy(FName, j + 1, Length(FName) - j);
                    end;
                    if i > 0 then
                    begin
                      P := Copy(FName, 1, i - 1);
                      s := ParseParam(P);
{$IFDEF DELPHI12}
                      V := s;
{$ELSE}
                      V := UTF8Decode(s);
{$ENDIF}
                      if V = '' then
                        V := s;
                      V := '''' + V + '''';
                      FVariables[P] := V;
                    end;
                  end;
                end;
                if Redir = '' then
                begin
                  FIsReport := True;
                  FName := frxGetAbsPathDir(ServerConfig.GetValue('server.reports.path'), ServerConfig.ConfigFolder) + RepName;
                  FReportName := RepName;
                  PrepareReportQuery;
                end
                else
                  FName := Redir;
              finally
                FVariables.Free;
              end;
          end else
            if i > 0 then
              FErrorCode := 403;
        end else
        begin
          FReturnData := TfrxReportServer(ParentReportServer).Variables.GetValue(s);
          if Length(FReturnData) = 0 then
          begin
            UpdateLocalVariables;
            FReturnData := LocalVariables.GetValue(s);
            if Length(FReturnData) = 0 then
              FErrorCode := 404;
          end;
        end;
      end;
end;

function TfrxServerSession.ParseParam(S: String): String;
var
  i, j: integer;
  aStrResult : AnsiString;
begin
  i := Pos(UpperCase(S) + '=', UpperCase(FName));
  if i > 0 then
  begin
    aStrResult := Copy(FName, i + Length(S) + 1, Length(FName) - i + Length(S) + 1);
    j := Pos('&', aStrResult);
    if j > 0 then
      aStrResult := Copy(aStrResult, 1, j - 1);
    Delete(FName, i, Length(S) + Length(aStrResult) + 1);
  end else
    aStrResult := '';
  if Length(FName) > 0 then
  begin
    i := 1;
    while (FName[i] = '&') and (i < Length(FName)) do
      Inc(i);
    Delete(FName, 1, i - 1);
  end;
  if aStrResult <> '' then
    aStrResult := HTML2Str(aStrResult);
{$IFDEF DELPHI12}
  Result := UTF8Decode(aStrResult)
{$ELSE}
  Result := aStrResult;
{$ENDIF}
end;

function TfrxServerSession.CheckBadPath: Boolean;
begin
  Result := (Pos('..\', FName) > 0) or (Pos('../', FName) > 0);
end;

procedure TfrxServerSession.CreateReplyHTTPData;
var
  SearchRec: TSearchRec;
  s, sn: String;
  Index: Integer;
begin
  FServerReplyData.Clear;
  FReplyHeader.Clear;

  if Length(FReturnData) > 0 then
    FErrorCode := 200;

  if (FErrorCode = 0) then
    if CheckBadPath then
      FErrorCode := 403
    else if FAuthNeeded then
      FErrorCode := 401
    else if (Length(FResultPage) > 0) then
    begin

      if ((FFormat = sfHTM) or (FFormat = sfHTMD)) and (not FDialog) then
      begin
        FErrorCode := 200;
        FRedirect := False;
      end
      else

      if FileExists(FParentHTTPServer.BasePath + FResultPage) then
      begin
        FErrorCode := 301;
        FRedirect := True;
      end
    end else
    begin
      if FName = '' then
        FName := FParentHTTPServer.MainDocument;
      if (FindFirst(FParentHTTPServer.BasePath + FName, faReadOnly + faArchive, SearchRec) = 0) or
         (FindFirst(FParentHTTPServer.BasePath + FName + FParentHTTPServer.MainDocument, faReadOnly + faArchive, SearchRec) = 0)
      then
      begin
        FErrorCode := 200;
        FSize := SearchRec.Size;
        FFileDate := FileDateToDateTime(SearchRec.Time);
      end else
        FErrorCode := 404;
      FindClose(SearchRec);
    end;
  UpdateSessionFName;
  s := ExtractFileExt(FName);
  if FMIMEType = '' then
    FMIMEType := GetMime(s);
  s := '';
  if FErrorCode = 401 then
    s := ' Unauthorized'
  else if FErrorCode = 403 then
    s := ' Forbidden';
  if FData <> nil then
    FData.HTTPVer := FHTTPVersion;
  if FData <> nil then
    FData.ErrorCode := FErrorCode;
  if (FErrorCode = 0 ) and (Length(FReportMessage) > 0) then
  begin
    FErrorCode := 500;
    s := FReportMessage;
  end;
  FReplyHeader.Add(FHTTPVersion + ' ' + IntToStr(FErrorCode) + s);
  if Length(s) = 0 then
  begin
    sn := 'Server';
{$IFDEF TRIAL}
    s := SERVER_NAME + ' D';
    s := s + 'e';
    s := s + 'm';
    s := s + 'o';
    FReplyHeader.Add(sn + ': ' + s);
    AddOutData(sn, s);
{$ELSE}
    FReplyHeader.Add(sn + ': ' + SERVER_NAME);
    AddOutData(sn, SERVER_NAME);
{$ENDIF}
    if FErrorCode = 200 then
    begin
      sn := 'Content-Type';
      AddOutData(sn, FMIMEType);
      FReplyHeader.Add(sn + ': ' + FMIMEType);

      if FIsExportRedirect then
      begin
        sn := 'Content-Disposition';
        Index := LastDelimiter('/', FName);
        if Index = Length(FName) then
          Index := 0;  
        S := 'inline; filename="' + Copy(FName, Index + 1, Length(FName)) + '"';
        AddOutData(sn, S);
        FReplyHeader.Add(sn + ': ' + S);
        FIsExportRedirect := false;
      end;
      
    end;        
    if (FParentHTTPServer.FNoCacheHeader) and (not FRedirect) then
    begin
      sn := 'Cache-Control';
      s := 'must-revalidate, max-age=0';
      AddOutData(sn, s);
      FReplyHeader.Add(sn + ': ' + s);
      sn := 'Pragma';
      s := 'no-cache';
      AddOutData(sn, s);
      FReplyHeader.Add(sn + ': ' + s);
    end;
    sn := 'Accept-ranges';
    s := 'none';
    AddOutData(sn, s);
    FReplyHeader.Add(sn + ': ' + s);
    sn := 'Last-Modified';
    s := DateTimeToRFCDateTime(FFileDate);
    AddOutData(sn, s);
    FReplyHeader.Add(sn + ':' + s);
    sn := 'Expires';
    s := DateTimeToRFCDateTime(FFileDate);
    if FData <> nil then
    begin
      FData.Expires := FFileDate;
      FData.LastMod := FFileDate;
    end;
    AddOutData(sn, s);
    FReplyHeader.Add(sn + ':' + s);
    if FGzip and CheckDeflate(FName) and (FErrorCode = 200) and FParentReportServer.SocketOpen then
    begin
      sn := 'Content-Encoding';
      s := 'gzip';
      AddOutData(sn, s);
      FReplyHeader.Add(sn + ': ' + s)
    end else
      FGzip := False;
    if FRedirect then
    begin
      sn := 'Location';
      s := 'result?report=' + FReportName;
      if FDialogSessionId <> '' then
        s := s + '&dialog_redirect='
      else
        s := s + '&export_redirect=';
      s := s + FResultPage;
      if (not FIsFP3) then
      begin
        s := s + '&cacheid=';
        if FDialogSessionId <> '' then
          s := s + FDialogSessionId
        else
          s := s + FSessionId;
      end;
      AddOutData(sn, s);
      FReplyHeader.Add(sn + ': ' + s);
    end;
    if FIsReport then
    begin
      sn := 'SessionId';
      if FDialogSessionId <> '' then
        s := FDialogSessionId
      else
        s := SessionId;
      AddOutData(sn, s);
      FReplyHeader.Add(sn + ': ' + s);
    end;
  end;
end;

function TfrxServerSession.GetSessionPath: AnsiString;
begin
  if (FIsFP3) then
  begin
    if FContentMD5 = '' then
      FContentMD5 := frMD5Stream(FStream);
    result := SID_STORE + FContentMD5;
  end
  else
    result := FSessionID;
end;

procedure TfrxServerSession.PrepareReportQuery;
var
 Path: String;
 {$IFNDEF FPC}
 SecAtrtrs: TSecurityAttributes;
 {$ENDIF}
 ReportTimeout: Integer;
 MaxReports: Integer;
begin
  if FIsReport then
  begin
    Path := FParentHTTPServer.BasePath + SessionId;
    {$IFDEF FPC}
    CreateDir(Path);
    {$ELSE}
    SecAtrtrs.nLength := SizeOf(TSecurityAttributes);
    SecAtrtrs.lpSecurityDescriptor := nil;
    SecAtrtrs.bInheritHandle := true;
    CreateDirectory(PChar(Path), @SecAtrtrs);
    {$ENDIF}
    if not FDialog then
    begin
      MaxReports := ServerConfig.GetNumber('server.reports.maxreports');
      ReportTimeout := ServerConfig.GetNumber('server.http.sockettimeout') * 1000;

      if MaxReports > 0 then
      begin
          while LogWriter.CurrentReports > MaxReports do
          begin
            if ReportTimeout = 0 then
            begin
              FErrorText := 'Maximum count of reports has been reached.';
              ErrorLog;
              exit;
            end
            else
              Dec(ReportTimeout);
            PMessages;
          end;
      end;

      FRepSession := TfrxReportSession.Create;
      FRepSession.ParentThread := Self;
      FRepSession.NativeClient := Pos('FastReport', FUserAgent) > 0;
      FRepSession.Stream := FStream;
      FRepSession.IsFP3 := FIsFP3;
      FRepSession.ParentReportServer := ParentReportServer;
      FRepSession.SessionId := SessionId;
      FRepSession.CacheId := FCacheId;
      if FIsFP3 then
      begin
        FRepSession.FileName := FContentMD5;
        FStream.Position := 0;
      end
      else
        FRepSession.FileName := FName;
      FRepSession.ReportPath := FParentHTTPServer.ReportPath;
      FRepSession.IndexFileName := FParentHTTPServer.MainDocument;
      FRepSession.RootPath := FParentHTTPServer.BasePath;
      FRepSession.PageRange := FPageRange;
      FRepSession.Format := FFormat;
      FRepSession.mPage := FmPage;
      FRepSession.Print := FBrowserPrn;
      if Assigned(ParentReportServer.OnGetVariables) then
        DoGetVariables;
      FRepSession.Variables := FVariables;
      FRepSession.FreeOnTerminate := True;

      FRepSession.Password := FPassword;
      FSessionItem.ReportThread := FRepSession;

      FRepSession.PageNav := FPageNavigator;
      FRepSession.Multipage := FMultipage;
      FRepSession.UserLogin := FLogin;
      FRepSession.UserGroup := FGroup;

      FRepSession.Resume;

    end else
    begin
      FSessionItem := SessionManager.FindSessionById(FDialogSessionId);
      if FSessionItem <> nil then
      begin
        FRepSession := FSessionItem.ReportThread;
        if FRepSession <> nil then
        begin
          FRepSession.Stream := FStream;
          FRepSession.Variables := FVariables;
          FRepSession.Continue := True;
          while FRepSession.DialogActive and (not Terminated) do
            Sleep(25);
        end;
      end;
    end;
    if (FRepSession <> nil) and (not Terminated) then
    begin
      while (not Terminated) and (FRepSession.Active) and (not FRepSession.DialogActive) do
        Sleep(10);
      if FRepSession.Active and Terminated then
      begin
        FRepSession.TerminateReport;
        // do not close session until report thread is down
        //while FRepSession.Active do
        //  Sleep(10);
      end;
      if FDialog then
        FName := PathDelim + FDialogSessionId + FRepSession.ResultPage
      else
      begin
        FName := PathDelim + SessionId + FRepSession.ResultPage;
      end;

      FReportTitle := FRepSession.ReportTitle;

      if FRepSession.Mime <> '' then
        FMIMEType := FRepSession.Mime;

      FReportMessage := FRepSession.ReportMessage;

      if FRepSession.Auth then
        FAuthNeeded := True;

      if (not FRepSession.DialogActive) then
        if FDialog then
        begin
          FRepSession.Terminate;
          PMessages;
          SessionManager.FindSessionById(FDialogSessionId).ReportThread := nil;
        end else
          SessionManager.FindSessionById(FSessionId).ReportThread := nil;
      FRepSession.Readed := True;
    end else
      FName := '';
    FResultPage := StringReplace(FName, '\', '/', [rfReplaceAll]);
    FFileDate := Now;
  end;
end;

procedure TfrxServerSession.WriteHtmlReportIndex(OutStream: TfrxSSIStream);
var
  FTemplate: TfrxServerTemplate;
  s, Template: String;
  AnsiStr: AnsiString;
begin
  Template := '';
  FTemplate := TfrxServerTemplate.Create;
  try
    FTemplate.SetTemplate('index');
    FTemplate.Variables.AddVariable('TITLE', FReportTitle);
    FTemplate.Variables.AddVariable('SESSION', FSessionId);
    if FMultipage then
      s := '1.html'
    else
    if FPageNavigator then
      s := 'main.html'
    else
      s := 'html';

    // /FastReport.Export.axd?object=
    FTemplate.Variables.AddVariable('INDEX', '/' + SessionId + '/index.' + s);
    FTemplate.Prepare;
    Template := FTemplate.TemplateStrings.Text;
  finally
    FTemplate.Free;
  end;
  AnsiStr := UTF8Encode(Template);
  OutStream.Write(AnsiStr[1], Length(AnsiStr));  // check
end;

procedure TfrxServerSession.MakeServerReply;
var
  FStream: TFileStream;
  Buffer, sn, s: AnsiString;
  i: Integer;
  MemStream, MemStreamOut: TMemoryStream;
  FSSIStream: TfrxSSIStream;
  FTemplate: TfrxServerTemplate;
{$IFDEf DELPHI12}
  TempStr: AnsiString;
{$ENDIF}
  crit: TfrxMutex;
begin
  if FData <> nil then
    FData.FileName := FName;
  if FErrorCode = 200 then
  begin
    if ClientSocket.Connected or (not FParentReportServer.SocketOpen) then
    begin
      MemStream := TMemoryStream.Create;
      FSSIStream := TfrxSSIStream.Create;
      FSSIStream.BasePath := FParentHTTPServer.BasePath;
      FSSIStream.Variables := FParentReportServer.Variables;
      UpdateLocalVariables;
      FSSIStream.LocalVariables := LocalVariables;
      try
        try
          if Length(FReturnData) = 0 then
          begin
            if FIsReport and (Pos('form', FName) = 0) and ((FFormat = sfHTM) or (FFormat = sfHTMD)) then
            begin
              WriteHtmlReportIndex(FSSIStream);
            end
            else
            begin
              crit := TfrxMutex.Create(FName);
              crit.Lock;
              FStream := TFileStream.Create(FParentHTTPServer.BasePath + FName, fmOpenRead + fmShareDenyWrite);
              try
                FSSIStream.CopyFrom(FStream, 0);
              finally
                FStream.Free;
                crit.Unlock;
                crit.Free;
              end;
              if CheckSSI(FName) then
                FSSIStream.Prepare
            end
          end
          else
            FSSIStream.Write(FReturnData[1], Length(FReturnData)); // check

          FSSIStream.Position := 0;
          if FGzip and FParentReportServer.SocketOpen then
          begin
            try
              frCompressStream(FSSIStream, MemStream, gzMax, FName);
            except
              on E:Exception do
              begin
                FErrorText := 'GZIP pack error. ' + E.Message;
                ErrorLog;
              end;
            end;
          end else
            MemStream.CopyFrom(FSSIStream, 0);
          MemStream.Position := 0;
          sn := 'Content-length';
          s := IntToStr(MemStream.Size);
          AddOutData(sn, s);
          FReplyHeader.Add(sn + ': ' + s);
          if FKeepAlive then
            FReplyHeader.Add('Connection: Keep-Alive')
          else
            FReplyHeader.Add('Connection: Close');
          if ServerConfig.GetBool('server.http.mic') then
          begin
            sn := 'Content-MD5';
            s := frMD5Stream(MemStream);
            AddOutData(sn, s);
            FReplyHeader.Add(sn + ': ' + s);
          end;
          FReplyHeader.Add('X-Powered-By: FastReportServer/' + SERVER_VERSION);

          if ((Pos('sid_', FName) > 0) or (Pos('store_', FName) > 0)) then
          begin
            s := 'frreport';
            FReplyHeader.Add('FastReport-container:' + s);
          end;

          FReplyHeader.Add('');
          Buffer := FReplyHeader.Text;
        except
          on E:Exception do
          begin
            FErrorText := 'error prepare output result ' + E.Message;
            ErrorLog;
          end;
        end;
        if FParentReportServer.SocketOpen then
        begin
          MemStreamOut := TMemoryStream.Create;
          try
            MemStream.SaveToStream(MemStreamOut);
            MemStreamOut.Position := 0;
{$IFDEF DEBUG}
            LogWriter.Write(ACCESS_LEVEL, Buffer);
{$ENDIF}
            ClientSocket.SendBuf(Buffer[1], Length(Buffer));  // check
            ClientSocket.SendStreamThenDrop(MemStreamOut);
          except
            on E:Exception do
            begin
              MemStreamOut.Free;
              FErrorText := 'error socket stream output result' + E.Message;
              ErrorLog;
            end;
          end;
        end else
        begin
          FData.RepHeader := Buffer;
          FData.Stream.CopyFrom(MemStream, 0);
        end;
      finally
        MemStream.Free;
        FSSIStream.Free;
      end
    end;
  end else
  begin
    sn := 'Content-Type';
    s := 'text/html';
    AddOutData(sn, s);
    FReplyHeader.Add(sn + ': ' + s);

    if FErrorCode = 404 then
    begin
      FTemplate := TfrxServerTemplate.Create;
      try
        FTemplate.SetTemplate('error404');
        FTemplate.Variables.AddVariable('ERROR', FReportMessage + '<br>' + ServerConfig.ServerMessage);
        FTemplate.Prepare;
        Buffer := FTemplate.TemplateStrings.Text;
      finally
        FTemplate.Free;
      end;

      i := Length(Buffer);
      FErrorText := FName + ' document not found ' + FReportMessage;
      ErrorLog;
    end else
    if FRedirect or (FErrorCode = 403) then
    begin
      i := 0;
      Buffer := '';
    end else
    if FErrorCode = 401 then
    begin
      i := 0;
      Buffer := '';
      if FAuthInProgress then
        FReplyHeader.Add(Format('WWW-Authenticate: ' + FAuthType + ' %s', [FAuthResponse]))
      else
      begin
        if ServerConfig.GetBool('server.security.winauth') then
        begin
          FReplyHeader.Add('WWW-Authenticate: NTLM');
          FReplyHeader.Add('WWW-Authenticate: Negotiate');
          FReplyHeader.Add('WWW-Authenticate: Kerberos');
          FKeepAlive := True;
        end
        else
        begin
          sn := 'WWW-Authenticate';
          s := 'Basic realm="' + SERVER_NAME + '"';
          AddOutData(sn, s);
          FReplyHeader.Add(sn + ': ' + s);
        end;
      end;
    end else
    begin
      FTemplate := TfrxServerTemplate.Create;
      try
        FTemplate.SetTemplate('error500');
        FTemplate.Variables.AddVariable('ERROR', '');
        FTemplate.Prepare;
        Buffer := FTemplate.TemplateStrings.Text;
      finally
        FTemplate.Free;
      end;
      i := Length(Buffer);
      FErrorText := 'unknown error';
      ErrorLog;
    end;

    if FKeepAlive then
      FReplyHeader.Add('Connection: Keep-Alive')
    else
      FReplyHeader.Add('Connection: Close');

    sn := 'Content-length';
    s := IntToStr(i);
    AddOutData(sn, s);
    FReplyHeader.Add(sn + ': ' + s);
    FReplyHeader.Add('');
//    Buffer := FReplyHeader.Text + Buffer;
    if FParentReportServer.SocketOpen then
    begin
      try
{$IFDEF DELPHI12}
        TempStr := AnsiString(FReplyHeader.Text);
        ClientSocket.SendText(TempStr);
{$ELSE}
{$IFDEF DEBUG}
        LogWriter.Write(ACCESS_LEVEL, FReplyHeader.Text);
{$ENDIF}
        ClientSocket.SendText(FReplyHeader.Text);
{$ENDIF}
        ClientSocket.SendText(Buffer);
        if not FKeepAlive then
          ClientSocket.Close;
      except
        on E: Exception do
        begin
          FErrorText := 'error socket stream output answer. ' + E.Message;
          ErrorLog;
        end;
      end;
    end else
    begin
      FData.RepHeader := FReplyHeader.Text;
      FData.Stream.Write(Buffer[1], Length(Buffer)); // check
    end;
  end;
end;

procedure TfrxServerSession.ClientExecute;
var
  FDSet: TFDSet;
  TimeVal: TTimeVal;
  TempStream, TempStream1: TMemoryStream;
  i: Integer;
  Len, HeaderEnd: Integer;
  HeaderParsed: Boolean;

  function SearchHeaderEnd(Strm: TMemoryStream; StartPos: Integer): Integer;
  var
    ptrByte: PAnsiChar;
  begin
    ptrByte := Strm.Memory;
    if StartPos < 0 then
      StartPos := 0;
    Result := -1;
    while StartPos < Strm.Size - 3 do
    begin
      if (ptrByte[StartPos] = #13) and (ptrByte[StartPos + 1] = #10) and (ptrByte[StartPos + 2] = #13) and (ptrByte[StartPos + 3] = #10) then
      begin
        Result := StartPos;
        Break;
      end;
      Inc(StartPos);
    end;
  end;

  function SearchStringInStream(Strm: TMemoryStream; StartPos: Integer; aString: AnsiString): Integer;
  var
    ptrByte: PAnsiChar;
    i, Reslen: Integer;
  begin
    Reslen := 0;
    ptrByte := Strm.Memory;
    if StartPos < 0 then
      StartPos := 0;
    while StartPos < Strm.Size - 3 do
    begin
      Reslen := 0;
      for i := 1 to Length(aString) do
      if (ptrByte[StartPos + i - 1] = aString[i]) then
        Inc(Reslen)
      else break;
      if Reslen = Length(aString) then Break;
      Inc(StartPos);
    end;
    Result := -1;
    if Reslen = Length(aString) then
      Result := StartPos;
  end;

  procedure ReadHeader(aHeaderLen: Integer; aStream: TStream);
  var
    OldPos: Integer;
  begin
    SetLength(FHeader, aHeaderLen);
    try
      OldPos := TempStream.Position;
      TempStream.Position := 0;
      TempStream.ReadBuffer(FHeader[1], aHeaderLen); // check
      TempStream.Position := OldPos;
      ParseHTTPHeader;
    except
      on E: Exception do
      begin
        FErrorText := 'error client stream parsing. ' + E.Message;
        ErrorLog;
      end;
    end;
    HeaderParsed := true;
  end;

  procedure GetDataFromBoundary(sPos: Integer);
  var
    i: Integer;
    ContentDisp, ContentType: AnsiString;
    ParamName, lFileName, lHeader: AnsiString;

    function GetValue(aStr: AnsiString; aName: AnsiString): AnsiString;
    var
      i, sPos: Integer;
    begin
      Result := '';
      sPos := Pos(aName + '="', aStr);
      if sPos < 1 then Exit;
      Inc(sPos, length(aName) + 2);
      i := sPos;
      while i <= Length(aStr) do
      begin
        if aStr[i] = '"' then break;
        Inc(i);
      end;
      Result := Copy(aStr, sPos, i - sPos);
    end;

  begin
    sPos := SearchStringInStream(TempStream, sPos, '--' + FBoundary);
    if sPos <> -1 then
    begin
      Inc(sPos, Length(FBoundary) + 2);
      i := SearchHeaderEnd(TempStream, sPos);
      if i <> -1 then
      begin
        SetLength(lHeader, i - sPos + 4);
        TempStream.Position := sPos;
        TempStream.ReadBuffer(lHeader[1], i - sPos + 4);

        ContentDisp := ParseHeaderField('Content-Disposition: ', lHeader);
        ContentType := ParseHeaderField('Content-Type: ', lHeader);

        ParamName := GetValue(ContentDisp, 'name');
        if ParamName = '0' then
          FFormFileName := ParamName
        else
        begin
          lFileName := ExtractFileName(GetValue(ContentDisp, 'filename'));
          SelectFormat(ParamName);
          if lFileName <> '' then
            FFormFileName := lFileName
        end;
        //IsFP3Content(ContentType);  //not need trash?
        sPos := i + 4;
        TempStream.Position := sPos;
        i := SearchStringInStream(TempStream, sPos, '--' + FBoundary) - 1;
        Len := i - 1 - TempStream.Position;
        if i <> -1 then
          FStream.CopyFrom(TempStream, Len);
      end;
    end;
    if (FContentMD5 <> '') then
    begin
      FIsFP3 := True;
      ParamName := ParseHeaderField('Format-Export: ');
      FFormFileName := 'NoInReport.fp3';
      SelectFormat(ParamName);
    end;
  end;

begin
  HeaderParsed := False;
  LogWriter.StatAddCurrentSession;
  FIsExportRedirect := False;
  if FParentReportServer.SocketOpen then
  begin
    FD_ZERO(FDSet);
    FD_SET(ClientSocket.SocketHandle, FDSet);
    TimeVal.tv_sec := FParentHTTPServer.SocketTimeOut;
    TimeVal.tv_usec := 0;
    repeat
{$IFDEF CS_ON}
      ServCS.Enter;
      try
{$ENDIF}
      {$IFNDEF Linux}
        i := select(0, @FDSet, nil, nil, @TimeVal);
      {$ELSE}
        i := select(ClientSocket.SocketHandle + 1, @FDSet, nil, nil, @TimeVal);
      {$ENDIF}
{$IFDEF CS_ON}
      finally
        ServCS.Leave;
      end;
{$ENDIF}
      if i = -1 then
        FKeepAlive := False;
      if (i > 0) and not Terminated then
      begin
        TempStream := TMemoryStream.Create;
        TempStream1 := TMemoryStream.Create;
        HeaderEnd := -1;
        Len := 0;
        try
          i := ClientSocket.ReceiveLength;
          try
            while (i <> 0) or (FContentLength > TempStream.Size - Len) do
            begin
              TempStream1.SetSize(i);
              ClientSocket.ReceiveBuf(TempStream1.Memory^, i);
              i := ClientSocket.ReceiveLength;
              TempStream.CopyFrom(TempStream1, 0);
              if HeaderEnd = -1 then
                HeaderEnd := SearchHeaderEnd(TempStream, TempStream.Size - TempStream1.Size - 4);
              if (not HeaderParsed) and (HeaderEnd > 0) then
              begin
                Len := HeaderEnd + 3;
                ReadHeader(Len, TempStream);
              end;

              if not HeaderParsed and (TempStream.Size > FParentHTTPServer.FMaxHTTPHeaderSize) or
                 HeaderParsed and (Len > FParentHTTPServer.FMaxHTTPHeaderSize)then
                raise Exception.Create('HTTP header is too large.');

              if HeaderParsed and (FParentHTTPServer.FMaxContentSize > 0) and
                (((FContentLength > 0) and (FContentLength > FParentHTTPServer.FMaxContentSize)) or
                (TempStream.Size - Len > FParentHTTPServer.FMaxContentSize)) then
                raise Exception.Create('HTTP content size is greater than allowed.');

              if (FContentMD5 <> '') and ReportCache.IsReportInCache(FContentMD5, nil, '') then
                break;
            end;
          except
            on E: Exception do
            begin
              FErrorText := 'error socket stream read.' + E.Message;
              ErrorLog;
            end;
          end;

          TempStream.Position := 0;
          i := StreamSearch(TempStream, 0, #13#10#13#10);
          if i <> -1 then
          begin
            Len := i + 4;
            if not HeaderParsed then
              ReadHeader(Len, TempStream);
            try
              if FBoundary <> '' then
                GetDataFromBoundary(Len)
              else
              begin
                TempStream.Position := Len;
                FStream.CopyFrom(TempStream, TempStream.Size - Len);
              end;
            except
              on E: Exception do
              begin
                FErrorText := 'error client query.' + E.Message;
                ErrorLog;
              end;
            end;
          end;
        finally
          TempStream.Free;
          TempStream1.Free;
        end;
      end;
{$IFDEF CS_ON}
      ServCS.Enter;
      try
{$ENDIF}
      {$IFNDEF Linux}
        i := select(0, nil, @FDSet, nil, @TimeVal);
      {$ELSE}
        i := select(ClientSocket.SocketHandle + 1, nil, @FDSet, nil, @TimeVal);
      {$ENDIF}
{$IFDEF CS_ON}
      finally
        ServCS.Leave;
      end;
{$ENDIF}
      if (i > 0) and not Terminated then
        if (Length(FHeader) > 0) and ClientSocket.Connected then
        begin
          ParseParameters;
          CreateReplyHTTPData;
          MakeServerReply;
        end;
    until not FKeepAlive;
    CloseSession;
  end
  else
  begin
    if FData.Stream.Size > 0 then
    begin
      FStream.CopyFrom(FData.Stream, 0);
      FData.Stream.Clear;
    end;
    FHeader := FData.Header;
    ParseHTTPHeader;
    ParseParameters;
    CreateReplyHTTPData;
    MakeServerReply;
    FActive := False;
    Sleep(100);
  end;
  LogWriter.StatRemoveCurrentSession;
end;

procedure TfrxServerSession.WriteLogs;
begin
  LogWriter.Write(ACCESS_LEVEL, DateTimeToStr(Now) + #9 + SessionId + #9 + FRemoteIP + #9 + FName);
  if Length(FReferer) > 0 then
    LogWriter.Write(REFERER_LEVEL, DateTimeToStr(Now) + #9 + FRemoteIP + #9 + FReferer);
  if Length(FUserAgent) > 0 then
    LogWriter.Write(AGENT_LEVEL, DateTimeToStr(Now) + #9 + FRemoteIP + #9 + FUserAgent);
end;

procedure TfrxServerSession.ErrorLog;
begin
  LogWriter.Write(ERROR_LEVEL, DateTimeToStr(Now) + #9 + FRemoteIP + #9 + FErrorText);
  LogWriter.ErrorReached;
end;

procedure TfrxServerSession.UpdateSessionFName;
begin
  SessionManager.FindSessionById(FSessionId).FileName := FName;
end;

procedure TfrxServerSession.CloseSession;
begin
  SessionManager.CompleteSessionId(SessionId);
end;

function TfrxServerSession.CheckSSI(FileName: String): Boolean;
var
  ext: String;
begin
  ext := LowerCase(ExtractFileExt(FileName));
  Result := (ext = '.htm') or (ext = '.html') or
            (ext = '.shtm') or (ext = '.shtml');
end;

function TfrxServerSession.CheckDeflate(FileName: String): Boolean;
var
  ext: String;
begin
  ext := LowerCase(ExtractFileExt(FileName));
  if Pos('MSIE', FUserAgent) > 0 then
    Result := ((ext = '.htm') or (ext = '.html') or
              (ext = '.shtm') or (ext = '.shtml') or
              (ext = '.css') or (ext = '.txt') or
              (ext = '.bmp')) and (FSize > MAX_IE_GZIP)
  else
    Result := (ext <> '.jpg') and (ext <> '.jpeg') and
              (ext <> '.gif') and (ext <> '.png') and
              (ext <> '.ods') and (ext <> '.odt') and
              (ext <> '.zip') and (ext <> '.rar');
end;

function TfrxServerSession.InitAuth(const SecPackageName: String): boolean;
{$IFNDEF Linux}
var
  ntlmSecPI: PSecPkgInfo;
{$ENDIF}
begin
  Result := false;
  {$IFNDEF Linux}
  if QuerySecurityPackageInfo(PChar(SecPackageName),ntlmSecPI) = 0 then
  begin
    FMaxTokenSize := ntlmSecPI^.cbMaxToken;
    FreeContextBuffer(ntlmSecPI);
    if AcquireCredentialsHandle(nil, PChar(SecPackageName),
      SECPKG_CRED_INBOUND, nil, nil, nil, nil, @FCredHandle, FExpire) = 0 then
      Result:=true;
  end;
  {$ENDIF}
end;

procedure TfrxServerSession.IsFP3Content(aContent: AnsiString);
begin
  FIsFP3 := not(Pos('FastReport', FUserAgent) > 0) and
    ((Pos('application/octet-stream', aContent) > 0) or
    (Pos('multipart/form-data; boundary', aContent) > 0) or
    (Pos('application/xml', aContent) > 0) or
    (Pos('application/zip', aContent) > 0));
  FIsFP3 := FIsFP3 or (Pos('application/fp3', aContent) > 0);
end;

procedure TfrxServerSession.FinalAuth;
begin
  {$IFNDEF Linux}
  FreeCredentialsHandle(@FCredHandle);
  {$ENDIF}
end;

function TfrxServerSession.ProcessAuthRequest(AuthRequest: AnsiString; NewConversation: boolean; var AuthResponse: AnsiString;
  var ContextHandle: TSecHandle; var AuthFinished: boolean): boolean;
var
  InBufD: TSecBufferDesc;
  InBuf: TSecBuffer;
  OutBufD: TSecBufferDesc;
  OutBuf: TSecBuffer;
  Attribs: cardinal;
  R: integer;
  Context: PCtxtHandle;
begin
  Result := false;
  // prepare input buffer
  AuthRequest := frBase64Decode(AuthRequest);
  inBufD.ulVersion := SECBUFFER_VERSION;
  inBufD.cBuffers := 1;
  inBufD.pBuffers := @inBuf;
  inBuf.BufferType := SECBUFFER_TOKEN;
  inBuf.cbBuffer := length(AuthRequest);
  inBuf.pvBuffer := AllocMem(inBuf.cbBuffer);
  Move(AuthRequest[1], inBuf.pvBuffer^, inBuf.cbBuffer);
  // prepare output buffer
  outBufD.ulVersion := SECBUFFER_VERSION;
  outBufD.cBuffers := 1;
  outBufD.pBuffers := @outBuf;
  outBuf.BufferType := SECBUFFER_TOKEN;
  outBuf.cbBuffer := FMaxTokenSize;
  outBuf.pvBuffer := AllocMem(outBuf.cbBuffer);
  // process request
  if NewConversation then
    Context := nil
  else
    Context := @ContextHandle;
  Attribs := 0;
  {$IFNDEF Linux}
  R := AcceptSecurityContext(@FCredHandle, Context, @inBufD, Attribs, SECURITY_NATIVE_DREP, @ContextHandle,
    @outBufD, Attribs, @FExpire);
  if (R = SEC_I_COMPLETE_NEEDED) or (R = SEC_I_COMPLETE_AND_CONTINUE) then
    if CompleteAuthToken(@ContextHandle, @outBufD) <> 0 then
      exit;
  {$ENDIF}
  AuthFinished := not((R = SEC_I_CONTINUE_NEEDED) or (R = SEC_I_COMPLETE_AND_CONTINUE));
  SetLength(AuthResponse, outBuf.cbBuffer);
  Move(outBuf.pvBuffer^, AuthResponse[1], outBuf.cbBuffer);
  AuthResponse := frBase64Encode(AuthResponse);
  // free buffers
  FreeMem(inBuf.pvBuffer);
  FreeMem(outBuf.pvBuffer);
  Result := true;
end;

procedure TfrxServerSession.SelectFormat(FormatName: String);
begin
  if Length(FormatName) > 0 then
  begin
    FormatName := UpperCase(FormatName);
    if FormatName = 'PDF' then FFormat := sfPDF else
    if FormatName = 'ODS' then FFormat := sfODS else
    if FormatName = 'ODT' then FFormat := sfODT else
    if FormatName = 'XML' then FFormat := sfXML else
    if FormatName = 'XLS' then FFormat := sfXLS else
    if FormatName = 'RTF' then FFormat := sfRTF else
    if FormatName = 'TXT' then FFormat := sfTXT else
    if FormatName = 'CSV' then FFormat := sfCSV else
    if FormatName = 'JPG' then FFormat := sfJPG else
    if FormatName = 'BMP' then FFormat := sfBMP else
    if FormatName = 'GIF' then FFormat := sfGIF else
    if (FormatName = 'TIFF') or (FormatName = 'TIF') then FFormat := sfTIFF else
    if (FormatName = 'FRP') or (FormatName = 'FP3') then FFormat := sfFRP else
    if (FormatName = 'HTML') or (FormatName = 'HTM') then FFormat := sfHTM else
    FFormat := sfHTMD;
  end;
end;

function TfrxServerSession.GetCurrentUserToken: TfrHandle;
begin
  {$IFNDEF Linux}
  if not OpenThreadToken(GetCurrentThread, TOKEN_READ or
    TOKEN_DUPLICATE or TOKEN_IMPERSONATE, true, Result) then
    if not OpenProcessToken(GetCurrentProcess, TOKEN_READ or
      TOKEN_DUPLICATE or TOKEN_IMPERSONATE, Result) then
  {$ENDIF}
      Result := 0;
end;


procedure TfrxServerSession.CheckAuth;
var
  i: Integer;
  s: AnsiString;
  L, P: AnsiString;
  sz: cardinal;

begin
  FAuthNeeded := ((Length(ServerConfig.GetValue('server.security.login')) > 0) and
     (Length(ServerConfig.GetValue('server.security.password')) > 0))
     or (ServerConfig.GetBool('server.security.userauth'));
  s := ParseHeaderField('Authorization: ');
  if Length(s) > 0 then
  begin
    FKeepAlive := True;
    i := Pos('Basic ', s);
    if (i > 0) and  not ServerConfig.GetBool('server.security.winauth') then
    begin
      FKeepAlive := False;
      s := Copy(s, i + 6, Length(s) - i - 5);
      s := frBase64Decode(s);
      i := Pos(':', s);
      if i > 0 then
      begin
        L := Copy(s, 1, i - 1);
        P := Copy(s, i + 1, Length(s) - i);
        FLogin := L;
        FPassword := P;

        if ServerConfig.GetBool('server.security.userauth') then
        begin
          FAuthNeeded := not ServerUsers.AllowLogin(L, P);
          if FName = '' then
            FName := ServerUsers.GetUserIndex(L);
          FGroup := ServerUsers.GetGroupOfUser(L);
        end
        else
        if (L = ServerConfig.GetValue('server.security.login')) and
           (P = ServerConfig.GetValue('server.security.password')) then
          FAuthNeeded := False
      end;
    end else
    begin
      // not basic auth
      i := Pos(' ', s);
      if i = 0 then
        i := Length(s);
      FAuthType := Copy(s, 1, i - 1);
      s := Copy(s, i + 1, Length(s) - i);

      if (Pos('Negotiate', FAuthType) > 0 ) or (Pos('Kerberos', FAuthType) > 0) or (Pos('NTLM', FAuthType) > 0 ) and not FAuthFinished then
      begin
        if FAuthNewConv then
        begin
          FAuthInProgress := true;
          if not InitAuth(FAuthType) then
            exit;
        end;
        if not ProcessAuthRequest(s, FAuthNewConv, FAuthResponse, FContextHandle, FAuthFinished) then
        begin
          FinalAuth;
          exit;
        end;
        FAuthNewConv := false;
        if FAuthFinished then
        begin
          {$IFNDEF Linux}
          if ImpersonateSecurityContext(@FContextHandle) <> 0 then
            exit;
          sz := 0;
          GetUserNameEx(NameSamCompatible, nil, sz);
          if sz = 0 then
            exit;
          SetLength(FLogin, sz);
          GetUserNameEx(NameSamCompatible, pointer(FLogin), sz);
          FLogin := string(PChar(FLogin));
          FPassword := '';
          if FToken <> 0 then
            CloseHandle(FToken);
          FToken := GetCurrentUserToken;
          if RevertSecurityContext(@FContextHandle) <> 0 then
            exit;
          FinalAuth;
          {$ENDIF}
          FAuthNewConv := True;
          FAuthInProgress := False;
          FAuthFinished := False;
          FAuthNeeded := False;
          FKeepAlive := False;
        end;
      end;
    end;
  end;
end;

procedure TfrxServerSession.DoGetVariables;
begin
  ParentReportServer.OnGetVariables(FName, FVariables, FLogin);
end;

procedure TfrxServerSession.AddOutData(const Name: String; const Value: String);
begin
  if FData <> nil then
    FData.OutParams.Add(Name + '=' + Value);
end;

procedure TfrxServerSession.UpdateLocalVariables;
var
  ReportsListHtml, ReportsListLines: AnsiString;

begin
  if ServerConfig.GetBool('server.security.reportslist') then
  begin
    ReportsListHtml := '';
    ReportsListLines := '';
    ReportsList.GetReports4Group(FGroup, ReportsListHtml, ReportsListLines);
    FLocalVariables.AddVariable('SERVER_REPORTS_LIST', ReportsListLines);
    FLocalVariables.AddVariable('SERVER_REPORTS_HTML', ReportsListHtml);
  end;
end;

function TfrxServerSession.GetMime(s: String): String;
begin
  result := ServerConfig.GetValue('server.exports' + LowerCase(s) + '.mimetype');
  if result = '' then
    result := GetFileMIMEType(s);
end;

{ TfrxServerData }

procedure TfrxServerData.Assign(Source: TfrxServerData);
begin
  FInParams.Assign(Source.InParams);
  FOutParams.Assign(Source.FOutParams);
  FErrorCode := Source.ErrorCode;
  FStream.Clear;
  if Source.Stream.Size > 0 then
  begin
    Source.Stream.Position := 0;
    FStream.CopyFrom(Source.Stream, 0);
  end;
  FErrorCode := Source.ErrorCode;
  FFileName := Source.FileName;
end;

constructor TfrxServerData.Create;
begin
  FInParams := TStringList.Create;
  FOutParams := TStringList.Create;
  FStream := TMemoryStream.Create;
  FErrorCode := 0;
end;

destructor TfrxServerData.Destroy;
begin
  FStream.Free;
  FInParams.Free;
  FOutParams.Free;
  inherited;
end;

{ TfrxServerGuard }

constructor TfrxServerGuard.Create(Server: TfrxReportServer);
begin
  inherited Create(True);
  FServer := Server;
  FTImeOut := ServerConfig.GetNumber('server.http.configrenewtimeout');
  if FTimeOut = 0 then
    FTimeOut := 30;
  FListTimeOut := ServerConfig.GetNumber('server.reports.reportslistrenewtimeout');
  if FListTimeOut = 0  then
    FListTimeOut := 180;
  Priority := tpLowest;
  Resume;
end;

destructor TfrxServerGuard.Destroy;
begin
  Sleep(100);
  inherited;
end;

procedure TfrxServerGuard.DoLoadConf;
begin
  FServer.LoadConfigs;
end;

procedure TfrxServerGuard.Execute;
var
  time1, time2, out1, out2: Cardinal;
begin
  time1 := GetTickCount;
  time2 := time1;
  out1 := FTimeOut * 1000;
  out2 := FListTimeOut * 1000;
  while not Terminated do
  begin
    if (GetTickCount - time1) > out1 then
    begin
//      Synchronize(DoLoadConf);
      DoLoadConf;
      time1 := GetTickCount;
    end;
    if ((GetTickCount - time2) > out2) and ServerConfig.GetBool('server.security.reportslist') then
    begin
      ReportsList.BuildListOfReports;
      time2 := GetTickCount;
    end;
    Sleep(5000);
    PMessages;
  end;
end;

initialization
  ServCS := TCriticalSection.Create;
{$IFNDEF FPC}
  frDisableThreadSynchronizer := True;
{$ENDIF}

finalization
  ServCS.Free;

end.
