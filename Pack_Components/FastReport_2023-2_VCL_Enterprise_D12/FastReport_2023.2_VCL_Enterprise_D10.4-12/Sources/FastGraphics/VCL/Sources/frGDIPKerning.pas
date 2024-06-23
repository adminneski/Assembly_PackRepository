{******************************************}
{                                          }
{          FastReport VCL/FMX/LCL          }
{             Graphics Library             }
{                                          }
{         Copyright (c) 1998-2022          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

      {******************************************************************}
      { GDIPKerning                                                      }
      {                                                                  }
      { home page : http://www.mwcs.de                                   }
      { email     : martin.walter@mwcs.de                                }
      {                                                                  }
      { date      : 20-11-2007                                           }
      {                                                                  }
      { version   : 1.1                                                  }
      {                                                                  }
      { Use of this file is permitted for commercial and non-commercial  }
      { use, as long as the author is credited.                          }
      { This file (c) 2007 Martin Walter                                 }
      {                                                                  }
      { This Software is distributed on an "AS IS" basis, WITHOUT        }
      { WARRANTY OF ANY KIND, either express or implied.                 }
      {                                                                  }
      { *****************************************************************}
      {               Adapted for FR 7 by Oleg Adibekov                  }
      { *****************************************************************}

unit frGDIPKerning;

interface

{$I frVer.inc}

uses
  Windows,
  Classes,
{$IFDEF DELPHI16}
  Winapi.GDIPOBJ,
  Winapi.GDIPAPI,
{$ELSE}
  frGDIPOBJ,
  frGDIPAPI,
{$ENDIF}
  Types,
  frSVGCanvas;

type
  TKerningPairs = array of TKerningPair;
  PKerningPairs = ^TKerningPairs;

  TKerning = record
    Chars: Cardinal;
    Cell: Integer;
    Kerning: Integer;
  end;
  
  PKerning = ^TKerning;

  TGPKerningText = class(TObject)
  private
    FKerningList: TList;
    FKerningPairs: TKerningPairs;
    FPairCount: Integer;
    FLastFont: WideString;
    FLastWeight: Integer;
    FLastStyle: Integer;
    FFontSizeFactor: Double;

    FFont: HFont;
    FOldFont: HFont;
    FDC: HDC;
    FGPFont: TGPFont;

    procedure PrepareDC;
    procedure UnprepareDC;
    procedure PrepareFont(const LF: TLogFontW);
    procedure UnprepareFont;
    procedure PrepareKerning(const Font: TGPFont); overload;
    procedure PrepareKerning(const Font: TGPFont; const Graphics: TGPGraphics;
      WithFactor: Boolean); overload;
    procedure UnprepareKerning;
    procedure ClearKerningList;
    procedure AddToKerningList(const First, Second: Word;
      Cell, Kerning: Integer);
    function IndexOfKerning(const First, Second: Word): Integer;

    function GetDistance(const Index: Integer;
      const DistanceFactor, KerningFactor: Single): Single;

    procedure Clear;

    function AddGlyphToPath(const Path: TGPGraphicsPath; const Char: WideChar;
      const Family: TGPFontFamily; const Style: Integer; const Size: Single;
      const Origin: TGPPointF; const Format: TGPStringFormat): TStatus;

    function AddGlyphToGraphics(const Graphics: TGPGraphics;
      const Char: WideChar; const Font: TGPFont; const Origin: TGPPointF;
      const Format: TGPStringFormat; const Brush: TGPBrush): TStatus;

    procedure AddDecoration(const Path: TGPGraphicsPath;
      const Left, Top, Width: Single; const Font: TGPFont; dY: Single);
  public
    constructor Create;
    destructor Destroy; override;

  	function AddToPath(const Path, UPath, LPath, OPath: TGPGraphicsPath;
      const Text: WideString; const Family: TGPFontFamily; Style: Integer;
      const Size: Single; TextOrigin: TTextOrigin;
      const DistanceFactor: Single = 1;
      const KerningFactor: Single = 1): TStatus;

  	function AddToGraphics(const Graphics: TGPGraphics;
      const Text: WideString; const Font: TGPFont; Origin: TGPPointF;
      const Format: TGPStringFormat; const Brush: TGPBrush;
      const DistanceFactor: Single = 1;
      const KerningFactor: Single = 1): TStatus; overload;

  	function AddToGraphics(const Graphics: TGPGraphics;
      const Text: WideString; const Font: TGPFont; Origin: TGPPoint;
      const Format: TGPStringFormat; const Brush: TGPBrush;
      const DistanceFactor: Single = 1;
      const KerningFactor: Single = 1): TStatus; overload;

    function MeasureText(const Text: WideString; const Font: TGPFont;
      const DistanceFactor: Single = 1;
      const KerningFactor: Single = 1): Single;

    function GetCellWidth(const First, Second: Word;
      const DistanceFactor: Single = 1;
      const KerningFactor: Single = 1): Single;

    procedure Prepare(const Family: TGPFontFamily; Style: Integer;
      const Size: Single; const Format: TGPStringFormat);

    procedure Unprepare;
  end;

function KerningText: TGPKerningText;

implementation

var
  FKerningText: TGPKerningText;

function KerningText: TGPKerningText;
begin
  if not Assigned(FKerningText) then
    FKerningText := TGPKerningText.Create;

  Result := FKerningText;
end;

{ TKerningText }

procedure TGPKerningText.AddDecoration(const Path: TGPGraphicsPath; const Left,
  Top, Width: Single; const Font: TGPFont; dY: Single);
var
  YPos, Height: Single;
begin
  if Path <> nil then
  begin
    Height := Font.GetSize / 20;
    YPos := Top + Font.GetSize * dY + Height / 2;
    Path.SetFillMode(FillModeWinding);
    Path.AddRectangle(MakeRect(Left, YPos, Width, Height));
  end;
end;

function TGPKerningText.AddGlyphToGraphics(const Graphics: TGPGraphics;
  const Char: WideChar; const Font: TGPFont; const Origin: TGPPointF;
  const Format: TGPStringFormat; const Brush: TGPBrush): TStatus;
begin
  Result := Graphics.DrawString(Char, -1, Font, Origin, Format, Brush);
end;

function TGPKerningText.AddGlyphToPath(const Path: TGPGraphicsPath;
  const Char: WideChar; const Family: TGPFontFamily; const Style: Integer;
  const Size: Single; const Origin: TGPPointF;
  const Format: TGPStringFormat): TStatus;
begin
  Result := Path.AddString(Char, -1, Family, Style, Size, Origin, Format);
end;

function TGPKerningText.AddToGraphics(const Graphics: TGPGraphics;
  const Text: WideString; const Font: TGPFont; Origin: TGPPointF;
  const Format: TGPStringFormat; const Brush: TGPBrush;
  const DistanceFactor: Single = 1; const KerningFactor: Single = 1): TStatus;
var
  P1, P2: PWideChar;
  Status: TStatus;
begin
  Status := Ok;
  if Text = '' then
  begin
    Result := Ok;
    Exit;
  end;

  PrepareKerning(Font, Graphics, False);
  try
    P1 := PWideChar(Text);
    while (P1^ <> #0) do
    begin
      Status := AddGlyphToGraphics(Graphics, P1^, Font, Origin, Format, Brush);
      if Status <> Ok then
        Break;
      P2 := P1 + 1;
      Origin.X := Origin.X + GetCellWidth(Word(P1^), Word(P2^),
        DistanceFactor, KerningFactor);
      Inc(P1);
    end;
  finally
    UnprepareDC;
  end;
  Result := Status;
end;

function TGPKerningText.AddToGraphics(const Graphics: TGPGraphics;
  const Text: WideString; const Font: TGPFont; Origin: TGPPoint;
  const Format: TGPStringFormat; const Brush: TGPBrush;
  const DistanceFactor: Single = 1; const KerningFactor: Single = 1): TStatus;
var
  OriginF: TGPPointF;
begin
  OriginF.X := Origin.X;
  OriginF.Y := Origin.Y;
  Result := AddToGraphics(Graphics, Text, Font, OriginF, Format, Brush,
    DistanceFactor, KerningFactor);
end;

procedure TGPKerningText.AddToKerningList(const First, Second: Word;
  Cell, Kerning: Integer);
var
  Item: PKerning;
begin
  GetMem(Item, SizeOf(TKerning));
  Item^.Chars := First shl 16 + Second;
  Item^.Cell := Cell;
  Item^.Kerning := Kerning;
  FKerningList.Add(Item);
end;

procedure TGPKerningText.Clear;
begin
  UnprepareKerning;
  UnprepareDC;
  UnprepareFont;

  FGPFont.Free;
  FGPFont := nil;
end;

procedure TGPKerningText.ClearKerningList;
var
  C: Integer;
begin
  for C := 0 to FKerningList.Count - 1 do
    FreeMem(FKerningList[C]);

  FKerningList.Clear;
end;

constructor TGPKerningText.Create;
begin
  inherited;
  FKerningList := TList.Create;
end;

destructor TGPKerningText.Destroy;
begin
  Clear;
  FKerningList.Free;

  inherited;
end;

function TGPKerningText.GetCellWidth(const First, Second: Word;
  const DistanceFactor: Single = 1; const KerningFactor: Single = 1): Single;
var
  GM: TGlyphMetrics;
  Count: Cardinal;
  Cell: Integer;
  Kerning: Integer;
  Mat: TMat2;
  C: Integer;
begin
  C := IndexOfKerning(First, Second);
  if C <> -1 then
  begin
    Result := GetDistance(C, DistanceFactor, KerningFactor) * FFontSizeFactor;
    Exit;
  end;

  FillChar(Mat, SizeOf(Mat), 0);
  Mat.eM11.value := 1;
  Mat.eM22.value := 1;

  Count := GetGlyphOutlineW(FDC, First, GGO_METRICS, GM, 0, nil, Mat);
  if (Count = GDI_ERROR) then
  begin
    Result := -1;
    Exit;
  end;

  Cell := GM.gmCellIncX + GM.gmCellIncY;
  Kerning := 0;

  for C := 0 to FPairCount - 1 do
  begin
    if (FKerningPairs[C].wFirst = First) and
       (FKerningPairs[C].wSecond = Second) then
    begin
      Kerning := FKerningPairs[C].iKernAmount;
      Break;
    end;
  end;

  AddToKerningList(First, Second, Cell, Kerning);

  Result := (Cell * DistanceFactor + Kerning * KerningFactor) * FFontSizeFactor;
end;

function TGPKerningText.GetDistance(const Index: Integer;
  const DistanceFactor, KerningFactor: Single): Single;
var
  Kerning: PKerning;
begin
  Kerning := PKerning(FKerningList[Index]);
  Result := Kerning^.Cell * DistanceFactor + Kerning^.Kerning * KerningFactor;
end;

function TGPKerningText.IndexOfKerning(const First, Second: Word): Integer;
var
  Chars: Cardinal;
begin
  Chars := First shl 16 + Second;
  for Result := 0 to FKerningList.Count - 1 do
    if PKerning(FKerningList[Result])^.Chars = Chars then
      Exit;
  Result := -1;
end;

function TGPKerningText.MeasureText(const Text: WideString;
  const Font: TGPFont; const DistanceFactor: Single = 1;
  const KerningFactor: Single = 1): Single;
var
  P1, P2: PWideChar;
begin
  Result := 0;

  if Text = '' then
    Exit;

  PrepareKerning(Font);
  try
    P1 := PWideChar(Text);
    while (P1^ <> #0) do
    begin
      P2 := P1 + 1;
      Result := Result + GetCellWidth(Word(P1^), Word(P2^), DistanceFactor,
        KerningFactor);
      Inc(P1);
    end;
  finally
    UnprepareDC;
  end;
end;

procedure TGPKerningText.Prepare(const Family: TGPFontFamily; Style: Integer;
  const Size: Single; const Format: TGPStringFormat);
begin
  FGPFont.Free;
  FGPFont := TGPFont.Create(Family, Size, Style);
  PrepareKerning(FGPFont);
end;

procedure TGPKerningText.PrepareDC;
begin
  if (FDC <> 0) then
    Exit;

  FDC := GetDC(0);
  FOldFont := SelectObject(FDC, FFont);
end;

procedure TGPKerningText.PrepareFont(const LF: TLogFontW);
begin
  if (FFont <> 0) then
    Exit;

  FFont := CreateFontIndirectW(LF);
end;

procedure TGPKerningText.PrepareKerning(const Font: TGPFont;
  const Graphics: TGPGraphics; WithFactor: Boolean);
var
  LF: TLogFontW;
  S: WideString;
  DC: HDC;
  Factor, Size: Single;
begin
  Font.GetLogFontW(Graphics, LF);

  Size := Font.GetSize;

  if Font.GetUnit in [UnitWorld, UnitPixel] then
    WithFactor := True;
    
  if WithFactor then
  begin
    FFontSizeFactor := Size / 1000;
    LF.lfHeight := -1000;
    //LF.lfHeight := Round(Size * -1000)
  end
  else
  begin
    DC := Graphics.GetHDC;
    Factor := -GetDeviceCaps(DC, LOGPIXELSY) / 72;
    FFontSizeFactor := Size * Factor / 1000;
    LF.lfHeight := 1000;
    //LF.lfHeight := Round(Size * Factor * 1000);
    Graphics.ReleaseHDC(DC);
  end;


  S := LF.lfFaceName;
  if (S = FLastFont) and
     (LF.lfWeight = FLastWeight) and (LF.lfItalic = FLastStyle) then
  begin
    PrepareDC;
    Exit;
  end else
    UnprepareFont;

  FLastFont := WideString(LF.lfFaceName);
  FLastWeight := LF.lfWeight;
  FLastStyle := LF.lfItalic;

  PrepareFont(LF);
  PrepareDC;
  ClearKerningList;

  FPairCount := GetKerningPairs(FDC, 0,  PKerningPair(nil)^);
  if (FPairCount > 0) then
  begin
    SetLength(FKerningPairs, FPairCount);
    GetKerningPairs(FDC, FPairCount, FKerningPairs[0]);
  end;
end;

procedure TGPKerningText.PrepareKerning(const Font: TGPFont);
var
  G: TGPGraphics;
  DC: HDC;
begin
  DC := GetDC(0);
  G := TGPGraphics.Create(DC);
  PrepareKerning(Font, G, True);
  G.Free;
  ReleaseDC(0, DC);
end;

function TGPKerningText.AddToPath(const Path, UPath, LPath, OPath: TGPGraphicsPath;
  const Text: WideString; const Family: TGPFontFamily; Style: Integer;
  const Size: Single; TextOrigin: TTextOrigin; const DistanceFactor,
  KerningFactor: Single): TStatus;
var
  P1, P2: PWideChar;
  Status: TStatus;
  Font: TGPFont;
  Width: Single;
  SF: TGPStringFormat;
  Start, Origin: TGPPointF;
  i: Integer;
begin
  Status := Ok;
  if Text = '' then
  begin
    Result := Ok;
    Exit;
  end;

  Style := Style and not FontStyleUnderline and not FontStyleStrikeout;
  Font := TGPFont.Create(Family, Size, Style);
  try
    PrepareKerning(Font);

    i := 0;
    Start := MakePoint(TextOrigin.X[0] + TextOrigin.DX[0], TextOrigin.Y[0] + TextOrigin.DY[0]);
    Origin := Start;

    Width := MeasureText(Text, Font, DistanceFactor, KerningFactor);

    AddDecoration(LPath, Start.X, Start.Y, Width, Font, 0.55);

    SF := TGPStringFormat.Create(TGPStringFormat.GenericTypographic);
    try
      SF.SetFormatFlags(StringFormatFlagsMeasureTrailingSpaces);

      try
        P1 := PWideChar(Text);
        while (P1^ <> #0) do
        begin
          Status := AddGlyphToPath(Path, P1^, Family, Style, Size, Origin, SF);
          if Status <> Ok then
            Break;

          Inc(i);
          if i <= High(TextOrigin.X) then
            Origin.X := TextOrigin.X[i]
          else
          begin
            P2 := P1 + 1;
            Origin.X := Origin.X + GetCellWidth(Word(P1^), Word(P2^),
              DistanceFactor, KerningFactor);
          end;

          if i <= High(TextOrigin.DX) then
            Origin.X := Origin.X + TextOrigin.DX[i];

          if i <= High(TextOrigin.Y) then
            Origin.Y := TextOrigin.Y[i];

          if i <= High(TextOrigin.DY) then
            Origin.Y := Origin.Y + TextOrigin.DY[i];

          Inc(P1);
        end;
      finally
        UnprepareDC;
      end;
    finally
      SF.Free;
    end;

    AddDecoration(UPath, Start.X, Start.Y, Width, Font, 0.95);
    AddDecoration(OPath, Start.X, Start.Y, Width, Font, 0.05);
  finally
    Font.Free;
  end;

  Result := Status;
end;

procedure TGPKerningText.Unprepare;
begin
  UnprepareDC;
  FGPFont.Free;
  FGPFont := nil;
end;

procedure TGPKerningText.UnprepareDC;
begin
  if (FOldFont <> 0) and (FDC <> 0) then
    SelectObject(FDC, FOldFont);
  FoldFont := 0;

  if FDC <> 0 then
    ReleaseDC(0, FDC);
  FDC := 0;
end;

procedure TGPKerningText.UnprepareFont;
begin
  if FFont <> 0 then
    DeleteObject(FFont);
  FFont := 0;
end;

procedure TGPKerningText.UnprepareKerning;
begin
  SetLength(FKerningPairs, 0);
  FPairCount := 0;
  ClearKerningList;
end;

initialization
  FKerningText := nil;
finalization
  FKerningText.Free;
end.
