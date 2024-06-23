unit GOX.Core.Zap.Api.WaMe;

{ API: https://api-wa.me/  }

interface

uses
  System.SysUtils,
  System.Classes,
  System.StrUtils,
  System.JSON,
  System.IOUtils,
  System.NetEncoding,
  Vcl.ExtCtrls,
  Vcl.Imaging.Jpeg,
  Vcl.Imaging.PngImage,
  GOX.Code.RESTRequest,
  GOX.Core.Zap.Interfaces;

type


  TGOXWhatsZap_WaMe = class(TInterfacedObject,IGOXWhatsZap)
  private
    { Private declarations }
    //
    procedure ConvertBase64ToTImage(Base64String: String; out AImg: TImage);
    function JSONFormat(AJSON: String): String;
    //
    const FURLBase = 'https://server.api-wa.me';
    const FToken  = 'x1514x707f1dc5c79fe67cccdd1e3c4cf92ef0b6baf4c0bc2111d644dc72f9597875b5';
  public
    { Public declarations }
     constructor Create;
     destructor Destroy; override;
     class function New: IGOXWhatsZap;

     //Security
     procedure Security_SetTokens(ANAME_Instance:String; AID_Instance:String; ATOKEN_Instance:String);
     procedure Security_GetTokens(out ANAME_Instance:String; out AID_Instance:String; out ATOKEN_Instance:String);

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


{ TGOXWhatsZap_WaMe }


function TGOXWhatsZap_WaMe.JSONFormat(AJSON: String): String;
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

function TGOXWhatsZap_WaMe.Message_DeleteMessage(AToPhone, AMessageId: String): String;
begin

end;

function TGOXWhatsZap_WaMe.Message_ReadMessage(AToPhone, AMessageId: String): String;
begin

end;

function TGOXWhatsZap_WaMe.Message_SendAudio(AToPhone, ABase64AudioOrURLAudio: String): String;
var
  LGOXResponse : IGOXResponse;
  LBodyN1: TJSONObject;
  LBodyN2: TJSONObject;
begin
  try
    try
      Result := '';
      //
      LBodyN2 := TJSONObject.Create;
      LBodyN2.AddPair('to',AToPhone);
      LBodyN2.AddPair('url',ABase64AudioOrURLAudio);
      LBodyN2.AddPair('type','audio');
      LBodyN2.AddPair('caption','');
      //
      LBodyN1 := TJSONObject.Create;
      LBodyN1.AddPair('data',LBodyN2);

      //
      LGOXResponse := TGOXRequest.New
                      .BaseURL(FURLBase)
                      .Accept('application/json')
                      .ContentType('application/json')
                      .AddParam('key',FToken)
                      //
                      .AddBody(LBodyN1.ToJSON)
                      .Resource('message/media')
                      .Post;
      Result := LGOXResponse.JSONValue.ToJSON;
    finally
      FreeAndNil(LBodyN1);
    end;
  except on E: Exception do
    raise Exception.Create('Message_Audio: '+E.Message);
  end;
end;

function TGOXWhatsZap_WaMe.Message_SendContact(AToPhone, AContactPhone, AContactName, AContactBusinessDescription: String): String;
begin

end;

function TGOXWhatsZap_WaMe.Message_SendDocument(AToPhone, AURLDocument, AExtension: String): String;
var
  LGOXResponse : IGOXResponse;
  LBodyN1: TJSONObject;
  LBodyN2: TJSONObject;
begin
  try
    try
      Result := '';
      //
      LBodyN2 := TJSONObject.Create;
      LBodyN2.AddPair('to',AToPhone);
      LBodyN2.AddPair('url',AURLDocument);
      LBodyN2.AddPair('type','document');
      LBodyN2.AddPair('caption','');
      //
      LBodyN1 := TJSONObject.Create;
      LBodyN1.AddPair('data',LBodyN2);

      //
      LGOXResponse := TGOXRequest.New
                      .BaseURL(FURLBase)
                      .Accept('application/json')
                      .ContentType('application/json')
                      .AddParam('key',FToken)
                      //
                      .AddBody(LBodyN1.ToJSON)
                      .Resource('message/media')
                      .Post;
      Result := LGOXResponse.JSONValue.ToJSON;
    finally
      FreeAndNil(LBodyN1);
    end;
  except on E: Exception do
    raise Exception.Create('Message_Document: '+E.Message);
  end;
end;

function TGOXWhatsZap_WaMe.Message_SendImage(AToPhone, ABase64ImageOrURLImage: String): String;
begin

end;

function TGOXWhatsZap_WaMe.Message_SendLink(AToPhone, AMessage, AURLImage, ALinkUrl, ATitle, ALinkDescription: String): String;
var
  LGOXResponse : IGOXResponse;
  LBodyN1: TJSONObject;
  LBodyN2: TJSONObject;
begin
  try
    try
      Result := '';
      //
      LBodyN2 := TJSONObject.Create;
      LBodyN2.AddPair('to',AToPhone);
      LBodyN2.AddPair('title',ATitle);
      LBodyN2.AddPair('text',AMessage);
      LBodyN2.AddPair('type','');
      LBodyN2.AddPair('body',ALinkDescription);
      LBodyN2.AddPair('thumbnailUrl',AURLImage);
      LBodyN2.AddPair('sourceUrl',ALinkUrl);
      //
      LBodyN1 := TJSONObject.Create;
      LBodyN1.AddPair('messageData',LBodyN2);

      //
      LGOXResponse := TGOXRequest.New
                      .BaseURL(FURLBase)
                      .Accept('application/json')
                      .ContentType('application/json')
                      .AddParam('key',FToken)
                      //
                      .AddBody(LBodyN1.ToJSON)
                      .Resource('message/link')
                      .Post;
      Result := LGOXResponse.JSONValue.ToJSON;
    finally
      FreeAndNil(LBodyN1);
    end;
  except on E: Exception do
    raise Exception.Create('Message_Link: '+E.Message);
  end;
end;

function TGOXWhatsZap_WaMe.Message_SendText(AToPhone, AMessage: String): String;
var
  LGOXResponse : IGOXResponse;
  LBodyN1: TJSONObject;
  LBodyN2: TJSONObject;
begin
  try
    try
      Result := '';
      //
      LBodyN2 := TJSONObject.Create;
      LBodyN2.AddPair('to',AToPhone);
      LBodyN2.AddPair('text',AMessage);
      //
      LBodyN1 := TJSONObject.Create;
      LBodyN1.AddPair('messageData',LBodyN2);

      //
      LGOXResponse := TGOXRequest.New
                      .BaseURL(FURLBase)
                      .Accept('application/json')
                      .ContentType('application/json')
                      .AddParam('key',FToken)
                      //
                      .AddBody(LBodyN1.ToJSON)
                      .Resource('message/text')
                      .Post;
      Result := LGOXResponse.JSONValue.ToJSON;
    finally
      FreeAndNil(LBodyN1);
    end;
  except on E: Exception do
    raise Exception.Create('Message_text: '+E.Message);
  end;
end;

function TGOXWhatsZap_WaMe.Message_SendVideo(AToPhone, ABase64VideoOrURLVideo: String): String;
var
  LGOXResponse : IGOXResponse;
  LBodyN1: TJSONObject;
  LBodyN2: TJSONObject;
begin
  try
    try
      Result := '';
      //
      LBodyN2 := TJSONObject.Create;
      LBodyN2.AddPair('to',AToPhone);
      LBodyN2.AddPair('url',ABase64VideoOrURLVideo);
      LBodyN2.AddPair('type','video');
      LBodyN2.AddPair('caption','');
      //
      LBodyN1 := TJSONObject.Create;
      LBodyN1.AddPair('data',LBodyN2);

      //
      LGOXResponse := TGOXRequest.New
                      .BaseURL(FURLBase)
                      .Accept('application/json')
                      .ContentType('application/json')
                      .AddParam('key',FToken)
                      //
                      .AddBody(LBodyN1.ToJSON)
                      .Resource('message/media')
                      .Post;
      Result := LGOXResponse.JSONValue.ToJSON;
    finally
      FreeAndNil(LBodyN1);
    end;
  except on E: Exception do
    raise Exception.Create('Message_Video: '+E.Message);
  end;
end;

class function TGOXWhatsZap_WaMe.New: IGOXWhatsZap;
begin
  Result := Self.Create;
end;

procedure TGOXWhatsZap_WaMe.Security_GetTokens(out ANAME_Instance, AID_Instance, ATOKEN_Instance: String);
begin
//
end;

procedure TGOXWhatsZap_WaMe.Security_SetTokens(ANAME_Instance, AID_Instance, ATOKEN_Instance: String);
begin
//
end;

procedure TGOXWhatsZap_WaMe.ConvertBase64ToTImage(Base64String: String; out AImg: TImage);
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

constructor TGOXWhatsZap_WaMe.Create;
begin

end;

destructor TGOXWhatsZap_WaMe.Destroy;
begin
  inherited;
end;

function TGOXWhatsZap_WaMe.Instance_Disconnect: String;
var
  LGOXResponse : IGOXResponse;
begin
  try
    Result := '';
    LGOXResponse := TGOXRequest.New
                    .BaseURL(FURLBase)
                    .Accept('application/json')
                    .ContentType('application/json')
                    .AddParam('key',FToken)
                    //
                    .Resource('instance/logout')
                    .Delete;
    Result := JSONFormat(LGOXResponse.Content);
  except on E: Exception do
    raise Exception.Create('DELETE_InstanceLogout: '+E.Message);
  end;
end;

function TGOXWhatsZap_WaMe.Instance_Status: String;
var
  LGOXResponse : IGOXResponse;
begin
  try
    Result := '';
    LGOXResponse := TGOXRequest.New
                    .BaseURL(FURLBase)
                    .Accept('application/json')
                    .ContentType('application/json')
                    .AddParam('key',FToken)
                    //
                    .Resource('instance/info')
                    .Get;
    Result := JSONFormat(LGOXResponse.Content);
  except on E: Exception do
    raise Exception.Create('GET_InstanceInfo: '+E.Message);
  end;

end;

function TGOXWhatsZap_WaMe.Instance_QrCodeBase64: String;
var
  LGOXResponse : IGOXResponse;
  LResult:String;
begin
  try
    Result := '';
    LGOXResponse := TGOXRequest.New
                    .BaseURL(FURLBase)
                    .Accept('application/json')
                    .ContentType('application/json')
                    .AddParam('key',FToken)
                    //
                    .Resource('instance/qrcode_base64')
                    .Get;
   Result := JSONFormat(LGOXResponse.Content);
  except on E: Exception do
    raise Exception.Create('GET_InstanceQrCodeBase64: '+E.Message);
  end;
end;

function TGOXWhatsZap_WaMe.Instance_QRCodeImage(out AImg: TImage): String;
var
  LBase64:String;
  LJSONValue : TJSONValue;
begin
  try
    try
      AImg.Picture := nil;
      LJSONValue := TJSONObject.ParseJSONValue(Instance_QrCodeBase64);
      LJSONValue.TryGetValue<String>('qrcode',LBase64);
      LBase64 := ReplaceStr(LBase64,'data:image/png;base64,','');
      ConvertBase64ToTImage(LBase64,AImg);
    finally
      FreeAndNil(LJSONValue);
    end;
  except on E: Exception do
    raise Exception.Create('Show_QRCodeTImage: '+E.Message);
  end;
end;

function TGOXWhatsZap_WaMe.Instance_Restart: String;
begin
//
end;

function TGOXWhatsZap_WaMe.Instance_RestoreSession: String;
begin
//
end;

end.
