
{******************************************}
{                                          }
{             FastReport VCL               }
{           Configuration utils            }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxConfigUtils;

{$I frx.inc}

interface

uses
  Classes, Windows, WinSvc, Registry, SysUtils, DateUtils;

function DateTime2Str(const DateTime: TDateTime): String;
function Str2DateTime(const Str: String): TDateTime;
function UnquoteStr(const Str: String): String;
function TimeCalc(const DateTime: TDateTime; const Value: Integer; const Mode: Integer): TDateTime;
function ServiceInstalled(const ServiceName: String): Boolean;
function ServiceStarted(const ServiceName: String): Boolean;
procedure InstallService(Name, DisplayName: String; StartType: Integer; Path, ServiceStartName, Password: String);
procedure UninstallService(Name: String);
function ServiceStop(const aMachine, aServiceName: string ): boolean;
function ServiceStart(const aMachine, aServiceName: string): boolean;
function GetTempFile: String;
function Base64Encode(const S: String): String;
function Base64Decode(const S: String): String;

implementation

const
  Base64Charset = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';

function ServiceStart(const aMachine, aServiceName: string): boolean;
var
  h_manager, h_svc: SC_Handle;
  svc_status: TServiceStatus;
  Temp: PChar;
  dwCheckPoint: DWord;
begin
  svc_status.dwCurrentState := 1;
  h_manager := OpenSCManager(PChar(aMachine), Nil, SC_MANAGER_CONNECT);
  if h_manager > 0 then
  begin
    h_svc := OpenService(h_manager, PChar(aServiceName), SERVICE_START or SERVICE_QUERY_STATUS);
    if h_svc > 0 then
    begin
      temp := nil;
      if (StartService(h_svc,0,temp)) then
        if (QueryServiceStatus(h_svc,svc_status)) then
        begin
          while (SERVICE_RUNNING <> svc_status.dwCurrentState) do
          begin
            dwCheckPoint := svc_status.dwCheckPoint;
            Sleep(svc_status.dwWaitHint);
            if (not QueryServiceStatus(h_svc,svc_status)) then
              break;
            if (svc_status.dwCheckPoint < dwCheckPoint) then
            begin
              break;
            end;
          end;
        end;
      CloseServiceHandle(h_svc);
    end;
    CloseServiceHandle(h_manager);
  end;
  Result := SERVICE_RUNNING = svc_status.dwCurrentState;
end;

function ServiceStop(const aMachine, aServiceName: string ): boolean;
var
  h_manager, h_svc: SC_Handle;
  svc_status: TServiceStatus;
  dwCheckPoint: DWord;
begin
  h_manager := OpenSCManager(PChar(aMachine),nil, SC_MANAGER_CONNECT);
  if h_manager > 0 then
  begin
    h_svc := OpenService(h_manager,PChar(aServiceName), SERVICE_STOP or SERVICE_QUERY_STATUS);
    if h_svc > 0 then
    begin
      if(ControlService(h_svc,SERVICE_CONTROL_STOP, svc_status))then
      begin
        if(QueryServiceStatus(h_svc,svc_status))then
        begin
          while(SERVICE_STOPPED <> svc_status.dwCurrentState)do
          begin
            dwCheckPoint := svc_status.dwCheckPoint;
            Sleep(svc_status.dwWaitHint);
            if(not QueryServiceStatus(h_svc,svc_status))then
              break;
            if(svc_status.dwCheckPoint < dwCheckPoint)then
              break;
          end;
        end;
      end;
      CloseServiceHandle(h_svc);
    end;
    CloseServiceHandle(h_manager);
  end;
  Result := SERVICE_STOPPED = svc_status.dwCurrentState;
end;

function ServiceGetStatus(sMachine, sService: string): DWord;
var
  h_manager, h_svc: SC_Handle;
  service_status: TServiceStatus;
  hStat: DWord;
begin
  hStat := 1;
  h_manager := OpenSCManager(PChar(sMachine) ,Nil, SC_MANAGER_CONNECT);
  if h_manager > 0 then
  begin
    h_svc := OpenService(h_manager,PChar(sService), SERVICE_QUERY_STATUS);
    if h_svc > 0 then
    begin
      if(QueryServiceStatus(h_svc, service_status)) then
        hStat := service_status.dwCurrentState;
      CloseServiceHandle(h_svc);
    end;
    CloseServiceHandle(h_manager);
  end;
  Result := hStat;
end;

