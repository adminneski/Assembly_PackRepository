
{******************************************}
{                                          }
{             FastReport VCL               }
{            Registration unit             }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxRegDB;

{$I frx.inc}

interface


procedure Register;

implementation

uses
  Windows, Messages, SysUtils, Classes, Forms, Controls, frxReg,
{$IFNDEF DELPHI6}
  DsgnIntf,
{$ELSE}
  DesignIntf, DesignEditors,
{$ENDIF}
  frxDBSet,
  frxCustomDB,
  frxCustomDBEditor,
  frxCustomDBRTTI,
  frxEditMD,
  frxEditQueryParams;


{-----------------------------------------------------------------------}
procedure Register;
begin
  RegisterComponents(frxDefaultProductPage, [TfrxDBDataset]);
{$IFDEF DELPHI16}
  //GroupDescendentsWith(TfrxDBDataset, TControl);
{$ENDIF}
end;

end.
