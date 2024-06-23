unit frxWinCrypt;

interface

uses
  Windows,
  frCore;

type
  HCERTSTORE = Pointer;
  {$EXTERNALSYM HCERTSTORE}
  PHCERTSTORE = ^HCERTSTORE;

  HCRYPTMSG = Pointer;
  {$EXTERNALSYM HCRYPTMSG}
  
  LPVOID = Pointer;
  {$EXTERNALSYM LPVOID}

  PLPCSTR = ^LPCSTR;

{$MINENUMSIZE 4}
{$WARN SYMBOL_PLATFORM OFF}

// dwFlags definitions for CryptAcquireContext
const
  CRYPT_VERIFYCONTEXT    = $F0000000;
  {$EXTERNALSYM CRYPT_VERIFYCONTEXT}
  CRYPT_NEWKEYSET        = $00000008;
  {$EXTERNALSYM CRYPT_NEWKEYSET}
  CRYPT_DELETEKEYSET     = $00000010;
  {$EXTERNALSYM CRYPT_DELETEKEYSET}
  CRYPT_MACHINE_KEYSET   = $00000020;
  {$EXTERNALSYM CRYPT_MACHINE_KEYSET}
  CRYPT_SILENT           = $00000040;
  {$EXTERNALSYM CRYPT_SILENT}
  CRYPT_DEFAULT_CONTAINER_OPTIONAL = $00000080;
  {$EXTERNALSYM CRYPT_DEFAULT_CONTAINER_OPTIONAL}

// CryptGetProvParam
//
const
  PP_SIGNATURE_PIN       = 33;
  {$EXTERNALSYM PP_SIGNATURE_PIN}
// Used for certenroll.idl:
// certenrolls_begin -- HCRYPT*
type
  PHCRYPTPROV = ^HCRYPTPROV;
  HCRYPTPROV = Pointer;
  {$EXTERNALSYM HCRYPTPROV}
  HCRYPTKEY = Pointer;
  {$EXTERNALSYM HCRYPTKEY}
  HCRYPTHASH = Pointer;
  {$EXTERNALSYM HCRYPTHASH}

function CryptReleaseContext(
  hProv: HCRYPTPROV;
  dwFlags: DWORD): LongBool; stdcall;
{$EXTERNALSYM CryptReleaseContext}
// certenrolls_end
//+-------------------------------------------------------------------------
//  CRYPTOAPI BLOB definitions
//--------------------------------------------------------------------------
// certenrolls_begin -- *_BLOB
type
  _CRYPTOAPI_BLOB = record
    cbData: DWORD;
    pbData: PByte;
  end;
  {$EXTERNALSYM _CRYPTOAPI_BLOB}
  PCryptIntegerBlob = ^TCryptIntegerBlob;
  CRYPT_INTEGER_BLOB = _CRYPTOAPI_BLOB;
  {$EXTERNALSYM CRYPT_INTEGER_BLOB}
  TCryptIntegerBlob = _CRYPTOAPI_BLOB;
  PCRYPT_INTEGER_BLOB = PCryptIntegerBlob;
  {$EXTERNALSYM PCRYPT_INTEGER_BLOB}
  PCryptUIntBlob = ^TCryptUIntBlob;
  CRYPT_UINT_BLOB = _CRYPTOAPI_BLOB;
  {$EXTERNALSYM CRYPT_UINT_BLOB}
  TCryptUIntBlob = _CRYPTOAPI_BLOB;
  PCRYPT_UINT_BLOB = PCryptUIntBlob;
  {$EXTERNALSYM PCRYPT_UINT_BLOB}
  PCryptObjIDBlob = ^TCryptObjIDBlob;
  CRYPT_OBJID_BLOB = _CRYPTOAPI_BLOB;
  {$EXTERNALSYM CRYPT_OBJID_BLOB}
  TCryptObjIDBlob = _CRYPTOAPI_BLOB;
  PCRYPT_OBJID_BLOB = PCryptObjIDBlob;
  {$EXTERNALSYM PCRYPT_OBJID_BLOB}
  PCertNameBlob = ^TCertNameBlob;
  CERT_NAME_BLOB = _CRYPTOAPI_BLOB;
  {$EXTERNALSYM CERT_NAME_BLOB}
  TCertNameBlob = _CRYPTOAPI_BLOB;
  PCERT_NAME_BLOB = PCertNameBlob;
  {$EXTERNALSYM PCERT_NAME_BLOB}
  PCertRDNValueBlob = ^TCertRDNValueBlob;
  CERT_RDN_VALUE_BLOB = _CRYPTOAPI_BLOB;
  {$EXTERNALSYM CERT_RDN_VALUE_BLOB}
  TCertRDNValueBlob = _CRYPTOAPI_BLOB;
  PCERT_RDN_VALUE_BLOB = PCertRDNValueBlob;
  {$EXTERNALSYM PCERT_RDN_VALUE_BLOB}
  PCertBlob = ^TCertBlob;
  CERT_BLOB = _CRYPTOAPI_BLOB;
  {$EXTERNALSYM CERT_BLOB}
  TCertBlob = _CRYPTOAPI_BLOB;
  PCERT_BLOB = PCertBlob;
  {$EXTERNALSYM PCERT_BLOB}
  PCRLBlob = ^TCRLBlob;
  CRL_BLOB = _CRYPTOAPI_BLOB;
  {$EXTERNALSYM CRL_BLOB}
  TCRLBlob = _CRYPTOAPI_BLOB;
  PCRL_BLOB = PCRLBlob;
  {$EXTERNALSYM PCRL_BLOB}
  PDataBlob = ^TDataBlob;
  DATA_BLOB = _CRYPTOAPI_BLOB;
  {$EXTERNALSYM DATA_BLOB}
  TDataBlob = _CRYPTOAPI_BLOB;
  PDATA_BLOB = PDataBlob;
  {$EXTERNALSYM PDATA_BLOB}
  PCryptDataBlob = ^TCryptDataBlob;
  CRYPT_DATA_BLOB = _CRYPTOAPI_BLOB;
  {$EXTERNALSYM CRYPT_DATA_BLOB}
  TCryptDataBlob = _CRYPTOAPI_BLOB;
  PPCRYPT_DATA_BLOB = ^PCRYPT_DATA_BLOB;
  PCRYPT_DATA_BLOB = PCryptDataBlob;
  {$EXTERNALSYM PCRYPT_DATA_BLOB}
  PCryptHashBlob = ^TCryptHashBlob;
  CRYPT_HASH_BLOB = _CRYPTOAPI_BLOB;
  {$EXTERNALSYM CRYPT_HASH_BLOB}
  TCryptHashBlob = _CRYPTOAPI_BLOB;
  PCRYPT_HASH_BLOB = PCryptHashBlob;
  {$EXTERNALSYM PCRYPT_HASH_BLOB}
  PCryptDigestBlob = ^TCryptDigestBlob;
  CRYPT_DIGEST_BLOB = _CRYPTOAPI_BLOB;
  {$EXTERNALSYM CRYPT_DIGEST_BLOB}
  TCryptDigestBlob = _CRYPTOAPI_BLOB;
  PCRYPT_DIGEST_BLOB = PCryptDigestBlob;
  {$EXTERNALSYM PCRYPT_DIGEST_BLOB}
  PCryptDERBlob = ^TCryptDERBlob;
  CRYPT_DER_BLOB = _CRYPTOAPI_BLOB;
  {$EXTERNALSYM CRYPT_DER_BLOB}
  TCryptDERBlob = _CRYPTOAPI_BLOB;
  PCRYPT_DER_BLOB = PCryptDERBlob;
  {$EXTERNALSYM PCRYPT_DER_BLOB}
  PCryptAttrBlob = ^TCryptAttrBlob;
  CRYPT_ATTR_BLOB = _CRYPTOAPI_BLOB;
  {$EXTERNALSYM CRYPT_ATTR_BLOB}
  TCryptAttrBlob = _CRYPTOAPI_BLOB;
  PCRYPT_ATTR_BLOB = PCryptAttrBlob;
  {$EXTERNALSYM PCRYPT_ATTR_BLOB}
// certenrolls_end

function CryptSetProvParam(
  hProv: HCRYPTPROV;
  dwParam: DWORD;
  pbData: PByte;
  dwFlags: DWORD): LongBool; stdcall;
{$EXTERNALSYM CryptSetProvParam}

// This type is used where the HCRYPTPROV parameter is no longer used.
// The caller should always pass in NULL.
type
  HCRYPTPROV_LEGACY = Pointer;
  {$EXTERNALSYM HCRYPTPROV_LEGACY}

function CryptAcquireContextW(
  phProv: PHCRYPTPROV;
  szContainer: LPCWSTR;
  szProvider: LPCWSTR;
  dwProvType: DWORD;
  dwFlags: DWORD): LongBool; stdcall;
{$EXTERNALSYM CryptAcquireContextW}

//+-------------------------------------------------------------------------
//  In a CRYPT_BIT_BLOB the last byte may contain 0-7 unused bits. Therefore, the
//  overall bit length is cbData * 8 - cUnusedBits.
//--------------------------------------------------------------------------
// certenrolls_begin -- CERT_CONTEXT
type
  _CRYPT_BIT_BLOB = record
    cbData: DWORD;
    pbData: PByte;
    cUnusedBits: DWORD;
  end;
  {$EXTERNALSYM _CRYPT_BIT_BLOB}
  CRYPT_BIT_BLOB = _CRYPT_BIT_BLOB;
  {$EXTERNALSYM CRYPT_BIT_BLOB}
  PCRYPT_BIT_BLOB = ^CRYPT_BIT_BLOB;
  {$EXTERNALSYM PCRYPT_BIT_BLOB}
//+-------------------------------------------------------------------------
//  Type used for any algorithm
//
//  Where the Parameters CRYPT_OBJID_BLOB is in its encoded representation. For most
//  algorithm types, the Parameters CRYPT_OBJID_BLOB is NULL (Parameters.cbData = 0).
//--------------------------------------------------------------------------
type
  _CRYPT_ALGORITHM_IDENTIFIER = record
    pszObjId: LPSTR;
    Parameters: TCryptObjIDBlob;
  end;
  {$EXTERNALSYM _CRYPT_ALGORITHM_IDENTIFIER}
  CRYPT_ALGORITHM_IDENTIFIER = _CRYPT_ALGORITHM_IDENTIFIER;
  {$EXTERNALSYM CRYPT_ALGORITHM_IDENTIFIER}
  PCRYPT_ALGORITHM_IDENTIFIER = ^CRYPT_ALGORITHM_IDENTIFIER;
  {$EXTERNALSYM PCRYPT_ALGORITHM_IDENTIFIER}
// certenrolls_end

//+-------------------------------------------------------------------------
//  Attributes
//
//  Where the Value's PATTR_BLOBs are in their encoded representation.
//--------------------------------------------------------------------------
// certenrolls_begin -- CRYPT_ATTRIBUTE
type
  _CRYPT_ATTRIBUTE = record
    pszObjId: LPSTR;
    cValue: DWORD;
    rgValue: PCryptAttrBlob;
  end;
  {$EXTERNALSYM _CRYPT_ATTRIBUTE}
  CRYPT_ATTRIBUTE = _CRYPT_ATTRIBUTE;
  {$EXTERNALSYM CRYPT_ATTRIBUTE}
  PCRYPT_ATTRIBUTE = ^CRYPT_ATTRIBUTE;

