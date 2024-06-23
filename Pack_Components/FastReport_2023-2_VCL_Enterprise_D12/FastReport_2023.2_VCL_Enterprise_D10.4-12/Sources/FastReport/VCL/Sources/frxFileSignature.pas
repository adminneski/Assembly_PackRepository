unit frxFileSignature;

{$I frx.inc}

interface

uses
  SysUtils, Windows, Types,
  frxWinCrypt, frxHelpers;

type
  /// <summary>
  /// The TCertificateStoreLookup object finds the first certificate context in
  /// a certificate store that matches a search criteria established by it
  /// properties.
  /// </summary>
  TCertificateStoreLookup = class // https://docs.microsoft.com/en-us/windows/win32/api/wincrypt/ns-wincrypt-cert_info
  private
    FIgnoreCase: Boolean;
    FIssuer: WideString;
    FNotBefore: string;
    FNotAfter: string;
    FSubject: WideString;
    FDateFormat: string;
    FCertificatePath: WideString;
  protected
    function IsCertificateSuitable(Certificate: PCERT_CONTEXT): Boolean;
    function IsNameSuitable(const NameBlob: TCertNameBlob; Name: WideString): Boolean;
    function IsWideInclude(Str, SubStr: WideString): Boolean;
    function IsTimeSuitable(const CertTime: TFileTime; SoughtFor: string): Boolean;
  public
    constructor Create;
    function LookupParams: string;
    function FindCertificate(hCertStore: HCERTSTORE): PCERT_CONTEXT;
    function OpenPFXStore(Password: AnsiString): HCERTSTORE;

    /// <summary>
    ///   Allows you to ignore case sensitivity for Issuer and Subject properies.
    ///   Default = False;
    /// </summary>
    property IgnoreCase: Boolean read FIgnoreCase write FIgnoreCase;
    /// <summary>
    ///   This substring (if specified) must be in the certificate Issuer field.
    /// </summary>
    property Issuer: WideString read FIssuer write FIssuer;
    /// <summary>
    ///   This string (if provided) must match the certificate's NotBefore field.
    ///   Note: in Console Root / Certificates dates may be rounded.
    /// </summary>
    property NotBefore: string read FNotBefore write FNotBefore;
    /// <summary>
    ///   This string (if provided) must match the certificate's NotAfter field.
    ///   Note: in Console Root / Certificates dates may be rounded.
    /// </summary>
    property NotAfter: string read FNotAfter write FNotAfter;
    /// <summary>
    ///   This substring (if specified) must be in the certificate Subject field.
    /// </summary>
    property Subject: WideString read FSubject write FSubject;
    /// <summary>
    ///   Determines date format for NotBefore and NotAfter properies.
    ///   Default = 'dd.mm.yy'
    /// </summary>
    property DateFormat: string read FDateFormat write FDateFormat;
    /// <summary>
    ///   pfx / p12 file path.
    /// </summary>
    property CertificatePath: WideString read FCertificatePath write FCertificatePath;
  end;

const // FileSignatureOptions
  fsoDetached =   $01;
  fsoChain =      $02;
  fsoOnlyGOST =   $04; // Non GOST certificate causes error
//  fsoUniqueness = $08; // Only one certificate must match the search criteria
  fsoDebugLog =   $10;
  fsoPFXFile =    $20; // Load certificate from pfx / p12 file

function FileSignatureOptions(Detached, Chain, OnlyGOST, DebugLog, PFXFile: Boolean): Integer;

type
  TFileSignatureSatus = (ssOK, ssMessageFileNotSpecified, ssMessageFileNotFound,
    ssLookupParamsNotSpecified, ssStoreHandleWasNotGot, ssCertificateNotFound,
    ssCertificateContextPropertyWasNotGot, ssCryptAcquireContextFailed,
    ssCryptSetProvParamFailed, ssNotGOST, ssReadMessageDataFailed,
    ssCryptSignMessageFailed, ssCryptReleaseContextFiled,
    ssSaveSignatureFailed, ssCertCloseStoreFailed, ssWrongLen,
    ssCertGetCertificateChainFailed, ssCertificateFileNotSpecified,
    ssCertificateFileNotFound);

