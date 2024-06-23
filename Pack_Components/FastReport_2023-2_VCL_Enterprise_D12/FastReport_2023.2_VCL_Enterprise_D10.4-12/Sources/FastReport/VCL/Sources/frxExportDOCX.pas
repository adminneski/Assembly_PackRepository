
{******************************************}
{                                          }
{             FastReport VCL               }
{               DOCX export                }
{                                          }
{         Copyright (c) 1998-2021          }
{                                          }
{******************************************}

unit frxExportDOCX;

interface

{$I frx.inc}

uses
{$IFNDEF FPC}
  Windows, Messages, ShellAPI,
{$ELSE}
  LCLType, LCLIntf, LazHelper,
{$ENDIF}
  SysUtils, Classes, Graphics,
  frxClass, frZip, frxExportMatrix,
  frxImageConverter, frxExportBaseDialog, frxPlatformServices, frxGraphicUtils, frxOfficeOpen
{$IFDEF DELPHI16}
, System.UITypes
{$ENDIF}
;

type
  TfrxDocxPage = record
    Width: Integer;
    Height: Integer;
    Margins: TRect;
  end;

  TExportType = (dxTable, dxObjects);  //TODO dxText

{$IFDEF DELPHI16}
[ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxDOCXExport = class(TfrxBaseDialogExportFilter)
  private
    FDocFolder: string;
    FDocument: TStream; // word/document.xml
    FDocRels: TStream; // word/_rels/document.xml.rels
    FMatrix: TfrxIEMatrix;
    FLastPage: TfrxDocxPage;
    FURLNum: Integer;
    FFirstPage: Boolean;
    FPictureType: TfrxPictureType;
    FExportType: TExportType;
    FLeftCurPage, FTopCurPage: Extended;
    function SubPath(const s: string): string;
    function SecPr: string;
    procedure WriteRels(URL: string);
  protected
    function EnableCalculateHash: Boolean; override;
  public
    constructor Create(Owner: TComponent); override;
    class function GetDescription: string; override;
    class function ExportDialogClass: TfrxBaseExportDialogClass; override;
    function Start: Boolean; override;
    procedure Finish; override;
    procedure StartPage(Page: TfrxReportPage; Index: Integer); override;
    procedure FinishPage(Page: TfrxReportPage; Index: Integer); override;
    procedure ExportObject(Obj: TfrxComponent); override;
  published
    property OpenAfterExport;
    property OverwritePrompt;
    property PictureType: TfrxPictureType read FPictureType write FPictureType;
    property ExportType: TExportType read FExportType write FExportType;
  end;

  //suport:
  function GetVAlign(a: TfrxVAlign): string;
  function GetHAlign(a: TfrxHAlign): string;
  function GetFont(f: TFont; SubType: TSubStyle = ssNormal; RTL: Boolean = false): string;
  function BStr(b: Boolean; s: string): string;
  function GetText(const s: string): string;
  function WriteTaggedText(Text: WideString; HTMLTags, RTL: boolean; AStyle: TfrxIEMStyle; AWriter: TfrxWriter): Boolean;
  function StrokedToString(frame: TfrxFrame): String;

implementation

uses
  frxUtils, frxFileUtils, frUnicodeUtils, frxRes, frxExportDOCXDialog, frBaseGraphicsTypes;

const
  FileExt: string = '.docx';
  LenFactor: Double = 56.79;
  XFactor: Double = 15.50;
  YFactor: Double = 14.70;
  MMFactor: Double = 269.332;

{ TfrxDOCXExport }

function TfrxDOCXExport.SubPath(const s: string): string;
begin
  Result := FDocFolder + '/' + s;
end;

function TfrxDOCXExport.SecPr: string;
begin
  Result := Format('<w:sectPr><w:pgSz w:w="%d" w:h="%d"', [FLastPage.Width, FLastPage.Height]);
  if FLastPage.Width > FLastPage.Height then Result := Result + ' w:orient="landscape"';
  Result := Result + Format('/><w:pgMar w:top="%d" w:right="%d" w:bottom="%d" w:left="%d" w:header="720" w:footer="720" w:gutter="0"/>' +
                          '<w:cols w:space="720"/><w:noEndnote/></w:sectPr>',
                          [FLastPage.Margins.Top, FLastPage.Margins.Right, FLastPage.Margins.Bottom, FLastPage.Margins.Left]);
end;

procedure TfrxDOCXExport.WriteRels(URL: string);
begin
  with TfrxWriter.Create(FDocRels) do
    begin
      Write('<Relationship Id="rURLId%d" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/hyperlink" Target="%s" TargetMode="External"/>',
            [FURLNum, URL]);
      Free;
    end;
  inc(FURLNum);
end;

function TfrxDOCXExport.EnableCalculateHash: Boolean;
begin
  Result := True;
end;

class function TfrxDOCXExport.GetDescription: string;
begin
  Result := frxGet(9203);
end;

class function TfrxDOCXExport.ExportDialogClass: TfrxBaseExportDialogClass;
begin
  Result := TfrxDOCXExportDialog;
end;

function TfrxDOCXExport.Start: Boolean;
var
  TempStream: TStream;
begin
  Result := False; // Default

  if (FileName = '') and not Assigned(Stream) then
    Exit;

  Result := True;
  FURLNum := 1;
  FFirstPage := True;

  { file structure }
  try
  FDocFolder := IOTransport.TempFilter.BasePath;
  CreateDirs(IOTransport.TempFilter, ['_rels', 'docProps', 'word', 'word/theme', 'word/_rels', 'word/media' ]);

  { [Content_Types].xml }
  TempStream := IOTransport.TempFilter.GetStream(SubPath('[Content_Types].xml'));
  with TfrxWriter.Create(TempStream) do
  begin
    Write(['<?xml version="1.0" encoding="UTF-8" standalone="yes"?>',
      '<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">',
      '<Default Extension="emf" ContentType="image/x-emf"/>',
      '<Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>',
      '<Default Extension="xml" ContentType="application/xml"/>',
      '<Override PartName="/word/document.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.document.main+xml"/>',
      '<Override PartName="/word/styles.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.styles+xml"/>',
      '<Override PartName="/docProps/app.xml" ContentType="application/vnd.openxmlformats-officedocument.extended-properties+xml"/>',
      '<Override PartName="/word/settings.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.settings+xml"/>',
//      '<Override PartName="/word/theme/theme1.xml" ContentType="application/vnd.openxmlformats-officedocument.theme+xml"/>',
      '<Override PartName="/word/fontTable.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.fontTable+xml"/>',
//      '<Override PartName="/word/webSettings.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.webSettings+xml"/>',
      '<Override PartName="/docProps/core.xml" ContentType="application/vnd.openxmlformats-package.core-properties+xml"/>',
      '</Types>']);

    Free;
  end;
  IOTransport.TempFilter.FreeStream(TempStream);

  { _rels/.rels }
  TempStream := IOTransport.TempFilter.GetStream(SubPath('_rels/.rels'));
  with TfrxWriter.Create(TempStream) do
  begin
    Write(['<?xml version="1.0" encoding="UTF-8" standalone="yes"?>',
      '<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">',
      '<Relationship Id="rId3" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/extended-properties" Target="docProps/app.xml"/>',
      '<Relationship Id="rId2" Type="http://schemas.openxmlformats.org/package/2006/relationships/metadata/core-properties" Target="docProps/core.xml"/>',
      '<Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="word/document.xml"/>',
      '</Relationships>']);

    Free;
  end;
  IOTransport.TempFilter.FreeStream(TempStream);
  { docProps/core.xml }
  TempStream := IOTransport.TempFilter.GetStream(SubPath('docProps/core.xml'));
  with TfrxWriter.Create(TempStream) do
  begin
    Write(['<?xml version="1.0" encoding="UTF-8" standalone="yes"?>',
      '<cp:coreProperties xmlns:cp="http://schemas.openxmlformats.org/package/2006/metadata/core-properties"',
      ' xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:dcmitype="http://purl.org/dc/dcmitype/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">',
      '<dc:title>' + Report.ReportOptions.Name + '</dc:title>',
      '<dc:subject></dc:subject>',
      '<dc:creator>' + Report.ReportOptions.Author + '</dc:creator>',
      '<cp:keywords></cp:keywords>',
      '<dc:description>' + Report.ReportOptions.Description.Text + '</dc:description>',
      '<cp:lastModifiedBy>' + Report.ReportOptions.Author + '</cp:lastModifiedBy>',
      '<cp:revision>2</cp:revision>',
      {$IfDef EXPORT_TEST}
      '<dcterms:created xsi:type="dcterms:W3CDTF">2019-01-12T11:06:45Z</dcterms:created>',
      '<dcterms:modified xsi:type="dcterms:W3CDTF">2019-01-12T11:06:45Z</dcterms:modified>',
      {$Else}
      '<dcterms:created xsi:type="dcterms:W3CDTF">' + FormatDateTime('yyyy"-"mm"-"dd"T"hh":"nn":"ss"Z"', DateTimeToUTC(Now)) + '</dcterms:created>',
      '<dcterms:modified xsi:type="dcterms:W3CDTF">' + FormatDateTime('yyyy"-"mm"-"dd"T"hh":"nn":"ss"Z"', DateTimeToUTC(Now)) + '</dcterms:modified>',
      {$EndIf}
      '</cp:coreProperties>'], True);

    Free;
  end;
  IOTransport.TempFilter.FreeStream(TempStream);
  { docProps/app.xml }
  TempStream := IOTransport.TempFilter.GetStream(SubPath('docProps/app.xml'));
  with TfrxWriter.Create(TempStream) do
  begin
    Write(['<?xml version="1.0" encoding="UTF-8" standalone="yes"?>',
      '<Properties xmlns="http://schemas.openxmlformats.org/officeDocument/2006/extended-properties" xmlns:vt="http://schemas.openxmlformats.org/officeDocument/2006/docPropsVTypes">',
      '<Template>Normal.dotm</Template>',
      '<TotalTime>1</TotalTime>',

      // todo: are these lines really needed ?
      //'<Pages>6</Pages>',
      //'<Words>2340</Words>',
      //'<Characters>13340</Characters>',
      //'<Lines>111</Lines>',
      //'<Paragraphs>31</Paragraphs>',
      //'<CharactersWithSpaces>15649</CharactersWithSpaces>',

      '<Application>FastReports</Application>',
      '<DocSecurity>0</DocSecurity>',
      '<ScaleCrop>false</ScaleCrop>',
      '<Company></Company>',
      '<LinksUpToDate>false</LinksUpToDate>',
      '<SharedDoc>false</SharedDoc>',
      '<HyperlinksChanged>false</HyperlinksChanged>',
      '<AppVersion>12.0000</AppVersion>',
      '</Properties>']);

    Free;
  end;
  IOTransport.TempFilter.FreeStream(TempStream);
  { word/_rels/document.xml.rels }
  FDocRels := IOTransport.TempFilter.GetStream(SubPath('word/_rels/document.xml.rels'));
  with TfrxWriter.Create(FDocRels) do
  begin
    Write(['<?xml version="1.0" encoding="UTF-8" standalone="yes"?>',
      '<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">',
//      '<Relationship Id="rId3" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/webSettings" Target="webSettings.xml"/>',
      '<Relationship Id="rId2" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/settings" Target="settings.xml"/>',
      '<Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles" Target="styles.xml"/>',
//      '<Relationship Id="rId5" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/theme" Target="theme/theme1.xml"/>',
      '<Relationship Id="rId4" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/fontTable" Target="fontTable.xml"/>']);

    Free;
  end;
  { word/webSettings.xml }
{
  with TfrxFileWriter.Create(SubPath('word/webSettings.xml')) do
  begin
    Write(['<?xml version="1.0" encoding="UTF-8" standalone="yes"?>',
      '<w:webSettings xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">',
      '<w:optimizeForBrowser/>',
      '</w:webSettings>']);

    Free;
  end;
}
  { word/styles.xml }
  TempStream := IOTransport.TempFilter.GetStream(SubPath('word/styles.xml'));
  with TResourceStream.Create(HInstance, 'OfficeOpenStyles', 'XML') do
  begin
    SaveToStream(TempStream);
    Free;
  end;
  IOTransport.TempFilter.FreeStream(TempStream);
  { word/fontTable.xml }
  TempStream := IOTransport.TempFilter.GetStream(SubPath('word/fontTable.xml'));
  with TResourceStream.Create(HInstance, 'DocxFontTable', 'XML') do
  begin
    SaveToStream(TempStream);
    Free;
  end;
  IOTransport.TempFilter.FreeStream(TempStream);
  { word/settings.xml }
  TempStream := IOTransport.TempFilter.GetStream(SubPath('word/settings.xml'));
  with TResourceStream.Create(HInstance, 'OfficeOpenSettings', 'XML') do
  begin
    SaveToStream(TempStream);
    Free;
  end;
  IOTransport.TempFilter.FreeStream(TempStream);
  { word/theme/theme1.xml }
{
  with TResourceStream.Create(HInstance, 'OfficeOpenTheme', 'XML') do
  begin
    SaveToFile(SubPath('word/theme/theme1.xml'));
    Free;
  end;
}
  { word/document.xml }
  FDocument := IOTransport.TempFilter.GetStream(SubPath('word/document.xml'));
  with TfrxWriter.Create(FDocument) do
  begin
    Write(['<?xml version="1.0" encoding="UTF-8" standalone="yes"?>',
      '<w:document xmlns:ve="http://schemas.openxmlformats.org/markup-compatibility/2006"',
      ' xmlns:o="urn:schemas-microsoft-com:office:office"',
      ' xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"',
      ' xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math"',
      ' xmlns:v="urn:schemas-microsoft-com:vml"',
      ' xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing"',
      ' xmlns:w10="urn:schemas-microsoft-com:office:word" xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:wne="http://schemas.microsoft.com/office/word/2006/wordml">',
      '<w:body>']);

    Free;
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

procedure TfrxDOCXExport.StartPage(Page: TfrxReportPage; Index: Integer);
begin
  if FExportType = dxTable then
  begin
  FMatrix := TfrxIEMatrix.Create(UseFileCache, Report.EngineOptions.TempDir, Report.PictureCacheOptions.CachedImagesBuildType);

  with FMatrix do
  begin
    Background      := False;
    BackgroundImage := False;
    Printable       := ExportNotPrintable;
    RichText        := False;
    PlainRich       := False;
    Inaccuracy      := 2;
    DeleteHTMLTags  := False;
    Images          := True;
    WrapText        := False;
    ShowProgress    := False;
    EmptyLines      := True;
    BrushAsBitmap   := False;
    {$IFNDEF FPC}
    EMFPictures     := True;
    {$ENDIF}
    MaxCellWidth    := 500;
    MaxCellHeight   := 500;
  end;
  end;
  if not FFirstPage then
    try
    with TfrxWriter.Create(FDocument) do
    begin
      Write(['<w:p>',
        '<w:pPr><w:widowControl w:val="0"/><w:autoSpaceDE w:val="0"/>',
        '<w:autoSpaceDN w:val="0"/><w:adjustRightInd w:val="0"/><w:spacing w:after="0" w:line="240" w:lineRule="auto"/>',
        '<w:rPr><w:rFonts w:ascii="Tahoma" w:hAnsi="Tahoma" w:cs="Tahoma"/><w:sz w:val="24"/>',
        '<w:szCs w:val="24"/></w:rPr>', SecPr, '</w:pPr></w:p>']);

      Free;
    end
    except
      on e: Exception do
        case Report.EngineOptions.NewSilentMode of
          simSilent:        Report.Errors.Add(e.Message);
          simMessageBoxes:  frxErrorMsg(e.Message);
          simReThrow:       raise;
        end;
    end;
  if FExportType = dxObjects then
  begin
    FLeftCurPage := Page.LeftMargin * fr01cm;
    FTopCurPage := Page.TopMargin * fr01cm;
    with TfrxWriter.Create(FDocument) do
    begin
      Write('<w:p>');
      Free;
    end;
  end;

  FFirstPage := False;
end;

constructor TfrxDOCXExport.Create(Owner: TComponent);
begin
  inherited;
  DefaultExt := '.docx';
  FilterDesc := frxGet(9206);
  FExportType := dxTable;
end;

procedure TfrxDOCXExport.ExportObject(Obj: TfrxComponent);
var
  v: TfrxView;
  Writer: TfrxWriter;
  s: TfrxIEMStyle;

   procedure ExportLineObj(x, y, h, w: Extended; col: TColor; FrWi: Extended; st, en: Boolean);
   begin
     Writer.Write('<w:r><w:pict>');

     Writer.Write(Format('<v:shape type="#_x0000_t32" ' +
       'style="position:absolute;margin-left:%f;margin-top:%f;width:%f;height:%f" ' +
       'o:connectortype="straight" ' +
       'strokecolor="%s" ' +
       'strokeweight="%dpt">',
       [x, y, h, w, HTMLRGBColor(col), Round(FrWi)]));

     if st then
       Writer.Write('<v:stroke startarrow="classic"/>');
     if en then
       Writer.Write('<v:stroke endarrow="classic"/>');

     Writer.Write('</v:shape></w:pict></w:r>');
   end;

   procedure ExportLineasObject(Obj: TfrxLineView);
   begin
     ExportLineObj(obj.AbsLeft - FLeftCurPage, obj.AbsTop - FTopCurPage, obj.Width, obj.Height,
       obj.Frame.Color, Obj.Frame.Width, obj.ArrowStart, obj.ArrowEnd);
   end;
  
  procedure ExportTextasObject(Obj: TfrxCustomMemoView);

    function VAlignToString(i: TfrxVAlign): String;
    begin
      if i = vaTop then
        Result := 'top'
      else
      if i = vaBottom then
        Result := 'bottom'
      else
        Result := 'middle';
    end;

    function FillToString(fill: TfrxCustomFill): String;
    var
      fill_color, filled: string;
      brush: TfrxBrushFill;
      grad: TfrxGradientFill;
      glass: TfrxGlassFill;
      col: TColor;

      function MixColor(a, b: Tcolor): Tcolor;
      begin
        Result := RGB(
                    GetRValue(a) + GetRValue(b) div 2,
                    GetGValue(a) + GetGValue(b) div 2,
                    GetBValue(a) + GetBValue(b) div 2);
      end;

    begin
      fill_color := '';
      filled := '';
      if (fill is TfrxBrushFill) then
      begin
        brush := fill as TfrxBrushFill;        
        if (brush.BackColor <> clNone) then
          Result := Format('fillcolor="%s"', [HTMLRGBColor(brush.BackColor)])
        else
          Result := 'filled="f"';
      end
      else //TODO: TfrxBrushFill.styles and gradient, glass
      if (fill is TfrxBrushFill) then
      begin
        grad := fill as TfrxGradientFill;
        col := MixColor(grad.StartColor, grad.EndColor);
        if (col <> clNone) then
          Result := Format('fillcolor="%s"', [HTMLRGBColor(col)])
        else
          Result := 'filled="f"';
      end
      else
      begin
        glass := fill as TfrxGlassFill;
        if (glass.Color <> clNone) then
          Result := Format('fillcolor="%s"', [HTMLRGBColor(glass.Color)])
        else
          Result := 'filled="f"';
      end;
    end;

    function Open_Paragraph(Obj: TfrxCustomMemoView; exportTopPadding, exportBottomPadding: Boolean): String;
    var
      font_size: Double;
      left: Double;
      //borderLine: String;
    begin
      Result := '';
      font_size := 2 * obj.Font.Size;
      Result := Result + '<w:p><w:pPr><w:spacing w:after=';

      if (exportBottomPadding) then // TODO: Not Gap
        Result := Result + QuotedStr(IntToStr(Trunc(Obj.GapX/fr1in*1440)))
      else
        Result := Result + QuotedStr('0');
      if (exportTopPadding) then // TODO: Not Gap
      begin
        Result := Result + ' w:before=' + QuotedStr(IntToStr(Trunc(obj.GapY/fr1in*1440)));
      end;
            
      Result := Result + ' w:line="240" w:lineRule="auto"/>';
            
      {if (Obj.Frame.Typ <> []) and (Obj.Frame.Typ <> [ftLeft, ftRight, ftTop, ftBottom]) then
      begin
        Result := Result + '<w:pBdr>';
        borderLine := '<w:%s w:val="single" w:sz="%d" w:space="1" w:color="%s"/>';
        if (ftTop in Obj.Frame.Typ) and (Obj.Frame.TopLine.Width > 0) then
          Result := Result + Format(borderLine, ['top', Round(Obj.Frame.TopLine.Width * 8), HTMLRGBColor(Obj.Frame.TopLine.Color)]);
        if (ftBottom in Obj.Frame.Typ) and (Obj.Frame.BottomLine.Width > 0) then
          Result := Result + Format(borderLine, ['bottom', Round(Obj.Frame.BottomLine.Width * 8), HTMLRGBColor(Obj.Frame.BottomLine.Color)]);
        if (ftLeft in Obj.Frame.Typ) and (Obj.Frame.LeftLine.Width > 0) then
          Result := Result + Format(borderLine, ['left', Round(Obj.Frame.LeftLine.Width * 8), HTMLRGBColor(Obj.Frame.LeftLine.Color)]);
        if (ftRight in Obj.Frame.Typ) and (Obj.Frame.RightLine.Width > 0) then
          Result := Result + Format(borderLine, ['right', Round(Obj.Frame.RightLine.Width * 8), HTMLRGBColor(Obj.Frame.RightLine.Color)]);
        Result := Result + '</w:pBdr>';
      end;}

      left := Obj.GapX * 15;
      if (left > 0) then
        Result := Result + '<w:ind w:left=' + QuotedStr(FloatToStr(left)) + ' w:right="0"/>';
      Result := Result + '<w:jc w:val=' + QuotedStr(GetHAlign(obj.HAlign)) +
        ' /><w:rPr><w:sz w:val=' + QuotedStr(FloatToStr(font_size)) +
        '/><w:szCs w:val=' + QuotedStr(FloatToStr(font_size)) + '/></w:rPr></w:pPr>'; 
    end;

    function Close_Paragraph(): String;
    begin
      Result := '</w:p>';
    end;

    function MemoToIEMStyle(MObj: TfrxCustomMemoView): TfrxIEMStyle;
    var
      Style: TfrxIEMStyle; 
    begin
      Style := TfrxIEMStyle.Create;
      if MObj.Highlight.Active and
         Assigned(MObj.Highlight.Font) then
      begin
        Style.Font.Assign(MObj.Highlight.Font);
        Style.Color := MObj.Highlight.Color;
      end
      else
      begin
        Style.Font.Assign(MObj.Font);
        Style.Color := MObj.Color;
      end;
      Style.DisplayFormat := MObj.DisplayFormat;
      Style.HAlign := MObj.HAlign;
      Style.VAlign := MObj.VAlign;
      Style.LineSpacing := MObj.LineSpacing;
      Style.GapX := MObj.GapX;
      Style.GapY := MObj.GapY;
      Style.Charset := MObj.Font.Charset;
      Style.CharSpacing := MObj.CharSpacing;
      Style.ParagraphGap := MObj.ParagraphGap;
      Style.WordBreak := MObj.WordBreak;
      Style.FrameTyp := MObj.Frame.Typ;
      Style.LeftLine.Assign(MObj.Frame.LeftLine);
      Style.TopLine.Assign(MObj.Frame.TopLine);
      Style.RightLine.Assign(MObj.Frame.RightLine);
      Style.BottomLine.Assign(MObj.Frame.BottomLine);
      Style.Rotation := MObj.Rotation;
      Style.BrushStyle := MObj.BrushStyle;
      Style.WordWrap := MObj.WordWrap;
      Result := Style;
    end;

  var  
    i: Integer;
    pPr: String;

  begin
    with Writer do
    begin
      Writer.Write(Format('<w:r><w:rPr><w:noProof/></w:rPr><w:pict><v:rect id="%s" ' +
        'style="position:absolute;margin-left:%f;margin-top:%f;width:%f;height:%f;v-text-anchor:%s" %s %s>',
        [obj.Name, obj.AbsLeft - FLeftCurPage, obj.AbsTop - FTopCurPage, obj.Width, obj.Height, VAlignToString(obj.VAlign),
        FillToString(obj.Fill), StrokedToString(obj.Frame)]));

      Writer.Write('<v:textbox inset="0,0,0,0"><w:txbxContent>');
      pPr := Open_Paragraph(Obj, false, false);
      Writer.Write(pPr);

      if (obj.URL <> '') then
      begin
        Write(Format('<w:hyperlink r:id="rURLId%d">', [FURLNum]));
        WriteRels(Escape(Obj.URL));
      end;

      s := MemoToIEMStyle(obj);
      if not Obj.AllowHTMLTags or not WriteTaggedText(Obj.Memo.Text, Obj.AllowHTMLTags, obj.RTLReading, s, Writer) then
        for i := 0 to Obj.Memo.Count - 1 do
        begin
          // note: in unicode DELPHI12+ Utf8Encode has no effect: when converted to widestring it does utf8decode automatically
          Write(['<w:r>', GetFont(obj.Font, ssNormal, Obj.RTLReading), BStr((i > 0) and not ((Obj.ParagraphGap <> 0) and (Obj.Memo.Count > 1) {and (i <> Obj.Memo.Count - 1)}), '<w:br/>'), GetText(String(Utf8Encode(Obj.Memo[i]))), '</w:r>'], {$IFDEF DELPHI12}True{$ELSE}False{$ENDIF});
          if (Obj.ParagraphGap <> 0) and (Obj.Memo.Count > 1) and (i <> Obj.Memo.Count - 1) then
          begin
            if Obj.URL <> '' then
              Write('</w:hyperlink>');
            Write(['</w:p><w:p>', pPr]);
            Write('<w:jc w:val="%s"/>', [GetHAlign(obj.HAlign)]);
            Write(GetFont(obj.Font, ssNormal, Obj.RTLReading), {$IFDEF DELPHI12}True{$ELSE}False{$ENDIF});
            Write('</w:pPr>');
            if Obj.URL <> '' then
            begin
              Write('<w:hyperlink r:id="rURLId%d">', [FURLNum]);
              WriteRels(Escape(Obj.URL));
            end;
          end;
          if Obj.URL <> '' then
            Write('</w:hyperlink>');
        end;
       s.Free; 
      Writer.Write(Close_Paragraph);
       
      Writer.Write('</w:txbxContent></v:textbox></v:rect></w:pict></w:r>');

      if (Obj.Frame.Typ <> []) and (Obj.Frame.Typ <> [ftLeft, ftRight, ftTop, ftBottom]) then
      begin
        if (ftTop in Obj.Frame.Typ) and (Obj.Frame.TopLine.Width > 0) then
          ExportLineObj(obj.AbsLeft - FLeftCurPage, obj.AbsTop - FTopCurPage, obj.Width,
            0, obj.Frame.TopLine.Color, Obj.Frame.TopLine.Width, false, false);
        if (ftBottom in Obj.Frame.Typ) and (Obj.Frame.BottomLine.Width > 0) then
          ExportLineObj(obj.AbsLeft - FLeftCurPage, obj.AbsTop - FTopCurPage + obj.Height, obj.Width,
            0, obj.Frame.BottomLine.Color, Obj.Frame.BottomLine.Width, false, false);
        if (ftLeft in Obj.Frame.Typ) and (Obj.Frame.LeftLine.Width > 0) then
          ExportLineObj(obj.AbsLeft - FLeftCurPage, obj.AbsTop - FTopCurPage, 0,
            Obj.Height, obj.Frame.LeftLine.Color, Obj.Frame.LeftLine.Width, false, false);
        if (ftRight in Obj.Frame.Typ) and (Obj.Frame.RightLine.Width > 0) then
          ExportLineObj(obj.AbsLeft - FLeftCurPage + Obj.Width, obj.AbsTop - FTopCurPage, 0,
            Obj.Height, obj.Frame.RightLine.Color, Obj.Frame.RightLine.Width, false, false);
      end;
    end;
  end;

  procedure ExportImageAsObject(Obj: TfrxView);
  var
  {$IFDEF FPC}
  m: TBitMap;
  {$ELSE}
  m: TMetafile;
  {$ENDIF}
  Path, id, Adds: String;
  IntertNum: Integer;

    function ObjToImage(obj: TfrxView): {$IFDEF FPC}TBitMap{$ELSE}TMetafile{$ENDIF};
    begin
      {$IFDEF FPC}
      Result := TBitmap.Create();
      Result.Height := Round(Obj.Height);
      Result.Width := Round(Obj.Width);
      Result.Canvas.Brush.Color := ClWhite;
      Result.Canvas.FillRect(Rect(0, 0, Result.Width, Result.Height));
      try
        Obj.Draw(Result.Canvas, 1, 1, -Obj.AbsLeft, -Obj.AbsTop);
      except
        // charts throw exceptions when numbers are malformed
      end;
      {$ELSE}
      Result := TMetafile(Obj.GetVectorGraphic(True));
      {$ENDIF}
    end;

  begin
    if Obj.Height * Obj.Width = 0 then Exit;
    m := ObjToImage(Obj);

    IntertNum := FfrxPictureHashMap.FindOrAddGraphic(m, phmIndex) + 1;

    Path := 'image' + IntToStr(IntertNum) + '.emf';
    id := 'picId' + IntToStr(IntertNum);

    if (FfrxPictureHashMap.isLastNew) then
    begin
      with TfrxWriter.Create(FDocRels) do
      begin
        Write('<Relationship Id="%s" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/image"' +
          ' Target="media/%s"/>', [id, Path]);
        Free;
      end;
      SaveGraphicAs(m, IOTransport.TempFilter.GetStream(SubPath('word/media/' + Path)), PictureType);
    end;
    m.Free;
    Adds := '';
    if obj.Color = clNone then
      Adds := ' fillcolor="none"';

    with Writer do
    begin
      Write(Format('<w:r><w:rPr><w:noProof/></w:rPr><w:pict><v:rect id="%s" ' +
        'style="position:absolute;margin-left:%f;margin-top:%f;width:%f;height:%f" %s' + Adds + '>' +
        '<v:fill r:id="%s" o:title="%d" recolor="f" type="frame"/></v:rect></w:pict></w:r>',
        [obj.Name, obj.AbsLeft - FLeftCurPage, obj.AbsTop - FTopCurPage, obj.Width, obj.Height, StrokedToString(obj.Frame), id, IntertNum]));
    end;
  end;

begin
  if not (Obj is TfrxView) then
    Exit;

  v := Obj as TfrxView;

  if IsPageBG(v) or not (vsExport in v.Visibility) then
    Exit;
  if FExportType = dxTable then
    FMatrix.AddObject(v)
  else
  begin
    Writer := TfrxWriter.Create(FDocument);
    if FExportType = dxObjects then
    begin
      if (Obj is TfrxCustomMemoView) then
        ExportTextasObject(TfrxCustomMemoView(Obj))
      else
      if (Obj is TfrxLineView) then
        ExportLineasObject(TfrxLineView(Obj))
      else
      if (obj is TfrxView) then
        ExportImageasObject(TfrxView(Obj));
    end
    else
    begin
      //dxText
    end;
    Writer.Free;
  end;
end;

procedure TfrxDOCXExport.FinishPage(Page: TfrxReportPage; Index: Integer);

  function BorderStyle(style: TfrxFrameStyle): String;
  begin
      case style of
      fsSolid:        Result := 'single';
      fsDash:         Result := 'dashed';
      fsDot:          Result := 'dotted';
      fsDashDot:      Result := 'dashDot';
      fsDashDotDot:   Result := 'dashDotDot';
      fsDouble:       Result := 'double';
      fsAltDot:       Result := 'dashDot';
      fsSquare:       Result := 'thin';
      else            Result := 'thin';
      end;
  end;

  function GetBorder( fl: TfrxFrameLine; ex: Bool): string;
  begin
    if ex then
      Result := Format('w:val="%s" w:sz="%d" w:space="0" w:color="%s"',
        [ BorderStyle(fl.Style), Trunc(fl.Width * 4), HTMLRGBColor(fl.Color) ])
    else
      Result := 'w:val="nil"';
  end;

  function GetMerging(r, c: Integer): string;
  var
    i, x, y, dx, dy: Integer;
  begin
    Result := '';
    i := FMatrix.GetCell(c, r);
    if i < 0 then
      Exit;

    FMatrix.GetObjectPos(i, x, y, dx, dy);

    if dy > 1 then
      if r = y then
        Result := '<w:vMerge w:val="restart"/>'
      else
        Result := '<w:vMerge/>';
  end;

  function GetPicture(m: TGraphic; URL: string = ''): string;
  var
    w, h: Integer;
    id, pic: string;
    ImageIndex: Integer;
  begin
    if m.Width = 0 then
    begin
      Result := '';
      Exit;
    end;

    ImageIndex := FfrxPictureHashMap.FindOrAddGraphic(m, phmIndex);

    w := Round(m.Width * 360000 / fr1cm{m.MMWidth * MMFactor});
    h := Round(m.Height * 360000 / fr1cm{m.MMHeight * MMFactor});
    id := 'picId' + IntToStr(ImageIndex);
    pic := 'image' + IntToStr(ImageIndex) + '.emf';

    if not FileExists(SubPath('word/media/' + pic)) then
    begin
      with TfrxWriter.Create(FDocRels) do
      begin
        Write('<Relationship Id="%s" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/image"' +
          ' Target="media/%s"/>', [id, pic]);

        Free;
      end;
      SaveGraphicAs(m, IOTransport.TempFilter.GetStream(SubPath('word/media/' + pic)), PictureType);
    end;

    Result := Format('<w:drawing><wp:inline distT="0" distB="0" distL="0" distR="0">' +
      '<wp:extent cx="%d" cy="%d"/><wp:effectExtent l="0" t="0" r="0" b="0"/>' +
      '<wp:docPr id="1" name="Picture"'+ BStr(URL = '', '/') + '>' + URL + '<wp:cNvGraphicFramePr>' +
      '<a:graphicFrameLocks xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" noChangeAspect="1"/>' +
      '</wp:cNvGraphicFramePr><a:graphic xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main">' +
      '<a:graphicData uri="http://schemas.openxmlformats.org/drawingml/2006/picture">' +
      '<pic:pic xmlns:pic="http://schemas.openxmlformats.org/drawingml/2006/picture">' +
      '<pic:nvPicPr><pic:cNvPr id="0" name="Picture"/><pic:cNvPicPr>' +
      '<a:picLocks noChangeAspect="1" noChangeArrowheads="1"/></pic:cNvPicPr></pic:nvPicPr>' +
      '<pic:blipFill><a:blip r:embed="%s"/><a:srcRect/><a:stretch><a:fillRect/></a:stretch></pic:blipFill>' +
      '<pic:spPr bwMode="auto"><a:xfrm><a:off x="0" y="0"/><a:ext cx="%d" cy="%d"/></a:xfrm>' +
      '<a:prstGeom prst="rect"><a:avLst/></a:prstGeom><a:noFill/><a:ln w="9525"><a:noFill/><a:miter lim="800000"/>' +
      '<a:headEnd/><a:tailEnd/></a:ln></pic:spPr></pic:pic></a:graphicData></a:graphic></wp:inline></w:drawing>',
      [w, h, id, w, h]);
  end;

var
  i, r, c1, c2, XPos, YPos: Integer;
  Obj: TfrxIEMObject;
  w: Integer;
  s: TfrxIEMStyle;
  rotate, pPr, URL: String;
  Writer: TfrxWriter;
begin
  with FLastPage do
  begin
    Width := Round(Page.PaperWidth * LenFactor);
    Height := Round(Page.PaperHeight * LenFactor);

    with Margins do
    begin
      Left := Round(Page.LeftMargin * LenFactor);
      Right := Round(Page.RightMargin * LenFactor);
      Top := Round(Page.TopMargin * LenFactor);
      Bottom := Round(Page.BottomMargin * LenFactor);
    end;
  end;

  if FExportType <> dxTable then
  begin
    if FExportType = dxObjects then
    with TfrxWriter.Create(FDocument) do
    begin
      Write('</w:p>');
      Free;
    end;

    Exit;
  end;

  FMatrix.Prepare;

  for i := 0 to FMatrix.GetObjectsCount - 1 do
    FMatrix.GetObjectById(i).Counter := 0;
  try
  Writer := TfrxWriter.Create(FDocument);
  with Writer do
  begin
    Write('<w:tbl>');

    if FMatrix.ObjectsCount > 0 then
      begin
        XPos := Round(XFactor * FMatrix.GetXPosById(0));
        YPos := Round(YFactor * FMatrix.GetYPosById(0));
      end
    else
      begin
        XPos := 0;
        YPos := 0;
      end; 

    Write('<w:tblPr><w:tblpPr w:leftFromText="0" w:rightFromText="0" w:vertAnchor="page" w:horzAnchor="page" w:tblpX="%d" w:tblpY="%d"/>' +
      '<w:tblW w:w="0" w:type="auto"/><w:tblInd w:w="15" w:type="dxa"/>' +
      '<w:tblLayout w:type="fixed"/><w:tblCellMar><w:left w:w="15" w:type="dxa"/>' +
      '<w:right w:w="15" w:type="dxa"/></w:tblCellMar><w:tblLook w:val="0000"/>' +
      '</w:tblPr>', [XPos, YPos]); 

    Write('<w:tblGrid>');

    for i := 0 to FMatrix.Width - 2 do
    begin
      w := Round(XFactor * (FMatrix.GetXPosById(i + 1) - FMatrix.GetXPosById(i)));
      Write('<w:gridCol w:w="%d"/>', [w]);
    end;

    Write('</w:tblGrid>');

    for r := 0 to FMatrix.Height - 2 do
    begin
      Write('<w:tr>');

      Write('<w:tblPrEx><w:tblCellMar><w:top w:w="0" w:type="dxa"/><w:bottom w:w="0" w:type="dxa"/>' +
        '</w:tblCellMar></w:tblPrEx><w:trPr><w:trHeight w:hRule="exact" w:val="%d"/></w:trPr>',
        [Round(YFactor * (FMatrix.GetYPosById(r + 1) - FMatrix.GetYPosById(r)))]);

      c1 := 0;
      while (c1 < FMatrix.Width - 1) and (c1 < 63) do
      begin
        c2 := c1;
        w := 0;

        with FMatrix do
          while (c2 < Width - 1) and (GetCell(c1, r) = GetCell(c2, r)) do
          begin
            Inc(w, Round(XFactor * (GetXPosById(c2 + 1) - GetXPosById(c2))));
            Inc(c2);
          end;

        Dec(c2);

        Write('<w:tc>');
        Write('<w:tcPr><w:tcW w:w="%d" w:type="dxa"/>', [w]);

        if c2 > c1 then
          Write('<w:gridSpan w:val="%d"/>', [c2 - c1 + 1]);

        Obj := FMatrix.GetObject(c1, r);
        s := FMatrix.GetStyle(c1, r);
        if s <> nil then
          Write('<w:tcMar><w:top w:w="%d" w:type="dxa"/><w:left w:w="%d" w:type="dxa"/><w:bottom w:w="%d" w:type="dxa"/><w:right w:w="%d" w:type="dxa"/></w:tcMar>',
                [Trunc((s.GapY - 1)/fr1in*1440), Trunc(s.GapX/fr1in*1440), Trunc((s.GapY - 1)/fr1in*1440), Trunc(s.GapX/fr1in*1440)]);

        Write(GetMerging(r, c1));

        if (s <> nil) then
          Write('<w:tcBorders><w:top %s/><w:left %s/><w:bottom %s/><w:right %s/></w:tcBorders>',
            [GetBorder(s.TopLine, ftTop in s.FrameTyp),
            GetBorder(s.LeftLine, ftLeft in s.FrameTyp),
            GetBorder(s.BottomLine, ftBottom in s.FrameTyp),
            GetBorder(s.RightLine, ftRight in s.FrameTyp)]);

        if Obj <> nil then begin
          if s.Color <> clNone then
            Write('<w:shd w:val="clear" w:color="auto" w:fill="%s"/><w:vAlign w:val="%s"/>',
              [HTMLRGBColor(s.Color), GetVAlign(s.VAlign)])
          else
            Write('<w:shd w:val="clear" w:color="auto" w:fill="auto"/><w:vAlign w:val="%s"/>',
              [GetVAlign(s.VAlign)]);
          if Obj.Style.Rotation <> 0 then begin
            case Obj.Style.Rotation of
              90:   rotate := 'btLr';
              270:  rotate := 'tbRlV';
            else
              rotate := 'lrTb';
            end;
            Write('<w:textDirection w:val="' + rotate + '" />');
          end;
        end;

        Write('</w:tcPr>');

        Write('<w:p>');

        pPr := '<w:pPr><w:widowControl w:val="0"/>' +
               '<w:autoSpaceDE w:val="0"/><w:autoSpaceDN w:val="0"/><w:adjustRightInd w:val="0"/>' +
               '<w:spacing w:before="29" w:after="0" w:line="213" w:lineRule="auto"/><w:ind w:left="15"/>';

        if (Obj <> nil) then
          if Obj.IsText then
            pPr := '<w:pPr><w:widowControl w:val="0"/>' +
                   '<w:autoSpaceDE w:val="0"/><w:autoSpaceDN w:val="0"/><w:adjustRightInd w:val="0"/>' +
                   '<w:spacing w:before="29" w:after="0" w:line="' +
                   IntToStr(Trunc((s.Font.Size + (Obj.LineSpacing - 1) * 0.95 / 96 * 72) * 20)) +
                   '" w:lineRule="exact"/><w:ind w:left="15"/><w:ind w:firstLine="' + IntToStr(Trunc(Obj.Style.ParagraphGap / 96 * 72 * 20)) + '"/>';

        Write(pPr);

        if Obj <> nil then
        begin
          Write('<w:jc w:val="%s"/>', [GetHAlign(s.HAlign)]);
          Write(GetFont(s.Font, ssNormal, Obj.RTL), {$IFDEF DELPHI12}True{$ELSE}False{$ENDIF});
        end;

        Write('</w:pPr>');

        if (Obj <> nil) and (Obj.Counter = 0) then
        begin
          if (Obj.Image <> nil) and (Obj.Image.Width > 0) then
          begin
            URL := '';
            if Obj.URL <> '' then
            begin
              URL := Format('<a:hlinkClick xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" r:id="rURLId%d"/></wp:docPr>', [FURLNum]);
              WriteRels(Escape(Obj.URL));
            end;
            Write(['<w:r>', GetFont(s.Font), GetPicture(Obj.Image, URL), '</w:r>'], {$IFDEF DELPHI12}True{$ELSE}False{$ENDIF});
          end
          else
            begin
              if Obj.URL <> '' then
                begin
                  Write('<w:hyperlink r:id="rURLId%d">', [FURLNum]);
                  WriteRels(Escape(Obj.URL));
                end;

              if not Obj.HTMLTags or not WriteTaggedText(Obj.Memo.Text, Obj.HTMLTags, obj.RTL, s, Writer) then
                for i := 0 to Obj.Memo.Count - 1 do
                  begin
                    // note: in unicode DELPHI12+ Utf8Encode has no effect: when converted to widestring it does utf8decode automatically
                    Write(['<w:r>', GetFont(s.Font, ssNormal, Obj.RTL), BStr((i > 0) and not ((Obj.Style.ParagraphGap <> 0) and (Obj.Memo.Count > 1) {and (i <> Obj.Memo.Count - 1)}), '<w:br/>'), GetText(String(Utf8Encode(Obj.Memo[i]))), '</w:r>'], {$IFDEF DELPHI12}True{$ELSE}False{$ENDIF});
                    if (Obj.Style.ParagraphGap <> 0) and (Obj.Memo.Count > 1) and (i <> Obj.Memo.Count - 1) then
                      begin
                        if Obj.URL <> '' then
                          Write('</w:hyperlink>');
                        Write(['</w:p><w:p>', pPr]);
                        Write('<w:jc w:val="%s"/>', [GetHAlign(s.HAlign)]);
                        Write(GetFont(s.Font, ssNormal, Obj.RTL), {$IFDEF DELPHI12}True{$ELSE}False{$ENDIF});
                        Write('</w:pPr>');
                        if Obj.URL <> '' then
                          begin
                            Write('<w:hyperlink r:id="rURLId%d">', [FURLNum]);
                            WriteRels(Escape(Obj.URL));
                           end;
                      end;
                  end;

              if Obj.URL <> '' then
                Write('</w:hyperlink>');
            end;
        end;
        Write('</w:p></w:tc>');
        c1 := c2 + 1;

        if Obj <> nil then
          Obj.Counter := 1;
      end;

      Write('</w:tr>');
    end;

    Write('</w:tbl>');
    Free;
  end
  except
      on e: Exception do
        case Report.EngineOptions.NewSilentMode of
          simSilent:        Report.Errors.Add(e.Message);
          simMessageBoxes:  frxErrorMsg(e.Message);
          simReThrow:       raise;
        end;
    end;

  FMatrix.Free;
end;

procedure TfrxDOCXExport.Finish;
var
  Zip: TfrZipArchive;
  f: TStream;
  FileNames: TStrings;
begin
  try
  with TfrxWriter.Create(FDocRels) do
  begin
    Write('</Relationships>');
    Free;
  end;

  with TfrxWriter.Create(FDocument) do
  begin
    Write(['<w:p/>',
      SecPr, '</w:body></w:document>']);

    Free;
  end;
  IOTransport.TempFilter.FreeStream(FDocRels);
  IOTransport.TempFilter.FreeStream(FDocument);

  FileNames := TStringList.Create;
  { close files }
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
    Zip := TfrZipArchive.Create;
    try
      Zip.RootFolder := AnsiString(SubPath(''));
      if not IOTransport.DoFilterProcessStream(f, Self) then
        Zip.SaveToStreamFromList(f, FileNames);
    finally
      Zip.Free;
    end;
  end;

  if not Assigned(Stream) then
    IOTransport.FreeStream(f);

  FileNames.Free;
  except
      on e: Exception do
        case Report.EngineOptions.NewSilentMode of
          simSilent:        Report.Errors.Add(e.Message);
          simMessageBoxes:  frxErrorMsg(e.Message);
          simReThrow:       raise;
        end;
    end;
end;

//suport:

function GetVAlign(a: TfrxVAlign): string;
begin
  case a of
    vaTop: Result := 'top';
    vaBottom: Result := 'bottom';
    vaCenter: Result := 'center';
    else Result := 'top';
  end;
end;

function GetHAlign(a: TfrxHAlign): string;
begin
  case a of
    haLeft: Result := 'left';
    haRight: Result := 'right';
    haCenter: Result := 'center';
    haBlock: Result := 'both';
    else Result := 'left';
  end;
end;

function GetFont(f: TFont; SubType: TSubStyle = ssNormal; RTL: Boolean = false): string;
var
  st: string;
  FontName: String;
begin
  case SubType of
    ssNormal: st:= 'baseline';
    ssSubscript: st := 'subscript';
    ssSuperscript: st := 'superscript';
  end;
{$IFDEF DELPHI12}
  FontName := f.Name;
{$ELSE}
  FontName := UTF8Encode(f.Name);
{$ENDIF}
//Result := Format('<w:rPr><w:rFonts w:ascii="%s" w:hAnsi="%s" w:cs="%s" w:eastAsia="%s" w:hint="eastAsia"/>%s<w:bCs/>%s%s<w:color w:val="%s"/><w:w w:val="105"/>' +
  Result := Format('<w:rPr><w:rFonts w:ascii="%s" w:hAnsi="%s" w:cs="%s" w:eastAsia="%s"/>%s<w:bCs/>%s%s<w:color w:val="%s"/><w:w w:val="105"/>' +
  '<w:sz w:val="%d"/><w:szCs w:val="%d"/>%s<w:vertAlign w:val="%s"/>%s</w:rPr>',
  [FontName, FontName, FontName, FontName, BStr(fsBold in f.Style, '<w:b/>'), BStr(fsItalic in f.Style, '<w:i/>'), BStr(fsStrikeOut in f.Style, '<w:strike/>'), HTMLRGBColor(f.Color), f.Size * 2, f.Size * 2, BStr(fsUnderline in f.Style, '<w:u w:val="single"/>'), st, BStr(RTL, '<w:rtl/>')]);
end;

function BStr(b: Boolean; s: string): string;
begin
  if b then
    Result := s
  else
    Result := '';
end;

function GetText(const s: string): string;
begin
  if s = '' then
    Result := ''
  else
    Result := '<w:t>' + Escape(s) + '</w:t>';
end;

function WriteTaggedText(Text: WideString; HTMLTags, RTL: boolean; AStyle: TfrxIEMStyle; AWriter: TfrxWriter): Boolean;
var
  TagList: TfrxHTMLTagsList;
  sw: {$IFDEF FPCUNICODE}String{$ELSE}WideString{$ENDIF};
  sChunk: String;
  i, iPos: Integer;
  PrevTag, Tag: TfrxHTMLTag;
  SaveFont: TFont;
  ASubType, SaveSubType: TSubStyle;
  bStyleChanged, bEOL, bEOF: Boolean;

  procedure TagToStyle(ATag: TfrxHTMLTag; AStyle: TfrxIEMStyle; var ASubType: TSubStyle);
  begin
    AStyle.Font.Style := ATag.Style;
    AStyle.Font.Color := ATag.Color;
    ASubType := ATag.SubType;
  end;

  function GetSpacedText(const s: string): string;
  begin
    if s = '' then
      Result := ''
    else
      Result := '<w:t xml:space="preserve">' + Escape(s) + '</w:t>';
  end;
  
begin
  Result := False;
  ASubType := ssNormal;
  if not HTMLTags then
    Exit;

  SaveFont := TFont.Create;
  TagList := TfrxHTMLTagsList.Create;
  try
    SaveFont.Assign(AStyle.Font);
    SaveFont.Style := [fsBold];
    SaveSubType := ssNormal;
    sw := Text;
    TagList.ExpandHTMLTags(sw);
    if (TagList.Count = 0) or (TagList.Items[0].Count = 0) then
      Exit;

    PrevTag := TagList.Items[0].Items[0];
    TagToStyle(PrevTag, AStyle, ASubType);
    i := 1;
    iPos := 1;
    repeat
      Tag := TagList.Items[0].Items[i - 1];

      bEOF := i = frxLength(sw);
      bStyleChanged := (Tag.Style <> PrevTag.Style) or (Tag.Color <> PrevTag.Color) or (Tag.SubType <> PrevTag.SubType);
      bEOL := frxCopy(sw, i, Length(sLineBreak)) = sLineBreak;

      if bStyleChanged or bEOL or bEOF then
      begin
        sChunk := GetSpacedText(String(Utf8Encode(frxCopy(sw, iPos, i - iPos))));
        iPos := i;
        if sChunk <> '' then
          AWriter.Write(['<w:r>', GetFont(AStyle.Font, ASubType, RTL), '', sChunk, '</w:r>'], {$IFDEF DELPHI12}True{$ELSE}False{$ENDIF});
      end;

      if bEOL then
      begin
        iPos := i + Length(sLineBreak);
        AWriter.Write(['<w:r>', GetFont(SaveFont, SaveSubType, RTL), BStr(i < Length(sw) - 1, '<w:br/>'), '</w:r>'], {$IFDEF DELPHI12}True{$ELSE}False{$ENDIF});
      end;

      if bStyleChanged then
       TagToStyle(Tag, AStyle, ASubType);

      PrevTag := Tag;
      Inc(i);
    until bEOF;
    Result := True;
  finally
    FreeAndNil(TagList);
    FreeAndNil(SaveFont);
  end;
end;

function StrokedToString(frame: TfrxFrame): String;
begin
  Result := 'stroked="';
  if (frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]) then
    Result := Result + Format('t" strokecolor="%s" strokeweight="%dpt"',[HTMLRGBColor(frame.Color), Round(frame.Width)])
  else
    Result := Result + 'f"';
end;

end.
