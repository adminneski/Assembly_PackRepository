{*******************************************************}
{                                                       }
{                      EhLib 10.2                       }
{                                                       }
{               XML Spreadsheet Format                  }
{                                                       }
{     Copyright (c) 2014-2022 by Dmitry V. Bolshakov    }
{                                                       }
{*******************************************************}

unit XMLSpreadsheetFormatEh;

{$I EhLib.Inc}

interface

uses
  SysUtils, Classes, Graphics, Dialogs, Controls,
  Variants, Clipbrd,
{$IFDEF EH_LIB_17} System.UITypes, System.Contnrs, {$ENDIF}
{$IFDEF FPC}
  LCLIntf,
  {$IFDEF FPC_CROSSP}
  {$ELSE}
    Windows,
  {$ENDIF}
{$ELSE}
  Windows,
{$ENDIF}
  ToolCtrlsEh,
  StdCtrls;
type

  TExportAsXMLSpShOptionEh = (xmlssColoredEh, xmlssDataAsDisplayTextEh,
    xmlssDataAsEditTextEh);
  TExportAsXMLSpShOptionsEh = set of TExportAsXMLSpShOptionEh;

  TSpShLineStyleEh = (lsNoneEh, lsContinuousEh, lsDashEh, lsDotEh, lsDashDotEh,
    lsDashDotDotEh, lsSlantDashDotEh, lsDoubleEh);
  TSpShInteriorPatternEh = (ipNoneEh, ipSolidEh);
  TSpShHorizontalAlignmentEh = (haDefaultEh, haLeftJustifyEh, haRightJustifyEh,
    haCenterEh);
  TSpShVerticalAlignmentEh = (vaDefaultEh, vaTopEh, vaCenterEh, vaBottomEh);
  TSpShBorderPlacementEh = (bpLeftEh, bpTopEh, bpRightEh, bpBottomEh);

  TSpShBorderEh = record
    LineStyle: TSpShLineStyleEh;
    Weight: Integer;
    Color: TColor;
  end;

  TSpShInteriorEh = record
    Pattern: TSpShInteriorPatternEh;
    Color: TColor;
  end;

  TSpShFontEh = record
    Name: String;
    CharSet: Integer;
    Family: String;
    Size: Integer;
    Color: TColor;
    Style: TFontStyles;
  end;

  TSpShMergeCells = record
    ColSpan: Integer;
    RowSpan: Integer;
  end;

  TSpShStyleEh = record
    StyleNum: Integer;
    StyleName: String;

    AlignmentHorizontal: TSpShHorizontalAlignmentEh;
    AlignmentVertical: TSpShVerticalAlignmentEh;
    AlignmentRotate: Integer;
    AlignmentWrapText: Boolean;

    Border: array[TSpShBorderPlacementEh] of TSpShBorderEh;
    Interior: TSpShInteriorEh;
    Font: TSpShFontEh;

    MergeCells: TSpShMergeCells;

    SpShNumberFormat: String;
  end;

  TSpShStyleArrEh = array of TSpShStyleEh;

{ TXMLSpreadsheetExportEh }

  TXMLSpreadsheetExportEh = class(TObject)
  private
    FColCount: Word;
    FRowCount: Word;
    FStyles: TSpShStyleArrEh;
    FXMLStream: TStringStream;
    function AddStyle(AStyle: TSpShStyleEh): String;
  protected
    procedure WriteHeader(AStream: TStringStream);
    procedure WriteStyles(AStream: TStringStream);
  public
    constructor Create;
    destructor Destroy; override;
    procedure InitializeStyle(out AStyle: TSpShStyleEh);
    procedure SetFont(var AStyle: TSpShStyleEh; Font: TFont);
    procedure BeginRow();
    procedure EndRow();
    procedure AddColumn(ColumnWidth: Integer);
    procedure AddCell(AStyle: TSpShStyleEh; const ColIndex: String; const CellType: String; const CellValue: String);
    procedure ExportToStream(AStream: TStream);
  end;

