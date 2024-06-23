
{******************************************}
{                                          }
{              FastReport v6.0             }
{             GMail Indy Filter            }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxIOTransportGMailIndy;

interface

{$I frx.inc}

uses
  Classes, Forms, Controls, StdCtrls, ComCtrls, frxIOTransportHelpers,
  frxIOTransportGMailBase, frxBaseTransportConnection, IdHTTP, IdComponent,
  frxBaseMailApi;

type
{$IFDEF DELPHI16}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxGMailIOTransportIndy = class(TfrxBaseGMailIOTransport)
  protected
    function GetListLabels(aFilter: String = ''): String; override;
    function GetListMessages(aFilter: String = ''): String; override;
    function GetListMessagesContinue(NextPageToken: String; aFilter: String = ''): String; override;
    function GetMessageInfo(id: String; aFilter: String = ''): String; override;
    function GetListDownloads(frxMessageStack: TfrxMessageStack; Id: String; aFilter: String = ''): String; override;
    procedure Upload(const Source: TStream; DestFileName: String = ''); override;
  public
    function GetConnectorInstance: TfrxBaseTransportConnectionClass; override;
    class function GetDescription: String; override;
    function GetAccessToken(const AuthorizationCode: String; var ErrorMsg: String): String; override;
    procedure TestToken; override;
  end;

implementation

uses
  SysUtils, frxMapHelpers, frxRes, frxJSON, frxTransportIndyConnectorHTTP,
  IdSSLOpenSSL, Variants, StrUtils, IdURI, IdMultipartFormData, frxNetUtils;

type
  TIdHTTPAccess = class(TIdHTTP)
  end;

{ TfrxGMailIOTransport }

function TfrxGMailIOTransportIndy.GetAccessToken(const AuthorizationCode: String; var ErrorMsg: String): String;
var
  IdHTTP: TIdHTTP;
  Source: TStringStream;
  Res: String;
  frxJSON: TfrxJSON;
begin
  Source := TStringStream.Create('');
  Source.WriteString('code=' + AuthorizationCode + '&');
  Source.WriteString('client_id=' + ClientId + '&');
  Source.WriteString('client_secret=' + ClientSecret + '&');
  Source.WriteString('redirect_uri=' + GetRedirectURI + '&');
  Source.WriteString('grant_type=authorization_code');
  try
    IdHttp := TIdHttp.Create(nil);
    try
{$IFDEF Indy9}
      IdHTTP.IOHandler := TIdSSLIOHandlerSocket.Create(IdHTTP);
      TIdSSLIOHandlerSocket(IdHTTP.IOHandler).SSLOptions.Method := sslvTLSv1;
      IdHTTP.Request.CustomHeaders.FoldLength := MaxInt;
{$ELSE}
      IdHTTP.IOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(IdHTTP);
{$ENDIF}
      IdHTTP.Request.BasicAuthentication := False;
      IdHTTP.Request.Accept := 'text/html,application/xhtml+xml,application/xml;q=0.9';
      IdHTTP.Request.ContentType := 'application/x-www-form-urlencoded';
      Res := IdHttp.Post(frx_GMail_GetToken_URL, Source);
      frxJSON := TfrxJSON.Create(Res);
      try
        if frxJSON.IsNameExists('access_token') then
          Result := frxJSON.ValueByName('access_token')
        else if frxJSON.IsNameValueExists('type', 'error') then
          ErrorMsg := 'Error: ' + frxJSON.ValueByName('status') + '; ' +
            frxJSON.ValueByName('message');
      finally
        frxJSON.Free;
      end;
    finally
      IdHttp.Free;
    end;
  finally
    Source.Free;
  end;
end;

function TfrxGMailIOTransportIndy.GetConnectorInstance: TfrxBaseTransportConnectionClass;
begin
  Result := TfrxTransportIndyConnectorHTTP;
end;

class function TfrxGMailIOTransportIndy.GetDescription: String;
begin
  Result :=  '(Indy)' + inherited GetDescription;
end;

function TfrxGMailIOTransportIndy.GetListLabels(aFilter: String = ''): String;
begin
  Result := TfrxTransportIndyConnectorHTTP(FHTTP).GetIdHTTP.Get(frx_GMail_ListLabels_URL);
end;

function TfrxGMailIOTransportIndy.GetListMessages(aFilter: String = ''): String;
begin
  Result := TfrxTransportIndyConnectorHTTP(FHTTP).GetIdHTTP.Get(frx_GMail_ListMessages_URL(FfrxMessageStack.frxLabel));
end;

function TfrxGMailIOTransportIndy.GetListMessagesContinue(NextPageToken: String; aFilter: String = ''): String;
begin
  Result := TfrxTransportIndyConnectorHTTP(FHTTP).GetIdHTTP.Get(
    frx_GMail_ListMessagesContinue_URL(FfrxMessageStack.frxLabel, '', NextPageToken));
end;

function TfrxGMailIOTransportIndy.GetMessageInfo(id: String; aFilter: String = ''): String;
begin
  Result := TfrxTransportIndyConnectorHTTP(FHTTP).GetIdHTTP.Get(frx_GMail_ListAttachments_URL(id));
end;

function TfrxGMailIOTransportIndy.GetListDownloads(frxMessageStack: TfrxMessageStack; Id: String; aFilter: String = ''): String;
begin
  Result := TfrxTransportIndyConnectorHTTP(FHTTP).GetIdHTTP.Get(frx_GMail_Download_URL(frxMessageStack.frxMessage, ID));
end;

procedure TfrxGMailIOTransportIndy.TestToken;
begin
  frxTestTokenIndy(frx_GMail_Test, FAccessToken, False);
end;

procedure TfrxGMailIOTransportIndy.Upload(const Source: TStream;
  DestFileName: String);
const
  Boundary = '560310243403';
var
  MemoryStream: TMemoryStream;
  IdHTTP: TIdHTTP;
  Code: AnsiString;
begin
  inherited;
  IdHTTP := TfrxTransportIndyConnectorHTTP(FHTTP).GetIdHTTP;
  IdHTTP.Request.ContentType :=
    Format('multipart/related; boundary="%s"', [GMailBoundary]);
{$IfNDef Indy9}
{$IfNDef INDY10_1}
  idHTTP.Request.CharSet:='';
{$EndIf}
{$EndIf}

  Code := PrepareUploadStream(Source, AnsiString(idHTTP.Request.ContentType), DestFileName);

  MemoryStream := TMemoryStream.Create;
  MemoryStream.Write(Code[1], Length(Code));

  try
    IdHTTP.Post(frx_GMail_Upload_URL, MemoryStream);
  finally
    MemoryStream.Free;
  end;
end;

end.
