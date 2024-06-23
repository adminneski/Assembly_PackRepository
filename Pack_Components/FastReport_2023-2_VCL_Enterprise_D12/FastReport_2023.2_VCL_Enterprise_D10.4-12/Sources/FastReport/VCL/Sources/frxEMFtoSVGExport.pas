
{******************************************}
{                                          }
{             FastReport VCL               }
{            EMF to SVG Export             }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxEMFtoSVGExport;

interface

{$I frx.inc}

uses
  Windows, Graphics, Classes,
  frxClass, frxExportHelpers, frxEMFAbstractExport, frxEMFFormat, frxUtils,
  frxAnaliticGeometry, frCSSStyle;

type
  TSVGDeviceContext = class (TDeviceContext)
  protected
    FLastClipPathName: string;
    FLastPatternName: string;
  public
    procedure CopyFrom(ADC: TObject); override;
    procedure Init; override;
  end;

  TEMFtoSVGExport = class (TEMFAbstractExport)
  private
    FCSS: TfrxCSSList;
    FPath: string;
    FEmbedded: Boolean;
    FX, FY: Extended;
    FForceMitterLineJoin: Boolean;
    FLinearBarcode: Boolean;

    procedure NextClipPath;
    procedure NextPattern;

    function MeasureUnit(r: Extended; DefaultUnits: string = ''): string;
    function MU(r: Extended): string;

    function MeasureAngleArc(Center: TPoint; Radius: Integer; StartAngle, SweepAngle: Single): string;
    function MeasureArc(LR: TRect; LStart, LEnd: TPoint; NeedClosePath: Boolean = False): string;
    function MeasureClipPath: string;
    function MeasureDominantBaseline: string;
    function MeasureDx(OutputDx: TLongWordDinArray; OutputString: WideString): string;
    function MeasureDy(OutputDy: TLongWordDinArray; OutputString: WideString): string;
    function MeasureEllipse(LR: TRect): string;
    function MeasureEndCap: string;
    function MeasureFill(Options: byte): string;
    function MeasureFontStyle: string;
    function MeasureFontSize: string;
    function MeasureFontOrientation(LP: TPoint): string; overload;
    function MeasureFontOrientation(LP: TDoublePoint): string; overload;
    function MeasureLine: string;
    function MeasureLineJoin: string;
    function MeasurePenWidth: string;
    function MeasurePie(LR: TRect; LStart, LEnd: TPoint): string;
    function MeasurePoint(LP: TfrxPoint; dX: Extended = 0): string; overload;
    function MeasurePoint(LP: TDoublePoint; dX: Extended = 0): string; overload;
    function MeasurePoint(LP: TPoint; dX: Extended = 0): string; overload;
    function MeasurePoint(LP: TSmallPoint; dX: Extended = 0): string; overload;
    function MeasurePolyPoints: string; overload;
    function MeasurePoly16Points: string; overload;
    function MeasurePolyPoints(var MovToPos: String): string; overload;
    function MeasurePoly16Points(var MovToPos: String): string; overload;
    function MeasurePolyFillMode: string;
    function MeasureStroke(Options: byte): string;
    function MeasureStrokeMiterLimit: string;
    function MeasureStrokeDasharray: string;
    function MeasureTextAnchor: string;
    function MeasureTextDecoration: string;
//    function MeasureTextLength: string;
    function MeasureRect(LR: TRect; dHeight: Double = 0.0): string; overload;
    function MeasureRect(x, y, cx, cy: Integer): string; overload;
    function MeasureRectAsPath(LR: TRect): string;
    function MeasureRoundRect(LR: TRect; LS: TSize): string; overload;
    function MeasureXY(LP: TDoublePoint): string;
    function MeasureXYText(LP: TDoublePoint): string; overload;
    function MeasureXYText(LP: TPoint): string; overload;
    function MeasureXYText(X, Y: Double): string; overload;
    function SpaceDlm(st: string): string;

    procedure Puts(const s: WideString); overload;
    procedure Puts(const Fmt: WideString; const Args: array of const); overload;
    procedure PutsA(const s: AnsiString);
    procedure PutsRaw(const s: AnsiString);

    function CSSPaintStyleName(Options: byte): string;

    procedure Do_BitMap(DestRect: string; dwRop: LongWord; EMRBitmap: TEMRBitmap);
    procedure Do_Pattern(XLine, YLine, Turn: Boolean);
    procedure Do_PolyPoly(Name: string; Options: byte);
    procedure Do_PolyPoly16(Name: string; Options: byte);
  protected
    procedure Comment(CommentString: string = ''); override;
    function NormalizeRect(frxRect: TfrxRect): TfrxRect; overload;
    function NormalizeRect(const Rect: TRect): TRect; overload;
    procedure DCCreate; override;
    function FontCreate: TEMFFont; override;
    function SVGDeviceContext: TSVGDeviceContext;
    function IsNonZero(A: TIntegerDinArray): Boolean;
    function SureFirstM(Path: string): string;

    procedure DoEMR_AbortPath; override;
    procedure DoEMR_AlphaBlend; override;
    procedure DoEMR_AngleArc; override;
    procedure DoEMR_Arc; override;
    procedure DoEMR_ArcTo; override;
    procedure DoEMR_BeginPath; override;
    procedure DoEMR_BitBlt; override;
    procedure DoEMR_Chord; override;
    procedure DoEMR_CloseFigure; override;
    procedure DoEMR_Ellipse; override;
    procedure DoEMR_EoF; override;
    procedure DoEMR_ExtSelectClipRgn; override;
    procedure DoEMR_ExtTextOutA; override;
    procedure DoEMR_ExtTextOutW; override;
    procedure DoEMR_FillPath; override;
    procedure DoEMR_FillRgn; override;
    procedure DoEMR_FlattenPath; override;
    procedure DoEMR_FrameRgn; override;
    procedure DoEMR_Header; override;
    procedure DoEMR_IntersectClipRect; override;
    procedure DoEMR_LineTo; override;
    procedure DoEMR_MaskBlt; override;
    procedure DoEMR_MoveToEx; override;
    procedure DoEMR_PaintRgn; override;
    procedure DoEMR_Pie; override;
    procedure DoEMR_PLGBlt; override;
    procedure DoEMR_PolyBezier; override;
    procedure DoEMR_PolyBezier16; override;
    procedure DoEMR_PolyBezierTo; override;
    procedure DoEMR_PolyBezierTo16; override;
    procedure DoEMR_PolyDraw; override;
    procedure DoEMR_PolyDraw16; override;
    procedure DoEMR_Polygon; override;
    procedure DoEMR_Polygon16; override;
    procedure DoEMR_Polyline; override;
    procedure DoEMR_Polyline16; override;
    procedure DoEMR_PolylineTo; override;
    procedure DoEMR_PolylineTo16; override;
    procedure DoEMR_PolyPolygon; override;
    procedure DoEMR_PolyPolygon16; override;
    procedure DoEMR_PolyPolyline; override;
    procedure DoEMR_PolyPolyline16; override;
    procedure DoEMR_PolyTextOutA; override;
    procedure DoEMR_PolyTextOutW; override;
    procedure DoEMR_Rectangle; override;
    procedure DoEMR_RoundRect; override;
    procedure DoEMR_SelectClipPath; override;
    procedure DoEMR_SetDIBitsToDevice; override;
    procedure DoEMR_SetMetaRgn; override;
    procedure DoEMR_SetPixelV; override;
    procedure DoEMR_SmallTextOut; override;
    procedure DoEMR_StretchBlt; override;
    procedure DoEMR_StretchDIBits; override;
    procedure DoEMR_StrokeAndFillPath; override;
    procedure DoEMR_StrokePath; override;
    procedure DoEMR_TransparentBlt; override;
    procedure DoEMR_WidenPath; override;

    procedure DoStart; override;
    procedure DoFinish; override;
  public
    procedure AfterConstruction; override;
    procedure SetEmbedded(CSS: TfrxCSSList; Obj: TfrxView);

    property ForceMitterLineJoin: Boolean write FForceMitterLineJoin;
    property LinearBarcode: Boolean write FLinearBarcode;
  end;

implementation

uses
  frUtils,
  SysUtils, Contnrs, Math;

const
  Accuracy = 3;
  xCorrection = 1e-3;
  CanvasToSVGFactor = 0.61; // Empiric

// Paint Style Options
  psFill =   $1;
  psStroke = $2;
  psText =   $4;
  psBG =     $8;

{ Utility routines }

procedure Swap(var E1, E2: Extended);
var
  Temp: Extended;
