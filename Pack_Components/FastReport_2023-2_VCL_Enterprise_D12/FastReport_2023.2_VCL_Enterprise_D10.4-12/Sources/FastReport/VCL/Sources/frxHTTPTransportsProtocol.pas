
{******************************************}
{                                          }
{             FastReport VCL               }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxHTTPTransportsProtocol;

interface

{$I frx.inc}

uses
  SysUtils, Classes, SyncObjs, frxProtocolFactory;

type
  TfrxHTTPTransportsDatalinkProtocol = class(TfrxCustomDatalinkProtocol)
  public
    class function LoadBy(var Link: String; Stream: TStream; BoundData: TObject = nil): Boolean; override;
  end;

implementation
uses frxIOTransportHelpers, frxClass;

{ TfrxHTTPDatalinkProtocol }

const
  REDIR_TRIES = 10;

class function TfrxHTTPTransportsDatalinkProtocol.LoadBy(var Link: String;
  Stream: TStream; BoundData: TObject): Boolean;
var
  Lio: TfrxHTTPIOTransport;
  sLink: String;
  i: Integer;
begin
  Result := False;
  if not Assigned(BoundData) then Exit;
  Lio := TfrxHTTPIOTransport(BoundData.NewInstance);
  Lio.CreateNoRegister;
  Lio.AssignSharedProperties(TfrxHTTPIOTransport(BoundData));
  Lio.ShowProgress := False;
  Lio.ShowDialog := False;
  Lio.FilterAccess := faRead;
  Lio.BlockedType := True;
  try
    if Lio.OpenFilter then
    begin
      i := Pos('//', Link) + 2;
      sLink := Copy(Link, i, Length(link) - (i - 1));
      Lio.DownloadToStream(sLink, Stream);
    end;
  finally
    Result := (Stream.Size > 0);
    Lio.Free;
  end;
end;

end.