function ServiceInstalled(const ServiceName: String): Boolean;
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create(KEY_READ);
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    Result := Reg.KeyExists('System\CurrentControlSet\Services\' + ServiceName);
  finally
    Reg.Free;
  end;
end;

function ServiceStarted(const ServiceName: String): Boolean;
begin
  Result := ServiceGetStatus('', ServiceName) = SERVICE_RUNNING;
end;

procedure InstallService(Name, DisplayName: String; StartType: Integer; Path, ServiceStartName, Password: String);
var
  SvcMgr: Integer;
  Svc: Integer;
  PSSN: Pointer;
  i: Integer;
const
  NTStartType: array[0..4] of Integer = (SERVICE_BOOT_START,
    SERVICE_SYSTEM_START, SERVICE_AUTO_START, SERVICE_DEMAND_START,
    SERVICE_DISABLED);
begin
  i := NTStartType[StartType];
  SvcMgr := OpenSCManager(nil, nil, SC_MANAGER_ALL_ACCESS);
  if SvcMgr = 0 then RaiseLastOSError;
  try
    if ServiceStartName = '' then
      PSSN := nil else
      PSSN := PChar(ServiceStartName);
    Svc := CreateService(SvcMgr, PChar(Name), PChar(DisplayName),
      SERVICE_ALL_ACCESS, SERVICE_WIN32_OWN_PROCESS, i, SERVICE_ERROR_NORMAL,
      PChar(Path), nil, nil, nil,
      PSSN, PChar(Password));
    if Svc = 0 then
      RaiseLastOSError;
    CloseServiceHandle(Svc);
  finally
    CloseServiceHandle(SvcMgr);
  end;
end;

procedure UninstallService(Name: String);
var
  Svc: Integer;
  SvcMgr: Integer;
begin
  SvcMgr := OpenSCManager(nil, nil, SC_MANAGER_ALL_ACCESS);
  if SvcMgr = 0 then RaiseLastOSError;
  try
    Svc := OpenService(SvcMgr, PChar(Name), SERVICE_ALL_ACCESS);
    if Svc = 0 then RaiseLastOSError;
    try
      if not DeleteService(Svc) then RaiseLastOSError;
    finally
      CloseServiceHandle(Svc);
    end;
  finally
    CloseServiceHandle(SvcMgr);
  end;
end;

function TimeCalc(const DateTime: TDateTime; const Value, Mode: Integer): TDateTime;
begin
  Result := DateTime;
  case Mode of
    // 1 -  minute
    1: Result := IncMinute(Result, Value);
    // 2 - hour
    2: Result := IncHour(Result, Value);
    // 3 - day
    3: Result := IncDay(Result, Value);
    // 4 - week
    4: Result := IncWeek(Result, Value);
    // 6 - month
    5: Result := IncMonth(Result, Value);
  end;
end;

function UnquoteStr(const Str: String): String;
begin
  if (Pos('"', Str) = 1) and (Str[Length(Str)] = '"') then
    Result := Copy(Str, 2, Length(Str) - 2)
  else
    Result := Str;
end;

function DateTime2Str(const DateTime: TDateTime): String;
begin
  Result := FormatDateTime('YYYYMMDDHHMMSS', DateTime)
end;

function Str2DateTime(const Str: String): TDateTime;
begin
  Result := EncodeDateTime(StrToInt(copy(Str, 1, 4)),
         StrToInt(copy(Str, 5, 2)),
         StrToInt(copy(Str, 7, 2)),
         StrToInt(copy(Str, 9, 2)),
         StrToInt(copy(Str, 11, 2)),
         StrToInt(copy(Str, 13, 2)), 0);
end;

function GetTempFile: String;
var
  Path: String;
  FileName: String;
begin
  SetLength(Path, MAX_PATH);
  SetLength(Path, GetTempPath(MAX_PATH, @Path[1]));
  SetLength(FileName, MAX_PATH);
  GetTempFileName(@Path[1], PChar('fr'), 0, @FileName[1]);
{$IFDEF DELPHI12}
  Result := StrPas(PWideChar(@FileName[1]));
{$ELSE}
  Result := StrPas(@FileName[1]);
{$ENDIF}
end;

function Base64Encode(const S: String): String;
var
  R, C : Byte;
  F, L, M, N, U : Integer;
  P : PChar;
begin
  L := Length(S);
  if L > 0 then
  begin
    M := L mod 3;
    N := (L div 3) * 4 + M;
    if M > 0 then Inc(N);
    U := N mod 4;
    if U > 0 then
    begin
      U := 4 - U;
      Inc(N, U);
    end;
    SetLength(Result, N);
    P := Pointer(Result);
    R := 0;
    for F := 0 to L - 1 do
    begin
      C := Byte(S [F + 1]);
      case F mod 3 of
        0 : begin
              P^ := Base64Charset[C shr 2 + 1];
              Inc(P);
              R := (C and 3) shl 4;
            end;
        1 : begin
              P^ := Base64Charset[C shr 4 + R + 1];
              Inc(P);
              R := (C and $0F) shl 2;
            end;
        2 : begin
              P^ := Base64Charset[C shr 6 + R + 1];
              Inc(P);
              P^ := Base64Charset[C and $3F + 1];
              Inc(P);
            end;
      end;
    end;
    if M > 0 then
    begin
      P^ := Base64Charset[R + 1];
      Inc(P);
    end;
    for F := 1 to U do
    begin
      P^ := '=';
      Inc(P);
    end;
  end else
    Result := '';
end;

function Base64Decode(const S: String): String;
var
  F, L, M, P: Integer;
  B, OutPos: Byte;
  OutB: Array[1..3] of Byte;
  Lookup: Array[Char] of Byte;
  R: PChar;
begin
  L := Length(S);
  P := 0;
  while (L - P > 0) and (S[L - P] = '=') do Inc(P);
  M := L - P;
  if M <> 0 then
  begin
    SetLength(Result, (M * 3) div 4);
    FillChar(Lookup, Sizeof(Lookup), #0);
    for F := 0 to 63 do
      Lookup[Base64Charset[F + 1]] := F;
    R := Pointer(Result);
    OutPos := 0;
    for F := 1 to L - P do
    begin
      B := Lookup[S[F]];
      case OutPos of
          0 : OutB[1] := B shl 2;
          1 : begin
                OutB[1] := OutB[1] or (B shr 4);
                R^ := Char(OutB[1]);
                Inc(R);
                OutB[2] := (B shl 4) and $FF;
              end;
          2 : begin
                OutB[2] := OutB[2] or (B shr 2);
                R^ := Char(OutB[2]);
                Inc(R);
                OutB[3] := (B shl 6) and $FF;
              end;
          3 : begin
                OutB[3] := OutB[3] or B;
                R^ := Char(OutB[3]);
                Inc(R);
              end;
        end;
      OutPos := (OutPos + 1) mod 4;
    end;
    if (OutPos > 0) and (P = 0) then
      if OutB[OutPos] <> 0 then
        Result := Result + Char(OutB[OutPos]);
  end else
    Result := '';
end;

end.
