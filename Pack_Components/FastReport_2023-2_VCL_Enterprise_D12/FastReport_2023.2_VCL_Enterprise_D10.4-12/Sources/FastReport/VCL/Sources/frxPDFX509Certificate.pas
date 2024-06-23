unit frxPDFX509Certificate;

{$I frx.inc}

interface

uses
  {$IFNDEF Linux}
  Windows,
  {$ENDIF}
  SysUtils, Classes,
  frCoreClasses, frUtils,
  frxHelpers, frxASN1;

type

  TfrxRSAPrivateKey = class
  private
    FVersion: Integer;
    FAlgorithmName: TOIDName;

    function GetExponent1: TfrxASN1Integer;
    function GetExponent2: TfrxASN1Integer;
    function GetModulus: TfrxASN1Integer;
    function GetPrime1: TfrxASN1Integer;
    function GetPrime2: TfrxASN1Integer;
    function GetPrivateExponent: TfrxASN1Integer;
    function GetPublicExponent: TfrxASN1Integer;
    function GetCoeficient: TfrxASN1Integer;
  protected
    FKey: TfrxASN1Container;
  public
    destructor Destroy; override;
    procedure Read(PrivateKeyInfo: TfrxASN1Container;
      Attributes: TfrxASN1Container);
    procedure ReadCrypted(EncryptedPrivateKeyInfo,
      Attributes: TfrxASN1Container; Password: UTF8String);

    property Version: Integer read FVersion;
    property Modulus: TfrxASN1Integer read GetModulus;                 // n
    property PublicExponent: TfrxASN1Integer read GetPublicExponent;   // e
    property PrivateExponent: TfrxASN1Integer read GetPrivateExponent; // d
    property Prime1: TfrxASN1Integer read GetPrime1;                   // p
    property Prime2: TfrxASN1Integer read GetPrime2;                   // q
    property Exponent1: TfrxASN1Integer read GetExponent1;             // d mod (p - 1)
    property Exponent2: TfrxASN1Integer read GetExponent2;             // d mod (q - 1)
    property Coeficient: TfrxASN1Integer read GetCoeficient;           // (inverse of q) mod p
  end;

  TfrxX509KeyValue = class
  private
    FKey: TOIDName;
    FValue: TfrxASN1Base;
  public
    constructor Create(AKey: TOIDName; AValue: TfrxASN1Base);
    function IsEqual(X509KeyValue: TfrxX509KeyValue): Boolean;

    property Key: TOIDName read FKey;
    property Value: TfrxASN1Base read FValue;
  end;

  TfrxX509KeyValueList = class(TfrOwnObjList)
  private
    function GetX509KeyValue(Index: Integer): TfrxX509KeyValue;
  public
    procedure AddX509KeyValue(Key: TOIDName; Value: TfrxASN1Base);
    function IsEqual(KeyValueList: TfrxX509KeyValueList): Boolean;

    property Items[Index: Integer]: TfrxX509KeyValue read GetX509KeyValue; default;
  end;

  TfrxX509Certificate = class
  private
    FPrivateKey: TfrxRSAPrivateKey;
    FIssuer: TfrxX509KeyValueList;
    FSubject: TfrxX509KeyValueList;
    FPublicKey: TfrxASN1Container;
    FASN1Certificate: TfrxASN1Container;
    FOwner: TfrxX509Certificate;
//    FValidTo: TDateTime;
//    FValidFrom: TDateTime;

    procedure LoadValidity(Validity: TfrxASN1Base);
    procedure LoadSubjectPublicKey(subjectPublicKeyInfo: TfrxASN1Base);
    procedure LoadName(ASN1Name: TfrxASN1Base; Name: TfrxX509KeyValueList);
    function GetCommonName: WideString;
    function GetDistinguishedName: WideString;
  protected
    function GetNamePart(Key: TOIDName; out Part: WideString): Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Load(Container: TfrxASN1Container);
    function CheckPrivateKey(PrivateKey: TfrxRSAPrivateKey): Boolean;
    function CheckOwner(Owner: TfrxX509Certificate): Boolean;

    class function GetVersionShift(Version: TfrxASN1Base): Integer;

    property PrivateKey: TfrxRSAPrivateKey read FPrivateKey;
    property Owner: TfrxX509Certificate read FOwner;
    property ASN1Certificate: TfrxASN1Container read FASN1Certificate;
