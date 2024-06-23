
{******************************************}
{                                          }
{             FastReport VCL               }
{                 QR code                  }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxBarcodeQR;


interface

{$I frx.inc}

uses
{$IFDEF FPC}
  LCLType, LMessages, LazHelper, LCLIntf,
{$ELSE}
  Windows, Messages,
{$ENDIF}
  SysUtils, Types, StrUtils, Classes, Graphics, Controls, Forms, Dialogs, frxBarcode2DBase, frxDelphiZXingQRCode;

type
  TfrxBarcodeLogo = class(TPersistent)
  private
    FLogo: TPicture;
    FWidth: Integer;
    FHeight: Integer;
    procedure SetLogo(const Value: TPicture);
    function GetLogo: TPicture;
    function GetLogoInst: TPicture;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Draw(DrawRect: TRect; ScaleX, ScaleY: Extended; Canvas: TCanvas; Zoom: Extended);
  published
    property Logo: TPicture read GetLogo write SetLogo;
    property Width: Integer read FWidth write FWidth;
    property Height: Integer read FHeight write FHeight;
  end;

  TfrxBarcodeGraphicMarker = class(TPersistent)
  private
    FShowGraphicMarker : Boolean;
    FWidthLine: Integer;
    FDistance: Integer;
    FPixelSize: Integer;
    FScaleX: Extended;
    FScaleY: Extended;
    procedure SetWidthLine(const Value: Integer);
    procedure SetDistance(const Value: Integer);
    procedure SetPixelSize(const Value: Integer);
  public
    constructor Create(PixelSize : Integer);
    procedure Draw(DrawRect: TRect; ScaleX, ScaleY: Extended; var Canvas: TCanvas;
      Zoom: Extended; FooterHeight: Integer);
  published
    property ShowGraphicMarker: Boolean read FShowGraphicMarker write FShowGraphicMarker;
    property WidthLine: Integer read FWidthLine write SetWidthLine;
    property Distance: Integer read FDistance write SetDistance;
  end;

  TfrxBarcodeQR = class( TfrxBarcode2DBaseWithUnion )
  private
    FDelphiZXingQRCode: TDelphiZXingQRCode;
    FLogo: TfrxBarcodeLogo;
    FGraphicMarker: TfrxBarcodeGraphicMarker;
    procedure Generate();
    function GetEncoding: TQRCodeEncoding;
    function GetQuietZone: Integer;
    procedure SetEncoding(const Value: TQRCodeEncoding);
    procedure SetQuietZone(const Value: Integer);
    function GetErrorLevels: TQRErrorLevels;
    procedure SetErrorLevels(const Value: TQRErrorLevels);
    function  GetPixelSize : integer;
    procedure SetPixelSize(v : integer);
    function GetCodepage: Longint;
    procedure SetCodepage(const Value: Longint);
  protected
    procedure SetText( v : string ); override;
    function GetWidth: Integer; override;
    function GetHeight: Integer; override;
  public
    constructor Create; override;
    destructor  Destroy; override;
    procedure   Assign(src: TfrxBarcode2DBase);override;
    procedure Draw2DBarcode(var g: TCanvas; scalex, scaley: Extended;
      x, y: Integer); override;
  published
     property Encoding: TQRCodeEncoding read GetEncoding write SetEncoding;
     property QuietZone: Integer read GetQuietZone write SetQuietZone;
     property ErrorLevels: TQRErrorLevels read GetErrorLevels write SetErrorLevels;
     property PixelSize : integer read GetPixelSize write SetPixelSize;
     property Codepage : Longint read GetCodepage write SetCodepage;
     property Logo: TfrxBarcodeLogo read FLogo;
     property GraphicMarker : TfrxBarcodeGraphicMarker read FGraphicMarker;
  end;


implementation


{ TfrxBarcodeQR }

procedure TfrxBarcodeQR.Assign(src: TfrxBarcode2DBase);
var
   BSource : TfrxBarcodeQR;
begin
   inherited;
   if src is TfrxBarcodeQR then
   begin
      BSource    := TfrxBarcodeQR( src );
      FHeight    := BSource.FHeight;
      Encoding := BSource.Encoding;
      QuietZone := BSource.QuietZone;
      ErrorLevels := BSource.ErrorLevels;
   end;
end;

