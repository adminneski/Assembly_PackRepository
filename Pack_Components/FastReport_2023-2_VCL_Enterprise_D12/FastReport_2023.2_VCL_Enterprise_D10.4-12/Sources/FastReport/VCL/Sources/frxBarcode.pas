
{******************************************}
{                                          }
{             FastReport VCL               }
{          Barcode Add-in object           }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxBarcode;

interface

{$I frx.inc}

uses
  {$IFNDEF FPC}Windows, Messages, {$ENDIF}
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Menus, frxBarcod, frxClass, ExtCtrls, frxBarcodeInterface
{$IFDEF FPC}
  , LCLType, LCLIntf, LazarusPackageIntf, LazHelper, frLazGraphicClasses
{$ENDIF}
{$IFDEF DELPHI6}
, Variants
{$ENDIF}
{$IFDEF DELPHI16}
, System.Types
{$ENDIF}
;

const
  frxBarcodeCategoryName = 'Barcode';

type
{$IFDEF DELPHI16}
/// <summary>
///   The TfrxBarCodeObject allows the use of the BarCode component in your
///   report. TfrxBarCodeObject is an empty component. It is used for adding
///   the frxBarCode.pas file to the "uses" list. The main component is
///   TfrxBarCodeView.
/// </summary>
[ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxBarCodeObject = class(TComponent);  // fake component

  /// <summary>
  ///   The TfrxBarCodeView component represents a barcode. it shows the Text
  ///   property value as a barcode. It can also show a barcode from the DB
  ///   field (you should set DataSet, DataField properties) or from an
  ///   expression (Expression property).
  /// </summary>
  TfrxBarCodeView = class(TfrxView, IfrxBarCodeView)
  private
    FBarCode: TfrxBarCode;
    FBarType: TfrxBarcodeType;
    FCalcCheckSum: Boolean;
    FExpression: String;
    FHAlign: TfrxHAlign;
    FRotation: Integer;
    FShowText: Boolean;
    FTestLine: Boolean;
    FText: String;
    FTextSup: String;
    FWideBarRatio: Extended;
    FZoom: Extended;
    FMacroLoaded: Boolean;
    FAutoSize: Boolean;
    FFirstTryAfterSBT: boolean;
    procedure BcFontChanged(Sender: TObject);
    procedure TypeDefStr(v: TfrxBarcodeType);
    procedure SetBarType(v: TfrxBarcodeType);
    function GetBarcodeText: TfrxBarcodeText;
    procedure SetBarcodeText(const Value: TfrxBarcodeText);
    function GetBarcodeType: Integer;
    procedure SetBarcodeType(const Value: Integer);
  public
    constructor Create(AOwner: TComponent); override;
    constructor DesignCreate(AOwner: TComponent; Flags: Word); override;
    destructor Destroy; override;
    procedure Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended); override;
    procedure GetData; override;
    function GetText: String;
    procedure SetText(Value: String);
    function GetTextSup: String;
    procedure SetTextSup(Value: String);
    procedure SetZoom(v: Extended);
    function GetZoom: Extended;
    function GetFont: TFont;

    function GetFontHeightTop: Integer;
    function GetFontHeightBottom: Integer;

    class function GetDescription: String; override;
    function GetRealBounds: TfrxRect; override;
    procedure SetColorBar(c: TColor);
    function GetColorBar: TColor;

    procedure SaveContentToDictionary(aReport: TfrxReport; PostProcessor: TfrxPostProcessor); override;
    function LoadContentFromDictionary(aReport: TfrxReport; aItem: TfrxMacrosItem): Boolean; override;
    procedure ProcessDictionary(aItem: TfrxMacrosItem; aReport: TfrxReport; PostProcessor: TfrxPostProcessor); override;

    /// <summary>
    ///   Reference to internal TfrxBarCode object.
    /// </summary>
    property BarCode: TfrxBarCode read FBarCode;
  published
    property AutoSize: Boolean read FAutoSize write FAutoSize default True;
    /// <summary>
    ///   Type of the barcode.
    /// </summary>
    property BarType: TfrxBarcodeType read FBarType write SetBarType;
    property BrushStyle;
    /// <summary>
    ///   Determines if a checksum calc is required.
    /// </summary>
    property CalcCheckSum: Boolean read FCalcCheckSum write FCalcCheckSum default False;
    property FillType;
    property Fill;
    property Color;
    property Cursor;
    property DataField;
    property DataSet;
    property DataSetName;
    /// <summary>
    ///   Value of the expression is printed as a barcode.
    /// </summary>
    property Expression: String read FExpression write FExpression;
    property Frame;
    /// <summary>
    ///   Determines how the Left property will be changed depending on the
    ///   barcode width. Valid values are: <br />haLeft - don't change Left; <br />
    ///   haRight - change Left so right edge is locked; <br />haCenter -
    ///   change Left so center is locked.
    /// </summary>
    property HAlign: TfrxHAlign read FHAlign write FHAlign default haLeft;
    property Processing;
    /// <summary>
    ///   Rotation of the barcode, in degrees.
    /// </summary>
    property Rotation: Integer read FRotation write FRotation;
    /// <summary>
    ///   Determines if we show the barcode text.
    /// </summary>
    property ShowText: Boolean read FShowText write FShowText default True;
    property Style;
    property TagStr;
    property TestLine: Boolean read FTestLine write FTestLine;
    /// <summary>
    ///   Text of the barcode.
    /// </summary>
    property Text: String read GetText write SetText;
    property TextSup: String read GetTextSup write SetTextSup;
    property URL;
    property WideBarRatio: Extended read FWideBarRatio write FWideBarRatio;
    /// <summary>
    ///   Zoom of the barcode, can be non-integer.
    /// </summary>
    property Zoom: Extended read GetZoom write SetZoom;
    property Font: TFont read GetFont stored False;
    property ColorBar: TColor read GetColorBar write SetColorBar;
    property BarcodeText: TfrxBarcodeText read GetBarcodeText write SetBarcodeText;
  end;