type
  _CRYPT_ATTRIBUTES = record
    cAttr: DWORD;
    rgAttr: PCRYPT_ATTRIBUTE;
  end;
  {$EXTERNALSYM _CRYPT_ATTRIBUTES}
  CRYPT_ATTRIBUTES = _CRYPT_ATTRIBUTES;
  {$EXTERNALSYM CRYPT_ATTRIBUTES}
  PCRYPT_ATTRIBUTES = ^CRYPT_ATTRIBUTES;
  {$EXTERNALSYM PCRYPT_ATTRIBUTES}
// certenrolls_end

//+-------------------------------------------------------------------------
//  Type used for an extension to an encoded content
//
//  Where the Value's CRYPT_OBJID_BLOB is in its encoded representation.
//--------------------------------------------------------------------------
// certenrolls_begin -- CERT_CONTEXT
type
  _CERT_EXTENSION = record
    pszObjId: LPSTR;
    fCritical: LongBool;
    Value: TCryptObjIDBlob;
  end;
  {$EXTERNALSYM _CERT_EXTENSION}
  CERT_EXTENSION = _CERT_EXTENSION;
  {$EXTERNALSYM CERT_EXTENSION}
  PCERT_EXTENSION = ^CERT_EXTENSION;
  {$EXTERNALSYM PCERT_EXTENSION}
// certenrolls_end

//+-------------------------------------------------------------------------
//  Public Key Info
//
//  The PublicKey is the encoded representation of the information as it is
//  stored in the bit string
//--------------------------------------------------------------------------
// certenrolls_begin -- CERT_CONTEXT
type
  _CERT_PUBLIC_KEY_INFO = record
    Algorithm: CRYPT_ALGORITHM_IDENTIFIER;
    PublicKey: CRYPT_BIT_BLOB;
  end;
  {$EXTERNALSYM _CERT_PUBLIC_KEY_INFO}
  CERT_PUBLIC_KEY_INFO = _CERT_PUBLIC_KEY_INFO;
  {$EXTERNALSYM CERT_PUBLIC_KEY_INFO}
  PCERT_PUBLIC_KEY_INFO = ^CERT_PUBLIC_KEY_INFO;
  {$EXTERNALSYM PCERT_PUBLIC_KEY_INFO}
// certenrolls_end

//+-------------------------------------------------------------------------
//  Certificate Information Flags
//--------------------------------------------------------------------------
const
  CERT_INFO_VERSION_FLAG                     = 1;
  {$EXTERNALSYM CERT_INFO_VERSION_FLAG}
  CERT_INFO_SERIAL_NUMBER_FLAG               = 2;
  {$EXTERNALSYM CERT_INFO_SERIAL_NUMBER_FLAG}
  CERT_INFO_SIGNATURE_ALGORITHM_FLAG         = 3;
  {$EXTERNALSYM CERT_INFO_SIGNATURE_ALGORITHM_FLAG}
  CERT_INFO_ISSUER_FLAG                      = 4;
  {$EXTERNALSYM CERT_INFO_ISSUER_FLAG}
  CERT_INFO_NOT_BEFORE_FLAG                  = 5;
  {$EXTERNALSYM CERT_INFO_NOT_BEFORE_FLAG}
  CERT_INFO_NOT_AFTER_FLAG                   = 6;
  {$EXTERNALSYM CERT_INFO_NOT_AFTER_FLAG}
  CERT_INFO_SUBJECT_FLAG                     = 7;
  {$EXTERNALSYM CERT_INFO_SUBJECT_FLAG}
  CERT_INFO_SUBJECT_PUBLIC_KEY_INFO_FLAG     = 8;
  {$EXTERNALSYM CERT_INFO_SUBJECT_PUBLIC_KEY_INFO_FLAG}
  CERT_INFO_ISSUER_UNIQUE_ID_FLAG            = 9;
  {$EXTERNALSYM CERT_INFO_ISSUER_UNIQUE_ID_FLAG}
  CERT_INFO_SUBJECT_UNIQUE_ID_FLAG           = 10;
  {$EXTERNALSYM CERT_INFO_SUBJECT_UNIQUE_ID_FLAG}
  CERT_INFO_EXTENSION_FLAG                   = 11;
  {$EXTERNALSYM CERT_INFO_EXTENSION_FLAG}

//+-------------------------------------------------------------------------
//  Information stored in a certificate
//
//  The Issuer, Subject, Algorithm, PublicKey and Extension BLOBs are the
//  encoded representation of the information.
//--------------------------------------------------------------------------
// certenrolls_begin -- CERT_CONTEXT
type
  _CERT_INFO = record
    dwVersion: DWORD;
    SerialNumber: TCryptIntegerBlob;
    SignatureAlgorithm: CRYPT_ALGORITHM_IDENTIFIER;
    Issuer: TCertNameBlob;
    NotBefore: TFileTime;
    NotAfter: TFileTime;
    Subject: TCertNameBlob;
    SubjectPublicKeyInfo: CERT_PUBLIC_KEY_INFO;
    IssuerUniqueId: CRYPT_BIT_BLOB;
    SubjectUniqueId: CRYPT_BIT_BLOB;
    cExtension: DWORD;
    rgExtension: PCERT_EXTENSION;
  end;
  {$EXTERNALSYM _CERT_INFO}
  CERT_INFO = _CERT_INFO;
  {$EXTERNALSYM CERT_INFO}
  PCERT_INFO = ^CERT_INFO;
  {$EXTERNALSYM PCERT_INFO}
// certenrolls_end

//+-------------------------------------------------------------------------
//  An entry in a CRL
//
//  The Extension BLOBs are the encoded representation of the information.
//--------------------------------------------------------------------------
type
  _CRL_ENTRY = record
    SerialNumber: TCryptIntegerBlob;
    RevocationDate: TFileTime;
    cExtension: DWORD;
    rgExtension: PCERT_EXTENSION;
  end;
  {$EXTERNALSYM _CRL_ENTRY}
  CRL_ENTRY = _CRL_ENTRY;
  {$EXTERNALSYM CRL_ENTRY}
  PCRL_ENTRY = ^CRL_ENTRY;
  {$EXTERNALSYM PCRL_ENTRY}
//+-------------------------------------------------------------------------
//  Information stored in a CRL
//
//  The Issuer, Algorithm and Extension BLOBs are the encoded
//  representation of the information.
//--------------------------------------------------------------------------
type
  _CRL_INFO = record
    dwVersion: DWORD;
    SignatureAlgorithm: CRYPT_ALGORITHM_IDENTIFIER;
    Issuer: TCertNameBlob;
    ThisUpdate: TFileTime;
    NextUpdate: TFileTime;
    cCRLEntry: DWORD;
    rgCRLEntry: PCRL_ENTRY;
    cExtension: DWORD;
    rgExtension:  PCERT_EXTENSION;
  end;
  {$EXTERNALSYM _CRL_INFO}
  CRL_INFO = _CRL_INFO;
  {$EXTERNALSYM CRL_INFO}
  PCRL_INFO = ^CRL_INFO;
  {$EXTERNALSYM PCRL_INFO}

//+-------------------------------------------------------------------------
//  Certificate Trust List (CTL)
//--------------------------------------------------------------------------
//+-------------------------------------------------------------------------
//  CTL Usage. Also used for EnhancedKeyUsage extension.
//--------------------------------------------------------------------------
type
  _CTL_USAGE = record
    cUsageIdentifier: DWORD;
    rgpszUsageIdentifier: PLPSTR;                    // array of pszObjId
  end;
  {$EXTERNALSYM _CTL_USAGE}
  CTL_USAGE = _CTL_USAGE;
  {$EXTERNALSYM CTL_USAGE}
  PCTL_USAGE = ^CTL_USAGE;
  {$EXTERNALSYM PCTL_USAGE}
  CERT_ENHKEY_USAGE = CTL_USAGE;
  {$EXTERNALSYM CERT_ENHKEY_USAGE}
  PCERT_ENHKEY_USAGE = PCTL_USAGE;
  {$EXTERNALSYM PCERT_ENHKEY_USAGE}

//+-------------------------------------------------------------------------
//  An entry in a CTL
//--------------------------------------------------------------------------
type
  _CTL_ENTRY = record
    SubjectIdentifier: TCryptDataBlob;               // For example, its hash
    cAttribute: DWORD;
    rgAttribute: PCRYPT_ATTRIBUTE                    // OPTIONAL
  end;
  {$EXTERNALSYM _CTL_ENTRY}
  CTL_ENTRY = _CTL_ENTRY;
  {$EXTERNALSYM CTL_ENTRY}
  PCTL_ENTRY = ^CTL_ENTRY;
  {$EXTERNALSYM PCTL_ENTRY}

//+-------------------------------------------------------------------------
//  Information stored in a CTL
//--------------------------------------------------------------------------
type
  _CTL_INFO = record
    dwVersion: DWORD;
    SubjectUsage: CTL_USAGE;
    ListIdentifier: TCryptDataBlob;                  // OPTIONAL
    SequenceNumber: TCryptIntegerBlob;               // OPTIONAL
    ThisUpdate: TFileTime;
    NextUpdate: TFileTime;                           // OPTIONAL
    SubjectAlgorithm: CRYPT_ALGORITHM_IDENTIFIER;
    cCTLEntry: DWORD;
    rgCTLEntry: PCTL_ENTRY;                           // OPTIONAL
    cExtension: DWORD;
    rgExtension: PCERT_EXTENSION;                    // OPTIONAL
  end;
  {$EXTERNALSYM _CTL_INFO}
  CTL_INFO = _CTL_INFO;
  {$EXTERNALSYM CTL_INFO}
  PCTL_INFO = ^CTL_INFO;
  {$EXTERNALSYM PCTL_INFO}

const
  X509_ASN_ENCODING          = $00000001;
  {$EXTERNALSYM X509_ASN_ENCODING}
  PKCS_7_ASN_ENCODING        = $00010000;
  {$EXTERNALSYM PKCS_7_ASN_ENCODING}

//+-------------------------------------------------------------------------
//  Certificate context.
//
//  A certificate context contains both the encoded and decoded representation
//  of a certificate. A certificate context returned by a cert store function
//  must be freed by calling the CertFreeCertificateContext function. The
//  CertDuplicateCertificateContext function can be called to make a duplicate
//  copy (which also must be freed by calling CertFreeCertificateContext).
//--------------------------------------------------------------------------
// certenrolls_begin -- CERT_CONTEXT
type
  _CERT_CONTEXT = record
    dwCertEncodingType: DWORD;
    pbCertEncoded: PByte;
    cbCertEncoded: DWORD;
    pCertInfo: PCERT_INFO;
    hCertStore: HCERTSTORE;
  end;
  {$EXTERNALSYM _CERT_CONTEXT}
  CERT_CONTEXT = _CERT_CONTEXT;
  {$EXTERNALSYM CERT_CONTEXT}
  PCERT_CONTEXT = ^CERT_CONTEXT;
  {$EXTERNALSYM PCERT_CONTEXT}
  PCCERT_CONTEXT = PCERT_CONTEXT;
  {$EXTERNALSYM PCCERT_CONTEXT}
// certenrolls_end

