{ ****************************************** }
{                                            }
{             FastReport VCL                 }
{            QRCodeSberPreset                }
{                                            }
{         Copyright (c) 1998-2021            }
{            by Fast Reports Inc.            }
{                                            }
{ ****************************************** }

unit frxQRCodeSberPreset;

interface

{$I frx.inc}

uses
  SysUtils, Classes, Variants, frxClass, TypInfo, frxBarcode2D;

type

 TfrxSberEncoding = (ec_WIN1251 ,ec_UTF8 ,ec_KOI8_R);
 TfrxFieldTypesQR = (fdExpression, fdStatic);

 TfrxCustomPresetAttr = class(TPersistent)
  private
    FSeparator: Char;
    FEncoding: TfrxSberEncoding;
    FFieldTypes : TfrxFieldTypesQR;
    function GetValue(aReport: TfrxReport; const aFileld: String; const aFileldName: String): String;
  public
    function GetData(aReport: TfrxReport): String; virtual; abstract;
  published
    function GetEncoding: TfrxSberEncoding;
    function GetSeparator: Char;
    function GetFieldTypes: TfrxFieldTypesQR;
  end;

 TfrxSberPayee = class(TfrxCustomPresetAttr)
  private
    FName: String;
    FPersonalAcc: String;
    FBankName: String;
    FBIC: String;
    FCorrespAcc: String;
    procedure SetName(val: String);
    procedure SetPersonalAcc(val: String);
    procedure SetBankName(val: String);
    procedure SetBIC(val: String);
    procedure SetCorrespAcc(val: String);
  public
    function GetData(aReport: TfrxReport): String; override;
  published
    property Name: String read FName write SetName;
    property PersonalAcc: String read FPersonalAcc write SetPersonalAcc;
    property BankName: String read FBankName write SetBankName;
    property BIC: String read FBIC write SetBIC;
    property CorrespAcc: String read FCorrespAcc write SetCorrespAcc;
  end;

 TfrxSberPayeeAdditionalInfo = class(TfrxCustomPresetAttr)
  private
    FPayeeINN: String;
    FKPP: String;
    procedure SetPayeeINN(val: String);
    procedure SetKPP(val: String);
  public
    function GetData(aReport: TfrxReport): String; override;
  published
    property PayeeINN: String read FPayeeINN write SetPayeeINN;
    property KPP: String read FKPP write SetKPP;
  end;

  TfrxSberDepartmentalInfo = class(TfrxCustomPresetAttr)
  private
    FDrawerStatus: String;
    FCBC: String;
    FOKTMO: String;
    FPaytReason: String;
    FTaxPeriod: String;
    FDocNo: String;
    FDocDate: String;
    FTaxPaytKind: String;
    procedure SetDrawerStatus(val: String);
    procedure SetCBC(val: String);
    procedure SetOKTMO(val: String);
    procedure SetPaytReason(val: String);
    procedure SetTaxPeriod(val: String);
    procedure SetDocNo(val: String);
    procedure SetDocDate(val: String);
    procedure SetTaxPaytKind(val: String);
  public
    function GetData(aReport: TfrxReport): String; override;
  published
    property DrawerStatus: String read FDrawerStatus write SetDrawerStatus;
    property CBC: String read FCBC write SetCBC;
    property OKTMO: String read FOKTMO write SetOKTMO;
    property PaytReason: String read FPaytReason write SetPaytReason;
    property TaxPeriod: String read FTaxPeriod write SetTaxPeriod;
    property DocNo: String read FDocNo write SetDocNo;
    property DocDate: String read FDocDate write SetDocDate;
    property TaxPaytKind: String read FTaxPaytKind write SetTaxPaytKind;
  end;

  TfrxSberRequiredBankingDetails = class(TfrxCustomPresetAttr)
  private
    FPayee: TfrxSberPayee;
    procedure SetPayee(val: TfrxSberPayee);
  public
    constructor Create;
    destructor Destroy; override;
    function GetData(aReport: TfrxReport): String; override;
  published
    property Payee: TfrxSberPayee read FPayee write SetPayee;
  end;

  TfrxSberAdditionalBankingDetails = class(TfrxCustomPresetAttr)
  private
    FSum: String;
    FPurpose: String;
    FPayeeAdditionalInfo: TfrxSberPayeeAdditionalInfo;
    FPayerINN: String;
    FDepartmentalInfo: TfrxSberDepartmentalInfo;
    procedure SetSum(val: String);
    procedure SetPurpose(val: String);
    procedure SetPayeeAdditionalInfo(val: TfrxSberPayeeAdditionalInfo);
    procedure SetPayerINN(val: String);
    procedure SetDepartmentalInfo(val: TfrxSberDepartmentalInfo);
  public
    constructor Create;
    destructor Destroy; override;
    function GetData(aReport: TfrxReport): String; override;
  published
    property Sum: String read FSum write SetSum;
    property Purpose: String read FPurpose write SetPurpose;
    property PayeeAdditionalInfo: TfrxSberPayeeAdditionalInfo read FPayeeAdditionalInfo
      write SetPayeeAdditionalInfo;
    property PayerINN: String read FPayerINN write SetPayerINN;
    property DepartmentalInfo: TfrxSberDepartmentalInfo read FDepartmentalInfo
      write SetDepartmentalInfo;
  end;

  TfrxSberOtherAdditionalBankingDetails = class(TfrxCustomPresetAttr)
  private
    FLastName: String;
    FFirstName: String;
    FMiddleName: String;
    FPayerAddress: String;
    FPersonalAccount: String;
    FDocIdx: String;
    FPensAcc: String;
    FContract: String;
    FPersAcc: String;
    FFlat: String;
    FPhone: String;
    FPayerIdType: String;
    FPayerIdNum: String;
    FChildFio: String;
    FBirthDate: String;
    FPaymTerm: String;
    FPaymPeriod: String;
    FCategory: String;
    FServiceName: String;
    FCounterId: String;
    FCounterVal: String;
    FQuittId: String;
    FInstNum: String;
    FClassNum: String;
    FSpecFio: String;
    FAddAmount: String;
    FRuleId: String;
    FExecId: String;
    FRegType: String;
    FUIN: String;
    FTechCode: String;
  public
    function GetData(aReport: TfrxReport): String; override;
  published
    property LastName: String read FLastName write FLastName;
    property FirstName: String read FFirstName write FFirstName;
    property MiddleName: String read FMiddleName write FMiddleName;
    property PayerAddress: String read FPayerAddress write FPayerAddress;
    property PersonalAccount: String read FPersonalAccount write FPersonalAccount;
    property DocIdx: String read FDocIdx write FDocIdx;
    property PensAcc: String read FPensAcc write FPensAcc;
    property Contract: String read FContract write FContract;
    property PersAcc: String read FPersAcc write FPersAcc;
    property Flat: String read FFlat write FFlat;
    property Phone: String read FPhone write FPhone;
    property PayerIdType: String read FPayerIdType write FPayerIdType;
    property PayerIdNum: String read FPayerIdNum write FPayerIdNum;
    property ChildFio: String read FChildFio write FChildFio;
    property BirthDate: String read FBirthDate write FBirthDate;
    property PaymTerm: String read FPaymTerm write FPaymTerm;
    property PaymPeriod: String read FPaymPeriod write FPaymPeriod;
    property Category: String read FCategory write FCategory;
    property ServiceName: String read FServiceName write FServiceName;
    property CounterId: String read FCounterId write FCounterId;
    property CounterVal: String read FCounterVal write FCounterVal;
    property QuittId: String read FQuittId write FQuittId;
    property InstNum: String read FInstNum write FInstNum;
    property ClassNum: String read FClassNum write FClassNum;
    property SpecFio: String read FSpecFio write FSpecFio;
    property AddAmount: String read FAddAmount write FAddAmount;
    property RuleId: String read FRuleId write FRuleId;
    property ExecId: String read FExecId write FExecId;
    property RegType: String read FRegType write FRegType;
    property UIN: String read FUIN write FUIN;
    property TechCode: String read FTechCode write FTechCode;
  end;

 TfrxSberData = class(TfrxCustomPresetAttr)
  private
    FIdFormat: String;
    FVersion: String;
    FRequiredBankingDetails: TfrxSberRequiredBankingDetails;
    FAdditionalBankingDetails: TfrxSberAdditionalBankingDetails;
    FOtherAdditionalBankingDetails: TfrxSberOtherAdditionalBankingDetails;
    procedure SetIdFormat(val: String);
    procedure SetVersion(val: String);
    procedure SetEncoding(val: TfrxSberEncoding);
    procedure SetSeparator(val: Char);
    procedure SetFieldTypes(val: TfrxFieldTypesQR);
  public
    constructor Create;
    destructor Destroy; override;
    function GetData(aReport: TfrxReport): String; override;
  published
    property IdFormat: String read FIdFormat write SetIdFormat;
    property Version: String read FVersion write SetVersion;
    property Encoding: TfrxSberEncoding read GetEncoding write SetEncoding default ec_WIN1251;
    property Separator: Char read GetSeparator write SetSeparator default '|';
    property FieldTypes : TfrxFieldTypesQR read GetFieldTypes write SetFieldTypes default fdExpression;
  end;

   TfrxSberPaymentPreset = class(TfrxCustomObjectPreset)
  private
    FSberData: TfrxSberData;
    FSaveErrorLevels: Integer;
    FSaveMarker: Boolean;
    FSaveShowText: Boolean;
    function GetRequiredBankingDetails: TfrxSberRequiredBankingDetails;
    function GetAdditionalBankingDetails: TfrxSberAdditionalBankingDetails;
    function GetOtherAdditionalBankingDetails: TfrxSberOtherAdditionalBankingDetails;
  public
    constructor Create; override;
    destructor Destroy; override;
    function GetData(aReport: TfrxReport): String; override;
    procedure ApplySettings(aComponent: TfrxComponent); override;
    procedure SaveComponentState(aComponent: TfrxComponent); override;
    procedure RestoreComponentState(aComponent: TfrxComponent); override;
  published
    property SberData: TfrxSberData read FSberData;
    property RequiredBankingDetails: TfrxSberRequiredBankingDetails
      read GetRequiredBankingDetails;
    property AdditionalBankingDetails: TfrxSberAdditionalBankingDetails
      read GetAdditionalBankingDetails;
    property OtherAdditionalBankingDetails: TfrxSberOtherAdditionalBankingDetails
      read GetOtherAdditionalBankingDetails;
  end;

