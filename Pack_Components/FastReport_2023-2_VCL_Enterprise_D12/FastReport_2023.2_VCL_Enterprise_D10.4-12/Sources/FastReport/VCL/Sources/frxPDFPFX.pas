unit frxPDFPFX;

{$I frx.inc}

interface

uses
  {$IFNDEF Linux}
  Windows,
  {$ENDIF}
  SysUtils, Classes, Math,
  frCoreClasses,
  frxHelpers,
  frxASN1, frxPDFX509Certificate;

type

  TfrxPKCS12Document = class
  private
    FContentInfo: AnsiString;

    FMacSalt: AnsiString;
    FMacDigest: AnsiString;
    FMacAlgorithmName: TOIDName;
    FMacIterations: Integer;

    FValidPassword: UTF8String;
    FPrivateKeys: TfrOwnObjList;
    FCertificates: TfrOwnObjList;
    FChain: TfrxX509Certificate;
    FChainLen: Integer;

    function GetCertificates(i: Integer): TfrxX509Certificate;
    function GetPrivateKeys(i: Integer): TfrxRSAPrivateKey;
  protected
    FDebugLog: TLogList;

    procedure Clear;
    procedure ClearMacData;
    procedure LoadMacData(MacData: TfrxASN1Container);
    procedure ProcessSafeBag(SafeBag: TfrxASN1Container);
    class procedure PartCopy(Source: AnsiString; var Dest: AnsiString; APos: Integer);
    class procedure PartCopy2(Source: AnsiString; var Dest: AnsiString; APos: Integer);
    class function NormalizePassword(Password: UTF8String): AnsiString;
    procedure ReadPrivateKey(BagId: TOIDName; BagValue, BagAttributes: TfrxASN1Container);
    procedure ReadCertificate(BagValue, BagAttributes: TfrxASN1Container);

    property Certificates[i: Integer]: TfrxX509Certificate read GetCertificates;
    property PrivateKeys[i: Integer]: TfrxRSAPrivateKey read GetPrivateKeys;
  public
    constructor Create(ADebugLog: TLogList = nil);
    destructor Destroy; override;
    procedure LoadFromFile(AFileName: string);
    procedure LoadFromStream(AStream: TStream);
    function IsCheckPassword(Password: UTF8String): Boolean;
    procedure Parse;
    class function DerivingKey(Password: UTF8String; Salt: AnsiString; ID: Byte;
      Algorithm: TOIDName; Iteration: Integer; Len: Cardinal): AnsiString;

    property Chain: TfrxX509Certificate read FChain;
    property ChainLen: Integer read FChainLen;
  end;

implementation

uses
  frxHash, frxCipher;

const
  UnknownStructure = 'Unknown structure.';


function PKCS7ProcessData(Data: TfrxASN1Container): AnsiString;
begin
// Fix for using OCTET STRING as a Container like
//    [0] (1 elem)
//      OCTET STRING (1 elem)
//        OCTET STRING (1 elem)
  while (Data[0] is TfrxASN1Container) and (Data[0].IsTag(ASN1_TAG_OCTET_STRING)) do
  begin
    Data := TfrxASN1Container(Data[0]);
    RaiseIf(Data.IsEmpty, UnknownStructure);
  end;

  RaiseIf(Data[0].IsNot(ASN1_TAG_OCTET_STRING), UnknownStructure);
  Result := TfrxASN1Data(Data[0]).Data;
end;

function PKCS7ProcessEncryptedData(Content: TfrxASN1Container; Password: UTF8String): AnsiString;
const
  InvalidEncryptedData = 'Invalid Encrypted Data.';
var
  Version: TfrxASN1Base;
  EncryptedData, EncryptedContentInfo: TfrxASN1Container;
begin
//  RaiseIf(Password = '', 'Empty Password');

// [0]
  RaiseIf(Content[0].IsNot(ASN1_TAG_SEQUENCE), InvalidEncryptedData);
  EncryptedData := Content[0] as TfrxASN1Container;

//   EncryptedData ::= SEQUENCE {
//     version Version,
//     encryptedContentInfo EncryptedContentInfo }
  RaiseIf(EncryptedData.Count < 2, InvalidEncryptedData);

  Version := EncryptedData[0];
  RaiseIf(not (Version is TfrxASN1Integer), InvalidEncryptedData);
  RaiseIf(TfrxASN1Integer(Version).Value <> 0, 'Invalid Encryption Algorithm Version.');