//+-------------------------------------------------------------------------
//  CRL context.
//
//  A CRL context contains both the encoded and decoded representation
//  of a CRL. A CRL context returned by a cert store function
//  must be freed by calling the CertFreeCRLContext function. The
//  CertDuplicateCRLContext function can be called to make a duplicate
//  copy (which also must be freed by calling CertFreeCRLContext).
//--------------------------------------------------------------------------
type
  _CRL_CONTEXT = record
    dwCertEncodingType: DWORD;
    pbCrlEncoded: PByte;
    cbCrlEncoded: DWORD;
    pCrlInfo: PCRL_INFO;
    hCertStore: HCERTSTORE;
  end;
  {$EXTERNALSYM _CRL_CONTEXT}
  CRL_CONTEXT = _CRL_CONTEXT;
  {$EXTERNALSYM CRL_CONTEXT}
  PCRL_CONTEXT = ^CRL_CONTEXT;
  {$EXTERNALSYM PCCRL_CONTEXT}
  PCCRL_CONTEXT = PCRL_CONTEXT;
  {$EXTERNALSYM PCCRL_CONTEXT}

// certenrolld_begin -- CERT_*_PROP_ID
//+-------------------------------------------------------------------------
//  Certificate, CRL and CTL property IDs
//
//  See CertSetCertificateContextProperty or CertGetCertificateContextProperty
//  for usage information.
//--------------------------------------------------------------------------
const
  CERT_KEY_PROV_HANDLE_PROP_ID        = 1;
  {$EXTERNALSYM CERT_KEY_PROV_HANDLE_PROP_ID}
  CERT_KEY_PROV_INFO_PROP_ID          = 2; // CRYPT_KEY_PROV_INFO
  {$EXTERNALSYM CERT_KEY_PROV_INFO_PROP_ID}
  CERT_SHA1_HASH_PROP_ID              = 3;
  {$EXTERNALSYM CERT_SHA1_HASH_PROP_ID}
  CERT_MD5_HASH_PROP_ID               = 4;
  {$EXTERNALSYM CERT_MD5_HASH_PROP_ID}
  CERT_HASH_PROP_ID                   = CERT_SHA1_HASH_PROP_ID;
  {$EXTERNALSYM CERT_HASH_PROP_ID}
  CERT_KEY_CONTEXT_PROP_ID            = 5;
  {$EXTERNALSYM CERT_KEY_CONTEXT_PROP_ID}
  CERT_KEY_SPEC_PROP_ID               = 6;
  {$EXTERNALSYM CERT_KEY_SPEC_PROP_ID}
  CERT_IE30_RESERVED_PROP_ID          = 7;
  {$EXTERNALSYM CERT_IE30_RESERVED_PROP_ID}
  CERT_PUBKEY_HASH_RESERVED_PROP_ID   = 8;
  {$EXTERNALSYM CERT_PUBKEY_HASH_RESERVED_PROP_ID}
  CERT_ENHKEY_USAGE_PROP_ID           = 9;
  {$EXTERNALSYM CERT_ENHKEY_USAGE_PROP_ID}
  CERT_CTL_USAGE_PROP_ID              = CERT_ENHKEY_USAGE_PROP_ID;
  {$EXTERNALSYM CERT_CTL_USAGE_PROP_ID}
  CERT_NEXT_UPDATE_LOCATION_PROP_ID   = 10;
  {$EXTERNALSYM CERT_NEXT_UPDATE_LOCATION_PROP_ID}
  CERT_FRIENDLY_NAME_PROP_ID          = 11; // string
  {$EXTERNALSYM CERT_FRIENDLY_NAME_PROP_ID}
  CERT_PVK_FILE_PROP_ID               = 12;
  {$EXTERNALSYM CERT_PVK_FILE_PROP_ID}
  CERT_DESCRIPTION_PROP_ID            = 13; // string
  {$EXTERNALSYM CERT_DESCRIPTION_PROP_ID}
  CERT_ACCESS_STATE_PROP_ID           = 14;
  {$EXTERNALSYM CERT_ACCESS_STATE_PROP_ID}
  CERT_SIGNATURE_HASH_PROP_ID         = 15;
  {$EXTERNALSYM CERT_SIGNATURE_HASH_PROP_ID}
  CERT_SMART_CARD_DATA_PROP_ID        = 16;
  {$EXTERNALSYM CERT_SMART_CARD_DATA_PROP_ID}
  CERT_EFS_PROP_ID                    = 17;
  {$EXTERNALSYM CERT_EFS_PROP_ID}
  CERT_FORTEZZA_DATA_PROP_ID          = 18;
  {$EXTERNALSYM CERT_FORTEZZA_DATA_PROP_ID}
  CERT_ARCHIVED_PROP_ID               = 19;
  {$EXTERNALSYM CERT_ARCHIVED_PROP_ID}
  CERT_KEY_IDENTIFIER_PROP_ID         = 20;
  {$EXTERNALSYM CERT_KEY_IDENTIFIER_PROP_ID}
  CERT_AUTO_ENROLL_PROP_ID            = 21; // string:Template name
  {$EXTERNALSYM CERT_AUTO_ENROLL_PROP_ID}
  CERT_PUBKEY_ALG_PARA_PROP_ID        = 22;
  {$EXTERNALSYM CERT_PUBKEY_ALG_PARA_PROP_ID}
  CERT_CROSS_CERT_DIST_POINTS_PROP_ID = 23;
  {$EXTERNALSYM CERT_CROSS_CERT_DIST_POINTS_PROP_ID}
  CERT_ISSUER_PUBLIC_KEY_MD5_HASH_PROP_ID    = 24;
  {$EXTERNALSYM CERT_ISSUER_PUBLIC_KEY_MD5_HASH_PROP_ID}
  CERT_SUBJECT_PUBLIC_KEY_MD5_HASH_PROP_ID   = 25;
  {$EXTERNALSYM CERT_SUBJECT_PUBLIC_KEY_MD5_HASH_PROP_ID}
  CERT_ENROLLMENT_PROP_ID             = 26; // RequestId+CADNS+CACN+Friendly Name
  {$EXTERNALSYM CERT_ENROLLMENT_PROP_ID}
  CERT_DATE_STAMP_PROP_ID             = 27; // FILETIME
  {$EXTERNALSYM CERT_DATE_STAMP_PROP_ID}
  CERT_ISSUER_SERIAL_NUMBER_MD5_HASH_PROP_ID = 28;
  {$EXTERNALSYM CERT_ISSUER_SERIAL_NUMBER_MD5_HASH_PROP_ID}
  CERT_SUBJECT_NAME_MD5_HASH_PROP_ID  = 29;
  {$EXTERNALSYM CERT_SUBJECT_NAME_MD5_HASH_PROP_ID}
  CERT_EXTENDED_ERROR_INFO_PROP_ID    = 30; // string
  {$EXTERNALSYM CERT_EXTENDED_ERROR_INFO_PROP_ID}

// Note, 32 - 35 are reserved for the CERT, CRL, CTL and KeyId file element IDs.
//       36 - 62 are reserved for future element IDs.

  CERT_RENEWAL_PROP_ID                = 64;
  {$EXTERNALSYM CERT_RENEWAL_PROP_ID}
  CERT_ARCHIVED_KEY_HASH_PROP_ID      = 65; // Encrypted key hash
  {$EXTERNALSYM CERT_ARCHIVED_KEY_HASH_PROP_ID}
  CERT_AUTO_ENROLL_RETRY_PROP_ID      = 66; // AE_RETRY_INFO:cb+cRetry+FILETIME
  {$EXTERNALSYM CERT_AUTO_ENROLL_RETRY_PROP_ID}
  CERT_AIA_URL_RETRIEVED_PROP_ID      = 67;
  {$EXTERNALSYM CERT_AIA_URL_RETRIEVED_PROP_ID}
  CERT_AUTHORITY_INFO_ACCESS_PROP_ID  = 68;
  {$EXTERNALSYM CERT_AUTHORITY_INFO_ACCESS_PROP_ID}
  CERT_BACKED_UP_PROP_ID              = 69; // VARIANT_BOOL+FILETIME
  {$EXTERNALSYM CERT_BACKED_UP_PROP_ID}
  CERT_OCSP_RESPONSE_PROP_ID          = 70;
  {$EXTERNALSYM CERT_OCSP_RESPONSE_PROP_ID}
  CERT_REQUEST_ORIGINATOR_PROP_ID     = 71; // string:machine DNS name
  {$EXTERNALSYM CERT_REQUEST_ORIGINATOR_PROP_ID}
  CERT_SOURCE_LOCATION_PROP_ID        = 72; // string
  {$EXTERNALSYM CERT_SOURCE_LOCATION_PROP_ID}
  CERT_SOURCE_URL_PROP_ID             = 73; // string
  {$EXTERNALSYM CERT_SOURCE_URL_PROP_ID}
  CERT_NEW_KEY_PROP_ID                = 74;
  {$EXTERNALSYM CERT_NEW_KEY_PROP_ID}
  CERT_OCSP_CACHE_PREFIX_PROP_ID      = 75; // string
  {$EXTERNALSYM CERT_OCSP_CACHE_PREFIX_PROP_ID}
  CERT_SMART_CARD_ROOT_INFO_PROP_ID   = 76; // CRYPT_SMART_CARD_ROOT_INFO
  {$EXTERNALSYM CERT_SMART_CARD_ROOT_INFO_PROP_ID}
  CERT_NO_AUTO_EXPIRE_CHECK_PROP_ID   = 77;
  {$EXTERNALSYM CERT_NO_AUTO_EXPIRE_CHECK_PROP_ID}
  CERT_NCRYPT_KEY_HANDLE_PROP_ID      = 78;
  {$EXTERNALSYM CERT_NCRYPT_KEY_HANDLE_PROP_ID}
  CERT_HCRYPTPROV_OR_NCRYPT_KEY_HANDLE_PROP_ID  = 79;
  {$EXTERNALSYM CERT_HCRYPTPROV_OR_NCRYPT_KEY_HANDLE_PROP_ID}

  CERT_SUBJECT_INFO_ACCESS_PROP_ID    = 80;
  {$EXTERNALSYM CERT_SUBJECT_INFO_ACCESS_PROP_ID}
  CERT_CA_OCSP_AUTHORITY_INFO_ACCESS_PROP_ID = 81;
  {$EXTERNALSYM CERT_CA_OCSP_AUTHORITY_INFO_ACCESS_PROP_ID}
  CERT_CA_DISABLE_CRL_PROP_ID         = 82;
  {$EXTERNALSYM CERT_CA_DISABLE_CRL_PROP_ID}
  CERT_ROOT_PROGRAM_CERT_POLICIES_PROP_ID    = 83;
  {$EXTERNALSYM CERT_ROOT_PROGRAM_CERT_POLICIES_PROP_ID}
  CERT_ROOT_PROGRAM_NAME_CONSTRAINTS_PROP_ID = 84;
  {$EXTERNALSYM CERT_ROOT_PROGRAM_NAME_CONSTRAINTS_PROP_ID}
  CERT_SUBJECT_OCSP_AUTHORITY_INFO_ACCESS_PROP_ID = 85;
  {$EXTERNALSYM CERT_SUBJECT_OCSP_AUTHORITY_INFO_ACCESS_PROP_ID}
  CERT_SUBJECT_DISABLE_CRL_PROP_ID    = 86;
  {$EXTERNALSYM CERT_SUBJECT_DISABLE_CRL_PROP_ID}
  CERT_CEP_PROP_ID                    = 87; // Version+PropFlags+AuthType+UrlFlags+CESAuthType+Url+Id+CESUrl+ReqId
  {$EXTERNALSYM CERT_CEP_PROP_ID}
