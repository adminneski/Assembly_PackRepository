unit Gobt_Encryp;

// Mr. Franco Paolo Brescianini's Sample provide
// String Encryption/Decryption Algorithm
//
// Freeware Non-Visual Component for Delphi 2.0x
// Written By Tom Lee , From Taiwan - Republic Of China
// Version 1.01 Release date OCT 20 1996
//

interface

uses
  SysUtils,
  Classes;

type
  TActionType = (atEncryption, atDecryption);

  TGoEncryp = class(TComponent)
  private
    { Private declarations }
    FInputString:String;
    FOutputString:String;
//    FHexInputString:string;
//    FHexOutputString:string;
    FKeyString:String;
    FAction:TActionType;
    procedure SetInputString(input:String);
    procedure SetOutputString(input:String);
    procedure SetKeyString(input:String);
    Function  EncryptionEngine (Src:String; Key : String; Encrypt : Boolean):String;
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent);override;
    Procedure Execute;
  published
    { Published declarations }
    property Input: String read FInputString write SetInputString;
    property Output: String read FOutputString write SetOutputString;
    property Key: String read FKeyString write SetKeyString;
    property Action: TActionType read FAction write FAction default atEncryption;
  end;


implementation


constructor TGoEncryp.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   Action:=atEncryption;
end;

Procedure TGoEncryp.SetOutputString(input:String);
begin
   if input<> FOutputString then
     FOutputString:=input;
end;

Procedure TGoEncryp.SetKeyString(input:String);
begin
   if input <> FKeyString Then
      FKeyString:=input;
end;

Procedure TGoEncryp.SetInputString(input:String);
begin
   if input <> FInputString Then
     FInputString:=input;
end;

Function TGoEncryp.EncryptionEngine (Src:String; Key:String; Encrypt : Boolean):String;
var
//   idx         :integer;
KeyLen      :Integer;
KeyPos      :Integer;
offset      :Integer;
dest        :String;
SrcPos      :Integer;
SrcAsc      :Integer;
TmpSrcAsc   :Integer;
Range       :Integer;
begin
   KeyLen:=Length(Key);
   if KeyLen = 0 then key:='Yabadabadoo';
   KeyPos:=0;
   SrcPos:=0;
   SrcAsc:=0;
   Range:=256;
   try
     if (Encrypt) then
     begin
        Randomize;
        offset:=Random(Range);
        dest:=format('%1.2x',[offset]);
        for SrcPos := 1 to Length(Src) do
        begin
           SrcAsc := (Ord(Src[SrcPos]) + offset) MOD 255;
           if KeyPos < KeyLen then KeyPos:= KeyPos + 1 else KeyPos:=1;
           SrcAsc:= SrcAsc xor Ord(Key[KeyPos]);
           dest:=dest + format('%1.2x',[SrcAsc]);
           offset:=SrcAsc;
        end;
     end
     else
     begin
        offset:=StrToInt('$'+ copy(src,1,2));
        SrcPos:=3;
        repeat
           SrcAsc:=StrToInt('$'+ copy(src,SrcPos,2));
           if KeyPos < KeyLen Then KeyPos := KeyPos + 1 else KeyPos := 1;
           TmpSrcAsc := SrcAsc xor Ord(Key[KeyPos]);
           if TmpSrcAsc <= offset then
                TmpSrcAsc := 255 + TmpSrcAsc - offset
           else
                TmpSrcAsc := TmpSrcAsc - offset;
           dest := dest + chr(TmpSrcAsc);
           offset:=srcAsc;
           SrcPos:=SrcPos + 2;
        until SrcPos >= Length(Src);
     end;
   finally
     Result:=Dest;
   end;
end;


procedure TGoEncryp.Execute;
var
EncryptionFlag:Boolean;
begin
   if length(FInputString)=0 then
   begin
        FOutputString:='';
        exit;
   end;

   if FAction = atEncryption then
      EncryptionFlag:=True
    else
      EncryptionFlag:=False;

   FOutputString:=EncryptionEngine(FInputString,FKeyString,EncryptionFlag);
end;

end.