begin
  Temp := E1;
  E1 := E2;
  E2 := Temp;
end;

function PointProduct(P, Factor: TfrxPoint): TfrxPoint; overload;
begin
  Result := frxPoint(P.X * Factor.X, P.Y * Factor.Y);
end;

function PointProduct(P: TPoint; Factor: TfrxPoint): TfrxPoint; overload;
begin
  Result := frxPoint(P.X * Factor.X, P.Y * Factor.Y);
end;

{ TEMFtoSVGExport }

procedure TEMFtoSVGExport.AfterConstruction;
begin
  FPath := '';
  FEmbedded := False;
  FForceMitterLineJoin := False;
  FLinearBarcode := False;
end;

procedure TEMFtoSVGExport.Comment(CommentString: string = '');
begin
  if CommentString = '' then
    if ShowComments then
      CommentString := Parsing
    else
      Exit;
  Puts('<!-- ' + StrFindAndReplace(CommentString, ':', []) + ' -->');
end;

function TEMFtoSVGExport.CSSPaintStyleName(Options: byte): string;
var
  StyleFill, StyleStroke: string;
begin
  StyleFill := MeasureFill(Options);
  StyleStroke := MeasureStroke(Options);
  with TfrxCSSStyle.Create do
  begin
    Style['fill'] := StyleFill;
    if StyleFill <> 'none' then
      Style['fill-rule'] := MeasurePolyFillMode;

    Style['stroke'] := StyleStroke;
    if StyleStroke <> 'none' then
    begin
      Style['stroke-width'] := MeasurePenWidth;
      Style['stroke-linecap'] := MeasureEndCap;
      Style['stroke-linejoin'] := MeasureLineJoin;
      Style['stroke-miterlimit'] := MeasureStrokeMiterLimit;
      Style['stroke-dasharray'] := MeasureStrokeDasharray;
    end;

    if Options and psText = psText then
    begin
      Style['text-anchor'] := MeasureTextAnchor;
      Style['dominant-baseline'] := MeasureDominantBaseline;
      Style['font-family'] := FDC.FontFamily;
      Style['font-size'] := MeasureFontSize;
      Style['font-weight'] := IntToStr(FDC.FontWeight);
      Style['font-style'] := MeasureFontStyle;
      Style['text-decoration'] := MeasureTextDecoration;
    end;

    with SVGDeviceContext do
      if FLastClipPathName <> '' then
        Style['clip-path'] := Format('url(#%s)', [FLastClipPathName]);

    Result := FCSS.AddStyle(This);
  end;
end;

procedure TEMFtoSVGExport.DCCreate;
begin
  FDC := TSVGDeviceContext.Create;
end;

procedure TEMFtoSVGExport.Do_BitMap(DestRect: string; dwRop: LongWord; EMRBitmap: TEMRBitmap);
var
  Pic: TGraphic;
  ClipPath: string;
begin
  case dwRop of // https://msdn.microsoft.com/en-us/library/cc250408.aspx
    PATCOPY {P}:
      begin
        Puts('<rect class="%s" %s/>',
          [CSSPaintStyleName(psFill), DestRect]);
      end;
    SRCCOPY {S}, SRCPAINT {DSo}, SRCAND {DSa}, SRCINVERT {DSx}, $1FF0000:
      begin
        ClipPath := '';
        with SVGDeviceContext do
          if FLastClipPathName <> '' then
            ClipPath := Format('clip-path="url(#%s)"', [FLastClipPathName]);

        PutsRaw(AnsiString(Format('<image %s %s preserveAspectRatio="none" xlink:href="',
          [DestRect, ClipPath])));

        if dwRop = $1FF0000 then
          Pic := TEMRAlphaBlendObj(EMRBitmap).GetARGBGraphic
        else
        begin
          Pic := EMRBitmap.GetBitmap;
//          if EMRBitmap is TEMRStretchDIBitsObj then // https://stackoverflow.com/questions/8346115/why-are-bmps-stored-upside-down
//            TEMRStretchDIBitsObj(EMRBitmap).FlipVertical(TBitmap(Pic));
        end;

        PutsRaw(AnsiString(Format('data:%s;base64,', [GetPicInfo(Pic).Mimetype])));
        PutsRaw(GraphicToBase64AnsiString(Pic));
        Pic.Free;

        Puts('"/>');
      end;
    $AA0029: {D}
      begin
        // Do nothing
      end;
  else
    Comment(' Unsupported dwRop: ' + IntToStr(dwRop));
  end;
end;

procedure TEMFtoSVGExport.Do_Pattern(XLine, YLine, Turn: Boolean);
begin
  NextPattern;
  Puts(SVGPattern(Formatted, XLine, YLine, Turn, FDC.BrushColor,
                  1.4, SVGDeviceContext.FLastPatternName));
end;

procedure TEMFtoSVGExport.Do_PolyPoly(Name: string; Options: byte);
var
  Poly, Point: integer;
  PartialPath: string;
begin
  PartialPath := '';
  with FEMRList.Last as TEMRPolyPolygonObj do
    for Poly := 0 to P^.PolyPolygon.nPolys - 1 do
    begin
      PartialPath := PartialPath + SpaceDlm(PartialPath) + 'M';
      for Point := 0 to P^.PolyPolygon.aPolyCounts[Poly] - 1 do
        PartialPath := PartialPath + ' ' + MeasurePoint(PolyPoint[Poly, Point]);
      PartialPath := PartialPath + frIfStr(Name = 'polygon', ' Z');
    end;
  if FDC.IsPathBracketOpened then
    FPath := FPath + PartialPath
  else
    Puts('<path class="%s" d="%s"/>', [CSSPaintStyleName(Options), PartialPath]);
end;

procedure TEMFtoSVGExport.Do_PolyPoly16(Name: string; Options: byte);
var
  Poly, Point: integer;
  PartialPath: string;
begin
  PartialPath := '';
  with FEMRList.Last as TEMRPolyPolygon16Obj do
    for Poly := 0 to P^.PolyPolygon16.nPolys - 1 do
    begin
      PartialPath := PartialPath + SpaceDlm(PartialPath) + 'M';
      for Point := 0 to P^.PolyPolygon16.aPolyCounts[Poly] - 1 do
        PartialPath := PartialPath + ' ' + MeasurePoint(PolyPoint[Poly, Point]);
      PartialPath := PartialPath + frIfStr(Name = 'polygon', ' Z');
    end;
  if FDC.IsPathBracketOpened then
    FPath := FPath + PartialPath
  else
    Puts('<path class="%s" d="%s"/>', [CSSPaintStyleName(Options), PartialPath]);
end;

function TEMFtoSVGExport.FontCreate: TEMFFont;
begin
  Result := inherited FontCreate;

  Result.PreciseSize := LogToDevSize(FDC.FontSize);
  Result.Size := Round(Result.PreciseSize);
end;

function TEMFtoSVGExport.IsNonZero(A: TIntegerDinArray): Boolean;
var
  i: Integer;
begin
  Result := True;
  for i := 0 to High(A) do
    if A[i] <> 0 then
      Exit;
  Result := False;
end;

procedure TEMFtoSVGExport.DoEMR_AbortPath;
begin
  inherited;

  FPath := '';
end;

procedure TEMFtoSVGExport.DoEMR_AlphaBlend;
begin
  inherited;

  with PLast^.AlphaBlend do
    Do_BitMap(MeasureRect(xDest, yDest, cxDest, cyDest),
      dwRop, FEMRList.Last as TEMRAlphaBlendObj);
end;

procedure TEMFtoSVGExport.DoEMR_AngleArc;
begin
  inherited;

  with PLast^ do
    if not FDC.IsPathBracketOpened then
      with AngleArc do
        Puts('<path class="%s" %s/>',
          [CSSPaintStyleName(psStroke),
           MeasureAngleArc(ptlCenter, nRadius, eStartAngle, eSweepAngle)]);
end;

procedure TEMFtoSVGExport.DoEMR_Arc;
begin
  inherited DoEMR_Arc;

  with PLast^ do
    if not FDC.IsPathBracketOpened then
      with Arc do
        Puts('<path class="%s" %s/>',
          [CSSPaintStyleName(psFill + psStroke),
           MeasureArc(rclBox, ptlStart, ptlEnd)]);
end;

procedure TEMFtoSVGExport.DoEMR_ArcTo;
begin
  inherited;

  // http://www.w3.org/TR/SVG/paths.html#PathDataEllipticalArcCommands
end;

procedure TEMFtoSVGExport.DoEMR_BeginPath;
begin
  inherited;

  FPath := '';
