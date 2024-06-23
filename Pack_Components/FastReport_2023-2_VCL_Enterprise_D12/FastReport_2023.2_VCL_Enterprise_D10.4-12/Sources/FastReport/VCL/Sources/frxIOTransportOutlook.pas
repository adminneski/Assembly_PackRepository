
{******************************************}
{                                          }
{              FastReport v6.0             }
{            Outlook Save Filter           }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxIOTransportOutlook;

interface

{$I frx.inc}

uses
  Classes, frxIOTransportHelpers, frxBaseTransportConnection,
  frxIOTransportOutlookBase, frxProtocolFactory, frxBaseMailApi;

type
{$IFDEF DELPHI16}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxOutlookIOTransport = class(TfrxBaseOutlookIOTransport)
  protected
    function GetListLabels(aFilter: String = ''): String; override;
    function GetListMessages(aFilter: String = ''): String; override;
    function GetListMessagesContinue(NextPageToken: String): String; override;
    function GetMessageInfo(id: String; aFilter: String = ''): String; override;
    function GetListDownloads(frxMessageStack: TfrxMessageStack; Id: String; aFilter: String = ''): String; override;
    procedure Upload(const Source: TStream; DestFileName: String = ''); override;
  public
    function GetAccessToken(const AuthorizationCode: String; var ErrorMsg: String): String; override;
    function GetConnectorInstance: TfrxBaseTransportConnectionClass; override;
    procedure TestToken; override;
  end;

implementation

uses
  SysUtils, frxJSON, frxTransportHTTP, frxNetUtils, frxUtils;

{ TfrxOutlookIOTransport }

function TfrxOutlookIOTransport.GetAccessToken(const AuthorizationCode: String; var ErrorMsg: String): String;
var
  tHTTP: TfrxTransportHTTP;
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
    tHTTP := TfrxTransportHTTP.Create(nil);
    try
      if BlockedType then
        tHTTP.SocketType := fstBlocking;
      tHTTP.HTTPRequest.Encoding := '';
      tHTTP.HTTPRequest.DefAcceptTypes := htcDefaultXML;
      tHTTP.HTTPRequest.ContentType := 'application/x-www-form-urlencoded';
      Res := UTF8Decode(tHTTP.Post(AnsiString(frx_Outlook_GetToken_URL(FfrxTenant)), Source));
      if Res = '' then
      begin
        ErrorMsg := 'Error: Not connected';
        Exit;
      end;
      frxJSON := TfrxJSON.Create(Res);
      try
        if frxJSON.IsNameExists('access_token') then
          Result := frxJSON.ValueByName('access_token')
        else if frxJSON.IsNameValueExists('type', 'error') then
          ErrorMsg := 'Error: ' + frxJSON.ValueByName('status') + '; ' +
            frxJSON.ValueByName('message')
        else
          ErrorMsg := 'Error: Answer code: ' + IntToStr(tHTTP.ServerFields.AnswerCode) + ' Result: ' + Res;
      finally
        frxJSON.Free;
      end;
    finally
      tHTTP.Free;
    end;
  finally
    Source.Free;
  end;
end;

function TfrxOutlookIOTransport.GetConnectorInstance: TfrxBaseTransportConnectionClass;
begin
  Result := TfrxTransportHTTP;
end;

function TfrxOutlookIOTransport.GetListLabels(aFilter: String = ''): String;
begin
  Result := UTF8Decode(TfrxTransportHTTP(FHTTP).Get(AnsiString(frx_Outlook_ListLabels_URL)));
end;

function TfrxOutlookIOTransport.GetListMessages(aFilter: String): String;
begin
  Result := UTF8Decode(TfrxTransportHTTP(FHTTP).Get(AnsiString(frx_Outlook_ListMessages_URL(FfrxMessageStack.frxLabel))));
end;

function TfrxOutlookIOTransport.GetListMessagesContinue(NextPageToken: String): String;
begin
  Result := UTF8Decode(TfrxTransportHTTP(FHTTP).Get(AnsiString(NextPageToken)));
end;

function TfrxOutlookIOTransport.GetMessageInfo(id: String; aFilter: String = ''): String;
begin
  Result := UTF8Decode(TfrxTransportHTTP(FHTTP).Get(AnsiString(frx_Outlook_ListAttachments_URL(id))));
end;

function TfrxOutlookIOTransport.GetListDownloads(frxMessageStack: TfrxMessageStack; Id: String; aFilter: String = ''): String;
begin
  Result := UTF8Decode(TfrxTransportHTTP(FHTTP).Get(AnsiString(frx_Outlook_Download_URL(frxMessageStack.frxMessage, ID))));
end;

procedure TfrxOutlookIOTransport.TestToken;
begin
  frxTestToken(frx_Outlook_Test, FAccessToken, False);
end;

procedure TfrxOutlookIOTransport.Upload(const Source: TStream;
  DestFileName: String);
var
  MemoryStream: TMemoryStream;
  tHTTP: TfrxTransportHTTP;
  Code: AnsiString;
begin
  inherited;
  tHTTP := TfrxTransportHTTP(FHTTP);
  tHTTP.HTTPRequest.ContentType := AnsiString('application/json');
  tHTTP.HTTPRequest.Encoding:='';

  Code := PrepareUploadStream(Source, tHTTP.HTTPRequest.ContentType, DestFileName);

  MemoryStream := TMemoryStream.Create;
  MemoryStream.Write(Code[1], Length(Code));

  try
    tHTTP.Post(frx_Outlook_Upload_URL, MemoryStream);
  finally
    MemoryStream.Free;
  end;
end;

end.
