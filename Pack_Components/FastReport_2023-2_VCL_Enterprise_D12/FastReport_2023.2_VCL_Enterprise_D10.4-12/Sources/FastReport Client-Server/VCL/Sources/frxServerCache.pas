
{******************************************}
{                                          }
{             FastReport VCL               }
{            Server cahce module           }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxServerCache;

{$I frx.inc}

interface

uses
     {$IFNDEF Linux}
     Windows,
     {$ENDIF}
     {$IFDEF LCLGTK2}
     gdk2,
     {$ENDIF}
     Classes, SysUtils, frxUtils, frxServerUtils, frxNetUtils,
     frxVariables, frxClass, frxServerLog, SyncObjs;

type
  TfrxServerCacheItem = class(TCollectionItem)
  private
    FReportName: String;
    FVariables: TfrxVariables;
    FFileName: String;
    FExpTime: TDateTime;
    FSessionId: String;
    FStream: TStream;
    FInternalId: String;
    FFileType: TfrxServerFormat;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property ReportName: String read FReportName write FReportName;
    property Variables: TfrxVariables read FVariables write FVariables;
    property FileName: String read FFileName write FFileName;
    property FileType: TfrxServerFormat read FFileType write FFileType;
    property ExpTime: TDateTime read FExpTime write FExpTime;
    property SessionId: String read FSessionId write FSessionId;
    property Stream: TStream read FStream write FStream;
    property InternalId: String read FInternalId write FInternalId;
  end;

  TfrxServerCacheSpool = class(TCollection)
  private
    function GetItems(Index: Integer): TfrxServerCacheItem;
    function EqualVariables(const Var1: TfrxVariables; const Var2: TfrxVariables): Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    property Items[Index: Integer]: TfrxServerCacheItem read GetItems;
    procedure Clear;
  published
    function Add: TfrxServerCacheItem;
    function Insert(Index: Integer): TfrxServerCacheItem;
    function IndexOf(const ReportName: String; const Variables: TfrxVariables; const SessionId: String; const aFileFormat: TfrxServerFormat): Integer;
  end;

  TfrxServerCache = class (TThread)
  protected
    FCACHE_PREFIX: String;
    FCachePath: String;
    FActive: Boolean;
    FLatency: Integer;
    FHeap: TfrxServerCacheSpool;
    FMemoryCache: Boolean;
    FThreadActive: Boolean;
    procedure SetActive(const Value: Boolean);
    procedure CleanUpFiles; virtual;
    procedure RemoveExpired; virtual;
    procedure Execute; override;
  public
    constructor Create(WithInitialization: Boolean = True);
    destructor Destroy; override;
    function GetCachedStream(const Report: TfrxReport; const ReportName: String; const Variables: TfrxVariables; const Id: String): Boolean; overload;
    function GetCachedReportById(const Report: TfrxReport; const Id: String): Boolean;
    function IsReportInCache(const ReportName: String; const Variables: TfrxVariables; const Id: String; const aFileFormat: TfrxServerFormat = sfFRP): Boolean;
    function CopyCacheFileIfExist(const aFileName: String; const ReportName: String; const Variables: TfrxVariables; const Id: String; const aFileFormat: TfrxServerFormat = sfFRP): Boolean;
    procedure Open;
    procedure Close;
    procedure Clear;
    procedure AddReport(const Report: TfrxReport;
      const ReportName: String; const Variables: TfrxVariables; const Id: String; const InternalId: String);
    procedure AddFileFormat(const sStream: TStream; const aFileFormat: TfrxServerFormat;
      const ReportName: String; const Variables: TfrxVariables; const Id: String; const InternalId: String); virtual;

    property Active: Boolean read FActive write SetActive;
    property CachePath: String read FCachePath write FCachePath;
    property DefaultLatency: Integer read FLatency write FLatency;
    property Heap: TfrxServerCacheSpool read FHeap;
    property MemoryCache: Boolean read FMemoryCache write FMemoryCache;
    property CACHE_PREFIX: String read FCACHE_PREFIX write FCACHE_PREFIX;
  end;

  TfrxResultCache = class (TfrxServerCache)  //for caching fp3 export results
  protected
    procedure CleanUpFiles; override;
  public
    constructor Create(aCachePath, aCACHE_PREFIX: String); overload;
    procedure AddFileFormat(const sStream: TStream; const aFileFormat: TfrxServerFormat;
      const ReportName: String; const Variables: TfrxVariables; const Id: String; const InternalId: String); override;
    procedure RemoveExpired; override;
    procedure UpdExpTime(const ReportName: String; const Variables: TfrxVariables; const SessionId: String; const aFileFormat: TfrxServerFormat);
  end;