//   EncryptedContentInfo ::= SEQUENCE {
//     contentType ContentType,
//     contentEncryptionAlgorithm
//       ContentEncryptionAlgorithmIdentifier,
//     encryptedContent
//       [0] IMPLICIT EncryptedContent OPTIONAL }
//   EncryptedContent ::= OCTET STRING
  RaiseIf(not (EncryptedData[1] is TfrxASN1Container) or
          (TfrxASN1Container(EncryptedData[1]).Count < 3), InvalidEncryptedData);
  EncryptedContentInfo := EncryptedData[1] as TfrxASN1Container;

  Result := EncriptData(EncryptedContentInfo[1], EncryptedContentInfo[2], Password);
end;

function ExtractPKCS7Info(ContentInfo: TfrxASN1Container; Password: UTF8String; DebugLog: TLogList = nil): AnsiString;
var
  ContentType: TfrxASN1Base;
  Content: TfrxASN1Container;
begin

//   ContentInfo ::= SEQUENCE {
//     contentType ContentType,
//     content
//       [0] EXPLICIT ANY DEFINED BY contentType OPTIONAL }

  RaiseIf(ContentInfo.IsEmpty, 'ContentInfo.IsEmpty: ' + UnknownStructure, DebugLog);
//   ContentType ::= OBJECT IDENTIFIER
  ContentType := ContentInfo[0];
  RaiseIf(ContentType.IsNot(ASN1_TAG_OBJECT_ID), 'ContentType.IsNot(ASN1_TAG_OBJECT_ID): ' + UnknownStructure, DebugLog);

  if ContentInfo.Count >= 2 then
    if ContentInfo[1].IsTag(ASN1_TAG_EOC) and ContentInfo[1].IsClass(ASN1_CLASS_CONTEXT) and
       (ContentInfo[1] is TfrxASN1Container) and not TfrxASN1Container(ContentInfo[1]).IsEmpty then
    begin
      Content := ContentInfo[1] as TfrxASN1Container;

      case TfrxASN1ObjectID(ContentType).OIDName of
        OID_pkcs7_data:
          begin
            DebugLog.Add('OID_pkcs7_data');
            Result := PKCS7ProcessData(Content);
          end;
//      OID_pkcs7_signedData:
//      OID_pkcs7_envelopedData:
//      OID_pkcs7_signedAndEnvelopedData:
//      OID_pkcs7_digestedData:
        OID_pkcs7_encryptedData: // The encrypted-data content type shall have ASN.1 type EncryptedData:
          begin
            DebugLog.Add('OID_pkcs7_encryptedData');
            Result := PKCS7ProcessEncryptedData(Content, Password);
          end;
      else
        RaiseIf(True, 'TfrxASN1ObjectID(ContentType).OIDName: Unsupported document.', DebugLog);
      end
    end
    else
      RaiseIf(True, 'ExtractPKCS7Info: ' + UnknownStructure, DebugLog);
end;

function HMAC(const Key, Text: AnsiString; HashAlgorithm: TOIDName; DebugLog: TLogList = nil): AnsiString;
var
  HC: TfrxHashClass;
  H: TfrxHash;
  PAD, WrkPAD: array [0 .. 63] of Byte;
  HashDigest: TfrxHashDigest;
  i: Integer;
begin
  HC := OIDtoHashClass(HashAlgorithm);
  RaiseIf(HC = nil, 'Algorithm not supported', DebugLog);
  H := HC.Create;

  try
    FillChar(PAD, SizeOf(PAD), 0);
    if Length(Key) <= 64 then
      Move(Key[1], PAD, Length(Key))
    else
    begin
      H.Initialize;
      H.UpdateByAnsi(Key);
      H.Finalize;
      H.MoveDigestTo(PAD);
    end;
    for i := 0 to 63 do
      WrkPAD[i] := PAD[i] xor $36;
    H.Initialize;
    H.Update(WrkPAD, 64);
    H.UpdateByAnsi(Text);
    H.Finalize;
    H.MoveDigestTo(HashDigest);
    for i := 0 to 63 do
      WrkPAD[i] := PAD[i] xor $5C;
    H.Initialize;
    H.Update(WrkPAD, 64);
    H.Update(HashDigest, H.DigestSize);
    H.Finalize;

    Result := H.DigestToAnsi;
  finally
    H.Free;
  end;
