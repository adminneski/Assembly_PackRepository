unit frxHashStreebog; // http://oid-info.com/get/1.0.10118.3.0

{$I frx.inc}

interface

uses
  frxHash;

const
  BlockSize = 64;

type
  TBlockArray = array[0 .. BlockSize - 1] of Byte;

  TfrxCustomStreebogHash = class(TfrxHash)
  private
    Buffer: TBlockArray;
    BufferSize: Cardinal;
    Hash: TBlockArray;
    h: TBlockArray;
    N: TBlockArray;
    Sigma: TBlockArray;
    v_0: TBlockArray;
    v_512: TBlockArray;
  protected
    procedure FillBlock(var X; Value: Byte);
    procedure ClearBlock(var X);
    procedure MoveBlock(const Source; var Dest);

    procedure Stage_2(const data: TBlockArray);
    procedure GetKey(var K: TBlockArray; i: Integer);
    procedure X(const a, b: TBlockArray;  var c: TBlockArray);
    procedure SPL(var state: TBlockArray);
    procedure G(var N_: TBlockArray; const m: TBlockArray);
    procedure E(var K: TBlockArray; const m: TBlockArray; var state: TBlockArray);
    procedure Add512(const a, b: TBlockArray; var c: TBlockArray);
    procedure Stage_3;
    procedure Padding;
  public
    procedure Initialize; override;
    procedure Update(const Buf; Len: Cardinal); override;
    procedure Finalize; override;
  end;

  TfrxStreebog256Hash = class(TfrxCustomStreebogHash)
  public
    procedure Initialize; override;
    class function DigestSize: Cardinal; override;
  end;

  TfrxStreebog512Hash = class(TfrxCustomStreebogHash)
  public
    procedure Initialize; override;
    class function DigestSize: Cardinal; override;
  end;

implementation

uses
  Math, frxHelpers;

const
  Tau: TBlockArray = (
    0,   8,  16,  24,  32,  40,  48,  56,
    1,   9,  17,  25,  33,  41,  49,  57,
    2,  10,  18,  26,  34,  42,  50,  58,
    3,  11,  19,  27,  35,  43,  51,  59,
    4,  12,  20,  28,  36,  44,  52,  60,
    5,  13,  21,  29,  37,  45,  53,  61,
    6,  14,  22,  30,  38,  46,  54,  62,
    7,  15,  23,  31,  39,  47,  55,  63
  );

  Pi: array[0 .. 256 - 1] of Byte = (
    252, 238, 221,  17, 207, 110,  49,  22,
    251, 196, 250, 218,  35, 197,   4,  77,
    233, 119, 240, 219, 147,  46, 153, 186,
     23,  54, 241, 187,  20, 205,  95, 193,
    249,  24, 101,  90, 226,  92, 239,  33,
    129,  28,  60,  66, 139,   1, 142,  79,
      5, 132,   2, 174, 227, 106, 143, 160,
      6,  11, 237, 152, 127, 212, 211,  31,
    235,  52,  44,  81, 234, 200,  72, 171,
    242,  42, 104, 162, 253,  58, 206, 204,
    181, 112,  14,  86,   8,  12, 118,  18,
    191, 114,  19,  71, 156, 183,  93, 135,
     21, 161, 150,  41,  16, 123, 154, 199,
    243, 145, 120, 111, 157, 158, 178, 177,
     50, 117,  25,  61, 255,  53, 138, 126,
    109,  84, 198, 128, 195, 189,  13,  87,
    223, 245,  36, 169,  62, 168,  67, 201,
    215, 121, 214, 246, 124,  34, 185,   3,
    224,  15, 236, 222, 122, 148, 176, 188,
    220, 232,  40,  80,  78,  51,  10,  74,
    167, 151,  96, 115,  30,   0,  98,  68,
     26, 184,  56, 130, 100, 159,  38,  65,
    173,  69,  70, 146,  39,  94,  85,  47,
    140, 163, 165, 125, 105, 213, 149,  59,
      7,  88, 179,  64, 134, 172,  29, 247,
     48,  55, 107, 228, 136, 217, 231, 137,
    225,  27, 131,  73,  76,  63, 248, 254,
    141,  83, 170, 144, 202, 216, 133,  97,
     32, 113, 103, 164,  45,  43,   9,  91,
    203, 155,  37, 208, 190, 229, 108,  82,
     89, 166, 116, 210, 230, 244, 180, 192,
    209, 102, 175, 194,  57,  75,  99, 182
  );

