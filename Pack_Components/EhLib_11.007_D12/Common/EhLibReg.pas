{*******************************************************}
{                                                       }
{                       EhLib 10.2                      }
{                    Registration unit                  }
{                                                       }
{   Copyright (c) 1998-2022 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit EhLibReg;

interface

uses
{$IFDEF CIL} Borland.Vcl.Design.DesignIntf,
             Borland.Vcl.Design.DesignEditors,
             Borland.Vcl.Design.ColnEdit,
             Borland.Vcl.Design.VCLEditors, Variants,
             EhLibVCLNET,
{$ELSE}
  {$IFDEF FPC}
  DBGridsEh, DBVertGridsEh, PrnDbgEh,
  EhLibLCL, LCLType,
  PropEdits, ComponentEditors,
  {$ELSE}
  DBGridEh, DBVertGridsEh, PrnDbgEh, PrViewEh,
  EhLibVCL, ColnEdit,
  DesignIntf, DesignEditors, VCLEditors, Variants, ToolsAPI,
  StorablePropsDesignIntfEh,
  LookupLinkDesignEh,
  EhLibSelectFromListDesignEh, DBLookupUtilsEh,
  {$ENDIF}
{$ENDIF}
   PropStorageEditEh, Contnrs, DB, Classes;

{$IFDEF CIL}

{$R DBCtrlsEh.TDBCheckBoxEh.bmp}
{$R DBCtrlsEh.TDBComboBoxEh.bmp}
{$R DBCtrlsEh.TDBDateTimeEditEh.bmp}
{$R DBCtrlsEh.TDBEditEh.bmp}
{$R DBCtrlsEh.TDBNumberEditEh.bmp}
{$R DBGridEh.TDBGridEh.bmp}
{$R DBLookupEh.TDBLookupComboboxEh.bmp}
{$R DBSumLst.TDBSumList.bmp}
{$R PrnDbgEh.TPrintDBGridEh.bmp}
{$R PrViewEh.TPreviewBox.bmp}
{$R PropStorageEh.TIniPropStorageManEh.bmp}
{$R PropStorageEh.TPropStorageEh.bmp}
{$R PropStorageEh.TRegPropStorageManEh.bmp}

{$R DataDriverEh.TDataSetDriverEh.bmp}
{$R DataDriverEh.TSQLDataDriverEh.bmp}
{$R MemTableEh.TMemTableEh.bmp}

{$ENDIF}


type

{ TListFieldProperty }

  TListFieldProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValueList(List: TStrings); virtual;
    procedure GetValues(Proc: TGetStrProc); override;
    function GetDataSourcePropName: string; virtual;
    function GetDataSet: TDataSet; virtual;
  end;

{ TBasePrintControlComponentPropertyEh }

  TBasePrintControlComponentPropertyEh = class(TComponentProperty)
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;

var
  NiClasses: TClassList;

procedure Register;

{$IFDEF FPC}
{$ELSE}
procedure GetComponentNamesEh(lst: TStrings; TargetClass:
  TClass; DividePackages: Boolean; TargetComponet: TComponent = nil;
  TargetPropName: String = '');


{$ENDIF}

implementation

{$IFDEF FPC}
{$R EhLibReg.dcr}
{$ENDIF}

uses TypInfo, Dialogs,
{$IFDEF FPC}

{$ELSE}
  StrEdit, StringsEdit, RichEdEh, BasePrintGridPageSetupDialogEh,
  PrintUtilsEh, Windows,
{$ENDIF}
  Forms, SysUtils, ImgList, Graphics,
  EhLibDesignAbout, GridEhEd,
  DBAxisGridsEh, DBSumLst,
  PropStorageEh,
  DBCtrlsEh, DBLookupEh, ToolCtrlsEh, ButtonsEh, Controls,
  DBGridEhGrouping, DataSetImpExpEh;

{$IFDEF FPC}
{$ELSE}
type

{ TCustomImageIndexPropertyEditor }

  TCustomImageIndexPropertyEditor = class(TIntegerProperty, ICustomPropertyListDrawing)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetImageListAt(Index: Integer): TCustomImageList; virtual;

    procedure GetValues(Proc: TGetStrProc); override;

    procedure ListMeasureHeight(const Value: string; ACanvas: TCanvas; var AHeight: Integer);
    procedure ListMeasureWidth(const Value: string; ACanvas: TCanvas; var AWidth: Integer);
    procedure ListDrawValue(const Value: string; ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
  end;

function TCustomImageIndexPropertyEditor.GetImageListAt(Index: Integer): TCustomImageList;
begin
  Result := nil;
end;

function TCustomImageIndexPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect, paValueList, paRevertable];
end;

procedure TCustomImageIndexPropertyEditor.GetValues(Proc: TGetStrProc);
var
  ImgList: TCustomImageList;
  I: Integer;
begin
  ImgList := GetImageListAt(0);
  if Assigned(ImgList) then
    for I := 0 to ImgList.Count -1 do
      Proc(IntToStr(I));
end;

procedure TCustomImageIndexPropertyEditor.ListDrawValue(const Value: string;
  ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
var
  ImgList: TCustomImageList;
  X: Integer;
begin
  ImgList := GetImageListAt(0);
  ACanvas.FillRect(ARect);
  X := ARect.Left + 2;
  if Assigned(ImgList) then
  begin
    ImgList.Draw(ACanvas, X, ARect.Top + 2, StrToInt(Value));
    Inc(X, ImgList.Width);
  end;
  ACanvas.TextOut(X + 3, ARect.Top + 1, Value);
end;

procedure TCustomImageIndexPropertyEditor.ListMeasureHeight(const Value: string;
  ACanvas: TCanvas; var AHeight: Integer);
var
  ImgList: TCustomImageList;
begin
  ImgList := GetImageListAt(0);
  AHeight := ACanvas.TextHeight(Value) + 2;
  if Assigned(ImgList) and (ImgList.Height + 4 > AHeight) then
    AHeight := ImgList.Height + 4;
end;

procedure TCustomImageIndexPropertyEditor.ListMeasureWidth(const Value: string;
  ACanvas: TCanvas; var AWidth: Integer);
var
  ImgList: TCustomImageList;
begin
  ImgList := GetImageListAt(0);
  AWidth := ACanvas.TextWidth(Value) + 4;
  if Assigned(ImgList) then
    Inc(AWidth, ImgList.Width);
end;

{ TDBGridColumnTitleImageIndexEditorEh }

type

  TDBGridColumnTitleImageIndexEditorEh = class(TCustomImageIndexPropertyEditor)
  protected
    function GetImageListAt(AIndex: integer): TCustomImageList; override;
  end;

  TDBVertGridRowLabelImageIndexEditorEh = class(TCustomImageIndexPropertyEditor)
  protected
    function GetImageListAt(AIndex: integer): TCustomImageList; override;
  end;

  TEditControlImageIndexEditorEh = class(TCustomImageIndexPropertyEditor)
  protected
    function GetImageListAt(AIndex: integer): TCustomImageList; override;
  end;

  TEditButtonImageIndexEditorEh = class(TCustomImageIndexPropertyEditor)
  protected
    function GetImageListAt(AIndex: integer): TCustomImageList; override;
  end;

function TDBGridColumnTitleImageIndexEditorEh.GetImageListAt(AIndex: Integer): TCustomImageList;
var
  Item: TPersistent;
begin
  Result := nil;
  Item := GetComponent(AIndex);
  if Item is TColumnTitleEh then
    Result := TColumnTitleEh(Item).Column.Grid.TitleImages;
end;

{ TDBVerGridRowLabelImageIndexEditorEh }

function TDBVertGridRowLabelImageIndexEditorEh.GetImageListAt(AIndex: Integer): TCustomImageList;
var
  Item: TPersistent;
begin
  Result := nil;
  Item := GetComponent(AIndex);
  if Item is TRowLabelEh then
    Result := TRowLabelEh(Item).Row.Grid.LabelColParams.Images;
end;

{ TEditControlImageImageIndexEditorEh }

function TEditControlImageIndexEditorEh.GetImageListAt(AIndex: Integer): TCustomImageList;
var
  Item: TPersistent;
begin
  Result := nil;
  Item := GetComponent(AIndex);
  if Item is TEditImageEh then
    Result := TEditImageEh(Item).Images;
end;

{ TEditButtonImageIndexEditorEh }

function TEditButtonImageIndexEditorEh.GetImageListAt(AIndex: Integer): TCustomImageList;
var
  Item: TPersistent;
  PropName: String;
begin
  Result := nil;
  Item := GetComponent(AIndex);
  PropName := GetName();
  if Item is TEditButtonImagesEh then
  begin
    if PropName = 'HotIndex' then
      Result := TEditButtonImagesEh(Item).HotImages
    else if PropName = 'PressedIndex' then
      Result := TEditButtonImagesEh(Item).PressedImages
    else if PropName = 'DisabledIndex' then
      Result := TEditButtonImagesEh(Item).DisabledImages;
    if Result = nil then
      Result := TEditButtonImagesEh(Item).NormalImages;
  end;
end;

type

{ TDBRichEditEhEditor }

  TDBRichEditEhEditor = class(TComponentEditor)
    function  GetVerbCount: Integer;              override;
    function  GetVerb(Index: Integer): string;    override;
    procedure ExecuteVerb(Index: Integer);        override;

    procedure EditLines;
  end;

function TDBRichEditEhEditor.GetVerbCount: Integer;
begin
  Result := 3;
end;

function TDBRichEditEhEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'Edit lines';
    1: Result := '-';
    2: Result := EhLibVerInfo + ' ' + EhLibBuildInfo + ' ' + EhLibEditionInfo;
  end;
end;

procedure TDBRichEditEhEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0 :
    {$IFDEF FPC}
      ;
    {$ELSE}
      EditLines;
    {$ENDIF}
    2:
      ShowAboutForm;
  end;
end;

procedure TDBRichEditEhEditor.EditLines;
var
  Stream: TStringStream;
  re: TRichStrEditDlgEh;
begin
  re := TRichStrEditDlgEh.Create(Application);
  try
    Stream := TStringStream.Create('');
    TCustomDBRichEditEh(Component).Lines.SaveToStream(Stream);
    Stream.Position := 0;
    re.Editor.Lines.LoadFromStream(Stream);
    case re.ShowModal of
      mrOk:
        begin
          Stream.Position := 0;
          re.Editor.Lines.SaveToStream(Stream);
          Stream.Position := 0;
          TCustomDBRichEditEh(Component).Lines.LoadFromStream(Stream);
          Self.Designer.Modified;
        end;
    end;
    Stream.Free;
  finally
    re.Free;
  end;
end;

type

  TDBMemoEhEditor = class(TComponentEditor)
    function  GetVerbCount: Integer;              override;
    function  GetVerb(Index: Integer): string;    override;
    procedure ExecuteVerb(Index: Integer);        override;

    procedure EditLines;
  end;

function TDBMemoEhEditor.GetVerbCount: Integer;
begin
  Result := 3;
end;

function TDBMemoEhEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'Edit lines';
    1: Result := '-';
    2: Result := EhLibVerInfo + ' ' + EhLibBuildInfo + ' ' + EhLibEditionInfo;
  end;
end;

procedure TDBMemoEhEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0 :
    {$IFDEF FPC}
      ;
    {$ELSE}
      EditLines;
    {$ENDIF}
    2:
      ShowAboutForm;
  end;
end;

procedure TDBMemoEhEditor.EditLines;
var
  dlg: TStrEditDlg;
begin
  dlg := TStringsEditDlg.Create(Application);
  try
    dlg.Lines := TCustomDBMemoEh(Component).Lines;
    dlg.CodeEditorItem.Enabled := False;
    dlg.CodeWndBtn.Enabled := False;
    if dlg.ShowModal = mrOk then
    begin
      TCustomDBMemoEh(Component).Lines := dlg.Lines;
      Self.Designer.Modified;
    end;
  finally
    dlg.Free;
  end;
end;
{$ENDIF}

type

  TDBEditEhEditor = class(TComponentEditor)
    function  GetVerbCount: Integer;              override;
    function  GetVerb(Index: Integer): string;    override;
    procedure ExecuteVerb(Index: Integer);        override;
  end;

  TDBComboBoxEhEditor = class(TComponentEditor)
    function  GetVerbCount: Integer;              override;
    function  GetVerb(Index: Integer): string;    override;
    procedure ExecuteVerb(Index: Integer);        override;
  end;


function TDBEditEhEditor.GetVerbCount: Integer;
begin
  Result := 3;
end;

function TDBEditEhEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'Edit buttons';
    1: Result := '-';
    2: Result := EhLibVerInfo + ' ' + EhLibBuildInfo + ' ' + EhLibEditionInfo;
  end;
end;

procedure TDBEditEhEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0 :
    {$IFDEF FPC}
      ;
    {$ELSE}
      ShowCollectionEditorClass(Designer, TCollectionEditor, Component,
        TDBEditEh(Component).EditButtons, 'EditButtons', [coAdd, coDelete, coMove]);
    {$ENDIF}
    2:
      ShowAboutForm;
  end;
end;


function TDBComboBoxEhEditor.GetVerbCount: Integer;
begin
  Result := 2;
end;

function TDBComboBoxEhEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0 : Result := 'Edit buttons';
    1: Result := '-';
    2: Result := EhLibVerInfo + ' ' + EhLibBuildInfo + ' ' + EhLibEditionInfo;
  end;
end;

procedure TDBComboBoxEhEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0 :
    {$IFDEF FPC}
      ;
    {$ELSE}
      ShowCollectionEditorClass(Designer, TCollectionEditor, Component,
        TDBComboBoxEh(Component).EditButtons, 'EditButtons', [coAdd, coDelete, coMove]);
    {$ENDIF}
    2:
      ShowAboutForm;
  end;
end;

{ TListFieldProperty }

function TListFieldProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paMultiSelect];
end;

function GetPropertyValue(Instance: TPersistent; const PropName: string): TPersistent;
var
  PropInfo: PPropInfo;
begin
  Result := nil;
  PropInfo := TypInfo.GetPropInfo(Instance.ClassInfo, PropName);
  if (PropInfo <> nil) and (PropType_GetKind(PropInfo_getPropType(PropInfo)) = tkClass) then
    Result := TObject(GetObjectProp(Instance, PropInfo)) as TPersistent;
end;

procedure TListFieldProperty.GetValueList(List: TStrings);
var
  DataSource: TDataSource;
  ADataSet: TDataSet;
begin
  ADataSet := GetDataSet;
  if ADataSet = nil then
  begin
    DataSource := GetPropertyValue(GetComponent(0), GetDataSourcePropName) as TDataSource;
    if DataSource <> nil then
      ADataSet := DataSource.DataSet;
  end;
  if ADataSet <> nil then
    ADataSet.GetFieldNames(List);
end;

procedure TListFieldProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
  Values: TStringList;
begin
  Values := TStringList.Create;
  try
    GetValueList(Values);
    for I := 0 to Values.Count - 1 do Proc(Values[I]);
  finally
    Values.Free;
  end;
end;

function TListFieldProperty.GetDataSourcePropName: string;
begin
  Result := 'ListSource';
end;

function TListFieldProperty.GetDataSet: TDataSet;
begin
  Result := nil;
end;


{ TLookupParamsKeyListFieldProperty }
{$IFDEF FPC}
{$ELSE}
type
  TLookupParamsKeyListFieldProperty = class(TListFieldProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValueList(List: TStrings); override;
    procedure Edit; override;
    function GetDataSource: TDataSource;
  end;

function TLookupParamsKeyListFieldProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paMultiSelect, paDialog];
end;

procedure TLookupParamsKeyListFieldProperty.GetValueList(List: TStrings);
var
  DataSource: TDataSource;
begin
  DataSource := GetDataSource;
  if (DataSource <> nil) and (DataSource.DataSet <> nil) then
    DataSource.DataSet.GetFieldNames(List);
end;

procedure TLookupParamsKeyListFieldProperty.Edit;
var
  AChanged: Boolean;
  ADataSet: TDataSet;
  AKeyFieldNames: String;
  ALookupKeyFieldNames: String;
  ALookupResultField: String;
  ALookupDataSet: TDataSet;
  DataSource: TDataSource;
  LookupData: TDBLookupDataEh;
begin
  DataSource := GetDataSource;
  if (DataSource <> nil) and (DataSource.DataSet <> nil)
    then ADataSet := DataSource.DataSet
    else Exit;
  LookupData := TDBLookupDataEh(GetComponent(0));
  AKeyFieldNames := LookupData.KeyFieldNames;
  ALookupKeyFieldNames := LookupData.LookupKeyFieldNames;
  ALookupResultField := LookupData.LookupDisplayFieldName;
  ALookupDataSet := LookupData.LookupDataSet;
  AChanged := EditLookupLink(
    TAxisBarEh(TDBLookupDataEh(GetComponent(0)).AxisBar).Grid,
    Designer, ADataSet,
    AKeyFieldNames, ALookupKeyFieldNames, ALookupResultField, ALookupDataSet);
  if AChanged then
  begin
    LookupData.KeyFieldNames := AKeyFieldNames;
    LookupData.LookupKeyFieldNames := ALookupKeyFieldNames;
    LookupData.LookupDisplayFieldName := ALookupResultField;
    LookupData.LookupDataSet := ALookupDataSet;
    Modified;
  end;
end;

function TLookupParamsKeyListFieldProperty.GetDataSource: TDataSource;
begin
  if GetComponent(0) is TDBLookupDataEh
    then Result := TAxisBarEh(TDBLookupDataEh(GetComponent(0)).AxisBar).Grid.DataSource
    else Result := nil;
end;

{ TLookupParamsLookupFieldProperty }

type
  TLookupParamsLookupFieldProperty = class(TLookupParamsKeyListFieldProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;

procedure TLookupParamsLookupFieldProperty.GetValueList(List: TStrings);
var
  LookupData: TDBLookupDataEh;
begin
  LookupData := TDBLookupDataEh(GetComponent(0));
  if (LookupData.LookupListSource.DataSet <> nil) then
    LookupData.LookupListSource.DataSet.GetFieldNames(List);
end;
{$ENDIF}

{ TDBGridEhFieldProperty }

type

  TFilterDataFieldProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValueList(List: TStrings); virtual;
    procedure GetValues(Proc: TGetStrProc); override;
  end;


function TFilterDataFieldProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paMultiSelect];
end;

procedure TFilterDataFieldProperty.GetValueList(List: TStrings);
var
  Ehg : TCustomDBGridEh;
begin
  if (GetComponent(0) = nil) then Exit;

  if (GetComponent(0) is TSTColumnFilterEh)
    then  Ehg := (GetComponent(0) as TSTColumnFilterEh).Grid
    else Exit;

  if (Ehg <> nil) and (Ehg.DataSource <> nil) and (Ehg.DataSource.DataSet <> nil) then
       Ehg.DataSource.DataSet.GetFieldNames(List);
end;

procedure TFilterDataFieldProperty.GetValues(Proc: TGetStrProc);
var
  i: Integer;
  Values: TStringList;
begin
  Values := TStringList.Create;
  try
    GetValueList(Values);
    for i := 0 to Values.Count - 1 do Proc(Values[i]);
  finally
    Values.Free;
  end;
end;

{ TDateProperty
  Date property editor for Value property of TDBDateTimeEditEh components. }

type
  TVarDateProperty = class(TPropertyEditor)
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

function TVarDateProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect, paRevertable];
end;

