
{ ****************************************** }
{                                            }
{             FastReport VCL                 }
{          Barcode Add-in object             }
{                                            }
{         Copyright (c) 1998-2021            }
{            by Fast Reports Inc.            }
{                                            }
{ ****************************************** }

unit frxQRCodeSwissPreset;

interface

{$I frx.inc}

uses
  SysUtils, Classes, Variants, frxClass, frxBarcode2D
{$IFNDEF FPC}
     , Windows
{$ELSE}
  , LCLType
{$ENDIF}
  , Graphics;

type
 TfrxCustomPresetAttr = class(TPersistent)
  private
    function GetValue(aReport: TfrxReport; const aFileld: String): String;
  public
    function GetData(aReport: TfrxReport): String; virtual; abstract;
  end;

  TfrxSPCreditorInformation = class(TfrxCustomPresetAttr)
  private
    FIBAN: String;
  public
    function GetData(aReport: TfrxReport): String; override;
  published
    property IBAN: String read FIBAN write FIBAN;
  end;

  TfrxSPAddressType = (frAddT_S, frAddT_K);


  TfrxSPPersonInfo = class(TfrxCustomPresetAttr)
  private
    FTown: String;
    FName: String;
    FAddressTypeExp: String;
    FPostalCode: String;
    FAddressLine2: String;
    FAddressLine1: String;
    FAddressType: TfrxSPAddressType;
    FCountry: String;
  protected
    function GetAddrType(aReport: TfrxReport): String; virtual;
  public
    function GetData(aReport: TfrxReport): String; override;
    property AddressType: TfrxSPAddressType read FAddressType write FAddressType;
    property AddressTypeExp: String read FAddressTypeExp write FAddressTypeExp;
    property Name: String read FName write FName;
    property AddressLine1: String read FAddressLine1 write FAddressLine1;
    property AddressLine2: String read FAddressLine2 write FAddressLine2;
    property PostalCode: String read FPostalCode write FPostalCode;
    property Town: String read FTown write FTown;
    property Country: String read FCountry write FCountry;
  end;

  TfrxSPCreditor = class(TfrxSPPersonInfo)
  published
    property AddressType;
    property AddressTypeExp;
    property Name;
    property AddressLine1;
    property AddressLine2;
    property PostalCode;
    property Town;
    property Country;
  end;

  TfrxSPUltimateInfo = class(TfrxSPPersonInfo)
  protected
    function GetAddrType(aReport: TfrxReport): String; override;
  end;

  TfrxSPUltimateCreditor = class(TfrxSPUltimateInfo)
  published
    property AddressType;
    property AddressTypeExp;
    property Name;
    property AddressLine1;
    property AddressLine2;
    property PostalCode;
    property Town;
    property Country;
  end;

  TfrxSPPaymentAmountInfo = class(TfrxCustomPresetAttr)
  private
    FAmount: String;
    FCurrency: String;
  public
    function GetData(aReport: TfrxReport): String; override;
  published
    property Amount: String read FAmount write FAmount;
    property Currency: String read FCurrency write FCurrency;
  end;

  TfrxSPUltimateDebtor = class(TfrxSPUltimateInfo)
  published
    property AddressType;
    property AddressTypeExp;
    property Name;
    property AddressLine1;
    property AddressLine2;
    property PostalCode;
    property Town;
    property Country;
  end;

  TfrxSPReferenceType = (frRT_QRR, frRT_SCOR, frRT_NON);

  TfrxSPPaymentReference = class(TfrxCustomPresetAttr)
  private
    FReferenceTyp: TfrxSPReferenceType;
    FReference: String;
    FReferenceTypExp: String;
  public
    function GetData(aReport: TfrxReport): String; override;
  published
    property ReferenceTyp: TfrxSPReferenceType read FReferenceTyp write FReferenceTyp;
    property ReferenceTypExp: String read FReferenceTypExp write FReferenceTypExp;
    property Reference: String read FReference write FReference;
  end;

  TfrxSPAdditionalInformation = class(TfrxCustomPresetAttr)
  private
    FUnstructuredMessage: String;
    FBillInformation: String;
  public
    function GetData(aReport: TfrxReport): String; override;
  published
    property UnstructuredMessage: String read FUnstructuredMessage write FUnstructuredMessage;
    property BillInformation: String read FBillInformation write FBillInformation;
  end;

  TfrxSPAlternativeSchemes = class(TfrxCustomPresetAttr)
  private
    FSchemeParameterOne: String;
    FSchemeParameterTwo: String;
  public
    function GetData(aReport: TfrxReport): String; override;
  published
    property SchemeParameterOne: String read FSchemeParameterOne write FSchemeParameterOne;
    property SchemeParameterTwo: String read FSchemeParameterTwo write FSchemeParameterTwo;
  end;


  TfrxSwissPaymentPreset = class(TfrxCustomObjectPreset)
  private
    FAlternativeSchemes: TfrxSPAlternativeSchemes;
    FPaymentReference: TfrxSPPaymentReference;
    FPaymentAmountInfo: TfrxSPPaymentAmountInfo;
    FUltimateCreditor: TfrxSPUltimateCreditor;
    FCreditor: TfrxSPCreditor;
    FCreditorInformation: TfrxSPCreditorInformation;
    FUltimateDebtor: TfrxSPUltimateDebtor;
    FAdditionalInformation: TfrxSPAdditionalInformation;
    FSaveErrorLevels: Integer;
    FSaveGraphic: TGraphic;
  public
    constructor Create; override;
    destructor Destroy; override;
    function GetData(aReport: TfrxReport): String; override;
    procedure ApplySettings(aComponent: TfrxComponent); override;
    procedure SaveComponentState(aComponent: TfrxComponent); override;
    procedure RestoreComponentState(aComponent: TfrxComponent); override;
  published
    property CreditorInformation: TfrxSPCreditorInformation read FCreditorInformation;
    property Creditor: TfrxSPCreditor read FCreditor;
    property UltimateCreditor: TfrxSPUltimateCreditor read FUltimateCreditor;
    property PaymentAmountInfo: TfrxSPPaymentAmountInfo read FPaymentAmountInfo;
    property UltimateDebtor: TfrxSPUltimateDebtor read FUltimateDebtor;
    property PaymentReference: TfrxSPPaymentReference read FPaymentReference;
    property AdditionalInformation: TfrxSPAdditionalInformation read FAdditionalInformation;
    property AlternativeSchemes: TfrxSPAlternativeSchemes read FAlternativeSchemes;
  end;