end;

procedure TEMFtoSVGExport.DoEMR_BitBlt;
begin
  inherited;

  with PLast^.BitBlt do
    Do_BitMap(MeasureRect(xDest, yDest, cxDest, cyDest),
      dwRop, FEMRList.Last as TEMRBitBltObj);
end;

procedure TEMFtoSVGExport.DoEMR_Chord;
begin
  inherited;

  // http://www.w3.org/TR/SVG/paths.html#PathDataEllipticalArcCommands
end;

procedure TEMFtoSVGExport.DoEMR_CloseFigure;
begin
  inherited;

  FPath := FPath + ' Z ';
end;

procedure TEMFtoSVGExport.DoEMR_Ellipse;
begin
  inherited;

  with PLast^ do
    if not FDC.IsPathBracketOpened then
      Puts('<ellipse class="%s" %s/>',
        [CSSPaintStyleName(psFill + psStroke), MeasureEllipse(Ellipse.rclBox)]);
end;

procedure TEMFtoSVGExport.DoEMR_EoF;
begin
  inherited;

  if (FOutStream <> nil) and not FEmbedded then
  begin
    Puts('<style type="text/css"><![CDATA[');
    FCSS.Save(FOutStream, Formatted);
    Puts(']]></style>');
  end;

  Puts('</svg>');
end;

procedure TEMFtoSVGExport.DoEMR_ExtSelectClipRgn;
begin
  inherited;

  if MeasureClipPath = '' then
    SVGDeviceContext.FLastClipPathName := ''
  else
  begin
    NextClipPath;
    Puts('<defs><clipPath id="%s">', [SVGDeviceContext.FLastClipPathName]);
      Puts('<path d="%s"/>', [MeasureClipPath]);
    Puts('</clipPath></defs>');
  end;
end;

procedure TEMFtoSVGExport.DoEMR_ExtTextOutA;
var
  ETO: TEMRExtTextOutAObj;
  OutputString: WideString;
  Reference: TDoublePoint;
  BGName, Filter: string;
begin
  inherited DoEMR_ExtTextOutA;
  ETO := FEMRList.Last as TEMRExtTextOutAObj;
  OutputString := WideString(ETO.OutputString);

  with PLast^.ExtTextOutA do
    if ETO.IsOption(ETO_OPAQUE) then
      Puts('<rect class="%s" %s/>',
        [CSSPaintStyleName(psBG), MeasureRect(emrtext.rcl)]);

  if FDC.BkMode = OPAQUE then
  begin
    BGName := SVGUniqueID;
    Puts('<defs>');
      Puts('<filter x="0" y="0" width="1" height="1" id="%s">', [BGName]);
        Puts('<feFlood flood-color="%s"/>', [GetColor(FDC.BkColor)]);
        Puts('<feComposite in="SourceGraphic"/>');
      Puts('</filter>');
    Puts('</defs>');
    Filter := Format('filter="url(#%s)" ', [BGName]);
  end
  else
    Filter := '';

  if OutputString = '' then
    Exit;

  with PLast^.ExtTextOutA do
    Puts('<text class="%s" %s%s%s%s%s>',
      [CSSPaintStyleName(psText), Filter,
       MeasureXYText(Reference),
       MeasureFontOrientation(Reference),
       MeasureDx(ETO.OutputDx, OutputString),
       MeasureDy(ETO.OutputDy, OutputString)]);

  Puts(SVGStartSpace(SVGEscapeTextAndAttribute(OutputString)));
  Puts('</text>');
end;

procedure TEMFtoSVGExport.DoEMR_ExtTextOutW;
var
  ETO: TEMRExtTextOutWObj;
  OutputString: WideString;
  Reference: TDoublePoint;
  BGName, Filter: string;
  BoundsHeight, FontSize: Double;
begin
  inherited DoEMR_ExtTextOutW;
  ETO := FEMRList.Last as TEMRExtTextOutWObj;
  OutputString := ETO.OutputString(FDC.FontFamily);

  with PLast^.ExtTextOutW do
    if ETO.IsOption(ETO_OPAQUE) then
      Puts('<rect class="%s" %s/>',
        [CSSPaintStyleName(psBG), MeasureRect(emrtext.rcl)]);

  if FDC.BkMode = OPAQUE then
  begin
    BGName := SVGUniqueID;
    Puts('<defs>');
      Puts('<filter x="0" y="0" width="1" height="1" id="%s">', [BGName]);
        Puts('<feFlood flood-color="%s"/>', [GetColor(FDC.BkColor)]);
        Puts('<feComposite in="SourceGraphic"/>');
      Puts('</filter>');
    Puts('</defs>');
    Filter := Format('filter="url(#%s)" ', [BGName]);
  end
  else
    Filter := '';

  if OutputString = '' then
    Exit;

  Reference := DoublePoint(PLast^.ExtTextOutW.emrtext.ptlReference);

  if FDC.FontFamily = 'Cambria Math' then
  begin
    with PLast^.ExtTextOutW.rclBounds do
      BoundsHeight := Bottom - Top;
    FontSize := FDC.FontSize;
    Reference.Y := 3.8 * FontSize - 0.38 * BoundsHeight -0.000037 * FontSize * BoundsHeight;
  end;

  with PLast^.ExtTextOutW do
    Puts('<text class="%s" %s%s%s%s%s>',
      [CSSPaintStyleName(psText), Filter,
       MeasureXYText(Reference),
       MeasureFontOrientation(Reference),
       MeasureDx(ETO.OutputDx, OutputString),
       MeasureDy(ETO.OutputDy, OutputString)]);

  Puts(SVGStartSpace(SVGEscapeTextAndAttribute(OutputString)));
  Puts('</text>');
end;

procedure TEMFtoSVGExport.DoEMR_FillPath;
begin
  inherited;

  if FPath <> '' then
    Puts('<path class="%s" d="%s"/>', [CSSPaintStyleName(psFill), FPath]);
end;

procedure TEMFtoSVGExport.DoEMR_FillRgn;
const
  RectangleGap = 0.5;
var
  PRD: PRgnData;
  RectCount, i: Integer;
  R: TRect;
begin
  inherited DoEMR_FillRgn;

  PRD := @PLast^.FillRgn.RgnData;
  RectCount := PRD^.rdh.nCount;

  Puts('<g fill="%s">', [GetColor(BrushAverageColor(PLast^.FillRgn.ihBrush))]);
  for i := 0 to RectCount - 1 do
  begin
    Move(PRD^.Buffer[i * SizeOf(TRect)], R, SizeOf(TRect));
    Puts('<rect %s/>', [MeasureRect(R, RectangleGap)]);
  end;
  Puts('</g>');
end;

procedure TEMFtoSVGExport.DoEMR_FlattenPath;
begin
  inherited;

  // https://msdn.microsoft.com/en-us/library/cc230531.aspx
end;

procedure TEMFtoSVGExport.DoEMR_FrameRgn;
begin
  inherited;

  //  https://msdn.microsoft.com/en-us/library/cc230630.aspx
end;

procedure TEMFtoSVGExport.DoEMR_Header;
var
  Size: TfrxPoint;
  TopLeft: string;
begin
  inherited;

  if FEmbedded then
    TopLeft := Format('x="%s" y="%s"', [Float2Str(FX, Accuracy), Float2Str(FY, Accuracy)])
  else
    TopLeft := '';

  with PLast^.Header do
  begin
    if FMEP.IsExternal then
      Size := frxPoint(FMEP.Width, FMEP.Height)
    else
      Size := frxPoint(
        szlDevice.cx / szlMillimeters.cx * (rclFrame.Right - rclFrame.Left) / 100,
        szlDevice.cy / szlMillimeters.cy * (rclFrame.Bottom - rclFrame.Top) / 100);

    Puts('<svg %s width="%s" height="%s">',
      [TopLeft, Float2Str(Size.X, Accuracy), Float2Str(Size.Y, Accuracy)]);
  end;
end;

procedure TEMFtoSVGExport.DoEMR_IntersectClipRect;
begin
  inherited;

  NextClipPath;
  Puts('<defs><clipPath id="%s">', [SVGDeviceContext.FLastClipPathName]);
    Puts('<path d="M %s Z"/>', [MeasureRectAsPath(PLast^.IntersectClipRect.rclClip)]);
  Puts('</clipPath></defs>');
end;

procedure TEMFtoSVGExport.DoEMR_LineTo;
begin
  inherited;

  if FDC.IsPathBracketOpened then
    FPath := FPath + ' L ' + MeasurePoint(FDC.PositionNext)
  else
    Puts('<line class="%s" %s/>',
      [CSSPaintStyleName(psStroke), MeasureLine]);