function TVarDateProperty.GetValue: string;
var
  v: Variant;
begin
  v := GetVarValue;
  if v = Null then
    Result := ''
  else if TCustomDBDateTimeEditEh(GetComponent(0)).Kind = dtkDateEh then
    Result := DateToStr(v)
  else if TCustomDBDateTimeEditEh(GetComponent(0)).Kind = dtkTimeEh then
    Result := TimeToStr(v)
  else
    Result := DateTimeToStr(v);
end;

procedure TVarDateProperty.SetValue(const Value: string);
var
  v: Variant;
begin
  if Value = '' then
    v := Null
  else if TCustomDBDateTimeEditEh(GetComponent(0)).Kind = dtkDateEh then
    v := StrToDate(Value)
  else if TCustomDBDateTimeEditEh(GetComponent(0)).Kind = dtkTimeEh then
    v := StrToTime(Value)
  else
    v := StrToDateTime(Value);
  SetVarValue(v);
end;

{ TNumberProperty
  Date property editor for Value property of TCustomDBNumberEditEh components. }

type
  TVarNumberProperty = class(TPropertyEditor)
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

function TVarNumberProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect, paRevertable];
end;

function TVarNumberProperty.GetValue: string;
var
  v: Variant;
begin
  v := GetVarValue;
  if v = Null then Result := ''
  else Result := FloatToStr(v);
