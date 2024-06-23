
{******************************************}
{                                          }
{             FastReport VCL               }
{       BDE components registration        }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxBDEReg;

interface

{$I frx.inc}
{$R *.dcr} //Repacked Version Line added
procedure Register;

implementation

uses
  Windows, Messages, SysUtils, Classes, Controls, frxReg,
{$IFNDEF DELPHI6}
  DsgnIntf,
{$ELSE}
  DesignIntf, DesignEditors,
{$ENDIF}
  frxBDEComponents;

procedure Register;
begin
  RegisterComponents(frxDefaultProductPage, [TfrxBDEComponents]);
{$IFDEF DELPHI16}
//  GroupDescendentsWith(TfrxBDEComponents, TControl);
{$ENDIF}
end;

end.
