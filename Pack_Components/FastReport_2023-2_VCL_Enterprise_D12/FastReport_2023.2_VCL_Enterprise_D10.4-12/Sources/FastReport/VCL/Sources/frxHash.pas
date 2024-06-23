unit frxHash;

{$I frx.inc}

interface

uses
  {$IFNDEF Linux}
  Windows,
  {$ENDIF}
  SysUtils, frxASN1;

const
  MaxDigestSize = 64;

type
  TfrxHashDigest = array[0 .. MaxDigestSize - 1] of Byte;

  TfrxHash = class
  protected
    FDigest: TfrxHashDigest;

    function GetDigestToAnsi: AnsiString;
  public
    constructor Create;
    procedure Initialize; virtual; abstract;
    procedure Update(const Buf; Len: Cardinal); virtual; abstract;
    procedure UpdateByAnsi(const Str: AnsiString);
    procedure Finalize; virtual; abstract;
    procedure MoveDigestTo(var Destination; Size: Integer = -1);
    procedure Iterate(const Str: AnsiString; Count: Cardinal);
    function DigestFromAnsiToAnsi(const Str: AnsiString): AnsiString;
    class function DigestSize: Cardinal; virtual; abstract;

    property DigestToAnsi: AnsiString read GetDigestToAnsi;
  end;

  TfrxHashClass = class of TfrxHash;

  TfrxMD5Hash = class(TfrxHash)
  private
    FCount: array[0..1] of DWord;
    FState: array[0..3] of DWord;
    FBuffer: array[0..63] of Byte;
    FBufLen: DWord;
    procedure Transform(var Accu; const Buf);
  public
    procedure Initialize; override;
    procedure Update(const Buf; Len: Cardinal); override;
    procedure Finalize; override;
    class function DigestSize: Cardinal; override;
  end;

  TfrxSHA1Hash = class(TfrxHash)
  private
    Size: Int64; //Cardinal;
    CA, CB, CC, CD, CE: DWord;
    Buffer: array [0..63] of byte;
    W: array [0..79] of DWord;
    BufSize: Cardinal;
    procedure Transform(Chunk: Pointer);
  public
    procedure Initialize; override;
    procedure Update(const Buf; Len: Cardinal); override;
    procedure Finalize; override;
    class function DigestSize: Cardinal; override;
  end;

  TfrxSHA256Hash = class(TfrxHash)
  private
    FLenHi, FLenLo: DWord;
    FIndex: Cardinal;
    FHash: array[0..7] of DWord;
    FBuffer: array[0..63] of Byte;
    procedure Transform;
  public
    procedure Initialize; override;
    procedure Update(const Buf; Len: Cardinal); override;
    procedure Finalize; override;
    class function DigestSize: Cardinal; override;
  end;


function OIDtoHashClass(OID: TOIDName): TfrxHashClass;

implementation

uses
  frxHelpers;

{$IfOpt Q+}
  {$Define QPlus}
  {$Q-}
{$EndIf}

const
  SHABufSize = 64;

function OIDtoHashClass(OID: TOIDName): TfrxHashClass;
begin
  case OID of
    OID_md5: Result := TfrxMD5Hash;
    OID_sha1: Result := TfrxSHA1Hash;
    OID_sha256: Result := TfrxSHA256Hash;
  else
    Result := nil;
  end;
end;

{ TSHA1Hash }

class function TfrxSHA1Hash.DigestSize: Cardinal;
begin
  Result := 20;
end;

procedure TfrxSHA1Hash.Initialize;
begin
  CA := $67452301;
  CB := $efcdab89;
  CC := $98badcfe;
  CD := $10325476;
  CE := $c3d2e1f0;
  Size := 0;
  BufSize := 0;
  FillChar(Buffer, SizeOf(Buffer), 0);
end;

procedure TfrxSHA1Hash.Transform(Chunk: Pointer);

  function F(i: Integer; B, C, D: DWord): DWord;
  begin
    case i div 20 of
      0: Result := ((B and C) or (not B and D)) + $5A827999;
      1: Result := (B xor C xor D) + $6ED9EBA1;
      2: Result := ((B and C) or (B and D) or (C and D)) + $8F1BBCDC;
    else Result := (B xor C xor D) + $CA62C1D6; // 3:
    end;
  end;