end;

procedure TVarNumberProperty.SetValue(const Value: string);
var
  v: Variant;
begin
  if Value = '' then v := Null
  else v := StrToFloat(Value);
  SetVarValue(v);
end;


{ TPropertyNamesEhProperty }

type
  TPropertyNamesEhProperty = class(TPropertyEditor {TClassProperty})
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure Edit; override;
  end;

{ TPropertyNamesEhProperty }

procedure TPropertyNamesEhProperty.Edit;
var
  Obj: TPersistent;
begin
  Obj := GetComponent(0);
  while (Obj <> nil) and not (Obj is TComponent) do
    Obj := GetUltimateOwner(Obj);
  {$IFDEF FPC}
  if EditPropStorage(TPropStorageEh(Obj)) then
    Modified('StoredProps');
  {$ELSE}
  if EditPropStorage(TPropStorageEh(Obj)) then
    Designer.Modified;
  {$ENDIF}
end;

function TPropertyNamesEhProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly {, paSubProperties}];
end;

function TPropertyNamesEhProperty.GetValue: string;
begin
  Result := '';
{$IFDEF CIL}
  FmtStr(Result, '(%s)', [GetPropType.Name]);
{$ELSE}
  FmtStr(Result, '(%s)', [GetPropType^.Name]);
{$ENDIF}
end;