{$IfNDef Delphi11}
type
  UInt64 = Int64;
{$EndIf}

const
  A: array[0 .. BlockSize - 1] of UInt64 = (
    $8e20faa72ba0b470,
    $47107ddd9b505a38,
    $ad08b0e0c3282d1c,
    $d8045870ef14980e,
    $6c022c38f90a4c07,
    $3601161cf205268d,
    $1b8e0b0e798c13c8,
    $83478b07b2468764,
    $a011d380818e8f40,
    $5086e740ce47c920,
    $2843fd2067adea10,
    $14aff010bdd87508,
    $0ad97808d06cb404,
    $05e23c0468365a02,
    $8c711e02341b2d01,
    $46b60f011a83988e,
    $90dab52a387ae76f,
    $486dd4151c3dfdb9,
    $24b86a840e90f0d2,
    $125c354207487869,
    $092e94218d243cba,
    $8a174a9ec8121e5d,
    $4585254f64090fa0,
    $accc9ca9328a8950,
    $9d4df05d5f661451,
    $c0a878a0a1330aa6,
    $60543c50de970553,
    $302a1e286fc58ca7,
    $18150f14b9ec46dd,
    $0c84890ad27623e0,
    $0642ca05693b9f70,
    $0321658cba93c138,
    $86275df09ce8aaa8,
    $439da0784e745554,
    $afc0503c273aa42a,
    $d960281e9d1d5215,
    $e230140fc0802984,
    $71180a8960409a42,
    $b60c05ca30204d21,
    $5b068c651810a89e,
    $456c34887a3805b9,
    $ac361a443d1c8cd2,
    $561b0d22900e4669,
    $2b838811480723ba,
    $9bcf4486248d9f5d,
    $c3e9224312c8c1a0,
    $effa11af0964ee50,
    $f97d86d98a327728,
    $e4fa2054a80b329c,
    $727d102a548b194e,
    $39b008152acb8227,
    $9258048415eb419d,
    $492c024284fbaec0,
    $aa16012142f35760,
    $550b8e9e21f7a530,
    $a48b474f9ef5dc18,
    $70a6a56e2440598e,
    $3853dc371220a247,
    $1ca76e95091051ad,
    $0edd37c48a08a6d8,
    $07e095624504536c,
    $8d70c431ac02a736,
    $c83862965601dd1b,
    $641c314b2b8ee083
  );

  C: array[0 .. 12 - 1] of TBlockArray = (
    (
        $07, $45, $a6, $f2, $59, $65, $80, $dd,
        $23, $4d, $74, $cc, $36, $74, $76, $05,
        $15, $d3, $60, $a4, $08, $2a, $42, $a2,
        $01, $69, $67, $92, $91, $e0, $7c, $4b,
        $fc, $c4, $85, $75, $8d, $b8, $4e, $71,
        $16, $d0, $45, $2e, $43, $76, $6a, $2f,
        $1f, $7c, $65, $c0, $81, $2f, $cb, $eb,
        $e9, $da, $ca, $1e, $da, $5b, $08, $b1
    ), (
        $b7, $9b, $b1, $21, $70, $04, $79, $e6,
        $56, $cd, $cb, $d7, $1b, $a2, $dd, $55,
        $ca, $a7, $0a, $db, $c2, $61, $b5, $5c,
        $58, $99, $d6, $12, $6b, $17, $b5, $9a,
        $31, $01, $b5, $16, $0f, $5e, $d5, $61,
        $98, $2b, $23, $0a, $72, $ea, $fe, $f3,
        $d7, $b5, $70, $0f, $46, $9d, $e3, $4f,
        $1a, $2f, $9d, $a9, $8a, $b5, $a3, $6f
    ), (
        $b2, $0a, $ba, $0a, $f5, $96, $1e, $99,
        $31, $db, $7a, $86, $43, $f4, $b6, $c2,
        $09, $db, $62, $60, $37, $3a, $c9, $c1,
        $b1, $9e, $35, $90, $e4, $0f, $e2, $d3,
        $7b, $7b, $29, $b1, $14, $75, $ea, $f2,
        $8b, $1f, $9c, $52, $5f, $5e, $f1, $06,
        $35, $84, $3d, $6a, $28, $fc, $39, $0a,
        $c7, $2f, $ce, $2b, $ac, $dc, $74, $f5
    ), (
        $2e, $d1, $e3, $84, $bc, $be, $0c, $22,
        $f1, $37, $e8, $93, $a1, $ea, $53, $34,
        $be, $03, $52, $93, $33, $13, $b7, $d8,
        $75, $d6, $03, $ed, $82, $2c, $d7, $a9,
        $3f, $35, $5e, $68, $ad, $1c, $72, $9d,
        $7d, $3c, $5c, $33, $7e, $85, $8e, $48,
        $dd, $e4, $71, $5d, $a0, $e1, $48, $f9,
        $d2, $66, $15, $e8, $b3, $df, $1f, $ef
    ), (
        $57, $fe, $6c, $7c, $fd, $58, $17, $60,
        $f5, $63, $ea, $a9, $7e, $a2, $56, $7a,
        $16, $1a, $27, $23, $b7, $00, $ff, $df,
        $a3, $f5, $3a, $25, $47, $17, $cd, $bf,
        $bd, $ff, $0f, $80, $d7, $35, $9e, $35,
        $4a, $10, $86, $16, $1f, $1c, $15, $7f,
        $63, $23, $a9, $6c, $0c, $41, $3f, $9a,
        $99, $47, $47, $ad, $ac, $6b, $ea, $4b
    ), (
        $6e, $7d, $64, $46, $7a, $40, $68, $fa,
        $35, $4f, $90, $36, $72, $c5, $71, $bf,
        $b6, $c6, $be, $c2, $66, $1f, $f2, $0a,
        $b4, $b7, $9a, $1c, $b7, $a6, $fa, $cf,
        $c6, $8e, $f0, $9a, $b4, $9a, $7f, $18,
        $6c, $a4, $42, $51, $f9, $c4, $66, $2d,
        $c0, $39, $30, $7a, $3b, $c3, $a4, $6f,
        $d9, $d3, $3a, $1d, $ae, $ae, $4f, $ae
    ), (
        $93, $d4, $14, $3a, $4d, $56, $86, $88,
        $f3, $4a, $3c, $a2, $4c, $45, $17, $35,
        $04, $05, $4a, $28, $83, $69, $47, $06,
        $37, $2c, $82, $2d, $c5, $ab, $92, $09,
        $c9, $93, $7a, $19, $33, $3e, $47, $d3,
        $c9, $87, $bf, $e6, $c7, $c6, $9e, $39,
        $54, $09, $24, $bf, $fe, $86, $ac, $51,
        $ec, $c5, $aa, $ee, $16, $0e, $c7, $f4
    ), (
        $1e, $e7, $02, $bf, $d4, $0d, $7f, $a4,
        $d9, $a8, $51, $59, $35, $c2, $ac, $36,
        $2f, $c4, $a5, $d1, $2b, $8d, $d1, $69,
        $90, $06, $9b, $92, $cb, $2b, $89, $f4,
        $9a, $c4, $db, $4d, $3b, $44, $b4, $89,
        $1e, $de, $36, $9c, $71, $f8, $b7, $4e,
        $41, $41, $6e, $0c, $02, $aa, $e7, $03,
        $a7, $c9, $93, $4d, $42, $5b, $1f, $9b
    ), (
        $db, $5a, $23, $83, $51, $44, $61, $72,
        $60, $2a, $1f, $cb, $92, $dc, $38, $0e,
        $54, $9c, $07, $a6, $9a, $8a, $2b, $7b,
        $b1, $ce, $b2, $db, $0b, $44, $0a, $80,
        $84, $09, $0d, $e0, $b7, $55, $d9, $3c,
        $24, $42, $89, $25, $1b, $3a, $7d, $3a,
        $de, $5f, $16, $ec, $d8, $9a, $4c, $94,
        $9b, $22, $31, $16, $54, $5a, $8f, $37
    ), (
        $ed, $9c, $45, $98, $fb, $c7, $b4, $74,
        $c3, $b6, $3b, $15, $d1, $fa, $98, $36,
        $f4, $52, $76, $3b, $30, $6c, $1e, $7a,
        $4b, $33, $69, $af, $02, $67, $e7, $9f,
        $03, $61, $33, $1b, $8a, $e1, $ff, $1f,
        $db, $78, $8a, $ff, $1c, $e7, $41, $89,
        $f3, $f3, $e4, $b2, $48, $e5, $2a, $38,
        $52, $6f, $05, $80, $a6, $de, $be, $ab
    ), (
        $1b, $2d, $f3, $81, $cd, $a4, $ca, $6b,
        $5d, $d8, $6f, $c0, $4a, $59, $a2, $de,
        $98, $6e, $47, $7d, $1d, $cd, $ba, $ef,
        $ca, $b9, $48, $ea, $ef, $71, $1d, $8a,
        $79, $66, $84, $14, $21, $80, $01, $20,
        $61, $07, $ab, $eb, $bb, $6b, $fa, $d8,
        $94, $fe, $5a, $63, $cd, $c6, $02, $30,
        $fb, $89, $c8, $ef, $d0, $9e, $cd, $7b
    ), (
        $20, $d7, $1b, $f1, $4a, $92, $bc, $48,
        $99, $1b, $b2, $d9, $d5, $17, $f4, $fa,
        $52, $28, $e1, $88, $aa, $a4, $1d, $e7,
        $86, $cc, $91, $18, $9d, $ef, $80, $5d,
        $9b, $9f, $21, $30, $d4, $12, $20, $f8,
        $77, $1d, $df, $bc, $32, $3c, $a4, $cd,
        $7a, $b1, $49, $04, $b0, $80, $13, $d2,
        $ba, $31, $16, $f1, $67, $e7, $8e, $37
    )
  );

