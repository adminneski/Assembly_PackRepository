
{******************************************}
{                                          }
{             FastReport VCL               }
{          Preview Page settings           }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxPreviewPageSettings;

interface

{$I frx.inc}

uses
  {$IFNDEF FPC}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, frxClass, frBaseForm, frxBaseForm
  {$IFDEF FPC}
  , LResources, LCLType
  {$ENDIF}
{$IFDEF DELPHI6}
, Variants
{$ENDIF};

type
  TfrxDesignerUnits = (duCM, duInches, duPixels, duChars);

  TfrxPageSettingsForm = class(TfrxBaseForm)
    OKB: TButton;
    CancelB: TButton;
    SizeL: TGroupBox;
    WidthL: TLabel;
    HeightL: TLabel;
    UnitL1: TLabel;
    UnitL2: TLabel;
    WidthE: TEdit;
    HeightE: TEdit;
    SizeCB: TComboBox;
    OrientationL: TGroupBox;
    PortraitImg: TImage;
    LandscapeImg: TImage;
    PortraitRB: TRadioButton;
    LandscapeRB: TRadioButton;
    MarginsL: TGroupBox;
    LeftL: TLabel;
    TopL: TLabel;
    RightL: TLabel;
    BottomL: TLabel;
    UnitL3: TLabel;
    UnitL4: TLabel;
    UnitL5: TLabel;
    UnitL6: TLabel;
    MarginLeftE: TEdit;
    MarginTopE: TEdit;
    MarginRightE: TEdit;
    MarginBottomE: TEdit;
    OtherL: TGroupBox;
    ApplyToCurRB: TRadioButton;
    ApplyToAllRB: TRadioButton;
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure PortraitRBClick(Sender: TObject);
    procedure SizeCBClick(Sender: TObject);
    procedure WidthEChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditorKeyPress(Sender: TObject; var Key: Char);
  protected
    { Private declarations }
    FPage: TfrxReportPage;
    FReport: TfrxReport;
    FUnits: TfrxDesignerUnits;
    FUpdating: Boolean;
    function GetNeedRebuild: Boolean;
    function mmToUnits(mm: Extended): Extended;
    function UnitsTomm(mm: Extended): Extended;
    function GetAvailablePreferences: TfrxPreferencesTypes; override;
    procedure LoadFormPreferences(PreferencesStorage: TObject; DefPreferencesStorage: TObject); override;
  public
    { Public declarations }
    procedure UpdateResouces; override;
    property NeedRebuild: Boolean read GetNeedRebuild;
    property Page: TfrxReportPage read FPage write FPage;
    property Report: TfrxReport read FReport write FReport;
  end;


implementation

{$IFNDEF FPC}
{$R *.DFM}
{$ELSE}
{$R *.lfm}
{$ENDIF}

uses
  Printers, frUtils, frxPrinter, frxUtils, frxRes, IniFiles;


function TfrxPageSettingsForm.mmToUnits(mm: Extended): Extended;
begin
  Result := 0;
  case FUnits of
    duCM, duPixels, duChars:
      Result := mm / 10;
    duInches:
      Result := mm / 25.4;
  end;
end;

function TfrxPageSettingsForm.UnitsTomm(mm: Extended): Extended;
begin
  Result := 0;
  case FUnits of
    duCM, duPixels, duChars:
      Result := mm * 10;
    duInches:
      Result := mm * 25.4;
  end;
end;

procedure TfrxPageSettingsForm.UpdateResouces;
begin
  inherited;
  FUpdating := True;
  Caption := frxGet(400);
  WidthL.Caption := frxGet(401);
  HeightL.Caption := frxGet(402);
  SizeL.Caption := frxGet(403);
  OrientationL.Caption := frxGet(404);
  LeftL.Caption := frxGet(405);
  TopL.Caption := frxGet(406);
  RightL.Caption := frxGet(407);
  BottomL.Caption := frxGet(408);
  MarginsL.Caption := frxGet(409);
  PortraitRB.Caption := frxGet(410);
  LandscapeRB.Caption := frxGet(411);
  OKB.Caption := frxGet(1);
  CancelB.Caption := frxGet(2);
  OtherL.Caption := frxGet(412);
  ApplyToCurRB.Caption := frxGet(413);
  ApplyToAllRB.Caption := frxGet(414);
  FUpdating := False;
end;

function TfrxPageSettingsForm.GetAvailablePreferences: TfrxPreferencesTypes;
begin
  Result := [frPtFormCustom];
end;

function TfrxPageSettingsForm.GetNeedRebuild: Boolean;
begin
  Result := ApplyToAllRB.Checked;
end;

procedure TfrxPageSettingsForm.LoadFormPreferences(PreferencesStorage: TObject; DefPreferencesStorage: TObject);
var
  Ini: TCustomIniFile;
begin
  inherited;
  if not(PreferencesStorage is TCustomIniFile) then Exit;
  Ini :=  TCustomIniFile(PreferencesStorage);
  FUnits := TfrxDesignerUnits(Ini.ReadInteger('Form5.TfrxDesignerForm', 'Units', 0));
end;

