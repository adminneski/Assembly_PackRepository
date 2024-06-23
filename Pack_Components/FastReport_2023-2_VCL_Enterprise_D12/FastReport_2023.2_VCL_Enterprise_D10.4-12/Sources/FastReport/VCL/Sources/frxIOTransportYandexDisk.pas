
{******************************************}
{                                          }
{              FastReport v6.0             }
{          YandexDisk Save Filter          }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxIOTransportYandexDisk;

interface

{$I frx.inc}

uses
  Classes, frxIOTransportHelpers, frxBaseTransportConnection,
  frxIOTransportYandexDiskBase, frxProtocolFactory, frxTransportHTTP;

type
{$IFDEF DELPHI16}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxYandexDiskIOTransport = class(TfrxBaseYandexDiskIOTransport)
  protected
    function GetListFolder: String; override;
    function GetListFolderContinue(Offset: String): String; override;
    procedure CreateFolder(Dir: String); override;
    procedure DeleteFileOrFolder(const Id: String); override;
    procedure Upload(const Source: TStream; DestFileName: String = ''); override;
    procedure Download(const SourceFileName: String; const Source: TStream); override;
  public
    function GetAccessToken(const AuthorizationCode: String; var ErrorMsg: String): String; override;
    function GetConnectorInstance: TfrxBaseTransportConnectionClass; override;
    procedure TestToken; override;
  end;

  TfrxYandexDiskTransportHTTP = class(TfrxTransportHTTP)
  public
    procedure SetDefaultParametersWithToken(AToken: String); override;
  end;

implementation

uses
  SysUtils, frxJSON, frxServerUtils;

{ TfrxYandexDiskIOTransport }

procedure TfrxYandexDiskIOTransport.CreateFolder(Dir: String);
begin
  TfrxTransportHTTP(FHTTP).Put(
    Format(frx_YandexDisk_CreateDir_URL,[Str2HTML(UTF8Encode(FDirStack.Full + Dir))]));
end;

procedure TfrxYandexDiskIOTransport.DeleteFileOrFolder(const Id: String);
begin
  TfrxTransportHTTP(FHTTP).Delete(Format(frx_YandexDisk_Delete_URL, [Str2HTML(UTF8Encode(FDirStack.Full + Id))]));
end;

procedure TfrxYandexDiskIOTransport.Download(const SourceFileName: String;
  const Source: TStream);
var
  tHTTP: TfrxTransportHTTP;
  SRes, URL: String;
  JRes :TfrxJSON;
begin
  inherited;
  tHTTP := TfrxTransportHTTP(FHTTP);
  SRes := tHTTP.Get(Format(frx_YandexDisk_Download_URL, [Str2HTML(UTF8Encode(FDirStack.Full + SourceFileName))]));
  JRes := TfrxJSON.Create(SRes);
  URL := JRes.ValueByName('href');
  if URL <> '' then
  begin
    tHTTP.Get(URL);
    tHTTP.Get(tHTTP.ServerFields.Location, Source);
  end;
  JRes.Free;
end;

function TfrxYandexDiskIOTransport.GetAccessToken(const AuthorizationCode: String; var ErrorMsg: String): String;
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
  Source.WriteString('grant_type=authorization_code');
  try
    tHTTP := TfrxTransportHTTP.Create(nil);
    try
      if BlockedType then
        tHTTP.SocketType := fstBlocking;
      tHTTP.HTTPRequest.Encoding := '';
      tHTTP.HTTPRequest.DefAcceptTypes := htcDefaultXML;
      tHTTP.HTTPRequest.ContentType := 'application/x-www-form-urlencoded';
      Res := tHTTP.Post(frx_YandexDisk_GetToken_URL, Source);
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

function TfrxYandexDiskIOTransport.GetConnectorInstance: TfrxBaseTransportConnectionClass;
begin
  Result := TfrxYandexDiskTransportHTTP;
end;

function TfrxYandexDiskIOTransport.GetListFolder: String;
begin
  Result := UTF8Decode(TfrxTransportHTTP(FHTTP)
    .Get(AnsiString(Format(frx_YandexDisk_ListDir_URL, [Str2HTML(UTF8Encode(FDirStack.Full))]))));
end;

function TfrxYandexDiskIOTransport.GetListFolderContinue(Offset: String): String;
begin
  Result := UTF8Decode(TfrxTransportHTTP(FHTTP)
    .Get(AnsiString(Format(frx_YandexDisk_ListDirContinue_URL, [Str2HTML(UTF8Encode(FDirStack.Full)), Offset]))));
end;

procedure TfrxYandexDiskIOTransport.TestToken;
begin
  frxTestToken(frx_YandexDisk_Test, FAccessToken, False, frx_YandexDisk_PreAut);
end;

procedure TfrxYandexDiskIOTransport.Upload(const Source: TStream;
  DestFileName: String);
var
  tHTTP: TfrxTransportHTTP;
  SResGet, PutURL: String;
  JResGet: TfrxJSON;

  function ParseURL(URL: String): String;
  var
    buffURL: String;
    fp1, fp2: Integer;
  begin
    buffURL := URL;
    Delete(URL, 1, 8);
    fp1 := Pos(':', URL);
    fp2 := Pos('/', URL);
    tHTTP.Port := StrToInt(Copy(URL, fp1 + 1, fp2 - fp1 - 1));
    Delete(buffURL, fp1 + 8, fp2 - fp1);
    Result := buffURL;
  end;

begin
  inherited;
  tHTTP := TfrxTransportHTTP(FHTTP);

  SResget := tHTTP.Get(Format(frx_YandexDisk_Upload_URL, [Str2HTML(UTF8Encode(FDirStack.Full + DestFileName))]));
  JResGet := TfrxJSON.Create(SResget);
  PutURL := JResGet.ValueByName('href');
  PutURL := ParseURL(PutURL);

  tHTTP.Put(PutURL, Source);

  JResGet.Free;
end;

{ TfrxYandexDiskTransportHTTP }

procedure TfrxYandexDiskTransportHTTP.SetDefaultParametersWithToken(AToken: String);
begin
  inherited;
  HTTPRequest.Authorization := frx_YandexDisk_PreAut + AnsiString(AToken);
end;

end.