var
  CacheCS1: TCriticalSection;
  ReportCache: TfrxServerCache;
  ResultCache: TfrxResultCache;

  procedure RemoveAll(path: string);
  function GetFileCount(Dir: string): Integer;

implementation

uses frxFileUtils, frxServerConfig, frxServerReportsList, frxIOTransportIntf;

procedure Lock();
begin
{$IFDEF LCLGTK2}
  gdk_threads_enter;
{$ENDIF}
end;

procedure Unlock();
begin
{$IFDEF LCLGTK2}
  gdk_threads_leave;
{$ENDIF}
end;

{ TfrxServerCacheSpool }

function TfrxServerCacheSpool.Add: TfrxServerCacheItem;
begin
  Result := TfrxServerCacheItem.Create(Self);
end;

procedure TfrxServerCacheSpool.Clear;
var
  i: Integer;
begin
  CacheCS1.Enter;
  try
  for i := 0 to Count - 1 do
    if Assigned(Items[i].Stream) then
    begin
        Items[i].Stream.Free;
        Items[i].Stream := nil;
    end;
  finally
    CacheCS1.Leave;
  end;
  inherited Clear;
end;

constructor TfrxServerCacheSpool.Create;
begin
  inherited Create(TfrxServerCacheItem);
end;

destructor TfrxServerCacheSpool.Destroy;
begin
  inherited;
end;

function TfrxServerCacheSpool.EqualVariables(const Var1,
  Var2: TfrxVariables): Boolean;
var
  i, j, k: Integer;
begin
  Result := False;
  if Assigned(Var1) and Assigned(Var2) then
  begin
    j := Var1.Count;
    if j = Var2.Count then
    begin
      Result := True;
      for i := 0 to j - 1 do
      begin
        k := Var2.IndexOf(Var1.Items[i].Name);
        if (k = -1) or (Var2.Items[k].Value <> Var1.Items[i].Value) then
        begin
          Result := False;
          Break;
        end;
      end;
    end;
  end
  else if Var1 = Var2 then
    Result := True;
end;

function TfrxServerCacheSpool.GetItems(Index: Integer): TfrxServerCacheItem;
begin
  Result := TfrxServerCacheItem(inherited Items[Index]);
end;

function TfrxServerCacheSpool.IndexOf(const ReportName: String;
  const Variables: TfrxVariables; const SessionId: String; const
  aFileFormat: TfrxServerFormat): Integer;
var
  i: Integer;
  s: String;
begin
  Result := -1;
  for i := 0 to Count - 1 do
  begin
    s := Items[i].SessionId;
    if ((aFileFormat = Items[i].FileType) and
      (AnsiCompareText(ReportName, Items[i].ReportName) = 0) and
       EqualVariables(Items[i].Variables, Variables)) and (s = '') or
       ((AnsiCompareText(SessionId, s) = 0) and (s <> '')) then
    begin
      Result := i;
      break;
    end;
  end;
end;

function TfrxServerCacheSpool.Insert(Index: Integer): TfrxServerCacheItem;
begin
  Result := TfrxServerCacheItem(inherited Insert(Index));
end;

{ TfrxServerCacheItem }

constructor TfrxServerCacheItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FStream := nil;
  FFileType := sfFRP;
end;

destructor TfrxServerCacheItem.Destroy;
begin
  CacheCS1.Enter;
  try
    if Assigned(FStream) then
      FStream.Free;
    if Assigned(FVariables) then
      FVariables.Free;
  finally
    CacheCS1.Leave;
  end;
  inherited;
end;

{ TfrxServerCache }

procedure TfrxServerCache.AddReport(const Report: TfrxReport;
  const ReportName: String; const Variables: TfrxVariables; const Id: String; const InternalId: String);
var
  Item: TfrxServerCacheItem;
  Lat: TDateTime;
