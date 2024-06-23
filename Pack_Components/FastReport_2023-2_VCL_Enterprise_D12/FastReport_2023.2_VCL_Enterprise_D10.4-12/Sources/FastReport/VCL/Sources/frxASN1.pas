unit frxASN1;

{$I frx.inc}

interface

uses
  {$IFNDEF Linux}
  Windows,
  {$ENDIF}
  SysUtils, Classes, Math,
  frCoreClasses,
  frxHelpers;

type
  TOIDName = (
    OID_undef,
    OID_rsaEncryption,                      // 1.2.840.113549.1.1.1
    OID_pkcs7_data,                         // 1.2.840.113549.1.7.1
    OID_pkcs7_signedData,                   // 1.2.840.113549.1.7.2
    OID_pkcs7_envelopedData,                // 1.2.840.113549.1.7.3
    OID_pkcs7_signedAndEnvelopedData,       // 1.2.840.113549.1.7.4
    OID_pkcs7_digestedData,                 // 1.2.840.113549.1.7.5
    OID_pkcs7_encryptedData,                // 1.2.840.113549.1.7.6
    OID_pkcs9_emailAddress,                 // 1.2.840.113549.1.9.1
    OID_pkcs9_contentType,                  // 1.2.840.113549.1.9.3
    OID_pkcs9_messageDigest,                // 1.2.840.113549.1.9.4
    OID_friendlyName,                       // 1.2.840.113549.1.9.20
    OID_localKeyID,                         // 1.2.840.113549.1.9.21
    OID_x509Certificate,                    // 1.2.840.113549.1.9.22.1
    OID_pbeWithSHA1And128BitRC4,            // 1.2.840.113549.1.12.1.1
    OID_pbeWithSHA1And40BitRC4,             // 1.2.840.113549.1.12.1.2
    OID_pbeWithSHA1And3_KeyTripleDES_CBC,   // 1.2.840.113549.1.12.1.3
    OID_pbeWithSHA1And2_KeyTripleDES_CBC,   // 1.2.840.113549.1.12.1.4
    OID_pbeWithSHA1And128BitRC2_CBC,        // 1.2.840.113549.1.12.1.5
    OID_pbeWithSHA1And40BitRC2_CBC,         // 1.2.840.113549.1.12.1.6
    OID_keyBag,                             // 1.2.840.113549.1.12.10.1.1
    OID_pkcs_8ShroudedKeyBag,               // 1.2.840.113549.1.12.10.1.2
    OID_certBag,                            // 1.2.840.113549.1.12.10.1.3
    OID_crlBag,                             // 1.2.840.113549.1.12.10.1.4
    OID_secretBag,                          // 1.2.840.113549.1.12.10.1.5
    OID_safeContentsBag,                    // 1.2.840.113549.1.12.10.1.6
    OID_md5,                                // 1.2.840.113549.2.5
    OID_sha1,                               // 1.3.14.3.2.26 - US Secure Hash Algorithm 1 (SHA1)
    OID_commonName,                         // 2.5.4.3
    OID_surname,                            // 2.5.4.4
    OID_serialNumber,                       // 2.5.4.5
    OID_countryName,                        // 2.5.4.6
    OID_localityName,                       // 2.5.4.7
    OID_stateOrProvinceName,                // 2.5.4.8
    OID_streetAddress,                      // 2.5.4.9
    OID_organizationName,                   // 2.5.4.10
    OID_organizationUnitName,               // 2.5.4.11
    OID_title,                              // 2.5.4.12
    OID_postalCode,                         // 2.5.4.17
    OID_givenName,                          // 2.5.4.42
    OID_initials,                           // 2.5.4.43
    OID_generationQualifier,                // 2.5.4.44
    OID_dnQualifier,                        // 2.5.4.46
    OID_pseudonym,                          // 2.5.4.65
    OID_sha256                              // 2.16.840.1.101.3.4.2.1
  );

  TfrxASN1Base = class
  private
    FTag: Cardinal;
    FClass: Byte;
  protected
    function CalcSize(Value, Threshold, Shift: Cardinal): Cardinal;
    function GetTagSize: Cardinal;
    function GetLenSize: Cardinal; virtual;
    function GetDataSize: Cardinal; virtual;
    function GetTotalSize: Cardinal;
    function Constructed: Byte; virtual;
    function HeaderToAnsi: AnsiString;
    function LengthToAnsi: AnsiString; virtual;
    function DataToAnsi: AnsiString; virtual;
  public
    constructor Create(ATag: Cardinal; AClass: Byte);
    function ToAnsi: AnsiString;
    function CreateCopy: TfrxASN1Base; virtual; abstract;
    function IsEqual(ASN1Object: TfrxASN1Base): Boolean; virtual;
    function IsTag(ATag: Cardinal): Boolean;
    function IsNot(ATag: Cardinal): Boolean;
    function IsClass(AClass: Byte): Boolean;
    function DataToWide: WideString; virtual;

    property Tag: Cardinal read FTag;
    property ASN1Class: Byte read FClass;
  end;

  TfrxASN1Null = class(TfrxASN1Base)
  protected
  public
    constructor Create;
    function CreateCopy: TfrxASN1Base; override;
  end;

  TfrxASN1Data = class(TfrxASN1Base)
  private
    procedure SetData(const Value: AnsiString); virtual;
  protected
    FData: AnsiString;
    function GetDataSize: Cardinal; override;
    function DataToAnsi: AnsiString; override;
  public
    constructor Create(ATag: Cardinal; AClass: Byte; AValue: AnsiString); overload;
    constructor Create(AValue: AnsiString); overload;
    function CreateCopy: TfrxASN1Base; override;
    function IsEqual(ASN1Object: TfrxASN1Base): Boolean; override;
    function DataToWide: WideString; override;

    property Data: AnsiString read FData write SetData;
  end;

  TfrxASN1ImmutableData = class(TfrxASN1Data)
  private
    procedure SetData(const Value: AnsiString); override;
  end;

  TfrxASN1Boolean = class(TfrxASN1ImmutableData)
  private
    FValue: Boolean;
  protected
  public
    constructor Create(AValue: Boolean); overload;
    constructor Create(AData: AnsiString); overload;
    function CreateCopy: TfrxASN1Base; override;
    property Value: Boolean read FValue;
  end;

  TfrxASN1Integer = class(TfrxASN1ImmutableData)
  private
    FValue: Int64;
    FIsOver64Bit: Boolean;
  public
    constructor Create(AValue: Int64); overload;
    constructor Create(AData: AnsiString); overload;
    function CreateCopy: TfrxASN1Base; override;
    property Value: Int64 read FValue;
    property IsOver64Bit: Boolean read FIsOver64Bit;
  end;

  TfrxASN1ObjectID = class(TfrxASN1ImmutableData)
  private
    FOIDName: TOIDName;
  public
    constructor Create(AData: AnsiString); overload;
    constructor Create(AOIDName: TOIDName); overload;
    function CreateCopy: TfrxASN1Base; override;
    property OIDName: TOIDName read FOIDName;
  end;

