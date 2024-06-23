
{******************************************}
{                                          }
{              FastReport v6.0             }
{             GMail Save Filter            }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxIOTransportGMail;

interface

{$I frx.inc}

uses
  Classes, frxIOTransportHelpers, frxBaseTransportConnection,
  frxIOTransportGMailBase, frxProtocolFactory, frxBaseMailApi;

type
{$IFDEF DELPHI16}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxGMailIOTransport = class(TfrxBaseGMailIOTransport)
  protected
    function GetListLabels(aFilter: String = ''): String; override;
    function GetListMessages(aFilter: String = ''): String; override;
    function GetListMessagesContinue(NextPageToken: String; aFilter: String = ''): String; override;
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

{ TfrxGMailIOTransport }

function TfrxGMailIOTransport.GetAccessToken(const AuthorizationCode: String; var ErrorMsg: String): String;
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
  Source.WriteString('grant_type=authorization_code');
  try
    tHTTP := TfrxTransportHTTP.Create(nil);
    try
      if BlockedType then
        tHTTP.SocketType := fstBlocking;
      tHTTP.HTTPRequest.Encoding := '';
      tHTTP.HTTPRequest.DefAcceptTypes := htcDefaultXML;
      tHTTP.HTTPRequest.ContentType := 'application/x-www-form-urlencoded';
      Res := UTF8Decode(tHTTP.Post(AnsiString(frx_GMail_GetToken_URL), Source));
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

function TfrxGMailIOTransport.GetConnectorInstance: TfrxBaseTransportConnectionClass;
begin
  Result := TfrxTransportHTTP;
end;

function TfrxGMailIOTransport.GetListLabels(aFilter: String = ''): String;
begin
  Result := UTF8Decode(TfrxTransportHTTP(FHTTP).Get(AnsiString(frx_GMail_ListLabels_URL)));
end;

function TfrxGMailIOTransport.GetListMessages(aFilter: String): String;
begin
  Result := UTF8Decode(TfrxTransportHTTP(FHTTP).Get(AnsiString(frx_GMail_ListMessages_URL(FfrxMessageStack.frxLabel))));
end;

function TfrxGMailIOTransport.GetListMessagesContinue(NextPageToken: String; aFilter: String): String;
begin
  Result := UTF8Decode(TfrxTransportHTTP(FHTTP).Get(
    AnsiString(frx_GMail_ListMessagesContinue_URL(FfrxMessageStack.frxLabel, '', NextPageToken))));
end;

function TfrxGMailIOTransport.GetMessageInfo(id: String; aFilter: String = ''): String;
begin
  Result := UTF8Decode(TfrxTransportHTTP(FHTTP).Get(AnsiString(frx_GMail_ListAttachments_URL(id))));
end;

function TfrxGMailIOTransport.GetListDownloads(frxMessageStack: TfrxMessageStack; Id: String; aFilter: String = ''): String;
begin
  Result := UTF8Decode(TfrxTransportHTTP(FHTTP).Get(AnsiString(frx_GMail_Download_URL(frxMessageStack.frxMessage, ID))));
end;

procedure TfrxGMailIOTransport.TestToken;
begin
  frxTestToken(frx_GMail_Test, FAccessToken, False);
end;

procedure TfrxGMailIOTransport.Upload(const Source: TStream;
  DestFileName: String);
var
  MemoryStream: TMemoryStream;
  tHTTP: TfrxTransportHTTP;
  Code: AnsiString;
begin
  inherited;
  tHTTP := TfrxTransportHTTP(FHTTP);
  tHTTP.HTTPRequest.ContentType :=
    AnsiString(Format('multipart/related; boundary="%s"', [GMailBoundary]));
  tHTTP.HTTPRequest.Encoding:='';

  Code := PrepareUploadStream(Source, tHTTP.HTTPRequest.ContentType, DestFileName);

  MemoryStream := TMemoryStream.Create;
  MemoryStream.Write(Code[1], Length(Code));

  try
    tHTTP.Post(frx_GMail_Upload_URL, MemoryStream);
  finally
    MemoryStream.Free;
  end;
end;

end.