var
  CF_XML_Spreadsheet: Word;

implementation

constructor TXMLSpreadsheetExportEh.Create;
var
  AStyle: TSpShStyleEh;
begin
  inherited Create;

  FXMLStream := TStringStream.Create(''{$IFDEF EH_LIB_13} ,TEncoding.UTF8 {$ENDIF});

  FColCount := 0;
  FRowCount := 0;

  InitializeStyle(AStyle);
  AStyle.StyleNum  := 64;
  AStyle.StyleName := 'Default';
  AddStyle(AStyle);
end;

destructor TXMLSpreadsheetExportEh.Destroy;
begin
  SetLength(FStyles, 0);
  FreeAndNil(FXMLStream);

  inherited Destroy;
end;

procedure TXMLSpreadsheetExportEh.InitializeStyle(out AStyle: TSpShStyleEh);
var
  bp: TSpShBorderPlacementEh;
begin
  AStyle.StyleNum  := 0;
  AStyle.StyleName := '';

  AStyle.AlignmentHorizontal := haDefaultEh;
  AStyle.AlignmentVertical   := vaDefaultEh;
  AStyle.AlignmentRotate     := 0;
  AStyle.AlignmentWrapText   := False;

  for bp := Low(TSpShBorderPlacementEh) to High(TSpShBorderPlacementEh) do
  begin
    AStyle.Border[bp].LineStyle := lsNoneEh;
    AStyle.Border[bp].Weight    := 1;
    AStyle.Border[bp].Color     := clDefault;
  end;

  AStyle.Interior.Pattern := ipNoneEh;
  AStyle.Interior.Color   := clDefault;

  AStyle.Font.Name    := '';
  AStyle.Font.CharSet := -1;
  AStyle.Font.Family  := 'Swiss';
  AStyle.Font.Size    := 11;
  AStyle.Font.Color   := clDefault;
  AStyle.Font.Style   := [];

  AStyle.MergeCells.ColSpan := 0;
  AStyle.MergeCells.RowSpan := 0;

  AStyle.SpShNumberFormat := '';
end;

procedure TXMLSpreadsheetExportEh.SetFont(var AStyle: TSpShStyleEh; Font: TFont);
begin
  AStyle.Font.Name  := Font.Name;
  AStyle.Font.Size  := Font.Size;
  AStyle.Font.Style := Font.Style;
  AStyle.Font.Color := Font.Color;
end;

function TXMLSpreadsheetExportEh.AddStyle(AStyle: TSpShStyleEh): String;
var
  i, ALast: Integer;

  function IsBordersEqual(AStyle1: TSpShStyleEh; AStyle2: TSpShStyleEh): Boolean;
  var
    bp: TSpShBorderPlacementEh;
    IsEqual: Boolean;
  begin
    IsEqual := True;
    for bp := Low(TSpShBorderPlacementEh) to High(TSpShBorderPlacementEh) do
      IsEqual := IsEqual
                 and (AStyle1.Border[bp].LineStyle = AStyle2.Border[bp].LineStyle)
                 and (AStyle1.Border[bp].Weight    = AStyle2.Border[bp].Weight)
                 and (AStyle1.Border[bp].Color     = AStyle2.Border[bp].Color);
    Result := IsEqual;
  end;