implementation
uses frxDelphiZXingQRCode, frxBarcodeProperties, frx2DBarcodesPresets;

{$R frxSwissLogo.res}
{ TfrxSPPersonInfo }
const
   qrLineBreak =  AnsiString(#10);

function TfrxSPPersonInfo.GetAddrType(aReport: TfrxReport): String;
begin
  if Assigned(aReport) and (FAddressTypeExp <> '') then
    Result := VarToStr(aReport.Calc(FAddressTypeExp))
  else
    case AddressType of
      frAddT_S: Result := 'S';
      frAddT_K: Result := 'K';
    end;
end;

function TfrxSPPersonInfo.GetData(aReport: TfrxReport): String;
begin
  Result := '';
  Result := GetAddrType(aReport);
  Result := Result + qrLineBreak;
  Result := Result + GetValue(aReport, FName);
  Result := Result + GetValue(aReport, FAddressLine1);
  Result := Result + GetValue(aReport, FAddressLine2);
  if AddressType <> frAddT_K then
    begin
      Result := Result + GetValue(aReport, FPostalCode);
      Result := Result + GetValue(aReport, FTown);
    end
  else
    Result := Result + qrLineBreak + qrLineBreak;
  Result := Result + GetValue(aReport, FCountry);
end;

{ TfrxSPPaymentAmountInfo }

function TfrxSPPaymentAmountInfo.GetData(aReport: TfrxReport): String;
begin
  Result := GetValue(aReport, FAmount);
  Result := Result + GetValue(aReport, FCurrency);
end;

{ TfrxSPPaymentReference }

function TfrxSPPaymentReference.GetData(aReport: TfrxReport): String;
begin
  if FReferenceTypExp <> '' then
    Result := GetValue(aReport, FReferenceTypExp)
  else
  begin
    case FReferenceTyp of
      frRT_QRR: Result := 'QRR' + qrLineBreak;
      frRT_SCOR: Result := 'SCOR' + qrLineBreak;
      frRT_NON: Result := 'NON' + qrLineBreak;
    end;
  end;
  Result := Result + GetValue(aReport, FReference);
end;

{ TfrxSPAdditionalInformation }

function TfrxSPAdditionalInformation.GetData(aReport: TfrxReport): String;
begin
  Result := GetValue(aReport, FUnstructuredMessage);
  Result := Result + 'EPD';
  if FBillInformation <> '' then
    Result := Result + qrLineBreak;
  Result := Result + GetValue(aReport, FBillInformation);
end;

{ TfrxSPAlternativeSchemes }

function TfrxSPAlternativeSchemes.GetData(aReport: TfrxReport): String;
var
  tStr: String;
begin
  Result :=  '';
  tStr := '';
  if (FSchemeParameterOne <> '') or (FSchemeParameterTwo <> '') then
  begin
    tStr := GetValue(aReport, FSchemeParameterOne);
    if Assigned(aReport) and (FSchemeParameterTwo <> '') then
      tStr := tStr + VarToStr(aReport.Calc(FSchemeParameterTwo));
  end;
  Result := tStr;
end;

{ TfrxSPCreditorInformation }

function TfrxSPCreditorInformation.GetData(aReport: TfrxReport): String;
begin
  Result := '';
  if Assigned(aReport) and (FIBAN <> '') then
    Result := VarToStr(aReport.Calc(FIBAN));
  Result := Result + qrLineBreak;
end;

{ TfrxSwissPaymentPreset }

procedure TfrxSwissPaymentPreset.ApplySettings(aComponent: TfrxComponent);
var
  Props: TfrxQRProperties;
  res: TResourceStream;
  bmp: TBitmap;
begin
  if (aComponent is TfrxBarcode2DView) and (TfrxBarcode2DView(aComponent).BarType = bcCodeQR) then
  begin
    Props := TfrxQRProperties(TfrxBarcode2DView(aComponent).BarProperties);
    Props.ErrorLevels := ecM;
    Props.Logo.Width := Round(7 * fr01cm);
    Props.Logo.Height := Round(7 * fr01cm);
    res := TResourceStream.Create(hInstance, 'SWISSLOGOQR', RT_RCDATA);
    bmp := TBitmap.Create;
    try
      res.Position := 0;
      bmp.LoadFromStream(res);
      Props.Logo.Logo.Assign(bmp);
    finally
      res.Free;
      bmp.Free;
    end;
  end;
end;

constructor TfrxSwissPaymentPreset.Create;
begin
  FAlternativeSchemes := TfrxSPAlternativeSchemes.Create;
  FPaymentReference := TfrxSPPaymentReference.Create;
  FPaymentAmountInfo := TfrxSPPaymentAmountInfo.Create;
  FUltimateCreditor := TfrxSPUltimateCreditor.Create;
  FCreditor := TfrxSPCreditor.Create;
  FCreditorInformation := TfrxSPCreditorInformation.Create;
  FUltimateDebtor := TfrxSPUltimateDebtor.Create;
  FAdditionalInformation := TfrxSPAdditionalInformation.Create;
end;

destructor TfrxSwissPaymentPreset.Destroy;
begin
  FreeAndNil(FAlternativeSchemes);
  FreeAndNil(FPaymentReference);
  FreeAndNil(FPaymentAmountInfo);
  FreeAndNil(FUltimateCreditor);
  FreeAndNil(FCreditor);
  FreeAndNil(FCreditorInformation);
  FreeAndNil(FUltimateDebtor);
  FreeAndNil(FAdditionalInformation);
  FreeAndNil(FSaveGraphic);
  inherited;
end;

function TfrxSwissPaymentPreset.GetData(aReport: TfrxReport): String;
begin
  Result := 'SPC' + qrLineBreak + '0200' + qrLineBreak +'1' + qrLineBreak + CreditorInformation.GetData(aReport);
  Result := Result + Creditor.GetData(aReport);
  Result := Result + UltimateCreditor.GetData(aReport);
  Result := Result + PaymentAmountInfo.GetData(aReport);
  Result := Result + UltimateDebtor.GetData(aReport);
  Result := Result + PaymentReference.GetData(aReport);
  Result := Result + AdditionalInformation.GetData(aReport);
  Result := Result + AlternativeSchemes.GetData(aReport);
end;

procedure TfrxSwissPaymentPreset.RestoreComponentState(
  aComponent: TfrxComponent);
var
  Props: TfrxQRProperties;
begin
  if (aComponent is TfrxBarcode2DView) and (TfrxBarcode2DView(aComponent).BarType = bcCodeQR) then
  begin
    Props := TfrxQRProperties(TfrxBarcode2DView(aComponent).BarProperties);
    Props.ErrorLevels := TQRErrorLevels(Byte(FSaveErrorLevels));
    Props.Logo.Logo.Assign(FSaveGraphic);
    FreeAndNil(FSaveGraphic);
  end;
end;

procedure TfrxSwissPaymentPreset.SaveComponentState(aComponent: TfrxComponent);
var
  Props: TfrxQRProperties;
begin
  if (aComponent is TfrxBarcode2DView) and (TfrxBarcode2DView(aComponent).BarType = bcCodeQR) then
  begin
    Props := TfrxQRProperties(TfrxBarcode2DView(aComponent).BarProperties);
    FSaveErrorLevels := ord(Props.ErrorLevels);
    if Assigned(Props.Logo.Logo.Graphic) then
    begin
      FSaveGraphic := TGraphic(Props.Logo.Logo.Graphic.NewInstance);
      FSaveGraphic.Create;
      FSaveGraphic.Assign(Props.Logo.Logo.Graphic);
    end;
  end;

end;

{ TfrxCustomPresetAttr }

function TfrxCustomPresetAttr.GetValue(aReport: TfrxReport; const aFileld: String): String;
begin
  Result := '';
  if Assigned(aReport) and (aFileld <> '') then
    Result := VarToStr(aReport.Calc(aFileld));
  Result := Result + qrLineBreak;
end;

{ TfrxSPUltimateInfo }

function TfrxSPUltimateInfo.GetAddrType(aReport: TfrxReport): String;
begin
  if (FName <> '') or (FAddressLine1 <> '') or (FAddressLine2 <> '') or (FPostalCode <> '') or (FTown <> '') or (FCountry <> '') then
    Result := inherited GetAddrType(aReport)
  else
    Result := '';
end;

initialization
  RegisterClasses([TfrxSwissPaymentPreset]);
  frxBarcode2DPresetList.Add(TfrxSwissPaymentPreset);

end.
