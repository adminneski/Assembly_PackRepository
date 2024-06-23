unit frxExportZPL;

interface

{$I frx.inc}

uses
{$IFNDEF Linux}
  Windows,
{$ELSE}
  LCLType, LCLIntf, LCLProc,
{$ENDIF}
  Messages, frxExportBaseDialog, SysUtils, Classes, Graphics, frCore, frxClass,
  frxExportMatrix, Math, frxBarcod, frxBarcode, frxBarcode2D,
  frxBarcodeMaxiCode, frxTableObject, frxRes, frxExportZPLDialog;

type
    TZplDensity = (d6_dpmm_152_dpi, d8_dpmm_203_dpi, d12_dpmm_300_dpi, d24_dpmm_600_dpi, test1to1);

type TZplScale = record
    PageScale, BarcodeScale: Double;
    TwoDCodeScale: Integer;
  end;

const defaultFontScale: double = 1.4;
const Dictionary: String = 'GHIJKLMNOPQRSTUVWXYghijklmnopqrstuvwxyz';
const counts: array[0..38] of Integer = (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,
                                         20,40,60,80,100,120,140,160,180,200,220,240,260,280,300,320,340,360,380,400);
const ZplScale: array[0..4] of TZplScale = (
                                            (PageScale : 1.5833 ; BarcodeScale : 2;   TwoDCodeScale : 7),     //6 dpmm(152 dpi)
                                            (PageScale : 2.11458; BarcodeScale : 2.5; TwoDCodeScale : 8),    //8 dpmm(203 dpi)
                                            (PageScale : 3.16667; BarcodeScale : 4;   TwoDCodeScale : 10),    //12 dpmm(300 dpi)
                                            (PageScale : 6.34375; BarcodeScale : 8;   TwoDCodeScale : 10),    //24 dpmm(600 dpi)
                                            (PageScale : 1      ; BarcodeScale : 1;   TwoDCodeScale : 1 ));   //test

type

{$IFDEF DELPHI16}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxZPLExport = class(TfrxBaseDialogExportFilter)
  private
    FPage: TfrxReportPage;
    FPrintAsBitmap, FBMillimeters, FBreakLines, FHexText: Boolean;
    Exp: TStream;
    FFontScale, leftMargin, topMargin: double;
    PageBitmap: TBitmap;
    FZplDensity: TZplDensity;
  public
    PrinterInit, CodePage, PrinterFinish, PageInit, PrinterFont: String;
    scaleIndex: Byte;
  private
    procedure ZWrite  (s: String);
    procedure ZWriteLn(s: String);
    procedure ZFDWriteLn(s: String; prefix: String = '');

    procedure SetPosition      (left, top: Integer);
    procedure SetTextAttributes(width, lines, leading: Integer; HAlign :TfrxHAlign; gap: Integer);
    procedure DrawRectangle    (width, height, lineWidth: Integer);
    procedure DrawEllipse      (width, height, lineWidth: Integer);
    procedure DrawLine         (width, height, lineWidth: Integer; direction: Boolean);
    procedure DrawText         (fontHeight, fontWidth: Integer; text: String);
    procedure DrawPictureObject(pic: TfrxPictureView);
    procedure DrawBorders      (Frame :TfrxFrame; AbsLeft, AbsTop, Width, Height: Double);
    procedure DrawBWPicture    (tbm: TBitMap);
    procedure WriteRotation    (rot: Integer);

    procedure ExportTextObject     (FfrxCMV: TfrxCustomMemoView);
    procedure ExportRectangle      (Left, Top, Width, Height, LineWidth: Double);
    procedure ExportEllipse        (Left, Top, Width, Height, LineWidth: Double);
    procedure ExportLine           (Left, Top, Width, Height, LineWidth: Double);
    procedure ExportPicture        (pic: TfrxPictureView);
    procedure ExportLineObject     (line: TfrxLineView);
    procedure ExportBarcodeObject  (b: TfrxBarCodeView);
    procedure Export2DBarcodeObject(b: TfrxBarCode2DView);
    procedure ExportShapeObject    (ShapeObject: TfrxShapeView);

    function  GetWidth (width, height:Double; rotation: Integer): Integer;
    function  GetTop   (top: Double): Integer;
    function  GetHeight(width, height: Double; rotation: Integer): Integer;
    function  GetLeft  (left: Double): Integer;

    function  GetZPLText(source: String) : String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    class function GetDescription: String; override;
    class function ExportDialogClass: TfrxBaseExportDialogClass; override;
    function Start: Boolean; override;
    procedure Finish; override;
    procedure FinishPage(Page: TfrxReportPage; Index: Integer); override;
    procedure StartPage(Page: TfrxReportPage; Index: Integer); override;
    procedure ExportObject(Obj: TfrxComponent); override;

    procedure SetFZplDensity(ZPLD: TZplDensity);
  published
    property PrintAsBitmap: Boolean read FPrintAsBitmap write FPrintAsBitmap default True;
    property BMillimeters: Boolean read FBMillimeters write FBMillimeters default True;
    property BreakLines: Boolean read FBreakLines write FBreakLines default True;
    property FontScale: double read FFontScale write FFontScale;
    property ZplDensity: TZplDensity read FZplDensity write SetFZplDensity default d8_dpmm_203_dpi;
    property HexText: Boolean read FHexText write FHexText default False;
