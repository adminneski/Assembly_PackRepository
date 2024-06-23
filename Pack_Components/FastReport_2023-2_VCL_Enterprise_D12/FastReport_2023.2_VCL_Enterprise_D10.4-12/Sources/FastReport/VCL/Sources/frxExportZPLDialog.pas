unit frxExportZPLDialog;

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
  TfrxExportZPLDialog = class(TfrxBaseExportDialog)
    PrintAsBitmap: TCheckBox;
    BreakLines: TCheckBox;
    ComboBox1: TComboBox;
    Label1: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure InitControlsFromFilter(ExportFilter: TfrxBaseDialogExportFilter); override;
    procedure InitFilterFromDialog(ExportFilter: TfrxBaseDialogExportFilter); override;
  end;

var
  frxExportZPLDialoge: TfrxExportZPLDialog;

implementation

uses frxExportZPL;

{$R *.dfm}

procedure TfrxExportZPLDialog.InitControlsFromFilter(ExportFilter: TfrxBaseDialogExportFilter);
var
  zpl: TfrxZPLExport;
begin
  inherited;
  zpl := TfrxZPLExport(ExportFilter);
  PrintAsBitmap.Checked := zpl.PrintAsBitmap;
  BreakLines.Checked := zpl.BreakLines;
  ComboBox1.ItemIndex := zpl.scaleIndex;
end;

procedure TfrxExportZPLDialog.InitFilterFromDialog(ExportFilter: TfrxBaseDialogExportFilter);
var
  zpl: TfrxZPLExport;
begin
  inherited;
  zpl := TfrxZPLExport(ExportFilter);
  zpl.PrintAsBitmap := PrintAsBitmap.Checked;
  zpl.BreakLines := BreakLines.Checked;
  zpl.ZplDensity := TZplDensity(ComboBox1.ItemIndex);
end;

end.