end;

{ TPKCS12Document }

procedure TfrxPKCS12Document.Clear;
begin
  FValidPassword := '';
  FContentInfo := '';
  ClearMacData;
  FCertificates.Clear;
  FPrivateKeys.Clear;
end;

procedure TfrxPKCS12Document.ClearMacData;
begin
  FMacSalt := '';
  FMacAlgorithmName := OID_Undef;
  FMacDigest := '';
  FMacIterations := 1; // Default
end;

constructor TfrxPKCS12Document.Create(ADebugLog: TLogList = nil);
begin
  FDebugLog := ADebugLog;
  FCertificates := TfrOwnObjList.Create;
  FPrivateKeys := TfrOwnObjList.Create;
end;

class function TfrxPKCS12Document.DerivingKey(Password: UTF8String;
  Salt: AnsiString; ID: Byte; Algorithm: TOIDName; Iteration: Integer;
  Len: Cardinal): AnsiString;

  procedure FillData(out OutData: AnsiString; out OutLen: Integer; InData: AnsiString);
  var
    InLen: Integer;
    i: Integer;
  begin
    InLen := Length(InData);
    if InLen and $3F = 0 then
    begin
      OutLen := InLen;
      OutData := InData;
    end
    else
    begin
      OutLen := ((InLen shr 6) + 1) shl 6;
      SetLength(OutData, OutLen);
      for i := 0 to OutLen - 1 do
        OutData[i + 1] := InData[(i mod InLen) + 1];
    end;

  end;
var
  NormalizedPassword: AnsiString;
  i : Cardinal;
  j, SLen, PLen: Integer;
  V: Integer;
  D, S, P, A, B: AnsiString;
  H: TfrxHash;
  HC: TfrxHashClass;
begin
  Result := '';
  HC := OIDtoHashClass(Algorithm);
  if (Len = 0) or (HC = nil) then
    Exit;

  NormalizedPassword := NormalizePassword(PassWord);

  V := 64;
  SetLength(D, V);
  FillChar(D[1], V, ID);

  FillData(S, SLen, Salt);

  FillData(P, PLen, NormalizedPassword);

  SetLength(B, V);
  SetLength(Result, Len);
  H := HC.Create;
  try
    i := 0;
    while True do
    begin
      H.Initialize;
      H.Iterate(D + S + P, Iteration);
      A := H.DigestToAnsi;

      PartCopy(A, Result, i);
      Inc(i, H.DigestSize);
      if i >= Len then
        Break;

      j := 0;
      while j < V do
      begin
        PartCopy(A, B, j);
        Inc(j, H.DigestSize);
      end;

      j := 0;
      while j < SLen do
      begin
        PartCopy2(B, S, j);
        Inc(j, V);
      end;

      j := 0;
      while j < PLen do
      begin
        PartCopy2(B, P, j);
        Inc(j, V);
      end;
    end;
  finally
    H.Free;
  end;
end;

destructor TfrxPKCS12Document.Destroy;
begin
  FPrivateKeys.Free;
  FCertificates.Free;
  inherited;
end;

function TfrxPKCS12Document.GetCertificates(i: Integer): TfrxX509Certificate;
begin
  Result := TfrxX509Certificate(FCertificates[i]);
end;

function TfrxPKCS12Document.GetPrivateKeys(i: Integer): TfrxRSAPrivateKey;
begin
  Result := TfrxRSAPrivateKey(FPrivateKeys[i]);
end;

function TfrxPKCS12Document.IsCheckPassword(Password: UTF8String): Boolean;
var
  Key: AnsiString;
  Digest: AnsiString;
  HSize: Cardinal;
begin
  HSize := OIDtoHashClass(FMacAlgorithmName).DigestSize;
  Key := DerivingKey(Password, FMacSalt, 3, FMacAlgorithmName, FMacIterations, HSize);

  try
    Digest := HMAC(Key, FContentInfo, FMacAlgorithmName, FDebugLog);
  except
    Result := False;
    Exit;
  end;

  Result := FMacDigest = Digest;

  if Result then
    FValidPassword := Password;
