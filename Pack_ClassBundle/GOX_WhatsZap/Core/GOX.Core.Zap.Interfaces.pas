unit GOX.Core.Zap.Interfaces;

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
  GOX.Code.RESTRequest;

type

  IGOXWhatsZap = interface
    ['{19CEDD44-C1A4-45CC-B898-D7092BE01D01}']
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

end.
