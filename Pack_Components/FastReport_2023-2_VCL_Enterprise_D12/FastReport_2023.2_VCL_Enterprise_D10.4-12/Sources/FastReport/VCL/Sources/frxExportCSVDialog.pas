
{******************************************}
{                                          }
{             FastReport VCL               }
{            CSV export dialog             }
{                                          }
{         Copyright (c) 1998-2021          }
{                                          }
{******************************************}

{ The specification of the CSV document file format
  can be downloaded from here:

  http://www.rfc-editor.org/rfc/rfc4180.txt }

unit frxExportCSVDialog;

interface

{$I frx.inc}

uses
  {$IFNDEF Linux}
  Windows,
  {$ELSE}
  LCLType, LCLIntf, LCLProc,
  {$ENDIF}
  Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, extctrls, frxExportBaseDialog,
  ComCtrls
{$IFDEF DELPHI6}, Variants {$ENDIF};

type
  TfrxCSVExportDialog = class(TfrxBaseExportDialog)
    OEMCB: TCheckBox;
    SeparatorLB: TLabel;
    SeparatorE: TEdit;
  protected
    procedure InitControlsFromFilter(ExportFilter: TfrxBaseDialogExportFilter); override;
    procedure InitFilterFromDialog(ExportFilter: TfrxBaseDialogExportFilter); override;
  end;

implementation

uses frxRes, frxExportCSV;

{$R *.dfm}

{ TfrxCSVExportDialog }

procedure TfrxCSVExportDialog.InitControlsFromFilter(
  ExportFilter: TfrxBaseDialogExportFilter);
begin
  inherited;
  with TfrxCSVExport(ExportFilter) do
  begin
    OEMCB.Checked := OEMCodepage;
    SeparatorE.Text := Separator;
  end;
end;

procedure TfrxCSVExportDialog.InitFilterFromDialog(
  ExportFilter: TfrxBaseDialogExportFilter);
begin
  inherited;
  with TfrxCSVExport(ExportFilter) do
  begin
    OEMCodepage := OEMCB.Checked;
    Separator := SeparatorE.Text;
  end;
end;

end.
