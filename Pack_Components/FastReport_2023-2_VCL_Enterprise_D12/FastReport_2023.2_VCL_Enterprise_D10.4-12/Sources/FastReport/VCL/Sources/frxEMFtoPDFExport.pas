
{******************************************}
{                                          }
{             FastReport VCL               }
{            EMF to PDF Export             }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxEMFtoPDFExport;

interface

{$I frx.inc}

uses
  Windows, Graphics, Classes, frxExportHelpers, frxEMFAbstractExport,
  frxEMFFormat, frxExportPDFHelpers, frxClass, frxAnaliticGeometry, frxUtils;

type
  TBezierResult = record
    P0, P1, P2, P3: TfrxPoint;
  end;

  TPDFDeviceContext = class(TDeviceContext);

  TEMFtoPDFExport = class(TEMFAbstractExport)
  private
    FForceMitterLineJoin: Boolean;
    FForceButtLineCap: Boolean;
    FForceNullBrush: Boolean;
    FTransparency: Boolean;
    FForceAnsi: Boolean;
    FClipped: Boolean;
    FPictureDPI: Integer;
    FPrecision: Integer;
    FRasterFill: Boolean;

    procedure Put(const S: AnsiString);
    procedure PutCRLF(const S: AnsiString); {$IFDEF DELPHI12} overload;
    procedure PutCRLF(const S: string); overload; {$ENDIF}
    procedure PutLF(const S: AnsiString); {$IFDEF DELPHI12} overload;
    procedure PutLF(const S: string); overload; {$ENDIF}

    function pdfSize(emfSize: Extended): Extended;

    function pdfFrxPoint(emfP: TPoint): TfrxPoint; overload;
    function pdfFrxPoint(emfSP: TSmallPoint): TfrxPoint; overload;
    function pdfFrxPoint(emfDP: TfrxPoint): TfrxPoint; overload;

    function pdfFrxRect(emfR: TRect): TfrxRect;

//    function emfSize2Str(emfSize: Extended): string;

    function emfPoint2Str(emfP: TPoint): string; overload;
    function emfPoint2Str(emfSP: TSmallPoint): string; overload;
    function emfPoint2Str(emfFP: TfrxPoint): string; overload;
//    function emfPoint2Str(X, Y: Extended): string; overload;

//    function emfRect2Str(emfR: TRect): string;

    function EvenOdd: string;
    function IsNullBrush: Boolean;
    function IsNullPen: Boolean;
    procedure ReferenceToImageXObject(PicIndex: Integer; pdfRect: TfrxRect);

    function BezierCurve(Center, Radius: TfrxPoint; startAngle, arcAngle: Double): TBezierResult;
    procedure cmd_AngleArc(Center, Radius: TfrxPoint; StartAngle, SweepAngle: Single);
    procedure cmd_RoundRect(l, t, r, b, rx, ry: Extended);
    procedure cmdPathPainting(Options: Integer);
    procedure cmdSetClippingPath;
    procedure cmdCloseSubpath;
    procedure cmdAppendAngleArcToPath(AngleArc: TEMRAngleArc);
    procedure cmdAppendArcToPath(Arc: TEMRArc);
    procedure cmdAppendPieToPath(Pie: TEMRPie);
    procedure cmdAppendEllipsToPath(emfRect: TRect);
    procedure cmdAppendRectangleToPath(emfRect: TRect; IsCompartible: Boolean = False);
    procedure cmdAppendEMFRectangleToPath(emfRect: TRect);
    procedure cmdAppendRoundRectToPath(emfRect: TRect; emfCorners: TSize);

    procedure cmdMoveTo(X, Y: Extended); overload;
    procedure cmdMoveTo(emfP: TPoint); overload;
    procedure cmdMoveTo(emfSP: TSmallPoint); overload;
    procedure cmdMoveTo(emfFP: TfrxPoint); overload;

    procedure cmdLineTo(X, Y: Extended); overload;
    procedure cmdLineTo(emfP: TPoint); overload;
    procedure cmdLineTo(emfSP: TSmallPoint); overload;
    procedure cmdLineTo(emfFP: TfrxPoint); overload;

    procedure cmdSetLineDashPattern(PenStyle: LongWord; Width: Extended);
    procedure cmdSetStrokeColor(Color: TColor);
    procedure cmdSetFillColor(Color: TColor);
    procedure cmdSetFillFilter;
    procedure cmdSetFillPatternBitmap(Bitmap: TBitmap);
    procedure cmdSetStroke;
    procedure cmdSetLineWidth(Width: Extended); overload;
    procedure cmdSetLineWidth(PDFWidth: string); overload;
    procedure cmdSetMiterLimit(MiterLimit: Extended);
    procedure cmdSetLineCap(PenEndCap: Integer);
    procedure cmdSetLineJoin(PenLineJoin: Integer);
    procedure cmdAppendCurvedSegment2final(emfSP1, emfSP3: TSmallPoint); overload;
    procedure cmdAppendCurvedSegment2final(emfP1, emfP3: TPoint); overload;
    procedure cmdAppendCurvedSegment3(emfSP1, emfSP2, emfSP3: TSmallPoint); overload;
    procedure cmdAppendCurvedSegment3(emfP1, emfP2, emfP3: TPoint); overload;
    procedure cmdAppendCurvedSegment3(emfDP1, emfDP2, emfDP3: TfrxPoint); overload;
    procedure cmdPolyBezier(Options: Integer = 0);
    procedure cmdPolyBezier16(Options: Integer = 0);
    procedure cmdPolyLine(Options: Integer = 0);
    procedure cmdPolyLine16(Options: Integer = 0);
    procedure cmdPolyPolyLine(Options: Integer = 0);
    procedure cmdPolyPolyLine16(Options: Integer = 0);

    procedure cmdCreateExtSelectClipRgn;

    procedure cmdSaveGraphicsState;
    procedure cmdRestoreGraphicsState;

    procedure cmdBitmap(emfRect: TRect; dwRop: LongWord; EMRBitmap: TEMRBitmap);
    function BitmapSave(emfRect: TRect; Bitmap: TBitmap; ForPattern: Boolean = False): Integer;
    procedure cmdBitmap32(emfRect: TRect; dwRop: LongWord; EMRBitmap: TEMRBitmap);
    function GlueBitmap32(EMRBitmapAlpha, EMRBitmap: TEMRBitmap): TBitmap;

    procedure cmdTranslationAndScaling(Sx, Sy, Tx, Ty: Extended);
  protected
    FPDFRect: TfrxRect;
    FLastClipRect: TRect;
    FEMFtoPDFFactor: TfrxPoint;
    FPOH: TPDFObjectsHelper;
    FRotation2D: TRotation2D;
    FRealizationList: TStringList;
    FqQBalance: Integer;
    FFiller: TObject;
    FIsPreviousAlpha: Boolean;

    procedure Comment(CommentString: string = ''); override;
    procedure CommentAboutRealization;
    procedure CommentTextRect(rtl: TRect; Color: TColor = clRed);
    procedure RealizationListFill(RealizedCommands: array of string);
    function NormalizeRect(const Rect: TRect): TRect;
    procedure DCCreate; override;
    function FontCreate: TEMFFont; override;
    function IsSameCharacterWidth(FontName: string): Boolean;
    function IsBitmapAsAlpha: Boolean;
    function GetNextEnhMetaObj: TEMRBitmapROP;

    procedure DrawFontLines(FontSize: Double; TextPosition: TfrxPoint; TextWidth: Extended);
    procedure DrawFigureStart(Options: Integer);
    procedure DrawFigureFinish(Options: Integer);
    function FillStrokeOptions(Options: Integer): Integer;

    procedure DoEMR_AngleArc; override;
    procedure DoEMR_Arc; override;
    procedure DoEMR_AlphaBlend; override;
    procedure DoEMR_BitBlt; override;
    procedure DoEMR_CloseFigure; override;
    procedure DoEMR_CreateDIBPatternBrushPt; override;
    procedure DoEMR_Ellipse; override;
    procedure DoEMR_EoF; override;
    procedure DoEMR_ExtSelectClipRgn; override;
    procedure DoEMR_ExtTextOutW; override;
    procedure DoEMR_FillPath; override;
    procedure DoEMR_FillRgn; override;
    procedure DoEMR_Header; override;
    procedure DoEMR_IntersectClipRect; override;
    procedure DoEMR_LineTo; override;
    procedure DoEMR_MaskBlt; override;
    procedure DoEMR_MoveToEx; override;
    procedure DoEMR_Pie; override;
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
    procedure DoEMR_Rectangle; override;
    procedure DoEMR_RestoreDC; override;
    procedure DoEMR_RoundRect; override;
    procedure DoEMR_SaveDC; override;
    procedure DoEMR_SelectClipPath; override;
    procedure DoEMR_StretchBlt; override;
    procedure DoEMR_StretchDIBits; override;
    procedure DoEMR_StrokeAndFillPath; override;
    procedure DoEMR_StrokePath; override;
    procedure DoEMR_TransparentBlt; override;

    procedure DoStart; override;
    procedure DoFinish; override;
  public
    constructor Create(InStream: TMemoryStream; OutStream: TStream; APDFRect: TfrxRect; APOH: TPDFObjectsHelper);
    destructor Destroy; override;

    property ForceMitterLineJoin: Boolean read FForceMitterLineJoin write FForceMitterLineJoin;
    property ForceButtLineCap: Boolean write FForceButtLineCap;
    property ForceNullBrush: Boolean write FForceNullBrush;
    property Transparency: Boolean write FTransparency;
    property ForceAnsi: Boolean write FForceAnsi;
    property Clipped: Boolean write FClipped;
    property PictureDPI: Integer write FPictureDPI;
    property Precision: Integer write FPrecision;
    property RasterFill: Boolean read FRasterFill write FRasterFill;
  end;

implementation

uses
//frxMapHelpers, // todo : frxMapHelpers
  Contnrs, SysUtils, Types, Math, frPictureGraphics, frxHelpers
{$IFDEF DELPHI16}
  ,UITypes
{$ENDIF} {It is necessary to prevent H2443}
  ,frUtils;

const
  ZeroRect: TRect = (Left: 0; Top: 0; Right: 0; Bottom: 0);

  EMRStrokeOp = [EMR_AngleArc, EMR_Arc, EMR_Ellipse, EMR_LineTo, EMR_Pie,
    EMR_PolyBezier, EMR_PolyBezier16, EMR_PolyBezierTo, EMR_PolyBezierTo16,
    EMR_PolyDraw, EMR_PolyDraw16, EMR_Polygon, EMR_Polygon16, EMR_Polyline,
    EMR_Polyline16, EMR_PolylineTo, EMR_PolylineTo16, EMR_PolyPolygon,
    EMR_PolyPolygon16, EMR_PolyPolyline, EMR_PolyPolyline16, EMR_Rectangle,
    EMR_RoundRect, EMR_StrokeAndFillPath, EMR_StrokePath];

  EmrTextOp = [EMR_ExtTextOutW, EMR_ExtTextOutW, EMR_PolyTextOutA,
    EMR_PolyTextOutW, EMR_SmallTextOut];

  EMRFillOp =[EMR_Ellipse, EMR_FillPath, EMR_FillRgn, EMR_Pie, EMR_Polygon,
    EMR_Polygon16, EMR_PolyPolygon, EMR_PolyPolygon16, EMR_Rectangle,
    EMR_RoundRect, EMR_StrokeAndFillPath];