end;


{$IFNDEF FPC}
    procedure WriteToPrinter(PrinterIndex: Integer; PrinterName, SText: String); overload;
    procedure WriteToPrinter(PrinterIndex: Integer; PrinterName: String; mem: TMemoryStream); overload;
{$ENDIF}
implementation

uses frxUtils {$IFNDEF FPC}, WinSpool, Printers {$ENDIF};

procedure Invert(var BM: TBitMap);

const
  BitCounts: array [pf1Bit..pf32Bit] of Byte = (1,4,8,16,16,24,32);
var
  x, y: Integer;
  pB: PByte;
  {$IFDEF FPC}
  function BytesPerScanline(PixelsPerScanline, BitsPerPixel, Alignment: Longint): Longint;
  begin
    Dec(Alignment);
    Result := ((PixelsPerScanline * BitsPerPixel) + Alignment) and not Alignment;
    Result := Result div 8;
  end;
  {$ENDIF}
begin
  for y := 0 to BM.Height-1 do
  begin
    pB := BM.ScanLine[y];
    for x := 0 to BytesPerScanline(BM.Width, BitCounts[BM.PixelFormat], 32) - 1 do
    begin
      pB^ := not pB^;
      Inc(pB);
    end;
  end;
end;

constructor TfrxZPLExport.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  DefaultExt := GetStr('ZPLExtension');
  FilterDesc := GetStr('ZPLFilter');
  PrintAsBitmap := False;
  ZplDensity := d8_dpmm_203_dpi;  //set scaleIndex
  FFontScale := defaultFontScale;
  leftMargin := 0;
  topMargin := 0;
  PrinterFont := 'A';
  CodePage := '^CI28';
  PageBitmap:= nil;
  FPrintAsBitmap := True;
  BreakLines := True;
end;

destructor TfrxZPLExport.Destroy;
begin
  inherited;
end;

procedure TfrxZPLExport.ZWrite(s: String);
{$IFDEF DELPHI14}
var AnsStr: AnsiString;
{$ENDIF}
begin
{$IFDEF DELPHI14}
 {$WARNINGS OFF}
  AnsStr := s;
 {$WARNINGS ON}
  Exp.Write(Pointer(AnsStr)^, length(AnsStr));
{$ELSE}
  Exp.Write(Pointer(s)^, length(s));
{$ENDIF}
end;

procedure TfrxZPLExport.ZWriteLn(s: String);
begin
  if BreakLines then
    ZWrite(s+sLineBreak)
  else
    ZWrite(s);
end;

procedure TfrxZPLExport.ZFDWriteLn(s: String; prefix: String = '');

  {$IFDEF FPC}
    {$DEFINE DELPHI14orFPC}
  {$ELSE}
    {$IFDEF DELPHI14}
      {$DEFINE DELPHI14orFPC}
    {$ENDIF}
  {$ENDIF}

 {$IFDEF DELPHI14orFPC}
  function StrToHex(const source: string): string;
  var
    StrAsBytes:TBytes;
    i:cardinal;
  begin
    result := '';
    StrAsBytes := TEncoding.UTF8.GetBytes(source);
    for i := 0 to length(StrAsBytes) - 1 do
      result:= result + '_' + IntToHex(StrAsBytes[i], 2);
  end;
 {$ELSE}
  function StrToHex(const source: WideString): String;
  var
    s: String;
    i: Integer;
  begin
  s := UTF8Encode(source);
  result := '';
  for i:=1 to Length(s)-2 do
    result := result + '_' +  IntToHex(Integer(s[i]),2);
  end;
 {$ENDIF}

begin
  if FHexText then
    ZWriteLn('^FH^FD' + prefix + StrToHex(s) + '^FS')
  else
    ZWriteLn('^FD' + prefix + s + '^FS');
end;

class function TfrxZPLExport.GetDescription: String;
begin
  Result := frxResources.Get('9523');
end;