{ TPropStorageEhEditor }

type
  TPropStorageEhEditor = class(TComponentEditor)
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

{ TPropStorageEhEditor }

procedure TPropStorageEhEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0: if EditPropStorage(TPropStorageEh(Component))  then
         Designer.Modified;
  end;
end;

function TPropStorageEhEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'Stored properties ...';
  end;
end;

function TPropStorageEhEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{$IFDEF FPC}
{$ELSE}
type
  TPropStorageEhSelectionEditor = class(TSelectionEditor)
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;

{ TPropStorageEhSelectionEditor }

procedure TPropStorageEhSelectionEditor.RequiresUnits(Proc: TGetStrProc);
begin
   inherited RequiresUnits(Proc);
   Proc('PropFilerEh');
end;

type
 TTDBLookupComboboxEhSelectionEditor = class(TSelectionEditor)
 public
   procedure RequiresUnits(Proc: TGetStrProc); override;
 end;

{ TPropStorageEhSelectionEditor }

procedure TTDBLookupComboboxEhSelectionEditor.RequiresUnits(Proc: TGetStrProc);
begin
   inherited RequiresUnits(Proc);
   Proc('DBGridEh');
end;

type
 TDBGridEhSelectionEditor = class(TSelectionEditor)
 public
   procedure RequiresUnits(Proc: TGetStrProc); override;
 end;