type
  TDWordArray = array[0..15] of DWord;
var
  i: Integer;
  Temp, A, B, C, D, E: DWord;
  PDW: ^TDWordArray;
begin
  A := CA;
  B := CB;
  C := CC;
  D := CD;
  E := CE;

  PDW := Chunk;
  for i := 0 to 15 do
    W[i] := ByteSwap(PDW^[i]);

  for i := 16 to 79 do
  begin
    Temp := W[i - 3] xor W[i - 8] xor W[i - 14] xor W[i - 16];
    W[i] := (Temp shl 1) xor (Temp shr 31);
  end;

  for i := 0 to 79 do
  begin
    Temp := ((A shl 5) or (A shr 27)) + E + W[i] + F(i, B, C, D);
    E := D;
    D := C;
    C := (B shl 30) or (B shr 2);
    B := A;
    A := Temp;
  end;

  Inc(CA, A);
  Inc(CB, B);
  Inc(CC, C);
  Inc(CD, D);
  Inc(CE, E);
end;

procedure TfrxSHA1Hash.Update(const Buf; Len: Cardinal);
var
  Left, i: Cardinal;
  Block: Pointer;
begin
  if Len = 0 then
    Exit;
  Block := @Buf;
  Inc(Size, Len);
  if BufSize > 0 then
  begin
    Left := SHABufSize - BufSize;
    if Left > Len then
    begin
      Move(Block^, Buffer[BufSize], Len);
      Inc(BufSize, Len);
      Exit;
    end
    else
    begin
      Move(Block^, Buffer[BufSize], Left);
      Block := IncPointer(Block, Left);
      Dec(Len, Left);
      Transform(@Buffer);
      BufSize := 0;
    end;
  end;
  i := 0;
  while Len >= SHABufSize do
  begin
    Transform(IncPointer(Block, i));
    Inc(i, SHABufSize);
    Dec(Len, SHABufSize);
  end;
  if Len > 0 then
  begin
    Move(IncPointer(Block, i)^, Buffer[0], Len);
    BufSize := Len;
  end;
end;

procedure TfrxSHA1Hash.Finalize;
type
  TDig = array [0..5] of DWord;
var
  Tail: array[0..127] of byte;
  ToAdd: Cardinal;
  Count: Int64;
  Temp: DWord;
  PDig: ^TDig;
  PD: ^DWord;
begin
  FillChar(Tail[0], SizeOf(Tail), 0);
  Count := Size shl 3;
  if BufSize >= 56  then
    ToAdd := 120 - BufSize
  else
    ToAdd := 56 - BufSize;
  if BufSize > 0 then
    Move(Buffer[0], Tail[0], BufSize);
  Tail[BufSize] := $80;

  Temp := Count shr 32;
  PD := Pointer(@Tail[ToAdd + BufSize]);
  PD^ := ByteSwap(Temp);
  Temp := DWord(Count);
  Inc(PD);
  PD^ := ByteSwap(Temp);
  Transform(@Tail[0]);
  if BufSize + ToAdd + 8 > SHABufSize then
    Transform(@Tail[SHABufSize]);

  PDig := Pointer(@FDigest);
  PDig^[0] := ByteSwap(CA);
  PDig^[1] := ByteSwap(CB);
  PDig^[2] := ByteSwap(CC);
  PDig^[3] := ByteSwap(CD);
  PDig^[4] := ByteSwap(CE);
end;

{ TSHA256Hash }

procedure TfrxSHA256Hash.Finalize;
var
  i: Integer;
begin
  FBuffer[FIndex] := $80;
  if FIndex >= 56 then
    Transform;
  PDWORD(@FBuffer[56])^ := ByteSwap(FLenHi);
  PDWord(@FBuffer[60])^ := ByteSwap(FLenLo);
  Transform;
  for i := 0 to 7 do
    FHash[i] := ByteSwap(FHash[i]);
  Move(FHash, FDigest, 32);
