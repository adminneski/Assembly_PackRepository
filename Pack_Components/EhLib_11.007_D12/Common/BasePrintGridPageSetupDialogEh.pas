{*******************************************************}
{                                                       }
{                        EhLib 10.2                     }
{                                                       }
{   Copyright (c) 2015-2022 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit BasePrintGridPageSetupDialogEh;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, ExtCtrls, StdCtrls, ComCtrls,
{$IFDEF EH_LIB_17} System.UITypes, {$ENDIF}
  LanguageResManEh, PrintUtilsEh, DBCtrlsEh, ToolCtrlsEh,
  Mask, Printers, Math, Buttons;

type
  TfSpreadGridsPrintPageSetupDialogEh = class(TForm)
    pcPageSetup: TPageControl;
    tsPage: TTabSheet;
    tsMargins: TTabSheet;
    tsHeaderFooter: TTabSheet;
    bOk: TButton;
    bCancel: TButton;
    Label1: TLabel;
    Bevel1: TBevel;
    Label2: TLabel;
    Bevel2: TBevel;
    Panel1: TPanel;
    rbPortrait: TRadioButton;
    rbLandscape: TRadioButton;
    Image1: TImage;
    Image2: TImage;
    Panel2: TPanel;
    rdAdjust: TRadioButton;
    rbFit: TRadioButton;
    lPerNormalSize: TLabel;
    lPagesWideBy: TLabel;
    lTall: TLabel;
    neScale: TDBNumberEditEh;
    neFitToWide: TDBNumberEditEh;
    neFitToTall: TDBNumberEditEh;
    neLeftMargin: TDBNumberEditEh;
    neTopMargin: TDBNumberEditEh;
    neBottomMargin: TDBNumberEditEh;
    neRightMargin: TDBNumberEditEh;
    neHeader: TDBNumberEditEh;
    neFooter: TDBNumberEditEh;
    reHeaderLeft: TDBRichEditEh;
    reHeaderCenter: TDBRichEditEh;
    reHeaderRight: TDBRichEditEh;
    reFooterLeft: TDBRichEditEh;
    reFooterCenter: TDBRichEditEh;
    reFooterRight: TDBRichEditEh;
    Label7: TLabel;
    spFont: TSpeedButton;
    spInsertPageNo: TSpeedButton;
    spInsertPages: TSpeedButton;
    spInsertDate: TSpeedButton;
    spInsertShortDate: TSpeedButton;
    spInsertLongDate: TSpeedButton;
    spInsertTime: TSpeedButton;
    Bevel3: TBevel;
    Bevel4: TBevel;
    FontDialog1: TFontDialog;
    Label6: TLabel;
    procedure spInsertPageNoClick(Sender: TObject);
    procedure spInsertPagesClick(Sender: TObject);
    procedure spInsertDateClick(Sender: TObject);
    procedure spInsertShortDateClick(Sender: TObject);
    procedure spInsertLongDateClick(Sender: TObject);
    procedure spInsertTimeClick(Sender: TObject);
    procedure spFontClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    rdAdjustCaptionDelta: Integer;
    rbFitCaptionDelta: Integer;

    procedure WMSettingChange(var Message: TMessage); message WM_SETTINGCHANGE;

  protected
    procedure ResourceLanguageChanged; virtual;

  public
  end;

var
  fSpreadGridsPrintPageSetupDialogEh: TfSpreadGridsPrintPageSetupDialogEh;

function ShowSpreadGridPageSetupDialog(PrintComponent: TBasePrintServiceComponentEh): Boolean;

implementation

uses EhLibLangConsts;

{$R *.dfm}

type
  TPrintControlComponentCrack = class(TBasePrintServiceComponentEh);

function ShowSpreadGridPageSetupDialog(PrintComponent: TBasePrintServiceComponentEh): Boolean;
var
  f: TfSpreadGridsPrintPageSetupDialogEh;
  ppr: TPrintControlComponentCrack;

  procedure ResetRichtextAlignment(RichEdit: TDBRichEditEh; Alignment: TAlignment);
  begin
    RichEdit.SelectAll;
    RichEdit.Paragraph.Alignment := Alignment;
  end;

begin
  Result := False;
  f := TfSpreadGridsPrintPageSetupDialogEh.Create(Application);
  f.pcPageSetup.ActivePageIndex := 0;
  ppr := TPrintControlComponentCrack(PrintComponent);
  if ppr.Orientation = poPortrait
    then f.rbPortrait.Checked := True
    else f.rbLandscape.Checked := True;

  if ppr.ScalingMode = smAdjustToScaleEh
    then f.rdAdjust.Checked := True
    else f.rbFit.Checked := True;

  f.neScale.Value := ppr.Scale;
  f.neFitToWide.Value := ppr.FitToPagesWide;
  f.neFitToTall.Value := ppr.FitToPagesTall;

  f.neLeftMargin.Value := Round(ppr.PageMargins.CurRegionalMetricLeft*10) / 10;
  f.neRightMargin.Value := Round(ppr.PageMargins.CurRegionalMetricRight*10) / 10;
  f.neTopMargin.Value := Round(ppr.PageMargins.CurRegionalMetricTop*10) / 10;
  f.neBottomMargin.Value := Round(ppr.PageMargins.CurRegionalMetricBottom*10) / 10;
  f.neHeader.Value := Round(ppr.PageMargins.CurRegionalMetricHeader*10) / 10;
  f.neFooter.Value := Round(ppr.PageMargins.CurRegionalMetricFooter*10) / 10;

  f.reHeaderLeft.RtfText := ppr.PageHeader.LeftText;
  ResetRichtextAlignment(f.reHeaderLeft, taLeftJustify);
  f.reHeaderCenter.RtfText := ppr.PageHeader.CenterText;
  ResetRichtextAlignment(f.reHeaderCenter, taCenter);
  f.reHeaderRight.RtfText := ppr.PageHeader.RightText;
  ResetRichtextAlignment(f.reHeaderRight, taRightJustify);

  f.reFooterLeft.RtfText := ppr.PageFooter.LeftText;
  ResetRichtextAlignment(f.reFooterLeft, taLeftJustify);
  f.reFooterCenter.RtfText := ppr.PageFooter.CenterText;
  ResetRichtextAlignment(f.reFooterCenter, taCenter);
  f.reFooterRight.RtfText := ppr.PageFooter.RightText;
  ResetRichtextAlignment(f.reFooterRight, taRightJustify);

  if f.ShowModal = mrOk then
  begin

    if f.rbPortrait.Checked
      then ppr.Orientation := poPortrait
      else ppr.Orientation := poLandscape;

    if f.rdAdjust.Checked = True
      then ppr.ScalingMode := smAdjustToScaleEh
      else ppr.ScalingMode := smFitToPagesEh;

    ppr.Scale := f.neScale.Value;
    ppr.FitToPagesWide := f.neFitToWide.Value;
    ppr.FitToPagesTall := f.neFitToTall.Value;

    ppr.PageMargins.CurRegionalMetricLeft := f.neLeftMargin.Value;
    ppr.PageMargins.CurRegionalMetricRight := f.neRightMargin.Value;
    ppr.PageMargins.CurRegionalMetricTop := f.neTopMargin.Value;
    ppr.PageMargins.CurRegionalMetricBottom := f.neBottomMargin.Value;
    ppr.PageMargins.CurRegionalMetricHeader := f.neHeader.Value;
    ppr.PageMargins.CurRegionalMetricFooter := f.neFooter.Value;

    if f.reHeaderLeft.Lines.Text <> ''
      then ppr.PageHeader.LeftText := f.reHeaderLeft.RtfText
      else ppr.PageHeader.LeftText := '';

    if f.reHeaderCenter.Lines.Text <> ''
      then ppr.PageHeader.CenterText := f.reHeaderCenter.RtfText
      else ppr.PageHeader.CenterText := '';

    if f.reHeaderRight.Lines.Text <> ''
      then ppr.PageHeader.RightText := f.reHeaderRight.RtfText
      else ppr.PageHeader.RightText := '';

    if f.reFooterLeft.Lines.Text <> ''
      then ppr.PageFooter.LeftText := f.reFooterLeft.RtfText
      else ppr.PageFooter.LeftText := '';

    if f.reFooterCenter.Lines.Text <> ''
      then ppr.PageFooter.CenterText := f.reFooterCenter.RtfText
      else ppr.PageFooter.CenterText := '';

    if f.reFooterRight.Lines.Text <> ''
      then ppr.PageFooter.RightText := f.reFooterRight.RtfText
      else ppr.PageFooter.RightText := '';

    Result := True;
  end;

  f.Free;
end;

procedure TfSpreadGridsPrintPageSetupDialogEh.FormCreate(Sender: TObject);
begin
  rdAdjustCaptionDelta := rdAdjust.Width - Canvas.TextWidth(rdAdjust.Caption);
  rbFitCaptionDelta := rbFit.Width - Canvas.TextWidth(rbFit.Caption);
  ResourceLanguageChanged;
end;

procedure TfSpreadGridsPrintPageSetupDialogEh.spInsertPageNoClick(
  Sender: TObject);
begin
  if ActiveControl is TDBRichEditEh then
    (ActiveControl as TDBRichEditEh).SelText := '&[Page]';
end;

procedure TfSpreadGridsPrintPageSetupDialogEh.spInsertPagesClick(
  Sender: TObject);
begin
  if ActiveControl is TDBRichEditEh then
    (ActiveControl as TDBRichEditEh).SelText := '&[Pages]';
end;

procedure TfSpreadGridsPrintPageSetupDialogEh.Image1Click(Sender: TObject);
begin
  rbPortrait.Checked := True;
end;

procedure TfSpreadGridsPrintPageSetupDialogEh.Image2Click(Sender: TObject);
begin
  rbLandscape.Checked := True;
end;

procedure TfSpreadGridsPrintPageSetupDialogEh.spFontClick(Sender: TObject);
var
  re: TDBRichEditEh;
begin
  if ActiveControl is TDBRichEditEh then
  begin
    re := ActiveControl as TDBRichEditEh;
    FontDialog1.Font.Assign(re.SelAttributes);
    if FontDialog1.Execute then
      re.SelAttributes.Assign(FontDialog1.Font);
  end;
end;

procedure TfSpreadGridsPrintPageSetupDialogEh.spInsertDateClick(
  Sender: TObject);
begin
  if ActiveControl is TDBRichEditEh then
    (ActiveControl as TDBRichEditEh).SelText := '&[Date]';
end;

procedure TfSpreadGridsPrintPageSetupDialogEh.spInsertShortDateClick(
  Sender: TObject);
begin
  if ActiveControl is TDBRichEditEh then
    (ActiveControl as TDBRichEditEh).SelText := '&[ShortDate]';
end;

procedure TfSpreadGridsPrintPageSetupDialogEh.spInsertLongDateClick(
  Sender: TObject);
begin
  if ActiveControl is TDBRichEditEh then
    (ActiveControl as TDBRichEditEh).SelText := '&[LongDate]';
end;

procedure TfSpreadGridsPrintPageSetupDialogEh.spInsertTimeClick(
  Sender: TObject);
begin
  if ActiveControl is TDBRichEditEh then
    (ActiveControl as TDBRichEditEh).SelText := '&[Time]';
end;

procedure TfSpreadGridsPrintPageSetupDialogEh.WMSettingChange(var Message: TMessage);
begin
  inherited;
  ResourceLanguageChanged;
end;

procedure TfSpreadGridsPrintPageSetupDialogEh.ResourceLanguageChanged;
begin
  Caption := EhLibLanguageConsts.PrintPageSetupDialog_Caption; 
  tsPage.Caption := EhLibLanguageConsts.PrintPageSetupDialog_Page; 
  Label1.Caption := EhLibLanguageConsts.PrintPageSetupDialog_Orientation; 
  Label2.Caption := EhLibLanguageConsts.PrintPageSetupDialog_Scaling; 
  rbPortrait.Caption := EhLibLanguageConsts.PrintPageSetupDialog_Portrait; 
  rbLandscape.Caption := EhLibLanguageConsts.PrintPageSetupDialog_Landscape; 
  lPerNormalSize.Caption := EhLibLanguageConsts.PrintPageSetupDialog_PrNormalSize; 
  lPagesWideBy.Caption := EhLibLanguageConsts.PrintPageSetupDialog_PageWideBy; 
  lTall.Caption := EhLibLanguageConsts.PrintPageSetupDialog_tall; 
  rdAdjust.Caption := EhLibLanguageConsts.PrintPageSetupDialog_AdjustTo; 
  rbFit.Caption := EhLibLanguageConsts.PrintPageSetupDialog_FitTo; 
  tsMargins.Caption := EhLibLanguageConsts.PrintPageSetupDialog_Margins; 
  neLeftMargin.ControlLabel.Caption := EhLibLanguageConsts.PrintPageSetupDialog_Left; 
  neTopMargin.ControlLabel.Caption := EhLibLanguageConsts.PrintPageSetupDialog_Top; 
  neBottomMargin.ControlLabel.Caption := EhLibLanguageConsts.PrintPageSetupDialog_Bottom; 
  neRightMargin.ControlLabel.Caption := EhLibLanguageConsts.PrintPageSetupDialog_Right; 
  neHeader.ControlLabel.Caption := EhLibLanguageConsts.PrintPageSetupDialog_Header; 
  neFooter.ControlLabel.Caption := EhLibLanguageConsts.PrintPageSetupDialog_Footer; 
  tsHeaderFooter.Caption := EhLibLanguageConsts.PrintPageSetupDialog_HeaderFooter; 
  spFont.Hint := EhLibLanguageConsts.PrintPageSetupDialog_ChangeFont; 
  spFont.Caption := EhLibLanguageConsts.PrintPageSetupDialog_FontAbr; 
  spInsertPageNo.Hint := EhLibLanguageConsts.PrintPageSetupDialog_InsertPageNo_Hint; 
  spInsertPageNo.Caption := EhLibLanguageConsts.PrintPageSetupDialog_InsertPageNo_Abr; 
  spInsertPages.Hint := EhLibLanguageConsts.PrintPageSetupDialog_InsertPages_Hint; 
  spInsertPages.Caption := EhLibLanguageConsts.PrintPageSetupDialog_InsertPages_Abr; 
  spInsertDate.Hint := EhLibLanguageConsts.PrintPageSetupDialog_InsertDate_Hint; 
  spInsertDate.Caption := EhLibLanguageConsts.PrintPageSetupDialog_InsertDate_Abr; 
  spInsertShortDate.Hint := EhLibLanguageConsts.PrintPageSetupDialog_InsertShortDate_Hint; 
  spInsertShortDate.Caption := EhLibLanguageConsts.PrintPageSetupDialog_InsertShortDate_Abr; 
  spInsertLongDate.Hint := EhLibLanguageConsts.PrintPageSetupDialog_InsertLongDate_Hint; 
  spInsertLongDate.Caption := EhLibLanguageConsts.PrintPageSetupDialog_InsertLongDate_Abr; 
  spInsertTime.Hint := EhLibLanguageConsts.PrintPageSetupDialog_InsertTime_Hint; 
  spInsertTime.Caption := EhLibLanguageConsts.PrintPageSetupDialog_InsertTime_Abr; 
  Label6.Caption := EhLibLanguageConsts.PrintPageSetupDialog_PageHeader; 
  Label7.Caption := EhLibLanguageConsts.PrintPageSetupDialog_PageFooter; 

  reHeaderLeft.ControlLabel.Caption := EhLibLanguageConsts.PrintPageSetupDialog_Left; 
  reHeaderCenter.ControlLabel.Caption := EhLibLanguageConsts.PrintPageSetupDialog_Center; 
  reHeaderRight.ControlLabel.Caption := EhLibLanguageConsts.PrintPageSetupDialog_Right; 
  reFooterLeft.ControlLabel.Caption := EhLibLanguageConsts.PrintPageSetupDialog_Left; 
  reFooterCenter.ControlLabel.Caption := EhLibLanguageConsts.PrintPageSetupDialog_Center; 
  reFooterRight.ControlLabel.Caption := EhLibLanguageConsts.PrintPageSetupDialog_Right; 

  rdAdjust.Width := rdAdjustCaptionDelta + Canvas.TextWidth(rdAdjust.Caption);
  neScale.Left := rdAdjust.Left + rdAdjustCaptionDelta + Canvas.TextWidth(rdAdjust.Caption);
  lPerNormalSize.Left := neScale.Left + neScale.Width + 14;

  rbFit.Width := rbFitCaptionDelta + Canvas.TextWidth(rbFit.Caption);
  neFitToWide.Left := rbFit.Left + rbFit.Width;
  lPagesWideBy.Left := neFitToWide.Left + neFitToWide.Width + 14;
  neFitToTall.Left := lPagesWideBy.Left + lPagesWideBy.Width + 14;
  lTall.Left := neFitToTall.Left + neFitToTall.Width + 14;
end;

end.
