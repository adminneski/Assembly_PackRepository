
{******************************************}
{                                          }
{             FastReport VCL               }
{        Open Document Format export       }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxExportODF;

interface

{$I frx.inc}

uses
{$IFNDEF FPC}
  Windows, Messages,
{$ELSE}
  LCLType, LCLIntf, LCLProc,fileutil,
{$ENDIF}
  SysUtils, Classes, Graphics,
  Printers, frxClass, frxExportMatrix, frxProgress, frPictureGraphics,
  frXML, frxImageConverter, frxExportBaseDialog, frZip, Variants,
{$IFNDEF FPC}
  ShellAPI,
{$ENDIF}
{$IFDEF DELPHI16}
  System.UITypes,
{$ENDIF}
  frCore;

type

{$IFDEF DELPHI16}
[ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxODFExport = class(TfrxBaseDialogExportFilter)
  private
    FExportPageBreaks: Boolean;
    FExportStyles: Boolean;
    FFirstPage: Boolean;
    FMatrix: TfrxIEMatrix;
    FPageWidth: Extended;
    FPageHeight: Extended;
    FWysiwyg: Boolean;
    FSingleSheet: Boolean;
    FBackground: Boolean;
    FCreator: String;
    FEmptyLines: Boolean;
    FTempFolder: String;
    FZipFile: TfrZipArchive;
    FThumbImage: TBitmap;
    FProgress: TfrxProgress;
    FExportType: String;
    FLanguage: string;
    FStyleNode: TfrXMLItem;  // this node contains ODF styles
    FStyles: TList;           // List of TSpanStyle
    FCreationTime: TDateTime;
    FPictureType: TfrxPictureType;
    FRowStyleNames: TStrings;
    FPageStyle: TStringList;
    FPageIndex: Integer;
    FHelperG:TfrxCustomGraphicFormatClass;

    function  IsTerminated: Boolean;
    procedure DoOnProgress(Sender: TObject);
    function OdfPrepareString(const Str: WideString): WideString;
    function OdfGetFrameName(const FrameStyle:  TfrxFrameStyle): String;
    procedure OdfMakeHeader(const Item: TfrXMLItem);
    procedure OdfCreateMeta(const FileName: String; const Creator: String);
    procedure OdfCreateManifest(const FileName: String; const PicCount: Integer; const MValue: String);
    procedure OdfCreateMime(const FileName: String; const MValue: String);
    procedure AddNumberStyle(Item: TfrXMLItem; const StyleName, Fmt: string);
    procedure ExportBody(BodyNode: TfrXMLItem);
    procedure AddPic(Node: TfrXMLItem; Obj: TfrxIEMObject);
    procedure SplitOnTags( pNode: TfrXMLItem; obj: TfrxIEMObject; line: {$IFNDEF FPC}WideString{$ELSE}String{$ENDIF} );
    function GetHeaderText(m: TfrxIEMatrix): string;
    function GetFooterText(m: TfrxIEMatrix): string;
    procedure CreateStyles;
    function CreateRowStyle(Row: Integer; PageBreakBefore: Boolean): string;
   procedure SetPictureType(PT: TfrxPictureType);

    // Exports a row from the matrix to an ODF node.

    procedure CreateRow(Node: TfrXMLItem; Row: Integer; PageBreak: Boolean);

    // Exports a range of rows from the matrix to an ODF node
    // representing a report page.

    procedure ExportRows(PageNode: TfrXMLItem; RowFirst, RowLast, PageIndex: Integer);

    // Creates an empty ODF cell.

    procedure CreatEmptyCell(Node: TfrXMLItem);

    // Creates an adjacent empty cell.
    // Such cells are created when an object covers several
    // cells: one cell contains the object's data, the other
    // are adjacent empty cells.

    procedure CreateAdjacentCell(Node: TfrXMLItem; Columns: Integer = 1);

    // Creates an ODF cell with text or a picture.

    procedure CreateDataCell(Node: TfrXMLItem; Obj: TfrxIEMObject;
      RowsSpanned, ColsSpanned: Integer);

    //
    // Adds a named style to the ODF document
    // and returns the name of the added style.
    // If a style with the same parameters has
    // already been added, the duplicate is not
    // created.
    //

    function AddStyle(Color: TColor; Style: TFontStyles): WideString;

    // Checks whether a row in the matrix is empty.

    function IsRowEmpty(Row: Integer): Boolean;

    function BuildPageString(aPage: TfrxIEMPage): String;

  protected

    procedure ExportPage(Stream: TStream);

  public

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    class function GetDescription: String; override;
    class function ExportDialogClass: TfrxBaseExportDialogClass; override;
    class function ProcessSpaces(const s: WideString): WideString;
    class function ProcessTabs(const s: WideString): WideString;
    class function ProcessControlSymbols(const s: WideString): WideString;

    function Start: Boolean; override;
    procedure Finish; override;
    procedure FinishPage(Page: TfrxReportPage; Index: Integer); override;
    procedure StartPage(Page: TfrxReportPage; Index: Integer); override;
    procedure ExportObject(Obj: TfrxComponent); override;

    property ExportType: String read FExportType write FExportType;
    property ExportTitle;

  published
    property PictureType: TfrxPictureType read FPictureType write SetPictureType;
    property ExportStyles: Boolean read FExportStyles write FExportStyles default True;
    property ExportPageBreaks: Boolean read FExportPageBreaks write FExportPageBreaks default True;
    property OpenAfterExport;
    property Wysiwyg: Boolean read FWysiwyg write FWysiwyg default True;
    property Background: Boolean read FBackground write FBackground default False;
    property Creator: String read FCreator write FCreator;
    property CreationTime: TDateTime read FCreationTime write FCreationTime;
    property EmptyLines: Boolean read FEmptyLines write FEmptyLines default True;
    property SingleSheet: Boolean read FSingleSheet write FSingleSheet default True;
    property Language: string read FLanguage write FLanguage; {default 'en'}
    property SuppressPageHeadersFooters;
    property OverwritePrompt;
  end;

{$IFDEF DELPHI16}
[ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxODSExport = class(TfrxODFExport)
  public
    constructor Create(AOwner: TComponent); override;
    class function GetDescription: String; override;
    property ExportTitle;
  published
    property ExportStyles;
    property ExportPageBreaks;
    property ShowProgress;
    property Wysiwyg;
    property Background;
    property Creator;
    property EmptyLines;
    property SuppressPageHeadersFooters;
    property OverwritePrompt;
    property PictureType;
  end;

{$IFDEF DELPHI16}
[ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxODTExport = class(TfrxODFExport)
  public
    constructor Create(AOwner: TComponent); override;
    class function GetDescription: String; override;
  published
    property ExportStyles;
    property ExportPageBreaks;
    property ShowProgress;
    property Wysiwyg;
    property Background;
    property Creator;
    property EmptyLines;
    property SuppressPageHeadersFooters;
    property OverwritePrompt;
    property PictureType;
  end;

implementation

uses
  frxUtils,
  frxFileUtils,
  frUnicodeUtils,
  frxRes,
  frxOfficeOpen,
  frxGraphicUtils,
  frxExportODFDialog;

const
  odfDivider = 38.5;
  odfPageDiv = 37.8;
  odfMargDiv = 10;
  odfHeaderSize = 20;
  odfRep = 'urn:oasis:names:tc:opendocument:xmlns:';

var
  odfXMLHeader: array[0..odfHeaderSize - 1] of array [0..1] of String = (
  ('xmlns:office', odfRep + 'office:1.0'),
  ('xmlns:style', odfRep + 'style:1.0'),
  ('xmlns:text', odfRep + 'text:1.0'),
  ('xmlns:table', odfRep + 'table:1.0'),
  ('xmlns:draw', odfRep + 'drawing:1.0'),
  ('xmlns:fo', odfRep + 'xsl-fo-compatible:1.0'),
  ('xmlns:xlink', 'http://www.w3.org/1999/xlink'),
  ('xmlns:dc', 'http://purl.org/dc/elements/1.1/'),
  ('xmlns:meta', odfRep + 'meta:1.0'),
  ('xmlns:number', odfRep + 'datastyle:1.0'),
  ('xmlns:svg', odfRep + 'svg-compatible:1.0'),
  ('xmlns:chart', odfRep + 'chart:1.0'),
  ('xmlns:dr3d', odfRep + 'dr3d:1.0'),
  ('xmlns:math', 'http://www.w3.org/1998/Math/MathML'),
  ('xmlns:form', odfRep + 'form:1.0'),
  ('xmlns:script', odfRep + 'script:1.0'),
  ('xmlns:dom', 'http://www.w3.org/2001/xml-events'),
  ('xmlns:xforms', 'http://www.w3.org/2002/xforms'),
  ('xmlns:xsd', 'http://www.w3.org/2001/XMLSchema'),
  ('xmlns:xsi', 'http://www.w3.org/2001/XMLSchema-instance'));

type
  TSpanStyle = class
  public
    Color:    TColor;
    Style:    TFontStyles;
    Name:     WideString;
  end;

  TAnsiCharSet = set of AnsiChar;

function FilterStr(const Src: string; const Chars: TAnsiCharSet): string;
var
  i: Integer;
begin
  Result := '';

  for i := 1 to Length(Src) do
    if AnsiChar(Src[i]) in Chars then
      Result := Result + Src[i];
end;

{ TfrxODFExport }

constructor TfrxODFExport.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FExportPageBreaks := True;
  FExportStyles := True;
  FWysiwyg := True;
  FBackground := True;
  FCreator := 'FastReport';
  FEmptyLines := True;
  FThumbImage := TBitmap.Create;
  FLanguage := 'en';
  FRowStyleNames := TStringList.Create;
  FPageStyle := TStringList.Create;
  FPageStyle.Sorted := True;
  TStringList(FRowStyleNames).Sorted := True;
  FSingleSheet := True;
end;

procedure TfrxODFExport.SetPictureType(PT: TfrxPictureType);
begin
  FPictureType := PT;
end;

procedure TfrxODFExport.AddNumberStyle(Item: TfrXMLItem; const StyleName, Fmt: string);
var
  DecSep, PercentPos: Integer;
  DecPlaces, Grouping: string;
begin
  DecSep := Pos('.', Fmt);
  PercentPos := Pos('%', Fmt);
  Grouping := Copy(Fmt, length(Fmt), 1);

  if DecSep = 0 then
    DecPlaces := '0'
  else
    begin
      if PercentPos > 0 then
        DecPlaces := FilterStr(Copy(Fmt, DecSep, Length(Fmt)), ['0'..'9'])
      else
        DecPlaces := FilterStr(Copy(Fmt, DecSep, Length(Fmt)), ['0'..'9', '#'])
    end;

  if DecPlaces = '' then
    DecPlaces := '0';

  with Item do
  begin
    Name := 'number:number-style';

    Prop['style:name'] := StyleName;

    with Add do
    begin
      Name := 'number:number';

      if PercentPos > 0 then
        Prop['number:decimal-places'] := DecPlaces
      else
        Prop['number:decimal-places'] := IntToStr(Length(DecPlaces));
      Prop['number:min-integer-digits'] := '1';
      if (Grouping = 'm') or (Grouping = 'n') then
        Prop['number:grouping'] := 'true';
    end;
  end;
end;

class function TfrxODFExport.GetDescription: String;
begin
  Result := '';
end;

procedure TfrxODFExport.OdfCreateMeta(const FileName: String; const Creator: String);
var
  XML: TfrXMLDocument;
  f: TStream;
begin
  XML := TfrXMLDocument.Create;
  f := IOTransport.TempFilter.GetStream(FileName);
  try
    XML.AutoIndent := True;
    XML.Root.Name := 'office:document-meta';
    XML.Root.Prop['xmlns:office'] := 'urn:oasis:names:tc:opendocument:xmlns:office:1.0';
    XML.Root.Prop['xmlns:xlink'] := 'http://www.w3.org/1999/xlink';
    XML.Root.Prop['xmlns:dc'] := 'http://purl.org/dc/elements/1.1/';
    XML.Root.Prop['xmlns:meta'] := 'urn:oasis:names:tc:opendocument:xmlns:meta:1.0';
    with XML.Root.Add do
    begin
      Name := 'office:meta';
      with Add do
      begin
        Name := 'meta:generator';
        {$IFNDEF EXPORT_TEST}
        Value := 'fast-report.com/Fast Report/build:' + FR_VERSION;
        {$ELSE}
        Value := 'fast-report.com/Fast Report/build: 0';
        {$ENDIF}
      end;
      with Add do
      begin
        Name := 'meta:initial-creator';
        Value := string({$IFNDEF FPC}UTF8Encode{$ENDIF}(Creator));
      end;
      with Add do
      begin
        Name := 'meta:creation-date';
        {$IfDef EXPORT_TEST}
        CreationTime := 1.1;
        {$EndIf}
        Value := FormatDateTime('YYYY-MM-DD', CreationTime) + 'T' +
          FormatDateTime('HH:MM:SS', CreationTime);
      end;
    end;
    if not IOTransport.TempFilter.DoFilterProcessStream(f, Self) then
      XML.SaveToStream(f);
  finally
    IOTransport.TempFilter.FreeStream(f);
    XML.Free;
  end;
end;

procedure TfrxODFExport.OdfCreateMime(const FileName: String; const MValue: String);
var
  f: TStream;
  s: AnsiString;
begin
  f := IOTransport.TempFilter.GetStream(FileName);
  try
    if not IOTransport.TempFilter.DoFilterProcessStream(f, Self) then
    begin
      s := AnsiString('application/vnd.oasis.opendocument.' + MValue);
      f.Write(s[1], Length(s));
    end;
  finally
    IOTransport.TempFilter.FreeStream(f);
  end;
end;

procedure TfrxODFExport.OdfCreateManifest(const FileName: String; const PicCount: Integer; const MValue: String);
var
  XML: TfrXMLDocument;
  i: Integer;
  Fmime, s: String;
  f: TStream;
begin
  XML := TfrXMLDocument.Create;
  f := IOTransport.TempFilter.GetStream(FileName);
  try
    XML.AutoIndent := True;
    XML.Root.Name := 'manifest:manifest';
    XML.Root.Prop['xmlns:manifest'] := 'urn:oasis:names:tc:opendocument:xmlns:manifest:1.0';
    with XML.Root.Add do
    begin
      Name := 'manifest:file-entry';
      Prop['manifest:media-type'] := 'application/vnd.oasis.opendocument.' + MValue;
      Prop['manifest:full-path'] := '/';
    end;
    with XML.Root.Add do
    begin
      Name := 'manifest:file-entry';
      Prop['manifest:media-type'] := 'text/xml';
      Prop['manifest:full-path'] := 'content.xml';
    end;
    with XML.Root.Add do
    begin
      Name := 'manifest:file-entry';
      Prop['manifest:media-type'] := 'text/xml';
      Prop['manifest:full-path'] := 'styles.xml';
    end;
    with XML.Root.Add do
    begin
      Name := 'manifest:file-entry';
      Prop['manifest:media-type'] := 'text/xml';
      Prop['manifest:full-path'] := 'meta.xml';
    end;
    s := '.' + GetPicFileExtension(PictureType);
    FMime := GetFileMIMEType(s);
    for i := 1 to PicCount do
      with XML.Root.Add do
      begin
        Name := 'manifest:file-entry';
        Prop['manifest:media-type'] := FMime;
        Prop['manifest:full-path'] := 'Pictures/Pic' + IntToStr(i) + s;
      end;
    if not IOTransport.TempFilter.DoFilterProcessStream(f, Self) then
      XML.SaveToStream(f);
  finally
    IOTransport.TempFilter.FreeStream(f);
    XML.Free;
  end;
end;

function TfrxODFExport.OdfPrepareString(const Str: WideString): WideString;
var
  i: Integer;
  s: WideString;
begin
  Result := '';
  s := Str;
  if Copy(s, Length(s) - 1, 4) = sLineBreak then
    Delete(s, Length(s) - 1, 4);
  for i := 1 to Length(s) do
  begin
    if s[i] = '&' then
      Result := Result + '&amp;'
    else
    if s[i] = '"' then
      Result := Result + '&quot;'
    else if s[i] = '<' then
      Result := Result + '&lt;'
    else if s[i] = '>' then
      Result := Result + '&gt;'
    else if (s[i] <> #10) then
      Result := Result + s[i]
  end;
end;

class function TfrxODFExport.ProcessSpaces(const s: WideString): WideString;

  function Ch(i: Integer): WideChar;
  begin
    if (i > 0) and (i <= Length(s)) then
      Result := s[i]
    else
      Result := #0;
  end;

  function Ts(n: Integer): WideString;
  begin
    if n = 1 then
      Result := '<text:s/>'
    else
      Result := '<text:s text:c="' + IntToStr(n) + '"/>';
  end;

const
  Space: WideChar = ' ';
var
  f, i: Integer;
begin
  if s = '' then
  begin
    Result := '';
    Exit;
  end;

  f := 1;
  Result := '';

  for i := 1 to Length(s) do
    if (s[f] = Space) <> (s[i] = Space) then
      if s[f] = Space then
      begin
        Result := Result + Ts(i - f);
        f := i;
      end
      else if (i > 0) and (s[i - 1] = Space) or (i = Length(s)) then
      begin
        Result := Result + Copy(s, f, i - f);
        f := i;
      end;

  i := Length(s) + 1;

  if s[f] = Space then
    Result := Result + Ts(i - f)
  else
    Result := Result + Copy(s, f, i - f);
end;

class function TfrxODFExport.ProcessTabs(const s: WideString): WideString;
begin
  Result := StringReplace(s, #9, '<text:tab/>', [rfReplaceAll]);
end;

class function TfrxODFExport.ProcessControlSymbols(const s: WideString): WideString;
var
  i, j: Integer;
begin
  SetLength(Result, Length(s));
  i := 0;

  for j := 1 to Length(s) do
    if Ord(s[j]) > 31 then
    begin
      i := i + 1;
      Result[i] := s[j];
    end;

  SetLength(Result, i);
end;

function TfrxODFExport.OdfGetFrameName(const FrameStyle:  TfrxFrameStyle): String;
begin
  if FrameStyle = fsDouble then
    Result := 'double'
  else
    Result := 'solid';
end;

procedure TfrxODFExport.OdfMakeHeader(const Item: TfrXMLItem);
var
  i: Integer;
begin
  for i := 0 to odfHeaderSize - 1 do
    Item.Prop[odfXMLHeader[i][0]] := odfXMLHeader[i][1];
end;

procedure TfrxODFExport.CreatEmptyCell(Node: TfrXMLItem);
begin
  Node.Name := 'table:table-cell';
end;

procedure TfrxODFExport.CreateAdjacentCell(Node: TfrXMLItem; Columns: Integer = 1);
begin
  Node.Name := 'table:covered-table-cell';
  Node.Prop['table:style-name'] := 'ceb';

  if Columns > 1 then
    Node.Prop['table:number-columns-repeated'] := IntToStr(Columns);
end;

procedure TfrxODFExport.CreateDataCell(Node: TfrXMLItem; Obj: TfrxIEMObject;
  RowsSpanned, ColsSpanned: Integer);
var
  i, k: Integer;
  s, s2: WideString;
  LineNode: TfrXMLItem;

begin

  with Node do
  begin
    Name := 'table:table-cell';
    Prop['table:style-name'] := 'ce' + IntToStr(Obj.StyleIndex);

    if (RowsSpanned > 1) or (ColsSpanned > 1) then
    begin
      Prop['table:number-columns-spanned'] := IntToStr(ColsSpanned);
      Prop['table:number-rows-spanned'] := IntToStr(RowsSpanned);
    end;

    // text cell

    if Obj.IsText then
    begin
      with Obj.Style.DisplayFormat do
        if Kind <> fkNumeric then
        begin
          for i := 0 to Obj.Memo.Count - 1 do
          begin
{$IFNDEF DELPHI12}
  {$IFNDEF FPC}
              s := UTF8Encode(Obj.Memo[i]);
  {$ELSE}
              s := Obj.Memo[i];
  {$ENDIF}
{$ELSE}
             s := Obj.Memo[i];
{$ENDIF}
            if not Obj.HTMLTags then
            begin
              s := OdfPrepareString(s);
              s := ProcessSpaces(s);
              s := ProcessTabs(s);
              s := ProcessControlSymbols(s);
            end;
            Prop['office:value-type'] := 'string';
            LineNode := Add;
            LineNode.Name := 'text:p';

            if ExportType = 'text' then
              LineNode.Prop['text:style-name'] := 'p' + IntToStr(Obj.StyleIndex);

            if (Obj.URL <> '') and (Obj.URL[1] <> '#') and (Obj.URL[1] <> '@') then
            begin
              LineNode := LineNode.Add;
              with LineNode do
              begin
                Name := 'text:a';
                Prop['xlink:href'] := Obj.URL;
              end;
            end;

            if Obj.HTMLTags then
              SplitOnTags(LineNode, Obj, s)
            else
              LineNode.Value := s;
          end;
        end
        else
        begin
          for i := 0 to Obj.Memo.Count - 1 do
          begin
{$IFNDEF DELPHI12}
  {$IFNDEF FPC}
              s := UTF8Encode(Obj.Memo[i]);
  {$ELSE}
              s := Obj.Memo[i];
  {$ENDIF}
{$ELSE}
             s := Obj.Memo[i];
{$ENDIF}
            if s <> '' then
              begin
                if not Obj.HTMLTags then
                  s := OdfPrepareString(s);
                  s2 := '';

                  s := ProcessSpaces(Trim(s));
                  s := ProcessTabs(s);
                  s := ProcessControlSymbols(s);

                  for k := 1 to Length(s) do
                    if AnsiChar(s[k]) in ['0'..'9', '-'] then
                      s2 := s2 + s[k]
                    else
{$IFDEF DELPHI16}
                      if (Char(s[k]) = FormatSettings.DecimalSeparator) or (s[k] = DecimalSeparator) then
                        s2 := s2 + FormatSettings.DecimalSeparator;
{$ELSE}
                      if (Char(s[k]) = SysUtils.DecimalSeparator) or (s[k] = DecimalSeparator) then
                        s2 := s2 + SysUtils.DecimalSeparator;
{$ENDIF}


                  Prop['office:value-type'] := 'float';

        {$IFDEF DELPHI16}
                  Prop['office:value'] := string(UTF8Encode(
                      StringReplace(s2, FormatSettings.DecimalSeparator, '.', [rfReplaceAll])));
        {$ELSE}
                  Prop['office:value'] := string({$IFNDEF FPC}UTF8Encode{$ENDIF}(
                      StringReplace(s2, SysUtils.DecimalSeparator, '.', [rfReplaceAll])));
        {$ENDIF}

        {$IFNDEF FPC}
                  s := WideString(UTF8Encode(s));
        {$ENDIF}

                  with Add do
                  begin
                    Name := 'text:p';
                    Value := s;

                    if ExportType = 'text' then
                      Prop['text:style-name'] := 'p' + IntToStr(Obj.StyleIndex);
                  end;
              end;
          end;
        end;
    end

    // picture cell

    else if (Obj.Image <> nil) and (Obj.Image.Width > 0) then
      if FExportType <> 'text' then
        AddPic(Add, Obj)
      else
        with Add do
        begin
          Name := 'text:p';
          AddPic(Add, Obj);
        end
  end;
end;

procedure TfrxODFExport.CreateRow(Node: TfrXMLItem; Row: Integer; PageBreak: Boolean);
var
  x: Integer;
  Obj: TfrxIEMObject;
  fx, fy, dx, dy: Integer;
  acn: Integer; // number of consequent adjacent cells

  procedure FlushAdjacentCells();
  begin
    if acn > 0 then
    begin
      CreateAdjacentCell(Node.Add, acn);
      acn := 0;
    end;
  end;

begin
  Node.Name := 'table:table-row';
  Node.Prop['table:style-name'] := CreateRowStyle(Row, PageBreak);

  acn := 0;

  for x := 0 to FMatrix.Width - 2 do
  begin
    Obj := FMatrix.GetObject(x, Row);

    // empty cell

    if Obj = nil then
    begin
      FlushAdjacentCells;
      CreatEmptyCell(Node.Add);
    end

    // cell belonging to an already visited object

    else if Obj.Counter <> 0 then
      Inc(acn)

    // cell that's not been visited before

    else
    begin
      FlushAdjacentCells;
      Obj.Counter := 1;
      FMatrix.GetObjectPos(FMatrix.GetCell(x, Row), fx, fy, dx, dy);
      CreateDataCell(Node.Add, Obj, dy, dx);
    end;
  end;

  FlushAdjacentCells;
end;

function TfrxODFExport.CreateRowStyle(Row: Integer; PageBreakBefore: Boolean): string;
var
  Height: Extended;
begin
  Height := (FMatrix.GetYPosById(Row + 1) - FMatrix.GetYPosById(Row)) / odfDivider;
  Result := 'ro' + frFloat2Str(Height, 3);

  if PageBreakBefore then
    Result := Result + 'b';

  if FRowStyleNames.IndexOf(Result) >= 0 then
    Exit;

  FRowStyleNames.Add(Result);

  with FStyleNode.Add do
  begin
    Name := 'style:style';

    Prop['style:name'] := Result;
    Prop['style:family'] := 'table-row';

    with Add do
    begin
      Name := 'style:table-row-properties';

      if PageBreakBefore then
        Prop['fo:break-before'] := 'page'
      else
        Prop['fo:break-before'] := 'auto';

      Prop['style:row-height'] := frFloat2Str(Height, 3) + 'cm';
    end;
  end;
end;

procedure TfrxODFExport.AddPic(Node: TfrXMLItem; Obj: TfrxIEMObject);
var
  s: string;
  r: TfrxRect;
begin
  r := FMatrix.GetObjectBounds(Obj);

  with Node do
  begin
    s := 'Pic' + IntToStr(Obj.ImageIndex) + '.' + GetPicFileExtension(PictureType);

    if not FileExists(s) then
    begin
      if (Obj.Image <> nil) and (Obj.Image.Width > 0) and (Obj.Image.Height > 0) then
        SaveGraphicAs(Obj.Image, IOTransport.TempFilter.GetStream(FTempFolder + 'Pictures\' + s), PictureType)
      else if (Obj.Image <> nil) then
        SaveGraphicAs(Obj.Image, IOTransport.TempFilter.GetStream(FTempFolder + 'Pictures\' + s), PictureType);
    end;

    Name := 'draw:frame';
    Prop['draw:z-index'] := '0';
    Prop['draw:name'] := 'Picture' + IntToStr(Obj.ImageIndex);
    Prop['draw:style-name'] := 'gr1';
    Prop['draw:text-style-name'] := 'P1';
    Prop['svg:width'] := frFloat2Str((r.Right - r.Left) / odfDivider, 3) + 'cm';
    Prop['svg:height'] := frFloat2Str((r.Bottom - r.Top) / odfDivider, 3) + 'cm';
    Prop['svg:x'] := '0cm';
    Prop['svg:y'] := '0cm';

    with Add do
    begin
      Name := 'draw:image';
      Prop['xlink:href'] := 'Pictures/' + s;
      Prop['xlink:type'] := 'simple';
      Prop['xlink:show'] := 'embed';
      Prop['text:anchor-type'] := 'frame';
      Prop['xlink:actuate'] := 'onLoad';
    end;
  end;
end;

procedure TfrxODFExport.SplitOnTags(pNode: TfrXMLItem;
  obj: TfrxIEMObject; line: {$IFNDEF FPC}WideString{$ELSE}String{$ENDIF});
var
  orig:   {$IFNDEF FPC}WideString{$ELSE}String{$ENDIF};
  sub:    {$IFNDEF FPC}WideString{$ELSE}String{$ENDIF};
  subTag: TfrxHTMLTag;

  procedure SuppressEndingTrash( var s: {$IFNDEF FPC}WideString{$ELSE}String{$ENDIF});
  var
    len: LongWord;
  begin
    if s = '' then Exit;
    len := Length(s);
    while ( len > 0 ) and ( s[len] < #32 ) do Dec(len);
    SetLength( s, len );
  end;

  procedure Reset;
  begin
    subTag := Nil;
    sub := '';
  end;

  function Empty: Boolean;
  begin
    Result := subTag = Nil;
  end;

  procedure Flush;
  var
    s: WideString;
  begin
    if sub = #0 then sub := '';
    with pNode.Add do
    begin
      Name  := 'text:span';
      s := {$IFNDEF FPC}OdfPrepareString(sub){$ELSE}sub{$ENDIF};
      s := ProcessSpaces(s);
      s := ProcessTabs(s);
      s := ProcessControlSymbols(s);
      Value := s;
      Prop['text:style-name'] := AddStyle( subTag.Color, subTag.Style );
    end;
  end;

  procedure AddTag( tag: TfrxHTMLTag );
  begin
    sub := sub + orig[tag.Position];
    subTag := tag;
  end;

  function Same( tag: TfrxHTMLTag ): Boolean;
  begin
    Result := False;
    if subTag = Nil then Exit;

    with subTag do
      Result := ( Color = tag.Color ) and ( Style = tag.Style );
  end;

var
  list:   TfrxHTMLTagsList;
  tags:   TfrxHTMLTags;
  tag:    TfrxHTMLTag;
  i, j:   LongInt;

begin
  if line = '' then Exit;

  list := TfrxHTMLTagsList.Create;
  list.AllowTags := True;

  with obj.Style.Font do
    list.SetDefaults( Color, 0, Style );

  orig := line;
  list.ExpandHTMLTags(line);

  for i := 0 to list.Count - 1 do
  begin
    tags := list[i];
    if tags.Count = 0 then Continue;
    Reset;

    for j := 0 to tags.Count - 1 do
    begin
      tag := tags[j];

      if not Empty and not Same(tag) then
      begin
        Flush;
        Reset;
      end;

      AddTag(tag);
    end;
  end;

  Flush;
  list.Destroy;
end;

function TfrxODFExport.AddStyle(Color: TColor; Style: TFontStyles): WideString;
var
  i: LongInt;
  s: TSpanStyle;
begin
  for i := 0 to FStyles.Count - 1 do
  begin
    s := TSpanStyle(FStyles[i]);
    if (s.Color = Color) and (s.Style = Style) then
    begin
      Result := s.Name;
      Exit;
    end;
  end;

  s := TSpanStyle.Create;
  FStyles.Add(s);

  s.Color := Color;
  s.Style := Style;
  s.Name  := 'ss-' + IntToStr(FStyles.Count);

  with FStyleNode.Add do
  begin
    Name := 'style:style';
    Prop['style:name'] := s.Name;
    Prop['style:family'] := 'text';

    with Add do
    begin
      Name := 'style:text-properties';
      Prop['fo:color'] := HTMLRGBColor(Color);
    end;

    if fsItalic in s.Style then
      with Add do
      begin
        Name := 'style:text-properties';
        Prop['fo:font-style'] := 'italic';
        Prop['style:font-style-asian'] := 'italic';
        Prop['style:font-style-complex'] := 'italic';
      end;

    if fsBold in s.Style then
      with Add do
      begin
        Name := 'style:text-properties';
        Prop['fo:font-weight'] := 'bold';
        Prop['style:font-weight-asian'] := 'bold';
        Prop['style:font-weight-complex'] := 'bold';
      end;

    if fsUnderline in s.Style then
      with Add do
      begin
        Name := 'style:text-properties';
        Prop['style:text-underline-style'] := 'solid';
        Prop['style:text-underline-width'] := 'auto';
        Prop['style:text-underline-color'] := 'font-color';
      end;

    // todo: struck-out text
  end;

  Result := s.Name;
end;

function TfrxODFExport.BuildPageString(aPage: TfrxIEMPage): String;
begin
  Result := frFloat2Str(aPage.LeftMargin) + frFloat2Str(aPage.TopMargin)
    + frFloat2Str(aPage.BottomMargin) + frFloat2Str(aPage.RightMargin)
    + IntToStr(Integer(aPage.Orientation)) + frFloat2Str(aPage.Width) + frFloat2Str(aPage.Height);
end;

function TfrxODFExport.GetHeaderText(m: TfrxIEMatrix): string;
var
  i: LongInt;
begin
  for i := 0 to m.GetObjectsCount - 1 do
    with m.GetObjectById(i) do
      if Header then
        Result := Result + Memo.Text;

  Result := OdfPrepareString(Result);
end;

function TfrxODFExport.IsRowEmpty(Row: Integer): Boolean;
var
  Col: Integer;
begin
  for Col := 0 to FMatrix.Width - 1 do
    if FMatrix.GetCell(Col, Row) >= 0 then
    begin
      Result := False;
      Exit;
    end;

  Result := True;
end;

function TfrxODFExport.IsTerminated: Boolean;
begin
  Result := (FProgress <> nil) and FProgress.Terminated
end;

function TfrxODFExport.GetFooterText(m: TfrxIEMatrix): string;
var
  i: LongInt;
begin
  for i := 0 to m.GetObjectsCount - 1 do
    with m.GetObjectById(i) do
      if Footer then
        Result := Result + Memo.Text;

  Result := OdfPrepareString(Result);
end;

procedure TfrxODFExport.CreateStyles;
var
  XML: TfrXMLDocument;
  f, h: string;
  fs: TStream;
  i: Integer;
  aPage: TfrxIEMPage;
begin
  f := GetFooterText(FMatrix);
  h := GetHeaderText(FMatrix);

  XML := TfrXMLDocument.Create;
  fs := IOTransport.TempFilter.GetStream(FTempFolder + 'styles.xml');
  try
    XML.AutoIndent := True;
    XML.Root.Name := 'office:document-styles';
    OdfMakeHeader(XML.Root);

    with XML.Root.Add do
    begin
      Name := 'office:styles';

      with Add do
      begin
        Name := 'style:default-style';
        Prop['style:family'] := 'paragraph';
      end;

      with Add do
      begin
        Name := 'style:paragraph-properties';

        Prop['style:text-autospace'] := 'ideograph-alpha';
        Prop['style:punctuation-wrap'] := 'hanging';
        Prop['style:line-break'] := 'strict';
        Prop['style:writing-mode'] := 'page';
      end;

      with Add do
      begin
        Name := 'style:text-properties';

        Prop['fo:color'] := '#000000';
        Prop['style:font-name'] := 'Times New Roman';
        Prop['fo:font-size'] := '12pt';
        Prop['fo:language'] := LowerCase(Language);
        Prop['fo:country'] := UpperCase(Language);
        Prop['style:font-name-asian'] := 'Arial Unicode MS';
        Prop['style:font-size-asian'] := '12pt';
        Prop['style:language-asian'] := LowerCase(Language);
        Prop['style:country-asian'] := UpperCase(Language);
        Prop['style:font-name-complex'] := 'Tahoma1';
        Prop['style:font-size-complex'] := '12pt';
        Prop['style:language-complex'] := LowerCase(Language);
        Prop['style:country-complex'] := UpperCase(Language);
      end;
    end;

    for i := 0 to FPageStyle.Count - 1 do
    begin
      aPage := TfrxIEMPage(FPageStyle.Objects[i]);
      with XML.Root.Add do
      begin
        Name := 'office:automatic-styles';

        with Add do
        begin
          Name := 'style:page-layout';
          Prop['style:name'] := 'pm' + IntToStr(i);
          with Add do
          begin
            Name := 'style:page-layout-properties';
            Prop['fo:page-width'] := frFloat2Str(aPage.Width / odfPageDiv, 1) + 'cm';
            Prop['fo:page-height'] := frFloat2Str(aPage.Height / odfPageDiv, 1) + 'cm';
            Prop['fo:margin-top'] := frFloat2Str(aPage.TopMargin / odfMargDiv, 3) + 'cm';
            Prop['fo:margin-bottom'] := frFloat2Str(aPage.BottomMargin / odfMargDiv, 3) + 'cm';
            Prop['fo:margin-left'] := frFloat2Str(aPage.LeftMargin / odfMargDiv, 3) + 'cm';
            Prop['fo:margin-right'] := frFloat2Str(aPage.RightMargin / odfMargDiv, 3) + 'cm';
          end;
        end;
      end;

      with XML.Root.Add do
      begin
        Name := 'office:master-styles';
        with Add do
        begin
          Name := 'style:master-page';
          Prop['style:name'] := 'PageDef' + IntToStr(i);
          Prop['style:page-layout-name'] := 'pm' + IntToStr(i);

          if h <> '' then
            with Add do
            begin
              Name := 'style:header';
              with Add do
              begin
                Name := 'text:p';
                Value := h;
              end;
            end;

          if f <> '' then
            with Add do
            begin
              Name := 'style:footer';
              with Add do
              begin
                Name := 'text:p';
                Value := f;
              end;
            end;
        end;
      end;
    end;
    if not IOTransport.TempFilter.DoFilterProcessStream(fs, Self) then
      XML.SaveToStream(fs);
  finally
    IOTransport.TempFilter.FreeStream(fs);
    XML.Free;
  end;
end;

procedure SaveImage(GraphicHelper: TfrxCustomGraphicFormatClass; IOFilter: TfrxCustomIOTransport; Img: TGraphic; DestinationFilename: string );
var
  f: TStream;
  Graphic: TGraphic;
begin
  Graphic := GraphicHelper.ConvertFrom(Img, pf24bit, 100);
  if Assigned(Graphic) then
  begin
    try
      f := IOFilter.GetStream(DestinationFilename);
      if not IOFilter.DoFilterProcessStream(f, img) then
        Graphic.SaveToStream(f);
      IOFilter.FreeStream(f);
    finally
      Graphic.Free;
    end;
  end;
end;

procedure TfrxODFExport.ExportPage(Stream: TStream);
var
  XML: TfrXMLDocument;
  s: WideString;
  str: String;
  FList: TStringList;
  i: Integer;
  Style: TfrxIEMStyle;
  d, MaxW: Extended;
  f: TStream;
  FileNames: TStrings;

  function BorderProp( fl: TfrxFrameLine ) : string;
  begin
    Result := frFloat2Str(fl.Width / odfDivider, 3) + 'cm ' +
      OdfGetFrameName(fl.Style) + ' ' + HTMLRGBColor(fl.Color);
  end;

begin
  if ShowProgress then
    FProgress.Execute(FMatrix.Height - 1, frxResources.Get('ProgressWait'), True, True);
  FTempFolder := IOTransport.TempFilter.BasePath;
  FTempFolder := FTempFolder + PathDelim;
  CreateDirs(IOTransport.TempFilter, ['Pictures', 'Thumbnails', 'META-INF']);

  SaveImage(FHelperG, IOTransport.TempFilter, FThumbImage, FTempFolder + 'Thumbnails\thumbnail.jpg');

  CreateStyles;

  XML := TfrXMLDocument.Create;
  f := IOTransport.TempFilter.GetStream(FTempFolder + 'content.xml');
  try
    XML.AutoIndent := False;
//    XML.AutoIndent := True;
    XML.Root.Name := 'office:document-content';
    OdfMakeHeader(XML.Root);
    with XML.Root.Add do
      Name := 'office:scripts';
    // font styles
    FList := TStringList.Create;
    try
      FList.Sorted := True;
      for i := 0 to FMatrix.StylesCount - 1 do
      begin
        Style := FMatrix.GetStyleById(i);
        if (Style.Font <> nil) and (FList.IndexOf(Style.Font.Name) = -1) then
          FList.Add(Style.Font.Name);
      end;
      with XML.Root.Add do
      begin
        Name := 'office:font-face-decls';
        for i := 0 to FList.Count - 1 do
        begin
          with Add do
          begin
            Name := 'style:font-face';
            Prop['style:name'] := FList[i];
            Prop['svg:font-family'] := {'&apos;' + }FList[i]{ + '&apos;'};
            Prop['style:font-pitch'] := 'variable';
          end;
        end;
      end;
    finally
      FList.Free;
    end;

    FStyleNode := XML.Root.Add;
    FStyles := TList.Create;

    with FStyleNode do
    begin
      Name := 'office:automatic-styles';

      with Add do
      begin
        Name := 'style:style';

        Prop['style:style-name'] := 'pagebreak';
        Prop['style:style-family'] := 'paragraph';
        Prop['style:parent-style-name'] := 'Standard';

        with Add do
        begin
          Name := 'style:paragraph-properties';
          Prop['fo:break-after'] := 'page';
        end;
      end;
      MaxW := 0;
      FList := {$IFNDEF NONWINFPC}TStringList.Create;{$ELSE}TfrxStringList.Create;{$ENDIF}
      try
        FList.Sorted := True;
        for i := 1 to FMatrix.Width - 1 do
        begin
          d := (FMatrix.GetXPosById(i) - FMatrix.GetXPosById(i - 1)) / odfDivider;
          MaxW := MaxW + d;
          s := frFloat2Str(d, 3);
          if FList.IndexOf(s) = -1 then
            FList.Add(s);
        end;

        for i := 0 to FPageStyle.Count - 1 do
          // table style
          with Add do
          begin
            Name := 'style:style';
            Str := 'PageDef' + IntToStr(i);
            Prop['style:name'] := Str + 'ta1';
            Prop['style:family'] := 'table';
            Prop['style:display-name'] := Str + 'ta1';
            Prop['style:master-page-name'] := Str;
            with Add do
            begin
              Name := 'style:table-properties';
              Prop['table:display'] := 'true';
              Prop['style:width'] := frFloat2Str(MaxW, 3) + 'cm';
              Prop['table:align'] := 'left';
              Prop['style:writing-mode'] := 'lr-tb';
              /// RTL - LTR?
            end;
          end;

        for i := 0 to FList.Count - 1 do
        begin
          with Add do
          begin
            Name := 'style:style';
            Prop['style:name'] := 'co' + FList[i];
            Prop['style:family'] := 'table-column';
            with Add do
            begin
              Name := 'style:table-column-properties';
              Prop['fo:break-before'] := 'auto';
              Prop['style:column-width'] := FList[i] + 'cm';
            end;
          end;
        end;
      finally
        FList.Free;
      end;

      FRowStyleNames.Clear;

      // cells styles
      with Add do
      begin
        Name := 'style:style';
        Prop['style:name'] := 'ceb';
        Prop['style:family'] := 'table-cell';
        Prop['style:display'] := 'false';
      end;

      for i := 0 to FMatrix.StylesCount - 1 do
      begin
        Style := FMatrix.GetStyleById(i);

        if Style.DisplayFormat.Kind = fkNumeric then
          if Style.DisplayFormat.FormatStr <> '%g' then
            AddNumberStyle(Add, 'N' + IntToStr(i), Style.DisplayFormat.FormatStr);
      end;

      for i := 0 to FMatrix.StylesCount - 1 do
      begin
        Style := FMatrix.GetStyleById(i);

        with Add do
        begin
          Name := 'style:style';
          Prop['style:name'] := 'ce' + IntToStr(i);
          Prop['style:family'] := 'table-cell';
          Prop['style:parent-style-name'] := 'Standard';

          if Style.DisplayFormat.Kind = fkNumeric then
            if Style.DisplayFormat.FormatStr <> '%g' then
              Prop['style:data-style-name'] := 'N' + IntToStr(i);

          if FExportType <> 'text' then
          begin
            with Add do
            begin
              Name := 'style:text-properties';
              Prop['style:font-name'] := Style.Font.Name;
              Prop['fo:font-size'] := IntToStr(Style.Font.Size) + 'pt';

              if fsUnderline in Style.Font.Style then
              begin
                Prop['style:text-underline-style'] := 'solid';
                Prop['style:text-underline-width'] := 'auto';
                Prop['style:text-underline-color'] := 'font-color';
              end;

              if fsItalic in Style.Font.Style then
                Prop['fo:font-style'] := 'italic';

              if fsBold in Style.Font.Style then
                Prop['fo:font-weight'] := 'bold';

              Prop['fo:color'] := HTMLRGBColor(Style.Font.Color);
            end;

            with Add do
            begin
              Name := 'style:paragraph-properties';
              if Style.Rotation = 90 then
                begin
                  if Style.VAlign = vaTop then
                    Prop['fo:text-align'] := 'start'
                  else if Style.VAlign = vaBottom then
                    Prop['fo:text-align'] := 'end'
                  else if Style.VAlign = vaCenter then
                    Prop['fo:text-align'] := 'center';
                end
              else if Style.Rotation = 270 then
                begin
                  if Style.VAlign = vaTop then
                    Prop['fo:text-align'] := 'end'
                  else if Style.VAlign = vaBottom then
                    Prop['fo:text-align'] := 'start'
                  else if Style.VAlign = vaCenter then
                    Prop['fo:text-align'] := 'center';
                end
              else
                begin
                  if Style.HAlign = haLeft then
                    Prop['fo:text-align'] := 'start'
                  else if Style.HAlign = haCenter then
                    Prop['fo:text-align'] := 'center'
                  else if Style.HAlign = haRight then
                    Prop['fo:text-align'] := 'end'
                  else if Style.HAlign = haBlock then
                    Prop['fo:text-align'] := 'start';
                end;
              if Style.GapX <> 0 then
              begin
                Prop['fo:margin-left'] := frFloat2Str(Style.GapX / odfDivider * 0.5, 3) + 'cm';
                Prop['fo:margin-right'] := Prop['fo:margin-left'];
              end;
            end;
          end;

          with Add do
          begin
            Name := 'style:table-cell-properties';

            if Style.Color = clNone then
              Prop['fo:background-color'] := 'transparent'
            else
              Prop['fo:background-color'] := HTMLRGBColor(Style.Color);

            Prop['style:repeat-content'] := 'false';
            if Style.Rotation > 0 then
            begin
              Prop['style:rotation-angle'] := IntToStr(Style.Rotation);
              Prop['style:rotation-align'] := 'none';
            end;
            if Style.Rotation = 90 then
              begin
                if Style.HAlign = haLeft then
                  Prop['style:vertical-align'] := 'bottom'
                else if Style.HAlign = haRight then
                  Prop['style:vertical-align'] := 'top'
                else if Style.HAlign = haCenter then
                  Prop['style:vertical-align'] := 'middle'
                else if Style.HAlign = haBlock then
                  Prop['style:vertical-align'] := 'bottom';
              end
            else if Style.Rotation = 270 then
              begin
                if Style.HAlign = haLeft then
                  Prop['style:vertical-align'] := 'top'
                else if Style.HAlign = haRight then
                  Prop['style:vertical-align'] := 'bottom'
                else if Style.HAlign = haCenter then
                  Prop['style:vertical-align'] := 'middle'
                else if Style.HAlign = haBlock then
                  Prop['style:vertical-align'] := 'top';
              end
            else
              begin
                if Style.VAlign = vaCenter then
                  Prop['style:vertical-align'] := 'middle'
                else if Style.VAlign = vaTop then
                  Prop['style:vertical-align'] := 'top'
                else if Style.VAlign = vaBottom then
                  Prop['style:vertical-align'] := 'bottom';
              end;
            if (ftLeft in Style.FrameTyp) then
              Prop['fo:border-left'] := BorderProp( Style.LeftLine);
            if (ftRight in Style.FrameTyp) then
              Prop['fo:border-right'] := BorderProp( Style.RightLine);
            if (ftTop in Style.FrameTyp) then
              Prop['fo:border-top'] := BorderProp( Style.TopLine);
            if (ftBottom in Style.FrameTyp) then
              Prop['fo:border-bottom'] := BorderProp( Style.BottomLine);
            if Style.WordWrap then
              Prop['fo:wrap-option'] := 'wrap';
          end;
        end;
      end;

      if FExportType = 'text' then
      begin
        // text styles
        with Add do
        begin
          Name := 'style:style';
          Prop['style:name'] := 'pb';
          Prop['style:family'] := 'paragraph';
          Prop['style:display'] := 'false';
        end;
        for i := 0 to FMatrix.StylesCount - 1 do
        begin
          Style := FMatrix.GetStyleById(i);
          with Add do
          begin
            Name := 'style:style';
            Prop['style:name'] := 'p' + IntToStr(i);
            Prop['style:family'] := 'paragraph';
            Prop['style:parent-style-name'] := 'Standard';
            with Add do
            begin
              Name := 'style:paragraph-properties';
              if Style.Rotation = 90 then
                begin
                  if Style.VAlign = vaTop then
                    Prop['fo:text-align'] := 'start'
                  else if Style.VAlign = vaBottom then
                    Prop['fo:text-align'] := 'end'
                  else if Style.VAlign = vaCenter then
                    Prop['fo:text-align'] := 'center';
                end
              else if Style.Rotation = 270 then
                begin
                  if Style.VAlign = vaTop then
                    Prop['fo:text-align'] := 'end'
                  else if Style.VAlign = vaBottom then
                    Prop['fo:text-align'] := 'start'
                  else if Style.VAlign = vaCenter then
                    Prop['fo:text-align'] := 'center';
                end
              else
                begin
                  if Style.HAlign = haLeft then
                    Prop['fo:text-align'] := 'start'
                  else if Style.HAlign = haCenter then
                    Prop['fo:text-align'] := 'center'
                  else if Style.HAlign = haRight then
                    Prop['fo:text-align'] := 'end'
                  else if Style.HAlign = haBlock then
                    Prop['fo:text-align'] := 'start';
                end;
              if Style.GapX <> 0 then
              begin
                Prop['fo:margin-left'] := frFloat2Str(Style.GapX / odfDivider * 0.5, 3) + 'cm';
                Prop['fo:margin-right'] := Prop['fo:margin-left'];
              end;
            end;
            with Add do
            begin
              Name := 'style:text-properties';
              Prop['fo:letter-spacing'] := frFloat2Str(Style.CharSpacing/96, 4) + 'in';
              Prop['style:font-name'] := Style.Font.Name;
              Prop['fo:font-size'] := IntToStr(Style.Font.Size) + 'pt';
              if fsUnderline in Style.Font.Style then
              begin
                Prop['style:text-underline-style'] := 'solid';
                Prop['style:text-underline-width'] := 'auto';
                Prop['style:text-underline-color'] := 'font-color';
              end;
              if fsItalic in Style.Font.Style then
                Prop['fo:font-style'] := 'italic';
              if fsBold in Style.Font.Style then
                Prop['fo:font-weight'] := 'bold';
              Prop['fo:color'] := HTMLRGBColor(Style.Font.Color);
              if Style.Rotation > 0 then
            begin
              Prop['style:text-rotation-angle'] := IntToStr(Style.Rotation);
              Prop['style:text-rotation-align'] := 'line-height';
            end;
            end;
          end;
        end;
      end;
      // pic style
      with Add do
      begin
        Name := 'style:style';
        Prop['style:name'] := 'gr1';
        Prop['style:family'] := 'graphic';
        with Add do
        begin
          Name := 'style:graphic-properties';
          Prop['draw:stroke'] := 'none';
          Prop['draw:fill'] := 'none';
          Prop['draw:textarea-horizontal-align'] := 'left';
          Prop['draw:textarea-vertical-align'] := 'top';
          Prop['draw:color-mode'] := 'standard';
          Prop['draw:luminance'] := '0%';
          Prop['draw:contrast'] := '0%';
          Prop['draw:gamma'] := '100%';
          Prop['draw:red'] := '0%';
          Prop['draw:green'] := '0%';
          Prop['draw:blue'] := '0%';
          Prop['fo:clip'] := 'rect(0cm 0cm 0cm 0cm)';
          Prop['draw:image-opacity'] := '100%';
          Prop['style:mirror'] := 'none';
        end;
      end;
    end;

    ExportBody(XML.Root.Add);
    if not IOTransport.TempFilter.DoFilterProcessStream(f, Self) then
      XML.SaveToStream(f);
  finally
    IOTransport.TempFilter.FreeStream(f);
    XML.Free;

    for i := 0 to FStyles.Count - 1 do
      TObject(FStyles[i]).Free;

    FStyles.Free;
  end;
  s := FExportType;
  OdfCreateManifest(FTempFolder + 'META-INF' + PathDelim + 'manifest.xml', FMatrix.GetPicturesCount, s);
  OdfCreateMime(FTempFolder + 'mimetype', s);
  OdfCreateMeta(FTempFolder + 'meta.xml', OdfPrepareString(Creator));

  FileNames := TStringList.Create;
  IOTransport.TempFilter.FilterAccess := faRead;
  IOTransport.TempFilter.LoadClosedStreams;
  FileNames.Clear;
  IOTransport.TempFilter.CopyStreamsNames(FileNames, True);

  { compress data }

  if Assigned(Stream) then
    f := Stream
  else
    try
      f := IOTransport.GetStream(FileName);
    except
      f := nil;
    end;
  if Assigned(f) then
  begin
    FZipFile := TfrZipArchive.Create;
    try
      FZipFile.RootFolder := AnsiString(FTempFolder);
      if not IOTransport.DoFilterProcessStream(f, Self) then
        FZipFile.SaveToStreamFromList(f, FileNames);
    finally
      FZipFile.Free;
    end;
  end;

  if not Assigned(Stream) then
    IOTransport.FreeStream(f);
  FileNames.Free;


//  FZipFile := TfrZipArchive.Create;
//  try
//{$IFDEF DELPHI12}
//    FZipFile.RootFolder := AnsiString(FTempFolder);
//    FZipFile.AddDir(AnsiString(FTempFolder));
//{$ELSE}
//    FZipFile.RootFolder := FTempFolder;
//    FZipFile.AddDir(FTempFolder);
//{$ENDIF}
//    if ShowProgress then
//    begin
//      FProgress.Execute(FZipFile.FileCount, frxResources.Get('ProgressWait'), True, True);
//      FZipFile.OnProgress := DoOnProgress;
//    end;
//    FZipFile.SaveToStream(Stream);
//  finally
//    FZipFile.Free;
//  end;
//  DeleteFolder(FTempFolder);
end;

function TfrxODFExport.Start: Boolean;
begin
  FThumbImage.Width := 0;
  FThumbImage.Height := 0;
  if (FileName <> '') or Assigned(Stream) then
  begin
    FFirstPage := True;

    FMatrix := TfrxIEMatrix.Create(UseFileCache, Report.EngineOptions.TempDir, Report.PictureCacheOptions.CachedImagesBuildType, CalculatePictureHash);
    FMatrix.RotatedAsImage := False;
    FMatrix.ShowProgress := ShowProgress;
    FMatrix.Background := FBackground and FEmptyLines;
    FMatrix.BackgroundImage := False;
    FMatrix.Printable := ExportNotPrintable;
    FMatrix.RichText := {$IFNDEF FPC}PictureType <> gpEMF{$ELSE}True{$ENDIF};
    FMatrix.PlainRich := {$IFNDEF FPC}PictureType <> gpEMF{$ELSE}True{$ENDIF};
    FMatrix.EmptyLines := FEmptyLines;
    FMatrix.WrapText := False;
    {$IFNDEF FPC}
    FMatrix.EMFPictures := True;
    {$ENDIF}
    FPageStyle.Clear;
    if FWysiwyg then
      FMatrix.Inaccuracy := 0.5
    else
      FMatrix.Inaccuracy := 10;
    FMatrix.DeleteHTMLTags := False;
    Result := True
  end
  else
    Result := False;
  FHelperG := GetGraphicFormats.FindByName('JPG')
end;

procedure TfrxODFExport.StartPage(Page: TfrxReportPage; Index: Integer);
begin
  if FFirstPage then
  begin
    FPageWidth := Page.Width;
    FPageHeight := Page.Height;
    FPageIndex := Index;
    FThumbImage.Width := Round(Page.Width / 5);
    FThumbImage.Height := Round(Page.Height / 5);
{$IFDEF FPC}
    FThumbImage.Canvas.Brush.Color := clWhite;
    FThumbImage.Canvas.FillRect(0, 0, FThumbImage.Width, FThumbImage.Height);
{$ENDIF}
  end;
  if SingleSheet and ((FPageWidth < Page.Width) or (FPageHeight < Page.Height)) then
    FPageIndex := Index;
end;

procedure TfrxODFExport.ExportRows(PageNode: TfrXMLItem; RowFirst, RowLast, PageIndex: Integer);
var
  x, y, Index: Integer;
  d: Extended;
  s: string;
  PageBreak: Boolean;
begin
  //DbgPrintMatrix(FMatrix, RowFirst, RowLast);

  while (RowLast >= RowFirst) and IsRowEmpty(RowLast) do
    Dec(RowLast);

  while (RowLast >= RowFirst) and IsRowEmpty(RowFirst) do
    Inc(RowFirst);

  with PageNode do
  begin
    Name := 'table:table';
    s := BuildPageString(FMatrix.IEPages[PageIndex]);
    Index := FPageStyle.IndexOf(s);
    if index = -1 then
      Index := 0;
    Prop['table:name'] := string({$IFNDEF FPC}UTF8Encode{$ENDIF}(frxGet(8322) + ' ' + IntToStr(PageIndex + 1)));
    Prop['table:style-name'] := 'PageDef' + IntToStr(Index) + 'ta1';
    Prop['table:print'] := 'false';

    for x := 0 to FMatrix.Width - 2 do
      with Add do
      begin
        Name := 'table:table-column';
        d := (FMatrix.GetXPosById(x + 1) - FMatrix.GetXPosById(x)) / odfDivider;
        s := frFloat2Str(d, 3);
        Prop['table:style-name'] := 'co' + s;
      end;

    for y := RowFirst to RowLast do
    begin
      PageBreak := ExportPageBreaks and
        (FMatrix.PagesCount > PageIndex) and
        (FMatrix.GetYPosById(y) >= FMatrix.GetPageBreak(PageIndex));

      CreateRow(Add, y, PageBreak);

      if PageBreak then
        Inc(PageIndex);
    end;
  end;
end;

procedure TfrxODFExport.ExportBody(BodyNode: TfrXMLItem);
var
  y1, y2, Page: Integer;
begin
  BodyNode.Name := 'office:body';

  with BodyNode.Add do
  begin
    if ExportType = 'text' then
    begin
      Name := 'office:text';
      Prop['text:use-soft-page-breaks'] := 'true';
    end
    else
      Name := 'office:spreadsheet';

    Page := 0;
    if SingleSheet then
      Page := FPageIndex;
    y1 := 0;

    if not SingleSheet then
      with FMatrix do
        for y2 := 0 to Height - 2 do
          if (PagesCount > Page) and (GetYPosById(y2) >= GetPageBreak(Page)) then
          begin
            ExportRows(Add, y1, y2 - 1, Page);
            y1 := y2;
            Page := Page + 1;

            if ExportPageBreaks then
              with Add do
              begin
                Name := 'text:p';
                Prop['text:style-name'] := 'pagebreak';
              end;

            DoOnProgress(Self);

            if IsTerminated then
              Break;
          end;

    if not IsTerminated then
      ExportRows(Add, y1, FMatrix.Height - 2, Page);

    DoOnProgress(Self);
  end;
end;

class function TfrxODFExport.ExportDialogClass: TfrxBaseExportDialogClass;
begin
  Result := TfrxODFExportDialog;
end;

procedure TfrxODFExport.ExportObject(Obj: TfrxComponent);
var
  Pic: TfrxPictureView;
  v: TfrxView;
begin
  { TfrxPreviewPages.Export adds a TfrxPictureView component
    to each page. This component represents the background
    picture. If the picture is not set and the background color is clNone,
    then this component may be discarded.

    The background component causes creation lots of quasi-components
    that waste memory and time, so if possible the background should be
    discarded. }

  if IsPageBG(Obj) then
    if not Background then
      Exit
    else if (Obj is TfrxPictureView) then
    begin
      Pic := TfrxPictureView(Obj);

      if (Pic.GraphicWidth * Pic.GraphicHeight = 0) and (Pic.Color = clNone) then
        Exit;
    end;

  if (Obj is TfrxView) then
  begin
    v := TfrxView(Obj);
    if vsExport in v.Visibility then
      begin
        FMatrix.AddObject(v);
        if FFirstPage then
          begin
            FThumbImage.Canvas.Lock;
            try
              v.Draw(FThumbImage.Canvas, 0.2, 0.2, v.Left / 5, v.Top / 5);
            finally
              FThumbImage.Canvas.Unlock;
            end;
          end;
      end;
  end;
end;

procedure TfrxODFExport.FinishPage(Page: TfrxReportPage; Index: Integer);
var
  s: String;
  i: Integer;
begin
  FFirstPage := False;
  FMatrix.AddPage(Page.Orientation, Page.Width, Page.Height, Page.LeftMargin,
                  Page.TopMargin, Page.RightMargin, Page.BottomMargin, Page.MirrorMargins, Index);
  i := FMatrix.GetPagesCount - 1;
  s := BuildPageString(FMatrix.IEPages[i]);
  if FPageStyle.IndexOf(s) = -1 then
    FPageStyle.AddObject(s, FMatrix.IEPages[i]);
end;

procedure TfrxODFExport.Finish;
var
  Exp: TStream;
begin
  try
    Exp := nil;
    FProgress := nil;

    try
      if ShowProgress then
        FProgress := TfrxProgress.Create(nil);

      FMatrix.Prepare;

      if Assigned(Stream) then
        Exp := Stream
      else
        Exp := IOTransport.GetStream(FileName);

      ExportPage(Exp);
    finally
      FProgress.Free;
      FMatrix.Free;

      if not Assigned(Stream) then
      begin
        IOTransport.DoFilterProcessStream(Exp, Self);
        IOTransport.FreeStream(Exp);
      end;
    end;
  except
    on e: Exception do
      case Report.EngineOptions.NewSilentMode of
        simSilent:        Report.Errors.Add(e.Message);
        simMessageBoxes:  frxErrorMsg(e.Message);
        simReThrow:       raise;
      end;
  end;
end;

destructor TfrxODFExport.Destroy;
begin
  FThumbImage.Free;
  FRowStyleNames.Free;
  FreeAndNil(FPageStyle);
  inherited;
end;

procedure TfrxODFExport.DoOnProgress(Sender: TObject);
begin
  if ShowProgress then
    FProgress.Tick;
end;

{ TfrxODSExport }

constructor TfrxODSExport.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ExportType := 'spreadsheet';
  FilterDesc := frxResources.Get('ODSExportFilter');
  DefaultExt := frxGet(8960);
  ExportTitle := frxResources.Get('ODSExport');
end;

class function TfrxODSExport.GetDescription: String;
begin
  Result := frxResources.Get('ODSExport');
end;

{ TfrxODTExport }

constructor TfrxODTExport.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ExportType := 'text';
  FilterDesc := frxResources.Get('ODTExportFilter');
  DefaultExt := frxGet(8961);
  ExportTitle := frxResources.Get('ODTExport');
end;

class function TfrxODTExport.GetDescription: String;
begin
  Result := frxResources.Get('ODTExport');
end;

end.