procedure TfrxPageSettingsForm.EditorKeyPress(Sender: TObject; var Key: Char);
begin
  {$IFDEF DELPHI12}
  if not CharInSet(Key, ['0', '1'..'9', '.', ',', #8]) then
  {$ELSE}
  if not (Key in ['0', '1'..'9', '.', ',', #8]) then
  {$ENDIF}
    Key := #0;
end;

procedure TfrxPageSettingsForm.FormShow(Sender: TObject);
var
  i: Integer;
  Ini: TCustomIniFile;
  uStr: String;
begin
  FUpdating := True;

  if UseRightToLeftAlignment then
    FlipChildren(True);

  Ini :=  Report.GetIniFile;
  FUnits := TfrxDesignerUnits(Ini.ReadInteger('Form5.TfrxDesignerForm', 'Units', 0));
  Ini.Free;
  uStr := '';
  case FUnits of
    duCM, duPixels, duChars:
      uStr := frxResources.Get('uCm');
    duInches:
      uStr := frxResources.Get('uInch');
  end;

  UnitL1.Caption := uStr;
  UnitL2.Caption := uStr;
  UnitL3.Caption := uStr;
  UnitL4.Caption := uStr;
  UnitL5.Caption := uStr;
  UnitL6.Caption := uStr;
  SizeCB.Items := frxPrinters.Printer.Papers;
  i := frxPrinters.Printer.PaperIndex(Page.PaperSize);
  if i = -1 then
    i := frxPrinters.Printer.PaperIndex(256);
  SizeCB.ItemIndex := i;

  WidthE.Text := frFloatToStr(mmToUnits(Page.PaperWidth));
  HeightE.Text := frFloatToStr(mmToUnits(Page.PaperHeight));
  PortraitRB.Checked := Page.Orientation = poPortrait;
  LandscapeRB.Checked := Page.Orientation = poLandscape;

  MarginLeftE.Text := frFloatToStr(mmToUnits(Page.LeftMargin));
  MarginRightE.Text := frFloatToStr(mmToUnits(Page.RightMargin));
  MarginTopE.Text := frFloatToStr(mmToUnits(Page.TopMargin));
  MarginBottomE.Text := frFloatToStr(mmToUnits(Page.BottomMargin));

  WidthE.OnKeyPress := EditorKeyPress;
  HeightE.OnKeyPress := EditorKeyPress;
  MarginLeftE.OnKeyPress := EditorKeyPress;
  MarginTopE.OnKeyPress := EditorKeyPress;
  MarginRightE.OnKeyPress := EditorKeyPress;
  MarginBottomE.OnKeyPress := EditorKeyPress;

  PortraitRBClick(nil);
  FUpdating := False;
end;

procedure TfrxPageSettingsForm.FormHide(Sender: TObject);
begin
  if ModalResult = mrOk then
  begin
    if PortraitRB.Checked then
      Page.Orientation := poPortrait else
      Page.Orientation := poLandscape;

    if Trim(WidthE.Text) = '' then
      WidthE.Text := frFloatToStr(mmToUnits(Page.PaperWidth));
    if Trim(HeightE.Text) = '' then
      HeightE.Text := frFloatToStr(mmToUnits(Page.PaperHeight));

    Page.PaperWidth := UnitsTomm(frxStrToFloat(WidthE.Text));
    Page.PaperHeight := UnitsTomm(frxStrToFloat(HeightE.Text));
    Page.PaperSize := frxPrinters.Printer.PaperNameToNumber(SizeCB.Text);

    if Trim(MarginLeftE.Text) = '' then
      MarginLeftE.Text := '0';
    if Trim(MarginRightE.Text) = '' then
      MarginRightE.Text := '0';
    if Trim(MarginTopE.Text) = '' then
      MarginTopE.Text := '0';
    if Trim(MarginBottomE.Text) = '' then
      MarginBottomE.Text := '0';

    Page.LeftMargin := UnitsTomm(frxStrToFloat(MarginLeftE.Text));
    Page.RightMargin := UnitsTomm(frxStrToFloat(MarginRightE.Text));
    Page.TopMargin := UnitsTomm(frxStrToFloat(MarginTopE.Text));
    Page.BottomMargin := UnitsTomm(frxStrToFloat(MarginBottomE.Text));

    Page.AlignChildren;
  end;
end;

procedure TfrxPageSettingsForm.PortraitRBClick(Sender: TObject);
begin
  PortraitImg.Visible := PortraitRB.Checked;
  LandscapeImg.Visible := LandscapeRB.Checked;
  SizeCBClick(nil);
end;

procedure TfrxPageSettingsForm.SizeCBClick(Sender: TObject);
var
  pOr: TPrinterOrientation;
  pNumber: Integer;
  pWidth, pHeight: Extended;
begin
  if FUpdating then Exit;
  FUpdating := True;

  with frxPrinters.Printer do
  begin
    pNumber := PaperNameToNumber(SizeCB.Text);
    pWidth := UnitsTomm(frxStrToFloat(WidthE.Text));
    pHeight := UnitsTomm(frxStrToFloat(HeightE.Text));
    if PortraitRB.Checked then
      pOr := poPortrait else
      pOr := poLandscape;

    if pNumber = 256 then
      SetViewParams(pNumber, pHeight, pWidth, pOr) else
      SetViewParams(pNumber, pWidth, pHeight, pOr);

    WidthE.Text := frFloatToStr(mmToUnits(PaperWidth));
    HeightE.Text := frFloatToStr(mmToUnits(PaperHeight));
  end;

  FUpdating := False;
end;

procedure TfrxPageSettingsForm.WidthEChange(Sender: TObject);
begin
  if not FUpdating then
    SizeCB.ItemIndex := 0;
end;

procedure TfrxPageSettingsForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    frxResources.Help(Self);
end;

end.
