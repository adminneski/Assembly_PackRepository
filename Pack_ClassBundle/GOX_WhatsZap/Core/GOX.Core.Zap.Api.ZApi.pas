unit GOX.Core.Zap.Api.ZApi;

{ API: https://www.z-api.io/  }

interface

uses
  System.SysUtils,
  System.Classes,
  System.StrUtils,
  System.JSON,
  System.IOUtils,
  System.NetEncoding,
  Vcl.ExtCtrls,
  Winapi.WinInet,
  Vcl.Imaging.Jpeg,
  Vcl.Imaging.PngImage,
  GOX.Code.RESTRequest,
  GOX.Core.Zap.Interfaces,
  System.IniFiles;

type

  TGOXWhatsZap_ZApi = class(TInterfacedObject,IGOXWhatsZap)
  private
    { Private declarations }
    FSECURITY_TOKENSeguranca:String;
    FSECURITY_IDInstance:String;
    FSECURITY_TOKENInstance:String;
    //
    FURL_Instance    : String;
    //
    FPathIniFileParams : String;
    procedure ConvertBase64ToTImage(Base64String: String; out AImg: TImage);
    function JSONFormat(AJSON: String): String;
    function IsInternetConnected: Boolean;
  public
    { Public declarations }
     constructor Create;
     destructor Destroy; override;
     class function New: IGOXWhatsZap;
     //Security
     procedure Security_SetTokens(ATOKEN_Seguranca:String; AID_Instance:String; ATOKEN_Instance:String);
     //Instance
     function Instance_Status:String;
     function Instance_QrCodeBase64:String;
     function Instance_QRCodeImage(out AImg: TImage):String;
     function Instance_Restart:String;
     function Instance_Disconnect:String;
     function Instance_RestoreSession:String;

      //SendMessage
     function Message_SendText(AToPhone:String; AMessage:String):String;
     function Message_SendContact(AToPhone:String; AContactPhone:String; AContactName:String;AContactBusinessDescription:String = ''):String;
     function Message_SendImage(AToPhone:String; ABase64ImageOrURLImage:String):String;
     function Message_SendAudio(AToPhone:String; ABase64AudioOrURLAudio:String):String;
     function Message_SendVideo(AToPhone:String; ABase64VideoOrURLVideo:String):String;
     function Message_SendDocument(AToPhone:String; AURLDocument:String; AExtension:String = 'pdf'):String;
     function Message_SendLink(AToPhone:String; AMessage:String; AURLImage:String; ALinkUrl:String; ATitle:String; ALinkDescription:String):String;
     function Message_ReadMessage(AToPhone:String; AMessageId:String):String;
     function Message_DeleteMessage(AToPhone:String; AMessageId:String):String;
  end;

implementation

uses
  Vcl.Dialogs;


{ TGOXWhatsZap_ZApi }


function TGOXWhatsZap_ZApi.JSONFormat(AJSON: String): String;
const
 DEF_INDENT = 2;
var
 JO : TJSONObject;
begin
 try
   try
    JO := TJSONObject.ParseJSONValue(AJSON) as TJSONObject;
    Result := JO.Format(DEF_INDENT);
   finally
     FreeAndNil(JO);
   end;
 except
  on E:Exception do
   begin
    Result := AJSON;
    MessageDlg('Erro na sintaxe do JSON para Formatar.', mtError, [mbOK], 0);
   end;
 end;
end;

function TGOXWhatsZap_ZApi.Message_DeleteMessage(AToPhone, AMessageId: String): String;
var
  LGOXResponse : IGOXResponse;
  LBodyN1: TJSONObject;
begin
  if not IsInternetConnected then
  begin
    Result := 'Sem Internet.';
    Exit;
  end;
  //
  try
    try
      Result := '';
      //
      LBodyN1 := TJSONObject.Create;
      LBodyN1.AddPair('phone',AToPhone);
      LBodyN1.AddPair('messageId',AMessageId);
      //
      LGOXResponse := TGOXRequest.New
                      .BaseURL(FURL_Instance)
                      .Accept('*/*')
                      .ContentType('application/json')
                      .AddHeader('Client-Token',FSECURITY_TOKENSeguranca)
                      .AddParam('messageId',AMessageId)
                      .AddParam('phone',AToPhone)
                      .AddParam('owner',BoolToStr(False)) //Destinatario
                      .Resource('/messages')
                      .Delete;

      LGOXResponse := TGOXRequest.New
                      .BaseURL(FURL_Instance)
                      .Accept('*/*')
                      .ContentType('application/json')
                      .AddHeader('Client-Token',FSECURITY_TOKENSeguranca)
                      .AddParam('messageId',AMessageId)
                      .AddParam('phone',AToPhone)
                      .AddParam('owner',BoolToStr(True))  //Emitente
                      .Resource('/messages')
                      .Delete;

      Result := JSONFormat(LGOXResponse.JSONValue.ToJSON);
    finally
      FreeAndNil(LBodyN1);
    end;
  except on E: Exception do
    raise Exception.Create('function: '+'Message_ReadMessage'+#13+E.Message);
  end;
end;

function TGOXWhatsZap_ZApi.Message_ReadMessage(AToPhone, AMessageId: String): String;
var
  LGOXResponse : IGOXResponse;
  LBodyN1: TJSONObject;
begin
  if not IsInternetConnected then
  begin
    Result := 'Sem Internet.';
    Exit;
  end;
  //
  try
    try
      Result := '';
      //
      LBodyN1 := TJSONObject.Create;
      LBodyN1.AddPair('phone',AToPhone);
      LBodyN1.AddPair('messageId',AMessageId);
      //
      LGOXResponse := TGOXRequest.New
                      .BaseURL(FURL_Instance)
                      .Accept('*/*')
                      .ContentType('application/json')
                      .AddHeader('Client-Token',FSECURITY_TOKENSeguranca)
                      .AddBody(LBodyN1.ToJSON)
                      .Resource('/read-message')
                      .Post;
      Result := JSONFormat(LGOXResponse.JSONValue.ToJSON);
    finally
      FreeAndNil(LBodyN1);
    end;
  except on E: Exception do
    raise Exception.Create('function: '+'Message_ReadMessage'+#13+E.Message);
  end;
end;

function TGOXWhatsZap_ZApi.Message_SendAudio(AToPhone, ABase64AudioOrURLAudio: String): String;
var
  LGOXResponse : IGOXResponse;
  LBodyN1: TJSONObject;
begin
  if not IsInternetConnected then
  begin
    Result := 'Sem Internet.';
    Exit;
  end;
  //
  try
    try
      Result := '';
      //
      LBodyN1 := TJSONObject.Create;
      LBodyN1.AddPair('phone',AToPhone);
      LBodyN1.AddPair('audio',ABase64AudioOrURLAudio);
      //
      LGOXResponse := TGOXRequest.New
                      .BaseURL(FURL_Instance)
                      .Accept('*/*')
                      .ContentType('application/json')
                      .AddHeader('Client-Token',FSECURITY_TOKENSeguranca)
                      .AddBody(LBodyN1.ToJSON)
                      .Resource('/send-audio')
                      .Post;
      Result := JSONFormat(LGOXResponse.JSONValue.ToJSON);
    finally
      FreeAndNil(LBodyN1);
    end;
  except on E: Exception do
    raise Exception.Create('function: '+'Message_SendAudio'+#13+E.Message);
  end;
end;

function TGOXWhatsZap_ZApi.Message_SendContact(AToPhone, AContactPhone, AContactName, AContactBusinessDescription: String): String;
var
  LGOXResponse : IGOXResponse;
  LBodyN1: TJSONObject;
begin
  if not IsInternetConnected then
  begin
    Result := 'Sem Internet.';
    Exit;
  end;
  //
  try
    try
      Result := '';
      //
      LBodyN1 := TJSONObject.Create;
      LBodyN1.AddPair('phone',AToPhone);
      LBodyN1.AddPair('contactName',AContactName);
      LBodyN1.AddPair('contactPhone',AContactPhone);
      LBodyN1.AddPair('contactBusinessDescription',AContactBusinessDescription);
      //
      LGOXResponse := TGOXRequest.New
                      .BaseURL(FURL_Instance)
                      .Accept('*/*')
                      .ContentType('application/json')
                      .AddHeader('Client-Token',FSECURITY_TOKENSeguranca)
                      .AddBody(LBodyN1.ToJSON)
                      .Resource('/send-contact')
                      .Post;
      Result := JSONFormat(LGOXResponse.JSONValue.ToJSON);
    finally
      FreeAndNil(LBodyN1);
    end;
  except on E: Exception do
    raise Exception.Create('function: '+'Message_SendContact'+#13+E.Message);
  end;
end;

function TGOXWhatsZap_ZApi.Message_SendDocument(AToPhone, AURLDocument, AExtension: String): String;
var
  LGOXResponse : IGOXResponse;
  LBodyN1: TJSONObject;
begin
  if not IsInternetConnected then
  begin
    Result := 'Sem Internet.';
    Exit;
  end;
  //
  try
    try
      Result := '';
      //
      LBodyN1 := TJSONObject.Create;
      LBodyN1.AddPair('phone',AToPhone);
      LBodyN1.AddPair('document',AURLDocument);
      //
      LGOXResponse := TGOXRequest.New
                      .BaseURL(FURL_Instance)
                      .Accept('*/*')
                      .ContentType('application/json')
                      .AddHeader('Client-Token',FSECURITY_TOKENSeguranca)
                      .AddBody(LBodyN1.ToJSON)
                      .Resource('/send-document/'+AExtension)
                      .Post;
      Result := JSONFormat(LGOXResponse.JSONValue.ToJSON);
    finally
      FreeAndNil(LBodyN1);
    end;
  except on E: Exception do
    raise Exception.Create('function: '+'Message_SendDocument'+#13+E.Message);
  end;
end;

function TGOXWhatsZap_ZApi.Message_SendImage(AToPhone, ABase64ImageOrURLImage: String): String;
var
  LGOXResponse : IGOXResponse;
  LBodyN1: TJSONObject;
begin
  if not IsInternetConnected then
  begin
    Result := 'Sem Internet.';
    Exit;
  end;
  //
  try
    try
      Result := '';
      //
      LBodyN1 := TJSONObject.Create;
      LBodyN1.AddPair('phone',AToPhone);
      LBodyN1.AddPair('image',ABase64ImageOrURLImage);
      //
      LGOXResponse := TGOXRequest.New
                      .BaseURL(FURL_Instance)
                      .Accept('*/*')
                      .ContentType('application/json')
                      .AddHeader('Client-Token',FSECURITY_TOKENSeguranca)
                      .AddBody(LBodyN1.ToJSON)
                      .Resource('/send-image')
                      .Post;
      Result := JSONFormat(LGOXResponse.JSONValue.ToJSON);
    finally
      FreeAndNil(LBodyN1);
    end;
  except on E: Exception do
    raise Exception.Create('function: '+'Message_SendImage'+#13+E.Message);
  end;
end;

function TGOXWhatsZap_ZApi.Message_SendLink(AToPhone, AMessage, AURLImage, ALinkUrl, ATitle, ALinkDescription: String): String;
var
  LGOXResponse : IGOXResponse;
  LBodyN1: TJSONObject;
begin
  if not IsInternetConnected then
  begin
    Result := 'Sem Internet.';
    Exit;
  end;
  //
  try
    try
      Result := '';
      //
      LBodyN1 := TJSONObject.Create;
      LBodyN1.AddPair('phone',AToPhone);
      LBodyN1.AddPair('message',AMessage);
      LBodyN1.AddPair('image',AURLImage);
      LBodyN1.AddPair('linkUrl',ALinkUrl);
      LBodyN1.AddPair('title',ATitle);
      LBodyN1.AddPair('linkDescription',ALinkDescription);
      //
      LGOXResponse := TGOXRequest.New
                      .BaseURL(FURL_Instance)
                      .Accept('*/*')
                      .ContentType('application/json')
                      .AddHeader('Client-Token',FSECURITY_TOKENSeguranca)
                      .AddBody(LBodyN1.ToJSON)
                      .Resource('/send-link')
                      .Post;
      Result := JSONFormat(LGOXResponse.JSONValue.ToJSON);
    finally
      FreeAndNil(LBodyN1);
    end;
  except on E: Exception do
    raise Exception.Create('function: '+'Message_SendLink'+#13+E.Message);
  end;
end;

function TGOXWhatsZap_ZApi.Message_SendText(AToPhone, AMessage: String): String;
var
  LGOXResponse : IGOXResponse;
  LBodyN1: TJSONObject;
begin
  if not IsInternetConnected then
  begin
    Result := 'Sem Internet.';
    Exit;
  end;
  //
  try
    try
      Result := '';
      //
      LBodyN1 := TJSONObject.Create;
      LBodyN1.AddPair('phone',AToPhone);
      LBodyN1.AddPair('message',AMessage);
      //
      LGOXResponse := TGOXRequest.New
                      .BaseURL(FURL_Instance)
                      .Accept('*/*')
                      .ContentType('application/json')
                      .AddHeader('Client-Token',FSECURITY_TOKENSeguranca)
                      .AddBody(LBodyN1.ToJSON)
                      .Resource('/send-text')
                      .Post;
      Result := JSONFormat(LGOXResponse.JSONValue.ToJSON);
    finally
      FreeAndNil(LBodyN1);
    end;
  except on E: Exception do
    raise Exception.Create('function: '+'Message_SendText'+#13+E.Message);
  end;
end;

function TGOXWhatsZap_ZApi.Message_SendVideo(AToPhone, ABase64VideoOrURLVideo: String): String;
var
  LGOXResponse : IGOXResponse;
  LBodyN1: TJSONObject;
begin
  if not IsInternetConnected then
  begin
    Result := 'Sem Internet.';
    Exit;
  end;
  //
  try
    try
      Result := '';
      //
      LBodyN1 := TJSONObject.Create;
      LBodyN1.AddPair('phone',AToPhone);
      LBodyN1.AddPair('video',ABase64VideoOrURLVideo);
      //
      LGOXResponse := TGOXRequest.New
                      .BaseURL(FURL_Instance)
                      .Accept('*/*')
                      .ContentType('application/json')
                      .AddHeader('Client-Token',FSECURITY_TOKENSeguranca)
                      .AddBody(LBodyN1.ToJSON)
                      .Resource('/send-video')
                      .Post;
      Result := JSONFormat(LGOXResponse.JSONValue.ToJSON);
    finally
      FreeAndNil(LBodyN1);
    end;
  except on E: Exception do
    raise Exception.Create('function: '+'Message_SendVideo'+#13+E.Message);
  end;
end;

class function TGOXWhatsZap_ZApi.New: IGOXWhatsZap;
begin
  Result := Self.Create;
end;

procedure TGOXWhatsZap_ZApi.Security_SetTokens(ATOKEN_Seguranca:String; AID_Instance:String; ATOKEN_Instance: String);
begin
  { Token Desenvolvimento Neski
   ID_Instance     = '3CDEE1D7A1273005A00246D85C1A9F0C';
   Token_Instance  = 'AA83F20995F21F563C99D7EF';
  }
  FSECURITY_TOKENSeguranca := ATOKEN_Seguranca;
  FSECURITY_IDInstance     := AID_Instance;
  FSECURITY_TOKENInstance  := ATOKEN_Instance;
  //
  //Monta URL
  FURL_Instance   := 'https://api.z-api.io/instances/'+FSECURITY_IDInstance+'/token/'+FSECURITY_TOKENInstance;
end;

procedure TGOXWhatsZap_ZApi.ConvertBase64ToTImage(Base64String: String; out AImg: TImage);
var
  LInput, LOutput: TMemoryStream;
  LStringImagem: TStringStream;
begin
  {
   uses Units pra Funcionar funcao.
   System.Classes,
   Vcl.Imaging.Jpeg,
   Vcl.Imaging.PngImage,
   System.NetEncoding,
  }
  LInput := TMemoryStream.Create;
  LOutput := TMemoryStream.Create;
  LStringImagem := TStringStream.Create;
  try
    LStringImagem.WriteString(Base64String);
    LInput.LoadFromStream(LStringImagem);
    LInput.Position := 0;
    TNetEncoding.Base64.Decode( LInput, LOutput );
    LOutput.Position := 0;
    {$IFDEF FMX}
    AImg.BitMap.LoadFromStream(LOutput);
    {$ELSE}
    AImg.Picture.LoadFromStream(LOutput);
    {$ENDIF}
  finally
    FreeAndNil(LInput);
    FreeAndNil(LOutput);
    FreeAndNil(LStringImagem);
  end;
end;

constructor TGOXWhatsZap_ZApi.Create;
begin
  FPathIniFileParams := ExtractFileDir(ExtractFilePath(ParamStr(0)))+'\PARAMS_WhatsApp.ini';
end;

destructor TGOXWhatsZap_ZApi.Destroy;
begin
  inherited;
end;

function TGOXWhatsZap_ZApi.Instance_QRCodeImage(out AImg: TImage): String;
var
  LBase64:String;
  LJSONValue : TJSONValue;
  LGOXResponse : IGOXResponse;
begin
  if not IsInternetConnected then
  begin
    Result := 'Sem Internet.';
    Exit;
  end;
  //
  try
    try
      Result := '';
      AImg.Picture := nil;
      //
      LGOXResponse := TGOXRequest.New
                    .BaseURL(FURL_Instance)
                    .Accept('application/json')
                    .ContentType('application/json')
                    .AddHeader('Client-Token',FSECURITY_TOKENSeguranca)
                    .Resource('/qr-code/image')
                    .Get;
      //
      LJSONValue := TJSONObject.ParseJSONValue(LGOXResponse.Content);
      LJSONValue.TryGetValue<String>('value',LBase64);
      LBase64 := ReplaceStr(LBase64,'data:image/png;base64,','');
      ConvertBase64ToTImage(LBase64,AImg);
      Result := JSONFormat(LGOXResponse.Content);
    finally
      FreeAndNil(LJSONValue);
    end;
  except on E: Exception do
    raise Exception.Create('function: '+'Instance_QRCodeImage '+#13+E.Message);
  end;
end;

function TGOXWhatsZap_ZApi.Instance_Restart: String;
var
  LGOXResponse : IGOXResponse;
begin
  if not IsInternetConnected then
  begin
    Result := 'Sem Internet.';
    Exit;
  end;
  //
  try
    Result := '';
    LGOXResponse := TGOXRequest.New
                    .BaseURL(FURL_Instance)
                    .Accept('application/json')
                    .ContentType('application/json')
                    .AddHeader('Client-Token',FSECURITY_TOKENSeguranca)
                    .Resource('/restart')
                    .Get;
    Result := JSONFormat(LGOXResponse.Content);
  except on E: Exception do
    raise Exception.Create('function: '+'Instance_Restart'+#13+E.Message);
  end;
end;

function TGOXWhatsZap_ZApi.Instance_RestoreSession: String;
var
  LGOXResponse : IGOXResponse;
begin
  if not IsInternetConnected then
  begin
    Result := 'Sem Internet.';
    Exit;
  end;
  //
  try
    Result := '';
    LGOXResponse := TGOXRequest.New
                    .BaseURL(FURL_Instance)
                    .Accept('application/json')
                    .ContentType('application/json')
                    .AddHeader('Client-Token',FSECURITY_TOKENSeguranca)
                    .Resource('/restore-session')
                    .Get;
    Result := JSONFormat(LGOXResponse.Content);
  except on E: Exception do
    raise Exception.Create('function: '+'Instance_RestoreSession'+#13+E.Message);
  end;
end;

function TGOXWhatsZap_ZApi.Instance_Status: String;
var
  LGOXResponse : IGOXResponse;
begin
  if not IsInternetConnected then
  begin
    Result := 'Sem Internet.';
    Exit;
  end;
  //
  try
    Result := '';
    LGOXResponse := TGOXRequest.New
                    .BaseURL(FURL_Instance)
                    .Accept('application/json')
                    .ContentType('application/json')
                    .AddHeader('Client-Token',FSECURITY_TOKENSeguranca)
                    .Resource('/status')
                    .Get;
    Result := JSONFormat(LGOXResponse.Content);
  except on E: Exception do
    raise Exception.Create('function: '+'Instance_Status'+#13+E.Message);
  end;
end;

function TGOXWhatsZap_ZApi.IsInternetConnected: Boolean;
begin
  //  Inclua no uses WinInet
  //  BOOL InternetCheckConnection(LPCTSTR lpszUrl,DWORD dwFlags,DWORD dwReserved);
  try
    if InternetCheckConnection('http://www.google.com/', 1, 0) then
     Result := true  //Connected
    else
     Result := false; //Disconnected
  except
    Result := false; //Disconnected
  end;
end;

function TGOXWhatsZap_ZApi.Instance_Disconnect: String;
var
  LGOXResponse : IGOXResponse;
begin
  if not IsInternetConnected then
  begin
    Result := 'Sem Internet.';
    Exit;
  end;
  //
  try
    Result := '';
    LGOXResponse := TGOXRequest.New
                    .BaseURL(FURL_Instance)
                    .Accept('application/json')
                    .ContentType('application/json')
                    .AddHeader('Client-Token',FSECURITY_TOKENSeguranca)
                    .Resource('/disconnect')
                    .Get;
    Result := JSONFormat(LGOXResponse.Content);
  except on E: Exception do
    raise Exception.Create('function: '+'Instance_Disconnect'+#13+E.Message);
  end;
end;

function TGOXWhatsZap_ZApi.Instance_QrCodeBase64: String;
var
  LGOXResponse : IGOXResponse;
begin
  if not IsInternetConnected then
  begin
    Result := 'Sem Internet.';
    Exit;
  end;
  //
  try
    Result := '';
    LGOXResponse := TGOXRequest.New
                    .BaseURL(FURL_Instance)
                    .Accept('application/json')
                    .ContentType('application/json')
                    .AddHeader('Client-Token',FSECURITY_TOKENSeguranca)
                    .Resource('/qr-code/image')
                    .Get;
   Result := JSONFormat(LGOXResponse.Content);
  except on E: Exception do
    raise Exception.Create('function: '+'Instance_QrCodeBase64'+#13+E.Message);
  end;
end;
end.