type
  TEMFOutStream = class (TMemoryStream)
  private
    FqRecords: Cardinal;
  public
    constructor Create;

    procedure AddRecord(const Buffer; Count: LongInt);
    procedure SetHeader;
  end;

  TFillerType = (ftSolidColor, ftPatternBitmap);
  TFiller = class
  private
    FExport: TEMFtoPDFExport;
    FBitmap: TBitmap;
    FihBrush: Integer;
    FFillerType: TFillerType;
    FSolidColor: TColor;
  protected
    procedure CreateSolidColor(Color: TColor);

    procedure CreateMonoBrushObj(MonoBrushObj: TEMRCreateMonoBrushObj);
    procedure CreateDIBPatternBrushPtObj(DIBPatternBrushPtObj: TEMRCreateDIBPatternBrushPtObj);
    procedure CreateBrushIndirectObj(BrushIndirect: TEMRCreateBrushIndirect);

  public
    constructor Create(AExport: TEMFtoPDFExport);
    destructor Destroy; override;

    procedure Init;

    property ihBrush: Integer read FihBrush write FihBrush;
    property SolidColor: TColor read FSolidColor;
    property FillerType: TFillerType read FFillerType;
    property Bitmap: TBitmap read FBitmap;
  end;

  TEMFPDFSizeConverter = class
  private
    FDev: Double; // EMR_ExtTextOutW.rclBounds
    FLog: Double; // EMR_ExtTextOutW.emrtext.ptlReference // WordTransform etc...
    FPDF: Double;
    FChar: Double;
    procedure SetDev(const Value: Double);
    procedure SetLog(const Value: Double);
    procedure SetPDF(const Value: Double);
    procedure SetChar(const Value: Double);
  protected
    FExport: TEMFtoPDFExport;
    FEMFPDFFactor: Double;
    FFont: TEMFFont;
  public
    constructor Create(AExport: TEMFtoPDFExport);
    destructor Destroy; override;

    function LogToDev(Value: Double): Double;

    property Dev: Double read FDev write SetDev;
    property Log: Double read FLog write SetLog;
    property PDF: Double read FPDF write SetPDF;
    property Char: Double read FChar write SetChar;
  end;

const
  // Path-Painting Operators
  ppEnd      =  $0;
  ppClose    =  $1;
  ppStroke   =  $2;
  ppFill     =  $4;
  ppWithTo   =  $8; // To reset the current position

{ Utility routines }

function CreateWidenedBitmap(Factor: Double; Bitmap: TBitmap): TBitmap;
begin
  Result := TBitmap.Create;
  Result.PixelFormat := Bitmap.PixelFormat;
  Result.Width := Round(Bitmap.Width * Factor);
  Result.Height := Round(Bitmap.Height * Factor);
  Result.Canvas.StretchDraw(Result.Canvas.ClipRect, Bitmap);
end;

function IsStrInSet(Str: string; StrSet: array of string): Boolean;
var
  i: Integer;
begin
  Result := True;
  for i := 0 to High(StrSet) do
    if Str = StrSet[i] then
      Exit;
  Result := False;
end;

procedure Swap(var E1, E2: Extended);
var
  Temp: Extended;
begin
  Temp := E1;
  E1 := E2;
  E2 := Temp;
end;

function PenStyle2Str(PenStyle: LongWord; Width: Extended): string;
var
  Dash, Dot: string;
begin
  Dash := Float2Str(6 * Width) + ' ';
  Dot := Float2Str(2 * Width) + ' ';
  case PenStyle of
    PS_SOLID:
      Result := '';
    PS_DASH:
      Result := Dash;
    PS_DOT:
      Result := Dot + Dash;
    PS_DASHDOT:
      Result := Dash + Dash + Dot + Dash;
    PS_DASHDOTDOT:
      Result := Dash + Dash + Dot + Dash + Dot + Dash;
    PS_NULL:
      Result := '';
    PS_INSIDEFRAME:
      Result := '';
    PS_ALTERNATE:
      Result := Dot + Dot;
  else // PS_USERSTYLE:
    Result := Dash + Dot;
  end;
  if Result <> '' then
    Delete(Result, Length(Result), 1);
end;

{ TEMFtoPDFExport }

function TEMFtoPDFExport.BezierCurve(Center, Radius: TfrxPoint; StartAngle, ArcAngle: Double): TBezierResult;
  function Rad(Degree: Double): Extended;
  begin
    Result := Degree * Pi / 180;
  end;
var
  Cos1, Sin1, Cos2, Sin2, Aux, Alpha: Extended;
begin
  SinCos(Rad(StartAngle), Sin1, Cos1);
  SinCos(Rad(StartAngle + ArcAngle), Sin2, Cos2);

  //point p1. Start point
  Result.P0 := frxPoint(Center.X + Radius.X * Cos1, Center.Y - Radius.Y * Sin1);
  //point p2. End point
  Result.P3 := frxPoint(Center.X + Radius.X * Cos2, Center.Y - Radius.Y * Sin2);

  //Alpha constant
  Aux := Tan(Rad(ArcAngle / 2));
  Alpha := Sin(Rad(ArcAngle)) * (Sqrt(4 + 3 * Aux * Aux) - 1.0) / 3.0;

  //point q1. First control point
  Result.P1 := frxPoint(Result.P0.X - Alpha * Radius.X * Sin1,
                        Result.P0.Y - Alpha * Radius.Y * Cos1);
  //point q2. Second control point.
  Result.P2 := frxPoint(Result.P3.X + Alpha * Radius.X * Sin2,
                        Result.P3.Y + Alpha * Radius.Y * Cos2);
end;

function TEMFtoPDFExport.BitmapSave(emfRect: TRect; Bitmap: TBitmap; ForPattern: Boolean = False): Integer;
var
  Graphic: TGraphic;
  Stream: TStream;
  Hash: TfrxPDFXObjectHash;
begin
  Graphic := GetGraphicFormats.Convert(Bitmap, 'JPG', pf24bit, FPOH.Quality);
  try
    Stream := TMemoryStream.Create;
    try
      Graphic.SaveToStream(Stream);

      Stream.Position := 0;
      GetStreamHash(Hash, Stream);
      Result := FPOH.FindXObject(Hash);

      if Result = -1 then
        Result := FPOH.OutXObjectImage(Hash, Graphic, Stream);
    finally
      Stream.Free;
    end;
  finally
    Graphic.Free;
  end;

  if not ForPattern then
    ReferenceToImageXObject(Result, pdfFrxRect(emfRect));
end;

procedure TEMFtoPDFExport.cmdAppendAngleArcToPath(AngleArc: TEMRAngleArc);
begin
  with AngleArc do
    cmd_AngleArc(ToFrxPoint(ptlCenter), frxPoint(nRadius, nRadius), eStartAngle, eSweepAngle);
end;

procedure TEMFtoPDFExport.cmdAppendArcToPath(Arc: TEMRArc);
var
  Center, Radius, AspectRatio: TfrxPoint;
  StartAngle, EndAngle, SweepAngle: Extended;
begin
  AspectRatio := frxPoint(1.0, 1.0);
  with NormalizeRect(Arc.rclBox) do
  begin
    Center := frxPoint((Right + Left) / 2, (Bottom + Top) / 2);
    Radius := frxPoint((Right - Left) / 2, (Bottom - Top) / 2);
    if      (Right - Left) > (Bottom - Top) then
      AspectRatio.X := (Bottom - Top) / (Right - Left)
    else if (Bottom - Top) > (Right - Left) then
      AspectRatio.Y := (Right - Left) / (Bottom - Top);
  end;

  with Arc do
  begin
    StartAngle := ArcTan2((ptlStart.Y - Center.Y) * AspectRatio.Y,
                          (ptlStart.X - Center.X) * AspectRatio.X) / Pi * 180;
    EndAngle := ArcTan2((ptlEnd.Y - Center.Y) * AspectRatio.Y,
                        (ptlEnd.X - Center.X) * AspectRatio.X) / Pi * 180;
  end;

  if FDC.iArcDirection = AD_CLOCKWISE then
    Swap(StartAngle, EndAngle);
  SweepAngle := StartAngle - EndAngle;

  if SweepAngle = 0.0 then
    SweepAngle := 360 - 1e-4
  else if SweepAngle < 0 then
    SweepAngle := SweepAngle + 360;

  cmd_AngleArc(Center, Radius, -StartAngle, SweepAngle);
end;

procedure TEMFtoPDFExport.cmdAppendCurvedSegment2final(emfSP1, emfSP3: TSmallPoint);
begin
  PutLF(emfPoint2Str(emfSP1) + ' ' + emfPoint2Str(emfSP3) + ' v');
end;

procedure TEMFtoPDFExport.cmdAppendCurvedSegment2final(emfP1, emfP3: TPoint);
begin
  PutLF(emfPoint2Str(emfP1) + ' ' + emfPoint2Str(emfP3) + ' v');
end;

procedure TEMFtoPDFExport.cmdAppendCurvedSegment3(emfDP1, emfDP2, emfDP3: TfrxPoint);
begin
  PutLF(emfPoint2Str(emfDP1) + ' ' + emfPoint2Str(emfDP2) + ' ' + emfPoint2Str(emfDP3) + ' c');
end;

procedure TEMFtoPDFExport.cmdAppendCurvedSegment3(emfP1, emfP2, emfP3: TPoint);
begin
  PutLF(emfPoint2Str(emfP1) + ' ' + emfPoint2Str(emfP2) + ' ' + emfPoint2Str(emfP3) + ' c');
end;

procedure TEMFtoPDFExport.cmdAppendCurvedSegment3(emfSP1, emfSP2, emfSP3: TSmallPoint);
begin
  PutLF(emfPoint2Str(emfSP1) + ' ' + emfPoint2Str(emfSP2) + ' ' + emfPoint2Str(emfSP3) + ' c');
end;

procedure TEMFtoPDFExport.cmdAppendEllipsToPath(emfRect: TRect);
begin
  with pdfFrxRect(emfRect) do
    cmd_RoundRect(Left, Top, Right, Bottom, (Right - Left) / 2, (Top - Bottom) / 2);
end;

procedure TEMFtoPDFExport.cmdAppendEMFRectangleToPath(emfRect: TRect);
begin
  EnableTransform := False;
  try
    cmdAppendRectangleToPath(emfRect);
  finally
    EnableTransform := True;
  end;
end;

procedure TEMFtoPDFExport.cmdAppendPieToPath(Pie: TEMRPie);
var
  Center: TfrxPoint;
begin
  cmdAppendArcToPath(Pie);

  with NormalizeRect(Pie.rclBox) do
    Center := frxPoint((Right + Left) / 2, (Bottom + Top) / 2);
  cmdLineTo(Center);
end;

procedure TEMFtoPDFExport.cmdAppendRectangleToPath(emfRect: TRect; IsCompartible: Boolean = False);
begin
  FScalingOnly := IsCompartible;
  try
    PutLF(frxRect2Str(pdfFrxRect(emfRect), FPrecision) + ' re');
  finally
    FScalingOnly := False;
  end;
end;

procedure TEMFtoPDFExport.cmdAppendRoundRectToPath(emfRect: TRect; emfCorners: TSize);
begin
  with pdfFrxRect(emfRect), emfCorners do
    cmd_RoundRect(Left, Top, Right, Bottom, pdfSize(cx) / 2, pdfSize(cy) / 2);
end;

