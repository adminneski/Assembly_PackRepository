
{******************************************}
{                                          }
{              FastReport v6.0             }
{            Dropbox Save Filter           }
{                                          }
{         Copyright (c) 1998-2021          }
{                                          }
{******************************************}

unit frxIOTransportDropbox;

interface

{$I frx.inc}

uses
  Classes, frxIOTransportDropboxBase, frxIOTransportHelpers,
  frxBaseTransportConnection;

type
{$IFDEF DELPHI16}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxDropboxIOTransport = class(TfrxBaseDropboxIOTransport)
  protected
    function FolderAPI(const URL, Source: String): String; override;
    procedure Upload(const Source: TStream; DestFileName: String = ''); override;
    procedure Download(const SourceFileName: String; const Source: TStream); override;
  public
    function GetAccessToken(const AuthorizationCode: String; var ErrorMsg: String): String; override;
    function GetConnectorInstance: TfrxBaseTransportConnectionClass; override;
    procedure TestToken; override;
  end;

implementation

uses
  SysUtils,
  frHashUtils, frxJSON, frxTransportHTTP, frxNetUtils;

{ TfrxDropboxIOTransport }

procedure TfrxDropboxIOTransport.Download(const SourceFileName: String;
  const Source: TStream);
var
  FileName: String;
  THTTP: TfrxTransportHTTP;
begin
  inherited;
  THTTP := TfrxTransportHTTP(FHTTP);
  FileName := RemoteDir + SourceFileName;
  if (Length(FileName) > 0) and (FileName[1] <> '/') then
    FileName := '/' + FileName;
  THTTP.HTTPRequest.Encoding := '';
  THTTP.HTTPRequest.DefAcceptTypes := htcDefaultXML;
  THTTP.HTTPRequest.ContentType := '';
  THTTP.HTTPRequest.CustomHeader.Add('Dropbox-API-Arg: ' + Format('{ "path": "%s"}',
        {$IfDef DELPHI12}[JsonEncode(FileName)]));
        {$Else}          [AnsiToUtf8(FileName)]));
        {$EndIf}
  try
    THTTP.Get(FRX_DBOX_DL_URL, Source);
    if THTTP.Errors.Count > 0 then
      raise Exception.Create(THTTP.Errors.Text);
  finally
    THTTP.HTTPRequest.CustomHeader.Clear;
  end;
end;

function TfrxDropboxIOTransport.FolderAPI(const URL, Source: String): String;
var
  Stream: TStringStream;
  THTTP: TfrxTransportHTTP;
begin
  THTTP := TfrxTransportHTTP(FHTTP);
  THTTP.HTTPRequest.ContentType := 'application/json';
  THTTP.HTTPRequest.Encoding := 'UTF-8';
  Stream := TStringStream.Create(Source{$IfDef DELPHI12}, TEncoding.UTF8{$EndIf});
  try
    Result := THTTP.Post(URL, Stream);
    if THTTP.Errors.Count > 0 then
      raise Exception.Create(THTTP.Errors.Text);
  finally
    Stream.Free;
  end;
end;

function TfrxDropboxIOTransport.GetAccessToken(const AuthorizationCode: String; var ErrorMsg: String): String;
var
  tHTTP: TfrxTransportHTTP;
  Source: TStringStream;
  Res: String;
  frxJSON: TfrxJSON;
begin
  Source := TStringStream.Create('');
  Source.WriteString('code=' + AuthorizationCode + '&');
  Source.WriteString('grant_type=authorization_code&');
  Source.WriteString('redirect_uri=' + GetRedirectURI);

  try
    tHTTP := TfrxTransportHTTP.Create(nil);
    try
      if BlockedType then
        tHTTP.SocketType := fstBlocking;
      tHTTP.HTTPRequest.Encoding := '';
      tHTTP.HTTPRequest.DefAcceptTypes := htcDefaultXML;
      tHTTP.HTTPRequest.Authorization := 'Basic ' + frBase64Encode(AnsiString(ClientId + ':' + ClientSecret));
      tHTTP.HTTPRequest.ContentType := 'application/x-www-form-urlencoded';
      Res := tHTTP.Post('https://api.dropboxapi.com/oauth2/token', Source);
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

function TfrxDropboxIOTransport.GetConnectorInstance: TfrxBaseTransportConnectionClass;
begin
  Result := TfrxTransportHTTP;
end;

procedure TfrxDropboxIOTransport.TestToken;
begin
  frxTestToken('https://api.dropboxapi.com/2/users/get_space_usage', FAccessToken, True);
end;

procedure TfrxDropboxIOTransport.Upload(const Source: TStream;
  DestFileName: String);
var
  Res: String;
  FileName: String;
  THTTP: TfrxTransportHTTP;
begin
  inherited;
  FileName := RemoteDir + DestFileName;
  if (Length(FileName) > 0) and (FileName[1] <> '/') then
    FileName := '/' + FileName;

  THTTP := TfrxTransportHTTP(FHTTP);
  THTTP.HTTPRequest.ContentType := 'application/octet-stream';
  THTTP.HTTPRequest.Encoding := '';
  try
    THTTP.HTTPRequest.CustomHeader.Add('Dropbox-API-Arg: ' +
      Format('{ "path": "%s", "mode": "overwrite"}',
        {$IfDef DELPHI12}[JsonEncode(FileName)]));
        {$Else}          [AnsiToUtf8(FileName)]));
        {$EndIf}
    Res := THTTP.Post(FRX_DBOX_UL_URL, Source);
    if THTTP.Errors.Count > 0 then
      raise Exception.Create(THTTP.Errors.Text);
  finally
    THTTP.HTTPRequest.CustomHeader.Clear;
  end;
end;

end.
