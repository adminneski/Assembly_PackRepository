unit frxCipher;

{$I frx.inc}

interface

uses
  {$IFNDEF Linux}
  Windows,
  {$ENDIF}
  SysUtils, Classes, Graphics, Math,
  frxASN1, frxHelpers;

type
  TfrxCipher = class
  private
    FKeyLen: Cardinal;
  protected
    procedure Init(Key, InitVector: AnsiString); virtual; abstract;
    procedure ExpandLastBlock(var Str: AnsiString); virtual; // Empty
    procedure RemoveExpansion(var Str: AnsiString); virtual; // Empty
    procedure Decode(Buf: Pointer; Len: Cardinal); virtual; abstract;
    procedure Encode(Buf: Pointer; Len: Cardinal); virtual; abstract;
 public
    constructor Create(Key, InitVector: AnsiString);
    function DecodeToStr(Str: AnsiString): AnsiString;
    function EncodeToStr(Str: AnsiString): AnsiString;
  end;

  TfrxCipherClass = class of TfrxCipher;

  TfrxBlockCipher = class(TfrxCipher)
  private
    FInitVector: array[0..63] of byte;
    function GetBlockSize: Integer; virtual; abstract;
    function GetIVSize: Integer; virtual; abstract;
  protected
    procedure Init(Key, InitVector: AnsiString); override;
    procedure ExpandLastBlock(var Str: AnsiString); override;
    procedure RemoveExpansion(var Str: AnsiString); override;
    procedure XORBuffer(const Buf1, Buf2: Pointer; const BufferSize: Integer);
    procedure DecodeBlock(Buf: Pointer); virtual; abstract;
    procedure EncodeBlock(Buf: Pointer); virtual; abstract;
    procedure Decode(Buf: Pointer; Len: Cardinal); override;
    procedure Encode(Buf: Pointer; Len: Cardinal); override;

    property BlockSize: Integer read GetBlockSize;
    property IVSize: Integer read GetIVSize;
  public
  end;

  TfrxRC2CipherKey = packed record
    case Byte of
      0 : (Bytes: array[0..127] of Byte);
      1 : (Words: array[0..63] of Word);
  end;

  TfrxRC2Cipher = class(TfrxBlockCipher)
  private
    FKey: TfrxRC2CipherKey;
    function GetBlockSize: Integer; override;
    function GetIVSize: Integer; override;
  protected
    procedure Init(Key, InitVector: AnsiString); override;
    procedure DecodeBlock(Buf: Pointer);override;
    procedure EncodeBlock(Buf: Pointer);override;
  public
  end;

  TfrxDES3Cipher = class(TfrxBlockCipher)
  private
    FUserInfo: array[0..192 - 1] of DWord;
    function GetBlockSize: Integer; override;
    function GetIVSize: Integer; override;
  protected
    procedure Init(Key, InitVector: AnsiString); override;
    procedure DES_Func(Buf: Pointer; Index: Integer);
    procedure DES3_Func(Buf: Pointer; i1, i2, i3: Integer);
    procedure DecodeBlock(Buf: Pointer); override;
    procedure EncodeBlock(Buf: Pointer); override;
    procedure MakeKey(const Data: array of Byte; Key: PDWord; Reverse: Boolean);
  end;

implementation

{ TfrxBlockCipher }

const
  MaxBlockSize = 4096;

procedure TfrxBlockCipher.Decode(Buf: Pointer; Len: Cardinal);
var
  P: PByte;
  L: Integer;
  B, C: array[0..MaxBlockSize - 1] of Byte;
begin
  P := Buf;
  L := Len;
  Move(FInitVector, B[0], BlockSize);
  while L >= BlockSize do
  begin
    Move(P^, C[0], BlockSize);
    DecodeBlock(P);
    XORBuffer(P, @B[0], BlockSize);
    Move(C[0], B[0], BlockSize);
    Dec(L, BlockSize);
    Inc(P, BlockSize);
  end;
  if L > 0 then
  begin
    Move(P^, C[0], L);
    FillChar(C[L], BlockSize - L, 0);
    DecodeBlock(@C[0]);
    XORBuffer(@C[0], @B[0], BlockSize);
    Move(C[0], P^, L);
  end;
