unit uAdvanced;

//{$INCLUDE fcx.inc}

interface

uses

  Windows, Messages, ADODB, FileCtrl, TeeProcs, TeEngine, Chart,
  SysUtils, DateUtils, Classes, Graphics, Controls, Forms, Variants,
  frxClass, frxDBSet, frxDesgn, fcxpComponents, fcxpChartComponents, fcxpChart,
  Dialogs, ComCtrls, DB, StdCtrls, ExtCtrls, GraphUtil, Menus, ImgList, ToolWin,
  fcxTypes, fcxComponent, fcxRes, fcxDataSource, fcxCube, fcxSlice, fcxPainters,
  fcxGridPainters, fcxZone, fcxCustomGrid, fcxSliceGrid, fcxCubeGrid,
  fcxChart, fcxSliceGridToolbar, fcxCubeGridToolBar,
  fcxCustomExport, fcxExportBIFF, fcxExportODF, fcxExportXML, fcxExportHTML, fcxExportDBF,
  fcxExportCSV, fcxCustomToolbar, fcxControl, fcxStyles, fcxExportXLSX, fcxCustomSliceGridExport,
  uDemoMain, XPMan, ActnList, fcxFSInterpreter,
  frDPIAwareUtils, VclTee.TeeGDIPlus, frDPIAwareControls, System.ImageList,
  System.Actions;

type

  TfrmAdvancedMain = class(TfrmDemoMain)
    Pages: TPageControl;
    SliceGridSheet: TTabSheet;
    CubeGridSheet: TTabSheet;
    ColorDialog: TColorDialog;
    NotesSheet: TTabSheet;
    AxisImages: TImageList;
    CellImages: TImageList;
    FieldsImages: TImageList;
    ImageList1: TImageList;
    NewInDemo: TMemo;
    FontDialog: TFontDialog;
    fcSliceGridToolbar1: TfcxSliceGridToolbar;
    MDGrid: TfcxSliceGrid;
    CubeGrid: TfcxCubeGrid;
    MDSlice: TfcxSlice;
    MDCube: TfcxCube;
    fcDataSource1: TfcxDataSource;
    fcDBDataSet1: TfcxDBDataSet;
    fcxDirDataset: TfcxUserDataSet;
    fcxDBDSItems: TfcxDBDataSet;
    fcxDBDScustomer: TfcxDBDataSet;
    fcxDBDSemployee: TfcxDBDataSet;
    fcxDBDSparts: TfcxDBDataSet;
    Demo: TfcxDataSource;
    fcxDBDSorders: TfcxDBDataSet;
    fcxDBvendors: TfcxDBDataSet;
    fcxCalendarDataset: TfcxUserDataSet;
    fcxCalendarDataSource: TfcxDataSource;
    ChartSheet: TTabSheet;
    fcxChart1: TfcxChart;
    fcxChartToolBar1: TfcxChartToolBar;
    Splitter2: TSplitter;
    Panel2: TPanel;
    Tree: TTreeView;
    CubeDescr: TMemo;
    Splitter1: TSplitter;
    fcxCubeGridToolbar1: TfcxCubeGridToolbar;
    fcxBIFFExport1: TfcxBIFFExport;
    fcxODSExport1: TfcxODSExport;
    fcxXMLExport1: TfcxXMLExport;
    fcxHTMLExport1: TfcxHTMLExport;
    fcxDBFExport1: TfcxDBFExport;
    fcxCSVExport1: TfcxCSVExport;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Panel3: TPanel;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Panel4: TPanel;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    PrintBtn: TButton;
    fcxXLSXExport1: TfcxXLSXExport;
    SliceGrid1: TMenuItem;
    Editstyles1: TMenuItem;
    PaintStyleMenu: TMenuItem;

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TreeChange(Sender: TObject; Node: TTreeNode);
    procedure TreeCustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure TreeDeletion(Sender: TObject; Node: TTreeNode);
    procedure ShowSplitFieldsInFieldListChange(Sender: TObject);
    procedure OnUpdateSelection(Sender: TObject);
    procedure fcxDirDatasetOpen(Sender: TObject);
    procedure fcxDirDatasetFirst(Sender: TObject);
    procedure fcxDirDatasetNext(Sender: TObject);
    function fcxDirDatasetEof(Sender: TObject): Boolean;
    procedure fcxDirDatasetClose(Sender: TObject);
    function fcxDirDatasetGetVarData(Sender: TObject; AFieldIndex: Integer;
      out AValue: Variant): Boolean;
    procedure fcxDirDatasetDataFieldAt(Sender: TObject;
      AFieldIndex: Integer; var ADataFieldPropery: TfcxDataFieldPropery);
    function fcxDirDatasetActive(Sender: TObject): Boolean;
    procedure DoGetCellImageIndex(Sender: TfcxSliceDataZone; const Cell: TfcxMeasureCell; var ImageIndex: Integer);
    procedure DoGetCellStyle(Sender: TfcxSliceDataZone; const Cell: TfcxMeasureCell; States: TfcxThemeCellStates; Style: TfcxCustomThemeStyle);
    procedure DoGetAxisCellStyle(Sender: TfcxSliceCustomAxisZone; const AInfo: TfcxCellInfo; State: TfcxThemeState; Style: TfcxCustomThemeStyle);
    procedure MDGridGetDataCellText(Sender: TfcxSliceDataZone;
      const Cell: TfcxMeasureCell; var Text: String);
    procedure employeeCalcFields(DataSet: TDataSet);
    function fcxCalendarDatasetActive(Sender: TObject): Boolean;
    procedure fcxCalendarDatasetClose(Sender: TObject);
    procedure fcxCalendarDatasetDataFieldAt(Sender: TObject; AFieldIndex: Integer;
        var ADataFieldPropery: TfcxDataFieldPropery);
    function fcxCalendarDatasetEof(Sender: TObject): Boolean;
    procedure fcxCalendarDatasetFirst(Sender: TObject);
    function fcxCalendarDatasetGetVarData(Sender: TObject; AFieldIndex: Integer;
        out AValue: Variant): Boolean;
    procedure fcxCalendarDatasetNext(Sender: TObject);
    procedure fcxCalendarDatasetOpen(Sender: TObject);
    procedure Editstyles1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure TreeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TreeClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure MDGridGetAxisCellImageIndex(Sender: TfcxSliceCustomAxisZone;
      const AInfo: TfcxCellInfo; var ImageIndex: Integer);
    procedure PrintBtnClick(Sender: TObject);
    procedure frxReportGetValue(const VarName: String; var Value: Variant);
  private
    procedure SetPaintStyle(const Value: TfcxPaintStyle);
    function GetPaintStyle: TfcxPaintStyle;
    procedure PaintStyleClick(Sender: TObject);
    procedure SetActiveCube(const Value: TTreeNode);
    procedure OpenExample(Node: TTreeNode; AClearCaption: boolean = True);
    procedure CreateAdoObjects;
    procedure CreateReportObjects;
    procedure DoAcceptDrag(Sender: TZone; Source: TObject; var Accept: Boolean);
  private
    FCurrentStyle: Integer;
    FUserPaint: Boolean;
    FDirectory: String;
    FSearchRec: TSearchRec;
    FEof: Boolean;
    FDate: TDate;
    FActiveCube: TTreeNode;
    FSkipAdoExamples: Boolean;
    // report objects
    frxReport: TfrxReport;
    frxDBDataset: TfrxDBDataset;
    fcxpSliceGridProvider: TfcxpSliceGridProvider;
    fcxpChartProvider: TfcxpChartProvider;
    // examples
    procedure OpenSampleCube(FileCube: String);
    procedure OpenSampleReport;
    procedure LoadExamplesTree;
    property PaintStyle: TfcxPaintStyle read GetPaintStyle write SetPaintStyle;
  public
    constructor Create(AOwner: TComponent); override;
    property ActiveCube: TTreeNode read FActiveCube write SetActiveCube;
  end;