class function TfrxZPLExport.ExportDialogClass: TfrxBaseExportDialogClass;
begin
  Result := TfrxExportZPLDialog;
end;

procedure TfrxZPLExport.FinishPage(Page: TfrxReportPage; Index: Integer);
begin
  FPage := Page;
  if (printAsBitmap) then
  begin
    SetPosition(Round(leftMargin), Round(topMargin));    
    Invert(pageBitmap);   
    DrawBWPicture(pageBitmap);
    FreeAndNil(pageBitmap);
  end;
  ZWrite('^XZ');
end;

procedure TfrxZPLExport.Finish;
begin
  ZWriteLn(PrinterFinish);
  if not Assigned(Stream) then
  begin
    IOTransport.DoFilterProcessStream(Exp, Self);
    IOTransport.FreeStream(Exp);
  end;
end;

function TfrxZPLExport.Start: Boolean;
begin
  if (FileName <> '') or Assigned(Stream) then
  begin
    if (ExtractFilePath(FileName) = '') and (DefaultPath <> '') then
      FileName := DefaultPath + '\' + FileName;
    try
      if Assigned(Stream) then
        Exp := Stream
      else
        Exp := IOTransport.GetStream(FileName);
       ZWriteLn(PrinterInit);
       Result := True;
    except
      Result := False;
    end;
  end
  else
    Result := False;
end;

procedure TfrxZPLExport.StartPage(Page: TfrxReportPage; Index: Integer);
var
  Millimeters: Double;
begin
  if (FBMillimeters) then
    Millimeters := 3.78
  else
    Millimeters := 1;
  ZWriteLn('^XA'+CodePage);
  ZWriteLn(PageInit);
  leftMargin := page.LeftMargin * Millimeters * ZplScale[scaleIndex].PageScale;
  topMargin := page.TopMargin * Millimeters * ZplScale[scaleIndex].PageScale;
  if (printAsBitmap) then
  begin
    PageBitmap := TBitmap.Create();
    {$IFNDEF Linux}
    PageBitmap.PixelFormat := pf1bit;
    {$ENDIF}
    PageBitmap.Width := Round(Page.Width * Millimeters * ZplScale[scaleIndex].PageScale);
    PageBitmap.Height := Round(Page.Height * Millimeters * ZplScale[scaleIndex].PageScale);
    PageBitmap.Canvas.Brush.Color := clWhite;
    PageBitmap.Canvas.FillRect(PageBitmap.Canvas.ClipRect);
  end;
end;

procedure TfrxZPLExport.ExportObject(Obj: TfrxComponent);
begin
  if IsPageBG(Obj) then
    Exit;

  if (FprintAsBitmap) then
      TfrxView(Obj).Draw(PageBitmap.Canvas, ZplScale[scaleIndex].PageScale, ZplScale[scaleIndex].PageScale, 0, 0)
  else
  if Obj is TfrxPictureView then
      ExportPicture(TfrxPictureView(Obj))
  else
  if Obj is TfrxBarCodeView then
    ExportBarcodeObject(TfrxBarCodeView(Obj))
  else
  if Obj is TfrxBarCode2DView then
    Export2DBarcodeObject(TfrxBarCode2DView(Obj))
  else
  if Obj is TfrxLineView then
    ExportLineObject(TfrxLineView(Obj))
  else
  if Obj is TfrxShapeView then
    ExportShapeObject(TfrxShapeView(Obj))
  else
  if Obj is TfrxCustomMemoView then
    if (vsExport in TfrxCustomMemoView(Obj).Visibility) then ExportTextObject(TfrxCustomMemoView(Obj));
end;
{$IFNDEF FPC}
procedure WriteToPrinter(PrinterIndex: Integer; PrinterName, SText: String); 
var
  ADevice, ADeviceName, ADevicePort: array[0..255]of Char;
  PrinterHandle: TfrHandle;
  DocInfo: TDocInfo1;
  dwJob: cardinal;
  dwBytesWritten: cardinal;
  AUtf8: UTF8string;
  ADeviceMode: TfrHandle;