end;

procedure TfrxBlockCipher.Encode(Buf: Pointer; Len: Cardinal);
var
  P, F: PByte;
  L: Integer;
  B: array[0..MaxBlockSize - 1] of Byte;
begin
  P := Buf;
  L := Len;
  F := @FInitVector;
  while L >= BlockSize do
  begin
    XORBuffer(P, F, BlockSize);
    EncodeBlock(P);
    F := P;
    Dec(L, BlockSize);
    Inc(P, BlockSize);
  end;
  if L > 0 then
  begin
    Move(P^, B[0], L);
    FillChar(B[L], BlockSize - L, 0);
    XORBuffer(@B[0], F, BlockSize);
    EncodeBlock(@B[0]);
    Move(B[0], P^, L);
  end;
end;

procedure TfrxBlockCipher.ExpandLastBlock(var Str: AnsiString);
var
  Expansion: Integer;
begin
  Expansion := BlockSize - Length(Str) mod BlockSize;
  if Expansion > 0 then
    Str := Str + StringOfChar(AnsiChar(Chr(Expansion)), Expansion);
end;

procedure TfrxBlockCipher.Init(Key, InitVector: AnsiString);
begin
  Move(InitVector[1], FInitVector, IVSize);
end;

procedure TfrxBlockCipher.RemoveExpansion(var Str: AnsiString);
var
  Expansion, Len, i: Integer;
begin
  Len := Length(Str);
  Expansion := Byte(Str[Len]);
  if (Expansion > 0) and (Expansion <= BlockSize) then
  begin
    for i := Len - Expansion + 1 to Len - 1 do
      if Byte(Str[i]) <> Expansion then
        Exit;
    SetLength(Str,Len - Expansion);
  end;
end;

procedure TfrxBlockCipher.XORBuffer(const Buf1, Buf2: Pointer; const BufferSize: Integer);
var
  i: Integer;
  P, Q : PByte;
begin
  P := Buf1;
  Q := Buf2;
  for i := 0 to BufferSize - 1 do
  begin
    P^ := P^ xor Q^;
    Inc(P);
    Inc(Q);
  end;
end;

{ TfrxCipher }

constructor TfrxCipher.Create(Key, InitVector: AnsiString);
begin
  FKeyLen := Length(Key);
  Init(Key, InitVector);
end;

function TfrxCipher.DecodeToStr(Str: AnsiString): AnsiString;
begin
  Result := Str;
  if Str = '' then
    Exit;
  Decode(@Result[1], Length(Result));
  RemoveExpansion(Result);
end;

function TfrxCipher.EncodeToStr(Str: AnsiString): AnsiString;
begin
  Result := Str;
  if Str = '' then
    Exit;
  ExpandLastBlock(Result);
  Encode(@Result[1], Length(Result));
end;

procedure TfrxCipher.ExpandLastBlock(var Str: AnsiString);
begin
  { Empty }
end;

procedure TfrxCipher.RemoveExpansion(var Str: AnsiString);
begin
  { Empty }
end;

{ TfrxDES3Cipher }