var
  frmAdvancedMain: TfrmAdvancedMain;
  FDataPath: String = '';
  FNeedExePath: String = '';

implementation

{$R *.dfm}

uses
  typinfo,
  StrUtils,
  uAdvancedAbout,
  fcxUtils,
  fcxStylesEditor;

type
  TTreeNodeKind = (tnkGroup, tnkCube, tnkSchema);

  TTreeNodeValue = record
    FileName: string;
    Description: string;
    StateIndex: Integer;
    NodeKind: TTreeNodeKind;
  end;
  PTreeNodeValue = ^TTreeNodeValue;

// exmple description
const
  PathDelim  = '\';
  DriveDelim = ':';
  PathSep    = ';';

function PosEx(const SubStr, S: string; Offset: Cardinal = 1): Integer;
var
  I,X: Integer;
  Len, LenSubStr: Integer;
begin
  if Offset = 1 then
    Result := Pos(SubStr, S)
  else
  begin
    I := Offset;
    LenSubStr := Length(SubStr);
    Len := Length(S) - LenSubStr + 1;
    while I <= Len do
    begin
      if S[I] = SubStr[1] then
      begin
        X := 1;
        while (X < LenSubStr) and (S[I + X] = SubStr[X + 1]) do
          Inc(X);
        if (X = LenSubStr) then
        begin
          Result := I;
          exit;
        end;
      end;
      Inc(I);
    end;
    Result := 0;
  end;
end;

function GetDataPath: String;
var
  ADir: String;
//  I: Integer;
  {$ifdef darwin}
  ExeName: String;
  {$endif}
begin
  if FDataPath <> '' then
  begin
    Result := FDataPath;
    Exit;
  end;
  {$ifdef darwin}
  ADir := ExpandFileName(ParamStr(0));
  // we need a path outside the bundle
  I := LastDelimiter(PathDelim, ADir);
  if I > 0 then
  begin
    ExeName := Copy(ADir, I + 1, Length(ADir));
    ExeName := '/' + ExeName + '.app/Contents/MacOS/' + ExeName;
    I := Pos(ExeName, ADir);
    if I > 0 then
      Delete(ADir, I, Length(ADir));
  end;
  I := LastDelimiter(PathDelim + DriveDelim, ADir);
  FDataPath := Copy(ADir, 1, I) + 'data' + PathDelim;
  FNeedExePath := Copy(ADir, 1, I) + 'advanced' + PathDelim;
  {$else}
  ADir := ExtractFileDir(ParamStr(0));
  FDataPath := ADir + '\..\Data\';
  {$endif}
  Result := FDataPath;
end;

constructor TfrmAdvancedMain.Create(AOwner: TComponent);
var
  ps: TfcxPaintStyle;
  Item: TMenuItem;
begin
  inherited;

  FCurrentStyle := -1;
  Pages.ActivePageIndex := 0;
  for ps := Low(TfcxPaintStyle) to High(TfcxPaintStyle) do
  begin
    Item := NewItem(GetEnumName(TypeInfo(TfcxPaintStyle), Ord(ps)), 0, False, True, PaintStyleClick, 0, '');
    Item.RadioItem := True;
    PaintStyleMenu.Add(Item);
  end;
  PaintStyle := psDefault;

  // test imagelist
  MDGrid.DataZone.Images := CellImages;
  MDCube.Formats.SetDefaults;
  MDGrid.OnAcceptDrag := DoAcceptDrag;
end;

procedure TfrmAdvancedMain.LoadExamplesTree;
var
  AFile: TextFile;
  AOneStr, ANameLang, AValueLang : string;
  LastGroup, LastCube, Node: TTreeNode;
  APos1, APos2, APos3, StateIndex: integer;
  NodeValue: PTreeNodeValue;