begin
  Printer.PrinterIndex := PrinterIndex;
  Printer.GetPrinter(ADevice, ADeviceName, ADevicePort, ADeviceMode);
  if not OpenPrinter(PChar(PrinterName), PrinterHandle,  nil) then
    raise Exception.Create('print error 0');
  DocInfo.pDocName := PChar('Spooler Document Name');
  DocInfo.pOutputFile := nil;
  DocInfo.pDatatype := 'RAW';
  dwJob := StartDocPrinter(PrinterHandle, 1, @DocInfo);
  if dwJob = 0 then
  begin
    ClosePrinter(PrinterHandle);
    PrinterHandle := 0;
    raise Exception.Create('print error 1');
  end;
  if not StartPagePrinter(PrinterHandle) then
  begin
    EndDocPrinter(PrinterHandle);
    ClosePrinter(PrinterHandle);
    PrinterHandle := 0;
    raise Exception.Create('print error 2');
  end;
  AUtf8 := UTF8string(SText);
  WritePrinter(PrinterHandle, @AUtf8[1], Length(AUtf8), dwBytesWritten);
  if not EndPagePrinter(PrinterHandle) then
  begin
    EndDocPrinter(PrinterHandle);
    ClosePrinter(PrinterHandle);
    PrinterHandle := 0;
    raise Exception.Create('print error 3');
  end;
  if not EndDocPrinter(PrinterHandle) then
  begin
    ClosePrinter(PrinterHandle);
    PrinterHandle := 0;
    raise Exception.Create('print error 4');
  end;
  ClosePrinter(PrinterHandle);
  PrinterHandle := 0;
end;

procedure WriteToPrinter(PrinterIndex: Integer; PrinterName: String; mem: TMemoryStream);
var
  s: String;
begin
   SetString(s, PAnsiChar(mem.Memory), mem.Size);
   WriteToPrinter(PrinterIndex, PrinterName, s);
end;
{$ENDIF}
procedure TfrxZPLExport.SetFZplDensity(ZPLD: TZplDensity);
begin
  FZplDensity := ZPLD;
  scaleIndex := Byte(ZPLD);
end;

procedure TfrxZPLExport.SetPosition(left, top: Integer);
begin
  ZWrite('^FO'+IntToStr(left)+','+IntToStr(top));
end;

procedure TfrxZPLExport.SetTextAttributes(width, lines, leading: Integer; HAlign :TfrxHAlign; gap: Integer);
  function TfrxHAlignToString(): Char;
  begin
    Case Halign of
      haLeft:   result := 'L';
      haRight:  result := 'R';
      haCenter: result := 'C';
      haBlock:  result := 'J';
      else      result := 'L';
    end;
  end;
begin
  ZWriteLn('^FB'+IntToStr(width)+','+IntToStr(lines)+','+IntToStr(leading)+','+TfrxHAlignToString()+','+IntToStr(gap));
end;

procedure TfrxZPLExport.DrawRectangle(width, height, lineWidth: Integer);
begin
  ZWriteLn('^GB'+IntToStr(width)+','+IntToStr(height)+','+IntToStr(lineWidth)+'^FS');
end;

procedure TfrxZPLExport.DrawEllipse(width, height, lineWidth: Integer);
begin
  ZWriteLn('^GE'+IntToStr(width)+','+IntToStr(height)+','+IntToStr(lineWidth)+'^FS');
end;

procedure TfrxZPLExport.DrawLine(width, height, lineWidth: Integer; direction: Boolean);
  function directionToStr(): Char;
  begin
    if direction then
      result := 'L'
    else
      result := 'R';
  end;
begin
  ZWriteLn('^GD'+IntToStr(width)+','+IntToStr(height)+','+IntToStr(lineWidth)+directionToStr+'^FS');
end;

procedure TfrxZPLExport.DrawText(fontHeight, fontWidth: Integer; text: String);
begin
  ZWriteLn('^A'+PrinterFont+','+IntToStr(fontHeight)+','+IntToStr(fontWidth));
  ZFDWriteLn(GetZPLText(text));
end;

procedure TfrxZPLExport.WriteRotation(rot: Integer);
  function GetRot(): Char;
  begin
    Case rot of
      0..89   : Result := 'N';
      90..179 : Result := 'R';
      180..269: Result := 'I';
      270..359 :Result := 'B';
      else      Result := 'N';
    end;
  end;
begin
  ZWriteLn('^FW'+GetRot());
end;

procedure TfrxZPLExport.ExportTextObject(FfrxCMV: TfrxCustomMemoView);
var
  width, lines, fontHeight, fontWidth, top: Integer;