{$IFDEF FPC}
//  procedure Register;
{$ENDIF}
implementation

uses
  Math,
{$IFNDEF NO_EDITORS}
  frxBarcodeEditor,
{$ENDIF}
{$IFDEF DELPHI16}
  System.UITypes,
{$ENDIF}
  frxInPlaceEditors,
  frxBarcodeRTTI, frxDsgnIntf, frxRes, frxUtils, frxBarcodeComposite{$IFNDEF RAD_ED}{$IFNDEF ACADEMIC_ED}, frxBarcode2D{$ENDIF}{$ENDIF};

const
  cbDefaultText = '12345678';


{ TfrxBarCodeView }

constructor TfrxBarCodeView.Create(AOwner: TComponent);
begin
  inherited;
  FFirstTryAfterSBT := False;
  FBarCode := TfrxBarCode.Create(nil);
  FBarType := bcCode39;
  FShowText := True;
  FTestLine := False;
  FZoom := 1;
  FText := cbDefaultText;
  FTextSup := '';
  FWideBarRatio := 2;
  Font.Name := 'Arial';
  Font.Size := 9;
  Font.OnChange := BcFontChanged;
  Font.PixelsPerInch := 96;
  FAutoSize := True;
end;

constructor TfrxBarCodeView.DesignCreate(AOwner: TComponent; Flags: Word);
begin
  inherited;
  BarType := TfrxBarcodeType(Flags);
  TypeDefStr(FBarType);
end;

destructor TfrxBarCodeView.Destroy;
begin
  FBarCode.Free;
  inherited Destroy;
end;

class function TfrxBarCodeView.GetDescription: String;
begin
  Result := frxResources.Get('obBarC');
end;

procedure TfrxBarCodeView.Draw(Canvas: TCanvas;
  ScaleX, ScaleY, OffsetX, OffsetY: Extended);
