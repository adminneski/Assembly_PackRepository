
{******************************************}
{                                          }
{             FastScript v1.9              }
{            Registration unit             }
{                                          }
{  (c) 2003-2007 by Alexander Tzyganenko,  }
{             Fast Reports Inc             }
{                                          }
{******************************************}

unit fs_iibxreg;

{$i fs.inc}

interface


procedure Register;

implementation

uses
  Classes
{$IFNDEF FPC}
  {$IFNDEF DELPHI6}
, DsgnIntf
{$ELSE}
{$IFDEF DELPHI16}
, Controls
{$ENDIF}
, DesignIntf
{$ENDIF}
{$ELSE}
,PropEdits, LazarusPackageIntf, LResources
{$ENDIF}
, fs_iibxrtti, fs_ireg;




{-----------------------------------------------------------------------}

procedure Register;
begin
{$IFDEF DELPHI16}
  //GroupDescendentsWith(TfsIBXRTTI, TControl);
{$ENDIF}
    RegisterComponents(fsDefaultProductPage, [TfsIBXRTTI]);
end;

initialization
{$IFDEF FPC}
  {$INCLUDE fs_ireg.lrs}
{$ENDIF}


end.