end;

class function TfrxSHA256Hash.DigestSize: Cardinal;
begin
  Result := 32;
end;

procedure TfrxSHA256Hash.Initialize;
begin
  FillChar(FBuffer, SizeOf(FBuffer), 0);
  FLenHi:= 0;
  FLenLo:= 0;
  FIndex:= 0;
  FHash[0]:= $6a09e667;
  FHash[1]:= $bb67ae85;
  FHash[2]:= $3c6ef372;
  FHash[3]:= $a54ff53a;
  FHash[4]:= $510e527f;
  FHash[5]:= $9b05688c;
  FHash[6]:= $1f83d9ab;
  FHash[7]:= $5be0cd19;
end;

procedure TfrxSHA256Hash.Transform;

  function F1(X: DWord): DWord;
  begin
    Result := ((X shr  6) or (X shl 26))
          xor ((X shr 11) or (X shl 21))
          xor ((X shr 25) or (X shl  7));
  end;

  function F2(X: DWord): DWord;
  begin
    Result := ((X shr  2) or (X shl 30))
          xor ((X shr 13) or (X shl 19))
          xor ((X shr 22) or (X shl 10));
  end;

const
  K: array[0..63] of DWord = (
    $428a2f98, $71374491, $b5c0fbcf, $e9b5dba5,
    $3956c25b, $59f111f1, $923f82a4, $ab1c5ed5,
    $d807aa98, $12835b01, $243185be, $550c7dc3,
    $72be5d74, $80deb1fe, $9bdc06a7, $c19bf174,
    $e49b69c1, $efbe4786, $0fc19dc6, $240ca1cc,
    $2de92c6f, $4a7484aa, $5cb0a9dc, $76f988da,
    $983e5152, $a831c66d, $b00327c8, $bf597fc7,
    $c6e00bf3, $d5a79147, $06ca6351, $14292967,
    $27b70a85, $2e1b2138, $4d2c6dfc, $53380d13,
    $650a7354, $766a0abb, $81c2c92e, $92722c85,
    $a2bfe8a1, $a81a664b, $c24b8b70, $c76c51a3,
    $d192e819, $d6990624, $f40e3585, $106aa070,
    $19a4c116, $1e376c08, $2748774c, $34b0bcb5,
    $391c0cb3, $4ed8aa4a, $5b9cca4f, $682e6ff3,
    $748f82ee, $78a5636f, $84c87814, $8cc70208,
    $90befffa, $a4506ceb, $bef9a3f7, $c67178f2);

var
  W: array[0..63] of DWord;

  procedure F3(var X1, X2: DWord; X3, X4, X5, X6, X7, X8: DWord; j: Integer);
  var
    T1, T2: DWord;
  begin
    T1 := X1 + F1(X3) + ((X3 and X4) xor (not X3 and X5)) + K[j] + W[j];
    T2 := F2(X6) + ((X6 and X7) xor (X6 and X8) xor (X7 and X8));
    X1 := T1 + T2;
    X2 := X2 + T1;
  end;

var
  A, B, C, D, E, F, G, H: DWord;
  i: Integer;