var
  SaveWidth, aScaleX, aScaleY: Extended;
  ErrorText: String;
  DrawRect: TRect;
  CorrL, CorrR, TxtHeight, WidthLine: Integer;
  IsHorizontal: Boolean;
  BottomFix: Integer;
  BColor: TColor;
  PStyle: TPenStyle;

  procedure DoSwap(var ValueX: Integer; var ValueY: Integer);
  var
    tmpSwap: Integer;
  begin
    tmpSwap := ValueX;
    ValueX := ValueY;
    ValueY := tmpSwap;
  end;

  procedure Polygon(a ,b ,c ,d: Integer);
  begin
    Canvas.Polygon([Point(a, b), Point(c, b), Point(c, d), Point(a, d)]);
  end;

  procedure DrawTop();
  begin
    Canvas.Brush.Color := FBarCode.ColorBar;
    Canvas.Pen.Style := psClear;
    case Rotation of
      0:    Polygon(FX + Round(CorrL * ScaleX), FY, FX1 - Round(CorrR  * ScaleX), FY + WidthLine);
      90:   Polygon(FX + Round(CorrL * ScaleX), FY, FX + Round(CorrL * ScaleX) + WidthLine, FY1);
      180:  Polygon(FX + Round(CorrL * ScaleX), FY1, FX1 - Round(CorrR * ScaleX), FY1 - WidthLine);
      270:  Polygon(FX1 - Round(CorrR * ScaleX), FY, FX1 - Round(CorrR * ScaleX) - WidthLine, FY1);
    end;
  end;