const
  DES_PC1: array[0..55] of Byte =
   (56, 48, 40, 32, 24, 16,  8,  0, 57, 49, 41, 33, 25, 17,
     9,  1, 58, 50, 42, 34, 26,	18, 10,  2, 59, 51, 43, 35,
    62, 54, 46, 38, 30, 22, 14,	 6, 61, 53, 45, 37, 29, 21,
    13,  5, 60, 52, 44, 36, 28,	20, 12,  4, 27, 19, 11,  3);
  DES_PC2: array[0..47] of Byte =
   (13, 16, 10, 23,  0,  4,  2, 27, 14,  5, 20,  9,
    22, 18, 11,  3, 25,  7, 15,  6, 26, 19, 12,  1,
    40, 51, 30, 36, 46, 54, 29, 39, 50, 44, 32, 47,
    43, 48, 38, 55, 33, 52, 45, 41, 49, 35, 28, 31);
  DES_Data: array[0..7, 0..63] of LongWord = (
   ($00200000,$04200002,$04000802,$00000000,$00000800,$04000802,$00200802,$04200800,
    $04200802,$00200000,$00000000,$04000002,$00000002,$04000000,$04200002,$00000802,
    $04000800,$00200802,$00200002,$04000800,$04000002,$04200000,$04200800,$00200002,
    $04200000,$00000800,$00000802,$04200802,$00200800,$00000002,$04000000,$00200800,
    $04000000,$00200800,$00200000,$04000802,$04000802,$04200002,$04200002,$00000002,
    $00200002,$04000000,$04000800,$00200000,$04200800,$00000802,$00200802,$04200800,
    $00000802,$04000002,$04200802,$04200000,$00200800,$00000000,$00000002,$04200802,
    $00000000,$00200802,$04200000,$00000800,$04000002,$04000800,$00000800,$00200002),
   ($00000100,$02080100,$02080000,$42000100,$00080000,$00000100,$40000000,$02080000,
    $40080100,$00080000,$02000100,$40080100,$42000100,$42080000,$00080100,$40000000,
    $02000000,$40080000,$40080000,$00000000,$40000100,$42080100,$42080100,$02000100,
    $42080000,$40000100,$00000000,$42000000,$02080100,$02000000,$42000000,$00080100,
    $00080000,$42000100,$00000100,$02000000,$40000000,$02080000,$42000100,$40080100,
    $02000100,$40000000,$42080000,$02080100,$40080100,$00000100,$02000000,$42080000,
    $42080100,$00080100,$42000000,$42080100,$02080000,$00000000,$40080000,$42000000,
    $00080100,$02000100,$40000100,$00080000,$00000000,$40080000,$02080100,$40000100),
   ($00000208,$08020200,$00000000,$08020008,$08000200,$00000000,$00020208,$08000200,
    $00020008,$08000008,$08000008,$00020000,$08020208,$00020008,$08020000,$00000208,
    $08000000,$00000008,$08020200,$00000200,$00020200,$08020000,$08020008,$00020208,
    $08000208,$00020200,$00020000,$08000208,$00000008,$08020208,$00000200,$08000000,
    $08020200,$08000000,$00020008,$00000208,$00020000,$08020200,$08000200,$00000000,
    $00000200,$00020008,$08020208,$08000200,$08000008,$00000200,$00000000,$08020008,
    $08000208,$00020000,$08000000,$08020208,$00000008,$00020208,$00020200,$08000008,
    $08020000,$08000208,$00000208,$08020000,$00020208,$00000008,$08020008,$00020200),
   ($01010400,$00000000,$00010000,$01010404,$01010004,$00010404,$00000004,$00010000,
    $00000400,$01010400,$01010404,$00000400,$01000404,$01010004,$01000000,$00000004,
    $00000404,$01000400,$01000400,$00010400,$00010400,$01010000,$01010000,$01000404,
    $00010004,$01000004,$01000004,$00010004,$00000000,$00000404,$00010404,$01000000,
    $00010000,$01010404,$00000004,$01010000,$01010400,$01000000,$01000000,$00000400,
    $01010004,$00010000,$00010400,$01000004,$00000400,$00000004,$01000404,$00010404,
    $01010404,$00010004,$01010000,$01000404,$01000004,$00000404,$00010404,$01010400,
    $00000404,$01000400,$01000400,$00000000,$00010004,$00010400,$00000000,$01010004),
   ($10001040,$00001000,$00040000,$10041040,$10000000,$10001040,$00000040,$10000000,
    $00040040,$10040000,$10041040,$00041000,$10041000,$00041040,$00001000,$00000040,
    $10040000,$10000040,$10001000,$00001040,$00041000,$00040040,$10040040,$10041000,
    $00001040,$00000000,$00000000,$10040040,$10000040,$10001000,$00041040,$00040000,
    $00041040,$00040000,$10041000,$00001000,$00000040,$10040040,$00001000,$00041040,
    $10001000,$00000040,$10000040,$10040000,$10040040,$10000000,$00040000,$10001040,
    $00000000,$10041040,$00040040,$10000040,$10040000,$10001000,$10001040,$00000000,
    $10041040,$00041000,$00041000,$00001040,$00001040,$00040040,$10000000,$10041000),
   ($20000010,$20400000,$00004000,$20404010,$20400000,$00000010,$20404010,$00400000,
    $20004000,$00404010,$00400000,$20000010,$00400010,$20004000,$20000000,$00004010,
    $00000000,$00400010,$20004010,$00004000,$00404000,$20004010,$00000010,$20400010,
    $20400010,$00000000,$00404010,$20404000,$00004010,$00404000,$20404000,$20000000,
    $20004000,$00000010,$20400010,$00404000,$20404010,$00400000,$00004010,$20000010,
    $00400000,$20004000,$20000000,$00004010,$20000010,$20404010,$00404000,$20400000,
    $00404010,$20404000,$00000000,$20400010,$00000010,$00004000,$20400000,$00404010,
    $00004000,$00400010,$20004010,$00000000,$20404000,$20000000,$00400010,$20004010),
   ($00802001,$00002081,$00002081,$00000080,$00802080,$00800081,$00800001,$00002001,
    $00000000,$00802000,$00802000,$00802081,$00000081,$00000000,$00800080,$00800001,
    $00000001,$00002000,$00800000,$00802001,$00000080,$00800000,$00002001,$00002080,
    $00800081,$00000001,$00002080,$00800080,$00002000,$00802080,$00802081,$00000081,
    $00800080,$00800001,$00802000,$00802081,$00000081,$00000000,$00000000,$00802000,
    $00002080,$00800080,$00800081,$00000001,$00802001,$00002081,$00002081,$00000080,
    $00802081,$00000081,$00000001,$00002000,$00800001,$00002001,$00802080,$00800081,
    $00002001,$00002080,$00800000,$00802001,$00000080,$00800000,$00002000,$00802080),
   ($80108020,$80008000,$00008000,$00108020,$00100000,$00000020,$80100020,$80008020,
    $80000020,$80108020,$80108000,$80000000,$80008000,$00100000,$00000020,$80100020,
    $00108000,$00100020,$80008020,$00000000,$80000000,$00008000,$00108020,$80100000,
    $00100020,$80000020,$00000000,$00108000,$00008020,$80108000,$80100000,$00008020,
    $00000000,$00108020,$80100020,$00100000,$80008020,$80100000,$80108000,$00008000,
    $80100000,$80008000,$00000020,$80108020,$00108020,$00000020,$00008000,$80000000,
    $00008020,$80108000,$00100000,$80000020,$00100020,$80008020,$80000020,$00100020,
    $00108000,$00000000,$80008000,$00008020,$80000000,$80100020,$80108020,$00108000));