end;

procedure TEMFtoSVGExport.DoEMR_MaskBlt;
begin
  inherited;

  with PLast^.MaskBlt do
    Do_BitMap(MeasureRect(xDest, yDest, cxDest, cyDest),
      dwRop, FEMRList.Last as TEMRMaskBltObj);
end;

procedure TEMFtoSVGExport.DoEMR_MoveToEx;
begin
  inherited;

  if FDC.IsPathBracketOpened then
    FPath := FPath + ' M ' + MeasurePoint(FDC.PositionNext);
end;

procedure TEMFtoSVGExport.DoEMR_PaintRgn;
begin
  inherited;

  // https://msdn.microsoft.com/en-us/library/cc230645.aspx
end;

procedure TEMFtoSVGExport.DoEMR_Pie;
begin
  inherited DoEMR_Pie;

  with PLast^ do
    if not FDC.IsPathBracketOpened then
      with Pie do
        Puts('<path class="%s" %s/>',
          [CSSPaintStyleName(psFill + psStroke),
           MeasurePie(rclBox, ptlStart, ptlEnd)]);
end;

procedure TEMFtoSVGExport.DoEMR_PLGBlt;
begin
  inherited;

  // https://msdn.microsoft.com/en-us/library/cc230648.aspx
end;

procedure TEMFtoSVGExport.DoEMR_PolyBezier;
var
  sMovPos, sPoints: String;
begin
  inherited;
  sMovPos := '';
  sPoints := MeasurePolyPoints(sMovPos);
  if FDC.IsPathBracketOpened then
    FPath := FPath + ' M ' + sMovPos + ' C ' + sPoints
  else
    Puts('<path class="%s" d="M %s C %s"/>',
      [CSSPaintStyleName(psStroke), sMovPos, sPoints]);
end;

procedure TEMFtoSVGExport.DoEMR_PolyBezier16;
var
  sMovPos, sPoints: String;
begin
  inherited;
  sMovPos := '';
  sPoints := MeasurePoly16Points(sMovPos);
  if FDC.IsPathBracketOpened then
    FPath := FPath + ' M ' + sMovPos + ' C ' + sPoints
  else
    Puts('<path class="%s" d="M %s C %s"/>',
      [CSSPaintStyleName(psStroke), sMovPos, sPoints]);
end;

procedure TEMFtoSVGExport.DoEMR_PolyBezierTo;
begin
  inherited;

  if FDC.IsPathBracketOpened then
    FPath := FPath + ' C ' + MeasurePolyPoints
  else
    Puts('<path class="%s" d="M %s C %s"/>', [CSSPaintStyleName(psStroke),
      MeasurePoint(FDC.PositionCurrent), MeasurePolyPoints]);
end;

procedure TEMFtoSVGExport.DoEMR_PolyBezierTo16;
begin
  inherited;

  if FDC.IsPathBracketOpened then
    FPath := FPath + ' C ' + MeasurePoly16Points
  else
    Puts('<path class="%s" d="M %s C %s"/>', [CSSPaintStyleName(psStroke),
      MeasurePoint(FDC.PositionCurrent), MeasurePoly16Points]);
end;

procedure TEMFtoSVGExport.DoEMR_PolyDraw;
var
  Point, T, BezierPointNumber: integer;
  D: string;
begin
  inherited;

  BezierPointNumber := 0;
  D := '';
  with FEMRList.Last as TEMRPolyDrawObj do
    for Point := 0 to Integer(P^.PolyDraw.cptl) - 1 do
    begin
      T := Types[Point];
      if IsInclude(T, PT_MOVETO) {PT_MOVETO - MUST be first test} then
        D := D + ' M '
      else if IsInclude(T, PT_LINETO) then
        D := D + ' L '
      else if IsInclude(T, PT_BEZIERTO) then
        if BezierPointNumber = 0 then
        begin
          D := D + ' C ';
          BezierPointNumber := 2;
        end
        else
        begin
          D := D + ' ';
          BezierPointNumber := BezierPointNumber - 1;
        end;
      D := D + MeasurePoint(P.PolyDraw.aptl[Point]);
      if IsInclude(T, PT_CLOSEFIGURE) then
        D := D + ' Z ';
    end;

  if FDC.IsPathBracketOpened then
    FPath := FPath + D
  else
    Puts('<path class="%s" d="%s"/>', [CSSPaintStyleName(psFill + psStroke), D]);
end;

procedure TEMFtoSVGExport.DoEMR_PolyDraw16;
var
  Point, T, BezierPointNumber: integer;
  D: string;
begin
  inherited;

  BezierPointNumber := 0;
  D := '';
  with FEMRList.Last as TEMRPolyDraw16Obj do
    for Point := 0 to Integer(P^.PolyDraw16.cpts) - 1 do
    begin
      T := Types[Point];
      if IsInclude(T, PT_MOVETO) {PT_MOVETO - MUST be first test} then
        D := D + ' M '
      else if IsInclude(T, PT_LINETO) then
        D := D + ' L '
      else if IsInclude(T, PT_BEZIERTO) then
        if BezierPointNumber = 0 then
        begin
          D := D + ' C ';
          BezierPointNumber := 2;
        end
        else
        begin
          D := D + ' ';
          BezierPointNumber := BezierPointNumber - 1;
        end;
      D := D + MeasurePoint(P.PolyDraw16.apts[Point]);
      if IsInclude(T, PT_CLOSEFIGURE) then
        D := D + ' Z ';
    end;

  if FDC.IsPathBracketOpened then
    FPath := FPath + D
  else
    Puts('<path class="%s" d="%s"/>', [CSSPaintStyleName(psFill + psStroke), D]);
end;

procedure TEMFtoSVGExport.DoEMR_Polygon;
begin
  inherited;

  if FDC.IsPathBracketOpened then
    FPath := FPath + Format(' M %s Z', [MeasurePolyPoints])
  else
    Puts('<polygon class="%s" points="%s"/>',
      [CSSPaintStyleName(psFill + psStroke), MeasurePolyPoints]);
end;

procedure TEMFtoSVGExport.DoEMR_Polygon16;
begin
  inherited;

  if FDC.IsPathBracketOpened then
    FPath := FPath + Format(' M %s Z', [MeasurePoly16Points])
  else
    Puts('<polygon class="%s" points="%s"/>',
      [CSSPaintStyleName(psFill + psStroke), MeasurePoly16Points]);
end;

procedure TEMFtoSVGExport.DoEMR_Polyline;
begin
  inherited;

  if FDC.IsPathBracketOpened then
    FPath := FPath + Format(' M %s', [MeasurePolyPoints])
  else
    Puts('<polyline class="%s" points="%s"/>',
      [CSSPaintStyleName(psStroke), MeasurePolyPoints]);
end;

procedure TEMFtoSVGExport.DoEMR_Polyline16;
begin
  inherited;

  if FDC.IsPathBracketOpened then
    FPath := FPath + Format(' M %s', [MeasurePoly16Points])
  else
    Puts('<polyline class="%s" points="%s"/>',
      [CSSPaintStyleName(psStroke), MeasurePoly16Points]);
end;

procedure TEMFtoSVGExport.DoEMR_PolylineTo;
begin
  inherited;

  if FDC.IsPathBracketOpened then
    FPath := FPath + ' L ' + MeasurePolyPoints
  else
    Puts('<path class="%s" d="M %s L %s"/>', [CSSPaintStyleName(psStroke),
      MeasurePoint(FDC.PositionCurrent), MeasurePolyPoints]);
end;

procedure TEMFtoSVGExport.DoEMR_PolylineTo16;
begin
  inherited;

  if FDC.IsPathBracketOpened then
    FPath := FPath + ' L ' + MeasurePoly16Points
  else
    Puts('<path class="%s" d="M %s L %s"/>', [CSSPaintStyleName(psStroke),
      MeasurePoint(FDC.PositionCurrent), MeasurePoly16Points]);
end;

procedure TEMFtoSVGExport.DoEMR_PolyPolygon;
begin
  inherited;
  Do_PolyPoly('polygon', psFill + psStroke);
end;

procedure TEMFtoSVGExport.DoEMR_PolyPolygon16;
begin
  inherited;
  Do_PolyPoly16('polygon', psFill + psStroke);
end;

procedure TEMFtoSVGExport.DoEMR_PolyPolyline;
begin
  inherited;
  Do_PolyPoly('polyline', psStroke);
