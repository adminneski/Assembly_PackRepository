{*******************************************************}
{                                                       }
{                      EhLib 10.2                       }
{                                                       }
{             TPdgGraphicsEh, TPdgFontEh,               }
{          TPdgStrokeEh, TPdgBrushEh classes            }
{                                                       }
{    Copyright (c) 2021-2022 by Dmitry V. Bolshakov     }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit PdfGraphicsEh;

{$SCOPEDENUMS ON}

interface

uses
{$IFDEF EH_LIB_17} System.UITypes, {$ENDIF}
{$IFDEF FPC}
  EhLibLCL, LCLType, LCLIntf, Generics.Collections, IntfGraphics,
{$ELSE}
  EhLibVCL, Generics.Collections,
{$ENDIF}
  Classes, SysUtils, Types, Graphics, Math,
  PdfElemetsEh, PdfFontsEh, PdfImagesEh;

type
  TPdgGraphicsEh = class;
  TPdgFontEh = class;
  TPdgStrokeEh = class;
  TPdgBrushEh = class;

{ TPdgGraphicsEh }

  TPdgGraphicsEh = class(TObject)
  private
    FBrush: TPdgBrushEh;
    FCurTextPos: TPointF;
    FFont: TPdgFontEh;
    FOwnerPage: TPdfObjectEh;
    FRotationDegree: Single;
    FStroke: TPdgStrokeEh;

    function GetDataStream: TPdfAsciiStreamEh;
    function GetRotationDegree: Single;
    procedure InternalDrawStringLine(AText: String; PosX, PosY: Double); overload;
    procedure SetRotationDegree(const Value: Single);
  protected
    function FixPageCoord(Coord: TPointF): TPointF;

    procedure WriteFillColor;

    property DataStream: TPdfAsciiStreamEh read GetDataStream;
    property CurTextPos: TPointF read FCurTextPos;

  public
    constructor Create(AnOwnerPage: TPdfObjectEh);
    destructor Destroy; override;

    function CalcTextSize(const AText: String; InitRectWidth: Double; WordWrap: Boolean): TSizeF;
    function GetCurrentPdfFont: TPdfType0FontEh;
    function GetStringCharWidths(const Text: string): TDoubleDynArray;
    function TextExtent(const Text: string): TSizeF;

    procedure IntersectClipRect(AClipRect: TRectF);
    procedure RestoreClip;

    procedure DrawString(AText: String; ATextRect: TRectF; Alignment: TAlignment; VertAlignment: TVerticalAlignment; WordWrap: Boolean); overload;
    procedure DrawString(S: String; APos: TPointF); overload;
    procedure DrawText(AText: String; ATextRect: TRectF; var Options: TDrawTextOptionsEh); overload;
    procedure DrawText(AText: String; ATextRect: TRectF; var Options: TDrawTextOptionsEh; AClipRect: TRectF); overload;

    procedure DrawGraphic(Graphic: TGraphic; X, Y: Single); overload;
    procedure DrawGraphic(Graphic: TGraphic; ARect: TRectF); overload;

    procedure DrawLine(X1, Y1, X2, Y2: Single);
    procedure FillRect(ARect: TRectF);

    property Stroke: TPdgStrokeEh read FStroke;
    property Font: TPdgFontEh read FFont;
    property Brush: TPdgBrushEh read FBrush;
    property RotationDegree: Single read GetRotationDegree write SetRotationDegree;

  end;

