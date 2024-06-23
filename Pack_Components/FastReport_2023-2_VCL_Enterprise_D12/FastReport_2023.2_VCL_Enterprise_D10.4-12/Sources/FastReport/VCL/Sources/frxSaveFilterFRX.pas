
{******************************************}
{                                          }
{             FastReport VCL               }
{             Convert to .FRX              }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxSaveFilterFRX;

interface

{$I frx.inc}

uses
  Windows, Classes, Graphics, Printers, SysUtils, Controls, Forms, StdCtrls,
  ComCtrls, frxClass, frXML, frUnicodeUtils, frxVariables, frxUtils, frxEngine,
  Variants, frxBarcode, frxChBox, frxRich, frxNetUtils, frxDesgn, frxDCtrl,
{$IFDEF DELPHI16}
  System.UITypes,
{$ENDIF}
  frHashUtils;

type
  TfrxSaveFRX = class(TfrxIOTransportFile)
  private
    procedure ConvertReport(root: TfrXmlItem);
    procedure ConvertVariables(root: TfrXmlItem);
    procedure ConvertReportPage(Page: TfrxReportPage; root: TfrXmlItem);
    function ConvertBand(Band: TfrxBand; root: TfrXmlItem): TfrXmlItem;
    procedure ConvertReportObject(Obj: TfrxView; root: TfrXmlItem);
    procedure ConvertMemo(Memo: TfrxCustomMemoView; root: TfrXmlItem);
    procedure ConvertPicture(Picture: TfrxPictureView; root: TfrXmlItem);
    procedure ConvertLine(Line: TfrxLineView; root: TfrXmlItem);
    procedure ConvertShape(Shape: TfrxShapeView; root: TfrXmlItem);
    procedure ConvertSubreport(Subreport: TfrxSubreport; root: TfrXmlItem);
    procedure ConvertBarcode(Barcode: TfrxBarcodeView; root: TfrXmlItem);
    procedure ConvertRich(Rich: TfrxRichView; root: TfrXmlItem);
    procedure ConvertCheckBox(CheckBox: TfrxCheckBoxView; root: TfrXmlItem);

    procedure ConvertDialogPage(Page: TfrxDialogPage; root: TfrXmlItem);
    procedure ConvertDialogControl(Control: TfrxDialogControl; root: TfrXmlItem);
    procedure ConvertDialogButton(Button: TfrxButtonControl; root: TfrXmlItem);
    procedure ConvertDialogLabel(Lbl: TfrxLabelControl; root: TfrXmlItem);
    procedure ConvertDialogEdit(Edit: TfrxCustomEditControl; root: TfrXmlItem);
    procedure ConvertDialogCheckBox(CheckBox: TfrxCheckBoxControl; root: TfrXmlItem);
    procedure ConvertDialogRadioButton(RadioButton: TfrxRadioButtonControl; root: TfrXmlItem);
    procedure ConvertDialogListBox(ListBox: TfrxListBoxControl; root: TfrXmlItem);
    procedure ConvertDialogComboBox(ComboBox: TfrxComboBoxControl; root: TfrXmlItem);
    procedure ConvertDialogPanel(Panel: TfrxPanelControl; root: TfrXmlItem);
    procedure ConvertDialogGroupBox(GroupBox: TfrxGroupBoxControl; root: TfrXmlItem);
    procedure ConvertDialogDateEdit(DateEdit: TfrxDateEditControl; root: TfrXmlItem);
    procedure ConvertDialogImage(Image: TfrxImageControl; root: TfrXmlItem);
    procedure ConvertDialogCheckListBox(CheckListBox: TfrxCheckListBoxControl; root: TfrXmlItem);

    procedure ConvertFrame(Frame: TfrxFrame; root: TfrXmlItem);
    procedure ConvertFrameLine(Line: TfrxFrameLine; Name: String; root: TfrXmlItem);
    procedure ConvertFont(Font: TFont; Name: String; root: TfrXmlItem);
  public
    constructor Create(AOwner: TComponent); override;
    function DoFilterProcessStream(aStream: TStream; ProcesssingObject: TObject): Boolean; override;
    class function GetDescription: String; override;
  end;


implementation

function frxFloatToStr(d: Extended): String;
var
  i: Integer;
begin
  if Int(d) = d then
    Result := FloatToStr(d) else
    Result := Format('%2.2f', [d]);

  for i := 1 to Length(Result) do
  begin
{$IFDEF DELPHI12}
    if CharInSet(Result[i], [',', ' ']) then
{$ELSE}
    if Result[i] in [',', ' '] then
{$ENDIF}
      Result[i] := '.';
  end;
end;

function frxColorToStr(Color: TColor): String;
var
  l: LongInt;
begin
  l := ColorToRGB(Color);
  Result := IntToStr(l mod 256);
  l := l div 256;
  Result := Result + ', ' + IntToStr(l mod 256);
  l := l div 256;
  Result := Result + ', ' + IntToStr(l mod 256);
end;

function frxStreamToBase64String(Stream: TStream): AnsiString;
var
  Size: Integer;
  p: AnsiString;
begin
  Size := Stream.Size;
  SetLength(p, Size);

  Stream.Position := 0;
  Stream.Read(p[1], Size);

  Result := frBase64Encode(p);
end;

