{*******************************************************}
{                                                       }
{                       EhLib 10.2                      }
{                   TPdfWriterEh class                  }
{                                                       }
{   Copyright (c) 2021-2022 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit PdfWritersEh;

interface

{$SCOPEDENUMS ON}

uses
  SysUtils, Classes,
  {$IFDEF FPC}
    {$IFDEF FPC_WINDOWS}
    Windows,
    {$ENDIF}
  EhLibLCL, LCLType, Generics.Collections,
  {$ELSE}
  EhLibVCL, Generics.Collections,
  {$ENDIF}
  PdfElemetsEh, PdfDocumentsEh;

type

{ TPdfWriterEh }

  TPdfWriterEh = class(TObject)
  private
    FDocument: TPdfDocumentEh;
    FStream: TStream;
    FStartXRefPos: Int64;
    FDictionaryLevel: Integer;
  protected
    procedure WriteHeader;
    procedure WriteTrailer;
    procedure WriteBody;
    procedure WriteCrossReferenceTable;
    procedure WriteStartXRef;
    procedure WriteEOF;

    procedure WriteStr(Str: String);
    procedure WriteAnsiStr(AnsiStr: AnsiString);
    procedure WriteLineStr(Str: String);
    procedure WriteLineFeed;
    procedure WriteObjectOrRef(AnObject: TPdfObjectEh; out LineFeeded: Boolean); overload;
    procedure WriteObjectOrRef(AnObject: TPdfObjectEh); overload;
    procedure WriteObjectContent(AnObject: TPdfObjectEh);
    procedure CheckWriteObjectDictionaryStream(AnObject: TPdfObjectEh);

    procedure WritePdfIntegerNumber(IntNumber: TPdfIntegerNumberEh);
    procedure WritePdfRealNumber(IntNumber: TPdfRealNumber);
    procedure WritePdfBoolean(BoolNumber: TPdfBoolean);
    procedure WritePdfName(AName: TPdfNameEh);
    procedure WritePdfString(Str: TPdfStringEh);
    procedure WritePdfArray(Arr: TPdfArrayEh);
    procedure WritePdfDictionary(Dictionary: TPdfDictionaryEh);
    procedure WritePdfIndirectObject(IndirectObject: TPdfIndirectObjectEh);
  public
    constructor Create;

    procedure WriteToStream(Document: TPdfDocumentEh; Stream: TStream);
  end;

implementation

const
  LineFeed: AnsiChar = #10;

type
  TPdfDocumentCrack = class(TPdfDocumentEh);
  TPdfIndirectObjectCrack = class(TPdfIndirectObjectEh);

{ TPdfWriter }

constructor TPdfWriterEh.Create;
begin
end;

procedure TPdfWriterEh.WriteHeader;
var
  BinarySignStr: AnsiString;
begin
  WriteLineStr('%PDF-1.4');

  BinarySignStr := '%' + AnsiChar($E2) + AnsiChar($E3) + AnsiChar($CF) + AnsiChar($D3);
  WriteAnsiStr(BinarySignStr);
  WriteLineFeed;

  WriteLineStr('%EhLib version: ' +  EhLibVerInfo + ' ' + EhLibBuildInfo);
  WriteLineStr('%File creation date: ' + FormatDateTime('YYYY-MM-DD MM:NN:SS', Now));
end;

procedure TPdfWriterEh.WriteBody;
var
  Elem: TPdfIndirectObjectEh;
  ObtList: TPdfIndirectObjectListEh;
  I :Integer;
begin
  ObtList := TPdfDocumentCrack(FDocument).IndirectObjectList;

  if ObtList.Count = 0 then Exit;

  for I := 0 to ObtList.Count - 1 do
  begin
    Elem := ObtList[I];
    Elem.PrepareForExport;
    TPdfIndirectObjectCrack(Elem).FStreamPos := FStream.Position;

    WriteStr(IntToStr(Elem.ObjectID) + ' 0 obj');
    WriteLineStr('     %' + Elem.ClassName);
    WriteObjectContent(Elem.ContentObject);
    CheckWriteObjectDictionaryStream(Elem);
    WriteLineStr('endobj');
    WriteLineFeed;
  end;
end;

procedure TPdfWriterEh.WriteTrailer;
begin
  WriteLineStr('trailer');
  TPdfDocumentCrack(FDocument).Trailer.PrepareForExport;
  WritePdfDictionary(TPdfDocumentCrack(FDocument).Trailer);
end;

procedure TPdfWriterEh.WriteCrossReferenceTable;
var
  Elem: TPdfIndirectObjectEh;
  ObtList: TPdfIndirectObjectListEh;
  s: String;
begin
  FStartXRefPos := FStream.Position;
  ObtList := TPdfDocumentCrack(FDocument).IndirectObjectList;

  WriteLineStr('xref');

  s := IntToStr(ObtList.Count + 1);
  WriteLineStr('0 ' + s);
  WriteLineStr('0000000000 65535 f ');

  for Elem in ObtList do
  begin
    s := FormatFloat('0000000000', TPdfIndirectObjectCrack(Elem).FStreamPos);
    WriteLineStr(s + ' 00000 n ');
  end;
end;

procedure TPdfWriterEh.WriteStartXRef;
begin
  WriteLineStr('startxref');
  WriteLineStr(IntToStr(FStartXRefPos));
end;

procedure TPdfWriterEh.WriteEOF;
begin
  WriteLineStr('%%EOF');
end;

procedure TPdfWriterEh.WriteObjectOrRef(AnObject: TPdfObjectEh);
var
  LineFeeded: Boolean;
begin
  WriteObjectOrRef(AnObject, LineFeeded);
end;

procedure TPdfWriterEh.WriteObjectOrRef(AnObject: TPdfObjectEh; out LineFeeded: Boolean);
begin
  LineFeeded := False;
  if (AnObject is TPdfNameEh) then
  begin
    AnObject.PrepareForExport;
    WritePdfName(TPdfNameEh(AnObject));
  end
  else if (AnObject is TPdfStringEh) then
  begin
    AnObject.PrepareForExport;
    WritePdfString(TPdfStringEh(AnObject));
  end
  else if (AnObject is TPdfIntegerNumberEh) then
  begin
    AnObject.PrepareForExport;
    WritePdfIntegerNumber(TPdfIntegerNumberEh(AnObject))
  end
  else if (AnObject is TPdfRealNumber) then
  begin
    AnObject.PrepareForExport;
    WritePdfRealNumber(TPdfRealNumber(AnObject))
  end
  else if (AnObject is TPdfBoolean) then
  begin
    AnObject.PrepareForExport;
    WritePdfBoolean(TPdfBoolean(AnObject))
  end
  else if (AnObject is TPdfArrayEh) then
  begin
    AnObject.PrepareForExport;
    WritePdfArray(TPdfArrayEh(AnObject));
  end
  else if (AnObject is TPdfDictionaryEh) then
  begin
    FDictionaryLevel := FDictionaryLevel + 1;
    WritePdfDictionary(TPdfDictionaryEh(AnObject));
    FDictionaryLevel := FDictionaryLevel - 1;
    LineFeeded := True;
  end
  else if (AnObject is TPdfIndirectObjectEh) then
  begin
    WritePdfIndirectObject(TPdfIndirectObjectEh(AnObject));
  end;
end;

procedure TPdfWriterEh.WriteObjectContent(AnObject: TPdfObjectEh);
begin
  AnObject.PrepareForExport;
  if (AnObject is TPdfArrayEh) then
  begin
    WritePdfArray(TPdfArrayEh(AnObject))
  end else if (AnObject is TPdfDictionaryEh) then
  begin
    WritePdfDictionary(TPdfDictionaryEh(AnObject));
  end;
end;

procedure TPdfWriterEh.CheckWriteObjectDictionaryStream(AnObject: TPdfObjectEh);
var
  DicObject: TPdfIdrectDictionaryObjectEh;
begin
  DicObject := AnObject as TPdfIdrectDictionaryObjectEh;
  if (DicObject <> nil) and (DicObject.BoundStream <> nil) then
  begin
    WriteLineStr('stream');
    DicObject.BoundStream.WriteToGeneralStream(FStream);
    WriteLineFeed;
    WriteLineStr('endstream');
  end;
end;

procedure TPdfWriterEh.WritePdfDictionary(Dictionary: TPdfDictionaryEh);
var
  MyElem: TPair<String, TPdfObjectEh>;
  Indent: String;
  LineFeeded: Boolean;
begin
  if Dictionary.Items.Count = 0 then Exit;

  if (FDictionaryLevel > 0) then
  begin
    WriteLineFeed;
    Indent := StringOfChar(' ', FDictionaryLevel * 2)
  end else
    Indent := '';

  WriteLineStr(Indent + '<<');
  for MyElem in Dictionary.Items do
  begin
    WriteStr(Indent + '  ');
    WriteStr(MyElem.Key);
    WriteStr(' ');
    WriteObjectOrRef(MyElem.Value, LineFeeded);
    if not LineFeeded then
      WriteLineFeed;
  end;
  WriteLineStr(Indent + '>>');
end;

procedure TPdfWriterEh.WriteLineStr(Str: String);
begin
  WriteStr(Str);
  WriteLineFeed;
end;

procedure TPdfWriterEh.WritePdfArray(Arr: TPdfArrayEh);
var
  MyElem: TPdfObjectEh;
  NoFirst: Boolean;
begin
  //if Arr.Items.Count = 0 then Exit;
  NoFirst := False;

  WriteStr('[');
  for MyElem in Arr.Items do
  begin
    if NoFirst then WriteStr(' ');
    WriteObjectOrRef(MyElem);
    NoFirst := True;
  end;
  WriteStr(']');
end;

procedure TPdfWriterEh.WritePdfName(AName: TPdfNameEh);
begin
  WriteStr(String(AName.Value));
end;

procedure TPdfWriterEh.WritePdfString(Str: TPdfStringEh);
begin
  if Str.StringType = TPdfStringType.Hexadecimal then
  begin
    WriteStr('<');
    WriteStr(String(Str.Value));
    WriteStr('>');
  end else
  begin
    WriteStr('(');
    WriteStr(String(Str.Value));
    WriteStr(')');
  end;
end;

procedure TPdfWriterEh.WritePdfIntegerNumber(IntNumber: TPdfIntegerNumberEh);
begin
  WriteStr(IntToStr(IntNumber.Value));
end;

procedure TPdfWriterEh.WritePdfRealNumber(IntNumber: TPdfRealNumber);
begin
  WriteStr(SysFloatToStr(IntNumber.Value));
end;

procedure TPdfWriterEh.WritePdfBoolean(BoolNumber: TPdfBoolean);
begin
  if BoolNumber.Value = True then
    WriteStr('true')
  else
    WriteStr('false');
end;

procedure TPdfWriterEh.WritePdfIndirectObject(IndirectObject: TPdfIndirectObjectEh);
begin
  WriteStr(IntToStr(IndirectObject.ObjectID) + ' 0 R');
end;

procedure TPdfWriterEh.WriteLineFeed;
begin
  FStream.Write(LineFeed, 1);
end;

procedure TPdfWriterEh.WriteStr(Str: String);
begin
  WriteAnsiStr(AnsiString(Str));
end;

procedure TPdfWriterEh.WriteAnsiStr(AnsiStr: AnsiString);
begin
  if (Length(AnsiStr) = 0) then Exit;
  FStream.Write(AnsiStr[1], Length(AnsiStr));
end;

procedure TPdfWriterEh.WriteToStream(Document: TPdfDocumentEh; Stream: TStream);
begin
  FDocument := Document;
  FStream := Stream;
  WriteHeader;
  WriteLineFeed;

  WriteBody;
  WriteCrossReferenceTable;
  WriteTrailer;
  WriteStartXref;
  WriteEOF;
end;

end.
