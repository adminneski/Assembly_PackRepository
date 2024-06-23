{******************************************}
{                                          }
{             FastReport VCL               }
{            PDF export filter             }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}
{      haBlock alignment improved by:      }
{              Nikolay Zverev              }
{            www.delphinotes.ru            }
{******************************************}

unit frxExportPDFDialog;

interface

{$I frx.inc}

uses
{$IFNDEF Linux}
  Windows,
{$ELSE}
  LCLType, LCLIntf, LCLProc,
{$ENDIF}
  SysUtils, Graphics, Controls, Classes, Forms, Dialogs, frxExportBaseDialog,
  StdCtrls, ExtCtrls, ComCtrls, Variants, frxPreview, Buttons, frxHelpers,
  frxExportPDF;

type
  TfrxPDFExportDialog = class(TfrxBaseExportDialog)
    InfoPage: TTabSheet;
    SecurityPage: TTabSheet;
    ViewerPage: TTabSheet;
    CompressedCB: TCheckBox;
    EmbeddedCB: TCheckBox;
    PrintOptCB: TCheckBox;
    OutlineCB: TCheckBox;
    BackgrCB: TCheckBox;
    SecGB: TGroupBox;
    OwnPassL: TLabel;
    UserPassL: TLabel;
    OwnPassE: TEdit;
    UserPassE: TEdit;
    PermGB: TGroupBox;
    PrintCB: TCheckBox;
    ModCB: TCheckBox;
    CopyCB: TCheckBox;
    AnnotCB: TCheckBox;
    DocInfoGB: TGroupBox;
    TitleL: TLabel;
    TitleE: TEdit;
    AuthorE: TEdit;
    AuthorL: TLabel;
    SubjectL: TLabel;
    SubjectE: TEdit;
    KeywordsL: TLabel;
    KeywordsE: TEdit;
    CreatorE: TEdit;
    CreatorL: TLabel;
    ProducerL: TLabel;
    ProducerE: TEdit;
    ViewerGB: TGroupBox;
    HideToolbarCB: TCheckBox;
    HideMenubarCB: TCheckBox;
    HideWindowUICB: TCheckBox;
    FitWindowCB: TCheckBox;
    CenterWindowCB: TCheckBox;
    PrintScalingCB: TCheckBox;
    QualityEdit: TEdit;
    Label2: TLabel;
    TransparentCB: TCheckBox;
    PDFStandardComboBox: TComboBox;
    PDFStandardLabel: TLabel;
    PDFVersionComboBox: TComboBox;
    PDFVersionLabel: TLabel;
    IFormsCB: TCheckBox;
    FontGLB: TLabel;
    FSubsetED: TEdit;
    SignaturePage: TTabSheet;
    AdditionalInformationGB: TGroupBox;
    LocationL: TLabel;
    ReasonL: TLabel;
    ContactL: TLabel;
    LocationE: TEdit;
    ReasonE: TEdit;
    ContactE: TEdit;
    CertificateGB: TGroupBox;
    CertificateFileB: TSpeedButton;
    CertificateFileE: TEdit;
    CertificateFileL: TLabel;
    CertificatePasswordL: TLabel;
    CertificatePasswordE: TEdit;
    CertificateOD: TOpenDialog;
    DescriptionListBox: TListBox;
    DescriptionLabel: TLabel;
    AutoFillButton: TButton;
    AddButton: TButton;
    DeleteButton: TButton;
    procedure PDFStandardComboBoxChange(Sender: TObject);
    procedure IFormsCBClick(Sender: TObject);
    procedure CertificateFileBClick(Sender: TObject);
    procedure OkBClick(Sender: TObject);
    procedure DescriptionListBoxClick(Sender: TObject);
    procedure DataEditChange(Sender: TObject);
    procedure AddButtonClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure AutoFillButtonClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  protected
    FPDFFilter: TfrxPDFExport;
    FSIL: TSignatureInfoList;

    procedure SetupComboBox(ComboBox: TComboBox; st: String);
    procedure DoStandard;
    function KindName(Index: Integer; Unknown: Boolean): string;
    procedure AddToDescriptionListBox(Index: Integer; Unknown: Boolean = False);
    procedure SetItemIndex(Index: Integer);
    procedure FillDescriptionListBox;

    procedure InitDialog; override;
    procedure InitControlsFromFilter(ExportFilter: TfrxBaseDialogExportFilter); override;
    procedure InitFilterFromDialog(ExportFilter: TfrxBaseDialogExportFilter); override;
  end;

implementation

uses
  Math,
  frxRes, frxExportPDFHelpers,
{$IFNDEF RAD_ED}
  frxPDFSignature, frxSignatureErrorDialog,
{$ENDIF}
  frUtils, frxUtils, frxClass;