{ TDBGridEhSelectionEditor }

procedure TDBGridEhSelectionEditor.RequiresUnits(Proc: TGetStrProc);
var
  I: Integer;
  Grid: TCustomDBGridEh;
  ClassImageName: String;
begin
  inherited RequiresUnits(Proc);
  Proc('DBGridEhGrouping');
  Proc('ToolCtrlsEh');
  Proc('DBGridEhToolCtrls');
  Proc('DynVarsEh');

  for I := 0 to Designer.Root.ComponentCount - 1 do
  begin
    if Designer.Root.Components[i] is TCustomDBGridEh then
    begin
      Grid := TCustomDBGridEh(Designer.Root.Components[i]);
      if (Grid.BackgroundData.Picture.Graphic <> nil) then
      begin
        ClassImageName := Grid.BackgroundData.Picture.Graphic.ClassName;
        if ClassImageName = 'TPngImage' then
          Proc('EhLibPNGImage')
        else if ClassImageName = 'TGIFImage' then
          Proc('EhLibGIFImage')
        else if ClassImageName = 'TJPEGImage' then
          Proc('EhLibJPegImage');
      end;
      if iimJpegImageModuleEh in Grid.IncludeImageModules then
        Proc('EhLibJPegImage');
  {$IFDEF EH_LIB_11}
      if iimGIFImageModuleEh in Grid.IncludeImageModules then
        Proc('EhLibGIFImage');
  {$ENDIF}
  {$IFDEF EH_LIB_12}
      if iimPNGImageModuleEh in Grid.IncludeImageModules then
        Proc('EhLibPNGImage');
  {$ENDIF}
    end;
  end;