{ TfrxCustomStreebogHash }

procedure TfrxCustomStreebogHash.ClearBlock(var X);
begin
  FillBlock(X, $00);
end;

procedure TfrxCustomStreebogHash.FillBlock(var X; Value: Byte);
begin
  FillChar(X, BlockSize, Value);
end;

procedure TfrxCustomStreebogHash.Finalize;
begin
  Stage_3;
  BufferSize := 0;
  Move(Hash[BlockSize - DigestSize], FDigest, DigestSize);
end;

procedure TfrxCustomStreebogHash.Add512(const a, b: TBlockArray; var c: TBlockArray);
var
  i: Integer;
  w: Word;
begin
  w := 0;
  for i := 0 to BlockSize - 1 do
  begin
    w := Word(a[i]) + Word(b[i]) + (w shr 8);
    c[i] := w and $ff;
  end;
end;

procedure TfrxCustomStreebogHash.E(var K: TBlockArray; const m: TBlockArray; var state: TBlockArray);
var
  i: Integer;
begin
  X(m, K, state);
  for i := 0 to 12 - 1 do
  begin
    SPL(state);
    GetKey(K, i);
    X(state, K, state);
  end;
end;

procedure TfrxCustomStreebogHash.G(var N_: TBlockArray; const m: TBlockArray);
var
  K, Work: TBlockArray;
