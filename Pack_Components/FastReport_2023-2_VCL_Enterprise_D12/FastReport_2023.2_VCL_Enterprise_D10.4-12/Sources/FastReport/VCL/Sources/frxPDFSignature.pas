unit frxPDFSignature;

{$I frx.inc}

interface

uses
  Classes, SysUtils,
  frxASN1, frxPDFPFX, frxHelpers;

type
  TSignatureSatus = (ssOK, ssWrongPassword, ssUnknownHashAlgorithm,
    ssUnknownChipherAlgorithm, ssInvalidASN1File, ssCantParseCertificate,
    ssPrepareSignError, ssSignDigestError, ssCertificateNotFound);


  TfrxPDFSignature = class
  private
    FStatus: TSignatureSatus;
    FPFX: TfrxPKCS12Document;
    FDigest: TfrxASN1Data;
    FSignedDigest: TfrxASN1Data;
    FSign: TfrxASN1Base;
    FDebugLog: TLogList;
    function GetCertificateCommonName: WideString;
    function GetCertificateDistinguishedName: WideString;
  protected
    procedure PrepareSign;
    procedure CalcHash(Stream: TStream;
      ContentPosition, ContentEndPosition: Int64);
  public
    constructor Create(Path: WideString; Password: AnsiString);
    destructor Destroy; override;
    function CalcPDFSign(Stream: TStream;
      ContentPosition, ContentEndPosition: Int64): Ansistring;

    property Status: TSignatureSatus read FStatus write FStatus;
    property DebugLog: TLogList read FDebugLog;

    property CertificateCommonName: WideString read GetCertificateCommonName;
    property CertificateDistinguishedName: WideString read GetCertificateDistinguishedName;
  end;

implementation

uses
  frxHash, frxPDFX509Certificate, frxPDFRSA;

{ TfrxPDFSignature }

procedure TfrxPDFSignature.CalcHash(Stream: TStream; ContentPosition,
  ContentEndPosition: Int64);
const
  BUFFSIZE = 512 * 1024;
var
  SHA: TfrxSHA1Hash;
  RS: Integer;
  P: Pointer;
  SZ: Int64;
  st: AnsiString;
  DigestObj, Algorithm, ASet, Attr, Tmp: TfrxASN1Container;
  Hash: AnsiString;
begin
  SZ := Stream.Size;
  SHA := TfrxSHA1Hash.Create;
  try
    SHA.Initialize;
    Stream.Position := 0;
    P := GetMemory(BUFFSIZE);
    try
      while Stream.Position <> ContentPosition do
      begin
        if Stream.Position + BUFFSIZE <= ContentPosition then
          RS := BUFFSIZE
        else
          RS := ContentPosition - Stream.Position;
        Stream.Read(P^, RS);
        SHA.Update(P^, RS);
      end;
      Stream.Position := ContentEndPosition;
      while Stream.Position <> SZ do
      begin
        if Stream.Position + BUFFSIZE <= SZ then
          RS := BUFFSIZE
        else
          RS := SZ - Stream.Position;
        Stream.Read(P^, RS);
        SHA.Update(P^, RS);
      end;
    finally
      FreeMemory(P)
    end;
    SHA.Finalize;
    Hash := SHA.DigestToAnsi;
    FDigest.Data := Hash;
    ASet := TfrxASN1Container.CreateSET;
    try
      Tmp := TfrxASN1Container.CreateSET;
      Tmp.Add(TfrxASN1Data.Create(Hash));
      Attr := TfrxASN1Container.CreateSEQUENCE;
      Attr.Add(TfrxASN1ObjectID.Create(OID_pkcs9_messageDigest));
      Attr.Add(Tmp);
      ASet.Add(Attr);

      Tmp := TfrxASN1Container.CreateSET;
      Tmp.Add(TfrxASN1ObjectID.Create(OID_pkcs7_Data));
      Attr := TfrxASN1Container.CreateSEQUENCE;
      Attr.Add(TfrxASN1ObjectID.Create(OID_pkcs9_contentType));
      Attr.Add(Tmp);
      ASet.Add(Attr);

      st := SHA.DigestFromAnsiToAnsi(ASet.ToAnsi);
    finally
      ASet.Free;
    end;

    DigestObj := TfrxASN1Container.CreateSEQUENCE;
    try
      Algorithm :=TfrxASN1Container.CreateSEQUENCE;
      Algorithm.Add(TfrxASN1ObjectID.Create(OID_sha1));
      Algorithm.Add(TfrxASN1Null.Create);
      DigestObj.Add(Algorithm);
      DigestObj.Add(TfrxASN1Data.Create(st));
      FSignedDigest.Data := SignDigest(FPFX.Chain.PrivateKey, DigestObj);
    finally
      DigestObj.Free;
    end;
  finally
    SHA.Free;
  end;