begin
  NewInDemo.Clear;
  AssignFile(AFile, GetDataPath + fcxResources.Get('dmConf'));
  Reset(AFile);
  try
    LastGroup := nil;
    LastCube := nil;
    Tree.Items.BeginUpdate;
    while not Eof(AFile) do
    begin
      Readln(AFile, AOneStr);
      if Trim(AOneStr) = '' then
        Continue;
      if Copy(AOneStr, 1, 4) = 'GROU' then
      begin
        Node := Tree.Items.AddChild(nil, StringToControl(Trim(copy(AOneStr, 7, Length(AOneStr)))));
        Node.SelectedIndex := 0;
        Node.ImageIndex := 0;
        New(NodeValue);
        NodeValue^.FileName := '';
        NodeValue^.Description := '';
        NodeValue^.NodeKind := tnkGroup;
        NodeValue^.StateIndex := -1;
        Node.Data := NodeValue;
        LastGroup := Node;
      end
      else
      if copy(AOneStr, 1, 4) = 'CUBE' then
      begin
        APos1 := PosEx(';', AOneStr, 1);
        if APos1 = 0 then continue;
        APos2 := PosEx(';', AOneStr, APos1+1);
        if APos2 = 0 then continue;
        APos3 := PosEx(';', AOneStr, APos2+1);
        if APos3 = 0 then continue;

        StateIndex := StrToInt(trim(copy(AOneStr, 6, APos1 - 6)));
        if FSkipAdoExamples and (StateIndex in [2, 12]) then
          Continue;
        Node := Tree.Items.AddChild(LastGroup, StringToControl(trim(copy(AOneStr, APos2 + 1, APos3 - APos2 - 1))));
        Node.ImageIndex := 1;
        Node.SelectedIndex := 1;
        New(NodeValue);
        NodeValue^.FileName := trim(copy(AOneStr, APos1 + 1, APos2 - APos1 - 1));
        NodeValue^.Description := trim(copy(AOneStr, APos3 + 1, Length(AOneStr)));
        NodeValue^.StateIndex := StateIndex;
        NodeValue^.NodeKind := tnkCube;
        Node.Data := NodeValue;
        LastCube := Node;
      end
      else
      if (copy(AOneStr, 1, 4) = 'SCHE') then
      begin
        APos1 := PosEx(';', AOneStr, 1);
        if APos1 = 0 then continue;
        APos2 := PosEx(';', AOneStr, APos1+1);
        if APos2 = 0 then continue;
        APos3 := PosEx(';', AOneStr, APos2+1);
        if APos3 = 0 then continue;

        Node := Tree.Items.AddChild(LastCube, StringToControl(trim(copy(AOneStr, APos2 + 1, APos3 - APos2 - 1))));
        Node.ImageIndex := 2;
        Node.SelectedIndex := 2;
        New(NodeValue);
        NodeValue^.FileName := trim(copy(AOneStr, APos1 + 1, APos2 - APos1 - 1));
        NodeValue^.Description := trim(copy(AOneStr, APos3 + 1, Length(AOneStr)));
        NodeValue^.StateIndex := StrToInt(trim(copy(AOneStr, 8, APos1 - 8)));
        NodeValue^.NodeKind := tnkSchema;
        Node.Data := NodeValue;
      end
      else
      if copy(AOneStr, 1, 4) = 'LANG' then
      begin
        APos1 := PosEx('=', AOneStr, 1);
        if APos1 = 0 then continue;
        ANameLang := trim(copy(AOneStr, 6, APos1 - 6));
        AValueLang := trim(copy(AOneStr, APos1 + 1, Length(AOneStr)));
{
        if ANameLang = 'FIELDSORDER' then
          lbFieldListOrder.Caption := AValueLang
        else if ANameLang = 'USECHARTEVENT' then
          UseChartEvent.Caption := AValueLang;
}
      end
      else
      if copy(AOneStr, 1, 9) = 'NEWINDEMO' then
      begin
        if NotesSheet.Caption = '' then
          NotesSheet.Caption := StringToControl(trim(copy(AOneStr, 11, Length(AOneStr))))
        else
          NewInDemo.Lines.Add(StringToControl(trim(copy(AOneStr, 11, Length(AOneStr)))));
      end
      else
        Continue;
    end;
  finally
    Tree.Items.EndUpdate;
    CloseFile(AFile);
  end;
end;

procedure TfrmAdvancedMain.OpenSampleCube(FileCube: String);
begin
  MDCube.LoadfromFile(GetDataPath + 'cubes' + PathDelim + FileCube);
end;

procedure TfrmAdvancedMain.FormCreate(Sender: TObject);
begin
  FSkipAdoExamples := False;
  try
    CreateAdoObjects;
  except
    on E: Exception do
      FSkipAdoExamples := True;//MessageDlg(E.Message, mtError, [mbOk], 0);
  end;
  CreateReportObjects;
  LoadExamplesTree;
  SliceGridSheet.Caption := fcxResources.Get('dmCrossTbl');
  SliceGrid1.Caption := fcxResources.Get('dmCrossTbl');
  ChartSheet.Caption := fcxResources.Get('dmChart');
  CubeGridSheet.Caption := fcxResources.Get('dmSourceTbl');
//  MDGrid.OnUpdateSelection := OnUpdateSelection;
end;

procedure TfrmAdvancedMain.FormShow(Sender: TObject);
begin
  Tree.Items[0].Item[0].Selected := True;
end;

procedure TfrmAdvancedMain.OpenExample(Node: TTreeNode; AClearCaption: boolean = True);
begin
  if AClearCaption then
    MDCube.Caption := '';

  Pages.ActivePageIndex := 0;
  case PTreeNodeValue(Node.Data).NodeKind of
    tnkGroup:
      begin
        // imposible
      end;
    tnkCube:
      begin
        ActiveCube := Node;
      end;
    tnkSchema:
      begin
        ActiveCube := Node.Parent;
        if MDCube.CubeSource <> fccs_None then
        begin
          MDCube.CubeSource := fccs_None;
          OpenSampleCube(PTreeNodeValue(Node.Parent.Data)^.FileName);
        end
        else
          MDCube.ClearGroups;

        MDSlice.LoadfromFile(GetDataPath + 'cubes' + PathDelim + PTreeNodeValue(Node.Data)^.FileName);
        MDCube.Caption := PTreeNodeValue(Node.Data)^.Description;
      end;
  end;
