{*******************************************************}
{                                                       }
{                       EhLib 10.2                      }
{                                                       }
{            TfDesignConnectionListEh form              }
{                                                       }
{    Copyright (c) 2005-2022 by Dmitry V. Bolshakov     }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit DesignConnectionListEh;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Contnrs,
  Dialogs, StdCtrls, DB, MemTableEh, ExtCtrls, DBGridEh, SQLDriverEditEh,
{$IFDEF CIL}
  EhLibVCLNET,
{$ELSE}
  EhLibVCL,
{$ENDIF}
  Variants,
  GridsEh, DBGridEhGrouping, DBGridEhToolCtrls, MemTableDataEh, ToolCtrlsEh,
  DynVarsEh, DBAxisGridsEh;

type
  TfDesignConnectionListEh = class(TForm)
    DBGridEh1: TDBGridEh;
    Panel1: TPanel;
    DataSource1: TDataSource;
    MemTableEh1: TMemTableEh;
    MemTableEh1ConnectionName: TStringField;
    MemTableEh1Engine: TStringField;
    MemTableEh1ServerType: TStringField;
    MemTableEh1Connected: TBooleanField;
    bSelect: TButton;
    bNew: TButton;
    bDelete: TButton;
    bCancel: TButton;
    bEdit: TButton;
    MemTableEh1RefObject: TRefObjectField;
    procedure bEditClick(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure bNewClick(Sender: TObject);
    procedure bDeleteClick(Sender: TObject);
    procedure bSelectClick(Sender: TObject);
  private
    { Private declarations }
  public
    FDesignDataBase: TObject;
    procedure PrepareList(DesignDataBaseList: TObjectList);
    function CurrentDesignDataBase: TDesignDataBaseEh;
  end;

var
  fDesignConnectionListEh: TfDesignConnectionListEh;

function SelectDesignConnectionListEh(DesignDataBaseList: TObjectList): TDesignDataBaseEh;

implementation

{$R *.dfm}

function SelectDesignConnectionListEh(DesignDataBaseList: TObjectList): TDesignDataBaseEh;
var
  DCForm: TfDesignConnectionListEh;
begin
  Result := nil;
  DCForm := TfDesignConnectionListEh.Create(Application);
  DCForm.PrepareList(DesignDataBaseList);
  if DCForm.ShowModal = mrOk then
    Result := TDesignDataBaseEh(DCForm.FDesignDataBase);

  DCForm.Free;
end;

{ TfDesignConnectionListEh }

function TfDesignConnectionListEh.CurrentDesignDataBase: TDesignDataBaseEh;
begin
  Result := nil;
end;

procedure TfDesignConnectionListEh.PrepareList(DesignDataBaseList: TObjectList);
var
  i: Integer;
  ddb: TDesignDataBaseEh;
begin
  for i := 0 to DesignDataBaseList.Count-1 do
  begin
    MemTableEh1.Append;
    ddb := TDesignDataBaseEh(DesignDataBaseList[i]);
    MemTableEh1['ConnectionName'] := ddb.DesignConnectionName;
    MemTableEh1['Engine'] := ddb.GetEngineName;
    MemTableEh1['ServerType'] := ddb.GetServerTypeName;
    MemTableEh1['Connected'] := ddb.Connected;
    MemTableEh1['RefObject'] := RefObjectToVariant(DesignDataBaseList[i]);
    MemTableEh1.Post;
  end;
end;

procedure TfDesignConnectionListEh.bNewClick(Sender: TObject);
var
  sdb: TSelectDBService;
begin
  sdb := TSelectDBService.Create;
  if GUISelectAccessEngine(sdb) and (sdb.AccessEngine <> nil) then
    sdb.AccessEngine.CreateDesignDataBase(nil, sdb.DBServiceClass, sdb.DBName);
  sdb.Free;
  while not MemTableEh1.Eof do
    MemTableEh1.Delete;
  PrepareList(DesignDataBaseList);
end;

procedure TfDesignConnectionListEh.bDeleteClick(Sender: TObject);
var
  RefObject: TObject;
begin
  RefObject := VariantToRefObject(MemTableEh1['RefObject']);
  MemTableEh1.Edit;
  MemTableEh1['RefObject'] := Null;
  MemTableEh1.Post;
  MemTableEh1.Delete;
  if RefObject <> nil then
    RefObject.Free;
end;

procedure TfDesignConnectionListEh.bSelectClick(Sender: TObject);
begin
  if VarIsNull(MemTableEh1['RefObject'])
    then FDesignDataBase := nil
    else FDesignDataBase := TDesignDataBaseEh(VariantToRefObject(MemTableEh1['RefObject']));
end;

procedure TfDesignConnectionListEh.DataSource1DataChange(Sender: TObject;
  Field: TField);
begin
  bSelect.Enabled := not MemTableEh1.IsEmpty;
  bDelete.Enabled := not MemTableEh1.IsEmpty;
  bEdit.Enabled := not MemTableEh1.IsEmpty;
end;

procedure TfDesignConnectionListEh.bEditClick(Sender: TObject);
var
  RefObject: TObject;
begin
  RefObject := VariantToRefObject(MemTableEh1['RefObject']);
  if (RefObject <> nil) then
    (RefObject as TDesignDataBaseEh).EditDatabaseParams;
end;

end.