procedure TEMFtoPDFExport.cmdBitmap(emfRect: TRect; dwRop: LongWord; EMRBitmap: TEMRBitmap);
var
  SourceBM: TBitmap;
  NeedD, NeedP, NeedS: Boolean;

  function GetBitmapWithDPI: TBitmap;
  var
    Factor: Double;

    function CalcFactor(Bitmap: TBitmap): Double;
    var
      SC: TEMFPDFSizeConverter;
      ImageDeviceRect: TDoubleRect;
      ImageInchSize, ImageActualDPI: TDoublePoint;
    begin
      SC := TEMFPDFSizeConverter.Create(Self);
      try
        ImageDeviceRect := DoubleRect(
          SC.LogToDev(emfRect.Left), SC.LogToDev(emfRect.Top),
          SC.LogToDev(emfRect.Right), SC.LogToDev(emfRect.Bottom));
      finally
        SC.Free;
      end;

      ImageInchSize := DoublePoint(
        Abs(ImageDeviceRect.Right - ImageDeviceRect.Left) / FDC.DeviceDPI.X,
        Abs(ImageDeviceRect.Bottom - ImageDeviceRect.Top) / FDC.DeviceDPI.X);
      ImageActualDPI := DoublePoint(
        Bitmap.Width / ImageInchSize.X, Bitmap.Width / ImageInchSize.Y);
      Factor := FPictureDPI / Sqrt(ImageActualDPI.X * ImageActualDPI.Y);
      Result := Factor;
    end;

  var
    BM: TBitmap;
  begin
    Result := EMRBitmap.GetBitmap;
    if (FPictureDPI > 0) and (CalcFactor(Result) < 1) then
    begin
      BM := CreateWidenedBitmap(Factor, Result);
      Result.Free;
      Result := BM;
    end;
    if Result.PixelFormat <> pf32bit then
      Result.PixelFormat := pf24bit;
  end;

  procedure OutOpaque;
  begin
    BitmapSave(emfRect, SourceBM);
    SourceBM.Free;
  end;

begin
  SourceBM := nil;
  TernaryRasterOperationNeeds(dwRop, NeedD, NeedP, NeedS);

  if NeedS then
    SourceBM := GetBitmapWithDPI;

  case dwRop of // https://msdn.microsoft.com/en-us/library/cc250408.aspx
    $F00021, // P           15728673 PATCOPY
    $A000C9: // DPa         10485961
      begin
        DrawFigureStart(ppFill);
        cmdAppendRectangleToPath(emfRect);
        DrawFigureFinish(ppFill);
      end;
    $CC0020, // S           13369376 SRCCOPY
    $EE0086, // DSo         15597702 SRCPAINT
    $8800C6, // DSa          8913094 SRCAND
    $660046: // DSx          6684742 SRCINVERT
      OutOpaque;
    $AA0029, // D           11141161
    $5A0049: // DPx          5898313 PATINVERT
      ; // Do nothing
  else
    Comment(' Unsupported dwRop: ' + IntToStr(dwRop));
    if NeedS then
      OutOpaque;
  end;
end;

procedure TEMFtoPDFExport.cmdBitmap32(emfRect: TRect; dwRop: LongWord; EMRBitmap: TEMRBitmap);
var
  pdfRect: TfrxRect;
  PicIndex: Integer;
  Graphic: TGraphic;
begin
  pdfRect := pdfFrxRect(emfRect);
  case dwRop of // https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-emf/34e07d4f-aee6-4b63-a4bb-96996ad47669
    $1FF0000:
      begin
        Graphic := TEMRAlphaBlendObj(EMRBitmap).GetARGBGraphic;
        try
          PicIndex := FPOH.OutTransparentGraphic(Graphic);
        finally
          Graphic.Free;
        end;
      end;
  else
    Comment(' Usupported dwRop: ' + IntToStr(dwRop));
    Exit;
  end;
  ReferenceToImageXObject(PicIndex, pdfRect);
end;

procedure TEMFtoPDFExport.cmdCloseSubpath;
begin
  PutLF('h');
end;

procedure TEMFtoPDFExport.cmdCreateExtSelectClipRgn;
var
  PRegionData: PRgnData;
  Size, i: Integer;
  R: TRect;
begin
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
          cmdAppendEMFRectangleToPath(R);
          FLastClipRect := R;
        end;
        cmdSetClippingPath;
        cmdPathPainting(ppEnd);
      finally
        FreeMem(PRegionData, Size);
      end;
    end;
  end;
end;

procedure TEMFtoPDFExport.cmdLineTo(emfFP: TfrxPoint);
begin
  PutLF(emfPoint2Str(emfFP) + ' l');
end;

procedure TEMFtoPDFExport.cmdLineTo(emfP: TPoint);
begin
  PutLF(emfPoint2Str(emfP) + ' l');
end;

procedure TEMFtoPDFExport.cmdLineTo(emfSP: TSmallPoint);
begin
  PutLF(emfPoint2Str(emfSP) + ' l');
end;

procedure TEMFtoPDFExport.cmdLineTo(X, Y: Extended);
begin
  PutLF(frxPoint2Str(X, Y, FPrecision) + ' l');
end;

procedure TEMFtoPDFExport.cmdMoveTo(emfFP: TfrxPoint);
begin
  PutLF(emfPoint2Str(emfFP) + ' m');
end;

procedure TEMFtoPDFExport.cmdMoveTo(emfP: TPoint);
begin
  PutLF(emfPoint2Str(emfP) + ' m');
end;

procedure TEMFtoPDFExport.cmdMoveTo(emfSP: TSmallPoint);
begin
  PutLF(emfPoint2Str(emfSP) + ' m');
end;

procedure TEMFtoPDFExport.cmdMoveTo(X, Y: Extended);
begin
  PutLF(frxPoint2Str(X, Y, FPrecision) + ' m');
end;

procedure TEMFtoPDFExport.cmdPathPainting(Options: Integer);
begin
  case Options and (ppEnd or ppClose or ppStroke or ppFill) of
    ppEnd:                       PutLF('n');
    ppStroke:                    PutLF('S');
    ppStroke + ppClose:          PutLF('s');
    ppFill, ppFill + ppClose:
      if RasterFill then
        PutLF('n%--f')
      else
        PutLF('f' + EvenOdd);
    ppFill + ppStroke:
      if RasterFill then
        PutLF('S%--B')
      else
        PutLF('B' + EvenOdd);
    ppFill + ppStroke + ppClose:
      if RasterFill then
        PutLF('s%--b')
      else
        PutLF('b' + EvenOdd);
  else
    raise Exception.Create('Invalid Patch Painting');
  end;
end;

procedure TEMFtoPDFExport.cmdPolyBezier(Options: Integer = 0);
var
  Point: Integer;
begin
  with PLast^ do
  begin
    if IsInclude(Options, ppWithTo) then
      Point := 0
    else
      begin
        cmdMoveTo(Polyline.aptl[0]);
        Point := 1;
      end;
    while True do
      case Integer(Polyline.cptl) - Point of
        0, 1:
          Break;
        2, 4:
          begin
            cmdAppendCurvedSegment2final(Polyline.aptl[Point],
              Polyline.aptl[Point + 1]);
            Inc(Point, 2);
          end;
      else
        cmdAppendCurvedSegment3(Polyline.aptl[Point],
          Polyline.aptl[Point + 1], Polyline.aptl[Point + 2]);
        Inc(Point, 3);
      end;
  end;
end;

procedure TEMFtoPDFExport.cmdPolyBezier16(Options: Integer = 0);
var
  Point: Integer;
begin
  with PLast^ do
  begin
    if IsInclude(Options, ppWithTo) then
      Point := 0
    else
      begin
        cmdMoveTo(Polyline16.apts[0]);
        Point := 1;
      end;
    while True do
      case Integer(Polyline16.cpts) - Point of
        0, 1:
          Break;
        2, 4:
          begin
            cmdAppendCurvedSegment2final(Polyline16.apts[Point],
              Polyline16.apts[Point + 1]);
            Inc(Point, 2);
          end;
      else
        cmdAppendCurvedSegment3(Polyline16.apts[Point],
          Polyline16.apts[Point + 1], Polyline16.apts[Point + 2]);
        Inc(Point, 3);
      end;
  end;
end;

procedure TEMFtoPDFExport.cmdPolyLine(Options: Integer = 0);
var
  Point: Integer;
begin
  with PLast^ do
  begin
    if IsInclude(Options, ppWithTo) then
      cmdLineTo(Polyline.aptl[0])
    else
      cmdMoveTo(Polyline.aptl[0]);
    for Point := 1 to Polyline.cptl - 1 do
      cmdLineTo(Polyline.aptl[Point])
  end;
  if IsInclude(Options, ppClose) then
    cmdCloseSubpath;
end;

procedure TEMFtoPDFExport.cmdPolyLine16(Options: Integer = 0);
var
  Point: Integer;
begin
  with PLast^ do
  begin
    if IsInclude(Options, ppWithTo) then
      cmdLineTo(Polyline16.apts[0])
    else
      cmdMoveTo(Polyline16.apts[0]);
    for Point := 1 to Polyline16.cpts - 1 do
      cmdLineTo(Polyline16.apts[Point])
  end;
  if IsInclude(Options, ppClose) then
    cmdCloseSubpath;
end;

procedure TEMFtoPDFExport.cmdPolyPolyLine(Options: Integer = 0);
var
  Poly, Point: Integer;
begin
  with FEMRList.Last as TEMRPolyPolygonObj do
  begin
    for Poly := 0 to P^.PolyPolygon.nPolys - 1 do
    begin
      if IsInclude(Options, ppWithTo) then
        cmdLineTo(PolyPoint[Poly, 0])
      else
        cmdMoveTo(PolyPoint[Poly, 0]);
      for Point := 1 to P^.PolyPolygon.aPolyCounts[Poly] - 1 do
        cmdLineTo(PolyPoint[Poly, Point]);
      if IsInclude(Options, ppClose) then
        cmdCloseSubpath;
    end;
  end;
end;

procedure TEMFtoPDFExport.cmdPolyPolyLine16(Options: Integer = 0);
var
  Poly, Point: Integer;
begin
  with FEMRList.Last as TEMRPolyPolygon16Obj do
  begin
    for Poly := 0 to P^.PolyPolygon16.nPolys - 1 do
    begin
      if IsInclude(Options, ppWithTo) then
        cmdLineTo(PolyPoint[Poly, 0])
      else
        cmdMoveTo(PolyPoint[Poly, 0]);
      for Point := 1 to P^.PolyPolygon16.aPolyCounts[Poly] - 1 do
        cmdLineTo(PolyPoint[Poly, Point]);
      if IsInclude(Options, ppClose) then
        cmdCloseSubpath;
    end;
  end;
end;

procedure TEMFtoPDFExport.cmdRestoreGraphicsState;
begin
  PutLF('Q');
  FqQBalance := FqQBalance - 1;
end;

procedure TEMFtoPDFExport.cmdSaveGraphicsState;
begin
  PutLF('q');
  FqQBalance := FqQBalance + 1;
end;

procedure TEMFtoPDFExport.cmdSetClippingPath;
begin
  PutLF('W' + EvenOdd);
end;

procedure TEMFtoPDFExport.cmdSetFillColor(Color: TColor);
begin
  PutLF(Color2Str(Color) + ' rg'); // Set RGB color for nonstroking operations
end;