end;

procedure TEMFtoSVGExport.DoEMR_PolyPolyline16;
begin
  inherited;
  Do_PolyPoly16('polyline', psStroke);
end;

procedure TEMFtoSVGExport.DoEMR_PolyTextOutA;
var
  i: integer;
  StyleName: string;
begin
  inherited;

  StyleName := CSSPaintStyleName(psText);
  for i := 0 to PLast^.PolyTextOutA.cStrings - 1 do
  begin
    with PLast^.PolyTextOutA.aemrtext[i] do
      Puts('<text class="%s" %s %s>',
        [StyleName, MeasureXYText(ptlReference), MeasureFontOrientation(ptlReference)]);

    with (FEMRList.Last as TEMRPolyTextOutAObj) do
      Puts(SVGStartSpace(SVGEscapeTextAndAttribute(WideString(OutputString[i]))));
    Puts('</text>');
  end;
end;

procedure TEMFtoSVGExport.DoEMR_PolyTextOutW;
var
  i: integer;
  StyleName: string;
begin
  inherited;

  StyleName := CSSPaintStyleName(psText);
  for i := 0 to PLast^.PolyTextOutW.cStrings - 1 do
  begin
    with PLast^.PolyTextOutW.aemrtext[i] do
      Puts('<text class="%s" %s %s>',
        [StyleName, MeasureXYText(ptlReference), MeasureFontOrientation(ptlReference)]);

    with (FEMRList.Last as TEMRPolyTextOutWObj) do
      Puts(SVGStartSpace(SVGEscapeTextAndAttribute(OutputString[i])));
    Puts('</text>');
  end;
end;

procedure TEMFtoSVGExport.DoEMR_Rectangle;
begin
  inherited;

  with PLast^ do
    if FDC.IsPathBracketOpened then
      FPath := FPath + ' L ' + MeasureRectAsPath(Rectangle.rclBox) + ' Z'
    else
      Puts('<rect class="%s" %s/>',
        [CSSPaintStyleName(psFill + psStroke), MeasureRect(Rectangle.rclBox)]);
end;

procedure TEMFtoSVGExport.DoEMR_RoundRect;
begin
  inherited;

  with PLast^ do
    if not FDC.IsPathBracketOpened then
      Puts('<rect class="%s" %s/>',
        [CSSPaintStyleName(psFill + psStroke),
         MeasureRoundRect(RoundRect.rclBox, RoundRect.szlCorner)]);
end;

procedure TEMFtoSVGExport.DoEMR_SelectClipPath;
begin
  inherited;

  case PLast^.SelectClipPath.iMode of
    RGN_AND,
    RGN_OR,
    RGN_XOR,
    RGN_DIFF, // EMR_SelectClipPath and RegionMode https://msdn.microsoft.com/en-us/library/cc230541.aspx
    RGN_COPY:
    if FPath <> '' then
    begin
      NextClipPath;
      Puts('<defs><clipPath id="%s">', [SVGDeviceContext.FLastClipPathName]);
        Puts('<path d="%s"/>', [SureFirstM(FPath)]);
      Puts('</clipPath></defs>');
    end;
  end;
end;

procedure TEMFtoSVGExport.DoEMR_SetDIBitsToDevice;
begin
  inherited;

  // https://msdn.microsoft.com/en-us/library/cc230685.aspx
end;

procedure TEMFtoSVGExport.DoEMR_SetMetaRgn;
begin
  inherited;

  SVGDeviceContext.FLastClipPathName := '';
end;

procedure TEMFtoSVGExport.DoEMR_SetPixelV;
begin
  inherited;

  with PLast^.SetPixelV do
    Puts('<rect fill="%s" %s/>', [GetColor(crColor),
      MeasureRect(ptlPixel.X, ptlPixel.Y, 1, 1)]);
end;

procedure TEMFtoSVGExport.DoEMR_SmallTextOut;
begin
  inherited;

  with PLast^.SmallTextOut do
    Puts('<text class="%s" %s %s>',
      [CSSPaintStyleName(psText), MeasureXYText(ptlReference), MeasureFontOrientation(ptlReference)]);

  with (FEMRList.Last as TEMRSmallTextOutObj) do
    Puts(SVGStartSpace(SVGEscapeTextAndAttribute(frIfStr(IsANSI, WideString(OutputStringANSI), OutputStringWide))));
  Puts('</text>');
end;

procedure TEMFtoSVGExport.DoEMR_StretchBlt;
begin
  inherited;

  with PLast^.StretchBlt do
    Do_BitMap(MeasureRect(xDest, yDest, cxDest, cyDest),
      dwRop, FEMRList.Last as TEMRStretchBltObj);
end;

procedure TEMFtoSVGExport.DoEMR_StretchDIBits;
begin
  inherited;

  with PLast^.StretchDIBits do
    Do_BitMap(MeasureRect(xDest, yDest, cxDest, cyDest),
      dwRop, FEMRList.Last as TEMRStretchDIBitsObj);
end;

procedure TEMFtoSVGExport.DoEMR_StrokeAndFillPath;
begin
  inherited;

  if FPath <> '' then
    Puts('<path class="%s" d="%s"/>', [CSSPaintStyleName(psFill + psStroke), FPath]);
end;

procedure TEMFtoSVGExport.DoEMR_StrokePath;
begin
  inherited;

  if FPath <> '' then
    Puts('<path class="%s" d="%s"/>', [CSSPaintStyleName(psStroke), FPath]);
end;

procedure TEMFtoSVGExport.DoEMR_TransparentBlt;
begin
  inherited;

  with PLast^.TransparentBlt do
    Do_BitMap(MeasureRect(xDest, yDest, cxDest, cyDest),
      dwRop, FEMRList.Last as TEMRBitBltObj);
end;

procedure TEMFtoSVGExport.DoEMR_WidenPath;
begin
  inherited;

  // https://msdn.microsoft.com/en-us/library/cc230531.aspx
end;

procedure TEMFtoSVGExport.DoFinish;
begin
  if not FEmbedded then
    FCSS.Free;
end;

procedure TEMFtoSVGExport.DoStart;
begin
  if not FEmbedded then
    FCSS := TfrxCSSList.Create;
end;

function TEMFtoSVGExport.MeasureAngleArc(Center: TPoint; Radius: Integer; StartAngle, SweepAngle: Single): string;
  function RotatedPoint(P: TfrxPoint; Angle: Single): TfrxPoint;
  var
    SinA, CosA: Extended;
  begin
    SinCos(Angle * Pi / 180, SinA, CosA);
    Result.X := CosA * (P.X - Center.X) + SinA * (P.Y - Center.Y) + Center.X;
    Result.Y := CosA * (P.Y - Center.Y) - SinA * (P.X - Center.X) + Center.Y;
  end;
const
  AxisRotation = '0';
var
  Source, Start, Finish: TfrxPoint;
  rRadius: Extended;
  LargeArc, Sweep: String;
begin
  Source := frxPoint(Center.X + Radius, Center.Y);
  Start := RotatedPoint(Source, StartAngle);
  Finish := RotatedPoint(Start, SweepAngle);

  rRadius := LogToDevSize(Radius);

  if Abs(SweepAngle) > 180 then LargeArc := '1'
  else                          LargeArc := '0';

  if SweepAngle < 0 then Sweep := '1'
  else                   Sweep := '0';


  Result := Format('d="M %s A %s,%s %s %s,%s %s"',
    [MeasurePoint(Start), MU(rRadius), MU(rRadius), AxisRotation, LargeArc, Sweep, MeasurePoint(Finish)]);
end;

function TEMFtoSVGExport.MeasureArc(LR: TRect; LStart, LEnd: TPoint; NeedClosePath: Boolean = False): string;
const
  AxisRotation = '0';
var
  AspectRatio: TfrxPoint;
  SqLR: TfrxRect;
  SqLStart, SqLEnd, SqEaStart, SqEaEnd, SqCenter: TfrxPoint;
  SqStartAngle, SqEndAngle, SqSweepAngle: Extended;

  Radius, Center, eaStart, eaEnd : TfrxPoint;
  LargeArc, Sweep, Close: String;
  SweepOne, LargeArcOne: Boolean;