//    property ValidFrom: TDateTime read FValidFrom;
//    property ValidTo: TDateTime read FValidTo;
    property CommonName: WideString read GetCommonName;
    property DistinguishedName: WideString read GetDistinguishedName;
  end;

function EncriptData(AlgorithmIdentifier, Data: TfrxASN1Base;
  Password: UTF8String): AnsiString;

implementation

uses frxCipher, frxPDFPFX, frxUtils;

const
  InvalidEncryptedData = 'Invalid Encrypted Data.';
  InvalidNameOfCertificate = 'Invalid name of certificate';
  UnsupportedAlgorithm = 'Unsupported algorithm';
  InvalidPrivateKey = 'Invalid private key';

function EncriptData(AlgorithmIdentifier, Data: TfrxASN1Base;
  Password: UTF8String): AnsiString;
var
  i: Integer;
  EncryptedData, Salt: AnsiString;
  Container, EncryptionAlgorithm, Parameters: TfrxASN1Container;
  Algorithm: TfrxASN1ObjectID;
  IVLen, KeyLen: Integer;
  CipherClass: TfrxCipherClass;
  IV, Key: AnsiString;
  Iterations: Cardinal;
begin
  if Data is TfrxASN1Container then
  begin
//  Fix for EncryptedContent
//    [0] (2 elem)
//      OCTET STRING (... byte) ...
//      OCTET STRING (... byte) ...
//
//  https://tools.ietf.org/html/rfc5652
//  EncryptedContent ::= OCTET STRING
//
    Container := TfrxASN1Container(Data);
    RaiseIf(Container.IsEmpty, InvalidEncryptedData);
    EncryptedData := '';
    for i := 0 to Container.Count - 1 do
    begin
      RaiseIf(not (Container[i] is TfrxASN1Data), InvalidEncryptedData);
      EncryptedData := EncryptedData + TfrxASN1Data(Container[i]).Data;
    end;
  end
  else if Data is TfrxASN1Data then
    EncryptedData := TfrxASN1Data(Data).Data
  else
    raise ESignException.Create(InvalidEncryptedData);

  // AlgorithmIdentifier  ::=  SEQUENCE  {
  //   algorithm   OBJECT IDENTIFIER,
  //   parameters  ANY DEFINED BY algorithm OPTIONAL }
  RaiseIf(AlgorithmIdentifier.IsNot(ASN1_TAG_SEQUENCE), InvalidEncryptedData);
  EncryptionAlgorithm := TfrxASN1Container(AlgorithmIdentifier);

  RaiseIf((EncryptionAlgorithm.Count < 2) or
    (EncryptionAlgorithm[0].IsNot(ASN1_TAG_OBJECT_ID)) or
    (EncryptionAlgorithm[1].IsNot(ASN1_TAG_SEQUENCE)), InvalidEncryptedData);

  Algorithm := TfrxASN1ObjectID(EncryptionAlgorithm[0]);

  Parameters := EncryptionAlgorithm[1] as TfrxASN1Container;
  RaiseIf(Parameters.IsEmpty or Parameters[0].IsNot(ASN1_TAG_OCTET_STRING),
    InvalidEncryptedData);

  Salt := TfrxASN1Data(Parameters[0]).Data;

  if (Parameters.Count = 1) or Parameters[1].IsNot(ASN1_TAG_INTEGER) then
    Iterations := 1
  else
    Iterations := TfrxASN1Integer(Parameters[1]).Value;

  case Algorithm.OIDName of
    OID_pbeWithSHA1And3_KeyTripleDES_CBC:
      begin
        IVLen := 8;
        KeyLen := 24;
        CipherClass := TfrxDES3Cipher;
      end;
    OID_pbeWithSHA1And2_KeyTripleDES_CBC:
      begin
        IVLen := 8;
        KeyLen := 16;
        CipherClass := TfrxDES3Cipher;
      end;
    OID_pbeWithSHA1And128BitRC2_CBC:
      begin
        IVLen := 8;
        KeyLen := 16;
        CipherClass := TfrxRC2Cipher;
      end;
    OID_pbeWithSHA1And40BitRC2_CBC:
      begin
        IVLen := 8;
        KeyLen := 5;
        CipherClass := TfrxRC2Cipher;
      end;
  else
    raise ESignException.Create('Invalid Encryption Algorithm.');
  end;

  IV := TfrxPKCS12Document.DerivingKey(Password, Salt, 2, OID_sha1,
    Iterations, IVLen);
  Key := TfrxPKCS12Document.DerivingKey(Password, Salt, 1, OID_sha1,
    Iterations, KeyLen);
  with CipherClass.Create(Key, IV) do
    try
      Result := DecodeToStr(EncryptedData);
    finally
      Free;
    end;
