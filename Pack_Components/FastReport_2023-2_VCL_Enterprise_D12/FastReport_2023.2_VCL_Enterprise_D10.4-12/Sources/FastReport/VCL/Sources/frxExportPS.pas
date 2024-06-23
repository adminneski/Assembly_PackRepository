unit frxExportPS;

interface

{$I frx.inc}

uses
{$IFNDEF Linux}
  Windows,
{$ELSE}
  LCLType, LCLIntf, LCLProc,
{$ENDIF}
  Messages, frxExportBaseDialog, SysUtils, Classes, Graphics, frxClass, frxExportMatrix, Math, frxBarcod, frxBarcode, frxBarcode2D,
  frxBarcodeMaxiCode, frxTableObject, frxRes, frxExportPSDialog, frxImageConverter, frxExportPSDocument,  frxExportPSHelper;

type

{$IFDEF DELPHI16}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxPSExport = class(TfrxBaseDialogExportFilter)
  protected
    FPath, fileNameWOext, extension, pageFileName: String;
    FIndent: Double;
    FPictures, FHasMultipleFiles, FIncludeImages: Boolean;
    FPSImageFormat :PSImageFormat;
    ps: PSDocument;
  protected
    function EnableCalculateHash: Boolean; override;
    function GetImageFormat(): String;
    {$IFNDEF FPC}
    function RadGetImageFormat(): TfrxPictureType;
    {$ENDIF}
    function GetBlendColor(c: TColor; Blend: Double): TColor;
    procedure DrawArrow(AWidth, AHeight, lineWidth, x1, y1, x2, y2: Double; var x3, y3, x4, y4: Double);
    procedure NormalizeBackgroundColor(obj: TfrxView; var Background: String);
    procedure NormalizeColor(obj: TfrxShapeView; var BorderBrush: String; var Background: String);

    procedure AddPictureObject(ps: PSDocument; obj: TfrxPictureView);
    procedure AddLine(ps: PSDocument; line: TfrxLineView);
    procedure AddShape(ps: PSDocument; shape: TfrxShapeView);
    procedure AddTextObject(ps: PSDocument; text: TfrxCustomMemoView; Band: Boolean);

  public
    function Start: Boolean; override;
    procedure StartPage(Page: TfrxReportPage; Index: Integer); override;
    procedure ExportObject(Obj: TfrxComponent); override;
    procedure FinishPage(Page: TfrxReportPage; Index: Integer); override;
    procedure Finish; override;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    class function GetDescription: String; override;
    class function ExportDialogClass: TfrxBaseExportDialogClass; override;

  published
    property Indent: Double read FIndent write FIndent;
    property Pictures: Boolean read FPictures write FPictures;
    property IncludeImages: Boolean read FIncludeImages write FIncludeImages;
    property ImageFormat :PSImageFormat read FPSImageFormat write FPSImageFormat;
    property HasMultipleFiles: Boolean read FHasMultipleFiles write FHasMultipleFiles;
end;


implementation

uses
  frxUtils, frHashUtils, frBaseGraphicsTypes;

function TfrxPSExport.EnableCalculateHash: Boolean;
begin
  Result := True;
end;

function TfrxPSExport.GetImageFormat(): String;
begin
  if (FPSImageFormat = psJpeg) then
    result := 'jpeg'
  else
    result := 'png';
end;
{$IFNDEF FPC}
function TfrxPSExport.RadGetImageFormat(): TfrxPictureType;
begin
  if (FPSImageFormat = psJpeg) then
    result := gpJPG
  else
    result := gpPNG;
end;
{$ENDIF}

function TfrxPSExport.GetBlendColor(c: TColor; Blend: Double): TColor;
var
  Color: Longint;
  r, g, b: Byte;
begin
  Color := ColorToRGB(c);
  r := Color;
  g := Color shr 8;
  b := Color shr 16;
  result := RGB(Round(r + (255 - r) * Blend), Round(g + (255 - g) * Blend), Round(b + (255 - b) * Blend));
end;