begin
  AspectRatio := frxPoint(1.0, 1.0);
  with NormalizeRect(LR) do
    if      (Right - Left) > (Bottom - Top) then
      AspectRatio.X := (Bottom - Top) / (Right - Left)
    else if (Bottom - Top) > (Right - Left) then
      AspectRatio.Y := (Right - Left) / (Bottom - Top);

  SqLR := frxRect(LR.Left * AspectRatio.X, LR.Top * AspectRatio.Y,
    LR.Right * AspectRatio.X, LR.Bottom * AspectRatio.Y);
  SqLStart := PointProduct(LStart, AspectRatio);
  SqLEnd := PointProduct(LEnd, AspectRatio);

  SqEaStart := IntersectionEllipse(DoubleRect(SqLR), SqLStart);
  SqEaEnd := IntersectionEllipse(DoubleRect(SqLR), SqLEnd);

  with SqLR do
    SqCenter := frxPoint((Right + Left) / 2, (Bottom + Top) / 2);

  SqStartAngle := ArcTan2(SqLStart.Y - SqCenter.Y, SqLStart.X - SqCenter.X) / Pi * 180;
  SqEndAngle := ArcTan2(SqLEnd.Y - SqCenter.Y, SqLEnd.X - SqCenter.X) / Pi * 180;

  SqSweepAngle := SqStartAngle - SqEndAngle;
  if SqSweepAngle < 0 then
    SqSweepAngle := SqSweepAngle + 360;

  LargeArcOne := Abs(SqSweepAngle) > 180;
  if FDC.iArcDirection = AD_CLOCKWISE then
    LargeArcOne := not LargeArcOne;
  LargeArc := frIfStr(LargeArcOne, '1', '0');

  SweepOne := SqSweepAngle < 0;
  if LR.Left > LR.Right then
    SweepOne := not SweepOne;
  if LR.Top > LR.Bottom then
    SweepOne := not SweepOne;
  if FDC.iArcDirection = AD_CLOCKWISE then
    SweepOne := not SweepOne;
  Sweep := frIfStr(SweepOne, '1', '0');

  With LR do
  begin
    Center := frxPoint((Right + Left) / 2, (Bottom + Top) / 2);
    Radius := frxPoint(LogToDevSize(Abs(Right - Left) / 2), LogToDevSize(Abs(Bottom - Top) / 2));
  end;
  AspectRatio := frxPoint(1 / AspectRatio.X, 1 / AspectRatio.Y);
  eaStart := PointProduct(SqEaStart, AspectRatio);
  eaEnd := PointProduct(SqEaEnd, AspectRatio);
  Close := frIfStr(NeedClosePath, 'Z');

  Result := Format('d="M %s A %s,%s %s %s,%s %s L %s %s"',
    [MeasurePoint(eaStart), MU(Radius.X), MU(Radius.Y), AxisRotation,
     LargeArc, Sweep, MeasurePoint(eaEnd), MeasurePoint(Center), Close]);
end;

function TEMFtoSVGExport.MeasureClipPath: string;

  function RectToPath(R: TRect): string;
  begin
    EnableTransform := False;
    with NormalizeRect(LogToDevRect(R)) do
      Result := Format('M %s,%s H %s V %s H %s Z',
        [MU(Left), MU(Top), MU(Right), MU(Bottom), MU(Left)]);
    EnableTransform := True;
  end;

var
  PRegionData: PRgnData;
  Size, i: Integer;
  R: TRect;
begin
  Result := '';
  if FDC.ClipRgn <> HRGN(nil) then
  begin
    Size := GetRegionData(FDC.ClipRgn, 0, nil);
    if Size > 0 then
    begin
      GetMem(PRegionData, Size);
      try
        GetRegionData(FDC.ClipRgn, Size, PRegionData);
        for i := 0 to PRegionData^.rdh.nCount - 1 do
        begin
          Move(PRegionData^.Buffer[i * SizeOf(TRect)], R, SizeOf(TRect));
          Result := Result + SpaceDlm(Result) + RectToPath(R);
        end;
      finally
        FreeMem(PRegionData, Size);
      end;
    end;
  end;
end;

function TEMFtoSVGExport.MeasureDominantBaseline: string;
begin
  Result := 'auto'; // See MeasureXYText
//  if      FDC.TextAlignmentMode and TA_BOTTOM = TA_BOTTOM then
//    Result := 'text-after-edge'
//  else if FDC.TextAlignmentMode and TA_BASELINE = TA_BASELINE then
//    Result := 'central'
//  else // TA_TOP
//    Result := 'text-before-edge';
end;

function TEMFtoSVGExport.MeasureDx(OutputDx: TLongWordDinArray; OutputString: WideString): string;
{$Define FloatDx}
var
  CharWidth: TIntegerDinArray;
  Font: TFont;

  procedure CalcCharWidth;
  var
    ExportFont: TfrxExportFont;
    RTLReading: Boolean;
    IsRTL, IsGlyphOut: Boolean;
  begin
    IsRTL := IsInclude(PLast^.ExtTextOutW.emrtext.fOptions, ETO_RTLREADING)
          or IsInclude(FDC.TextAlignmentMode, TA_RTLREADING)
          or IsInclude(FDC.Layout, EMR_LAYOUT_RTL)
          or (FDC.FontCharSet in [ARABIC_CHARSET, HEBREW_CHARSET]);
    IsGlyphOut := not IsRTL and
      IsInclude(PLast^.ExtTextOutW.emrtext.fOptions, ETO_GLYPH_INDEX);
    { disable back conversion in OutputString }
    if IsGlyphOut then
      PLast^.ExtTextOutW.emrtext.fOptions := PLast^.ExtTextOutW.emrtext.fOptions and not ETO_GLYPH_INDEX;
    RTLReading := FDC.TextAlignmentMode and TA_RTLREADING = TA_RTLREADING;
    ExportFont := TfrxExportFont.Create(Font);
    try
      CharWidth := ExportFont.SoftRemapString(OutputString, RTLReading, IsGlyphOut).CharWidth;
    finally
      ExportFont.Free;
    end;
  end;

var
  Dx: TDoubleArray;
  i: Integer;
  Factor: Double;
begin
  Result := '';
  if Length(OutputDx) = 0 then
    Exit;

  Font := FontCreate;
  try
    CalcCharWidth;

    SetLength(Dx, Length(OutputDx));
    Factor := Font.Size / 1000;
    Dx[0] := 0;
    for i := 1 to High(OutputDx) do
      Dx[i] := (LogToDevSize(LongInt(OutputDx[i - 1])) - CharWidth[i - 1] * Factor)
  finally
    Font.Free;
  end;

  Result := ' dx="' + CommentArray(Dx) + '"';
end;

function TEMFtoSVGExport.MeasureDy(OutputDy: TLongWordDinArray; OutputString: WideString): string;
var
  Dy: TDoubleArray;
  Bitmap: TBitmap;
  Font: TFont;
  i: Integer;
begin
  Result := '';
  Exit; { TODO : Not tested yet. Test when examle with DY will be found. }
  if Length(OutputDy) = 0 then
    Exit;

  SetLength(Dy, Length(OutputDy));
  Bitmap := TBitmap.Create;
  try
    Font := FontCreate;
    Bitmap.Canvas.Font := Font;
    Font.Free;
    for i := 0 to High(OutputDy) do
      Dy[i] := LogToDevSize(LongInt(OutputDy[i])) -
        CanvasToSVGFactor * Bitmap.Canvas.TextHeight(OutputString[i + 1]);
  finally
    Bitmap.Free;
  end;

  Result := ' dy="' + CommentArray(Dy, 1) + '"';
end;

function TEMFtoSVGExport.MeasureEllipse(LR: TRect): string;
begin
  with NormalizeRect(LogToDevRect(LR)) do
    Result := Format('cx="%s" cy="%s" rx="%s" ry="%s"',
      [MU((Left + Right) / 2), MU((Top + Bottom) / 2),
       MU((Right - Left) / 2), MU((Bottom - Top) / 2)]);
end;

function TEMFtoSVGExport.MeasureEndCap: string;
begin
  case FDC.PenEndCap of
    PS_ENDCAP_ROUND:
      Result := 'round';
    PS_ENDCAP_SQUARE:
      Result := 'square';
  else // PS_ENDCAP_FLAT
      Result := 'butt';
  end;
end;