begin
  width := GetWidth(FfrxCMV.Width, FfrxCMV.Height, FfrxCMV.Rotation);
  lines := Round(FfrxCMV.Height / FfrxCMV.Font.Height);
  //lineHeight := Round(FfrxCMV.Font.Height * ZplScale[scaleIndex].PageScale);
  fontHeight := Round(FfrxCMV.Font.Height * ZplScale[scaleIndex].PageScale / FFontScale);
  fontWidth := Round(fontHeight / 2);
  if (FfrxCMV.VAlign = vaTop) then
    top := GetTop(FfrxCMV.AbsTop)
  else
    if (FfrxCMV.VAlign = vaBottom) then
      top := GetTop(FfrxCMV.AbsTop) + GetHeight(FfrxCMV.Width, FfrxCMV.Height, FfrxCMV.Rotation) - fontHeight * lines
    else
      top := GetTop(FfrxCMV.AbsTop) + Round(GetHeight(FfrxCMV.Width, FfrxCMV.Height, FfrxCMV.Rotation) / 2) - Round(fontHeight * lines / 2);
  SetPosition(GetLeft(FfrxCMV.AbsLeft), top);
  SetTextAttributes(width, lines, 0, FfrxCMV.HAlign, 0);
  WriteRotation(FfrxCMV.Rotation);
  DrawText(fontHeight, fontWidth, FfrxCMV.Text);
  DrawBorders(FfrxCMV.Frame, FfrxCMV.AbsLeft, FfrxCMV.AbsTop, FfrxCMV.Width, FfrxCMV.Height);
end;

function TfrxZPLExport.GetWidth(width, height:Double; rotation: Integer): Integer;
begin
  if (rotation = 90) or (rotation = 270) then
    result := Round(height * ZplScale[scaleIndex].PageScale)
  else
    result := Round(width * ZplScale[scaleIndex].PageScale);
end;

function TfrxZPLExport.GetTop(top: Double): Integer;
begin
  result := Round(top * ZplScale[scaleIndex].PageScale + topMargin);
end;

function TfrxZPLExport.GetHeight(width, height: Double; rotation: Integer): Integer;
begin
  if (rotation = 90) or (rotation = 270) then
    result := Round(width * ZplScale[scaleIndex].PageScale)
  else
    result := Round(height * ZplScale[scaleIndex].PageScale);
end;

function TfrxZPLExport.GetLeft(left: Double): Integer;
begin
  result := Round(left * ZplScale[scaleIndex].PageScale + leftMargin);
end;

procedure TfrxZPLExport.ExportRectangle(Left, Top, Width, Height, LineWidth: Double);
var
  vleft, vtop, vwidth, vheight,vlineWidth: Integer;
begin
  if (Width > 0) then
    vleft := GetLeft(Left)
  else
    vleft := GetLeft(Left + Width);
  if (Height > 0) then
    vtop := GetLeft(Top)
  else
    vtop := GetTop(Top + Height);
  vwidth := Abs(Round(Width * ZplScale[scaleIndex].PageScale));
  vheight := Abs(Round(Height * ZplScale[scaleIndex].PageScale));
  vlineWidth := Round(LineWidth * ZplScale[scaleIndex].PageScale);
  SetPosition(vleft, vtop);
  DrawRectangle(vwidth, vheight, vlineWidth);
end;

procedure TfrxZPLExport.ExportEllipse(Left, Top, Width, Height, LineWidth: Double);
var
  vleft, vtop, vwidth, vheight,vlineWidth: Integer;
begin
  if (Width > 0) then
    vleft := GetLeft(Left)
  else
    vleft := GetLeft(Left + Width);
  if (Height > 0) then
    vtop := GetLeft(Top)
  else
    vtop := GetTop(Top + Height);
  vwidth := Abs(Round(Width * ZplScale[scaleIndex].PageScale));
  vheight := Abs(Round(Height * ZplScale[scaleIndex].PageScale));
  vlineWidth := Round(LineWidth * ZplScale[scaleIndex].PageScale);
  SetPosition(vleft, vtop);
  DrawEllipse(vwidth, vheight, vlineWidth);
end;

procedure TfrxZPLExport.ExportLine(Left, Top, Width, Height, LineWidth: Double);
var
  vleft, vtop, vwidth, vheight,vlineWidth: Integer;
  vdirection: Boolean;
begin
  if (Width > 0) then
    vleft := GetLeft(Left)
  else
    vleft := GetLeft(Left + Width);
  if (Height > 0) then
    vtop := GetLeft(Top)
  else
    vtop := GetTop(Top + Height);
  vwidth := Abs(Round(Width * ZplScale[scaleIndex].PageScale));
  vheight := Abs(Round(Height * ZplScale[scaleIndex].PageScale));
  vlineWidth := Round(LineWidth * ZplScale[scaleIndex].PageScale);
  vdirection := ((Width > 0) and (Height > 0)) or ((Width < 0) and (Height < 0));
  SetPosition(vleft, vtop);
  DrawLine(vwidth, vheight, vlineWidth, vdirection);
end;

procedure TfrxZPLExport.DrawBorders(Frame :TfrxFrame; AbsLeft, AbsTop, Width, Height: Double);
var
  vleft, vtop, vwidth, vheight, vlineWidth: Integer;
