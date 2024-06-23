
{******************************************}
{                                          }
{              FastReport v6.0             }
{            Outlook Indy Filter           }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxIOTransportOutlookIndy;

interface

{$I frx.inc}

uses
  Classes, Forms, Controls, StdCtrls, ComCtrls, frxIOTransportHelpers,
  frxIOTransportOutlookBase, frxBaseTransportConnection, IdHTTP, IdComponent,
  frxBaseMailApi;

type
{$IFDEF DELPHI16}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxOutlookIOTransportIndy = class(TfrxBaseOutlookIOTransport)
  protected
    function GetListLabels(aFilter: String = ''): String; override;
    function GetListMessages(aFilter: String = ''): String; override;
    function GetListMessagesContinue(NextPageToken: String): String; override;
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

{ TfrxOutlookIOTransport }

function TfrxOutlookIOTransportIndy.GetAccessToken(const AuthorizationCode: String; var ErrorMsg: String): String;
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
  Source.WriteString(frx_Outlook_Scope + '&');
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
      Res := IdHttp.Post(frx_Outlook_GetToken_URL(FfrxTenant), Source);
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

function TfrxOutlookIOTransportIndy.GetConnectorInstance: TfrxBaseTransportConnectionClass;
begin
  Result := TfrxTransportIndyConnectorHTTP;
end;

class function TfrxOutlookIOTransportIndy.GetDescription: String;
begin
  Result :=  '(Indy)' + inherited GetDescription;
end;

function TfrxOutlookIOTransportIndy.GetListLabels(aFilter: String = ''): String;
begin
  Result := TfrxTransportIndyConnectorHTTP(FHTTP).GetIdHTTP.Get(frx_Outlook_ListLabels_URL);
end;

function TfrxOutlookIOTransportIndy.GetListMessages(aFilter: String = ''): String;
begin
  Result := TfrxTransportIndyConnectorHTTP(FHTTP).GetIdHTTP.Get(frx_Outlook_ListMessages_URL(FfrxMessageStack.frxLabel));
end;

function TfrxOutlookIOTransportIndy.GetListMessagesContinue(NextPageToken: String): String;
begin
  Result := TfrxTransportIndyConnectorHTTP(FHTTP).GetIdHTTP.Get(NextPageToken);
end;

function TfrxOutlookIOTransportIndy.GetMessageInfo(id: String; aFilter: String = ''): String;
begin
  Result := TfrxTransportIndyConnectorHTTP(FHTTP).GetIdHTTP.Get(frx_Outlook_ListAttachments_URL(id));
end;

function TfrxOutlookIOTransportIndy.GetListDownloads(frxMessageStack: TfrxMessageStack; Id: String; aFilter: String = ''): String;
begin
  Result := TfrxTransportIndyConnectorHTTP(FHTTP).GetIdHTTP.Get(frx_Outlook_Download_URL(frxMessageStack.frxMessage, ID));
end;

procedure TfrxOutlookIOTransportIndy.TestToken;
begin
  frxTestTokenIndy(frx_Outlook_Test, FAccessToken, False);
end;

procedure TfrxOutlookIOTransportIndy.Upload(const Source: TStream;
  DestFileName: String);
var
  MemoryStream: TMemoryStream;
  IdHTTP: TIdHTTP;
  Code: AnsiString;
begin
  inherited;
  IdHTTP := TfrxTransportIndyConnectorHTTP(FHTTP).GetIdHTTP;
  IdHTTP.Request.ContentType := 'application/json';
{$IfNDef Indy9}
{$IfNDef INDY10_1}
  idHTTP.Request.CharSet:='';
{$EndIf}
{$EndIf}

  Code := PrepareUploadStream(Source, AnsiString(idHTTP.Request.ContentType), DestFileName);

  MemoryStream := TMemoryStream.Create;
  MemoryStream.Write(Code[1], Length(Code));

  try
    IdHTTP.Post(frx_Outlook_Upload_URL, MemoryStream);
  finally
    MemoryStream.Free;
  end;
end;

end.