// 88 reserved, originally used for CERT_CEP_PROP_ID
  CERT_SIGN_HASH_CNG_ALG_PROP_ID      = 89;
  {$EXTERNALSYM CERT_SIGN_HASH_CNG_ALG_PROP_ID}

  CERT_SCARD_PIN_ID_PROP_ID           = 90;
  {$EXTERNALSYM CERT_SCARD_PIN_ID_PROP_ID}
  CERT_SCARD_PIN_INFO_PROP_ID         = 91;
  {$EXTERNALSYM CERT_SCARD_PIN_INFO_PROP_ID}

  CERT_SUBJECT_PUB_KEY_BIT_LENGTH_PROP_ID = 92;
  {$EXTERNALSYM CERT_SUBJECT_PUB_KEY_BIT_LENGTH_PROP_ID}
  CERT_PUB_KEY_CNG_ALG_BIT_LENGTH_PROP_ID = 93;
  {$EXTERNALSYM CERT_PUB_KEY_CNG_ALG_BIT_LENGTH_PROP_ID}
  CERT_ISSUER_PUB_KEY_BIT_LENGTH_PROP_ID = 94;
  {$EXTERNALSYM CERT_ISSUER_PUB_KEY_BIT_LENGTH_PROP_ID}
  CERT_ISSUER_CHAIN_SIGN_HASH_CNG_ALG_PROP_ID = 95;
  {$EXTERNALSYM CERT_ISSUER_CHAIN_SIGN_HASH_CNG_ALG_PROP_ID}
  CERT_ISSUER_CHAIN_PUB_KEY_CNG_ALG_BIT_LENGTH_PROP_ID = 96;
  {$EXTERNALSYM CERT_ISSUER_CHAIN_PUB_KEY_CNG_ALG_BIT_LENGTH_PROP_ID}

  CERT_NO_EXPIRE_NOTIFICATION_PROP_ID = 97;
  {$EXTERNALSYM CERT_NO_EXPIRE_NOTIFICATION_PROP_ID}

// Following property isn't implicitly created via a GetProperty.
  CERT_AUTH_ROOT_SHA256_HASH_PROP_ID  = 98;
  {$EXTERNALSYM CERT_AUTH_ROOT_SHA256_HASH_PROP_ID}

  CERT_NCRYPT_KEY_HANDLE_TRANSFER_PROP_ID = 99;
  {$EXTERNALSYM CERT_NCRYPT_KEY_HANDLE_TRANSFER_PROP_ID}
  CERT_HCRYPTPROV_TRANSFER_PROP_ID    = 100;
  {$EXTERNALSYM CERT_HCRYPTPROV_TRANSFER_PROP_ID}

// Smart card reader image path
  CERT_SMART_CARD_READER_PROP_ID      = 101; //string
  {$EXTERNALSYM CERT_SMART_CARD_READER_PROP_ID}

// Send as trusted issuer
  CERT_SEND_AS_TRUSTED_ISSUER_PROP_ID = 102; //boolean
  {$EXTERNALSYM CERT_SEND_AS_TRUSTED_ISSUER_PROP_ID}

  CERT_KEY_REPAIR_ATTEMPTED_PROP_ID   = 103; // FILETME
  {$EXTERNALSYM CERT_KEY_REPAIR_ATTEMPTED_PROP_ID}

  CERT_DISALLOWED_FILETIME_PROP_ID    = 104;
  {$EXTERNALSYM CERT_DISALLOWED_FILETIME_PROP_ID}
  CERT_ROOT_PROGRAM_CHAIN_POLICIES_PROP_ID = 105;
  {$EXTERNALSYM CERT_ROOT_PROGRAM_CHAIN_POLICIES_PROP_ID}

// Smart card reader removable capabilities
  CERT_SMART_CARD_READER_NON_REMOVABLE_PROP_ID     = 106; // boolean
  {$EXTERNALSYM CERT_SMART_CARD_READER_NON_REMOVABLE_PROP_ID}

  CERT_FIRST_RESERVED_PROP_ID         = 107;
  {$EXTERNALSYM CERT_FIRST_RESERVED_PROP_ID}

  CERT_LAST_RESERVED_PROP_ID          = $00007FFF;
  {$EXTERNALSYM CERT_LAST_RESERVED_PROP_ID}
  CERT_FIRST_USER_PROP_ID             = $00008000;
  {$EXTERNALSYM CERT_FIRST_USER_PROP_ID}
  CERT_LAST_USER_PROP_ID              = $0000FFFF;
  {$EXTERNALSYM CERT_LAST_USER_PROP_ID}
// certenrolld_end

//+-------------------------------------------------------------------------
//  Certificate Trust List (CTL) context.
//
//  A CTL context contains both the encoded and decoded representation
//  of a CTL. Also contains an opened HCRYPTMSG handle to the decoded
//  cryptographic signed message containing the CTL_INFO as its inner content.
//  pbCtlContent is the encoded inner content of the signed message.
//
//  The CryptMsg APIs can be used to extract additional signer information.
//--------------------------------------------------------------------------
type
  _CTL_CONTEXT = record
    dwMsgAndCertEncodingType: DWORD;
    pbCtlEncoded: PByte;
    cbCtlEncoded: DWORD;
    pCtlInfo: PCTL_INFO;
    hCertStore: HCERTSTORE;
    hCryptMsg: HCRYPTMSG;
    pbCtlContent: PByte;
    cbCtlContent: DWORD;
  end;
  {$EXTERNALSYM _CTL_CONTEXT}
  CTL_CONTEXT = _CTL_CONTEXT;
  {$EXTERNALSYM CTL_CONTEXT}
  PCTL_CONTEXT = ^CTL_CONTEXT;
  {$EXTERNALSYM PCTL_CONTEXT}
  PCCTL_CONTEXT = PCTL_CONTEXT;
  {$EXTERNALSYM PCCTL_CONTEXT}

//+-------------------------------------------------------------------------
//  Cryptographic Key Provider Information
//
//  CRYPT_KEY_PROV_INFO defines the CERT_KEY_PROV_INFO_PROP_ID's pvData.
//
//  The CRYPT_KEY_PROV_INFO fields are passed to CryptAcquireContext
//  to get a HCRYPTPROV handle. The optional CRYPT_KEY_PROV_PARAM fields are
//  passed to CryptSetProvParam to further initialize the provider.
//
//  The dwKeySpec field identifies the private key to use from the container
//  For example, AT_KEYEXCHANGE or AT_SIGNATURE.
//--------------------------------------------------------------------------
type
  PCryptKeyProvParam = ^TCryptKeyProvParam;
  _CRYPT_KEY_PROV_PARAM = record
    dwParam: DWORD;
    pbData: PByte;
    cbData: DWORD;
    dwFlags: DWORD;
  end;
  {$EXTERNALSYM _CRYPT_KEY_PROV_PARAM}
  CRYPT_KEY_PROV_PARAM = _CRYPT_KEY_PROV_PARAM;
  {$EXTERNALSYM CRYPT_KEY_PROV_PARAM}
  TCryptKeyProvParam = _CRYPT_KEY_PROV_PARAM;
  PCRYPT_KEY_PROV_PARAM = PCryptKeyProvParam;
  {$EXTERNALSYM PCRYPT_KEY_PROV_PARAM}
type
  PCryptKeyProvInfo = ^TCryptKeyProvInfo;
  _CRYPT_KEY_PROV_INFO = record
    pwszContainerName: LPWSTR;
    pwszProvName: LPWSTR;
    dwProvType: DWORD;
    dwFlags: DWORD;
    cProvParam: DWORD;
    rgProvParam: PCryptKeyProvParam;
    dwKeySpec: DWORD;
  end;
  {$EXTERNALSYM _CRYPT_KEY_PROV_INFO}
  CRYPT_KEY_PROV_INFO = _CRYPT_KEY_PROV_INFO;
  {$EXTERNALSYM CRYPT_KEY_PROV_INFO}
  TCryptKeyProvInfo = _CRYPT_KEY_PROV_INFO;
  PCRYPT_KEY_PROV_INFO = PCryptKeyProvInfo;
  {$EXTERNALSYM PCRYPT_KEY_PROV_INFO}

//+-------------------------------------------------------------------------
//  Close a cert store handle.
//
//  There needs to be a corresponding close for each open and duplicate.
//
//  Even on the final close, the cert store isn't freed until all of its
//  certificate and CRL contexts have also been freed.
//
//  On the final close, the hCryptProv passed to CertStoreOpen is
//  CryptReleaseContext'ed.
//
//  To force the closure of the store with all of its memory freed, set the
//  CERT_STORE_CLOSE_FORCE_FLAG. This flag should be set when the caller does
//  its own reference counting and wants everything to vanish.
//
//  To check if all the store's certificates and CRLs have been freed and that
//  this is the last CertCloseStore, set the CERT_CLOSE_STORE_CHECK_FLAG. If
//  set and certs, CRLs or stores still need to be freed/closed, FALSE is
//  returned with LastError set to CRYPT_E_PENDING_CLOSE. Note, for FALSE,
//  the store is still closed. This is a diagnostic flag.
//
//  LastError is preserved unless CERT_CLOSE_STORE_CHECK_FLAG is set and FALSE
//  is returned.
//--------------------------------------------------------------------------
function CertCloseStore(
  hCertStore: HCERTSTORE;
  dwFlags: DWORD): LongBool; stdcall;
{$EXTERNALSYM CertCloseStore}

//+-------------------------------------------------------------------------
//  Find the first or next certificate context in the store.
//
//  The certificate is found according to the dwFindType and its pvFindPara.
//  See below for a list of the find types and its parameters.
//
//  Currently dwFindFlags is only used for CERT_FIND_SUBJECT_ATTR,
//  CERT_FIND_ISSUER_ATTR or CERT_FIND_CTL_USAGE. Otherwise, must be set to 0.
//
//  Usage of dwCertEncodingType depends on the dwFindType.
//
//  If the first or next certificate isn't found, NULL is returned.
//  Otherwise, a pointer to a read only CERT_CONTEXT is returned. CERT_CONTEXT
//  must be freed by calling CertFreeCertificateContext or is freed when passed as the
//  pPrevCertContext on a subsequent call. CertDuplicateCertificateContext
//  can be called to make a duplicate.
//
//  pPrevCertContext MUST BE NULL on the first
//  call to find the certificate. To find the next certificate, the
//  pPrevCertContext is set to the CERT_CONTEXT returned by a previous call.
//
//  NOTE: a NON-NULL pPrevCertContext is always CertFreeCertificateContext'ed by
//  this function, even for an error.
//--------------------------------------------------------------------------
function CertFindCertificateInStore(
  hCertStore: HCERTSTORE;
  dwCertEncodingType: DWORD;
  dwFindFlags: DWORD;
  dwFindType: DWORD;
  pvFindPara: Pointer;
  pPrevCertContext: PCERT_CONTEXT): PCERT_CONTEXT; stdcall;
{$EXTERNALSYM CertFindCertificateInStore}

