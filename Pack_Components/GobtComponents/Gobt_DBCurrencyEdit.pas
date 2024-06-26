{*******************************************************}
{                                                       }
{         Delphi VCL Extensions (RX)                    }
{                                                       }
{         Copyright (c) 2008 Jaro Benes                 }
{                                                       }
{*******************************************************}

unit Gobt_DBCurrencyEdit;

interface

uses
  SysUtils, {$IFNDEF VER80}Windows, {$ELSE}WinTypes, WinProcs, {$ENDIF}
  Messages, Classes, Graphics, Controls, Menus, Forms, StdCtrls, Mask,
  Buttons, Gobt_CurrencyEdit, DB, DBCtrls;

  {  TDBCurrencyEdit  }

type
  TGoDBCurrencyEdit = class(TGoCurrencyEdit)
  private
    FDataLink: TFieldDataLink;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetReadOnly: Boolean; reintroduce;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(const Value: TDataSource);
    procedure SetReadOnly(const Value: Boolean);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DoDataChange(Sender: TObject);
    procedure DoEditingChange(Sender: TObject);
    procedure DoUpdateData(Sender: TObject);
    procedure DoActiveChange(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
  end;

implementation

uses Consts;
{ TDBCurrencyEdit }
procedure TGoDBCurrencyEdit.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then
    DataSource := nil;
end;

function TGoDBCurrencyEdit.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TGoDBCurrencyEdit.SetDataSource(const Value: TDataSource);
begin
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

function TGoDBCurrencyEdit.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

procedure TGoDBCurrencyEdit.SetDataField(const Value: string);
begin
//  if not (csDesigning in ComponentState) then
//    ResetMaxLength;
  FDataLink.FieldName := Value;
end;

constructor TGoDBCurrencyEdit.Create(AOwner: TComponent);
begin
  inherited;
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DoDataChange;
  FDataLink.OnEditingChange := DoEditingChange;
  FDataLink.OnUpdateData := DoUpdateData;
  FDataLink.OnActiveChange := DoActiveChange;
end;

destructor TGoDBCurrencyEdit.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited;
end;

procedure TGoDBCurrencyEdit.DoActiveChange(Sender: TObject);
begin
  if (FDataLink <> nil) and (FDataLink.Active)
    and (DataField <> '') and (FDataLink.DataSet <> nil)
    and (FDataLink.DataSet.Active) then
  begin
    if not (FDataLink.DataSet.FieldByName(DataField).DataType in [ftInteger, ftSmallint, ftWord, ftFloat]) then
    begin
      raise Exception.Create('DataField can be type number only');
    end;
  end;
end;

procedure TGoDBCurrencyEdit.DoDataChange(Sender: TObject);
begin
  if Assigned(FDataLink.Field) then
    Value := FDataLink.Field.AsFloat
  else
    Value := 0;
end;

procedure TGoDBCurrencyEdit.DoEditingChange(Sender: TObject);
begin
  if Assigned(FDataLink.Field) then
    if FDataLink.DataSet.State in [dsEdit, dsInsert] then
      FDataLink.Field.AsFloat := Value;
end;

procedure TGoDBCurrencyEdit.DoUpdateData(Sender: TObject);
begin
  try
    FDataLink.OnDataChange := nil;
    FDataLink.DataSet.Edit;
    FDataLink.Field.AsFloat := Value;
  finally
    FDataLink.OnDataChange := DoDataChange;
  end;
end;

function TGoDBCurrencyEdit.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TGoDBCurrencyEdit.SetReadOnly(const Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

end.