{ TPdgStrokeEh }

  TPdgStrokeKindEh = (None, Solid, Dash, Dot, DashDot, DashDotDot);

  TPdgStrokeEh = class(TObject)
  private
    FColor: TColor;
    FGraphics: TPdgGraphicsEh;
    FKind: TPdgStrokeKindEh;
    FOpacity: Single;
    FWidth: Single;

    procedure SetWidth(const Value: Single);
    procedure SetColor(const Value: TColor);
    procedure SetOpacity(const Value: Single);
    procedure SetKind(const Value: TPdgStrokeKindEh);
    function GetDataStream: TPdfAsciiStreamEh;

  protected
    procedure WriteWidthToStream;
    procedure WriteColorToStream;

    property DataStream: TPdfAsciiStreamEh read GetDataStream;
  public
    constructor Create(AGraphics: TPdgGraphicsEh);

    property Kind: TPdgStrokeKindEh read FKind write SetKind;
    property Width: Single read FWidth write SetWidth;
    property Color: TColor read FColor write SetColor;
    property Opacity: Single read FOpacity write SetOpacity;
  end;

{ TPdgBrushEh }

  TPdgBrushEh = class(TObject)
  private
    FColor: TColor;
    FGraphics: TPdgGraphicsEh;
    FOpacity: Single;

    procedure SetColor(const Value: TColor);
    procedure SetOpacity(const Value: Single);

  protected
  public
    constructor Create(AGraphics: TPdgGraphicsEh);

    property Color: TColor read FColor write SetColor;
    property Opacity: Single read FOpacity write SetOpacity;
  end;

{ TPdgFontEh }

  //TPdgFontStyleEh = (Regular, Bold, Italic, BoldItalic, Underline, Strikeout);
  TPdgFontStyleEh = (Bold, Italic, Underline, Strikeout);
  TPdgFontStylesEh = set of TPdgFontStyleEh;

  TPdgFontEh = class(TObject)
  private
    FFontKeyName: String;
    FGraphics: TPdgGraphicsEh;
    FName: String;
    FSize: Double;
    FStyle: TPdgFontStylesEh;

    procedure SetName(const Value: String);
    procedure SetSize(const Value: Double);
    procedure SetStyle(const Value: TPdgFontStylesEh);
    procedure UpdateFontKeyName();
  protected

    property FontKeyName: String read FFontKeyName;
  public
    constructor Create(AGraphics: TPdgGraphicsEh); overload;

    property Name: String read FName write SetName;
    property Size: Double read FSize write SetSize;
    property Style: TPdgFontStylesEh read FStyle write SetStyle;
  end;

implementation

uses
  PdfDocumentsEh;

function FloatToSysStr(Val: Extended): string;
var
  ASep: Char;
begin
  ASep := FormatSettings.DecimalSeparator;
  FormatSettings.DecimalSeparator := '.';
  try
    Result := FormatFloat('0.############', Val);
  finally
    FormatSettings.DecimalSeparator := ASep;
  end;
end;

function StringToPdfHexString(Str: String): String;
var
  I: Integer;
begin
  Result := '';
  for I := 1 to Length(Str) do
    Result := Result + CharToHexEh(Str[I]);
end;

function WordsToPdfHexString(Wrds: TWordDynArray): String;
var
  I: Integer;
begin
  Result := '';
  for I := 0 to Length(Wrds) - 1 do
    Result := Result + WordToHexEh(Wrds[I]);
end;

type
  TWrappedOneLineInfo = record
    st: Longint;
    le: Longint;
    pwi: Double;
    phi: Double;
  end;

  TWrappedLinesInfo = array of TWrappedOneLineInfo;

  TDrawStringLineInfo = record
    Text: String;
    PosX: Double;
    PosY: Double;
    RectWidth: Double;
    Alignment: TAlignment;
  end;

function geli(s: String; p0: Integer; W: Double; var WidthPxl: Double; cex: TDoubleDynArray; ML:Boolean): Integer;

  function cexSu(c: TDoubleDynArray; p, cnt: Integer): Double;
  var
    i: Integer;
  begin
    Result := 0;
    for i := p to p + cnt - 1 do
    begin
      Result := Result + c[i];
    end;
  end;

var
  cw, wpxl: Double;
  i, ls0: Integer;
  sLen: Integer;
  ni: Integer;
