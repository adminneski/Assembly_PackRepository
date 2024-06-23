
{******************************************}
{                                          }
{             FastReport VCL               }
{         GZIP compress/decompress         }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{             Fast Reports, Inc.           }
{                                          }
{******************************************}

unit frxGZip;

interface

{$I frVer.inc}

uses
  Classes, SysUtils, frGZIP, frxClass;

type
  TfrxCompressionLevel = TfrCompressionLevel;
{$IFDEF DELPHI16}
  /// <summary>
  ///   The TfrxGZipCompressor component lets you compress/decompress
  ///   FastReport files (.FR3 and .FP3). gzip algorithm is used for
  ///   compression.
  /// </summary>
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}

  TfrxGZipCompressor = class(TfrxCustomCompressor)
  public
    procedure Compress(Dest: TStream); override;
    function Decompress(Source: TStream): Boolean; override;
  end;


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
/// <param name="FileName">
///   Used to store the file name into gzip header
/// </param>
procedure frxCompressStream(Source, Dest: TStream;
  Compression: TfrxCompressionLevel = gzDefault; FileName: string = '');
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
function frxDecompressStream(Source, Dest: TStream): AnsiString;
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
procedure frxDeflateStream(Source, Dest: TStream;
  Compression: TfrxCompressionLevel = gzDefault);
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
procedure frxInflateStream(Source, Dest: TStream);


implementation

uses frxUtils;

procedure frxCompressStream(Source, Dest: TStream;
  Compression: TfrxCompressionLevel = gzDefault; FileName: String = '');
begin
  frCompressStream(Source, Dest, Compression, FileName);
end;

function frxDecompressStream(Source, Dest: TStream): AnsiString;
begin
  frDecompressStream(Source, Dest);
end;

procedure frxDeflateStream(Source, Dest: TStream;
  Compression: TfrxCompressionLevel = gzDefault);
begin
  frDeflateStream(Source, Dest, Compression);
end;

procedure frxInflateStream(Source, Dest: TStream);
begin
  frInflateStream(Source, Dest);
end;

{ TfrxGZipCompressor }

procedure TfrxGZipCompressor.Compress(Dest: TStream);
var
  Compression: TfrxCompressionLevel;
  FileName: String;
begin
  if IsFR3File then
  begin
    Compression := gzMax;
    FileName := '1.fr3';
  end
  else
  begin
    Compression := gzDefault;
    FileName := '1.fp3';
  end;
  frxCompressStream(Stream, Dest, Compression, FileName);
end;

function TfrxGZipCompressor.Decompress(Source: TStream): Boolean;
var
  Signature: array[0..1] of Byte;
begin
  Source.Read(Signature, 2);
  Source.Seek(-2, soFromCurrent);
  Result := (Signature[0] = $1F) and (Signature[1] = $8B);
  if Result then
    frxDecompressStream(Source, Stream);
  Stream.Position := 0;
end;

end.