function frxLinesToStr(Lines: String): String;
begin
  Result := Lines;
  if Length(Lines) > 2 then
    if (Lines[Length(Lines) - 1] = #13) and (Lines[Length(Lines)] = #10) then
      Result := Copy(Result, 1, Length(Result) - 2);
end;

constructor TfrxSaveFRX.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  FilterString := 'FastReport.Net file (*.frx)|*.frx';
  FVisibility := [fvDesignerFileFilter];
  DefaultExt := '.frx'
end;

function TfrxSaveFRX.DoFilterProcessStream(aStream: TStream;
  ProcesssingObject: TObject): Boolean;
var
  doc: TfrXMLDocument;
begin
  Result := False;
  if (aStream = nil) or (Report = nil) then Exit;
  doc := TfrXMLDocument.Create();
  try
    ConvertReport(doc.Root);

    doc.AutoIndent := True;
    aStream.Size := 0;
    doc.SaveToStream(aStream);
    Result := True;
  finally
    doc.Free;
  end;
end;


class function TfrxSaveFRX.GetDescription: String;
begin
  Result := 'FastReport.Net file';
end;

procedure TfrxSaveFRX.ConvertReport(root: TfrXmlItem);
var
  dictRoot: TfrXmlItem;
  version, script: String;
  i: Integer;
begin
  root.Name := 'Report';

  script := StringReplace(Report.ScriptText.Text, #13#10, '', [rfReplaceAll]);
  if script <> 'beginend.' then
  begin
    script := 'using System;' + #13#10 +
      'using System.Collections;' + #13#10 +
      'using System.Collections.Generic;' + #13#10 +
      'using System.ComponentModel;' + #13#10 +
      'using System.Windows.Forms;' + #13#10 +
      'using System.Drawing;' + #13#10 +
      'using System.Data;' + #13#10 +
      'using FastReport;' + #13#10 +
      'using FastReport.Data;' + #13#10 +
      'using FastReport.Dialog;' + #13#10 +
      'using FastReport.Barcode;' + #13#10 +
      'using FastReport.Table;' + #13#10 +
      'using FastReport.Utils;' + #13#10 +
      '' + #13#10 +
      'namespace FastReport' + #13#10 +
      '{' + #13#10 +
      '  public class ReportScript' + #13#10 +
      '  {' + #13#10 +
      '  }' + #13#10 +
      '}' + #13#10;
{$IFDEF DELPHI12}
    root.Prop['ScriptText'] := script + '/*' + Report.ScriptText.Text + '*/';
{$ELSE}
    root.Prop['ScriptText'] := UTF8Encode(script + '/*' + Report.ScriptText.Text + '*/');
{$ENDIF}
  end;

{$IFDEF DELPHI12}
  root.Prop['ReportInfo.Name'] := Report.ReportOptions.Name;
  root.Prop['ReportInfo.Author'] := Report.ReportOptions.Author;
  root.Prop['ReportInfo.Description'] := Report.ReportOptions.Description.Text;
{$ELSE}
  root.Prop['ReportInfo.Name'] := UTF8Encode(Report.ReportOptions.Name);
  root.Prop['ReportInfo.Author'] := UTF8Encode(Report.ReportOptions.Author);
  root.Prop['ReportInfo.Description'] := UTF8Encode(Report.ReportOptions.Description.Text);
{$ENDIF}
  version := Report.ReportOptions.VersionMajor + '.' +
    Report.ReportOptions.VersionMinor + '.' +
    Report.ReportOptions.VersionRelease + '.' +
    Report.ReportOptions.VersionBuild;
  if version <> '...' then
{$IFDEF DELPHI12}
    root.Prop['ReportInfo.Version'] := version;
{$ELSE}
    root.Prop['ReportInfo.Version'] := UTF8Encode(version);
{$ENDIF}

  dictRoot := root.Add;
  dictRoot.Name := 'Dictionary';
  ConvertVariables(dictRoot);

  // prepare band tree
  (Report.Engine as TfrxEngine).Initialize;

  for i := 0 to Report.PagesCount - 1 do
  begin
    if Report.Pages[i] is TfrxReportPage then
      ConvertReportPage(Report.Pages[i] as TfrxReportPage, root)
    else if Report.Pages[i] is TfrxDialogPage then
      ConvertDialogPage(Report.Pages[i] as TfrxDialogPage, root)
  end;

  (Report.Engine as TfrxEngine).Finalize;
end;

procedure TfrxSaveFRX.ConvertVariables(root: TfrXmlItem);
var
  i: Integer;
  v: TfrxVariable;
  xi: TfrXmlItem;
begin
  for i := 0 to Report.Variables.Count - 1 do
  begin
    v := Report.Variables.Items[i];
    if (v.Name <> '') and (v.Name[1] <> ' ') then
    begin
      xi := root.Add;
      xi.Name := 'Parameter';
{$IFDEF DELPHI12}
      xi.Prop['Name'] := v.Name;
{$ELSE}
      xi.Prop['Name'] := UTF8Encode(v.Name);
{$ENDIF}
      if v.Value <> null then
      begin
        if (TVarData(v.Value).VType = varString) or
          (TVarData(v.Value).VType = varOleStr)
          {$IFDEF DELPHI12} or (TVarData(v.Value).VType = varUString){$ENDIF} then
          if v.Value <> '' then
{$IFDEF DELPHI12}
            xi.Prop['Expression'] := v.Value;
{$ELSE}
            xi.Prop['Expression'] := UTF8Encode(v.Value);
{$ENDIF}
      end;
    end;
  end;
end;


{------------------------------------------------------------------------------}
procedure TfrxSaveFRX.ConvertReportPage(Page: TfrxReportPage; root: TfrXmlItem);
var
  i: Integer;
  pageItem: TfrXmlItem;
  band: TfrxBand;
  hasReportTitle: Boolean;
  hasOverlay: Boolean;
  h: Extended;
begin
  pageItem := root.Add;
  pageItem.Name := 'ReportPage';
  pageItem.Prop['Name'] := Page.Name;
  if Page.Orientation = poLandscape then
    pageItem.Prop['Landscape'] := 'true';
  pageItem.Prop['PaperWidth'] := frxFloatToStr(Page.PaperWidth);
  pageItem.Prop['PaperHeight'] := frxFloatToStr(Page.PaperHeight);
  pageItem.Prop['LeftMargin'] := frxFloatToStr(Page.LeftMargin);
  pageItem.Prop['RightMargin'] := frxFloatToStr(Page.RightMargin);
  pageItem.Prop['TopMargin'] := frxFloatToStr(Page.TopMargin);
  pageItem.Prop['BottomMargin'] := frxFloatToStr(Page.BottomMargin);
  pageItem.Prop['Columns.Count'] := IntToStr(Page.Columns);
  pageItem.Prop['Columns.Width'] := frxFloatToStr(Page.ColumnWidth);

  if Page.PrintOnPreviousPage then
    pageItem.Prop['PrintOnPreviousPage'] := 'true';
  if Page.MirrorMargins then
    pageItem.Prop['MirrorMargins'] := 'true';
  if Page.OutlineText <> '' then
{$IFDEF DELPHI12}
    pageItem.Prop['OutlineExpression'] := Page.OutlineText;
{$ELSE}
    pageItem.Prop['OutlineExpression'] := UTF8Encode(Page.OutlineText);
{$ENDIF}
  if Page.TitleBeforeHeader then
    pageItem.Prop['TitleBeforeHeader'] := 'true';
  if Page.Bin <> DMBIN_AUTO then
    pageItem.Prop['FirstPageSource'] := IntToStr(Page.Bin);
  if Page.BinOtherPages <> DMBIN_AUTO then
    pageItem.Prop['OtherPagesSource'] := IntToStr(Page.BinOtherPages);

  hasReportTitle := false;
  hasOverlay := false;

  for i := 0 to Page.Objects.Count - 1 do
  begin
    if TObject(Page.Objects[i]) is TfrxBand then
    begin
      band := TObject(Page.Objects[i]) as TfrxBand;
      if (band is TfrxReportTitle) or (band is TfrxReportSummary) or
        (band is TfrxPageHeader) or (band is TfrxPageFooter) or
        (band is TfrxColumnHeader) or (band is TfrxColumnFooter) or
        (band is TfrxOverlay) then
        ConvertBand(band, pageItem);

      if band is TfrxReportTitle then
        hasReportTitle := true;
      if band is TfrxOverlay then
        hasOverlay := true;
    end;
  end;

  band := nil;
  if not hasReportTitle then
    band := TfrxReportTitle.Create(nil)
  else if not hasOverlay then
    band := TfrxOverlay.Create(nil);

  if band <> nil then
  begin
    for i := 0 to Page.Objects.Count - 1 do
    begin
      if TObject(Page.Objects[i]) is TfrxView then
      begin
        band.Objects.Add(Page.Objects[i]);
        with TObject(Page.Objects[i]) as TfrxView do
          h := Top + Height;
        if h > band.Height then
          band.Height := h;
      end;
    end;

    band.Name := band.BaseName + '1';
    if band.Objects.Count <> 0 then
      ConvertBand(band, pageItem);
  end;

  if band <> nil then
  begin
    band.Objects.Clear;
    band.Free;
  end;

  for i := 0 to Page.FSubBands.Count - 1 do
  begin
    band := TObject(Page.FSubBands[i]) as TfrxBand;
    ConvertBand(band, pageItem);
  end;
end;

function TfrxSaveFRX.ConvertBand(Band: TfrxBand; root: TfrXmlItem): TfrXmlItem;
var
  i: Integer;
  bandItem: TfrXmlItem;
  groupBand: TfrxGroupHeader;
  dataBand: TfrxDataBand;
const
  bands: array[0..BND_COUNT - 1] of String =
    ('ReportTitleBand', 'ReportSummaryBand', 'PageHeaderBand', 'PageFooterBand',
     'DataHeaderBand', 'DataFooterBand', 'DataBand', 'DataBand', 'DataBand',
     'DataBand', 'DataBand', 'DataBand', 'GroupHeaderBand', 'GroupFooterBand',
     'ChildBand', 'ColumnHeaderBand', 'ColumnFooterBand', 'OverlayBand');
begin
  if Band.Vertical then
  begin
    Result := root;
    Exit;
  end;

  if (Band is TfrxDataBand) and (Band.FGroup <> nil) then
  begin
    groupBand := Band.FGroup as TfrxGroupHeader;
    for i := 0 to groupBand.FSubBands.Count - 1 do
    begin
      root := ConvertBand(TfrxBand(groupBand.FSubBands[i]), root);
    end;
  end;

  bandItem := root.Add;
  bandItem.Name := bands[Band.BandNumber];
  bandItem.Prop['Name'] := Band.Name;
  bandItem.Prop['Height'] := frxFloatToStr(Band.Height);

  if Band.Stretched then
  begin
    bandItem.Prop['CanGrow'] := 'true';
    bandItem.Prop['CanShrink'] := 'true';
  end;

  if Band.AllowSplit then
    bandItem.Prop['CanBreak'] := 'true';

  if Band.KeepChild then
    bandItem.Prop['KeepChild'] := 'true';

  if Band.StartNewPage then
    bandItem.Prop['StartNewPage'] := 'true';

  if Band.OutlineText <> '' then
{$IFDEF DELPHI12}
    bandItem.Prop['OutlineExpression'] := Band.OutlineText;
{$ELSE}
    bandItem.Prop['OutlineExpression'] := UTF8Encode(Band.OutlineText);
{$ENDIF}

  if Band is TfrxDataBand then
  begin
    dataBand := Band as TfrxDataBand;

    if dataBand.Columns > 1 then
    begin
      bandItem.Prop['Columns.Count'] := IntToStr(dataBand.Columns);
      bandItem.Prop['Columns.Width'] := frxFloatToStr(dataBand.ColumnWidth);
    end;

    if dataBand.DataSet <> nil then
{$IFDEF DELPHI12}
      bandItem.Prop['DataSource'] := dataBand.DataSet.Name;
{$ELSE}
      bandItem.Prop['DataSource'] := UTF8Encode(dataBand.DataSet.Name);
{$ENDIF}

    if dataBand.KeepTogether then
      bandItem.Prop['KeepTogether'] := 'true';

    if dataBand.PrintIfDetailEmpty then
      bandItem.Prop['PrintIfDetailEmpty'] := 'true';

    if Band.FHeader <> nil then
      ConvertBand(Band.FHeader, bandItem);

    for i := 0 to Band.FSubBands.Count - 1 do
    begin
      ConvertBand(TfrxBand(Band.FSubBands[i]), bandItem);
    end;

    if Band.FFooter <> nil then
      ConvertBand(Band.FFooter, bandItem);
  end;

  if Band is TfrxGroupHeader then
  begin
    groupBand := Band as TfrxGroupHeader;

    if groupBand.Condition <> '' then
{$IFDEF DELPHI12}
      bandItem.Prop['Condition'] := groupBand.Condition;
{$ELSE}
      bandItem.Prop['Condition'] := UTF8Encode(groupBand.Condition);
{$ENDIF}

    if groupBand.KeepTogether then
      bandItem.Prop['KeepTogether'] := 'true';

    if groupBand.ReprintOnNewPage then
      bandItem.Prop['RepeatOnEveryPage'] := 'true';

    if groupBand.ResetPageNumbers then
      bandItem.Prop['ResetPageNumber'] := 'true';

    if Band.FFooter <> nil then
      ConvertBand(Band.FFooter, bandItem);
  end;

  if Band.Child <> nil then
    ConvertBand(Band.Child, bandItem);

  for i := 0 to Band.Objects.Count - 1 do
  begin
    ConvertReportObject(TfrxView(Band.Objects[i]), bandItem);
  end;

  Result := bandItem;
end;

procedure TfrxSaveFRX.ConvertReportObject(Obj: TfrxView; root: TfrXmlItem);
var
  objItem: TfrXmlItem;
  objClass: String;
const
  brushStyles: array [0..7] of String = (
    'Solid', 'Clear', 'Horizontal', 'Vertical', 'ForwardDiagonal',
    'BackwardDiagonal', 'LargeGrid', 'OutlinedDiamond');
begin
  objItem := root.Add;

{$IFDEF DELPHI12}
  objItem.Prop['Name'] := Obj.Name;
{$ELSE}
  objItem.Prop['Name'] := UTF8Encode(Obj.Name);
{$ENDIF}
  objItem.Prop['Left'] := frxFloatToStr(Obj.Left);
  objItem.Prop['Top'] := frxFloatToStr(Obj.Top);
  objItem.Prop['Width'] := frxFloatToStr(Obj.Width);
  objItem.Prop['Height'] := frxFloatToStr(Obj.Height);

  if not Obj.Visible then
    objItem.Prop['Visible'] := 'false';

  if not Obj.Printable then
    objItem.Prop['Printable'] := 'false';

  if Obj.BrushStyle <> bsSolid then
  begin
    objItem.Prop['Fill'] := 'Hatch';
    objItem.Prop['Fill.Style'] := brushStyles[Integer(Obj.BrushStyle)];
    objItem.Prop['Fill.BackColor'] := frxColorToStr(Obj.Color);
  end
  else if Obj.Color <> clTransparent then
    objItem.Prop['Fill.Color'] := frxColorToStr(Obj.Color);

  if Obj.Cursor = crHandPoint then
    objItem.Prop['Cursor'] := 'Hand';

  ConvertFrame(Obj.Frame, objItem);

  if Obj.ShiftMode = smDontShift then
    objItem.Prop['ShiftMode'] := 'Never'
  else if Obj.ShiftMode = smWhenOverlapped then
    objItem.Prop['ShiftMode'] := 'WhenOverlapped';

  if Obj.URL <> '' then
  begin
    if Pos('@', Obj.URL) = 1 then
    begin
      objItem.Prop['Hyperlink.Kind'] := 'PageNumber';
{$IFDEF DELPHI12}
      objItem.Prop['Hyperlink.Value'] := Copy(Obj.URL, 2, 255);
{$ELSE}
      objItem.Prop['Hyperlink.Value'] := UTF8Encode(Copy(Obj.URL, 2, 255));
{$ENDIF}
    end
    else if Pos('#', Obj.URL) = 1 then
    begin
      objItem.Prop['Hyperlink.Kind'] := 'Bookmark';
{$IFDEF DELPHI12}
      objItem.Prop['Hyperlink.Value'] := Copy(Obj.URL, 2, 255);
{$ELSE}
      objItem.Prop['Hyperlink.Value'] := UTF8Encode(Copy(Obj.URL, 2, 255));
{$ENDIF}
    end
    else
    begin
{$IFDEF DELPHI12}
      objItem.Prop['Hyperlink.Value'] := Obj.URL;
{$ELSE}
      objItem.Prop['Hyperlink.Value'] := UTF8Encode(Obj.URL);
{$ENDIF}
    end;
  end;

  if (Obj.DataSetName <> '') and (Obj.DataField <> '') and
    not (Obj is TfrxCustomMemoView) then
{$IFDEF DELPHI12}
    objItem.Prop['DataColumn'] := Obj.DataSetName + '.' + Obj.DataField;
{$ELSE}
    objItem.Prop['DataColumn'] := UTF8Encode(Obj.DataSetName + '.' + Obj.DataField);
{$ENDIF}

  if Obj is TfrxCustomMemoView then
  begin
    objClass := 'TextObject';
    ConvertMemo(Obj as TfrxCustomMemoView, objItem);
  end
  else if Obj is TfrxPictureView then
  begin
    objClass := 'PictureObject';
    ConvertPicture(Obj as TfrxPictureView, objItem);
  end
  else if Obj is TfrxLineView then
  begin
    objClass := 'LineObject';
    ConvertLine(Obj as TfrxLineView, objItem);
  end
  else if Obj is TfrxShapeView then
  begin
    objClass := 'ShapeObject';
    ConvertShape(Obj as TfrxShapeView, objItem);
  end
  else if Obj is TfrxSubReport then
  begin
    objClass := 'SubreportObject';
    ConvertSubreport(Obj as TfrxSubreport, objItem);
  end
  else if Obj is TfrxBarcodeView then
  begin
    objClass := 'BarcodeObject';
    ConvertBarcode(Obj as TfrxBarcodeView, objItem);
  end
  else if Obj is TfrxRichView then
  begin
    objClass := 'RichObject';
    ConvertRich(Obj as TfrxRichView, objItem);
  end
  else if Obj is TfrxCheckBoxView then
  begin
    objClass := 'CheckBoxObject';
    ConvertCheckBox(Obj as TfrxCheckBoxView, objItem);
  end;

  objItem.Name := objClass;
end;

procedure TfrxSaveFRX.ConvertMemo(Memo: TfrxCustomMemoView; root: TfrXmlItem);
var
  hltItem: TfrXmlItem;
  s, s1, s2, dc1, dc2: String;
  i, j: Integer;
const
  haligns: array [0..3] of String = (
    'Left', 'Right', 'Center', 'Justify');
  valigns: array [0..2] of String = (
    'Top', 'Bottom', 'Center');
begin
  ConvertFont(Memo.Font, 'Font', root);
  s := memo.Text;
  if (Length(s) > 1) and (Copy(s, Length(s) - 1, 2) = #13#10) then
    s := Copy(s, 1, Length(s) - 2);

  i := 1;
  dc1 := Memo.ExpressionDelimiters;
  dc2 := Copy(dc1, Pos(',', dc1) + 1, 255);
  dc1 := Copy(dc1, 1, Pos(',', dc1) - 1);

  if Pos(dc1, s) <> 0 then
  begin
    repeat
      while (i < Length(s)) and (Copy(s, i, Length(dc1)) <> dc1) do Inc(i);

      s1 := frxGetBrackedVariableW(s, dc1, dc2, i, j);
      if i <> j then
      begin
        Delete(s, i, j - i + 1);

        if (Pos('."', s1) > 1) and (s1[Length(s1)] = '"') then
        begin
          Delete(s1, Pos('."', s1) + 1, 1);
          Delete(s1, Length(s1), 1);
        end;
        s2 := '[' + s1 + ']';
        Insert(s2, s, i);
        Inc(i, Length(s2));
        j := 0;
      end;
    until i = j;
  end;
{$IFDEF DELPHI12}
  root.Prop['Text'] := s;
{$ELSE}
  root.Prop['Text'] := UTF8Encode(s);
{$ENDIF}

  if memo.StretchMode = smActualHeight then
  begin
    root.Prop['CanGrow'] := 'true';
    root.Prop['CanShrink'] := 'true';
  end
  else if memo.StretchMode = smMaxHeight then
    root.Prop['GrowToBottom'] := 'true';

  if not memo.AllowExpressions then
    root.Prop['AllowExpressions'] := 'false';

  if memo.AutoWidth then
    root.Prop['AutoWidth'] := 'true';

  if not memo.Clipped then
    root.Prop['Clip'] := 'false';

  if memo.ExpressionDelimiters <> '[,]' then
    root.Prop['Brackets'] := memo.ExpressionDelimiters;

  if memo.FlowTo <> nil then
{$IFDEF DELPHI12}
    root.Prop['BreakTo'] := memo.FlowTo.Name;
{$ELSE}
    root.Prop['BreakTo'] := UTF8Encode(memo.FlowTo.Name);
{$ENDIF}
  root.Prop['Padding'] := IntToStr(Round(memo.GapX)) + ', ' +
    IntToStr(Round(memo.GapY)) + ', ' +
    IntToStr(Round(memo.GapX)) + ', ' + IntToStr(Round(memo.GapY));

  root.Prop['HorzAlign'] := haligns[Integer(memo.HAlign)];
  root.Prop['VertAlign'] := valigns[Integer(memo.VAlign)];

  if memo.HideZeros then
    root.Prop['HideValue'] := '0';

  if memo.LineSpacing <> 2 then
    root.Prop['LineSpacing'] := frxFloatToStr(memo.LineSpacing);

  if memo.Rotation <> 0 then
    root.Prop['Angle'] := IntToStr(memo.Rotation);

  if memo.RTLReading then
    root.Prop['RightToLeft'] := 'true';

  if memo.SuppressRepeated then
    root.Prop['Duplicates'] := 'Hide';

  if memo.Underlines then
    root.Prop['Underlines'] := 'true';

  if not memo.WordWrap then
    root.Prop['WordWrap'] := 'false';

  if memo.Font.Color <> clBlack then
    root.Prop['TextFill.Color'] := frxColorToStr(memo.Font.Color);

  if memo.DisplayFormat.Kind = fkNumeric then
  begin
    if memo.DisplayFormat.FormatStr = '%2.2m' then
      root.Prop['Format'] := 'Currency'
    else
      root.Prop['Format'] := 'Number';
  end
  else if memo.DisplayFormat.Kind = fkDateTime then
  begin
    if Pos('h', memo.DisplayFormat.FormatStr) <> 0 then
      root.Prop['Format'] := 'Time'
    else
      root.Prop['Format'] := 'Date';
  end
  else if memo.DisplayFormat.Kind = fkBoolean then
    root.Prop['Format'] := 'Boolean';

  if memo.Highlight.Condition <> '' then
  begin
    hltItem := root.Add;
    hltItem.Name := 'Highlight';
    hltItem := hltItem.Add;
    hltItem.Name := 'Condition';
{$IFDEF DELPHI12}
    hltItem.Prop['Expression'] := memo.Highlight.Condition;
{$ELSE}
    hltItem.Prop['Expression'] := UTF8Encode(memo.Highlight.Condition);
{$ENDIF}
    ConvertFont(memo.Highlight.Font, 'Font', hltItem);
    hltItem.Prop['Fill.Color'] := frxColorToStr(memo.Highlight.Color);
    hltItem.Prop['TextFill.Color'] := frxColorToStr(memo.Highlight.Font.Color);
    hltItem.Prop['ApplyFill'] := 'true';
    hltItem.Prop['ApplyFont'] := 'true';
  end;
end;

procedure TfrxSaveFRX.ConvertPicture(Picture: TfrxPictureView; root: TfrXmlItem);
var
  s: TMemoryStream;
begin
  if picture.AutoSize then
    root.Prop['SizeMode'] := 'AutoSize'
  else if picture.Center then
    root.Prop['SizeMode'] := 'CenterImage'
  else if picture.Stretched then
  begin
    if picture.KeepAspectRatio then
      root.Prop['SizeMode'] := 'Zoom'
    else
      root.Prop['SizeMode'] := 'StretchImage'
  end;

  if picture.FileLink <> '' then
{$IFDEF DELPHI12}
    root.Prop['ImageLocation'] := picture.FileLink
{$ELSE}
    root.Prop['ImageLocation'] := UTF8Encode(picture.FileLink)
{$ENDIF}
  else if (picture.Picture.Graphic <> nil) and not picture.Picture.Graphic.Empty then
  begin
    s := TMemoryStream.Create;
    picture.Picture.Graphic.SaveToStream(s);
{$IFDEF DELPHI12}
    root.Prop['Image'] := String(frxStreamToBase64String(s));
{$ELSE}
    root.Prop['Image'] := frxStreamToBase64String(s);
{$ENDIF}
    s.Free;
  end;
end;

procedure TfrxSaveFRX.ConvertLine(Line: TfrxLineView; root: TfrXmlItem);
begin
  if line.Diagonal then
    root.Prop['Diagonal'] := 'true';

  if line.ArrowStart then
  begin
    root.Prop['StartCap.Style'] := 'Arrow';
    root.Prop['StartCap.Width'] := IntToStr(line.ArrowWidth);
    root.Prop['StartCap.Height'] := IntToStr(line.ArrowLength);
  end;

  if line.ArrowEnd then
  begin
    root.Prop['EndCap.Style'] := 'Arrow';
    root.Prop['EndCap.Width'] := IntToStr(line.ArrowWidth);
    root.Prop['EndCap.Height'] := IntToStr(line.ArrowLength);
  end;
end;

procedure TfrxSaveFRX.ConvertShape(Shape: TfrxShapeView; root: TfrXmlItem);
const
  shapes: array [0..6] of String = (
    'Rectangle', 'RoundRectangle', 'Ellipse', 'Triangle',
    'Diamond', 'Rectangle', 'Rectangle');
begin
  root.Prop['Shape'] := shapes[Integer(Shape.Shape)];
  if Shape.Shape = skRoundRectangle then
    root.Prop['Curve'] := IntToStr(Shape.Curve);
end;

procedure TfrxSaveFRX.ConvertSubreport(Subreport: TfrxSubreport; root: TfrXmlItem);
begin
  if Subreport.PrintOnParent then
    root.Prop['PrintOnParent'] := 'true';
  root.Prop['ReportPage'] := Subreport.Page.Name;
end;

procedure TfrxSaveFRX.ConvertBarcode(Barcode: TfrxBarcodeView; root: TfrXmlItem);
const
  barcodes: array [0..22] of String = (
    '2/5 Interleaved', '2/5 Industrial', '2/5 Matrix', 'Code39',
    'Code39 Extended', 'Code128', 'Code128', 'Code128', 'Code93',
    'Code93 Extended', 'MSI', 'PostNet', 'Codabar', 'EAN8',
    'EAN13', 'UPC-A', 'UPC-E0', 'UPC-E1', 'Supplement 2',
    'Supplement 5', 'Code128', 'Code128', 'Code128');

begin
  root.Prop['Barcode'] := barcodes[Integer(Barcode.BarType)];
  if not Barcode.CalcCheckSum then
    root.Prop['Barcode.CalcCheckSum'] := 'false';
  root.Prop['Barcode.WideBarRatio'] := frxFloatToStr(Barcode.WideBarRatio);
  if Barcode.Rotation <> 0 then
    root.Prop['Angle'] := IntToStr(Barcode.Rotation);
  if not Barcode.ShowText then
    root.Prop['ShowText'] := 'false';
{$IFDEF DELPHI12}
  root.Prop['Text'] := Barcode.Text;
{$ELSE}
  root.Prop['Text'] := UTF8Encode(Barcode.Text);
{$ENDIF}
  if Barcode.Expression <> '' then
{$IFDEF DELPHI12}
    root.Prop['Expression'] := Barcode.Expression;
{$ELSE}
    root.Prop['Expression'] := UTF8Encode(Barcode.Expression);
{$ENDIF}
  root.Prop['Zoom'] := frxFloatToStr(Barcode.Zoom);
end;

procedure TfrxSaveFRX.ConvertRich(Rich: TfrxRichView; root: TfrXmlItem);
var
  stm: TMemoryStream;
  s: AnsiString;
begin
  if rich.StretchMode = smActualHeight then
  begin
    root.Prop['CanGrow'] := 'true';
    root.Prop['CanShrink'] := 'true';
  end
  else if rich.StretchMode = smMaxHeight then
    root.Prop['GrowToBottom'] := 'true';

  if not rich.AllowExpressions then
    root.Prop['AllowExpressions'] := 'false';

  if rich.ExpressionDelimiters <> '[,]' then
    root.Prop['Brackets'] := rich.ExpressionDelimiters;

  if rich.FlowTo <> nil then
{$IFDEF DELPHI12}
    root.Prop['BreakTo'] := rich.FlowTo.Name;
{$ELSE}
    root.Prop['BreakTo'] := UTF8Encode(rich.FlowTo.Name);
{$ENDIF}

  root.Prop['Padding'] := IntToStr(Round(rich.GapX)) + ', ' +
    IntToStr(Round(rich.GapY)) + ', ' + IntToStr(Round(rich.GapX)) + ', ' +
    IntToStr(Round(rich.GapY));

  stm := TMemoryStream.Create;
  rich.RichEdit.Lines.SaveToStream(stm);
  SetLength(s, stm.Size);
  stm.Position := 0;
  stm.Read(s[1], stm.Size);
  stm.Free;

{$IFDEF DELPHI12}
  root.Prop['Text'] := String(s);
{$ELSE}
  root.Prop['Text'] := UTF8Encode(s);
{$ENDIF}
end;

procedure TfrxSaveFRX.ConvertCheckBox(CheckBox: TfrxCheckBoxView; root: TfrXmlItem);
const
  checkStyles: array [0..3] of String = (
    'Cross', 'Check', 'Cross', 'Plus');
  uncheckStyles: array [0..3] of String = (
    'None', 'Cross', 'Cross', 'Minus');
begin
  root.Prop['CheckedSymbol'] := checkStyles[Integer(CheckBox.CheckStyle)];
  root.Prop['UncheckedSymbol'] := uncheckStyles[Integer(CheckBox.UncheckStyle)];
  if not CheckBox.Checked then
    root.Prop['Checked'] := 'false';
  if CheckBox.CheckColor <> clBlack then
    root.Prop['CheckColor'] := frxColorToStr(CheckBox.CheckColor);
  if CheckBox.Expression <> '' then
{$IFDEF DELPHI12}
    root.Prop['Expression'] := CheckBox.Expression;
{$ELSE}
    root.Prop['Expression'] := UTF8Encode(CheckBox.Expression);
{$ENDIF}
end;


{------------------------------------------------------------------------------}
procedure TfrxSaveFRX.ConvertDialogPage(Page: TfrxDialogPage; root: TfrXmlItem);
var
  i: Integer;
  pageItem: TfrXmlItem;
begin
  pageItem := root.Add;
  pageItem.Name := 'DialogPage';
  pageItem.Prop['Name'] := Page.Name;
  pageItem.Prop['Width'] := frxFloatToStr(Page.Width);
  pageItem.Prop['Height'] := frxFloatToStr(Page.Height);

  if Page.BorderStyle <> bsDialog then
    pageItem.Prop['FormBorderStyle'] := 'Sizable';
{$IFDEF DELPHI12}
  pageItem.Prop['Text'] := Page.Caption;
{$ELSE}
  pageItem.Prop['Text'] := UTF8Encode(Page.Caption);
{$ENDIF}
  if Page.Color <> clBtnFace then
    pageItem.Prop['BackColor'] := frxColorToStr(Page.Color);
  ConvertFont(Page.Font, 'Font', pageItem);

  for i := 0 to Page.Objects.Count - 1 do
  begin
    if TObject(Page.Objects[i]) is TfrxDialogControl then
      ConvertDialogControl(TfrxDialogControl(Page.Objects[i]), pageItem);
  end;
end;

procedure TfrxSaveFRX.ConvertDialogControl(Control: TfrxDialogControl; root: TfrXmlItem);
var
  objItem: TfrXmlItem;
  objClass: String;
begin
  if (Control is TfrxBitBtnControl) or (Control is TfrxSpeedButtonControl) or
    (Control is TfrxBevelControl) then Exit;

  objItem := root.Add;

{$IFDEF DELPHI12}
  objItem.Prop['Name'] := Control.Name;
{$ELSE}
  objItem.Prop['Name'] := UTF8Encode(Control.Name);
{$ENDIF}
  objItem.Prop['Left'] := frxFloatToStr(Control.Left);
  objItem.Prop['Top'] := frxFloatToStr(Control.Top);
  objItem.Prop['Width'] := frxFloatToStr(Control.Width);
  objItem.Prop['Height'] := frxFloatToStr(Control.Height);

  ConvertFont(Control.Font, 'Font', objItem);

  if not Control.Visible then
    objItem.Prop['Visible'] := 'false';

  if not Control.Enabled then
    objItem.Prop['Enabled'] := 'false';

  if Control.Font.Color <> clWindowText then
    objItem.Prop['ForeColor'] := frxColorToStr(Control.Font.Color);

  if Control.Color <> clBtnFace then
    objItem.Prop['BackColor'] := frxColorToStr(Control.Color);

  if Control.Caption <> '' then
{$IFDEF DELPHI12}
    objItem.Prop['Text'] := Control.Caption;
{$ELSE}
    objItem.Prop['Text'] := UTF8Encode(Control.Caption);
{$ENDIF}

  if Control is TfrxButtonControl then
  begin
    objClass := 'ButtonControl';
    ConvertDialogButton(Control as TfrxButtonControl, objItem);
  end
  else if Control is TfrxLabelControl then
  begin
    objClass := 'LabelControl';
    ConvertDialogLabel(Control as TfrxLabelControl, objItem);
  end
  else if Control is TfrxMaskEditControl then
  begin
    objClass := 'MaskedTextBoxControl';
    ConvertDialogEdit(Control as TfrxCustomEditControl, objItem);
  end
  else if Control is TfrxCustomEditControl then
  begin
    objClass := 'TextBoxControl';
    ConvertDialogEdit(Control as TfrxCustomEditControl, objItem);
  end
  else if Control is TfrxCheckBoxControl then
  begin
    objClass := 'CheckBoxControl';
    ConvertDialogCheckBox(Control as TfrxCheckBoxControl, objItem);
  end
  else if Control is TfrxRadioButtonControl then
  begin
    objClass := 'RadioButtonControl';
    ConvertDialogRadioButton(Control as TfrxRadioButtonControl, objItem);
  end
  else if Control is TfrxListBoxControl then
  begin
    objClass := 'ListBoxControl';
    ConvertDialogListBox(Control as TfrxListBoxControl, objItem);
  end
  else if Control is TfrxComboBoxControl then
  begin
    objClass := 'ComboBoxControl';
    ConvertDialogComboBox(Control as TfrxComboBoxControl, objItem);
  end
  else if Control is TfrxPanelControl then
  begin
    objClass := 'PanelControl';
    ConvertDialogPanel(Control as TfrxPanelControl, objItem);
  end
  else if Control is TfrxGroupBoxControl then
  begin
    objClass := 'GroupBoxControl';
    ConvertDialogGroupBox(Control as TfrxGroupBoxControl, objItem);
  end
  else if Control is TfrxDateEditControl then
  begin
    objClass := 'DateTimePickerControl';
    ConvertDialogDateEdit(Control as TfrxDateEditControl, objItem);
  end
  else if Control is TfrxImageControl then
  begin
    objClass := 'PictureBoxControl';
    ConvertDialogImage(Control as TfrxImageControl, objItem);
  end
  else if Control is TfrxCheckListBoxControl then
  begin
    objClass := 'CheckedListBoxControl';
    ConvertDialogCheckListBox(Control as TfrxCheckListBoxControl, objItem);
  end;

  objItem.Name := objClass;
end;

procedure TfrxSaveFRX.ConvertDialogButton(Button: TfrxButtonControl; root: TfrXmlItem);
var
  s: String;
begin
  s := 'None';
  if Button.ModalResult = mrOk then
    s := 'OK'
  else if Button.ModalResult = mrCancel then
    s := 'Cancel';
  root.Prop['DialogResult'] := s;
end;

procedure TfrxSaveFRX.ConvertDialogLabel(Lbl: TfrxLabelControl; root: TfrXmlItem);
const
  align: array [0..2] of String = (
    'TopLeft', 'TopRight', 'TopCenter');
begin
  root.Prop['TextAlign'] := align[Integer(Lbl.Alignment)];
  if not Lbl.AutoSize then
    root.Prop['AutoSize'] := 'false';
end;

procedure TfrxSaveFRX.ConvertDialogEdit(Edit: TfrxCustomEditControl; root: TfrXmlItem);
const
  sbars: array [0..3] of String = (
    'None', 'Horizontal', 'Vertical', 'Both');
begin
  if Edit is TfrxMemoControl then
  begin
    root.Prop['Multiline'] := 'true';
    if not TfrxMemoControl(Edit).WordWrap then
      root.Prop['WordWrap'] := 'false';
    root.Prop['ScrollBars'] := sbars[Integer(TfrxMemoControl(Edit).ScrollBars)];
  end;

  if Edit is TfrxMaskEditControl then
{$IFDEF DELPHI12}
    root.Prop['Mask'] := TfrxMaskEditControl(Edit).EditMask;
{$ELSE}
    root.Prop['Mask'] := UTF8Encode(TfrxMaskEditControl(Edit).EditMask);
{$ENDIF}

  if Edit.MaxLength <> 0 then
    root.Prop['MaxLength'] := IntToStr(Edit.MaxLength);
  if Edit.PasswordChar <> #0 then
    root.Prop['UseSystemPasswordChar'] := 'true';
  if Edit.ReadOnly then
    root.Prop['ReadOnly'] := 'true';
{$IFDEF DELPHI12}
  root.Prop['Text'] := Edit.Text;
{$ELSE}
  root.Prop['Text'] := UTF8Encode(Edit.Text);
{$ENDIF}
end;

procedure TfrxSaveFRX.ConvertDialogCheckBox(CheckBox: TfrxCheckBoxControl; root: TfrXmlItem);
begin
  if CheckBox.AllowGrayed then
    root.Prop['ThreeState'] := 'true';
  if CheckBox.Checked then
    root.Prop['Checked'] := 'true';
  if CheckBox.Alignment = taLeftJustify then
    root.Prop['CheckAlign'] := 'MiddleRight';
end;

procedure TfrxSaveFRX.ConvertDialogRadioButton(RadioButton: TfrxRadioButtonControl; root: TfrXmlItem);
begin
  if RadioButton.Checked then
    root.Prop['Checked'] := 'true';
  if RadioButton.Alignment = taLeftJustify then
    root.Prop['CheckAlign'] := 'MiddleRight';
end;

procedure TfrxSaveFRX.ConvertDialogListBox(ListBox: TfrxListBoxControl; root: TfrXmlItem);
begin
{$IFDEF DELPHI12}
  root.Prop['ItemsText'] := frxLinesToStr(ListBox.Items.Text);
{$ELSE}
  root.Prop['ItemsText'] := UTF8Encode(frxLinesToStr(ListBox.Items.Text));
{$ENDIF}
end;

procedure TfrxSaveFRX.ConvertDialogComboBox(ComboBox: TfrxComboBoxControl; root: TfrXmlItem);
begin
  if ComboBox.Style = csDropDownList then
    root.Prop['DropDownStyle'] := 'DropDownList';
{$IFDEF DELPHI12}
  root.Prop['ItemsText'] := frxLinesToStr(ComboBox.Items.Text);
{$ELSE}
  root.Prop['ItemsText'] := UTF8Encode(frxLinesToStr(ComboBox.Items.Text));
{$ENDIF}
  if ComboBox.Text <> '' then
{$IFDEF DELPHI12}
    root.Prop['Text'] := ComboBox.Text;
{$ELSE}
    root.Prop['Text'] := UTF8Encode(ComboBox.Text);
{$ENDIF}
end;

procedure TfrxSaveFRX.ConvertDialogPanel(Panel: TfrxPanelControl; root: TfrXmlItem);
var
  i: Integer;
begin
  for i := 0 to Panel.Objects.Count - 1 do
  begin
    if TObject(Panel.Objects[i]) is TfrxDialogControl then
      ConvertDialogControl(TfrxDialogControl(Panel.Objects[i]), root);
  end;
end;

procedure TfrxSaveFRX.ConvertDialogGroupBox(GroupBox: TfrxGroupBoxControl; root: TfrXmlItem);
var
  i: Integer;
begin
  for i := 0 to GroupBox.Objects.Count - 1 do
  begin
    if TObject(GroupBox.Objects[i]) is TfrxDialogControl then
      ConvertDialogControl(TfrxDialogControl(GroupBox.Objects[i]), root);
  end;
end;

procedure TfrxSaveFRX.ConvertDialogDateEdit(DateEdit: TfrxDateEditControl; root: TfrXmlItem);
begin
  if DateEdit.Kind = dtkDate then
  begin
    if dateEdit.DateFormat = dfShort then
      root.Prop['Format'] := 'Short';
  end
  else
  begin
    root.Prop['Format'] := 'Time';
  end;

  root.Prop['Value'] := DateToStr(DateEdit.Date) + ' ' + TimeToStr(DateEdit.Time);
end;

procedure TfrxSaveFRX.ConvertDialogImage(Image: TfrxImageControl; root: TfrXmlItem);
var
  s: TMemoryStream;
begin
  if Image.AutoSize then
    root.Prop['SizeMode'] := 'AutoSize'
  else if Image.Center then
    root.Prop['SizeMode'] := 'CenterImage'
  else if Image.Stretch then
    root.Prop['SizeMode'] := 'StretchImage';

  if (Image.Picture.Graphic <> nil) and not Image.Picture.Graphic.Empty then
  begin
    s := TMemoryStream.Create;
    Image.Picture.Graphic.SaveToStream(s);
{$IFDEF DELPHI12}
    root.Prop['Image'] := String(frxStreamToBase64String(s));
{$ELSE}
    root.Prop['Image'] := frxStreamToBase64String(s);
{$ENDIF}
    s.Free;
  end;
end;

procedure TfrxSaveFRX.ConvertDialogCheckListBox(CheckListBox: TfrxCheckListBoxControl; root: TfrXmlItem);
begin
{$IFDEF DELPHI12}
  root.Prop['ItemsText'] := frxLinesToStr(CheckListBox.Items.Text);
{$ELSE}
  root.Prop['ItemsText'] := UTF8Encode(frxLinesToStr(CheckListBox.Items.Text));
{$ENDIF}
  if CheckListBox.Sorted then
    root.Prop['Sorted'] := 'true';
end;

{------------------------------------------------------------------------------}
procedure TfrxSaveFRX.ConvertFrame(Frame: TfrxFrame; root: TfrXmlItem);
var
  s: String;
begin
  if Frame.DropShadow then
  begin
    root.Prop['Border.DropShadow'] := 'true';
    root.Prop['Border.ShadowWidth'] := frxFloatToStr(Frame.ShadowWidth);
    root.Prop['Border.ShadowColor'] := frxColorToStr(Frame.ShadowColor);
  end;
  if Frame.Typ <> [] then
  begin
    s := '';
    if ftLeft in Frame.Typ then
      s := s + 'Left, ';
    if ftRight in Frame.Typ then
      s := s + 'Right, ';
    if ftTop in Frame.Typ then
      s := s + 'Top, ';
    if ftBottom in Frame.Typ then
      s := s + 'Bottom, ';
    if s[Length(s)] = ' ' then
      s := Copy(s, 1, Length(s) - 2);
    root.Prop['Border.Lines'] := s;

    ConvertFrameLine(Frame.LeftLine, 'Left', root);
    ConvertFrameLine(Frame.RightLine, 'Right', root);
    ConvertFrameLine(Frame.TopLine, 'Top', root);
    ConvertFrameLine(Frame.BottomLine, 'Bottom', root);
  end;
end;

procedure TfrxSaveFRX.ConvertFrameLine(Line: TfrxFrameLine; Name: String; root: TfrXmlItem);
const
  styles: array [0..7] of String = (
    'Solid', 'Dash', 'Dot', 'DashDot', 'DashDotDot', 'Double', 'Dot', 'Dot');
begin
  root.Prop['Border.' + Name + 'Line.Color'] := frxColorToStr(Line.Color);
  root.Prop['Border.' + Name + 'Line.Style'] := styles[Integer(Line.Style)];
  root.Prop['Border.' + Name + 'Line.Width'] := frxFloatToStr(Line.Width);
end;

procedure TfrxSaveFRX.ConvertFont(Font: TFont; Name: String; root: TfrXmlItem);
var
  s: String;
begin
  if (Font.Name <> 'Arial') or (Font.Size <> 10) or (Font.Style <> []) then
  begin
    s := Font.Name + ', ' + IntToStr(Font.Size) + 'pt';
    if Font.Style <> [] then
    begin
      s := s + ', style=';
      if fsBold in Font.Style then
        s := s + 'Bold, ';
      if fsItalic in Font.Style then
        s := s + 'Italic, ';
      if fsUnderline in Font.Style then
        s := s + 'Underline, ';
      if fsStrikeout in Font.Style then
        s := s + 'Strikeout, ';
      if s[Length(s)] = ' ' then
        s := Copy(s, 1, Length(s) - 2);
    end;
{$IFDEF DELPHI12}
    root.Prop[Name] := s;
{$ELSE}
    root.Prop[Name] := UTF8Encode(s);
{$ENDIF}
  end;
end;


initialization

finalization

end.
