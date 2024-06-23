
{******************************************}
{                                          }
{             FastReport VCL               }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxHTTPProtocol;

interface

{$I frx.inc}

uses
  SysUtils, Classes, SyncObjs, frxProtocolFactory, frxBaseSocketIOHandler;

type
  TfrxHTTPDatalinkProtocol = class(TfrxCustomDatalinkProtocol)
  protected
    class function GetIOHandlerClass: TfrxCustomIOHandlerClass; virtual;
  public
    class function LoadBy(var Link: String; Stream: TStream; BoundData: TObject = nil): Boolean; override;
  end;

implementation
uses frxBaseTransportConnection, frxTransportHTTP;

{ TfrxHTTPDatalinkProtocol }

class function TfrxHTTPDatalinkProtocol.GetIOHandlerClass: TfrxCustomIOHandlerClass;
begin
  Result := frxHTTPSocketIOHandlerClass;
end;

const
  REDIR_TRIES = 10;

class function TfrxHTTPDatalinkProtocol.LoadBy(var Link: String;
  Stream: TStream; BoundData: TObject): Boolean;
var
  tHttp: TfrxTransportHTTP;
  Res: AnsiString;
  MemTmp: TMemoryStream;
  iPos, rTry: Integer;
  sLink: AnsiString;
begin
  tHttp := TfrxTransportHTTP.Create(nil);
  tHttp.HandleOnlySocketMessages := True;
  tHttp.SocketType := fstBlocking;
  MemTmp := TMemoryStream.Create;
  iPos := Stream.Position;
  rTry := 0;
  try
    tHttp.HTTPRequest.DefAcceptTypes := htcDefaultApp;
    tHttp.IOHandler := GetIOHandlerClass.Create;
    tHttp.TimeOut := 20;
    tHttp.RetryCount := 3;
    sLink := AnsiString(Link);
    Res := tHttp.Get(sLink, Stream);
    while (tHttp.ServerFields.AnswerCode = 301) and (rTry < REDIR_TRIES) do
    begin
      Stream.Size := 0;
      if Pos('//', tHttp.ServerFields.Location) > 0 then
        sLink := AnsiString(tHttp.ServerFields.Location)
      else
        sLink := sLink + AnsiString(tHttp.ServerFields.Location);
      Res := tHttp.Get(sLink, Stream);
      //frxDataProtocols.LoadByLink(sLink, Stream);
      Inc(rTry);
    end;
  finally
    Result := (Stream.Size - iPos > 0) and (tHttp.Errors.Count = 0);
    Link := String(sLink);
    tHttp.Free;
    MemTmp.Free;
  end;
end;

initialization
  frxDataProtocols.Register(TfrxHTTPDatalinkProtocol, 'http');

finalization
  frxDataProtocols.Unregister('http');

end.