procedure TfrxDES3Cipher.DecodeBlock(Buf: Pointer);
begin
  case FKeyLen of
    16: DES3_Func(Buf, 64, 96, 64);
    24: DES3_Func(Buf, 96, 128, 160);
  end;
end;

type
  DWordArray = array[0..1] of DWord;
  PDWordArray = ^DWordArray;

procedure TfrxDES3Cipher.DES3_Func(Buf: Pointer; i1, i2, i3: Integer);
begin
  DES_Func(Buf, i1);
  DES_Func(Buf, i2);
  DES_Func(Buf, i3);
end;

procedure TfrxDES3Cipher.DES_Func(Buf: Pointer; Index: Integer);
var
  X, Y: LongWord;
  Key: PDWord;

  procedure F1(var A, B: LongWord; C, D: LongWord);
  begin
    X := (A shr C xor B) and D;
    B := B xor X;
    A := A xor X shl C;
  end;

  procedure F2(var A: LongWord; B: LongWord);
  begin
    X := (B shl 28 or B shr 4) xor Key^; Inc(Key);
    Y := B xor Key^;                     Inc(Key);
    A := A xor (DES_Data[0, X        and $3F] or DES_Data[1, X shr  8 and $3F] or
                DES_Data[2, X shr 16 and $3F] or DES_Data[3, X shr 24 and $3F] or
                DES_Data[4, Y        and $3F] or DES_Data[5, Y shr  8 and $3F] or
                DES_Data[6, Y shr 16 and $3F] or DES_Data[7, Y shr 24 and $3F]);
  end;

