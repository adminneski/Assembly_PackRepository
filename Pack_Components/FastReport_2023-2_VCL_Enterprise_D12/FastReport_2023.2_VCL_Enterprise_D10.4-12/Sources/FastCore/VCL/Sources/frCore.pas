{******************************************}
{                                          }
{          FastReport VCL/FMX/LCL          }
{              Core Library                }
{                                          }
{         Copyright (c) 1998-2022          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

{$IFNDEF FMX}
unit frCore;
{$ENDIF}

{$I frVer.inc}

interface

uses
{$IFNDEF FMX}
  {$IFNDEF FPC} Windows, Types,{$ENDIF}
  Classes, SysUtils,
  {$IFDEF FPC} LCLType, {$ENDIF}
  frUnicodeUtils;
{$ELSE}
  System.Classes, System.SysUtils, System.IOUtils,
{$IFDEF MACOS}
  Posix.Stdlib,
{$ENDIF MACOS}
  FMX.frUnicodeUtils;
{$ENDIF}

const
  FR_VERSION = {$I frVersion.inc};

type
{$IFDEF DELPHI29}
  TfrListInteger = NativeInt;
{$ELSE}
  TfrListInteger = Integer;
{$ENDIF}
  TfrHandle = THandle;
{$IFDEF DELPHI16}
  frInteger = NativeInt;
{$ELSE}
  frInteger = {$IFDEF FPC}PtrInt{$ELSE}Integer{$ENDIF};
{$ENDIF}

const
{$IFNDEF FPC}
  AllFilesMask = '*';
  DirectorySeparator = PathDelim;
{$ENDIF}
  {$EXTERNALSYM SW_SHOWNORMAL}
  SW_SHOWNORMAL = 1;


function frCapitalizeStr(const AValue: string; AAllWords: Boolean = True): string;
function frStrToAnsi(const AValue: string; ACodePage: Integer = 0): AnsiString;
function frStrToWStr(const AValue: string; ACodePage: Integer = 0): WideString;
function frWStrToStr(const AValue: WideString; ACodePage: Integer = 0): string;
function frAnsiToStr(const AValue: AnsiString; ACodePage: Integer = 0): string;
//
function frCRC32(Stream: TStream): Cardinal;
//
function frGetTempFileName(ATempDir, APrefix: String): String;
function frGetTemporaryFolder: String;
function frGetTempFile: String;
function frGetAppPath: string;
//
function frShellExecute(const AFileName: string; AShowCmd: Integer = SW_SHOWNORMAL): Boolean; overload;
function frShellExecute(AHandle: TfrHandle; const AFileName: string; AShowCmd: Integer = SW_SHOWNORMAL): Boolean; overload;
//
function frSeek(AStream: TStream; AOffset: Integer; AOrigin: Word): Int64;

implementation

{$IFDEF MSWINDOWS}
  uses
    ShellApi;
{$ENDIF}

const
  CRCTable: array [0..255] of Cardinal = (
 0000000000, 1996959894, 3993919788, 2567524794,
 0124634137, 1886057615, 3915621685, 2657392035,
 0249268274, 2044508324, 3772115230, 2547177864,
 0162941995, 2125561021, 3887607047, 2428444049,
 0498536548, 1789927666, 4089016648, 2227061214,
 0450548861, 1843258603, 4107580753, 2211677639,
 0325883990, 1684777152, 4251122042, 2321926636,
 0335633487, 1661365465, 4195302755, 2366115317,
 0997073096, 1281953886, 3579855332, 2724688242,
 1006888145, 1258607687, 3524101629, 2768942443,
 0901097722, 1119000684, 3686517206, 2898065728,
 0853044451, 1172266101, 3705015759, 2882616665,
 0651767980, 1373503546, 3369554304, 3218104598,
 0565507253, 1454621731, 3485111705, 3099436303,
 0671266974, 1594198024, 3322730930, 2970347812,
 0795835527, 1483230225, 3244367275, 3060149565,
 1994146192, 0031158534, 2563907772, 4023717930,
 1907459465, 0112637215, 2680153253, 3904427059,
 2013776290, 0251722036, 2517215374, 3775830040,
 2137656763, 0141376813, 2439277719, 3865271297,
 1802195444, 0476864866, 2238001368, 4066508878,
 1812370925, 0453092731, 2181625025, 4111451223,
 1706088902, 0314042704, 2344532202, 4240017532,
 1658658271, 0366619977, 2362670323, 4224994405,
 1303535960, 0984961486, 2747007092, 3569037538,
 1256170817, 1037604311, 2765210733, 3554079995,
 1131014506, 0879679996, 2909243462, 3663771856,
 1141124467, 0855842277, 2852801631, 3708648649,
 1342533948, 0654459306, 3188396048, 3373015174,
 1466479909, 0544179635, 3110523913, 3462522015,
 1591671054, 0702138776, 2966460450, 3352799412,
 1504918807, 0783551873, 3082640443, 3233442989,
 3988292384, 2596254646, 0062317068, 1957810842,
 3939845945, 2647816111, 0081470997, 1943803523,
 3814918930, 2489596804, 0225274430, 2053790376,
 3826175755, 2466906013, 0167816743, 2097651377,
 4027552580, 2265490386, 0503444072, 1762050814,
 4150417245, 2154129355, 0426522225, 1852507879,
 4275313526, 2312317920, 0282753626, 1742555852,
 4189708143, 2394877945, 0397917763, 1622183637,
 3604390888, 2714866558, 0953729732, 1340076626,
 3518719985, 2797360999, 1068828381, 1219638859,
 3624741850, 2936675148, 0906185462, 1090812512,
 3747672003, 2825379669, 0829329135, 1181335161,
 3412177804, 3160834842, 0628085408, 1382605366,
 3423369109, 3138078467, 0570562233, 1426400815,
 3317316542, 2998733608, 0733239954, 1555261956,
 3268935591, 3050360625, 0752459403, 1541320221,
 2607071920, 3965973030, 1969922972, 0040735498,
 2617837225, 3943577151, 1913087877, 0083908371,
 2512341634, 3803740692, 2075208622, 0213261112,
 2463272603, 3855990285, 2094854071, 0198958881,
 2262029012, 4057260610, 1759359992, 0534414190,
 2176718541, 4139329115, 1873836001, 0414664567,
 2282248934, 4279200368, 1711684554, 0285281116,
 2405801727, 4167216745, 1634467795, 0376229701,
 2685067896, 3608007406, 1308918612, 0956543938,
 2808555105, 3495958263, 1231636301, 1047427035,
 2932959818, 3654703836, 1088359270, 0936918000,
 2847714899, 3736837829, 1202900863, 0817233897,
 3183342108, 3401237130, 1404277552, 0615818150,
 3134207493, 3453421203, 1423857449, 0601450431,
 3009837614, 3294710456, 1567103746, 0711928724,
 3020668471, 3272380065, 1510334235, 0755167117);

function frCRC32(Stream: TStream): Cardinal;
var
  OldPos: Integer;
  b: Byte;
  c: Cardinal;
begin
  OldPos := Stream.Position;
  Stream.Position := 0;
  c := $ffffffff;
  while Stream.Position < Stream.Size do
  begin
    Stream.Read(b,1);
    c := CrcTable[(c xor Cardinal(b)) and $ff] xor (c shr 8);
  end;
  Stream.Position := OldPos;
  Result := c xor $ffffffff;
end;

function frCapitalizeStr(const AValue: string; AAllWords: Boolean = True): string;
var
  I: Integer;
  LBeginWord: Boolean;
begin
  Result := LowerCase(AValue);
  LBeginWord := True;
  for I := 1 to Length(AValue) do
  begin
    if LBeginWord and (Result[I] <> ' ') then
      Result[I] := UpCase(Result[I]);
    LBeginWord := Result[I] = ' ';
    if not AAllWords and not LBeginWord then
      Break;
  end;
end;

function frStrToAnsi(const AValue: string; ACodePage: Integer = 0): AnsiString;
begin
{$IFNDEF DELPHI12}
  Result := AValue
{$ELSE}
  Result := _UnicodeToAnsi(AValue, DEFAULT_CHARSET, ACodePage);
{$ENDIF}
end;

function frStrToWStr(const AValue: string; ACodePage: Integer = 0): WideString;
begin
{$IFDEF DELPHI12}
  Result := AValue
{$ELSE}
  Result := AnsiToUnicode(AValue, DEFAULT_CHARSET, ACodePage)
{$ENDIF}
end;

function frWStrToStr(const AValue: WideString; ACodePage: Integer = 0): string;
begin
{$IFDEF DELPHI12}
  Result := AValue
{$ELSE}
  Result := _UnicodeToAnsi(AValue, DEFAULT_CHARSET, ACodePage);
{$ENDIF}
end;

function frAnsiToStr(const AValue: AnsiString; ACodePage: Integer = 0): string;
begin
{$IFNDEF DELPHI12}
  Result := AValue
{$ELSE}
  Result := AnsiToUnicode(AValue, DEFAULT_CHARSET, ACodePage);
{$ENDIF}
end;

function frGetAppFileName: String;
// There is no cross platoform method at moment
// Lets hope that user want the same directory as .exe directory but not .dll
{$IFDEF DELPHIVCL}
var
  fName: String;
  nsize: cardinal;
{$ENDIF}
begin
{$IFDEF DELPHIVCL}
  nsize := MAX_PATH;
  SetLength(fName, nsize);
  SetLength(fName, GetModuleFileName(hinstance, PChar(fName), nsize));
  Result := fName;
{$ELSE}
  Result := ParamStr(0);
{$ENDIF}
end;

function frGetAppPath: string;
begin
  Result := ExtractFilePath(frGetAppFileName);
end;

function frShellExecute(const AFileName: string; AShowCmd: Integer = SW_SHOWNORMAL): Boolean;
begin
  Result := frShellExecute(0, AFileName, AShowCmd);
end;

function frShellExecute(AHandle: TfrHandle; const AFileName: string; AShowCmd: Integer = SW_SHOWNORMAL): Boolean;
begin
{$IFDEF MSWINDOWS}
  Result := ShellExecute(AHandle, 'open', PChar(AFileName), nil, nil, AShowCmd) >= 32;
{$ELSE}
  {$IFDEF MACOS}
    Result := _system(PAnsiChar('open ' + '"' + AnsiString(AFileName) + '"')) = 0;
  {$ELSE}
    Result := False;
  {$ENDIF MACOS}
{$ENDIF MXWINDOWS}
end;

{$IFNDEF FMX}

function frGetTemporaryFolder: String;
{$IFNDEF FPC}
var
  Path: String;
{$ENDIF}
begin
{$IFDEF FPC}
  Result := GetTempDir;
  if (Length(Result) > 0) and (Result[Length(Result)] = DirectorySeparator) then
    Delete(Result, Length(Result), 1);
{$ELSE}
  Setlength(Path, MAX_PATH);
  SetLength(Path, GetTempPath(MAX_PATH, @Path[1]));
{$IFDEF DELPHI12}
  Result := StrPas(PWideChar(@Path[1]));
{$ELSE}
  Result := StrPas(@Path[1]);
{$ENDIF}
{$ENDIF}
end;

function frGetTempFileName(ATempDir, APrefix: String): String;
var
{$IFDEF FPC}
  Path: String;
{$ELSE}
  {$IFDEF DELPHI12}
    Path: WideString;
    FileName: WideString;
  {$ELSE}
    Path: String[64];
    FileName: String[255];
  {$ENDIF}
{$ENDIF}
begin
{$IFDEF FPC}
  Path := ATempDir;
  if (Path = '') or not DirectoryExists(Path) then
    Path := GetTempDir;
  Result := GetTempFilename(Path, '');
{$ELSE}
  {$IFDEF DELPHI12}
    SetLength(FileName, 255);
    Path := ATempDir;
    if (Path = '') or not DirectoryExists(String(Path)) then
    begin
      SetLength(Path, 255);
      SetLength(Path, GetTempPath(255, @Path[1]));
    end
    else
  {$ELSE}
    Path := ATempDir;
    if (Path = '') or not DirectoryExists(Path) then
      Path[0] := Chr(GetTempPath(64, @Path[1])) else
  {$ENDIF}
      Path := Path + #0;
    if (Path <> '') and (Path[Length(Path)] <> '\') then
      Path := Path + '\';
    Windows.GetTempFileName(@Path[1], PChar(APrefix), 0, @FileName[1]);
  {$IFDEF DELPHI12}
    Result := StrPas(PWideChar(@FileName[1]));
  {$ELSE}
    Result := StrPas(@FileName[1]);
  {$ENDIF}
{$ENDIF}
end;

{$ELSE }
function frGetTemporaryFolder: String;
begin
  Result := TPath.GetTempPath;
end;

function frGetTempFileName(ATempDir, APrefix: String): String;
var
  Path: String;
  FileName: String;
begin
  SetLength(FileName, 255);
  Path := ATempDir;
  if (Path = '') or not DirectoryExists(Path) then
    Path := frGetTemporaryFolder;
  if (Path <> '') and (Path[Length(Path)] <> '\') then
    Path := Path + '\';
  FileName := APrefix + Copy(TPath.GetRandomFileName, 2, 255);
  Result := Path + FileName;
end;

{$ENDIF}

function frGetTempFile: String;
begin
{$IFDEF FPC}
  Result := GetTempFileName(frGetTemporaryFolder, 'fc');
  // FPC does not create an empty file for us
  with TFileStream.Create(Result, fmCreate) do Free;
{$ELSE}
  Result := frGetTempFileName(frGetTemporaryFolder, 'fc');
{$ENDIF}
end;

function frSeek(AStream: TStream; AOffset: Integer; AOrigin: Word): Int64;
begin
{$IFDEF FPC}
  Result := AStream.Seek(AOffset, AOrigin);
{$ELSE}
  {$IFDEF DELPHI25}
    Result := AStream.Seek32(AOffset, TSeekOrigin(AOrigin));
  {$ELSE}
    Result := AStream.Seek(AOffset, AOrigin);
  {$ENDIF}
{$ENDIF}
end;

end.
