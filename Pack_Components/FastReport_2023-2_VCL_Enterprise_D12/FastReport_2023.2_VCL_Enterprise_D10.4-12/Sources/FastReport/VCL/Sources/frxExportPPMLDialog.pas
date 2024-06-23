unit frxExportPPMLDialog;

{$I frx.inc}

interface

uses
{$IFNDEF FPC}
  Windows,
{$ELSE}
  LCLType, LCLIntf, LCLProc,
{$ENDIF}
  SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, frxExportBaseDialog, StdCtrls,
  ComCtrls;

type
  TfrxExportPPMLDialog = class(TfrxBaseExportDialog)
    Pictures: TCheckBox;
    IncludeImages: TCheckBox;
    HasMultipleFiles: TCheckBox;
    PicturesL: TLabel;
    ComboBox1: TComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure InitControlsFromFilter(ExportFilter: TfrxBaseDialogExportFilter); override;
    procedure InitFilterFromDialog(ExportFilter: TfrxBaseDialogExportFilter); override;
 end;

var
  frxExportPPMLDialoge: TfrxExportPPMLDialog;

implementation

uses frxExportPPML, frxExportPSHelper;

{$R *.dfm}

procedure TfrxExportPPMLDialog.InitControlsFromFilter(ExportFilter: TfrxBaseDialogExportFilter);
var
  PPML: TfrxPPMLExport;
begin
  inherited;
  PPML := TfrxPPMLExport(ExportFilter);
  Pictures.Checked := PPML.Pictures;
  IncludeImages.Checked := PPML.IncludeImages;
  HasMultipleFiles.Checked := PPML.HasMultipleFiles;
  if (PPML.ImageFormat = psPng) then
    ComboBox1.ItemIndex := 0
  else
    ComboBox1.ItemIndex := 1;
end;

procedure TfrxExportPPMLDialog.InitFilterFromDialog(ExportFilter: TfrxBaseDialogExportFilter);
var
  PPML: TfrxPPMLExport;
begin
  inherited;
  PPML := TfrxPPMLExport(ExportFilter);
  PPML.Pictures := Pictures.Checked;
  PPML.IncludeImages := IncludeImages.Checked;
  PPML.HasMultipleFiles := HasMultipleFiles.Checked;
  PPML.ImageFormat := PSImageFormat(ComboBox1.ItemIndex);
end;

end.