end;

{$ENDIF} 

{ TRegistryKeyProperty }
type

  TRegistryKeyProperty = class(TIntegerProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

{ TRegistryKeyProperty }

function TRegistryKeyProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect, paSortList, paValueList];
end;

function TRegistryKeyProperty.GetValue: string;
begin
  Result := '';
  if not RegistryKeyToIdent(HKEY(GetOrdValue), Result) then
    FmtStr(Result, '%d', [GetOrdValue]);
end;

procedure TRegistryKeyProperty.GetValues(Proc: TGetStrProc);
begin
  GetRegistryKeyValues(Proc);
end;

procedure TRegistryKeyProperty.SetValue(const Value: string);
var
  NewValue: Longint;
begin
  if IdentToRegistryKey(Value, NewValue)
    then SetOrdValue(NewValue)
    else inherited SetValue(Value);
end;

procedure InitUnit;
begin
  NiClasses := TClassList.Create;
  {$IFDEF FPC}
  {$ELSE}
  {$ENDIF}
end;

procedure FinalizeUnit;
begin
  FreeAndNil(NiClasses);
end;


{$IFDEF FPC}
{$ELSE}

procedure GetNvfComponentNamesEh(lst: TStrings;
  TargetClass: TClass; AddSeparator: Boolean;
  TargetComponet: TComponent = nil; TargetPropName: String = '');
var
  i: Integer;
  CRef: TClass;
  TheNewOne: Boolean;
  INiComponentSideParentItfs: ISideOwnerEh;
  Approved: Boolean;
begin
  TheNewOne := False;
  Approved := False;
  if TargetComponet = nil then
    Approved := True
  else if Supports(TargetComponet, ISideOwnerEh, INiComponentSideParentItfs) and
          INiComponentSideParentItfs.IsSideParentableForProperty(TargetPropName)
  then
    Approved := True;

  if not Approved then Exit;

  for I := 0 to NiClasses.Count-1 do
  begin
    if AddSeparator and TheNewOne and (lst.Count > 0) then
      lst.AddObject('-', nil);
    CRef := TClass(NiClasses[i]);
    if (CRef <> nil) and CRef.InheritsFrom(TargetClass) then
    begin
      lst.AddObject(CRef.ClassName, TObject(CRef));
      TheNewOne := False;
    end;
 end;