function FileSignatureErrorDEscription(FileSignatureSatus: TFileSignatureSatus): string;

type
  TfrxFileSignature = class
  private
    FLookup: TCertificateStoreLookup;
    FMessageFileName: TFileName;
    FSignatureFileName: TFileName;
    FCertificatePassword: AnsiString;
    FOptions: LongWord;
  protected
    FStatus: TFileSignatureSatus;
    FDebugLog: TLogList;

    function IsError(ErrorCondition: Boolean; ErrorStatus: TFileSignatureSatus;
      IsUseLastError: Boolean = False): Boolean;
    function IsOptions(const Param: LongWord): Boolean;
    function GetGOSTHashOid(pCert: PCCERT_CONTEXT): PAnsiChar;
    function IsReadMessageData(out BDA: TByteDynArray): Boolean;
    function IsSaveSignature(const SignedMessage: TByteDynArray): Boolean;
  public
    constructor Create(
      ALookup: TCertificateStoreLookup;
      AMessageFileName: TFileName;
      ASignatureFileName: TFileName;
      ACertificatePassword: AnsiString;
      AOptions: LongWord);
    destructor Destroy; override;

    procedure Sign;

    property Status: TFileSignatureSatus read FStatus;
    property DebugLog: TLogList read FDebugLog;
  end;

implementation

uses
  Classes, frxRes,
  frUtils;

const
  UseLastError = True;
  Encoding = X509_ASN_ENCODING or PKCS_7_ASN_ENCODING;
  MaxSignatureSize = 512 * 1024;

{ Utilities }

function IsReadFile2BDA(const FileName: TFileName; out BDA: TByteDynArray): Boolean;
var
  Stream: TFileStream;
begin
  Result := True;
  Stream := TFileStream.Create(FileName, fmOpenRead);
  try
    SetLength(BDA, Stream.Size);
    try
      Stream.ReadBuffer(BDA[0], Stream.Size);
    except
      on EReadError do
      begin
        Result := False;
        Exit;
      end;
    end;
  finally
    Stream.Free;
  end;
end;

function FileSignatureErrorDescription(FileSignatureSatus: TFileSignatureSatus): string;
begin
  case FileSignatureSatus of
    ssMessageFileNotSpecified:             Result := frxResources.Get('MessageFileNotSpecified');
    ssMessageFileNotFound:                 Result := frxResources.Get('MessageFileNotFound');
    ssLookupParamsNotSpecified:            Result := frxResources.Get('LookupParamsNotSpecified');
    ssStoreHandleWasNotGot:                Result := frxResources.Get('StoreHandleWasNotGot');
    ssCertificateNotFound:                 Result := frxResources.Get('CertificateNotFound');
    ssCertificateContextPropertyWasNotGot: Result := frxResources.Get('CertificateContextPropertyWasNotGot');
    ssCryptAcquireContextFailed:           Result := frxResources.Get('CryptAcquireContextFailed');
    ssCryptSetProvParamFailed:             Result := frxResources.Get('CryptSetProvParamFailed');
    ssNotGOST:                             Result := frxResources.Get('NotGOST');
    ssReadMessageDataFailed:               Result := frxResources.Get('ReadMessageDataFailed');
    ssCryptSignMessageFailed:              Result := frxResources.Get('CryptSignMessageFailed');
    ssCryptReleaseContextFiled:            Result := frxResources.Get('CryptReleaseContextFiled');
    ssSaveSignatureFailed:                 Result := frxResources.Get('SaveSignatureFailed');
    ssCertCloseStoreFailed:                Result := frxResources.Get('SaveSignatureFailed');
    ssWrongLen:                            Result := frxResources.Get('WrongLen');
    ssCertificateFileNotSpecified:         Result := frxResources.Get('CertificateFileNotSpecified');
    ssCertificateFileNotFound:             Result := frxResources.Get('CertificateFileNotFound');
    else
      Result := 'Unknown Signature Error';
  end;