end;

procedure TfrxPKCS12Document.LoadFromFile(AFileName: string);
var
  FS: TFileStream;
begin
  FS := TFileStream.Create(AFileName, fmOpenRead);
  try
    LoadFromStream(FS);
  finally
    FS.Free;
  end;
end;

procedure TfrxPKCS12Document.LoadFromStream(AStream: TStream);
var
  PFX: TfrxASN1Container;
  Version, AuthSafe, MacData: TfrxASN1Base;
  FASN1Doc: TfrxASN1Document;
begin
  Clear;
  FASN1Doc := TfrxASN1Document.Create;
  try
    FASN1Doc.LoadFromStream(AStream);
//  PFX ::= SEQUENCE {
//      version     INTEGER {v3(3)}(v3,...),
//      authSafe    ContentInfo,
//      macData     MacData OPTIONAL }
    RaiseIf((FASN1Doc.Count = 0) or FASN1Doc[0].IsNot(ASN1_TAG_SEQUENCE), 'ASN1 sequence not found.', FDebugLog);

    PFX := FASN1Doc[0] as TfrxASN1Container;
    RaiseIf(PFX.Count < 2, UnknownStructure);

    Version := PFX[0]; // version     INTEGER {v3(3)}(v3,...)
    RaiseIf(Version.IsNot(ASN1_TAG_INTEGER) or (TfrxASN1Integer(Version).Value <> 3), 'Invalid version of document.', FDebugLog);

    AuthSafe := PFX[1]; // authSafe    ContentInfo
    RaiseIf(AuthSafe.IsNot(ASN1_TAG_SEQUENCE), 'PKCS#7 information not found.', FDebugLog);
    FContentInfo := ExtractPKCS7Info(AuthSafe as TfrxASN1Container, '', FDebugLog);

    if PFX.Count > 2 then // macData     MacData OPTIONAL
    begin
      MacData := PFX[2];
      RaiseIf(MacData.IsNot(ASN1_TAG_SEQUENCE), 'MacData information not found.', FDebugLog);
      LoadMacData(MacData as TfrxASN1Container);
    end;
  finally
    FASN1Doc.Free;
  end;
end;

procedure TfrxPKCS12Document.LoadMacData(MacData: TfrxASN1Container);
const
  UnknownMacDataStructure = 'Unknown MacData structure.';
  UnknownDigestStructure = 'Unknown digest structure.';
var
  Mac, DigestAlgorithm: TfrxASN1Container;
  Digest, MacSalt, Iterations: TfrxASN1Base;
begin
  RaiseIf(MacData.Count < 2, 'MacData.Count < 2: ' + UnknownMacDataStructure, FDebugLog);
//   MacData ::= SEQUENCE {
//       mac         DigestInfo,
//       macSalt     OCTET STRING,
//       iterations  INTEGER DEFAULT 1 }
  ClearMacData;
  // MacData.Mac
//   DigestInfo ::= SEQUENCE {
//     digestAlgorithm DigestAlgorithmIdentifier,
//     digest Digest }
  RaiseIf(MacData[0].IsNot(ASN1_TAG_SEQUENCE), 'MacData[0].IsNot(ASN1_TAG_SEQUENCE): ' + UnknownMacDataStructure, FDebugLog);
  Mac := TfrxASN1Container(MacData[0]);
  RaiseIf(Mac.Count <> 2, 'Mac.Count <> 2: ' + UnknownDigestStructure, FDebugLog);
    // MacData.Mac.DigestAlgorithm
  RaiseIf(Mac[0].IsNot(ASN1_TAG_SEQUENCE), 'Mac[0].IsNot(ASN1_TAG_SEQUENCE)' + UnknownDigestStructure, FDebugLog);
  DigestAlgorithm := TfrxASN1Container(Mac[0]);
  RaiseIf((DigestAlgorithm.IsEmpty) or DigestAlgorithm[0].IsNot(ASN1_TAG_Object_ID), UnknownDigestStructure, FDebugLog);
  FMacAlgorithmName := TfrxASN1ObjectID(DigestAlgorithm[0]).OIDName;
  RaiseIf(FMacAlgorithmName <> OID_sha1, 'Unsupported digest algorithm.', FDebugLog);
    // MacData.Mac.Digest