end;

procedure TfrmAdvancedMain.TreeChange(Sender: TObject; Node: TTreeNode);
begin
  if PTreeNodeValue(Node.Data).StateIndex = -1 then
  begin
    Tree.FullCollapse;
    Node[0].Selected := True;
    Node[0].Expand(True);
  end else
  begin
    CubeDescr.Lines.Text := StringToControl(PTreeNodeValue(Node.Data)^.Description);
    Node.Expand(True);
    OpenExample(Node);
  end;
end;

procedure TfrmAdvancedMain.TreeCustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode;
  State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  if Node.Count <> 0 then
    Tree.Canvas.Font.Style := [fsBold]
  else
    Tree.Canvas.Font.Style := [];
end;

procedure TfrmAdvancedMain.TreeDeletion(Sender: TObject; Node: TTreeNode);
begin
  Dispose(PTreeNodeValue(Node.Data));
end;

procedure TfrmAdvancedMain.PaintStyleClick(Sender: TObject);
begin
  PaintStyle := TfcxPaintStyle(TMenuItem(Sender).MenuIndex);
end;

procedure TfrmAdvancedMain.SetPaintStyle(const Value: TfcxPaintStyle);
begin
  MDGrid.PaintStyle := Value;
  CubeGrid.PaintStyle := Value;
  PaintStyleMenu.Items[Ord(Value)].Checked := True;
end;

function TfrmAdvancedMain.GetPaintStyle: TfcxPaintStyle;
begin
  Result := MDGrid.PaintStyle;
end;

procedure TfrmAdvancedMain.ShowSplitFieldsInFieldListChange(Sender: TObject);
begin
  //MDSlice.ShowSplitFieldsInFieldList := TfcxShowSplitFields(ShowSplitFieldsInFieldList.ItemIndex);
end;

procedure TfrmAdvancedMain.OnUpdateSelection(Sender: TObject);
begin
  //lb_Selection.Caption := 'Col: ' + IntToStr(MDSlice.SelectedCol) + ' ' +
  //                        'Row: ' + IntToStr(MDSlice.SelectedRow) + ' ' +
  //                        'Fact: ' + IntToStr(MDSlice.SelectedFact);
end;

procedure TfrmAdvancedMain.DoGetCellImageIndex(Sender: TfcxSliceDataZone;
  const Cell: TfcxMeasureCell; var ImageIndex: Integer);
begin
  if FUserPaint then
    if Cell.IsGrandTotal then
      ImageIndex := 2
    else
    if Cell.IsTotal then
      ImageIndex := 1
    else
      ImageIndex := 0;
end;

procedure TfrmAdvancedMain.DoGetCellStyle(Sender: TfcxSliceDataZone;
  const Cell: TfcxMeasureCell; States: TfcxThemeCellStates;
  Style: TfcxCustomThemeStyle);
var
  LFactor: Integer;
begin
  if FUserPaint then
    if States = [] then
    begin
      Style.GradientDirection := tgdVertical;
      LFactor := Round(Sqrt(Cell.MeasureIndex + 1) * 20);
      Style.FillColor := RGB(100 + LFactor * 2, LFactor * 3, LFactor * 4);
//      Style.FillColor := RGB(100 + (Cell.MeasureIndex + 1) * 40, (Cell.MeasureIndex + 1) * 60, (Cell.MeasureIndex + 1) * 80);
      Style.GradientColor := GetHighLightColor(Style.FillColor{$IFDEF DELPHI7}, 60 {$ENDIF});
      Style.Font.Style := [fsBold];
    end;
end;

procedure TfrmAdvancedMain.DoAcceptDrag(Sender: TZone; Source: TObject;
  var Accept: Boolean);
var
  DragItem: TfcxCustomDragItem;
  Item: TObject;
  Field: TfcxSliceField;
begin
  if not Accept then
    Exit;

  if (Source is TfcxCustomDragItem) and
     ((Sender is TfcxSliceCustomAxisZone) or (Sender is TfcxSliceItemsZone)) then
  begin
    DragItem := TfcxCustomDragItem(Source);
    Item := DragItem.GetItem;
    if (Item is TfcxSliceField) then
      Field := TfcxSliceField(Item)
    else
    if (Item is TfcxAxisField) then
      Field := TfcxAxisField(Item).SliceField
    else
    if (Item is TfcxMeasureField) then
      Field := TfcxMeasureField(Item).SliceField
    else
      Field := nil;
    if Assigned(Field) then
      Accept := not ContainsText(Field.FieldName, 'a');
  end;
end;

procedure TfrmAdvancedMain.DoGetAxisCellStyle(Sender: TfcxSliceCustomAxisZone;
  const AInfo: TfcxCellInfo; State: TfcxThemeState; Style: TfcxCustomThemeStyle);
var
  AColor: TColor;
begin
  if FUserPaint then
  begin
    AColor := Style.FillColor;
    if AColor <> clNone then
    begin
      Style.GradientDirection := tgdHorizontal;
      Style.FillColor := GetHighLightColor(ColorToRGB(AColor){$IFDEF DELPHI7}, 12 {$ENDIF});
      Style.GradientColor := GetShadowColor(ColorToRGB(AColor){$IFDEF DELPHI7}, 12 {$ENDIF});
    end;
  end;
end;

procedure TfrmAdvancedMain.fcxDirDatasetOpen(Sender: TObject);
begin
  if not SelectDirectory('Select directory', '', FDirectory) then
    FDirectory := ExtractFilePath(ParamStr(0));
  FEof := False;
end;

