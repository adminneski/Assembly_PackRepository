
{******************************************}
{                                          }
{             FastReport VCL               }
{            Registration unit             }
{                                          }
{         Copyright (c) 1998-2014          }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit frxRegHTML;

{$I frx.inc}
{$R frxHTMLReg.dcr} //Repacked Version Line added
interface


procedure Register;

implementation

uses
{$IFNDEF FPC}
  Windows,
{$ENDIF}
  Messages, SysUtils, Classes, Forms, Controls, frxReg,
{$IFNDEF DELPHI6}
  DsgnIntf,
{$ELSE}
 {$IFNDEF FPC}
  DesignIntf, DesignEditors,
 {$ENDIF}
{$ENDIF}
  frxHTML,
  frxHTMLViewer,
  frxHTMLEditor,
  frxHTMLRTTI;


{-----------------------------------------------------------------------}
procedure Register;
begin
  RegisterComponents(frxDefaultProductPage + ' HTMLView Components', [TfrxHTMLObject]);
end;

end.