const
  ASN1_TAG_EOC = 0; // End-of-Content
  ASN1_TAG_BOOLEAN = 1;
  ASN1_TAG_INTEGER = 2;
  ASN1_TAG_OCTET_STRING = 4;
  ASN1_TAG_NULL = 5;
  ASN1_TAG_OBJECT_ID = 6;

  ASN1_TAG_UTF8STRING = 12;
  ASN1_TAG_NUMERICSTRING = 18;
  ASN1_TAG_PRINTABLESTRING = 19;
  ASN1_TAG_TG1STRING = 20;
  ASN1_TAG_VIDEOTEXSTRING = 21;
  ASN1_TAG_IA5STRING = 22;
  ASN1_TAG_GRAPHICSTRING = 25;
  ASN1_TAG_VISIBLESTRING = 26;
  ASN1_TAG_GENERALSTRING = 27;
  ASN1_TAG_UNIVERSALSTRING = 28;
  ASN1_TAG_BMPSTRING = 29;

  ASN1_TAG_SEQUENCE = 16;
  ASN1_TAG_SET = 17;

  ASN1_CLASS_UNIVERSAL = 0;
  ASN1_CLASS_CONTEXT = 2;

type
  TfrxASN1Container = class(TfrxASN1Base)
  private
    FList: TfrOwnObjList;
    FUnknowLength: Boolean;
    function GetItems(Index: Integer): TfrxASN1Base;
    function GetCount: Integer;
  protected
    function Constructed: Byte; override;
    function GetLenSize: Cardinal; override;
    function GetDataSize: Cardinal; override;
    function LengthToAnsi: AnsiString; override;
    function DataToAnsi: AnsiString; override;
  public
    constructor Create(ATag: Cardinal; AClass: Byte);
    constructor CreateSEQUENCE(AClass: Byte = ASN1_CLASS_UNIVERSAL);
    constructor CreateSET;
    destructor Destroy; override;
    function Add(AObject: TfrxASN1Base): Integer;
    function CreateCopy: TfrxASN1Base; override;
    function IsEqual(ASN1Object: TfrxASN1Base): Boolean; override;
    function IsEmpty: Boolean;
    property Items[Index: Integer]: TfrxASN1Base read GetItems; default;
    property Count: Integer read GetCount;
  end;

  TfrxASN1Document = class(TObject)
  private
    FList: TfrOwnObjList;
    procedure LoadFromBuffer(Buffer: Pointer; Size: Cardinal);
    function GetCount: Integer;
    function GetItems(Index: Integer): TfrxASN1Base;
  public
    constructor Create;
    destructor Destroy; override;
    procedure LoadFromStream(AStream: TStream);
    function Add(AObject: TfrxASN1Base): Integer;
    procedure Clear;
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TfrxASN1Base read GetItems; default;
  end;

