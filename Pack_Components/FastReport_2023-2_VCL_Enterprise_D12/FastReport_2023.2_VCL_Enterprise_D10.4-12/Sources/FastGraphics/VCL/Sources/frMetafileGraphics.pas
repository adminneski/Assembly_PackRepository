
{******************************************}
{                                          }
{          FastReport VCL/FMX/LCL          }
{             Graphics Library             }
{                                          }
{         Copyright (c) 1998-2022          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frMetafileGraphics;

{$I frVer.inc}

interface

uses
  SysUtils,
{$IFNDEF FPC}
  Windows, Messages,
{$ELSE}
  frLazGraphicClasses,
{$ENDIF}
  Classes, Graphics, frPictureGraphics;

const
  frxWMFFileFormat = 1;
  frxEMFFileFormat = 2;

implementation

uses
  frUtils, frGraphicUtils;

type
  TfrxBaseMetafileGraphicFormat = class(TfrxCustomVectorGraphicFormat)
  protected
    class function GetCanvasHelperClass: TfrxGraphicCanvasHelperClass; override;
  public
    class function ConvertFrom(Graphic: TGraphic; DestPixelFormat: TPixelFormat; DestQuality: Integer = 100): TGraphic; override;
    class function CreateNew(Width: Integer; Height: Integer; PixelFormat: TPixelFormat; Transparent: Boolean; Quality: Integer = 100): TGraphic; override;
    class function GetGraphicClass: TGraphicClass; override;
    class function GetGraphicProps(Graphic: TGraphic): TfrxGraphicProps; override;
  end;


  TfrxMetaCanvasHelper = class(TfrxGraphicCanvasHelper)
  private
    FCanvas: TCanvas;
  protected
    function GetCanvas: TCanvas; override;
  public
    destructor Destroy; override;
    procedure ReleaseCanvas; override;
  end;

  TfrxWMFGraphicFormat = class(TfrxBaseMetafileGraphicFormat)
  public
    class function GetGraphicMime: String; override;
    class function GetGraphicName: String; override;
    class function GetGraphicExt: String; override;
    class function GetGraphicConst: Integer; override;
    class function IsSupportedFormat(const Stream: TStream): Boolean; override;
  end;

  TfrxEMFGraphicFormat = class(TfrxBaseMetafileGraphicFormat)
  public
    class function CreateNew(Width: Integer; Height: Integer; PixelFormat: TPixelFormat; Transparent: Boolean; Quality: Integer = 100): TGraphic; override;
    class function GetGraphicMime: String; override;
    class function GetGraphicName: String; override;
    class function GetGraphicExt: String; override;
    class function GetGraphicConst: Integer; override;
    class function IsSupportedFormat(const Stream: TStream): Boolean; override;
  end;

  TfrxFREMFGraphicFormat = class(TfrxEMFGraphicFormat)
  public
    class function GetGraphicName: String; override;
    class function GetGraphicClass: TGraphicClass; override;
  end;

  FR_SMALL_RECT = record
    Left: ShortInt;
    Top: ShortInt;
    Right: ShortInt;
    Bottom: ShortInt;
  end;
  TSmallRect = FR_SMALL_RECT;

  TMetafileHeader = packed record
    Key: Longint;
    Handle: SmallInt;
    Box: TSmallRect;
    Inch: Word;
    Reserved: Longint;
    CheckSum: Word;
  end;

  THackGraphic = class(TGraphic);

{ TfrxWMFGraphicFormat }

class function TfrxWMFGraphicFormat.GetGraphicConst: Integer;
begin
  Result := frxWMFFileFormat;
end;

class function TfrxWMFGraphicFormat.GetGraphicExt: String;
begin
  Result := '.wmf';
end;

class function TfrxWMFGraphicFormat.GetGraphicMime: String;
begin
  Result := 'image/metafile';
end;

class function TfrxWMFGraphicFormat.GetGraphicName: String;
begin
  Result := 'WMF';
end;

class function TfrxWMFGraphicFormat.IsSupportedFormat(
  const Stream: TStream): Boolean;
const
  WMFKey = Integer($9AC6CDD7);
  WMFWord = $CDD7;
var
  WMFHeader: TMetafileHeader;
  pos: Integer;
begin
  Result := False;
  if (Stream.Size - Stream.Position) >= SizeOf(WMFHeader) then
  begin
    pos := Stream.Position;
    Stream.ReadBuffer(WMFHeader, SizeOf(WMFHeader));
    Stream.Position := pos;
    if WMFHeader.Key = WMFKEY then
      Result := True;
  end;
end;

{ TfrxEMFGraphicFormat }

class function TfrxEMFGraphicFormat.CreateNew(Width, Height: Integer;
  PixelFormat: TPixelFormat; Transparent: Boolean; Quality: Integer): TGraphic;
begin
  Result := inherited CreateNew(Width, Height, PixelFormat, Transparent, Quality);
  TMetafile(Result).Enhanced := True;
end;

class function TfrxEMFGraphicFormat.GetGraphicConst: Integer;
begin
  Result := frxEMFFileFormat;
end;

class function TfrxEMFGraphicFormat.GetGraphicExt: String;
begin
  Result := '.emf';
end;

class function TfrxEMFGraphicFormat.GetGraphicMime: String;
begin
  Result := 'image/metafile';
end;

class function TfrxEMFGraphicFormat.GetGraphicName: String;
begin
  Result := 'EMF';
end;

class function TfrxEMFGraphicFormat.IsSupportedFormat(
  const Stream: TStream): Boolean;
var
  EMFHeader: TEnhMetaHeader;
  pos: Integer;
begin
  Result := False;
  if (Stream.Size - Stream.Position) >= SizeOf(EMFHeader) then
  begin
    pos := Stream.Position;
    Stream.ReadBuffer(EMFHeader, SizeOf(EMFHeader));
    Stream.Position := pos;
    if EMFHeader.dSignature = ENHMETA_SIGNATURE then
      Result := True;
  end;
end;

{ TfrxBaseMetafileGraphicFormat }

class function TfrxBaseMetafileGraphicFormat.ConvertFrom(Graphic: TGraphic;
  DestPixelFormat: TPixelFormat; DestQuality: Integer): TGraphic;
var
  GHelper: TfrxCustomGraphicFormatClass;
  Bitmap: TBitmap;
  MetaF: TMetafile absolute Result;
  Canvas: TMetafileCanvas;
begin
 Result := CreateNew(Graphic.Width, Graphic.Height, DestPixelFormat, True, DestQuality);
 if Graphic is TMetafile then
    Result.Assign(Graphic)
  else
  begin
    GHelper := GetGraphicFormats.FindByGraphic(TGraphicClass(Graphic.ClassType));
    if Assigned(GHelper) then
    begin
      Bitmap := TBitmap(GHelper.ConvertToBitmap(Graphic, DestPixelFormat));
      Canvas := TMetafileCanvas.Create(MetaF, 0);
      Canvas.Lock;
      try
        Canvas.Draw(0, 0, Bitmap);
      finally
        Canvas.Unlock;
        Canvas.Free;
        Bitmap.Free;
      end;
    end;
  end;
end;

class function TfrxBaseMetafileGraphicFormat.CreateNew(Width, Height: Integer;
  PixelFormat: TPixelFormat; Transparent: Boolean; Quality: Integer): TGraphic;
begin
  Result := GetGraphicClass.Create;
  Result.Width := Width;
  Result.Height := Height;
end;

class function TfrxBaseMetafileGraphicFormat.GetCanvasHelperClass: TfrxGraphicCanvasHelperClass;
begin
  Result := TfrxMetaCanvasHelper;
end;

class function TfrxBaseMetafileGraphicFormat.GetGraphicClass: TGraphicClass;
begin
  Result := TMetafile;
end;

class function TfrxBaseMetafileGraphicFormat.GetGraphicProps(
  Graphic: TGraphic): TfrxGraphicProps;
var
  Metafile: TMetafile absolute Graphic;
begin
  Result.HasAlpha := False;
  Result.Transparent := Metafile.Transparent;
  Result.TransparentColor := clNone;
  Result.Quality := 100;
  Result.PixelFormat := pfDevice;
end;

{ TfrxMetaCanvasHelper }

destructor TfrxMetaCanvasHelper.Destroy;
begin
  ReleaseCanvas;
  inherited;
end;

function TfrxMetaCanvasHelper.GetCanvas: TCanvas;
begin
  if not Assigned(FCanvas) then
    FCanvas := TMetafileCanvas.Create(TMetafile(FGraphic), 0);
  Result := FCanvas;
end;

procedure TfrxMetaCanvasHelper.ReleaseCanvas;
begin
  FreeAndNil(FCanvas);
  inherited;
end;

{ TfrxFREMFGraphicFormat }

class function TfrxFREMFGraphicFormat.GetGraphicClass: TGraphicClass;
begin
  Result := TfrxMetafile;
end;

class function TfrxFREMFGraphicFormat.GetGraphicName: String;
begin
  Result := 'FREMF';
end;

initialization
  frxDefaultMetaCanvasClass := TMetafileCanvas;
  GetGraphicFormats.RegisterFormat(TfrxWMFGraphicFormat);
  GetGraphicFormats.RegisterFormat(TfrxEMFGraphicFormat);
  GetGraphicFormats.RegisterFormat(TfrxFREMFGraphicFormat);

finalization
  frxDefaultMetaCanvasClass := nil;
  GetGraphicFormats.UnregisterFormat(TfrxEMFGraphicFormat);
  GetGraphicFormats.UnregisterFormat(TfrxWMFGraphicFormat);
  GetGraphicFormats.UnregisterFormat(TfrxFREMFGraphicFormat);

end.
