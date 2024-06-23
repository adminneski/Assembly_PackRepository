
{******************************************}
{                                          }
{             FastReport VCL               }
{         Simple text export dialog        }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxExportTextDialog;

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
  TfrxSimpleTextExportDialog = class(TfrxBaseExportDialog)
    PageBreaksCB: TCheckBox;
    FramesCB: TCheckBox;
    EmptyLinesCB: TCheckBox;
    OEMCB: TCheckBox;
  protected
    procedure InitControlsFromFilter(ExportFilter: TfrxBaseDialogExportFilter); override;
    procedure InitFilterFromDialog(ExportFilter: TfrxBaseDialogExportFilter); override;
  end;

implementation

uses frxRes, frxExportText;

{$R *.dfm}

{ TfrxSimpleTextExportDialog }

procedure TfrxSimpleTextExportDialog.InitControlsFromFilter(
  ExportFilter: TfrxBaseDialogExportFilter);
begin
  inherited;
  with TfrxSimpleTextExport(ExportFilter) do
  begin
    PageBreaksCB.Checked := PageBreaks;
    FramesCB.Checked := Frames;
    EmptyLinesCB.Checked := EmptyLines;
    OEMCB.Checked := OEMCodepage;
  end;
end;

procedure TfrxSimpleTextExportDialog.InitFilterFromDialog(
  ExportFilter: TfrxBaseDialogExportFilter);
begin
  inherited;
  with TfrxSimpleTextExport(ExportFilter) do
  begin
    PageBreaks := PageBreaksCB.Checked;
    OpenAfterExport := OpenCB.Checked;
    Frames := FramesCB.Checked;
    EmptyLines := EmptyLinesCB.Checked;
    OEMCodepage := OEMCB.Checked;
  end;
end;

end.
