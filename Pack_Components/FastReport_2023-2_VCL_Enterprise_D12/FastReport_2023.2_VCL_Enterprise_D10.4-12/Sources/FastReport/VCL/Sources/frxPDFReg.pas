
{******************************************}
{                                          }
{             FastReport VCL               }
{       PDF components registration        }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxPDFReg;

{$I frx.inc}
{$R *.dcr}  //Repacked Version Line added
interface

procedure Register;

implementation

uses
{$IFNDEF Linux}
  Windows,
{$ELSE}
  LCLType, LCLIntf, LCLProc,
{$ENDIF}
  Messages, SysUtils, Classes, Controls, frxReg
{$IFNDEF DELPHI6}
, DsgnIntf
{$ELSE}
 {$IFNDEF FPC}
, DesignIntf, DesignEditors
 {$ENDIF}
{$ENDIF}
{$IFDEF FPC}
, LResources
{$ENDIF}
, frxPDFViewer;

procedure Register;
begin
  RegisterComponents(frxDefaultProductPage, [TfrxPDFObject]);
{$IFDEF DELPHI16}
//  GroupDescendentsWith(TfrxPDFComponent, TControl);
{$ENDIF}
end;

{$IFDEF FPC}
 initialization
  {$INCLUDE frxRegPDFLaz.lrs}
{$ENDIF}

end.