function TEMFtoSVGExport.MeasureFill(Options: byte): string;
begin
  if      Options and psText = psText then
    Result := GetColor(FDC.TextColor)
  else if Options and psBG = psBG then
    Result := GetColor(FDC.BkColor)
  else if (Options and psFill = 0) or
          (FDC.BrushColor = clNone) then
    Result := 'none'
  else
    case FDC.BrushStyle of
      BS_SOLID:
        Result := GetColor(FDC.BrushColor);
      BS_NULL, BS_PATTERN8X8, BS_DIBPATTERN8X8, BS_MONOPATTERN:
        Result := 'none';
      BS_HATCHED:
        begin
          case FDC.BrushHatch of
            HS_HORIZONTAL: Do_Pattern(True,  False, False);
            HS_VERTICAL:   Do_Pattern(False, True,  False);
            HS_FDIAGONAL:  Do_Pattern(True,  False, True);
            HS_BDIAGONAL:  Do_Pattern(False, True,  True);
            HS_CROSS:      Do_Pattern(True,  True,  False);
            HS_DIAGCROSS:  Do_Pattern(True,  True,  True);
          end;
          Result := Format('url(#%s)', [SVGDeviceContext.FLastPatternName]);
        end;
    else // BS_PATTERN, BS_INDEXED, BS_DIBPATTERN, BS_DIBPATTERNPT
      Result := GetColor(FDC.BrushColor);
    end;
end;

function TEMFtoSVGExport.MeasureFontOrientation(LP: TPoint): string;
begin
  if FDC.FontOrientation = 0 then
    Result := ''
  else
    Result := Format(' transform="rotate(%s %s)"',
      [Float2Str(-FDC.FontOrientation / 10, 1), MeasurePoint(LP)]);
end;

function TEMFtoSVGExport.MeasureFontOrientation(LP: TDoublePoint): string;
begin
  if FDC.FontOrientation = 0 then
    Result := ''
  else
    Result := Format(' transform="rotate(%s %s)"',
      [Float2Str(-FDC.FontOrientation / 10, 1), MeasurePoint(LP)]);
end;

function TEMFtoSVGExport.MeasureFontSize: string;
begin
  Result := MeasureUnit(LogToDevSize(FDC.FontSize), 'px');
end;

function TEMFtoSVGExport.MeasureFontStyle: string;
begin
  if FDC.FontItalic then
    Result := 'italic'
  else
    Result := 'normal';
end;

function TEMFtoSVGExport.MeasureLine: string;
var
  rP: TfrxPoint;
begin
  rP := LogToDevPoint(FDC.PositionNext);
  with LogToDevPoint(FDC.PositionCurrent) do
    Result := Format('x1="%s" y1="%s" x2="%s" y2="%s"',
      [MU(X), MU(Y), MU(rP.X), MU(rP.Y)]);
end;

function TEMFtoSVGExport.MeasureLineJoin: string;
begin
  case FDC.PenLineJoin of
    PS_JOIN_ROUND:
      Result := 'round';
    PS_JOIN_BEVEL:
      Result := 'bevel';
  else // PS_JOIN_MITER
    Result := 'miter';
  end;

  if FForceMitterLineJoin then
    Result := 'miter';
end;

function TEMFtoSVGExport.MeasurePenWidth: string;
begin
  if FDC.PenType = PS_GEOMETRIC then
    Result := MeasureUnit(LogToDevSize(FDC.PenWidth))
  else // FDC.PenType = PS_COSMETIC
    Result := MeasureUnit(1.0); // https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-emf/93ce3f45-37ac-4aff-b6e8-2f6db054c4c4
end;

function TEMFtoSVGExport.MeasurePie(LR: TRect; LStart, LEnd: TPoint): string;
const
  NeedClosePath = True;
begin
  Result := MeasureArc(LR, LStart, LEnd, NeedClosePath);
end;

function TEMFtoSVGExport.MeasurePoint(LP: TSmallPoint; dX: Extended = 0): string;
begin
  with LogToDevPoint(LP) do
    Result := MU(X + FMEP.Shift.X + dX) + ',' + MU(Y + FMEP.Shift.Y);
end;

function TEMFtoSVGExport.MeasurePoint(LP: TDoublePoint; dX: Extended): string;
begin
  with LogToDevPoint(LP) do
    Result := MU(X + FMEP.Shift.X + dX) + ',' + MU(Y + FMEP.Shift.Y);
end;

function TEMFtoSVGExport.MeasurePoint(LP: TPoint; dX: Extended = 0): string;
begin
  with LogToDevPoint(LP) do
    Result := MU(X + FMEP.Shift.X + dX) + ',' + MU(Y + FMEP.Shift.Y);
end;

function TEMFtoSVGExport.MeasurePoint(LP: TfrxPoint; dX: Extended = 0): string;
begin
  with LogToDevPoint(LP) do
    Result := MU(X + FMEP.Shift.X + dX) + ',' + MU(Y + FMEP.Shift.Y);
end;

function TEMFtoSVGExport.MeasurePoly16Points(var MovToPos: String): string;
var
  Point: integer;
  NeedCorrection: boolean;
begin
  Result := '';
  with PLast^ do
  begin
    NeedCorrection := FLinearBarcode and (Polyline16.cpts = 4);
    for Point := 0 to Polyline16.cpts - 1 do
    begin
      if (Point = 1) then
      begin
        MovToPos := Result;
        Result := '';
      end;
      Result := Result + SpaceDlm(Result) + MeasurePoint(Polyline16.apts[Point],
           frIfReal(NeedCorrection and (Point > 1), xCorrection));
    end;
  end;
end;

function TEMFtoSVGExport.MeasurePoly16Points: string;
var
  Point: integer;
  NeedCorrection: boolean;
begin
  Result := '';
  with PLast^ do
  begin
    NeedCorrection := FLinearBarcode and (Polyline16.cpts = 4);
    for Point := 0 to Polyline16.cpts - 1 do

      Result := Result + SpaceDlm(Result) + MeasurePoint(Polyline16.apts[Point],
           frIfReal(NeedCorrection and (Point > 1), xCorrection));
  end;
end;

function TEMFtoSVGExport.MeasurePolyFillMode: string;
begin
  if FDC.PolyFillMode = ALTERNATE then
    Result := 'evenodd'
  else // PolyFillMode = WINDING
    Result := 'nonzero';
end;

function TEMFtoSVGExport.MeasurePolyPoints: string;
var
  Point: integer;
  NeedCorrection: boolean;
begin
  Result := '';
  with PLast^ do
  begin
    NeedCorrection := FLinearBarcode and (Polyline.cptl = 4);
    for Point := 0 to Polyline.cptl - 1 do
      Result := Result + SpaceDlm(Result) + MeasurePoint(Polyline.aptl[Point],
           frIfReal(NeedCorrection and (Point > 1), xCorrection));
  end;
end;

function TEMFtoSVGExport.MeasurePolyPoints(var MovToPos: String): string;
var
  Point: integer;
  NeedCorrection: boolean;
begin
  Result := '';
  with PLast^ do
  begin
    NeedCorrection := FLinearBarcode and (Polyline.cptl = 4);
    for Point := 0 to Polyline.cptl - 1 do
    begin
      if (Point = 1) then
      begin
        MovToPos := Result;
        Result := '';
      end;
      Result := Result + SpaceDlm(Result) + MeasurePoint(Polyline.aptl[Point],
           frIfReal(NeedCorrection and (Point > 1), xCorrection));
    end;
  end;
end;

function TEMFtoSVGExport.MeasureRect(LR: TRect; dHeight: Double = 0.0): string;
begin
  with NormalizeRect(LogToDevRect(LR)) do
    Result := Format('x="%s" y="%s" width="%s" height="%s"',
      [MU(Left), MU(Top - dHeight), MU(Right - Left), MU(Bottom + dHeight - Top)]);
end;

function TEMFtoSVGExport.MeasureRect(x, y, cx, cy: Integer): string;
begin
  Result := MeasureRect(Bounds(x, y, cx, cy));
end;

function TEMFtoSVGExport.MeasureRectAsPath(LR: TRect): string;
begin
  with NormalizeRect(LogToDevRect(LR)) do
    Result := Format('%s,%s %s,%s %s,%s %s,%s',
      [MU(Left), MU(Top), MU(Right), MU(Top),
       MU(Right), MU(Bottom), MU(Left), MU(Bottom)]);
end;

function TEMFtoSVGExport.MeasureRoundRect(LR: TRect; LS: TSize): string;
begin
  Result := MeasureRect(LR) + Format(' rx="%s" ry="%s"',
    [MU(LogToDevSizeX(LS.cx / 2)), MU(LogToDevSizeY(LS.cy / 2))]);
end;

function TEMFtoSVGExport.MeasureStroke(Options: byte): string;
begin // Stroke with Bitmap Pen
  if (Options and psStroke = 0) or
     (FDC.PenStyle = PS_NULL) or
     (Options and psText = psText) then
    Result := 'none'
  else
    Result := GetColor(FDC.PenColor);
end;