begin
  A := FHash[0];
  B := FHash[1];
  C := FHash[2];
  D := FHash[3];
  E := FHash[4];
  F := FHash[5];
  G := FHash[6];
  H := FHash[7];
  FIndex:= 0;

  Move(FBuffer, W, SHABufSize);
  for i := 0 to 15 do
    W[i] := ByteSwap(W[i]);
  for i := 16 to 63 do
    W[i] := (((W[i -  2] shr 17) or (W[i -  2] shl 15)) xor
             ((W[i -  2] shr 19) or (W[i -  2] shl 13)) xor (W[i -  2] shr 10)) +
               W[i -  7] +
            (((W[i - 15] shr  7) or (W[i - 15] shl 25)) xor
             ((W[i - 15] shr 18) or (W[i - 15] shl 14)) xor (W[i - 15] shr  3)) +
               W[i - 16];
  for i := 0 to 7 do
  begin
    F3(H, D, E, F, G, A, B, C, i * 8);
    F3(G, C, D, E, F, H, A, B, i * 8 + 1);
    F3(F, B, C, D, E, G, H, A, i * 8 + 2);
    F3(E, A, B, C, D, F, G, H, i * 8 + 3);
    F3(D, H, A, B, C, E, F, G, i * 8 + 4);
    F3(C, G, H, A, B, D, E, F, i * 8 + 5);
    F3(B, F, G, H, A, C, D, E, i * 8 + 6);
    F3(A, E, F, G, H, B, C, D, i * 8 + 7);
  end;
  Inc(FHash[0], A);
  Inc(FHash[1], B);
  Inc(FHash[2], C);
  Inc(FHash[3], D);
  Inc(FHash[4], E);
  Inc(FHash[5], F);
  Inc(FHash[6], G);
  Inc(FHash[7], H);
  FillChar(FBuffer, SHABufSize, 0);
end;

procedure TfrxSHA256Hash.Update(const Buf; Len: Cardinal);
var
  BufPtr: ^byte;
begin
  Inc(FLenHi ,Len shr 29);
  Inc(FLenLo, Len * 8);
  if FLenLo < (Len * 8) then
    Inc(FLenHi);
  BufPtr:= @Buf;
  while Len > 0 do
  begin
    if (SHABufSize - FIndex) <= Len then
    begin
      Move(BufPtr^, FBuffer[FIndex], SHABufSize - FIndex);
      Dec(Len, SHABufSize - FIndex);
      Inc(BufPtr, SHABufSize - FIndex);
      Transform;
    end
    else
    begin
      Move(BufPtr^, FBuffer[FIndex], Len);
      Inc(FIndex, Len);
      Len := 0;
    end;
  end;
end;

{ TfrxHash }

constructor TfrxHash.Create;
begin
  Initialize;
end;

function TfrxHash.DigestFromAnsiToAnsi(const Str: AnsiString): AnsiString;
begin
  Initialize;
  UpdateByAnsi(Str);
  Finalize;
  Result := DigestToAnsi;
end;

function TfrxHash.GetDigestToAnsi: AnsiString;
begin
  SetLength(Result, DigestSize);
  MoveDigestTo(Result[1]);
end;

procedure TfrxHash.Iterate(const Str: AnsiString; Count: Cardinal);
var
  st: AnsiString;
  i: Integer;
begin
  st := Str;
  for i := 0 to Count - 1 do
    st := DigestFromAnsiToAnsi(st);
end;

procedure TfrxHash.MoveDigestTo(var Destination; Size: Integer = -1);
begin
  if Size = -1 then
    Move(FDigest, Destination, DigestSize)
  else
    Move(FDigest, Destination, Size);
end;

procedure TfrxHash.UpdateByAnsi(const Str: AnsiString);
begin
  Update(Str[1], Length(Str));
end;

{ TfrxMD45Hash }

class function TfrxMD5Hash.DigestSize: Cardinal;
begin
  Result := 16;
end;

procedure TfrxMD5Hash.Finalize;
var
  WorkBuf: array [0..63] of Byte;
  WorkBufDW: array[0..15] of DWord absolute WorkBuf;
  WorkLen: Cardinal;
begin
  Move(FState, FDigest, 16);
  Move(FBuffer, WorkBuf, FBufLen);
  WorkBuf[FBufLen] := $80;
  WorkLen := FBufLen + 1;
  if WorkLen > 56 then
  begin
    FillChar(WorkBuf[WorkLen], 64 - WorkLen, 0);
    TransForm(FDigest, WorkBuf);
    WorkLen := 0
  end;
  FillChar(WorkBuf[WorkLen], 56 - WorkLen, 0);
  WorkBufDW[14] := FCount[0];
  WorkBufDW[15] := FCount[1];
  Transform(FDigest, WorkBuf);
end;

