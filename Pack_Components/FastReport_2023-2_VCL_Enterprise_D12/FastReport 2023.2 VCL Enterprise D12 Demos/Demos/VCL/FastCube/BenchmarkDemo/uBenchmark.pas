unit uBenchmark;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, XPMan, ActnList, ComCtrls, StdCtrls, Spin,
  ExtCtrls, fcxComponent, fcxZone, fcxCustomGrid, fcxSliceGrid, ToolWin,
  fcxSliceGridToolbar, fcxDataSource, fcxSlice, fcxCube, fcxTypes,
  fcxControl, fcxCustomToolbar, uDemoMain, ImgList, Menus, DBClient, DB, fcxFSInterpreter;

type
  TfrmBenchmarkMain = class(TfrmDemoMain)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Status: TLabel;
    d_cnt: TSpinEdit;
    m_cnt: TSpinEdit;
    r_cnt: TSpinEdit;
    dm_cnt: TSpinEdit;
    Button1: TButton;
    Button2: TButton;
    Progress: TProgressBar;
    Button3: TButton;
    actLoadDS: TAction;
    actBuildCross: TAction;
    fcxSliceGridToolbar1: TfcxSliceGridToolbar;
    fcxSliceGrid1: TfcxSliceGrid;
    fcxCube1: TfcxCube;
    fcxSlice1: TfcxSlice;
    fcxDataSource1: TfcxDataSource;
    fcxDBDataSet1: TfcxDBDataSet;
    cdsBench: TClientDataSet;
    procedure actBuildCrossExecute(Sender: TObject);
    procedure actBuildCrossUpdate(Sender: TObject);
    procedure actLoadDSExecute(Sender: TObject);
    procedure actLoadDSUpdate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    FDataSetCreated: boolean;
    FDataSetLoaded: boolean;
    procedure BuildDS;
    procedure UpdateStatus(StatusText: string);
    procedure CreateTable;
  end;

var
  frmBenchmarkMain: TfrmBenchmarkMain;

implementation

{$R *.dfm}
const
  ABDExitst: boolean = false;//true;

resourcestring
  sBuildInfo = 'Время построения %.3f. Число ячеек %d';
  sFetchingStart = 'Загрузка данных в куб';
  sFetchingEnd = 'Данные загружены в куб';
  sFetchingError = 'Ошибка при загрузке данных в куб';
  sPreparingSlice = 'Подготовка среза';
  sDatasetStart = 'Создание набора данных';
  sDatasetEnd = 'Создан набор данных';
  sDatasetError = 'Ошибка при создании набора данных';

function GetNewStrS(Len: Integer): string;
var
  i: integer;
  S: string;
begin
  Len := 1 + Random(Len - 1);
  S := '';
  for i := 0 to Len - 1 do
    S := S + Chr(Ord('a') + Random(26));
  Result := s;
end;

procedure TfrmBenchmarkMain.actBuildCrossExecute(Sender: TObject);
const
  Regs: array[0..1] of TfcxRegionOfField =
    (
    rf_CapYAx,
    rf_CapXAx
    );
var
  tmAxis, tmMeasures: DWord;
  CellCount: Int64;
  AOldCursor: TCursor;
begin
  Progress.Max := 100;
  Progress.Min := 0;
  Progress.Step := 50;
  Progress.Visible := True;
  AOldCursor := Cursor;
  Cursor := crHourGlass;
  try
    tmAxis := GetTickCount;
    fcxSlice1.BeginUpdate;
    if d_cnt.Value > 0 then
      fcxSlice1.YAxisContainer.AddDimension(fcxSlice1.SliceField[0], 'Dim' + IntToStr(1), 'Dim' + IntToStr(1));
    if d_cnt.Value > 1 then
      fcxSlice1.XAxisContainer.AddDimension(fcxSlice1.SliceField[1], 'Dim' + IntToStr(2), 'Dim' + IntToStr(2));
    if d_cnt.Value > 2 then
      fcxSlice1.YAxisContainer.AddDimension(fcxSlice1.SliceField[2], 'Dim' + IntToStr(3), 'Dim' + IntToStr(3));
    tmAxis := GetTickCount - tmAxis;
    Progress.StepIt;
    tmMeasures := GetTickCount;
    fcxSlice1.XAxisContainer.InsertMeasuresField(1);
    fcxSlice1.EndUpdate;
    tmMeasures := GetTickCount - tmMeasures;
    CellCount := fcxSlice1.XAxisContainer.VisibleAxisNodes.Count *
      fcxSlice1.YAxisContainer.VisibleAxisNodes.Count;
    Progress.StepIt;
  finally
    Cursor := AOldCursor;
  end;
  UpdateStatus(Format(sBuildInfo, [(tmAxis + tmMeasures) / 1000, CellCount]));
  MessageDlg(Format(sBuildInfo, [(tmAxis + tmMeasures) / 1000, CellCount]), mtInformation, [mbOk], 0);
  Progress.Visible := False;