begin
  cw := 0;
  ls0 := -1;
  wpxl := 0;
  sLen := Length(s);
  i := p0;
  ni := i + 1;
  while (ni <= sLen) do
  //for i := p0 to sLen-1 do
  begin
    if S[ni] = ' ' then
    begin
      ls0 := ni;
      wpxl := cw + cexSu(cex, i, ni - i);
    end;

    cw := cw + cexSu(cex, i, ni - i);

    if ML and ((S[ni] = #13) or (S[ni] = #10)) then
    begin
      if (ni < sLen-1) and (S[ni] = #13) and (S[ni+1] = #10)
        then Result := i+2
        else Result := i+1;
      WidthPxl := cw;
      Exit;
    end else if (cw > W) and (ls0 > -1) then
    begin
      if ML then
      begin
        Result := ls0{ + 1};
        WidthPxl := wpxl;
      end else
      begin
        Result := ni;
        WidthPxl := cw;
      end;
      Exit;
    end;
    i := ni;
    ni := StringNextCharPos(S, ni);
  end;
  Result := sLen;
  WidthPxl := cw;
end;

function CalcWrap(W: Double; const T: string; ML: Boolean; var Size: TSizeF; Cex: TDoubleDynArray; LnHgt: Double): TWrappedLinesInfo; overload;
var
  wpxl: Double;
  nlp, olp, Line: Integer;
  lsa: TWrappedLinesInfo;
begin
  olp := 0;
  Line := 0;
  Size.cx := 0;
  while True do
  begin
    nlp := geli(T, olp, W, wpxl, cex, ML);
    SetLength(lsa, Line+1);
    lsa[Line].st := olp;
    lsa[Line].le := nlp - olp{ + 1};
    lsa[Line].pwi := wpxl;
    lsa[Line].phi := LnHgt;
    if wpxl > Size.cx then
      Size.cx := wpxl;
    Inc(Line);
    if nlp >= Length(T) then
      Break;
    olp := nlp;
    if not ML then Break;
  end;

  Size.cy := Length(lsa) * LnHgt;
  Result := lsa;
end;

{ TPdgGraphicsEh }

constructor TPdgGraphicsEh.Create(AnOwnerPage: TPdfObjectEh);
begin
  inherited Create;
  FOwnerPage := AnOwnerPage;
  FStroke := TPdgStrokeEh.Create(Self);
  FFont := TPdgFontEh.Create(Self);
  FBrush := TPdgBrushEh.Create(Self);
end;

destructor TPdgGraphicsEh.Destroy;
begin
  FreeAndNil(FStroke);
  FreeAndNil(FFont);
  FreeAndNil(FBrush);

  inherited Destroy;
end;

function TPdgGraphicsEh.GetCurrentPdfFont: TPdfType0FontEh;
var
  PdfFontDef: TPdfFontDefEh;
begin
  PdfFontDef.Name := Font.Name;
  PdfFontDef.IsBold := TPdgFontStyleEh.Bold in Font.Style;
  PdfFontDef.IsItalic := TPdgFontStyleEh.Italic in Font.Style;
  PdfFontDef.FontKeyName := Font.FontKeyName;
  Result := TPdfDocumentEh(TPdfPageEh(FOwnerPage).Document).GetFontByKey(PdfFontDef);

  TPdfPageEh(FOwnerPage).AddUsedFont(Result);
end;

function TPdgGraphicsEh.GetDataStream: TPdfAsciiStreamEh;
begin
  Result := TPdfPageEh(FOwnerPage).Content.BoundStream;
end;

function TPdgGraphicsEh.GetStringCharWidths(const Text: string): TDoubleDynArray;
var
  I: Integer;
  PdfFont: TPdfType0FontEh;
  GlyphWidth: Integer;
  FontFileGlyphIndex: Word;
  WideText: WideString;
begin
  PdfFont := GetCurrentPdfFont;

  WideText := WideString(Text);
  SetLength(Result, Length(WideText));

  for I := 1 to Length(WideText) do
  begin
    FontFileGlyphIndex := PdfFont.OpenTypeFontData.GlyphIndexByCharCode(WideText[I]);
    GlyphWidth := PdfFont.OpenTypeFontData.GlyphWidthByGlyphIndex(FontFileGlyphIndex, False);
    Result[I - 1] := GlyphWidth / PdfFont.UnitsPerEm * Font.Size;
  end;
end;

function TPdgGraphicsEh.TextExtent(const Text: string): TSizeF;
var
  PdfFont: TPdfType0FontEh;
  I: Integer;
  GlyphWidth: Integer;
  TextWidth: Integer;
  FontFileGlyphIndex: Word;
  WideText: WideString;
begin
  PdfFont := GetCurrentPdfFont;

  Result.Height := PdfFont.OutlineTextmetric.otmTextMetrics.tmHeight / PdfFont.UnitsPerEm * Font.Size;

  TextWidth := 0;
  WideText := WideString(Text);
  for I := 1 to Length(WideText) do
  begin
    FontFileGlyphIndex := PdfFont.OpenTypeFontData.GlyphIndexByCharCode(WideText[I]);
    GlyphWidth := PdfFont.OpenTypeFontData.GlyphWidthByGlyphIndex(FontFileGlyphIndex, False);
    TextWidth := TextWidth + GlyphWidth;
  end;

  Result.Width := TextWidth / PdfFont.UnitsPerEm * Font.Size;
end;

function TPdgGraphicsEh.CalcTextSize(const AText: String; InitRectWidth: Double; WordWrap: Boolean): TSizeF;
var
  PdfFont: TPdfType0FontEh;
  TextSize: TSizeF;
  WrappedLinesInfo: TWrappedLinesInfo;
  I: Integer;
  StringCharWidths: TDoubleDynArray;
  LineHeight: Double;
  ATextRect: TRectF;
begin
  if (WordWrap) then
  begin
    ATextRect := RectF(0, 0, InitRectWidth, 0);
    PdfFont := GetCurrentPdfFont;
    LineHeight := PdfFont.OutlineTextmetric.otmTextMetrics.tmHeight / PdfFont.UnitsPerEm * Font.Size;

    StringCharWidths := GetStringCharWidths(AText);
    WrappedLinesInfo := CalcWrap(RectFWidth(ATextRect), AText, True, TextSize, StringCharWidths, LineHeight);

    Result.cy := Length(WrappedLinesInfo) * LineHeight;
    Result.cx := InitRectWidth;

    for I := 0 to Length(WrappedLinesInfo) - 1 do
    begin
      if (WrappedLinesInfo[i].pwi > Result.Width) then
        Result.Width := WrappedLinesInfo[i].pwi;
    end;
  end else
  begin
    Result := TextExtent(AText);
  end;
end;

procedure TPdgGraphicsEh.DrawGraphic(Graphic: TGraphic; ARect: TRectF);
var
  Document: TPdfDocumentEh;
  Image: TPdfImageEh;
  Pos: TPointF;
begin
  Document := TPdfDocumentEh(TPdfPageEh(FOwnerPage).Document);
  Image := Document.GetPdfImageByGraphic(Graphic);
  TPdfPageEh(FOwnerPage).EnsureImageRef(Image);

  Pos := FixPageCoord(ARect.TopLeft);
  Pos.Y := Pos.Y - RectFHeight(ARect);

  DataStream.WriteStr('q ');
  DataStream.WriteStr(FloatToSysStr(RectFWidth(ARect)) + ' 0 0 ' + FloatToSysStr(RectFHeight(ARect)) + ' ' +
                      FloatToSysStr(Pos.X) + ' ' +  FloatToSysStr(Pos.Y));
  DataStream.WriteStr(' cm ' + '/' + Image.ImageCode + ' Do');

  DataStream.WriteStr(' Q');
  DataStream.WriteLineFeed;
end;

procedure TPdgGraphicsEh.DrawGraphic(Graphic: TGraphic; X, Y: Single);
var
  ARect: TRectF;
begin
  ARect := RectF(X, Y, X + Graphic.Width, Y + Graphic.Height);
  DrawGraphic(Graphic, ARect);
end;

procedure TPdgGraphicsEh.DrawLine(X1, Y1, X2, Y2: Single);
var
  Pos1: TPointF;
  Pos2: TPointF;
begin
  Pos1 := FixPageCoord(PointF(X1, Y1));
  Pos2 := FixPageCoord(PointF(X2, Y2));
  DataStream.WriteLineStr(FloatToSysStr(Pos1.X) + ' ' + FloatToSysStr(Pos1.Y) + ' m');
  DataStream.WriteLineStr(FloatToSysStr(Pos2.X) + ' ' + FloatToSysStr(Pos2.Y) + ' l');
  DataStream.WriteLineStr('S');
end;

procedure TPdgGraphicsEh.WriteFillColor;
var
  rs, gs, bs: Single;
  r, g, b: Byte;
begin
  GetRGB(ColorToRGB(Brush.Color), r, g, b);
  rs := r / 255;
  gs := g / 255;
  bs := b / 255;

  DataStream.WriteLineStr(FloatToSysStr(rs) + ' ' + FloatToSysStr(gs) + ' ' + FloatToSysStr(bs) + ' rg');
end;

procedure TPdgGraphicsEh.FillRect(ARect: TRectF);
var
  Pos: TPointF;
  Size: TSizeF;
begin
  Pos := FixPageCoord(PointF(ARect.Left, ARect.Bottom));
  Size.cx := RectFWidth(ARect);
  Size.cy := RectFHeight(ARect);

  WriteFillColor;
  DataStream.WriteLineStr(FloatToSysStr(Pos.X) + ' ' + FloatToSysStr(Pos.Y) + ' ' +
                          FloatToSysStr(Size.Width) + ' ' + FloatToSysStr(Size.Height) + ' re');
  DataStream.WriteLineStr('F');

end;

procedure TPdgGraphicsEh.InternalDrawStringLine(AText: String; PosX, PosY: Double);
var
  Pos1: TPointF;
  PdfFont: TPdfType0FontEh;
  HexString: String;
  GlyphIndexes: TWordDynArray;
  BaseFontAscent: Longint;
  TextAscent: Double;
  UnderlineShift: Double;
  UnderlinePos: Double;
  UnderlineSize: Double;
  UnderlineRect: TRectF;
  TextSize: TSizeF;
  StrikeoutShift: Double;
  StrikeoutPos: Double;
  StrikeoutSize: Double;
  StrikeoutRect: TRectF;
begin
  Pos1.X := PosX;
  Pos1.Y := PosY;
  Pos1 := FixPageCoord(Pos1);

  PdfFont := GetCurrentPdfFont;
  GlyphIndexes := PdfFont.AddUsedCharsGetGlyphIndexes(AText);
  HexString := WordsToPdfHexString(GlyphIndexes);

  DataStream.WriteLineStr('BT');

  BaseFontAscent := PdfFont.OutlineTextmetric.otmTextMetrics.tmAscent;
  TextAscent := BaseFontAscent / PdfFont.UnitsPerEm * Font.Size;
  Pos1.Y := Pos1.Y - TextAscent;

  WriteFillColor;
  DataStream.WriteLineStr(FloatToSysStr(Pos1.X) + ' ' + FloatToSysStr(Pos1.Y) + ' Td');
  DataStream.WriteLineStr('<' + HexString + '> Tj');
  DataStream.WriteLineStr('ET');

  if (TPdgFontStyleEh.Underline in Font.Style) or (TPdgFontStyleEh.Strikeout in Font.Style) then
  begin
    TextSize := TextExtent(AText);

    if (TPdgFontStyleEh.Underline in Font.Style) then
    begin
      UnderlineShift := PdfFont.UnderlineShift / PdfFont.UnitsPerEm * Font.Size;
      UnderlinePos := PosY + TextAscent - UnderlineShift;
      UnderlineSize := PdfFont.UnderlineSize / PdfFont.UnitsPerEm * Font.Size;
      UnderlineRect := RectF(PosX, UnderlinePos, PosX + TextSize.Width, UnderlinePos + UnderlineSize);
      FillRect(UnderlineRect);
    end;

    if (TPdgFontStyleEh.Strikeout in Font.Style) then
    begin
      StrikeoutShift := PdfFont.StrikeoutShift / PdfFont.UnitsPerEm * Font.Size;
      StrikeoutPos := PosY + TextAscent - StrikeoutShift;
      StrikeoutSize := PdfFont.StrikeoutSize / PdfFont.UnitsPerEm * Font.Size;
      StrikeoutRect := RectF(PosX, StrikeoutPos, PosX + TextSize.Width, StrikeoutPos + StrikeoutSize);
      FillRect(StrikeoutRect);
    end;
  end;
end;

procedure TPdgGraphicsEh.DrawText(AText: String; ATextRect: TRectF; var Options: TDrawTextOptionsEh);
var
  PdfFont: TPdfType0FontEh;
  TextSize: TSizeF;
  DrawStringLines: array of TDrawStringLineInfo;
  WrappedLinesInfo: TWrappedLinesInfo;
  PosY: Double;
  I: Integer;
  StringCharWidths: TDoubleDynArray;
  LineHeight: Double;
  TextPos: TPointF;
  FinalTextPos: TPointF;
begin
  IntersectClipRect(ATextRect);

  if (Options.WrapStyle = TTextWrapStyleEh.twsWordWrapEh) then
  begin
    PdfFont := GetCurrentPdfFont;
    LineHeight := PdfFont.OutlineTextmetric.otmTextMetrics.tmHeight / PdfFont.UnitsPerEm * Font.Size;

    StringCharWidths := GetStringCharWidths(AText);
    WrappedLinesInfo := CalcWrap(RectFWidth(ATextRect), AText, True, TextSize, StringCharWidths, LineHeight);

    SetLength(DrawStringLines, Length(WrappedLinesInfo));

    for I := 0 to Length(WrappedLinesInfo) - 1 do
    begin
      DrawStringLines[I].Text := Copy(AText, WrappedLinesInfo[I].st + 1, WrappedLinesInfo[I].le);
      DrawStringLines[I].PosX := ATextRect.Left;
      DrawStringLines[I].PosY := ATextRect.Top + LineHeight * I;
      DrawStringLines[I].RectWidth := RectFWidth(ATextRect);
      DrawStringLines[I].Alignment := Options.HorzAlignment;
    end;
  end else
  begin
    SetLength(DrawStringLines, 1);
    TextSize := TextExtent(AText);

    if (Options.VertAlignment = taAlignBottom) then
      PosY := ATextRect.Bottom - TextSize.Height
    else if (Options.VertAlignment = taVerticalCenter) then
      PosY := ATextRect.Top + (RectFHeight(ATextRect) - TextSize.Height) / 2
    else
      PosY := ATextRect.Top;

    DrawStringLines[0].Text := AText;
    DrawStringLines[0].PosX := ATextRect.Left;
    DrawStringLines[0].PosY := PosY;
    DrawStringLines[0].RectWidth := RectFWidth(ATextRect);
    DrawStringLines[0].Alignment := Options.HorzAlignment;
  end;

  PdfFont := GetCurrentPdfFont;
  DataStream.WriteLineStr('/' + PdfFont.FontCode + ' ' + FloatToSysStr(Font.Size) + ' Tf');

  for I := 0 to Length(DrawStringLines) - 1 do
  begin
    TextPos := PointF(DrawStringLines[I].PosX, DrawStringLines[I].PosY);

    if (Options.HorzAlignment = taRightJustify) then
      TextPos.X := TextPos.X + DrawStringLines[I].RectWidth - TextSize.Width
    else if (Options.HorzAlignment = taCenter) then
      TextPos.X := TextPos.X + (DrawStringLines[I].RectWidth - TextSize.Width) / 2;

    FinalTextPos := TextPos;

    InternalDrawStringLine(DrawStringLines[I].Text, FinalTextPos.X, FinalTextPos.Y);
  end;

  RestoreClip;
end;

procedure TPdgGraphicsEh.DrawText(AText: String; ATextRect: TRectF;
  var Options: TDrawTextOptionsEh; AClipRect: TRectF);
begin
  IntersectClipRect(ATextRect);
  DrawText(AText, ATextRect, Options);
  RestoreClip;
end;

procedure TPdgGraphicsEh.DrawString(S: String; APos: TPointF);
var
  PdfFont: TPdfType0FontEh;
begin
  PdfFont := GetCurrentPdfFont;
  DataStream.WriteLineStr('/' + PdfFont.FontCode + ' ' + FloatToSysStr(Font.Size) + ' Tf');

  InternalDrawStringLine(S, APos.X, APos.Y);
end;

procedure TPdgGraphicsEh.DrawString(AText: String; ATextRect: TRectF;
  Alignment: TAlignment; VertAlignment: TVerticalAlignment; WordWrap: Boolean);
var
  DrawOptions: TDrawTextOptionsEh;
begin
  DrawOptions.Clear;
  DrawOptions.HorzAlignment := Alignment;
  DrawOptions.VertAlignment := VertAlignment;
  if (WordWrap)
    then DrawOptions.WrapStyle := twsWordWrapEh
    else DrawOptions.WrapStyle := twsNoWrapEh;
  DrawText(AText, ATextRect, DrawOptions);
end;

procedure TPdgGraphicsEh.IntersectClipRect(AClipRect: TRectF);
var
  Pos1: TPointF;
begin
  Pos1 := FixPageCoord(PointF(AClipRect.Left, AClipRect.Bottom));
  DataStream.WriteLineStr('q'); // Save graphics state
  DataStream.WriteLineStr(FloatToSysStr(Pos1.X) + ' ' + FloatToSysStr(Pos1.Y) + ' ' +
                          FloatToSysStr(RectFWidth(AClipRect)) + ' ' + FloatToSysStr(RectFHeight(AClipRect)) + ' ' +
                          're'); //Append rectangle to path
  DataStream.WriteLineStr('W n'); //Set clippng path and end path without fill or stroke.
end;

procedure TPdgGraphicsEh.RestoreClip;
begin
  DataStream.WriteLineStr('Q'); // Restore graphics state
end;

function TPdgGraphicsEh.FixPageCoord(Coord: TPointF): TPointF;
begin
  Result.X := Coord.X;
  Result.Y := TPdfPageEh(FOwnerPage).Size.Height - Coord.Y;
end;

function TPdgGraphicsEh.GetRotationDegree: Single;
begin
  Result := FRotationDegree;
end;

procedure TPdgGraphicsEh.SetRotationDegree(const Value: Single);
var
  eM11: Extended;
  eM12: Extended;
  eM21: Extended;
  eM22: Extended;
  eDx: Extended;
  eDy: Extended;
  C: Extended;
  S: Extended;
  Rads: Extended;
begin
  FRotationDegree := Value;

  if (Value = 0) then
  begin
    DataStream.WriteLineStr(' Q'); // Restore graphics state
    Exit;
  end;

  Rads := Math.DegToRad(Value {-90});
  C := Cos(Rads);
  S := Sin(Rads);
  eM11 := C;
  eM12 := S;
  eM21 := -S;
  eM22 := C;
  eDx := 0;
  eDy := 0;

  DataStream.WriteLineStr(' q'); // Save graphics state
  //0.7071 0.7071 -0.7071 0.7071 0 0 cm
  DataStream.WriteLineStr(FloatToSysStr(eM11) + ' ' + FloatToSysStr(eM12) + ' ' +
                          FloatToSysStr(eM21) + ' ' + FloatToSysStr(eM22) + ' ' +
                          FloatToSysStr(eDx) + ' ' + FloatToSysStr(eDy) + ' ' +
                          'cm'); //Modify the current transformation matrix (CTM)
end;

{ TXFont }

constructor TPdgFontEh.Create(AGraphics: TPdgGraphicsEh);
begin
  inherited Create;
  FGraphics := AGraphics;

  FName := String(DefFontData.Name);
  FSize := 8;
  UpdateFontKeyName();
end;

procedure TPdgFontEh.SetName(const Value: String);
begin
  if (FName <> Value) then
  begin
    FName := Value;
    UpdateFontKeyName();
  end;
end;

procedure TPdgFontEh.SetSize(const Value: Double);
begin
  FSize := Value;
end;

procedure TPdgFontEh.SetStyle(const Value: TPdgFontStylesEh);
begin
  if (FStyle <> Value) then
  begin
    FStyle := Value;
    UpdateFontKeyName();
  end;
end;

procedure TPdgFontEh.UpdateFontKeyName;
var
  I: Integer;
begin
  FFontKeyName := FName;

  for I := Length(FFontKeyName) downto 1 do
  begin
    if (FFontKeyName[i] <= ' ') or (FFontKeyName[i] >= #127) then
      Delete(FFontKeyName, I, 1); // Spaces and not ASCII chars
  end;

  if (TPdgFontStyleEh.Bold in Style) then
    FFontKeyName := FFontKeyName + ':Bold';
  if (TPdgFontStyleEh.Italic in Style) then
    FFontKeyName := FFontKeyName + ':Italic';
end;

{ TXStroke }

constructor TPdgStrokeEh.Create(AGraphics: TPdgGraphicsEh);
begin
  inherited Create;
  FGraphics := AGraphics;

  FKind := TPdgStrokeKindEh.Solid;
  FColor := clBlack;
  FOpacity := 1;
  FWidth := 1;
end;

function TPdgStrokeEh.GetDataStream: TPdfAsciiStreamEh;
begin
  Result := FGraphics.DataStream;
end;

procedure TPdgStrokeEh.SetColor(const Value: TColor);
begin
  if (FColor <> Value) then
  begin
    FColor := Value;
    WriteColorToStream;
  end;
end;

procedure TPdgStrokeEh.SetKind(const Value: TPdgStrokeKindEh);
begin
  FKind := Value;
end;

procedure TPdgStrokeEh.SetOpacity(const Value: Single);
begin
  FOpacity := Value;
end;

procedure TPdgStrokeEh.SetWidth(const Value: Single);
begin
  if (FWidth <> Value) then
  begin
    FWidth := Value;
    WriteWidthToStream;
  end;
end;

procedure TPdgStrokeEh.WriteWidthToStream;
begin
  DataStream.WriteLineStr(FloatToSysStr(Width) + ' w');
end;

procedure TPdgStrokeEh.WriteColorToStream;
var
  r1, b1, g1: Extended;
  r, g, b: Byte;
begin
  GetRGB(Color, r, g, b);
  r1 := RoundTo(r / 256, -4);
  g1 := RoundTo(g / 256, -4);
  b1 := RoundTo(b / 256, -4);

  DataStream.WriteLineStr(FloatToSysStr(r1) + ' ' +
                          FloatToSysStr(g1) + ' ' +
                          FloatToSysStr(b1) + ' ' +
                          'RG');
end;

{ TPdgBrushEh }

constructor TPdgBrushEh.Create(AGraphics: TPdgGraphicsEh);
begin
  inherited Create;
  FGraphics := AGraphics;

  FColor := clWhite;
  FOpacity := 1;
end;

procedure TPdgBrushEh.SetColor(const Value: TColor);
begin
  FColor := Value;
end;

procedure TPdgBrushEh.SetOpacity(const Value: Single);
begin
  FOpacity := Value;
end;

end.