//+-------------------------------------------------------------------------
// Certificate comparison functions
//--------------------------------------------------------------------------
const
  CERT_COMPARE_MASK           = $FFFF;
  {$EXTERNALSYM CERT_COMPARE_MASK}
  CERT_COMPARE_SHIFT          = 16;
  {$EXTERNALSYM CERT_COMPARE_SHIFT}
  CERT_COMPARE_ANY            = 0;
  {$EXTERNALSYM CERT_COMPARE_ANY}
  CERT_COMPARE_SHA1_HASH      = 1;
  {$EXTERNALSYM CERT_COMPARE_SHA1_HASH}
  CERT_COMPARE_NAME           = 2;
  {$EXTERNALSYM CERT_COMPARE_NAME}
  CERT_COMPARE_ATTR           = 3;
  {$EXTERNALSYM CERT_COMPARE_ATTR}
  CERT_COMPARE_MD5_HASH       = 4;
  {$EXTERNALSYM CERT_COMPARE_MD5_HASH}
  CERT_COMPARE_PROPERTY       = 5;
  {$EXTERNALSYM CERT_COMPARE_PROPERTY}
  CERT_COMPARE_PUBLIC_KEY     = 6;
  {$EXTERNALSYM CERT_COMPARE_PUBLIC_KEY}
  CERT_COMPARE_HASH           = CERT_COMPARE_SHA1_HASH;
  {$EXTERNALSYM CERT_COMPARE_HASH}
  CERT_COMPARE_NAME_STR_A     = 7;
  {$EXTERNALSYM CERT_COMPARE_NAME_STR_A}
  CERT_COMPARE_NAME_STR_W     = 8;
  {$EXTERNALSYM CERT_COMPARE_NAME_STR_W}
  CERT_COMPARE_KEY_SPEC       = 9;
  {$EXTERNALSYM CERT_COMPARE_KEY_SPEC}
  CERT_COMPARE_ENHKEY_USAGE   = 10;
  {$EXTERNALSYM CERT_COMPARE_ENHKEY_USAGE}
  CERT_COMPARE_CTL_USAGE      = CERT_COMPARE_ENHKEY_USAGE;
  {$EXTERNALSYM CERT_COMPARE_CTL_USAGE}
  CERT_COMPARE_SUBJECT_CERT   = 11;
  {$EXTERNALSYM CERT_COMPARE_SUBJECT_CERT}
  CERT_COMPARE_ISSUER_OF      = 12;
  {$EXTERNALSYM CERT_COMPARE_ISSUER_OF}
  CERT_COMPARE_EXISTING       = 13;
  {$EXTERNALSYM CERT_COMPARE_EXISTING}
  CERT_COMPARE_SIGNATURE_HASH = 14;
  {$EXTERNALSYM CERT_COMPARE_SIGNATURE_HASH}
  CERT_COMPARE_KEY_IDENTIFIER = 15;
  {$EXTERNALSYM CERT_COMPARE_KEY_IDENTIFIER}
  CERT_COMPARE_CERT_ID        = 16;
  {$EXTERNALSYM CERT_COMPARE_CERT_ID}
  CERT_COMPARE_CROSS_CERT_DIST_POINTS = 17;
  {$EXTERNALSYM CERT_COMPARE_CROSS_CERT_DIST_POINTS}

  CERT_COMPARE_PUBKEY_MD5_HASH = 18;
  {$EXTERNALSYM CERT_COMPARE_PUBKEY_MD5_HASH}

  CERT_COMPARE_SUBJECT_INFO_ACCESS = 19;
  {$EXTERNALSYM CERT_COMPARE_SUBJECT_INFO_ACCESS}
  CERT_COMPARE_HASH_STR       = 20;
  {$EXTERNALSYM CERT_COMPARE_HASH_STR}
  CERT_COMPARE_HAS_PRIVATE_KEY = 21;
  {$EXTERNALSYM CERT_COMPARE_HAS_PRIVATE_KEY}

//+-------------------------------------------------------------------------
//  dwFindType
//
//  The dwFindType definition consists of two components:
//   - comparison function
//   - certificate information flag
//--------------------------------------------------------------------------
const
  CERT_FIND_ANY           = (CERT_COMPARE_ANY shl CERT_COMPARE_SHIFT);
  {$EXTERNALSYM CERT_FIND_ANY}
  CERT_FIND_SHA1_HASH     = (CERT_COMPARE_SHA1_HASH shl CERT_COMPARE_SHIFT);
  {$EXTERNALSYM CERT_FIND_SHA1_HASH}
  CERT_FIND_MD5_HASH      = (CERT_COMPARE_MD5_HASH shl CERT_COMPARE_SHIFT);
  {$EXTERNALSYM CERT_FIND_MD5_HASH}
  CERT_FIND_SIGNATURE_HASH = (CERT_COMPARE_SIGNATURE_HASH shl CERT_COMPARE_SHIFT);
  {$EXTERNALSYM CERT_FIND_SIGNATURE_HASH}
  CERT_FIND_KEY_IDENTIFIER = (CERT_COMPARE_KEY_IDENTIFIER shl CERT_COMPARE_SHIFT);
  {$EXTERNALSYM CERT_FIND_KEY_IDENTIFIER}
  CERT_FIND_HASH          = CERT_FIND_SHA1_HASH;
  {$EXTERNALSYM CERT_FIND_HASH}
  CERT_FIND_PROPERTY      = (CERT_COMPARE_PROPERTY shl CERT_COMPARE_SHIFT);
  {$EXTERNALSYM CERT_FIND_PROPERTY}
  CERT_FIND_PUBLIC_KEY    = (CERT_COMPARE_PUBLIC_KEY shl CERT_COMPARE_SHIFT);
  {$EXTERNALSYM CERT_FIND_PUBLIC_KEY}
  CERT_FIND_SUBJECT_NAME  = (CERT_COMPARE_NAME shl CERT_COMPARE_SHIFT or CERT_INFO_SUBJECT_FLAG);
  {$EXTERNALSYM CERT_FIND_SUBJECT_NAME}
  CERT_FIND_SUBJECT_ATTR  = (CERT_COMPARE_ATTR shl CERT_COMPARE_SHIFT or CERT_INFO_SUBJECT_FLAG);
  {$EXTERNALSYM CERT_FIND_SUBJECT_ATTR}
  CERT_FIND_ISSUER_NAME   = (CERT_COMPARE_NAME shl CERT_COMPARE_SHIFT or CERT_INFO_ISSUER_FLAG);
  {$EXTERNALSYM CERT_FIND_ISSUER_NAME}
  CERT_FIND_ISSUER_ATTR   = (CERT_COMPARE_ATTR shl CERT_COMPARE_SHIFT or CERT_INFO_ISSUER_FLAG);
  {$EXTERNALSYM CERT_FIND_ISSUER_ATTR}
  CERT_FIND_SUBJECT_STR_A = (CERT_COMPARE_NAME_STR_A shl CERT_COMPARE_SHIFT or CERT_INFO_SUBJECT_FLAG);
  {$EXTERNALSYM CERT_FIND_SUBJECT_STR_A}
  CERT_FIND_SUBJECT_STR_W = (CERT_COMPARE_NAME_STR_W shl CERT_COMPARE_SHIFT or CERT_INFO_SUBJECT_FLAG);
  {$EXTERNALSYM CERT_FIND_SUBJECT_STR_W}
  CERT_FIND_SUBJECT_STR   = CERT_FIND_SUBJECT_STR_W;
  {$EXTERNALSYM CERT_FIND_SUBJECT_STR}
  CERT_FIND_ISSUER_STR_A  = (CERT_COMPARE_NAME_STR_A shl CERT_COMPARE_SHIFT or CERT_INFO_ISSUER_FLAG);
  {$EXTERNALSYM CERT_FIND_ISSUER_STR_A}
  CERT_FIND_ISSUER_STR_W  = (CERT_COMPARE_NAME_STR_W shl CERT_COMPARE_SHIFT or CERT_INFO_ISSUER_FLAG);
  {$EXTERNALSYM CERT_FIND_ISSUER_STR_W}
  CERT_FIND_ISSUER_STR    = CERT_FIND_ISSUER_STR_W;
  {$EXTERNALSYM CERT_FIND_ISSUER_STR}
  CERT_FIND_KEY_SPEC      = (CERT_COMPARE_KEY_SPEC shl CERT_COMPARE_SHIFT);
  {$EXTERNALSYM CERT_FIND_KEY_SPEC}
  CERT_FIND_ENHKEY_USAGE  = (CERT_COMPARE_ENHKEY_USAGE shl CERT_COMPARE_SHIFT);
  {$EXTERNALSYM CERT_FIND_ENHKEY_USAGE}
  CERT_FIND_CTL_USAGE     = CERT_FIND_ENHKEY_USAGE;
  {$EXTERNALSYM CERT_FIND_CTL_USAGE}

  CERT_FIND_SUBJECT_CERT  = (CERT_COMPARE_SUBJECT_CERT shl CERT_COMPARE_SHIFT);
  {$EXTERNALSYM CERT_FIND_SUBJECT_CERT}
  CERT_FIND_ISSUER_OF     = (CERT_COMPARE_ISSUER_OF shl CERT_COMPARE_SHIFT);
  {$EXTERNALSYM CERT_FIND_ISSUER_OF}
  CERT_FIND_EXISTING      = (CERT_COMPARE_EXISTING shl CERT_COMPARE_SHIFT);
  {$EXTERNALSYM CERT_FIND_EXISTING}
  CERT_FIND_CERT_ID       = (CERT_COMPARE_CERT_ID shl CERT_COMPARE_SHIFT);
  {$EXTERNALSYM CERT_FIND_CERT_ID}
  CERT_FIND_CROSS_CERT_DIST_POINTS = (CERT_COMPARE_CROSS_CERT_DIST_POINTS shl CERT_COMPARE_SHIFT);
  {$EXTERNALSYM CERT_FIND_CROSS_CERT_DIST_POINTS}

  CERT_FIND_PUBKEY_MD5_HASH = (CERT_COMPARE_PUBKEY_MD5_HASH shl CERT_COMPARE_SHIFT);
  {$EXTERNALSYM CERT_FIND_PUBKEY_MD5_HASH}

  CERT_FIND_SUBJECT_INFO_ACCESS = (CERT_COMPARE_SUBJECT_INFO_ACCESS shl CERT_COMPARE_SHIFT);
  {$EXTERNALSYM CERT_FIND_SUBJECT_INFO_ACCESS}

  CERT_FIND_HASH_STR      = (CERT_COMPARE_HASH_STR shl CERT_COMPARE_SHIFT);
  {$EXTERNALSYM CERT_FIND_HASH_STR}
  CERT_FIND_HAS_PRIVATE_KEY = (CERT_COMPARE_HAS_PRIVATE_KEY shl CERT_COMPARE_SHIFT);
  {$EXTERNALSYM CERT_FIND_HAS_PRIVATE_KEY}