implementation

uses frx2DBarcodesPresets, frxBarcodeProperties, frxDelphiZXingQRCode
{$IFNDEF FPC}
     , Windows
{$ELSE}
  , LCLType
{$ENDIF}
, Graphics;

const
   chEquality =  AnsiString(#61);

{ TfrxSberServiceData }

procedure TfrxSberData.SetIdFormat(val: String);
begin
  if (FFieldTypes = fdExpression) or ((FFieldTypes = fdStatic) and (Length(val) <= 2)) then
    FIdFormat := val;
end;

procedure TfrxSberData.SetVersion(val: String);
begin
  if (FFieldTypes = fdExpression) or ((FFieldTypes = fdStatic) and (Length(val) <= 4)) then
    FVersion := val;
end;

procedure TfrxSberData.SetEncoding(val: TfrxSberEncoding);
begin
  FEncoding := val;
  FRequiredBankingDetails.FEncoding:= val;
  FRequiredBankingDetails.FPayee.FEncoding:= val;
  FAdditionalBankingDetails.FEncoding:= val;
  FAdditionalBankingDetails.FPayeeAdditionalInfo.FEncoding:= val;
  FAdditionalBankingDetails.FDepartmentalInfo.FEncoding:= val;
  FOtherAdditionalBankingDetails.FEncoding:= val;
end;

procedure TfrxSberData.SetSeparator(val: Char);
begin
  FSeparator := val;
  FRequiredBankingDetails.FSeparator:= val;
  FRequiredBankingDetails.FPayee.FSeparator:= val;
  FAdditionalBankingDetails.FSeparator:= val;
  FAdditionalBankingDetails.FPayeeAdditionalInfo.FSeparator:= val;
  FAdditionalBankingDetails.FSeparator:= val;
  FOtherAdditionalBankingDetails.FSeparator:= val;
end;

procedure TfrxSberData.SetFieldTypes(val: TfrxFieldTypesQR);
begin
  FFieldTypes := val;
  FRequiredBankingDetails.FFieldTypes:= val;
  FRequiredBankingDetails.FPayee.FFieldTypes:= val;
  FAdditionalBankingDetails.FFieldTypes:= val;
  FAdditionalBankingDetails.FPayeeAdditionalInfo.FFieldTypes:= val;
  FAdditionalBankingDetails.FFieldTypes:= val;
  FOtherAdditionalBankingDetails.FFieldTypes:= val;
end;

constructor TfrxSberData.Create;
begin
  FIdFormat :='ST';
  FVersion := '0001';
  FRequiredBankingDetails := TfrxSberRequiredBankingDetails.Create;
  FAdditionalBankingDetails := TfrxSberAdditionalBankingDetails.Create;
  FOtherAdditionalBankingDetails := TfrxSberOtherAdditionalBankingDetails.Create;
  Encoding := ec_WIN1251;
  Separator := '|';
  FieldTypes := fdExpression;
end;

destructor TfrxSberData.Destroy;
begin
  FreeAndNil(FRequiredBankingDetails);
  FreeAndNil(FAdditionalBankingDetails);
  FreeAndNil(FOtherAdditionalBankingDetails);
  inherited;
end;

function TfrxSberData.GetData(aReport: TfrxReport): String;
begin
  Result := '';
  Result := Result + FIdFormat;
  Result := Result + FVersion;
  Result := Result + IntToStr(GetEnumValue(TypeInfo(TfrxSberEncoding),
              (GetEnumName(TypeInfo(TfrxSberEncoding),Ord(FEncoding))))+1);
  Result := Result + FSeparator;
end;

{ TfrxSberPayee }

procedure TfrxSberPayee.SetName(val: String);
begin
  if (FFieldTypes = fdExpression) or ((FFieldTypes = fdStatic) and (Length(val) <= 160)) then
    FName := val;
end;

procedure TfrxSberPayee.SetPersonalAcc(val: String);
begin
  if (FFieldTypes = fdExpression) or ((FFieldTypes = fdStatic) and (Length(val) <= 20)) then
    FPersonalAcc := val;
end;

procedure TfrxSberPayee.SetBankName(val: String);
begin
  if (FFieldTypes = fdExpression) or ((FFieldTypes = fdStatic) and (Length(val) <= 45)) then
    FBankName := val;
end;

procedure TfrxSberPayee.SetBIC(val: String);
begin
  if (FFieldTypes = fdExpression) or ((FFieldTypes = fdStatic) and (Length(val) <= 9)) then
    FBIC := val;
end;

procedure TfrxSberPayee.SetCorrespAcc(val: String);
begin
  if (FFieldTypes = fdExpression) or ((FFieldTypes = fdStatic) and (Length(val) <= 20)) then
    FCorrespAcc := val;
end;

function TfrxSberPayee.GetData(aReport: TfrxReport): String;
begin
  Result := '';
  Result := Result + GetValue(aReport, FName, 'Name');
  Result := Result + GetValue(aReport, FPersonalAcc, 'PersonalAcc');
  Result := Result + GetValue(aReport, FBankName,  'BankName');
  Result := Result + GetValue(aReport, FBIC, 'BIC');
  Result := Result + GetValue(aReport, FCorrespAcc, 'CorrespAcc');
end;

{ TfrxSberPayeeAdditionalInfo }

procedure TfrxSberPayeeAdditionalInfo.SetPayeeINN(val: String);
begin
  if (FFieldTypes = fdExpression) or ((FFieldTypes = fdStatic) and (Length(val) <= 12)) then
    FPayeeINN := val;
end;

procedure TfrxSberPayeeAdditionalInfo.SetKPP(val: String);
begin
  if (FFieldTypes = fdExpression) or ((FFieldTypes = fdStatic) and (Length(val) <= 9)) then
    FKPP := val;
end;

function TfrxSberPayeeAdditionalInfo.GetData(aReport: TfrxReport): String;
begin
  Result := '';
  Result := Result + GetValue(aReport, FPayeeINN, 'PayeeINN');
  Result := Result + GetValue(aReport, FKPP, 'KPP');
end;

{ TfrxSberDepartmentalInfo }

procedure TfrxSberDepartmentalInfo.SetDrawerStatus(val: String);
begin
  if (FFieldTypes = fdExpression) or ((FFieldTypes = fdStatic) and (Length(val) <= 2)) then
    FDrawerStatus := val;
end;

procedure TfrxSberDepartmentalInfo.SetCBC(val: String);
begin
  if (FFieldTypes = fdExpression) or ((FFieldTypes = fdStatic) and (Length(val) <= 20)) then
    FCBC := val;
end;

procedure TfrxSberDepartmentalInfo.SetOKTMO(val: String);
begin
  if (FFieldTypes = fdExpression) or ((FFieldTypes = fdStatic) and (Length(val) <= 11)) then
    FOKTMO := val;
end;

procedure TfrxSberDepartmentalInfo.SetPaytReason(val: String);
begin
  if (FFieldTypes = fdExpression) or ((FFieldTypes = fdStatic) and (Length(val) <= 2)) then
    FPaytReason := val;
end;

procedure TfrxSberDepartmentalInfo.SetTaxPeriod(val: String);
begin
  if (FFieldTypes = fdExpression) or ((FFieldTypes = fdStatic) and (Length(val) <= 10)) then
    FTaxPeriod := val;
end;

procedure TfrxSberDepartmentalInfo.SetDocNo(val: String);
begin
  if (FFieldTypes = fdExpression) or ((FFieldTypes = fdStatic) and (Length(val) <= 15)) then
    FDocNo := val;
end;

procedure TfrxSberDepartmentalInfo.SetDocDate(val: String);
begin
  if (FFieldTypes = fdExpression) or ((FFieldTypes = fdStatic) and (Length(val) <= 10)) then
    FDocDate := val;
end;

procedure TfrxSberDepartmentalInfo.SetTaxPaytKind(val: String);
begin
  if (FFieldTypes = fdExpression) or ((FFieldTypes = fdStatic) and (Length(val) <= 2)) then
    FTaxPaytKind := val;
end;

function TfrxSberDepartmentalInfo.GetData(aReport: TfrxReport): String;
begin
  Result := '';
  Result := Result + GetValue(aReport, FDrawerStatus, 'DrawerStatus');
  Result := Result + GetValue(aReport, FCBC, 'CBC');
  Result := Result + GetValue(aReport, FOKTMO, 'OKTMO');
  Result := Result + GetValue(aReport, FPaytReason, 'PaytReason');
  Result := Result + GetValue(aReport, TaxPeriod, 'TaxPeriod');
  Result := Result + GetValue(aReport, FDocNo, 'DocNo');
  Result := Result + GetValue(aReport, FDocDate, 'DocDate');
  Result := Result + GetValue(aReport, FTaxPaytKind, 'TaxPaytKind');
end;

{ TfrxSberRequiredBankingDetails }

procedure TfrxSberRequiredBankingDetails.SetPayee(val: TfrxSberPayee);
begin
    FPayee := val;
end;

constructor TfrxSberRequiredBankingDetails.Create;
begin
  inherited;
  FPayee := TfrxSberPayee.Create;
end;

destructor TfrxSberRequiredBankingDetails.Destroy;
begin
  FreeAndNil(FPayee);
  inherited;
end;

function TfrxSberRequiredBankingDetails.GetData(aReport: TfrxReport): String;
begin
  Result := '';
  Result := Result + Payee.GetData(aReport);
end;

{ TfrxSberAdditionalBankingDetails }

procedure TfrxSberAdditionalBankingDetails.SetSum(val: String);
begin
  if  (FFieldTypes = fdExpression) or ((FFieldTypes = fdStatic) and (Length(val) <= 18)) then
    FSum := val;
end;

procedure TfrxSberAdditionalBankingDetails.SetPurpose(val: String);
begin
  if (FFieldTypes = fdExpression) or ((FFieldTypes = fdStatic) and (Length(val) <= 210)) then
    FPurpose := val;
end;

procedure TfrxSberAdditionalBankingDetails.SetPayeeAdditionalInfo(val: TfrxSberPayeeAdditionalInfo);
begin
    FPayeeAdditionalInfo := val;
end;

procedure TfrxSberAdditionalBankingDetails.SetPayerINN(val: String);
begin
  if (FFieldTypes = fdExpression) or ((FFieldTypes = fdStatic) and (Length(val) <= 12)) then
    FPayerINN := val;
end;

procedure TfrxSberAdditionalBankingDetails.SetDepartmentalInfo(val: TfrxSberDepartmentalInfo);
begin
    FDepartmentalInfo := val;
end;

constructor TfrxSberAdditionalBankingDetails.Create;
begin
  inherited;
  FPayeeAdditionalInfo := TfrxSberPayeeAdditionalInfo.Create;
  FDepartmentalInfo := TfrxSberDepartmentalInfo.Create;
end;

destructor TfrxSberAdditionalBankingDetails.Destroy;
begin
  FreeAndNil(FPayeeAdditionalInfo);
  FreeAndNil(FDepartmentalInfo);
  inherited;
end;

function TfrxSberAdditionalBankingDetails.GetData(aReport: TfrxReport): String;
begin
  Result := '';
  Result := Result + GetValue(aReport, FSum, 'Sum');
  Result := Result + GetValue(aReport, FPurpose, 'Purpose');
  Result := Result + PayeeAdditionalInfo.GetData(aReport);
  Result := Result + GetValue(aReport, FPayerINN, 'PayerINN');
  Result := Result + DepartmentalInfo.GetData(aReport);
end;

{ TfrxSberOtherAdditionalBankingDetails }

function TfrxSberOtherAdditionalBankingDetails.GetData(aReport: TfrxReport): String;
begin
  Result := '';
  Result := Result + GetValue(aReport, FLastName, 'LastName');
  Result := Result + GetValue(aReport, FFirstName, 'FirstName');
  Result := Result + GetValue(aReport, FMiddleName, 'MiddleName');
  Result := Result + GetValue(aReport, FPayerAddress, 'PayerAddress');
  Result := Result + GetValue(aReport, FPersonalAccount, 'PersonalAccount');
  Result := Result + GetValue(aReport, FDocIdx, 'DocIdx');
  Result := Result + GetValue(aReport, FPensAcc, 'PensAcc');
  Result := Result + GetValue(aReport, FContract, 'Contract');
  Result := Result + GetValue(aReport, FPersAcc, 'PersAcc');
  Result := Result + GetValue(aReport, FFlat, 'Flat');
  Result := Result + GetValue(aReport, FPhone, 'Phone');
  Result := Result + GetValue(aReport, FPayerIdType, 'PayerIdType');
  Result := Result + GetValue(aReport, FPayerIdNum, 'PayerIdNum');
  Result := Result + GetValue(aReport, FChildFio, 'ChildFio');
  Result := Result + GetValue(aReport, FBirthDate, 'BirthDate');
  Result := Result + GetValue(aReport, FPaymTerm, 'PaymTerm');
  Result := Result + GetValue(aReport, FPaymPeriod, 'PaymPeriod');
  Result := Result + GetValue(aReport, FCategory, 'Category');
  Result := Result + GetValue(aReport, FServiceName, 'ServiceName');
  Result := Result + GetValue(aReport, FCounterId, 'CounterId');
  Result := Result + GetValue(aReport, FCounterVal, 'CounterVal');
  Result := Result + GetValue(aReport, FQuittId, 'QuittId');
  Result := Result + GetValue(aReport, FInstNum, 'InstNum');
  Result := Result + GetValue(aReport, FClassNum, 'ClassNum');
  Result := Result + GetValue(aReport, FSpecFio, 'SpecFio');
  Result := Result + GetValue(aReport, FAddAmount, 'AddAmount');
  Result := Result + GetValue(aReport, FRuleId, 'RuleId');
  Result := Result + GetValue(aReport, FExecId, 'ExecId');
  Result := Result + GetValue(aReport, FRegType, 'RegType');
  Result := Result + GetValue(aReport, FUIN, 'UIN');
  Result := Result + GetValue(aReport, FTechCode, 'TechCode');
end;

{ TfrxSberPaymentPreset }

procedure TfrxSberPaymentPreset.ApplySettings(aComponent: TfrxComponent);
var
  Props: TfrxQRProperties;

begin
  if (aComponent is TfrxBarcode2DView) and (TfrxBarcode2DView(aComponent).BarType = bcCodeQR) then
  begin
    Props := TfrxQRProperties(TfrxBarcode2DView(aComponent).BarProperties);
    Props.ErrorLevels := ecM;
    Props.GraphicMarker.ShowGraphicMarker := True;
    TfrxBarcode2DView(aComponent).ShowText := False;
  end;
end;

constructor TfrxSberPaymentPreset.Create;
begin
  FSberData := TfrxSberData.Create;
end;

destructor TfrxSberPaymentPreset.Destroy;
begin
  FreeAndNil(FSberData);
  inherited;
end;

function TfrxSberPaymentPreset.GetData(aReport: TfrxReport): String;
begin
  Result := Result + SberData.GetData(aReport);
  Result := Result + RequiredBankingDetails.GetData(aReport);
  Result := Result + AdditionalBankingDetails.GetData(aReport);
  Result := Result + OtherAdditionalBankingDetails.GetData(aReport);
end;

function TfrxSberPaymentPreset.GetRequiredBankingDetails: TfrxSberRequiredBankingDetails;
begin
  Result := FSberData.FRequiredBankingDetails;
end;

procedure TfrxSberPaymentPreset.RestoreComponentState(
  aComponent: TfrxComponent);
var
  Props: TfrxQRProperties;
begin
  if (aComponent is TfrxBarcode2DView) and (TfrxBarcode2DView(aComponent).BarType = bcCodeQR) then
  begin
    Props := TfrxQRProperties(TfrxBarcode2DView(aComponent).BarProperties);
    Props.ErrorLevels := TQRErrorLevels(Byte(FSaveErrorLevels));
    Props.GraphicMarker.ShowGraphicMarker := FSaveMarker;
    TfrxBarcode2DView(aComponent).ShowText := FSaveShowText;
  end;
end;

procedure TfrxSberPaymentPreset.SaveComponentState(aComponent: TfrxComponent);
var
  Props: TfrxQRProperties;
begin
  if (aComponent is TfrxBarcode2DView) and (TfrxBarcode2DView(aComponent).BarType = bcCodeQR) then
  begin
    Props := TfrxQRProperties(TfrxBarcode2DView(aComponent).BarProperties);
    FSaveErrorLevels := ord(Props.ErrorLevels);
    FSaveMarker := Props.GraphicMarker.ShowGraphicMarker;
    FSaveShowText := TfrxBarcode2DView(aComponent).ShowText;
  end;
end;

function TfrxSberPaymentPreset.GetAdditionalBankingDetails: TfrxSberAdditionalBankingDetails;
begin
  Result := FSberData.FAdditionalBankingDetails;
end;

function TfrxSberPaymentPreset.GetOtherAdditionalBankingDetails: TfrxSberOtherAdditionalBankingDetails;
begin
  Result := FSberData.FOtherAdditionalBankingDetails;
end;

{ TfrxCustomPresetAttr }

function TfrxCustomPresetAttr.GetValue(aReport: TfrxReport; const aFileld: String;
  const aFileldName: String): String;
var
  ECIString: String;
begin
  Result := '';
  ECIString := '&ECI22;';
  if Assigned(aReport) and (aFileld <> '') then
    if FFieldTypes = fdExpression then
      Result := VarToStr(aReport.Calc(aFileld))
    else
    if FFieldTypes = fdStatic then
      Result := aFileld;
    case FEncoding of
      ec_WIN1251 :  ECIString := '&ECI22;';
      ec_UTF8:      ECIString := '&ECI26;';
      ec_KOI8_R:    ECIString := '&ECI03;';
  end;
  if Result <> '' then
    Result := ECIString + aFileldName + chEquality +ECIString+ Result + FSeparator;
end;

function TfrxCustomPresetAttr.GetEncoding: TfrxSberEncoding;
begin
  Result := FEncoding;
end;

function TfrxCustomPresetAttr.GetSeparator: Char;
begin
   Result := FSeparator;
end;

function TfrxCustomPresetAttr.GetFieldTypes: TfrxFieldTypesQR;
begin
  Result := FFieldTypes;
end;

initialization
  RegisterClasses([TfrxSberPaymentPreset]);
  frxBarcode2DPresetList.Add(TfrxSberPaymentPreset);
end.
