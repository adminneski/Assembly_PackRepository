
{******************************************}
{                                          }
{             FastReport VCL               }
{    HTTP Report Server Session Manager    }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxServerSessionManager;

{$I frx.inc}

interface

uses
{$IFDEF FPC}
 {$IFNDEF Linux}
  Windows,
 {$ENDIF}
  LCLType, LCLIntf, LazHelper, LazSocket,
{$ELSE}
  Windows, ScktComp,
{$ENDIF}
  SysUtils, Classes, Forms, frxServerReports;

type
  TfrxSessionItem = class(TObject)
  private
    FActive: Boolean;
    FCompleted: Boolean;
    FName: String;
    FReportThread: TfrxReportSession;
    FSessionId: String;
    FSocket: TCustomWinSocket;
    FTimeComplete: TDateTime;
    FTimeCreated: TDateTime;
  public
    constructor Create;
    destructor Destroy; override;

    property Active: Boolean read FActive write FActive;
    property SessionId: String read FSessionId write FSessionId;
    property Socket: TCustomWinSocket read FSocket write FSocket;
    property Completed: Boolean read FCompleted write FCompleted;
    property TimeCreated: TDateTime read FTimeCreated write FTimeCreated;
    property TimeComplete: TDateTime read FTimeComplete write FTimeComplete;
    property FileName: String read FName write FName;
    property ReportThread: TfrxReportSession read FReportThread
      write FReportThread;
  end;

  TfrxSessionManager = class(TThread)
  private
    FCleanUpTimeOut: Integer;
    FSession: TfrxSessionItem;
    FSessionList: TList;
    FSessionPath: String;
    FShutDown: Boolean;
    FThreadActive: Boolean;
    function CleanUpSession(SessionId: String): Boolean;
    procedure Clear;
    procedure DeleteSession;
    procedure DeleteSessionFolder(const DirName: String);
    procedure SetSessionPath(const Value: String);
    function GetCount: Integer;
  protected
    procedure Execute; override;
  public
    constructor Create;
    destructor Destroy; override;
    function AddSession(SessionId: String;
      Socket: TCustomWinSocket): TfrxSessionItem;
    procedure CompleteSession(Socket: TCustomWinSocket);
    procedure CompleteSessionId(SessionId: String);
    function FindSessionBySocket(Socket: TCustomWinSocket): TfrxSessionItem;
    function FindSessionById(SessionId: String): TfrxSessionItem;
    procedure CleanUp;

    property CleanUpTimeOut: Integer read FCleanUpTimeOut write FCleanUpTimeOut;
    property SessionPath: String read FSessionPath write SetSessionPath;
    property Count: Integer read GetCount;
  end;

  TfrxOldSessionsCleanupThread = class(TThread)
  private
    FPath: String;
  protected
    procedure Execute; override;
  public
    constructor Create(const Dir: String);
  public
    property Path: String read FPath write FPath;
  end;

var
  SessionManager: TfrxSessionManager;

implementation

uses frxServer, frxFileUtils, frxServerUtils, frxNetUtils, frxServerConfig, SyncObjs;

var
  SessionCS: TCriticalSection;

{ TfrxSessionItem }

constructor TfrxSessionItem.Create;
begin
  FSessionId := '';
  FName := '';
  FSocket := nil;
  FCompleted := False;
  FTimeCreated := Now;
  FTimeComplete := 0;
end;

destructor TfrxSessionItem.Destroy;
begin
  if FReportThread <> nil then
    ReportThread.Terminate;
  PMessages;
  inherited;
end;

{ TfrxSessionManager }

constructor TfrxSessionManager.Create;
begin
  inherited Create(True);
  FSessionList := TList.Create;
  FCleanUpTimeOut := StrToInt(ServerConfig.GetValue('server.http.sessiontimeout'));
  SessionPath := frxGetAbsPathDir(ServerConfig.GetValue('server.http.rootpath'), ServerConfig.ConfigFolder);
  Priority := tpLowest;
  FShutDown := False;
  Resume;
end;

destructor TfrxSessionManager.Destroy;
begin
  Terminate;
  while FThreadActive do
    PMessages;
  Clear;
  FSessionList.Free;
  inherited;
end;

function TfrxSessionManager.AddSession(SessionId: String;
  Socket: TCustomWinSocket): TfrxSessionItem;
var
  Session: TfrxSessionItem;
begin
  Session := TfrxSessionItem.Create;
  Session.SessionId := SessionId;
  Session.Socket := Socket;
  Session.FReportThread := nil;
  SessionCS.Enter;
  try
    FSessionList.Add(Session);
  finally
    SessionCS.Leave;
  end;
  Result := Session;
end;

function TfrxSessionManager.CleanUpSession(SessionId: String): Boolean;
var
  DirName: String;
  Approved: Boolean;
  i: Integer;
  Session: TfrxSessionItem;
  t, t1: TDateTime;
begin
  Result := False;
  Approved := True;
  if not FShutDown then
  begin
    t1 := FCleanUpTimeOut / 100000;
    i := 0;
    while i < FSessionList.Count do
    begin
      Session := TfrxSessionItem(FSessionList[i]);
      t := Now;
      if (t < (Session.TimeComplete + t1)) and
         (Pos(SessionId, Session.FName) > 0) then
      begin
        Approved := False;
        break;
      end;
      Inc(i);
    end;
  end;
  DirName := FSessionPath + SessionId;
  if Approved then
  begin
    DeleteSessionFolder(DirName);
    Result := True;
  end;