begin
  X(N_, h, K);
  SPL(K);
  E(K, m, Work);
  X(Work, h, Work);
  X(Work, m, h);
end;

procedure TfrxCustomStreebogHash.GetKey(var K: TBlockArray; i: Integer);
begin
  X(K, C[i], K);
  SPL(K);
end;

procedure TfrxCustomStreebogHash.MoveBlock(const Source; var Dest);
begin
  Move(Source, Dest, BlockSize);
end;

procedure TfrxCustomStreebogHash.Padding;
var
  Work: TBlockArray;
begin
  if BufferSize < BlockSize then
  begin
    ClearBlock(Work);

    Move(Buffer, Work, BufferSize);
    Work[BufferSize] := $01;
    MoveBlock(Work, Buffer);
  end;
end;

procedure TfrxCustomStreebogHash.SPL(var state: TBlockArray);
var
  i, j: Integer;
  WorkS, WorkP: TBlockArray;
  WorkIn: array [0 .. 8 - 1] of UInt64 absolute WorkP;
  WorkOut: array [0 .. 8 - 1] of UInt64;
begin
  for i := BlockSize - 1 downto 0 do
    WorkS[i] := Pi[state[i]];

  for i := BlockSize - 1 downto 0 do
    WorkP[i] := WorkS[Tau[i]];

  ClearBlock(WorkOut);
  for i := 8 - 1 downto 0 do
    for j := 64 - 1 downto 0 do
      if ((WorkIn[i] shr j) and 1) <> 0 then
        WorkOut[i] := WorkOut[i] xor A[63 - j];

  MoveBlock(WorkOut, state);