procedure TfrmAdvancedMain.fcxDirDatasetFirst(Sender: TObject);
begin
  FEof := FindFirst(FDirectory + PathDelim + AllFilesMask, faAnyFile, FSearchRec) <> 0;
end;

procedure TfrmAdvancedMain.fcxDirDatasetNext(Sender: TObject);
begin
  FEof := FindNext(FSearchRec) <> 0;
end;

function TfrmAdvancedMain.fcxDirDatasetEof(Sender: TObject): Boolean;
begin
  Result := FEof;
end;

procedure TfrmAdvancedMain.fcxDirDatasetClose(Sender: TObject);
begin
  FindClose(FSearchRec);
end;

function TfrmAdvancedMain.fcxDirDatasetGetVarData(Sender: TObject;
  AFieldIndex: Integer; out AValue: Variant): Boolean;
begin
  Result := True;
  case AFieldIndex of
    0: AValue := FileDateToDateTime(FSearchRec.Time);
    1: AValue := FSearchRec.Size;
    2: AValue := FSearchRec.Attr;
    3: AValue := FSearchRec.Name;
  else
    Result := False;
  end;
end;

procedure TfrmAdvancedMain.fcxDirDatasetDataFieldAt(Sender: TObject;
  AFieldIndex: Integer; var ADataFieldPropery: TfcxDataFieldPropery);
begin
  case AFieldIndex of
    0:
      with ADataFieldPropery do
      begin
        FieldName := 'Time';
        DisplayLabel := 'Time';
        Index := 0;
        Size := SizeOf(TDateTime);
        Visible := True;
        FieldType := ftDateTime;
      end;
    1:
      with ADataFieldPropery do
      begin
        FieldName := 'Size';
        DisplayLabel := 'Size';
        Index := 1;
        Size := SizeOf(Integer);
        Visible := True;
        FieldType := ftInteger;
      end;
    2:
      with ADataFieldPropery do
      begin
        FieldName := 'Attr';
        DisplayLabel := 'Attr';
        Index := 2;
        Size := SizeOf(Integer);
        Visible := True;
        FieldType := ftInteger;
      end;
    3:
      with ADataFieldPropery do
      begin
        FieldName := 'Name';
        DisplayLabel := 'FileName';
        Index := 3;
        Size := 0;
        Visible := True;
        FieldType := ftString;
      end;
  end;
end;

function TfrmAdvancedMain.fcxDirDatasetActive(Sender: TObject): Boolean;
begin
  Result := FSearchRec.FindHandle <> INVALID_HANDLE_VALUE;
end;

procedure TfrmAdvancedMain.MDGridGetDataCellText(Sender: TfcxSliceDataZone;
  const Cell: TfcxMeasureCell; var Text: String);
begin
  if FUserPaint then
    if Cell.IsGrandTotal then
      Text := Format('(%s) %s', [fcxResources.Get('sGrandTotal'), Text])
    else
    if Cell.IsTotal then
      Text := Format('(%s) %s', [fcxResources.Get('sTotal'), Text]);
end;

procedure TfrmAdvancedMain.employeeCalcFields(DataSet: TDataSet);
begin
  DataSet.FieldByName('Name').AsString := DataSet.FieldByName('LastName').AsString + ' ' + DataSet.FieldByName('FirstName').AsString;
end;

function TfrmAdvancedMain.fcxCalendarDatasetActive(Sender: TObject): Boolean;
begin
  Result := True;
end;

procedure TfrmAdvancedMain.fcxCalendarDatasetClose(Sender: TObject);
begin
//
end;

procedure TfrmAdvancedMain.fcxCalendarDatasetDataFieldAt(Sender: TObject; AFieldIndex:
    Integer; var ADataFieldPropery: TfcxDataFieldPropery);
begin
  case AFieldIndex of
    0:
      with ADataFieldPropery do
      begin
        FieldName := 'Date';
        DisplayLabel := 'Date';
        Index := 0;
        Size := SizeOf(TDateTime);
        Visible := True;
        FieldType := ftDate;
      end;
  end;
end;

function TfrmAdvancedMain.fcxCalendarDatasetEof(Sender: TObject): Boolean;
begin
  Result := FDate > EndOfTheYear(Now);
end;

procedure TfrmAdvancedMain.fcxCalendarDatasetFirst(Sender: TObject);
begin
  FDate := StartOfTheYear(Now);
end;

function TfrmAdvancedMain.fcxCalendarDatasetGetVarData(Sender: TObject; AFieldIndex:
    Integer; out AValue: Variant): Boolean;
begin
  AValue := FDate;
  Result := True;
end;

procedure TfrmAdvancedMain.fcxCalendarDatasetNext(Sender: TObject);
begin
  FDate := FDate + 1;
end;

procedure TfrmAdvancedMain.fcxCalendarDatasetOpen(Sender: TObject);
begin
  FDate := StartOfTheYear(Now);
end;

procedure TfrmAdvancedMain.Editstyles1Click(Sender: TObject);
begin
  with TfcxStylesEditorDialog.Create(nil) do
  begin
    Styles := MDGrid.Styles;
    if Execute then
      MDGrid.Styles := TfcxSliceGridStyles(Styles);
  end;
end;

procedure TfrmAdvancedMain.About1Click(Sender: TObject);
begin
  with TAboutForm.Create(Application) do
  begin
    ShowModal;
    Free;
  end;
end;

procedure TfrmAdvancedMain.SetActiveCube(const Value: TTreeNode);
var
  Data: PTreeNodeValue;
  I: Integer;
  D: Cardinal;