constructor TfrxBarcodeQR.Create;
begin
  inherited;
  FLogo := TfrxBarcodeLogo.Create;
  FGraphicMarker := TfrxBarcodeGraphicMarker.Create(PixelSize);
  FDelphiZXingQRCode := TDelphiZXingQRCode.Create;
  FDelphiZXingQRCode.Data := FText;
  PixelWidth := 4;
  PixelHeight := 4;
  QuietZone := 0;
  Generate;
end;

destructor TfrxBarcodeQR.Destroy;
begin
  FDelphiZXingQRCode.Free;
  FreeAndNil(FLogo);
  FreeAndNil(FGraphicMarker);
  inherited;
end;


procedure TfrxBarcodeQR.Draw2DBarcode(var g: TCanvas; scalex, scaley: Extended;
  x, y: Integer);
var
  drawR: TRect;
begin
  inherited;
  if ShowText then
    drawR := Rect(X, Y, X + Width, Y + Height - GetFooterHeight)
  else
    drawR := Rect(X, Y, X + Width, Y + Height);

  if FGraphicMarker.ShowGraphicMarker then
  begin
    if ShowText then
      GraphicMarker.Draw(drawR, scalex, scaley, g, Zoom,GetFooterHeight)
    else
      GraphicMarker.Draw(drawR, scalex, scaley, g, Zoom,0);
    drawR := Rect(X, Y, X + Width - Round(FGraphicMarker.FDistance +
      FGraphicMarker.FWidthLine*PixelSize* Zoom),
      Y+ Height - Round(FGraphicMarker.FDistance +
      FGraphicMarker.FWidthLine*PixelSize* Zoom));
    if ShowText then
      drawR.Bottom := drawR.Bottom - GetFooterHeight
  end;

  FLogo.Draw(drawR, scalex, scaley, g, Zoom);
end;

procedure TfrxBarcodeQR.Generate;
begin
    FHeight := FDelphiZXingQRCode.Rows;
    FWidth := FDelphiZXingQRCode.Columns;
    T2DBooleanArrayToVectorPrimitives(FDelphiZXingQRCode.FElements, FHeight, FWidth, FDelphiZXingQRCode.QuietZone);
end;

function TfrxBarcodeQR.GetCodepage: Longint;
begin
  Result := FDelphiZXingQRCode.CodePage;
end;

function TfrxBarcodeQR.GetEncoding: TQRCodeEncoding;
begin
  Result := FDelphiZXingQRCode.Encoding;
end;

function TfrxBarcodeQR.GetErrorLevels: TQRErrorLevels;
begin
  Result := FDelphiZXingQRCode.ErrorLevels;
end;

function TfrxBarcodeQR.GetQuietZone: Integer;
begin
  Result := FDelphiZXingQRCode.QuietZone;
end;

procedure TfrxBarcodeQR.SetCodepage(const Value: Longint);
begin
  FDelphiZXingQRCode.CodePage := Value;
end;

procedure TfrxBarcodeQR.SetEncoding(const Value: TQRCodeEncoding);
begin
  FDelphiZXingQRCode.Encoding := Value;
  Generate;
end;

procedure TfrxBarcodeQR.SetErrorLevels(const Value: TQRErrorLevels);
begin
  FDelphiZXingQRCode.ErrorLevels := Value;
  Generate;
end;

procedure TfrxBarcodeQR.SetQuietZone(const Value: Integer);
begin
  FDelphiZXingQRCode.QuietZone := Value;
  Generate;
end;

procedure TfrxBarcodeQR.SetText(v: string);
begin
  inherited;
  ErrorText := '';
  try
    FDelphiZXingQRCode.Data := v;
  except
    on e: Exception do
      ErrorText := e.Message;
  end;
  Generate;
end;

function TfrxBarcodeQR.GetPixelSize: integer;
begin
  result := FPixelWidth;
end;

procedure TfrxBarcodeQR.SetPixelSize(v : integer);
begin
  FPixelWidth := v;
  FPixelHeight := v;
end;

function TfrxBarcodeQR.GetWidth: Integer;
begin
  Result := inherited GetWidth;
  if FGraphicMarker.ShowGraphicMarker then
  begin
    FGraphicMarker.SetPixelSize(PixelSize);
    Result := Round(Result + (FGraphicMarker.FDistance +
      FGraphicMarker.FWidthLine*PixelSize* Zoom));
  end;
end;

function TfrxBarcodeQR.GetHeight: Integer;
begin
  Result := inherited GetHeight;
  if FGraphicMarker.ShowGraphicMarker then
  begin
    FGraphicMarker.SetPixelSize(PixelSize);
    Result := Round(Result + (FGraphicMarker.FDistance +
      FGraphicMarker.FWidthLine*PixelSize* Zoom));
  end;