//+-------------------------------------------------------------------------
//  Get the property for the specified certificate context.
//
//  For CERT_KEY_PROV_HANDLE_PROP_ID, pvData points to a HCRYPTPROV.
//  The CERT_NCRYPT_KEY_SPEC NCRYPT_KEY_HANDLE choice isn't returned.
//
//  For CERT_NCRYPT_KEY_HANDLE_PROP_ID, pvData points to a NCRYPT_KEY_HANDLE.
//  Only returned for the CERT_NCRYPT_KEY_SPEC choice.
//
//  For CERT_HCRYPTPROV_OR_NCRYPT_KEY_HANDLE_PROP_ID, pvData points to a
//  HCRYPTPROV_OR_NCRYPT_KEY_HANDLE. Returns either the HCRYPTPROV or
//  NCRYPT_KEY_HANDLE choice.
//
//  For CERT_KEY_PROV_INFO_PROP_ID, pvData points to a CRYPT_KEY_PROV_INFO structure.
//  Elements pointed to by fields in the pvData structure follow the
//  structure. Therefore, *pcbData may exceed the size of the structure.
//
//  For CERT_KEY_CONTEXT_PROP_ID, pvData points to a CERT_KEY_CONTEXT structure.
//
//  For CERT_KEY_SPEC_PROP_ID, pvData points to a DWORD containing the KeySpec.
//  If the CERT_KEY_CONTEXT_PROP_ID exists, the KeySpec is obtained from there.
//  Otherwise, if the CERT_KEY_PROV_INFO_PROP_ID exists, its the source
//  of the KeySpec. CERT_NCRYPT_KEY_SPEC is returned if the
//  CERT_NCRYPT_KEY_HANDLE_PROP_ID has been set.
//
//  For CERT_SHA1_HASH_PROP_ID or CERT_MD5_HASH_PROP_ID, if the hash
//  doesn't already exist, then, its computed via CryptHashCertificate()
//  and then set. pvData points to the computed hash. Normally, the length
//  is 20 bytes for SHA and 16 for MD5.
//
//  For CERT_SIGNATURE_HASH_PROP_ID, if the hash
//  doesn't already exist, then, its computed via CryptHashToBeSigned()
//  and then set. pvData points to the computed hash. Normally, the length
//  is 20 bytes for SHA and 16 for MD5.
//
//  For CERT_ACCESS_STATE_PROP_ID, pvData points to a DWORD containing the
//  access state flags. The appropriate CERT_ACCESS_STATE_*_FLAG's are set
//  in the returned DWORD. See the CERT_ACCESS_STATE_*_FLAG definitions
//  above. Note, this property is read only. It can't be set.
//
//  For CERT_KEY_IDENTIFIER_PROP_ID, if property doesn't already exist,
//  first searches for the szOID_SUBJECT_KEY_IDENTIFIER extension. Next,
//  does SHA1 hash of the certficate's SubjectPublicKeyInfo. pvData
//  points to the key identifier bytes. Normally, the length is 20 bytes.
//
//  For CERT_PUBKEY_ALG_PARA_PROP_ID, pvPara points to the ASN.1 encoded
//  PublicKey Algorithm Parameters. This property will only be set
//  for public keys supporting algorithm parameter inheritance and when the
//  parameters have been omitted from the encoded and signed certificate.
//
//  For CERT_DATE_STAMP_PROP_ID, pvPara points to a FILETIME updated by
//  an admin tool to indicate when the certificate was added to the store.
//
//  For CERT_OCSP_RESPONSE_PROP_ID, pvPara points to an encoded OCSP response.
//
//  For CERT_SOURCE_LOCATION_PROP_ID and CERT_SOURCE_URL_PROP_ID,
//  pvPara points to a NULL terminated unicode, wide character string.
//
//  For all other PROP_IDs, pvData points to an encoded array of bytes.
//--------------------------------------------------------------------------
function CertGetCertificateContextProperty(
  pCertContext: PCERT_CONTEXT;
  dwPropId: DWORD;
  pvData: Pointer;
  pcbData: PDWORD): LongBool; stdcall;
{$EXTERNALSYM CertGetCertificateContextProperty}

//+-------------------------------------------------------------------------
//  Enumerate the certificate contexts in the store.
//
//  If a certificate isn't found, NULL is returned.
//  Otherwise, a pointer to a read only CERT_CONTEXT is returned. CERT_CONTEXT
//  must be freed by calling CertFreeCertificateContext or is freed when passed as the
//  pPrevCertContext on a subsequent call. CertDuplicateCertificateContext
//  can be called to make a duplicate.
//
//  pPrevCertContext MUST BE NULL to enumerate the first
//  certificate in the store. Successive certificates are enumerated by setting
//  pPrevCertContext to the CERT_CONTEXT returned by a previous call.
//
//  NOTE: a NON-NULL pPrevCertContext is always CertFreeCertificateContext'ed by
//  this function, even for an error.
//--------------------------------------------------------------------------
function CertEnumCertificatesInStore(
  hCertStore: HCERTSTORE;
  pPrevCertContext: PCERT_CONTEXT): PCERT_CONTEXT; stdcall;
{$EXTERNALSYM CertEnumCertificatesInStore}
//+-------------------------------------------------------------------------
//  Free a certificate context
//
//  There needs to be a corresponding free for each context obtained by a
//  get, find, duplicate or create.
//--------------------------------------------------------------------------
function CertFreeCertificateContext(
  pCertContext: PCERT_CONTEXT): LongBool; stdcall;
{$EXTERNALSYM CertFreeCertificateContext}

//+=========================================================================
//  Certificate Revocation Data Structures and APIs
//==========================================================================
//+-------------------------------------------------------------------------
//  This data structure is updated by a CRL revocation type handler
//  with the base and possibly the delta CRL used.
//--------------------------------------------------------------------------
type
  _CERT_REVOCATION_CRL_INFO = record
    cbSize: DWORD;
    pBaseCrlContext: PCRL_CONTEXT;
    pDeltaCrlContext: PCRL_CONTEXT;
    // When revoked, points to entry in either of the above CRL contexts.
    // Don't free.
    pCrlEntry: PCRL_ENTRY;
    fDeltaCrlEntry: LongBool;                     // TRUE if in pDeltaCrlContext
  end;
  {$EXTERNALSYM _CERT_REVOCATION_CRL_INFO}
  CERT_REVOCATION_CRL_INFO = _CERT_REVOCATION_CRL_INFO;
  {$EXTERNALSYM CERT_REVOCATION_CRL_INFO}
  PCERT_REVOCATION_CRL_INFO = ^CERT_REVOCATION_CRL_INFO;
  {$EXTERNALSYM PCERT_REVOCATION_CRL_INFO}

type
  HCERTCHAINENGINE = TfrHandle;
  {$EXTERNALSYM HCERTCHAINENGINE}

//+-------------------------------------------------------------------------
//  Convert the certificate name blob to a null terminated char string.
//
//  Follows the string representation of distinguished names specified in
//  RFC 1779. (Note, added double quoting "" for embedded quotes, quote
//  empty strings and don't quote strings containing consecutive spaces).
//  RDN values of type CERT_RDN_ENCODED_BLOB or CERT_RDN_OCTET_STRING are
//  formatted in hexadecimal (e.g. #0A56CF).
//
//  The name string is formatted according to the dwStrType:
//    CERT_SIMPLE_NAME_STR
//      The object identifiers are discarded. CERT_RDN entries are separated
//      by ", ". Multiple attributes per CERT_RDN are separated by " + ".
//      For example:
//          Microsoft, Joe Cool + Programmer
//    CERT_OID_NAME_STR
//      The object identifiers are included with a "=" separator from their
//      attribute value. CERT_RDN entries are separated by ", ".
//      Multiple attributes per CERT_RDN are separated by " + ". For example:
//          2.5.4.11=Microsoft, 2.5.4.3=Joe Cool + 2.5.4.12=Programmer
//    CERT_X500_NAME_STR
//      The object identifiers are converted to their X500 key name. Otherwise,
//      same as CERT_OID_NAME_STR. If the object identifier doesn't have
//      a corresponding X500 key name, then, the object identifier is used with
//      a "OID." prefix. For example:
//          OU=Microsoft, CN=Joe Cool + T=Programmer, OID.1.2.3.4.5.6=Unknown
//    CERT_XML_NAME_STR
//      The object identifiers are converted the same as the above
//      CERT_X500_NAME_STR. However, formatted as sequence of XML elements.
//      Here's an example:
//          <CN>cart.barnesandnoble.com</CN>
//          <OU>Terms of use at www.verisign.com/rpa (c)00</OU>
//          <OU rDNAttribute="true">IT Operations</OU>
//          <O>Barnesandnoble.com</O>
//          <L>New York</L>
//          <S>New York</S>
//          <C>US</C>
//          <RDN oid="1.2.3.4" type="string">name</RDN>
//          <RDN rDNAttribute="true" oid="1.2.1.3" type="encoded">0500</RDN>
//          <RDN oid="1.2.1.4" type="encoded">020135</RDN>
//          <RDN oid="1.2.2.5.3" type="octet">01FF7F</RDN>
//      Where:
//          Any XML markup characters are escaped:
//             L'&'   - L"&amp;"
//             L'<'   - L"&lt;"
//             L'>'   - L"&gt;"
//             L'\''  - L"&apos;"
//             L'\"'  - L"&quot;"
//          Will escape characters > 0x7F via chararacter references,
//          L"&#xXXXX;"
//
//          CERT_NAME_STR_REVERSE_FLAG and CERT_NAME_STR_CRLF_FLAG can be set.
//          The following quoting, semicolon and plus semantics aren't
//          applicable. The "+" is replaced with rDNAttribute="true".
//
//
//  We quote the RDN value if it contains leading or trailing whitespace
//  or one of the following characters: ",", "+", "=", """, "\n",  "<", ">",
//  "#" or ";". The quoting character is ". If the the RDN Value contains
//  a " it is double quoted (""). For example:
//      OU="  Microsoft", CN="Joe ""Cool""" + T="Programmer, Manager"
//
//  CERT_NAME_STR_SEMICOLON_FLAG can be or'ed into dwStrType to replace
//  the ", " separator with a "; " separator.
//
//  CERT_NAME_STR_CRLF_FLAG can be or'ed into dwStrType to replace
//  the ", " separator with a "\r\n" separator.
//
//  CERT_NAME_STR_NO_PLUS_FLAG can be or'ed into dwStrType to replace the
//  " + " separator with a single space, " ".
//
//  CERT_NAME_STR_NO_QUOTING_FLAG can be or'ed into dwStrType to inhibit
//  the above quoting.
//
//  CERT_NAME_STR_REVERSE_FLAG can be or'ed into dwStrType to reverse the
//  order of the RDNs before converting to the string.
//
//  By default, CERT_RDN_T61_STRING encoded values are initially decoded
//  as UTF8. If the UTF8 decoding fails, then, decoded as 8 bit characters.
//  CERT_NAME_STR_DISABLE_IE4_UTF8_FLAG can be or'ed into dwStrType to
//  skip the initial attempt to decode as UTF8.
//
//  CERT_NAME_STR_ENABLE_PUNYCODE_FLAG can be or'ed into dwStrType to enable
//  encoding/decoding of unicode characters in email RDN value.
//
//  Returns the number of characters converted including the terminating null
//  character. If psz is NULL or csz is 0, returns the required size of the
//  destination string (including the terminating null char).
//
//  If psz != NULL && csz != 0, returned psz is always NULL terminated.
//
//  Note: csz includes the NULL char.
//--------------------------------------------------------------------------
//+-------------------------------------------------------------------------
//--------------------------------------------------------------------------
function CertNameToStrA(
  dwCertEncodingType: DWORD;
  pName: PCertNameBlob;
  dwStrType: DWORD;
  psz: Pointer;
  csz: DWORD): DWORD; stdcall;
{$EXTERNALSYM CertNameToStrA}
//+-------------------------------------------------------------------------
//--------------------------------------------------------------------------
function CertNameToStrW(
  dwCertEncodingType: DWORD;
  pName: PCertNameBlob;
  dwStrType: DWORD;
  psz: Pointer;
  csz: DWORD): DWORD; stdcall;
{$EXTERNALSYM CertNameToStrW}
function CertNameToStr(
  dwCertEncodingType: DWORD;
  pName: PCertNameBlob;
  dwStrType: DWORD;
  psz: Pointer;
  csz: DWORD): DWORD; stdcall;
{$EXTERNALSYM CertNameToStr}

