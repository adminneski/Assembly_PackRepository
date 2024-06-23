
{******************************************}
{                                          }
{              FastReport v6.0             }
{          YandexDisk Save Filter          }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxIOTransportYandexDiskIndy;

interface

{$I frx.inc}

uses
  Classes, Forms, Controls, StdCtrls, ComCtrls,
  frxIOTransportHelpers, frxIOTransportYandexDiskBase,
  frxBaseTransportConnection, IdHTTP, IdComponent, frxTransportIndyConnectorHTTP;

type
{$IFDEF DELPHI16}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxYandexDiskIOTransportIndy = class(TfrxBaseYandexDiskIOTransport)
  protected
    function GetListFolder: String; override;
    function GetListFolderContinue(Offset: String): String; override;
    procedure CreateFolder(Dir: String); override;
    procedure DeleteFileOrFolder(const Id: String); override;
    procedure Upload(const Source: TStream; DestFileName: String = ''); override;
    procedure Download(const SourceFileName: String; const Source: TStream); override;
  public
    function GetConnectorInstance: TfrxBaseTransportConnectionClass; override;
    class function GetDescription: String; override;
    function GetAccessToken(const AuthorizationCode: String; var ErrorMsg: String): String; override;
    procedure TestToken; override;
  end;

  TfrxYandexDiskTransportIndyHTTP = class(TfrxTransportIndyConnectorHTTP)
  public
    procedure SetDefaultParametersWithToken(AToken: String); override;
  end;

implementation

uses
  SysUtils, frxMapHelpers, frxRes, frxJSON, IdSSLOpenSSL, Variants, StrUtils,
  IdURI, IdMultipartFormData, frxServerUtils;

type
  TIdHTTPAccess = class(TIdHTTP)
  end;

{ TfrxYandexDiskIOTransport }

procedure TfrxYandexDiskIOTransportIndy.CreateFolder(Dir: String);
begin
  TfrxTransportIndyConnectorHTTP(FHTTP).GetIdHTTP.Put(
    Format(frx_YandexDisk_CreateDir_URL,[Str2HTML(UTF8Encode(FDirStack.Full + Dir))]), nil);
end;

procedure TfrxYandexDiskIOTransportIndy.DeleteFileOrFolder(const Id: String);
begin
// Indy 10.0 don't have TIdHTTP.Delete, Indy 10.6 have it
//  FHTTP.Delete(Format(URL, [Id]));
{$IfNDef Indy9}
{$IfNDef INDY10_1}
  TIdHTTPAccess(TfrxTransportIndyConnectorHTTP(FHTTP).GetIdHTTP)
    .DoRequest('DELETE', Format(frx_YandexDisk_Delete_URL, [Str2HTML(UTF8Encode(FDirStack.Full + Id))]), nil,
    nil, []);
{$EndIf}
{$EndIf}
end;

procedure TfrxYandexDiskIOTransportIndy.Download(const SourceFileName: String;
  const Source: TStream);
var
  IdHTTP: TIdHTTP;
  SRes, URL: String;
  JRes :TfrxJSON;
begin
  inherited;
  IdHTTP := TfrxTransportIndyConnectorHTTP(FHTTP).GetIdHTTP;
  SRes := IdHTTP.Get(Format(frx_YandexDisk_Download_URL, [Str2HTML(UTF8Encode(FDirStack.Full + SourceFileName))]));
  JRes := TfrxJSON.Create(SRes);
  URL := JRes.ValueByName('href');
  if URL <> '' then
  begin
    try
      IdHTTP.Get(URL);
    except
      on E: EIdHTTPProtocolException do
{$IfDef Indy9}
        if (E.ReplyErrorCode <> 302) then
{$ELSE}
        if (E.ErrorCode <> 302) then
{$ENDIF}
          raise EIdHTTPProtocolException.Create(E.ErrorMessage);
    end;
    IdHTTP.Get(IdHTTP.Response.Location, Source);
  end;
  JRes.Free;
end;

function TfrxYandexDiskIOTransportIndy.GetAccessToken(const AuthorizationCode: String; var ErrorMsg: String): String;
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
      Res := IdHttp.Post(frx_YandexDisk_GetToken_URL, Source);
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

function TfrxYandexDiskIOTransportIndy.GetConnectorInstance: TfrxBaseTransportConnectionClass;
begin
  Result := TfrxYandexDiskTransportIndyHTTP;
end;

class function TfrxYandexDiskIOTransportIndy.GetDescription: String;
begin
  Result :=  '(Indy)' + inherited GetDescription;
end;

function TfrxYandexDiskIOTransportIndy.GetListFolder: String;
begin
  Result := TfrxTransportIndyConnectorHTTP(FHTTP)
    .GetIdHTTP.Get(Format(frx_YandexDisk_ListDir_URL, [FDirStack.Full]));
end;

function TfrxYandexDiskIOTransportIndy.GetListFolderContinue(Offset: String): String;
begin
  Result := TfrxTransportIndyConnectorHTTP(FHTTP)
    .GetIdHTTP.Get(Format(frx_YandexDisk_ListDirContinue_URL, [FDirStack.Full, Offset]));
end;

procedure TfrxYandexDiskIOTransportIndy.TestToken;
begin
  frxTestTokenIndy(frx_YandexDisk_Test, FAccessToken, False, frx_YandexDisk_PreAut);
end;

procedure TfrxYandexDiskIOTransportIndy.Upload(const Source: TStream;
  DestFileName: String);
var
  IdHTTP: TIdHTTP;
  SResGet, PutURL: String;
  JResGet: TfrxJSON;
begin
  inherited;

  IdHTTP := TfrxTransportIndyConnectorHTTP(FHTTP).GetIdHTTP;
  SResget := IdHTTP.Get(Format(frx_YandexDisk_Upload_URL, [Str2HTML(UTF8Encode(FDirStack.Full + DestFileName))]));
  JResGet := TfrxJSON.Create(SResget);
  PutURL := JResGet.ValueByName('href');
  IdHTTP.Put(PutURL, Source);

  JResGet.Free;
end;

{ TfrxYandexDiskTransportIndyHTTP }

procedure TfrxYandexDiskTransportIndyHTTP.SetDefaultParametersWithToken(AToken: String);
begin
  inherited;
  TidHTTP(FIdConnection).Request.CustomHeaders.Values['Authorization'] :=
    frx_YandexDisk_PreAut + AToken;
end;

end.