var
  L, R, i: LongWord;
  Data: PDWordArray;
begin
  Data := Buf;
  Key := @FUserInfo[Index];
  L := ByteSwap(Data[0]);
  R := ByteSwap(Data[1]);

  F1(L, R,  4, $0F0F0F0F);
  F1(L, R, 16, $0000FFFF);
  F1(R, L,  2, $33333333);
  F1(R, L,  8, $00FF00FF);
  R := R shl 1 or R shr 31;
  F1(L, R,  0, $AAAAAAAA);
  L := L shl 1 or L shr 31;

  for i := 0 to 7 do
  begin
    F2(L, R);
    F2(R, L);
  end;

  R := R shl 31 or R shr 1;
  F1(L, R,  0, $AAAAAAAA);
  L := L shl 31 or L shr 1;
  F1(L, R,  8, $00FF00FF);
  F1(L, R,  2, $33333333);
  F1(R, L, 16, $0000FFFF);
  F1(R, L,  4, $0F0F0F0F);
  Data[0] := ByteSwap(R);
  Data[1] := ByteSwap(L);
end;

procedure TfrxDES3Cipher.EncodeBlock(Buf: Pointer);
begin
  case FKeyLen of
    16: DES3_Func(Buf, 0, 32, 0);
    24: DES3_Func(Buf, 0, 32, 64);
  end;
end;

function TfrxDES3Cipher.GetBlockSize: Integer;
begin
  Result := 8;
end;

function TfrxDES3Cipher.GetIVSize: Integer;
begin
  Result := 8;
end;

procedure TfrxDES3Cipher.Init(Key, InitVector: AnsiString);
var
  K: array[0..23] of Byte;
  Len: Cardinal;
  P: PDWord;
begin
  Len := Length(Key);
  FillChar(K, SizeOf(K), 0);
  Move(Key[1], K, Len);
  P := Pointer(@FUserInfo);
  if Len = 24 then
  begin
    MakeKey(K[ 0], P, False); Inc(P, 32);
    MakeKey(K[ 8], P, True);  Inc(P, 32);
    MakeKey(K[16], P, False); Inc(P, 32);
    MakeKey(K[16], P, True);  Inc(P, 32);
    MakeKey(K[ 8], P, False); Inc(P, 32);
    MakeKey(K[ 0], P, True);
  end
  else // Len = 16
  begin
    MakeKey(K[0], P, False); Inc(P, 32);
    MakeKey(K[8], P, True);  Inc(P, 32);
    MakeKey(K[0], P, True);  Inc(P, 32);
    MakeKey(K[8], P, False);
  end;
  FillChar(K, SizeOf(K), 0);
  inherited Init(Key, InitVector);
end;

procedure TfrxDES3Cipher.MakeKey(const Data: array of Byte; Key: PDWord; Reverse: Boolean);
const
  ROT: array[0..15] of Byte =
    (1, 2, 4, 6, 8, 10, 12, 14, 15, 17, 19, 21, 23, 25, 27, 28);
var
  i, j, L, M: LongWord;
  PC_M, PC_R: array[0..55] of Byte;
  K: array[0..31] of LongWord;
begin
  FillChar(K, SizeOf(K), 0);
  for i := 0 to 56 - 1 do
    if Data[DES_PC1[i] shr 3] and ($80 shr (DES_PC1[i] and $07)) <> 0 then
      PC_M[i] := 1
    else
      PC_M[i] := 0;
  for i := 0 to 15 do
  begin
    if Reverse then
      M := (15 - i) shl 1
    else
      M := i shl 1;
    for j := 0 to 56 - 1 do
    begin
      L := j + ROT[i];
      if L < 28 * ((j div 28) + 1) then
        PC_R[j] := PC_M[L]
      else
        PC_R[j] := PC_M[L - 28];
    end;
    L := $1000000;
    for j := 0 to 23 do
    begin
      L := L shr 1;
      if PC_R[DES_PC2[j]] <> 0 then
        K[M] := K[M] or L;
      if PC_R[DES_PC2[j + 24]] <> 0 then
        K[M + 1] := K[M + 1] or L;
    end;
  end;
  for i := 0 to 15 do
  begin
    M := i shl 1;
    Key^ := K[M]     and $00FC0000 shl  6 or K[M]     and $00000FC0 shl 10 or
            K[M + 1] and $00FC0000 shr 10 or K[M + 1] and $00000FC0 shr 6;
    Inc(Key);
    Key^ := K[M]     and $0003F000 shl 12 or K[M]     and $0000003F shl 16 or
            K[M + 1] and $0003F000 shr  4 or K[M + 1] and $0000003F;
    Inc(Key);
  end;