end;

procedure GetComponentNamesEh(lst: TStrings;
  TargetClass: TClass; DividePackages: Boolean; TargetComponet: TComponent = nil;
  TargetPropName: String = '');
var
  i, k: Integer;
  CRef: TClass;
  LServices: IOTAPackageServices;
  TheNewOne: Boolean;
begin
  lst.Clear;
  LServices := BorlandIDEServices as IOTAPackageServices;
  TheNewOne := False;
  for i := 0 to LServices.PackageCount-1 do
  begin
    for k := 0 to LServices.ComponentCount[i]-1 do
    begin
      CRef := TClass(GetClass(LServices.GetComponentName(i, k)));
      if (CRef <> nil) and CRef.InheritsFrom(TargetClass) then
      begin
        if DividePackages and TheNewOne then
          lst.AddObject('-', nil);
        lst.AddObject(CRef.ClassName, TObject(CRef));
        TheNewOne := False;
      end;
    end;
    TheNewOne := True;
  end;

  GetNvfComponentNamesEh(lst, TargetClass, DividePackages, TargetComponet, TargetPropName);
end;
{$ENDIF}

procedure Register;
begin
{$IFDEF EH_LIB_9}
{$ENDIF}


  Classes.RegisterClass(TSpeedButtonEh);

  RegisterComponents('EhLib Controls', [TDBGridEh]);
  RegisterComponents('EhLib Controls', [TDBEditEh, TDBDateTimeEditEh, TDBNumberEditEh,
    TDBComboBoxEh, TDBLookupComboboxEh, TDBCheckBoxEh]);
  RegisterComponents('EhLib Controls', [TDBMemoEh, TDBImageEh, TDBRadioGroupEh]);
  RegisterComponents('EhLib Components', [TDBSumList]);
  RegisterComponents('EhLib Components', [TPropStorageEh, TIniPropStorageManEh, TRegPropStorageManEh]);

  RegisterComponents('EhLib Components', [TPrintDBGridEh]);

{$IFDEF FPC}
{$ELSE}
  RegisterComponents('EhLib Controls', [TDBRichEditEh]);
  RegisterComponents('EhLib Components', [TPreviewBox]);

{$ENDIF}


  RegisterComponentEditor(TDBEditEh, TDBEditEhEditor);
  RegisterComponentEditor(TDBComboBoxEh, TDBEditEhEditor);
  RegisterComponentEditor(TDBNumberEditEh, TDBEditEhEditor);
  RegisterComponentEditor(TDBDateTimeEditEh, TDBEditEhEditor);
  RegisterComponentEditor(TPropStorageEh, TPropStorageEhEditor);

  RegisterComponentEditor(TDBGridEh, TDBGridEhEditor);
{$IFDEF FPC}
{$ELSE}
  RegisterComponentEditor(TDBLookupComboboxEh, TDBLookupComboboxEhEditor);
  RegisterComponentEditor(TCustomDBRichEditEh, TDBRichEditEhEditor);
  RegisterComponentEditor(TCustomDBMemoEh, TDBMemoEhEditor);
{$ENDIF}


  RegisterPropertyEditor(TypeInfo(string), TSTColumnFilterEh, 'KeyField', TListFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TSTColumnFilterEh, 'ListField', TListFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TSTColumnFilterEh, 'DataField', TFilterDataFieldProperty);
  RegisterPropertyEditor(TypeInfo(TShortCut), TDBGridSearchPanelEh, 'ShortCut', TShortCutProperty);


  RegisterPropertyEditor(TypeInfo(string), TDBLookupComboboxEh, 'KeyField', TListFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TDBLookupComboboxEh, 'ListField', TListFieldProperty);

  RegisterPropertyEditor(TypeInfo(Variant), TCustomDBDateTimeEditEh, 'Value', TVarDateProperty);
  RegisterPropertyEditor(TypeInfo(Variant), TCustomDBNumberEditEh, 'Value', TVarNumberProperty);

  RegisterPropertyEditor(TypeInfo(TStrings), TPropStorageEh, 'StoredProps', TPropertyNamesEhProperty);

  RegisterPropertyEditor(TypeInfo(HKEY), TRegPropStorageManEh, 'Key', TRegistryKeyProperty);

  RegisterPropertyEditor(TypeInfo(TShortCut), TEditButtonEh, 'ShortCut', TShortCutProperty);
  RegisterPropertyEditor(TypeInfo(TShortCut), TSpecRowEh, 'ShortCut', TShortCutProperty);

  RegisterPropertyEditor(TypeInfo(string), TColumnEh, 'FieldName', TDBGridEhFieldProperty);

