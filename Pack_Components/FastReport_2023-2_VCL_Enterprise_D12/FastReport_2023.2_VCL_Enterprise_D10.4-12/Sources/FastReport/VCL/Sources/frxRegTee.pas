
{******************************************}
{                                          }
{             FastReport VCL               }
{            Registration unit             }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxRegTee;

{$I frx.inc}

interface


procedure Register;

implementation

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, frxReg,
{$IFNDEF DELPHI6}
  DsgnIntf,
{$ELSE}
  DesignIntf, DesignEditors,
{$ENDIF}
  frxChart;


procedure Register;
begin
  RegisterComponents(frxDefaultProductPage, [TfrxChartObject]);
{$IFDEF DELPHI16}
  //GroupDescendentsWith(TfrxChartObject, TControl);
{$ENDIF}
end;

end.
