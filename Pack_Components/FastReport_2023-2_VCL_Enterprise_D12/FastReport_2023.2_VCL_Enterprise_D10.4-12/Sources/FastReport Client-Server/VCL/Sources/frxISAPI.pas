
{******************************************}
{                                          }
{             FastReport VCL               }
{             ISAPI extension              }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxISAPI;
{$I frx.inc}
interface

uses Windows, Isapi2, SysUtils, Classes,
  frxServer, frxDBSet, frGZip, frxNetUtils,
  frxDCtrl, frxDMPExport, frxGradient, frxChBox, frxCross, frxRich,
  frxChart, frxBarcode, frxServerUtils, ActiveX, Registry, frxUtils,
  frxServerConfig, frxFileUtils, frxServerStat, SyncObjs, ComObj, frThreading
{$IFDEF DELPHI12}
  , AnsiStrings
{$ENDIF};

function GetExtensionVersion(var Ver: THSE_VERSION_INFO): BOOL stdcall;
function HttpExtensionProc(var ECB: TEXTENSION_CONTROL_BLOCK): DWORD stdcall;
function TerminateExtension(dwFlags: DWORD): BOOL stdcall;

type
  TfrxISAPIThread = class(TThread)
  private
   FECB: PEXTENSION_CONTROL_BLOCK;
  protected
    procedure Execute; override;
  public
    constructor Create(AECB: PEXTENSION_CONTROL_BLOCK);
    property ECB: PEXTENSION_CONTROL_BLOCK read FECB;
  end;

var
  g_dwThreadCount: Integer = 0;
  ISAPIThread: TfrxISAPIThread;
  r: TRegistry;
  FServer: TfrxReportServer;
  ServerRoot: String;
  InstallPath: String;
  sModuleName: String;

{$IFDEF FR_DEBUG}
procedure OutMess(const s: String);
{$ENDIF}

implementation

uses
  frxServerDB;

{$IFDEF FR_DEBUG}
const
  LogFile = 'c:\fastreport.log';
procedure OutMess(const s: String);
var
  f:  TFileStream;
