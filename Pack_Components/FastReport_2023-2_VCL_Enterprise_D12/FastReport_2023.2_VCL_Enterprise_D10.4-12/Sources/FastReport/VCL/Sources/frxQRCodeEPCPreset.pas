
{ ****************************************** }
{                                            }
{             FastReport VCL                 }
{          Barcode Add-in object             }
{                                            }
{         Copyright (c) 1998-2021            }
{            by Fast Reports Inc.            }
{                                            }
{ ****************************************** }

unit frxQRCodeEPCPreset;

interface

{$I frx.inc}

uses
  SysUtils, Classes, Variants, frxClass, frxBarcode2D, Graphics, Types,
{$IFDEF FPC}
  LResources, LMessages, LCLType, LCLIntf, LazarusPackageIntf,
  LCLProc, FileUtil, LazHelper
{$ELSE}
  Windows
{$ENDIF};

const
  frxEPCVersionString: array[0..1] of string = ('001', '002');
  frxEPCCurrencyString: array[0..0] of string = ('EUR');

type
  TfrxEPCVersion = (V1 = 0, V2 = 1);
  TfrxEPCCurrency = (EUR = 0);
  TfrxEPCCharSet = (UTF8 = 1);
  TfrxEPCTypeRemittance = (iref, itext);

  TOneStringContent = (a, n);
  TStringContent = set of TOneStringContent;
  TArrayI = array of Integer;

  TfrxEPCHintType = (htEPCNone, htEPCLeft, htEPCRight, htEPCTop, htEPCBottom);
  TfrxEPCPaymentPreset = class;

  TfrxEPCDrawOptions = class(TPersistent)
  private
    FHint: String;
    FFrameWidth: Integer;
    FFrameColor: TColor;
    FFrameVisible: Boolean;
    FFillColor: TColor;
    FFont: TFont;
    FHintType: TfrxEPCHintType;
    FHintExpression: String;
    FOwner: TfrxEPCPaymentPreset;
    procedure SetFrameWidth(const Value: Integer);
    procedure SetFrameVisible(const Value: Boolean);
    procedure SetHintType(const Value: TfrxEPCHintType);
  public
    constructor Create(Owner: TfrxEPCPaymentPreset);
    destructor Destroy; override;
    procedure Draw(Canvas: TCanvas; ScaleX, ScaleY: Extended; Area: TRect);
    function CalcQuietZone: Integer;
  published
    property FrameColor: TColor read FFrameColor write FFrameColor default clBlack;
    property FillColor: TColor read FFillColor write FFillColor default clWhite;
    property Hint: String read FHint write FHint;
    property HintExpression: String read FHintExpression write FHintExpression;
    property HintType: TfrxEPCHintType read FHintType write SetHintType;
    property FrameWidth: Integer read FFrameWidth write SetFrameWidth default 1;
    property FrameVisible: Boolean read FFrameVisible write SetFrameVisible default False;
  end;

  TfrxEPCPMoney = class(TPersistent)
  private
    FCurrency: TfrxEPCCurrency;
    FAmount: String;
  published
    property Currency: TfrxEPCCurrency read FCurrency write FCurrency;
    property Amount: String read FAmount write FAmount;
  end;

  TfrxEPCPRemittance = class(TPersistent)
  private
    FTypeRemittance: TfrxEPCTypeRemittance;
    FValue: String;
  published
    property Value: String read FValue write FValue;
    property TypeRemittance: TfrxEPCTypeRemittance read FTypeRemittance write FTypeRemittance;
  end;

  TfrxEPCPaymentPreset = class(TfrxCustomObjectPreset)
  private
    FServiceTag: String;
    FVersion: TfrxEPCVersion;
    FCharSet: TfrxEPCCharSet;
    FIdentification: String;
    FBIC: String;
    FName: String;
    FIBAN: String;
    FDrawOptions: TfrxEPCDrawOptions;
    FMoney: TfrxEPCPMoney;
    FPurpose: String;
    FRemittance: TfrxEPCPRemittance;
    FInformation: String;
    //
    FSaveErrorLevels: Integer;
    FSaveShowText: Boolean;
    FOwner: TfrxComponent;
    procedure CheckString(pref, s: String; variants: TArrayI; Content: TStringContent; Mandatory: Boolean); overload;
    //procedure CheckString(pref, s: String; Lng: Integer; Content: TStringContent; Mandatory: Boolean); overload;
    procedure CheckString(pref, s: String; LngMin, LngMax: Integer; Content: TStringContent; Mandatory: Boolean); overload;
    procedure StartCheck(pref, s: String; Mandatory: Boolean);
    procedure CheckContent(pref, s: String; Content: TStringContent);
    function AmountToString(aReport: TfrxReport): String;
    function RemittanceToString(aReport: TfrxReport): String;
    procedure CreateError(a: String);
  public
    constructor Create; override;
    destructor Destroy; override;
    function GetData(aReport: TfrxReport): String; override;
    procedure ApplySettings(aComponent: TfrxComponent); override;
    procedure SaveComponentState(aComponent: TfrxComponent); override;
    procedure RestoreComponentState(aComponent: TfrxComponent); override;
    procedure BeginDraw(Canvas: TCanvas; ScaleX, ScaleY: Extended; Area: TRect); override;
    procedure UpdateSettings;
  published
    property ServiceTag: String read FServiceTag;
    property Version: TfrxEPCVersion read FVersion write FVersion;
    property CharSet: TfrxEPCCharSet read FCharSet write FCharSet;
    property Identification: String read FIdentification;
    property BIC: String read FBIC write FBIC;
    property Name: String read FName write FName;
    property IBAN: String read FIBAN write FIBAN;
    property Money: TfrxEPCPMoney read FMoney write FMoney;
    property Purpose: String read FPurpose write FPurpose;
    property Remittance: TfrxEPCPRemittance read FRemittance write FRemittance;
    property Information: String read FInformation write FInformation;
    property DrawOptions: TfrxEPCDrawOptions read FDrawOptions write FDrawOptions;
  end;

  function GetValue(aReport: TfrxReport; const aFileld: String): String;
  function VersionToString(vers: TfrxEPCVersion): String;
  function CurrencyToString(cur: TfrxEPCCurrency): String;
  function TArrayIToString(arr: TArrayI): String;
  function FindInArray(arr: TArrayI; val: Integer): Boolean;

