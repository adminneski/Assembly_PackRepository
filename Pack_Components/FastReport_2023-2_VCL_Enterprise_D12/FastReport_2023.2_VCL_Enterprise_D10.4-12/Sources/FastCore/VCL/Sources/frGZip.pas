{******************************************}
{                                          }
{          FastReport VCL/FMX/LCL          }
{              Core Library                }
{         GZIP compress/decompress         }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{             Fast Reports, Inc.           }
{                                          }
{******************************************}

{$IFNDEF FMX}
unit frGZip;
{$ENDIF}

interface

{$I frVer.inc}

uses
{$IFNDEF FMX}
  {$IFDEF FPC}
    frZLib,
  {$ELSE}
    ZLib,
  {$ENDIF}
  Classes, SysUtils, frCore;
{$ELSE}
  System.Classes, System.SysUtils, FMX.frCore, ZLib;
{$ENDIF}


type
  /// <summary>
  ///   The compression level.
  /// </summary>
  TfrCompressionLevel = (gzNone, gzFastest, gzDefault, gzMax);

/// <summary>
///   Method compresses the Source stream and saves compressed data to the Dest
///   stream. gzip algorithm is used for compression. Optional parameter
///   FileName is used to store the file name into gzip header.
/// </summary>
/// <param name="Source">
///   Source stream
/// </param>
/// <param name="Dest">
///   Destination stream
/// </param>
/// <param name="Compression">
///   Compression level
/// </param>
/// <param name="FileNameW">
///   Used to store the file name into gzip header
/// </param>
procedure frCompressStream(Source, Dest: TStream;
  Compression: TfrCompressionLevel = gzDefault; {$IFDEF DELPHI12}FileNameW{$ELSE}FileName{$ENDIF}: String = '');
/// <summary>
///   Method decompresses the Source stream and saves uncompressed data to the
///   Dest stream. It returns the file name from gzip header.
/// </summary>
/// <param name="Source">
///   Source stream
/// </param>
/// <param name="Dest">
///   Destination stream
/// </param>
function frDecompressStream(Source, Dest: TStream): AnsiString;
/// <summary>
///   Method compresses the Source stream and saves compressed data to the Dest
///   stream. Deflate algorithm is used for compression.
/// </summary>
/// <param name="Source">
///   Source stream
/// </param>
/// <param name="Dest">
///   Destination stream
/// </param>
/// <param name="Compression">
///   Compression level
/// </param>
procedure frDeflateStream(Source, Dest: TStream;
  Compression: TfrCompressionLevel = gzDefault);
/// <summary>
///   Method decompresses the Source stream and saves uncompressed data to the
///   Dest stream. Inflate algorithm is used for decompression.
/// </summary>
/// <param name="Source">
///   Source stream
/// </param>
/// <param name="Dest">
///   Destination stream
/// </param>
procedure frInflateStream(Source, Dest: TStream);

implementation

procedure frCompressStream(Source, Dest: TStream;
  Compression: TfrCompressionLevel = gzDefault; {$IFDEF DELPHI12}FileNameW{$ELSE}FileName{$ENDIF}: String = '');
var
  header: array [0..3] of Byte;
  Compressor: TZCompressionStream;
  Size: Cardinal;
  CRC: Cardinal;
  {$IFDEF DELPHI12}
  FileName: AnsiString;
  {$ENDIF}
begin
  CRC := frCRC32(Source);
  Size := Source.Size;
  {$IFDEF DELPHI12}
  FileName := AnsiString(FileNameW);
  {$ENDIF}
  if FileName = '' then
    FileName := '1';
  FileName := FileName + #0;

  // put gzip header
  header[0] := $1f; // ID1 (IDentification 1)
  header[1] := $8b; // ID2 (IDentification 2)
  header[2] := $8;  // CM (Compression Method) CM = 8 denotes the "deflate"
  header[3] := $8;  // FLG (FLaGs) bit 3   FNAME
  Dest.Write(header, 4);

  // reserve 4 bytes in MTIME field
  Dest.Write(header, 4);

  header[0] := 0; // XFL (eXtra FLags) XFL = 2 - compressor used maximum compression
  header[1] := 0; // OS (Operating System) 0 - FAT filesystem (MS-DOS, OS/2, NT/Win32)
  Dest.Write(header, 2);

  // original file name, zero-terminated
  Dest.Write(FileName[1], Length(FileName));

  // seek back to skip 2 bytes zlib header
  frSeek(Dest, -2, soFromCurrent);

  // put compressed data
  Compressor := TZCompressionStream.Create(Dest);
