
{******************************************}
{                                          }
{             FastScript v1.9              }
{            Registration unit             }
{                                          }
{  (c) 2003-2007 by Alexander Tzyganenko,  }
{             Fast Reports Inc             }
{                                          }
{******************************************}

unit fs_ibdereg;

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
, fs_ibdertti, fs_ireg;

{-----------------------------------------------------------------------}

procedure Register;
begin
{$IFDEF DELPHI16}
  //GroupDescendentsWith(TfsBDERTTI, TControl);
{$ENDIF}
  RegisterComponents(fsDefaultProductPage, [TfsBDERTTI]);
end;

end.