end;

procedure TfrxSessionManager.CompleteSession(Socket: TCustomWinSocket);
var
  Session: TfrxSessionItem;
begin
  Session := FindSessionBySocket(Socket);
  if Session <> nil then
  begin
    Session.Completed := True;
    Session.TimeComplete := Now;
  end;
end;

procedure TfrxSessionManager.CompleteSessionId(SessionId: String);
var
  Session: TfrxSessionItem;
begin
  Session := FindSessionById(SessionId);
  if Session <> nil then
  begin
    Session.Completed := True;
    Session.TimeComplete := Now;
  end;
end;

procedure TfrxSessionManager.DeleteSession;
var
  i: Integer;
begin
  SessionCS.Enter;
  try
    i := FSessionList.IndexOf(FSession);
    if (i <> -1) then
    begin
      if CleanUpSession(TfrxSessionItem(FSessionList[i]).SessionId) then
      begin
        TfrxSessionItem(FSessionList[i]).Free;
        FSessionList.Delete(i);
      end;
    end;
  finally
    SessionCS.Leave;
  end;
end;

procedure TfrxSessionManager.Execute;
var
  i: Integer;
begin
  FThreadActive := True;
  while not Terminated do
  begin
    i := 0;
    CleanUp;
    while (not Terminated) and (i < 1000) do
    begin
      Inc(i);
      Sleep(10);
      PMessages;
    end;
  end;
  FThreadActive := False;
end;

function TfrxSessionManager.FindSessionById(SessionId: String): TfrxSessionItem;
var
  i: Integer;
  Session: TfrxSessionItem;
begin
  Result := nil;
  for i := 0 to FSessionList.Count - 1 do
  begin
    Session := TfrxSessionItem(FSessionList[i]);
    if Session.FSessionId = SessionId then
    begin
      Result := Session;
      break;
    end
  end;
end;

function TfrxSessionManager.FindSessionBySocket(Socket: TCustomWinSocket): TfrxSessionItem;
var
  i: Integer;
  Session: TfrxSessionItem;
begin
  Result := nil;
  for i := 0 to FSessionList.Count - 1 do
  begin
    Session := TfrxSessionItem(FSessionList[i]);
    if Session.Socket = Socket then
    begin
      Result := Session;
      break;
    end
  end;
end;

procedure TfrxSessionManager.Clear;
var
  i: Integer;
begin
  FShutDown := True;
  for i := 0 to FSessionList.Count - 1 do
  begin
    if i < FSessionList.Count then
      CleanUpSession(TfrxSessionItem(FSessionList[i]).SessionId);
    if i < FSessionList.Count
      then TfrxSessionItem(FSessionList[i]).Free;
    Application.ProcessMessages;
  end;
  FSessionList.Clear;
  FShutDown := False;
end;

procedure TfrxSessionManager.DeleteSessionFolder(const DirName: String);
var
  SearchRec: TSearchRec;
  i: Integer;
begin
  if DirectoryExists(DirName) and (Pos(SID_SIGN, DirName) > 0) then
  begin
    i := FindFirst(DirName + PathDelim + '*.*', 0, SearchRec);
    try
      while i = 0 do
      begin
        try
          DeleteFile(PChar(DirName + PathDelim + SearchRec.Name));
        except
        end;
        i := FindNext(SearchRec);
        PMessages;
      end;
    finally
      FindClose(SearchRec);
    end;
    try
      {$IFNDEF FPC}
      RemoveDirectory(PChar(DirName));
      {$ELSE}
      DeleteFolder(DirName);
      {$ENDIF}
    except
    end;
  end;
end;

procedure TfrxSessionManager.SetSessionPath(const Value: String);
begin
  FSessionPath := Value;
  TfrxOldSessionsCleanupThread.Create(FSessionPath);
end;

procedure TfrxSessionManager.CleanUp;
var
  i, j: Integer;
  t, t1: TDateTime;
begin
    i := 0;
    t1 := FCleanUpTimeOut / 100000;
    j := 30;
    while (i < FSessionList.Count) and (j > 0) do
    begin
      FSession := TfrxSessionItem(FSessionList[i]);
      t := Now;
      if Assigned(FSession) and FSession.Completed then
        if t > (FSession.FTimeComplete + t1) then
        begin
          DeleteSession;
          Dec(j);
        end
        else Inc(i)
      else Inc(i);
    end;
end;

function TfrxSessionManager.GetCount: Integer;
begin
  Result := FSessionList.Count;
end;

{ TfrxOldSessionsCleanupThread }

constructor TfrxOldSessionsCleanupThread.Create(const Dir: String);
begin
  inherited Create(True);
  FPath := Dir;
  FreeOnTerminate := True;
  Resume;
end;

procedure TfrxOldSessionsCleanupThread.Execute;
var
  SearchRec: TSearchRec;
  i: Integer;
begin
  if DirectoryExists(FPath) and (not Terminated) then
  begin
    i := FindFirst(FPath + SID_SIGN + '*', faDirectory  , SearchRec);
    try
      while (i = 0) and not Terminated do
      begin
        try
          DeleteFolder(FPath + SearchRec.Name);
        except
        end;
        i := FindNext(SearchRec);
        PMessages;
      end;
    finally
      FindClose(SearchRec);
    end;
  end;
end;

initialization
  SessionCS := TCriticalSection.Create;

finalization
  SessionCS.Free;


end.