begin
  Result := '';
  for i := 0 to Length(FStyles)-1 do
  begin
    if (FStyles[i].AlignmentHorizontal   = AStyle.AlignmentHorizontal)
       and (FStyles[i].AlignmentVertical = AStyle.AlignmentVertical)
       and (FStyles[i].AlignmentRotate   = AStyle.AlignmentRotate)
       and (FStyles[i].AlignmentWrapText = AStyle.AlignmentWrapText)

       and IsBordersEqual(FStyles[i], AStyle)

       and (FStyles[i].Interior.Pattern = AStyle.Interior.Pattern)
       and (FStyles[i].Interior.Color   = AStyle.Interior.Color)

       and (FStyles[i].Font.Name    = AStyle.Font.Name)
       and (FStyles[i].Font.CharSet = AStyle.Font.CharSet)
       and (FStyles[i].Font.Family  = AStyle.Font.Family)
       and (FStyles[i].Font.Size    = AStyle.Font.Size)
       and (FStyles[i].Font.Color   = AStyle.Font.Color)
       and (FStyles[i].Font.Style   = AStyle.Font.Style)

       and (FStyles[i].SpShNumberFormat = AStyle.SpShNumberFormat)
    then
    begin
      Result := FStyles[i].StyleName;
      Break;
    end;
  end;

  if Result = '' then
  begin
    ALast := Length(FStyles);
    SetLength(FStyles, Length(FStyles) + 1);

    if AStyle.StyleNum = 0 then
    begin
      if ALast = 0 then
        AStyle.StyleNum := 1
      else
        AStyle.StyleNum := FStyles[ALast-1].StyleNum + 1;
      AStyle.StyleName := 's' + IntToStr(AStyle.StyleNum);
    end;

    FStyles[ALast] := AStyle;

    Result := FStyles[ALast].StyleName;
  end;
end;

procedure TXMLSpreadsheetExportEh.BeginRow();
begin
  FXMLStream.WriteString('    <Row>');
  FXMLStream.WriteString(sLineBreak);
end;

procedure TXMLSpreadsheetExportEh.EndRow();
begin
  FXMLStream.WriteString('    </Row>');
  FXMLStream.WriteString(sLineBreak);
  Inc(FRowCount);
end;

procedure TXMLSpreadsheetExportEh.AddColumn(ColumnWidth: Integer);
begin
  FXMLStream.WriteString('    <Column');
  FXMLStream.WriteString(' ss:Width="' + SysFloatToStr(ColumnWidth * 72 / 96) + '"');
  FXMLStream.WriteString(' ss:AutoFitWidth="0"');
  FXMLStream.WriteString('/>');
  FXMLStream.WriteString(sLineBreak);
  Inc(FColCount);
end;

procedure TXMLSpreadsheetExportEh.AddCell(AStyle: TSpShStyleEh; const ColIndex: String; const CellType: String; const CellValue: String);
var
  StyleName: String;

  function StrToXMLValue(S: String): String;
  begin
    Result := StringReplace(S,   '&', '&amp;',[rfReplaceAll]);
    Result := StringReplace(Result, '<', '&lt;',[rfReplaceAll]);
    Result := StringReplace(Result, '>', '&gt;',[rfReplaceAll]);
    {$IFDEF EH_LIB_13}
    {$ELSE}
    Result := String(AnsiToUtf8(Result));
    {$ENDIF}
  end;

begin
  StyleName := AddStyle(AStyle);
  FXMLStream.WriteString('      <Cell');
  if ColIndex <> '' then
    FXMLStream.WriteString(' ss:Index="' + ColIndex + '"');
  if (StyleName <> '') and (StyleName <> 'Default') then
    FXMLStream.WriteString(' ss:StyleID="' + StyleName + '"');
  if AStyle.MergeCells.ColSpan > 0 then
    FXMLStream.WriteString(' ss:MergeAcross="' + IntToStr(AStyle.MergeCells.ColSpan) + '"');
  if AStyle.MergeCells.RowSpan > 0 then
    FXMLStream.WriteString(' ss:MergeDown="' + IntToStr(AStyle.MergeCells.RowSpan) + '"');
  FXMLStream.WriteString('>');
  FXMLStream.WriteString('<Data ss:Type="' + CellType + '">');
  FXMLStream.WriteString(StrToXMLValue(CellValue));
  FXMLStream.WriteString('</Data>');
  FXMLStream.WriteString('</Cell>');
  FXMLStream.WriteString(sLineBreak);
end;