procedure TEMFtoPDFExport.cmdSetFillFilter;
begin
  if not FDC.IsPathBracketOpened and not IsNullBrush then
  begin
    TFiller(FFiller).Init;
    case TFiller(FFiller).FillerType of
      ftSolidColor:
        cmdSetFillColor(TFiller(FFiller).SolidColor);
      ftPatternBitmap:
        cmdSetFillPatternBitmap(TFiller(FFiller).Bitmap)
    else
      raise Exception.Create('Wrong Filler Type');
    end;
  end;
end;

procedure TEMFtoPDFExport.cmdSetFillPatternBitmap(Bitmap: TBitmap);
const
  ForPattern = True;
  MinPatternSize = 32;
var
  PicIndex, PatIndex: Integer;
  Factor: Double;
  BM: TBitmap;
begin
  if Bitmap.PixelFormat = pf32bit then
    PicIndex := FPOH.OutTransparentGraphic(Bitmap)
  else
  begin
    Factor := MinPatternSize / Sqrt(Bitmap.Width * Bitmap.Height);
    if Factor > 1.0 then
    begin
      BM := CreateWidenedBitmap(Factor, Bitmap);
      try
        PicIndex := BitmapSave(ZeroRect, BM, ForPattern);
      finally
        BM.Free;
      end;
    end
    else
      PicIndex := BitmapSave(ZeroRect, Bitmap, ForPattern);
  end;

  PatIndex := FPOH.OutPattern(PicIndex, Bitmap.Width, Bitmap.Height);
  PutCRLF('/Pattern cs');
  PutCRLF('/P' + IntToStr(PatIndex) + ' scn');
end;

procedure TEMFtoPDFExport.cmdSetLineCap(PenEndCap: Integer);
begin
  if FForceButtLineCap then
    PutLF('2 J')
  else
    case FDC.PenEndCap of
      PS_ENDCAP_ROUND:
        PutLF('1 J');
      PS_ENDCAP_SQUARE:
        PutLF('2 J');
    else // PS_ENDCAP_FLAT
        PutLF('0 J');
    end;
end;

procedure TEMFtoPDFExport.cmdSetLineDashPattern(PenStyle: LongWord; Width: Extended);
begin
  PutLF('[' + PenStyle2Str(PenStyle, Width) + '] 0 d');
end;

procedure TEMFtoPDFExport.cmdSetLineJoin(PenLineJoin: Integer);
begin
  if FForceMitterLineJoin then
    PutLF('0 j')
  else
    case FDC.PenLineJoin of
      PS_JOIN_ROUND:
        PutLF('1 j');
      PS_JOIN_BEVEL:
        PutLF('2 j');
    else // PS_JOIN_MITER
        PutLF('0 j');
    end;

end;

procedure TEMFtoPDFExport.cmdSetLineWidth(PDFWidth: string);
begin
  PutLF(PDFWidth + ' w');
end;

procedure TEMFtoPDFExport.cmdSetLineWidth(Width: Extended);
begin
  cmdSetLineWidth(Float2Str(Width, 2));
end;

procedure TEMFtoPDFExport.cmdSetMiterLimit(MiterLimit: Extended);
begin
  PutLF(Float2Str(MiterLimit) + ' M');
end;

procedure TEMFtoPDFExport.cmdSetStroke;
begin
  if not FDC.IsPathBracketOpened and not IsNullPen then
  begin
    cmdSetLineDashPattern(FDC.PenStyle, pdfSize(FDC.PenWidth));
    cmdSetStrokeColor(FDC.PenColor);
    cmdSetLineWidth(pdfSize(FDC.PenWidth));
    cmdSetMiterLimit(FDC.MiterLimit);
    cmdSetLineCap(FDC.PenEndCap);
    cmdSetLineJoin(FDC.PenLineJoin);
  end;
end;

procedure TEMFtoPDFExport.cmdSetStrokeColor(Color: TColor);
begin
  PutLF(Color2Str(Color) + ' RG'); // Set RGB color for stroking operations
end;

procedure TEMFtoPDFExport.cmdTranslationAndScaling(Sx, Sy, Tx, Ty: Extended);
begin
  PutLF(Float2Str(Sx) + ' 0 0 ' + Float2Str(Sy) + ' ' +
        Float2Str(Tx, FPrecision) + ' ' + Float2Str(Ty, FPrecision) + ' cm');
end;

procedure TEMFtoPDFExport.cmd_AngleArc(Center, Radius: TfrxPoint; StartAngle, SweepAngle: Single);
const
  MaxAnglePerCurve = 45;
var
  n, i: Integer;
  ActualArcAngle: Double;
  Bezier: TBezierResult;
begin
  n := Ceil(Abs(SweepAngle / MaxAnglePerCurve));
  ActualArcAngle := SweepAngle / n;
  for i := 0 to n - 1 do
  begin
    Bezier := BezierCurve(Center, Radius, StartAngle + i * ActualArcAngle, ActualArcAngle);
  	if i = 0 then
      cmdMoveTo(Bezier.P0);
    cmdAppendCurvedSegment3(Bezier.P1, Bezier.P2, Bezier.P3);
  end;
end;

procedure TEMFtoPDFExport.cmd_RoundRect(l, t, r, b, rx, ry: Extended);
  procedure Corner(x1, y1, x2, y2, x3, y3: Extended);
  begin
    PutLF(Float2Str(x1, FPrecision) + ' ' + Float2Str(y1, FPrecision) + ' ' +
          Float2Str(x2, FPrecision) + ' ' + Float2Str(y2, FPrecision) + ' ' +
          Float2Str(x3, FPrecision) + ' ' + Float2Str(y3, FPrecision) + ' c');
  end;
begin
  CmdMoveTo(l + rx, b);
  CmdLineTo(r - rx, b); // bottom
  Corner(r - rx / 2, b, r, b + ry / 2, r, b + ry);  // right-bottom
  CmdLineTo(r, t - ry); // right
  Corner(r, t - ry / 2, r - rx / 2, t, r - rx, t);  // right-top
  CmdLineTo(l + rx, t); // top
  Corner(l + rx / 2, t, l, t - ry / 2, l, t - ry);  // left-top
  CmdLineTo(l, b + ry); // left
  Corner(l, b + ry / 2, l + rx / 2, b, l + rx, b);  // left-bottom
end;

procedure TEMFtoPDFExport.Comment(CommentString: string);
begin
  if CommentString <> '' then
    PutCRLF('%--'+ CommentString)
  else if ShowComments then
  begin
    CommentAboutRealization;
    PutCRLF('%--' + Parsing);
  end;
end;

procedure TEMFtoPDFExport.CommentAboutRealization;
var
  CommandName, Value: string;
  i: Integer;
begin
  CommandName := Copy(Parsing, 1, Pos(' ', Parsing + ' ') - 1);
  if FRealizationList.IndexOf(CommandName) <> -1 then // OK
    Exit;
  i := FRealizationList.IndexOfName(CommandName);
  Value := frIfStr(i <> -1, FRealizationList.ValueFromIndex[i], '0');
  PutCRLF('% Realization: ' + Value);
end;

procedure TEMFtoPDFExport.CommentTextRect(rtl: TRect; Color: TColor = clRed);
var
  XFactor, YFactor: Extended;
  P1, P2: TfrxPoint;
begin
  XFactor := 1 / FDC.XFormScale.X;
  YFactor := 1 / FDC.XFormScale.Y;

  P1 := pdfFrxPoint(frxPoint(rtl.Left * XFactor, rtl.Top * YFactor));
  P2 := pdfFrxPoint(frxPoint(rtl.Right * XFactor, rtl.Bottom * YFactor));

  Comment('Comment ExtTextOutW.rclBounds >>>>>>');
  Comment(IntToStr(rtl.Left) + ', ' + IntToStr(rtl.Right) +
    ' (' + IntToStr(rtl.Right - rtl.Left) + ') -=> ' +
    frFloat2Str(P1.X, 2) + ', ' + frFloat2Str(P2.X, 2) +
    ' (' + frFloat2Str(P2.X - P1.X, 2) + ')');
  cmdSaveGraphicsState;
  PutLF('[] 0 d');
  cmdSetLineWidth(0.25);

  cmdMoveTo(P1.X, P1.Y);
  cmdLineTo(P1.X, P2.Y);
  cmdLineTo(P2.X, P1.Y);
  cmdLineTo(P2.X, P2.Y);
  cmdSetStrokeColor(Color);
  PutLF('S');

  cmdRestoreGraphicsState;
  Comment('Comment ExtTextOutW.rclBounds <<<<<<');
end;

constructor TEMFtoPDFExport.Create(InStream: TMemoryStream; OutStream: TStream; APDFRect: TfrxRect; APOH: TPDFObjectsHelper);
begin
  inherited Create(InStream, OutStream);
  FPDFRect := APDFRect;
  FPOH := APOH;
  FLastClipRect := Rect(0, 0, 0, 0);

  FForceMitterLineJoin := False;
  FForceButtLineCap := False;
  FForceNullBrush := False;
  FTransparency := False;
  FForceAnsi := False;
  FClipped := True;
  FPictureDPI := 0;
  FPrecision := 2;

  FRotation2D := TRotation2D.Create;

  FFiller := TFiller.Create(Self);

  FIsPreviousAlpha := False;

  FRealizationList := TStringList.Create;
  FRealizationList.NameValueSeparator := '=';
  RealizationListFill([
    'EMR_AbortPath=?',
    'EMR_AngleArc',
    'EMR_Arc',
    'EMR_AlphaBlend',
    'EMR_BeginPath',
    'EMR_BitBlt',
    'EMR_BrushOrgEx',
    'EMR_CloseFigure',
    'EMR_CreateDIBPatternBrushPt',
    'EMR_CreateBrushIndirect',
    'EMR_CreateMonoBrush',
    'EMR_CreatePen',
    'EMR_DeleteObject',
    'EMR_PolyDraw',
    'EMR_PolyDraw16',
    'EMR_Ellipse',
    'EMR_EndPath',
    'EMR_EoF',
    'EMR_ExtCreateFontIndirectW',
    'EMR_ExtCreatePen',
    'EMR_ExtSelectClipRgn',
    'EMR_ExtTextOutW',
    'EMR_FillPath',
    'EMR_FillRgn',
    'EMR_GDIComment',
    'EMR_Header',
    'EMR_IntersectClipRect',
    'EMR_LineTo',
    'EMR_MaskBlt',
    'EMR_ModifyWorldTransform',
    'EMR_MoveToEx',
    'EMR_PolyBezier',
    'EMR_PolyBezier16',
    'EMR_PolyBezierTo',
    'EMR_PolyBezierTo16',
    'EMR_Polygon',
    'EMR_Polygon16',
    'EMR_Polyline',
    'EMR_Polyline16',
    'EMR_PolylineTo',
    'EMR_PolylineTo16',
    'EMR_PolyPolygon',
    'EMR_PolyPolygon16',
    'EMR_PolyPolyline',
    'EMR_PolyPolyline16',
    'EMR_Rectangle',
    'EMR_RestoreDC',
    'EMR_RoundRect',
    'EMR_SaveDC',
    'EMR_SelectClipPath',
    'EMR_SelectObject',
    'EMR_SetArcDirection',
    'EMR_SetBkColor',
    'EMR_SetBkMode',
    'EMR_SetICMMode',
    'EMR_SetLayout',
    'EMR_SetMetaRgn',
    'EMR_SetMiterLimit',
    'EMR_SetPolyFillMode',
    'EMR_SetRop2',
    'EMR_SetTextAlign',
    'EMR_SetTextColor',
    'EMR_SetStretchBltMode',
    'EMR_SetWorldTransform',
    'EMR_StretchDIBits',
    'EMR_StretchBlt',
    'EMR_StrokeAndFillPath',
    'EMR_StrokePath',
    'EMR_TransparentBlt'
  ]);
