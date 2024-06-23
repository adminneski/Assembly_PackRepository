
{******************************************}
{                                          }
{             FastReport VCL               }
{           HTTP Report Server Logs        }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxServerLog;

{$I frx.inc}

interface

uses
  {$IFNDEF Linux}
  Windows,
  {$ENDIF}
  SysUtils, Classes, SyncObjs, frxUtils, frxServerUtils, frxNetUtils;

type
  TfrxServerLog = class(TThread)
  private
    FCurrentReports: Integer;
    FCurrentSessions: Integer;
    FErrorsCount: Integer;
    FLevelFName: TStringList;
    FLevels: TList;
    FLogDir: String;
    FLogging: Boolean;
    FMaxReports: Integer;
    FMaxReportTime: Integer;
    FMaxSessions: Integer;
    FTotalReports: Integer;
    FTotalReportTime: Integer;
    FTotalSessions: Integer;
    FMaxLogSize: Integer;
    FMaxLogFiles: Integer;
    FCS: TCriticalSection;
    FTotalCacheHits: Integer;
    FThreadActive: Boolean;
    procedure WriteFile(const FName: String; const Text: String);
    procedure LogRotate(const FName: String);
    procedure SetCurrentReports(Value: Integer);
    procedure SetCurrentSessions(Value: Integer);
  protected
    procedure Execute; override;
  public
    constructor Create;
    destructor Destroy; override;
    function AddLevel(const FileName: String): Integer;
    procedure Clear;
    procedure Flush;
    procedure ErrorReached;
    procedure StartAddReportTime(i: Integer);
    procedure StatAddCurrentReport;
    procedure StatAddCurrentSession;
    procedure StatAddCacheHit;
    procedure StatAddReports(i: Integer);
    procedure StatAddSessions(i: Integer);
    procedure StatRemoveCurrentReport;
    procedure StatRemoveCurrentSession;
    procedure Write(const Level: Integer; const Msg: String);

    property Active: Boolean read FLogging write FLogging;
    property CurrentReports: Integer read FCurrentReports write SetCurrentReports;
    property CurrentSessions: Integer read FCurrentSessions write SetCurrentSessions;
    property ErrorsCount: Integer read FErrorsCount write FErrorsCount;
    property LogDir: String read FLogDir write FLogDir;
    property MaxReports: Integer read FMaxReports write FMaxReports;
    property MaxReportTime: Integer read FMaxReportTime write FMaxReportTime;
    property MaxSessions: Integer read FMaxSessions write FMaxSessions;
    property TotalReports: Integer read FTotalReports write FTotalReports;
    property TotalReportTime: Integer read FTotalReportTime write FTotalReportTime;
    property TotalSessions: Integer read FTotalSessions write FTotalSessions;
    property MaxLogSize: Integer read FMaxLogSize write FMaxLogSize;
    property MaxLogFiles: Integer read FMaxLogFiles write FMaxLogFiles;
    property TotalCacheHits: Integer read FTotalCacheHits write FTotalCacheHits;
  end;

var
  LogWriter: TfrxServerLog;

const
  ERROR_LEVEL = 0;
  ACCESS_LEVEL = 1;
  REFERER_LEVEL = 2;
  AGENT_LEVEL = 3;
  SERVER_LEVEL = 4;
  SCHEDULER_LEVEL = 5;

implementation

{ TfrxServerLog }

constructor TfrxServerLog.Create;
begin
  inherited Create(True);
  FLogging := False;
  Priority := tpLowest;
  FLevels := TList.Create;
  FLevelFName := TStringList.Create;
  FTotalSessions := 0;
  FMaxSessions := 0;
  FTotalReports := 0;
  FMaxReports := 0;
  FMaxReportTime := 0;
  FTotalReportTime := 0;
  FTotalCacheHits := 0;
  FCurrentSessions := 0;
  FCurrentReports := 0;
  FErrorsCount := 0;
  FCS := TCriticalSection.Create;
  FThreadActive := False;
  Resume;
end;

destructor TfrxServerLog.Destroy;
begin
  Clear;
  Terminate;