end;

function ProcessEncryptedData(EncryptedPrivateKeyInfo: TfrxASN1Container;
  Password: UTF8String): AnsiString;
begin
//  RaiseIf(Password = '', 'Empty Password');

  // [0]
  RaiseIf(EncryptedPrivateKeyInfo[0].IsNot(ASN1_TAG_SEQUENCE),
    InvalidEncryptedData);
  EncryptedPrivateKeyInfo := EncryptedPrivateKeyInfo[0] as TfrxASN1Container;

  // EncryptedPrivateKeyInfo ::= SEQUENCE {
  // encryptionAlgorithm  EncryptionAlgorithmIdentifier,
  // encryptedData        EncryptedData }
  RaiseIf(EncryptedPrivateKeyInfo.Count < 2, InvalidEncryptedData);

  Result := EncriptData(EncryptedPrivateKeyInfo[0], EncryptedPrivateKeyInfo[1],
    Password);
end;

{ TPrivateKey }

destructor TfrxRSAPrivateKey.Destroy;
begin
  FreeAndNil(FKey);
  inherited;
end;

function TfrxRSAPrivateKey.GetCoeficient: TfrxASN1Integer;
begin
  Result := FKey[8] as TfrxASN1Integer;
end;

function TfrxRSAPrivateKey.GetExponent1: TfrxASN1Integer;
begin
  Result := FKey[6] as TfrxASN1Integer;
end;

function TfrxRSAPrivateKey.GetExponent2: TfrxASN1Integer;
begin
  Result := FKey[7] as TfrxASN1Integer;
end;

function TfrxRSAPrivateKey.GetModulus: TfrxASN1Integer;
begin
  Result := FKey[1] as TfrxASN1Integer;
end;

function TfrxRSAPrivateKey.GetPrime1: TfrxASN1Integer;
begin
  Result := FKey[4] as TfrxASN1Integer;
end;

function TfrxRSAPrivateKey.GetPrime2: TfrxASN1Integer;
begin
  Result := FKey[5] as TfrxASN1Integer;
end;

function TfrxRSAPrivateKey.GetPrivateExponent: TfrxASN1Integer;
begin
  Result := FKey[3] as TfrxASN1Integer;
end;

function TfrxRSAPrivateKey.GetPublicExponent: TfrxASN1Integer;
begin
  Result := FKey[2] as TfrxASN1Integer;
end;

procedure TfrxRSAPrivateKey.Read(PrivateKeyInfo, Attributes: TfrxASN1Container);
var
  PrivateKeyAlgorithm: TfrxASN1Container;
  KeyData: AnsiString;
  KeyObj: TfrxASN1Base;
  i: Integer;
begin
  // https://tools.ietf.org/html/rfc5208
  // PrivateKeyInfo ::= SEQUENCE {
  // version                   Version,
  // privateKeyAlgorithm       PrivateKeyAlgorithmIdentifier,
  // privateKey                PrivateKey,
  // attributes           [0]  IMPLICIT Attributes OPTIONAL }
  //
  // Attributes ::= SET OF Attribute

  RaiseIf((PrivateKeyInfo.Count < 3)
       or PrivateKeyInfo[0].IsNot(ASN1_TAG_INTEGER)
       or PrivateKeyInfo[1].IsNot(ASN1_TAG_SEQUENCE)
       or PrivateKeyInfo[2].IsNot(ASN1_TAG_OCTET_STRING),
    InvalidPrivateKey);

  // Version ::= INTEGER
  FVersion := TfrxASN1Integer(PrivateKeyInfo[0]).Value;

  // PrivateKeyAlgorithmIdentifier ::= AlgorithmIdentifier
  PrivateKeyAlgorithm := TfrxASN1Container(PrivateKeyInfo[1]);
  RaiseIf(PrivateKeyAlgorithm.IsEmpty or
          PrivateKeyAlgorithm[0].IsNot(ASN1_TAG_OBJECT_ID),
    InvalidPrivateKey);

  FAlgorithmName := TfrxASN1ObjectID(PrivateKeyAlgorithm[0]).OIDName;
  RaiseIf(FAlgorithmName <> OID_rsaEncryption, UnsupportedAlgorithm);

  // PrivateKey ::= OCTET STRING
  KeyData := TfrxASN1Data(PrivateKeyInfo[2]).Data;
  RaiseIf(KeyData = '', InvalidPrivateKey);

  KeyObj := ReadASN1Object(KeyData);
  try
    RaiseIf(not (KeyObj is TfrxASN1Container) or
      (TfrxASN1Container(KeyObj).Count < 8), InvalidPrivateKey);
    for i := 0 to 7 do
      RaiseIf(not (TfrxASN1Container(KeyObj)[i] is TfrxASN1Integer),
        InvalidPrivateKey);
  except
    on Exception do
    begin
      KeyObj.Free;
      raise;
    end;
  end;
  FKey := TfrxASN1Container(KeyObj);
