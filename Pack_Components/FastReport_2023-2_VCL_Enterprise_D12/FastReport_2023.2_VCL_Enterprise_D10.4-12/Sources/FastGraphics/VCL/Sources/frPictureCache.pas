
{******************************************}
{                                          }
{          FastReport VCL/FMX/LCL          }
{             Graphics Library             }
{                                          }
{         Copyright (c) 1998-2022          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frPictureCache;

interface

{$I frVer.inc}

uses
  {$IFNDEF FPC}
  Windows, Messages,
  {$ELSE}
  Types,
  {$ENDIF}
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  frXML, frBaseGraphicsTypes, SyncObjs, Variants, frHashUtils;


type
  TfrxCacheItem = packed record
    Segment: Longint;
    Offset: Longint;
    Loading: Integer;
    Width: Integer;
    Height: Integer;
  end;

  TfrxThumbnailsUpdateState = (tusAdded, tusClear);
  PfrxCacheItem = ^TfrxCacheItem;

  TfrxThumbnailsUpdate = procedure (Sender: TObject; UpdateState: TfrxThumbnailsUpdateState) of object;

  TFindOrAddGraphic = function (g: TGraphic; ResultType: TfrPictureHashMapResultType; IntData: Integer = -1): Integer of object;
  TGetIsLastNew = function: Boolean of object;

  TfrxPictureHashMap = class
  private
    //For Real
    FfrxDataHashMap: TfrDataHashMap;
    FIsLastNew: Boolean;
    //For Fake
    FCount: Integer;

    FRealHash: Boolean;
    FFindOrAddGraphic: TFindOrAddGraphic;
    FGetIsLastNew: TGetIsLastNew;

    function RealFindOrAddGraphic(g: TGraphic; ResultType: TfrPictureHashMapResultType; IntData: Integer = -1): Integer;
    function RealGetIsLastNew: Boolean;
    function FakeFindOrAddGraphic(g: TGraphic; ResultType: TfrPictureHashMapResultType; IntData: Integer = -1): Integer;
    function FakeGetIsLastNew: Boolean;

    procedure SetRealHash(RealHash: Boolean);

  public
    constructor Create(RealHash: Boolean);
    destructor Destroy; override;

    property FindOrAddGraphic: TFindOrAddGraphic read FFindOrAddGraphic;
    property IsLastNew: TGetIsLastNew read FGetIsLastNew;
    property RealHash: Boolean read FRealHash write SetRealHash;
  end;

  TfrxCacheList = class(TObject)
  private
    function Get(Index: Integer): PfrxCacheItem;
  protected
    FItems: TList;
  protected
    procedure Clear;
  public
    constructor Create;
    destructor Destroy; override;
    function Add: PfrxCacheItem;
    function Count: Integer;
    function GetSize(const Index: Integer): TSize;
    property Items[Index: Integer]: PfrxCacheItem read Get; default;
  end;

  TfrxFileStream = class(TFileStream)
  private
    FSz: LongWord;
  public
    function Seek(Offset: Longint; Origin: Word): Longint; override;
{$IFDEF DELPHI6}
    function Seek(const Offset: Int64; Origin: TSeekOrigin): Int64; override;
{$ENDIF}
  end;

  TfrxMemoryStream = class(TMemoryStream)
  private
    FSz: LongWord;
  public
    function Seek(Offset: Longint; Origin: Word): Longint; override;
{$IFDEF DELPHI6}
    function Seek(const Offset: Int64; Origin: TSeekOrigin): Int64; override;
{$ENDIF}
  end;


  TfrxInternalPictureCache = class(TObject)
  private
    FItems: TfrxCacheList;
    FCacheStreamList: TList;
    FTempFile: TStringList;
    FTempDir: String;
    FUseFileCache: Boolean;
    FCrit: TCriticalSection;
    function Add: PfrxCacheItem;
    procedure SetTempDir(const Value: String);
    procedure SetUseFileCache(const Value: Boolean);
    procedure AddSegment;
    function InternalGetPicture(APicture: TPicture; aGraphic: TGraphic; ImageIndex: Integer): TGraphic;
  protected
    function Count: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    function AddPicture(aGraphic: TGraphic): Integer;
    procedure GetPicture(aGraphic: TGraphic; ImageIndex: Integer); overload;
    procedure GetPicture(Picture: TPicture; ImageIndex: Integer); overload;
    function GetPicture(const ImageIndex: Integer): TGraphic; overload;
    function GetSize(const ImageIndex: Integer): TSize;
    procedure SetSize(const ImageIndex: Integer; Width, Height: Integer);
    function IsExist(const ImageIndex: Integer): Boolean;
    procedure SaveToXML(Item: TfrXMLItem);
    procedure LoadFromXML(Item: TfrXMLItem);
    property UseFileCache: Boolean read FUseFileCache write SetUseFileCache;
    property TempDir: String read FTempDir write SetTempDir;
  end;

  TfrxPictureCache = class;

  TfrxThumbnailThread = class(TThread)
  private
    FCache: TfrxPictureCache;
    procedure DoUpdate;
  public
    constructor Create(ACache: TfrxPictureCache);
    destructor Destroy; override;
    procedure Execute; override;
  end;

  TfrxPictureCache = class(TInterfacedObject, IfrxPictureCache)
  private
    FPictureCache: TfrxInternalPictureCache;
    FThumbnailCache: TfrxInternalPictureCache;
    FCahcedBitmap: TStringList;
//    FThumbnailThread: TfrxThumbnailThread;
    FOnThumbnailUpdated: TfrxThumbnailsUpdate;
    FIsUpdating: Boolean;
    FPictureCacheOptions: TfrxPictureCacheOptions;
    FfrxPictureHashMap: TfrxPictureHashMap;
    function GetTempDir: String;
    function GetUseFileCache: Boolean;
    procedure SetTempDir(const Value: String);
    procedure SetUseFileCache(const Value: Boolean);
    function GetPicture(const ImageIndex: Integer; const CacheType: TfrxCachedGraphicType): TGraphic; overload;
    procedure BuildThumbnailFromCache;
    procedure StartThumbnailThread;
    procedure FreeThumbnailThread;
    function CalcThumbnailSize(const Width, Height: Integer; const CacheType: TfrxCachedGraphicType): TSize;
    procedure ThumbnailUpdate(State: TfrxThumbnailsUpdateState);
    procedure SetPictureCacheOptions(const Value: TfrxPictureCacheOptions);
    function AddPictureTo(aGraphic: TGraphic; InternalCache: TfrxInternalPictureCache): Integer;
    function IsAutoRefMode: Boolean;
    function GetSize(const CacheType: TfrxCachedGraphicType; const ImageIndex: Integer): TSize;
    function GetCount: Integer;
    procedure UpdatePictureCacheOptions;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure BuildFinished;
    function AddPicture(aGraphic: TGraphic): Integer;
    procedure GetGraphic(aGraphic: TGraphic; ImageIndex: Integer); overload;
    procedure GetPicture(APicture: TPicture; ImageIndex: Integer); overload;
    function GetGraphic(ImageIndex: Integer): TGraphic; overload;
    function GetCachedBitmap(CacheType: TfrxCachedGraphicType; ImageIndex: Integer): IfrxCachedGraphic;
    function GetPictureTo(APicture: TPicture; aGraphic: TGraphic; ImageIndex: Integer): TGraphic; overload;
    procedure SaveToXML(Item: TfrXMLItem);
    procedure LoadFromXML(Item: TfrXMLItem);
    property UseFileCache: Boolean read GetUseFileCache write SetUseFileCache;
    property TempDir: String read GetTempDir write SetTempDir;
    property PictureCacheOptions: TfrxPictureCacheOptions read FPictureCacheOptions write SetPictureCacheOptions;
    property OnThumbnailUpdated: TfrxThumbnailsUpdate read FOnThumbnailUpdated write FOnThumbnailUpdated;
    property Count: Integer read GetCount;
  end;

implementation

uses
  frPictureGraphics,
  frThreading, frCore;

type
  TfrxAutoRefGraphic = class(TInterfacedObject, IfrxCachedGraphic)
  private
    FParentList: TStringList;
    FGraphic: TGraphic;
    FOriginalWidth: Integer;
    FOriginalHeight: Integer;
    FIndex: Integer;
    FCacheType: TfrxCachedGraphicType;
    FPictureCache: TfrxPictureCache;
  protected
    function GetCacheType: TfrxCachedGraphicType;
    procedure SetCacheType(CacheType: TfrxCachedGraphicType);
    function GetOriginalSize: TSize;
  public
    constructor Create(ParentList: TStringList; Index: Integer; CacheType: TfrxCachedGraphicType; APictureCache: TfrxPictureCache);
    destructor Destroy; override;
    procedure Draw(Canvas: TCanvas; X, Y, X1, Y1: Integer);
    function GetGraphic(CacheType: TfrxCachedGraphicType): TGraphic;
  end;

function GraphicToMD5(aGraphic: TGraphic): String;
var
  mem: TMemoryStream;
begin
  mem := TMemoryStream.Create;
  try
    aGraphic.SaveToStream(mem);
    Result := String(frMD5Stream(mem));
  finally
    mem.Free;
  end;
end;

function frxStreamToString(Stream: TStream; Size: Integer): String;
var
{$IFDEF DELPHI12}
    p: PAnsiChar;
{$ELSE}
    p: PChar;
{$ENDIF}
begin
  SetLength(Result, Size * 2);
  GetMem(p, Size);
  Stream.Read(p^, Size);
  BinToHex(p, PChar(@Result[1]), Size);
  FreeMem(p, Size);
end;

procedure frxStringToStream(const s: String; Stream: TStream);
var
  Size: Integer;
{$IFDEF DELPHI12}
    p: PAnsiChar;
{$ELSE}
    p: PChar;
{$ENDIF}
begin
  Size := Length(s) div 2;
  GetMem(p, Size);
  HexToBin(PChar(@s[1]), p, Size * 2);
  Stream.Write(p^, Size);
  FreeMem(p, Size);
end;


{ TfrxPictureCache }

constructor TfrxInternalPictureCache.Create;
begin
  FItems := TfrxCacheList.Create;
  FCacheStreamList := TList.Create;
  FTempFile := TStringList.Create;
  FUseFileCache := False;
  FCrit := TCriticalSection.Create;
end;

destructor TfrxInternalPictureCache.Destroy;
begin
  Clear;
  FItems.Free;
  FCacheStreamList.Free;
  FTempFile.Free;
  FreeAndNil(FCrit);
  inherited;
end;

procedure TfrxInternalPictureCache.GetPicture(Picture: TPicture;
  ImageIndex: Integer);
begin
  InternalGetPicture(Picture, nil, ImageIndex);
end;

function TfrxInternalPictureCache.GetPicture(
  const ImageIndex: Integer): TGraphic;
begin
  Result := InternalGetPicture(nil, nil, ImageIndex);
end;

function TfrxInternalPictureCache.GetSize(const ImageIndex: Integer): TSize;
begin
  Result := FItems.GetSize(ImageIndex - 1);
end;

function TfrxInternalPictureCache.InternalGetPicture(APicture: TPicture; aGraphic: TGraphic;
  ImageIndex: Integer): TGraphic;
var
  Size, Offset, Segment: Longint;
  Stream: TStream;
begin
  Result := aGraphic;
  FCrit.Enter;
  try
  if (ImageIndex <= 0) or (ImageIndex > FItems.Count) or (FCacheStreamList.Count = 0) then
    Exit;
  if Fitems[ImageIndex - 1]^.Loading = 1 then Exit;
  Segment := Fitems[ImageIndex - 1]^.Segment;
  Offset := FItems[ImageIndex - 1]^.Offset;
  Stream := TStream(FCacheStreamList[Segment]);

  if (ImageIndex < FItems.Count) and (Fitems[ImageIndex]^.Segment = Segment) then
    Size := FItems[ImageIndex]^.Offset - Offset
  else
    Size := Stream.Size - Offset;
  Stream.Position := Offset;

  if FUseFileCache then
    TfrxFileStream(Stream).FSz := Offset + Size
  else
    TfrxMemoryStream(Stream).FSz := Offset + Size;

  try
    if Assigned(aGraphic) then
      aGraphic.LoadFromStream(Stream)
    else if Assigned(APicture) then
      GetGraphicFormats.LoadFromStream(APicture, Stream)
    else
      try
        Result := GetGraphicFormats.LoadFromStream(Stream);
      except
        Result := nil;
      end;
  finally
    if FUseFileCache then
      TfrxFileStream(Stream).FSz := 0
    else
      TfrxMemoryStream(Stream).FSz := 0
  end;

  if Assigned(APicture) then
    Result := APicture.Graphic;
  finally
    FCrit.Leave;
  end;
end;

function TfrxInternalPictureCache.IsExist(const ImageIndex: Integer): Boolean;
begin
  Result := (ImageIndex > 0) and (ImageIndex <= FItems.Count) and (FCacheStreamList.Count <> 0);
end;

procedure TfrxInternalPictureCache.GetPicture(aGraphic: TGraphic; ImageIndex: Integer);
begin
  InternalGetPicture(nil, aGraphic, ImageIndex);
end;

procedure TfrxInternalPictureCache.Clear;
begin
  while FCacheStreamList.Count > 0 do
  begin
    TObject(FCacheStreamList[0]).Free;
    FCacheStreamList.Delete(0);
    if FUseFileCache then
    begin
      DeleteFile(FTempFile[0]);
      FTempFile.Delete(0);
    end;
  end;
  FItems.Clear;
end;

function TfrxInternalPictureCache.Count: Integer;
begin
  Result := FItems.Count;
end;

function TfrxInternalPictureCache.Add: PfrxCacheItem;
begin
  if (FCacheStreamList.Count = 0) or (TStream(FCacheStreamList[FCacheStreamList.Count - 1]).Size >= Round(MaxInt - MaxInt/6)) then
    AddSegment;
  Result := FItems.Add;
  with Result^ do
  begin
    Segment := FCacheStreamList.Count - 1;
    Offset := TStream(FCacheStreamList[FCacheStreamList.Count - 1]).Size;
    TStream(FCacheStreamList[FCacheStreamList.Count - 1]).Position := Offset;
  end;
end;

procedure TfrxInternalPictureCache.LoadFromXML(Item: TfrXMLItem);
var
  i: Integer;
  xi: TfrXMLItem;
  PItem: PfrxCacheItem;
  s: String;
begin
  Clear;
  for i := 0 to Item.Count - 1 do
  begin
    xi := Item[i];
    PItem := Add;
    try
      frxStringToStream(xi.Prop['stream'], TStream(FCacheStreamList[FCacheStreamList.Count - 1]));
      if xi.Count > 0 then
      begin
        s := xi[0].Prop['w'];
        if s <> '' then
         PItem^.Width := StrToInt(s);
        s := xi[0].Prop['h'];
        if s <> '' then
         PItem^.Height := StrToInt(s);
      end;
    finally
      PItem^.Loading := 0;
    end;
  end;
end;

procedure TfrxInternalPictureCache.SaveToXML(Item: TfrXMLItem);
var
  i, Size: Integer;
  xi: TfrXMLItem;
begin
  Item.Clear;
  for i := 0 to FCacheStreamList.Count - 1 do
    TStream(FCacheStreamList[i]).Position := 0;
  for i := 0 to FItems.Count - 1 do
  begin
    if (i + 1 < FItems.Count) and (Fitems[i]^.Segment = Fitems[i + 1]^.Segment) then
        Size := Integer(FItems[i + 1]^.Offset) - Integer(FItems[i]^.Offset)
    else
        Size := TStream(FCacheStreamList[FItems[i]^.Segment]).Size - Integer(FItems[i]^.Offset);
    xi := Item.Add;
    xi.Name := 'item';
    xi.Text := 'stream="' + frxStreamToString(TStream(FCacheStreamList[FItems[i]^.Segment]), Size) + '"';
    {added as a nested item. Saving sizes in props will impact performance, because of search through stream data }
    xi := xi.Add;
    xi.Name := 'size';
    xi.Text := 'w="' + IntToStr(FItems[i]^.Width) + '" h="' + IntToStr(FItems[i]^.Height) + '"';
  end;
end;

procedure TfrxInternalPictureCache.SetSize(const ImageIndex: Integer; Width, Height: Integer);
var
  PItem: PfrxCacheItem;
begin
  PItem := FItems.Get(ImageIndex - 1);
  PItem^.Width := Width;
  PItem^.Height := Height;
end;

procedure TfrxInternalPictureCache.SetTempDir(const Value: String);
begin
  if FCacheStreamList.Count = 0 then
    FTempDir := Value;
end;

procedure TfrxInternalPictureCache.SetUseFileCache(const Value: Boolean);
begin
  if FCacheStreamList.Count = 0 then
    FUseFileCache := Value;
end;

function TfrxInternalPictureCache.AddPicture(aGraphic: TGraphic): Integer;
begin
  Result := 0;
  if (aGraphic = nil) or ((aGraphic.Width = 0) and (aGraphic.Height = 0)) then
    Exit
  else
  begin
    Result := FItems.Count + 1;
    Add;
    aGraphic.SaveToStream(TStream(FCacheStreamList[FItems[Result - 1]^.Segment]));
    FItems[Result - 1]^.Width := aGraphic.Width;
    FItems[Result - 1]^.Height := aGraphic.Height;
    InterlockedExchange(FItems[Result - 1]^.Loading, 0);
  end;
end;

procedure TfrxInternalPictureCache.AddSegment;
var
  Stream: TStream;
{$IFDEF FPC}
  Path: String;
  FileName: String;
  AFileHandle: TfrHandle;
{$ELSE}
{$IFDEF DELPHI12}
  Path: WideString;
  FileName: WideString;
{$ELSE}
  Path: String[64];
  FileName: String[255];
{$ENDIF}
{$ENDIF}
begin
  if FUseFileCache then
  begin
{$IFDEF DELPHI12}
    SetLength(FileName, 255);
{$ENDIF}
    Path := FTempDir;
    if Path = '' then
{$IFDEF DELPHI12}
    begin
      SetLength(Path, 255);
      SetLength(Path, GetTempPath(255, @Path[1]));
    end
    else
{$ELSE}
  {$IFDEF FPC}
      Path := GetTempDir(True);
  {$ELSE}
      Path[0] := Chr(GetTempPath(64, @Path[1])) else
  {$ENDIF}
{$ENDIF}
  {$IFDEF FPC}
    if (Path <> '') and (Path[Length(Path)] <> PathDelim) then
      Path := Path + PathDelim;
    FileName := GetTempFileName(Path, 'frPic');
    AFileHandle := FileCreate(FileName);
    if AFileHandle <> -1 then
    begin
      FileClose(AFileHandle);
      Path := FileName;
    end;
{$ELSE}
      Path := Path + #0;
    if (Path <> '') and (Path[Length(Path)] <> '\') then
      Path := Path + '\';
    GetTempFileName(@Path[1], PChar('frPic'), 0, @FileName[1]);
{$IFDEF DELPHI12}
    Path := StrPas(PWideChar(@FileName[1]));
{$ELSE}
    Path := StrPas(@FileName[1]);
{$ENDIF}
  {$ENDIF} // FPC
    FTempFile.Add(String(Path));
    Stream := TfrxFileStream.Create(String(Path), fmOpenReadWrite);
    TfrxFileStream(Stream).FSz := 0;
  end
  else
  begin
    Stream := TfrxMemoryStream.Create;
    TfrxMemoryStream(Stream).FSz := 0;
  end;
  FCacheStreamList.Add(Stream);
end;


function TfrxMemoryStream.Seek(Offset: Integer; Origin: Word): Longint;
begin
  if (FSz <> 0) and (Offset = 0) and (Origin = soFromEnd) then
    Result := FSz
  else
    Result :=  inherited Seek(Offset, Origin);
end;

{$IFDEF DELPHI6}
function TfrxMemoryStream.Seek(const Offset: Int64;
  Origin: TSeekOrigin): Int64;
begin
  if (FSz <> 0) and (Offset = 0) and (Origin = soEnd) then
    Result := FSz
  else
    Result :=  inherited Seek(Offset, Origin);
end;
{$ENDIF}

function TfrxFileStream.Seek(Offset: Integer; Origin: Word): Longint;
begin
  if (FSz <> 0) and (Offset = 0) and (Origin = soFromEnd) then
    Result := FSz
  else
    Result := inherited Seek(Offset, Origin);
end;

{$IFDEF DELPHI6}
function TfrxFileStream.Seek(const Offset: Int64;
  Origin: TSeekOrigin): Int64;
begin
  if (FSz <> 0) and (Offset = 0) and (Origin = soEnd) then
    Result := FSz
  else
    Result :=  inherited Seek(Offset, Origin);
end;
{$ENDIF}

{ TfrxPictureCache }

function TfrxPictureCache.AddPicture(aGraphic: TGraphic): Integer;
var
  i: Integer;
begin
  UpdatePictureCacheOptions;
  Result := 0;
  if (aGraphic = nil) or (aGraphic.Empty) then Exit;
  i := FfrxPictureHashMap.FindOrAddGraphic(aGraphic, phmIndex);
  if (FfrxPictureHashMap.isLastNew) then
  begin
    Result := AddPictureTo(aGraphic, FPictureCache);
    if PictureCacheOptions.CachedImagesBuildType = tbtAtPrepare then
      Result := AddPictureTo(aGraphic, FThumbnailCache);
  end
  else
    Result := i + 1;
end;

function TfrxPictureCache.AddPictureTo(aGraphic: TGraphic;
  InternalCache: TfrxInternalPictureCache): Integer;
var
  NewSize: TSize;
  CacheType: TfrxCachedGraphicType;
  LGraphic: TGraphic;
  bNeedScale: Boolean;
begin
  CacheType := cgOriginal;
  LGraphic := aGraphic;
  if InternalCache = FThumbnailCache then
    CacheType := cgThumbnail;
  NewSize := CalcThumbnailSize(aGraphic.Width, aGraphic.Height, CacheType);
  bNeedScale := ((aGraphic.Width <> NewSize.cx) or (aGraphic.Height <> NewSize.cy)) and (PictureCacheOptions.CachedImagesBuildType <> tbtNone);
  if bNeedScale then
    LGraphic := GetGraphicFormats.ScaleGraphicToNew(aGraphic, NewSize.cx, NewSize.cy);
  if LGraphic = nil then
  begin
    LGraphic := aGraphic;
    bNeedScale := False;
  end;
  try
    Result := InternalCache.AddPicture(LGraphic);
    if bNeedScale and (Result > 0) then
      InternalCache.SetSize(Result, aGraphic.Width, aGraphic.Height);
  finally
    if bNeedScale then
      LGraphic.Free;
  end;
end;

procedure TfrxPictureCache.BuildFinished;
begin
  if PictureCacheOptions.CachedImagesBuildType <> tbtAtPreview then Exit;
  FIsUpdating := True;
//  try
//    BuildThumbnailFromCache;
//  finally
//    FIsUpdating := False;
//  end;
  { TODO: doesnt work yet, have to change storage to use with MREW like TMultiReadExclusiveWriteSynchronizer }
  StartThumbnailThread;
end;

procedure TfrxPictureCache.BuildThumbnailFromCache;
var
  i: Integer;
  LGraphic: TGraphic;
begin
  FIsUpdating := True;
  try
    for i := 1 to FPictureCache.Count do
    begin
      if FThumbnailCache.IsExist(i) then continue;
      LGraphic := FPictureCache.GetPicture(i);
      if LGraphic = nil then Exit;
      try
        AddPictureTo(LGraphic, FThumbnailCache);
      finally
        LGraphic.Free;
      end;
    end;
  finally
    FIsUpdating := False;
  end;
end;

function TfrxPictureCache.CalcThumbnailSize(const Width,
  Height: Integer; const CacheType: TfrxCachedGraphicType): TSize;
var
  LPercent: Integer;
begin
  LPercent := PictureCacheOptions.GetPercentFor(CacheType, Width, Height);
  Result.cx := Width * (100 - LPercent) div 100;
  Result.cy := Height * (100 - LPercent) div 100;
  if Result.cx = 0 then
    Result.cx := Width;
  if Result.cy = 0 then
    Result.cy := Height;
end;

procedure TfrxPictureCache.Clear;
var
  i: Integer;
begin
  FreeThumbnailThread;
  for i := 0 to FCahcedBitmap.Count - 1 do
    TfrxAutoRefGraphic(FCahcedBitmap[i]).FPictureCache := nil;
  FCahcedBitmap.Clear;
  FPictureCache.Clear;
  FThumbnailCache.Clear;
  ThumbnailUpdate(tusClear);
  UpdatePictureCacheOptions;
end;

constructor TfrxPictureCache.Create;
begin
  FPictureCacheOptions := TfrxPictureCacheOptions.Create;
  FPictureCache := TfrxInternalPictureCache.Create;
  FThumbnailCache := TfrxInternalPictureCache.Create;
  FCahcedBitmap := TStringList.Create;
  FCahcedBitmap.Sorted := True;
  FfrxPictureHashMap := nil;
  FfrxPictureHashMap := TfrxPictureHashMap.Create(False);
end;

destructor TfrxPictureCache.Destroy;
begin
  FreeThumbnailThread;
  FreeAndNil(FPictureCache);
  FreeAndNil(FThumbnailCache);
  FreeAndNil(FCahcedBitmap);
  FreeAndNil(FPictureCacheOptions);
  FreeAndNil(FfrxPictureHashMap);
  inherited;
end;

procedure TfrxPictureCache.FreeThumbnailThread;
begin
//  if Assigned(FThumbnailThread) then
//    FThumbnailThread.Terminate;
//  FreeAndNil(FThumbnailThread);
end;

function TfrxPictureCache.GetCachedBitmap(CacheType: TfrxCachedGraphicType; ImageIndex: Integer): IfrxCachedGraphic;
var
  s: String;
  i: Integer;
  Icb: TfrxAutoRefGraphic;
  LGraphic: TGraphic;
  sz: TSize;
begin
  Result := nil;
  if ImageIndex <= 0 then Exit;
  s := IntToStr(ImageIndex);// + '.' + IntToStr(Round(Picture.Width)) + '.' + IntToStr(Round(Picture.Height));
  i := FCahcedBitmap.IndexOf(s);
//  Stor := stOriginal;
//  if CacheType in [cgThumbnail] then
//    Stor := stThumbnail;
  if i > - 1 then
  begin
    Icb := TfrxAutoRefGraphic(FCahcedBitmap.Objects[i]);
    Result := Icb;
    if(Icb.FCacheType <> CacheType) then
    begin
      LGraphic := GetPicture(ImageIndex, CacheType);
      if Assigned(LGraphic) then
      begin
        FreeAndNil(Icb.FGraphic);
        Icb.FGraphic := LGraphic;
        Icb.FCacheType := CacheType;
      end;
    end;
    Exit;
  end;
  LGraphic := GetPicture(ImageIndex, CacheType);
  if Assigned(LGraphic) then
  begin
    Icb := TfrxAutoRefGraphic.Create(FCahcedBitmap, ImageIndex, CacheType, Self);
    Icb.FGraphic := LGraphic;
    sz := GetSize(CacheType, ImageIndex);
    Icb.FOriginalWidth := sz.cx;
    Icb.FOriginalHeight := sz.cy;
    FCahcedBitmap.AddObject(s, Icb);
    Result := Icb;
  end
  else if CacheType <> cgOriginal then
  begin
    Result := GetCachedBitmap(cgOriginal, ImageIndex);
    { prevent updating }
    if Assigned(Result) then
      Result.SetCacheType(CacheType);
  end;
end;

function TfrxPictureCache.GetGraphic(ImageIndex: Integer): TGraphic;
begin
  Result := FPictureCache.GetPicture(ImageIndex);
end;

function TfrxPictureCache.GetPictureTo(APicture: TPicture; aGraphic: TGraphic; ImageIndex: Integer): TGraphic;
begin
  Result := FPictureCache.InternalGetPicture(APicture, aGraphic, ImageIndex);
end;

function TfrxPictureCache.GetSize(const CacheType: TfrxCachedGraphicType; const ImageIndex: Integer): TSize;
begin
  Result := FPictureCache.GetSize(ImageIndex);
end;

function TfrxPictureCache.GetCount: Integer;
begin
  Result := FPictureCache.Count;
end;

function TfrxPictureCache.GetPicture(const ImageIndex: Integer; const CacheType: TfrxCachedGraphicType): TGraphic;
begin
  Result := nil;
  if CacheType = cgThumbnail then
  begin
    if not FIsUpdating then
      Result := FThumbnailCache.GetPicture(ImageIndex);
  end
  else
    Result := FPictureCache.GetPicture(ImageIndex);
end;

procedure TfrxPictureCache.GetGraphic(aGraphic: TGraphic; ImageIndex: Integer);
begin
  FPictureCache.GetPicture(aGraphic, ImageIndex);
end;

function TfrxPictureCache.GetTempDir: String;
begin
  Result := FPictureCache.TempDir;
end;

function TfrxPictureCache.GetUseFileCache: Boolean;
begin
  Result := FPictureCache.UseFileCache;
end;

function TfrxPictureCache.IsAutoRefMode: Boolean;
begin
  Result := (FPictureCacheOptions.CachedImagesBuildType <> tbtNone);
end;

procedure TfrxPictureCache.LoadFromXML(Item: TfrXMLItem);
var
  ItemIdx: Integer;
begin
  UpdatePictureCacheOptions;
  ItemIdx := Item.Find('picturecache');
  if ItemIdx >= 0 then
    FPictureCache.LoadFromXML(Item[ItemIdx]);
  ItemIdx := Item.Find('thumbnailcache');
  if ItemIdx >= 0 then
  begin
    FThumbnailCache.LoadFromXML(Item[ItemIdx]);
    if PictureCacheOptions.CachedImagesBuildType = tbtNone then
      PictureCacheOptions.CachedImagesBuildType := tbtOriginal;
  end;
end;

procedure TfrxPictureCache.SaveToXML(Item: TfrXMLItem);
var
  NewItem: TfrXMLItem;
begin
  NewItem := Item.FindItem('picturecache');
  FPictureCache.SaveToXML(NewItem);
  if Assigned(FThumbnailCache) and (PictureCacheOptions.CachedImagesBuildType in [tbtAtSave, tbtAtPrepare]) then
  begin
    if PictureCacheOptions.CachedImagesBuildType = tbtAtSave then
      BuildThumbnailFromCache;
    NewItem := Item.FindItem('thumbnailcache');
    FThumbnailCache.SaveToXML(NewItem);
  end;
end;

procedure TfrxPictureCache.SetPictureCacheOptions(
  const Value: TfrxPictureCacheOptions);
begin
  FPictureCacheOptions.Assign(Value);
  UpdatePictureCacheOptions;
end;

procedure TfrxPictureCache.SetTempDir(const Value: String);
begin
  FPictureCache.TempDir := Value;
end;

procedure TfrxPictureCache.SetUseFileCache(const Value: Boolean);
begin
  FPictureCache.UseFileCache := Value;
end;

procedure TfrxPictureCache.StartThumbnailThread;
begin
//  if Assigned(FThumbnailThread) and not FThumbnailThread.Suspended then Exit;
//  FreeThumbnailThread;
//  FThumbnailThread := TfrxThumbnailThread.Create(Self);
end;

procedure TfrxPictureCache.ThumbnailUpdate(State: TfrxThumbnailsUpdateState);
begin
  FIsUpdating := False;
  if Assigned(FOnThumbnailUpdated) then
    FOnThumbnailUpdated(Self, State);
end;

procedure TfrxPictureCache.UpdatePictureCacheOptions;
begin
  if FfrxPictureHashMap.RealHash <> FPictureCacheOptions.CalculateHash then
    FfrxPictureHashMap.RealHash := FPictureCacheOptions.CalculateHash;
end;

procedure TfrxPictureCache.GetPicture(APicture: TPicture; ImageIndex: Integer);
begin
  FPictureCache.GetPicture(APicture, ImageIndex);
end;

{ TfrxCacheList }

function TfrxCacheList.Add: PfrxCacheItem;
begin
  GetMem(Result, sizeof(TfrxCacheItem));
  Result.Loading := 1;
  Result.Width := 0;
  Result.Height := 0;
  FItems.Add(Result);
end;

procedure TfrxCacheList.Clear;
var
  idx: Integer;
begin
  for idx := 0 to FItems.Count - 1 do
    FreeMem(FItems[idx], sizeof(TfrxCacheItem));
  FItems.Clear;
end;

function TfrxCacheList.Count: Integer;
begin
  Result := FItems.Count;
end;

constructor TfrxCacheList.Create;
begin
  FItems := TList.Create;
end;

destructor TfrxCacheList.Destroy;
begin
  Clear;
  FItems.Free;
  inherited;
end;

function TfrxCacheList.Get(Index: Integer): PfrxCacheItem;
begin
  Result := PfrxCacheItem(FItems[Index]);
end;

function TfrxCacheList.GetSize(const Index: Integer): TSize;
begin
  Result.cx := PfrxCacheItem(FItems[Index]).Width;
  Result.cy := PfrxCacheItem(FItems[Index]).Height;
end;

{ TfrxAutoRefGraphic }

constructor TfrxAutoRefGraphic.Create(ParentList: TStringList; Index: Integer; CacheType: TfrxCachedGraphicType; APictureCache: TfrxPictureCache);
begin
  FParentList := ParentList;
  FIndex := Index;
  FCacheType := CacheType;
  FPictureCache := APictureCache;
end;

destructor TfrxAutoRefGraphic.Destroy;
var
  i: Integer;
begin
  i := FParentList.IndexOf(IntToStr(FIndex));
  if i > -1 then
    FParentList.Delete(i);
  FIndex := -1;
  FParentList := nil;
  FreeAndNil(FGraphic);
  inherited;
end;

procedure TfrxAutoRefGraphic.Draw(Canvas: TCanvas; X, Y, X1, Y1: Integer);
begin

end;

function TfrxAutoRefGraphic.GetCacheType: TfrxCachedGraphicType;
begin
  Result := FCacheType;
end;

function TfrxAutoRefGraphic.GetGraphic(CacheType: TfrxCachedGraphicType): TGraphic;
begin
  Result := FGraphic;
end;

function TfrxAutoRefGraphic.GetOriginalSize: TSize;
begin
  Result.cx := FOriginalWidth;
  Result.cy := FOriginalHeight;
end;

procedure TfrxAutoRefGraphic.SetCacheType(CacheType: TfrxCachedGraphicType);
begin
  FCacheType := CacheType;
end;

{ TfrxThumbnailThread }

constructor TfrxThumbnailThread.Create(ACache: TfrxPictureCache);
begin
  inherited Create(False);
  FCache := ACache;
end;

destructor TfrxThumbnailThread.Destroy;
begin
  Terminate;
  FCache := nil;
  inherited;
end;

procedure TfrxThumbnailThread.DoUpdate;
begin
  FCache.ThumbnailUpdate(tusAdded);
end;

procedure TfrxThumbnailThread.Execute;
var
  i: Integer;
  LGraphic: TGraphic;
begin
  try
    for i := 1 to FCache.FPictureCache.Count do
    begin
      if Terminated then Exit;
      if FCache.FThumbnailCache.IsExist(i) then continue;
      LGraphic := FCache.FPictureCache.GetPicture(i);
      if LGraphic = nil then Exit;
      FCache.AddPictureTo(LGraphic, FCache.FThumbnailCache);
    end;
  finally
   frThreadSynchronize(DoUpdate);
  end;
end;

{ TfrxPictureHashMap }

constructor TfrxPictureHashMap.Create(RealHash: Boolean);
begin
  SetRealHash(RealHash);
end;

destructor TfrxPictureHashMap.Destroy;
begin
  FreeAndNil(FfrxDataHashMap);
  inherited;
end;

procedure TfrxPictureHashMap.SetRealHash(RealHash: Boolean);
begin
  if RealHash and (FfrxDataHashMap = nil) then
  begin
    FfrxDataHashMap := TfrDataHashMap.Create;
    FFindOrAddGraphic := RealFindOrAddGraphic;
    FGetIsLastNew := RealGetIsLastNew;
  end
  else
  begin
    FreeAndNil(FfrxDataHashMap);
    FFindOrAddGraphic := FakeFindOrAddGraphic;
    FGetIsLastNew := FakeGetIsLastNew;
  end;
end;

function TfrxPictureHashMap.RealFindOrAddGraphic(g: TGraphic; ResultType: TfrPictureHashMapResultType; IntData: Integer = -1): Integer;
var
  md5s: String;
  IndexImg: Integer;
begin
  md5s := GraphicToMD5(g);
  IndexImg := FfrxDataHashMap.FindPicture(md5s);
  FIsLastNew := (IndexImg = -1);
  if (FIsLastNew) then
  begin
    if (ResultType = phmIndex) then
      Result := FfrxDataHashMap.Count
    else
      Result := IntData;
    FfrxDataHashMap.AddPicture(md5s, IntData);
  end
  else
  begin
    if (ResultType = phmIndex) then
      Result := IndexImg
    else
      Result := FfrxDataHashMap.GetData(IndexImg);
  end;
end;

function TfrxPictureHashMap.RealGetIsLastNew: Boolean;
begin
  Result := FIsLastNew;
end;

function TfrxPictureHashMap.FakeFindOrAddGraphic(g: TGraphic; ResultType: TfrPictureHashMapResultType; IntData: Integer = -1): Integer;
begin
  Result := FCount;
  FCount := FCount + 1;
end;

function TfrxPictureHashMap.FakeGetIsLastNew: Boolean;
begin
  Result := True;
end;

end.