end;

procedure TfrmBenchmarkMain.actBuildCrossUpdate(Sender: TObject);
begin
  actBuildCross.Enabled := FDataSetLoaded;
end;

procedure TfrmBenchmarkMain.actLoadDSExecute(Sender: TObject);
var
  i: integer;
  tmLoad: DWord;
begin
  if ABDExitst then
  begin
    cdsBench.Close;
    cdsBench.FileName := ExtractFilePath(ParamStr(0)) + 'bench.cds';
  end;
  UpdateStatus(sFetchingStart);
  tmLoad := GetTickCount;
  try
    fcxDataSource1.DeleteFields;
    fcxCube1.Open;
    // filling Slice
    UpdateStatus(sPreparingSlice);
    for i := 0 to d_cnt.Value - 1 do
      fcxSlice1.PageContainer.AddFilterField(fcxSlice1.SliceField[i], 'Dim' + IntToStr(i + 1), 'Dim' + IntToStr(i + 1));

    for i := 0 to m_cnt.Value - 1 do
      fcxSlice1.MeasuresContainer.AddMeasure(fcxSlice1.SliceField[d_cnt.Value + i], 'Measure' + IntToStr(i + 1), 'Measure' + IntToStr(i + 1), af_Sum);
  except
    fcxCube1.Close;
    ShowMessage(sFetchingError);
    FDataSetLoaded := False;
    Exit;
  end;
  tmLoad := GetTickCount - tmLoad;
  UpdateStatus(sFetchingEnd);
  FDataSetLoaded := True;
  ShowMessage('Общее время построения: ' + FloatToStr(tmLoad/1000) + ' сек');
end;

procedure TfrmBenchmarkMain.actLoadDSUpdate(Sender: TObject);
begin
  actLoadDS.Enabled := FDataSetCreated or ABDExitst;
end;

procedure TfrmBenchmarkMain.Button1Click(Sender: TObject);
begin
  UpdateStatus(sDatasetStart);
  fcxCube1.Close;
  try
    BuildDS;
  except
    ShowMessage(sDatasetError);
    FDataSetCreated := False;
    FDataSetLoaded := False;
    Exit;
  end;
  UpdateStatus(sDatasetEnd);
  FDataSetCreated := True;
  FDataSetLoaded := False;
end;

procedure TfrmBenchmarkMain.UpdateStatus(StatusText: string);
begin
  Status.Caption := StatusText;
  Application.ProcessMessages;
end;

procedure TfrmBenchmarkMain.CreateTable;
var
  i: integer;
begin
  cdsBench.Close;
  cdsBench.FileName := ExtractFilePath(ParamStr(0)) + 'bench.db';
  cdsBench.FieldDefs.Clear;

  for i := 0 to d_cnt.Value - 1 do
    with cdsBench.FieldDefs.AddFieldDef do
    begin
      Name := 'Dim' + IntToStr(i + 1);
      DataType := ftString;
      Size := 10;
    end;
  for i := 0 to m_cnt.Value - 1 do
    with cdsBench.FieldDefs.AddFieldDef do
    begin
      Name := 'Measure' + IntToStr(i + 1);
      DataType := ftInteger;
    end;
  cdsBench.CreateDataSet;
end;

procedure TfrmBenchmarkMain.BuildDS;
var
  i, j: integer;
  RandStr: TStringList;
  a: array of TVarRec;
  AStr: string;
begin
  Randomize;

  // prepare progress
  Progress.Max := r_cnt.Value;
  Progress.Min := 0;
  Progress.Step := 100;
  Progress.Visible := True;
  SetLength(a, d_cnt.Value + m_cnt.Value);

  // 1. create paradox table with required fields
  CreateTable;
  cdsBench.Open;
  cdsBench.Edit;

  RandStr := TStringList.Create;
  RandStr.Duplicates := dupIgnore;
  RandStr.Sorted := True;
  try
    // 1. generate unique strings
    while RandStr.Count < dm_cnt.Value do
      RandStr.Add(GetNewStrS(10));

    // 2. populate table with random data
    for i := 0 to r_cnt.Value - 1 do
    begin
      for j := 0 to d_cnt.Value - 1 do
      begin
        a[j].VType := vtAnsiString;
        // We should add to dimenension all values from the list and only after 
        // use random to ensure that dimension uniques count be equal to spinedit value
        if i < dm_cnt.Value then
          AStr := RandStr[i]
        else
          AStr := RandStr[Random(dm_cnt.Value)];
        a[j].VAnsiString := Pointer(AStr);
      end;
      for j := d_cnt.Value to d_cnt.Value + m_cnt.Value - 1 do
      begin
        a[j].VType := vtInteger;
        a[j].VInteger := Random(255);
      end;
      cdsBench.AppendRecord(a);
      if (i + 1) mod 100 = 0 then
        Progress.StepIt;
    end;
  finally
    RandStr.Free;
  end;
  cdsBench.Close;
  Progress.Visible := False;
end;

end.
