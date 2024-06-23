{*******************************************************}
{                                                       }
{                        EhLib 10.2                     }
{                                                       }
{            PivotField Sum function Edit Form          }
{                                                       }
{   Copyright (c) 2014-2022 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

unit EditPivotFieldFormEh;

{$I EhLib.Inc}

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  {$IFDEF EH_LIB_17} System.UITypes, {$ENDIF}
  {$IFDEF FPC}
  MaskEdit, EhLibLCL,
  {$ELSE}
  Mask, Windows,
  {$ENDIF}
  Messages, Dialogs, StdCtrls,
  ToolCtrlsEh, LanguageResManEh, DBCtrlsEh, PivotGridsEh;

type
  TfEditPivotField = class(TForm)
    lFieldName: TLabel;
    fAggrFunc: TLabel;
    ListBox1: TListBox;
    bOk: TButton;
    bCancel: TButton;
    lDisplayFormat: TLabel;
    cbDisplayFormat: TDBComboBoxEh;
    procedure FormCreate(Sender: TObject);
  private
    FSumFunction: TPivotValueTypeEh;
    FVisibleAggregateFunction: TPivotValueTypesEh;
    procedure WMSettingChange(var Message: TMessage); message WM_SETTINGCHANGE;
    procedure SetSumFunction(const Value: TPivotValueTypeEh);
    procedure SetVisibleAggregateFunction(const Value: TPivotValueTypesEh);
  protected
    procedure ResourceLanguageChanged; virtual;
  public
    procedure UpdateSumFunctionSelection;

    property VisibleAggregateFunction: TPivotValueTypesEh read FVisibleAggregateFunction write SetVisibleAggregateFunction;
    property SumFunction: TPivotValueTypeEh read FSumFunction write SetSumFunction;
  end;

var
  fEditPivotField: TfEditPivotField;

function EditPivotField(PivotFieldValueInfo: TPivotFieldValueInfoEh;
  VisibleAggregateFunction: TPivotValueTypesEh): Boolean;

implementation

uses EhLibLangConsts;

{$R *.dfm}

function EditPivotField(PivotFieldValueInfo: TPivotFieldValueInfoEh;
  VisibleAggregateFunction: TPivotValueTypesEh): Boolean;
var
  f: TfEditPivotField;
begin
  Result := False;
  f := TfEditPivotField.Create(Application);

  f.lFieldName.Caption := {'Pivot field: ' + }PivotFieldValueInfo.PivotField.FieldName;
  f.lFieldName.Font.Style := f.Font.Style + [fsBold];
  f.VisibleAggregateFunction := VisibleAggregateFunction;
  f.SumFunction := PivotFieldValueInfo.SumFunction;
  f.cbDisplayFormat.Text := PivotFieldValueInfo.DisplayFormat;

  if f.ShowModal = mrOk then
  begin
    if f.ListBox1.ItemIndex >= 0 then
      PivotFieldValueInfo.SumFunction := TPivotValueTypeEh(f.ListBox1.Items.Objects[f.ListBox1.ItemIndex]);
    PivotFieldValueInfo.DisplayFormat := f.cbDisplayFormat.Text;
    Result := True;
  end;
  f.Free;
end;

{ TfEditPivotField }

procedure TfEditPivotField.FormCreate(Sender: TObject);
begin
  ResourceLanguageChanged;
end;

procedure TfEditPivotField.WMSettingChange(var Message: TMessage);
begin
  inherited;
  ResourceLanguageChanged;
end;

procedure TfEditPivotField.ResourceLanguageChanged;
begin
  Caption := EhLibLanguageConsts.EditPivotField_Caption; 
  fAggrFunc.Caption := EhLibLanguageConsts.EditPivotField_AggrFunc; 
  lDisplayFormat.Caption := EhLibLanguageConsts.EditPivotField_DisplayFormat; 
  bOk.Caption := EhLibLanguageConsts.OKButtonEh;
  bCancel.Caption := EhLibLanguageConsts.CancelButtonEh;
end;

procedure TfEditPivotField.SetSumFunction(const Value: TPivotValueTypeEh);
begin
  FSumFunction := Value;
  UpdateSumFunctionSelection;
end;

procedure TfEditPivotField.UpdateSumFunctionSelection;
var
  i: Integer;
begin
  ListBox1.ItemIndex := -1;
  for i := 0 to ListBox1.Items.Count-1 do
  begin
    if ListBox1.Items.Objects[i] = TObject(FSumFunction) then
    begin
      ListBox1.ItemIndex := i;
      Break;
    end;
  end;
end;

procedure TfEditPivotField.SetVisibleAggregateFunction(
  const Value: TPivotValueTypesEh);
begin
  FVisibleAggregateFunction := Value;

  ListBox1.Items.Clear;
  if svtSumEh in VisibleAggregateFunction then
    ListBox1.Items.AddObject(EhLibLanguageConsts.PivotSumFunctionSum, TObject(svtSumEh));
  if svtCountEh in VisibleAggregateFunction then
    ListBox1.Items.AddObject(EhLibLanguageConsts.PivotSumFunctionCount, TObject(svtCountEh));
  if svtAvgEh in VisibleAggregateFunction then
    ListBox1.Items.AddObject(EhLibLanguageConsts.PivotSumFunctiontAvg, TObject(svtAvgEh));
  if svtMaxEh in VisibleAggregateFunction then
    ListBox1.Items.AddObject(EhLibLanguageConsts.PivotSumFunctionMax, TObject(svtMaxEh));
  if svtMinEh in VisibleAggregateFunction then
    ListBox1.Items.AddObject(EhLibLanguageConsts.PivotSumFunctionMin, TObject(svtMinEh));
  if svtCountDistinctEh in VisibleAggregateFunction then
    ListBox1.Items.AddObject(EhLibLanguageConsts.PivotSumFunctionCountDistinct, TObject(svtCountDistinctEh));
  if svtProductEh in VisibleAggregateFunction then
    ListBox1.Items.AddObject(EhLibLanguageConsts.PivotSumFunctionProduct, TObject(svtProductEh));
  if svtStDevEh in VisibleAggregateFunction then
    ListBox1.Items.AddObject(EhLibLanguageConsts.PivotSumFunctionStDev, TObject(svtStDevEh));
  if svtStDevpEh in VisibleAggregateFunction then
    ListBox1.Items.AddObject(EhLibLanguageConsts.PivotSumFunctionStDevp, TObject(svtStDevpEh));
  if svtVarEh in VisibleAggregateFunction then
    ListBox1.Items.AddObject(EhLibLanguageConsts.PivotSumFunctionVar, TObject(svtVarEh));
  if svtVarpEh in VisibleAggregateFunction then
    ListBox1.Items.AddObject(EhLibLanguageConsts.PivotSumFunctionVarp, TObject(svtVarpEh));
end;

end.
