
{******************************************}
{                                          }
{             FastReport VCL               }
{               SVG Graphic                }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}
unit frSVGGraphic;

interface

{$I frVer.inc}

uses
  Windows, Classes, Graphics,
  frCoreClasses,
  frSVGBase, frSVGHelpers, frGraphicUtils, frCore;

type
  TfrxSVGGraphic = class(TGraphic)
  private
    FRootObj: TSVGRootObj;
    function GetSource: string;
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadData(Stream: TStream); override;
    procedure WriteData(Stream: TStream); override;

    procedure Draw(ACanvas: TCanvas; const Rect: TRect); override;
    procedure DrawToSize(ACanvas: TCanvas; const Rect: TRect);

    function GetEmpty: Boolean; override;
    function GetWidth: Integer; override;
    function GetHeight: Integer; override;
    procedure SetHeight(Value: Integer); override;
    procedure SetWidth(Value: Integer); override;

    procedure AssignTo(Dest: TPersistent); override;

    procedure SetExternalParams(BoundsRect: TRect; ScaleX, ScaleY: Single; Centered: Boolean);
    procedure Clear;
    function IsAutoSize: Boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure SwitchFullOpacity;
    class function CanLoadFromStream(Stream: TStream): Boolean; {$IFDEF DELPHI25} override; {$ENDIF}
    procedure LoadFromText(const Text: string);
    procedure LoadFromFile(const Filename: string); override;
    procedure LoadFromStream(Stream: TStream); override;
    procedure SaveToStream(Stream: TStream); override;

    procedure LoadFromClipboardFormat(AFormat: Word; AData: TfrHandle;
      APalette: HPALETTE); override;
    procedure SaveToClipboardFormat(var AFormat: Word; var AData: TfrHandle;
      var APalette: HPALETTE); override;

    property Source: string read GetSource;
  end;

  TfrxSVGGraphicCache = class (TfrOwnObjList)
  protected
    function IsFindHash(MD5: AnsiString; out Index: Integer): Boolean;
  public
    function GraphicFromText(const Text: string): TGraphic;
    function GraphicFromFile(const Filename: string): TGraphic;
    function GraphicFromStream(Stream: TStream): TGraphic;
  end;

implementation

uses
  Math, SysUtils, frSVGComponents, frHashUtils;

type
  TSVGGraphicCacheObj = class
  private
    FGraphic: TfrxSVGGraphic;
    FMD5: AnsiString;
  public
    constructor CreateFromFile(const Filename: string; AMD5: AnsiString = '');
    constructor CreateFromStream(Stream: TStream; AMD5: AnsiString = '');
    constructor CreateFromText(const Text: string; AMD5: AnsiString = '');
    destructor Destroy; override;


    property Graphic: TfrxSVGGraphic read FGraphic;
    property MD5: AnsiString read FMD5;
  end;

function CacheObj(O: TObject): TSVGGraphicCacheObj;
begin
  Result := O as TSVGGraphicCacheObj;
end;

{ TfrxSVGGraphic }

procedure TfrxSVGGraphic.AssignTo(Dest: TPersistent);
var
  D: TfrxSVGGraphic;
begin
  if Dest is TfrxSVGGraphic then
  begin
    D := TfrxSVGGraphic(Dest);

//    D.FRootObj.LoadFromText(FRootObj.Source);
    D.FRootObj.Free;
    D.FRootObj := TSVGRootObj(FRootObj.Clone(nil));

    Changed(Dest);
  end;
end;

class function TfrxSVGGraphic.CanLoadFromStream(Stream: TStream): Boolean;
const
  BOM = #239#187#191;
  SVG = '<SVG';
  XML = '<?XML';
var
  AnsiHeader: AnsiString;
  Header: string;
  p, HeaderLen: Integer;
begin
  Result := False;
  HeaderLen := Length(BOM) + Max(Length(SVG), Length(XML));
  if (Stream.Size - Stream.Position) >= HeaderLen then
  begin
    p := Stream.Position;
    SetLength(AnsiHeader, HeaderLen);
    Stream.ReadBuffer(AnsiHeader[1], HeaderLen);
    Header := string(AnsiHeader);
    Stream.Position := p;
    if Pos(BOM, Header) = 1 then
      Delete(Header, 1, 3);
    Header := AnsiUpperCase(Header);
    Result := (Pos(SVG, Header) = 1) or (Pos(XML, Header) = 1);
  end;
end;

procedure TfrxSVGGraphic.Clear;
begin
  FRootObj.Clear;
  Changed(Self);
end;

constructor TfrxSVGGraphic.Create;
begin
  inherited Create;
  FRootObj := TSVGRootObj.Create;
end;

procedure TfrxSVGGraphic.DefineProperties(Filer: TFiler);
begin
  Filer.DefineBinaryProperty('Data', ReadData, WriteData, True);
end;