end;

procedure TfrxCustomStreebogHash.Stage_2(const data: TBlockArray);
begin
  G(N, data);
  Add512(N, v_512, N);
  Add512(Sigma, data, Sigma);
end;

procedure TfrxCustomStreebogHash.Stage_3;
var
  Work: TBlockArray;
begin
  ClearBlock(Work);
  Work[1] := ((BufferSize * 8) shr 8) and $ff;
  Work[0] := (BufferSize * 8) and $ff;

  Padding;

  G(N, Buffer);

  Add512(N, Work, N);
  Add512(Sigma, Buffer, Sigma);

  G(v_0, N);
  G(v_0, Sigma);

  MoveBlock(h, Hash);
end;

procedure TfrxCustomStreebogHash.X(const a, b: TBlockArray; var c: TBlockArray);
var
  i: Integer;
begin
  for i := 0 to BlockSize - 1 do
    c[i] := a[i] xor b[i];
end;

procedure TfrxCustomStreebogHash.Initialize;
begin
  ClearBlock(Buffer);
  ClearBlock(Hash);
  ClearBlock(N);
  ClearBlock(Sigma);
  ClearBlock(v_0);
  ClearBlock(v_512);
  v_512[1] := $02;
  BufferSize := 0;
end;


procedure TfrxCustomStreebogHash.Update(const Buf; Len: Cardinal);
var
  PartSize: Cardinal;
  DataVect: TBlockArray;
  DataPos: Cardinal;
  Data: PAnsiChar;
begin
  Data := PAnsiChar(@Buf);
  DataPos := 0;
  while (len > BlockSize - 1) and (BufferSize = 0) do
  begin
    MoveBlock(Data[DataPos], DataVect);
    Stage_2(DataVect);
    DataPos := DataPos + BlockSize;
    len := len - BlockSize;
  end;

  while len > 0 do
  begin
    PartSize := Min(BlockSize - BufferSize, len);
    Move(Data[DataPos], Buffer[BufferSize], PartSize);
    BufferSize := BufferSize + PartSize;
    len := len - PartSize;
    DataPos := DataPos + PartSize;
    if BufferSize = 64 then
    begin
      Stage_2(Buffer);
      BufferSize := 0;
    end;
  end;
end;

{ TfrxStreebog256Hash }

class function TfrxStreebog256Hash.DigestSize: Cardinal;
begin
  Result := 32;
end;

procedure TfrxStreebog256Hash.Initialize;
begin
  inherited Initialize;
  FillBlock(h, $01);
end;

{ TfrxStreebog512Hash }

class function TfrxStreebog512Hash.DigestSize: Cardinal;
begin
  Result := 64;
end;

procedure TfrxStreebog512Hash.Initialize;
begin
  inherited Initialize;
  ClearBlock(h);
end;

{ Autotest }
{$IfDef DEBUG}
{$ASSERTIONS ON}

function CalcHash(Msg: AnsiString; HashSize: Integer; PartLen: Integer = 0): AnsiString;
var
  StreebogHash: TfrxCustomStreebogHash;
  DataPos, len: Integer;
begin
  if HashSize = 256 then
    StreebogHash := TfrxStreebog256Hash.Create
  else
    StreebogHash := TfrxStreebog512Hash.Create;

  StreebogHash.Initialize;

  if PartLen <= 0 then
    StreebogHash.UpdateByAnsi(Msg)
  else
  begin
    DataPos := 1;
    while DataPos <= Length(Msg) do
    begin
      len := Min(PartLen, Length(Msg) - DataPos + 1);
      StreebogHash.Update(Msg[DataPos], len);
      DataPos := DataPos + len;
    end;
  end;

  StreebogHash.Finalize;

  Result := AnsiToHex(StreebogHash.DigestToAnsi, False);
end;

procedure TestMsg(Msg, Hash256, Hash512: AnsiString);
begin
  Assert(CalcHash(Msg, 256) = Hash256);
  Assert(CalcHash(Msg, 512) = Hash512);
  Assert(CalcHash(Msg, 256, Random(Length(Msg)) + 1) = Hash256);
  Assert(CalcHash(Msg, 512, Random(Length(Msg)) + 1) = Hash512);
end;

function AnsiStringOfChar(AC: AnsiChar; Len: Integer): AnsiString;
begin
  SetLength(Result, Len);
  FillChar(Result[1], Len, AC);