end;

procedure TEMFtoPDFExport.DCCreate;
begin
  FDC := TPDFDeviceContext.Create;
end;

destructor TEMFtoPDFExport.Destroy;
begin
  FRotation2D.Free;
  FRealizationList.Free;
  FFiller.Free;

  inherited;
end;

procedure TEMFtoPDFExport.DoEMR_AlphaBlend;
begin
  inherited;

  with PLast^.AlphaBlend do
    cmdBitMap32(Bounds(xDest, yDest, cxDest, cyDest), dwRop,
      FEMRList.Last as TEMRAlphaBlendObj);
//    cmdBitMap(Bounds(xDest, yDest, cxDest, cyDest), dwRop,
//      FEMRList.Last as TEMRAlphaBlendObj);
end;

procedure TEMFtoPDFExport.DoEMR_AngleArc;
begin
  inherited;

  DrawFigureStart(ppStroke);

  cmdAppendAngleArcToPath(PLast^.AngleArc);

  DrawFigureFinish(ppStroke);
end;

procedure TEMFtoPDFExport.DoEMR_Arc;
begin
  inherited;

  DrawFigureStart(ppStroke);

  cmdAppendArcToPath(PLast^.Arc);

  DrawFigureFinish(ppStroke);
end;

procedure TEMFtoPDFExport.DoEMR_BitBlt;
begin
  inherited;

  with PLast^.BitBlt do
    cmdBitMap(Bounds(xDest, yDest, cxDest, cyDest), dwRop, FEMRList.Last as TEMRBitBltObj);
end;

procedure TEMFtoPDFExport.DoEMR_CloseFigure;
begin
  inherited;

  cmdCloseSubpath;
end;

procedure TEMFtoPDFExport.DoEMR_CreateDIBPatternBrushPt;
begin // not supported
  inherited DoEMR_CreateDIBPatternBrushPt;

  FEMRLastCreated[PLast^.SelectObject.ihObject] :=
    StockObject(NULL_BRUSH + ENHMETA_STOCK_OBJECT);
end;

procedure TEMFtoPDFExport.DoEMR_Ellipse;
begin
  inherited;

  DrawFigureStart(ppFill + ppStroke);

  cmdAppendEllipsToPath(PLast^.Ellipse.rclBox);

  DrawFigureFinish(ppFill + ppStroke);
end;

procedure TEMFtoPDFExport.DoEMR_EoF;
begin
  inherited;

  while FqQBalance > 0 do
    cmdRestoreGraphicsState;
end;

procedure TEMFtoPDFExport.DoEMR_ExtSelectClipRgn;
begin
  inherited DoEMR_ExtSelectClipRgn;

  case PLast^.ExtSelectClipRgn.iMode of
    RGN_AND:
      cmdCreateExtSelectClipRgn;
    RGN_OR,
    RGN_XOR,
    RGN_DIFF:
      Comment('Ignored ExtSelectClipRgn.iMode'); // Implement when data with this iMode is found
    RGN_COPY:
      begin
// https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-emf/c6b9f4e6-27f6-4a4d-a383-c2daf5da11d9
// If RegionMode is RGN_COPY, this data can be omitted and the clipping region SHOULD be set to the default clipping region.
        cmdRestoreGraphicsState;
        cmdSaveGraphicsState;
      end;
  end;
end;

procedure TEMFtoPDFExport.DoEMR_ExtTextOutW;

  function IsCompatible: Boolean;
  begin
    Result := PLast^.ExtTextOutW.iGraphicsMode = GM_COMPATIBLE;
  end;

  function IsAdvanced: Boolean;
  begin
    Result := PLast^.ExtTextOutW.iGraphicsMode = GM_ADVANCED;
  end;

  procedure DrawRotation(var pdfTextPosition: TfrxPoint);
  var
    LineOrientation, SumOrientation: LongInt; // specifies the angle, in tenths of degrees
    SumRadian: Single;
  begin
    if IsAdvanced then
      LineOrientation := FDC.LineOrientation
    else // GM_COMPATIBLE
      LineOrientation := 0;

    SumOrientation := FDC.FontOrientation + LineOrientation;
    if SumOrientation <> 0 then
    begin
      SumRadian := SumOrientation / 10.0 * Pi / 180.0;
      FRotation2D.Init(SumRadian, frxPoint(0.0, 0.0), FPrecision);
      PutLF(FRotation2D.Matrix + ' cm');
      pdfTextPosition := FRotation2D.Turn(pdfTextPosition);
    end;
  end;

var
  EMRExtTextOutWObj: TEMRExtTextOutWObj;
  Font: TEMFFont;
  RS: TRemapedString;

  function pdfDX: TDoubleArray;
  var
    i: Integer;
    OutputDx: TLongWordDinArray;
    SC: TEMFPDFSizeConverter;
  begin
    SC := TEMFPDFSizeConverter.Create(Self);
    try
      OutputDx := EMRExtTextOutWObj.OutputDx;

      SetLength(Result, Length(OutputDx));
      for i := 0 to High(OutputDx) do
      begin
        SC.Log := LongInt(OutputDx[i]);
        Result[i] := SC.Char;
      end;
    finally
      SC.Free;
    end;
  end;

var
  FontIndex: Integer;
  MovedTextPosition, ShiftSign, pdfTextPosition: TfrxPoint;
  Simulation: string;
  SimulateBold: Boolean;
  AlCorr: TfrxPoint; // Alignment correction
  IsRTLLanguage, IsRTLOptions, IsGlyphOut: Boolean;
  LogRect: TRect;
  XFactor, YFactor: Extended;
  R: TfrxRect;
  RoundFontSize: Integer;
  AverageDx: Boolean;
const
  YCorr: array[TfrxVAlign] of Extended = (0.92, -0.23, 0.0);
  XCorr: array[TfrxHalign] of Extended = (0.0, -1.0, -0.5, 0.0);

  procedure DoOutputString(const AOutputString: WideString);
  var
    pdfFont: TfrxPDFFont;
  begin
    if AOutputString = '' then Exit;
    Font := FontCreate;
    try
      with PLast^.ExtTextOutW do
        if IsInclude(emrtext.fOptions, ETO_CLIPPED) then
        begin
          cmdAppendRectangleToPath(emrtext.rcl, IsCompatible);
          cmdSetClippingPath;
          cmdPathPainting(ppEnd);
        end;

      AlCorr.X := Sin(FDC.FontRadian) * YCorr[FDC.VAlign] * FDC.FontSize
        + Cos(FDC.FontRadian) * XCorr[FDC.HAlign] * EMRExtTextOutWObj.TextLength;
      AlCorr.Y := Cos(FDC.FontRadian) * YCorr[FDC.VAlign] * FDC.FontSize +
        - Sin(FDC.FontRadian) * XCorr[FDC.HAlign] * EMRExtTextOutWObj.TextLength;
      ShiftSign := frxPoint(1.0, 1.0);
      if IsCompatible then // Need testing for GM_ADVANCED
        ShiftSign := frxPoint(Sign(FDC.XForm.eM11), Sign(FDC.XForm.eM22));

      with PLast^.ExtTextOutW.emrtext.ptlReference do
        MovedTextPosition := frxPoint(
          X + ShiftSign.X * (AlCorr.X),
          Y + ShiftSign.Y * (AlCorr.Y - FDC.FontSize * (1.0 - Font.DownSizeFactor)));

      pdfTextPosition := pdfFrxPoint(MovedTextPosition);
      { cut all bottom outbound text }
      if FClipped and (LogRect.Bottom = LogRect.Top) and (FLastClipRect.Bottom <> 0) and
        (FLastClipRect.Bottom < MovedTextPosition.Y) then
        Exit;

      { TODO : Needs rework }
      if (FDC.FontFamily = 'Cambria Math') then
      begin
        R := pdfFrxRect(LogRect);
        pdfTextPosition.Y := pdfTextPosition.Y
          - (R.Top - R.Bottom - Font.Size) / 2.25;
      end
      else if (FDC.FontFamily = 'Segoe UI Symbol') then
      begin
        R := pdfFrxRect(LogRect);
        pdfTextPosition.Y := pdfTextPosition.Y
          - (R.Top - R.Bottom - Font.Size) / 2.5;
      end;

      DrawRotation({var} pdfTextPosition);
      if  (FDC.FontOrientation > -1800) and (FDC.FontOrientation <= -1) and
          (FDC.XForm.eM22 < 0) and IsCompatible then
        PutLF('-1 0 0 -1 ' +
          Float2Str(2 * pdfTextPosition.X, FPrecision) + ' ' +
          Float2Str(2 * (pdfTextPosition.Y + Font.PreciseSize * (1 - tpPt)), FPrecision) +
          ' cm');

      if FPOH.IsBBox then
      begin
        PutLF('/Tx BMC');
        cmdSaveGraphicsState;
      end;

      PutLF('BT'); // Begin text object

      FontIndex := FPOH.GetObjFontNumber(Font);

      if IsAdvanced then
        PutLF(FPOH.Fonts[FontIndex].Name +
          AnsiString(' ' + Float2Str(Font.PreciseSize * (1 - tpPt)) + ' Tf'))
      else
        PutLF(FPOH.Fonts[FontIndex].Name +
          AnsiString(' ' + Float2Str(EMFPDFFontSize(Font), 3) + ' Tf'));

      PutLF('[] 0 d');

      cmdSetFillColor(Font.Color);

      PutLF(frxPoint2Str(pdfTextPosition, FPrecision) + ' Td'); // Move text position

      pdfFont := FPOH.Fonts[FontIndex];
      pdfFont.ForceAnsi := FForceAnsi;
      try
        pdfFont.SameCharacterWidth := IsSameCharacterWidth(FDC.FontFamily);
        try
          RS := pdfFont.SoftRemapString(AOutputString, IsRTLOptions, IsGlyphOut);
        finally
          pdfFont.SameCharacterWidth := False;
        end;

        RoundFontSize := Round(pdfSize(FDC.FontSize));
        AverageDx := RoundFontSize <= 20;
      finally
        pdfFont.ForceAnsi := False;
      end;

      if IsNeedsItalicSimulation(Font, Simulation) then
        PutLF(Simulation + ' ' + frxPoint2Str(pdfTextPosition) + ' Tm');
      SimulateBold := IsNeedsBoldSimulation(Font, Simulation);
      if SimulateBold then
        PutLF(Simulation);

      if IsRTLOptions or not RS.IsValidCharWidth or RS.IsHasLigatures then
        PutLF('<' + StrToHex(RS.Data) + '> Tj') // Show text
      else
        PutLF('[<' + StrToHexDx(RS, pdfDX, AverageDx) + '>] TJ');

      PutLF('ET'); // End text object

      if FPOH.IsBBox then
      begin
        PutLF('EMC');
        cmdRestoreGraphicsState;
      end;

      if SimulateBold then
        PutLF('0 Tr');

      if FDC.FontUnderline or FDC.FontStrikeOut then
        if PLast^.ExtTextOutW.iGraphicsMode = GM_ADVANCED then
          DrawFontLines(Font.PreciseSize, pdfTextPosition, pdfSize(EMRExtTextOutWObj.TextLength))
        else
          DrawFontLines(Font.Size, pdfTextPosition, pdfSize(EMRExtTextOutWObj.TextLength));

    finally
      Font.Free;
    end;
  end;