end;

function FileSignatureOptions(Detached, Chain, OnlyGOST, DebugLog, PFXFile: Boolean): Integer;
begin
  Result :=
    frIfInt(Detached, fsoDetached) + frIfInt(Chain, fsoChain) +
    frIfInt(OnlyGOST, fsoOnlyGOST) + frIfInt(DebugLog, fsoDebugLog) +
    frIfInt(PFXFile, fsoPFXFile);
end;

{ TfrxFileSignature }

constructor TfrxFileSignature.Create(ALookup: TCertificateStoreLookup;
  AMessageFileName: TFileName; ASignatureFileName: TFileName;
  ACertificatePassword: AnsiString; AOptions: LongWord);
begin
  FOptions := AOptions;
  if IsOptions(fsoDebugLog) then
    FDebugLog := TLogList.Create;

  FLookup := ALookUp;
  FMessageFileName := AMessageFileName;
  FSignatureFileName := ASignatureFileName;
  if FSignatureFileName = '' then
    FSignatureFileName := FMessageFileName + '.sig';
  FCertificatePassword := ACertificatePassword;
end;

destructor TfrxFileSignature.Destroy;
begin
  FDebugLog.Free;
  inherited;
end;

function TfrxFileSignature.GetGOSTHashOid(pCert: PCCERT_CONTEXT): PAnsiChar;
const
// https://cpdn.cryptopro.ru/content/csp40/html/group___pro_c_s_p_ex_DP8.html
  szOID_CP_GOST_R3411	= '1.2.643.2.2.9'; // Функция хэширования ГОСТ Р 34.11-94
  szOID_CP_GOST_R3411_12_256 = '1.2.643.7.1.1.2.2'; // Функция хэширования ГОСТ Р 34.11-2012, длина выхода 256 бит
  szOID_CP_GOST_R3411_12_512 = '1.2.643.7.1.1.2.3'; // Функция хэширования ГОСТ Р 34.11-2012, длина выхода 512 бит
  szOID_CP_GOST_R3410EL = '1.2.643.2.2.19'; // Алгоритм ГОСТ Р 34.10-2001, используемый при экспорте/импорте ключей
  szOID_CP_GOST_R3410_12_256 = '1.2.643.7.1.1.1.1'; // Алгоритм ГОСТ Р 34.10-2012 для ключей длины 256 бит, используемый при экспорте/импорте ключей
  szOID_CP_GOST_R3410_12_512 = '1.2.643.7.1.1.1.2'; // Алгоритм ГОСТ Р 34.10-2012 для ключей длины 512 бит, используемый при экспорте/импорте ключей
var
  pKeyAlg: PAnsiChar;
begin
  pKeyAlg := pCert.pCertInfo.SubjectPublicKeyInfo.Algorithm.pszObjId;
  Result := nil;
  if      pKeyAlg = szOID_CP_GOST_R3410EL then
    Result := szOID_CP_GOST_R3411
  else if pKeyAlg = szOID_CP_GOST_R3410_12_256 then
    Result := szOID_CP_GOST_R3411_12_256
  else if pKeyAlg = szOID_CP_GOST_R3410_12_512 then
    Result := szOID_CP_GOST_R3411_12_512;
end;

function TfrxFileSignature.IsError(ErrorCondition: Boolean; ErrorStatus: TFileSignatureSatus; IsUseLastError: Boolean = False): Boolean;
var
  LastError: DWORD;
