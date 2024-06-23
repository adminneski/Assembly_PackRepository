{******************************************}
{                                          }
{          FastReport VCL/FMX/LCL          }
{             Graphics Library             }
{                                          }
{         Copyright (c) 1998-2022          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}
{
Version   11.9
Copyright (c) 1995-2008 by L. David Baldwin
Copyright (c) 2008-2010 by HtmlViewer Team
Copyright (c) 2011-2018 by Bernd Gabriel

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

Note that the source modules HTMLGIF1.PAS and DITHERUNIT.PAS
are covered by separate copyright notices located in those modules.
}

{$I frVer.inc}

unit frGif2;

interface

uses
{$ifdef FPC}
  LclIntf, IntfGraphics, FpImage, LclType, frLazHTMLMisc,
{$else}
  Windows, mmSystem,
{$endif}
  SysUtils, Classes, Graphics,
  frCore, frGif1;

type

  TfrxGIFFrame = class
  private
    { private declarations }
    frLeft: Integer;
    frTop: Integer;
    frWidth: Integer;
    frHeight: Integer;

    TheEnd: boolean; {end of what gets copied}

  public
    constructor CreateCopy(Item: TfrxGIFFrame);
  end;

  TfrxGIFFrameList = class(TList)
  private
    function GetFrame(I: TfrListInteger): TfrxGIFFrame;
  public
    {note: Frames is 1 based, goes from [1..Count]}
    property Frames[I: TfrListInteger]: TfrxGIFFrame read GetFrame; default;
  end;

  { TGIFImage }

  TfrxGIFImage = class(TfrxHtBitmap)
  private
    FGif: TGif;

    FImageWidth: Integer;
    FImageHeight: Integer;
    FNumFrames: Integer;
    FTransparent: Boolean;
    FVisible: Boolean;

    Strip: TfrxHtBitmap;
    Frames: TfrxGIFFrameList;

    procedure SetTransparent(AValue: Boolean); reintroduce;

  public
    constructor Create; override;
    constructor CreateCopy(Item: TfrxGIFImage);
    destructor Destroy; override;

    procedure LoadFromStream(Stream: TStream); override;
    procedure SaveToStream(Stream: TStream); override;

    procedure Draw(Canvas: TCanvas; const ARect: TRect); override;
    function TransparentColor: TColor;

    property IsTransparent: Boolean read FTransparent write SetTransparent;
    property Visible: Boolean read FVisible write FVisible;

    property NumFrames: Integer read FNumFrames;
  end;

implementation

function PtrSub(P1, P2: Pointer): Integer;
 {$ifdef UseInline} inline; {$endif}
begin
{$ifdef FPC}
  Result := P1 - P2;
{$else}
  Result := PAnsiChar(P1) - PAnsiChar(P2);
{$endif}
end;

constructor TfrxGIFFrame.CreateCopy(Item: TfrxGIFFrame);
begin
  inherited Create;
  System.Move(Item.frLeft, frLeft, PtrSub(@TheEnd, @frLeft));
end;

{----------------TGIFImage.Create}

constructor TfrxGIFImage.Create;
begin
  inherited Create;
  FVisible := True;
  FGif := TGif.Create;
  Frames := TfrxGIFFrameList.Create;
end;

constructor TfrxGIFImage.CreateCopy(Item: TfrxGIFImage);
var
  I: integer;
begin
  inherited Create;
  Assign(Item);

  FTransparent := Item.FTransparent;
  FVisible := Item.FVisible;
  FImageWidth := Item.FImageWidth;
  FImageHeight := Item.FImageHeight;

  Strip.Free;
  Strip := TfrxHtBitmap.Create;
  Strip.Assign(Item.Strip);

  FGif := TGif.CreateCopy(Item.FGif);

  Frames := TfrxGIFFrameList.Create;
  FNumFrames := Item.NumFrames;
  for I := 1 to FNumFrames do
    Frames.Add(TfrxGIFFrame.CreateCopy(Item.Frames[I]));
end;

{----------------TGIFImage.Destroy}

destructor TfrxGIFImage.Destroy;
var
  I: Integer;
begin
  for I := Frames.Count downto 1 do
    Frames[I].Free;
  Frames.Free;
  Strip.Free;
  FGif.Free;
  inherited Destroy;
end;

{----------------TGIFImage.Draw}

procedure TfrxGIFImage.Draw(Canvas: TCanvas; const ARect: TRect);
var
  SRect: TRect;
begin
  if FVisible and (FNumFrames > 0) then
  begin
    SRect := Rect(0, 0, Width, Height); {current frame location in Strip bitmap}

    Canvas.CopyMode := cmSrcCopy;
  {draw the correct portion of the strip}
    SetStretchBltMode(Canvas.Handle, ColorOnColor);
    Strip.StretchDraw(Canvas, ARect, SRect);
  end;
end;

//-- BG ---------------------------------------------------------- 27.08.2015 --
procedure TfrxGIFImage.LoadFromStream(Stream: TStream);
var
  Frame: TfrxGIFFrame;
  I: integer;

begin
  FGif.Free;
  FGif := TGif.Create;
  FGif.LoadFromStream(Stream);

  FNumFrames := FGif.ImageCount;
  FImageWidth := FGif.Width;
  FImageHeight := FGif.Height;
  FTransparent := FGif.Transparent;

  Strip.Free;
  Strip := FGif.GetStripBitmap();
//  if Strip.Palette <> 0 then
//    DeleteObject(Strip.ReleasePalette);
//  Strip.Palette := CopyPalette(ThePalette);

  for I := 0 to FNumFrames - 1 do
  begin
    Frame := TfrxGIFFrame.Create;
    try
      Frame.frLeft := FGif.ImageLeft[I];
      Frame.frTop := FGif.ImageTop[I];
      Frame.frWidth := FGif.ImageWidth[I];
      Frame.frHeight := FGif.ImageHeight[I];
    except
      Frame.Free;
      raise;
    end;
    Frames.Add(Frame);
  end;

  inherited Assign(Strip);
  Width := FImageWidth;
  Transparent := False;
end;

procedure TfrxGIFImage.SaveToStream(Stream: TStream);
begin
  FGif.SaveToStream(Stream);
end;

procedure TfrxGIFImage.SetTransparent(AValue: Boolean);
begin
  if FTransparent=AValue then
    Exit;
  FTransparent:=AValue;
  if FMask = nil then
    FMask := TBitmap.Create;
end;

function TfrxGIFImage.TransparentColor: TColor;
begin
  Result := FGif.TransparentColor;
end;

{----------------TgfFrameList.GetFrame}

function TfrxGIFFrameList.GetFrame(I: TfrListInteger): TfrxGIFFrame;
begin
  Assert((I <= Count) and (I >= 1), 'Frame index out of range');
  Result := TfrxGIFFrame(Items[I - 1]);
end;

end.
