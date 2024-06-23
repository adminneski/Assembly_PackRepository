
{******************************************}
{                                          }
{              FastReport v6.0             }
{          Dropbox(Indy) Save Filter       }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxIOTransportDropboxIndy;

interface

{$I frx.inc}

uses
  Classes, frxIOTransportDropboxBase, frxIOTransportHelpers,
  frxBaseTransportConnection, IdHTTP, IdComponent;

type
{$IFDEF DELPHI16}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxDropboxIOTransportIndy = class(TfrxBaseDropboxIOTransport)
  protected
    function FolderAPI(const URL, Source: String): String; override;
    procedure Upload(const Source: TStream; DestFileName: String = ''); override;
    procedure Download(const SourceFileName: String; const Source: TStream); override;
  public
    function GetConnectorInstance: TfrxBaseTransportConnectionClass; override;
    class function GetDescription: String; override;
    function GetAccessToken(const AuthorizationCode: String; var ErrorMsg: String): String; override;
    procedure TestToken; override;
  end;

implementation

uses
  SysUtils,
  frHashUtils,
  frxMapHelpers, frxRes, frxJSON, frxTransportIndyConnectorHTTP,
  IdSSLOpenSSL, Variants, StrUtils, frxNetUtils;

{ TfrxDropboxIOTransport }

procedure TfrxDropboxIOTransportIndy.Download(const SourceFileName: String;
  const Source: TStream);
var
  FileName: String;
  IdHTTP: TIdHTTP;
begin
  inherited;
  IdHTTP := TfrxTransportIndyConnectorHTTP(FHTTP).GetIdHTTP;
  IdHTTP.Request.ContentType := '';
{$IfNDef Indy9}
{$IfNDef INDY10_1}
  IdHTTP.Request.CharSet:='';
{$EndIf}
{$EndIf}
  FileName := RemoteDir + SourceFileName;
  if (Length(FileName) > 0) and (FileName[1] <> '/') then
    FileName := '/' + FileName;
  try
    IdHTTP.Request.CustomHeaders.Values['Dropbox-API-Arg'] :=
      Format('{ "path": "%s"}',
        {$IfDef DELPHI12}[JsonEncode(FileName)]);
        {$Else}          [AnsiToUtf8(FileName)]);
        {$EndIf}
   IdHTTP.Get(FRX_DBOX_DL_URL, Source);
  finally
  end;
end;

function TfrxDropboxIOTransportIndy.FolderAPI(const URL, Source: String): String;
var
  Stream: TStringStream;
  IdHTTP: TIdHTTP;
begin
  IdHTTP := TfrxTransportIndyConnectorHTTP(FHTTP).GetIdHTTP;
  IdHTTP.Request.ContentType := 'application/json';
{$IfNDef Indy9}
{$IfNDef INDY10_1}
  IdHTTP.Request.CharSet:='UTF-8';
{$EndIf}
{$EndIf}

  Stream := TStringStream.Create(Source{$IfDef DELPHI12}, TEncoding.UTF8{$EndIf});
  try
    Result := IdHTTP.Post(URL, Stream);
  finally
    Stream.Free;
  end;
end;

function TfrxDropboxIOTransportIndy.GetAccessToken(
  const AuthorizationCode: String; var ErrorMsg: String): String;
var
  tHTTP: TfrxTransportIndyConnectorHTTP;
  Source: TStringStream;
  Res: String;
  frxJSON: TfrxJSON;
begin
  Source := TStringStream.Create('');
  Source.WriteString('code=' + AuthorizationCode + '&');
  Source.WriteString('grant_type=authorization_code&');
  Source.WriteString('redirect_uri=' + GetRedirectURI);

  try
    tHTTP := TfrxTransportIndyConnectorHTTP.Create(nil);
    try
      if BlockedType then
        tHTTP.SocketType := fstBlocking;

      tHTTP.GetIdHTTP.Request.ContentType := 'application/x-www-form-urlencoded';
{$IfNDef Indy9}
{$IfNDef INDY10_1}
      tHTTP.GetIdHTTP.Request.CharSet:='';
{$EndIf}
{$EndIf}
      tHTTP.GetIdHTTP.Request.CustomHeaders.Values['Authorization'] := 'Basic ' + String(frBase64Encode(AnsiString(ClientId + ':' + ClientSecret)));
      tHTTP.GetIdHTTP.Request.BasicAuthentication := False;
      Res := tHTTP.GetIdHTTP.Post('https://api.dropboxapi.com/oauth2/token', Source);
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
          ErrorMsg := 'Error: Answer code: ' + IntToStr(tHTTP.GetIdHTTP.ResponseCode) + ' Result: ' + Res;
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

function TfrxDropboxIOTransportIndy.GetConnectorInstance: TfrxBaseTransportConnectionClass;
begin
  Result := TfrxTransportIndyConnectorHTTP;
end;

class function TfrxDropboxIOTransportIndy.GetDescription: String;
begin
  Result :=  '(Indy)' + inherited GetDescription;
end;

procedure TfrxDropboxIOTransportIndy.TestToken;
begin
  frxTestTokenIndy('https://api.dropboxapi.com/2/users/get_space_usage', FAccessToken, True);
end;

procedure TfrxDropboxIOTransportIndy.Upload(const Source: TStream;
  DestFileName: String);
var
  Res: String;
  FileName: String;
  IdHTTP: TIdHTTP;
begin
  inherited;
  IdHTTP := TfrxTransportIndyConnectorHTTP(FHTTP).GetIdHTTP;
  IdHTTP.Request.ContentType := 'application/octet-stream';
{$IfNDef Indy9}
{$IfNDef INDY10_1}
  IdHTTP.Request.CharSet:='';
{$EndIf}
{$EndIf}

  FileName := RemoteDir + DestFileName;
  if (Length(FileName) > 0) and (FileName[1] <> '/') then
    FileName := '/' + FileName;
  IdHTTP.Request.CustomHeaders.Values['Dropbox-API-Arg'] :=
      Format('{ "path": "%s", "mode": "overwrite"}',
        {$IfDef DELPHI12}[JsonEncode(FileName)]);
        {$Else}          [AnsiToUtf8(FileName)]);
        {$EndIf}
  Res := IdHTTP.Post(FRX_DBOX_UL_URL, Source);
end;

end.