end;

procedure TfrxRSAPrivateKey.ReadCrypted(EncryptedPrivateKeyInfo,
  Attributes: TfrxASN1Container; Password: UTF8String);
var
  Obj: TfrxASN1Base;
  Data: AnsiString;
begin
  Data := ProcessEncryptedData(EncryptedPrivateKeyInfo, Password);
  Obj := ReadASN1Object(Data);
  RaiseIf(not (Obj is TfrxASN1Container), InvalidPrivateKey);
  Read(Obj as TfrxASN1Container, Attributes);
  Obj.Free;
end;

{ TfrxX509Certificate }

function TfrxX509Certificate.CheckOwner(Owner: TfrxX509Certificate): Boolean;
begin
  Result := FIssuer.IsEqual(Owner.FSubject);
  if Result then
    FOwner := Owner;
end;

function TfrxX509Certificate.CheckPrivateKey(PrivateKey: TfrxRSAPrivateKey): Boolean;
var
  Obj: TfrxASN1Base;
  Data1, Data2: AnsiString;
begin
  Result := False;
  if FPublicKey = nil then
    Exit;
  Obj := FPublicKey[0];
  if not (Obj is TfrxASN1Data) then
    Exit;
  Data1 := PrivateKey.Modulus.Data;
  Data2 := TfrxASN1Data(Obj).Data;
  if Length(Data1) <> Length(Data2) then
    Exit;
  Result := CompareMem(@Data1[1], @Data2[1], Length(Data1));
  if Result then
    FPrivateKey := PrivateKey;
end;

constructor TfrxX509Certificate.Create;
begin
  FIssuer := TfrxX509KeyValueList.Create;
  FSubject := TfrxX509KeyValueList.Create;
  FASN1Certificate := nil;
  FPublicKey := nil;
  FOwner := nil;
  FPrivateKey := nil;
end;

destructor TfrxX509Certificate.Destroy;
begin
  FPublicKey.Free;
  FASN1Certificate.Free;
  FIssuer.Free;
  FSubject.Free;
  inherited;
end;

function TfrxX509Certificate.GetCommonName: WideString;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to FSubject.Count - 1 do
    if FSubject[i].FKey = OID_commonName then
    begin
      Result := FSubject[i].Value.DataToWide;
      Exit;
    end;
end;

function TfrxX509Certificate.GetDistinguishedName: WideString;
var
  i: Integer;
  Part: WideString;
begin
  Result := '';
  for i := 0 to FSubject.Count - 1 do
    if GetNamePart(FSubject[i].FKey, Part) then
      Result := Result + frIfStr(Result <> '', ', ') + Part + '=' + FSubject[i].Value.DataToWide;
end;

function TfrxX509Certificate.GetNamePart(Key: TOIDName; out Part: WideString): Boolean;
begin
  Result := True;
  case Key of
    OID_pkcs9_emailAddress:   Part := 'MAIL';
    OID_commonName:           Part := 'CN';
    OID_surname:              Part := 'Surname';
    OID_serialNumber:         Part := 'SERIALNUMBER';
    OID_countryName:          Part := 'C';
    OID_localityName:         Part := 'L';
    OID_stateOrProvinceName:  Part := 'ST';
    OID_streetAddress:        Part := 'STREET';
    OID_organizationName:     Part := 'O';
    OID_organizationUnitName: Part := 'OU';
    OID_title:                Part := 'T';
    OID_postalCode:           Part := 'PC';
    OID_givenName:            Part := 'GivenName';
    OID_initials:             Part := 'Initials';
    OID_generationQualifier:  Part := 'GQ';
    OID_dnQualifier:          Part := 'DNQ';
    OID_pseudonym:            Part := 'Pseudonym';
  else
    Result := True;
  end;