begin
  FBarCode.Angle := FRotation;
  FBarCode.BarcodeText.TextSettings.Font.Assign(Font);
  FBarCode.Checksum := FCalcCheckSum;
  FBarCode.Typ := FBarType;
  FBarCode.Ratio := FWideBarRatio;
  FBarCode.Color := clWhite;
  if FillType = ftBrush then
  begin
    if (Color <> clNone) then
      FBarCode.Color := Color;
  end
  else
    FBarCode.Color := clNone;

  IsHorizontal := (FRotation = 0) or (FRotation = 180);

  if IsHorizontal then
    SaveWidth := Width
  else
    SaveWidth := Height;

  FBarCode.Text := AnsiString(FText);
  FBarCode.TextSup := AnsiString(FTextSup);
  ErrorText := '';
  if FZoom < 0.0001 then
    FZoom := 1;

  { frame correction for some bacrode types }
  if FBarCode.Typ in [bcCodeUPC_E0, bcCodeUPC_E1, bcCodeUPC_A] then
    CorrR := 9
  else
    CorrR := 0;
  if FBarCode.Typ in [bcCodeEAN13, bcCodeUPC_A] then
    CorrL := 8
  else
    CorrL := 0;

  if (Rotation = 180) or (Rotation = 270) then
    DoSwap(CorrR, CorrL);

  try
    if AutoSize then
    begin
      if IsHorizontal then
        Width := (FBarCode.Width + CorrL + CorrR) * FZoom
      else
        Height := (FBarCode.Width + CorrL + CorrR) * FZoom;
    end
    else if IsHorizontal then
      FZoom := Width / (FBarCode.Width + CorrL + CorrR)
    else
      FZoom := Height / (FBarCode.Width + CorrL + CorrR);
  except
    on e: Exception do
      if FFirstTryAfterSBT then
      begin
        TypeDefStr(FBarType);
        Barcode.Text := AnsiString(FText);
        Barcode.TextSup := AnsiString(FTextSup);
        FFirstTryAfterSBT := False;
        Self.Draw(Canvas, ScaleX, ScaleY, OffsetX, OffsetY);
        Exit;
      end
      else
      ErrorText := e.Message;
  end;

  if FHAlign = haRight then
  begin
    if IsHorizontal then
      Left := Left + SaveWidth - Width
    else
      Top := Top + SaveWidth - Height
  end
  else if FHAlign = haCenter then
  begin
    if IsHorizontal then
      Left := Left + (SaveWidth - Width) / 2
    else
      Top := Top + (SaveWidth - Height) / 2
  end;

  BeginDraw(Canvas, ScaleX, ScaleY, OffsetX, OffsetY);

  GetScreenScale(aScaleX, aScaleY);
  DrawBackground;
  if ErrorText = '' then
  begin
    if IsHorizontal then
      FBarCode.DrawBarcode(Canvas, Rect(FX + Round(CorrL * ScaleX * FZoom), FY,
        FX1 - Round(CorrR * ScaleX * FZoom), FY1), FShowText, aScaleX, aScaleY)
    else
      FBarCode.DrawBarcode(Canvas, Rect(FX, FY + Round(CorrR * ScaleX * FZoom),
        FX1, FY1 - Round(CorrL * ScaleX * FZoom)), FShowText, aScaleX, aScaleY);
    PStyle := Canvas.Pen.Style;
    BColor := Canvas.Brush.Color;
    if FBarcode.Typ = bcCode_ITF_14 then
    begin
      WidthLine := Round((Frame.Width + 4) * ScaleY * Zoom);
      if ShowText then
        TxtHeight := Round((- Font.Height + 4) * ScaleY * Zoom)
      else
        TxtHeight := 0;
      DrawTop();  //Delete When fix
      DrawTop();  //Top
      if (ShowText) then
        BottomFix := Round(ScaleY * FZoom) //Fix is needed for all barcodes with text UNDER the frame when "ShowText" = true.
      else
        BottomFix := 0;
      case Rotation of  //Bottom
        0:    Polygon(FX + Round(CorrL * ScaleX), FY1 - TxtHeight + BottomFix, FX1 - Round(CorrR * ScaleX), FY1 - TxtHeight - WidthLine + BottomFix);
        90:   Polygon(FX1 - Round(CorrR * ScaleX) - TxtHeight + BottomFix, FY, FX1 - Round(CorrR * ScaleX) - TxtHeight - WidthLine + BottomFix, FY1);
        180:  Polygon(FX + Round(CorrL * ScaleX), FY + TxtHeight - BottomFix, FX1 - Round(CorrR * ScaleX), FY + TxtHeight + WidthLine - BottomFix);
        270:  Polygon(FX + Round(CorrL * ScaleX) + TxtHeight - BottomFix, FY, FX + Round(CorrL * ScaleX) + TxtHeight + WidthLine - BottomFix, FY1);
      end;
      if not(FTestLine) then //Left and Right
      begin
        case Rotation of
          0:
            begin
              Polygon(FX + Round(CorrL * ScaleX), FY, FX + Round(CorrL * ScaleX) + WidthLine, FY1 - TxtHeight);
              Polygon(FX1 - Round(CorrR * ScaleX), FY, FX1 - Round(CorrR * ScaleX) - WidthLine, FY1 - TxtHeight);
            end;
          90:
            begin
              Polygon(FX + Round(CorrL * ScaleX), FY, FX1 - Round(CorrR * ScaleX) - TxtHeight, FY + WidthLine);
              Polygon(FX + Round(CorrL * ScaleX), FY1, FX1 - Round(CorrR * ScaleX) - TxtHeight, FY1 - WidthLine);
            end;
          180:
            begin
              Polygon(FX + Round(CorrL * ScaleX), FY + TxtHeight, FX + Round(CorrL * ScaleX) + WidthLine, FY1);
              Polygon(FX1 - Round(CorrR * ScaleX), FY + TxtHeight, FX1 - Round(CorrR * ScaleX) - WidthLine, FY1);
            end;
          270:
            begin
              Polygon(FX + Round(CorrL * ScaleX) + TxtHeight, FY, FX1 - Round(CorrR * ScaleX), FY + WidthLine);
              Polygon(FX + Round(CorrL * ScaleX) + TxtHeight, FY1, FX1 - Round(CorrR * ScaleX), FY1 - WidthLine);
            end;
        end;
      end;
    end
    else
    if FTestLine then
    begin
      WidthLine := Round(2 * ScaleY);
      DrawTop();  //Delete When fix
      DrawTop();
    end;
    Canvas.Pen.Style := PStyle;
    Canvas.Brush.Color := BColor;
  end
  else
    with Canvas do
    begin
      Font.Name := 'Arial';
      Font.Size := Round(8 * ScaleY);
      Font.Color := clRed;
      DrawRect := Rect(FX + 2, FY + 2, FX1, FY1);
      DrawText(Handle, PChar(ErrorText), Length(ErrorText), DrawRect,
        DT_WORDBREAK);
    end;
  DrawFrame;