end;

{ TfrxRC2Cipher }

type
  TRC2Block = packed record
    case Integer of
      0 : (Bytes: array[0..7] of Byte);
      1 : (Words: array[0..3] of Word);
      2 : (A, B, C, D: Word);
  end;
  PRC2Block = ^TRC2Block;

procedure TfrxRC2Cipher.DecodeBlock(Buf: Pointer);
var
  j: Integer;

  procedure F1(Count: Integer);
  var
    i: Integer;
  begin
    for i := 1 to Count do
      with PRC2Block(Buf)^ do
      begin
        D := Word(ROR16(D, 5) - FKey.Words[j] - (C and B) - (not C and A)); Dec(j);
        C := Word(ROR16(C, 3) - FKey.Words[j] - (B and A) - (not B and D)); Dec(j);
        B := Word(ROR16(B, 2) - FKey.Words[j] - (A and D) - (not A and C)); Dec(j);
        A := Word(ROR16(A, 1) - FKey.Words[j] - (D and C) - (not D and B)); Dec(j);
      end;
  end;

  procedure F2;
  begin
    with PRC2Block(Buf)^ do
    begin
      D := Word(D - FKey.Words[C and $3F]);
      C := Word(C - FKey.Words[B and $3F]);
      B := Word(B - FKey.Words[A and $3F]);
      A := Word(A - FKey.Words[D and $3F]);
    end;
  end;

begin
  j := High(FKey.Words);
  F1(5);
  F2;
  F1(6);
  F2;
  F1(5);
end;

procedure TfrxRC2Cipher.EncodeBlock(Buf: Pointer);
var
  j: Integer;

  procedure F1(Count: Integer);
  var
    i : Integer;
  begin
    for i := 1 to Count do
      with PRC2Block(Buf)^ do
      begin
        A := ROL16(Word(A + FKey.Words[j] + (D and C) + (not D and B)), 1); Inc(j);
        B := ROL16(Word(B + FKey.Words[j] + (A and D) + (not A and C)), 2); Inc(j);
        C := ROL16(Word(C + FKey.Words[j] + (B and A) + (not B and D)), 3); Inc(j);
        D := ROL16(Word(D + FKey.Words[j] + (C and B) + (not C and A)), 5); Inc(j);
      end;
  end;

  procedure F2;
  begin
    with PRC2Block(Buf)^ do
    begin
      A := Word(A + FKey.Words[D and $3F]);
      B := Word(B + FKey.Words[A and $3F]);
      C := Word(C + FKey.Words[B and $3F]);
      D := Word(D + FKey.Words[C and $3F]);
    end;
  end;

begin
  j := 0;
  F1(5);
  F2;
  F1(6);
  F2;
  F1(5);
end;

function TfrxRC2Cipher.GetBlockSize: Integer;
begin
  Result := 8;
end;

function TfrxRC2Cipher.GetIVSize: Integer;
begin
  Result := 8;
end;