end;

{ TfrxBarcodeLogo }

procedure TfrxBarcodeLogo.Assign(Source: TPersistent);
begin
  inherited;
  if Source is  TfrxBarcodeLogo then
  begin
    Width := TfrxBarcodeLogo(Source).Width;
    Height := TfrxBarcodeLogo(Source).Height;
    Logo.Assign(TfrxBarcodeLogo(Source).Logo);
  end;

end;

constructor TfrxBarcodeLogo.Create;
begin
  Width := 32;
  Height := 32;
end;

destructor TfrxBarcodeLogo.Destroy;
begin
  FreeAndNil(FLogo);
  inherited;
end;

procedure TfrxBarcodeLogo.Draw(DrawRect: TRect; ScaleX, ScaleY: Extended; Canvas: TCanvas; Zoom: Extended);
var
  W, H: Integer;
begin
  if not Assigned(FLogo) then Exit;
  W := DrawRect.Right - DrawRect.Left;
  H := DrawRect.Bottom - DrawRect.Top;
  DrawRect.Left := DrawRect.Left + Round((W - Width) * ScaleX * Zoom) div 2;
  DrawRect.Top := DrawRect.Top + Round((H - Height) * ScaleY * Zoom) div 2;
  DrawRect.Right := DrawRect.Left + Round(Width * ScaleX * Zoom);
  DrawRect.Bottom := DrawRect.Top + Round(Height * ScaleY * Zoom);
  Canvas.StretchDraw(DrawRect, FLogo.Graphic);
end;

function TfrxBarcodeLogo.GetLogo: TPicture;
begin
  Result := GetLogoInst;
end;

function TfrxBarcodeLogo.GetLogoInst: TPicture;
begin
  if not Assigned(FLogo) then
    FLogo := TPicture.Create;
  Result := FLogo;
end;

procedure TfrxBarcodeLogo.SetLogo(const Value: TPicture);
begin
  GetLogoInst.Assign(Value);
end;

{ TfrxBarcodeGraphicMarker }

constructor TfrxBarcodeGraphicMarker.Create(PixelSize : Integer);
begin
  FPixelSize := PixelSize;
  FShowGraphicMarker := False;
  FWidthLine := FPixelSize *2;
  FDistance := FPixelSize *4;
  FScaleX := 1;
  FScaleY := 1;
end;

procedure TfrxBarcodeGraphicMarker.Draw(DrawRect: TRect; ScaleX, ScaleY: Extended;
  var Canvas: TCanvas; Zoom: Extended; FooterHeight: Integer);
var
  W,H,L,T: Integer;
begin
  FScaleX:= ScaleX;
  FScaleY:= ScaleY;
  W := DrawRect.Right - DrawRect.Left - FWidthLine div FPixelSize div 2;
  H := DrawRect.Bottom - DrawRect.Top - FWidthLine div FPixelSize div 2 + FooterHeight;
  L := DrawRect.Left;
  T := DrawRect.Top;
  DrawRect.Left := DrawRect.Left + Round((W - FWidthLine div 2) * ScaleX * Zoom);
  DrawRect.Top  := DrawRect.Top  + Round(H * ScaleY * Zoom) div 2
    - Round(FooterHeight * ScaleY * Zoom) div 2;
  DrawRect.Right := DrawRect.Left + Round(FWidthLine div 2 * ScaleX * Zoom);
  DrawRect.Bottom := DrawRect.Top + Round(((H - H div 2)) * ScaleY * Zoom)
    + Round(FooterHeight * ScaleY * Zoom) div 2;
  Canvas.FillRect(DrawRect);
  DrawRect.Left := L;
  DrawRect.Top := T;
  DrawRect.Left := DrawRect.Left + Round(W * ScaleX * Zoom) div 2;
  DrawRect.Top  := DrawRect.Top  + Round((H - FWidthLine div 2) * ScaleY * Zoom);
  Canvas.FillRect(DrawRect);
end;

procedure TfrxBarcodeGraphicMarker.SetWidthLine(const Value: Integer);
begin
  if Value >= 2*FPixelSize then
    FWidthLine := Value;

end;
procedure TfrxBarcodeGraphicMarker.SetDistance(const Value: Integer);
begin
  if Value >= 4*FPixelSize then
    FDistance := Value;
end;
procedure TfrxBarcodeGraphicMarker.SetPixelSize(const Value: Integer);
begin
    FPixelSize := Value;
end;
end.
