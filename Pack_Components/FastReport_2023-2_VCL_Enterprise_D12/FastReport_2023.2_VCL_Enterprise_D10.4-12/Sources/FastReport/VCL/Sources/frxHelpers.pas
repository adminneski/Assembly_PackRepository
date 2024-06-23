
{******************************************}
{                                          }
{             FastReport VCL               }
{                Helpers                   }
{                                          }
{         Copyright (c) 1998-2022          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxHelpers;

{$I frx.inc}

interface

uses
  Classes, SysUtils, frXML, frxVariables;

type
  TValueDlm = (vdUnknown, vdApostrophe, vdQuote);

  ESignException = class(Exception);

  TLogList = class(TStringList)
  public
    procedure Save(FileName: TFileName);
    procedure SaveAppend(FileName: TFileName);
  end;

function IncPointer(P: Pointer; Offset: Cardinal): Pointer;
function IntToAnsiStr(Value: Integer): AnsiString;
function ROL(const Value: LongWord; const Bits: Byte): LongWord;
function ROL16(const Value: Word; const Bits: Byte): Word;
function ROR16(const Value: Word; const Bits: Byte): Word;
function AnsiToHex(st: AnsiString; UpCase: Boolean = True): AnsiString;
function BufferToHex(Buffer: Pointer; Len: Cardinal; UpCase: Boolean = True): AnsiString;

function ByteSwap(Value: Cardinal): Cardinal; overload;
function ByteSwap(Value: Integer): Cardinal; overload;
function ByteSwap(Value: Int64): Int64; overload;

function AnsiStringOfChar(ACh: AnsiChar; Count: Integer): AnsiString;

function ReadExtended8(Stream: TStream): Extended;
function ReadExtended10(Stream: TStream): Extended;
function ReadExtended16(Stream: TStream): Extended;

function ReadWideStringFromStream(Stream: TStream): WideString;
procedure WriteWideStringToStream(Stream: TStream; const ws: WideString);

implementation

uses
  Math, StrUtils,
  frUtils,
  frxUtils;

{ Utility routines }

function ReadWideStringFromStream(Stream: TStream): WideString;
var
  nChars: Cardinal;
begin
  Stream.ReadBuffer(nChars, SizeOf(nChars));
  SetLength(Result, nChars);
  if nChars > 0 then
    Stream.ReadBuffer(Result[1], nChars * SizeOf(Result[1]));
end;

procedure WriteWideStringToStream(Stream: TStream; const ws: WideString);
var
  nChars: Cardinal;
begin
  nChars := Length(ws);
  Stream.WriteBuffer(nChars, SizeOf(nChars));
  if nChars > 0 then
    Stream.WriteBuffer(ws[1], nChars * SizeOf(ws[1]));
end;

function ReadExtended16(Stream: TStream): Extended;
begin
  case SizeOf(Extended) of
    8, 10:
      begin
        Result := ReadExtended10(Stream);
        Stream.Position := Stream.Position + 6;
      end;
    16:
      Stream.ReadBuffer(Result, SizeOf(Result));
  end;
end;

function ReadExtendedViaDouble(Stream: TStream): Double;
begin
  Stream.ReadBuffer(Result, SizeOf(Result));
end;

function ReadExtended8(Stream: TStream): Extended;
begin
  case SizeOf(Extended) of
    8:
      Stream.ReadBuffer(Result, SizeOf(Result));
    10, 16:
      Result := ReadExtendedViaDouble(Stream);
  end;
end;

// https://stackoverflow.com/questions/2943660/delphi-extended-to-c-sharp
function ConvertDelphiExtended(Stream: TStream): Extended;
const
  extendedSize = 10;
var
  buf: array [0 .. extendedSize - 1] of Byte;
  bf: Int64 absolute buf[0];
  sign, integral, mantissa, value: Extended;
  exp: word;
  iexp: Integer;
  fractal: Int64;
begin
  Stream.Read(buf[0], extendedSize);
  sign := frIfReal(buf[extendedSize - 1] and $80 = $80, -1, 1);
  buf[extendedSize - 1] := (buf[extendedSize - 1] and $7F);
  Move(buf[8], exp, 2);
  exp := word(buf[extendedSize - 1]) shl 8 + buf[extendedSize - 2];
  integral := frIfReal(buf[extendedSize - 3] and $80 = $80, 1, 0);
  // Calculate mantissa
  mantissa := 0.0;
  value := 1.0;
  fractal := bf;

  while fractal <> 0 do
  begin
    value := value / 2;
    if fractal and $4000000000000000 = $4000000000000000 then // Latest bit is sign, just skip it
      mantissa := mantissa + value;
    fractal := fractal shl 1;
  end;

  iexp := Integer(exp) - 16383;
  if ((iexp < -307) or (iexp > 307)) and (SizeOf(Extended) = 8) then
    Result := 0
  else
    Result := sign * Power(2, iexp) * (integral + mantissa);
end;

function ReadExtended10(Stream: TStream): Extended;
begin
  case SizeOf(Extended) of
    10:
      Stream.ReadBuffer(Result, SizeOf(Result));
    8, 16:
      Result := ConvertDelphiExtended(Stream);
  end;
end;

function AnsiStringOfChar(ACh: AnsiChar; Count: Integer): AnsiString;
begin
  Result := AnsiString(StringOfChar(ACh, Count));
end;

function ByteSwap(Value: Integer): Cardinal; overload;
begin
  Result := ByteSwap(Cardinal(Value));
end;

function ByteSwap(Value: Cardinal): Cardinal; overload;
begin
  Result := ((Value and $FF) shl 24) or ((Value and $FF00) shl 8) or
    ((Value and $FF0000) shr 8) or ((Value and $FF000000) shr 24);
end;

function ByteSwap(Value: Int64): Int64; overload;
begin
  Result := (Int64(ByteSwap(LongWord(Value and $FFFFFFFF))) shl 32) or
    ByteSwap(LongWord(Value shr 32));
end;

function BufferToHex(Buffer: Pointer; Len: Cardinal; UpCase: Boolean = True): AnsiString;
const
  HEX: array [Boolean, 0..15] of ANSIChar = (
    ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'),
    ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F')
  );
var
  i: Integer;
  b: PByte;
begin
  SetLength(Result, Len * 2);
  b := Buffer;
  for i := 0 to Len - 1 do
  begin
    Result[i * 2 + 1] := HEX[UpCase, b^ shr 4];
    Result[i * 2 + 2] := HEX[UpCase, b^ and $F];
    Inc(b);
  end;
end;

function AnsiToHex(st: AnsiString; UpCase: Boolean = True): AnsiString;
begin
  Result := BufferToHex(@st[1], Length(st), UpCase);
end;

function ROR16(const Value: Word; const Bits: Byte): Word;
begin
  Result := (Value shr Bits) or (Value shl (16 - Bits));
end;

function ROL16(const Value: Word; const Bits: Byte): Word;
begin
  Result := (Value shl Bits) or (Value shr (16 - Bits));
end;

function ROL(const Value: LongWord; const Bits: Byte): LongWord;
begin
  Result := (Value shl Bits) or (Value shr (32 - Bits));
end;

function IntToAnsiStr(Value: Integer): AnsiString;
begin
  Result := AnsiString(IntToStr(Value));
end;

function IncPointer(P: Pointer; Offset: Cardinal): Pointer;
begin
  Result := Pointer({$ifdef win64}UInt64{$else}Cardinal{$endif}(P) + Offset);
end;

{ TLogList }

procedure TLogList.Save(FileName: TFileName);
begin
  SaveToFile(FileName);
end;

procedure TLogList.SaveAppend(FileName: TFileName);
var
  AFile: TextFile;
begin
  if FileExists(FileName) then
  begin
    AssignFile(AFile, Filename);
    System.Append(AFile);
    try
      Writeln(AFile, Self.Text);
    finally
      CloseFile(AFile);
    end;
  end
  else
    Save(FileName);
end;

{ Test ConvertDelphiExtended }

type
  TExt10 = array[0..9] of byte;
  TTestExt10 = record
    Ext10: TExt10;
    Value: Double;
  end;

const
  TestExt10Array: array [0 .. 5] of TTestExt10 = (
    (Ext10: ($00, $00, $00, $00, $00, $00, $00, $80, $ff, $3f); Value: 1.0),
    (Ext10: ($00, $50, $AA, $7D, $3A, $1E, $33, $D3, $01, $40); Value: 6.59999),
    (Ext10: ($00, $00, $00, $00, $00, $00, $A0, $8C, $0B, $40); Value: 4500),
    (Ext10: ($00, $D0, $F7, $53, $E3, $A5, $9B, $C4, $F7, $3F); Value: 0.006),
    (Ext10: ($00, $A0, $70, $3D, $0A, $D7, $A3, $B0, $FD, $3F); Value: 0.345),
    (Ext10: ($00, $68, $66, $66, $66, $66, $66, $A2, $02, $40); Value: 10.15)
  );

procedure TestConvertDelphiExtended;
var
  i: Integer;
  Stream: TMemoryStream;
begin
  Stream := TMemoryStream.Create;
  try
    for i := Low(TestExt10Array) to High(TestExt10Array) do
    begin
      Stream.Position := 0;
      Stream.WriteBuffer(TestExt10Array[i].Ext10, SizeOf(TExt10));
      Stream.Position := 0;
      if ConvertDelphiExtended(Stream) <> TestExt10Array[i].Value then
        raise Exception.Create('Error ConvertDelphiExtended N ' + IntToStr(i));
    end;
  finally
    Stream.Free;
  end;
end;

initialization
//  TestConvertDelphiExtended;

end.