// certenrolld_begin -- CERT_NAME_STR_*_FLAG
//+-------------------------------------------------------------------------
//  Certificate name string types
//--------------------------------------------------------------------------
const
  CERT_SIMPLE_NAME_STR       = 1;
  {$EXTERNALSYM CERT_SIMPLE_NAME_STR}
  CERT_OID_NAME_STR          = 2;
  {$EXTERNALSYM CERT_OID_NAME_STR}
  CERT_X500_NAME_STR         = 3;
  {$EXTERNALSYM CERT_X500_NAME_STR}
  CERT_XML_NAME_STR          = 4;
  {$EXTERNALSYM CERT_XML_NAME_STR}
//+-------------------------------------------------------------------------
//  Certificate name string type flags OR'ed with the above types
//--------------------------------------------------------------------------
const
  CERT_NAME_STR_SEMICOLON_FLAG   = $40000000;
  {$EXTERNALSYM CERT_NAME_STR_SEMICOLON_FLAG}
  CERT_NAME_STR_NO_PLUS_FLAG     = $20000000;
  {$EXTERNALSYM CERT_NAME_STR_NO_PLUS_FLAG}
  CERT_NAME_STR_NO_QUOTING_FLAG  = $10000000;
  {$EXTERNALSYM CERT_NAME_STR_NO_QUOTING_FLAG}
  CERT_NAME_STR_CRLF_FLAG        = $08000000;
  {$EXTERNALSYM CERT_NAME_STR_CRLF_FLAG}
  CERT_NAME_STR_COMMA_FLAG       = $04000000;
  {$EXTERNALSYM CERT_NAME_STR_COMMA_FLAG
  CERT_NAME_STR_REVERSE_FLAG     = $02000000;
  {$EXTERNALSYM CERT_NAME_STR_REVERSE_FLAG}
  CERT_NAME_STR_FORWARD_FLAG     = $01000000;
  {$EXTERNALSYM CERT_NAME_STR_FORWARD_FLAG}
  CERT_NAME_STR_DISABLE_IE4_UTF8_FLAG     = $00010000;
  {$EXTERNALSYM CERT_NAME_STR_DISABLE_IE4_UTF8_FLAG}
  CERT_NAME_STR_ENABLE_T61_UNICODE_FLAG   = $00020000;
  {$EXTERNALSYM CERT_NAME_STR_ENABLE_T61_UNICODE_FLAG}
  CERT_NAME_STR_ENABLE_UTF8_UNICODE_FLAG  = $00040000;
  {$EXTERNALSYM CERT_NAME_STR_ENABLE_UTF8_UNICODE_FLAG}
  CERT_NAME_STR_FORCE_UTF8_DIR_STR_FLAG   = $00080000;
  {$EXTERNALSYM CERT_NAME_STR_FORCE_UTF8_DIR_STR_FLAG}
  CERT_NAME_STR_DISABLE_UTF8_DIR_STR_FLAG = $00100000;
  {$EXTERNALSYM CERT_NAME_STR_DISABLE_UTF8_DIR_STR_FLAG}
  CERT_NAME_STR_ENABLE_PUNYCODE_FLAG      = $00200000;
  {$EXTERNALSYM CERT_NAME_STR_ENABLE_PUNYCODE_FLAG}
// certenrolld_end

//+-------------------------------------------------------------------------
//  The CRYPT_SIGN_MESSAGE_PARA are used for signing messages using the
//  specified signing certificate context.
//
//  Either the CERT_KEY_PROV_HANDLE_PROP_ID or CERT_KEY_PROV_INFO_PROP_ID must
//  be set for each rgpSigningCert[]. Either one specifies the private
//  signature key to use.
//
//  If any certificates and/or CRLs are to be included in the signed message,
//  then, the MsgCert and MsgCrl parameters need to be updated. If the
//  rgpSigningCerts are to be included, then, they must also be in the
//  rgpMsgCert array.
//
//  cbSize must be set to the sizeof(CRYPT_SIGN_MESSAGE_PARA) or else
//  LastError will be updated with E_INVALIDARG.
//
//  pvHashAuxInfo currently isn't used and must be set to NULL.
//
//  dwFlags normally is set to 0. However, if the encoded output
//  is to be a CMSG_SIGNED inner content of an outer cryptographic message,
//  such as a CMSG_ENVELOPED, then, the CRYPT_MESSAGE_BARE_CONTENT_OUT_FLAG
//  should be set. If not set, then it would be encoded as an inner content
//  type of CMSG_DATA.
//
//  dwInnerContentType is normally set to 0. It needs to be set if the
//  ToBeSigned input is the encoded output of another cryptographic
//  message, such as, an CMSG_ENVELOPED. When set, it's one of the cryptographic
//  message types, for example, CMSG_ENVELOPED.
//
//  If the inner content of a nested cryptographic message is data (CMSG_DATA
//  the default), then, neither dwFlags or dwInnerContentType need to be set.
//
//  For CMS messages, CRYPT_MESSAGE_ENCAPSULATED_CONTENT_OUT_FLAG may be
//  set to encapsulate nonData inner content within an OCTET STRING.
//
//  For CMS messages, CRYPT_MESSAGE_KEYID_SIGNER_FLAG may be set to identify
//  signers by their Key Identifier and not their Issuer and Serial Number.
//
//  The CRYPT_MESSAGE_SILENT_KEYSET_FLAG can be set to suppress any UI by the
//  CSP. See CryptAcquireContext's CRYPT_SILENT flag for more details.
//
//  If HashEncryptionAlgorithm is present and not NULL its used instead of
//  the SigningCert's PublicKeyInfo.Algorithm.
//
//  Note, for RSA, the hash encryption algorithm is normally the same as
//  the public key algorithm. For DSA, the hash encryption algorithm is
//  normally a DSS signature algorithm.
//
//  pvHashEncryptionAuxInfo currently isn't used and must be set to NULL if
//  present in the data structure.
//--------------------------------------------------------------------------
{.$Define CRYPT_SIGN_MESSAGE_PARA_HAS_CMS_FIELDS}
type
  _CRYPT_SIGN_MESSAGE_PARA = record
    cbSize: DWORD;
    dwMsgEncodingType: DWORD;
    pSigningCert: PCERT_CONTEXT;
    HashAlgorithm: CRYPT_ALGORITHM_IDENTIFIER;
    pvHashAuxInfo: Pointer;
    cMsgCert: DWORD;
    rgpMsgCert: ^PCERT_CONTEXT;
    cMsgCrl: DWORD;
    rgpMsgCrl: ^PCRL_CONTEXT;
    cAuthAttr: DWORD;
    rgAuthAttr: PCRYPT_ATTRIBUTE;
    cUnauthAttr: DWORD;
    rgUnauthAttr: PCRYPT_ATTRIBUTE;
    dwFlags: DWORD;
    dwInnerContentType: DWORD;
{$IFDEF CRYPT_SIGN_MESSAGE_PARA_HAS_CMS_FIELDS}
    // This is also referred to as the SignatureAlgorithm
    HashEncryptionAlgorithm: TCryptAlgorithmIdentifier;
    pvHashEncryptionAuxInfo: Pointer;
{$ENDIF}
  end;
  {$EXTERNALSYM _CRYPT_SIGN_MESSAGE_PARA}
  CRYPT_SIGN_MESSAGE_PARA = _CRYPT_SIGN_MESSAGE_PARA;
  {$EXTERNALSYM CRYPT_SIGN_MESSAGE_PARA}
  PCRYPT_SIGN_MESSAGE_PARA = ^CRYPT_SIGN_MESSAGE_PARA;
  {$EXTERNALSYM PCRYPT_SIGN_MESSAGE_PARA}

type PPByte = ^PByte;
//+-------------------------------------------------------------------------
//  Sign the message.
//
//  If fDetachedSignature is TRUE, the "to be signed" content isn't included
//  in the encoded signed blob.
//--------------------------------------------------------------------------
function CryptSignMessage(
  pSignPara: PCRYPT_SIGN_MESSAGE_PARA;
  fDetachedSignature: LongBool;
  cToBeSigned: DWORD;
  rgpbToBeSigned: PPByte;
  rgcbToBeSigned: PDWORD;
  pbSignedBlob: PByte;
  var pcbSignedBlob: DWORD): LongBool; stdcall;
{$EXTERNALSYM CryptSignMessage}

//+=========================================================================
//  System Certificate Store Data Structures and APIs
//==========================================================================


//+-------------------------------------------------------------------------
//  Get a system certificate store based on a subsystem protocol.
//
//  Current examples of subsystems protocols are:
//      "MY"    Cert Store hold certs with associated Private Keys
//      "CA"    Certifying Authority certs
//      "ROOT"  Root Certs
//      "SPC"   Software publisher certs
//
//
//  If hProv is NULL the default provider "1" is opened for you.
//  When the store is closed the provider is release. Otherwise
//  if hProv is not NULL, no provider is created or released.
//
//  The returned Cert Store can be searched for an appropriate Cert
//  using the Cert Store API's (see certstor.h)
//
//  When done, the cert store should be closed using CertStoreClose
//--------------------------------------------------------------------------

function CertOpenSystemStoreA(
  hProv: HCRYPTPROV_LEGACY;
  szSubsystemProtocol: LPCSTR): HCERTSTORE; stdcall;
{$EXTERNALSYM CertOpenSystemStoreA}

function CertOpenSystemStoreW(
  hProv: HCRYPTPROV_LEGACY;
  szSubsystemProtocol: LPCWSTR): HCERTSTORE; stdcall;
{$EXTERNALSYM CertOpenSystemStoreW}

function CertOpenSystemStore(
  hProv: HCRYPTPROV_LEGACY;
  szSubsystemProtocol: LPCWSTR): HCERTSTORE; stdcall;
{$EXTERNALSYM CertOpenSystemStore}

// When an application requests a certificate chain, the data structure
// returned is in the form of a CERT_CHAIN_CONTEXT.  This contains
// an array of CERT_SIMPLE_CHAIN where each simple chain goes from
// an end cert to a self signed cert and the chain context connects simple
// chains via trust lists.  Each simple chain contains the chain of
// certificates, summary trust information about the chain and trust information
// about each certificate element in the chain.
//
// Trust status bits
//
type
  _CERT_TRUST_STATUS = record
    dwErrorStatus: DWORD;
    dwInfoStatus: DWORD;
  end;
  {$EXTERNALSYM _CERT_TRUST_STATUS}
  CERT_TRUST_STATUS = _CERT_TRUST_STATUS;
  {$EXTERNALSYM CERT_TRUST_STATUS}
  PCERT_TRUST_STATUS = ^CERT_TRUST_STATUS;
  {$EXTERNALSYM PCERT_TRUST_STATUS}

// Revocation Information
//
type
  _CERT_REVOCATION_INFO = record
    cbSize: DWORD;
    dwRevocationResult: DWORD;
    pszRevocationOid: LPCSTR;
    pvOidSpecificInfo: LPVOID;
    // fHasFreshnessTime is only set if we are able to retrieve revocation
    // information. For a CRL its CurrentTime - ThisUpdate.
    fHasFreshnessTime: LongBool;
    dwFreshnessTime: DWORD;    // seconds
    // NonNULL for CRL base revocation checking
    pCrlInfo: PCERT_REVOCATION_CRL_INFO;
  end;
  {$EXTERNALSYM _CERT_REVOCATION_INFO}
  CERT_REVOCATION_INFO = _CERT_REVOCATION_INFO;
  {$EXTERNALSYM CERT_REVOCATION_INFO}
  PCERT_REVOCATION_INFO = ^CERT_REVOCATION_INFO;
  {$EXTERNALSYM PCERT_REVOCATION_INFO}

// Trust List Information
//
type
  _CERT_TRUST_LIST_INFO = record
    cbSize: DWORD;
    pCtlEntry: PCTL_ENTRY;
    pCtlContext: PCTL_CONTEXT;
  end;
  {$EXTERNALSYM _CERT_TRUST_LIST_INFO}
  CERT_TRUST_LIST_INFO = _CERT_TRUST_LIST_INFO;
  {$EXTERNALSYM CERT_TRUST_LIST_INFO}
  PCERT_TRUST_LIST_INFO = ^CERT_TRUST_LIST_INFO;
  {$EXTERNALSYM PCERT_TRUST_LIST_INFO}

// Chain Element
//
type
  _CERT_CHAIN_ELEMENT = record
    cbSize: DWORD;
    pCertContext: PCERT_CONTEXT;
    TrustStatus: CERT_TRUST_STATUS;
    pRevocationInfo: PCERT_REVOCATION_INFO;
    pIssuanceUsage: PCERT_ENHKEY_USAGE;       // If NULL, any
    pApplicationUsage: PCERT_ENHKEY_USAGE;    // If NULL, any
    pwszExtendedErrorInfo: LPCWSTR;    // If NULL, none
  end;
  {$EXTERNALSYM _CERT_CHAIN_ELEMENT}
  CERT_CHAIN_ELEMENT = _CERT_CHAIN_ELEMENT;
  {$EXTERNALSYM CERT_CHAIN_ELEMENT}
  PCERT_CHAIN_ELEMENT = ^CERT_CHAIN_ELEMENT;
  {$EXTERNALSYM PCERT_CHAIN_ELEMENT}
  PCCERT_CHAIN_ELEMENT = PCERT_CHAIN_ELEMENT;
  {$EXTERNALSYM PCCERT_CHAIN_ELEMENT}
  PPCertChainElement = ^PCERT_CHAIN_ELEMENT;

// The simple chain is an array of chain elements and a summary trust status
// for the chain
//
// rgpElements[0] is the end certificate chain element
//
// rgpElements[cElement-1] is the self-signed "root" certificate chain element

type
  _CERT_SIMPLE_CHAIN = record
    cbSize: DWORD;
    TrustStatus: CERT_TRUST_STATUS;
    cElement: DWORD;
    rgpElement: PPCertChainElement;
    pTrustListInfo: PCERT_TRUST_LIST_INFO;
    // fHasRevocationFreshnessTime is only set if we are able to retrieve
    // revocation information for all elements checked for revocation.
    // For a CRL its CurrentTime - ThisUpdate.
    //
    // dwRevocationFreshnessTime is the largest time across all elements
    // checked.
    fHasRevocationFreshnessTime: LongBool;
    dwRevocationFreshnessTime: DWORD;    // seconds
  end;
  {$EXTERNALSYM _CERT_SIMPLE_CHAIN}
  CERT_SIMPLE_CHAIN = _CERT_SIMPLE_CHAIN;
  {$EXTERNALSYM CERT_SIMPLE_CHAIN}
  PCERT_SIMPLE_CHAIN = ^CERT_SIMPLE_CHAIN;
  {$EXTERNALSYM PCERT_SIMPLE_CHAIN}
  PCCERT_SIMPLE_CHAIN = PCERT_SIMPLE_CHAIN;
  {$EXTERNALSYM PCCERT_SIMPLE_CHAIN}

//
// And the chain context contains an array of simple chains and summary trust
// status for all the connected simple chains
//
// rgpChains[0] is the end certificate simple chain
//
// rgpChains[cChain-1] is the final (possibly trust list signer) chain which
// ends in a certificate which is contained in the root store
//

//type
  _CERT_CHAIN_CONTEXT = record
    cbSize: DWORD;
    TrustStatus: CERT_TRUST_STATUS;
    cChain: DWORD;
    rgpChain: ^PCERT_SIMPLE_CHAIN;
    // Following is returned when CERT_CHAIN_RETURN_LOWER_QUALITY_CONTEXTS
    // is set in dwFlags
    cLowerQualityChainContext: DWORD;
    rgpLowerQualityChainContext: ^PCERT_SIMPLE_CHAIN;
    // fHasRevocationFreshnessTime is only set if we are able to retrieve
    // revocation information for all elements checked for revocation.
    // For a CRL its CurrentTime - ThisUpdate.
    //
    // dwRevocationFreshnessTime is the largest time across all elements
    // checked.
    fHasRevocationFreshnessTime: LongBool;
    dwRevocationFreshnessTime: DWORD;    // seconds
    // Flags passed when created via CertGetCertificateChain
    dwCreateFlags: DWORD;
    // Following is updated with unique Id when the chain context is logged.
    ChainId: TGUID;
  end;
  {$EXTERNALSYM _CERT_CHAIN_CONTEXT}
  CERT_CHAIN_CONTEXT = _CERT_CHAIN_CONTEXT;
  {$EXTERNALSYM CERT_CHAIN_CONTEXT}
  PCERT_CHAIN_CONTEXT = ^CERT_CHAIN_CONTEXT;
  {$EXTERNALSYM PCERT_CHAIN_CONTEXT}
  PCCERT_CHAIN_CONTEXT = PCERT_CHAIN_CONTEXT;
  {$EXTERNALSYM PCCERT_CHAIN_CONTEXT}
  PPCertChainContext = ^PCERT_CHAIN_CONTEXT;

type
 _CERT_USAGE_MATCH = record
    dwType: DWORD;
    Usage: CTL_USAGE;
  end;
  {$EXTERNALSYM _CERT_USAGE_MATCH}
  CERT_USAGE_MATCH = _CERT_USAGE_MATCH;
  {$EXTERNALSYM CERT_USAGE_MATCH}
  PCERT_USAGE_MATCH = ^CERT_USAGE_MATCH;
  {$EXTERNALSYM PCERT_USAGE_MATCH}

{.$Defile CERT_CHAIN_PARA_HAS_EXTRA_FIELDS}
type
  _CERT_CHAIN_PARA = record
    cbSize: DWORD;
    RequestedUsage: CERT_USAGE_MATCH;
{$IFDEF CERT_CHAIN_PARA_HAS_EXTRA_FIELDS}
    // Note, if you #define CERT_CHAIN_PARA_HAS_EXTRA_FIELDS, then, you
    // must zero all unused fields in this data structure.
    // More fields could be added in a future release.
    RequestedIssuancePolicy: CERT_USAGE_MATCH;
    dwUrlRetrievalTimeout: DWORD;     // milliseconds
    fCheckRevocationFreshnessTime: LongBool;
    dwRevocationFreshnessTime: DWORD; // seconds
    // If nonNULL, any cached information before this time is considered
    // time invalid and forces a wire retrieval. When set overrides
    // the registry configuration CacheResync time.
    pftCacheResync: PFileTime;
    //
    // The following is set to check for Strong Signatures
    //
    pStrongSignPara: PCERT_STRONG_SIGN_PARA;
    //
    // By default the public key in the end certificate is checked.
    // CERT_CHAIN_STRONG_SIGN_DISABLE_END_CHECK_FLAG can be
    // set in the following flags to not check if the end certificate's public
    // key length is strong.
    //
    dwStrongSignFlags: DWORD;
{$ENDIF}
  end;
  {$EXTERNALSYM _CERT_CHAIN_PARA}
  CERT_CHAIN_PARA = _CERT_CHAIN_PARA;
  {$EXTERNALSYM CERT_CHAIN_PARA}
  PCERT_CHAIN_PARA = ^CERT_CHAIN_PARA;
  {$EXTERNALSYM PCERT_CHAIN_PARA}

function CertGetCertificateChain(
  hChainEngine: HCERTCHAINENGINE;
  pCertContext: PCERT_CONTEXT;
  pTime: PFileTime;
  hAdditionalStore: HCERTSTORE;
  pChainPara: PCERT_CHAIN_PARA;
  dwFlags: DWORD;
  pvReserved: LPVOID;
  ppChainContext: PPCertChainContext
): LongBool; stdcall;
{$EXTERNALSYM CertGetCertificateChain}

//
// Free a certificate chain
//
procedure CertFreeCertificateChain(
  pChainContext: PCERT_CHAIN_CONTEXT); stdcall;
{$EXTERNALSYM CertFreeCertificateChain}

//+-------------------------------------------------------------------------
//      PFXImportCertStore
//
//  Import the PFX blob and return a store containing certificates
//
//  If the password parameter is incorrect or any other problems decoding
//  the PFX blob are encountered, the function will return NULL and the
//      error code can be found from GetLastError().
//
//  The dwFlags parameter may be set to the following:
//  PKCS12_IMPORT_SILENT    - only allow importing key in silent mode. If the
//                            csp or ksp requires ui then this call will fail
//                            with the error from the csp or ksp.
//  CRYPT_EXPORTABLE - specify that any imported keys should be marked as
//                     exportable (see documentation on CryptImportKey)
//  CRYPT_USER_PROTECTED - (see documentation on CryptImportKey)
//  CRYPT_MACHINE_KEYSET - used to force the private key to be stored in the
//                        the local machine and not the current user.
//  CRYPT_USER_KEYSET - used to force the private key to be stored in the
//                      the current user and not the local machine, even if
//                      the pfx blob specifies that it should go into local
//                      machine.
//  PKCS12_INCLUDE_EXTENDED_PROPERTIES - used to import all extended
//                     properties that were saved with CertExportCertStore()
//                     using the same flag.
//--------------------------------------------------------------------------
function PFXImportCertStore(
  pPFX: PCryptDataBlob;
  szPassword: LPCWSTR;
  dwFlags: DWORD): HCERTSTORE; stdcall;
{$EXTERNALSYM PFXImportCertStore}

implementation

const
  Advapi32Dll = 'advapi32.dll';
  Crypt32Dll = 'crypt32.dll';

function CryptAcquireContextW; external Advapi32Dll name 'CryptAcquireContextW';

function CryptReleaseContext; external Advapi32Dll name 'CryptReleaseContext';

function CryptSetProvParam; external Advapi32Dll name 'CryptSetProvParam';


function CertCloseStore; external Crypt32Dll name 'CertCloseStore';

function CertEnumCertificatesInStore; external Crypt32Dll name 'CertEnumCertificatesInStore';
function CertFindCertificateInStore; external Crypt32Dll name 'CertFindCertificateInStore';

function CertFreeCertificateContext; external Crypt32Dll name 'CertFreeCertificateContext';

function CertNameToStrA; external Crypt32Dll name 'CertNameToStrA';
function CertNameToStrW; external Crypt32Dll name 'CertNameToStrW';
function CertNameToStr; external Crypt32Dll name 'CertNameToStrW';

function CertOpenSystemStoreA; external Crypt32Dll name 'CertOpenSystemStoreA';
function CertOpenSystemStoreW; external Crypt32Dll name 'CertOpenSystemStoreW';
function CertOpenSystemStore; external Crypt32Dll name 'CertOpenSystemStoreW';

function CertGetCertificateChain; external Crypt32Dll name 'CertGetCertificateChain';
procedure CertFreeCertificateChain; external Crypt32Dll name 'CertFreeCertificateChain';

function CryptSignMessage; external Crypt32Dll name 'CryptSignMessage';

function CertGetCertificateContextProperty; external Crypt32Dll name 'CertGetCertificateContextProperty';

function PFXImportCertStore; external Crypt32Dll name 'PFXImportCertStore';

end.
