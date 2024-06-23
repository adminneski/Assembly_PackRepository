{*******************************************************}
{                                                       }
{                       EhLib 10.2                      }
{      TPdfImage, TPdfBmpImage, TPdfBmpImage object     }
{                                                       }
{   Copyright (c) 2021-2022 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit PdfImagesEh;

{$SCOPEDENUMS ON}

interface

uses
{$IFDEF FPC}
    {$IFDEF FPC_WINDOWS}
    Windows,
    {$ENDIF}
  EhLibLCL, LCLType, Generics.Collections, Generics.Defaults,
{$ELSE}
  EhLibVCL, JPeg, Windows,
  Generics.Defaults, Generics.Collections,
{$ENDIF}
  SysUtils, Classes, Types,
  PdfElemetsEh,
  Graphics;

type
  TPdfImageEh = class;
  TPdfJpegImageEh = class;
  TPdfBmpImageEh = class;
  TPdfBmpImageAlphaMaskEh = class;

{ TPdfImageEh }

  TPdfImageEh = class(TPdfIdrectDictionaryObjectEh)
  private
    FImageCode: String;

  protected
    FSize: TSize;

    procedure InitImageFromGraphic(AGraphic: TGraphic); virtual;

  public
    constructor Create(ADocument: TPdfBaseDocumentEh; AGraphic: TGraphic; AImageCode: String);
    destructor Destroy; override;

    class function GetPdfImageByGraphic(ADocument: TPdfBaseDocumentEh; AGraphic: TGraphic; AImageCode: String): TPdfImageEh;

    property ImageCode: String read FImageCode;
    property Size: TSize read FSize;
  end;

{ TPdfJpegImageEh }

  TPdfJpegImageEh = class(TPdfImageEh)
  protected
    function CreateBoundStream: TPdfDictionaryStreamEh; override;

    procedure InitImageFromGraphic(AGraphic: TGraphic); override;

  public
    constructor Create(ADocument: TPdfBaseDocumentEh; AGraphic: TGraphic; AImageCode: String);
    destructor Destroy; override;

    procedure PrepareForExport; override;
  end;

{ TPdfBmpImageEh }

  TPdfBmpImageEh = class(TPdfImageEh)
  private
    FAlphaMaskObj: TPdfBmpImageAlphaMaskEh;

    procedure SaveToStream(ABitmap: TBitmap; ADataStream: TStream; AlphaMaskStream: TStream);
  protected
    function CreateBoundStream: TPdfDictionaryStreamEh; override;

    procedure InitImageFromGraphic(AGraphic: TGraphic); override;

  public
    constructor Create(ADocument: TPdfBaseDocumentEh; AGraphic: TGraphic; AImageCode: String);
    destructor Destroy; override;

    procedure PrepareForExport; override;
  end;

{ TPdfBmpImageAlphaMaskEh }

  TPdfBmpImageAlphaMaskEh = class(TPdfIdrectDictionaryObjectEh)
  private
    FBmpImage: TPdfBmpImageEh;

  protected
    function CreateBoundStream: TPdfDictionaryStreamEh; override;
    procedure InitMask;

  public
    constructor Create(ADocument: TPdfBaseDocumentEh; ABmpImage: TPdfBmpImageEh);
    destructor Destroy; override;

    procedure PrepareForExport; override;
  end;

implementation

{ TPdfImageEh }

constructor TPdfImageEh.Create(ADocument: TPdfBaseDocumentEh; AGraphic: TGraphic; AImageCode: String);
begin
  inherited Create(ADocument);

  InitImageFromGraphic(AGraphic);
  FImageCode := AImageCode;
end;

destructor TPdfImageEh.Destroy;
begin

  inherited Destroy;
end;

class function TPdfImageEh.GetPdfImageByGraphic(ADocument: TPdfBaseDocumentEh; AGraphic: TGraphic; AImageCode: String): TPdfImageEh;
begin
  if (AGraphic is TJPEGImage) then
    Result := TPdfJpegImageEh.Create(ADocument, AGraphic, AImageCode)
  else
    Result := TPdfBmpImageEh.Create(ADocument, AGraphic, AImageCode);
end;

procedure TPdfImageEh.InitImageFromGraphic(AGraphic: TGraphic);
begin

end;

{ TPdfJpegImageEh }

constructor TPdfJpegImageEh.Create(ADocument: TPdfBaseDocumentEh; AGraphic: TGraphic; AImageCode: String);
begin
  inherited Create(ADocument, AGraphic, AImageCode);
end;

destructor TPdfJpegImageEh.Destroy;
begin
  inherited Destroy;
end;

procedure TPdfJpegImageEh.InitImageFromGraphic(AGraphic: TGraphic);
begin
  if not (AGraphic is TJPEGImage) then
    raise Exception.Create('TPdfJpegImage.InitImageFromGraphic: AGraphic is not TJPEGImage.');

  FSize.cx := AGraphic.Width;
  FSize.cy := AGraphic.Height;

  AGraphic.SaveToStream(BoundStream.MemoryStream);
  BoundStream.Position := 0;

  Items.Add('/BitsPerComponent', TPdfIntegerNumberEh.Create(8));
  Items.Add('/ColorSpace', TPdfNameEh.Create('/DeviceRGB'));
  Items.Add('/Height', TPdfIntegerNumberEh.Create(AGraphic.Height));
  Items.Add('/Interpolate', TPdfBoolean.Create(True));
  Items.Add('/Subtype', TPdfNameEh.Create('/Image'));
  Items.Add('/Type', TPdfNameEh.Create('/XObject'));
  Items.Add('/Width', TPdfIntegerNumberEh.Create(AGraphic.Width));

  Items.Add('/Length', TPdfIntegerNumberEh.Create(BoundStream.Size));
  Items.Add('/Filter', TPdfNameEh.Create('/DCTDecode'));
end;

procedure TPdfJpegImageEh.PrepareForExport;
begin
  inherited PrepareForExport;
end;

function TPdfJpegImageEh.CreateBoundStream: TPdfDictionaryStreamEh;
begin
  Result := TPdfDictionaryStreamEh.Create;
end;

{ TPdfBmpImageEh }

constructor TPdfBmpImageEh.Create(ADocument: TPdfBaseDocumentEh; AGraphic: TGraphic;
  AImageCode: String);
begin
  inherited Create(ADocument, AGraphic, AImageCode);
end;

destructor TPdfBmpImageEh.Destroy;
begin
  FreeAndNil(FAlphaMaskObj);
  inherited Destroy;
end;

function TPdfBmpImageEh.CreateBoundStream: TPdfDictionaryStreamEh;
begin
  Result := TPdfDictionaryStreamEh.Create;
end;

procedure TPdfBmpImageEh.InitImageFromGraphic(AGraphic: TGraphic);
var
  ABitmap: TBitmap;
  ARect: TRect;
  FreeBitmapNeeded: Boolean;
begin
  if not (AGraphic is TBitmap) then
  begin
    ABitmap := TBitmap.Create;
    ABitmap.Width := AGraphic.Width;
    ABitmap.Height := AGraphic.Height;
    ABitmap.PixelFormat := pf24bit;
    ARect := Rect(0, 0, AGraphic.Width, AGraphic.Height);
    ABitmap.Canvas.Brush.Color := clWhite;
    ABitmap.Canvas.FillRect(ARect);
    ABitmap.Canvas.StretchDraw(ARect, AGraphic);
    FreeBitmapNeeded := True;
  end
  else
  begin
    ABitmap := TBitmap(AGraphic);
    FreeBitmapNeeded := False;
  end;

  FAlphaMaskObj := TPdfBmpImageAlphaMaskEh.Create(Document, Self);

  FSize.cx := AGraphic.Width;
  FSize.cy := AGraphic.Height;

  SaveToStream(ABitmap, BoundStream.MemoryStream, FAlphaMaskObj.BoundStream.MemoryStream);
  BoundStream.Position := 0;

  Items.Add('/BitsPerComponent', TPdfIntegerNumberEh.Create(8));
  Items.Add('/ColorSpace', TPdfNameEh.Create('/DeviceRGB'));
  Items.Add('/Height', TPdfIntegerNumberEh.Create(AGraphic.Height));
  Items.Add('/Interpolate', TPdfBoolean.Create(True));
  Items.Add('/Subtype', TPdfNameEh.Create('/Image'));
  Items.Add('/Type', TPdfNameEh.Create('/XObject'));
  Items.Add('/Width', TPdfIntegerNumberEh.Create(AGraphic.Width));

  Items.Add('/SMask', FAlphaMaskObj);
  Items.Add('/Length', TPdfIntegerNumberEh.Create(BoundStream.Size));

  FAlphaMaskObj.InitMask;

  if (FreeBitmapNeeded) then
    ABitmap.Free;
end;

procedure TPdfBmpImageEh.SaveToStream(ABitmap: TBitmap; ADataStream: TStream; AlphaMaskStream: TStream);
type
  TRGBBytes = array[0..2] of Byte;
var
  Y, X: Integer;
  Pixels: PByteArray;
  PixelSize: Integer;
  RColor, GColor, BColor, AlphaDegree: Byte;
  ABitmapCopy: TBitmap;
begin
  ABitmapCopy := nil;

  case ABitmap.PixelFormat of
    pf24bit: PixelSize := SizeOf(TRGBBytes);
    pf32bit: PixelSize := SizeOf(TRGBQuad);
  else
    ABitmapCopy := TBitmap.Create;
    ABitmapCopy.Assign(ABitmap);
    ABitmap := ABitmapCopy;
    ABitmap.PixelFormat := pf24bit;
    PixelSize := SizeOf(TRGBBytes);
  end;

  for Y := 0 to ABitmap.Height - 1 do
  begin
    Pixels := ABitmap.ScanLine[Y];

    for X := 0 to ABitmap.Width - 1 do
    begin
      BColor := Pixels[(X * PixelSize)];
      GColor := Pixels[(X * PixelSize + 1)];
      RColor := Pixels[(X * PixelSize + 2)];
      if (ABitmap.PixelFormat = pf32bit)
        then AlphaDegree := Pixels[(X * PixelSize + 3)]
        else AlphaDegree := 255;

      ADataStream.Write(RColor, SizeOf(RColor));
      ADataStream.Write(GColor, SizeOf(GColor));
      ADataStream.Write(BColor, SizeOf(BColor));

      AlphaMaskStream.Write(AlphaDegree, SizeOf(AlphaDegree));
    end;
  end;

  if (ABitmapCopy <> nil) then
    ABitmapCopy.Free;
end;

procedure TPdfBmpImageEh.PrepareForExport;
begin
  inherited PrepareForExport;
end;

{ TPdfBmpImageAlphaMaskEh }

constructor TPdfBmpImageAlphaMaskEh.Create(ADocument: TPdfBaseDocumentEh;
  ABmpImage: TPdfBmpImageEh);
begin
  inherited Create(ADocument);
  FBmpImage := ABmpImage;
end;

destructor TPdfBmpImageAlphaMaskEh.Destroy;
begin
  inherited Destroy;
end;

procedure TPdfBmpImageAlphaMaskEh.InitMask;
begin
  Items.Add('/BitsPerComponent', TPdfIntegerNumberEh.Create(8));
  Items.Add('/ColorSpace', TPdfNameEh.Create('/DeviceGray'));
  Items.Add('/Height', TPdfIntegerNumberEh.Create(FBmpImage.Size.cy));
  Items.Add('/Subtype', TPdfNameEh.Create('/Image'));
  Items.Add('/Type', TPdfNameEh.Create('/XObject'));
  Items.Add('/Width', TPdfIntegerNumberEh.Create(FBmpImage.Size.cx));

  Items.Add('/Length', TPdfIntegerNumberEh.Create(BoundStream.Size));
end;

function TPdfBmpImageAlphaMaskEh.CreateBoundStream: TPdfDictionaryStreamEh;
begin
  Result := TPdfDictionaryStreamEh.Create;
end;

procedure TPdfBmpImageAlphaMaskEh.PrepareForExport;
begin
  inherited PrepareForExport;
end;

end.