destructor TfrxSVGGraphic.Destroy;
begin
  FRootObj.Free;
  inherited Destroy;
end;

procedure TfrxSVGGraphic.Draw(ACanvas: TCanvas; const Rect: TRect);

  function IsNeedsToIncrease(const Rect: TRect; out IncreasedRect: TRect): boolean;
  const
    MetaSize = 8000;
  var
    w, h: Integer;
    Factor: Double;
  begin
    w := Rect.Right - Rect.Left;
    h := Rect.Bottom - Rect.Top;
    Factor := Min(MetaSize / Max(1, w), MetaSize / Max(1, h));
    Result := Factor > 1;
    if Result then
      IncreasedRect := Bounds(0, 0, Round(w * Factor), Round(h * Factor));
  end;

var
  IncreasedRect: TRect;
  Metafile: TMetafile;
  MetafileCanvas: TMetafileCanvas;
begin
  if Empty then
    Exit;

  if (ACanvas is TMetafileCanvas) and IsNeedsToIncrease(Rect, IncreasedRect) then
  begin
    Metafile := TMetafile.Create;
    try
      Metafile.Width := IncreasedRect.Right - IncreasedRect.Left;
      Metafile.Height := IncreasedRect.Bottom - IncreasedRect.Top;

      MetafileCanvas := TMetafileCanvas.Create(Metafile, 0);
      try
        try
          MetafileCanvas.Lock;
          DrawToSize(MetafileCanvas, IncreasedRect);
        finally
          MetafileCanvas.Unlock;
        end;
      finally
        MetafileCanvas.Free;
      end;

      ACanvas.StretchDraw(Rect, Metafile);

    finally
      Metafile.Free;
    end;
  end
  else
    DrawToSize(ACanvas, Rect);
end;

procedure TfrxSVGGraphic.DrawToSize(ACanvas: TCanvas; const Rect: TRect);
var
  SaveBounds: TSingleBounds;
  ScaleX, ScaleY: Single;
begin
  SaveBounds := FRootObj.ExternalBounds;

  if FRootObj.atIsPercent(at_width) then
    ScaleX := SaveBounds.Width / FRootObj.atLengthAuto(at_width)
  else
    ScaleX := (Rect.Right - Rect.Left) / Width;

  if FRootObj.atIsPercent(at_height) then
    ScaleY := SaveBounds.Height / FRootObj.atLengthAuto(at_height)
  else
    ScaleY := (Rect.Bottom - Rect.Top) / Height;

  try
    SetExternalParams(Rect, ScaleX, ScaleY, False);
    FRootObj.PaintTo(ACanvas.Handle);
  finally
    FRootObj.ExternalBounds := SaveBounds;
  end;
end;

function TfrxSVGGraphic.GetEmpty: Boolean;
begin
  Result := FRootObj.Count = 0;
end;

function TfrxSVGGraphic.GetHeight: Integer;
begin
  Result := Round(FRootObj.GetOuterHeight);
end;

function TfrxSVGGraphic.GetSource: string;
begin
  Result := '';
  if FRootObj <> nil then
    Result := FRootObj.Source;
end;

function TfrxSVGGraphic.GetWidth: Integer;
begin
  Result := Round(FRootObj.GetOuterWidth);
end;

function TfrxSVGGraphic.IsAutoSize: Boolean;
begin
  Result := FRootObj.atIsPercent(at_width) or FRootObj.atIsPercent(at_height);
end;

procedure TfrxSVGGraphic.LoadFromClipboardFormat(AFormat: Word; AData: TfrHandle; APalette: HPALETTE);
begin
  inherited;
end;

procedure TfrxSVGGraphic.LoadFromFile(const Filename: string);
begin
  FRootObj.LoadFromFile(FileName);
  Changed(Self);
end;

procedure TfrxSVGGraphic.LoadFromStream(Stream: TStream);
begin
  try
    FRootObj.LoadFromStream(Stream);
  except
  end;
  Changed(Self);
end;

procedure TfrxSVGGraphic.LoadFromText(const Text: string);
begin
  try
    FRootObj.LoadFromText(Text);
  except
  end;
  Changed(Self);
end;

procedure TfrxSVGGraphic.ReadData(Stream: TStream);
var
  Size: LongInt;
  MemoryStream: TMemoryStream;
begin
  Stream.Read(Size, SizeOf(Size));
  MemoryStream := TMemoryStream.Create;
  try
    MemoryStream.CopyFrom(Stream, Size);
    MemoryStream.Position := 0;
    FRootObj.LoadFromStream(MemoryStream);
  finally
    MemoryStream.Free;
  end;
end;

procedure TfrxSVGGraphic.SaveToClipboardFormat(var AFormat: Word; var AData: TfrHandle; var APalette: HPALETTE);
begin
  inherited;
end;

procedure TfrxSVGGraphic.SaveToStream(Stream: TStream);
begin
  FRootObj.SaveToStream(Stream);