implementation

uses frxDelphiZXingQRCode, frxBarcodeProperties, frx2DBarcodesPresets, frxPrinter, frxUtils, Math
{$IFDEF LCLGTK2}
  , Printers
{$ENDIF};

const
  qrLineBreak =  AnsiString(#10);

procedure TfrxEPCPaymentPreset.ApplySettings(aComponent: TfrxComponent);
var
  Props: TfrxQRProperties;
begin
  if (aComponent is TfrxBarcode2DView) and (TfrxBarcode2DView(aComponent).BarType = bcCodeQR) then
  begin
    Props := TfrxQRProperties(TfrxBarcode2DView(aComponent).BarProperties);
    Props.ErrorLevels := ecM;
    TfrxBarcode2DView(aComponent).QuietZone := FDrawOptions.CalcQuietZone - Props.QuietZone;
    TfrxBarcode2DView(aComponent).ShowText := False;
    FOwner := aComponent;
  end;
end;

constructor TfrxEPCPaymentPreset.Create;
begin
  inherited;
  FMoney := TfrxEPCPMoney.Create;
  FDrawOptions := TfrxEPCDrawOptions.Create(Self);
  FRemittance := TfrxEPCPRemittance.Create;
  FMoney.Currency := EUR;
  FMoney.Amount := '0.01';
  FRemittance.TypeRemittance := itext;
  FServiceTag := 'BCD';
  FVersion := V1;
  FCharSet := UTF8;
  FIdentification := 'SCT';
end;

destructor TfrxEPCPaymentPreset.Destroy;
begin
  FreeAndNil(FRemittance);
  FreeAndNil(FMoney);
  FreeAndNil(FDrawOptions);
  inherited;
end;

procedure TfrxEPCPaymentPreset.BeginDraw(Canvas: TCanvas; ScaleX, ScaleY: Extended; Area: TRect);
begin
  FDrawOptions.Draw(Canvas, ScaleX, ScaleY, Area);
end;

procedure TfrxEPCPaymentPreset.CheckString(pref, s: String; variants: TArrayI; Content: TStringContent; Mandatory: Boolean);
var
  lens: Integer;
begin
  StartCheck(pref, s, Mandatory);

  lens := Length(s);
  if (lens > 0) then
    if (not FindInArray(variants, lens)) then
      CreateError('property ' + pref + ' must be [' + TArrayIToString(variants) + '] but have ' + IntToStr(lens));
  CheckContent(pref, s, Content);
end;

{procedure TfrxEPCPaymentPreset.CheckString(pref, s: String; Lng: Integer; Content: TStringContent; Mandatory: Boolean);
var
  lens: Integer;
begin
  StartCheck(pref, s, Mandatory);

  lens := Length(s);
  if (lens > 0) then
    if (lens <> Lng) then
      CreateError('property ' + pref + ' must be ' + IntToStr(Lng) + ' but have ' + IntToStr(lens));
  CheckContent(pref, s, Content);
end;}

procedure TfrxEPCPaymentPreset.CheckString(pref, s: String; LngMin, LngMax: Integer; Content: TStringContent; Mandatory: Boolean);
var
  lens: Integer;
begin
  StartCheck(pref, s, Mandatory);

  lens := length(s);
  if (lens > 0) then
    if (lens < LngMin) or (lens > LngMax) then
      CreateError('property ' + pref + ' must be in [' + IntToStr(LngMin) + '-' + IntToStr(LngMax) + ' but have ' + IntToStr(lens));
  CheckContent(pref, s, Content);
end;

procedure TfrxEPCPaymentPreset.StartCheck(pref, s: String; Mandatory: Boolean);
begin
  if (Mandatory) then
    if (s = '') then
      CreateError('Mandatory property ' + pref + ' is empty');
end;

procedure TfrxEPCPaymentPreset.UpdateSettings;
begin
  if Assigned(FOwner) then
    ApplySettings(FOwner);
end;

procedure TfrxEPCPaymentPreset.CheckContent(pref, s: String; Content: TStringContent);
begin
  //not need now
end;

function TfrxEPCPaymentPreset.AmountToString(aReport: TfrxReport): String;
var
  bufs: String;
  bufd: Double;
begin
  bufd := 0;
  bufs := GetValue(aReport, FMoney.Amount);
  try
    bufd := StrToFloat(bufs);
  except
    CreateError('Wrong amount format');
  end;
  if ((bufd < 0.01) or (bufd > 999999999.99)) then
    CreateError('Amount must be 0.01 or more and 999999999.99 or less');
  bufs := FloatToStrF(bufd, ffGeneral, 9, 2);
  bufs  := StringReplace(bufs, ',', '.', [rfReplaceAll, rfIgnoreCase]);

  Result := CurrencyToString(FMoney.Currency) + bufs;
end;

function TfrxEPCPaymentPreset.RemittanceToString(aReport: TfrxReport): String;
var
  max: Integer;
  buf: String;
begin
  if (FRemittance.TypeRemittance = itext) then
    max := 35
  else
    max := 140;
  buf := GetValue(aReport, FRemittance.Value);
  CheckString('Remittance', buf, 1, max, [a, n], False);
  Result := buf;
  if (FRemittance.TypeRemittance = itext) then
    Result := qrLineBreak + Result
  else
    Result := Result + qrLineBreak;
end;

procedure TfrxEPCPaymentPreset.CreateError(a: String);
begin
  raise Exception.Create(a);
end;

function TfrxEPCPaymentPreset.GetData(aReport: TfrxReport): String;
var
  buf: String;
  vars: TArrayI;
begin
  Result := FServiceTag + qrLineBreak;                                          //w.o. check
  Result := Result + VersionToString(FVersion) + qrLineBreak;                   //w.o. check
  Result := Result + IntToStr(Integer(UTF8)) + qrLineBreak;                     //w.o. check
  Result := Result + FIdentification + qrLineBreak;                             //w.o. check

  buf := GetValue(aReport, FBIC);
  SetLength(vars, 2);
  vars[0] := 8;
  vars[1] := 11;
  CheckString('BIC', buf, vars, [a, n], FVersion = V1);
  Result := Result + buf + qrLineBreak;
  buf := GetValue(aReport, FName);
  CheckString('Name', buf, 1, 70, [a, n], True);
  Result := Result + buf + qrLineBreak;
  buf := GetValue(aReport, FIBAN);
  CheckString('IBAN', buf, 1, 34, [a, n], True);
  Result := Result + buf + qrLineBreak;

  Result := Result + AmountToString(aReport) + qrLineBreak;                     //check inside

  buf := GetValue(aReport, FPurpose);
  CheckString('Reason', buf, 1, 4, [a, n], False);
  Result := Result + buf + qrLineBreak;

  Result := Result + RemittanceToString(aReport) + qrLineBreak;                 //check inside

  buf := GetValue(aReport, FInformation);
  CheckString('Information', buf, 1, 70, [a, n], False);
  Result := Result + buf;

  if FDrawOptions.HintExpression <> '' then
    FDrawOptions.Hint := GetValue(aReport, FDrawOptions.HintExpression);

  while (Result[Length(Result)] = qrLineBreak) do
    Delete(Result, Length(Result), 1)
end;

procedure TfrxEPCPaymentPreset.RestoreComponentState(
  aComponent: TfrxComponent);
var
  Props: TfrxQRProperties;
begin
  if (aComponent is TfrxBarcode2DView) and (TfrxBarcode2DView(aComponent).BarType = bcCodeQR) then
  begin
    Props := TfrxQRProperties(TfrxBarcode2DView(aComponent).BarProperties);
    Props.ErrorLevels := TQRErrorLevels(Byte(FSaveErrorLevels));
    TfrxBarcode2DView(aComponent).ShowText := FSaveShowText;
    FOwner := nil;
  end;
end;

procedure TfrxEPCPaymentPreset.SaveComponentState(aComponent: TfrxComponent);
var
  Props: TfrxQRProperties;
begin
  if (aComponent is TfrxBarcode2DView) and (TfrxBarcode2DView(aComponent).BarType = bcCodeQR) then
  begin
    Props := TfrxQRProperties(TfrxBarcode2DView(aComponent).BarProperties);
    FSaveErrorLevels := ord(Props.ErrorLevels);
    FSaveShowText := TfrxBarcode2DView(aComponent).ShowText;
  end;
end;

{ Helpels }

function GetValue(aReport: TfrxReport; const aFileld: String): String;
begin
  Result := '';
  if Assigned(aReport) and (aFileld <> '') then
    Result := VarToStr(aReport.Calc(aFileld));
  Result := Result;
end;

function VersionToString(vers: TfrxEPCVersion): String;
begin
  Result := frxEPCVersionString[Integer(vers)];
end;

function CurrencyToString(cur: TfrxEPCCurrency): String;
begin
  Result := frxEPCCurrencyString[Integer(cur)];
end;

function TArrayIToString(arr: TArrayI): String;
var
  i: Integer;
begin
  Result := IntToStr(arr[0]);
  for i := 1 to Length(arr) - 1 do
    Result := Result + '/' + IntToStr(arr[i]);
end;

function FindInArray(arr: TArrayI; val: Integer): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to Length(arr) - 1 do
    if arr[i] = val then
    begin
      Result := True;
      break;
    end;
end;

{ TfrxEPCPFrame }

function TfrxEPCDrawOptions.CalcQuietZone: Integer;
begin
  Result := 0;
  if FFrameVisible then
  begin
    if FHintType <> htEPCNone then
      Result := Abs(FFont.Height);
    Result := Result + FFrameWidth * 2 + 1
  end;
end;

constructor TfrxEPCDrawOptions.Create(Owner: TfrxEPCPaymentPreset);
begin
  FFrameWidth := 1;
  FFont := TFont.Create;
  FFont.Name := 'Arial';
  FFont.Size := 8;
  FFrameColor := clBlack;
  FFillColor := clWhite;
  FOwner := Owner;
end;

destructor TfrxEPCDrawOptions.Destroy;
begin
  FreeAndNil(FFont);
  FOwner := nil;
  inherited;
end;

procedure TfrxEPCDrawOptions.Draw(Canvas: TCanvas; ScaleX, ScaleY: Extended; Area: TRect);
var
  dx, curve, Angle: Integer;
  F: TLogFont;
  FontHandle, OldFontHandle: HFont;
  fontScale: Extended;
  textLeftOffset, txtX, txtY: Integer;
  footerHeight: Integer;
begin
  if not FrameVisible then Exit;
  if HintType in [htEPCTop, htEPCBottom] then
    Angle := 0
  else
    Angle := 90;
  Canvas.Pen.Style := psClear;
  if FillColor <> clNone then
  begin
    Canvas.Brush.Style := bsSolid;
    Canvas.Brush.Color := FillColor
  end
  else
    Canvas.Brush.Style := bsClear;
  curve := Min(Area.Right - Area.Left, Area.Bottom - Area.Top) div 8;
  RoundRect(Canvas.Handle, Area.Left, Area.Top, Area.Right, Area.Bottom, curve, curve);
  if FrameColor <> clNone then
  begin
    Canvas.Pen.Style := psSolid;
    Canvas.Pen.Width := FrameWidth;
    Canvas.Pen.Color := FrameColor;
  end;

  if HintType <> htEPCNone then
  begin
    fontScale := 1.0;
    if not (Canvas is {$IFDEF LCLGTK2}TPrinterCanvas{$ELSE}TfrxPrinterCanvas{$ENDIF}) then
      fontScale := ScaleY;
    Canvas.Font.Assign(FFont);
    Canvas.Font.Height := -round(MulDiv(Canvas.Font.Size, Canvas.Font.PixelsPerInch, 72) * fontScale);
    Canvas.Font.Height := Max(Round(Canvas.Font.Height * (Area.Right - Area.Left - curve * 2) / Canvas.TextWidth(' ' + Hint + ' ')), Canvas.Font.Height);
    txtX := 0;
    txtY := 0;

    GetObject(Canvas.Font.Handle, SizeOf(TLogFont), @F);
    F.lfEscapement := round(Angle * 10);
    F.lfOrientation := F.lfEscapement;

    FontHandle := CreateFontIndirect(F);
    OldFontHandle := SelectObject(Canvas.Handle, FontHandle);
    Canvas.Font.Handle := FontHandle;
    Canvas.Brush.Color := FillColor;
    if FillColor <> clNone then
      frxSetBkMode(Canvas, OPAQUE)
    else
      frxSetBkMode(Canvas, TRANSPARENT);

    footerHeight :=  Abs(F.lfHeight);

    textLeftOffset := (Area.Right - Area.Left - Canvas.TextWidth(' ' + Hint + ' ')) div 2;
    if textLeftOffset < 0 then
      textLeftOffset := 0;

    case HintType of
      htEPCLeft:
        begin
          txtX := Area.Left + 1;
          txtY := Area.Bottom - textLeftOffset;
        end;
      htEPCRight:
        begin
          txtX := Area.Right - footerHeight - 4;
          txtY := Area.Bottom - textLeftOffset;
        end;
      htEPCTop:
        begin
          txtX := textLeftOffset + Area.Left;
          txtY := Area.Top + 1;
        end;
      htEPCBottom:
        begin
          txtX := textLeftOffset + Area.Left;
          txtY := Area.Bottom - footerHeight - 4;
        end;
    end;
    dx := -Round((Abs(F.lfHeight) + FFrameWidth * ScaleY) / 2 - fontScale);
    InflateRect(Area, dx, dx);
    if FillColor = clNone then
      Canvas.Brush.Style := bsClear;
    RoundRect(Canvas.Handle, Area.Left, Area.Top, Area.Right, Area.Bottom, curve, curve);
    Canvas.TextOut(txtX , txtY , ' ' + Hint + ' ');
    SelectObject(Canvas.Handle, OldFontHandle);
    {$IFNDEF FPC}
    DeleteObject(FontHandle);
    {$ENDIF}
  end
  else
    RoundRect(Canvas.Handle, Area.Left, Area.Top, Area.Right, Area.Bottom, curve, curve);
end;


procedure TfrxEPCDrawOptions.SetFrameVisible(const Value: Boolean);
begin
  FFrameVisible := Value;
  if Assigned(FOwner) then
    FOwner.UpdateSettings;
end;

procedure TfrxEPCDrawOptions.SetFrameWidth(const Value: Integer);
begin
  if Value <= 0 then
    FFrameWidth := 1
  else
    FFrameWidth := Value;
  if Assigned(FOwner) then
    FOwner.UpdateSettings;
end;

procedure TfrxEPCDrawOptions.SetHintType(const Value: TfrxEPCHintType);
begin
  FHintType := Value;
  if Assigned(FOwner) then
    FOwner.UpdateSettings;
end;

initialization
  RegisterClasses([TfrxEPCPaymentPreset]);
  frxBarcode2DPresetList.Add(TfrxEPCPaymentPreset);

end.