procedure TfrxPSExport.DrawArrow(AWidth, AHeight, lineWidth, x1, y1, x2, y2: Double; var x3, y3, x4, y4: Double);
var
  k1, a, b, c, d, xp, yp, wd, ld: Double;
begin
  wd := AWidth * lineWidth;
  ld := AHeight * lineWidth;
  if (Abs(x2 - x1) > 0) then
  begin
    k1 := (y2 - y1) / (x2 - x1);
    a := Power(k1, 2) + 1;
    b := 2 * (k1 * ((x2 * y1 - x1 * y2) / (x2 - x1) - y2) - x2);
    c := Power(x2, 2) + Power(y2, 2) - Power(ld, 2) + Power((x2 * y1 - x1 * y2) / (x2 - x1), 2) - 2 * y2 * (x2 * y1 - x1 * y2) / (x2 - x1);
    d := Power(b, 2) - 4 * a * c;
    xp := (-b + Sqrt(d)) / (2 * a);
    if ((xp > x1) and (xp > x2) or (xp < x1) and (xp < x2)) then
      xp := (-b - Sqrt(d)) / (2 * a);
    yp := xp * k1 + (x2 * y1 - x1 * y2) / (x2 - x1);
    if (y2 <> y1) then
    begin
      x3 := xp + wd * Sin(ArcTan(k1));
      y3 := yp - wd * Cos(ArcTan(k1));
      x4 := xp - wd * Sin(ArcTan(k1));
      y4 := yp + wd * Cos(ArcTan(k1));
    end
    else
    begin
      x3 := xp;
      y3 := yp - wd;
      x4 := xp;
      y4 := yp + wd;
    end;
  end
  else
  begin
    xp := x2;
    yp := y2 - ld;
    if ((yp > y1) and (yp > y2) or (yp < y1) and (yp < y2)) then
      yp := y2 + ld;
    x3 := xp - wd;
    y3 := yp;
    x4 := xp + wd;
    y4 := yp;
  end;
end;

procedure TfrxPSExport.NormalizeBackgroundColor(obj: TfrxView; var Background: String);
var
  col: TColor;
begin
  col := GetColorFromFill(obj.Fill);
  if (col = clNone) then
    Background := 'none'
  else
    Background := ColorToHtml(col);
end;

procedure TfrxPSExport.NormalizeColor(obj: TfrxShapeView; var BorderBrush: String; var Background: String);
begin
  BorderBrush := ColorToHtml(obj.Frame.Color);
  NormalizeBackgroundColor(obj, Background);
end;

procedure TfrxPSExport.AddPictureObject(ps: PSDocument; obj: TfrxPictureView);
var
  imageStream: TMemoryStream;
  num: String;
begin
  if (not FPictures) then
    Exit;
  imageStream := TMemoryStream.Create();
  if (FIncludeImages) then
    {$IFDEF FPC}
    obj.Picture.SaveToStreamWithFileExt(imageStream, 'jpeg')
    {$ELSE}
    SaveGraphicAs(obj.GetGraphic, imageStream, RadGetImageFormat())
    {$ENDIF}
  else
    {$IFDEF FPC}
    obj.Picture.SaveToStreamWithFileExt(imageStream, GetImageFormat());
    {$ELSE}
    SaveGraphicAs(obj.GetGraphic, imageStream, RadGetImageFormat());
    {$ENDIF}
  imageStream.Position := 0;
  num := IntToStr(FfrxPictureHashMap.FindOrAddGraphic(obj.GetGraphic, phmIndex));
  if (FfrxPictureHashMap.isLastNew) then
  begin
    if (FIncludeImages) then
    begin
      ps.PSWrite('/PIC' + num + ' (' + MemoryStreamToHexStr(imageStream) + ') def');
      ps.AddImage('PIC' + num, obj.AbsLeft, obj.AbsTop, obj.Width, obj.Height, obj.GraphicWidth, obj.GraphicHeight);
    end
    else
    begin
      ps.AddImage(StringReplace(fileNameWOext, ' ', '', [rfReplaceAll, rfIgnoreCase]) + num + '.' + GetImageFormat(), obj.AbsLeft, obj.AbsTop, obj.Width, obj.Height, obj.GraphicWidth, obj.GraphicHeight, false);
      if ( (not FIncludeImages) and DirectoryExists(FPath) and (FileName <> '') ) then
        imageStream.SaveToFile(FPath + PathDelim + fileNameWOext + num + '.' + GetImageFormat());
    end;
  end
  else
  begin
    if (FIncludeImages) then
    begin
      ps.AddImage('PIC' + num, obj.AbsLeft, obj.AbsTop, obj.Width, obj.Height, obj.GraphicWidth, obj.GraphicHeight);
    end
    else
    begin
      ps.AddImage(StringReplace(fileNameWOext, ' ', '', [rfReplaceAll, rfIgnoreCase]) + num + '.' + GetImageFormat(), obj.AbsLeft, obj.AbsTop, obj.Width, obj.Height, obj.GraphicWidth, obj.GraphicHeight, false);
    end;
  end;
  FreeAndNil(imageStream);
