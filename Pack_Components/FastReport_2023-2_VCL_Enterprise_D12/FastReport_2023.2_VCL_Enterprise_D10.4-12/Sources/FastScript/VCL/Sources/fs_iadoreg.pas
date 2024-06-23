
{******************************************}
{                                          }
{             FastScript v1.9              }
{            Registration unit             }
{                                          }
{  (c) 2003-2007 by Alexander Tzyganenko,  }
{             Fast Reports Inc             }
{                                          }
{******************************************}

unit fs_iadoreg;

{$i fs.inc}

interface


procedure Register;

implementation

uses
  Classes
{$IFNDEF DELPHI6}
, DsgnIntf
{$ELSE}
, DesignIntf
{$ENDIF}
{$IFDEF DELPHI16}
, Controls
{$ENDIF}
, fs_iadortti, fs_ireg;

{-----------------------------------------------------------------------}

procedure Register;
begin
{$IFDEF DELPHI16}
  //GroupDescendentsWith(TfsADORTTI, TControl);
{$ENDIF}
  RegisterComponents(fsDefaultProductPage, [TfsADORTTI]);
end;

end.