end;

procedure TfrxBarCodeView.GetData;
begin
  inherited;
  if IsDataField then
    FText := VarToStr(DataSet.Value[DataField])
  else if FExpression <> '' then
    FText := VarToStr(Report.Calc(FExpression));
end;

function TfrxBarCodeView.GetRealBounds: TfrxRect;
var
  LBitmap: TBitmap;
  procedure CalcBoundExpansion;
  var
    LExpansion, LSupWidth, LTextWidth, LBarWidth: Integer;
  begin
    LExpansion := 0;
    LBarWidth := Round(Width);
    if (FRotation = 90) or (FRotation = 270) then
      LBarWidth := Round(Height);
    LBitmap.Canvas.Font.Assign(Font);
    LTextWidth := LBitmap.Canvas.TextWidth(String(FBarCode.Text));
    LBitmap.Canvas.Font.Assign(BarcodeText.SupSettings.Font);
    LSupWidth := LBitmap.Canvas.TextWidth(String(FBarCode.TextSup));
    LTextWidth := Max(LSupWidth, LTextWidth);
    if LBarWidth < LTextWidth then
      LExpansion := (LTextWidth - LBarWidth) div 2 + 2;
    case FRotation of
      0, 180:
        begin
          Result.Left := Result.Left - LExpansion;
          Result.Right := Result.Right + LExpansion;
        end;
      90, 270:
        begin
          Result.Bottom := Result.Bottom + LExpansion;
          Result.Top := Result.Top - LExpansion;
        end;
    end;
  end;
begin
  LBitmap := TBitmap.Create;
  LBitmap.Canvas.Lock;
  try
    Draw(LBitmap.Canvas, 1, 1, 0, 0);
    Result := inherited GetRealBounds;
    if not (FBarType in [bcCodeEAN13, bcCodeUPC_A, bcCodeUPC_E0, bcCodeUPC_E1]) then
      CalcBoundExpansion;
  finally
    LBitmap.Canvas.Unlock;
    LBitmap.Free;
  end;
end;

procedure TfrxBarCodeView.SetColorBar(c: TColor);
begin
  FBarCode.ColorBar := c;
end;

function TfrxBarCodeView.GetColorBar: TColor;
begin
  Result := FBarCode.ColorBar;
end;

function TfrxBarCodeView.LoadContentFromDictionary(aReport: TfrxReport;
  aItem: TfrxMacrosItem): Boolean;
var
  ItemIdx: Integer;
  s: String;
begin
  Result := False;
  if (aItem <> nil) and not FMacroLoaded then
    if TryStrToInt(Text, ItemIdx) then
    begin
      s := aItem.Item[ItemIdx];
      if s <> '' then
      begin
        Text := s;
        FMacroLoaded := True;
      end;
    end;
end;

procedure TfrxBarCodeView.ProcessDictionary(aItem: TfrxMacrosItem;
  aReport: TfrxReport; PostProcessor: TfrxPostProcessor);
var
  sName, s: String;
  Index: Integer;
begin
  Index := aItem.Count - 1;
  s := Text;
  sName := aReport.CurObject;
  try
    aReport.CurObject := Name;
    GetData;
    aItem.Item[Index] := Text;
  finally
    aReport.CurObject := sName;
    Text := s;
  end;
end;

procedure TfrxBarCodeView.SaveContentToDictionary(aReport: TfrxReport;
  PostProcessor: TfrxPostProcessor);
var
  s: String;
  bName: String;
  Index: Integer;
begin
  bName := '';
  if Assigned(Parent) then
    bName := Parent.Name;
  s := Text;
  Index := PostProcessor.Add(bName, Name, s, Processing.ProcessAt, Self,
    ((Processing.ProcessAt <> paDefault)) and
    (bName <> ''));
  if Index <> -1 then
    Text := IntToStr(Index);
end;

procedure TfrxBarCodeView.BcFontChanged(Sender: TObject);
begin
  if Font.Size > 9 then Font.Size := 9;
end;

