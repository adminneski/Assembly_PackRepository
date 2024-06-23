
{******************************************}
{                                          }
{             FastReport VCL               }
{     HTML table export filter dialog      }
{                                          }
{         Copyright (c) 1998-2021          }
{                                          }
{******************************************}

unit frxExportHTMLDialog;

interface

{$I frx.inc}

uses
  {$IFNDEF Linux}
  Windows,
  {$ELSE}
  LCLType, LCLIntf, LCLProc,
  {$ENDIF}
  Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Variants, frxExportBaseDialog, ComCtrls, frxPreview
{$IFDEF DELPHI16}
, System.UITypes
{$ENDIF}
;

type
  TfrxHTMLExportDialog = class(TfrxBaseExportDialog)
    StylesCB: TCheckBox;
    PicsSameCB: TCheckBox;
    FixWidthCB: TCheckBox;
    NavigatorCB: TCheckBox;
    MultipageCB: TCheckBox;
    BackgrCB: TCheckBox;
    PicturesL: TLabel;
    PFormatCB: TComboBox;
    OutlineCB: TCheckBox;
    procedure MultipageCBClick(Sender: TObject);
  protected
    procedure InitDialog; override;
    procedure InitControlsFromFilter(ExportFilter: TfrxBaseDialogExportFilter); override;
    procedure InitFilterFromDialog(ExportFilter: TfrxBaseDialogExportFilter); override;
  end;


implementation

uses frxRes, frxExportHTML, frxImageConverter;

{$R *.dfm}

{ TfrxHTMLExportDialog }

procedure TfrxHTMLExportDialog.InitControlsFromFilter(
  ExportFilter: TfrxBaseDialogExportFilter);
begin
  inherited;
  {$IFNDEF Linux}
  SendMessage(GetWindow(PFormatCB.Handle,GW_CHILD), EM_SETREADONLY, 1, 0);
  {$ENDIF}
  with TfrxHTMLExport(ExportFilter) do
  begin
    if Report = nil then
      Outline := True
    else if Report.Preview = nil then
      Outline := Report.PreviewOptions.OutlineVisible
    else
      Outline := TfrxPreview(Report.Preview).OutlineVisible;

    MultipageCB.Enabled := not SlaveExport;
    BackgrCB.Enabled := not SlaveExport;
    NavigatorCB.Enabled := not SlaveExport;
    PicsSameCB.Enabled := not SlaveExport;
    OutlineCB.Enabled := Outline;

    if SlaveExport then
    begin
      ExportPictures := True;
      PicsInSameFolder := True;
      Navigator := False;
      Multipage := False;
      Background := False;
      Outline := False;
    end;

//      if (FileName = '') and (not SlaveExport) then
//        SaveDialog1.FileName := ChangeFileExt(ExtractFileName(frxUnixPath2WinPath(Report.FileName)), SaveDialog1.DefaultExt)
//      else
//        SaveDialog1.FileName := FileName;

    StylesCB.Checked := ExportStyles;
    PicsSameCB.Checked := PicsInSameFolder;

    if not ExportPictures then
      PFormatCB.ItemIndex := 0
    else
      PFormatCB.ItemIndex := Integer(PictureType) + 1;

    FixWidthCB.Checked := FixedWidth;
    NavigatorCB.Checked := Navigator;
    MultipageCB.Checked := Multipage;
    BackgrCB.Checked := Background;
    OutlineCB.Checked := Outline;
  end;
end;

procedure TfrxHTMLExportDialog.InitDialog;
begin
  {$IFNDEF FPC}
  PFormatCB.Items.Add('GIF');
  PFormatCB.Items.Add('EMF');
  PFormatCB.Items.Add('WMF');
  {$ENDIF}
  inherited;
end;

procedure TfrxHTMLExportDialog.InitFilterFromDialog(
  ExportFilter: TfrxBaseDialogExportFilter);
begin
  inherited;
  with TfrxHTMLExport(ExportFilter) do
  begin
    ExportStyles := StylesCB.Checked;
    PicsInSameFolder := PicsSameCB.Checked;
    ExportPictures := PFormatCB.ItemIndex > 0;
    PictureType := TfrxPictureType(PFormatCB.ItemIndex-1);

    FixedWidth := FixWidthCB.Checked;
    Navigator := NavigatorCB.Checked;
    Background := BackgrCB.Checked;
    Outline := OutlineCB.Checked;
    Multipage := MultipageCB.Checked;
  end;
end;

procedure TfrxHTMLExportDialog.MultipageCBClick(Sender: TObject);
begin
  OutlineCB.Enabled := not MultipageCB.Checked;
end;

end.
