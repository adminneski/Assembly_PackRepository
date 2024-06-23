
{******************************************}
{                                          }
{          FastReport VCL/FMX/LCL          }
{             Graphics Library             }
{                                          }
{         Copyright (c) 1998-2022          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frGIFGraphic;

interface

{$I frVer.inc}

uses
{$IFNDEF FPC}
  Windows,
{$ELSE}
  LCLType,
{$ENDIF}
  Classes, Graphics, frGif2, frCore;

type
  TfrxGIFGraphic = class(TGraphic)
  private
    FGIFImage: TfrxGIFImage;
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadData(Stream: TStream); override;
    procedure WriteData(Stream: TStream); override;

    procedure Draw(ACanvas: TCanvas; const Rect: TRect); override;

    function GetEmpty: Boolean; override;
    function GetWidth: Integer; override;
    function GetHeight: Integer; override;
    procedure SetHeight(Value: Integer); override;
    procedure SetWidth(Value: Integer); override;

    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create; override;
    destructor Destroy; override;

    procedure LoadFromFile(const Filename: string); override;
    procedure LoadFromStream(Stream: TStream); override;
    procedure SaveToStream(Stream: TStream); override;
{$IFNDEF FPC}
    procedure LoadFromClipboardFormat(AFormat: Word; AData: TfrHandle;
      APalette: HPALETTE); override;
    procedure SaveToClipboardFormat(var AFormat: Word; var AData: TfrHandle;
      var APalette: HPALETTE); override;
{$ELSE}
    procedure LoadFromClipboardFormat(FormatID: TClipboardFormat); override;
    procedure SaveToClipboardFormat(FormatID: TClipboardFormat); override;
{$ENDIF}

    function IsTransparent: boolean;
    function TransparentColor: TColor;
  end;

implementation

uses
  SysUtils;

{ TfrxGIFGraphic }

procedure TfrxGIFGraphic.AssignTo(Dest: TPersistent);
var
  D: TfrxGIFGraphic;
begin
  if Dest is TfrxGIFGraphic then
  begin
    D := TfrxGIFGraphic(Dest);

    D.FGIFImage.Free;
    D.FGIFImage := TfrxGIFImage.CreateCopy(FGIFImage);

    Changed(Dest);
  end;
end;

constructor TfrxGIFGraphic.Create;
begin
  inherited Create;
  FGIFImage := TfrxGIFImage.Create;
end;

procedure TfrxGIFGraphic.DefineProperties(Filer: TFiler);
begin
  Filer.DefineBinaryProperty('Data', ReadData, WriteData, True);
end;

destructor TfrxGIFGraphic.Destroy;
begin
  FGIFImage.Free;
  inherited Destroy;
end;

procedure TfrxGIFGraphic.Draw(ACanvas: TCanvas; const Rect: TRect);
begin
  FGIFImage.Draw(ACanvas, Rect);
end;

function TfrxGIFGraphic.GetEmpty: Boolean;
begin
  Result := FGIFImage.NumFrames <= 0;
end;

function TfrxGIFGraphic.GetHeight: Integer;
begin
  Result := FGIFImage.Height;
end;

function TfrxGIFGraphic.GetWidth: Integer;
begin
  Result := FGIFImage.Width;
end;

function TfrxGIFGraphic.IsTransparent: boolean;
begin
  Result := FGIFImage.IsTransparent;
end;

{$IFNDEF FPC}
procedure TfrxGIFGraphic.LoadFromClipboardFormat(AFormat: Word; AData: TfrHandle;
  APalette: HPALETTE);
{$ELSE}
procedure TfrxGIFGraphic.LoadFromClipboardFormat(FormatID: TClipboardFormat);
{$ENDIF}
var
  Bitmap: TBitmap;
begin
  Bitmap := TBitmap.Create;
  try
   {$IFNDEF FPC}
    Bitmap.LoadFromClipboardFormat(AFormat, AData, APalette);
   {$ELSE}
    Bitmap.LoadFromClipboardFormat(FormatID);
   {$ENDIF}
    FGIFImage.Assign(Bitmap);
  finally
    Bitmap.Free;
  end;
end;

procedure TfrxGIFGraphic.LoadFromFile(const Filename: string);
var
  Stream: TFileStream;
begin
  Stream := TFileStream.Create(Filename, fmOpenRead);
  try
    LoadFromStream(Stream);
  finally
    Stream.Free;
  end;
  Changed(Self);
end;

procedure TfrxGIFGraphic.LoadFromStream(Stream: TStream);
begin
  try
    FGIFImage.LoadFromStream(Stream);
  except
  end;
  Changed(Self);
end;

procedure TfrxGIFGraphic.ReadData(Stream: TStream);
var
  Size: LongInt;
  MemoryStream: TMemoryStream;
begin
  Stream.Read(Size, SizeOf(Size));
  MemoryStream := TMemoryStream.Create;
  try
    MemoryStream.CopyFrom(Stream, Size);
    MemoryStream.Position := 0;
    FGIFImage.LoadFromStream(MemoryStream);
  finally
    MemoryStream.Free;
  end;
end;

{$IFNDEF FPC}
procedure TfrxGIFGraphic.SaveToClipboardFormat(var AFormat: Word;
  var AData: TfrHandle; var APalette: HPALETTE);
{$ELSE}
procedure TfrxGIFGraphic.SaveToClipboardFormat(FormatID: TClipboardFormat);
{$ENDIF}
var
  Bitmap: TBitmap;
begin
  Bitmap := TBitmap.Create;
  try
    Bitmap.Width := FGIFImage.Width;
    Bitmap.Height := FGIFImage.Height;
    Draw(Bitmap.Canvas, Rect(0, 0, FGIFImage.Width, FGIFImage.Height));
   {$IFNDEF FPC}
    Bitmap.SaveToClipboardFormat(AFormat, AData, APalette);
   {$ELSE}
    Bitmap.SaveToClipboardFormat(FormatID);
   {$ENDIF}
  finally
    Bitmap.Free;
  end;
end;

procedure TfrxGIFGraphic.SaveToStream(Stream: TStream);
begin
  FGIFImage.SaveToStream(Stream);
end;

procedure TfrxGIFGraphic.SetHeight(Value: Integer);
begin
  if FGIFImage.Height <> Value then
    FGIFImage.Height := Value;
end;

procedure TfrxGIFGraphic.SetWidth(Value: Integer);
begin
  if FGIFImage.Width <> Value then
    FGIFImage.Width := Value;
end;

function TfrxGIFGraphic.TransparentColor: TColor;
begin
  Result := FGIFImage.TransparentColor;
end;

procedure TfrxGIFGraphic.WriteData(Stream: TStream);
var
  Size: LongInt;
  MemoryStream: TMemoryStream;
begin
  MemoryStream := TMemoryStream.Create;
  try
    FGIFImage.SaveToStream(MemoryStream);
    Size := MemoryStream.Size;
    Stream.Write(Size, SizeOf(Size));
    MemoryStream.Position := 0;
    MemoryStream.SaveToStream(Stream);
  finally
    MemoryStream.Free;
  end;
end;

initialization
  TPicture.RegisterFileFormat('GIF', 'Graphics Interchange Format', TfrxGIFGraphic);

finalization
  TPicture.UnregisterGraphicClass(TfrxGIFGraphic);

end.