end;

procedure TfrxPSExport.AddLine(ps: PSDocument; line: TfrxLineView);
var
  Left, Top, Width, Height, Border, x3, y3, x4, y4: Double;
  BorderBrush: String;
begin
  Left := line.AbsLeft;
  Top := line.AbsTop;
  Width := line.Width;
  Height := line.Height;
  ps.Convert(Left, Top, Width, Height);
  Border := line.Frame.Width;
  BorderBrush := ColorToHtml(line.Frame.Color);
  if (line.ArrowStart) then
  begin
    DrawArrow(line.ArrowWidth, line.ArrowLength, Border, Width + Left, Height + Top, Left, Top, x3, y3, x4, y4);
    ps.AddLine(Left, Top, x3, y3, BorderBrush, Border);
    ps.AddLine(Left, Top, x4, y4, BorderBrush, Border);
  end;
  if (line.ArrowEnd) then
  begin
    DrawArrow(line.ArrowWidth, line.ArrowLength, Border, Left, Top, Width + Left, Height + Top, x3, y3, x4, y4);
    ps.AddLine((Width + Left), Top + Height, x3, y3, BorderBrush, Border);
    ps.AddLine((Width + Left), Top + Height, x4, y4, BorderBrush, Border);
  end;
  ps.AddLine(Left, Top, Left + Width, Top + Height, BorderBrush, Border);
end;

procedure TfrxPSExport.AddShape(ps: PSDocument; shape: TfrxShapeView);
var
  BorderBrush, Background: String;
  Left, Top, Width, Height: Double;
begin
  Left := shape.AbsLeft;
  Top := shape.AbsTop;
  Width := shape.Width;
  Height := shape.Height;
  ps.Convert(Left, Top, Width, Height);
  NormalizeColor(shape, BorderBrush, Background);
   case(shape.Shape) of
     skRectangle:      ps.AddRectangle(Left, Top, Width, Height, BorderBrush, shape.Frame.Width, Background, false);
     skRoundRectangle: ps.AddRectangle(Left, Top, Width, Height, BorderBrush, shape.Frame.Width, Background, true);
     skEllipse:        ps.AddEllipse(Left, Top, Width, Height, BorderBrush, shape.Frame.Width, Background);
     skTriangle:       ps.AddTriangle(Left, Top, Width, Height, BorderBrush, shape.Frame.Width, Background);
     skDiamond:        ps.AddDiamond(Left, Top, Width, Height, BorderBrush, shape.Frame.Width, Background);
   end;
end;

procedure TfrxPSExport.AddTextObject(ps: PSDocument; text: TfrxCustomMemoView; Band: Boolean);
var
  font: TFont;
  BorderWidth, Width, Height, PaddingLeft, PaddingTop, PaddingRight, PaddingBottom, Angle, LeftLine,
    TopLine, RightLine, BottomLine, ShadowWidth: Double;
    HorzAlign: TfrxHAlign; VertAlign: TfrxVAlign; sText, FontName, BorderBrush, Background, Foreground: String;
    LeftLineDashStile, TopLineDashStile, RightLineDashStile, BottomLineDashStile: TfrxFrameStyle;
    colorLeftLine, colorTopLine, colorRightLine, colorBottomLine, colorTop,ShadowColor : String;
  (*Bold, Italic, Underline,*) WordWrap, Glass: Boolean;
  color: TColor;