procedure TfrxBarCodeView.TypeDefStr(v: TfrxBarcodeType);
begin
  if v = bcCodeUSPSIntelligentMail then
    FText := '12345678901234567890'
  else if v = bcGS1Code128 then
    FText := '(01)12345678901234'
  else if v = bcPharmacode then
    FText := '123456'
  else if v = bcDeutsche_Post_Identcode then
    FText := '01234567890'
  else if v = bcCode_ITF_14 then
    FText := '12345678912345'
  else if v = bcDeutsche_Post_Leitcode then
  begin
    FText := '0123456789012' ;
    FCalcCheckSum := True;
  end
  else if v = bcCodePlessey then
  begin
    FText := '0123456789ABCDEF';
    FCalcCheckSum := True;
  end
  else
    FText := '12345678';
end;

procedure TfrxBarCodeView.SetBarType(v: TfrxBarcodeType);
begin
  if FBarType = v then
    Exit;
  FBarType := v;
  FFirstTryAfterSBT := True;
end;

function TfrxBarCodeView.GetBarcodeText: TfrxBarcodeText;
begin
  Result := FBarCode.BarcodeText;
end;

function TfrxBarCodeView.GetBarcodeType: Integer;
begin
  Result := Ord(BarType);
end;

procedure TfrxBarCodeView.SetBarcodeText(const Value: TfrxBarcodeText);
begin
  FBarCode.BarcodeText.Assign(Value);
end;

procedure TfrxBarCodeView.SetBarcodeType(const Value: Integer);
begin
  BarType := TfrxBarcodeType(Value);
end;

function TfrxBarCodeView.GetText: String;
begin
  Result := FText;
end;

procedure TfrxBarCodeView.SetText(Value: String);
begin
  FText := Value;
  if Align in [baCenter, baRight] then
    GetRealBounds;
end;

function TfrxBarCodeView.GetTextSup: String;
begin
  Result := FTextSup;
end;

procedure TfrxBarCodeView.SetTextSup(Value: String);
begin
  FTextSup := Value;
end;

procedure TfrxBarCodeView.SetZoom(v: Extended);
begin
  FZoom := v;
end;

function TfrxBarCodeView.GetZoom: Extended;
begin
  Result := FZoom;
end;

function TfrxBarCodeView.GetFont: TFont;
begin
  Result := FBarCode.BarcodeText.TextSettings.Font;
end;

function TfrxBarCodeView.GetFontHeightTop: Integer;
begin
  Result := GetFontHeight(Self, btpTop);
end;

function TfrxBarCodeView.GetFontHeightBottom: Integer;
begin
  Result := GetFontHeight(Self, btpBottom);
end;

{$IFDEF FPC}
{procedure RegisterUnitfrxBarcode;
begin
  RegisterComponents('Fast Report 6',[TfrxBarCodeObject]);
end;

procedure Register;
begin
  RegisterUnit('frxBarcode',@RegisterUnitfrxBarcode);
end;}
{$ENDIF}