begin
  Result := ErrorCondition;
  if Result then
  begin
    FStatus := ErrorStatus;
    if FDebugLog <> nil then
    begin
      FDebugLog.Add(FileSignatureErrorDescription(ErrorStatus));
      if IsUseLastError then
      begin
        LastError := GetLastError;
        if LastError <> 0 then
          FDebugLog.Add(IntToStr(LastError) + ': ' + SysErrorMessage(LastError));
      end;
    end;
  end;
end;

function TfrxFileSignature.IsOptions(const Param: LongWord): Boolean;
begin
  Result := FOptions and Param = Param;
end;

function TfrxFileSignature.IsReadMessageData(out BDA: TByteDynArray): Boolean;
begin
  Result := IsReadFile2BDA(FMessageFileName, BDA);
end;

function TfrxFileSignature.IsSaveSignature(const SignedMessage: TByteDynArray): Boolean;
var
  Stream: TFileStream;
begin
  Result := False;
  Stream := TFileStream.Create(FSignatureFileName, fmCreate);
  try
    try
      Stream.WriteBuffer(SignedMessage[0], Length(SignedMessage));
    except
      on EWriteError do
        Exit;
    end;
  finally
    Stream.Free;
  end;
  Result := True;
end;

procedure TfrxFileSignature.Sign;
label
  Error;
