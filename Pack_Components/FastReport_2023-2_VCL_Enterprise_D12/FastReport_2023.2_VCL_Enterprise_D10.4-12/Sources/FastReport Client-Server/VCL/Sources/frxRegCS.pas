
{******************************************}
{                                          }
{             FastReport VCL               }
{            Registration unit             }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxRegCS;

{$I frx.inc}

{$IFDEF FPC}
{$R 'frxRegCS.dcr'}
{$ELSE}        //Repacked Version Line added
{$R *.dcr}     //Repacked Version Line added
{$ENDIF}

interface

procedure Register;

implementation

uses
  {$IFNDEF Linux}
  Windows,
  {$ENDIF}
  Messages, SysUtils, Classes, Graphics, Controls, Forms, frxReg,
{$IFNDEF DELPHI6}
  DsgnIntf,
{$ELSE}
{$IFNDEF FPC}
  DesignIntf, DesignEditors,
{$ENDIF}
{$ENDIF}
  frxServer, frxServerClient, frxHTTPClient;

{-----------------------------------------------------------------------}
procedure Register;
begin
  RegisterComponents(frxDefaultProductPage + ' Client/Server',
    [TfrxReportServer, TfrxServerConnection, TfrxReportClient,
    TfrxHTTPClient]);
end;

end.