procedure TXMLSpreadsheetExportEh.WriteHeader(AStream: TStringStream);
begin
  AStream.WriteString('<?xml version="1.0"?>');
  AStream.WriteString(sLineBreak);
  AStream.WriteString('<?mso-application progid="Excel.Sheet"?>');
  AStream.WriteString(sLineBreak);
  AStream.WriteString('<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"');
  AStream.WriteString(sLineBreak);
  AStream.WriteString(' xmlns:o="urn:schemas-microsoft-com:office:office"');
  AStream.WriteString(sLineBreak);
  AStream.WriteString(' xmlns:x="urn:schemas-microsoft-com:office:excel"');
  AStream.WriteString(sLineBreak);
  AStream.WriteString(' xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"');
  AStream.WriteString(sLineBreak);
  AStream.WriteString(' xmlns:html="http://www.w3.org/TR/REC-html40">');
  AStream.WriteString(sLineBreak);
end;

procedure TXMLSpreadsheetExportEh.WriteStyles(AStream: TStringStream);
var
  i: Integer;
  bp: TSpShBorderPlacementEh;
  create_borders: Boolean;

  function ColorToHex(AColor: TColor): String;
  begin
    Result :=
      IntToHex(GetRValue(ColorToRGB(AColor)), 2) +
      IntToHex(GetGValue(ColorToRGB(AColor)), 2) +
      IntToHex(GetBValue(ColorToRGB(AColor)), 2);
  end;

begin
  AStream.WriteString('  <Styles>');
  AStream.WriteString(sLineBreak);
  for i := 0 to Length(FStyles)-1 do
  begin
    AStream.WriteString('  <Style');
    AStream.WriteString(' ss:ID="' + FStyles[i].StyleName + '"');
    AStream.WriteString('>');
    AStream.WriteString(sLineBreak);
    if FStyles[i].SpShNumberFormat <> '' then
    begin
      AStream.WriteString('    <NumberFormat');
      AStream.WriteString(' ss:Format="' + FStyles[i].SpShNumberFormat + '"');
      AStream.WriteString('/>');
      AStream.WriteString(sLineBreak);
    end;

    if (FStyles[i].AlignmentHorizontal   <> haDefaultEh)
        or (FStyles[i].AlignmentVertical <> vaDefaultEh)
        or (FStyles[i].AlignmentRotate   <> 0)
        or (FStyles[i].AlignmentWrapText <> False)
    then
    begin
      AStream.WriteString('    <Alignment');
      case FStyles[i].AlignmentHorizontal of
        haLeftJustifyEh:  AStream.WriteString(' ss:Horizontal="Left"');
        haCenterEh:       AStream.WriteString(' ss:Horizontal="Center"');
        haRightJustifyEh: AStream.WriteString(' ss:Horizontal="Right"');
      end;
      case FStyles[i].AlignmentVertical of
        vaTopEh:    AStream.WriteString(' ss:Vertical="Top"');
        vaCenterEh: AStream.WriteString(' ss:Vertical="Center"');
        vaBottomEh: AStream.WriteString(' ss:Vertical="Bottom"');
      end;
      if FStyles[i].AlignmentRotate <> 0 then
        AStream.WriteString(' ss:Rotate="' + IntToStr(FStyles[i].AlignmentRotate) + '"');
      if FStyles[i].AlignmentWrapText then
        AStream.WriteString(' ss:WrapText="1"');
      AStream.WriteString('/>');
      AStream.WriteString(sLineBreak);
    end;

    create_borders := False;
    for bp := Low(TSpShBorderPlacementEh) to High(TSpShBorderPlacementEh) do
      if FStyles[i].Border[bp].LineStyle <> lsNoneEh then
      begin
        create_borders := True;
        Break;
      end;
    if create_borders then
    begin
      AStream.WriteString('    <Borders>');
      AStream.WriteString(sLineBreak);
      for bp := Low(TSpShBorderPlacementEh) to High(TSpShBorderPlacementEh) do
        if FStyles[i].Border[bp].LineStyle <> lsNoneEh then
        begin
          AStream.WriteString('      <Border');
          AStream.WriteString(' ss:LineStyle="Continuous"');
          AStream.WriteString(' ss:Weight="' + IntToStr(FStyles[i].Border[bp].Weight) + '"');
          case bp of
            bpLeftEh:   AStream.WriteString(' ss:Position="Left"');
            bpTopEh:    AStream.WriteString(' ss:Position="Top"');
            bpRightEh:  AStream.WriteString(' ss:Position="Right"');
            bpBottomEh: AStream.WriteString(' ss:Position="Bottom"');
          end;
          AStream.WriteString(' ss:Color="#' + ColorToHex(FStyles[i].Border[bp].Color) + '"');
          AStream.WriteString('/>');
          AStream.WriteString(sLineBreak);
        end;
      AStream.WriteString('    </Borders>');
      AStream.WriteString(sLineBreak);
    end;
    AStream.WriteString('    <Font');
    if FStyles[i].Font.Name <> '' then
      AStream.WriteString(' ss:FontName="' + FStyles[i].Font.Name + '"');
    if fsBold in FStyles[i].Font.Style then
      AStream.WriteString(' ss:Bold="1"');
    if fsItalic in FStyles[i].Font.Style then
      AStream.WriteString(' ss:Italic="1"');
    if fsUnderline in FStyles[i].Font.Style then
      AStream.WriteString(' ss:Underline="Single"');
    if fsStrikeOut in FStyles[i].Font.Style then
      AStream.WriteString(' ss:StrikeThrough="1"');
    if FStyles[i].Font.Color <> clDefault then
      AStream.WriteString(' ss:Color="#' + ColorToHex(FStyles[i].Font.Color) + '"');
    AStream.WriteString(' ss:Size="' + IntToStr(FStyles[i].Font.Size) + '"');
    AStream.WriteString('/>');
    AStream.WriteString(sLineBreak);

    if FStyles[i].Interior.Color <> clDefault then
    begin
      AStream.WriteString('    <Interior');
      AStream.WriteString(' ss:Color="#' + ColorToHex(FStyles[i].Interior.Color) + '"');
      AStream.WriteString(' ss:Pattern="Solid"');
      AStream.WriteString('/>');
      AStream.WriteString(sLineBreak);
    end;
    AStream.WriteString('  </Style>');
    AStream.WriteString(sLineBreak);
  end;
  AStream.WriteString('  </Styles>');
  AStream.WriteString(sLineBreak);
