
{******************************************}
{                                          }
{             FastReport VCL               }
{       ADO components registration        }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxADOReg;

interface

{$I frx.inc}
{$R *.dcr} //Repacked Version Line added
procedure Register;

implementation

uses
  Windows, Messages, SysUtils, Classes, Controls, frxReg
{$IFNDEF DELPHI6}
, DsgnIntf
{$ELSE}
, DesignIntf, DesignEditors
{$ENDIF}
, frxADOComponents;

procedure Register;
begin
  RegisterComponents(frxDefaultProductPage, [TfrxADOComponents]);
{$IFDEF DELPHI16}
//  GroupDescendentsWith(TfrxADOComponents, TControl);
{$ENDIF}
end;

end.