//   Digest ::= OCTET STRING
  Digest := Mac[1];
  RaiseIf(Digest.IsNot(ASN1_TAG_OCTET_STRING), 'Digest.IsNot(ASN1_TAG_OCTET_STRING): ' + UnknownDigestStructure, FDebugLog);
  FMacDigest := TfrxASN1Data(Digest).Data;

  // MacData.MacSalt
  MacSalt := MacData[1];
  RaiseIf(MacSalt.IsNot(ASN1_TAG_OCTET_STRING), 'MacSalt.IsNot(ASN1_TAG_OCTET_STRING):' + UnknownMacDataStructure, FDebugLog);
  FMacSalt := TfrxASN1Data(MacSalt).Data;

  // MacData.Iterations
  if MacData.Count > 2 then
  begin
    Iterations := MacData[2];
    RaiseIf(Iterations.IsNot(ASN1_TAG_INTEGER) or (TfrxASN1Integer(Iterations).IsOver64Bit), UnknownMacDataStructure, FDebugLog);
    FMacIterations := TfrxASN1Integer(Iterations).Value;
  end
  else // DEFAULT 1
    FMacIterations := 1;
end;

class function TfrxPKCS12Document.NormalizePassword(Password: UTF8String): AnsiString;
var
  Pass: WideString;
  i: Integer;
  WCh: Word;
begin
  Pass := {$IFDEF DELPHI12} UTF8ToWideString(Password);
          {$ELSE}           UTF8Decode(Password);
          {$ENDIF}
  SetLength(Result, (Length(Pass) + 1) * 2);
  for i := 1 to Length(Pass) do
  begin
    WCh := Word(Pass[i]);
    Result[i shl 1 - 1] := AnsiChar(Byte(WCh shr 8));
    Result[i shl 1] := AnsiChar(Byte(WCh and $FF));
  end;
  FillChar(Result[Length(Result) - 1], 2, 0);
end;

procedure TfrxPKCS12Document.Parse;
var
  AuthSafe, SafeContents: TfrxASN1Container;
  i, j: Integer;
  Item: TfrxASN1Base;
  Bag: AnsiString;
  Certificate: TfrxX509Certificate;
begin
  Item := nil; // Remove warning
  try
    Item := ReadASN1Object(FContentInfo);
  except
    on ESignException do
      RaiseIf(True, 'Parse - ReadASN1Object: AuthenticatedSafe cannot loaded', FDebugLog);
  end;

  AuthSafe := TfrxASN1Container(Item);
  FChain := nil;
  FChainLen := 0;
  FDebugLog.Add('AuthSafe.Count: ' + IntToStr(AuthSafe.Count));
  try
    for i := 0 to AuthSafe.Count - 1 do
      if AuthSafe[i].IsTag(ASN1_TAG_SEQUENCE) then
      begin
        FDebugLog.Add('AuthSafe[' + IntToStr(i) + '].IsTag(ASN1_TAG_SEQUENCE)');
        Bag := ExtractPKCS7Info(TfrxASN1Container(AuthSafe[i]), FValidPassword, FDebugLog);
        Item := ReadASN1Object(Bag);
        try
          if Item.IsTag(ASN1_TAG_SEQUENCE) then
          begin
            // SafeContents ::= SEQUENCE OF SafeBag
            SafeContents := TfrxASN1Container(Item);
            FDebugLog.Add('SafeContents.Count: ' + IntToStr(SafeContents.Count));
            for j := 0 to SafeContents.Count - 1 do
              if SafeContents[j].IsTag(ASN1_TAG_SEQUENCE) then
              begin
                FDebugLog.Add('SafeContents[' + IntToStr(j) + '].IsTag(ASN1_TAG_SEQUENCE)');
                ProcessSafeBag(SafeContents[j] as TfrxASN1Container);
              end;
          end;
        finally
          Item.Free;
        end;
      end;
    RaiseIf(FCertificates.Count = 0,
      'Certificates not found in pfx document', FDebugLog);
    RaiseIf(FPrivateKeys.Count = 0,
      'Private key not found in pfx document', FDebugLog);
    for i := 0 to FPrivateKeys.Count - 1 do
    begin
      for j := 0 to FCertificates.Count - 1 do
        if Certificates[j].CheckPrivateKey(PrivateKeys[i]) then
        begin
          FChain := Certificates[j];
          Break;
        end;
      if FChain <> nil then
        Break;
    end;
    RaiseIf(FChain = nil, 'Not found pair certificate and private key', FDebugLog);
    for i := 0 to FCertificates.Count - 1 do
      for j := 0 to FCertificates.Count - 1 do
        if (i <> j) and Certificates[i].CheckOwner(Certificates[j]) then
          Break;
    Certificate := FChain;
    while Certificate <> nil do
    begin
      Certificate := Certificate.Owner;
      Inc(FChainLen);
    end;
  finally
    AuthSafe.Free;
  end;