begin
  if (Frame.Width > 0) then
  begin
    Frame.RightLine := Frame.TopLine;
    if (Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]) then
      ExportRectangle(AbsLeft, AbsTop, Width, Height, Frame.Width)
    else
    begin
      if (Width > 0) then
        vleft := GetLeft(AbsLeft)
      else
        vleft := GetLeft(AbsLeft + Width);
      if (Height > 0) then
        vtop := GetLeft(AbsTop)
      else
        vtop := GetLeft(AbsTop + Height);
      vwidth := Abs(Round(Width * ZplScale[scaleIndex].PageScale));
      vheight := Abs(Round(Height * ZplScale[scaleIndex].PageScale));
      //vlineWidth := Round(Frame.Width * ZplScale[scaleIndex].PageScale);
      if (ftTop in Frame.Typ) then
      begin
        vlineWidth := Round(Frame.TopLine.Width * ZplScale[scaleIndex].PageScale);
        SetPosition(vleft, vtop);
        DrawRectangle(vwidth, 0, vlineWidth);
      end;
      if (ftLeft in Frame.Typ) then
      begin
        vlineWidth := Round(Frame.LeftLine.Width * ZplScale[scaleIndex].PageScale);
        SetPosition(vleft, vtop);
        DrawRectangle(0, vheight, vlineWidth);
      end;
      if (ftBottom in Frame.Typ) then
      begin
        vlineWidth := Round(Frame.BottomLine.Width * ZplScale[scaleIndex].PageScale);
        SetPosition(vleft, vtop + vheight);
        DrawRectangle(vwidth, 0, vlineWidth);
      end;
      if (ftRight in Frame.Typ) then
      begin
        vlineWidth := Round(Frame.RightLine.Width * ZplScale[scaleIndex].PageScale);
        SetPosition(vleft + vwidth, vtop);
        DrawRectangle(0, vheight, vlineWidth);
      end;
    end;
  end;
end;

procedure TfrxZPLExport.ExportPicture(pic: TfrxPictureView);
begin
  SetPosition(GetLeft(pic.AbsLeft), GetTop(pic.AbsTop));
  DrawPictureObject(pic);
end;

procedure TfrxZPLExport.ExportLineObject(line: TfrxLineView);
begin
  if (line.Width = 0) and (line.Height = 0) then
    ExportRectangle(line.AbsLeft, line.AbsTop, line.Width, line.Height, line.Frame.Width)
  else
    ExportLine(line.AbsLeft, line.AbsTop, line.Width, line.Height, line.Frame.Width);
end;

procedure TfrxZPLExport.DrawPictureObject(pic: TfrxPictureView);
var
  zoom: Double;
  picWidth, picHeight: Integer;
  BM: TBitMap;
begin
  if (pic.Width < 1) or (pic.Height < 1) then
  Exit;
  zoom := ZplScale[scaleIndex].PageScale;
  picWidth := Ceil(pic.Width * zoom);
  picHeight := Ceil(pic.Height * zoom);
  BM := TBitmap.Create();
  try
    {$IFNDEF Linux}
    BM.PixelFormat := pf1bit;
    {$ENDIF}
    BM.Width := picWidth;
    BM.Height := picHeight;
    BM.Canvas.StretchDraw(Rect(0, 0, picWidth, picHeight), pic.Picture.Bitmap);
    Invert(BM);
    DrawBWPicture(BM);
  finally
    BM.Free;
  end;
end;

procedure TfrxZPLExport.ExportBarcodeObject(b: TfrxBarCodeView);
var
  height: Integer;
  printLine: Char;