{$IFDEF FPC}
{$R *.lfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

{ TfrxPDFExportDialog }

procedure TfrxPDFExportDialog.AddButtonClick(Sender: TObject);
var
  SignName: string;
  Index: Integer;
begin
  SignName := InputBox(frxResources.Get('Input'),
    frxResources.Get('SignatureObjectName'), 'DigitalSignature');
  if SignName = '' then
    Exit;

  if FSIL.IsFind(SignName, Index) then
    SetItemIndex(Index)
  else
  begin
    FSIL.Add(TSignatureInfo.CreateUnknown(nil, SignName));
    AddToDescriptionListBox(FSIL.Count - 1, True);
    SetItemIndex(FSIL.Count - 1);
  end;
end;

procedure TfrxPDFExportDialog.AddToDescriptionListBox(Index: Integer; Unknown: Boolean = False);
var
  SD: TSignatureData;
  st: string;
begin
  SD := FSIL.Data[Index];

  if      Index = DefaultSignatureIndex then
    st := 'Default'
  else if SD.Description = '' then
    st := SD.Name
  else
    st := SD.Description;

  DescriptionListBox.AddItem(st + KindName(Index, Unknown), nil);
end;

procedure TfrxPDFExportDialog.AutoFillButtonClick(Sender: TObject);
begin
  FPDFFilter.FillSignatureInfoList(FSIL);
  FillDescriptionListBox;
  SetItemIndex(0);
end;

procedure TfrxPDFExportDialog.CertificateFileBClick(Sender: TObject);
begin
  with CertificateOD do
    if Execute then
      CertificateFileE.Text := FileName;
end;

procedure TfrxPDFExportDialog.DataEditChange(Sender: TObject);
var
  SD: TSignatureData;
begin
  if DescriptionListBox.ItemIndex > -1 then
    with (FSIL[DescriptionListBox.ItemIndex] as TSignatureInfo) do
      if Data.Kind <> skEmpty then
      begin
        SD := Data;

        SD.Location := LocationE.Text;
        SD.Reason := ReasonE.Text;
        SD.ContactInfo := ContactE.Text;
        SD.CertificatePath := CertificateFileE.Text;
        SD.CertificatePassword := AnsiString(CertificatePasswordE.Text);

        Data := SD;
      end;
end;

procedure TfrxPDFExportDialog.DeleteButtonClick(Sender: TObject);
var
  Index: Integer;
begin
  Index := DescriptionListBox.ItemIndex;
  if (Index > -1)  and (Index < FSIL.Count) then
  begin
    (FSIL[Index] as TSignatureInfo).Free;
    FSIL.Delete(Index);
    DescriptionListBox.Items.Delete(Index);
    SetItemIndex(Min(Index, FSIL.Count - 1));
  end;
end;

procedure TfrxPDFExportDialog.DescriptionListBoxClick(Sender: TObject);
begin
  SetItemIndex(DescriptionListBox.ItemIndex);
end;

procedure TfrxPDFExportDialog.DoStandard;
var
  PDFStandard: TPDFStandard;
  pv: TPDFVersion;
  IsPDFA, IsPDFA_1: Boolean;
begin
  PDFStandard := PDFStandardByName(PDFStandardComboBox.Text);
  IsPDFA := frxExportPDFHelpers.IsPDFA(PDFStandard);
  IsPDFA_1:= frxExportPDFHelpers.IsPDFA_1(PDFStandard);

  if IsVersionByStandard(PDFStandard, pv) then
    SetupComboBox(PDFVersionComboBox, PDFVersionName[pv]);
  PDFVersionComboBox.Enabled := PDFStandard = psNone;

  SecGB.Visible := not IsPDFA;
  PermGB.Visible := not IsPDFA;

  if IsPDFA then
    EmbeddedCB.Checked := True;
  EmbeddedCB.Enabled := not IsPDFA;

  if IsPDFA_1 then
    TransparentCB.Checked := False;
  TransparentCB.Enabled := not IsPDFA_1;
  IFormsCB.Enabled := (PDFStandard = psNone);
  IFormsCBClick(nil);
end;

procedure TfrxPDFExportDialog.FillDescriptionListBox;
var
  i: Integer;
begin
  DescriptionListBox.Clear;
  for i := 0 to FSIL.Count - 1 do
    AddToDescriptionListBox(i, i = DefaultSignatureIndex);
  SetItemIndex(0);
end;

procedure TfrxPDFExportDialog.FormDestroy(Sender: TObject);
begin
{$IFDEF RAD_ED}
{$ELSE}
    FSIL.Free;
{$ENDIF}
end;

procedure TfrxPDFExportDialog.InitControlsFromFilter(ExportFilter: TfrxBaseDialogExportFilter);
begin
  inherited InitControlsFromFilter(ExportFilter);
  FPDFFilter := TfrxPDFExport(ExportFilter);

  with FPDFFilter do
  begin
    if      Report = nil then
      Outline := True
    else if Report.Preview = nil then
      Outline := Report.PreviewOptions.OutlineVisible
    else
      Outline := TfrxPreview(Report.Preview).OutlineVisible;

    SetupComboBox(PDFStandardComboBox, PDFStandardName[PDFStandard]);
    DoStandard;
    if not IsPDFA then
      SetupComboBox(PDFVersionComboBox, PDFVersionName[PDFVersion]);

    CompressedCB.Checked := Compressed;
    EmbeddedCB.Checked := EmbeddedFonts;
    PrintOptCB.Checked := PrintOptimized;
    OutlineCB.Checked := Outline;
    OutlineCB.Enabled := Outline;
    BackgrCB.Checked := Background;
    QualityEdit.Text := IntToStr(Quality);

    OwnPassE.Text := String(OwnerPassword);
    UserPassE.Text := String(UserPassword);
    PrintCB.Checked := ePrint in ProtectionFlags;
    CopyCB.Checked := eCopy in ProtectionFlags;
    ModCB.Checked := eModify in ProtectionFlags;
    AnnotCB.Checked := eAnnot in ProtectionFlags;

    TitleE.Text := Title;
    AuthorE.Text := Author;
    SubjectE.Text := Subject;
    KeywordsE.Text := Keywords;
    CreatorE.Text := Creator;
    ProducerE.Text := Producer;

    PrintScalingCB.Checked := PrintScaling;
    FitWindowCB.Checked := FitWindow;
    HideMenubarCB.Checked := HideMenubar;
    CenterWindowCB.Checked := CenterWindow;
    HideWindowUICB.Checked := HideWindowUI;
    HideToolbarCB.Checked := HideToolbar;
    TransparentCB.Checked := Transparency;

    IFormsCB.Checked := InteractiveForms;
    FSubsetED.Text := InteractiveFormsFontSubset;
{$IFDEF RAD_ED}
    SignaturePage.TabVisible := False;
{$ELSE}
    SignaturePage.TabVisible := True;

    FSIL.PDFExport := FPDFFilter;
    FSIL.Init;
    FillDescriptionListBox;
{$ENDIF}

    IFormsCBClick(nil);
  end;
end;

procedure TfrxPDFExportDialog.InitDialog;
var
  ps: TPDFStandard;
  pv: TPDFVersion;
begin
  inherited InitDialog;
  FSubsetED.Hint := frxGet(8715);
  with PDFStandardComboBox.Items do
  begin
    Clear;
    BeginUpdate;
    for ps := Low(TPDFStandard) to High(TPDFStandard) do
      Add(PDFStandardName[ps]);
    EndUpdate;
  end;

  with PDFVersionComboBox.Items do
  begin
    Clear;
    BeginUpdate;
    for pv := Low(TPDFVersion) to High(TPDFVersion) do
      Add(PDFVersionName[pv]);
    EndUpdate;
  end;

  FSIL := TSignatureInfoList.Create(nil);
end;

procedure TfrxPDFExportDialog.InitFilterFromDialog(ExportFilter: TfrxBaseDialogExportFilter);
var
  PDFFilter: TfrxPDFExport;
  pFlags: TfrxPDFEncBits;
  i: Integer;
begin
  inherited;
  PDFFilter := TfrxPDFExport(ExportFilter);
  with PDFFilter do
  begin
    OwnerPassword := UTF8Encode(OwnPassE.Text);
    UserPassword := UTF8Encode(UserPassE.Text);
    pFlags := [];
    if PrintCB.Checked then
      pFlags := pFlags + [ePrint];
    if CopyCB.Checked then
      pFlags := pFlags + [eCopy];
    if ModCB.Checked then
      pFlags := pFlags + [eModify];
    if AnnotCB.Checked then
      pFlags := pFlags + [eAnnot];
    ProtectionFlags := pFlags;

    PDFStandard := PDFStandardByName(PDFStandardComboBox.Text);
    PDFVersion := PDFVersionByName(PDFVersionComboBox.Text);

    Compressed := CompressedCB.Checked;
    EmbeddedFonts := EmbeddedCB.Checked;
    PrintOptimized := PrintOptCB.Checked;
    Outline := OutlineCB.Checked;
    Background := BackgrCB.Checked;
    Quality := StrToInt(QualityEdit.Text);

    Title := TitleE.Text;
    Author := AuthorE.Text;
    Subject := SubjectE.Text;
    Keywords := KeywordsE.Text;
    Creator := CreatorE.Text;
    Producer := ProducerE.Text;

    PrintScaling := PrintScalingCB.Checked;
    FitWindow := FitWindowCB.Checked;
    HideMenubar := HideMenubarCB.Checked;
    CenterWindow := CenterWindowCB.Checked;
    HideWindowUI := HideWindowUICB.Checked;
    HideToolbar := HideToolbarCB.Checked;
    Transparency := TransparentCB.Checked;

{$IFDEF RAD_ED}
{$ELSE}
    FSIL.SetOldDigitalSignDataToExport;
    SignatureInfoList.Clear;
    for i := 0 to FSIL.Count - 1 do
      SignatureInfoList.AddData(FSIL.Data[i]);
{$ENDIF}

    InteractiveForms := IFormsCB.Checked;
    InteractiveFormsFontSubset := FSubsetED.Text;
  end;
end;

function TfrxPDFExportDialog.KindName(Index: Integer; Unknown: Boolean): string;
const
  Name: array[TPDFSignatureKind] of string = ('Invisible', 'Visible', 'Empty');
var
  SD: TSignatureData;
begin
  SD := FSIL.Data[Index];
  Result := ' (' + frIfStr(Unknown, 'Unknown', Name[FSIL.Data[Index].Kind])+ ')';
end;

procedure TfrxPDFExportDialog.OkBClick(Sender: TObject);
{$IFDEF RAD_ED}
begin

end;
{$ELSE}
  procedure PrepareToExit(Index: Integer);
  begin
    SetItemIndex(Index);
    ModalResult := mrNone;
  end;
var
  i: Integer;
  SD: TSignatureData;
  Signature: TfrxPDFSignature;
begin
  for i := 0 to FSIL.Count - 1 do
  begin
    SD := FSIL.Data[i];
    if (SD.Kind = skEmpty) or (SD.CertificatePath = '') then
      Continue;

    if not FileExists(SD.CertificatePath) then
    begin
      frxErrorMsg(frxResources.Get('dsCantLoad') + ': ' + SD.CertificatePath);
      PrepareToExit(i);
      Exit;
    end;

    Signature := TfrxPDFSignature.Create(SD.CertificatePath,
      AnsiString(SD.CertificatePassword));

    try
      if Signature.Status <> ssOK then
      begin
        SignatureErrorDialog(Signature, [mbOK]);
        PrepareToExit(i);
        Exit;
      end;

    finally
      Signature.Free;
    end;
  end;
end;
{$ENDIF}

procedure TfrxPDFExportDialog.PDFStandardComboBoxChange(Sender: TObject);
begin
  inherited;
  DoStandard;
end;

procedure TfrxPDFExportDialog.SetItemIndex(Index: Integer);
  procedure SetEditText(Edit: TEdit; st: string);
  begin
    Edit.OnChange := nil;
    Edit.Text := st;
    Edit.OnChange := DataEditChange;
  end;
var
  En: Boolean;
begin
  if (Index < 0)  or (Index > FSIL.Count - 1) then
    Exit;

  with (FSIL[Index] as TSignatureInfo).Data do
  begin;
    SetEditText(LocationE, Location);
    SetEditText(ReasonE, Reason);
    SetEditText(ContactE, ContactInfo);
    SetEditText(CertificateFileE, CertificatePath);
    SetEditText(CertificatePasswordE, string(CertificatePassword));

    En := Kind <> skEmpty;
  end;

  LocationL.Enabled := En;
  LocationE.Enabled := En;
  ReasonL.Enabled := En;
  ReasonE.Enabled := En;
  ContactL.Enabled := En;
  ContactE.Enabled := En;
  CertificateFileL.Enabled := En;
  CertificateFileE.Enabled := En;
  CertificateFileB.Enabled := En;
  CertificatePasswordL.Enabled := En;
  CertificatePasswordE.Enabled := En;

  DeleteButton.Enabled := Index <> DefaultSignatureIndex;

  DescriptionListBox.ItemIndex := Index;
end;

procedure TfrxPDFExportDialog.SetupComboBox(ComboBox: TComboBox; st: String);
var
  i: Integer;
begin
  with ComboBox do
    for i := 0 to Items.Count - 1 do
      if st = Items[i] then
      begin
        ItemIndex := i;
        Break;
      end;
end;

procedure TfrxPDFExportDialog.IFormsCBClick(Sender: TObject);
begin
  FSubsetED.Enabled := IFormsCB.Checked;
end;

end.
