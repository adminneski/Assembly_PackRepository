{*******************************************************}
{                                                       }
{                     EhLib 10.2                        }
{                                                       }
{             TMemTableFieldsEditorEh component         }
{                                                       }
{       Copyright (c) 2003-2022 by EhLib Team and       }
{                Dmitry V. Bolshakov                    }
{                                                       }
{*******************************************************}

unit MTCreateDataDriver;

interface

{$I EhLib.Inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, MemTableEh, DataDriverEh, Db, TypInfo, DBUtilsEh,
{$IFDEF CIL}
  Borland.Vcl.Design.DesignIntf,
{$ELSE}
  DesignIntf,
{$ENDIF}
  ExtCtrls;

type
  TfMTCreateDataDriver = class(TForm)
    DataSetList: TListBox;
    DataDriversList: TListBox;
    OkBtn: TButton;
    CancelBtn: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Bevel1: TBevel;
    Label3: TLabel;
    procedure OkBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
    FDataSet: TCustomMemTableEh;
    FDesigner: IDesigner;
    function Edit: Boolean;
    procedure CheckComponent(const Value: string);
  end;

  TAssingDataDriverFuncPtrEh = procedure (DataDriver: TDataDriverEh; DataSet: TDataSet);

var
  fMTCreateDataDriver: TfMTCreateDataDriver;
  DataDriversListItems: TStrings;
  AssingDataDriverFuncPtrEh: TAssingDataDriverFuncPtrEh;

function EditMTCreateDataDriver(ADataSet: TCustomMemTableEh; ADesigner: IDesigner): Boolean;

implementation

{$R *.dfm}

procedure  AssingDataDriverFunc(DataDriver: TDataDriverEh; DataSet: TDataSet);
var
  SQLPropValue: WideString;
  Params: TParams;
begin
  if DataDriver.ClassName = 'TDataSetDriverEh' then
  begin
    TDataSetDriverEh(DataDriver).ProviderDataSet := DataSet;
  end else if DataDriver is TCustomSQLDataDriverEh then
  begin
    if IsDataSetHaveSQLLikeProp(DataSet, 'SQL', SQLPropValue) then
    begin
      TCustomSQLDataDriverEh(DataDriver).SelectSQL.Text := SQLPropValue;
      Params := IProviderSupport(DataSet).PSGetParams;
      if Params <> nil then
        TSQLDataDriverEh(DataDriver).SelectCommand.Params := Params;
    end;
  end;
end;

procedure  AddToDataDriversListItems;
begin
  DataDriversListItems.AddObject('TDataSetDriverEh', TObject(TDataSetDriverEh));
  DataDriversListItems.AddObject('TSQLDataDriverEh', TObject(TSQLDataDriverEh));
  AssingDataDriverFuncPtrEh := @AssingDataDriverFunc;
end;

function EditMTCreateDataDriver(ADataSet: TCustomMemTableEh; ADesigner: IDesigner): Boolean;
var
  f: TfMTCreateDataDriver;
begin
  f := TfMTCreateDataDriver.Create(Application);
  try
    f.Caption := Format('SClientDataSetEditor', [ADataSet.Owner.Name, ADataSet.Name]);
    f.FDataSet := ADataSet;
    f.FDesigner := ADesigner;
    Result := f.Edit;
  finally
    f.Free;
  end;
end;

procedure TfMTCreateDataDriver.FormCreate(Sender: TObject);
var
  NonClientMetrics: TNonClientMetrics;
  i: Integer;
begin
  if ParentFont then
  begin
    NonClientMetrics.cbSize := sizeof(NonClientMetrics);
{$IFDEF CIL}
{$ELSE}
    if SystemParametersInfo(SPI_GETNONCLIENTMETRICS, 0, @NonClientMetrics, 0) then
      Font.Name := NonClientMetrics.lfMessageFont.lfFaceName;
{$ENDIF}
  end;

  for i := 0 to DataDriversListItems.Count - 1 do
    DataDriversList.Items.AddObject(
        DataDriversListItems[i], DataDriversListItems.Objects[i]
    );
end;

function TfMTCreateDataDriver.Edit: Boolean;
begin
  DataSetList.Clear;
  FDesigner.GetComponentNames(GetTypeData(TDataSet.ClassInfo), CheckComponent);
  if DataSetList.Items.Count > 0 then
  begin
    DataSetList.Enabled := True;
    DataSetList.ItemIndex := 0;
    OkBtn.Enabled := True;
    ActiveControl := DataSetList;
  end else
    ActiveControl := CancelBtn;
  Result := ShowModal = mrOK;
end;

procedure TfMTCreateDataDriver.OkBtnClick(Sender: TObject);
var
  ddr: TDataDriverEh;
  SourceDS: TDataSet;
{$IFDEF CIL}
{$ELSE}
  pos: LongRec;
{$ENDIF}
  ddrName: String;
  I: Integer;
  ComponentClass: TComponentClass;

  function IsUnique(const AName: string): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    for I := 0 to FDataSet.Owner.ComponentCount - 1 do
      if CompareText(AName, FDataSet.Owner.Components[I].Name) = 0 then Exit;
    Result := True;
  end;

begin
  if (DataSetList.ItemIndex < 0) or (DataDriversList.ItemIndex < 0) then Exit;
  SourceDS := FDesigner.GetComponent(DataSetList.Items[DataSetList.ItemIndex]) as TDataSet;
{$IFDEF CIL}
{$ELSE}
  ComponentClass := TComponentClass(DataDriversList.Items.Objects[DataDriversList.ItemIndex]);
  ddr := TDataDriverEh(FDesigner.CreateComponent(
    ComponentClass, FDataSet.Owner,
    LongRec(FDataSet.DesignInfo).Lo - 24, LongRec(FDataSet.DesignInfo).Hi, 0,0));
{$ENDIF}

  ddrName := 'dd' + FDataSet.Name;
  if not IsUnique(ddrName) then
    for I := 1 to MaxInt do
    begin
      ddrName := 'dd' + FDataSet.Name + IntToStr(I);
      if IsUnique(ddrName) then Break;
    end;

  ddr.Name := ddrName;
{$IFDEF CIL}
{$ELSE}
  pos.Lo := LongRec(FDataSet.DesignInfo).Lo - 24;
  pos.Hi := LongRec(FDataSet.DesignInfo).Hi;
  ddr.DesignInfo := Longint(pos);
{$ENDIF}
  FDesigner.Modified;
  FDataSet.DataDriver := ddr;

  AssingDataDriverFuncPtrEh(ddr, SourceDS);
end;

procedure TfMTCreateDataDriver.CheckComponent(const Value: string);
var
  DataSet: TDataSet;
begin
  DataSet := TDataSet(FDesigner.GetComponent(Value));
  if (DataSet.Owner <> FDataSet.Owner) then
    DataSetList.Items.Add(Concat(DataSet.Owner.Name, '.', DataSet.Name))
  else
    if AnsiCompareText(DataSet.Name, FDataSet.Name) <> 0 then
      DataSetList.Items.Add(DataSet.Name);
end;

initialization
  DataDriversListItems := TStringList.Create;
  AddToDataDriversListItems;
finalization
  FreeAndNil(DataDriversListItems);
  AssingDataDriverFuncPtrEh := nil;
end.