begin
  height := GetHeight(b.Width, b.Height, b.Rotation);
  SetPosition(GetLeft(b.AbsLeft), GetTop(b.AbsTop));
  ZWriteLn('^BY' + IntToStr(Round(b.Zoom * ZplScale[scaleIndex].BarcodeScale)) + ',,' + IntToStr(height));
  WriteRotation(b.Rotation);
  if b.ShowText then
    printLine := 'Y'
  else
    printLine := 'N';
  case b.BarType of
    bcCode128..bcCode128C, bcCodeEAN128..bcCodeEAN128C: ZWriteLn('^BC,,'+printLine+',N,N');
    bcCode_2_5_industrial:                              ZWriteLn('^BI,,'+printLine+',N');
    bcCode_2_5_interleaved:                             ZWriteLn('^B2,,'+printLine+',N,N');
    bcCode_2_5_matrix:                                  ZWriteLn('^BJ,,'+printLine+',N');
    bcCode39Extended:                                   ZWriteLn('^B3,Y,,'+printLine+',N');
    bcCode39:                                           ZWriteLn('^B3,N,,'+printLine+',N');
    bcCode93Extended:                                   ZWriteLn('^BA,,'+printLine+',N,N');
    bcCode93:                                           ZWriteLn('^BA,,'+printLine+',N,N');
    bcCodeCodabar:                                      ZWriteLn('^BK,N,'+printLine+',N,,');
    bcCodeUPC_A:                                        ZWriteLn('^BU,,'+printLine+',N,Y');
    bcCodeUPC_E0:                                       ZWriteLn('^B9,,'+printLine+',N,Y');
    bcCodeUPC_E1:                                       ZWriteLn('^B9,,'+printLine+',N,Y');
    bcCodeEAN8:                                         ZWriteLn('^B8,,'+printLine+',N');
    bcCodeEAN13:                                        ZWriteLn('^BE,,'+printLine+',N');
    bcCodeUSPSIntelligentMail:                          ZWriteLn('^BZ,,'+printLine+',N,3');
    bcCodeMSI:                                          ZWriteLn('^BM,,,'+printLine+',N,N');
    bcCodePostNet:                                      ZWriteLn('^BZ,,'+printLine+',N,0');
    bcCodeUPC_Supp2, bcCodeUPC_Supp5, bcGS1Code128:     begin
                                                          DrawText(Round(b.Height), Round(b.Width), 'not supported Barcode');
                                                          Exit;
                                                        end;
  end;
  ZFDWriteLn(GetZPLText(b.Text));
end;

procedure TfrxZPLExport.Export2DBarcodeObject(b: TfrxBarCode2DView);
var
  height: Integer;
begin
  height := GetHeight(b.Width, b.Height, b.Rotation);
  SetPosition(GetLeft(b.AbsLeft), GetTop(b.AbsTop));
  if b.BarType = bcCodePDF417 then
    ZWriteLn('^BY' + IntToStr(Round(b.Zoom * ZplScale[scaleIndex].TwoDCodeScale) * 2) + ',,' + IntToStr(height))
  else
    ZWriteLn('^BY' + IntToStr(Round(b.Zoom * ZplScale[scaleIndex].TwoDCodeScale)) + ',,' + IntToStr(height));
  WriteRotation(b.Rotation);
  case b.BarType of
    bcCodePDF417:                  ZWriteLn('^B7,,,,,');
    bcCodeDataMatrix:              ZWriteLn('^BX,,,,,,');
    bcCodeAztec:                   ZWriteLn('^BO,'+IntToStr(ZplScale[scaleIndex].TwoDCodeScale)+',,,,,');
    bcCodeMaxiCode:                ZWriteLn('^BD'+IntToStr(TfrxBarcodeMaxiCode(b).Mode)+',,');
    bcCodeQR:                      begin
                                     ZWriteLn('^BY2,2,0');
                                     ZWriteLn('^BQ,2,' + FloatToStr(Round(ZplScale[scaleIndex].TwoDCodeScale * b.Zoom)));
                                     ZFDWriteLn(GetZPLText(b.Text),'MA,');
                                     Exit;
                                   end;
    bcGS1DatabarE, bcGS1DatabarES: begin
                                     DrawText(Round(b.Height), Round(b.Width), 'not supported Barcode');
                                     Exit;
                                   end;
  end;
  ZFDWriteLn(GetZPLText(b.Text));
end;

procedure TfrxZPLExport.ExportShapeObject(ShapeObject: TfrxShapeView);
begin
  if (shapeObject.Shape = skEllipse) then
    ExportEllipse(shapeObject.AbsLeft, shapeObject.AbsTop, shapeObject.Width, shapeObject.Height, shapeObject.Frame.Width)
  else
    ExportRectangle(shapeObject.AbsLeft, shapeObject.AbsTop, shapeObject.Width, shapeObject.Height, shapeObject.Frame.Width);
end;

function TfrxZPLExport.GetZPLText(source: String) : String;
begin
  result  := StringReplace(source, '\\',   '\\\\', [rfReplaceAll, rfIgnoreCase]);
  result  := StringReplace(result, '\r\n', '\\&',  [rfReplaceAll, rfIgnoreCase]);
  result  := StringReplace(result, '$',    '\\$',  [rfReplaceAll, rfIgnoreCase]);
end;