begin
  font := text.Font;
  Width := text.Width;
  Height := text.Height;
  HorzAlign := text.HAlign;
  VertAlign := text.VAlign;
  BorderWidth := text.frame.Width;
  sText := text.WrapText(True);
  sText := StringReplace(sText, '(', '\(', [rfReplaceAll, rfIgnoreCase]);
  sText := StringReplace(sText, ')', '\)', [rfReplaceAll, rfIgnoreCase]);
  FontName := text.Font.Name;
  (*
  {$IFDEF FPC}
  Bold := text.Font.Bold;
  Italic := text.Font.Italic;
  Underline := text.Font.Underline;
  {$ELSE}
  Bold := fsBold in text.Font.Style;
  Italic := fsItalic in text.Font.Style;
  Underline := fsUnderline in text.Font.Style;
  {$ENDIF}
  *)
  PaddingLeft := text.Frame.LeftLine.Width;  //like text.Padding.Left; ??
  PaddingTop := text.Frame.TopLine.Width;
  PaddingRight := text.Frame.RightLine.Width;
  PaddingBottom := text.Frame.BottomLine.Width;

  WordWrap := text.WordWrap;
  Angle := Round(text.Rotation);
  LeftLine := text.Frame.LeftLine.Width;
  TopLine := text.Frame.TopLine.Width;
  RightLine := text.Frame.RightLine.Width;
  BottomLine := text.Frame.BottomLine.Width;
  //Dash
  LeftLineDashStile := text.Frame.LeftLine.Style;
  TopLineDashStile := text.Frame.TopLine.Style;
  RightLineDashStile := text.Frame.RightLine.Style;
  BottomLineDashStile := text.Frame.BottomLine.Style;

  colorLeftLine :=   ColorToHtml(text.Frame.LeftLine.Color);
  colorTopLine :=    ColorToHtml(text.Frame.TopLine.Color);
  colorRightLine :=  ColorToHtml(text.Frame.RightLine.Color);
  colorBottomLine := ColorToHtml(text.Frame.BottomLine.Color);
  //GlassFill
  Glass := false;
  colorTop := '';
  if (text.Fill is TfrxGlassFill) then
  begin
    Glass := true;
    color := GetBlendColor((text.Fill as TfrxGlassFill).Color, (text.Fill as TfrxGlassFill).Blend);
    colorTop := ColorToHtml(color);
  end;

  BorderBrush := ColorToHtml(text.Frame.Color);
  Foreground := ColorToHtml(text.Font.Color);
  NormalizeBackgroundColor(text, Background);
  //Shadow
  ShadowWidth := text.Frame.ShadowWidth;
  ShadowColor := ColorToHtml(text.Frame.ShadowColor);

  if (Band) then
  begin
    sText := '';
    Foreground := '';
    FontName := '';
    (*
    Bold := false;
    Italic := false;
    Underline := false;
    *)
    PaddingLeft := 0;
    PaddingTop := 0;
    PaddingRight := 0;
    PaddingBottom := 0;
    WordWrap := false;
  end;
  ps.AddTextObject(text.AbsLeft, text.AbsTop, Width, Height, HorzAlign, VertAlign, BorderBrush,
    BorderWidth, LeftLine, TopLine, RightLine, BottomLine, LeftLineDashStile, TopLineDashStile,
    RightLineDashStile, BottomLineDashStile, colorLeftLine, colorTopLine, colorRightLine, colorBottomLine,
    text.Frame.DropShadow, ShadowColor, ShadowWidth, Background, text.Frame.Typ, sText, Foreground, PaddingLeft, PaddingTop, PaddingRight, PaddingBottom, WordWrap, Angle, Glass, colorTop, font, FIndent);
