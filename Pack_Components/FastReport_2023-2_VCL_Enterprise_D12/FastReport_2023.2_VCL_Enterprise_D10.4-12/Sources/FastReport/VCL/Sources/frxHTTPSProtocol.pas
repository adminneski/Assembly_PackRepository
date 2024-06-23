
{******************************************}
{                                          }
{             FastReport VCL               }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxHTTPSProtocol;

interface

{$I frx.inc}

uses
  SysUtils, Classes, SyncObjs, frxBaseSocketIOHandler, frxProtocolFactory, frxHTTPProtocol;

type
  TfrxHTTPSDataLinkProtocol = class(TfrxHTTPDatalinkProtocol)
  protected
    class function GetIOHandlerClass: TfrxCustomIOHandlerClass; override;
  end;

implementation

{ TfrxHTTPDatalinkProtocol }

class function TfrxHTTPSDataLinkProtocol.GetIOHandlerClass: TfrxCustomIOHandlerClass;
begin
  Result := frxHTTPSSocketIOHandlerClass;
end;

initialization
  frxDataProtocols.Register(TfrxHTTPSDataLinkProtocol, 'https');

finalization
  frxDataProtocols.Unregister('https');

end.

