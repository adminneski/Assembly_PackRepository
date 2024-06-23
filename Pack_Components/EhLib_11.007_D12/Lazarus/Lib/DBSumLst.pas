{*******************************************************}
{                                                       }
{                       EhLib 10.2                      }
{                   TDBSumList component                }
{                                                       }
{   Copyright (c) 1998-2022 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit DBSumLst;

interface

uses
{$IFDEF CIL}
  EhLibVCLNET,
{$ELSE}
{$IFDEF FPC}
  EhLibLCL,
{$ELSE}
  EhLibVCL, Windows,
{$ENDIF}
{$ENDIF}
  Forms, Dialogs,
  SysUtils, Classes, DB, ToolCtrlsEh, Variants,
  TypInfo, FmtBcd;

type
  TGroupOperation = (goSum, goAvg, goCount, goMin, goMax);

  TDBSum = class(TCollectionItem)
  private
    procedure SetGroupOperation(const Value: TGroupOperation);
    procedure SetFieldName(const Value: String);
  protected
    FFieldName: String;
    FGroupOperation: TGroupOperation;
    Value: Variant;
    FNotNullRecordCount: Integer;
    FSumValueAsSum: Variant;
    VarValue: Variant;

  public
    SumValue: Variant;

    constructor Create(Collection: TCollection); override;
    procedure Assign(Source: TPersistent); override;

  published
    property FieldName: String read FFieldName write SetFieldName;
    property GroupOperation: TGroupOperation read FGroupOperation write SetGroupOperation;
  end;

  TDBSumCollection = class(TCollection)
  protected
    FOwner: TPersistent;
    function GetItem(Index: Integer): TDBSum;
    function GetOwner: TPersistent; override;
    procedure SetItem(Index: Integer; Value: TDBSum);
    procedure Update(Item: TCollectionItem); override;

  public
    function GetSumByOpAndFName(AGroupOperation: TGroupOperation; const AFieldName: String): TDBSum;
    property Items[Index: Integer]: TDBSum read GetItem write SetItem; default;
  end;

  TDBSumListProducer = class(TPersistent)
  private
    FVirtualRecords: Boolean;
  protected
    Changing: Boolean;
    FActive: Boolean;
    FDataSet: TDataSet;
    FDesignTimeWork: Boolean;
    FDataSetControlsWasDisabled: Boolean;
    FEventsOverloaded: Boolean;
    FExternalRecalc: Boolean;
    Filter: String;
    Filtered: Boolean;
    FInternalDataSource: TDataSource;
    FMasterDataset: TDataset;
    FMasterPropInfo: PPropInfo;
    FOldRecNo: Integer;
    FOnAfterRecalcAll: TNotifyEvent;
    FOnRecalcAll: TNotifyEvent;
    FOwner: TComponent;
    FRecalcAllSilently: Boolean;
    FSumCollection: TDBSumCollection;
    FSumListChanged: TNotifyEvent;
    FTryedInsert: Boolean;
    FVirtualRecList: TBMListEh;
    FDataSetChanging: Boolean;
    OldAfterClose: TDataSetNotifyEvent;
    OldAfterOpen: TDataSetNotifyEvent;
    OldAfterPost: TDataSetNotifyEvent;
    OldAfterScroll: TDataSetNotifyEvent;
    OldAfterDelete: TDataSetNotifyEvent;
    OldMasterAfterScroll: TDataSetNotifyEvent;

    function GetRecNo: Integer; virtual;
    function FindVirtualRecord(Bookmark: TUniBookmarkEh): Integer; virtual;
    function GetOwner: TPersistent; override;
    function BookmarkAvailable: Boolean;

    procedure SetRecNo(const Value: Integer); virtual;
    procedure SetVirtualRecords(const Value: Boolean);
    procedure DataSetAfterClose(DataSet: TDataSet); virtual;
    procedure DataSetAfterOpen(DataSet: TDataSet); virtual;
    procedure DataSetAfterPost(DataSet: TDataSet); virtual;
    procedure DataSetAfterScroll(DataSet: TDataSet); virtual;
    procedure DataSetAfterDelete(DataSet: TDataSet); virtual;
    procedure DoSumListChanged;
    procedure InternalDataSourceDataChanged(Sender: TObject; Field: TField);
    procedure Loaded;
    procedure MasterDataSetAfterScroll(DataSet: TDataSet);
    procedure RecalcAllSilently;
    procedure ResetMasterInfo;
    procedure ReturnEvents; virtual;
    procedure SetActive(const Value: Boolean);
    procedure SetDataSet(Value: TDataSet);
    procedure SetExternalRecalc(const Value: Boolean);
    procedure SetSumCollection(const Value: TDBSumCollection);
    procedure Update;

  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;

    function BookmarkInVisibleView({$IFDEF CIL}const{$ENDIF} Bookmark: TUniBookmarkEh): Boolean;
    function IsSequenced: Boolean; virtual;
    function RecordCount: Integer; virtual;

    procedure Activate(ARecalcAll: Boolean);
    procedure Assign(Source: TPersistent); override;
    procedure ClearSumValues; virtual;
    procedure Deactivate(AClearSumValues: Boolean);
    procedure RecalcAll; virtual;
    procedure RecalcAllForIntMemTable; virtual;
    procedure SetDataSetEvents; virtual;

    property Active: Boolean read FActive write SetActive default True;
    property DataSet: TDataSet read FDataSet write SetDataSet;
    property ExternalRecalc: Boolean read FExternalRecalc write SetExternalRecalc;
    property RecNo: Integer read GetRecNo write SetRecNo;
    property SumCollection: TDBSumCollection read FSumCollection write SetSumCollection;
    property VirtualRecords: Boolean read FVirtualRecords write SetVirtualRecords;
    property SumListChanged: TNotifyEvent read FSumListChanged write FSumListChanged;
    property OnAfterRecalcAll: TNotifyEvent read FOnAfterRecalcAll write FOnAfterRecalcAll;
    property OnRecalcAll: TNotifyEvent read FOnRecalcAll write FOnRecalcAll;
  end;

  TDBSumList = class(TComponent)
  private
    function GetActive: Boolean;
    function GetDataSet: TDataSet;
    function GetExternalRecalc: Boolean;
    function GetOnAfterRecalcAll: TNotifyEvent;
    function GetOnRecalcAll: TNotifyEvent;
    function GetRecNo: Integer;
    function GetSumCollection: TDBSumCollection;
    function GetSumListChanged: TNotifyEvent;
    function GetVirtualRecords: Boolean;

    procedure SetOnAfterRecalcAll(const Value: TNotifyEvent);
    procedure SetOnRecalcAll(const Value: TNotifyEvent);
    procedure SetRecNo(const Value: Integer);
    procedure SetSumListChanged(const Value: TNotifyEvent);
    procedure SetVirtualRecords(const Value: Boolean);

  protected
    FSumListProducer: TDBSumListProducer;
    procedure DataSetAfterClose(DataSet: TDataSet);
    procedure DataSetAfterOpen(DataSet: TDataSet);
    procedure DataSetAfterPost(DataSet: TDataSet);
    procedure DataSetAfterScroll(DataSet: TDataSet);
    procedure DoSumListChanged;
    procedure Loaded; override;
    procedure MasterDataSetAfterScroll(DataSet: TDataSet);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetActive(const Value: Boolean);
    procedure SetDataSet(Value: TDataSet);
    procedure SetExternalRecalc(const Value: Boolean);
    procedure SetSumCollection(const Value: TDBSumCollection);

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function IsSequenced: Boolean;
    function RecordCount: Integer;
    procedure Activate(ARecalcAll: Boolean);
    procedure ClearSumValues; virtual;
    procedure Deactivate(AClearSumValues: Boolean);
    procedure RecalcAll; virtual;
    procedure SetDataSetEvents;
    property RecNo: Integer read GetRecNo write SetRecNo;

  published
    property Active: Boolean read GetActive write SetActive default True;
    property DataSet: TDataSet read GetDataSet write SetDataSet;
    property ExternalRecalc: Boolean read GetExternalRecalc write SetExternalRecalc;
    property SumCollection: TDBSumCollection read GetSumCollection write SetSumCollection;
    property VirtualRecords: Boolean read GetVirtualRecords write SetVirtualRecords;
    property SumListChanged: TNotifyEvent read GetSumListChanged write SetSumListChanged;
    property OnAfterRecalcAll: TNotifyEvent read GetOnAfterRecalcAll write SetOnAfterRecalcAll;
    property OnRecalcAll: TNotifyEvent read GetOnRecalcAll write SetOnRecalcAll;
  end;

implementation

type
  TBMListCrackEh = class(TBMListEh);

{ TSLBookmarkListEh }

  TSLBookmarkListEh = class(TBMListEh)
  private
    FSumListProducer: TDBSumListProducer;
  protected
    function GetDataSet: TDataSet; override;
  public
    constructor Create(ASumListProducer: TDBSumListProducer);
  end;

constructor TSLBookmarkListEh.Create(ASumListProducer: TDBSumListProducer);
begin
  inherited Create;
  FSumListProducer := ASumListProducer;
end;

function TSLBookmarkListEh.GetDataSet: TDataSet;
begin
  Result := FSumListProducer.DataSet;
end;


{ TDBSumListProducer }

constructor TDBSumListProducer.Create(AOwner: TComponent);
begin
  inherited Create;
  FDesignTimeWork := False;
  FOwner := AOwner;
  FSumCollection := TDBSumCollection.Create(TDBSum);
  FSumCollection.FOwner := Self;
  FActive := True;
  FVirtualRecList := TSLBookmarkListEh.Create(Self);
  FInternalDataSource := TDataSource.Create(nil);
  FInternalDataSource.OnDataChange := InternalDataSourceDataChanged;
end;

destructor TDBSumListProducer.Destroy;
begin
  Deactivate(False);
  FreeAndNil(FVirtualRecList);
  FreeAndNil(FSumCollection);
  FreeAndNil(FInternalDataSource);
  inherited;
end;


procedure TDBSumListProducer.Assign(Source: TPersistent);
begin
  if Source is TDBSumListProducer then
  begin
    Active := TDBSumListProducer(Source).Active;
    DataSet := TDBSumListProducer(Source).DataSet;
    ExternalRecalc := TDBSumListProducer(Source).ExternalRecalc;
    SumCollection.Assign(TDBSumListProducer(Source).SumCollection);
    SumListChanged := TDBSumListProducer(Source).SumListChanged;
    VirtualRecords := TDBSumListProducer(Source).VirtualRecords;
    OnAfterRecalcAll := TDBSumListProducer(Source).OnAfterRecalcAll;
    OnRecalcAll := TDBSumListProducer(Source).OnRecalcAll;
  end
  else inherited Assign(Source);
end;

procedure TDBSumListProducer.ResetMasterInfo;
begin
  if Assigned(FMasterDataSet) then
  begin
    FMasterDataSet.AfterScroll := OldMasterAfterScroll;
  end;
  OldMasterAfterScroll := nil;
  FMasterPropInfo := GetPropInfo(FDataSet.ClassInfo, 'MasterSource');
  FMasterDataSet := GetMasterDataSet(FDataSet, FMasterPropInfo);
  if Assigned(FMasterDataSet)
    then OldMasterAfterScroll := FMasterDataSet.AfterScroll;
  if Assigned(FMasterDataSet)
    then FMasterDataSet.AfterScroll := MasterDataSetAfterScroll;
end;

procedure TDBSumListProducer.SetDataSetEvents;
begin
  if Assigned(FDataSet) and (FEventsOverloaded = False) then
  begin
    FInternalDataSource.DataSet := FDataSet;

    FMasterPropInfo := GetPropInfo(FDataSet.ClassInfo, 'MasterSource');
    FMasterDataSet := GetMasterDataSet(FDataSet, FMasterPropInfo);

    OldAfterOpen := FDataSet.AfterOpen;
    OldAfterPost := FDataSet.AfterPost;
    OldAfterScroll := FDataSet.AfterScroll;
    OldAfterDelete := FDataSet.AfterDelete;
    OldAfterClose := FDataSet.AfterClose;
    if Assigned(FMasterDataSet)
      then OldMasterAfterScroll := FMasterDataSet.AfterScroll;

    FDataSet.AfterOpen := DataSetAfterOpen;
    FDataSet.AfterPost := DataSetAfterPost;
    FDataSet.AfterScroll := DataSetAfterScroll;
    FDataSet.AfterDelete := DataSetAfterDelete;
    FDataSet.AfterClose := DataSetAfterClose;
    if Assigned(FMasterDataSet)
      then FMasterDataSet.AfterScroll := MasterDataSetAfterScroll;

    FEventsOverloaded := True;

  end;
end;

procedure TDBSumListProducer.ReturnEvents;
begin
  if Assigned(FDataSet) and
     (FEventsOverloaded = True) then
  begin
    FInternalDataSource.DataSet := nil;
    FDataSetControlsWasDisabled := False;

    if not (csDestroying in FDataSet.Componentstate) then
    begin
      FDataSet.AfterOpen := OldAfterOpen;
      FDataSet.AfterPost := OldAfterPost;
      FDataSet.AfterScroll := OldAfterScroll;
      FDataSet.AfterDelete := OldAfterDelete;
      FDataSet.AfterClose := OldAfterClose;
    end;

    if Assigned(FMasterDataSet) and
       not (csDestroying in FMasterDataSet.Componentstate) then
    begin
      FMasterDataSet.AfterScroll := OldMasterAfterScroll;
    end;

    OldMasterAfterScroll := nil;
    OldAfterOpen := nil;
    OldAfterPost := nil;
    OldAfterScroll := nil;
    OldAfterDelete := nil;
    OldAfterClose := nil;

    FMasterPropInfo := nil;
    FMasterDataSet := nil;

    FEventsOverloaded := False;
    FVirtualRecList.Clear;
  end;
end;

procedure TDBSumListProducer.SetDataSet(Value: TDataSet);
var OldActive: Boolean;
begin
  if Assigned(Value) and (FDataSet = Value) and (csDestroying in Value.ComponentState) then
  begin
    ReturnEvents;
    FDataSet := nil;
  end;

  if (FDataSet = Value) then Exit;

  if not (csLoading in FOwner.ComponentState) and
    (FDesignTimeWork or not (csDesigning in FOwner.ComponentState)) then
  begin
    FDataSetChanging := True;
    try
      OldActive := Active;
      Deactivate(True);
      FDataSet := Value;
    finally
      FDataSetChanging := False;
    end;
    if OldActive
      then Activate(True)
      else ClearSumValues;
  end else
    FDataSet := Value;
end;

procedure TDBSumListProducer.Loaded;
begin
  if Assigned(FDataSet) and Active then begin
    Activate(True);
  end;
end;

procedure TDBSumListProducer.RecalcAllForIntMemTable;
var
  AIntMemTable: IMemTableEh;
  i: Integer;
  item: TDBSum;
  ResultArr: TAggrResultArr;
  v: Variant;
  iaf: TAggrFunctionEh;
  BcdVarValue: Variant;
const
  GrOpOfAggFuncs: array [TGroupOperation] of TAggrFunctionEh = (agfSumEh, agfAvg, agfCountEh, agfMin, agfMax);
begin
  if not (not (csLoading in FOwner.ComponentState) and (Active = True) and
          Assigned(DataSet) and (DataSet.Active = True) and
          Supports(DataSet, IMemTableEh, AIntMemTable)
          ) then
    Exit;

  for iaf := Low(TAggrFunctionEh) to High(TAggrFunctionEh) do
    ResultArr[iaf] := Null;

  AIntMemTable.FetchRecords(-1);
  if Assigned(OnRecalcAll) then OnRecalcAll(Self);
  for i := 0 to FSumCollection.Count - 1 do
  begin
    item := TDBSum(FSumCollection.Items[i]);
    if (item.GroupOperation = goCount) or (item.FieldName <> '') then
    begin
      AIntMemTable.GetAggregatedValuesForRange(
        NilBookmarkEh, NilBookmarkEh, item.FieldName, ResultArr,
        [GrOpOfAggFuncs[Item.GroupOperation]]);
      case Item.GroupOperation of
        goSum: v := ResultArr[agfSumEh];
        goCount: v := ResultArr[agfCountEh];
        goAvg: v := ResultArr[agfAvg];
        goMin: v := ResultArr[agfMin];
        goMax: v := ResultArr[agfMax];
      end;
      if VarIsNull(v) then
        item.SumValue := 0
      else
      begin
        {$IFDEF FPC}
        BcdVarValue := Null;
        VarFmtBCDCreate(BcdVarValue, VarToBCD(v));
        {$ELSE}
        VarClear(BcdVarValue);
        VarCast(BcdVarValue, v, VarFMTBcd);
        {$ENDIF}
        item.SumValue := BcdVarValue;
      end;
    end;
  end;
  if Assigned(OnAfterRecalcAll) then OnAfterRecalcAll(Self);
  DoSumListChanged;
end;

function TDBSumListProducer.BookmarkAvailable;
var
  AIntMemTable: IMemTableEh;
begin
  if Supports(DataSet, IMemTableEh, AIntMemTable) then
  begin
    Result := (DataSet.RecordCount > 0);
  end else
    Result := True;
end;

procedure TDBSumListProducer.RecalcAllSilently;
begin
  FRecalcAllSilently := True;
  try
    RecalcAll;
  finally
    FRecalcAllSilently := False;
  end;
end;

type
  TDataSetCrack = class(TDataSet);

procedure TDBSumListProducer.RecalcAll;
var
  i: Integer;
  item: TDBSum;
  NeedRecalc: Boolean;
  ABookmark: TUniBookmarkEh;
  FieldArr: array of TField;
  AIntMemTable: IMemTableEh;

  OldActRec: Integer;
  BufferCount: Integer;
  DataSetCrack: TDataSetCrack;
  FieldValue: Variant;
  FieldBcdValue: Variant;

  function CheckCalculatedFieldsInProc: Boolean;
  var
    i: Integer;
    Field: TField;
  begin
    Result := False;
    for i := 0 to FSumCollection.Count - 1 do
    begin
      Field := FDataSet.FindField(FSumCollection.Items[i].FieldName);
      if (Field <> nil) and Field.Calculated then
      begin
        Result := True;
        Exit;
      end;
    end;
  end;

  procedure SaveRelativePos;
  begin
    DataSetCrack := TDataSetCrack(DataSet);
    OldActRec := DataSetCrack.ActiveRecord;
    BufferCount := DataSetCrack.BufferCount;
  end;

  procedure RestoreRelativePos;
  var
    ShiftBy: Integer;
    ActRec: Integer;
  begin
    ActRec := DataSetCrack.ActiveRecord;
    BufferCount := DataSetCrack.BufferCount;
    if (ActRec > OldActRec) then
    begin
      ShiftBy := BufferCount - 1 - OldActRec;
    end else if (ActRec < OldActRec) then
    begin
      ShiftBy := -OldActRec;
    end else
    begin
      ShiftBy := 0;
    end;

    if (ShiftBy <> 0) then
    begin
      DataSet.MoveBy(ShiftBy);
      DataSet.MoveBy(-ShiftBy);
    end;
  end;

begin
  if (DataSet <> nil) and (DataSet.ControlsDisabled = True) then
  begin
    FDataSetControlsWasDisabled := True;
    Exit;
  end;

  if not (csLoading in FOwner.ComponentState) and
         (Active = True) and
         Assigned(DataSet) and
         (DataSet.Active = True) and
         (VirtualRecords = False) and
         not CheckCalculatedFieldsInProc and
         Supports(DataSet, IMemTableEh, AIntMemTable)
  then
  begin
    RecalcAllForIntMemTable;
    Filtered := FDataSet.Filtered;
    Filter := FDataSet.Filter;
    Exit;
  end;

  if (not FDesignTimeWork and (csDesigning in FOwner.ComponentState)) or
    (csLoading in FOwner.ComponentState) or (Active = False) or not Assigned(DataSet) or
    (DataSet.Active = False) or (FEventsOverloaded = False) then Exit;
  try
    ClearSumValues;
    FOldRecNo := -1;

    if Assigned(OnRecalcAll) then OnRecalcAll(Self);
    if ExternalRecalc then Exit;

    NeedRecalc := FSumCollection.Count > 0;

    if NeedRecalc then
    begin
      SetLength(FieldArr, FSumCollection.Count);
      for i := 0 to FSumCollection.Count - 1 do
        if TDBSum(FSumCollection.Items[i]).FieldName <> '' then
          FieldArr[i] := FDataSet.FieldByName(FSumCollection.Items[i].FieldName);

      ABookmark := NilBookmarkEh;

      if BookmarkAvailable and (FDataSet.Bookmark <> NilBookmarkEh) then
        ABookmark := FDataSet.Bookmark;

      SaveRelativePos;
      FDataSet.DisableControls;
      try
      FVirtualRecList.Clear;
      Changing := True;

      FDataSet.First;
      while FDataSet.Eof = False do
      begin
        for i := 0 to FSumCollection.Count - 1 do
        begin
          item := TDBSum(FSumCollection.Items[i]);
          if (item.GroupOperation = goCount) or (item.FieldName <> '') then
          begin
            if (FieldArr[i] <> nil) then
            begin
              FieldValue := FieldArr[i].Value;
              if not VarIsNull(FieldValue) then
              begin
                {$IFDEF FPC}
                FieldBcdValue := Null;
                VarFmtBCDCreate(FieldBcdValue, VarToBCD(FieldValue));
                {$ELSE}
                VarClear(FieldBcdValue);
                VarCast(FieldBcdValue, FieldValue, VarFMTBcd);
                {$ENDIF}
              end else
              begin
                FieldBcdValue := Null;
              end;
            end;

            case Item.GroupOperation of
              goSum:
                if not VarIsNull(FieldBcdValue) then
                begin
                  if VarIsNull(Item.SumValue)
                    then Item.SumValue := FieldBcdValue
                    else Item.SumValue := Item.SumValue + FieldBcdValue;
                end;
              goCount:
                if (Item.FieldName = '') or not FieldArr[i].IsNull then
                  Item.SumValue := Item.SumValue + 1;
              goAvg:
                begin
                  if (FieldArr[i].IsNull = False) then
                  begin
                    Inc(Item.FNotNullRecordCount);
                    if VarIsNull(Item.FSumValueAsSum)
                      then Item.FSumValueAsSum := FieldBcdValue
                      else Item.FSumValueAsSum := Item.FSumValueAsSum + FieldBcdValue;
                  end;
                end;
              goMin:
                begin
                   if (not FieldArr[i].IsNull) then
                  begin
                    if VarIsNull(Item.VarValue) then
                      Item.VarValue := FieldBcdValue
                    else if FieldBcdValue < Item.VarValue then
                      Item.VarValue := FieldBcdValue;
                  end;
                end;
              goMax:
                begin
                  if (not FieldArr[i].IsNull) then
                  begin
                    if VarIsNull(Item.VarValue) then
                      Item.VarValue := FieldBcdValue
                    else if FieldBcdValue > Item.VarValue then
                      Item.VarValue := FieldBcdValue;
                  end;
                end;
            end;
          end;
        end;
        if {not FDataSet.IsSequenced and} VirtualRecords then
            TBMListCrackEh(FVirtualRecList).AppendItem(FDataSet.Bookmark);
        FDataSet.Next;
      end;

      if (ABookmark <> NilBookmarkEh) and BookmarkInVisibleView(ABookmark)
        then FDataSet.Bookmark := ABookmark
        else FDataSet.First;

      for i := 0 to FSumCollection.Count - 1 do
      begin
        item := TDBSum(FSumCollection.Items[i]);
        if item.GroupOperation = goAvg then
        begin
          if item.FNotNullRecordCount <> 0
            then item.SumValue := item.FSumValueAsSum / item.FNotNullRecordCount
            else item.SumValue := 0;
        end
        else if item.GroupOperation in [goMin, goMax] then
        begin
          if not VarIsNull(Item.VarValue) then
            Item.SumValue := Item.VarValue;
        end;
      end;
      finally
        FDataSet.EnableControls;
        RestoreRelativePos;
      end;
    end;

    if Assigned(OnAfterRecalcAll) then OnAfterRecalcAll(Self);

  finally
    Filtered := FDataSet.Filtered;
    Filter := FDataSet.Filter;
    Changing := False;
    DoSumListChanged;
  end;
end;

procedure TDBSumListProducer.DataSetAfterOpen(DataSet: TDataSet);
begin
  if Active then RecalcAll;
  if (Assigned(OldAfterOpen)) then
    OldAfterOpen(DataSet);
end;

procedure TDBSumListProducer.DataSetAfterPost(DataSet: TDataSet);
begin
  if Active then
  begin
    if (Assigned(OldAfterPost)) then
      OldAfterPost(DataSet);
    RecalcAll;
  end;
end;

procedure TDBSumListProducer.DataSetAfterScroll(DataSet: TDataSet);
begin
  if (Assigned(OldAfterScroll)) then
    OldAfterScroll(DataSet);
  if (Active = False) then Exit;

  if (Changing = False) then
  begin
    if ((DataSet.Filtered and (Filter <> DataSet.Filter)) or (Filtered <> DataSet.Filtered)) then
      RecalcAll;
  end;
end;

procedure TDBSumListProducer.DataSetAfterDelete(DataSet: TDataSet);
begin
  if (Assigned(OldAfterDelete)) then
    OldAfterDelete(DataSet);
  RecalcAll;
end;

procedure TDBSumListProducer.DataSetAfterClose(DataSet: TDataSet);
begin
  if Active then
  begin
    ClearSumValues;
    DoSumListChanged;
    Changing := False;
  end;

  FVirtualRecList.Clear;

  if (Assigned(OldAfterClose)) then
    OldAfterClose(DataSet);
end;

procedure TDBSumListProducer.SetSumCollection(const Value: TDBSumCollection);
begin
  FSumCollection.Assign(Value);
end;

procedure TDBSumListProducer.SetActive(const Value: Boolean);
begin
  if (FActive = Value) then Exit;
  if (Value = True) then Activate(True);
  if (Value = False) then Deactivate(True);
end;

procedure TDBSumListProducer.Activate(ARecalcAll: Boolean);
begin
  FActive := True;
  if (csLoading in FOwner.ComponentState) or
    (not FDesignTimeWork and (csDesigning in FOwner.ComponentState)) then Exit;
  SetDataSetEvents;
  if ARecalcAll then RecalcAll;
end;

procedure TDBSumListProducer.Deactivate(AClearSumValues: Boolean);
begin
  FActive := False;
  if (csLoading in FOwner.ComponentState) or
    (not FDesignTimeWork and (csDesigning in FOwner.ComponentState)) then Exit;
  ReturnEvents;
  if AClearSumValues and not FDataSetChanging then
    ClearSumValues;
end;

procedure TDBSumListProducer.DoSumListChanged;
begin
  if not FRecalcAllSilently and
     Assigned(SumListChanged)
  then
    SumListChanged(Self);
end;

procedure TDBSumListProducer.ClearSumValues;
var
  i: Integer;
  item: TDBSum;
begin
  for i := 0 to FSumCollection.Count - 1 do
  begin
    item := TDBSum(FSumCollection.Items[i]);
    if (item.GroupOperation = goCount) and (item.FieldName = '')
      then item.SumValue := 0
      else item.SumValue := Null;
    item.Value := Null;
    item.FSumValueAsSum := Null;
    item.FNotNullRecordCount := 0;
    item.VarValue := Null;
  end;
  DoSumListChanged;
end;

procedure TDBSumListProducer.SetExternalRecalc(const Value: Boolean);
begin
  if (FExternalRecalc = Value) then Exit;
  FExternalRecalc := Value;
  RecalcAll;
end;

procedure TDBSumListProducer.MasterDataSetAfterScroll(DataSet: TDataSet);
begin
  if (Assigned(OldMasterAfterScroll)) then
    OldMasterAfterScroll(DataSet);

  if (Active = False) then Exit;
  if Changing = False then RecalcAll;
end;

function TDBSumListProducer.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure TDBSumListProducer.Update;
begin
  if (csLoading in FOwner.ComponentState) then Exit;
  if (csDestroying in FOwner.ComponentState) then Exit; 
  RecalcAll;
end;

procedure TDBSumListProducer.SetVirtualRecords(const Value: Boolean);
begin
  if (FVirtualRecords = Value) then Exit;
  FVirtualRecords := Value;
  if FVirtualRecords then RecalcAll;
end;

function TDBSumListProducer.GetRecNo: Integer;
begin
  if {not DataSet.IsSequenced and} VirtualRecords and Active then
    Result := FindVirtualRecord(DataSet.Bookmark) + 1
  else
    Result := DataSet.RecNo;
end;

procedure TDBSumListProducer.SetRecNo(const Value: Integer);
begin
  if {not DataSet.IsSequenced and }VirtualRecords and Active then
    DataSet.Bookmark := FVirtualRecList[Value - 1]
  else
    DataSet.RecNo := Value;
end;

function TDBSumListProducer.RecordCount: Integer;
begin
  if Assigned(DataSet) and {not DataSet.IsSequenced and} VirtualRecords and Active then
    Result := FVirtualRecList.Count
  else if Assigned(DataSet) then
    Result := DataSet.RecordCount
  else Result := 0;
end;

function TDBSumListProducer.IsSequenced: Boolean;
begin
  Result := (Assigned(DataSet) and DataSet.IsSequenced) or
    (Assigned(DataSet) and VirtualRecords and Active and not ((FVirtualRecList.Count = 0) and not (DataSet.EOF and DataSet.BOF)));
end;

function TDBSumListProducer.FindVirtualRecord(Bookmark: TUniBookmarkEh): Integer;
var
  C: Integer;
begin
  Result := -1;
  if FOldRecNo = -1 then FOldRecNo := 0;

  if FVirtualRecList.Count = 0 then Exit;
  if FOldRecNo >= FVirtualRecList.Count then FOldRecNo := 0;

  C := DataSetCompareBookmarks(DataSet, FVirtualRecList[FOldRecNo], Bookmark);

  if (C > 0) then
    while C <> 0 do
    begin
      Dec(FOldRecNo);
      if (FOldRecNo < 0) then Exit;
      C := DataSetCompareBookmarks(DataSet, FVirtualRecList[FOldRecNo], Bookmark);
    end
  else if (C < 0) then
    while C <> 0 do
    begin
      Inc(FOldRecNo);
      if (FOldRecNo >= FVirtualRecList.Count) then Exit;
      C := DataSetCompareBookmarks(DataSet, FVirtualRecList[FOldRecNo], Bookmark);
    end;

  Result := FOldRecNo;
end;

function TDBSumListProducer.BookmarkInVisibleView(Bookmark: TUniBookmarkEh): Boolean;
var
  AIntMemTable: IMemTableEh;
begin
  if Supports(DataSet, IMemTableEh, AIntMemTable) then
  begin
    Result := AIntMemTable.BookmarkInVisibleView(Bookmark);
  end else
    Result := DataSetBookmarkValid(FDataSet, Bookmark);
end;

procedure TDBSumListProducer.InternalDataSourceDataChanged(Sender: TObject;
  Field: TField);
begin
  if (DataSet = nil) then Exit;

  if FDataSetControlsWasDisabled and not DataSet.ControlsDisabled then
  begin
    FDataSetControlsWasDisabled := False;
    RecalcAll;
  end;
end;

{ TDBSum }

procedure TDBSum.Assign(Source: TPersistent);
begin
  if Source is TDBSum then
  begin
    GroupOperation := TDBSum(Source).GroupOperation;
    FieldName := TDBSum(Source).FieldName;
    Value := TDBSum(Source).Value;
    SumValue := TDBSum(Source).SumValue;
  end
  else inherited Assign(Source);
end;

constructor TDBSum.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FFieldName := '';
end;

procedure TDBSum.SetFieldName(const Value: String);
begin
  if (FFieldName = Value) then Exit;
  FFieldName := Value;
  Changed(False);
end;

procedure TDBSum.SetGroupOperation(const Value: TGroupOperation);
begin
  if (FGroupOperation = Value) then Exit;
  FGroupOperation := Value;
  Changed(False);
end;

{ TDBSumCollection }

function TDBSumCollection.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

function TDBSumCollection.GetItem(Index: Integer): TDBSum;
begin
  Result := TDBSum(inherited GetItem(Index));
end;

procedure TDBSumCollection.SetItem(Index: Integer; Value: TDBSum);
begin
  inherited SetItem(Index, Value);
end;

procedure TDBSumCollection.Update(Item: TCollectionItem);
begin
  TDBSumListProducer(FOwner).Update;
end;

function TDBSumCollection.GetSumByOpAndFName(
  AGroupOperation: TGroupOperation; const AFieldName: String): TDBSum;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
  begin
    if (AGroupOperation = Items[i].GroupOperation) and
      (AnsiCompareText(AFieldName, Items[i].FieldName) = 0) then
    begin
      Result := Items[i];
      Exit;
    end;
  end;
end;

{ TDBSumList }

constructor TDBSumList.Create(AOwner: TComponent);
begin
  inherited;
  FSumListProducer := TDBSumListProducer.Create(Self);
end;

destructor TDBSumList.Destroy;
begin
  inherited;
  FreeAndNil(FSumListProducer);
end;

procedure TDBSumList.Activate(ARecalcAll: Boolean);
begin
  FSumListProducer.Activate(ARecalcAll);
end;

procedure TDBSumList.ClearSumValues;
begin
  FSumListProducer.ClearSumValues;
end;

procedure TDBSumList.DataSetAfterClose(DataSet: TDataSet);
begin
  FSumListProducer.DataSetAfterClose(DataSet);
end;

procedure TDBSumList.DataSetAfterOpen(DataSet: TDataSet);
begin
  FSumListProducer.DataSetAfterOpen(DataSet);
end;

procedure TDBSumList.DataSetAfterPost(DataSet: TDataSet);
begin
  FSumListProducer.DataSetAfterPost(DataSet);
end;

procedure TDBSumList.DataSetAfterScroll(DataSet: TDataSet);
begin
  FSumListProducer.DataSetAfterScroll(DataSet);
end;

procedure TDBSumList.Deactivate(AClearSumValues: Boolean);
begin
  FSumListProducer.Deactivate(AClearSumValues);
end;

procedure TDBSumList.DoSumListChanged;
begin
  FSumListProducer.DoSumListChanged;
end;

procedure TDBSumList.Loaded;
begin
  inherited;
  FSumListProducer.Loaded;
end;

procedure TDBSumList.MasterDataSetAfterScroll(DataSet: TDataSet);
begin
  FSumListProducer.MasterDataSetAfterScroll(DataSet);
end;

procedure TDBSumList.RecalcAll;
begin
  FSumListProducer.RecalcAll;
end;

procedure TDBSumList.SetActive(const Value: Boolean);
begin
  FSumListProducer.SetActive(Value);
end;

procedure TDBSumList.SetDataSet(Value: TDataSet);
begin
  FSumListProducer.SetDataSet(Value);
  if Value <> nil then Value.FreeNotification(Self);
end;

procedure TDBSumList.SetDataSetEvents;
begin
  FSumListProducer.SetDataSetEvents;
end;

procedure TDBSumList.SetExternalRecalc(const Value: Boolean);
begin
  FSumListProducer.SetExternalRecalc(Value);
end;

procedure TDBSumList.SetSumCollection(const Value: TDBSumCollection);
begin
  FSumListProducer.SetSumCollection(Value);
end;

function TDBSumList.GetActive: Boolean;
begin
  Result := FSumListProducer.Active;
end;

function TDBSumList.GetDataSet: TDataSet;
begin
  Result := FSumListProducer.DataSet;
end;

function TDBSumList.GetExternalRecalc: Boolean;
begin
  Result := FSumListProducer.ExternalRecalc;
end;

function TDBSumList.GetOnRecalcAll: TNotifyEvent;
begin
  Result := FSumListProducer.OnRecalcAll;
end;

function TDBSumList.GetSumCollection: TDBSumCollection;
begin
  Result := FSumListProducer.SumCollection;
end;

function TDBSumList.GetSumListChanged: TNotifyEvent;
begin
  Result := FSumListProducer.SumListChanged;
end;

procedure TDBSumList.SetOnRecalcAll(const Value: TNotifyEvent);
begin
  FSumListProducer.OnRecalcAll := Value;
end;

procedure TDBSumList.SetSumListChanged(const Value: TNotifyEvent);
begin
  FSumListProducer.SumListChanged := Value;
end;

function TDBSumList.IsSequenced: Boolean;
begin
  Result := FSumListProducer.IsSequenced;
end;

function TDBSumList.RecordCount: Integer;
begin
  Result := FSumListProducer.RecordCount;
end;

procedure TDBSumList.SetVirtualRecords(const Value: Boolean);
begin
  FSumListProducer.VirtualRecords := Value;
end;

function TDBSumList.GetVirtualRecords: Boolean;
begin
  Result := FSumListProducer.VirtualRecords;
end;

function TDBSumList.GetRecNo: Integer;
begin
  Result := FSumListProducer.RecNo;
end;

procedure TDBSumList.SetRecNo(const Value: Integer);
begin
  FSumListProducer.RecNo := Value;
end;

procedure TDBSumList.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if (AComponent is TDataSet) and (AComponent = DataSet) then
    begin
      DataSet := nil;
    end;
  end;
end;

function TDBSumList.GetOnAfterRecalcAll: TNotifyEvent;
begin
  Result := FSumListProducer.OnAfterRecalcAll;
end;

procedure TDBSumList.SetOnAfterRecalcAll(const Value: TNotifyEvent);
begin
  FSumListProducer.OnAfterRecalcAll := Value;
end;

end.