procedure TfrxMD5Hash.Initialize;
begin
  FBufLen := 0;
  FCount[0] := 0;
  FCount[1] := 0;
  FState[0] := $67452301;
  FState[1] := $EFCDAB89;
  FState[2] := $98BADCFE;
  FState[3] := $10325476;
end;

{ TfrxMD5Hash }

procedure TfrxMD5Hash.Transform(var Accu; const Buf);
var
  a, b, c, d: LongWord;
  lBuf: array[0..15] Of LongWord absolute Buf;
  lAccu: array[0..3] Of Longword absolute Accu;

  procedure FF(var a: LongWord; b, c, d, x, s, ac: LongWord);
  begin
    a := ROL(a + lBuf[x] + ac + (b and c or not b and d), s) + b;
  end;

  procedure GG(var a: LongWord; b, c, d, x, s, ac: LongWord);
  begin
    a := ROL(a + lBuf[x] + ac + (b and d or c and not d), s) + b;
  end;

  procedure HH(var a: LongWord; b, c, d, x, s, ac: LongWord);
  begin
    a := ROL(a + lBuf[x] + ac + (b Xor c Xor d), s) + b;
  end;

  procedure II(var a: LongWord; b, c, d, x, s, ac: LongWord);
  begin
    a := ROL(a + lBuf[x] + ac + (c Xor (b or not d)), s) + b;
  end;

begin
  a := lAccu[0];
  b := lAccu[1];
  c := lAccu[2];
  d := lAccu[3];

  FF(a, b, c, d,  0,  7, $d76aa478); FF(d, a, b, c,  1, 12, $e8c7b756);
  FF(c, d, a, b,  2, 17, $242070db); FF(b, c, d, a,  3, 22, $c1bdceee);
  FF(a, b, c, d,  4,  7, $f57c0faf); FF(d, a, b, c,  5, 12, $4787c62a);
  FF(c, d, a, b,  6, 17, $a8304613); FF(b, c, d, a,  7, 22, $fd469501);
  FF(a, b, c, d,  8,  7, $698098d8); FF(d, a, b, c,  9, 12, $8b44f7af);
  FF(c, d, a, b, 10, 17, $ffff5bb1); FF(b, c, d, a, 11, 22, $895cd7be);
  FF(a, b, c, d, 12,  7, $6b901122); FF(d, a, b, c, 13, 12, $fd987193);
  FF(c, d, a, b, 14, 17, $a679438e); FF(b, c, d, a, 15, 22, $49b40821);

  GG(a, b, c, d,  1,  5, $f61e2562); GG(d, a, b, c,  6,  9, $c040b340);
  GG(c, d, a, b, 11, 14, $265e5a51); GG(b, c, d, a,  0, 20, $e9b6c7aa);
  GG(a, b, c, d,  5,  5, $d62f105d); GG(d, a, b, c, 10,  9, $02441453);
  GG(c, d, a, b, 15, 14, $d8a1e681); GG(b, c, d, a,  4, 20, $e7d3fbc8);
  GG(a, b, c, d,  9,  5, $21e1cde6); GG(d, a, b, c, 14,  9, $c33707d6);
  GG(c, d, a, b,  3, 14, $f4d50d87); GG(b, c, d, a,  8, 20, $455a14ed);
  GG(a, b, c, d, 13,  5, $a9e3e905); GG(d, a, b, c,  2,  9, $fcefa3f8);
  GG(c, d, a, b,  7, 14, $676f02d9); GG(b, c, d, a, 12, 20, $8d2a4c8a);

  HH(a, b, c, d,  5,  4, $fffa3942); HH(d, a, b, c,  8, 11, $8771f681);
  HH(c, d, a, b, 11, 16, $6d9d6122); HH(b, c, d, a, 14, 23, $fde5380c);
  HH(a, b, c, d,  1,  4, $a4beea44); HH(d, a, b, c,  4, 11, $4bdecfa9);
  HH(c, d, a, b,  7, 16, $f6bb4b60); HH(b, c, d, a, 10, 23, $bebfbc70);
  HH(a, b, c, d, 13,  4, $289b7ec6); HH(d, a, b, c,  0, 11, $eaa127fa);
  HH(c, d, a, b,  3, 16, $d4ef3085); HH(b, c, d, a,  6, 23, $04881d05);
  HH(a, b, c, d,  9,  4, $d9d4d039); HH(d, a, b, c, 12, 11, $e6db99e5);
  HH(c, d, a, b, 15, 16, $1fa27cf8); HH(b, c, d, a,  2, 23, $c4ac5665);

  II(a, b, c, d,  0,  6, $f4292244); II(d, a, b, c,  7, 10, $432aff97);
  II(c, d, a, b, 14, 15, $ab9423a7); II(b, c, d, a,  5, 21, $fc93a039);
  II(a, b, c, d, 12,  6, $655b59c3); II(d, a, b, c,  3, 10, $8f0ccc92);
  II(c, d, a, b, 10, 15, $ffeff47d); II(b, c, d, a,  1, 21, $85845dd1);
  II(a, b, c, d,  8,  6, $6fa87e4f); II(d, a, b, c, 15, 10, $fe2ce6e0);
  II(c, d, a, b,  6, 15, $a3014314); II(b, c, d, a, 13, 21, $4e0811a1);
  II(a, b, c, d,  4,  6, $f7537e82); II(d, a, b, c, 11, 10, $bd3af235);
  II(c, d, a, b,  2, 15, $2ad7d2bb); II(b, c, d, a,  9, 21, $eb86d391);

  Inc(lAccu[0], a);
  Inc(lAccu[1], b);
  Inc(lAccu[2], c);
  Inc(lAccu[3], d);
