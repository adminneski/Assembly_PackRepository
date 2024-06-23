{*******************************************************}
{                                                       }
{                       EhLib 10.2                      }
{                  TPreviewFormEh form                  }
{                                                       }
{   Copyright (c) 1998-2022 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

unit PrvFrmEh;

{$I EhLib.Inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Variants, Types, ToolCtrlsEh,
{$IFDEF CIL}
{$ELSE}
{$ENDIF}
  ImgList, PrViewEh, ComCtrls, Menus, ExtCtrls, ToolWin, StdCtrls,
  EhLibVCL, GridsEh, LanguageResManEh;

type
  TPreviewFormEh = class(TForm, ILanguageResourceLoadNotificationConsumer)
    PreviewEh1: TPreviewBox;
    tbrMain: TToolBar;
    tbtPrint: TToolButton;
    tbtPrinterSetupDialog: TToolButton;
    tbtScale: TToolButton;
    tbtPrevPage: TToolButton;
    tbtNextPage: TToolButton;
    tbStop: TToolButton;
    tbClose: TToolButton;
    Splitter: TSplitter;
    pmnScale: TPopupMenu;
    mni500: TMenuItem;
    mni200: TMenuItem;
    mni150: TMenuItem;
    mni100: TMenuItem;
    mni75: TMenuItem;
    mni50: TMenuItem;
    mni25: TMenuItem;
    mni10: TMenuItem;
    mniWidth: TMenuItem;
    mniFull: TMenuItem;
    imlMain: TImageList;
    stbMain: TStatusBar;
    Timer1: TTimer;
    procedure tbtPrintClick(Sender: TObject);
    procedure tbtPrintDialogClick(Sender: TObject);
    procedure tbtPrinterSetupDialogClick(Sender: TObject);
    procedure tbtPrevPageClick(Sender: TObject);
    procedure tbtNextPageClick(Sender: TObject);
    procedure tbStopClick(Sender: TObject);
    procedure tbCloseClick(Sender: TObject);
    procedure mniScaleClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SplitterCanResize(Sender: TObject; var NewSize: Integer; var Accept: Boolean);
    procedure tbtScaleClick(Sender: TObject);
    procedure PreviewEh1PrinterPreviewChanged(Sender: TObject);
    procedure PreviewEh1OpenPreviewer(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure tbtNextPageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tbtNextPageMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tbtPrevPageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tbtPrevPageMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
    FPressedButton: TToolButton;
    FNeedClose: Boolean;

    procedure WMSettingChange(var Message: TMessage); message WM_SETTINGCHANGE;
  protected
    procedure ResourceLanguageChanged; virtual;
  public
  end;

var
  PreviewFormEh: TPreviewFormEh;

implementation

uses EhLibLangConsts;

{$R *.DFM}
const
  InitRepeatPause = 400; { pause before repeat timer (ms) }
  RepeatPause = 100; { pause before hint window displays (ms)}

procedure TPreviewFormEh.FormCreate(Sender: TObject);
begin
  Splitter.OnCanResize := SplitterCanResize;
  Splitter.ResizeStyle := rsUpdate;
  Splitter.Height := Trunc(Screen.PixelsPerInch / 16);
  mni500.Tag := 0;
  mni200.Tag := 1;
  mni150.Tag := 2;
  mni100.Tag := 3;
  mni75.Tag := 4;
  mni50.Tag := 5;
  mni25.Tag := 6;
  mni10.Tag := 7;
  mniWidth.Tag := 8;
  mniFull.Tag := 9;
{$IFDEF OLDPREVIEWBOX}
  PreviewEh1.HorzScrollBar.Tracking := True;
  PreviewEh1.VertScrollBar.Tracking := True;
  PreviewEh1.AutoScroll := False;
{$ELSE}
{$ENDIF}
  ResourceLanguageChanged;
end;

procedure TPreviewFormEh.FormDestroy(Sender: TObject);
begin
end;

procedure TPreviewFormEh.WMSettingChange(var Message: TMessage);
begin
  inherited;
  ResourceLanguageChanged;
end;

procedure TPreviewFormEh.ResourceLanguageChanged();
begin
  Caption := EhLibLanguageConsts.PreviewForm_Caption;
  tbtPrint.Hint := EhLibLanguageConsts.PreviewForm_Print_Hint;
  tbtPrint.Caption := EhLibLanguageConsts.PreviewForm_Print_Caption;
  tbtPrinterSetupDialog.Hint := EhLibLanguageConsts.PreviewForm_PrinterSetupDialog_Hint;
  tbtPrinterSetupDialog.Caption := EhLibLanguageConsts.PreviewForm_PrinterSetupDialog_Caption;
  tbtScale.Hint := EhLibLanguageConsts.PreviewForm_Scale_Hint;
  tbtScale.Caption := EhLibLanguageConsts.PreviewForm_Scale_Caption;
  tbtPrevPage.Hint := EhLibLanguageConsts.PreviewForm_PrevPage_Hint;
  tbtPrevPage.Caption := EhLibLanguageConsts.PreviewForm_PrevPage_Caption;
  tbtNextPage.Hint := EhLibLanguageConsts.PreviewForm_NextPage_Hint;
  tbtNextPage.Caption := EhLibLanguageConsts.PreviewForm_NextPage_Caption;
  tbStop.Caption := EhLibLanguageConsts.PreviewForm_Stop_Caption;
  tbClose.Hint := EhLibLanguageConsts.PreviewForm_Close_Hint;
  tbClose.Caption := EhLibLanguageConsts.PreviewForm_Close_Caption;
  mniWidth.Caption := EhLibLanguageConsts.PreviewForm_MenuPageWidth;
  mniFull.Caption := EhLibLanguageConsts.PreviewForm_MenuFullPage;
  stbMain.SimpleText := Format(EhLibLanguageConsts.PageOfPages, [PreviewEh1.PageIndex, PreviewEh1.PageCount]);
end;

procedure TPreviewFormEh.tbtPrintClick(Sender: TObject);
begin
  PreviewEh1.PrintDialog;
end;

procedure TPreviewFormEh.tbtPrintDialogClick(Sender: TObject);
begin
  PreviewEh1.PrintDialog;
end;

procedure TPreviewFormEh.tbtPrinterSetupDialogClick(Sender: TObject);
begin
  PreviewEh1.PrinterSetupDialog;
end;

procedure TPreviewFormEh.tbtPrevPageClick(Sender: TObject);
begin
  if {(FPressedButton <> nil) and }((Timer1.Interval <> RepeatPause) or (Sender = nil)) then
    PreviewEh1.PageIndex := Pred(PreviewEh1.PageIndex);
end;

procedure TPreviewFormEh.tbtNextPageClick(Sender: TObject);
begin
  if {(FPressedButton <> nil) and}((Timer1.Interval <> RepeatPause) or (Sender = nil)) then
    PreviewEh1.PageIndex := Succ(PreviewEh1.PageIndex);
end;

procedure TPreviewFormEh.tbStopClick(Sender: TObject);
begin
  PreviewEh1.Printer.Abort;
end;

procedure TPreviewFormEh.tbCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TPreviewFormEh.mniScaleClick(Sender: TObject);
const ViewModeArr: array [0..9] of TViewMode  =
  (vm500, vm200, vm150, vm100, vm75, vm50, vm25, vm10, vmPageWidth, vmFullPage);
var
  s: TMenuItem;
begin
  s := Sender as TMenuItem;
  s.Checked := True;
  PreviewEh1.ViewMode := ViewModeArr[Integer(s.Tag)];
  PreviewEh1.UpdatePageSetup;
end;

procedure TPreviewFormEh.SplitterCanResize(Sender: TObject; var NewSize: Integer; var Accept: Boolean);
begin
  if (NewSize >= 38 + 3) and (tbrMain.Images = nil) and tbrMain.ShowCaptions then
  begin
    tbrMain.ShowCaptions := False;
    tbrMain.Images := imlMain;
    tbrMain.ButtonHeight := 38;
    tbrMain.ButtonWidth := 39;
  end else
    if (NewSize >= 52 + 3) and not tbrMain.ShowCaptions and (tbrMain.Images <> nil)
      then tbrMain.ShowCaptions := True
    else if (NewSize <= 21 + 3) and not tbrMain.ShowCaptions and (tbrMain.Images <> nil) then
    begin
      tbrMain.Images := nil;
      tbrMain.ShowCaptions := True;
    end
    else if (NewSize <= 38 + 3) and tbrMain.ShowCaptions and (tbrMain.Images <> nil) then
    begin
      tbrMain.ShowCaptions := False;
      tbrMain.ButtonHeight := 38;
      tbrMain.ButtonWidth := 39;
    end
end;

procedure TPreviewFormEh.tbtScaleClick(Sender: TObject);
var p: TPoint;
begin
  p := tbtScale.ClientToScreen(Point(0, tbtScale.Height));
  tbtScale.DropdownMenu.Popup(p.x, p.y);
end;

procedure TPreviewFormEh.PreviewEh1PrinterPreviewChanged(Sender: TObject);
begin
  if not PreviewEh1.Printer.Printing and FNeedClose then
  begin
    FNeedClose := False;
    Close;
  end;
  tbStop.Enabled := PreviewEh1.Printer.Printing;
  tbClose.Enabled := not PreviewEh1.Printer.Printing;
  tbtPrint.Enabled := not PreviewEh1.Printer.Printing and
    (PreviewEh1.Printer.Printer.Printers.Count > 0);
  tbtPrinterSetupDialog.Enabled := not PreviewEh1.Printer.Printing and
    (Assigned(PreviewEh1.OnPrinterSetupDialog) or Assigned(PreviewEh1.OnPrinterSetupChanged)) and
    Assigned(PreviewEh1.PrinterSetupOwner);
  tbtPrevPage.Enabled := PreviewEh1.PageIndex > 1;
  tbtNextPage.Enabled := PreviewEh1.PageIndex < PreviewEh1.PageCount;
  stbMain.SimpleText := Format(EhLibLanguageConsts.PageOfPages, [PreviewEh1.PageIndex, PreviewEh1.PageCount]);
  case PreviewEh1.ViewMode of
    vm500: mni500.Checked := True;
    vm200: mni200.Checked := True;
    vm150: mni150.Checked := True;
    vm100: mni100.Checked := True;
    vm75: mni75.Checked := True;
    vm50: mni50.Checked := True;
    vm25: mni25.Checked := True;
    vm10: mni10.Checked := True;
    vmPageWidth: mniWidth.Checked := True;
    vmFullPage: mniFull.Checked := True;
  end;
  Caption := EhLibLanguageConsts.Preview + ' - ' + PreviewEh1.Printer.Title;
end;

procedure TPreviewFormEh.PreviewEh1OpenPreviewer(Sender: TObject);
begin
  if IsIconic(Handle) then ShowWindow(Handle, sw_Restore);
  BringWindowToTop(Handle);
  if not Visible then Show;
end;

type
  TToolButtonCracker = class(TToolButton)
    property MouseCapture;
  end;

procedure TPreviewFormEh.Timer1Timer(Sender: TObject);
begin
  Timer1.Interval := RepeatPause;
  if FPressedButton <> nil then
{$IFDEF CIL}
    if {FPressedButton.Down and}  IControl(FPressedButton).GetMouseCapture then
{$ELSE}
    if {FPressedButton.Down and}  TToolButtonCracker(FPressedButton).MouseCapture then
{$ENDIF}
    begin
      try
        FPressedButton.OnClick(nil);
      except
        Timer1.Enabled := False;
        raise;
      end;
    end;
end;

procedure TPreviewFormEh.tbtNextPageMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Timer1.Interval := InitRepeatPause;
  Timer1.Enabled := True;
  FPressedButton := tbtNextPage;
end;

procedure TPreviewFormEh.tbtNextPageMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Timer1.Enabled := False;
  FPressedButton := nil;
end;

procedure TPreviewFormEh.tbtPrevPageMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Timer1.Interval := InitRepeatPause;
  Timer1.Enabled := True;
  FPressedButton := tbtPrevPage;
end;

procedure TPreviewFormEh.tbtPrevPageMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Timer1.Enabled := False;
  FPressedButton := nil;
end;

procedure TPreviewFormEh.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    if PreviewEh1.Printer.Printing
      then PreviewEh1.Printer.Abort
      else Close;
end;

procedure TPreviewFormEh.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if PreviewEh1.Printer.Printing then
  begin
    PreviewEh1.Printer.Abort;
    FNeedClose := True;
    Action := caNone;
  end;
end;

end.