initialization
{$IFDEF DELPHI16}
  StartClassGroup(TControl);
  ActivateClassGroup(TControl);
  GroupDescendentsWith(TfrxBarCodeObject, TControl);
{$ENDIF}

  frxObjects.RegisterCategory(frxBarcodeCategoryName, nil, 'obBarC', 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, '2_5_interleaved', frxBarcodeCategoryName, 0, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, '2_5_industrial', frxBarcodeCategoryName, 1, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, '2_5_matrix', frxBarcodeCategoryName, 2, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, 'ITF_14', frxBarcodeCategoryName, 3, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, 'Code11', frxBarcodeCategoryName, 4, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, 'Code39', frxBarcodeCategoryName, 5, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, 'Code39 Extended', frxBarcodeCategoryName, 6, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, 'Code128', frxBarcodeCategoryName, 7, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, 'Code128A', frxBarcodeCategoryName, 8, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, 'Code128B', frxBarcodeCategoryName, 9, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, 'Code128C', frxBarcodeCategoryName, 10, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, 'Code93', frxBarcodeCategoryName, 11, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, 'Code93 Extended', frxBarcodeCategoryName, 12, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, 'MSI', frxBarcodeCategoryName, 13, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, 'PostNet', frxBarcodeCategoryName, 14, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, 'Codabar', frxBarcodeCategoryName, 15, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, 'EAN8', frxBarcodeCategoryName, 16, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, 'EAN13', frxBarcodeCategoryName, 17, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, 'UPC_A', frxBarcodeCategoryName, 18, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, 'UPC_E0', frxBarcodeCategoryName, 19, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, 'UPC_E1', frxBarcodeCategoryName, 20, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, 'UPC_Supp2', frxBarcodeCategoryName, 21, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, 'UPC_Supp5', frxBarcodeCategoryName, 22, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, 'EAN128', frxBarcodeCategoryName, 23, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, 'EAN128A', frxBarcodeCategoryName, 24, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, 'EAN128B', frxBarcodeCategoryName, 25, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, 'EAN128C', frxBarcodeCategoryName, 26, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, 'USPS Intelligent Mail', frxBarcodeCategoryName, 27, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, 'Plessey', frxBarcodeCategoryName, 28, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, 'GS1 Code128', frxBarcodeCategoryName, 29, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, 'Pharmacode', frxBarcodeCategoryName, 30, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, 'Deutsche Post Identcode', frxBarcodeCategoryName, 31, 23);
  frxObjects.RegisterObject1(TfrxBarcodeView, nil, 'Deutsche Post Leitcode', frxBarcodeCategoryName, 32, 23);
{$IFNDEF RAD_ED}
{$IFNDEF ACADEMIC_ED}
  frxObjects.RegisterObject1(TfrxBarcode2DView, nil, 'PDF417', frxBarcodeCategoryName, 0, 23);
  frxObjects.RegisterObject1(TfrxBarcode2DView, nil, 'DataMatrix', frxBarcodeCategoryName, 1, 23);
  frxObjects.RegisterObject1(TfrxBarcode2DView, nil, 'QRCode', frxBarcodeCategoryName, 2, 23);
  frxObjects.RegisterObject1(TfrxBarcode2DView, nil, 'Aztec', frxBarcodeCategoryName, 3, 23);
  frxObjects.RegisterObject1(TfrxBarcode2DView, nil, 'MaxiCode', frxBarcodeCategoryName, 4, 23);
  frxObjects.RegisterObject1(TfrxBarcode2DView, nil, 'GS1 Databar E.', frxBarcodeCategoryName, 5, 23);
  frxObjects.RegisterObject1(TfrxBarcode2DView, nil, 'GS1 Databar E.S.', frxBarcodeCategoryName,6, 23);
  frxObjects.RegisterObject1(TfrxBarcode2DView, nil, 'Pharmacode Two-Track', frxBarcodeCategoryName,7, 23);
{$ENDIF}
{$ENDIF}
  frxObjects.RegisterObject1(TfrxBarCodeCompositeView, nil, '3515', frxBarcodeCategoryName,0, 23);
  // prevent adding these items to the Objects toolbar
  frxObjects.RegisterObject1(TfrxBarCodeInternalView, nil, '', '', 0, 23, [ctNone]);
{$IFNDEF RAD_ED}
{$IFNDEF ACADEMIC_ED}
  frxObjects.RegisterObject1(TfrxBarCodeInternal2DView, nil, '', '', 0, 23, [ctNone]);
  //
  frxRegEditorsClasses.Register(TfrxBarcode2DView, [TfrxInPlaceDataFiledEditor], [[evDesigner]]);
  frxRegEditorsClasses.Register(TfrxBarcodeView, [TfrxInPlaceDataFiledEditor], [[evDesigner]]);
{$ENDIF}
{$ENDIF}

finalization
  frxUnregisterEditorsClass(TfrxBarcodeView, TfrxInPlaceDataFiledEditor);
  frxObjects.UnRegister(TfrxBarCodeView);
{$IFNDEF RAD_ED}
{$IFNDEF ACADEMIC_ED}
  frxUnregisterEditorsClass(TfrxBarcode2DView, TfrxInPlaceDataFiledEditor);
  frxObjects.Unregister(TfrxBarcode2DView);
{$ENDIF}
{$ENDIF}

end.