end;

procedure TXMLSpreadsheetExportEh.ExportToStream(AStream: TStream);
var
  SpShStream: TStringStream;
begin
  SpShStream := TStringStream.Create(''{$IFDEF EH_LIB_13} ,TEncoding.UTF8 {$ENDIF});
  WriteHeader(SpShStream);
  WriteStyles(SpShStream);
  SpShStream.WriteString('  <Worksheet ss:Name="Sheet1">');
  SpShStream.WriteString(sLineBreak);
  SpShStream.WriteString('  <Table');
  SpShStream.WriteString(' ss:ExpandedColumnCount="' + IntToStr(FColCount) + '"');
  SpShStream.WriteString(' ss:ExpandedRowCount="' + IntToStr(FRowCount) + '"');
  SpShStream.WriteString(' x:FullColumns="1"');
  SpShStream.WriteString(' x:FullRows="1"');
  SpShStream.WriteString('>');
  SpShStream.WriteString(sLineBreak);

  SpShStream.WriteString(FXMLStream.DataString);

  SpShStream.WriteString('  </Table>');
  SpShStream.WriteString(sLineBreak);
  SpShStream.WriteString('  </Worksheet>');
  SpShStream.WriteString(sLineBreak);
  SpShStream.WriteString('</Workbook>');
  SpShStream.WriteString(sLineBreak);

  AStream.CopyFrom(SpShStream, 0);

  FreeAndNil(SpShStream);
end;

initialization
  CF_XML_Spreadsheet := RegisterClipboardFormat('XML Spreadsheet');
end.
