{*******************************************************}
{                                                       }
{                        EhLib 10.2                     }
{                                                       }
{                Planner Source Component               }
{                                                       }
{   Copyright (c) 2014-2022 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit PlannerDataEh;

interface

uses
  Classes, Graphics, Dialogs, Contnrs,
{$IFDEF EH_LIB_17} System.Generics.Collections, System.UITypes, {$ENDIF}
{$IFDEF CIL}
  EhLibVCLNET,
  WinUtils,
{$ELSE}
  {$IFDEF FPC}
  EhLibLCL,
  {$ELSE}
  EhLibVCL, Windows,
  {$ENDIF}
{$ENDIF}
  Messages, Types, ToolCtrlsEh, DateUtils, DB, ImgList, TypInfo,
  SysUtils, Variants, GraphUtil;

type
  TPlannerDataSourceEh = class;
  TPlannerDataItemEh = class;
  TPlannerResourcesEh = class;
  TPlannerItemSourceParamsEh = class;
  TItemSourceFieldsMapEh = class;
  TItemSourceFieldsMapItemEh = class;

  TPlannerDataItemEhClass = class of TPlannerDataItemEh;

  TApplyUpdateToDataStorageEhEvent = procedure (PlannerDataSource: TPlannerDataSourceEh; PlanItem: TPlannerDataItemEh; UpdateStatus: TUpdateStatus) of object;
  TCheckLoadTimePlanRecordEhEvent = procedure (PlannerDataSource: TPlannerDataSourceEh; DataSet: TDataSet; var IsLoadRecord: Boolean) of object;

  TPrepareItemsReaderEhEvent = procedure (PlannerDataSource: TPlannerDataSourceEh;
    RequriedStartDate, RequriedFinishDate, LoadedBorderDate: TDateTime;
    var PreparedReadyStartDate, PreparedFinishDate: TDateTime) of object;
  TReadItemEhEvent = procedure (PlannerDataSource: TPlannerDataSourceEh; PlanItem: TPlannerDataItemEh; var Eof: Boolean) of object;

  TPlannerLoadDataForPeriodEhEvent =  procedure (PlannerDataSource: TPlannerDataSourceEh;
  StartDate, FinishDate, LoadedBorderDate: TDateTime; var LoadedStartDate, LoadedFinishDate: TDateTime) of object;

  TEditingStatusEh = (esBrowseEh, esEditEh, esInsertEh);

{ TPlannerResourceEh }

  TPlannerResourceEh = class(TCollectionItem)
  private
    FName: string;
    FImageIndex: TImageIndex;
    FColor: TColor;
    FResourceID: Variant;
    FFaceColor: TColor;
    FDarkLineColor: TColor;
    FBrightLineColor: TColor;

    procedure SetImageIndex(const Value: TImageIndex);
    procedure SetName(const Value: string);
    procedure SetColor(const Value: TColor);
    function GetCollection: TPlannerResourcesEh;
    procedure SetResourceID(const Value: Variant);
    function GetFaceColor: TColor;
    function GetDarkLineColor: TColor;
    function GetBrightLineColor: TColor;

  protected
    function GetDisplayName: string; override;
    procedure AssignTo(Dest: TPersistent); override;
    procedure SetDisplayName(const Value: string); override;

  public
    constructor Create(ACollection: TCollection); override;

    property FaceColor: TColor read GetFaceColor;
    property DarkLineColor: TColor read GetDarkLineColor;
    property BrightLineColor: TColor read GetBrightLineColor;

    property Collection: TPlannerResourcesEh read GetCollection;
  published
    property Color: TColor read FColor write SetColor default clDefault;
    property Name: string read FName write SetName;
    property ImageIndex: TImageIndex read FImageIndex write SetImageIndex default -1;
    property ResourceID: Variant read FResourceID write SetResourceID;

  end;

{ TPlannerResourcesEh }

  TPlannerResourcesEh = class(TCollection)
  private
    FPlannerSource: TPlannerDataSourceEh;
    procedure SetItem(Index: Integer; Value: TPlannerResourceEh);
    function GetItem(Index: Integer): TPlannerResourceEh;

  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;

  public
    constructor Create(APlannerSource: TPlannerDataSourceEh);

    function Add: TPlannerResourceEh;
    function ResourceByResourceID(ResourceID: Variant): TPlannerResourceEh;

    property Items[Index: Integer]: TPlannerResourceEh read GetItem write SetItem; default;
  end;

{ TPlannerDataItemEh }

  TPlannerDataItemEh = class(TPersistent)
  private
    FTitle: string;
    FEndTime: TDateTime;
    FStartTime: TDateTime;
    FSource: TPlannerDataSourceEh;
    FAllDay: Boolean;
    FResourceID: Variant;
    FUpdateStatus: TUpdateStatus;
    FItemID: Variant;
    FResource: TPlannerResourceEh;
    FFillColor: TColor;
    FBody: String;
    FFrameColor: TColor;
    FChangesApplying: Boolean;
    FEditingStatus: TEditingStatusEh;
    FReadOnly: Boolean;

    function GetDuration: TDateTime;
    procedure SetEndTime(const Value: TDateTime);
    procedure SetStartTime(const Value: TDateTime);
    procedure SetTitle(const Value: string);
    procedure SetAllDay(const Value: Boolean);
    procedure SetResourceID(const Value: Variant);
    procedure SetItemID(const Value: Variant);
    procedure SetResource(const Value: TPlannerResourceEh);
    procedure SetFillColor(const Value: TColor);
    procedure SetBody(const Value: String);
    procedure SetReadOnly(const Value: Boolean);

  protected
    FUpdateCount: Integer;
    FDummy: Boolean;

    procedure BeginInsert; virtual;
    procedure Change; virtual;
    procedure Delete;
    procedure FinishApplyChanges; virtual;
    procedure ResolvePlanItemUpdate; virtual;
    procedure StartApplyChanges; virtual;
    procedure UpdateRefResource; virtual;

  public
    constructor Create(ASource: TPlannerDataSourceEh); virtual;
    destructor Destroy; override;

    procedure BeginEdit; virtual;
    procedure EndEdit(PostChanges: Boolean); virtual;

    function GetFrameColor: TColor; virtual;

    function InsideDay: Boolean; virtual;
    function InsideDayRange: Boolean; virtual;
    procedure Assign(Source: TPersistent); override;
    procedure AssignProperties(Source: TPlannerDataItemEh); virtual;
    procedure MergeUpdates;
    procedure ApplyUpdates;

    property IsDummy: Boolean read FDummy;
    property Duration: TDateTime read GetDuration;
    property Source: TPlannerDataSourceEh read FSource;
    property Resource: TPlannerResourceEh read FResource write SetResource;

    property UpdateCount: Integer read FUpdateCount;
    property UpdateStatus: TUpdateStatus read FUpdateStatus;
    property EditingStatus: TEditingStatusEh read FEditingStatus;

  published
    property Title: String read FTitle write SetTitle;
    property Body: String read FBody write SetBody;
    property StartTime: TDateTime read FStartTime write SetStartTime;
    property EndTime: TDateTime read FEndTime write SetEndTime;
    property AllDay: Boolean read FAllDay write SetAllDay;
    property ResourceID: Variant read FResourceID write SetResourceID;
    property ItemID: Variant read FItemID write SetItemID;
    property FillColor: TColor read FFillColor write SetFillColor;
    property ReadOnly: Boolean read FReadOnly write SetReadOnly;
  end;

  TItemSourceReadValueEventEh = procedure(DataSource: TPlannerDataSourceEh;
    MapItem: TItemSourceFieldsMapItemEh; const DataItem: TPlannerDataItemEh;
    var Processed: Boolean) of object;

{ TItemSourceFieldsMapItemEh }

  TItemSourceFieldsMapItemEh = class(TCollectionItem)
  private
    FPropertyName: String;
    FField: TField;
    FDataSetFieldName: String;
    FPropInfo: PPropInfo;
    FOnReadValue: TItemSourceReadValueEventEh;
    function GetCollection: TItemSourceFieldsMapEh;

  public
    constructor Create(Collection: TCollection); override;

    procedure Assign(Source: TPersistent); override;
    procedure DefaulReadValue(const DataItem: TPlannerDataItemEh); virtual;
    procedure ReadValue(const DataItem: TPlannerDataItemEh); virtual;

    property Field: TField read FField write FField;
    property PropInfo: PPropInfo read FPropInfo write FPropInfo;
    property Collection: TItemSourceFieldsMapEh read GetCollection;

  published
    property DataSetFieldName: String read FDataSetFieldName write FDataSetFieldName;
    property PropertyName: String read FPropertyName write FPropertyName;

    property OnReadValue: TItemSourceReadValueEventEh read FOnReadValue write FOnReadValue;
  end;

{ TItemSourceFieldsMapEh }

  TItemSourceFieldsMapEh = class(TCollection, IDefaultItemsCollectionEh)
  private
    FItemSourceParamsEh: TPlannerItemSourceParamsEh;
    function GetItem(Index: Integer): TItemSourceFieldsMapItemEh;
    procedure SetItem(Index: Integer; const Value: TItemSourceFieldsMapItemEh);
    function GetSourceParams: TPlannerItemSourceParamsEh;

  protected
    {IInterface}
  {$IFDEF FPC}
    function QueryInterface(constref IID: TGUID; out Obj): HResult; virtual; {$IFDEF MSWINDOWS}stdcall {$ELSE}CDECL{$ENDIF};
    function _AddRef: Integer; {$IFDEF MSWINDOWS}stdcall {$ELSE}CDECL{$ENDIF};
    function _Release: Integer; {$IFDEF MSWINDOWS}stdcall {$ELSE}CDECL{$ENDIF};
  {$ELSE}
    function QueryInterface(const IID: TGUID; out Obj): HResult; virtual; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
  {$ENDIF}

    {IDefaultItemsCollectionEh}
    function CanAddDefaultItems: Boolean;
    procedure AddAllItems(DeleteExisting: Boolean);

  protected
    function GetOwner: TPersistent; override;

  public
    constructor Create(AItemSourceParamsEh: TPlannerItemSourceParamsEh; ItemClass: TCollectionItemClass);
    destructor Destroy; override;

    function Add: TItemSourceFieldsMapItemEh;

    procedure ReadDataRecordValues(DataItem: TPlannerDataItemEh);
    procedure InitItems;

    procedure BuildItems(const DataItemClass: TPlannerDataItemEhClass); virtual;
    property Item[Index: Integer]: TItemSourceFieldsMapItemEh read GetItem write SetItem; default;
    property SourceParams: TPlannerItemSourceParamsEh read GetSourceParams;
  end;

{ TPlannerItemSourceParamsEh }

  TPlannerItemSourceParamsEh = class(TPersistent)
  private
    FDataSet: TDataSet;
    FPlannerDataSource: TPlannerDataSourceEh;
    FFieldsMap: TItemSourceFieldsMapEh;
    procedure SetDataSet(const Value: TDataSet);
    procedure SetFieldMap(const Value: TItemSourceFieldsMapEh);

  protected
    function GetOwner: TPersistent; override;

  public
    constructor Create(APlannerDataSource: TPlannerDataSourceEh);
    destructor Destroy; override;

    property PlannerDataSource: TPlannerDataSourceEh read FPlannerDataSource;
  published
    property DataSet: TDataSet read FDataSet write SetDataSet;
    property FieldsMap: TItemSourceFieldsMapEh read FFieldsMap write SetFieldMap;
  end;

{ TPlannerDataSourceEh }

  TPlannerDataSourceEh = class(TComponent)
  private
    FAllItemsLoaded: Boolean;
    FChanged: Boolean;
    FItems: TObjectListEh;
    FItemSourceParams: TPlannerItemSourceParamsEh;
    FLoadedFinishDate: TDateTime;
    FLoadedStartDate: TDateTime;
    FNotificationConsumers: TInterfaceList;
    FResources: TPlannerResourcesEh;
    FTimePlanItemClass: TPlannerDataItemEhClass;
    FUpdateCount: Integer;

    FOnApplyUpdateToDataStorage: TApplyUpdateToDataStorageEhEvent;
    FOnCheckLoadTimePlanRecord: TCheckLoadTimePlanRecordEhEvent;
    FOnLoadDataForPeriod: TPlannerLoadDataForPeriodEhEvent;
    FOnPrepareItemsReader: TPrepareItemsReaderEhEvent;
    FOnPrepareReadItem: TReadItemEhEvent;

    function GetCount: Integer;
    function GetItems(Index: Integer): TPlannerDataItemEh;
    function GetResources: TPlannerResourcesEh;

    procedure SetResources(const Value: TPlannerResourcesEh);
    procedure SetItemSourceParams(const Value: TPlannerItemSourceParamsEh);
    procedure SetAllItemsLoaded(const Value: Boolean);
    procedure SetLoadedFinishDateC(const Value: TDateTime);
    procedure SetLoadedStartDate(const Value: TDateTime);

  protected

    function IsLoadTimePlanRecord(ADataSet: TDataSet): Boolean; virtual;

    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    procedure FreeItem(Item: TPlannerDataItemEh);
    procedure LoadDataForPeriod(StartDate, FinishDate, LoadedBorderDate: TDateTime; var LoadedStartDate, LoadedFinishDate: TDateTime); virtual;
    procedure PlanChanged; virtual;
    procedure PlanItemChanged(PlanItem: TPlannerDataItemEh); virtual;
    procedure PrepareItemsReader(StartDate, FinishDate, LoadedBorderDate: TDateTime; var ALoadedStartDate, ALoadedFinishDate: TDateTime); virtual;
    procedure ReadItem(PlanItem: TPlannerDataItemEh; var Eof: Boolean); virtual;
    procedure ResolvePlanItemUpdate(PlanItem: TPlannerDataItemEh; UpdateStatus: TUpdateStatus); virtual;
    procedure ResolvePlanItemUpdateToDataStorage(PlanItem: TPlannerDataItemEh; UpdateStatus: TUpdateStatus);
    procedure ResourcesChanged; virtual;
    procedure Sort;
    procedure UpdateRecourdesByRecourdeID; virtual;


  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure RegisterChanges(Value: ISimpleChangeNotificationEh);
    procedure UnRegisterChanges(Value: ISimpleChangeNotificationEh);

    function CreatePlannerItem: TPlannerDataItemEh; virtual;
    function CreateTmpPlannerItem: TPlannerDataItemEh; virtual;
    function NewItem(ATimePlanItemClass: TPlannerDataItemEhClass = nil; IsDummy: Boolean = False): TPlannerDataItemEh;
    function IndexOf(Item: TPlannerDataItemEh): Integer;

    procedure AddItem(Item: TPlannerDataItemEh);
    procedure BeginUpdate;
    procedure ClearItems;
    procedure DefaultPrepareItemsReader(RequriedStartDate, RequriedFinishDate, LoadedBorderDate: TDateTime; var PreparedReadyStartDate, PreparedFinishDate: TDateTime); virtual;
    procedure DefaultReadItem(PlanItem: TPlannerDataItemEh; var Eof: Boolean); virtual;
    procedure DeleteItem(Item: TPlannerDataItemEh);
    procedure DeleteItemAt(Index: Integer);
    procedure DeleteItemNoApplyUpdates(Item: TPlannerDataItemEh);
    procedure EndUpdate;
    procedure EnsureDataForPeriod(AStartDate, AEndDate: TDateTime); virtual;
    procedure FetchTimePlanItem(Item: TPlannerDataItemEh);
    procedure LoadTimeItems; virtual;
    procedure RequestItems(StartTime, EndTime: TDateTime);

    procedure StopAutoLoad;
    procedure ResetAutoLoadProcess;

    property AllItemsLoaded: Boolean read FAllItemsLoaded write SetAllItemsLoaded;
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TPlannerDataItemEh read GetItems; default;
    property LoadedFinishDate: TDateTime read FLoadedFinishDate write SetLoadedFinishDateC;
    property LoadedStartDate: TDateTime read FLoadedStartDate write SetLoadedStartDate;
    property Resources: TPlannerResourcesEh read GetResources write SetResources;
    property TimePlanItemClass: TPlannerDataItemEhClass read FTimePlanItemClass write FTimePlanItemClass;

  published
    property ItemSourceParams: TPlannerItemSourceParamsEh read FItemSourceParams write SetItemSourceParams;

    property OnApplyUpdateToDataStorage: TApplyUpdateToDataStorageEhEvent read FOnApplyUpdateToDataStorage write FOnApplyUpdateToDataStorage;
    property OnCheckLoadTimePlanRecord: TCheckLoadTimePlanRecordEhEvent read FOnCheckLoadTimePlanRecord write FOnCheckLoadTimePlanRecord;
    property OnPrepareItemsReader: TPrepareItemsReaderEhEvent read FOnPrepareItemsReader write FOnPrepareItemsReader;
    property OnLoadDataForPeriod: TPlannerLoadDataForPeriodEhEvent read FOnLoadDataForPeriod write FOnLoadDataForPeriod;
    property OnReadItem: TReadItemEhEvent read FOnPrepareReadItem write FOnPrepareReadItem;
  end;

implementation

uses
{$IFDEF EH_LIB_17}
  UIConsts,
{$ENDIF}
  EhLibLangConsts,
  PlannersEh;

procedure InitUnit;
begin
end;

procedure FinalizeUnit;
begin
end;

{ TPlannerDataItemEh }

constructor TPlannerDataItemEh.Create(ASource: TPlannerDataSourceEh);
begin
  inherited Create;
  FSource := ASource;
  FFillColor := clDefault;
  FFrameColor := ChangeColorLuminance(clSkyBlue, 100);
  FEditingStatus := esInsertEh;
end;

destructor TPlannerDataItemEh.Destroy;
begin
  Delete;
  inherited Destroy;
end;

procedure TPlannerDataItemEh.Delete;
begin
  if not IsDummy and Assigned(FSource) then
  begin
    FSource.FItems.Remove(Self);
    if FSource.FUpdateCount = 0
      then FSource.PlanChanged
      else FSource.FChanged := True;
    FSource := nil;
  end;
end;

procedure TPlannerDataItemEh.BeginEdit;
begin
  if FUpdateCount = 0 then
    FEditingStatus := esEditEh;
  Inc(FUpdateCount);
end;

procedure TPlannerDataItemEh.BeginInsert;
begin
  if FUpdateCount > 0 then
    raise Exception.Create('In the TTimePlanItemEh.BeginInsert method FUpdateCount can''t be > 0');
  if FEditingStatus <> esInsertEh then
    raise Exception.Create('In the TTimePlanItemEh.BeginInsert method FEditingStatus must be in esInsertEh Status');
  Inc(FUpdateCount);
end;

procedure TPlannerDataItemEh.EndEdit(PostChanges: Boolean);
begin
  if FEditingStatus = esBrowseEh then
    raise Exception.Create('The Time Plan Item is not in the Edit or Insert mode');
  Dec(FUpdateCount);
  if not FDummy and (Source <> nil) and (FUpdateCount = 0) then
  begin
    if FEditingStatus = esInsertEh then
    begin
      if PostChanges then
        Source.AddItem(Self)
      else
      begin
        Source.FreeItem(Self);
        Exit;
      end;
    end else
    begin
      Change;
    end;
    FEditingStatus := esBrowseEh;
  end;
end;

procedure TPlannerDataItemEh.Assign(Source: TPersistent);
begin
  if Source is TPlannerDataItemEh then
  begin
    BeginEdit;
    try
      AssignProperties(Source as TPlannerDataItemEh);
    except
      EndEdit(False);
    end;
    EndEdit(True);
  end;
end;

procedure TPlannerDataItemEh.AssignProperties(Source: TPlannerDataItemEh);
begin
  Title := TPlannerDataItemEh(Source).Title;
  FEndTime := TPlannerDataItemEh(Source).EndTime;
  StartTime := TPlannerDataItemEh(Source).StartTime;
  AllDay := TPlannerDataItemEh(Source).AllDay;

  Body := TPlannerDataItemEh(Source).Body;
  ResourceID := TPlannerDataItemEh(Source).ResourceID;
  ItemID := TPlannerDataItemEh(Source).ItemID;
  Resource := TPlannerDataItemEh(Source).Resource;
  FillColor := TPlannerDataItemEh(Source).FillColor;

  FSource :=  TPlannerDataItemEh(Source).Source;
end;

procedure TPlannerDataItemEh.Change;
begin
  if FChangesApplying then Exit;

  if UpdateStatus = usUnmodified then
    FUpdateStatus := usModified;
  if FUpdateCount = 0 then
  begin
    if UpdateStatus <> usUnmodified then
      ResolvePlanItemUpdate;
    if Source <> nil then
      Source.PlanItemChanged(Self);
  end;
end;

procedure TPlannerDataItemEh.ApplyUpdates;
begin
  if UpdateStatus = usInserted then
    ResolvePlanItemUpdate
  else if UpdateStatus = usDeleted then
    ResolvePlanItemUpdate;
  MergeUpdates;
end;

procedure TPlannerDataItemEh.ResolvePlanItemUpdate;
begin
  StartApplyChanges;
  try
    if Source <> nil then
      Source.ResolvePlanItemUpdate(Self, UpdateStatus);
  finally
    FinishApplyChanges;
  end;
end;

procedure TPlannerDataItemEh.MergeUpdates;
begin
  FUpdateStatus := usUnmodified;
end;

function TPlannerDataItemEh.GetDuration: TDateTime;
begin
  Result := FEndTime - FStartTime;
end;

function TPlannerDataItemEh.GetFrameColor: TColor;
begin
  Result := FFrameColor;
end;

function TPlannerDataItemEh.InsideDay: Boolean;
begin
  if (DateOf(EndTime) = EndTime) and (DateOf(StartTime+1) = EndTime) then
    Result := True
  else if not AllDay and (DateOf(StartTime) = DateOf(EndTime)) then
    Result := True
  else
    Result := False;
end;

function TPlannerDataItemEh.InsideDayRange: Boolean;
begin
  Result := (DateOf(StartTime) = DateOf(EndTime)) or (DateOf(StartTime+1) = EndTime);
end;

procedure TPlannerDataItemEh.SetAllDay(const Value: Boolean);
begin
  if FAllDay <> Value then
  begin
    FAllDay := Value;
    Change;
  end;
end;

procedure TPlannerDataItemEh.SetFillColor(const Value: TColor);
begin
  if FFillColor <> Value then
  begin
    FFillColor := Value;
    if FFillColor = clDefault then
      FFrameColor := ChangeColorLuminance(clSkyBlue, 100)
    else
      FFrameColor := ChangeColorLuminance(FFillColor, 100);
    Change;
  end;
end;

procedure TPlannerDataItemEh.SetItemID(const Value: Variant);
begin
  if FItemID <> Value then
  begin
    FItemID := Value;
    Change;
  end;
end;

procedure TPlannerDataItemEh.SetResourceID(const Value: Variant);
begin
  if not VarSameValue(FResourceID, Value) then
  begin
    FResourceID := Value;
    UpdateRefResource;
    Change;
  end;
end;

procedure TPlannerDataItemEh.SetResource(const Value: TPlannerResourceEh);
begin
  if FResource <> Value then
  begin
    FResource := Value;
    if FResource <> nil then
      FResourceID := FResource.ResourceID
    else
      FResourceID := Null;
    Change;
  end;
end;

procedure TPlannerDataItemEh.SetStartTime(const Value: TDateTime);
begin
  if FStartTime <> Value then
  begin
    FStartTime := NormalizeDateTime(Value);
    if FEndTime < FStartTime then
      FEndTime := FStartTime;
    Change;
  end;
end;

procedure TPlannerDataItemEh.SetEndTime(const Value: TDateTime);
begin
  if FEndTime <> Value then
  begin
    if Value < FStartTime then
      raise Exception.Create(EhLibLanguageConsts.PlannerEndTimeBeforeStartTimeEh);
    FEndTime := NormalizeDateTime(Value);
    Change;
  end;
end;

procedure TPlannerDataItemEh.SetTitle(const Value: string);
begin
  if FTitle <> Value then
  begin
    FTitle := Value;
    Change;
  end;
end;

procedure TPlannerDataItemEh.SetBody(const Value: String);
begin
  if FBody <> Value then
  begin
    FBody := Value;
    Change;
  end;
end;

procedure TPlannerDataItemEh.SetReadOnly(const Value: Boolean);
begin
  if FReadOnly <> Value then
  begin
    FReadOnly := Value;
    Change;
  end;
end;

procedure TPlannerDataItemEh.UpdateRefResource;
begin
  if Source <> nil then
    FResource := Source.Resources.ResourceByResourceID(ResourceID);
end;

procedure TPlannerDataItemEh.StartApplyChanges;
begin
  if FChangesApplying then
    raise Exception.Create('TTimePlanItemEh.StartApplyChanges: ApplyChanges already started.');
  FChangesApplying := True;
end;

procedure TPlannerDataItemEh.FinishApplyChanges;
begin
  if not FChangesApplying then
    raise Exception.Create('TTimePlanItemEh.FinishApplyChanges: ApplyChanges has not yet started.');
  FChangesApplying := False;
end;

{ TPlannerDataSourceEh }

constructor TPlannerDataSourceEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FItems := TObjectListEh.Create;
  FTimePlanItemClass := TPlannerDataItemEh;
  FNotificationConsumers := TInterfaceList.Create;
  FResources := TPlannerResourcesEh.Create(Self);
  FItemSourceParams := TPlannerItemSourceParamsEh.Create(Self);
  FLoadedStartDate := 0;
  FLoadedFinishDate := 0;
  FAllItemsLoaded := True;
end;

destructor TPlannerDataSourceEh.Destroy;
begin
  Destroying;
  ClearItems;
  FreeAndNil(FNotificationConsumers);
  FreeAndNil(FItems);
  FreeAndNil(FResources);
  FreeAndNil(FItemSourceParams);
  inherited Destroy;
end;

function TPlannerDataSourceEh.CreatePlannerItem: TPlannerDataItemEh;
begin
  Result := NewItem(TimePlanItemClass);
end;

function TPlannerDataSourceEh.CreateTmpPlannerItem: TPlannerDataItemEh;
begin
  Result := NewItem(TimePlanItemClass, True);
end;

function TPlannerDataSourceEh.NewItem(ATimePlanItemClass: TPlannerDataItemEhClass = nil; IsDummy: Boolean = False): TPlannerDataItemEh;
begin
  if ATimePlanItemClass = nil then
    ATimePlanItemClass := TimePlanItemClass;
  Result := ATimePlanItemClass.Create(Self);
  if IsDummy then
    Result.FDummy := True;
  Result.BeginInsert;
end;

procedure TPlannerDataSourceEh.AddItem(Item: TPlannerDataItemEh);
begin
  if Item.Source <> Self then
    raise Exception.Create('procedure TPlannerDataSourceEh.Add: TimePlanItem.Source is not belong to adding Source');
  if Item.FEditingStatus <> esInsertEh then
    raise Exception.Create('procedure TPlannerDataSourceEh.Add: TimePlanItem is not in esInsertEh Editing Status');
  Item.FUpdateStatus := usInserted;
  Item.ApplyUpdates;
  Item.FEditingStatus := esBrowseEh;  
  if Item.FUpdateCount > 0 then
    Dec(Item.FUpdateCount);
  FItems.Add(Item);
  PlanChanged;
end;

procedure TPlannerDataSourceEh.FreeItem(Item: TPlannerDataItemEh);
begin
  Item.Free;
end;

procedure TPlannerDataSourceEh.FetchTimePlanItem(Item: TPlannerDataItemEh);
begin
  if Item.FUpdateCount > 0 then
    Dec(Item.FUpdateCount);
  if Item.Source <> Self then
    raise Exception.Create('procedure TPlannerDataSourceEh.FetchTimePlanItem: TimePlanItem.Source is not belong to adding Source');
  if Item.FEditingStatus <> esInsertEh then
    raise Exception.Create('procedure TPlannerDataSourceEh.FetchTimePlanItem: TimePlanItem is not in esInsertEh Editing Status');
  FItems.Add(Item);
  Item.MergeUpdates;
  PlanChanged;
end;

procedure TPlannerDataSourceEh.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TPlannerDataSourceEh.EndUpdate;
begin
  if FUpdateCount > 0 then
  begin
    Dec(FUpdateCount);
    if FChanged then
      PlanChanged;
  end;
end;

procedure TPlannerDataSourceEh.PlanChanged;
var
  i: Integer;
begin
  if csDestroying in ComponentState then Exit;
  if FUpdateCount = 0 then
  begin
    FChanged := False;
    if FNotificationConsumers <> nil then
      for I := 0 to FNotificationConsumers.Count - 1 do
        (FNotificationConsumers[I] as ISimpleChangeNotificationEh).Change(Self);
  end else
    FChanged := True;
end;

procedure TPlannerDataSourceEh.ClearItems;
begin
  BeginUpdate;
  try
{$IFDEF NEXTGEN}
    FItems.Clear;
{$ELSE}
    while Count > 0 do
    begin
      FreeObjectEh(Items[Count-1]);
    end;
{$ENDIF}
  finally
    EndUpdate;
  end;
  FLoadedStartDate := 0;
  FLoadedFinishDate := 0;
end;

procedure TPlannerDataSourceEh.DeleteItem(Item: TPlannerDataItemEh);
begin
  Item.FUpdateStatus := usDeleted;
  Item.ApplyUpdates;
  DeleteItemNoApplyUpdates(Item);
end;

procedure TPlannerDataSourceEh.DeleteItemAt(Index: Integer);
begin
  DeleteItem(Items[Index]);
end;

procedure TPlannerDataSourceEh.DeleteItemNoApplyUpdates(Item: TPlannerDataItemEh);
begin
  Item.Delete;
  Item.Free;
end;

function TPlannerDataSourceEh.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TPlannerDataSourceEh.GetItems(Index: Integer): TPlannerDataItemEh;
begin
  Result := TPlannerDataItemEh(FItems[Index]);
end;

function TPlannerDataSourceEh.IndexOf(Item: TPlannerDataItemEh): Integer;
begin
  Result := FItems.IndexOf(Item);
end;

function TPlannerDataSourceEh.IsLoadTimePlanRecord(ADataSet: TDataSet): Boolean;
begin
  Result := True;
  if Assigned(OnCheckLoadTimePlanRecord) then
    OnCheckLoadTimePlanRecord(Self, ADataSet, Result);
end;

procedure TPlannerDataSourceEh.EnsureDataForPeriod(AStartDate, AEndDate: TDateTime);
var
  NewLoadedStartDate, NewLoadedFinishDate: TDateTime;
begin
  if AllItemsLoaded then Exit;

  if (LoadedStartDate = 0) and (LoadedFinishDate = 0) then
  begin
    LoadDataForPeriod(AStartDate, AEndDate, 0, NewLoadedStartDate, NewLoadedFinishDate);
    FLoadedStartDate := NewLoadedStartDate;
    FLoadedFinishDate := NewLoadedFinishDate;
    if (LoadedStartDate = 0) and (LoadedFinishDate = 0) then
      FAllItemsLoaded := True;
  end else
  begin
    if AStartDate < LoadedStartDate then
    begin
      BeginUpdate;
      try
        LoadDataForPeriod(AStartDate, LoadedStartDate, LoadedStartDate,
          NewLoadedStartDate, NewLoadedFinishDate);
        FLoadedStartDate := AStartDate;
      finally
        EndUpdate;
      end;
    end;
    if AEndDate > LoadedFinishDate then
    begin
      BeginUpdate;
      try
        LoadDataForPeriod(LoadedFinishDate, AEndDate, LoadedFinishDate,
          NewLoadedStartDate, NewLoadedFinishDate);
        FLoadedFinishDate := AEndDate;
      finally
        EndUpdate;
      end;
    end;
  end;
end;

procedure TPlannerDataSourceEh.LoadDataForPeriod(StartDate, FinishDate,
  LoadedBorderDate: TDateTime; var LoadedStartDate, LoadedFinishDate: TDateTime);
var
  PlanItem: TPlannerDataItemEh;
  Eof: Boolean;
begin
  if Assigned(OnLoadDataForPeriod) then
    OnLoadDataForPeriod(Self, StartDate, FinishDate, LoadedBorderDate, LoadedStartDate, LoadedFinishDate)
  else
  begin
    PrepareItemsReader(StartDate, FinishDate, LoadedBorderDate, LoadedStartDate, LoadedFinishDate);

    BeginUpdate;
    try

      while True do
      begin
        PlanItem := NewItem;
        ReadItem(PlanItem, Eof);
        if Eof then
        begin
          PlanItem.Free;
          Break;
        end else
          FetchTimePlanItem(PlanItem);
      end;

    finally
      EndUpdate;
    end;
  end;
end;

procedure TPlannerDataSourceEh.PrepareItemsReader(StartDate, FinishDate,
  LoadedBorderDate: TDateTime; var ALoadedStartDate,
  ALoadedFinishDate: TDateTime);
begin
  if Assigned(OnPrepareItemsReader) then
    OnPrepareItemsReader(Self, StartDate, FinishDate, LoadedBorderDate,
      ALoadedStartDate, ALoadedFinishDate)
  else
    DefaultPrepareItemsReader(StartDate, FinishDate, LoadedBorderDate,
      ALoadedStartDate, ALoadedFinishDate);
end;

procedure TPlannerDataSourceEh.DefaultPrepareItemsReader(
  RequriedStartDate, RequriedFinishDate, LoadedBorderDate: TDateTime;
  var PreparedReadyStartDate, PreparedFinishDate: TDateTime);
begin
  if ItemSourceParams.DataSet <> nil then
  begin
    ItemSourceParams.DataSet.First;
    ItemSourceParams.DataSet.DisableControls;
  end;
  PreparedReadyStartDate := 0;
  PreparedFinishDate := 0;
end;

procedure TPlannerDataSourceEh.ReadItem(PlanItem: TPlannerDataItemEh;
  var Eof: Boolean);
begin
  if Assigned(OnReadItem) then
    OnReadItem(Self, PlanItem, Eof)
  else
    DefaultReadItem(PlanItem, Eof);
end;

procedure TPlannerDataSourceEh.DefaultReadItem(PlanItem: TPlannerDataItemEh;
  var Eof: Boolean);
begin
  if (ItemSourceParams.DataSet = nil) or ItemSourceParams.DataSet.Eof then
    Eof := True;

  if Eof then
  begin
    if ItemSourceParams.DataSet <> nil then
      ItemSourceParams.DataSet.EnableControls;
    Exit;
  end;

  ItemSourceParams.DataSet.Next;
end;

procedure TPlannerDataSourceEh.LoadTimeItems;
var
  PlanItem: TPlannerDataItemEh;
begin
  if ItemSourceParams.DataSet = nil then Exit;


  BeginUpdate;
  try
    ItemSourceParams.DataSet.DisableControls;

    ClearItems;
    ItemSourceParams.DataSet.First;
    ItemSourceParams.FieldsMap.InitItems;

    while not ItemSourceParams.DataSet.Eof do
    begin

      if IsLoadTimePlanRecord(ItemSourceParams.DataSet) then
      begin

        PlanItem := NewItem();
        ItemSourceParams.FieldsMap.ReadDataRecordValues(PlanItem);

        FetchTimePlanItem(PlanItem);
      end;
      ItemSourceParams.DataSet.Next;
    end;
  finally
    ItemSourceParams.DataSet.EnableControls;
    EndUpdate;
  end;
end;

procedure TPlannerDataSourceEh.RequestItems(StartTime, EndTime: TDateTime);
begin

end;

procedure TPlannerDataSourceEh.PlanItemChanged(PlanItem: TPlannerDataItemEh);
begin
  PlanChanged;
end;

procedure TPlannerDataSourceEh.ResolvePlanItemUpdate(
  PlanItem: TPlannerDataItemEh; UpdateStatus: TUpdateStatus);
begin
  ResolvePlanItemUpdateToDataStorage(PlanItem, UpdateStatus);
end;

procedure TPlannerDataSourceEh.ResolvePlanItemUpdateToDataStorage(
  PlanItem: TPlannerDataItemEh; UpdateStatus: TUpdateStatus);
begin
  if Assigned(OnApplyUpdateToDataStorage) then
    OnApplyUpdateToDataStorage(Self, PlanItem, UpdateStatus);
end;

procedure TPlannerDataSourceEh.ResourcesChanged;
begin
  UpdateRecourdesByRecourdeID;
  PlanChanged;
end;

procedure TPlannerDataSourceEh.UpdateRecourdesByRecourdeID;
var
  i: Integer;
begin
  for i := 0 to Count-1 do
    Items[i].UpdateRefResource;
end;

procedure TPlannerDataSourceEh.Sort;
begin
  raise Exception.Create('TPlannerDataSourceEh.Sort: TODO');
end;

procedure TPlannerDataSourceEh.RegisterChanges(Value: ISimpleChangeNotificationEh);
begin
  if FNotificationConsumers.IndexOf(Value) < 0 then
    FNotificationConsumers.Add(Value);
end;

procedure TPlannerDataSourceEh.UnRegisterChanges(
  Value: ISimpleChangeNotificationEh);
begin
  if (FNotificationConsumers <> nil) then
    FNotificationConsumers.Remove(Value);
end;

procedure TPlannerDataSourceEh.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if (AComponent is TDataSet) and (AComponent = ItemSourceParams.DataSet) then
      ItemSourceParams.DataSet := nil;
  end;
end;

procedure TPlannerDataSourceEh.ResetAutoLoadProcess;
begin
  ClearItems;
  FLoadedStartDate := 0;
  FLoadedFinishDate := 0;
  FAllItemsLoaded := False;
  PlanChanged;
end;

procedure TPlannerDataSourceEh.StopAutoLoad;
begin
  FAllItemsLoaded := True;
end;

{ TPlannerResourceEh }

constructor TPlannerResourceEh.Create(ACollection: TCollection);
begin
  inherited Create(ACollection);
  FColor := clDefault;
  FFaceColor := clDefault;
  FDarkLineColor := clDefault;
  FBrightLineColor := clDefault;
end;

procedure TPlannerResourceEh.AssignTo(Dest: TPersistent);
var
  DestRes: TPlannerResourceEh;
begin
  if Dest is TPlannerResourceEh then
  begin
    DestRes := TPlannerResourceEh(Dest);
    DestRes.FName := FName;
    DestRes.FImageIndex := FImageIndex;
    DestRes.FColor := FColor;
    DestRes.Changed(False);
  end else
    inherited AssignTo(Dest);
end;

function TPlannerResourceEh.GetCollection: TPlannerResourcesEh;
begin
  Result := TPlannerResourcesEh(inherited Collection);
end;

function TPlannerResourceEh.GetDisplayName: string;
begin
  if FName <> ''
    then Result := FName
    else Result := inherited GetDisplayName;
end;

function TPlannerResourceEh.GetFaceColor: TColor;
begin
  if FFaceColor <> clDefault
    then Result := FFaceColor
    else Result := FColor;
end;

function TPlannerResourceEh.GetBrightLineColor: TColor;
begin
  Result := FBrightLineColor;
end;

function TPlannerResourceEh.GetDarkLineColor: TColor;
begin
  Result := FDarkLineColor;
end;

procedure TPlannerResourceEh.SetDisplayName(const Value: string);
begin
  Name := Value;
end;

procedure TPlannerResourceEh.SetColor(const Value: TColor);
var
{$IFDEF EH_LIB_17}
  H, S, L: Single;
{$ELSE}
  H, S, L: Word;
{$ENDIF}

begin
  if FColor <> Value then
  begin
    FColor := Value;
    Changed(False);

    if FColor <> clDefault then
    begin
{$IFDEF EH_LIB_17}
      RGBtoHSL(ColorToRGB(FColor), H, S, L);
      FFaceColor := MakeColor(HSLtoRGB(H, 0.3, 0.85), 0);
      FDarkLineColor := MakeColor(HSLtoRGB(H, 0.3, 0.75), 0);
      FBrightLineColor := MakeColor(HSLtoRGB(H, 0.3, 0.9), 0);
{$ELSE}
      ColorRGBToHLS(ColorToRGB(FColor), H, L, S);
      FFaceColor := ColorHLSToRGB(H, Trunc(0.85 * 240), Trunc(0.3 * 240));
      FDarkLineColor := ColorHLSToRGB(H, Trunc(0.75 * 240), Trunc(0.3 * 240));
      FBrightLineColor := ColorHLSToRGB(H, Trunc(0.9 * 240), Trunc(0.3 * 240));
{$ENDIF}
    end
    else
    begin
      FFaceColor := clDefault;
      FDarkLineColor := clDefault;
      FBrightLineColor := clDefault;
    end;
  end;
end;

procedure TPlannerResourceEh.SetImageIndex(const Value: TImageIndex);
begin
  if FImageIndex <> Value then
  begin
    FImageIndex := Value;
    Changed(False);
  end;
end;

procedure TPlannerResourceEh.SetName(const Value: string);
begin
  if FName <> Value then
  begin
    FName := Value;
    Changed(False);
  end;
end;

procedure TPlannerResourceEh.SetResourceID(const Value: Variant);
begin
  if not VarEquals(FResourceID, Value) then
  begin
    FResourceID := Value;
    Changed(False);
  end;
end;

function TPlannerDataSourceEh.GetResources: TPlannerResourcesEh;
begin
  Result := FResources;
end;

procedure TPlannerDataSourceEh.SetAllItemsLoaded(const Value: Boolean);
begin
  if FAllItemsLoaded <> Value then
  begin
    FAllItemsLoaded := Value;
  end;
end;

procedure TPlannerDataSourceEh.SetItemSourceParams(
  const Value: TPlannerItemSourceParamsEh);
begin
  FItemSourceParams.Assign(Value);
end;

procedure TPlannerDataSourceEh.SetLoadedFinishDateC(const Value: TDateTime);
begin
  if FLoadedFinishDate <> Value then
  begin
    FLoadedFinishDate := Value;
    ResourcesChanged;
  end;
end;

procedure TPlannerDataSourceEh.SetLoadedStartDate(const Value: TDateTime);
begin
  if FLoadedStartDate <> Value then
  begin
    FLoadedStartDate := Value;
    ResourcesChanged;
  end;
end;

procedure TPlannerDataSourceEh.SetResources(const Value: TPlannerResourcesEh);
begin
  FResources.Assign(Value);
end;

{ TPlannerResourcesEh }

constructor TPlannerResourcesEh.Create(APlannerSource: TPlannerDataSourceEh);
begin
  inherited Create(TPlannerResourceEh);
  FPlannerSource := APlannerSource;
end;

function TPlannerResourcesEh.Add: TPlannerResourceEh;
begin
  Result := TPlannerResourceEh(inherited Add);
end;

function TPlannerResourcesEh.GetItem(Index: Integer): TPlannerResourceEh;
begin
  Result := TPlannerResourceEh(inherited GetItem(Index));
end;

function TPlannerResourcesEh.GetOwner: TPersistent;
begin
  Result := FPlannerSource;
end;

function TPlannerResourcesEh.ResourceByResourceID(ResourceID: Variant): TPlannerResourceEh;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count-1 do
    if VarEquals(Items[i].ResourceID, ResourceID) then
    begin
      Result := Items[i];
      Break;
    end;
end;

procedure TPlannerResourcesEh.SetItem(Index: Integer;
  Value: TPlannerResourceEh);
begin
  inherited SetItem(Index, Value);
end;

procedure TPlannerResourcesEh.Update(Item: TCollectionItem);
begin
  if Assigned(FPlannerSource) then
    FPlannerSource.ResourcesChanged;
end;

{ TPlannerItemSourceParamsEh }

constructor TPlannerItemSourceParamsEh.Create(APlannerDataSource: TPlannerDataSourceEh);
begin
  inherited Create;
  FPlannerDataSource := APlannerDataSource;
  FFieldsMap := TItemSourceFieldsMapEh.Create(Self, TItemSourceFieldsMapItemEh);
end;

destructor TPlannerItemSourceParamsEh.Destroy;
begin
  FreeAndNil(FFieldsMap);
  inherited Destroy;
end;

function TPlannerItemSourceParamsEh.GetOwner: TPersistent;
begin
  Result := PlannerDataSource;
end;

procedure TPlannerItemSourceParamsEh.SetDataSet(const Value: TDataSet);
begin
  if FDataSet <> Value then
  begin
    FDataSet := Value;
    if FDataSet <> nil then
      FDataSet.FreeNotification(PlannerDataSource);
  end;
end;

procedure TPlannerItemSourceParamsEh.SetFieldMap(const Value: TItemSourceFieldsMapEh);
begin
  FFieldsMap.Assign(Value);
end;

{ TItemSourceFieldsMapEh }

function TItemSourceFieldsMapEh.Add: TItemSourceFieldsMapItemEh;
begin
  Result := TItemSourceFieldsMapItemEh(inherited Add);
end;

procedure TItemSourceFieldsMapEh.BuildItems(
  const DataItemClass: TPlannerDataItemEhClass);
var
  PropList: TPropListArray;
  i: Integer;
  AItem: TItemSourceFieldsMapItemEh;
begin
  PropList := GetPropListAsArray(DataItemClass.ClassInfo, tkProperties);
  for i := 0 to Length(PropList)-1 do
  begin
    AItem := Add;
{$IFDEF NEXTGEN}
    AItem.PropertyName := String(PropList[i].NameFld.ToString);
{$ELSE}
    AItem.PropertyName := String(PropList[i].Name);
{$ENDIF}
  end;
end;

constructor TItemSourceFieldsMapEh.Create(
  AItemSourceParamsEh: TPlannerItemSourceParamsEh;
  ItemClass: TCollectionItemClass);
begin
  inherited Create(ItemClass);
  FItemSourceParamsEh := AItemSourceParamsEh;
end;

destructor TItemSourceFieldsMapEh.Destroy;
begin
  inherited Destroy;
end;

procedure TItemSourceFieldsMapEh.InitItems;
var
  i: Integer;
begin
  for i := 0 to Count-1 do
  begin
    Item[i].FField := nil;
    if SourceParams.DataSet <> nil then
      Item[i].FField := SourceParams.DataSet.FindField(Item[i].DataSetFieldName);

    Item[i].FPropInfo := nil;
    if Item[i].PropertyName <> '' then
      Item[i].FPropInfo := GetPropInfo(
        SourceParams.PlannerDataSource.TimePlanItemClass.ClassInfo,
        Item[i].PropertyName);
  end;
end;

procedure TItemSourceFieldsMapEh.ReadDataRecordValues(DataItem: TPlannerDataItemEh);
var
  i: Integer;
begin
  for i := 0 to Count-1 do
    Item[i].ReadValue(DataItem);
end;

function TItemSourceFieldsMapEh.GetSourceParams: TPlannerItemSourceParamsEh;
begin
  Result := FItemSourceParamsEh;
end;

function TItemSourceFieldsMapEh.GetItem(
  Index: Integer): TItemSourceFieldsMapItemEh;
begin
  Result := TItemSourceFieldsMapItemEh(inherited Items[Index]);
end;

function TItemSourceFieldsMapEh.GetOwner: TPersistent;
begin
  Result := SourceParams;
end;

procedure TItemSourceFieldsMapEh.SetItem(Index: Integer;
  const Value: TItemSourceFieldsMapItemEh);
begin
  inherited Items[Index] := Value;
end;

function TItemSourceFieldsMapEh.CanAddDefaultItems: Boolean;
begin
  Result := True;
end;

procedure TItemSourceFieldsMapEh.AddAllItems(DeleteExisting: Boolean);
var
  it: TItemSourceFieldsMapItemEh;
begin
  it := Add;
  it.PropertyName := 'Title';
  if (SourceParams.DataSet <> nil) and (SourceParams.DataSet.FindField('Title') <> nil) then
    it.DataSetFieldName := 'Title';

  it := Add;
  it.PropertyName := 'Body';
  if (SourceParams.DataSet <> nil) and (SourceParams.DataSet.FindField('Body') <> nil) then
    it.DataSetFieldName := 'Body';

  it := Add;
  it.PropertyName := 'StartTime';
  if (SourceParams.DataSet <> nil) and (SourceParams.DataSet.FindField('StartTime') <> nil) then
    it.DataSetFieldName := 'StartTime';

  it := Add;
  it.PropertyName := 'EndTime';
  if (SourceParams.DataSet <> nil) and (SourceParams.DataSet.FindField('EndTime') <> nil) then
    it.DataSetFieldName := 'EndTime';

  it := Add;
  it.PropertyName := 'AllDay';
  if (SourceParams.DataSet <> nil) and (SourceParams.DataSet.FindField('AllDay') <> nil) then
    it.DataSetFieldName := 'AllDay';

  it := Add;
  it.PropertyName := 'ResourceID';
  if (SourceParams.DataSet <> nil) and (SourceParams.DataSet.FindField('ResourceID') <> nil) then
    it.DataSetFieldName := 'ResourceID';

  it := Add;
  it.PropertyName := 'ItemID';
  if (SourceParams.DataSet <> nil) and (SourceParams.DataSet.FindField('ItemID') <> nil) then
    it.DataSetFieldName := 'ItemID';

  it := Add;
  it.PropertyName := 'FillColor';
  if (SourceParams.DataSet <> nil) and (SourceParams.DataSet.FindField('FillColor') <> nil) then
    it.DataSetFieldName := 'FillColor';
end;

{$IFDEF FPC}
function TItemSourceFieldsMapEh.QueryInterface(constref IID: TGUID; 
  out Obj): HResult;
{$ELSE}
function TItemSourceFieldsMapEh.QueryInterface(const IID: TGUID; 
  out Obj): HResult;
{$ENDIF}
begin
  if GetInterface(IID, Obj)
    then Result := 0
    else Result := E_NOINTERFACE;
end;

function TItemSourceFieldsMapEh._AddRef: Integer;
begin
  Result := -1;
end;

function TItemSourceFieldsMapEh._Release: Integer;
begin
  Result := -1;
end;

{ TItemSourceFieldsMapItemEh }

constructor TItemSourceFieldsMapItemEh.Create(Collection: TCollection);
begin
  inherited Create(Collection);
end;

function TItemSourceFieldsMapItemEh.GetCollection: TItemSourceFieldsMapEh;
begin
  Result := TItemSourceFieldsMapEh(inherited Collection);
end;

procedure TItemSourceFieldsMapItemEh.DefaulReadValue(
  const DataItem: TPlannerDataItemEh);
var
  TypeKind: TTypeKind;
begin
  if (PropInfo <> nil) and (Field <> nil) and not Field.IsNull then
  begin
    TypeKind := PropType_getKind(PropInfo_getPropType(PropInfo));
    case TypeKind of
      tkInteger:
        SetOrdProp(DataItem, PropInfo, Field.AsInteger);
      tkChar:
        if Length(Field.AsString) > 0 then
          SetOrdProp(DataItem, PropInfo, Ord(Field.AsString[1]));
      tkEnumeration:
        SetOrdProp(DataItem, PropInfo, Field.AsInteger);
      tkFloat:
        SetFloatProp(DataItem, PropInfo, Field.AsFloat);
{$IFDEF NEXTGEN}
{$ELSE}
      tkString:
        SetStrProp(DataItem, PropInfo, Field.AsString);
      tkWString:
        SetWideStrProp(DataItem, PropInfo, WideString(Field.AsString));
{$ENDIF}
      tkLString:
        SetStrProp(DataItem, PropInfo, Field.AsString);
{$IFDEF EH_LIB_12}
      tkUString:
  {$IFDEF NEXTGEN}
        SetStrProp(DataItem, PropInfo, Field.AsString);
  {$ELSE}
        SetWideStrProp(DataItem, PropInfo, Field.AsString);
  {$ENDIF}
{$ENDIF}
      tkSet:
        SetOrdProp(DataItem, PropInfo, Field.AsInteger);
      tkVariant:
        SetVariantProp(DataItem, PropInfo, Field.AsVariant);
{$IFDEF EH_LIB_13}
      tkInt64:
        SetInt64Prop(DataItem, PropInfo, Field.AsLargeInt);
{$ENDIF}

      tkClass:
        raise Exception.Create('TItemSourceFieldsMapItemEh.ReadValue: tkClass is not supported');
      tkMethod:
        raise Exception.Create('TItemSourceFieldsMapItemEh.ReadValue: tkMethod is not supported');
      tkInterface:
        raise Exception.Create('TItemSourceFieldsMapItemEh.ReadValue: tkInterface is not supported');
    end;
  end;
end;

procedure TItemSourceFieldsMapItemEh.ReadValue(const DataItem: TPlannerDataItemEh);
var
  Processed: Boolean;
begin
  Processed := False;
  if Assigned(OnReadValue) then
    OnReadValue(Collection.SourceParams.PlannerDataSource, Self, DataItem, Processed);
  if not Processed then
    DefaulReadValue(DataItem);
end;

procedure TItemSourceFieldsMapItemEh.Assign(Source: TPersistent);
begin
  if Source is TItemSourceFieldsMapItemEh then
  begin
    DataSetFieldName := TItemSourceFieldsMapItemEh(Source).DataSetFieldName;
    PropertyName := TItemSourceFieldsMapItemEh(Source).PropertyName;
  end;
end;

initialization
  InitUnit;
finalization
  FinalizeUnit;
end.
