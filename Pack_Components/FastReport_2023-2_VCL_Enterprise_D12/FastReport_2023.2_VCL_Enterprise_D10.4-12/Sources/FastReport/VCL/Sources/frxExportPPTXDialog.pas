
{******************************************}
{                                          }
{             FastReport VCL               }
{            PPTX export dialog            }
{                                          }
{         Copyright (c) 1998-2021          }
{                                          }
{******************************************}

unit frxExportPPTXDialog;

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
  TfrxPPTXExportDialog = class(TfrxBaseExportDialog)
  end;

implementation

{$R *.dfm}

end.
