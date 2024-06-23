unit frxPDFRSA;

{$I frx.inc}

interface

uses
  frxASN1, frxPDFX509Certificate;

function SignDigest(PrivateKey: TfrxRSAPrivateKey; Hash: TfrxASN1Base): AnsiString;

implementation

uses
  {$IFNDEF Linux}
  Windows,
  {$ENDIF}
  SysUtils, Classes, Math,
  frxHelpers;

{$IfNDef DELPHI11}
  {$Define WordDigit}
{$EndIf}

type
{$IfDef WordDigit}
  TDigit = Word;
  TSignedLongDigit = LongInt;
  TUnsignedLongDigit = LongWord;
  TLongDigitRec = LongRec;
{$Else}
  TDigit = LongWord;
  TSignedLongDigit = Int64;
  TUnsignedLongDigit = UInt64;
  TLongDigitRec = Int64Rec;
{$EndIf}

const
  DigitBitSize = SizeOf(TDigit) * 8;

type
  TBigWord = class
  private
    FCount: Integer;
    procedure SetCount(const Value: Integer);
  protected
    FDigits: array of TDigit;

    procedure LoadANS1(P: Pointer; Size: LongWord);
    procedure ProductSafe(B, C: TBigWord);
    procedure ProductUnsafe(B, C: TBigWord);
    procedure ReminderSafe(B, C: TBigWord);
    procedure ReminderUnsafe(B, C: TBigWord);
    function IsEqualDigit(B: TDigit): Boolean;
    procedure BigSmall(Cmp: TValueSign; const B, C: TBigWord; var Big, Small: TBigWord);
    procedure Normalize;
    procedure SetZeroDigit;
    procedure SetDigit(Value: TDigit);
    procedure SetDigits(Values: array of TDigit);
    procedure ConcatDigit(Value: TDigit);
    procedure SetCountAndClear(ACount: Integer);
    function IsZero: Boolean;
    function IsOdd: Boolean;
    function IsEven: Boolean;
    procedure Copy(B: TBigWord);

    function Bit(i: Integer): byte; // 0 or 1; i - 0 based
    function BitCount: Integer;
    procedure SetLastBit;
    procedure ShiftLeft;
    procedure ShiftRight;

    property Count: Integer read FCount write SetCount;
  public
    constructor Create;
    constructor CreateASN1(AnsiStr: AnsiString; Len: Integer = 0);
    constructor CreateDigit(Value: TDigit);
    constructor CreateCopy(B: TBigWord);
    destructor Destroy; override;

    function ToAnsiString: AnsiString;

    function Compare(B: TBigWord): TValueSign;
    procedure Summa(B, C: TBigWord);
    procedure Add(B: TBigWord);
    function Difference(B, C: TBigWord): TValueSign;
    function Subtract(B: TBigWord): TValueSign;
    procedure Product(B, C: TBigWord);
    procedure Multiply(B: TBigWord);
    procedure Reminder(B, C: TBigWord);
    procedure CalcReminder(B: TBigWord);
    procedure PowerAndMod(const A, E, M: TBigWord);
  end;

function SignDigest(PrivateKey: TfrxRSAPrivateKey; Hash: TfrxASN1Base): AnsiString;
var
  C, dP, dQ, N, P, q, qInv: TBigWord;
  M1, M2, Tmp: TBigWord;
  ModulusRealSize, ModulusSize: Integer;
  HashStr: AnsiString;
  HashSize, i: Integer;
  SignBlock: AnsiString;