begin
  if (FActiveCube <> Value) then
  begin
    FActiveCube := Value;
    Data := PTreeNodeValue(Value.Data);
    FUserPaint := Data^.StateIndex = 5;
    Panel1.Visible := Data^.StateIndex = 16;
    Panel3.Visible := Data^.StateIndex in [12, 22];
    Panel4.Visible := Data^.StateIndex = 23;
    case Data^.StateIndex of
      0, 5, 22, 23: // regular cube
        OpenSampleCube(Data^.FileName);
      1: // speed test
      begin
        D := GetTickCount;
        OpenSampleCube(Data^.FileName);
        D := GetTickCount - D;
        MessageDlg(Format('Cube was loaded with %d msecs', [D]), mtInformation, [mbOk], 0);
      end;
      2,12: // ADO example
        begin
          Button4.Enabled := True;
          Button5.Enabled := True;
          TADOQuery(fcxDBDSItems.DataSet).SQL.Text :=
            'SELECT items.orderno, items.partno, items.qty, orders.custno, orders.empno, orders.saledate'#$D#$A+
            'FROM items LEFT OUTER JOIN orders ON items.orderno = orders.orderno where items.orderno < 1100';
          MDCube.Close;
          MDCube.DataSource := Demo;
          MDCube.CubeSource := fccs_DataSource;
          MDCube.Open;
          MDSlice.LoadfromFile(GetDataPath + 'cubes' + PathDelim + Data^.FileName);
          MDCube.Caption := Data^.Description;
          MDSlice.XAxisContainer.InsertMeasuresField(0);
        end;
      3: // FR
        begin
          OpenSampleReport;
          Exit;
        end;
      4: // radio filter
        begin
          OpenSampleCube(Data^.FileName);
          for I := 0 to MDSlice.FieldsOfRegion[rf_Page].Count - 1 do
            TfcxAxisField(MDSlice.FieldsOfRegion[rf_Page].Items[I]).SliceField.UVFilterType := uvft_Single;
          MDGrid.PageDimsZone.DropDown(0);
        end;
      6, 16: // user dataset
        begin
          FSearchRec.FindHandle := INVALID_HANDLE_VALUE;
          MDCube.Close;
          fcDataSource1.DataSet := fcxDirDataset;
          MDCube.DataSource := fcDataSource1;
          MDCube.CubeSource := fccs_DataSource;
          MDCube.Open;
          MDCube.Caption := Data^.Description;
          MDSlice.YAxisContainer.AddDimension(MDSlice.SliceFields.ItemByName['Name'], 'Name', 'File Name');
          MDSlice.MeasuresContainer.AddMeasure(MDSlice.SliceFields.ItemByName['Size'], 'Size', 'File Size', af_FirstValue);
          MDSlice.MeasuresContainer.AddMeasure(MDSlice.SliceFields.ItemByName['Attr'], 'Attr', 'File Attr', af_FirstValue);
          MDSlice.MeasuresContainer.AddMeasure(MDSlice.SliceFields.ItemByName['Time'], 'Time', 'File Time', af_FirstValue);
          MDSlice.XAxisContainer.InsertMeasuresField(0);
        end;
      7: // user dataset calendar
        begin
          MDCube.Close;
          MDCube.DataSource := fcxCalendarDataSource;
          MDCube.CubeSource := fccs_DataSource;
          MDCube.Open;
          MDCube.Caption := Data^.Description;
          if MDCube.Caption = 'Calendar' then
            MDSlice.LoadfromFile(GetDataPath + 'cubes' + PathDelim + 'calendar_en.mds')
          else
            MDSlice.LoadfromFile(GetDataPath + 'cubes' + PathDelim + 'calendar.mds');
  //        MDSlice.AddSliceFieldToRegion(MDSlice.SliceFields.ItemByName['Date'], 'Date', 'Date', rf_CapYAx);
  //        MDSlice.AddSliceFieldToRegion(MDSlice.SliceFields.ItemByName['Time'], 'Time', 'File Time', rf_CapFacts, af_FirstValue);
  //        MDSlice.MeasuresContainer.Container := MDSlice.XAxisContainer;
        end;
      else
        begin
          OpenSampleCube(Data^.FileName);
        end;
    end;
  end;
end;

procedure TfrmAdvancedMain.TreeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Key := 0;
end;

procedure TfrmAdvancedMain.CreateAdoObjects;
var
  Items, Customer, Employee, Parts, Orders, Vendors: TAdoQuery;
  I: Integer;
  employeeName: TStringField;
  DemoConnection: TAdoConnection;

  function NewQuery: TAdoQuery;
  begin
    Result := TAdoQuery.Create(Self);
    Result.Connection := DemoConnection;
    Result.CursorType := ctStatic;
  end;

  function NewTable(const ATableName: String): TAdoQuery;
  begin
    Result := NewQuery;
    Result.SQL.Text := 'SELECT * FROM ' + ATableName;
  end;

begin
  DemoConnection := TADOConnection.Create(Self);
  DemoConnection.Provider := 'Microsoft.Jet.OLEDB.4.0;Data Source=' + GetDataPath + 'demo.mdb;Persist Security Info=False';
  DemoConnection.LoginPrompt := False;
  DemoConnection.Mode := cmShareDenyNone;
  DemoConnection.Connected := True;
  Items := NewQuery;
  Items.SQL.Text :=
    'SELECT items.orderno, items.partno, items.qty, orders.custno, orders.empno, orders.saledate'#$D#$A+
//    'FROM items LEFT OUTER JOIN orders ON items.orderno = orders.orderno';
    'FROM items LEFT OUTER JOIN orders ON items.orderno = orders.orderno where items.orderno < 1100';
  fcxDBDSItems.DataSet := Items;

  Customer := NewTable('CUSTOMER');
  fcxDBDSCustomer.DataSet := Customer;

  Employee := NewTable('EMPLOYEE');
  Employee.OnCalcFields := employeeCalcFields;
  Employee.FieldDefs.Update;
  fcxDBDSEmployee.DataSet := Employee;
  for I := 0 to Employee.FieldDefs.Count - 1 do
    Employee.FieldDefs[I].CreateField(Employee);

  employeeName := TStringField.Create(Self);
  employeeName.FieldName := 'Name';
  employeeName.FieldKind := fkCalculated;
  employeeName.Size := 36;
  employeeName.DataSet := Employee;

  Parts := NewTable('PARTS');
  fcxDBDSParts.DataSet := Parts;

  Orders := NewTable('ORDERS');
  fcxDBDSOrders.DataSet := Orders;

  Vendors := NewTable('VENDORS');
  fcxDBVendors.DataSet := Vendors;