end;

procedure StreebogTest;
const
  M2: AnsiString = 'Се ветри, Стрибожи внуци, веютъ с моря стрелами на храбрыя плъкы Игоревы';
  M5: AnsiString = '123456789012345678901234567890 ' + #10 + '123456789012345678901234567890 ' + #10;
var
  AStr: AnsiString;
begin
  AStr := '';
  TestMsg(AStr,
    '3f539a213e97c802cc229d474c6aa32a825a360b2a933a949fd925208d9ce1bb',
    '8e945da209aa869f0455928529bcae4679e9873ab707b55315f56ceb98bef0a7362f715528356ee83cda5f2aac4c6ad2ba3a715c1bcd81cb8e9f90bf4c1c1a8a'
  );

  AStr := 'The quick brown fox jumps over the lazy dog';
  TestMsg(AStr,
    '3e7dea7f2384b6c5a3d0e24aaa29c05e89ddd762145030ec22c71a6db8b2c1f4',
    'd2b793a0bb6cb5904828b5b6dcfb443bb8f33efc06ad09368878ae4cdc8245b97e60802469bed1e7c21a64ff0b179a6a1e0bb74d92965450a0adab69162c00fe'
  );

  AStr := 'The quick brown fox jumps over the lazy dog.';
  TestMsg(AStr,
    '36816a824dcbe7d6171aa58500741f2ea2757ae2e1784ab72c5c3c6c198d71da',
    'fe0c42f267d921f940faa72bd9fcf84f9f1bd7e9d055e9816e4c2ace1ec83be82d2957cd59b86e123d8f5adee80b3ca08a017599a9fc1a14d940cf87c77df070'
  );

  AStr := '012345678901234567890123456789012345678901234567890123456789012';
  TestMsg(AStr,
    '9d151eefd8590b89daa6ba6cb74af9275dd051026bb149a452fd84e5e57b5500',
    '1b54d01a4af5b9d5cc3d86d68d285462b19abc2475222f35c085122be4ba1ffa00ad30f8767b3a82384c6574f024c311e2a481332b08ef7f41797891c1646f48'
  );

  AStr := M2;
  TestMsg(AStr,
    '9dd2fe4e90409e5da87f53976d7405b0c0cac628fc669a741d50063c557e8f50',
    '1e88e62226bfca6f9994f1f2d51569e0daf8475a3b0fe61a5300eee46d961376035fe83549ada2b8620fcd7c496ce5b33f0cb9dddc2b6460143b03dabac9fb28'
  );

  AStr := AnsiStringOfChar(#00, 64);
  TestMsg(AStr,
    'df1fda9ce83191390537358031db2ecaa6aa54cd0eda241dc107105e13636b95',
    'b0fd29ac1b0df441769ff3fdb8dc564df67721d6ac06fb28ceffb7bbaa7948c6c014ac999235b58cb26fb60fb112a145d7b4ade9ae566bf2611402c552d20db7'
  );

  AStr := M5;
  TestMsg(AStr,
    'f0a557f6a04a90ab1811c1b6e9b078e4163b74037c6cf59f52444a37f48e11d8',
    '363b449ec81ae40b3a407b125c3b1c2b768b50496bcb5f690b89e9007b06e4084182ed45d4072a67fec9d3421dab013da2aabc1d6528e8e775aec7b3457ac675'
  );

  AStr := M5 + M5 + M5;
  TestMsg(AStr,
    '2f4f651fe88fea46ec6f2223728d8dff3968893558ef00a310c23e7d1923ba0c',
    '8781dfc81d2db6a41d1857f3230b3ffe2bda574273ea1947189aaa5468470df1c4b374b1a2b56e59d11d213fea57e3514543b0ced9b20e553ae66425ec909cfd'
  );

  AStr := AnsiStringOfChar(#$EE, 64) + #$16 + AnsiStringOfChar(#$11, 62) + #$16;
  TestMsg(AStr,
    '81bb632fa31fcc38b4c379a662dbc58b9bed83f50d3a1b2ce7271ab02d25babb',
    '8b06f41e59907d9636e892caf5942fcdfb71fa31169a5e70f0edb873664df41c2cce6e06dc6755d15a61cdeb92bd607cc4aaca6732bf3568a23a210dd520fd41'
  );
end;

initialization

  StreebogTest;

{$EndIf}
end.