//  PMessages;
  while FThreadActive do
  begin
    Sleep(10);
    PMessages;
  end;
  FLevels.Free;
  FLevelFName.Free;
  FCS.Free;
  inherited;
end;

procedure TfrxServerLog.Clear;
var
  i: Integer;
begin
  Flush;
  for i := 0 to FLevels.Count - 1 do
    TStringList(FLevels[i]).Free;
  FLevels.Clear;
  FLevelFName.Clear;
end;

procedure TfrxServerLog.SetCurrentReports(Value: Integer);
begin
  FCS.Enter;
  try
    FCurrentReports := Value;
  finally
    FCS.Leave;
  end;
end;

procedure TfrxServerLog.SetCurrentSessions(Value: Integer);
begin
  FCS.Enter;
  try
    FCurrentSessions := Value;
  finally
    FCS.Leave;
  end;
end;

function TfrxServerLog.AddLevel(const FileName: String): Integer;
var
  Level: TStringList;
begin
  Level := TStringList.Create;
  FLevels.Add(Level);
  FLevelFName.Add(FileName);
  Result := FLevels.Count - 1;
end;

procedure TfrxServerLog.Write(const Level: Integer; const Msg: String);
begin
  FCS.Enter;
  try
    if Length(Msg) > 0 then
      TStringList(FLevels[Level]).Add(Msg);
  finally
    FCS.Leave;
  end;
end;

procedure TfrxServerLog.Execute;
var
  i: Integer;
begin
  FThreadActive := True;
  while not Terminated do
  begin
    Flush;
    i := 0;
    while (not Terminated) and (i < 100) do
    begin
      Sleep(10);
      Inc(i);
      PMessages;
    end;
  end;
  FThreadActive := False;
end;

procedure TfrxServerLog.Flush;
var
  i: Integer;
  Level: TStringList;
  Msg: String;
begin
  FCS.Enter;
  try
    for i := 0 to FLevels.Count - 1 do
    begin
      Level := TStringList(FLevels[i]);
      if (Level.Count > 0) then
      begin
        Msg := Level.Text;
        Level.Clear;
        if FLogging then
          WriteFile(FLevelFName[i], Msg);
      end;
    end;
  finally
    FCS.Leave;
  end;
end;