end;

class function TfrxX509Certificate.GetVersionShift(Version: TfrxASN1Base): Integer;
var
  IsPresent: Boolean;
  Ver: Integer;
begin
  // version         [0]  EXPLICIT Version DEFAULT v1,
  // Version  ::=  INTEGER  {  v1(0), v2(1), v3(2)  }
  // -- If present, version MUST be v2 or v3
  with Version do
    IsPresent := IsTag(ASN1_TAG_EOC) and IsClass(ASN1_CLASS_CONTEXT);
  if IsPresent then
  begin
    Ver := TfrxASN1Integer(TfrxASN1Container(Version)[0]).Value;
    RaiseIf(not (Ver in [1..2]), 'Invalid certificate version');
    Result := 1;
  end
  else
    Result := 0;
end;

procedure TfrxX509Certificate.Load(Container: TfrxASN1Container);
var
  tbsCertificate: TfrxASN1Container;
  Shift: Integer;
begin
  // https://tools.ietf.org/html/rfc5280#section-4.1
  // Certificate  ::=  SEQUENCE  {
  // tbsCertificate       TBSCertificate,
  // signatureAlgorithm   AlgorithmIdentifier,
  // signatureValue       BIT STRING  }
  FASN1Certificate := TfrxASN1Container(Container.CreateCopy);

  // TBSCertificate  ::=  SEQUENCE  {
  // version         [0]  EXPLICIT Version DEFAULT v1,
  // serialNumber         CertificateSerialNumber,
  // signature            AlgorithmIdentifier,
  // issuer               Name,
  // validity             Validity,
  // subject              Name,
  // subjectPublicKeyInfo SubjectPublicKeyInfo,
  // issuerUniqueID  [1]  IMPLICIT UniqueIdentifier OPTIONAL,
  tbsCertificate := FASN1Certificate[0] as TfrxASN1Container;

  Shift := TfrxX509Certificate.GetVersionShift(tbsCertificate[0]);

  RaiseIf(tbsCertificate.Count < 6 + Shift, 'Invalid certificate');
  RaiseIf(not (tbsCertificate[0 + Shift] is TfrxASN1Integer),
    'Invalid serial number of certificate');

  LoadName(tbsCertificate[2 + Shift], FIssuer);
  LoadValidity(tbsCertificate[3 + Shift]);
  LoadName(tbsCertificate[4 + Shift], FSubject);
  LoadSubjectPublicKey(tbsCertificate[5 + Shift]);
end;

procedure TfrxX509Certificate.LoadName(ASN1Name: TfrxASN1Base; Name: TfrxX509KeyValueList);
var
  i, j: Integer;
  RDNSequence, RelativeDistinguishedName, AttributeTypeAndValue: TfrxASN1Container;
begin
//   Name ::= CHOICE { -- only one possibility for now --
//     rdnSequence  RDNSequence }
//
//   RDNSequence ::= SEQUENCE OF RelativeDistinguishedName
//
//   RelativeDistinguishedName ::=
//     SET SIZE (1..MAX) OF AttributeTypeAndValue
//
//   AttributeTypeAndValue ::= SEQUENCE {
//     type     AttributeType,
//     value    AttributeValue }
//
//   AttributeType ::= OBJECT IDENTIFIER
//
//   AttributeValue ::= ANY -- DEFINED BY AttributeType
  RaiseIf(not (ASN1Name is TfrxASN1Container), InvalidNameOfCertificate);
  Name.Clear;
  RDNSequence := TfrxASN1Container(ASN1Name);
  for i := 0 to RDNSequence.Count - 1 do
    if RDNSequence[i] is TfrxASN1Container then
    begin
      RelativeDistinguishedName := RDNSequence[i] as TfrxASN1Container;
      for j := 0 to RelativeDistinguishedName.Count - 1 do
        if RelativeDistinguishedName[j] is TfrxASN1Container then
        begin
          AttributeTypeAndValue := RelativeDistinguishedName[j] as TfrxASN1Container;
          if (AttributeTypeAndValue.Count >= 2) and
             (AttributeTypeAndValue[0] is TfrxASN1ObjectID) then
            Name.AddX509KeyValue(TfrxASN1ObjectID(AttributeTypeAndValue[0]).OIDName,
              AttributeTypeAndValue[1]);
        end;
    end;