{$IFDEF FPC}
{$ELSE}
  RegisterPropertyEditor(TypeInfo(TImageIndex), TColumnTitleEh, 'ImageIndex', TDBGridColumnTitleImageIndexEditorEh);
  RegisterPropertyEditor(TypeInfo(TImageIndex), TRowLabelEh, 'ImageIndex', TDBVertGridRowLabelImageIndexEditorEh);
  RegisterPropertyEditor(TypeInfo(TImageIndex), TEditImageEh, 'ImageIndex', TEditControlImageIndexEditorEh);
  RegisterPropertyEditor(TypeInfo(TImageIndex), TEditButtonImagesEh, 'NormalIndex', TEditButtonImageIndexEditorEh);
  RegisterPropertyEditor(TypeInfo(TImageIndex), TEditButtonImagesEh, 'HotIndex', TEditButtonImageIndexEditorEh);
  RegisterPropertyEditor(TypeInfo(TImageIndex), TEditButtonImagesEh, 'PressedIndex', TEditButtonImageIndexEditorEh);
  RegisterPropertyEditor(TypeInfo(TImageIndex), TEditButtonImagesEh, 'DisabledIndex', TEditButtonImageIndexEditorEh);

  RegisterPropertyEditor(TypeInfo(TCollection), TCustomDBGridEh, 'Columns', TDBGridEhColumnsProperty);
  RegisterPropertyEditor(TypeInfo(TCollection), TGridDataGroupFooterEh, 'ColumnItems', TDBGridEhGroupFooterItemsProperty);
  RegisterPropertyEditor(TypeInfo(string), TDBLookupDataEh, 'KeyFieldNames', TLookupParamsKeyListFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TDBLookupDataEh, 'LookupKeyFieldNames', TLookupParamsLookupFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TDBLookupDataEh, 'LookupDisplayFieldName', TLookupParamsLookupFieldProperty);
  RegisterPropertyEditor(TypeInfo(TCollection), TColumnDropDownBoxEh, 'Columns', TDBGridEhColumnsProperty);

  RegisterPropertyEditor(TypeInfo(string), TColumnFooterEh, 'FieldName', TDBGridEhFieldAggProperty);
  RegisterPropertyEditor(TypeInfo(string), TDBGridEhDataGroupLevelEh, 'ColumnName', TDBGridEhGroupLelelColumnProperty);

  RegisterPropertyEditor(TypeInfo(string), TPrintDBGridEh, 'PrintFontName', TFontNameProperty);
  RegisterPropertyEditor(TypeInfo(TBasePrintServiceComponentEh), nil, '', TBasePrintControlComponentPropertyEh);
{$ENDIF}


{$IFDEF FPC}
{$ELSE}
  RegisterSelectionEditor(TPropStorageEh, TPropStorageEhSelectionEditor);
  RegisterSelectionEditor(TCustomDBLookupComboboxEh, TTDBLookupComboboxEhSelectionEditor);
  RegisterSelectionEditor(TDBGridEh, TDBGridEhSelectionEditor);
{$ENDIF}


  GroupDescendentsWith(TDBSumList, Controls.TControl);
  GroupDescendentsWith(TPropStorageEh, Controls.TControl);
  GroupDescendentsWith(TPropStorageManagerEh, Controls.TControl);

{$IFDEF FPC}
{$ELSE}
  GroupDescendentsWith(TPrintDBGridEh, Controls.TControl);

{$ENDIF}

{ Property Category registration }
{$IFDEF FPC}
{$ELSE}
  RegisterPropertiesInCategory(sDatabaseCategoryName, [TypeInfo(TDBGridColumnsEh)]);
  RegisterPropertyInCategory(sDatabaseCategoryName, TColumnEh, 'FieldName');
  RegisterPropertiesInCategory(sLocalizableCategoryName, TColumnEh, ['Picklist', 'KeyList']); { Do not localize }
  RegisterPropertiesInCategory(sLocalizableCategoryName, [TypeInfo(TColumnTitleEh)]);
  RegisterPropertiesInCategory(sVisualCategoryName, TColumnEh, ['AlwaysShowEditButton',
    'AutoFitColWidth', 'WordWrap', 'EndEllipsis', 'Checkboxes']);
{$ENDIF}

end;

{ TBasePrintControlComponentPropertyEh }

procedure TBasePrintControlComponentPropertyEh.Edit;
begin
  {$IFDEF FPC}
  {$ELSE}
  ShowSpreadGridPageSetupDialog(TBasePrintServiceComponentEh(GetOrdValue));
  {$ENDIF}
end;

function TBasePrintControlComponentPropertyEh.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog];
end;

initialization
  InitUnit;
finalization
  FinalizeUnit;
end.