end;

function TfrxPSExport.Start: Boolean;
  function ExtractOnlyFileName(const FileName: string): string;
  begin
    result := StringReplace(ExtractFileName(FileName), ExtractFileExt(FileName), '', []);
  end;
begin
  if (FileName <> '') or Assigned(Stream) then
  begin
    if (ExtractFilePath(FileName) = '') and (DefaultPath <> '') then
      FileName := DefaultPath + '\' + FileName;
    try
      if not Assigned(Stream) then
        Stream := IOTransport.GetStream(FileName);
      Result := True;
    except
      Result := False;
    end;
    FPath := ExtractFilePath(FileName);                //GetDirectoryName
    fileNameWOext := ExtractOnlyFileName(FileName);  //GetFileNameWithoutExtension
    extension := ExtractFileExt(FileName);           //GetExtension
  end
  else
  begin
    fileNameWOext := 'xamlreport';  //?
    Result := False;
  end;
end;

procedure TfrxPSExport.StartPage(Page: TfrxReportPage; Index: Integer);
var
  pageBorder: TfrxCustomMemoView;
begin
  ps := PSDocument.Create(fileNameWOext, page.PaperWidth, page.PaperHeight); //Units.Millimeters

  // page borders
  if (page.Frame.Typ <> []) then
  begin
    pageBorder := TfrxCustomMemoView.Create(nil);
    pageBorder.Frame := page.Frame;
    pageBorder.Left := 0;
    pageBorder.Top := 0;
    pageBorder.Width := page.Width - MmToDp(page.RightMargin + page.LeftMargin);
    pageBorder.Height := page.Height - MmToDp(page.BottomMargin + page.TopMargin);
    AddTextObject(ps, pageBorder, true);
    FreeAndNil(pageBorder);
  end;

  if (FPath <> '') then
    pageFileName := FPath + fileNameWOext + IntToStr(Index) + extension
  else
    pageFileName := '';
end;

procedure TfrxPSExport.FinishPage(Page: TfrxReportPage; Index: Integer);
begin
  ps.Finish();
  if (DirectoryExists(FPath) and (FileName <> '')) then
  begin
    if (Index = 0) then
      ps.Save(Stream)
    else
      if (FHasMultipleFiles) then
        ps.Save(pageFileName)
      else
        ps.Save(Stream);
  end
  else
  if (FPath = '') then
    ps.Save(Stream);
  FreeAndNil(ps);
end;

procedure TfrxPSExport.ExportObject(Obj: TfrxComponent);
begin
  if IsPageBG(Obj) then
    Exit;

  if Obj is TfrxPictureView then
    AddPictureObject(ps, TfrxPictureView(Obj))
  else
  if Obj is TfrxCustomMemoView then
  begin
    if (vsExport in TfrxCustomMemoView(Obj).Visibility) then AddTextObject(ps, TfrxCustomMemoView(Obj), false);
  end
  else
  if Obj is TfrxLineView then
    AddLine(ps, TfrxLineView(Obj))
  else
  if Obj is TfrxShapeView then
    AddShape(ps, TfrxShapeView(Obj));
end;

constructor TfrxPSExport.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  DefaultExt := GetStr('PSExtension');
  FilterDesc := GetStr('PSFilter');
  FPSImageFormat := psJpeg;
  FHasMultipleFiles := False;
  FIncludeImages := True;
  FPictures := True;
  FIndent := 1.1;
end;

destructor TfrxPSExport.Destroy;
begin
  inherited;
end;

class function TfrxPSExport.GetDescription: String;
begin
  Result := frxResources.Get('PSexport');
  if Result = '' then
    Result := 'PS Export ...';
end;

class function TfrxPSExport.ExportDialogClass: TfrxBaseExportDialogClass;
begin
  Result := TfrxExportPSDialog;
end;

procedure TfrxPSExport.Finish;
begin
  ps := nil;
  Stream := nil;
end;

end.