procedure TfrxRC2Cipher.Init(Key, InitVector: AnsiString);
const
  RC2_Data: array[0..255] of Byte =
   ($D9,$78,$F9,$C4,$19,$DD,$B5,$ED,$28,$E9,$FD,$79,$4A,$A0,$D8,$9D,
    $C6,$7E,$37,$83,$2B,$76,$53,$8E,$62,$4C,$64,$88,$44,$8B,$FB,$A2,
    $17,$9A,$59,$F5,$87,$B3,$4F,$13,$61,$45,$6D,$8D,$09,$81,$7D,$32,
    $BD,$8F,$40,$EB,$86,$B7,$7B,$0B,$F0,$95,$21,$22,$5C,$6B,$4E,$82,
    $54,$D6,$65,$93,$CE,$60,$B2,$1C,$73,$56,$C0,$14,$A7,$8C,$F1,$DC,
    $12,$75,$CA,$1F,$3B,$BE,$E4,$D1,$42,$3D,$D4,$30,$A3,$3C,$B6,$26,
    $6F,$BF,$0E,$DA,$46,$69,$07,$57,$27,$F2,$1D,$9B,$BC,$94,$43,$03,
    $F8,$11,$C7,$F6,$90,$EF,$3E,$E7,$06,$C3,$D5,$2F,$C8,$66,$1E,$D7,
    $08,$E8,$EA,$DE,$80,$52,$EE,$F7,$84,$AA,$72,$AC,$35,$4D,$6A,$2A,
    $96,$1A,$D2,$71,$5A,$15,$49,$74,$4B,$9F,$D0,$5E,$04,$18,$A4,$EC,
    $C2,$E0,$41,$6E,$0F,$51,$CB,$CC,$24,$91,$AF,$50,$A1,$F4,$70,$39,
    $99,$7C,$3A,$85,$23,$B8,$B4,$7A,$FC,$02,$36,$5B,$25,$55,$97,$31,
    $2D,$5D,$FA,$98,$E3,$8A,$92,$AE,$05,$DF,$29,$10,$67,$6C,$BA,$C9,
    $D3,$00,$E6,$CF,$E1,$9E,$A8,$2C,$63,$16,$01,$3F,$58,$E2,$89,$A9,
    $0D,$38,$34,$1B,$AB,$33,$FF,$B0,$BB,$48,$0C,$5F,$B9,$B1,$CD,$2E,
    $C5,$F3,$DB,$47,$E5,$A5,$9C,$77,$0A,$A6,$20,$68,$FE,$7F,$C1,$AD);
var
  i, KeyBits, T8, Len: Cardinal;
  TM: byte;
begin
  Len := Length(Key);
  KeyBits := Len shl 3;
  T8 := (KeyBits + 7) shr 3;
  TM := (1 shl (KeyBits and $7)) - 1;
  if TM = 0 then
    TM := $FF;
  Move(Key[1], FKey, Len);
  with FKey do
    begin
      for i := Len to 127 do
        Bytes[i] := RC2_Data[Byte(Bytes[i - 1] + Bytes[i - Len])];
      Bytes[128 - T8] := RC2_Data[Bytes[128 - T8] and TM];
      for i := 127 - T8 downto 0 do
        Bytes[i] := RC2_Data[Bytes[i + 1] xor Bytes[i + T8]];
    end;
  inherited Init(Key, InitVector);
end;

{ Autotest }
{$IfDef DEBUG}
{$ASSERTIONS ON}
const
  InitVector8: AnsiString  = '12345678';

  Key5: AnsiString  = '12345';
  Key16: AnsiString  = '1234567890123456';
  Key24: AnsiString  = '123456789012345678901234';

  Str: AnsiString = 'By default the private key is encrypted using triple DES and the certificate using 40 bit RC2.';

function IsCipherValid(CC: TfrxCipherClass; Key, InitVector: AnsiString): boolean;
var
  st: AnsiString;
begin
  with CC.Create(Key, InitVector) do
    try
      st := EncodeToStr(Str);
      st := DecodeToStr(st);
      Result := st = Str;
    finally
      Free;
    end;
end;

initialization

  Assert(IsCipherValid(TfrxRC2Cipher, Key5, InitVector8),
    'OID_pbeWithSHA1And40BitRC2_CBC');
  Assert(IsCipherValid(TfrxRC2Cipher, Key16, InitVector8),
    'OID_pbeWithSHA1And128BitRC2_CBC');

  Assert(IsCipherValid(TfrxDES3Cipher, Key16, InitVector8),
    'OID_pbeWithSHA1And2_KeyTripleDES_CBC');
  Assert(IsCipherValid(TfrxDES3Cipher, Key24, InitVector8),
    'OID_pbeWithSHA1And3_KeyTripleDES_CBC');
{$EndIf}
end.