end;

class procedure TfrxPKCS12Document.PartCopy(Source: AnsiString; var Dest: AnsiString; APos: Integer);
var
  MoveCount: Integer;
begin
  MoveCount := Min(Length(Source), Length(Dest) - APos);
  if MoveCount > 0 then
    Move(Source[1], Dest[1 + APos], MoveCount);
end;

class procedure TfrxPKCS12Document.PartCopy2(Source: AnsiString; var Dest: AnsiString; APos: Integer);
var
  i: Integer;
  W: Word;
  D, S: PByteArray;
begin
  if Source = '' then
    Exit;

  if (APos < 0) or (Length(Dest) < Length(Source) + APos) then
    raise Exception.Create('Invalid parameters');

  D := @Dest[APos + 1];
  S := @Source[1];
  W := 1;
  for i := Length(Source) - 1 downto 0 do
  begin
    W := D^[i] + S^[i] + W;
    D^[i] := Lo(W);
    W := Hi(W);
  end;
end;

procedure TfrxPKCS12Document.ProcessSafeBag(SafeBag: TfrxASN1Container);
var
  BagId: TOIDName;
  BagValue, BagAttributes: TfrxASN1Container;
  i: Integer;
begin
// SafeBag ::= SEQUENCE {
//     bagId          BAG-TYPE.&id ({PKCS12BagSet})
//     bagValue       [0] EXPLICIT BAG-TYPE.&Type({PKCS12BagSet}{@bagId}),
//     bagAttributes  SET OF PKCS12Attribute OPTIONAL }
  if (SafeBag.Count < 3) or
     SafeBag[0].IsNot(ASN1_TAG_OBJECT_ID) or
     not (SafeBag[1] is TfrxASN1Container) then
    Exit;

  BagId := TfrxASN1ObjectID(SafeBag[0]).OIDName;

  BagValue := TfrxASN1Container(SafeBag[1]);

  BagAttributes := nil;
  if SafeBag[2] is TfrxASN1Container then
    BagAttributes := SafeBag[2] as TfrxASN1Container;

//  PKCS12BagSet BAG-TYPE ::= { keyBag | pkcs8ShroudedKeyBag | certBag | crlBag | secretBag | safeContentsBag }
  case BagId of
    OID_keyBag, OID_pkcs_8ShroudedKeyBag:
      begin
        FDebugLog.Add('BagId: OID_keyBag, OID_pkcs_8ShroudedKeyBag');
        ReadPrivateKey(BagId, BagValue, BagAttributes);
      end;
    OID_certBag:
      begin
        FDebugLog.Add('BagId: OID_certBag');
        ReadCertificate(BagValue, BagAttributes);
      end;
    OID_crlBag: ;
    OID_secretBag: ;
    OID_safeContentsBag:
// This recursive structure allows for arbitrary nesting of multiple KeyBags,
// PKCS8ShroudedKeyBags, CertBags, CRLBags, and SecretBags within the top-level SafeContents.
      begin
        FDebugLog.Add('BagId: OID_safeContentsBag; BagValue.Count: ' + IntToStr(BagValue.Count));
        for i := 0 to BagValue.Count - 1 do
          if BagValue[i] is TfrxASN1Container then
          begin
            FDebugLog.Add('BagValue[' + IntToStr(i) + '] is TfrxASN1Container');
            ProcessSafeBag(BagValue[i] as TfrxASN1Container);
          end;
      end;
  end;
end;

