unit uSimple;

interface
//{$INCLUDE fcx.inc}
uses
  Classes, Graphics, Controls, Forms, ComCtrls, ToolWin, ImgList, ActnList, Menus, DBClient, DB,
  fcxTypes, fcxComponent, fcxSlice, fcxCube, fcxCustomToolbar, fcxSliceGridToolbar,
  fcxZone, fcxCustomGrid, fcxSliceGrid, fcxDataSource, fcxControl, uDemoMain, XPMan, fcxFSInterpreter,
  frDPIAwareControls, System.ImageList, System.Actions;

type
  TfrmSimpleMain = class(TfrmDemoMain)
    fcxCube1: TfcxCube;
    fcxSlice1: TfcxSlice;
    fcxSliceGrid1: TfcxSliceGrid;
    fcxSliceGridToolBar1: TfcxSliceGridToolBar;
    FieldsImages: TImageList;
    fcxDataSource1: TfcxDataSource;
    fcxDBDataSet1: TfcxDBDataSet;
    cdsTable: TClientDataSet;
    cdsTableName: TStringField;
    cdsTableCapital: TStringField;
    cdsTableContinent: TStringField;
    cdsTableArea: TFloatField;
    cdsTablePopulation: TFloatField;
    procedure fcxSliceGrid1GetItemImageIndex(
      Sender: TfcxSliceCustomItemsZone; const ItemIndex: Integer;
      var ImageIndex: Integer);
  public
    constructor Create(AOwner: TComponent); override;
  end;

var
  frmSimpleMain: TfrmSimpleMain;

implementation

{$R *.dfm}

{ TForm1 }

constructor TfrmSimpleMain.Create(AOwner: TComponent);
begin
  inherited;
  fcxCube1.Active := True;

  // start operations
  fcxSlice1.BeginUpdate;

  // fill Y Axis
  fcxSlice1.YAxisContainer.AddDimension(fcxSlice1.SliceFields.ItemByName['Continent'], 'Continent');
  fcxSlice1.YAxisContainer.AddDimension(fcxSlice1.SliceFields.ItemByName['Name'], 'Name');

  // fill measures
  fcxSlice1.MeasuresContainer.AddMeasure(fcxSlice1.SliceFields.ItemByName['Area'], 'Area', 'Area', af_Sum);
  fcxSlice1.MeasuresContainer.AddMeasure(fcxSlice1.SliceFields.ItemByName['Population'], 'Population', 'Population', af_Sum);

  // add calculated measure Population / Area
  fcxSlice1.MeasuresContainer.AddCalcMeasure('pop_area', 'Population/Area', af_Formula,
    'CalcPopulationByArea',
    '  if Measures[''Area''].CurrentValue <> 0 then'#$D#$A+
    '    Result := Measures[''Population''].CurrentValue / Measures[''Area''].CurrentValue else'#$D#$A+
    '    Result := 0;');

  // Add Measures to X Axis
  fcxSlice1.XAxisContainer.AddMeasuresField;

  // finish operation
  fcxSlice1.EndUpdate;
end;

procedure TfrmSimpleMain.fcxSliceGrid1GetItemImageIndex(
  Sender: TfcxSliceCustomItemsZone; const ItemIndex: Integer;
  var ImageIndex: Integer);
var
  LItem: TObject;
begin
  if Sender is TfcxSliceFieldsZone then
    ImageIndex := 0
  else
    if Sender is TfcxSliceItemsZone then
    begin
      LItem := TfcxSliceItemsZone(Sender).Item[ItemIndex];
      if LItem is TfcxMeasuresContainer then
        ImageIndex := 1;
    end;
end;

end.