procedure TfrxServerLog.WriteFile(const FName, Text: String);
var
  FStream: TFileStream;
  FSize: Extended;
{$IFDEF DELPHI12}
  EncString: AnsiString;
{$ENDIF}
begin
    FSize := 0;
    if FLogging and (Length(Trim(Text)) > 0) then
    begin
      if not FileExists(FLogDir + FName) then
      begin
        try
          FStream := TFileStream.Create(FLogDir + FName, fmCreate);
{$IFDEF DELPHI12}
          FStream.Write(ANsiString(#239#187#191), 3);  // UTF8 signature
{$ENDIF}
          FStream.Free;
        except
          FLogging := False;
        end;
      end;
      try
        FStream := TFileStream.Create(FLogDir + FName, fmOpenWrite + fmShareDenyWrite);
        try
          FStream.Seek(0, soFromEnd);
{$IFDEF DELPHI12}
          EncString := UTF8Encode(Text);
          FStream.Write(EncString[1], Length(EncString));
{$ELSE}
          FStream.Write(Text[1], Length(Text));
{$ENDIF}
          FSize := FStream.Size div 1024;
        finally
          FStream.Free;
          if FSize > FMaxLogSize then
            LogRotate(FLogDir + FName);
        end;
      except
        FLogging := False;
      end;
    end;
end;

procedure TfrxServerLog.StatAddReports(i: Integer);
begin
  FCS.Enter;
  try
    FTotalReports := FTotalReports + i;
  finally
    FCS.Leave;
  end;
end;

procedure TfrxServerLog.StatAddSessions(i: Integer);
begin
  FCS.Enter;
  try
    FTotalSessions := FTotalSessions + i;
  finally
    FCS.Leave;
  end;
end;

procedure TfrxServerLog.StartAddReportTime(i: Integer);
begin
  FCS.Enter;
  try
    FTotalReportTime := FTotalReportTime + i;
    if i > FMaxReportTime then
      FMaxReportTime := i;
  finally
    FCS.Leave;
  end;
end;

procedure TfrxServerLog.StatAddCurrentReport;
begin
  FCS.Enter;
  try
    FCurrentReports := FCurrentReports + 1;
    if FCurrentReports > FMaxReports then
      FMaxReports := FCurrentReports;
  finally
    FCS.Leave;
  end;
  StatAddReports(1);
end;

procedure TfrxServerLog.StatAddCurrentSession;
begin
  FCS.Enter;
  try
    FCurrentSessions := FCurrentSessions + 1;
    if FCurrentSessions > FMaxSessions then
      FMaxSessions := FCurrentSessions;
  finally
    FCS.Leave;
  end;
  StatAddSessions(1);
end;

procedure TfrxServerLog.StatAddCacheHit;
begin
  FCS.Enter;
  try
    Inc(FTotalCacheHits);
  finally
    FCS.Leave;
  end;
end;

procedure TfrxServerLog.StatRemoveCurrentReport;
begin
  FCS.Enter;
  try
    FCurrentReports := FCurrentReports - 1;
  finally
    FCS.Leave;
  end;
end;

procedure TfrxServerLog.StatRemoveCurrentSession;
begin
  FCS.Enter;
  try
    FCurrentSessions := FCurrentSessions - 1;
  finally
    FCS.Leave;
  end;
end;

procedure TfrxServerLog.ErrorReached;
begin
  FCS.Enter;
  try
    Inc(FErrorsCount);
  finally
    FCS.Leave;
  end;
end;

procedure TfrxServerLog.LogRotate(const FName: String);
var
  TmpStream: TFileStream;
  OutStream: TFileStream;
  i: Integer;
  s: String;
{$IFDEF DELPHI12}
  AnsiStr: AnsiString;
{$ENDIF}
  FRotated: Boolean;
begin
  FRotated := False;
  if FMaxLogFiles > 1 then
  begin
    i := FMaxLogFiles - 1;
    while i > 0 do
    begin
      s := ChangeFileExt(FName, '.log-' + IntToStr(i));
      if FileExists(s) then
        if i < (FMaxLogFiles - 1) then
          RenameFile(s, ChangeFileExt(s, '.log-' + IntToStr(i + 1)))
        else
          DeleteFile(s);
      i := i - 1;
    end;
    RenameFile(FName, ChangeFileExt(FName, '.log-1'))
  end
  else begin
    try
      TmpStream := TFileStream.Create(FName, fmOpenRead + fmShareDenyWrite);
      try
        if TmpStream.Size > FMaxLogSize * 1024 then
        begin
          TmpStream.Position := TmpStream.Size - FMaxLogSize * 1024;
{$IFDEF DELPHI12}
            AnsiStr := ' ';
          while (AnsiStr[1] <> #13) and (TmpStream.Position < TmpStream.Size) do
            TmpStream.Read(AnsiStr[1], 1);
          if AnsiStr[1] = #13 then
          begin
            TmpStream.Read(AnsiStr[1], 1);
            if AnsiStr[1] = #10 then
{$ELSE}
          s := ' ';
          while (s[1] <> #13) and (TmpStream.Position < TmpStream.Size) do
            TmpStream.Read(s[1], 1);
          if s[1] = #13 then
          begin
            TmpStream.Read(s[1], 1);
            if s[1] = #10 then
{$ENDIF}
            begin
              try
                s := ChangeFileExt(FName, '.tmp');
                OutStream := TFileStream.Create(s, fmCreate);
                try
                  OutStream.CopyFrom(TmpStream, TmpStream.Size - TmpStream.Position);
                  FRotated := True;
                finally
                  OutStream.Free;
                end;
              except
              end;
            end;
          end;
        end;
      finally
        TmpStream.Free;
        if FRotated then
        begin
          DeleteFile(FName);
          RenameFile(s, FName);
        end;
      end;
    except
    end;
  end;
end;

end.
