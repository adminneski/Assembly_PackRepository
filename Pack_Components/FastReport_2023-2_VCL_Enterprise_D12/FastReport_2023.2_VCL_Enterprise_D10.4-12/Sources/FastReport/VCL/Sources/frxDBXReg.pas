
{******************************************}
{                                          }
{             FastReport VCL               }
{       DBX components registration        }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxDBXReg;

interface

{$I frx.inc}
{$R *.dcr}  //Repacked Version Line added
procedure Register;

implementation

uses
  Windows, Messages, SysUtils, Classes, Controls, frxReg
{$IFNDEF DELPHI6}
, DsgnIntf
{$ELSE}
, DesignIntf, DesignEditors
{$ENDIF}
, frxDBXComponents;

procedure Register;
begin
  RegisterComponents(frxDefaultProductPage, [TfrxDBXComponents]);
{$IFDEF DELPHI16}
  //StartClassGroup(TControl);
  //ActivateClassGroup(TControl);
  //GroupDescendentsWith(TfrxDBXComponents, TControl);
{$ENDIF}
end;

end.