procedure TfrxZPLExport.DrawBWPicture(tbm: TBitMap);
var
  widthInBytes, imageSize, x, y: Integer;
  aob: PByte;
  b: Byte;
  previousHash, line, currentLine: String;
  lastZeros: Boolean;
  {$IFDEF Linux}
  BytesInPix: Byte;
  {$ENDIF}
  function Zip(s: String): String;
  var
    ni ,i, kol : Integer;
    sym: Char;
    function Comb(): String;//Dictionary/counts
    var
      i2: Integer;
    begin
      result := '';
      i2 := 38;
      while i2 >= 0 do
        if (kol >= counts[i2]) then
        begin
          result := result +  Dictionary[i2+1];
          dec(kol, counts[i2]);
        end
        else
        dec(i2);
    end;
  begin
    result := '';
    ni := 1;
    i := 2;
    sym := s[ni];
    while i <= Length(s) do
      if(s[i]=sym) then
      begin
        inc(i);
      end
      else
      begin
        kol := i - ni;
        if(kol>1) then
          result := result + Comb();
        result := result + sym;
        ni := i;
        sym := s[i];
      end;
    kol := i - ni;
    if(kol>1) then
      result := result + Comb();
    result := result + sym;
  end;

begin
  widthInBytes := Ceil(tbm.Width / 8);
  imageSize := widthInBytes * tbm.Height;
  ZWriteLn('');
  ZWriteLn('^GFA,'+IntToStr(imageSize)+','+IntToStr(imageSize)+','+IntToStr(widthInBytes)+',');
  tbm.Canvas.Lock();
  for y := 0 to tbm.Height-1 do
  begin
    lastZeros := True;
    aob := tbm.ScanLine[y];
    {$IFDEF Linux}
    BytesInPix := tbm.RawImage.Description.BitsPerPixel;
    if (BytesInPix = 32) or (BytesInPix = 24) then
    begin
      BytesInPix := BytesInPix div 8;
      for x := 0 to tbm.Width - 1 do
        if (aob[x * BytesInPix] + aob[x * BytesInPix + 1] + aob[x * BytesInPix + 2] > 382 {255*3/2}) then //is Black
          aob[x div 8] := aob[x div 8] or (128 shr (x and 7))
        else
          aob[x div 8] := aob[x div 8] and not (128 shr (x and 7))
    end
    else
      raise Exception.Create('BitsPerPixel not 24 and not 32');
    {$ENDIF}
    line := '';
    currentLine := '';
    for x := 0 to widthInBytes-1 do
    begin
      b := aob^;
      if (b <> 0) then
      begin
        lastZeros := False;
        currentLine := currentLine + line;
        line := '';
      end
      else
      begin
        if (not lastZeros) then
        begin
          currentLine := currentLine + line;
          line := '';
        end;
        lastZeros := True;
      end;
      line := line + IntToHex(aob^, 2);
      inc(aob);
    end;
    if lastZeros then
      currentLine := currentLine + ','
    else
      currentLine := currentLine + line;
    if (currentLine = previousHash) then
      ZWriteLn(':')
    else
    begin
      ZWriteLn(Zip(currentLine));
      previousHash := currentLine;
    end;
  end;
  ZWriteLn('^FS');
end;

//not used
(*
procedure TfrxZPLExport.ExportTableObject(table: TfrxTableObject);
var
  Memo: TfrxCustomMemoView;
  tableWidth, tableHeight: Double;
  i: Integer;
begin     //ExportTextObject(FfrxCMV: TfrxCustomMemoView);
  if (table.ColumnCount < 1) or (table.RowCount < 1) then
    Exit;
  Memo := TfrxCustomMemoView.Create(nil);
  Memo.Frame := table.Frame;
  Memo.Fill := table.Fill;
  Memo.FillType := table.FillType;
  Memo.Left := table.AbsLeft;
  Memo.Top := table.AbsTop;
  tableWidth := 0;
  tableHeight := 0;
  for i := 0 to table.ColumnCount-1 do
  tableWidth := tableWidth + table.Cells[i, 0].Width;
  for i := 0 to table.RowCount-1 do
  tableHeight := tableHeight + table.Rows[i].Height;
  if tableWidth < table.Width then
    Memo.Width := tableWidth
  else
    Memo.Width := table.Width;
  Memo.Height := tableHeight;
  ExportTextObject(Memo);
  AddTable(table);
end;

procedure TfrxZPLExport.AddTable(table: TfrxTableObject);
var
  y, x: Double;
  i, j: Integer;
  textcell: TfrxTableCell;
begin
  y := 0;
  for i := 0 to table.RowCount-1 do
  begin
    x := 0;
    for j := 0 to table.ColumnCount-1 do
    begin
      if table.Cells[j, i].Text <> '' then
      begin
        textcell := table.Cells[j, i];
        textcell.Left := x;
        textcell.Top := y;
        ExportTextObject(textcell as TfrxCustomMemoView);
      end;
      x := x + table.Columns[j].Width;
    end;
    y := y + table.Rows[i].Height;
  end;
end;
*)

end.