end;

function TfrxPDFSignature.CalcPDFSign(Stream: TStream; ContentPosition,
  ContentEndPosition: Int64): Ansistring;
begin
  try
    PrepareSign;
  except
    FStatus := ssPrepareSignError;
    Exit;
  end;

  try
    CalcHash(Stream, ContentPosition, ContentEndPosition);
  except
    FStatus := ssSignDigestError;
    Exit;
  end;

  Result := AnsiToHex(FSign.ToAnsi);
end;

constructor TfrxPDFSignature.Create(Path: WideString; Password: AnsiString);
var
  FS: TFileStream;
begin
  FDebugLog := TLogList.Create;
  if not FileExists(Path) then
  begin
    FStatus := ssCertificateNotFound;
    Exit;
  end;

  FS := TFileStream.Create(Path, fmOpenRead);
  try
    FPFX := TfrxPKCS12Document.Create(FDebugLog);

    try
      FPFX.LoadFromStream(FS);
    except
      FStatus := ssInvalidASN1File;
      Exit;
    end;

    if not FPFX.IsCheckPassword(UTF8String(Password)) then
    begin
      FStatus := ssWrongPassword;
      Exit;
    end;

    try
      FPFX.Parse;
    except
      FStatus := ssCantParseCertificate;
      Exit;
    end;

  finally
    FS.Free;
  end;
end;


destructor TfrxPDFSignature.Destroy;
begin
  FDebugLog.Free;
  FSign.Free;
  FPFX.Free;
  inherited;
end;

function TfrxPDFSignature.GetCertificateCommonName: WideString;
begin
  Result := FPFX.Chain.CommonName;
end;

function TfrxPDFSignature.GetCertificateDistinguishedName: WideString;
begin
  Result := FPFX.Chain.DistinguishedName;
end;

procedure TfrxPDFSignature.PrepareSign;
var
  Cont, WrkSeq, Data: TfrxASN1Container;
  Fill: TfrxASN1Container;
  ASet: TfrxASN1Container;
  SignerInfo, IssuerAndSerialNumber, Algorithm, Digest, Content, AuthenticatedAttributes: TfrxASN1Container;
  Chain: TfrxX509Certificate;
  CertificateInfo: TfrxASN1Container;
  Shift, SignatureSize: Integer;