end;

procedure TfrmAdvancedMain.TreeClick(Sender: TObject);
begin
  if PTreeNodeValue(Tree.Selected.Data).StateIndex <> -1 then
  begin
    CubeDescr.Lines.Text := StringToControl(PTreeNodeValue(Tree.Selected.Data)^.Description);
    OpenExample(Tree.Selected, False);
    Tree.Selected.Expand(True);
  end;
end;

procedure TfrmAdvancedMain.Button1Click(Sender: TObject);
var
 AStr: String;
begin
  AStr := MDCube.Caption;
  FSearchRec.FindHandle := INVALID_HANDLE_VALUE;
  MDCube.Close;
  fcDataSource1.DataSet := fcxDirDataset;
  MDCube.DataSource := fcDataSource1;
  MDCube.CubeSource := fccs_DataSource;
  MDCube.Open;
  MDCube.Caption := AStr;
  MDSlice.YAxisContainer.AddDimension(MDSlice.SliceFields.ItemByName['Name'], 'Name', 'File Name');
  MDSlice.MeasuresContainer.AddMeasure(MDSlice.SliceFields.ItemByName['Size'], 'Size', 'File Size', af_FirstValue);
  MDSlice.MeasuresContainer.AddMeasure(MDSlice.SliceFields.ItemByName['Attr'], 'Attr', 'File Attr', af_FirstValue);
  MDSlice.MeasuresContainer.AddMeasure(MDSlice.SliceFields.ItemByName['Time'], 'Time', 'File Time', af_FirstValue);
  MDSlice.XAxisContainer.InsertMeasuresField(0);
end;

procedure TfrmAdvancedMain.Button2Click(Sender: TObject);
begin
  FSearchRec.FindHandle := INVALID_HANDLE_VALUE;
  MDCube.AppendData;
  MDSlice.YAxisContainer.AddDimension(MDSlice.SliceFields.ItemByName['Name'], 'Name', 'File Name');
  MDSlice.MeasuresContainer.AddMeasure(MDSlice.SliceFields.ItemByName['Size'], 'Size', 'File Size', af_FirstValue);
  MDSlice.MeasuresContainer.AddMeasure(MDSlice.SliceFields.ItemByName['Attr'], 'Attr', 'File Attr', af_FirstValue);
  MDSlice.MeasuresContainer.AddMeasure(MDSlice.SliceFields.ItemByName['Time'], 'Time', 'File Time', af_FirstValue);
  MDSlice.XAxisContainer.InsertMeasuresField(0);
end;

procedure TfrmAdvancedMain.Button4Click(Sender: TObject);
var
  Data: PTreeNodeValue;
  AStream: TMemoryStream;
begin
  Data := PTreeNodeValue(FActiveCube.Data);
  if Data^.StateIndex = 22 then
  begin
    Button4.Enabled := False;
    AStream := TMemoryStream.Create;
    MDSlice.SaveToStream(AStream);
    AStream.Position := 0;
    MDCube.AppendFromFile(GetDataPath + 'cubes' + PathDelim + '2_0_append_2.mdc');
    MDSlice.LoadFromStream(AStream);
    AStream.Free
  end
  else
  if Data^.StateIndex = 23 then
  begin
    Button7.Enabled := False;
    AStream := TMemoryStream.Create;
    MDSlice.SaveToStream(AStream);
    AStream.Position := 0;
    MDCube.AppendFromFile(GetDataPath + 'cubes' + PathDelim + '2_0_Year_2005.mdc');
    MDSlice.LoadFromStream(AStream);
    AStream.Free
  end
  else
  begin
    Button4.Enabled := False;
    TADOQuery(fcxDBDSItems.DataSet).SQL.Text :=
      'SELECT items.orderno, items.partno, items.qty, orders.custno, orders.empno, orders.saledate'#$D#$A+
      'FROM items LEFT OUTER JOIN orders ON items.orderno = orders.orderno where items.orderno between 1100 and 1199';
    MDCube.AppendData;
    MDSlice.LoadfromFile(GetDataPath + 'cubes' + PathDelim + Data^.FileName);
    MDCube.Caption := Data^.Description;
    MDSlice.XAxisContainer.InsertMeasuresField(0);
  end
end;

procedure TfrmAdvancedMain.Button5Click(Sender: TObject);
var
  Data: PTreeNodeValue;
  AStream: TMemoryStream;
begin
  Data := PTreeNodeValue(FActiveCube.Data);
  if Data^.StateIndex = 22 then
  begin
    Button5.Enabled := False;
    AStream := TMemoryStream.Create;
    MDSlice.SaveToStream(AStream);
    AStream.Position := 0;
    MDCube.AppendFromFile(GetDataPath + 'cubes' + PathDelim + '2_0_append_3.mdc');
    MDSlice.LoadFromStream(AStream);
    AStream.Free
  end
  else
  if Data^.StateIndex = 23 then
  begin
    Button8.Enabled := False;
    AStream := TMemoryStream.Create;
    MDSlice.SaveToStream(AStream);
    AStream.Position := 0;
    MDCube.AppendFromFile(GetDataPath + 'cubes' + PathDelim + '2_0_Year_2006.mdc');
    MDSlice.LoadFromStream(AStream);
    AStream.Free
  end
  else
  begin
    Button5.Enabled := False;
    TADOQuery(fcxDBDSItems.DataSet).SQL.Text :=
      'SELECT items.orderno, items.partno, items.qty, orders.custno, orders.empno, orders.saledate'#$D#$A+
      'FROM items LEFT OUTER JOIN orders ON items.orderno = orders.orderno where items.orderno >= 1200';
    MDCube.AppendData;
    MDSlice.LoadfromFile(GetDataPath + 'cubes' + PathDelim + Data^.FileName);
    MDCube.Caption := Data^.Description;
    MDSlice.XAxisContainer.InsertMeasuresField(0);
  end;