end;

procedure TfrxSVGGraphic.SetExternalParams(BoundsRect: TRect; ScaleX, ScaleY: Single; Centered: Boolean);
begin
  FRootObj.ExternalBounds := ToSingleBounds(BoundsRect);
  FRootObj.ExternalScale := ToSinglePoint(ScaleX, ScaleY);
  FRootObj.ExternalCentered := Centered;
end;

procedure TfrxSVGGraphic.SwitchFullOpacity;
begin
  FRootObj.IsFullOpacity := not FRootObj.IsFullOpacity;
end;

procedure TfrxSVGGraphic.SetHeight(Value: Integer);
var
  Bounds: TSingleBounds;
begin
  if not SameValue(FRootObj.ExternalBounds.Height, Value) then
  begin
    Bounds := FRootObj.ExternalBounds;
    Bounds.Height := Value;
    FRootObj.ExternalBounds := Bounds;
  end;
end;

procedure TfrxSVGGraphic.SetWidth(Value: Integer);
var
  Bounds: TSingleBounds;
begin
  if not SameValue(FRootObj.ExternalBounds.Width, Value) then
  begin
    Bounds := FRootObj.ExternalBounds;
    Bounds.Width := Value;
    FRootObj.ExternalBounds := Bounds;
  end;
end;

procedure TfrxSVGGraphic.WriteData(Stream: TStream);
var
  Size: LongInt;
  MemoryStream: TMemoryStream;
begin
  MemoryStream := TMemoryStream.Create;
  try
    FRootObj.SaveToStream(MemoryStream);
    Size := MemoryStream.Size;
    Stream.Write(Size, SizeOf(Size));
    MemoryStream.Position := 0;
    MemoryStream.SaveToStream(Stream);
  finally
    MemoryStream.Free;
  end;
end;

{ TfrxSVGGraphicCacheObj }

constructor TSVGGraphicCacheObj.CreateFromFile(const Filename: string; AMD5: AnsiString = '');
begin
  FGraphic := TfrxSVGGraphic.Create;
  FGraphic.LoadFromFile(FileName);
  if AMD5 <> '' then
    FMD5 := AMD5
  else
    FMD5 := frMD5File(Filename);
end;

constructor TSVGGraphicCacheObj.CreateFromStream(Stream: TStream; AMD5: AnsiString = '');
begin
  FGraphic := TfrxSVGGraphic.Create;
  FGraphic.LoadFromStream(Stream);
  if AMD5 <> '' then
    FMD5 := AMD5
  else
    FMD5 := frMD5Stream(Stream);
end;

constructor TSVGGraphicCacheObj.CreateFromText(const Text: string; AMD5: AnsiString = '');
begin
  FGraphic := TfrxSVGGraphic.Create;
  FGraphic.LoadFromText(Text);
  if AMD5 <> '' then
    FMD5 := AMD5
  else
    FMD5 := frMD5String(AnsiString(FGraphic.FRootObj.Source));
end;

destructor TSVGGraphicCacheObj.Destroy;
begin
  FGraphic.Free;
  inherited;
end;

{ TfrxSVGGraphicCache }

function TfrxSVGGraphicCache.GraphicFromFile(const Filename: string): TGraphic;
var
  MD5: AnsiString;
  Index: Integer;
begin
  MD5 := frMD5File(Filename);
  if not IsFindHash(MD5, Index) then
    Index := Add(TSVGGraphicCacheObj.CreateFromFile(Filename, MD5));

  Result := CacheObj(Items[Index]).Graphic;
end;

function TfrxSVGGraphicCache.GraphicFromStream(Stream: TStream): TGraphic;
var
  MD5: AnsiString;
  Index: Integer;
begin
  MD5 := frMD5Stream(Stream);
  if not IsFindHash(MD5, Index) then
    Index := Add(TSVGGraphicCacheObj.CreateFromStream(Stream, MD5));

  Result := CacheObj(Items[Index]).Graphic;
end;

function TfrxSVGGraphicCache.GraphicFromText(const Text: string): TGraphic;
var
  MD5: AnsiString;
  Index: Integer;
begin
  MD5 := frMD5String(AnsiString(Text));
  if not IsFindHash(MD5, Index) then
    Index := Add(TSVGGraphicCacheObj.CreateFromText(Text, MD5));

  Result := CacheObj(Items[Index]).Graphic;
end;

function TfrxSVGGraphicCache.IsFindHash(MD5: AnsiString; out Index: Integer): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0  to Count - 1 do
    if CacheObj(Items[i]).MD5 = MD5 then
    begin
      Result := True;
      Index := i;
      Exit;
    end;

end;

initialization
  TPicture.RegisterFileFormat('SVG', 'Scalable Vector Graphics', TfrxSVGGraphic);

finalization
  TPicture.UnregisterGraphicClass(TfrxSVGGraphic);
end.