end;

procedure TfrxMD5Hash.Update(const Buf; Len: Cardinal);
var
  BufPtr: ^Byte;
  Left: Cardinal;
begin
  if FCount[0] + DWord(Integer(Len) shl 3) < FCount[0] then
    Inc(FCount[1]);
  Inc(FCount[0], Integer(Len) shl 3);
  Inc(FCount[1], Integer(Len) shr 29);

  BufPtr := @Buf;
  if FBufLen > 0 then
  begin
    Left := 64 - FBufLen;
    if Left > Len then
      Left := Len;
    Move(BufPtr^, FBuffer[FBufLen], Left);
    Inc(FBufLen, Left);
    Inc(BufPtr, Left);
    if FBufLen < 64 then
      Exit;
    Transform(FState, FBuffer);
    FBufLen := 0;
    Dec(Len, Left)
  end;
  while Len >= 64 do
  begin
    Transform(FState, BufPtr^);
    Inc(BufPtr, 64);
    Dec(Len, 64)
  end;
  if Len > 0 then
  begin
    FBufLen := Len;
    Move(BufPtr^, FBuffer[0], FBufLen)
  end
end;

{$IfDef QPlus}
  {$UnDef QPlus}
  {$Q+}
{$EndIf}

{ Autotest }
{$IfDef DEBUG}
{$ASSERTIONS ON}
const
  Str: AnsiString = 'Hashing engines supported: md2, md4, md5, sha1, sha224, sha256, sha384, sha512, ripemd128, ripemd160, ripemd256, ripemd320, whirlpool, tiger128,3, tiger160,3, tiger192,3, tiger128,4, tiger160,4, tiger192,4, snefru, snefru256, gost, ';

function IsHashValid(HashClass: TfrxHashClass; ValidHash: AnsiString): Boolean;
begin
  with HashClass.Create do
    try
      Result := AnsiToHex(DigestFromAnsiToAnsi(Str), False) = ValidHash;
    finally
      Free;
    end;
end;

initialization

  Assert(IsHashValid(TfrxMD5Hash,
    '492a8475201a9f8e01682cbec9f1aa81'),
    'MD5');
  Assert(IsHashValid(TfrxSHA1Hash,
    'e015415cb2005c3ad5439846987bddf809a8cef5'),
    'SHA1');
  Assert(IsHashValid(TfrxSHA256Hash,
    '7cd39da22c6f98311b06042d57a6ea19b7404ed5011e0f764eeab7b2c136b4ba'),
    'SHA256');
{$EndIf}
end.
