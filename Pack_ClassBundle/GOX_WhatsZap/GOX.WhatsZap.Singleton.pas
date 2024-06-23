unit GOX.WhatsZap.Singleton;

{$INCLUDE GOXWhatsZap.inc}

interface

uses
  System.SysUtils,
  System.Classes,
  System.StrUtils,
  System.JSON,
  System.IOUtils,
  System.NetEncoding,
  Vcl.ExtCtrls,
  Vcl.Dialogs,
  Vcl.Imaging.Jpeg,
  Vcl.Imaging.PngImage,

  //Api Zap
  {$IFDEF APIZap_ZApi}GOX.Core.Zap.Api.ZApi,{$ENDIF}
  {$IFDEF APIZap_WaMe}GOX.Core.Zap.Api.WaMe,{$ENDIF}
  GOX.Core.Zap.Emojis,
  GOX.Core.Zap.Interfaces,
  System.IniFiles;

type

  TGOXAPIZap = class({$IFDEF APIZap_ZApi}TGOXWhatsZap_ZApi{$ENDIF}
                     {$IFDEF APIZap_WaMe}TGOXWhatsZap_WaMe{$ENDIF})
  end;

  TGOXEmoji = class(TGOXEmojis)
  end;

  TGOXWhatsZap = class
  private
    { Private declarations }
    IZap : IGOXWhatsZap;

    class var FSingletonInstace : TGOXWhatsZap;
    constructor CreatePrivate;
  public
    { Public declarations }
     constructor Create;
     destructor Destroy; override;
     class function Initialize: TGOXWhatsZap;
     class function Get: TGOXWhatsZap;

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
     function Message_SendText(ACelular:String;AMessage:String):String;
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


{ TGOXWhatsZap }
function TGOXWhatsZap.Message_DeleteMessage(AToPhone, AMessageId: String): String;
begin
  Result := '';
  Result := IZap.Message_DeleteMessage(AToPhone,AMessageId);
end;

function TGOXWhatsZap.Message_ReadMessage(AToPhone, AMessageId: String): String;
begin
  Result := '';
  Result := IZap.Message_ReadMessage(AToPhone,AMessageId);
end;

function TGOXWhatsZap.Message_SendAudio(AToPhone, ABase64AudioOrURLAudio: String): String;
begin
  Result := '';
  Result := IZap.Message_SendAudio(AToPhone,ABase64AudioOrURLAudio);
end;

function TGOXWhatsZap.Message_SendContact(AToPhone, AContactPhone, AContactName, AContactBusinessDescription: String): String;
begin
  Result := '';
  Result := IZap.Message_SendContact(AToPhone,AContactPhone,AContactName,AContactBusinessDescription);
end;

function TGOXWhatsZap.Message_SendDocument(AToPhone, AURLDocument, AExtension: String): String;
begin
  Result := '';
  Result := IZap.Message_SendDocument(AToPhone,AURLDocument,AExtension);
end;

function TGOXWhatsZap.Message_SendImage(AToPhone, ABase64ImageOrURLImage: String): String;
begin
  Result := '';
  Result := IZap.Message_SendImage(AToPhone,ABase64ImageOrURLImage);
end;

function TGOXWhatsZap.Message_SendLink(AToPhone, AMessage, AURLImage, ALinkUrl, ATitle, ALinkDescription: String): String;
begin
  Result := '';
  Result := IZap.Message_SendLink(AToPhone,AMessage,AURLImage,ALinkUrl,ATitle,ALinkDescription);
end;

function TGOXWhatsZap.Message_SendText(ACelular, AMessage: String): String;
begin
  Result := '';
  Result := IZap.Message_SendText(ACelular,AMessage);
end;

function TGOXWhatsZap.Message_SendVideo(AToPhone, ABase64VideoOrURLVideo: String): String;
begin
  Result := '';
  Result := IZap.Message_SendVideo(AToPhone,ABase64VideoOrURLVideo);
end;

procedure TGOXWhatsZap.Security_GetTokens(out ANAME_Instance, AID_Instance, ATOKEN_Instance: String);
begin
  IZap.Security_GetTokens(ANAME_Instance,AID_Instance,ATOKEN_Instance);
end;

procedure TGOXWhatsZap.Security_SetTokens(ANAME_Instance, AID_Instance, ATOKEN_Instance: String);
begin
  IZap.Security_SetTokens(ANAME_Instance,AID_Instance,ATOKEN_Instance);
end;

constructor TGOXWhatsZap.Create;
begin
  raise Exception.Create('Para Obter uma Instância de '+Self.ClassName+', use Initialize');
end;

constructor TGOXWhatsZap.CreatePrivate;
begin
  inherited;
  IZap := TGOXAPIZap.New;
end;

destructor TGOXWhatsZap.Destroy;
begin
  inherited;
end;

function TGOXWhatsZap.Instance_QRCodeImage(out AImg: TImage): String;
begin
  Result := '';
  Result := IZap.Instance_QRCodeImage(AImg);
end;

class function TGOXWhatsZap.Initialize: TGOXWhatsZap;
begin
  if not Assigned(FSingletonInstace) then
    FSingletonInstace := TGOXWhatsZap.CreatePrivate;
  Result := FSingletonInstace;
end;


function TGOXWhatsZap.Instance_Status: String;
begin
  Result := '';
  Result := IZap.Instance_Status;
end;

function TGOXWhatsZap.Instance_Disconnect: String;
begin
  Result := '';
  Result := IZap.Instance_Disconnect;
end;

function TGOXWhatsZap.Instance_QrCodeBase64: String;
begin
  Result := '';
  Result := IZap.Instance_QrCodeBase64;
end;

function TGOXWhatsZap.Instance_Restart: String;
begin
  Result := '';
  Result := IZap.Instance_Restart;
end;

function TGOXWhatsZap.Instance_RestoreSession: String;
begin
  Result := '';
  Result := IZap.Instance_RestoreSession;
end;

class function TGOXWhatsZap.Get: TGOXWhatsZap;
begin
  if not Assigned(FSingletonInstace) then
    raise Exception.Create('Para Obter uma Instância de '+Self.ClassName+', use Initialize');
  //
  Result := FSingletonInstace;
end;


initialization
finalization
  if Assigned(TGOXWhatsZap.FSingletonInstace) then
    FreeAndNil(TGOXWhatsZap.FSingletonInstace);
end.