//  Compressor := TZCompressionStream.Create(Dest, TZCompressionLevel(Compression){$IFNDEF DELPHIVCL}{$IFDEF WIN64}, 15 {$ENDIF}{$ENDIF});
  try
    Compressor.CopyFrom(Source, 0);
  finally
    Compressor.Free;
  end;

  // get adler32 checksum
  frSeek(Dest, -4, soFromEnd);
  Dest.Read(header, 4);
  // write it to the header (to MTIME field)
  Dest.Position := 4;
  Dest.Write(header, 4);

  // restore original file name (it was corrupted by zlib header)
  frSeek(Dest, 2, soFromCurrent);
  Dest.Write(FileName[1], Length(FileName));

  // put crc32 and length
  frSeek(Dest, -4, soFromEnd);
  Dest.Write(CRC, 4);
  Dest.Write(Size, 4);
end;

function frDecompressStream(Source, Dest: TStream): AnsiString;
var
  s: AnsiString;
  header: array [0..3] of byte;
  adler32: Integer;
  FTempStream: TMemoryStream;
  UnknownPtr: Pointer;
  NewSize: Integer;
begin
  s := '';

  // read gzip header
  Source.Read(header, 4);
  if (header[0] = $1f) and (header[1] = $8b) and (header[2] = $8) then
  begin
    Source.Read(adler32, 4);
    Source.Read(header, 2);
    if (header[3] and $8) <> 0 then
    begin
      Source.Read(header, 1);
      while header[0] <> 0 do
      begin
        s := s + AnsiChar(Char(header[0]));
        Source.Read(header, 1);
      end;
    end;
  end;

  FTempStream := TMemoryStream.Create;
  try
    // put zlib header
    s := #$78#$DA;
    FTempStream.Write(s[1], 2);
    // put compressed data, skip gzip's crc32 and filelength
    FTempStream.CopyFrom(Source, Source.Size - Source.Position - 8);
    // put adler32
    FTempStream.Write(adler32, 4);

    // uncompress data and save it to the Dest
    ZDeCompress(FTempStream.Memory, FTempStream.Size, UnknownPtr, NewSize);
    Dest.Write(UnknownPtr^, NewSize);
    FreeMem(UnknownPtr, NewSize);
  finally
    FTempStream.Free;
  end;
  Result := s;
end;

procedure frDeflateStream(Source, Dest: TStream;
  Compression: TfrCompressionLevel = gzDefault);
var
  Compressor: TZCompressionStream;
begin
{$IFDEF FMX}
  Compressor := TZCompressionStream.Create(Dest, TZCompressionLevel(Compression), 15 );
{$ELSE}
  Compressor := TZCompressionStream.Create(Dest, TZCompressionLevel(Compression){$IFNDEF FPC}{$IFDEF DELPHI16}, 15 {$ENDIF}{$ENDIF});
{$ENDIF}
  try
    Compressor.CopyFrom(Source, 0);
  finally
    Compressor.Free;
  end;
end;

procedure frInflateStream(Source, Dest: TStream);
var
  FTempStream: TMemoryStream;
  UnknownPtr: Pointer;
  NewSize: Integer;
begin
  FTempStream := TMemoryStream.Create;
  try
    FTempStream.CopyFrom(Source, 0);
    // uncompress data and save it to the Dest
    ZDeCompress(FTempStream.Memory, FTempStream.Size, UnknownPtr, NewSize);
    Dest.Write(UnknownPtr^, NewSize);
    FreeMem(UnknownPtr, NewSize);
  finally
    FTempStream.Free;
  end;
end;

end.