begin
  if Active then
  begin
    CacheCS1.Enter;
    try
      Lat := ReportsList.GetCacheLatency(ReportName) / 86400;
      if Lat > 0 then
      begin
        Item := FHeap.Add;
        Item.ReportName := ReportName;
        Item.InternalId := InternalId;
        if Assigned(Variables) then
        begin
          Item.Variables := TfrxVariables.Create;
          Item.Variables.Assign(Variables);
        end;
        Item.ExpTime := Now + Lat;
        if Id <> '' then
          Item.ExpTime := Item.ExpTime * 20;
        if FMemoryCache then
        begin
          Item.Stream := TMemoryStream.Create;
          try
            Report.PreviewPages.SaveToStream(Item.Stream);
            Item.Stream.Position := 0;
          except
            Item.Stream.Free;
            FMemoryCache := False;
          end;
        end;
        if not FMemoryCache then
        begin
          Item.FileName := GetUniqueFileName(FCachePath, CACHE_PREFIX);
          try
            Report.PreviewPages.SaveToFile(Item.FileName);
          except
            Active := False;
          end;
        end;
        Item.SessionId := Id;
      end;
    finally
      CacheCS1.Leave;
    end;
  end;
end;

procedure TfrxServerCache.CleanUpFiles;
var
  SRec: TSearchRec;
  i: Integer;
begin
 if DirectoryExists(FCachePath) then
 begin
   i := FindFirst(FCachePath + CACHE_PREFIX + '*.*', 0, SRec);
   try
     while i = 0 do
     begin
       try
         DeleteFile(FCachePath + SRec.Name);
       except
       end;
       i := FindNext(SRec);
     end;
   finally
     FindClose(SRec);
   end;
 end;
end;

procedure TfrxServerCache.Clear;
begin
  FHeap.Clear;
  CleanUpFiles;
end;

procedure TfrxServerCache.Close;
begin
  if FActive then
  begin
    Suspend;
    Clear;
    FActive := False;
  end;
end;

function TfrxServerCache.CopyCacheFileIfExist(const aFileName,
  ReportName: String; const Variables: TfrxVariables; const Id: String;
  const aFileFormat: TfrxServerFormat): Boolean;
var
  FileIn , FileOut: TFileStream;
begin
  Result := False;
  if Active then
  begin
    CacheCS1.Enter;
    try
      if FHeap.IndexOf(ReportName, Variables, Id, aFileFormat) <> - 1 then
      begin
        FileOut := TFileStream.Create(aFileName, fmCreate);
        FileIn := TFileStream.Create(ReportCache.CachePath +  CACHE_PREFIX + ReportName, fmOpenRead or fmShareDenyWrite);
        try
          FileIn.Position := 0;
          FileOut.CopyFrom(FileIn, FileIn.Size);
          Result := FileIn.Size > 0;
        finally
          FileIn.Free;
          FileOut.Free;
        end;
      end;
    finally
      CacheCS1.Leave;
    end;
  end;
  if Result then
    LogWriter.StatAddCacheHit;
end;

constructor TfrxServerCache.Create(WithInitialization: Boolean = True);
begin
  inherited Create(True);
  FMemoryCache := ServerConfig.GetValue('server.cache.target') = 'memory';
  FActive := ServerConfig.GetValue('server.cache.active') = 'yes';
  FLatency := StrToInt(ServerConfig.GetValue('server.cache.defaultlatency'));
  FHeap := TfrxServerCacheSpool.Create;
  if (WithInitialization) then
  begin
    FCachePath := frxGetAbsPathDir(ServerConfig.GetValue('server.cache.path'), ServerConfig.ConfigFolder);
    FCACHE_PREFIX := '$fr_';
  end;
  CleanUpFiles;
  Resume;
end;

destructor TfrxServerCache.Destroy;
begin
  Clear;
  Terminate;
  PMessages;
  while FThreadActive do
    Sleep(10);
  FHeap.Free;
  inherited;
end;

procedure TfrxServerCache.Execute;
var
  i: Integer;
begin
  FThreadActive := True;
  while not Terminated do
  begin
    RemoveExpired;
    i := 0;
    while (not Terminated) and (i < 100) do
    begin
      Sleep(100);
      Inc(i);
      PMessages;
    end;
  end;
  FThreadActive := False;
end;

function TfrxServerCache.GetCachedStream(const Report: TfrxReport;
  const ReportName: String; const Variables: TfrxVariables; const Id: String): Boolean;
var
  i: Integer;