function ReadASN1Object(Data: AnsiString; Offset: Integer = 0): TfrxASN1Base;

procedure RaiseIf(Flag: Boolean; Text: string; DebugLog: TLogList = nil);

implementation

uses
  frUtils,
  frxNetUtils, frxUtils;

const
  OIDData: array[TOIDName, 0..1] of AnsiString = ( // https://misc.daniel-marschall.de/asn.1/oid-converter/online.php
    (#00, ''), // OID_undef,
    (#$2A#$86#$48#$86#$F7#$0D#$01#$01#$01, '1.2.840.113549.1.1.1'), // OID_rsaEncryption,
    (#$2A#$86#$48#$86#$F7#$0D#$01#$07#$01, '1.2.840.113549.1.7.1'), // OID_pkcs7_data,
    (#$2A#$86#$48#$86#$F7#$0D#$01#$07#$02, '1.2.840.113549.1.7.2'), // OID_pkcs7_signedData,
    (#$2A#$86#$48#$86#$F7#$0D#$01#$07#$03, '1.2.840.113549.1.7.3'), // OID_pkcs7_envelopedData,
    (#$2A#$86#$48#$86#$F7#$0D#$01#$07#$04, '1.2.840.113549.1.7.4'), // OID_pkcs7_signedAndEnvelopedData,
    (#$2A#$86#$48#$86#$F7#$0D#$01#$07#$05, '1.2.840.113549.1.7.5'), // OID_pkcs7_digestedData,
    (#$2A#$86#$48#$86#$F7#$0D#$01#$07#$06, '1.2.840.113549.1.7.6'), // OID_pkcs7_encryptedData,
    (#$2A#$86#$48#$86#$F7#$0D#$01#$09#$01, '1.2.840.113549.1.9.1'), // OID_pkcs9_emailAddress
    (#$2A#$86#$48#$86#$F7#$0D#$01#$09#$03, '1.2.840.113549.1.9.3'), // OID_pkcs9_contentType,
    (#$2A#$86#$48#$86#$F7#$0D#$01#$09#$04, '1.2.840.113549.1.9.4'), // OID_pkcs9_messageDigest,
    (#$2A#$86#$48#$86#$F7#$0D#$01#$09#$14, '1.2.840.113549.1.9.20'), // OID_friendlyName,
    (#$2A#$86#$48#$86#$F7#$0D#$01#$09#$15, '1.2.840.113549.1.9.21'), // OID_localKeyID,
    (#$2A#$86#$48#$86#$F7#$0D#$01#$09#$16#$01, '1.2.840.113549.1.9.22.1'), // OID_x509Certificate,
    (#$2A#$86#$48#$86#$F7#$0D#$01#$0C#$01#$01, '1.2.840.113549.1.12.1.1'), // OID_pbeWithSHA1And128BitRC4,
    (#$2A#$86#$48#$86#$F7#$0D#$01#$0C#$01#$02, '1.2.840.113549.1.12.1.2'), // OID_pbeWithSHA1And40BitRC4,
    (#$2A#$86#$48#$86#$F7#$0D#$01#$0C#$01#$03, '1.2.840.113549.1.12.1.3'), // OID_pbeWithSHA1And3_KeyTripleDES_CBC,
    (#$2A#$86#$48#$86#$F7#$0D#$01#$0C#$01#$04, '1.2.840.113549.1.12.1.4'), // OID_pbeWithSHA1And2_KeyTripleDES_CBC,
    (#$2A#$86#$48#$86#$F7#$0D#$01#$0C#$01#$05, '1.2.840.113549.1.12.1.5'), // OID_pbeWithSHA1And128BitRC2_CBC,
    (#$2A#$86#$48#$86#$F7#$0D#$01#$0C#$01#$06, '1.2.840.113549.1.12.1.6'), // OID_pbeWithSHA1And40BitRC2_CBC,
    (#$2A#$86#$48#$86#$F7#$0D#$01#$0C#$0A#$01#$01, '1.2.840.113549.1.12.10.1.1'), // OID_keyBag,
    (#$2A#$86#$48#$86#$F7#$0D#$01#$0C#$0A#$01#$02, '1.2.840.113549.1.12.10.1.2'), // OID_pkcs_8ShroudedKeyBag,
    (#$2A#$86#$48#$86#$F7#$0D#$01#$0C#$0A#$01#$03, '1.2.840.113549.1.12.10.1.3'), // OID_certBag,
    (#$2A#$86#$48#$86#$F7#$0D#$01#$0C#$0A#$01#$04, '1.2.840.113549.1.12.10.1.4'), // OID_crlBag,
    (#$2A#$86#$48#$86#$F7#$0D#$01#$0C#$0A#$01#$05, '1.2.840.113549.1.12.10.1.5'), // OID_secretBag,
    (#$2A#$86#$48#$86#$F7#$0D#$01#$0C#$0A#$01#$06, '1.2.840.113549.1.12.10.1.6'), // OID_safeContentsBag,
    (#$2A#$86#$48#$86#$F7#$0D#$02#$05, '1.2.840.113549.2.5'), // OID_md5,
    (#$2B#$0E#$03#$02#$1A, '1.3.14.3.2.26'), // OID_sha1,
    (#$55#$04#$03, '2.5.4.3'), // OID_commonName,
    (#$55#$04#$04, '2.5.4.4'), // OID_surname,
    (#$55#$04#$05, '2.5.4.5'), // OID_serialNumber,
    (#$55#$04#$06, '2.5.4.6'), // OID_countryName,
    (#$55#$04#$07, '2.5.4.7'), // OID_localityName,
    (#$55#$04#$08, '2.5.4.8'), // OID_stateOrProvinceName,
    (#$55#$04#$09, '2.5.4.9'), // OID_streetAddress,
    (#$55#$04#$0A, '2.5.4.10'), // OID_organizationName,
    (#$55#$04#$0B, '2.5.4.11'), // OID_organizationUnitName,
    (#$55#$04#$0C, '2.5.4.12'), // OID_title,
    (#$55#$04#$11, '2.5.4.17'), // OID_postalCode,
    (#$55#$04#$2A, '2.5.4.42'), // OID_givenName,
    (#$55#$04#$2B, '2.5.4.43'), // OID_initials,
    (#$55#$04#$2C, '2.5.4.44'), // OID_generationQualifier,
    (#$55#$04#$2E, '2.5.4.46'), // OID_dnQualifier,
    (#$55#$04#$41, '2.5.4.65'), // OID_pseudonym,
    (#$60#$86#$48#$01#$65#$03#$04#$02#$01, '2.16.840.1.101.3.4.2.1') // OID_sha256,
    );

  LEN_LONG = $80; // Indefinite or long length

  LEN_MASK = $7F; // 01111111B
  TAG_MASK = $1F; // 00011111B
  CLASS_MASK = $60; // 01100000B
  TAG_MAX = $1E; // 30
  LEN_MAX = $7F; // 127
  CONSTRUCTED_MASK = $20; // 00100000B

  InvalidASN1DocumentCannotCalcula = 'Invalid ASN.1 document. Cannot calculate length or tag.';

{ Utilities }

procedure RaiseIf(Flag: Boolean; Text: string; DebugLog: TLogList = nil);
begin
  if Flag then
  begin
    if Assigned(DebugLog) then
      DebugLog.Add(Text);
    raise ESignException.Create(Text);
  end;
end;

function CreateObject(Tag: Cardinal; AClass: Byte; Data: AnsiString): TfrxASN1Base;
begin
  if AClass <> ASN1_CLASS_UNIVERSAL then
    Result := TfrxASN1Data.Create(Tag, AClass, Data)
  else
    case Tag of
      ASN1_TAG_BOOLEAN:   Result := TfrxASN1Boolean.Create(Data);
      ASN1_TAG_NULL:      Result := TfrxASN1Null.Create;
      ASN1_TAG_INTEGER:   Result := TfrxASN1Integer.Create(Data);
      ASN1_TAG_OBJECT_ID: Result := TfrxASN1ObjectID.Create(Data);
    else
      Result := TfrxASN1Data.Create(Tag, AClass, Data);
    end;
end;

function DecodeTag(Data: PByteArray; Size: Cardinal; var NextRead: Cardinal): Cardinal;
var
  Work: byte;
  Res: Int64;
begin
  Work := Data[NextRead];
  Inc(NextRead);
  Work := Work and TAG_MASK;
  if Work = TAG_MASK then
  begin
    Res := 0;
    RaiseIf(NextRead >= Size, InvalidASN1DocumentCannotCalcula);
    repeat
      Work := Data[NextRead];
      Inc(NextRead);
      Res := (Res shl 7) or (Work and $7F);
      RaiseIf(Res > High(Cardinal), 'Invalid ASN.1 document. Very large Tag');
    until (NextRead >= Size) or (Work < $80);
    Result := Res;
  end
  else
    Result := Work;
end;

function DecodeLen(Data: PByteArray; Size: Cardinal; var NextRead: Cardinal; var UnknowLen: Boolean): Cardinal;
var
  LenSize, Work, i: byte;
begin
  Result := 0;
  Work := Data[NextRead];
  Inc(NextRead);

  if      Work = LEN_LONG then
    UnknowLen := True
  else if Work and LEN_LONG = 0 then
    Result := Work
  else
  begin
    LenSize := Work and LEN_MASK;
    RaiseIf(LenSize > 4, 'Invalid ASN.1 document. Very large length.');

    for i := 0 to LenSize - 1 do
    begin
      RaiseIf(NextRead >= Size, InvalidASN1DocumentCannotCalcula);
      Work := Data[NextRead];
      Inc(NextRead);
      Result := (Result shl 8) or Work;
    end;
  end;
end;

function ASN1ObjName(Tag: Integer): String;
begin
  case Tag of
    0:                     Result := '[0]';
    ASN1_TAG_BOOLEAN:      Result := 'Boolean';
    ASN1_TAG_INTEGER:      Result := 'Integer';
    ASN1_TAG_OCTET_STRING: Result := 'Octet String';
    ASN1_TAG_NULL:         Result := 'Null';
    ASN1_TAG_OBJECT_ID:    Result := 'Object ID';
    ASN1_TAG_SEQUENCE:     Result := 'Sequence';
    ASN1_TAG_SET:          Result := 'Set';
  else
    Result := 'Unknown';
  end;
end;

//function ASN1ObjValue(Base: TfrxASN1Base): String;
//begin
//  if      Base is TfrxASN1Boolean then
//    Result := IfStr(TfrxASN1Boolean(Base).Value, 'True', 'False')
//  else if Base is TfrxASN1Null then
//    Result := ''
//  else if Base is TfrxASN1Integer then
//    Result := IfStr(TfrxASN1Integer(Base).IsOver64Bit, 'Over64Bit', IntToStr(TfrxASN1Integer(Base).Value))
//  else if Base is TfrxASN1ObjectID then
//    Result := OIDData[TfrxASN1ObjectID(Base).OIDName, 1]
//  else if Base is TfrxASN1Container then
//    Result := IntToStr(TfrxASN1Container(Base).Count) + ' elem'
//  else if Base is TfrxASN1Data then
//    Result := AnsiToHex(TfrxASN1Data(Base).Data);
//  Result := '(' + Result + ')';
//end;

function ReadItem(List: TfrOwnObjList; Buffer: Pointer; Offset, Size: Cardinal;
  IsUnknowRealSize: Boolean): Cardinal;
const
  UnknowRealSize = High(Cardinal);
var
  PB: PByteArray;
  bClass, Constructed: Byte;
  Len, Tag: Cardinal;
  IsZeroTagAndLenSource: Boolean;
  Container: TfrxASN1Container;
  HeaderSize, ItemSize: Cardinal;
  NewBuffer: Pointer;
  UnknowLen: Boolean;
  Data: AnsiString;
begin
  Result := 0;
  if Offset >= Size then
    Exit;
  UnknowLen := False;

  PB := IncPointer(Buffer, Offset);

  bClass := PB[0] shr 6;
  Constructed := PB[0] and CONSTRUCTED_MASK;
  Tag := DecodeTag(PB, Size - Offset, Result);

  RaiseIf(Offset + Result >= Size, InvalidASN1DocumentCannotCalcula);

  IsZeroTagAndLenSource := (PB[0] = 0) // Tag Source
                       and (PB[Result] = 0); // Length Source
  if IsZeroTagAndLenSource then
  begin
    RaiseIf(not IsUnknowRealSize, 'Invalid ASN.1 document. Invalid tag was found');
    Result := UnknowRealSize;
    Exit;
  end;

  Len := DecodeLen(PB, Size - Offset, Result, UnknowLen);
  HeaderSize := Result;

  if not UnknowLen and (Offset + Result + Len > Size) then
    Exit;

  if Constructed = CONSTRUCTED_MASK then
  begin
    // OCTET STRING + CONSTRUCTED_MASK => Container ?!
    if (bClass <> ASN1_CLASS_UNIVERSAL) or
       (Tag in [ASN1_TAG_SEQUENCE, ASN1_TAG_SET, ASN1_TAG_OCTET_STRING]) then
    begin
      Container := TfrxASN1Container.Create(Tag, bClass);
      if UnknowLen then
        Len := Size - Offset - HeaderSize;

      try
        Container.FUnknowLength := UnknowLen;
        NewBuffer := IncPointer(Buffer, Offset + HeaderSize);

        Offset := 0;
        repeat
          ItemSize := ReadItem(Container.FList, NewBuffer, Offset, Len, UnknowLen);
          if UnknowLen and (ItemSize = UnknowRealSize) then
          begin
            Inc(Offset, 2);
            Break;
          end;
          Offset := Offset + ItemSize;
        until ItemSize = 0;

        if UnknowLen then
          Len := Offset;
      except
        Container.Free;
        raise;
      end;
      List.Add(Container);
    end
  end
  else
  begin
    RaiseIf(UnknowLen, InvalidASN1DocumentCannotCalcula);
    SetLength(Data, Len);
    Move(PB[Result], Data[1], Len);
    List.AddNonZero(CreateObject(Tag, bClass, Data));
  end;
  Result := Result + Len;
end;

function ReadASN1Object(Data: AnsiString; Offset: Integer = 0): TfrxASN1Base;
var
  List: TfrOwnObjList;
begin
  List := TfrOwnObjList.Create(False);
  try
    ReadItem(List, @Data[1 + Offset], 0, Length(Data) - Offset, False);
    if List.Count = 0 then
      Result := nil
    else
      Result := TfrxASN1Base(List[0]);
  finally
    List.Free;
  end;
end;

function ASN1DecodeDataInteger64(Data: AnsiString): Int64;
var
  Len: Cardinal;
  B: array[0 .. SizeOf(Int64) - 1] of Byte;
  Fill: Byte;
begin
  Len := Length(Data);
  if Len = 0 then
    Result := 0
  else
  begin
    Fill := frIfInt(Byte(Data[1]) and $80 <> 0, $FF);
    FillChar(B[0], SizeOf(Int64), Fill);
    Move(Data[1], B[SizeOf(Int64) - Len], Len);
    Result := ByteSwap(PInt64(@B[0])^); // B => Int64
  end;
end;

function ASN1EncodeDataInteger64(const Value: Int64): AnsiString;
var
  I64: Int64;
  Data: AnsiString;

  function IsTest(c: AnsiChar; b: Byte): Boolean;
  begin
    Result := (Data[1] = c) and (Byte(Data[2]) and $80 = b);
  end;

begin
  I64 := ByteSwap(Value);
  SetLength(Data, SizeOf(I64));
  Move(I64, Data[1], SizeOf(I64));
  while (Length(Data) > 1) and (IsTest(#$00, $00) or IsTest(#$FF, $80)) do
    Delete(Data, 1, 1);
  Result := Data;
end;

function ASN1EncodeDataBoolean(Value: Boolean): AnsiString;
begin
  if Value then Result := #$FF
  else          Result := #$00;
end;

{ TfrxASN1Base }

function TfrxASN1Base.CalcSize(Value, Threshold, Shift: Cardinal): Cardinal;
begin
  Result := 1;
  if Value > Threshold then
    repeat
      Inc(Result);
      Value := Value shr Shift;
    until Value = 0;
end;

function TfrxASN1Base.Constructed: Byte;
begin
  Result := 0;
end;

constructor TfrxASN1Base.Create(ATag: Cardinal; AClass: Byte);
begin
  FTag := ATag;
  FClass := AClass;
end;

function TfrxASN1Base.DataToAnsi: AnsiString;
begin
  Result := '';
end;

function TfrxASN1Base.DataToWide: WideString;
begin
  Result := '';
end;

function TfrxASN1Base.GetDataSize: Cardinal;
begin
  Result := 0;
end;

function TfrxASN1Base.GetLenSize: Cardinal;
begin
  Result := CalcSize(GetDataSize, LEN_MAX, 8);
end;

function TfrxASN1Base.GetTagSize: Cardinal;
begin
  Result := CalcSize(FTag, TAG_MAX, 7);
end;

function TfrxASN1Base.GetTotalSize: Cardinal;
begin
  Result := GetTagSize + GetLenSize + GetDataSize;
end;

function TfrxASN1Base.HeaderToAnsi: AnsiString;

  function LongTag(Tag: Cardinal): AnsiString;
  var
    Bit8: Byte;
  begin
    Bit8 := 0;
    Result := '';
    repeat
      Result := AnsiChar(Tag and (CLASS_MASK + TAG_MASK) or Bit8) + Result;
      Bit8 := $80;
      Tag := Tag shr 7;
    until Tag = 0;
  end;

var
  Bits8_6: Byte;
begin
  Bits8_6 := (FClass shl 6) or Constructed;
  if FTag > TAG_MAX then
    Result := AnsiChar(Bits8_6 or TAG_MASK) + LongTag(FTag)
  else
    Result := AnsiChar(Bits8_6 or FTag);
end;

function TfrxASN1Base.IsClass(AClass: Byte): Boolean;
begin
  Result := ASN1Class = AClass;
end;

function TfrxASN1Base.IsEqual(ASN1Object: TfrxASN1Base): Boolean;
begin
  Result := (ClassType = ASN1Object.ClassType)
        and (FClass = ASN1Object.FClass)
        and (FTag = ASN1Object.FTag);
end;

function TfrxASN1Base.IsNot(ATag: Cardinal): Boolean;
begin
  Result := Tag <> ATag;
end;

function TfrxASN1Base.IsTag(ATag: Cardinal): Boolean;
begin
  Result := Tag = ATag;
end;

function TfrxASN1Base.LengthToAnsi: AnsiString;
var
  Len: Cardinal;
  Count: Byte;
begin
  Len := GetDataSize;
  if Len > LEN_MAX then
  begin
    Result := '';
    Count := 0;
    while Len > 0 do
    begin
      Result := AnsiChar(Len and $FF) + Result;
      Len := Len shr 8;
      Inc(Count);
    end;
    Result := AnsiChar(Count or $80) + Result;
  end
  else
    Result := AnsiChar(Len);
end;

function TfrxASN1Base.ToAnsi: AnsiString;
begin
  Result := HeaderToAnsi + LengthToAnsi + DataToAnsi;
end;

{ TASN1Container }

function TfrxASN1Container.Add(AObject: TfrxASN1Base): Integer;
begin
  Result := FList.Add(AObject);
end;

function TfrxASN1Container.Constructed: Byte;
begin
  Result := CONSTRUCTED_MASK;
end;

function TfrxASN1Container.CreateCopy: TfrxASN1Base;
var
  i: Integer;
  R: TfrxASN1Container;
begin
  R := TfrxASN1Container.Create(FTag, FClass);
  for i := 0 to Count - 1 do
    R.Add(Items[i].CreateCopy);
  R.FUnknowLength := FUnknowLength;
  Result := R;
end;

constructor TfrxASN1Container.CreateSEQUENCE(AClass: Byte = ASN1_CLASS_UNIVERSAL);
begin
  Create(ASN1_TAG_SEQUENCE, AClass)
end;

constructor TfrxASN1Container.CreateSET;
begin
  Create(ASN1_TAG_SET, ASN1_CLASS_UNIVERSAL);
end;

constructor TfrxASN1Container.Create(ATag: Cardinal; AClass: Byte);
begin
  inherited Create(ATag, AClass);
  FList := TfrOwnObjList.Create;
  FUnknowLength := False;
end;

destructor TfrxASN1Container.Destroy;
begin
  FList.Free;
  inherited;
end;

function TfrxASN1Container.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TfrxASN1Container.GetDataSize: Cardinal;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to Count - 1 do
    Result := Result + Items[i].GetTotalSize;
  if FUnknowLength then
    Inc(Result, 2);
end;

function TfrxASN1Container.GetItems(Index: Integer): TfrxASN1Base;
begin
  Result := TfrxASN1Base(FList[Index]);
end;

function TfrxASN1Container.GetLenSize: Cardinal;
begin
  if FUnknowLength then
    Result := 1
  else
    Result := inherited GetLenSize;
end;

function TfrxASN1Container.IsEmpty: Boolean;
begin
  Result := Count < 1;
end;

function TfrxASN1Container.IsEqual(ASN1Object: TfrxASN1Base): Boolean;
var
  i: Integer;
begin
  Result := inherited IsEqual(ASN1Object)
        and (Count = TfrxASN1Container(ASN1Object).Count);
  i := 0;
  while Result and (i < Count) do
  begin
    Result := Result and Items[i].IsEqual(TfrxASN1Container(ASN1Object)[i]);
    Inc(i);
  end;
end;

function TfrxASN1Container.LengthToAnsi: AnsiString;
begin
  if FUnknowLength then
    Result := #128
  else
    Result := inherited LengthToAnsi;
end;

function TfrxASN1Container.DataToAnsi: AnsiString;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to Count - 1 do
    Result := Result + Items[i].ToAnsi;
  if FUnknowLength then
    Result := Result + #0#0;
end;

{ TASN1Null }

function TfrxASN1Null.CreateCopy: TfrxASN1Base;
begin
  Result := TfrxASN1Null.Create;
end;

constructor TfrxASN1Null.Create;
begin
  inherited Create(ASN1_TAG_NULL, ASN1_CLASS_UNIVERSAL);
end;

{ TASN1Boolean }

constructor TfrxASN1Boolean.Create(AData: AnsiString);
begin
  RaiseIf(Length(AData) <> 1, 'Invalid ASN.1 document. Tag Boolean length not equal to 1');
  Create(AData[1] <> #0);
end;

function TfrxASN1Boolean.CreateCopy: TfrxASN1Base;
begin
  Result := TfrxASN1Boolean.Create(FValue);
end;

constructor TfrxASN1Boolean.Create(AValue: Boolean);
begin
  inherited Create(ASN1_TAG_BOOLEAN, ASN1_CLASS_UNIVERSAL, ASN1EncodeDataBoolean(AValue));
  FValue := AValue;
end;

{ TASN1Integer }

constructor TfrxASN1Integer.Create(AValue: Int64);
begin
  inherited Create(ASN1_TAG_INTEGER, ASN1_CLASS_UNIVERSAL, ASN1EncodeDataInteger64(AValue));
  FValue := AValue;
  FIsOver64Bit := False;
end;

function TfrxASN1Integer.CreateCopy: TfrxASN1Base;
begin
  Result := TfrxASN1Integer.Create(FData);
end;

constructor TfrxASN1Integer.Create(AData: AnsiString);
begin
  inherited Create(ASN1_TAG_INTEGER, ASN1_CLASS_UNIVERSAL, AData);
  FIsOver64Bit := Length(AData) > SizeOf(Int64);
  if not FIsOver64Bit then
    FValue := ASN1DecodeDataInteger64(AData);
end;

{ TASN1Document }

function TfrxASN1Document.Add(AObject: TfrxASN1Base): Integer;
begin
  Result := FList.Add(AObject);
end;

procedure TfrxASN1Document.Clear;
begin
  FList.Clear;
end;

constructor TfrxASN1Document.Create;
begin
  FList := TfrOwnObjList.Create;
end;

destructor TfrxASN1Document.Destroy;
begin
  FList.Free;
  inherited;
end;

function TfrxASN1Document.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TfrxASN1Document.GetItems(Index: Integer): TfrxASN1Base;
begin
  Result := TfrxASN1Base(FList[Index]);
end;

procedure TfrxASN1Document.LoadFromBuffer(Buffer: Pointer; Size: Cardinal);
var
  Offset: Cardinal;
  ItemSize: Cardinal;
begin
  FList.Clear;
  Offset := 0;
  repeat
    ItemSize := ReadItem(FList, Buffer, Offset, Size, False);
    Offset := Offset + ItemSize;
  until ItemSize = 0;
end;

procedure TfrxASN1Document.LoadFromStream(AStream: TStream);
var
  Buffer: Pointer;
  Size, OldPosition: Cardinal;
begin
  Size := AStream.Size - AStream.Position;
  Buffer := GetMemory(Size);
  try
    OldPosition := AStream.Position;
    AStream.Read(Buffer^, Size);
    AStream.Position := OldPosition;
    LoadFromBuffer(Buffer, Size);
  finally
    FreeMemory(Buffer);
  end;
end;

{ TASN1Data }

function TfrxASN1Data.CreateCopy: TfrxASN1Base;
begin
  Result := TfrxASN1Data.Create(FTag, FClass, FData);
end;

constructor TfrxASN1Data.Create(AValue: AnsiString);
begin
  Create(ASN1_TAG_OCTET_STRING, ASN1_CLASS_UNIVERSAL, AValue);
end;

constructor TfrxASN1Data.Create(ATag: Cardinal; AClass: Byte; AValue: AnsiString);
begin
  inherited Create(ATag, AClass);
  FData := AValue;
end;

function TfrxASN1Data.GetDataSize: Cardinal;
begin
  Result := Length(FData);
end;

function TfrxASN1Data.IsEqual(ASN1Object: TfrxASN1Base): Boolean;
begin
  Result := inherited IsEqual(ASN1Object)
        and (FData = TfrxASN1Data(ASN1Object).FData);
end;

procedure TfrxASN1Data.SetData(const Value: AnsiString);
begin
  FData := Value;
end;

function TfrxASN1Data.DataToAnsi: AnsiString;
begin
  Result := FData;
end;

function TfrxASN1Data.DataToWide: WideString;
begin
  case Tag of
//    ASN1_TAG_UTF8STRING = 12;
//    ASN1_TAG_NUMERICSTRING = 18;
    ASN1_TAG_PRINTABLESTRING: Result := WideString(DataToAnsi);
//    ASN1_TAG_TG1STRING = 20;
//    ASN1_TAG_VIDEOTEXSTRING = 21;
    ASN1_TAG_IA5STRING: Result := WideString(DataToAnsi);
//    ASN1_TAG_GRAPHICSTRING = 25;
//    ASN1_TAG_VISIBLESTRING = 26;
//    ASN1_TAG_GENERALSTRING = 27;
//    ASN1_TAG_UNIVERSALSTRING = 28;
//    ASN1_TAG_BMPSTRING = 29;
  else
    Result := WideString(DataToAnsi);
  end;
end;

{ TASN1ObjectID }

function TfrxASN1ObjectID.CreateCopy: TfrxASN1Base;
begin
  Result := TfrxASN1ObjectID.Create(FData);
end;

constructor TfrxASN1ObjectID.Create(AData: AnsiString);
var
  OIDName: TOIDName;
begin
  inherited Create(ASN1_TAG_OBJECT_ID, ASN1_CLASS_UNIVERSAL, AData);

  for OIDName := Low(TOIDName) to High(TOIDName) do
    if FData = OIDData[OIDName, 0] then
    begin
      FOIDName := OIDName;
      Exit;
    end;
  FOIDName := OID_undef;
end;

constructor TfrxASN1ObjectID.Create(AOIDName: TOIDName);
begin
  Create(OIDData[AOIDName, 0]);
end;

{ TASN1ImmutableData }

procedure TfrxASN1ImmutableData.SetData(const Value: AnsiString);
begin
  raise ESignException.Create('Cannot change ASN.1 value for this class');
end;

end.