end;

procedure TfrxX509Certificate.LoadSubjectPublicKey(subjectPublicKeyInfo: TfrxASN1Base);
var
  algorithmIdentifier, subjectPublicKey, Key: TfrxASN1Base;
  EncryptionAlgorithm: TfrxASN1Container;
  Data: AnsiString;
begin
//   SubjectPublicKeyInfo  ::=  SEQUENCE  {
//        algorithmIdentifier  AlgorithmIdentifier,
//        subjectPublicKey     BIT STRING  }
  RaiseIf(not (subjectPublicKeyInfo is TfrxASN1Container) or
          (TfrxASN1Container(subjectPublicKeyInfo).Count < 2),
    InvalidNameOfCertificate);

  algorithmIdentifier := TfrxASN1Container(subjectPublicKeyInfo)[0];
  RaiseIf(not (algorithmIdentifier is TfrxASN1Container), InvalidNameOfCertificate);
  EncryptionAlgorithm := TfrxASN1Container(AlgorithmIdentifier);
  RaiseIf(not (EncryptionAlgorithm[0] is TfrxASN1ObjectID), InvalidNameOfCertificate);
  RaiseIf(TfrxASN1ObjectID(EncryptionAlgorithm[0]).OIDName <> OID_rsaEncryption, UnsupportedAlgorithm);

  subjectPublicKey := TfrxASN1Container(subjectPublicKeyInfo)[1];
  RaiseIf(not (subjectPublicKey is TfrxASN1Data), InvalidNameOfCertificate);
  Data := TfrxASN1Data(subjectPublicKey).Data;
  RaiseIf(Length(Data) < 1, InvalidNameOfCertificate);
  Key := ReadASN1Object(Data, 1);
  try
    RaiseIf(not (Key is TfrxASN1Container), InvalidNameOfCertificate);
    FPublicKey := TfrxASN1Container(Key.CreateCopy);
  finally
    Key.Free;
  end;
end;

procedure TfrxX509Certificate.LoadValidity(Validity: TfrxASN1Base);
begin
  // https://tools.ietf.org/html/rfc5280#section-4.1
  // Validity ::= SEQUENCE {
  // notBefore      Time,
  // notAfter       Time }
  RaiseIf(not (Validity is TfrxASN1Container) or
          (TfrxASN1Container(Validity).Count < 2),
    'Wrong validity data');

  //
  // Time ::= CHOICE {
  // utcTime        UTCTime,
  // generalTime    GeneralizedTime }

  { TODO: Append support of the validity }
  // flcX509Certificate: DecodeX509Validity + X509ValidityParseProc
  // flcASN1: ASN1Parse
end;

{ TfrxX509KeyValue }

constructor TfrxX509KeyValue.Create(AKey: TOIDName; AValue: TfrxASN1Base);
begin
  FKey := AKey;
  FValue := AValue; // Should not freed
end;

function TfrxX509KeyValue.IsEqual(X509KeyValue: TfrxX509KeyValue): Boolean;
begin
  Result := (Key = X509KeyValue.Key) and Value.IsEqual(X509KeyValue.FValue);
end;

{ TfrxX509KeyValueList }

procedure TfrxX509KeyValueList.AddX509KeyValue(Key: TOIDName; Value: TfrxASN1Base);
begin
  Add(TfrxX509KeyValue.Create(Key, Value));
end;

function TfrxX509KeyValueList.GetX509KeyValue(Index: Integer): TfrxX509KeyValue;
begin
  Result := (inherited Items[Index]) as TfrxX509KeyValue;
end;

function TfrxX509KeyValueList.IsEqual(KeyValueList: TfrxX509KeyValueList): Boolean;
var
  i: Integer;
begin
  Result := False;
  if Count <> KeyValueList.Count then
    Exit;
  for i := 0 to Count - 1 do
    if not Items[i].IsEqual(KeyValueList[i]) then
      Exit;
  Result := True;
end;

end.