begin
  if FileExists(LogFile) then
    f := TFileStream.Create(LogFile, fmOpenWrite + fmShareDenyWrite)
  else
    f := TFileStream.Create(LogFile, fmCreate);
  f.Seek(0, soFromEnd);
  f.Write(s[1], Length(s));
  f.Write(AnsiString(#13#10), 2);
  f.Free;
end;
{$ENDIF}

function GetExtensionVersion(var Ver: THSE_VERSION_INFO): BOOL stdcall;
begin
  Integer(Result) := 1;
  Ver.dwExtensionVersion := MakeLong(HSE_VERSION_MINOR, HSE_VERSION_MAJOR);
{$IFDEF DELPHI12}
  AnsiStrings.StrLCopy(Ver.lpszExtensionDesc, PAnsiChar('FastReport'), HSE_MAX_EXT_DLL_NAME_LEN);
{$ELSE}
  StrLCopy(Ver.lpszExtensionDesc, PAnsiChar('FastReport'), HSE_MAX_EXT_DLL_NAME_LEN);
{$ENDIF}
end;

function HttpExtensionProc(var ECB: TEXTENSION_CONTROL_BLOCK): DWORD stdcall;
begin
  ISAPIThread := TfrxISAPIThread.Create(@ECB);
	InterlockedIncrement(g_dwThreadCount);
  Result := HSE_STATUS_PENDING;
end;

function TerminateExtension(dwFlags: DWORD): BOOL stdcall;
begin
  while (g_dwThreadCount > 0) do
    SleepEx(100, FALSE);
  SleepEx(1000, FALSE);
  Integer(Result) := 1;
end;

{ TfrxISAPIThread }

constructor TfrxISAPIThread.Create(AECB: PEXTENSION_CONTROL_BLOCK);
begin
  inherited Create(True);
  FECB := AECB;
  FreeOnTerminate := True;
  Resume;
end;

function GetFieldByName(ECB: TEXTENSION_CONTROL_BLOCK; const Name: AnsiString): AnsiString;
var
  Buffer: array[0..4095] of AnsiChar;
  Size: DWORD;
begin
  Size := SizeOf(Buffer);
  if ECB.GetServerVariable(ECB.ConnID, PAnsiChar(Name), @Buffer, Size) or
     ECB.GetServerVariable(ECB.ConnID, PAnsiChar('HTTP_' + Name), @Buffer, Size) then
  begin
    if Size > 0 then Dec(Size);
    SetString(Result, Buffer, Size);
  end else Result := '';
end;

procedure TfrxISAPIThread.Execute;
var
  FScriptName, ResultHeaders: AnsiString;
  Size: DWORD;
  Data: TfrxServerData;
  s, s1: AnsiString;
  i: Integer;
  Status: DWORD;

begin
  PMessages;
  CoInitializeEx(nil, COINIT_MULTITHREADED);
  InitDefaultConnection;
  try
    try
      Data := TfrxServerData.Create;
      try
        s := ECB.lpszQueryString;
        s1 := ECB.lpszPathInfo;
        i := Pos(AnsiUpperCase(sModuleName), AnsiUpperCase(s1));
        if (i = 1) or (i = 2) then
        begin
          if s1[Length(sModuleName) + i] <> '/' then
          begin
            ECB.ServerSupportFunction(ECB.ConnID, HSE_REQ_SEND_URL_REDIRECT_RESP, PAnsiChar(s1 + '/'), nil, nil);
            Status := HSE_STATUS_SUCCESS_AND_KEEP_CONN;
            PMessages;
            ECB.ServerSupportFunction(ECB.ConnID, HSE_REQ_DONE_WITH_SESSION, @Status, nil, nil);
            PMessages;
            Exit;
          end;
          Delete(s1, i, Length(sModuleName) + (i - 1));
        end;
        if s1 = '' then
          s1 := '/'
        else if (s1 = '/result')  then
          s1 := s1 + '?';
        Data.Header :=  String(ECB.lpszMethod) + ' ' + String(s1) + String(s) + ' HTTP/1.1' + #13#10;
        Data.Header := Data.Header + String(GetFieldByName(ECB^, 'ALL_RAW')) + #13#10;
        PMessages;
        // working
        FServer.Get(Data);
        PMessages;
        Size := Data.Stream.Size;
        ResultHeaders := AnsiString(Data.RepHeader);
        i := Pos(AnsiString(#13#10), ResultHeaders);
        s := '';
        if i > 0 then
        begin
          s := Copy(ResultHeaders, 1, i - 1);
          Delete(ResultHeaders, 1, i + 1);
        end;
        FScriptName := GetFieldByName(ECB^, 'SCRIPT_NAME');
{$IFDEF DELPHI12}
        ResultHeaders := AnsiStrings.StringReplace(ResultHeaders, 'Location: ', 'Location: ' + AnsiString(FScriptName), []);
{$ELSE}
        ResultHeaders := StringReplace(ResultHeaders, 'Location: ', 'Location: ' + AnsiString(FScriptName), []);
{$ENDIF}
        if Data.OutParams.Values['Location'] <> '' then
        begin
          if (Length(FScriptName) > 0) and ((FScriptName[Length(FScriptName)] <> '\') or (FScriptName[Length(FScriptName)] <> '/')) then
            FScriptName := FScriptName + '/';
          s1 := FScriptName + AnsiString(Data.OutParams.Values['Location']);
          ECB.ServerSupportFunction(ECB.ConnID, HSE_REQ_SEND_URL_REDIRECT_RESP, PAnsiChar(s1), nil, nil);
        end else
        begin
          s1 := ParseHeaderField('Content-Type: ', ResultHeaders);
          if s1 <> '' then
          begin
            ECB.lpszContentType := @s1[1];
          end;
          ECB.dwHttpStatusCode := Data.ErrorCode;
          ECB.ServerSupportFunction(ECB.ConnID, HSE_REQ_SEND_RESPONSE_HEADER, nil, nil, LPDWORD(ResultHeaders));
          PMessages;
          ECB.WriteClient(ECB.ConnID, Data.Stream.Memory, Size, 0);
        end;
        Status := HSE_STATUS_SUCCESS_AND_KEEP_CONN;
      finally
        Data.Free;
      end;
    except
      Status := HSE_STATUS_ERROR;
    end;
    PMessages;
    ECB.ServerSupportFunction(ECB.ConnID, HSE_REQ_DONE_WITH_SESSION, @Status, nil, nil);
  finally
    PMessages;
    CoUninitialize;
  end;
	InterlockedDecrement(g_dwThreadCount);
end;

initialization
  r := TRegistry.Create;
  try
    r.RootKey := HKEY_LOCAL_MACHINE;
    r.OpenKey('\SOFTWARE\Fast Reports\Server', false);
    InstallPath := r.ReadString('InstallPath');
    if InstallPath = '' then
      InstallPath := ExtractFilePath(GetModuleName(HInstance));
    if InstallPath[Length(InstallPath)] <> '\'  then
      InstallPath := InstallPath + '\';
    ServerRoot :=  InstallPath;
    sModuleName :=  ExtractFileName(GetModuleName(HInstance));
  finally
    r.Free;
  end;
  frxDisableThreadSynchronizer := False;
  FServer := TfrxReportServer.CreateWithRoot(ServerRoot, False);
  FServer.Open;

finalization
  FServer.Free;

end.
