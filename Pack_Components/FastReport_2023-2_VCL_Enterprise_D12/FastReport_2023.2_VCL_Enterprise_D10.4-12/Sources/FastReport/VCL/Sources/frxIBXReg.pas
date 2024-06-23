
{******************************************}
{                                          }
{             FastReport VCL               }
{       IBX components registration        }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxIBXReg;

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
  frxIBXComponents;

procedure Register;
begin
  RegisterComponents(frxDefaultProductPage, [TfrxIBXComponents]);
{$IFDEF DELPHI16}
//  GroupDescendentsWith(TfrxIBXComponents, TControl);
{$ENDIF}
end;

end.