begin
  inherited DoEMR_ExtTextOutW;

  cmdSaveGraphicsState;

  with PLast^.ExtTextOutW do
    if IsInclude(emrtext.fOptions, ETO_OPAQUE) then // Use BkColor
    begin
      cmdSetFillColor(FDC.BkColor);
      cmdAppendRectangleToPath(emrtext.rcl, IsCompatible);
      cmdPathPainting(ppFill);
    end;

  XFactor := 1 / FDC.XFormScale.X;
  YFactor := 1 / FDC.XFormScale.Y;
  with PLast^.ExtTextOutW.rclBounds do
    LogRect := Rect(Floor((Left - FDC.DeviceTopLeft.X) * XFactor),
                    Floor((Top - FDC.DeviceTopLeft.Y) * YFactor),
                    Ceil((Right  - FDC.DeviceTopLeft.X)* XFactor),
                    Ceil((Bottom - FDC.DeviceTopLeft.Y) * YFactor));

  if FDC.BkMode = OPAQUE then
  begin
    cmdSetFillFilter;
    cmdAppendRectangleToPath(LogRect);
    cmdPathPainting(ppFill);
  end;

  IsRTLOptions := IsInclude(PLast^.ExtTextOutW.emrtext.fOptions, ETO_RTLREADING)
               or IsInclude(FDC.TextAlignmentMode, TA_RTLREADING)
               or IsInclude(FDC.Layout, EMR_LAYOUT_RTL);
  IsRTLLanguage := IsRTLOptions and
    (FDC.FontCharSet in [ARABIC_CHARSET, HEBREW_CHARSET]);
  IsGlyphOut := not IsRTLLanguage and
    IsInclude(PLast^.ExtTextOutW.emrtext.fOptions, ETO_GLYPH_INDEX);
  { disable back conversion in OutputString }
  if IsGlyphOut then
    PLast^.ExtTextOutW.emrtext.fOptions := PLast^.ExtTextOutW.emrtext.fOptions and not ETO_GLYPH_INDEX;

  EMRExtTextOutWObj := FEMRList.Last as TEMRExtTextOutWObj;

  DoOutputString(EMRExtTextOutWObj.OutputString(FDC.FontFamily, IsRTLLanguage));

  cmdRestoreGraphicsState;
end;

procedure TEMFtoPDFExport.DoEMR_FillPath;
begin
  inherited DoEMR_FillPath;

  cmdSetFillFilter;

  cmdPathPainting(ppFill);
end;

procedure TEMFtoPDFExport.DoEMR_FillRgn;
var
  PRD: PRgnData;
  RectCount, i: Integer;
  R: TRect;
begin
  inherited DoEMR_FillRgn;

  cmdSaveGraphicsState;

  PRD := @PLast^.FillRgn.RgnData;
  RectCount := PRD^.rdh.nCount;

  TFiller(FFiller).ihBrush := PLast^.FillRgn.ihBrush;
  cmdSetFillFilter;

  for i := 0 to RectCount - 1 do
  begin
    Move(PRD^.Buffer[i * SizeOf(TRect)], R, SizeOf(TRect));
    cmdAppendRectangleToPath(R);
  end;

  cmdPathPainting(ppFill);

  cmdRestoreGraphicsState;
end;

procedure TEMFtoPDFExport.DoEMR_Header;
var
  rWidth, rHeight: double;
begin
  inherited DoEMR_Header;

  with PLast^.Header do
  begin
    rWidth := szlDevice.cx / szlMillimeters.cx * (rclFrame.Right - rclFrame.Left) / 100;
    rHeight := szlDevice.cy / szlMillimeters.cy * (rclFrame.Bottom - rclFrame.Top) / 100;
  end;

  FEMFtoPDFFactor := frxPoint(
    (FPDFRect.Right - FPDFRect.Left) / rWidth,
    (FPDFRect.Top - FPDFRect.Bottom) / rHeight);

  FqQBalance := 0;
end;

procedure TEMFtoPDFExport.DoEMR_IntersectClipRect;
begin
  inherited DoEMR_IntersectClipRect;

  with PLast^.IntersectClipRect.rclClip do
    if (Right = Left) or (Bottom = Top) then
      Exit;
  FLastClipRect := PLast^.IntersectClipRect.rclClip;
  cmdAppendRectangleToPath(PLast^.IntersectClipRect.rclClip);
  cmdSetClippingPath;
  cmdPathPainting(ppEnd);
end;

procedure TEMFtoPDFExport.DoEMR_LineTo;
begin
  inherited;
  // Specifies a line from the current position up to the specified point.

  DrawFigureStart(ppStroke + ppWithTo);

  cmdLineTo(FDC.PositionNext);

  DrawFigureFinish(ppStroke + ppWithTo);
end;

procedure TEMFtoPDFExport.DoEMR_MaskBlt;
begin
  inherited;

  with PLast^.MaskBlt do
    cmdBitMap(Bounds(xDest, yDest, cxDest, cyDest), dwRop, FEMRList.Last as TEMRBitBltObj);
end;

procedure TEMFtoPDFExport.DoEMR_MoveToEx;
begin
  inherited;

  cmdMoveTo(FDC.PositionNext);
end;

procedure TEMFtoPDFExport.DoEMR_Pie;
begin
  inherited;

  DrawFigureStart(ppClose + ppFill + ppStroke);

  cmdAppendPieToPath(PLast^.Pie);

  DrawFigureFinish(ppClose + ppFill + ppStroke);
end;

procedure TEMFtoPDFExport.DoEMR_PolyBezier;
begin
  inherited;

  DrawFigureStart(ppStroke);

  cmdPolyBezier;

  DrawFigureFinish(ppStroke);
end;

procedure TEMFtoPDFExport.DoEMR_PolyBezier16;
begin
  inherited;

  DrawFigureStart(ppStroke);

  cmdPolyBezier16;

  DrawFigureFinish(ppStroke);
end;

procedure TEMFtoPDFExport.DoEMR_PolyBezierTo;
begin
  inherited;

  DrawFigureStart(ppStroke + ppWithTo);

  cmdPolyBezier(ppWithTo);

  DrawFigureFinish(ppStroke + ppWithTo);
end;

procedure TEMFtoPDFExport.DoEMR_PolyBezierTo16;
begin
  inherited;
// Specifies one or more Bezier curves based on the current position.

  DrawFigureStart(ppStroke + ppWithTo);

  cmdPolyBezier16(ppWithTo);

  DrawFigureFinish(ppStroke + ppWithTo);
end;

procedure TEMFtoPDFExport.DoEMR_PolyDraw;
var
  Point, T, Count: Integer;
begin
  inherited;

  DrawFigureStart(ppStroke);

  Point := 0;
  Count := PLast^.PolyDraw.cptl;
  with FEMRList.Last as TEMRPolyDrawObj do
    while Point <= Count - 1 do
    begin
      T := Types[Point];
      if IsInclude(T, PT_MOVETO) {PT_MOVETO - MUST be first test} then
        cmdMoveTo(P.PolyDraw.aptl[Point])
      else if IsInclude(T, PT_LINETO) then
        cmdLineTo(P.PolyDraw.aptl[Point])
      else if IsInclude(T, PT_BEZIERTO) then
        if      Point + 2 <= Count - 1 then
        begin
          cmdAppendCurvedSegment3(P.PolyDraw.aptl[Point],
            P.PolyDraw.aptl[Point + 1],
            P.PolyDraw.aptl[Point + 2]);
          Point := Point + 2;
        end
        else if Point + 1 <= Count - 1 then
        begin
          cmdAppendCurvedSegment2final(P.PolyDraw.aptl[Point],
            P.PolyDraw.aptl[Point + 1]);
          Point := Point + 1;
        end;

      if IsInclude(T, PT_CLOSEFIGURE) then
        cmdCloseSubpath;

      Point := Point + 1;
    end;

  DrawFigureFinish(ppStroke);
end;

procedure TEMFtoPDFExport.DoEMR_PolyDraw16;
var
  Point, T, Count: Integer;
begin
  inherited;

  DrawFigureStart(ppStroke);

  Point := 0;
  Count := PLast^.PolyDraw16.cpts;
  with FEMRList.Last as TEMRPolyDraw16Obj do
    while Point <= Count - 1 do
    begin
      T := Types[Point];
      if IsInclude(T, PT_MOVETO) {PT_MOVETO - MUST be first test} then
        cmdMoveTo(P.PolyDraw16.apts[Point])
      else if IsInclude(T, PT_LINETO) then
        cmdLineTo(P.PolyDraw16.apts[Point])
      else if IsInclude(T, PT_BEZIERTO) then
        if      Point + 2 <= Count - 1 then
        begin
          cmdAppendCurvedSegment3(P.PolyDraw16.apts[Point],
            P.PolyDraw16.apts[Point + 1],
            P.PolyDraw16.apts[Point + 2]);
          Point := Point + 2;
        end
        else if Point + 1 <= Count - 1 then
        begin
          cmdAppendCurvedSegment2final(P.PolyDraw16.apts[Point],
            P.PolyDraw16.apts[Point + 1]);
          Point := Point + 1;
        end;

      if IsInclude(T, PT_CLOSEFIGURE) then
        cmdCloseSubpath;

      Point := Point + 1;
    end;

  DrawFigureFinish(ppStroke);
end;

procedure TEMFtoPDFExport.DoEMR_Polygon;
begin
  inherited;

  if PLast^.Polyline.cptl > 1 then
  begin
    DrawFigureStart(ppFill + ppStroke);

    cmdPolyLine(ppClose);

    DrawFigureFinish(ppFill + ppStroke);
  end;
end;

procedure TEMFtoPDFExport.DoEMR_Polygon16;
begin
  inherited;
// The polygon SHOULD be outlined using the current pen and filled using
// the current brush and polygon fill mode. The polygon SHOULD be closed
// automatically by drawing a line from the last vertex to the first.

  if PLast^.Polyline16.cpts > 1 then
  begin
    DrawFigureStart(ppFill + ppStroke);

    cmdPolyLine16(ppClose);

    DrawFigureFinish(ppFill + ppStroke);
  end;
end;

procedure TEMFtoPDFExport.DoEMR_Polyline;
begin
  inherited;

  if PLast^.Polyline.cptl > 1 then
  begin
    DrawFigureStart(ppStroke);

    cmdPolyLine;

    DrawFigureFinish(ppStroke);
  end;
end;

procedure TEMFtoPDFExport.DoEMR_Polyline16;
begin
  inherited;

  if PLast^.Polyline16.cpts > 1 then
  begin
    DrawFigureStart(ppStroke);

    cmdPolyLine16;

    DrawFigureFinish(ppStroke);
  end;
end;

procedure TEMFtoPDFExport.DoEMR_PolylineTo;
begin
  inherited;

  if PLast^.Polyline.cptl > 1 then
  begin
    DrawFigureStart(ppStroke + ppWithTo);

    cmdPolyLine(ppWithTo);

    DrawFigureFinish(ppStroke + ppWithTo);
  end;
end;

procedure TEMFtoPDFExport.DoEMR_PolylineTo16;
begin
  inherited;

  if PLast^.Polyline16.cpts > 1 then
  begin
    DrawFigureStart(ppStroke + ppWithTo);

    cmdPolyLine16(ppWithTo);

    DrawFigureFinish(ppStroke + ppWithTo);
  end;