procedure TfrxPKCS12Document.ReadCertificate(BagValue, BagAttributes: TfrxASN1Container);
var
  CertBag, CertValue: TfrxASN1Container;
  Data: AnsiString;
  CertObj: TfrxASN1Base;
  Certificate: TfrxX509Certificate;
begin
//   CertBag ::= SEQUENCE {
//       certId      BAG-TYPE.&id   ({CertTypes}),
//       certValue   [0] EXPLICIT BAG-TYPE.&Type ({CertTypes}{@certId}) }
//
//   x509Certificate BAG-TYPE ::=
//       {OCTET STRING IDENTIFIED BY {certTypes 1}}
//       -- DER-encoded X.509 certificate stored in OCTET STRING
//   sdsiCertificate BAG-TYPE ::=
//       {IA5String IDENTIFIED BY {certTypes 2}}
//       -- Base64-encoded SDSI certificate stored in IA5String
//
//   CertTypes BAG-TYPE ::= { x509Certificate | sdsiCertificate }
  if BagValue.IsEmpty then
  begin
    FDebugLog.Add('BagValue.IsEmpty');
    Exit;
  end;

  if not (BagValue[0] is TfrxASN1Container) then
  begin
    FDebugLog.Add('not (BagValue[0] is TfrxASN1Container)');
    Exit;
  end;

  CertBag := TfrxASN1Container(BagValue[0]); // [0]

  if (CertBag.Count < 2) or
     not (CertBag[0] is TfrxASN1ObjectID) or
     (TfrxASN1ObjectID(CertBag[0]).OIDName <> OID_x509Certificate) or
     not (CertBag[1] is TfrxASN1Container) or
     (TfrxASN1Container(CertBag[1]).IsEmpty) then
  begin
    FDebugLog.Add('CertBag: Exit');
    Exit;
  end;

  CertValue := TfrxASN1Container(CertBag[1]);
  if CertValue[0].IsNot(ASN1_TAG_OCTET_STRING) then
  begin
    FDebugLog.Add('CertValue[0].IsNot(ASN1_TAG_OCTET_STRING)');
    Exit;
  end;
  Data := TfrxASN1Data(CertValue[0]).Data;
  if Data = '' then
  begin
    FDebugLog.Add('Data = ""');
    Exit;
  end;

  try
    CertObj := ReadASN1Object(Data);
  except
    on Exception do
      begin
        CertObj := nil;
        FDebugLog.Add('CertObj: raise ?');
      end;
  end;
  if CertObj = nil then
    Exit;

  try
    if not (CertObj is TfrxASN1Container) or
       ((CertObj as TfrxASN1Container).IsEmpty) or
       not ((CertObj as TfrxASN1Container)[0] is TfrxASN1Container) then
    begin
      FDebugLog.Add('CertObj: Exit');
      Exit;
    end;
    Certificate := TfrxX509Certificate.Create;
    try
      Certificate.Load(CertObj as TfrxASN1Container);
    except
      on Exception do
        begin
          FDebugLog.Add('Certificate: raise ?');
          FreeAndNil(Certificate);
        end;
    end;
    if Certificate <> nil then
      FCertificates.Add(Certificate);
  finally
    CertObj.Free;
  end;
end;

procedure TfrxPKCS12Document.ReadPrivateKey(BagId: TOIDName; BagValue, BagAttributes: TfrxASN1Container);
var
  PK: TfrxRSAPrivateKey;
begin
  PK := TfrxRSAPrivateKey.Create;
  try
    case BagId of
      OID_keyBag:               // KeyBag ::= PrivateKeyInfo (PKCS #8)
        begin
          FDebugLog.Add('BagId: OID_keyBag');
          PK.Read(BagValue, BagAttributes);
        end;
      OID_pkcs_8ShroudedKeyBag: // PKCS8ShroudedKeyBag ::= EncryptedPrivateKeyInfo (PKCS #8)
        begin
          FDebugLog.Add('BagId: OID_pkcs_8ShroudedKeyBag');
          PK.ReadCrypted(BagValue, BagAttributes, FValidPassword);
        end;
    end;
  except
    on ESignException do
      begin
        FreeAndNil(PK);
        FDebugLog.Add('raise ?');
      end;
  end;
  if PK <> nil then
    FPrivateKeys.Add(PK);
end;

end.
