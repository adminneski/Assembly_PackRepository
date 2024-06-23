
{******************************************}
{                                          }
{             FastReport VCL               }
{            DOCX export dialog            }
{                                          }
{         Copyright (c) 1998-2021          }
{                                          }
{******************************************}

unit frxExportDOCXDialog;

interface

{$I frx.inc}

uses
{$IFNDEF FPC}
  Windows, Messages,
{$ELSE}
  LCLType, LCLIntf,
{$ENDIF}
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, frxExportBaseDialog
{$IFDEF DELPHI16}
, System.UITypes
{$ENDIF}
;

type
  TfrxDOCXExportDialog = class(TfrxBaseExportDialog)
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
  protected
    procedure InitControlsFromFilter(ExportFilter: TfrxBaseDialogExportFilter); override;
    procedure InitFilterFromDialog(ExportFilter: TfrxBaseDialogExportFilter); override;
  end;
  
implementation

uses frxExportDOCX;

{$R *.dfm}

procedure TfrxDOCXExportDialog.InitControlsFromFilter(ExportFilter: TfrxBaseDialogExportFilter);
var
  Docx: TfrxDocxExport;
begin
  inherited;
  Docx := TfrxDocxExport(ExportFilter);
  case Docx.ExportType of
    dxTable:   RadioButton1.Checked := True;
    dxObjects: RadioButton2.Checked := True;
  end;
end;

procedure TfrxDOCXExportDialog.InitFilterFromDialog(ExportFilter: TfrxBaseDialogExportFilter);
var
  Docx: TfrxDocxExport;
begin
  inherited;
  Docx := TfrxDocxExport(ExportFilter);
  if RadioButton1.Checked then
    Docx.ExportType := dxTable
  else
    Docx.ExportType := dxObjects;
end;

end.