begin
  Cont := TfrxASN1Container.CreateSEQUENCE;
  try
    Cont.Add(TfrxASN1ObjectID.Create(OID_pkcs7_signedData));
    Data := TfrxASN1Container.CreateSEQUENCE;
    Fill := TfrxASN1Container.Create(ASN1_TAG_EOC, ASN1_CLASS_CONTEXT);
    Fill.Add(Data);
    Cont.Add(Fill);
    //Version
    Data.Add(TfrxASN1Integer.Create(1));
    //Algorithm
    Algorithm := TfrxASN1Container.CreateSEQUENCE;
    Algorithm.Add(TfrxASN1ObjectID.Create(OID_sha1));
    Algorithm.Add(TfrxASN1Null.Create);
    ASet := TfrxASN1Container.CreateSET;
    ASet.Add(Algorithm);
    Data.Add(ASet);
    //contentInfo
    WrkSeq := TfrxASN1Container.CreateSEQUENCE;
    WrkSeq.Add(TfrxASN1ObjectID.Create(OID_pkcs7_data));
    Data.Add(WrkSeq);
    //certificates
    Fill := TfrxASN1Container.Create(ASN1_TAG_EOC, ASN1_CLASS_CONTEXT);
    Chain := FPFX.Chain;
    CertificateInfo := FPFX.Chain.ASN1Certificate[0] as TfrxASN1Container;
    while Chain <> nil do
    begin
      Fill.Add(Chain.ASN1Certificate.CreateCopy);
      Chain := Chain.Owner;
    end;
    Data.Add(Fill);
    //signerInfos
    SignerInfo := TfrxASN1Container.CreateSEQUENCE;
    ASet := TfrxASN1Container.CreateSET;
    ASet.Add(SignerInfo);
    Data.Add(ASet);
    //Version
    SignerInfo.Add(TfrxASN1Integer.Create(1));
    // IssuerAndSerialNumber
    Shift := TfrxX509Certificate.GetVersionShift(CertificateInfo[0]);
    IssuerAndSerialNumber :=  TfrxASN1Container.CreateSEQUENCE;
    IssuerAndSerialNumber.Add(CertificateInfo[2 + Shift].CreateCopy);
    IssuerAndSerialNumber.Add(CertificateInfo[0 + Shift].CreateCopy);
    SignerInfo.Add(IssuerAndSerialNumber);

    Algorithm := TfrxASN1Container.CreateSEQUENCE;
    Algorithm.Add(TfrxASN1ObjectID.Create(OID_sha1));
    Algorithm.Add(TfrxASN1Null.Create);
    SignerInfo.Add(Algorithm);

    AuthenticatedAttributes := TfrxASN1Container.Create(ASN1_TAG_EOC, ASN1_CLASS_CONTEXT);
    SignerInfo.Add(AuthenticatedAttributes);
    // Digest
    Digest := TfrxASN1Container.CreateSEQUENCE;
    Digest.Add(TfrxASN1ObjectID.Create(OID_pkcs9_messageDigest));
    ASet := TfrxASN1Container.CreateSET;
    Digest.Add(ASet);
    AuthenticatedAttributes.Add(Digest);

    FDigest := TfrxASN1Data.Create(AnsiStringOfChar(#0, 20));
    ASet.Add(FDigest);
    // ContentType
    Content := TfrxASN1Container.CreateSEQUENCE;
    Content.Add(TfrxASN1ObjectID.Create(OID_pkcs9_contentType));
    ASet := TfrxASN1Container.CreateSET;
    ASet.Add(TfrxASN1ObjectID.Create(OID_pkcs7_data));
    Content.Add(ASet);
    AuthenticatedAttributes.Add(Content);

    Algorithm := TfrxASN1Container.CreateSEQUENCE;
    Algorithm.Add(TfrxASN1ObjectID.Create(OID_rsaEncryption));
    Algorithm.Add(TfrxASN1Null.Create);
    SignerInfo.Add(Algorithm);

    if FPFX.Chain.PrivateKey.Modulus.Data[1] = #0 then
      SignatureSize := Length(FPFX.Chain.PrivateKey.Modulus.Data) - 1
    else
      SignatureSize := Length(FPFX.Chain.PrivateKey.Modulus.Data);
    Inc(SignatureSize, 20);
    FSignedDigest := TfrxASN1Data.Create(AnsiStringOfChar(#0, SignatureSize));
    SignerInfo.Add(FSignedDigest);
  except
    on Exception do
    begin
      Cont.Free;
      raise;
    end;
  end;
  FSign := Cont;
end;

end.