end;

procedure TEMFtoPDFExport.DoEMR_PolyPolygon;
begin
  inherited;

  if PLast^.PolyPolyline.nPolys > 0 then
  begin
    DrawFigureStart(ppFill + ppStroke);

    cmdPolyPolyLine(ppClose);

    DrawFigureFinish(ppFill + ppStroke);
  end;
end;

procedure TEMFtoPDFExport.DoEMR_PolyPolygon16;
begin
  inherited;

  if PLast^.PolyPolyline16.nPolys > 0 then
  begin
    DrawFigureStart(ppFill + ppStroke);

    cmdPolyPolyLine16(ppClose);

    DrawFigureFinish(ppFill + ppStroke);
  end;
end;

procedure TEMFtoPDFExport.DoEMR_PolyPolyline;
begin
  inherited;

  if PLast^.PolyPolyline.nPolys > 0 then
  begin
    DrawFigureStart(ppStroke);

    cmdPolyPolyLine(ppEnd);

    DrawFigureFinish(ppStroke);
  end;
end;

procedure TEMFtoPDFExport.DoEMR_PolyPolyline16;
begin
  inherited;

  if PLast^.PolyPolyline16.nPolys > 0 then
  begin
    DrawFigureStart(ppStroke);

    cmdPolyPolyLine16(ppEnd);

    DrawFigureFinish(ppStroke);
  end;
end;

procedure TEMFtoPDFExport.DoEMR_Rectangle;
begin
  inherited DoEMR_Rectangle;

  DrawFigureStart(ppFill + ppStroke);

  cmdAppendRectangleToPath(PLast^.Rectangle.rclBox);

  DrawFigureFinish(ppFill + ppStroke);
end;

procedure TEMFtoPDFExport.DoEMR_RestoreDC;
var
  i: Integer;
begin
  inherited DoEMR_RestoreDC;

  for i := PLast^.RestoreDC.iRelative to -1 do
    cmdRestoreGraphicsState;
end;

procedure TEMFtoPDFExport.DoEMR_RoundRect;
begin
  inherited;

  DrawFigureStart(ppFill + ppStroke);

  with PLast^ do
    cmdAppendRoundRectToPath(RoundRect.rclBox, RoundRect.szlCorner);

  DrawFigureFinish(ppFill + ppStroke);
end;

procedure TEMFtoPDFExport.DoEMR_SaveDC;
begin
  inherited DoEMR_SaveDC;

  cmdSaveGraphicsState;
end;

procedure TEMFtoPDFExport.DoEMR_SelectClipPath;
begin
  inherited;

  cmdSetClippingPath;
  cmdPathPainting(ppEnd);
end;

procedure TEMFtoPDFExport.DoEMR_StretchBlt;
begin
  inherited;

  with PLast^.StretchBlt do
    cmdBitMap(Bounds(xDest, yDest, cxDest, cyDest), dwRop, FEMRList.Last as TEMRStretchBltObj);
end;

procedure TEMFtoPDFExport.DoEMR_StretchDIBits;
var
  NextEnhMetaObj: TEMRBitmap;
  Bitmap: TBitmap;
  pdfRect: TfrxRect;
  PicIndex: Integer;
begin
  inherited;

  if      FIsPreviousAlpha then
    FIsPreviousAlpha := False
  else if IsBitmapAsAlpha then
  begin
    FIsPreviousAlpha := True;
    NextEnhMetaObj := GetNextEnhMetaObj;
    Bitmap := GlueBitmap32(FEMRList.Last as TEMRBitmap, NextEnhMetaObj);
    NextEnhMetaObj.Free;

    with PLast^.StretchDIBits do
      pdfRect := pdfFrxRect(Bounds(xDest, yDest, cxDest, cyDest));
    PicIndex := FPOH.OutTransparentGraphic(Bitmap);
    ReferenceToImageXObject(PicIndex, pdfRect);

    Bitmap.Free;
  end
  else
    with PLast^.StretchDIBits do
      cmdBitMap(Bounds(xDest, yDest, cxDest, cyDest), dwRop, FEMRList.Last as TEMRStretchDIBitsObj);
end;

procedure TEMFtoPDFExport.DoEMR_StrokeAndFillPath;
begin
  inherited;

  cmdSetFillFilter;
  cmdSetStroke;

  cmdPathPainting(ppFill + ppStroke);
end;

procedure TEMFtoPDFExport.DoEMR_StrokePath;
begin
  inherited;

  cmdSetStroke;

  cmdPathPainting(ppStroke);
end;

procedure TEMFtoPDFExport.DoEMR_TransparentBlt;
begin
  inherited;

  with PLast^.TransparentBlt do
    cmdBitMap(Bounds(xDest, yDest, cxDest, cyDest), dwRop, FEMRList.Last as TEMRTransparentBltObj);
end;

procedure TEMFtoPDFExport.DoFinish;
begin
  inherited;

  cmdRestoreGraphicsState;
end;

procedure TEMFtoPDFExport.DoStart;
begin        // Before EMR_Header
  inherited;

  cmdSaveGraphicsState;

  if FClipped then
  begin
    PutLF(frxRect2Str(FPDFRect, FPrecision) + ' re');

    cmdSetClippingPath;
    cmdPathPainting(ppEnd);
  end;
end;

procedure TEMFtoPDFExport.DrawFigureFinish(Options: Integer);
begin
  if not FDC.IsPathBracketOpened then
  begin
    cmdPathPainting(FillStrokeOptions(Options));
    cmdRestoreGraphicsState;
    if IsInclude(Options, ppWithTo) then
      cmdMoveTo(FDC.PositionNext);
  end;
end;

procedure TEMFtoPDFExport.DrawFigureStart(Options: Integer);
begin
  if not FDC.IsPathBracketOpened then
  begin
    cmdSaveGraphicsState;
    if IsInclude(Options, ppFill) and not IsNullBrush then
      cmdSetFillFilter;
    if IsInclude(Options, ppStroke) and not IsNullPen then
      cmdSetStroke;
  end;
end;

procedure TEMFtoPDFExport.DrawFontLines(FontSize: Double; TextPosition: TfrxPoint; TextWidth: Extended);
  procedure DrawLine(Shift, Width: Extended);
  var
    Y: Extended;
  begin
    Y := TextPosition.Y + FontSize * Shift;

    cmdMoveTo(TextPosition.X, Y);
    cmdLineTo(TextPosition.X + TextWidth, Y);
    cmdSetLineWidth(Width);
    cmdPathPainting(ppStroke);
  end;
begin
  cmdSetLineDashPattern(PS_SOLID, 0);
  cmdSetStrokeColor(FDC.TextColor);

  if FDC.FontUnderline then
    DrawLine(UnderlineShift, FontSize * UnderlineWidth);
  if FDC.FontStrikeOut then
    DrawLine(StrikeOutShift, FontSize * StrikeOutWidth);
end;

function TEMFtoPDFExport.emfPoint2Str(emfSP: TSmallPoint): string;
begin
  Result := frxPoint2Str(pdfFrxPoint(emfSP), FPrecision);
end;

function TEMFtoPDFExport.emfPoint2Str(emfP: TPoint): string;
begin
  Result := frxPoint2Str(pdfFrxPoint(emfP), FPrecision);
end;

function TEMFtoPDFExport.emfPoint2Str(emfFP: TfrxPoint): string;
begin
  Result := frxPoint2Str(pdfFrxPoint(emfFP), FPrecision);
end;

//function TEMFtoPDFExport.emfPoint2Str(X, Y: Extended): string;
//begin
//  Result := frxPoint2Str(pdfFrxPoint(frxPoint(X, Y)), FPrecision);
//end;

//function TEMFtoPDFExport.emfRect2Str(emfR: TRect): string;
//begin
//  Result := frxRect2Str(pdfFrxRect(emfR), FPrecision);
//end;

//function TEMFtoPDFExport.emfSize2Str(emfSize: Extended): string;
//begin
//  Result := Float2Str(pdfSize(emfSize));
//end;

function TEMFtoPDFExport.EvenOdd: string;
begin
  Result := frIfStr(FDC.PolyFillMode = ALTERNATE, '*');
end;

function TEMFtoPDFExport.FillStrokeOptions(Options: Integer): Integer;
begin
  Result := frIfInt(IsInclude(Options, ppStroke) and not IsNullPen, ppStroke) +
            frIfInt(IsInclude(Options, ppFill) and not IsNullBrush, ppFill);
end;

function TEMFtoPDFExport.FontCreate: TEMFFont;
var
  FontIndex: Integer;
begin
  Result := inherited FontCreate;

  if FDC.IsFontHeight then
  begin
    FontIndex := FPOH.GetObjFontNumber(Result);
    Result.DownSizeFactor := FPOH.Fonts[FontIndex].FontHeightToPointSizeFactor;
  end
  else
    Result.DownSizeFactor := 1.0;

  Result.PreciseSize := pdfSize(FDC.FontSize * Result.DownSizeFactor);
  Result.Size := Round(Result.PreciseSize);
end;

function TEMFtoPDFExport.GetNextEnhMetaObj: TEMRBitmapROP;
var
  SavePosition: Int64;
begin
  SavePosition := FInStream.Position;
  try
    Result := TEMRStretchDIBitsObj.Create(FInStream, FLastRecord.nSize);
  finally
    FInStream.Position := SavePosition;
  end;
end;

function TEMFtoPDFExport.GlueBitmap32(EMRBitmapAlpha, EMRBitmap: TEMRBitmap): TBitmap;
var
  Alpha8: TBitmap;
  PQuad: PRGBQuad;
  PB: PByte;
  w, h: Integer;
begin
  Alpha8 := EMRBitmapAlpha.GetBitmap;
  Alpha8.PixelFormat := pf8bit;
  try
    Result := EMRBitmap.GetBitmap;
    Result.PixelFormat := pf32bit;

    for h := 0 to Result.Height - 1 do
    begin
      PQuad := Result.ScanLine[h];
      PB := Alpha8.ScanLine[h];
      for w := 0 to Result.Width - 1 do
      begin
        PQuad^.rgbReserved := PB^;
        Inc(PQuad);
        Inc(PB);
      end;
    end;
  finally
    Alpha8.Free;
  end;
end;

function TEMFtoPDFExport.IsBitmapAsAlpha: Boolean;
var
  SavePosition: Int64;
  S1, S2: TEMRStretchDIBits;
  EnhMetaObj: TEnhMetaObj;
begin
  Result := False;
  SavePosition := FInStream.Position;
  try
    InStreamLastRecord;
    if FLastRecord.iType = EMR_StretchDIBits then
    begin
      EnhMetaObj := TEnhMetaObj.Create(FInStream, FLastRecord.nSize);
      try
        S1 := PLast^.StretchDIBits;
        S2 := EnhMetaObj.P^.StretchDIBits;
        Result :=
          (S1.dwRop = SRCPAINT) and
          (S2.dwRop = SRCAND) and
          EqualRect(S1.rclBounds, S2.rclBounds) and
          (S1.xDest = S2.xDest) and (S1.yDest = S2.yDest) and
          (S1.cxDest = S2.cxDest) and (S1.cyDest = S2.cyDest);
      finally
        EnhMetaObj.Free;
      end;
    end;
  finally
    FInStream.Position := SavePosition;
  end;

end;