var
  signPara: CRYPT_SIGN_MESSAGE_PARA;
  context: PCCERT_CONTEXT;

  certs: array of PCCERT_CONTEXT;

  function IsDoChain: Boolean;
  var
    i, CertChainCount: Integer;
    ChainPara: CERT_CHAIN_PARA;
    rgpEl: PPCertChainElement;
    pChainContext: PCERT_CHAIN_CONTEXT;
  begin
    FillChar(ChainPara, SizeOf(ChainPara), #0);
    ChainPara.cbSize := SizeOf(ChainPara);

    pChainContext := nil;
    if IsError(
         not CertGetCertificateChain(0, context, nil, nil, @ChainPara, 0, nil, @pChainContext),
         ssCertGetCertificateChainFailed, UseLastError) then
      Result := False
    else
    begin
      Result := True;
      CertChainCount := pChainContext^.rgpChain^.cElement;
      SetLength(certs, CertChainCount - 1);
      rgpEl := pChainContext^.rgpChain^.rgpElement;
      for i := 0 to High(certs) do
      begin
        certs[i] := rgpEl^.pCertContext;
        Inc(rgpEl);
      end;

      if Length(certs) > 0 then
      begin
        signPara.cMsgCert := Length(certs);
        signPara.rgpMsgCert := @certs[0];
      end;
    end;

    if (pChainContext <> nil) then
       CertFreeCertificateChain(pChainContext);
  end;
var
  hStoreHandle: HCERTSTORE;
  MessageData: TByteDynArray;
  MessageLen: DWORD;
  PMessageData: PByte;
  SignedMessage: TByteDynArray;
  SignedMessageLen: DWORD;

  pProvKey: PCRYPT_KEY_PROV_INFO;
  dwProvKeyInfoSize: DWORD;
  hProvider: HCRYPTPROV;
begin
  hProvider := nil;
  pProvKey := nil;
  FStatus := ssOK;

  if IsError(FMessageFileName = '', ssMessageFileNotSpecified) or
     IsError(not FileExists(FMessageFileName), ssMessageFileNotFound) or
     IsError(FLookup = nil, ssLookupParamsNotSpecified) then
    Exit;

  if not IsOptions(fsoPFXFile) then
    hStoreHandle := CertOpenSystemStore(nil, 'MY')
  else if IsError(FLookup.CertificatePath = '', ssCertificateFileNotSpecified)
       or IsError(not FileExists(FLookup.CertificatePath), ssCertificateFileNotFound) then
    Exit
  else
    hStoreHandle := FLookup.OpenPFXStore(FCertificatePassword);

  if IsError(hStoreHandle = nil, ssStoreHandleWasNotGot) then
    Exit;

  context := FLookup.FindCertificate(hStoreHandle);

  if IsError(context = nil, ssCertificateNotFound) then
  begin
    if FDebugLog <> nil then
      FDebugLog.Add(FLookup.LookupParams);
    goto Error;
  end;

  if (FCertificatePassword <> '') and not IsOptions(fsoPFXFile) then
  begin
    dwProvKeyInfoSize := 0;
    if IsError(
       not CertGetCertificateContextProperty(context, CERT_KEY_PROV_INFO_PROP_ID, pProvKey, @dwProvKeyInfoSize),
       ssCertificateContextPropertyWasNotGot, UseLastError) then
      goto Error;
    GetMem(pProvKey, dwProvKeyInfoSize);
    if IsError(
       not CertGetCertificateContextProperty(context, CERT_KEY_PROV_INFO_PROP_ID, pProvKey, @dwProvKeyInfoSize),
       ssCertificateContextPropertyWasNotGot, UseLastError) then
      goto Error;
    if IsError(
       not CryptAcquireContextW(@hProvider, pProvKey^.pwszContainerName, pProvKey^.pwszProvName, pProvKey^.dwProvType, CRYPT_SILENT),
       ssCryptAcquireContextFailed, UseLastError) then
      goto Error;
    if IsError(
         not CryptSetProvParam(hProvider, PP_SIGNATURE_PIN, @FCertificatePassword[1], 0),
         ssCryptSetProvParamFailed, UseLastError) then
      goto Error;
  end;

  FillChar(signPara, SizeOf(signPara), #0);
  signPara.cbSize := SizeOf(signPara);
  signPara.dwMsgEncodingType := Encoding;
  signPara.pSigningCert := context;
  signPara.HashAlgorithm.pszObjId := LPSTR(GetGOSTHashOid(context));
  if IsError((signPara.HashAlgorithm.pszObjId = '') and IsOptions(fsoOnlyGOST), ssNotGOST) then
    goto Error
  else
    signPara.HashAlgorithm.pszObjId := '1.3.14.3.2.26'; // OID_sha1

  signPara.cMsgCert := 1;
  signPara.rgpMsgCert := @context;

  if IsOptions(fsoChain) and not IsDoChain then
    goto Error;

  if IsError(not IsReadMessageData(MessageData), ssReadMessageDataFailed) then
    goto Error;
  MessageLen := Length(MessageData);

  SignedMessageLen := 0;
  PMessageData := @MessageData[0];
  if IsError(
       not CryptSignMessage(@signPara, IsOptions(fsoDetached), 1, @PMessageData, @MessageLen, nil, SignedMessageLen),
       ssCryptSignMessageFailed, UseLastError) then
    goto Error;

  if IsError(
       IsOptions(fsoDetached) and (SignedMessageLen > MaxSignatureSize) or
       not IsOptions(fsoDetached) and (SignedMessageLen > MaxSignatureSize + MessageLen),
       ssWrongLen, UseLastError) then
    goto Error;

  SetLength(SignedMessage, SignedMessageLen);
  if IsError(
       not CryptSignMessage(@signPara, IsOptions(fsoDetached), 1, @PMessageData, @MessageLen, @SignedMessage[0], SignedMessageLen),
       ssCryptSignMessageFailed, UseLastError) then
    goto Error;

  if IsError(not IsSaveSignature(SignedMessage), ssSaveSignatureFailed) then
    goto Error;

Error:
  if pProvKey <> nil then
    FreeMem(pProvKey);

  if hProvider <> nil then
    if IsError(not CryptReleaseContext(hProvider, 0),
         ssCryptReleaseContextFiled, UseLastError) then
      Exit;

  if IsError(not CertCloseStore(hStoreHandle, 0), ssCertCloseStoreFailed, UseLastError) then
    Exit;

  if context <> nil then
    CertFreeCertificateContext(context);
end;

{ TCertificateStoreLookup }

constructor TCertificateStoreLookup.Create;
begin
  FDateFormat := 'dd.mm.yy';
  FIgnoreCase := False;
end;

function TCertificateStoreLookup.FindCertificate(hCertStore: HCERTSTORE): PCERT_CONTEXT;
begin
  Result := nil;
  repeat
    Result := CertEnumCertificatesInStore(hCertStore, Result);
  until (Result = nil) or IsCertificateSuitable(Result);
end;

function TCertificateStoreLookup.IsCertificateSuitable(Certificate: PCERT_CONTEXT): Boolean;
begin
  Result :=
    IsNameSuitable(Certificate^.pCertInfo^.Issuer, Issuer) and
    IsTimeSuitable(Certificate^.pCertInfo^.NotBefore, NotBefore) and
    IsTimeSuitable(Certificate^.pCertInfo^.NotAfter, NotAfter) and
    IsNameSuitable(Certificate^.pCertInfo^.Subject, Subject);
end;

function TCertificateStoreLookup.IsNameSuitable(const NameBlob: TCertNameBlob; Name: WideString): Boolean;
const
  StrType = CERT_SIMPLE_NAME_STR;
var
  WS: WideString;
  Size: DWORD;
begin
  Result := Name = '';
  if Result then
    Exit;
  Size := CertNameToStr(Encoding, @NameBlob, StrType, nil, 0);
  Result := Integer(Size) >= Length(Name);
  if not Result then
    Exit;
  SetLength(WS, size);
  CertNameToStr(Encoding, @NameBlob, StrType, Pointer(WS), Size);
  if IgnoreCase then
    Result := IsWideInclude(WideUpperCase(WS), WideUpperCase(Name))
  else
    Result := IsWideInclude(WS, Name);
end;

function TCertificateStoreLookup.IsTimeSuitable(const CertTime: TFileTime; SoughtFor: string): Boolean;
var
  SysTime: TSystemTime;
begin
  Result := SoughtFor = '';
  if Result then
    Exit;
  FileTimeToSystemTime(CertTime, SysTime);
  Result := SoughtFor = FormatDateTime(DateFormat, SystemTimeToDateTime(SysTime));
end;

function TCertificateStoreLookup.IsWideInclude(Str, SubStr: WideString): Boolean;
var
  LenStr, LenSubStr, s, ss: Integer;
begin
  Result := (Str <> '') and (SubStr <> '');
  if not Result then
    Exit;
  LenStr := Length(Str);
  LenSubStr := Length(SubStr);
  for s := 1 to LenStr - LenSubStr + 1 do
    for ss := 1 to LenSubStr do
      if      Str[s + ss - 1] <> SubStr[ss] then
        Break
      else if ss = LenSubStr then
        Exit;
  Result := False;
end;

function TCertificateStoreLookup.LookupParams: string;
begin
  Result := 'Lookup params:'
    + ' IgnoreCase="' + frIfStr(FIgnoreCase, 'True', 'False') + '";'
    + ' Issuer="' + FIssuer + '";'
    + ' Subject="' + FSubject + '";'
    + ' DateFormat="' + FDateFormat + '";'
    + ' NotBefore="' + FNotBefore + '";'
    + ' NotAfter="' + FNotAfter + '";'
  ;
end;

function TCertificateStoreLookup.OpenPFXStore(Password: AnsiString): HCERTSTORE;
var
  StoreData: TByteDynArray;
  Data: TCryptDataBlob;
  PPassword: LPCWSTR;
begin
  Result := nil;
  if not IsReadFile2BDA(FCertificatePath, StoreData) then
    Exit;

  Data.cbData := Length(StoreData);
  Data.pbData := @StoreData[0];

  PPassword := nil;
  if Password <> '' then
    PPassword := @WideString(Password)[1];

  Result := PFXImportCertStore(@Data, PPassword, 0);
end;

end.