function TEMFtoSVGExport.MeasureStrokeDasharray: string;
var
  Dash, Dot: string;
begin
  Dash := MeasureUnit(6 * LogToDevSize(FDC.PenWidth));
  Dot := MeasureUnit(2 * LogToDevSize(FDC.PenWidth));
  case FDC.PenStyle of
    PS_SOLID:
      Result := 'none';
    PS_DASH:
      Result := Dash + ' ' + Dot;
    PS_DOT:
      Result := Dot + ' ' + Dot;
    PS_DASHDOT:
      Result := Dash + ' ' + Dot + ' ' + Dot + ' ' + Dot;
    PS_DASHDOTDOT:
      Result := Dash + ' ' + Dot + ' ' + Dot + ' ' + Dot + ' ' + Dot + ' ' + Dot;
    PS_NULL:
      Result := 'none';
    PS_INSIDEFRAME: // inside the frame
      Result := 'none';
    PS_ALTERNATE:
      Result := Dot + ' ' + Dot;
  else // PS_USERSTYLE:
    Result := Dash + ' ' + Dot;
  end;
end;

function TEMFtoSVGExport.MeasureStrokeMiterLimit: string;
begin
  Result := FloatToStrF(FDC.MiterLimit, ffGeneral, 7, 0);
end;

function TEMFtoSVGExport.MeasureTextAnchor: string;
begin
  if      FDC.TextAlignmentMode and TA_CENTER = TA_CENTER then
    Result := 'middle'
  else if FDC.TextAlignmentMode and TA_RIGHT = TA_RIGHT then
    Result := 'end'
  else // TA_LEFT
    Result := 'start';
end;

function TEMFtoSVGExport.MeasureTextDecoration: string;
begin
  if      FDC.FontUnderline then
    Result := 'underline'
  else if FDC.FontStrikeOut then
    Result := 'line-through'
  else
    Result := 'none';
end;

//function TEMFtoSVGExport.MeasureTextLength: string;
//begin
//  with (FEMRList.Last as TEMRExtTextOutWObj) do
//    Result := Format(' textLength="%s" lengthAdjust="spacingAndGlyphs"',
//      [MeasureUnit(LogToDevSize(TextLength))]);
//end;

function TEMFtoSVGExport.MeasureUnit(r: Extended; DefaultUnits: string = ''): string;
  function Number(Value: Extended): string;
  begin
    Result := Float2Str(Value, Accuracy);
  end;

begin
  case FDC.MapMode of
    MM_LOMETRIC:
      Result := Number(r * 0.1) + 'mm';
    MM_HIMETRIC:
      Result := Number(r * 0.01) + 'mm';
    MM_LOENGLISH:
      Result := Number(r * 0.01 * 72) + 'pt';
    MM_HIENGLISH:
      Result := Number(r * 0.001 * 72) + 'pt';
    MM_TWIPS:
      Result := Number(r / 1440 * 72) + 'pt';
  else // MM_TEXT, MM_ISOTROPIC, MM_ANISOTROPIC:
    Result := Number(r) + DefaultUnits;
  end;
end;

function TEMFtoSVGExport.MeasureXY(LP: TDoublePoint): string;
begin
  with LogToDevPoint(LP) do
    Result := Format('x="%s" y="%s"', [MU(X + FMEP.Shift.X), MU(Y + FMEP.Shift.Y)]);
end;

function TEMFtoSVGExport.MeasureXYText(LP: TDoublePoint): string;
begin
  Result := MeasureXYText(LP.X, LP.Y);
end;

function TEMFtoSVGExport.MeasureXYText(LP: TPoint): string;
begin
  Result := MeasureXYText(LP.X, LP.Y);
end;

function TEMFtoSVGExport.MeasureXYText(X, Y: Double): string;
var
  FontLP: TDoublePoint;
begin
  FontLP := DoublePoint(X, Y);

  if      FDC.TextAlignmentMode and TA_BASELINE = TA_BASELINE then // central
    FontLP.Y := FontLP.Y
  else if FDC.TextAlignmentMode and TA_BOTTOM = TA_BOTTOM then // text-after-edge
    FontLP.Y := FontLP.Y - FDC.FontSize * 0.20
  else { FDC.TextAlignmentMode and TA_TOP = TA_TOP } // text-before-edge
    FontLP.Y := FontLP.Y + FDC.FontSize * 0.90;

  Result := MeasureXY(FontLP);
end;

function TEMFtoSVGExport.MU(r: Extended): string;
begin
  Result := MeasureUnit(r);
end;

procedure TEMFtoSVGExport.NextClipPath;
begin
  SVGDeviceContext.FLastClipPathName := SVGUniqueID;
end;

procedure TEMFtoSVGExport.NextPattern;
begin
  SVGDeviceContext.FLastPatternName := SVGUniqueID;
end;

function TEMFtoSVGExport.NormalizeRect(const Rect: TRect): TRect;
begin
  Result.Left := Min(Rect.Left, Rect.Right);
  Result.Right := Max(Rect.Left, Rect.Right);

  Result.Top := Min(Rect.Top, Rect.Bottom);
  Result.Bottom := Max(Rect.Top, Rect.Bottom);
end;

function TEMFtoSVGExport.NormalizeRect(frxRect: TfrxRect): TfrxRect;
begin
  Result.Left := Min(frxRect.Left, frxRect.Right);
  Result.Right := Max(frxRect.Left, frxRect.Right);

  Result.Top := Min(frxRect.Top, frxRect.Bottom);
  Result.Bottom := Max(frxRect.Top, frxRect.Bottom);
end;

procedure TEMFtoSVGExport.Puts(const Fmt: WideString; const Args: array of const);
begin
  Puts(Format(Fmt, Args));
end;

procedure TEMFtoSVGExport.Puts(const s: WideString);
begin
  PutsA(AnsiString(Utf8Encode(s)));
end;

procedure TEMFtoSVGExport.PutsA(const s: AnsiString);
begin
  PutsRaw(s);
  if Formatted and (s <> '') then
    PutsRaw(#13#10);
end;

procedure TEMFtoSVGExport.PutsRaw(const s: AnsiString);
begin
  if (FOutStream <> nil) and (s <> '') then
    FOutStream.Write(s[1], Length(s))
end;

procedure TEMFtoSVGExport.SetEmbedded(CSS: TfrxCSSList; Obj: TfrxView);
begin
  FEmbedded := True;
  FCSS := CSS;
  CalcMemoExternalParams(Obj);
  if not FMEP.IsExternal then
    with Obj.GetRealBounds do
    begin
      FX := Left;
      FY := Top;
    end;
end;

function TEMFtoSVGExport.SpaceDlm(st: string): string;
begin
  Result := frIfStr(st <> '', ' ');
end;

function TEMFtoSVGExport.SureFirstM(Path: string): string;
  {$IFNDEF DELPHI12}
  function CharInSet(Ch: Char; CharSet: TSysCharset): Boolean;
  begin
    Result := Ch in CharSet;
  end;
  {$ENDIF}

  function IsFound(SearchStart: Integer; CharSet: TSysCharset; out SearchResult: Integer): Boolean;
  var
    i: Integer;
  begin
    Result := True;
    for i := SearchStart to Length(Path) do
      if CharInSet(Path[i], CharSet) then
      begin
        SearchResult := i;
        Exit;
      end;
    Result := False;
  end;
const
  Digits = ['0'..'9', '.'];
  NotDigits = [#0..#255] - ['0'..'9', '.'];
var
  FirstNumberStart, j, SecondNumberFinish: Integer;
begin
  if IsFound(1,                    Digits,    FirstNumberStart) and
     IsFound(FirstNumberStart + 1, NotDigits, j) and
     IsFound(j + 1,                Digits,    j) and
     IsFound(j + 1,                NotDigits, SecondNumberFinish) then
    Result := 'M ' + Copy(Path, FirstNumberStart, SecondNumberFinish - FirstNumberStart) + ' ' + Path
  else
    Result := Path;
end;

function TEMFtoSVGExport.SVGDeviceContext: TSVGDeviceContext;
begin
  Result := FDC as TSVGDeviceContext;
end;

{ TSVGDeviceContext }

procedure TSVGDeviceContext.CopyFrom(ADC: TObject);
begin
  inherited;

  FLastClipPathName := (ADC as TSVGDeviceContext).FLastClipPathName;
  FLastPatternName := (ADC as TSVGDeviceContext).FLastPatternName;
end;

procedure TSVGDeviceContext.Init;
begin
  inherited;

  FLastClipPathName := '';
  FLastPatternName := '';
end;

end.


