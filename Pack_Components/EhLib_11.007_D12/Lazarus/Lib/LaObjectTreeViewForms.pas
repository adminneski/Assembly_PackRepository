{*******************************************************}
{                                                       }
{                       EhLib 11.0                      }
{                 LaObjectTreeViewForms                 }
{                                                       }
{    Copyright (c) 2022-2022 by Dmitry V. Bolshakov     }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit LaObjectTreeViewForms;

interface

uses
  Messages, SysUtils, Variants, Classes, Graphics, Types,
  {$IFDEF FPC}
  EhLibLCL, DBGridsEh,
  {$ELSE}
  EhLibVCL, DBGridEh,
  {$ENDIF}
  Controls, Forms, Dialogs, DBGridEhGrouping, ToolCtrlsEh,
  DBGridEhToolCtrls, DynVarsEh, GridsEh, DBAxisGridsEh,
  LaObjectsEh, ObjectInspectorEh,
  StdCtrls,
{$IFDEF EH_LIB_13} Rtti, {$ENDIF} //RAD Studio 2010
  ExtCtrls, MemTableDataEh, DB, MemTableEh;

type
  TLaObjectTreeViewForm = class(TForm)
    Panel1: TPanel;
    Splitter1: TSplitter;
    DBGridEh1: TDBGridEh;
    ObjInsPanel: TPanel;
    Button1: TButton;
    MemTableEh1: TMemTableEh;
    DataSource1: TDataSource;
    bTest: TButton;
    procedure FormCreate(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure Button1Click(Sender: TObject);
    procedure bTestClick(Sender: TObject);
  private
    FLaHost: TLaHost;
    FObjIns: TObjectInspectorEh;
    procedure SetLaHost(const Value: TLaHost);
    procedure FillLaObjectTreeViewForParent(ParentId: Int64; ALaObject: TLaObjectEh);
  public
    procedure FillLaObjectTreeView;

    property LaHost: TLaHost read FLaHost write SetLaHost;
  end;

var
  LaObjectTreeViewForm: TLaObjectTreeViewForm;

procedure ShowLaObjectTreeViewForm(LaHost: TLaHost; FormBounds: TRect;
  NewForm: Boolean = False);

//var
//  LaObjectTreeViewForm: TCustomForm;

implementation

{$R *.dfm}

procedure ShowLaObjectTreeViewForm(LaHost: TLaHost; FormBounds: TRect;
  NewForm: Boolean = False);
var
  Form: TLaObjectTreeViewForm;
//  FObjIns: TObjectInspectorEh;
//{$IFDEF EH_LIB_26} 
//  LPPI: Integer;
//{$ENDIF}
begin
  if NewForm or (LaObjectTreeViewForm = nil) then
  begin
    Form := TLaObjectTreeViewForm.Create(Application);
//    Form.ParentFont := True;
//{$IFDEF EH_LIB_26} 
//    LPPI := Screen.PixelsPerInch;
//    Form.ScaleForPPI(LPPI);
//{$ENDIF}

//    FObjIns := TObjectInspectorEh.Create(Form);
//    FObjIns.Parent := Form;
//    FObjIns.Left := 100;
//    FObjIns.Top := 100;
//    FObjIns.Anchors := [akLeft, akTop, akRight, akBottom];
//    FObjIns.Flat := True;
//    FObjIns.ParentFont := True;
//    FObjIns.LabelColWidth := 100;
//    FObjIns.Options := [goFixedVertLineEh, goVertLineEh, goEditingEh, goAlwaysShowEditorEh];
//    FObjIns.Align := alClient;
//    FObjIns.Name := 'ObjectInspectorEh';
    if not NewForm then
      LaObjectTreeViewForm := Form;
  end else
  begin
    Form := LaObjectTreeViewForm;
  end;

//  TObjectInspectorEh(Form.FindComponent('ObjectInspectorEh')).Component := Component;
//  if Component <> nil then
//  begin
//    if Component is TComponent then
//      Form.Caption := TComponent(Component).Name + ': ';
//    Form.Caption := Form.Caption + Component.ClassName
//  end else
//    Form.Caption := '';
  Form.LaHost := LaHost;

  Form.SetBounds(FormBounds.Left, FormBounds.Top,
    FormBounds.Right-FormBounds.Left, FormBounds.Bottom-FormBounds.Top);
  Form.Show;
end;

{ TLaObjectTreeViewForm }

procedure TLaObjectTreeViewForm.FillLaObjectTreeView;
var
  LaObject: TLaObjectEh;
begin
  //ID, RefParentID, DisplayName, RowType, RefRTTIObj;
  MemTableEh1.DisableControls;
  try

  if (LaHost <> nil)
    then LaObject := LaHost.LaObject
    else LaObject := nil;

  MemTableEh1.EmptyTable;
  if (LaObject = nil) then Exit;

  FillLaObjectTreeViewForParent(-1, LaObject);
//  MemTableEh1.AppendRecord([Null, Null, 'LaHost', '', Null]);
//
//  FillLaObjectTreeViewForParent(MemTableEh1.Fields[0].AsLargeInt, LaHost.LaObject);
  finally
    MemTableEh1.First;
    MemTableEh1.EnableControls;
  end;
end;

procedure TLaObjectTreeViewForm.FillLaObjectTreeViewForParent(ParentId: Int64; ALaObject: TLaObjectEh);
var
  I: Integer;
  DisplayName: String;
  RefObjectItfs: IRefObjectInterface;
  LaChild: TLaObjectEh;
  RecId: Int64;
begin

  DisplayName := ALaObject.ClassName;
  RefObjectItfs := TInterfacedRefObject.Create(ALaObject, False);

  MemTableEh1.Append;
  //MemTableEh1.Fields[0].Value := Null;
  MemTableEh1.Fields[1].Value := ParentId;
  MemTableEh1.Fields[2].Value := DisplayName;
  MemTableEh1.Fields[3].Value := ''; //RecType
  MemTableEh1.Fields[4].Value := RefObjectItfs;
  //MemTableEh1.AppendRecord([Null, ParentId, DisplayName, '', RefObjectItfs]);
  MemTableEh1.Post;
{$IFDEF EH_LIB_13} //RAD Studio 2010
  RecId := MemTableEh1.Fields[0].AsLargeInt;
{$ELSE}
  RecId := MemTableEh1.Fields[0].AsInteger;
{$ENDIF}

  for I := 0 to ALaObject.ChildrenCount - 1 do
  begin
    LaChild := ALaObject.Children[I];
    FillLaObjectTreeViewForParent(RecId, LaChild);
  end;
end;

procedure TLaObjectTreeViewForm.FormCreate(Sender: TObject);
begin
  FObjIns := TObjectInspectorEh.Create(Self);
  FObjIns.Parent := ObjInsPanel;
  FObjIns.Align := TAlign.alClient;
  FObjIns.Flat := True;
  FObjIns.ParentFont := True;
  FObjIns.LabelColWidth := 100;
  FObjIns.Options := [goFixedVertLineEh, goVertLineEh, goEditingEh, goAlwaysShowEditorEh];
  FObjIns.Name := 'ObjectInspectorEh';
  FObjIns.PropDataAccessWay := TPropDataAccessWayEh.Rtti;
end;

procedure TLaObjectTreeViewForm.SetLaHost(const Value: TLaHost);
begin
  if (FLaHost <> Value) then
  begin
    FLaHost := Value;
    FillLaObjectTreeView;
  end;
end;

procedure TLaObjectTreeViewForm.bTestClick(Sender: TObject);
//var
//  FContext : TRttiContext;
//  FType    : TRttiType;
//  FProp    : TRttiProperty;
//  RttiValue: TValue;
//  ItemVal: TValue;
//  Val: TPoint;
//  ResultStr: String;
//  tp: TRttiProperty;
//  {$IFDEF FPC}
//  {$ELSE}
//  tf: TRttiField;
//  {$ENDIF}
begin
//  FContext := TRttiContext.Create;
//  FType := FContext.GetType(LaHost.LaObject.ClassType);
//  FProp := FType.GetProperty('Location');
//  //RecValPtr :=
//  RttiValue := FProp.GetValue(LaHost.LaObject);
//
//  ResultStr := '';
//  for tp in FProp.PropertyType.GetProperties do
//  begin
//    ItemVal := tp.GetValue(RttiValue.GetReferenceToRawData);
//    if ResultStr = ''
//      then ResultStr := ResultStr + ', ' + ItemVal.ToString
//      else ResultStr := ResultStr + ', ' + ItemVal.AsString;
//  end;
//
//  {$IFDEF FPC}
//  {$ELSE}
//  for tf in FProp.PropertyType.GetFields do
//  begin
//    ItemVal:= tf.GetValue(RttiValue.GetReferenceToRawData);
//    if ResultStr = ''
//      then ResultStr := ResultStr + ', ' + ItemVal.ToString
//      else ResultStr := ResultStr + ', ' + ItemVal.AsString;
//  end;
//  {$ENDIF}
//
//  {$IFDEF FPC}
//  {$ELSE}
//  RttiValue.TryAsType<TPoint>(Val);
//  {$ENDIF}
//
//  FContext.Free;
end;

procedure TLaObjectTreeViewForm.Button1Click(Sender: TObject);
var
  ALaHost: TLaHost;
begin
  ALaHost := LaHost;
  LaHost := nil;
  LaHost := ALaHost;
end;

procedure TLaObjectTreeViewForm.DataSource1DataChange(Sender: TObject;
  Field: TField);
var
  Val: Variant;
  RefObj: IRefObjectInterface;
begin
  Val := MemTableEh1.Fields[4].Value;
  if (not VarIsNull(Val)) then
  begin
    RefObj := IRefObjectInterface(IInterface(Val));
    FObjIns.Component := RefObj.GetObject;
    if (LaHost <> nil) then
      LaHost.DesignBacklightObject := TLaObjectEh(RefObj.GetObject);
  end;
end;

end.