begin
  HashStr := Hash.ToAnsi;
  HashSize := Length(HashStr);

  ModulusSize := Length(PrivateKey.Modulus.Data);
  ModulusRealSize := ModulusSize;

  i := 0;
  while (i < ModulusSize) and (PrivateKey.Modulus.Data[i + 1] = #0) do
    Inc(i);
  Dec(ModulusRealSize, i);
  if HashSize > ModulusRealSize - 11 then
    raise ESignException.Create('Small modulus size for Digital Signature');
  SetLength(SignBlock, ModulusRealSize);
  FillChar(SignBlock[1], ModulusRealSize, #255);
  SignBlock[1] := #0;
  SignBlock[2] := #1;
  SignBlock[ModulusRealSize - HashSize] := #0;
  Move(HashStr[1], SignBlock[ModulusRealSize - HashSize + 1], HashSize);

  C := TBigWord.CreateASN1(SignBlock, ModulusRealSize);
  N := TBigWord.CreateASN1(PrivateKey.Modulus.Data);
  P := TBigWord.CreateASN1(PrivateKey.Prime1.Data);
  q := TBigWord.CreateASN1(PrivateKey.Prime2.Data);
  dP := TBigWord.CreateASN1(PrivateKey.Exponent1.Data);
  dQ := TBigWord.CreateASN1(PrivateKey.Exponent2.Data);
  qInv := TBigWord.CreateASN1(PrivateKey.Coeficient.Data);
  try
    if C.Compare(N) >= 0 then
      raise Exception.Create('RSA Error');
    Tmp := TBigWord.Create;
    M1 := TBigWord.Create;
    M2 := TBigWord.Create;
    try
      M1.PowerAndMod(C, dP, P);
      M2.PowerAndMod(C, dQ, q);

      if Tmp.Difference(M1, M2) < 0 then
      begin
        if P.Compare(Tmp) <= 0 then
          Tmp.CalcReminder(P);
        Tmp.Difference(P, Tmp);
      end;

      Tmp.Multiply(qInv);
      Tmp.CalcReminder(P);
      Tmp.Multiply(q);

      M2.Add(Tmp);
      Result := M2.ToAnsiString;
    finally
      Tmp.Free;
      M1.Free;
      M2.Free;
    end;
  finally
    C.Free;
    N.Free;
    P.Free;
    q.Free;
    dP.Free;
    dQ.Free;
    qInv.Free;
  end;
end;

{ TBigWord }

procedure TBigWord.Add(B: TBigWord);
begin
  Summa(Self, B);
end;

procedure TBigWord.BigSmall(Cmp: TValueSign; const B, C: TBigWord; var Big, Small: TBigWord);
begin
  if Cmp > 0 then
  begin
    Big := B;
    Small := C;
  end
  else
  begin
    Big := C;
    Small := B;
  end;
end;

function TBigWord.Bit(i: Integer): byte;
begin
  Result := (FDigits[i div DigitBitSize] shr (i and (DigitBitSize - 1))) and 1;
end;

function TBigWord.BitCount: Integer;
var
  l: Integer;
  D: TDigit;
begin
  Result := 0;
  for l := Count - 1 downto 0 do
    if FDigits[l] <> 0 then
    begin
      Result := DigitBitSize * l;
      D := FDigits[l];
      while D <> 0 do
      begin
        Inc(Result);
        D := D shr 1;
      end;
      Break;
    end;
end;

function TBigWord.Compare(B: TBigWord): TValueSign;
var
  l: Integer;
begin
  Normalize;
  B.Normalize;
  Result := Sign(Count - B.Count);
  if Result = 0 then
    for l := Count - 1 downto 0 do
    begin
      Result := Sign(TSignedLongDigit(FDigits[l]) - TSignedLongDigit(B.FDigits[l]));
      if Result <> 0 then
        Break;
    end;
end;

procedure TBigWord.ConcatDigit(Value: TDigit);
begin
  Count := Count + 1;
  FDigits[Count - 1] := Value;
end;

procedure TBigWord.Copy(B: TBigWord);
begin
  Count := B.Count;
  Move(B.FDigits[0], FDigits[0], Count * SizeOf(TDigit));
end;

constructor TBigWord.Create;
begin
  inherited;

  Count := 0;
  SetLength(FDigits, 0);
end;

constructor TBigWord.CreateASN1(AnsiStr: AnsiString; Len: Integer = 0);
begin
  Create;
  if Len = 0 then
    Len := Length(AnsiStr);
  LoadANS1(@AnsiStr[1], Len);
end;

constructor TBigWord.CreateCopy(B: TBigWord);
begin
  Create;
  Copy(B);
end;

constructor TBigWord.CreateDigit(Value: TDigit);
begin
  Create;
  SetDigit(Value);
end;

destructor TBigWord.Destroy;
begin
  SetLength(FDigits, 0);

  inherited;
end;

function TBigWord.Difference(B, C: TBigWord): TValueSign;
const
  Start: array[Boolean] of TUnsignedLongDigit =
    (High(TDigit) + TUnsignedLongDigit(1), High(TDigit));
var
  Big, Small: TBigWord;
  l: Integer;
  R: TUnsignedLongDigit;
  Borrowed: Boolean;
begin
  Result := B.Compare(C);
  if Result = 0 then
  begin
    Count := 0;
    Result := 1;
    Exit;
  end
  else
    BigSmall(Result, B, C, Big, Small);
  Small.SetCountAndClear(Big.Count);
  Count := Big.Count;
  Borrowed := False;
  for l := 0 to Big.Count - 1 do
  begin
    R := Start[Borrowed] + TUnsignedLongDigit(Big.FDigits[l])
                         - TUnsignedLongDigit(Small.FDigits[l]);
    FDigits[l] := TLongDigitRec(R).Lo;
    Borrowed := TLongDigitRec(R).Hi = 0;
  end;
  Normalize;
end;

function TBigWord.IsEqualDigit(B: TDigit): Boolean;
var
  l: Integer;
begin
  Result := (B = 0) and IsZero or (Count > 0) and (FDigits[0] = B);
  if Result then
    for l := 1 to Count - 1 do
    begin
      Result := FDigits[l] = 0;
      if not Result then
        Exit;
    end;
end;

function TBigWord.IsEven: Boolean;
begin
  Result := (Count = 0) or ((FDigits[0] and 1) = 0);
end;

function TBigWord.IsOdd: Boolean;
begin
  Result := (Count <> 0) and ((FDigits[0] and 1) = 1);
end;

function TBigWord.IsZero: Boolean;
var
  l: Integer;
begin
  Result := False;
  for l := 0 to Count - 1 do
    if FDigits[l] <> 0 then
      Exit;
  Result := True;
end;

procedure TBigWord.LoadANS1(P: Pointer; Size: LongWord);
var
  SZ, l, MD: Integer;
  PB: PByteArray;
begin
  SZ := (Size + SizeOf(TDigit) - 1) div SizeOf(TDigit);
  Count := SZ;

  MD := Size mod SizeOf(TDigit);
  if MD <> 0 then
  begin
    PB := P;
    P := IncPointer(P, MD);
    case MD of
      3: FDigits[SZ - 1] := PB[0] shl 16 + PB[1] shl 8 + PB[2];
      2: FDigits[SZ - 1] :=                PB[0] shl 8 + PB[1];
      1: FDigits[SZ - 1] :=                              PB[0];
    end;
    Dec(SZ);
  end;

  for l := SZ - 1 downto 0 do
  begin
    PB := P;
    P := IncPointer(P, SizeOf(TDigit));
    FDigits[l] :=
      {$IfDef WordDigit} PB[0] shl 8 + PB[1];
      {$Else}            PB[0] shl 24 + PB[1] shl 16 + PB[2] shl 8 + PB[3];
      {$EndIf}
  end;
  Normalize;
end;

procedure TBigWord.Multiply(B: TBigWord);
begin
  ProductSafe(Self, B);
end;

procedure TBigWord.Normalize;
begin
  while (Count > 0) and (FDigits[Count - 1] = 0) do
    Count := Count - 1;
end;

procedure TBigWord.PowerAndMod(const A, E, M: TBigWord);
var
  T, Y, F : TBigWord;
begin
  T := TBigWord.Create;
  Y := TBigWord.CreateCopy(A);
  F := TBigWord.CreateCopy(E);
  try
    Self.SetDigit(1);
    while not F.IsZero do
    begin
      if F.IsOdd then
        begin
          T.Product(Self, Y);
          Self.Reminder(T, M);
        end;
      T.Product(Y, Y);
      Y.Reminder(T, M);
      F.ShiftRight;
    end;
  finally
    F.Free;
    Y.Free;
    T.Free;
  end;
end;

procedure TBigWord.Product(B, C: TBigWord);
begin
  if (Self = B) or (Self = C) then
    ProductSafe(B, C)
  else
    ProductUnsafe(B, C);
end;

procedure TBigWord.ProductSafe(B, C: TBigWord);
var
  Temp: TBigWord;
begin
  Temp := TBigWord.Create;
  try
    Temp.ProductUnsafe(B, C);
    Copy(Temp);
  finally
    Temp.Free;
  end;
end;

procedure TBigWord.ProductUnsafe(B, C: TBigWord);
var
  Big, Small: TBigWord;
  lS, lB: Integer;
  R: TUnsignedLongDigit;
begin
  BigSmall(B.Compare(C), B, C, Big, Small);

  if      Small.IsZero then
  begin
    Count := 0;
    Exit;
  end
  else if Small.IsEqualDigit(1) then
  begin
    Copy(Big);
    Exit;
  end;

  Count := 0; // To Clear
  SetCountAndClear(Big.Count + Small.Count);
  for lS := 0 to Small.Count - 1 do
  begin
    R := 0;
    for lB := 0 to Big.Count - 1 do
    begin
      R := R + TUnsignedLongDigit(FDigits[lB + lS]) +
        TUnsignedLongDigit(Big.FDigits[lB]) * TUnsignedLongDigit(Small.FDigits[lS]);
      FDigits[lB + lS] := TLongDigitRec(R).Lo;
      R :=                TLongDigitRec(R).Hi;
    end;
    FDigits[lS + Big.Count] := TLongDigitRec(R).Lo;
  end;
  Normalize;
end;

procedure TBigWord.Reminder(B, C: TBigWord);
begin
  if (Self = B) or (Self = C) then
    ReminderSafe(B, C)
  else
    ReminderUnsafe(B, C);
end;

procedure TBigWord.CalcReminder(B: TBigWord);
begin
  ReminderSafe(Self, B);
end;

procedure TBigWord.ReminderSafe(B, C: TBigWord);
var
  Temp: TBigWord;
begin
  Temp := TBigWord.Create;
  try
    Temp.ReminderUnsafe(B, C);
    Copy(Temp);
  finally
    Temp.Free;
  end;
end;

procedure TBigWord.ReminderUnsafe(B, C: TBigWord);
var
  i: Integer;
begin
  SetZeroDigit;

  for i := B.BitCount - 1 downto 0 do
  begin
    ShiftLeft;
    FDigits[0] := FDigits[0] or B.Bit(i);

    case Compare(C) of
      1: Subtract(C);
      0: SetZeroDigit;
    end;
  end;
end;

procedure TBigWord.SetCount(const Value: Integer);
begin
  if Length(FDigits) < Value then
    SetLength(FDigits, Value);

  FCount := Value;
end;

procedure TBigWord.SetCountAndClear(ACount: Integer);
var
  OldCount: Integer;
begin
  OldCount := Count;
  Count := ACount;
  if ACount > OldCount then
    FillChar(FDigits[OldCount], (ACount - OldCount) * SizeOf(TDigit), 0);
end;

procedure TBigWord.SetLastBit;
begin
  if Count = 0 then
    SetZeroDigit;
  FDigits[0] := FDigits[0] or 1;
end;

procedure TBigWord.SetDigit(Value: TDigit);
begin
  if Value = 0 then
    Count := 0
  else
  begin
    Count := 1;
    FDigits[0] := Value;
  end;
end;

procedure TBigWord.SetDigits(Values: array of TDigit);
begin
  Count := Length(Values);
  Move(Values[0], FDigits[0], Length(Values) * SizeOf(TDigit));
end;

procedure TBigWord.SetZeroDigit;
begin
  Count := 1;
  FDigits[0] := 0;
end;

procedure TBigWord.ShiftLeft;
const
  HighBit: TDigit = (High(TDigit) + TUnsignedLongDigit(1)) div 2;
var
  l: Integer;
begin
  if Count = 0 then
    Exit;
  if (FDigits[Count - 1] and HighBit) <> 0 then
    SetCountAndClear(Count + 1);
  for l := Count - 1 downto 1 do
    FDigits[l] := (FDigits[l] shl 1) or (FDigits[l - 1] shr (DigitBitSize - 1));
  FDigits[0] := FDigits[0] shl 1;
end;

procedure TBigWord.ShiftRight;
var
  l: Integer;
begin
  if Count = 0 then
    Exit;
  for l := 0 to Count - 2 do
    FDigits[l] := (FDigits[l] shr 1) or (FDigits[l + 1] shl (DigitBitSize - 1));
  FDigits[Count - 1] := FDigits[Count - 1] shr 1;
end;

function TBigWord.Subtract(B: TBigWord): TValueSign;
begin
  Result := Difference(Self, B);
end;

procedure TBigWord.Summa(B, C: TBigWord);
var
  Long, Short: TBigWord;
  l: Integer;
  R: TUnsignedLongDigit;
begin
  BigSmall(Ord(B.Count > C.Count), B, C, Long, Short);
  Short.SetCountAndClear(Long.Count);
  Count := Long.Count;
  R := 0;
  for l := 0 to Long.Count - 1 do
  begin
    R := R + TUnsignedLongDigit(Long.FDigits[l]) + TUnsignedLongDigit(Short.FDigits[l]);
    FDigits[l] := TLongDigitRec(R).Lo;
    R :=          TLongDigitRec(R).Hi;
  end;
  if R <> 0 then
    ConcatDigit(TLongDigitRec(R).Lo);
end;

function TBigWord.ToAnsiString: AnsiString;
var
  l, C: Integer;
  D: TDigit;
begin
  SetLength(Result, SizeOf(TDigit) * Count);
  C := 1;
  for l := Count - 1 downto 0 do
  begin
    D := FDigits[l];
{$IfDef WordDigit}
    Result[C]     := AnsiChar((D shr 8) and $FF);
    Result[C + 1] := AnsiChar( D        and $FF);
{$Else}
    Result[C]     := AnsiChar((D shr 24) and $FF);
    Result[C + 1] := AnsiChar((D shr 16) and $FF);
    Result[C + 2] := AnsiChar((D shr  8) and $FF);
    Result[C + 3] := AnsiChar( D         and $FF);
{$EndIf}
    Inc(C, SizeOf(TDigit));
  end;
end;

initialization

end.
