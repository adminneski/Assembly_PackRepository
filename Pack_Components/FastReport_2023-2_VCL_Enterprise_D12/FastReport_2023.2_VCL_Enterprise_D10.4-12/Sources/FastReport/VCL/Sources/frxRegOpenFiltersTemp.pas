{******************************************}
{                                          }
{             FastReport VCL               }
{            Registration unit             }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxRegOpenFiltersTemp;

{$I frx.inc}
{$R *.dcr}  //Repacked Version Line added
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
  frxOpenFilterQR, frxOpenFilterRB;

procedure Register;
begin
  RegisterComponents(frxDefaultProductPage + ' Open Filters Template',
    [TfrxOpenFilterQR, TfrxOpenFilterRB]);
end;

end.