begin
  Result := False;
  if Active then
  begin
    CacheCS1.Enter;
    try
      i := FHeap.IndexOf(ReportName, Variables, Id, sfFRP);
      if i <> -1 then
      begin
        try
          FHeap.Items[i].ExpTime := Now + StrToInt(ServerConfig.GetValue('server.cache.defaultlatency')) / 86400;
          if Assigned(FHeap.Items[i].Stream) then
          begin
            FHeap.Items[i].Stream.Position := 0;
            try
              Lock;
              Report.PreviewPages.LoadFromStream(FHeap.Items[i].Stream);
            finally
              Unlock;
            end;
            Result := True;
          end
          else if FileExists(FHeap.Items[i].FileName) then
          begin
            try
              Lock;
              Report.PreviewPages.LoadFromFile(FHeap.Items[i].FileName);
            finally
              Unlock;
            end;
            Result := True;
          end;
        except
          on e: Exception do
          begin
            LogWriter.Write(ERROR_LEVEL, DateTimeToStr(Now) + #9 + Id + #9'cache read error: ' + FHeap.Items[i].FileName + ' ' + Report.Errors.Text + e.Message);
            LogWriter.ErrorReached;
            Result := False;
          end;
        end;
      end
    finally
      CacheCS1.Leave;
    end;
  end;
  if Result then
    LogWriter.StatAddCacheHit;
end;

function TfrxServerCache.IsReportInCache(const ReportName: String;
  const Variables: TfrxVariables; const Id: String; const aFileFormat: TfrxServerFormat = sfFRP): Boolean;
var
  i: Integer;
begin
  Result := False;
  if Active then
  begin
    CacheCS1.Enter;
    try
      i := FHeap.IndexOf(ReportName, Variables, Id, aFileFormat);
      if i <> - 1 then
      begin
        FHeap.Items[i].ExpTime := Now + StrToInt(ServerConfig.GetValue('server.cache.defaultlatency')) / 86400;
        Result := True;
      end;
    finally
      CacheCS1.Leave;
    end;
  end;
  if Result then
    LogWriter.StatAddCacheHit;
end;

procedure TfrxServerCache.Open;
begin
  if not FActive then
  begin
    Resume;
    FActive := True;
  end;
end;

procedure TfrxServerCache.RemoveExpired;
var
  i: Integer;
begin
  i := 0;
  CacheCS1.Enter;
  try
    while i < FHeap.Count do
    begin
      if FHeap.Items[i].ExpTime <= Now then
      begin
        if Assigned(FHeap.Items[i].Stream) then
        begin
          FHeap.Items[i].Stream.Free;
          FHeap.Items[i].Stream := nil;
        end;
        if FileExists(FHeap.Items[i].FileName) then
          DeleteFile(FHeap.Items[i].FileName);
        FHeap.Items[i].Free; // Delete(i);
      end else Inc(i);
    end;
  finally
    CacheCS1.Leave;
  end;
end;

procedure TfrxServerCache.SetActive(const Value: Boolean);
begin
  if Value <> FActive then
    if Value then Open
    else Close;
end;

function TfrxServerCache.GetCachedReportById(const Report: TfrxReport;
  const Id: String): Boolean;
var
  i: Integer;
begin
  Result := False;
  if Active then
  begin
    CacheCS1.Enter;
    try
      for i := 0 to FHeap.Count - 1 do
      begin
        if FHeap.Items[i].InternalId = Id then
        begin
          try
            if Assigned(FHeap.Items[i].Stream) then
            begin
              FHeap.Items[i].Stream.Position := 0;
              try
                Lock;
                Report.PreviewPages.LoadFromStream(FHeap.Items[i].Stream);
              finally
                Unlock;
              end;
              //Result := True;
            end
            else if FileExists(FHeap.Items[i].FileName) then
            begin
              try
                Lock;
                Report.PreviewPages.LoadFromFile(FHeap.Items[i].FileName);
              finally
                Unlock;
              end;
              //Result := True;
            end;
          except
            on e: Exception do
            begin
              LogWriter.Write(ERROR_LEVEL, DateTimeToStr(Now) + #9 + Id + #9'cache read error: ' + FHeap.Items[i].FileName + ' ' + Report.Errors.Text + e.Message);
              LogWriter.ErrorReached;
              //Result := False;
            end;
          end;
          Result := True;
          break;
        end;

      end;
    finally
      CacheCS1.Leave;
    end;
  end;
  if Result then
    LogWriter.StatAddCacheHit;
end;

procedure TfrxServerCache.AddFileFormat(const sStream: TStream;
  const aFileFormat: TfrxServerFormat; const ReportName: String;
  const Variables: TfrxVariables; const Id, InternalId: String);
begin
//
end;

{TfrxResultCache}

constructor TfrxResultCache.Create(aCachePath, aCACHE_PREFIX: String);
begin
  FCachePath := aCachePath;
  FCACHE_PREFIX := aCACHE_PREFIX;
  inherited Create(False);
end;

procedure TfrxResultCache.CleanUpFiles;
var
  searchResult: TSearchRec;
begin
  if FindFirst(FCachePath + CACHE_PREFIX + '*', faDirectory, searchResult) = 0 then
  begin
    repeat
      RemoveAll(FCachePath + searchResult.Name);
    until FindNext(searchResult) <> 0;
    FindClose(searchResult);
  end;
end;

procedure TfrxResultCache.AddFileFormat(const sStream: TStream; const aFileFormat: TfrxServerFormat;
      const ReportName: String; const Variables: TfrxVariables; const Id: String; const InternalId: String);
var
  Item: TfrxServerCacheItem;
  Lat: TDateTime;
begin
  if Active then
  begin
    CacheCS1.Enter;
    try
      Lat := ReportsList.GetCacheLatency(ReportName) / 86400;
      if Lat > 0 then
      begin
        Item := FHeap.Add;
        Item.FileType := aFileFormat;
        Item.ReportName := ReportName;
        Item.InternalId := InternalId;
        if Assigned(Variables) then
        begin
          Item.Variables := TfrxVariables.Create;
          Item.Variables.Assign(Variables);
        end;
        Item.ExpTime := Now + Lat;
        Item.FileName := FCachePath + PathDelim + Id + PathDelim+ ReportName;
        Item.ReportName := ReportName;
        Item.SessionId := Id;
        sStream.Position := 0;
      end;
    finally
      CacheCS1.Leave;
    end;
  end;
end;

procedure TfrxResultCache.RemoveExpired;
var
  i: Integer;
  folder: String;
begin
  i := 0;
  CacheCS1.Enter;
  try
    while i < FHeap.Count do
    begin
      if FHeap.Items[i].ExpTime <= Now then
      begin
        if FileExists(FHeap.Items[i].FileName) then
        begin
          DeleteFile(FHeap.Items[i].FileName);
          folder := ExtractFileDir(FHeap.Items[i].FileName);
          if GetFileCount(folder) = 0 then
            RemoveDir(folder);
        end;
        FHeap.Items[i].Free; // Delete(i);
      end else Inc(i);
    end;
  finally
    CacheCS1.Leave;
  end;
end;

procedure TfrxResultCache.UpdExpTime(const ReportName: String; const Variables: TfrxVariables; const SessionId: String; const aFileFormat: TfrxServerFormat);
var
  i: Integer;
begin
  if Active then
  begin
    CacheCS1.Enter;
    try
      i := FHeap.IndexOf(ReportName, Variables, SessionId, aFileFormat);
      if i <> -1 then
      begin
        FHeap.Items[i].ExpTime := Now + StrToInt(ServerConfig.GetValue('server.cache.defaultlatency')) / 86400;
      end
    finally
      CacheCS1.Leave;
    end;
  end;
end;

{other function}

procedure RemoveAll(path: string);
var
  sr: TSearchRec;
begin
  if FindFirst(path + PathDelim + '*.*', faAnyFile, sr) = 0 then
  begin
    repeat
      if sr.Attr and faDirectory = 0 then
      begin
        DeleteFile(path + PathDelim + sr.name);
      end
      else
      begin
        if pos('.', sr.name) <= 0 then
          RemoveAll(path + PathDelim + sr.name);
      end;
    until
      FindNext(sr) <> 0;
  end;
  FindClose(sr);
  {$IFNDEF FPC}
  RemoveDirectory(PChar(path));
  {$ELSE}
  DeleteFolder(path);
  {$ENDIF}
end;

function GetFileCount(Dir: string): Integer;
var
  fs: TSearchRec;
begin
  Result:=0;
  if FindFirst(Dir + PathDelim + '*.*',faAnyFile - faDirectory - faVolumeID, fs) = 0 then
    repeat
      inc(Result);
    until FindNext(fs) <> 0;
  FindClose(fs);
end;

initialization
  CacheCS1 := TCriticalSection.Create;

finalization
  CacheCS1.Free;

end.