end;

procedure TfrmAdvancedMain.Button3Click(Sender: TObject);
var
  Data: PTreeNodeValue;
  AStream: TMemoryStream;
begin
  Data := PTreeNodeValue(FActiveCube.Data);
  if Data^.StateIndex = 22 then
  begin
    Button4.Enabled := True;
    Button5.Enabled := True;
    AStream := TMemoryStream.Create;
    MDSlice.SaveToStream(AStream);
    AStream.Position := 0;
    MDCube.LoadFromFile(GetDataPath + 'cubes' + PathDelim + '2_0_append_3.mdc');
    MDSlice.LoadFromStream(AStream);
    AStream.Free
  end
  else
  if Data^.StateIndex = 23 then
  begin
    Button7.Enabled := True;
    Button8.Enabled := True;
    AStream := TMemoryStream.Create;
    MDSlice.SaveToStream(AStream);
    AStream.Position := 0;
    MDCube.LoadFromFile(GetDataPath + 'cubes' + PathDelim + '2_0_Year_2004.mdc');
    MDSlice.LoadFromStream(AStream);
    AStream.Free
  end
  else
  begin
    Button4.Enabled := True;
    Button5.Enabled := True;
    TADOQuery(fcxDBDSItems.DataSet).SQL.Text :=
      'SELECT items.orderno, items.partno, items.qty, orders.custno, orders.empno, orders.saledate'#$D#$A+
      'FROM items LEFT OUTER JOIN orders ON items.orderno = orders.orderno where items.orderno < 1100';
    MDCube.Close;
    MDCube.DataSource := Demo;
    MDCube.CubeSource := fccs_DataSource;
    MDCube.Open;
    MDSlice.LoadfromFile(GetDataPath + 'cubes' + PathDelim + Data^.FileName);
    MDCube.Caption := Data^.Description;
    MDSlice.XAxisContainer.InsertMeasuresField(0);
  end;
end;

procedure TfrmAdvancedMain.MDGridGetAxisCellImageIndex(
  Sender: TfcxSliceCustomAxisZone; const AInfo: TfcxCellInfo;
  var ImageIndex: Integer);
var
  AxisInfo: TfcxAxisLevelInfo;
  AttrIndex: Integer;
  AttrValue: Variant;
begin
  if Assigned(Tree.Selected) and
     (PTreeNodeValue(Tree.Selected.Data)^.StateIndex in [6, 16]) and
     (AInfo.Data.CellProperties * [pca_GrandTotal, pca_StartTotal] = []) then
  begin
    AxisInfo := Sender.AxisContainer.LevelInfo[AInfo.Data.TreeRect.Level];
    if Assigned(AxisInfo.RegionField) and (AxisInfo.RegionField.Name = 'Name') then
    begin
      AttrIndex := Sender.AxisContainer.Slice.MeasuresContainer.MeasureFields.IndexByName['Attr'];
      if AttrIndex = -1 then
        AttrValue := Null
      else
        AttrValue := Sender.AxisContainer.Slice.GetMeasureValueXY(-1, AInfo.Data.NodeLevel, 0, AInfo.Data.NodeIndex, AttrIndex, -1, -1);
      if TVarData(AttrValue).VType = varInteger then
      begin
        if (faDirectory and Integer(AttrValue)) <> 0 then
          ImageIndex := 0
        else
          ImageIndex := 1;
      end
      else
        ImageIndex := -1;
    end;
  end;
end;

procedure TfrmAdvancedMain.PrintBtnClick(Sender: TObject);
begin
  frxReport.LoadFromFile(GetDataPath + 'cubes' + PathDelim + 'ver2rep.fr3');
  frxReport.ShowReport();
//  frxReport.DesignReport();
end;

procedure TfrmAdvancedMain.frxReportGetValue(const VarName: String; var Value: Variant);
begin
{
  if VarName = 'CUBEDESCRIPTION' then
    value := PTreeNodeValue(Tree.Selected.Data)^.Description
  else
  if VarName = 'SCHEMADESCRIPTION' then
    if ListBox1.itemindex >= 0 then
      value := PTreeNodeValue(Tree.Selected.Data)^.Shemas[ListBox1.itemindex].Description
    else
      value := ''
  else
}
  if VarName = 'CUBECAPTION' then
    value := MDCube.Caption
{
  else
  if VarName = 'SCHEMACAPTION' then
    value := MDSlice.Caption
}
end;

procedure TfrmAdvancedMain.CreateReportObjects;
begin
  frxReport := TfrxReport.Create(Self);
  frxReport.OnGetValue := frxReportGetValue;
  frxDBDataset := TfrxDBDataset.Create(Self);
  frxDBDataset.UserName := 'frxDBDataset1';
  fcxpSliceGridProvider := TfcxpSliceGridProvider.Create(Self);
  fcxpSliceGridProvider.SliceGrid := MDGrid;
  fcxpSliceGridProvider.UserName := 'fcxpSliceGridProvider1';
  fcxpSliceGridProvider.PaintSizes.AutoSizeStyle := ssAutoRowHeight;
  fcxpChartProvider := TfcxpChartProvider.Create(Self);
  fcxpChartProvider.Chart := fcxChart1;
  fcxpChartProvider.UserName := 'fcxpChartProvider1';
end;

procedure TfrmAdvancedMain.OpenSampleReport;
 var
   oldCurrentDir: string;
begin
  oldCurrentDir := GetCurrentDir();
  SetCurrentDir(FNeedExePath);
  try
    frxReport.LoadfromFile(GetDataPath + 'fr4.fr3');
    frxReport.DesignReport;
  finally
    SetCurrentDir(oldCurrentDir);
  end;
end;

end.
