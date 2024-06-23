{ ****************************************** }
{ }
{ FastReport v5.0 }
{ HTML <div> Export }
{ }
{         Copyright (c) 1998-2021          }
{ by Anton Khayrudinov }
{ Fast Reports Inc. }
{ }
{ ****************************************** }

unit frxExportHTMLDivDialog;

{ General advice for using this export.

  • Avoid using vertical alignment in memos:
  it forces the export to create more
  complicated HTML. Leave the alignment vaTop
  whenever it's possible.

  • Use @-type anchors in TfrxView.URL instead of
  #-type, because #-type is much slower to export. }

interface

{$I frx.inc}

uses
{$IFNDEF FPC}
  Windows,
{$ENDIF}
  SysUtils, Classes, Controls, Forms,
  Dialogs, StdCtrls, Graphics, frxPreview,
{$IFDEF DELPHI16}
  System.UITypes,
{$ENDIF}
  frxExportBaseDialog, ComCtrls;

type
  TfrxHTMLDivExportDialog = class(TfrxBaseExportDialog)
    PicturesL: TLabel;
    StylesCB: TCheckBox;
    UnifiedPicturesCB: TCheckBox;
    PicturesCB: TCheckBox;
    MultipageCB: TCheckBox;
    PFormatCB: TComboBox;
    FormattedCB: TCheckBox;
    NavigationCB: TCheckBox;
    OutlineCB: TCheckBox;
    procedure MultipageCBClick(Sender: TObject);
  protected
    procedure InitControlsFromFilter(ExportFilter: TfrxBaseDialogExportFilter); override;
    procedure InitFilterFromDialog(ExportFilter: TfrxBaseDialogExportFilter); override;
  end;

implementation

uses
  frxRes, frxExportHelpers, frxExportHTMLDiv;

{$R *.dfm}

{ Utility routines }

{ TfrxHTMLDivExportDialog }

procedure TfrxHTMLDivExportDialog.InitControlsFromFilter
  (ExportFilter: TfrxBaseDialogExportFilter);

  procedure DisableCB(CB: TCheckBox);
  begin
    CB.State := cbGrayed;
    CB.Enabled := False;
  end;

begin
  inherited;
  with TExportHTMLDivSVGParent(ExportFilter) do
  begin
    if Report = nil then
      Outline := True
    else if Report.Preview = nil then
      Outline := Report.PreviewOptions.OutlineVisible
    else
      Outline := TfrxPreview(Report.Preview).OutlineVisible;
    if SlaveExport then
    begin
      EmbeddedCSS := True;
      DisableCB(StylesCB);

      EmbeddedPictures := True;
      DisableCB(PicturesCB);

      MultiPage := False;
      DisableCB(MultipageCB);

      Navigation := False;
      DisableCB(NavigationCB);

      PictureFormat := pfPNG;
      PFormatCB.Enabled := False;

      UnifiedPictures := True;
      DisableCB(UnifiedPicturesCB);
      OutlineCB.Enabled := Outline;
    end;

    StylesCB.Checked := EmbeddedCSS;
    PicturesCB.Checked := EmbeddedPictures;
    MultipageCB.Checked := MultiPage;
    NavigationCB.Checked := Navigation;
    UnifiedPicturesCB.Checked := UnifiedPictures;
    FormattedCB.Checked := Formatted;
    PFormatCB.ItemIndex := Integer(PictureFormat);
    PicturesL.Caption := frxGet(8002);
    OutlineCB.Checked := Outline;
    // SaveDialog1.Filter := GetStr('9301');
  end;
end;

procedure TfrxHTMLDivExportDialog.InitFilterFromDialog
  (ExportFilter: TfrxBaseDialogExportFilter);
begin
  inherited;
  with TExportHTMLDivSVGParent(ExportFilter) do
  begin
    EmbeddedCSS := StylesCB.Checked;
    EmbeddedPictures := PicturesCB.Checked;
    Navigation := NavigationCB.Checked;
    UnifiedPictures := UnifiedPicturesCB.Checked;
    Formatted := FormattedCB.Checked;
    PictureFormat := TfrxPictureFormat(PFormatCB.ItemIndex);
    Outline := OutlineCB.Checked;
    MultiPage := MultipageCB.Checked;
  end;
end;

procedure TfrxHTMLDivExportDialog.MultipageCBClick(Sender: TObject);
begin
  OutlineCB.Enabled := not MultipageCB.Checked;
end;

end.
