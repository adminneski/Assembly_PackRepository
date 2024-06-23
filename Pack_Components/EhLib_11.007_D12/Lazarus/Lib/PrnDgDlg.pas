{*******************************************************}
{                                                       }
{                       EhLib 10.2                      }
{             TfPrnDBGridEhSetupDialog form             }
{                                                       }
{   Copyright (c) 1998-2022 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

unit PrnDgDlg;

{$I EhLib.Inc}

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Messages,
  {$IFDEF FPC}
  PrintersDlgs, EhLibLCL,
  {$ELSE}
  {$ENDIF}
  StdCtrls, ToolCtrlsEh, Printers, ExtCtrls, LanguageResManEh;

type
  TfPrnDBGridEhSetupDialog = class(TForm)
    gbPrintFields: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    seUpMargin: TEdit;
    seLowMargin: TEdit;
    seLeftMargin: TEdit;
    seRightMargin: TEdit;
    cbFitWidthToPage: TCheckBox;
    ePrintFont: TEdit;
    cbAutoStretch: TCheckBox;
    bPrinterSetupDialog: TButton;
    bPrintFont: TButton;
    bOk: TButton;
    bCancel: TButton;
    FontDialog1: TFontDialog;
    PrinterSetupDialog1: TPrinterSetupDialog;
    cbColored: TCheckBox;
    rgFitingType: TRadioGroup;
    cbOptimalColWidths: TCheckBox;
    procedure bPrintFontClick(Sender: TObject);
    procedure bPrinterSetupDialogClick(Sender: TObject);
    procedure seMarginExit(Sender: TObject);
    procedure fPrnDBGridEHSetupDialogShow(Sender: TObject);
    procedure cbFitWidthToPageClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
      procedure CMBiDiModeChanged(var Message: TMessage); message CM_BIDIMODECHANGED;
      procedure WMSettingChange(var Message: TMessage); message WM_SETTINGCHANGE;

  protected
    procedure ResourceLanguageChanged; virtual;

  public
    ChildrenRightToLeft: Boolean;
  end;

var
  fPrnDBGridEhSetupDialog: TfPrnDBGridEhSetupDialog;

implementation

uses EhLibLangConsts;

{$R *.dfm}

procedure TfPrnDBGridEhSetupDialog.FormCreate(Sender: TObject);
begin
  ResourceLanguageChanged;
end;

procedure TfPrnDBGridEhSetupDialog.WMSettingChange(var Message: TMessage);
begin
  inherited;
  ResourceLanguageChanged;
end;

procedure TfPrnDBGridEhSetupDialog.CMBiDiModeChanged(var Message: TMessage);
begin
  inherited;
  if UseRightToLeftAlignment and not ChildrenRightToLeft then
  begin
    ChildrenRightToLeft := True;
    FlipChildren(True);
  end else if not UseRightToLeftAlignment and ChildrenRightToLeft then
  begin
    ChildrenRightToLeft := False;
    FlipChildren(True);
  end;
end;

procedure TfPrnDBGridEhSetupDialog.ResourceLanguageChanged;
begin
  Caption := EhLibLanguageConsts.PrnDBGridEhSetupDialog_Caption;
  gbPrintFields.Caption := EhLibLanguageConsts.PrnDBGridEhSetupDialog_Margins;
  Label5.Caption := EhLibLanguageConsts.PrnDBGridEhSetupDialog_Top;
  Label6.Caption := EhLibLanguageConsts.PrnDBGridEhSetupDialog_Bottom;
  Label7.Caption := EhLibLanguageConsts.PrnDBGridEhSetupDialog_Left;
  Label8.Caption := EhLibLanguageConsts.PrnDBGridEhSetupDialog_Right;
  cbAutoStretch.Caption := EhLibLanguageConsts.PrnDBGridEhSetupDialog_StretchLongLines;
  bPrinterSetupDialog.Caption := EhLibLanguageConsts.PrnDBGridEhSetupDialog_PrinterSetup;
  bOk.Caption := EhLibLanguageConsts.OKButtonEh;
  bCancel.Caption := EhLibLanguageConsts.CancelButtonEh;
  cbColored.Caption := EhLibLanguageConsts.PrnDBGridEhSetupDialog_Colored;
  rgFitingType.Items[0] := EhLibLanguageConsts.PrnDBGridEhSetupDialog_ScaleWholeGrid;
  rgFitingType.Items[1] := EhLibLanguageConsts.PrnDBGridEhSetupDialog_ChangeColumnWidths;
  cbFitWidthToPage.Caption := EhLibLanguageConsts.PrnDBGridEhSetupDialog_FitWidthToPage;
  cbOptimalColWidths.Caption := EhLibLanguageConsts.PrnDBGridEhSetupDialog_OptimalColWidths;

end;

procedure TfPrnDBGridEhSetupDialog.bPrintFontClick(Sender: TObject);
begin
  FontDialog1.Font.Name := ePrintFont.Text;
  if FontDialog1.Execute = True then
    ePrintFont.Text := FontDialog1.Font.Name;
end;

procedure TfPrnDBGridEhSetupDialog.bPrinterSetupDialogClick(Sender: TObject);
begin
  PrinterSetupDialog1.Execute;
end;

procedure TfPrnDBGridEhSetupDialog.seMarginExit(Sender: TObject);
begin
  StrToFloat(TEdit(Sender).Text);
end;

procedure TfPrnDBGridEhSetupDialog.fPrnDBGridEHSetupDialogShow(
  Sender: TObject);
begin
  bPrinterSetupDialog.Enabled := Printer.Printers.Count > 0;
end;

procedure TfPrnDBGridEhSetupDialog.cbFitWidthToPageClick(Sender: TObject);
begin
  rgFitingType.Enabled := cbFitWidthToPage.Checked;
end;

end.