function TEMFtoPDFExport.IsNullBrush: Boolean;
begin
  Result := FForceNullBrush or
    (FDC.BrushStyle in [BS_NULL, BS_PATTERN8X8, BS_DIBPATTERN8X8, BS_MONOPATTERN]);

  if FDC.BrushStyle in [BS_PATTERN8X8, BS_DIBPATTERN8X8, BS_MONOPATTERN] then
    Comment(' DC.BrushStyle: ' + IntToStr(FDC.BrushStyle));
end;

function TEMFtoPDFExport.IsNullPen: Boolean;
begin
  Result := FDC.PenStyle in [PS_NULL];
end;

function TEMFtoPDFExport.IsSameCharacterWidth(FontName: string): Boolean;
begin
  Result := (Pos('Arial', FontName) = 1)
         or (Pos('Calibri', FontName) = 1)
         or (Pos('Cambria', FontName) = 1)
//         or (Pos('Garamond', FontName) = 1)
//         or (Pos('Georgia', FontName) = 1)
         or (Pos('Gotham', FontName) = 1)
         or (Pos('Meiryo', FontName) = 1)
//         or (Pos('Tahoma', FontName) = 1)
         or (Pos('Times New Roman', FontName) = 1)
//         or (Pos('Trebuchet MS', FontName) = 1)
//         or (Pos('Verdana', FontName) = 1)
         ;
end;

function TEMFtoPDFExport.NormalizeRect(const Rect: TRect): TRect;
begin
  Result := Rect;
  if Result.Left > Result.Right then
  begin
    Result.Left := Rect.Right;
    Result.Right := Rect.Left;
  end;
  if Result.Top > Result.Bottom then
  begin
    Result.Top := Rect.Bottom;
    Result.Bottom := Rect.Top;
  end;
end;

function TEMFtoPDFExport.pdfFrxPoint(emfP: TPoint): TfrxPoint;
begin
  Result := LogToDevPoint(emfP);
  Result.X := FPDFRect.Left + Result.X * FEMFtoPDFFactor.X;
  Result.Y := FPDFRect.Top - Result.Y * FEMFtoPDFFactor.Y;
end;

function TEMFtoPDFExport.pdfFrxPoint(emfSP: TSmallPoint): TfrxPoint;
begin
  Result := LogToDevPoint(emfSP);
  Result.X := FPDFRect.Left + Result.X * FEMFtoPDFFactor.X;
  Result.Y := FPDFRect.Top - Result.Y * FEMFtoPDFFactor.Y;
end;

function TEMFtoPDFExport.pdfFrxPoint(emfDP: TfrxPoint): TfrxPoint;
begin
  Result := LogToDevPoint(emfDP);
  Result.X := FPDFRect.Left + Result.X * FEMFtoPDFFactor.X;
  Result.Y := FPDFRect.Top - Result.Y * FEMFtoPDFFactor.Y;
end;

function TEMFtoPDFExport.pdfFrxRect(emfR: TRect): TfrxRect;
var
  TopLeft, BottomRight: TfrxPoint;
begin
  TopLeft := pdfFrxPoint(emfR.TopLeft);
  BottomRight := pdfFrxPoint(emfR.BottomRight);

  Result.Left := Min(TopLeft.X, BottomRight.X);
  Result.Right := Max(TopLeft.X, BottomRight.X);

  Result.Top := Max(TopLeft.Y, BottomRight.Y);    // Max !
  Result.Bottom := Min(TopLeft.Y, BottomRight.Y); // Min !
end;

function TEMFtoPDFExport.pdfSize(emfSize: Extended): Extended;
begin
  Result := LogToDevSize(emfSize) * (FEMFtoPDFFactor.X + FEMFtoPDFFactor.Y) / 2;
end;

procedure TEMFtoPDFExport.Put(const S: AnsiString);
begin
  FOutStream.Write(S[1], Length(S));
end;

procedure TEMFtoPDFExport.PutCRLF(const S: AnsiString);
begin
  Put(S + AnsiString(#13#10));
end;

procedure TEMFtoPDFExport.PutLF(const S: AnsiString);
begin
  Put(S + AnsiString(#10));
end;

{$IFDEF DELPHI12}
procedure TEMFtoPDFExport.PutCRLF(const S: string);
begin
  PutCRLF(AnsiString(S));
end;

procedure TEMFtoPDFExport.PutLF(const S: string);
begin
  PutLF(AnsiString(S));
end;
{$ENDIF}

procedure TEMFtoPDFExport.RealizationListFill(RealizedCommands: array of string);
var
  i: Integer;
begin
  for i := Low(RealizedCommands) to High(RealizedCommands) do
    FRealizationList.Add(RealizedCommands[i]);
end;

procedure TEMFtoPDFExport.ReferenceToImageXObject(PicIndex: Integer; pdfRect: TfrxRect);
begin
  FPOH.PageXObjects.Add(PicIndex);

  cmdSaveGraphicsState;
  cmdTranslationAndScaling(pdfRect.Right - pdfRect.Left,
    pdfRect.Top - pdfRect.Bottom, pdfRect.Left, pdfRect.Bottom);
  PutCRLF('/Im' + IntToStr(PicIndex) + ' Do');
  cmdRestoreGraphicsState;
end;

{ TEMFPDFSizeConverter }

constructor TEMFPDFSizeConverter.Create(AExport: TEMFtoPDFExport);
begin
  FExport := AExport;
  FEMFPDFFactor := FExport.FEMFtoPDFFactor.X;
  FFont := FExport.FontCreate;
end;

destructor TEMFPDFSizeConverter.Destroy;
begin
  FFont.Free;
  inherited;
end;

function TEMFPDFSizeConverter.LogToDev(Value: Double): Double;
begin
  Log := Value;
  Result := Dev;
end;

procedure TEMFPDFSizeConverter.SetChar(const Value: Double);
begin
  FChar := Value;

  FDev := FChar * FFont.Size / 1000 / FEMFPDFFactor;

  FPDF := FDev * FEMFPDFFactor;

  FLog := FDev * FEXport.FDC.XFormAverageScale;
end;

procedure TEMFPDFSizeConverter.SetDev(const Value: Double);
begin
  FDev := Value;

  FPDF := FDev * FEMFPDFFactor;

  FChar := FDev * 1000 / Max(1, FFont.Size) * FEMFPDFFactor;

  FLog := FDev * FEXport.FDC.XFormAverageScale;
end;

procedure TEMFPDFSizeConverter.SetLog(const Value: Double);
begin
  FLog := Value;

  FDev := FExport.LogToDevSizeX(FLog);

  FPDF := FDev * FEMFPDFFactor;

  FChar := FDev * 1000 / Max(1, FFont.Size) * FEMFPDFFactor;
end;

procedure TEMFPDFSizeConverter.SetPDF(const Value: Double);
begin
  FPDF := Value;

  FDev := FPDF / FEMFPDFFactor;

  FChar := FDev * 1000 / Max(1, FFont.Size) * FEMFPDFFactor;

  FLog := FDev * FEXport.FDC.XFormAverageScale;
end;

{ TFiller }

constructor TFiller.Create(AExport: TEMFtoPDFExport);
begin
  FExport := AExport;
  FBitmap := nil;
  FihBrush := Unknown;
end;

procedure TFiller.CreateBrushIndirectObj(BrushIndirect: TEMRCreateBrushIndirect);
begin
  case BrushIndirect.lb.lbStyle of
    BS_SOLID:
      CreateSolidColor(BrushIndirect.lb.lbColor);
    BS_NULL:
      CreateSolidColor(clNone);
    BS_HATCHED:
      FExport.Comment(' lb.lbStyle: BS_HATCHED, lb.lbHatch: ' + IntToStr(BrushIndirect.lb.lbHatch));
  else
    FExport.Comment(' lb.lbStyle: ' + IntToStr(BrushIndirect.lb.lbStyle));
  end;
end;

procedure TFiller.CreateDIBPatternBrushPtObj(DIBPatternBrushPtObj: TEMRCreateDIBPatternBrushPtObj);
begin
  case DIBPatternBrushPtObj.PixelFormat of
    pf1bit:
      begin
        FFillerType := ftPatternBitmap;
        FBitmap.Free;
        FBitmap := DIBPatternBrushPtObj.GetBitmap32OutOf1;
      end;
    pf24bit:
      begin
        FFillerType := ftPatternBitmap;
        FBitmap.Free;
        FBitmap := DIBPatternBrushPtObj.GetBitmap;
      end;
  else
    FExport.Comment(' Unsupported PixelFormat: ' + IntToStr(Integer(DIBPatternBrushPtObj.PixelFormat)));
  end;
end;

procedure TFiller.CreateMonoBrushObj(MonoBrushObj: TEMRCreateMonoBrushObj);
begin
  case MonoBrushObj.PixelFormat of
    pf1bit:
      case MonoBrushObj.CountMonoColors of
        mcAllZero:
          CreateSolidColor(FExport.FDC.TextColor);
        mcAllOne:
          CreateSolidColor(FExport.FDC.BkColor);
        mcBoth:
          begin
            FFillerType := ftPatternBitmap;
            FBitmap.Free;
            FBitmap := MonoBrushObj.GetBitmap24OutOf1(FExport.FDC.BkColor, FExport.FDC.TextColor);
          end;
      end;
    pf24bit:
      begin
        FFillerType := ftPatternBitmap;
        FBitmap.Free;
        FBitmap := MonoBrushObj.GetBitmap;
      end;
  else
    FExport.Comment(' Unsupported PixelFormat: ' + IntToStr(Integer(MonoBrushObj.PixelFormat)));
  end;
end;

procedure TFiller.CreateSolidColor(Color: TColor);
begin
  FFillerType := ftSolidColor;
  FSolidColor := Color;
end;

destructor TFiller.Destroy;
begin
  FBitmap.Free;
  inherited;
end;

procedure TFiller.Init;
var
  EnhMetaObj: TEnhMetaObj;
begin
  if      ihBrush = Unknown then
    EnhMetaObj := FExport.FDC.Brush
  else
  begin
    if IsStockBrush(ihBrush) then
      EnhMetaObj := StockObject(ihBrush)
    else
      EnhMetaObj := FExport.FEMRLastCreated[ihBrush];
    ihBrush := Unknown;
  end;

  if EnhMetaObj = nil then
    EnhMetaObj := StockObject(NULL_BRUSH + ENHMETA_STOCK_OBJECT);

  case EnhMetaObj.P^.EMR.iType of
    EMR_CreateMonoBrush:
      CreateMonoBrushObj(TEMRCreateMonoBrushObj(EnhMetaObj));
    EMR_CreateDIBPatternBrushPt: // not supported
      CreateDIBPatternBrushPtObj(TEMRCreateDIBPatternBrushPtObj(EnhMetaObj));
    EMR_CreateBrushIndirect:
      CreateBrushIndirectObj(EnhMetaObj.P^.CreateBrushIndirect);
  else
    raise Exception.Create('Object not brush');
  end;
end;

{ TEMFOutStream }

procedure TEMFOutStream.AddRecord(const Buffer; Count: LongInt);
const
  Alignment = SizeOf(LongWord);
  B: Byte = 0;
begin
  while Position mod Alignment > 0 do
    Write(B, 1);

  Write(Buffer, Count);
  Inc(FqRecords);
end;

constructor TEMFOutStream.Create;
begin
  inherited;
  FqRecords := 0;
end;

procedure TEMFOutStream.SetHeader;
begin
  TEnhMetaHeader(Memory^).nBytes := Size;
  TEnhMetaHeader(Memory^).nRecords := FqRecords;
end;

end.

