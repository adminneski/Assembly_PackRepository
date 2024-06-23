unit frxExportPSDialog;

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
  TfrxExportPSDialog = class(TfrxBaseExportDialog)
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
  frxExportPSDialoge: TfrxExportPSDialog;

implementation

uses frxExportPS, frxExportPSHelper;

{$R *.dfm}

procedure TfrxExportPSDialog.InitControlsFromFilter(ExportFilter: TfrxBaseDialogExportFilter);
var
  PS: TfrxPSExport;
begin
  inherited;
  PS := TfrxPSExport(ExportFilter);
  Pictures.Checked := PS.Pictures;
  IncludeImages.Checked := PS.IncludeImages;
  HasMultipleFiles.Checked := PS.HasMultipleFiles;
  if (PS.ImageFormat = psPng) then
    ComboBox1.ItemIndex := 0
  else
    ComboBox1.ItemIndex := 1;
end;

procedure TfrxExportPSDialog.InitFilterFromDialog(ExportFilter: TfrxBaseDialogExportFilter);
var
  PS: TfrxPSExport;
begin
  inherited;
  PS := TfrxPSExport(ExportFilter);
  PS.Pictures := Pictures.Checked;
  PS.IncludeImages := IncludeImages.Checked;
  PS.HasMultipleFiles := HasMultipleFiles.Checked;
  PS.ImageFormat := PSImageFormat(ComboBox1.ItemIndex);
end;

end.
