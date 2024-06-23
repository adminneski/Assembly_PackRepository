
{******************************************}
{                                          }
{          FastReport VCL/FMX/LCL          }
{             Graphics Library             }
{                                          }
{         Copyright (c) 1998-2022          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frICOGraphics;

interface

{$I frVer.inc}

uses
  SysUtils, {$IFNDEF FPC}Windows, Messages,{$ENDIF}
  Classes, Graphics, frPictureGraphics;

const
  frxICOFileFormat = 3;

implementation

type
  TfrxICOGraphicFormat = class(TfrxCustomGraphicFormat)
  public
    class function ConvertToBitmap(Graphic: TGraphic; DestPixelFormat: TPixelFormat): TGraphic; override;
    class function CreateNew(Width: Integer; Height: Integer; PixelFormat: TPixelFormat; Transparent: Boolean; Quality: Integer = 100): TGraphic; override;
    class function GetGraphicClass: TGraphicClass; override;
    class function GetGraphicMime: String; override;
    class function GetGraphicName: String; override;
    class function GetGraphicExt: String; override;
    class function GetGraphicConst: Integer; override;
    class function IsSupportedFormat(const Stream: TStream): Boolean; override;
  end;

{ TfrxICOGraphicFormat }

class function TfrxICOGraphicFormat.ConvertToBitmap(Graphic: TGraphic;
  DestPixelFormat: TPixelFormat): TGraphic;
var
  Bmp: TBitmap absolute Result;
begin
  Result := nil;
  Result := TBitmap.Create;
  Bmp.PixelFormat := DestPixelFormat;
  Bmp.Width := Graphic.Width;
  Bmp.Height := Graphic.Height;
  Bmp.Canvas.Lock;
  try
    Bmp.Canvas.StretchDraw(Rect(0, 0, Bmp.Width, Bmp.Height), Graphic);
  finally
    Bmp.Canvas.Unlock;
  end;
end;

class function TfrxICOGraphicFormat.CreateNew(Width, Height: Integer;
  PixelFormat: TPixelFormat; Transparent: Boolean; Quality: Integer): TGraphic;
begin
  Result := TIcon.Create;
  Result.Width := Width;
  Result.Height := Height;
end;

class function TfrxICOGraphicFormat.GetGraphicClass: TGraphicClass;
begin
  Result := TIcon;
end;

class function TfrxICOGraphicFormat.GetGraphicConst: Integer;
begin
  Result := frxICOFileFormat;
end;

class function TfrxICOGraphicFormat.GetGraphicExt: String;
begin
  Result := '.ico';
end;

class function TfrxICOGraphicFormat.GetGraphicMime: String;
begin
  Result := 'image/vnd.microsoft.icon';
end;

class function TfrxICOGraphicFormat.GetGraphicName: String;
begin
  Result := 'ICO';
end;

class function TfrxICOGraphicFormat.IsSupportedFormat(
  const Stream: TStream): Boolean;

const
  rc3_StockIcon = 0;
  rc3_Icon = 1;
  rc3_Cursor = 2;

type
  TCursorOrIcon = packed record
    Reserved: Word;
    wType: Word;
    Count: Word;
  end;

var
  ICOHeader: TCursorOrIcon;
  pos: Integer;
begin
  Result := False;
  if (Stream.Size - Stream.Position) >= SizeOf(ICOHeader) then
  begin
    pos := Stream.Position;
    Stream.ReadBuffer(ICOHeader, SizeOf(ICOHeader));
    Stream.Position := pos;
    if (ICOHeader.wType in [RC3_STOCKICON, RC3_ICON]) and (ICOHeader.Reserved = 0) then
      Result := True;
  end;
end;

initialization
  GetGraphicFormats.RegisterFormat(TfrxICOGraphicFormat);

finalization
  GetGraphicFormats.UnregisterFormat(TfrxICOGraphicFormat);

end.
