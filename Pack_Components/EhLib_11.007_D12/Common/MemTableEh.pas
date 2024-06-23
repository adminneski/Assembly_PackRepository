{*******************************************************}
{                                                       }
{                      EhLib 10.2                       }
{                 TMemTableEh component                 }
{                                                       }
{     Copyright (c) 2004-2022 by Dmitry V. Bolshakov    }
{                                                       }
{*******************************************************}

unit MemTableEh;

{$I EhLib.Inc}

interface

uses SysUtils, Classes, Controls, Forms, DB, Dialogs, Types,
  Variants, Contnrs,
{$IFDEF EH_LIB_17} System.Generics.Collections, Winapi.ActiveX, {$ENDIF}
{$IFDEF CIL}
  System.Runtime.InteropServices,
  EhLibVCLNET,
{$ELSE}

{$IFDEF FPC}
  EhLibLCL, LCLType, LMessages,
{$ELSE}
  EhLibVCL, DBCommon, Windows,
{$ENDIF}

{$ENDIF}
  ToolCtrlsEh, MemTableDataEh, DataDriverEh, MemTreeEh,
  Messages;

type

  TCustomMemTableEh = class;
  TMemTableFiltersEh = class;

  TLoadMode = (lmCopy, lmAppend, lmCopyStructureOnly);

  TMemTableLoadOptionEh = (tloUseCachedUpdatesEh, tloDisregardFilterEh,
    tloOpenOnLoad);
  TMemTableLoadOptionsEh = set of TMemTableLoadOptionEh;

  TDfmStreamFormatEh = (dfmBinaryEh, dfmTextEh);

  TFieldTypesEh = set of TFieldType;

{ TMasterDataLinkEh }

  TMasterDataLinkEh = class(TDetailDataLink)
  private
    FDataSet: TDataSet;
    FFieldNames: string;
    FFields: TFieldListEh;
    FOnMasterChange: TNotifyEvent;
    FOnMasterDisable: TNotifyEvent;
    procedure SetFieldNames(const Value: string);
  protected
    function GetDetailDataSet: TDataSet; override;
    procedure ActiveChanged; override;
    procedure CheckBrowseMode; override;
    procedure LayoutChanged; override;
    procedure RecordChanged(Field: TField); override;
  public
    constructor Create(DataSet: TDataSet);
    destructor Destroy; override;
    property FieldNames: string read FFieldNames write SetFieldNames;
    property Fields: TFieldListEh read FFields;
    property OnMasterChange: TNotifyEvent read FOnMasterChange write FOnMasterChange;
    property OnMasterDisable: TNotifyEvent read FOnMasterDisable write FOnMasterDisable;
  end;

{ TMemTableTreeListEh }

  TMemTableTreeListEh = class(TPersistent)
  private
    FMemTable: TCustomMemTableEh;
    FLoadingActive: Boolean;
    function GetActive: Boolean;
    function GetDefaultNodeExpanded: Boolean;
    function GetDefaultNodeHasChildren: Boolean;
    function GetFilterNodeIfParentVisible: Boolean;
    function GetFullBuildCheck: Boolean;
    function GetKeyFieldName: String;
    function GetRefParentFieldName: String;
    procedure SetActive(const Value: Boolean);
    procedure SetDefaultNodeExpanded(const Value: Boolean);
    procedure SetDefaultNodeHasChildren(const Value: Boolean);
    procedure SetFilterNodeIfParentVisible(const Value: Boolean);
    procedure SetFullBuildCheck(const Value: Boolean);
    procedure SetKeyFieldName(const Value: String);
    procedure SetRefParentFieldName(const Value: String);
  public
    constructor Create(AMemTable: TCustomMemTableEh);
    function Locate(const KeyFields: string; const KeyValues: Variant; Options: TLocateOptions): Boolean; virtual;
    procedure FullCollapse; virtual;
    procedure FullExpand; virtual;
  published
    property Active: Boolean read GetActive write SetActive default False;
    property KeyFieldName: String read GetKeyFieldName write SetKeyFieldName;
    property RefParentFieldName: String read GetRefParentFieldName write SetRefParentFieldName;
    property DefaultNodeExpanded: Boolean read GetDefaultNodeExpanded write SetDefaultNodeExpanded default False;
    property DefaultNodeHasChildren: Boolean read GetDefaultNodeHasChildren write SetDefaultNodeHasChildren default False;
    property FullBuildCheck: Boolean read GetFullBuildCheck write SetFullBuildCheck default True;
    property FilterNodeIfParentVisible: Boolean read GetFilterNodeIfParentVisible write SetFilterNodeIfParentVisible default True;
  end;

  { TMTStringFieldEh }

  TMTStringFieldEh = class(TStringField, ICalcFieldEh)
  public
    function CanModifyWithoutEditMode: Boolean;
    procedure Clear; override;
  end;

{ TCustomMemTableEh }

  TMasterDetailSideEh = (mdsOnSelfEh, mdsOnProviderEh, mdsOnSelfAfterProviderEh);

  TMTUpdateActionEh = (uaFailEh, uaAbortEh, uaSkipEh, uaRetryEh, uaApplyEh, uaAppliedEh);

  TMTUpdateRecordEventEh = procedure(DeltaDataSet: TDataSet; UpdateKind: TUpdateKind;
    var UpdateAction: TMTUpdateActionEh) of object;

  TMTFetchRecordEventEh = procedure(PacketDataSet: TDataSet; var ProviderEOF,
    Applied: Boolean) of object;

  TMTRefreshRecordEventEh = procedure(PacketDataSet: TDataSet; var Applied: Boolean)
    of object;

  TMTTreeNodeExpandingEventEh = procedure(Sender: TObject; RecNo: Integer;
    var AllowExpansion: Boolean) of object;

  TRecordsViewTreeNodeExpandingEventEh = procedure (Sender: TObject; Node: TMemRecViewEh;
    var AllowExpansion: Boolean) of object;

  TRecordsViewTreeNodeExpandedEventEh = procedure (Sender: TObject; Node: TMemRecViewEh) of object;

  TRecordsViewCheckMoveNodeEventEh = function (Sender: TObject;
    SourceNode, AppointedParent: TMemRecViewEh; AppointedIndex: Integer): Boolean of object;

  TMemTableChangeFieldValueEventEh = procedure (MemTable: TCustomMemTableEh;
    Field: TField; var Value: Variant) of object;

  TGetOrderVarValueProcEh = procedure (var VarValue: Variant;
    Index: Integer)  of object;

  TFBRecBufValues = array of Variant;

  TBookmarkDataEh = record
    {$IFDEF NEXTGEN} [Unsafe] {$ENDIF} MemRec: TMemoryRecordEh;
    RecViewIndex: Integer;
    InSortedListIndex: Integer;
  end;
  PBookmarkDataEh = ^TBookmarkDataEh;

{ TMTRecBuf }

  TMTRecBuf = class(TObject)
  private
  public
    InUse: Boolean;
    BookmarkData: TBookmarkDataEh;
    BookmarkFlag: TBookmarkFlag;
    RecordStatus: Integer;
    RecordNumber: Integer;
    NewTreeNodeExpanded: Boolean;
    NewTreeNodeHasChildren: Boolean;
    RecView: TMemRecViewEh;
    MemRec: TMemoryRecordEh;
    Values: TFBRecBufValues;
    UseMemRec: Boolean;
    NeedUpdateCalcFields: Boolean;
    function GetValue(Field: TField): Variant;
    function GetOldValue(Field: TField): Variant;
    function ReadValueCount: Integer;
    procedure SetValue(Field: TField; v: Variant);
    procedure SetLength(Len: Integer);
    procedure Clear;
    destructor Destroy; override;
    property Value[Field: TField]: Variant read GetValue write SetValue;
    property OldValue[Field: TField]: Variant read GetOldValue;

    property ValueCount: Integer read ReadValueCount;
  end;

{ TSortedVarItemEh }

  TSortedVarItemEh = class (TObject)
  protected
    Value:Variant;
  public
    constructor Create(NewValue:variant);
  end;

{ TSortedVarlistEh }

  TSortedVarlistEh = class(TObjectListEh)
  protected
    function  VarInList(Value: Variant):boolean;
    function  FindValueIndex(Value: Variant; var Index: Integer):boolean;
  public
    function Add(AObject: TSortedVarItemEh): IntegerD12;
    procedure Insert(Index: IntegerD12; AObject: TSortedVarItemEh);
  end;

{ TMemTableFilterItemEh }

  TMemTableFilterItemEh = class(TCollectionItem)
  private
    FFilterExpr: TDataSetExprParserEh;
    FActive: Boolean;
    FFilter: String;
    FOnFilterRecord: TFilterRecordEvent;
    procedure SetActive(Value: Boolean);
    procedure SetFilter(const Value: String);
    procedure SetOnFilterRecord(Value: TFilterRecordEvent);
  public
    constructor Create(Collection: TCollection); overload; override;
    destructor Destroy; override;
    function MemTableFilters: TMemTableFiltersEh;
    function Filtered: Boolean;
    function IsCurRecordInFilter(Rec: TMemoryRecordEh): Boolean;
    procedure RecreateFilterExpr;
    procedure FilterProcChanged;
    property Active: Boolean read FActive write SetActive;
    property Filter: String read FFilter write SetFilter;
    property OnFilterRecord: TFilterRecordEvent read FOnFilterRecord write SetOnFilterRecord;
  end;

  TMemTableFilterItemEhClass = class of TMemTableFilterItemEh;

{ TMemTableFiltersEh }

  TMemTableFiltersEh = class(TCollection)
  private
    FOnChanged: TNotifyEvent;
    FActiveFilterItems: TObjectListEh;
    function GetFilterItem(Index: Integer): TMemTableFilterItemEh;
    procedure SetFilterItem(Index: Integer; Value: TMemTableFilterItemEh);
    function GetActiveFilterCount: Integer;
    function GetActiveFilterItem(Index: Integer): TMemTableFilterItemEh;
  protected
    FMemTable: TCustomMemTableEh;
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(AMemTable: TCustomMemTableEh; FilterItemClass: TMemTableFilterItemEhClass);
    destructor Destroy; override;
    procedure RecreateFilterExpr;
    function HasTextActiveFilter: Boolean;
    function HasEventActiveFilter: Boolean;
    function Add: TMemTableFilterItemEh;
    function IndexOfFilter(FilterItem: TMemTableFilterItemEh): Integer;
    function IsCurRecordInFilter(Rec: TMemoryRecordEh): Boolean;
    property Items[Index: Integer]: TMemTableFilterItemEh read GetFilterItem write SetFilterItem; default;
    property OnChanged: TNotifyEvent read FOnChanged write FOnChanged;
    property MemTable: TCustomMemTableEh read FMemTable;
    property ActiveFilterCount: Integer read GetActiveFilterCount;
    property ActiveFilterItem[Index: Integer]: TMemTableFilterItemEh read GetActiveFilterItem;
  end;

{ TCustomMemTableEh }

  TMemTableOptionEh = (mtoPersistentStructEh, mtoTextFieldsCaseInsensitive);
  TMemTableOptionsEh = set of TMemTableOptionEh;

  TCustomMemTableEh = class(TDataSet, IMemTableEh, IUnknown)
  private
    FStateInsert: Boolean;
    FStateInsertRowNum: Integer;
    FEventReceivers: TObjectListEh;
    FRecordCache: TObjectList;
    FActive: Boolean;
    FAutoInc: Longint;
    FCalcFieldIndexes: array of Integer;
    FDataDriver: TDataDriverEh;
    FDataSetReader: TDataSet;
    FDetailFieldList: TFieldListEh;
    FDetailFields: String;
    FDetailMode: Boolean;
    FFetchAllOnOpen: Boolean;
    FFilterExpr: TDataSetExprParserEh;
{$IFDEF EH_LIB_17}
{$IFDEF NEXTGEN}
   FInstantBuffers: TList<TRecBuf>;
{$ELSE}
   FInstantBuffers: TList<TRecordBuffer>;
{$ENDIF}
{$ELSE}
    FInstantBuffers: TObjectListEh;
{$ENDIF}
    FInstantReadCurRowNum: Integer;
    FMasterDetailSide: TMasterDetailSideEh;
    FMasterValues: Variant;
    FOnTreeNodeExpanding: TMTTreeNodeExpandingEventEh;
    FOnRecordsViewTreeNodeExpanding: TRecordsViewTreeNodeExpandingEventEh;
    FOnRecordsViewTreeNodeExpanded: TRecordsViewTreeNodeExpandedEventEh;
    FOnRecordsViewTreeNodeCollapsed: TRecordsViewTreeNodeExpandedEventEh;
    FOnRecordsViewCheckMoveNode: TRecordsViewCheckMoveNodeEventEh;
    FParams: TParams;
    FReadOnly: Boolean;
    FRecBufSize: Integer;
    FRecordPos: Integer;
    FRecordsView: TRecordsViewEh;
    FTreeList: TMemTableTreeListEh;
    FIndexDefs: TIndexDefs;
    FStoreDefs: Boolean;
    FDetailRecList: TObjectListEh;
    FDetailRecListActive: Boolean;
    FInternMemTableData: TMemTableDataEh;
    FExternalMemData: TCustomMemTableEh;
    FRecordsViewUpdating: Integer;
    FRecordsViewUpdated: Boolean;
    FMasterValList: TSortedVarlistEh;
    FSortOrder: String;
    FOnGetFieldValue: TMemTableChangeFieldValueEventEh;
    FOnSetFieldValue: TMemTableChangeFieldValueEventEh;
    FMTViewDataEventInactiveCount: Integer;
    FInactiveEventRowNum: Integer;
    FInactiveEvent: TMTViewEventTypeEh;
    FInactiveEventOldRowNum: Integer;
    FOldControlsDisabled: Boolean;
    FOldActive: Boolean;
    FOptions: TMemTableOptionsEh;
    FExtraFilters: TMemTableFiltersEh;
{$IFDEF CIL}
    FCalcBuffer: TRecordBuffer;
{$ELSE}
{$IFDEF EH_LIB_12}
    FCalcBuffer: {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF};
{$ELSE}
    FCalcBuffer: PChar;
{$ENDIF}
{$ENDIF}
    procedure BeginRecordsViewUpdate;
    procedure EndRecordsViewUpdate(AutoResync: Boolean);
    function GetAggregatesActive: Boolean;
    function GetAutoIncrement: TAutoIncrementEh;
    function GetCachedUpdates: Boolean;
    function GetDataFieldsCount: Integer;
    function GetInstantReadCurRowNum: Integer;
    function GetMasterFields: String;
    function GetMasterSource: TDataSource;
    function GetTreeNode: TMemRecViewEh;
    function GetTreeNodeChildCount: Integer;
    function GetTreeNodeHasChildren: Boolean;
    function GetTreeNodeHasVisibleChildren: Boolean;
    function GetUpdateError: TUpdateErrorEh;
    function GetIndexDefs: TIndexDefs;
{$IFDEF CIL}
    function GetInstantBuffer: TRecordBuffer;
{$ELSE}
{$IFDEF EH_LIB_12}
    function GetInstantBuffer: {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF};
{$ELSE}
    function GetInstantBuffer: PChar;
{$ENDIF}
{$ENDIF}
    function IsRecordInFilter(Rec: TMemoryRecordEh; Node: TMemRecViewEh): Boolean;
    procedure AncestorNotFound(Reader: TReader; const ComponentName: string; ComponentClass: TPersistentClass; var Component: TComponent);
    procedure ClearRecords;
    procedure CreateComponent(Reader: TReader; ComponentClass: TComponentClass; var Component: TComponent);
    procedure InitBufferPointers(GetProps: Boolean);
    procedure RefreshParams;
    {$IFDEF FPC}
    {$ELSE}
    procedure SetAggregatesActive(const Value: Boolean);
    {$ENDIF}
    procedure SetAutoIncrement(const Value: TAutoIncrementEh);
    procedure SetCachedUpdates(const Value: Boolean);
    procedure SetDataDriver(const Value: TDataDriverEh);
    procedure SetDetailFields(const Value: String);
    procedure SetExternalMemData(Value: TCustomMemTableEh);
    procedure SetMasterDetailSide(const Value: TMasterDetailSideEh);
    procedure SetMasterFields(const Value: String);
    procedure SetMasterSource(const Value: TDataSource);
    procedure SetParams(const Value: TParams);
    procedure SetParamsFromCursor;
    procedure SetTreeNodeExpanded(const Value: Boolean);
    procedure SetTreeNodeHasVisibleChildren(const Value: Boolean);
    procedure SetIndexDefs(Value: TIndexDefs);
    procedure SortData(ParamSort: TObject);
    function GetSortOrder: String;
    procedure SetSortOrder(const Value: String);
    function GetStatusFilter: TUpdateStatusSet;
    procedure SetStatusFilter(const Value: TUpdateStatusSet);
    procedure SetReadOnly(const Value: Boolean);
    procedure SetOptions(const Value: TMemTableOptionsEh);
    procedure SetExtraFilters(const Value: TMemTableFiltersEh);
    procedure WinProg(var Message: TMessage);

  protected
    { IProviderSupport }
    function PSGetIndexDefs(IndexTypes: TIndexOptions): TIndexDefs; override;
    function PSGetKeyFields: string; override;
    { IMemTableEh }
    function GetLikeWildcardForOneCharacter: String;
    function GetLikeWildcardForSeveralCharacters: String;

    procedure FilterAbort;

  protected
    FInstantReadMode: Boolean;
    FMasterDataLink: TMasterDataLinkEh;
    FAutoIncrementFieldName: String;
    FInLoaded: Boolean;
    FWinControl: TWinControl;
    FWndMethod: TWndMethod;
    FGetOrderVarValueProc: TGetOrderVarValueProcEh;
    FSortingValues: TVariantArrayEh;

    function GetActiveRecBuf(var RecBuf: TMTRecBuf; IsForWrite: Boolean = False): Boolean; virtual;
    function GetTreeNodeHasChields: Boolean;
    function GetTreeNodeLevel: Integer;
    function GetRecObject: TObject;
    function GetPrevVisibleTreeNodeLevel: Integer;
    function GetNextVisibleTreeNodeLevel: Integer;
    function IsInOperatorSupported: Boolean;
    function MemTableIsTreeList: Boolean;
    function ParentHasNextSibling(ParenLevel: Integer): Boolean;
    function ParentHasPriorSibling(ParenLevel: Integer): Boolean;
    function IMemTableGetTreeNodeExpanded(RowNum: Integer): Boolean;
    function GetTreeNodeExpanded(RowNum: Integer): Boolean; overload;
    function GetTreeNodeExpanded: Boolean; overload;
    function GetTreeNodeExpandedProp: Boolean;
    function IMemTableSetTreeNodeExpanded(RowNum: Integer; Value: Boolean): Integer;
    function IMemTableEh.SetTreeNodeExpanded = IMemTableSetTreeNodeExpanded;
    function GetFieldValueList(const AFieldName: String): IMemTableDataFieldValueListEh;
    function ApplyExtraFilter(const FilterStr: String; FilterProc: TFilterRecordEvent): TObject;
    function RevokeExtraFilter(FilterObject: TObject): Boolean;
    function ResetExtraFilter(FilterObject: TObject; const FilterStr: String; FilterProc: TFilterRecordEvent): Boolean;

    procedure FixBookmarkDataCache({$IFDEF CIL}const{$ENDIF} Bookmark: TBookmark);
    procedure RecreateFilterExpr;
    procedure DestroyFilterExpr;
{$IFDEF CIL}
    procedure CalculateFields(Buffer: TRecordBuffer); override;
{$ELSE}

  {$IFDEF EH_LIB_12}
    {$IFDEF EH_LIB_17}
    procedure CalculateFields(Buffer:{$IFDEF NEXTGEN}NativeInt{$ELSE}PByte{$ENDIF}); override;
    {$ELSE}
    procedure CalculateFields(Buffer: TRecordBuffer); override;
    {$ENDIF}
    procedure RefreshInternalCalcFields(Buffer: {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}); override;
  {$ELSE}
    procedure CalculateFields(Buffer: PChar); override;
    procedure RefreshInternalCalcFields(Buffer: PChar); override;
  {$ENDIF}
{$ENDIF}

{$IFDEF EH_LIB_12}
  {$IFDEF NEXTGEN}
    function AllocRecBuf: TRecBuf; override;
    procedure FreeRecBuf(var Buffer: TRecBuf); override;
  {$ELSE}
    function AllocRecordBuffer: TRecordBuffer; override;
    procedure FreeRecordBuffer(var Buffer: TRecordBuffer); override;
  {$ENDIF}
{$ELSE}
    function AllocRecordBuffer: {$IFDEF CIL}TRecordBuffer{$ELSE}PChar{$ENDIF}; override;
{$ENDIF}
    function CompareRecords(Rec1, Rec2: TMemoryRecordEh; ParamSort: TObject): Integer; virtual;
    function CompareTreeNodes(Rec1, Rec2: TBaseTreeNodeEh; ParamSort: TObject): Integer; virtual;
    function CreateDeltaDataSet: TCustomMemTableEh;
    function DoFetchRecords(Count: Integer): Integer;
    function FieldValueToVarValue(FieldBuffer: {$IFDEF CIL}TObject{$ELSE}Pointer{$ENDIF}; Field: TField): Variant;
    function GetBlobData(Field: TField; Buffer: TMTRecBuf): TMemBlobData;
{$IFDEF CIL}
    function BufferToIndex(Buf: TRecordBuffer): Integer;
    function BufferToRecBuf(Buf: TRecordBuffer): TMTRecBuf;
    function IndexToBuffer(I: Integer):TRecordBuffer;
    function GetBookmarkFlag(Buffer: TRecordBuffer): TBookmarkFlag; override;
    function GetRecord(Buffer: TRecordBuffer; GetMode: TGetMode; DoCheck: Boolean): TGetResult; override;
    procedure ClearCalcFields(Buffer: TRecordBuffer); override;
    procedure CopyBuffer(FromBuf, ToBuf: TRecordBuffer);
{$ELSE}
  {$IFDEF EH_LIB_12}

    function BufferToIndex(Buf: {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}): Integer;
    function BufferToRecBuf(Buf: {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}): TMTRecBuf;
    function IndexToBuffer(I: Integer): {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF};
    function GetBookmarkFlag(Buffer: {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}): TBookmarkFlag; override;
    function GetRecord(Buffer: {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}; GetMode: TGetMode; DoCheck: Boolean): TGetResult; override;

    {$IFDEF EH_LIB_17}
    procedure ClearCalcFields(Buffer: {$IFDEF NEXTGEN}NativeInt{$ELSE}PByte{$ENDIF}); override;
    {$ELSE}
    procedure ClearCalcFields(Buffer: TRecordBuffer); override;
    {$ENDIF}
    procedure CopyBuffer(FromBuf, ToBuf: {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF});
  {$ELSE}
    function BufferToIndex(Buf: PChar): Integer;
    function BufferToRecBuf(Buf: PChar): TMTRecBuf;
    function IndexToBuffer(I: Integer): PChar;
    function GetBookmarkFlag(Buffer: PChar): TBookmarkFlag; override;
    function GetRecord(Buffer: PChar; GetMode: TGetMode; DoCheck: Boolean): TGetResult; override;
    procedure ClearCalcFields(Buffer: PChar); override;
    procedure CopyBuffer(FromBuf, ToBuf: PChar);
  {$ENDIF}
{$ENDIF}
{$IFDEF FPC}
{$ELSE}
    function GetAggregateValue(Field: TField): Variant; override;
    procedure DefChanged(Sender: TObject); override;
    procedure ResetAggField(Field: TField); override;
{$ENDIF}
    function GetDataSource: TDataSource; override;
{$IFDEF NEXTGEN}
{$ELSE}
    function GetBookmarkStr: TBookmarkStr; override;
{$ENDIF}
    function GetCanModify: Boolean; override;
    function GetFieldClass(FieldType: TFieldType): TFieldClass; override;
    function GetRecNo: Integer; override;
    function GetRecordCount: Integer; override;
    function GetRecordSize: Word; override;
    function GetRec: TMemoryRecordEh;
    function GetRecView: TMemRecViewEh;
    function IndexOfBookmark(Bookmark: TBookmark): Integer;
    function IsCursorOpen: Boolean; override;
    function InternalApplyUpdates(AMemTableData: TMemTableDataEh; MaxErrors: Integer): Integer; virtual;
    function ParseOrderByStr(const OrderByStr: String): TObject;
    function SetToRec(Rec: TObject): Boolean;
    function CreateMemTableData: TMemTableDataEh; virtual;

    procedure BindFields(Binding: Boolean); {$IFDEF EH_LIB_12} override; {$ENDIF}
    procedure BindCalFields;
    procedure CloseBlob(Field: TField); override;
    procedure CreateFields; override;
    procedure CreateIndexesFromDefs; virtual;
{$IFDEF CIL}
    procedure DefChanged(Sender: TObject); override;
    procedure FetchRecord(DataSet: TDataSet);
    procedure FreeRecordBuffer(var Buffer: TRecordBuffer); override;
    procedure GetBookmarkData(Buffer: TRecordBuffer; var Bookmark: TBookmark); override;
    procedure InitRecord(Buffer: TRecordBuffer); override;
    procedure InternalAddRecord(Buffer: TRecordBuffer; Append: Boolean); override;
    procedure InternalGotoBookmark(const Bookmark: TBookmark); override;
    procedure InternalInitRecord(Buffer: TRecordBuffer); override;
    procedure InternalSetToRecord(Buffer: TRecordBuffer); override;
    procedure RecordToBuffer(MemRec: TMemoryRecordEh; DataValueVersion: TDataValueVersionEh; Buffer: TRecordBuffer; RecIndex: Integer);
    procedure SetBookmarkData(Buffer: TRecordBuffer; const Bookmark: TBookmark); override;
    procedure SetBookmarkFlag(Buffer: TRecordBuffer; Value: TBookmarkFlag); override;
    procedure SetFieldData(Field: TField; Buffer: TValueBuffer); override;
    procedure SetFieldData(Field: TField; Buffer: TValueBuffer; NativeFormat: Boolean); override;
    procedure SetMemoryRecordData(Buffer: TRecordBuffer; Rec: TMemoryRecordEh); virtual;
    procedure SetRecViewLookupBuffer(Buffer: TRecordBuffer; RecView: TMemRecViewEh);
    procedure VarValueToFieldValue(VarValue: Variant; FieldBuffer: TObject; Field: TField);
{$ELSE}
  {$IFDEF EH_LIB_12}
    {$IFDEF EH_LIB_17}
    procedure GetBookmarkData(Buffer: {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}; Data: TBookmark); override;
    {$ELSE}
    procedure GetBookmarkData(Buffer: TRecordBuffer; Data: Pointer); override;
    {$ENDIF}
    procedure InitRecord(Buffer: {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}); override;
    {$IFDEF EH_LIB_17}
    procedure InternalGotoBookmark(Bookmark: TBookmark); override;
    {$ELSE}
    procedure InternalGotoBookmark(Bookmark: Pointer); override;
    {$ENDIF}
    procedure InternalInitRecord(Buffer: {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}); override;
    procedure InternalSetToRecord(Buffer: {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}); override;
    procedure RecordToBuffer(MemRec: TMemoryRecordEh; DataValueVersion: TDataValueVersionEh; Buffer: {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}; RecIndex: Integer);
    {$IFDEF EH_LIB_17}
    procedure SetBookmarkData(Buffer: {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}; Data: TBookmark); override;
    {$ELSE}
    procedure SetBookmarkData(Buffer: {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}; Data: Pointer); override;
    {$ENDIF}
    procedure SetBookmarkFlag(Buffer: {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}; Value: TBookmarkFlag); override;
    procedure SetMemoryRecordData(Buffer: {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}; Rec: TMemoryRecordEh); virtual;
    procedure SetRecViewLookupBuffer(Buffer: {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}; RecView: TMemRecViewEh);
 {$ELSE} 
    procedure FreeRecordBuffer(var Buffer: PChar); override;
    procedure GetBookmarkData(Buffer: PChar; Data: Pointer); override;
    procedure InitRecord(Buffer: PChar); override;
    {$IFDEF FPC}
    procedure InternalGotoBookmark(Bookmark: Pointer); override;
    {$ELSE}
    procedure InternalGotoBookmark(Bookmark: TBookmark); override;
    {$ENDIF}
    procedure InternalInitRecord(Buffer: PChar); override;
    procedure InternalSetToRecord(Buffer: PChar); override;
    procedure RecordToBuffer(MemRec: TMemoryRecordEh; DataValueVersion: TDataValueVersionEh; Buffer: PChar; RecIndex: Integer);
    procedure SetBookmarkData(Buffer: PChar; Data: Pointer); override;
    procedure SetBookmarkFlag(Buffer: PChar; Value: TBookmarkFlag); override;
    procedure SetMemoryRecordData(Buffer: PChar; Rec: TMemoryRecordEh); virtual;
    procedure SetRecViewLookupBuffer(Buffer: PChar; RecView: TMemRecViewEh);
  {$ENDIF} 
    procedure DataEvent(Event: TDataEvent; Info: TDataEventInfoTypeEh); override;
    procedure FetchRecord(DataSet: TDataSet);
  {$IFDEF EH_LIB_17}
    procedure InternalAddRecord(Buffer: {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}; Append: Boolean); override;
    procedure SetFieldData(Field: TField; Buffer: TValueBuffer); override;
    procedure SetFieldData(Field: TField; Buffer: TValueBuffer; NativeFormat: Boolean); override;
    {$IFNDEF NEXTGEN}
    procedure SetFieldData(Field: TField; Buffer: Pointer); overload; override; deprecated 'Use overloaded method instead';
    procedure SetFieldData(Field: TField; Buffer: Pointer; NativeFormat: Boolean); overload; override; deprecated 'Use overloaded method instead';
    {$ENDIF !NEXTGEN}
  {$ELSE}
    procedure InternalAddRecord(Buffer: Pointer; Append: Boolean); override;
    {$IFDEF FPC}
  public
    procedure SetFieldData(Field: TField; Buffer: Pointer); override;
    procedure SetFieldData(Field: TField; Buffer: Pointer; NativeFormat: Boolean); override;
  protected
    {$ELSE}
    procedure SetFieldData(Field: TField; Buffer: Pointer); override;
    procedure SetFieldData(Field: TField; Buffer: Pointer; NativeFormat: Boolean); override;
    {$ENDIF}

  {$ENDIF} 
    procedure VarValueToFieldValue(VarValue: Variant; FieldBuffer: Pointer; Field: TField);
{$ENDIF} 
    procedure DoOnNewRecord; override;
    procedure DoOrderBy(const OrderByStr: String); virtual;
    procedure ReadState(Reader: TReader); override;
    procedure SetExtraStructParams;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;

    function FindRecord(Restart, GoForward: Boolean): Boolean; override;
    function ViewRecordIndexToViewRowNum(ViewRecordIndex: Integer): Integer;
    function GetPrefilteredList: TObjectList;
    function TreeViewNodeExpanding(Sender: TBaseTreeNodeEh): Boolean;

    procedure BookmarkToBookmarkData(Bookmark: TBookmark; var BookmarkData: TBookmarkDataEh);
    procedure CalcInternalFieldProg(MemRec: TMemoryRecordEh; var FieldValues: TVariantArrayEh);
    procedure InitFieldDefs; override;
    procedure InitFieldDefsFromFields;
    procedure InternalCancel; override;
    procedure InternalClose; override;
    procedure InternalDelete; override;
    procedure InternalEdit; override;
    procedure InternalFirst; override;
    procedure InternalGotoBookmarkData(var BookmarkData: TBookmarkDataEh);
    procedure InternalHandleException; override;
    procedure InternalInitFieldDefs; override;
    procedure InternalInsert; override;
    procedure InternalLast; override;
    procedure InternalOpen; override;
    procedure InternalPost; override;
    procedure InternalRefresh; override;
    procedure InternalRefreshFilter; virtual;
    procedure Loaded; override;
    procedure MasterChange(Sender: TObject);
    procedure MTApplyUpdates(AMemTableData: TMemTableDataEh);
    procedure MTCalcLookupBuffer(Item: TMemoryRecordEh; RecView: TMemRecViewEh);
    procedure MTStructChanged(AMemTableData: TMemTableDataEh);
    procedure MTViewDataEvent(RowNum: Integer; Event: TMTViewEventTypeEh; OldRowNum: Integer); virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure OpenCursor(InfoQuery: Boolean); override;
    procedure RegisterEventReceiver(AComponent: TPersistent);
    procedure SetActive(Value: Boolean); override;
    procedure SetBlobData(Field: TField; Buffer: TMTRecBuf; Value: TMemBlobData);
    procedure SetFiltered(Value: Boolean); override;
    procedure SetOnFilterRecord(const Value: TFilterRecordEvent); override;
    procedure SetRecNo(Value: Integer); override;
    procedure TreeViewNodeExpanded(Sender: TBaseTreeNodeEh);
    procedure UnregisterEventReceiver(AComponent: TPersistent);
    procedure UpdateDesigner;
    procedure UpdateDetailMode(AutoRefresh: Boolean);
    procedure UpdateIndexDefs; override;
    procedure UpdateSortOrder; virtual;
    procedure ViewDataEvent(MemRec: TMemoryRecordEh; Index: Integer; Action: TRecordsListNotification);
    procedure ViewRecordMovedEvent(MemRec: TMemoryRecordEh; OldIndex, NewIndex: Integer);
    {$IFDEF FPC}
    {$ELSE}
    property AggregatesActive: Boolean read GetAggregatesActive write SetAggregatesActive default False;
    {$ENDIF}
    property DataFieldsCount: Integer read GetDataFieldsCount;
{$IFDEF CIL}
    property InstantBuffer: TRecordBuffer read GetInstantBuffer;
{$ELSE}
 {$IFDEF EH_LIB_12}
    property InstantBuffer: {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF} read GetInstantBuffer;
    property CalcBuffer: {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF} read FCalcBuffer;
 {$ELSE}
    property InstantBuffer: PChar read GetInstantBuffer;
    property CalcBuffer: PChar read FCalcBuffer;
 {$ENDIF}
{$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function ApplyUpdates(MaxErrors: Integer): Integer; virtual;
    function BookmarkToRec(Bookmark: TUniBookmarkEh): TMemoryRecordEh;
    function RecToBookmark(Rec: TMemoryRecordEh): TUniBookmarkEh;

    function BookmarkValid({$IFDEF CIL}const{$ENDIF} Bookmark: TBookmark): Boolean; override;

    {$IFDEF NEXTGEN}
    {$ELSE}
    function BookmarkStrValid({$IFDEF CIL}const{$ENDIF} Bookmark: TBookmarkStr): Boolean;
    function BookmarkStrToRecNo(Bookmark: TBookmarkStr): Integer;
    {$ENDIF}

    function BookmarkToRecNo(Bookmark: TBookmark): Integer;
    function UniBookmarkToRecNo(Bookmark: TUniBookmarkEh): Integer;

    function UniBookmarkValid(Bookmark: TUniBookmarkEh): Boolean;
    function BookmarkInVisibleView({$IFDEF CIL}const{$ENDIF} Bookmark: TUniBookmarkEh): Boolean;
{$IFDEF EH_LIB_12}
{$ELSE}
{$ENDIF}
    function CompareBookmarks({$IFDEF CIL}const{$ENDIF} Bookmark1, Bookmark2: TBookmark): Integer; override;
{$IFDEF EH_LIB_12}
    function GetCurrentRecord(Buffer: {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}): Boolean; override;
{$ELSE}
    function GetCurrentRecord(Buffer: {$IFDEF CIL}TRecordBuffer{$ELSE}PChar{$ENDIF}): Boolean; override;
{$ENDIF}
    function GetBookmark: TBookmark; override;
{$IFDEF EH_LIB_17}
 {$IFDEF EH_LIB_18}
    function GetFieldData(Field: TField; var Buffer: TValueBuffer): Boolean; override;
    function GetFieldData(FieldNo: Integer; var Buffer: TValueBuffer): Boolean; override;
    function GetFieldData(Field: TField; var Buffer: TValueBuffer; NativeFormat: Boolean): Boolean; override;
 {$ELSE}
    function GetFieldData(Field: TField; Buffer: TValueBuffer): Boolean; override;
    function GetFieldData(FieldNo: Integer; Buffer: TValueBuffer): Boolean; override;
    function GetFieldData(Field: TField; Buffer: TValueBuffer; NativeFormat: Boolean): Boolean; override;
 {$ENDIF}
    procedure VarValueToValueBuffer(Field: TField; var Value: Variant; Buffer: TValueBuffer; NativeFormat: Boolean);
{$ENDIF}

    {$IFDEF NEXTGEN}
    {$ELSE}
    function GetFieldData(Field: TField; Buffer: {$IFDEF CIL}TRecordBuffer{$ELSE}Pointer{$ENDIF}): Boolean; override;
    function GetFieldData(Field: TField; Buffer: {$IFDEF CIL}TRecordBuffer{$ELSE}Pointer{$ENDIF}; NativeFormat: Boolean): Boolean; override;
    procedure VarValueToPointerBuffer(Field: TField; var Value: Variant; Buffer: {$IFDEF CIL}TRecordBuffer{$ELSE}Pointer{$ENDIF}; NativeFormat: Boolean);
    {$ENDIF}

    {$IFDEF FPC}
    {$ELSE}
    {$ENDIF}

    function GetFieldDataAsObject(Field: TField; var Value: TObject): Boolean; virtual;
    function GetFieldValue(Field: TField; var Value: Variant): Boolean; virtual;
    function GetFieldDisplayText(Field: TField): String; virtual;
{$IFDEF CIL}
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
{$ENDIF}
    function GotoRec(Rec: TMemoryRecordEh): Boolean;
    function CreateBlobStream(Field: TField; Mode: TBlobStreamMode): TStream; override;
    function DefaultLoadFromDataSet(Source: TDataSet; RecordCount: Integer; Mode: TLoadMode; UseCachedUpdates: Boolean): Integer;
    function FetchRecords(Count: Integer): Integer;
    function FindRec(const KeyFields: string; const KeyValues: Variant; Options: TLocateOptions; StartRecIndex: Integer = 0; TryUseIndex: Boolean = True): Integer;
    function InstantReadIndexOfBookmark(Bookmark: TUniBookmarkEh): Integer;
    function InstantReadRowCount: Integer;
    function InstantReadViewRow: Integer;
    function IsSequenced: Boolean; override;
    function HasCachedChanges: Boolean;
    function LoadFromDataSet(Source: TDataSet; RecordCount: Integer; Mode: TLoadMode; UseCachedUpdates: Boolean): Integer;
    function LoadFromMemTableEh(Source: TCustomMemTableEh; RecordCount: Integer; Mode: TLoadMode; LoadOptions: TMemTableLoadOptionsEh): Integer;
    function Locate(const KeyFields: string; const KeyValues: Variant; Options: TLocateOptions): Boolean; override;
    function Lookup(const KeyFields: string; const KeyValues: Variant; const ResultFields: string): Variant; override;
    function LookupAll(const KeyFields: string; const KeyValues: Variant; const ResultFields: string; Options: TLocateOptions): Variant;
    function SaveToDataSet(Dest: TDataSet; RecordCount: Integer): Integer;
    function UpdateStatus: TUpdateStatus; override;
    function MoveRecord(FromIndex, ToIndex: Longint; TreeLevel: Integer; CheckOnly: Boolean): Boolean;
    function MoveRecords(BookmarkList: TBMListEh; ToRecNo: Longint; TreeLevel: Integer; CheckOnly: Boolean): Boolean;
    function CalcLookupValue(AField: TField):Variant;
    procedure CancelUpdates;
    procedure CheckFieldDataVarValue(Field: TField; var VarValue: Variant);
    procedure CopyStructure(Source: TDataSet);
    procedure CreateDataSet;
    procedure DriverStructChanged;
    procedure DestroyTable;
    procedure EmptyTable;
    procedure FetchParams;
    procedure GetAggregatedValuesForRange(FromBM, ToBM: TUniBookmarkEh; const FieldName: String; var ResultArr: TAggrResultArr; AggrFuncs: TAggrFunctionsEh);
    procedure InstantReadEnter(RowNum: Integer); overload;
    procedure InstantReadEnter(RecView: TMemRecViewEh; RowNum: Integer); overload;
    procedure InstantReadEnter(MemRec: TMemoryRecordEh; RowNum: Integer); overload;
    procedure InstantReadLeave;
    procedure MergeChangeLog;
    procedure MTDisableControls;
    procedure MTEnableControls(ForceUpdateState: Boolean);
    procedure RefreshRecord;
    procedure Resync(Mode: TResyncMode); override;
    procedure RevertRecord;
    procedure SetFieldDataAsObject(Field: TField; Value: TObject); virtual;
    procedure SetFilterText(const Value: string); override;
    procedure SortByFields(const SortByStr: string);
    procedure SortWithExternalProc(OrderValueProc: TGetOrderVarValueProcEh; DescDirections: TExternalSortDataArrEh);

    procedure SaveToFile(const FileName: string = ''; Format: TDfmStreamFormatEh = dfmTextEh);
    procedure LoadFromFile(const FileName: string = '');
    procedure SaveToStream(Stream: TStream; Format: TDfmStreamFormatEh = dfmTextEh);
    procedure LoadFromStream(Stream: TStream);

    property AutoIncrement: TAutoIncrementEh read GetAutoIncrement write SetAutoIncrement;
    property CachedUpdates: Boolean read GetCachedUpdates write SetCachedUpdates default False;
    property DataDriver: TDataDriverEh read FDataDriver write SetDataDriver;
    property DetailFields: String read FDetailFields write SetDetailFields;
    property ExtraFilters: TMemTableFiltersEh read FExtraFilters write SetExtraFilters;
    property ExternalMemData: TCustomMemTableEh read FExternalMemData write SetExternalMemData;
    property FetchAllOnOpen: Boolean read FFetchAllOnOpen write FFetchAllOnOpen default False;
    property FieldDefs stored FStoreDefs;
    property IndexDefs: TIndexDefs read GetIndexDefs write SetIndexDefs stored FStoreDefs;
    property InstantReadCurRow: Integer read GetInstantReadCurRowNum;
    property MasterDetailSide: TMasterDetailSideEh read FMasterDetailSide write SetMasterDetailSide default mdsOnSelfEh;
    property MasterFields: String read GetMasterFields write SetMasterFields;
    property MasterSource: TDataSource read GetMasterSource write SetMasterSource;
    property Options: TMemTableOptionsEh read FOptions write SetOptions default [];
    property Params: TParams read FParams write SetParams;
    property ReadOnly: Boolean read FReadOnly write SetReadOnly default False;
    property Rec: TMemoryRecordEh read GetRec;
    property RecView: TMemRecViewEh read GetRecView;
    property RecordsView: TRecordsViewEh read FRecordsView;
    property SortOrder: String read GetSortOrder write SetSortOrder;
    property StatusFilter: TUpdateStatusSet read GetStatusFilter write SetStatusFilter default [usUnmodified, usModified, usInserted];
    property StoreDefs: Boolean read FStoreDefs write FStoreDefs default False;
    property TreeList: TMemTableTreeListEh read FTreeList write FTreeList;
    property TreeNode: TMemRecViewEh read GetTreeNode;
    property TreeNodeChildCount: Integer read GetTreeNodeChildCount;
    property TreeNodeExpanded: Boolean read GetTreeNodeExpandedProp write SetTreeNodeExpanded;
    property TreeNodeHasChildren: Boolean read GetTreeNodeHasChildren{ write SetTreeNodeHasChildren};
    property TreeNodeHasVisibleChildren: Boolean read GetTreeNodeHasVisibleChildren write SetTreeNodeHasVisibleChildren;
    property TreeNodeLevel: Integer read GetTreeNodeLevel;
    property UpdateError: TUpdateErrorEh read GetUpdateError;

    property OnTreeNodeExpanding: TMTTreeNodeExpandingEventEh read FOnTreeNodeExpanding write FOnTreeNodeExpanding;
    property OnRecordsViewTreeNodeExpanding: TRecordsViewTreeNodeExpandingEventEh read FOnRecordsViewTreeNodeExpanding write FOnRecordsViewTreeNodeExpanding;
    property OnRecordsViewTreeNodeExpanded: TRecordsViewTreeNodeExpandedEventEh read FOnRecordsViewTreeNodeExpanded write FOnRecordsViewTreeNodeExpanded;
    property OnRecordsViewTreeNodeCollapsed: TRecordsViewTreeNodeExpandedEventEh read FOnRecordsViewTreeNodeCollapsed write FOnRecordsViewTreeNodeCollapsed;
    property OnRecordsViewCheckMoveNode: TRecordsViewCheckMoveNodeEventEh read FOnRecordsViewCheckMoveNode write FOnRecordsViewCheckMoveNode;
    property OnGetFieldValue: TMemTableChangeFieldValueEventEh read FOnGetFieldValue write FOnGetFieldValue;
    property OnSetFieldValue: TMemTableChangeFieldValueEventEh read FOnSetFieldValue write FOnSetFieldValue;
  end;

{ TMemBlobStreamEh }

  TMemBlobStreamEh = class(TMemoryStream)
  private
    FField: TBlobField;
    FDataSet: TCustomMemTableEh;
    FBuffer: TMTRecBuf;
    FFieldNo: Integer;
    FModified: Boolean;
    FData: Variant;
    FFieldData: Variant;
  protected
    procedure ReadBlobData;
{$IFDEF CIL}
    function Realloc(var NewCapacity: Longint): TBytes; override;
{$ELSE}
  {$IFDEF FPC}
    function Realloc(var NewCapacity: PtrInt): Pointer; override;
  {$ELSE}
    {$IFDEF EH_LIB_28}
    function Realloc(var NewCapacity: NativeInt): Pointer; override;
    {$ELSE}
    function Realloc(var NewCapacity: System.Longint): Pointer; override;
  {$ENDIF}
{$ENDIF}
{$ENDIF}
  public
    constructor Create(Field: TBlobField; Mode: TBlobStreamMode);
    destructor Destroy; override;
{$IFDEF CIL}
    function Write(const Buffer: array of Byte; Offset, Count: Longint): Longint; override;
{$ELSE}
    function Write(const Buffer; Count: integerD12): integerD12; override;
{$ENDIF}
    procedure Truncate;
  end;

{ TMemTableEh }

  TMemTableEh = class(TCustomMemTableEh)
  published
    property Active;
    {$IFDEF FPC}
    {$ELSE}
    property AggregatesActive;
    {$ENDIF}
    property AutoCalcFields;
    property AutoIncrement;
    property CachedUpdates;
    property DetailFields;
    property ExternalMemData;
    property FieldDefs;
    property Filter;
    property Filtered;
    property FilterOptions;
    property FetchAllOnOpen;
    property IndexDefs;
    property MasterDetailSide;
    property MasterFields;
    property MasterSource;
    property Params;
    property DataDriver;
    property Options;
    property ReadOnly;
    property SortOrder;
    property StoreDefs;
    property TreeList;

    property BeforeOpen;
    property AfterOpen;
    property BeforeClose;
    property AfterClose;
    property BeforeInsert;
    property AfterInsert;
    property BeforeEdit;
    property AfterEdit;
    property BeforePost;
    property AfterPost;
    property BeforeCancel;
    property AfterCancel;
    property BeforeDelete;
    property AfterDelete;
    property BeforeScroll;
    property AfterScroll;
    property BeforeRefresh;
    property AfterRefresh;
    property OnCalcFields;
    property OnDeleteError;
    property OnEditError;
    property OnFilterRecord;
    property OnNewRecord;
    property OnPostError;
    property OnGetFieldValue;
    property OnSetFieldValue;
    property OnRecordsViewTreeNodeExpanding;
    property OnRecordsViewTreeNodeExpanded;
    property OnRecordsViewTreeNodeCollapsed;
  end;

{ TMemTableDataFieldValueListEh }

  TMemTableDataFieldValueListEh = class(TInterfacedObject, IMemTableDataFieldValueListEh)
  private
    FDataObsoleted: Boolean;
    FDataSet: TDataSet;
    FFieldName: String;
    FFilter: String;
    FFilterExpr: TDataSetExprParserEh;
    FNotificator: TRecordsListNotificatorEh;
    FValues: TStringList;
    FVarValues: TVariantArrayEh;

    function GetDataObject: TComponent;
    function GetValues: TStrings;

    procedure SetDataObject(const Value: TComponent);
    procedure SetFieldName(const Value: String);

  protected
    procedure MTDataEvent(MemRec: TMemoryRecordEh; Index: Integer; Action: TRecordsListNotification);
    procedure RecordListChanged; virtual;
    procedure RefreshValues;
    procedure RefreshVarValues;

  public
    constructor Create(ADataSet: TDataSet);
    destructor Destroy; override;
    procedure SetFilter(const Filter: String);
    property FieldName: String read FFieldName write SetFieldName;
    property DataObject: TComponent read GetDataObject write SetDataObject;
    property Values: TStrings read GetValues;
  end;

{ TRefObjectField }

  TRefObjectField = class(TField)
  protected
    class procedure CheckTypeSize(Value: Integer); override;
    function GetAsVariant: Variant; override;
    function GetValue: TObject;
    procedure SetValue(const Value: TObject);
    procedure SetVarValue(const Value: Variant); override;
  public
    constructor Create(AOwner: TComponent); override;
    property Value: TObject read GetValue write SetValue;
  end;

{ TMTOrderByList }

  TMTOrderByList = class(TOrderByList)
  end;

  procedure AssignRecord(Source, Destinate: TDataSet);

var
  ftSupportedAsStrEh: TFieldTypesEh = [ftUnknown, ftString, ftSmallint, ftInteger, ftWord, ftBoolean, ftFloat,
    ftCurrency, ftDate, ftTime, ftDateTime, ftAutoInc, ftBCD, ftBytes,
    ftVarBytes, ftADT, ftFixedChar, ftWideString,
    ftInterface, ftIDispatch,
    ftLargeint,
    ftGuid, ftTimeStamp, ftFMTBCD
{$IFDEF EH_LIB_10}
    ,ftFixedWideChar, ftWideMemo, ftOraTimeStamp, ftOraInterval
{$ENDIF}
{$IFDEF EH_LIB_12}
    ,ftLongWord, ftShortint, ftByte, TFieldType.ftExtended
{$ENDIF}
    ] +
    [
    ftMemo, ftFmtMemo
    ,ftOraClob
    {$IFDEF EH_LIB_10}, ftWideMemo {$ENDIF}
    {$IFDEF EH_LIB_13}, ftTimeStampOffset, ftSingle {$ENDIF}
    ];

implementation

uses
{$IFDEF FPC}
  DbConst,
{$ELSE}
  DbConsts, SqlTimSt,
{$ENDIF}
  Math, EhLibLangConsts,
  DBUtilsEh,
  FmtBcd,
  TypInfo;

resourcestring
  SMemNoRecords = 'No data found';
{$IFDEF FPC}
  SBcdOverflow = 'BCD overflow';
{$ELSE}
{$ENDIF}


const
  ftBlobTypes = [ftBlob, ftMemo, ftGraphic, ftFmtMemo, ftParadoxOle,
    ftDBaseOle, ftTypedBinary, ftOraBlob, ftOraClob
    {$IFDEF EH_LIB_10}, ftWideMemo {$ENDIF}
    ];

  ftSupported = [ftUnknown, ftString, ftSmallint, ftInteger, ftWord, ftBoolean, ftFloat,
    ftCurrency, ftDate, ftTime, ftDateTime, ftAutoInc, ftBCD, ftBytes,
    ftVarBytes, ftADT, ftFixedChar, ftWideString,
    ftInterface, ftIDispatch,
    ftLargeint, ftVariant, ftGuid
    ,ftTimeStamp, ftFMTBCD
{$IFDEF EH_LIB_10}
    ,ftFixedWideChar, ftWideMemo, ftOraTimeStamp, ftOraInterval
{$ENDIF}
{$IFDEF EH_LIB_12}
    ,ftLongWord, ftShortint, ftByte, TFieldType.ftExtended
{$ENDIF}
{$IFDEF EH_LIB_13}
    ,ftTimeStampOffset, TFieldType.ftSingle
{$ENDIF}
    ] +
    ftBlobTypes;

  fkStoredFields = [fkData, fkInternalCalc];

type
  TMemoryRecordEhCrack = class(TMemoryRecordEh);
  TBMListCrackEh = class(TBMListEh);

procedure Error(const Msg: string);
begin
  DatabaseError(Msg);
end;

procedure ErrorFmt(const Msg: string; const Args: array of const);
begin
  DatabaseErrorFmt(Msg, Args);
end;

procedure IntegerToBytes(Value: Integer; Buffer: TBytes);
begin
 {$IFDEF EH_LIB_22}
  TDBBitConverter.UnsafeFrom<Integer>(Value, Buffer);
 {$ELSE}
 {$IFDEF EH_LIB_17}
  TBitConverter.FromInteger(Value, Buffer);
 {$ELSE}
  Move(Value, Buffer[0], SizeOf(Integer));
 {$ENDIF}
 {$ENDIF}
end;

function BytesToInteger(Buffer: TBytes): Integer;
begin
 {$IFDEF EH_LIB_22}
  Result := TDBBitConverter.UnsafeInto<Integer>(Buffer);
 {$ELSE}
 {$IFDEF EH_LIB_17}
  Result := TBitConverter.ToInteger(Buffer);
 {$ELSE}
  Move(Buffer[0], Result, SizeOf(Integer));
 {$ENDIF}
 {$ENDIF}
end;

procedure CurrencyToBytes(Value: Currency; Buffer: TBytes);
begin
 {$IFDEF EH_LIB_22}
  TDBBitConverter.UnsafeFrom<Currency>(Value, Buffer);
 {$ELSE}
 {$IFDEF EH_LIB_17}
  TBitConverter.FromCurrency(Value, Buffer);
 {$ELSE}
  Move(Value, Buffer[0], SizeOf(Currency));
 {$ENDIF}
 {$ENDIF}
end;

function BytesToCurrency(Buffer: TBytes): Currency;
begin
 {$IFDEF EH_LIB_22}
  Result := TDBBitConverter.UnsafeInto<Currency>(Buffer);
 {$ELSE}
 {$IFDEF EH_LIB_17}
  Result := TBitConverter.ToCurrency(Buffer);
 {$ELSE}
  Move(Buffer[0], Result, SizeOf(Currency));
 {$ENDIF}
 {$ENDIF}
end;

procedure SmallIntToBytes(Value: SmallInt; Buffer: TBytes);
begin
 {$IFDEF EH_LIB_22}
  TDBBitConverter.UnsafeFrom<SmallInt>(Value, Buffer);
 {$ELSE}
 {$IFDEF EH_LIB_17}
  TBitConverter.FromSmallInt(Value, Buffer);
 {$ELSE}
  Move(Value, Buffer[0], SizeOf(SmallInt));
 {$ENDIF}
 {$ENDIF}
end;

function BytesToSmallInt(Buffer: TBytes): SmallInt;
begin
 {$IFDEF EH_LIB_22}
  Result := TDBBitConverter.UnsafeInto<SmallInt>(Buffer);
 {$ELSE}
 {$IFDEF EH_LIB_17}
  Result := TBitConverter.ToSmallInt(Buffer);
 {$ELSE}
  Move(Buffer[0], Result, SizeOf(SmallInt));
 {$ENDIF}
 {$ENDIF}
end;

procedure WordToBytes(Value: Word; Buffer: TBytes);
begin
 {$IFDEF EH_LIB_22}
  TDBBitConverter.UnsafeFrom<Word>(Value, Buffer);
 {$ELSE}
 {$IFDEF EH_LIB_17}
  TBitConverter.FromWord(Value, Buffer);
 {$ELSE}
  Move(Value, Buffer[0], SizeOf(Word));
 {$ENDIF}
 {$ENDIF}
end;

function BytesToWord(Buffer: TBytes): Word;
begin
 {$IFDEF EH_LIB_22}
  Result := TDBBitConverter.UnsafeInto<Word>(Buffer);
 {$ELSE}
 {$IFDEF EH_LIB_17}
  Result := TBitConverter.ToWord(Buffer);
 {$ELSE}
  Move(Buffer[0], Result, SizeOf(Word));
 {$ENDIF}
 {$ENDIF}
end;

procedure DoubleToBytes(Value: Double; Buffer: TBytes);
begin
 {$IFDEF EH_LIB_22}
  TDBBitConverter.UnsafeFrom<Double>(Value, Buffer);
 {$ELSE}
 {$IFDEF EH_LIB_17}
  TBitConverter.FromDouble(Value, Buffer);
 {$ELSE}
  Move(Value, Buffer[0], SizeOf(Double));
 {$ENDIF}
 {$ENDIF}
end;

function BytesToDouble(Buffer: TBytes): Double;
begin
 {$IFDEF EH_LIB_22}
  Result := TDBBitConverter.UnsafeInto<Double>(Buffer);
 {$ELSE}
 {$IFDEF EH_LIB_17}
  Result := TBitConverter.ToDouble(Buffer);
 {$ELSE}
  Move(Buffer[0], Result, SizeOf(Double));
 {$ENDIF}
 {$ENDIF}
end;

procedure WordBoolToBytes(Value: WordBool; Buffer: TBytes);
begin
 {$IFDEF EH_LIB_22}
  TDBBitConverter.UnsafeFrom<WordBool>(Value, Buffer);
 {$ELSE}
 {$IFDEF EH_LIB_17}
  TBitConverter.FromWordBool(Value, Buffer);
 {$ELSE}
  Move(Value, Buffer[0], SizeOf(WordBool));
 {$ENDIF}
 {$ENDIF}
end;

function BytesToWordBool(Buffer: TBytes): WordBool;
begin
 {$IFDEF EH_LIB_22}
  Result := TDBBitConverter.UnsafeInto<WordBool>(Buffer);
 {$ELSE}
 {$IFDEF EH_LIB_17}
  Result := TBitConverter.ToWordBool(Buffer);
 {$ELSE}
  Move(Buffer[0], Result, SizeOf(WordBool));
 {$ENDIF}
 {$ENDIF}
end;

{$IFDEF EH_LIB_17} 
procedure DBBitConverterUnsafeFromVariant(const Value: Variant;
  var B: TArray<Byte>; Offset: Integer);
begin
  FillChar(B[Offset], SizeOf(Variant), 0);
  PVariant(@B[Offset])^ := Value;
end;
{$ENDIF}

procedure VariantToBytes(const Value: Variant; Buffer: TBytes);
begin
{$IFDEF EH_LIB_24} 
  TDBBitConverter.UnsafeFromVariant(Value, Buffer);
{$ELSE}
 {$IFDEF EH_LIB_22}  
  DBBitConverterUnsafeFromVariant(Value, Buffer, 0);
 {$ELSE}
  {$IFDEF EH_LIB_17} 
  DBBitConverterUnsafeFromVariant(Value, Buffer, 0);
  {$ELSE}
  Move(Value, Buffer[0], SizeOf(Variant));
  {$ENDIF}
 {$ENDIF}
{$ENDIF}
end;

{$IFDEF EH_LIB_17} 
function DBBitConverterUnsafeInToVariant(const B: TArray<Byte>; Offset: Integer): Variant;
begin
  Result := PVariant(@B[Offset])^;
  PVariant(@B[Offset])^ := Unassigned;
end;
 {$ENDIF}

function BytesToVariant(Buffer: TBytes): Variant;
begin
 {$IFDEF EH_LIB_24} 
  Result := TDBBitConverter.UnsafeInToVariant(Buffer);
 {$ELSE}
 {$IFDEF EH_LIB_22} 
  Result := DBBitConverterUnsafeInToVariant(Buffer, 0);
 {$ELSE}
 {$IFDEF EH_LIB_17} 
  Result := DBBitConverterUnsafeInToVariant(Buffer, 0);
 {$ELSE}
  Result := Null;
  Move(Buffer[0], Result, SizeOf(Variant));
 {$ENDIF}
 {$ENDIF}
 {$ENDIF}
end;

procedure LargeIntToBytes(Value: LargeInt; Buffer: TBytes);
begin
 {$IFDEF EH_LIB_22}
  TDBBitConverter.UnsafeFrom<LargeInt>(Value, Buffer);
 {$ELSE}
 {$IFDEF EH_LIB_17}
  TBitConverter.FromLargeInt(Value, Buffer);
 {$ELSE}
  Move(Value, Buffer[0], SizeOf(LargeInt));
 {$ENDIF}
 {$ENDIF}
end;

function BytesToLargeInt(Buffer: TBytes): LargeInt;
begin
 {$IFDEF EH_LIB_22}
  Result := TDBBitConverter.UnsafeInto<LargeInt>(Buffer);
 {$ELSE}
 {$IFDEF EH_LIB_17}
  Result := TBitConverter.ToLargeInt(Buffer);
 {$ELSE}
  Move(Buffer[0], Result, SizeOf(LargeInt));
 {$ENDIF}
 {$ENDIF}
end;

{$IFDEF FPC}
{$ELSE}
procedure SQLTimeStampToBytes(const Value: TSQLTimeStamp; Buffer: TBytes);
begin
 {$IFDEF EH_LIB_22}
  TDBBitConverter.UnsafeFrom<TSQLTimeStamp>(Value, Buffer);
 {$ELSE}
 {$IFDEF EH_LIB_17}
  TBitConverter.FromSqlTimeStamp(Value, Buffer);
 {$ELSE}
  Move(Value, Buffer[0], SizeOf(TSQLTimeStamp));
 {$ENDIF}
 {$ENDIF}
end;

function BytesToSQLTimeStamp(Buffer: TBytes): TSQLTimeStamp;
begin
 {$IFDEF EH_LIB_22}
  Result := TDBBitConverter.UnsafeInto<TSQLTimeStamp>(Buffer);
 {$ELSE}
 {$IFDEF EH_LIB_17}
  Result := TBitConverter.ToSQLTimeStamp(Buffer);
 {$ELSE}
  Move(Buffer[0], Result, SizeOf(TSQLTimeStamp));
 {$ENDIF}
 {$ENDIF}
end;

{$IFDEF EH_LIB_13}
procedure SQLTimeStampOffsetToBytes(const Value: TSQLTimeStampOffset; Buffer: TBytes);
begin
 {$IFDEF EH_LIB_22}
  TDBBitConverter.UnsafeFrom<TSQLTimeStampOffset>(Value, Buffer);
 {$ELSE}
 {$IFDEF EH_LIB_17}
  TBitConverter.FromSqlTimeStampOffset(Value, Buffer);
 {$ELSE}
  Move(Value, Buffer[0], SizeOf(TSQLTimeStampOffset));
 {$ENDIF}
 {$ENDIF}
end;

function BytesToSQLTimeStampOffset(Buffer: TBytes): TSQLTimeStampOffset;
begin
 {$IFDEF EH_LIB_22}
  Result := TDBBitConverter.UnsafeInto<TSQLTimeStampOffset>(Buffer);
 {$ELSE}
 {$IFDEF EH_LIB_17}
  Result := TBitConverter.ToSQLTimeStampOffset(Buffer);
 {$ELSE}
  Move(Buffer[0], Result, SizeOf(TSQLTimeStampOffset));
 {$ENDIF}
 {$ENDIF}
end;
{$ENDIF}

{$ENDIF}

procedure BcdToBytes(const Value: TBcd; Buffer: TBytes);
begin
 {$IFDEF EH_LIB_22}
  TDBBitConverter.UnsafeFrom<TBcd>(Value, Buffer);
 {$ELSE}
 {$IFDEF EH_LIB_17}
  TBitConverter.FromBcd(Value, Buffer);
 {$ELSE}
  Move(Value, Buffer[0], SizeOf(TBcd));
 {$ENDIF}
 {$ENDIF}
end;

function BytesToBcd(Buffer: TBytes): TBcd;
begin
 {$IFDEF EH_LIB_22}
  Result := TDBBitConverter.UnsafeInto<TBcd>(Buffer);
 {$ELSE}
 {$IFDEF EH_LIB_17}
  Result := TBitConverter.ToBcd(Buffer);
 {$ELSE}
  Move(Buffer[0], Result, SizeOf(TBcd));
 {$ENDIF}
 {$ENDIF}
end;

procedure LongWordToBytes(const Value: LongWord; Buffer: TBytes);
begin
 {$IFDEF EH_LIB_22}
  TDBBitConverter.UnsafeFrom<LongWord>(Value, Buffer);
 {$ELSE}
 {$IFDEF EH_LIB_17}
  TBitConverter.FromLongWord(Value, Buffer);
 {$ELSE}
  Move(Value, Buffer[0], SizeOf(LongWord));
 {$ENDIF}
 {$ENDIF}
end;

function BytesToLongWord(Buffer: TBytes): LongWord;
begin
 {$IFDEF EH_LIB_22}
  Result := TDBBitConverter.UnsafeInto<LongWord>(Buffer);
 {$ELSE}
 {$IFDEF EH_LIB_17}
  Result := TBitConverter.ToLongWord(Buffer);
 {$ELSE}
  Move(Buffer[0], Result, SizeOf(LongWord));
 {$ENDIF}
 {$ENDIF}
end;

procedure ShortIntToBytes(const Value: ShortInt; Buffer: TBytes);
begin
 {$IFDEF EH_LIB_22}
  TDBBitConverter.UnsafeFrom<ShortInt>(Value, Buffer);
 {$ELSE}
 {$IFDEF EH_LIB_17}
  TBitConverter.FromShortInt(Value, Buffer);
 {$ELSE}
  Move(Value, Buffer[0], SizeOf(ShortInt));
 {$ENDIF}
 {$ENDIF}
end;

function BytesToShortInt(Buffer: TBytes): ShortInt;
begin
 {$IFDEF EH_LIB_22}
  Result := TDBBitConverter.UnsafeInto<ShortInt>(Buffer);
 {$ELSE}
 {$IFDEF EH_LIB_17}
  Result := TBitConverter.ToShortInt(Buffer);
 {$ELSE}
  Move(Buffer[0], Result, SizeOf(ShortInt));
 {$ENDIF}
 {$ENDIF}
end;

procedure ByteToBytes(const Value: Byte; Buffer: TBytes);
begin
 {$IFDEF EH_LIB_22}
  TDBBitConverter.UnsafeFrom<Byte>(Value, Buffer);
 {$ELSE}
 {$IFDEF EH_LIB_17}
  TBitConverter.FromByte(Value, Buffer);
 {$ELSE}
  Move(Value, Buffer[0], SizeOf(Byte));
 {$ENDIF}
 {$ENDIF}
end;

function BytesToByte(Buffer: TBytes): Byte;
begin
 {$IFDEF EH_LIB_22}
  Result := TDBBitConverter.UnsafeInto<Byte>(Buffer);
 {$ELSE}
 {$IFDEF EH_LIB_17}
  Result := TBitConverter.ToByte(Buffer);
 {$ELSE}
  Move(Buffer[0], Result, SizeOf(Byte));
 {$ENDIF}
 {$ENDIF}
end;

procedure ExtendedToBytes(const Value: Extended; Buffer: TBytes);
begin
 {$IFDEF EH_LIB_22}
  TDBBitConverter.UnsafeFrom<Extended>(Value, Buffer);
 {$ELSE}
 {$IFDEF EH_LIB_17}
  TBitConverter.FromExtended(Value, Buffer);
 {$ELSE}
  Move(Value, Buffer[0], SizeOf(Extended));
 {$ENDIF}
 {$ENDIF}
end;

function BytesToExtended(Buffer: TBytes): Extended;
begin
 {$IFDEF EH_LIB_22}
  Result := TDBBitConverter.UnsafeInto<Extended>(Buffer);
 {$ELSE}
 {$IFDEF EH_LIB_17}
  Result := TBitConverter.ToExtended(Buffer);
 {$ELSE}
  Move(Buffer[0], Result, SizeOf(Extended));
 {$ENDIF}
 {$ENDIF}
end;

procedure SingleToBytes(const Value: Single; Buffer: TBytes);
begin
 {$IFDEF EH_LIB_22}
  TDBBitConverter.UnsafeFrom<Single>(Value, Buffer);
 {$ELSE}
 {$IFDEF EH_LIB_17}
  TBitConverter.FromSingle(Value, Buffer);
 {$ELSE}
  Move(Value, Buffer[0], SizeOf(Single));
 {$ENDIF}
 {$ENDIF}
end;

function BytesToSingle(Buffer: TBytes): Single;
begin
 {$IFDEF EH_LIB_22}
  Result := TDBBitConverter.UnsafeInto<Single>(Buffer);
 {$ELSE}
 {$IFDEF EH_LIB_17}
  Result := TBitConverter.ToSingle(Buffer);
 {$ELSE}
  Move(Buffer[0], Result, SizeOf(Single));
 {$ENDIF}
 {$ENDIF}
end;

{$IFDEF NEXTGEN}
procedure StringToStringValueBuffer(var Value: Variant; Buffer: TValueBuffer; DataSize: Integer);
var
  Len: Integer;
  M: TMarshaller;
  StrValue: String;
begin
  StrValue := VarToStr(Value);
  Len := Integer(Length(TMarshal.AsAnsi(StrValue)) + 1);
  if DataSize < Len then
    Len := DataSize;
  TMarshal.Copy(M.AsAnsi(Value), Buffer, 0, Len-1);
  Buffer[Len-1] := 0;
end;

procedure StringToWideStringValueBuffer(var Value: Variant; Buffer: TValueBuffer; DataSize: Integer);
var
  Len: Integer;
  StrValue: String;
begin
  StrValue := VarToStr(Value);
  Len := (Length(StrValue) + 1) * SizeOf(WideChar);
  if DataSize < Len then
    Len := DataSize;
  TEncoding.Unicode.GetBytes(StrValue, Low(StrValue), (Len - 1) div SizeOf(WideChar), Buffer, 0);
  Buffer[Len - 2] := 0;
  Buffer[Len - 1] := 0;
end;

{$ELSE}

procedure StringToStringValueBuffer(var Value: Variant; Buffer: TValueBuffer; DataSize: Integer);
begin
  PAnsiChar(Buffer)[DataSize-1] := #0;
  StrLCopy(PAnsiChar(Buffer), PAnsiChar(VarToAnsiStr(Value)), DataSize-1);
end;

procedure StringToWideStringValueBuffer(var Value: Variant; Buffer: TValueBuffer; DataSize: Integer);
begin
  WStrCopy(PWideChar(Buffer), PWideChar(VarToWideStr(Value)));
end;
{$ENDIF}

function VarEqualsStd(const V1, V2: Variant): Boolean;
var i: Integer;
begin
  Result := not (VarIsArray(V1) xor VarIsArray(V2));
  if not Result then Exit;
  Result := False;
  try
    if VarIsArray(V1) and VarIsArray(V2) and
      (VarArrayDimCount(V1) = VarArrayDimCount(V2)) and
      (VarArrayLowBound(V1, 1) = VarArrayLowBound(V2, 1)) and
      (VarArrayHighBound(V1, 1) = VarArrayHighBound(V2, 1))
      then
      for i := VarArrayLowBound(V1, 1) to VarArrayHighBound(V1, 1) do
      begin
        Result := V1[i] = V2[i];
        if not Result then Exit;
      end
    else
      Result := V1 = V2;
  except
  end;
end;

function VarEquals(const V1, V2: Variant): Boolean; 
begin
{$IFDEF CIL}
{$ELSE}
  if (VarType(V1) = varInteger) and (VarType(V2) = varInteger) then
    Result := TVarData(V1).VInteger = TVarData(V2).VInteger
  else
{$ENDIF}
    Result := VarEqualsStd(V1, V2);
end;

{ TMTRecBuf }

destructor TMTRecBuf.Destroy;
var
  i: Integer;
begin
  for i := 0 to Length(Values) - 1 do
    Values[i] := Null;
  Values := nil;
  inherited Destroy;
end;

function TMTRecBuf.GetValue(Field: TField): Variant;
begin
  if UseMemRec and (MemRec <> nil) and (Field.FieldNo > 0) then
    Result := MemRec.Value[Field.FieldNo-1, dvvValueEh]
  else if UseMemRec and
          (RecView <> nil) and
          (Field.FieldKind in [fkCalculated, fkLookup]) and
          (Length(RecView.LookupBuffer) > Field.Index)
  then
    Result := RecView.LookupBuffer[Field.Index]
  else
    Result := Values[Field.Index];
end;

procedure TMTRecBuf.SetValue(Field: TField; v: Variant);
var
  i: Integer;
begin
  if UseMemRec and (Field.FieldKind in [fkCalculated, fkLookup]) then
  begin
    if (RecView <> nil) then
      RecView.LookupBuffer[Field.Index] := v;
    Values[Field.Index] := v;
  end else
  begin
    if UseMemRec and not (Field.FieldKind in [fkCalculated, fkLookup]) then
    begin
      for i := 0 to Field.DataSet.Fields.Count-1 do
        if Field.DataSet.Fields[i].FieldNo > 0 then
          Values[Field.DataSet.Fields[i].Index] :=
            MemRec.Value[Field.DataSet.Fields[i].FieldNo-1, dvvValueEh];
       UseMemRec := False;
    end;
    Values[Field.Index] := v;
  end;
end;

function TMTRecBuf.GetOldValue(Field: TField): Variant;
begin
  if UseMemRec and (MemRec <> nil) and (Field.FieldNo > 0) then
    if MemRec.OldData <> nil then
      Result := MemRec.Value[Field.FieldNo-1, dvvOldValueEh]
    else
      Result := GetValue(Field)
  else
    Result := Values[Field.Index];
end;

function TMTRecBuf.ReadValueCount: Integer;
begin
  Result := Length(Values);
end;

procedure TMTRecBuf.SetLength(Len: Integer);
begin
{$IFDEF CIL}
  Borland.Delphi.System.SetLength(Values, Len);
{$ELSE}
  if System.Length(Values) <> Len then
    System.SetLength(Values, Len);
{$ENDIF}
  Clear;
end;

procedure TMTRecBuf.Clear;
var
  I: Integer;
begin
  for I := 0 to Length(Values) - 1 do
    VarSetNull(Values[I]);
end;

{ TMasterDataLinkEh }

constructor TMasterDataLinkEh.Create(DataSet: TDataSet);
begin
  inherited Create;
  FDataSet := DataSet;
  FFields := TFieldListEh.Create;
end;

destructor TMasterDataLinkEh.Destroy;
begin
  FreeAndNil(FFields);
  inherited Destroy;
end;

procedure TMasterDataLinkEh.ActiveChanged;
begin
  FFields.Clear;
  if Active then
    try
      DataSet.GetFieldList(FFields, FFieldNames);
    except
      FFields.Clear;
      raise;
    end;
  if FDataSet.Active and not (csDestroying in FDataSet.ComponentState) then
    if Active {and (FFields.Count > 0)} then
    begin
      if Assigned(FOnMasterChange) then FOnMasterChange(Self);
    end else
      if Assigned(FOnMasterDisable) then FOnMasterDisable(Self);
end;

procedure TMasterDataLinkEh.CheckBrowseMode;
begin
  if FDataSet.Active then FDataSet.CheckBrowseMode;
end;

function TMasterDataLinkEh.GetDetailDataSet: TDataSet;
begin
  Result := FDataSet;
end;

procedure TMasterDataLinkEh.LayoutChanged;
begin
  ActiveChanged;
end;

procedure TMasterDataLinkEh.RecordChanged(Field: TField);
begin
  if (DataSource.State <> dsSetKey) and
     FDataSet.Active and
     ((Field = nil) or (FFields.IndexOf(Field) >= 0)) and
     Assigned(FOnMasterChange)
  then
    FOnMasterChange(Self);
end;

procedure TMasterDataLinkEh.SetFieldNames(const Value: string);
begin
  if FFieldNames <> Value then
  begin
    FFieldNames := Value;
    ActiveChanged;
  end;
end;

{ TCustomMemTableEh }

constructor TCustomMemTableEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FInLoaded := False;
  FRecordPos := -1;
  FInstantReadCurRowNum := -1;
  FAutoInc := 1;
  FRecordCache := TObjectList.Create(True);
  FEventReceivers := TObjectListEh.Create;

  FInternMemTableData := CreateMemTableData;
  FInternMemTableData.Name := 'MemTableData';

  FRecordsView := TRecordsViewEh.Create(Self);
  FRecordsView.OnFilterRecord := IsRecordInFilter;
  FRecordsView.OnParseOrderByStr := ParseOrderByStr;
  FRecordsView.OnCompareRecords := CompareRecords;
  FRecordsView.OnCompareTreeNode := CompareTreeNodes;
  FRecordsView.OnGetPrefilteredList := GetPrefilteredList;
  FRecordsView.OnViewDataEvent := ViewDataEvent;
  FRecordsView.OnViewRecordMovedEvent := ViewRecordMovedEvent;
  FRecordsView.DataObject := FInternMemTableData;
  FRecordsView.OnFetchRecords := DoFetchRecords;
  FRecordsView.MemoryTreeList.OnExpandedChanging := TreeViewNodeExpanding;
  FRecordsView.MemoryTreeList.OnExpandedChanged := TreeViewNodeExpanded;
  FRecordsView.OnApplyUpdates := nil;
  FRecordsView.OnStructChanged := MTStructChanged;
  FRecordsView.OnCalcLookupBuffer := MTCalcLookupBuffer;

  FMasterDataLink := TMasterDataLinkEh.Create(Self);
  FMasterDataLink.OnMasterChange := MasterChange;
  FDetailFieldList := TFieldListEh.Create;
  FParams := TParams.Create(Self);
  FFilterExpr := TDataSetExprParserEh.Create(Self, dsptFilterEh);
  FTreeList := TMemTableTreeListEh.Create(Self);
  FDetailRecList := TObjectListEh.Create;

{$IFDEF EH_LIB_17}
  FInstantBuffers := TList<{$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}>.Create;
{$ELSE}
  FInstantBuffers := TObjectListEh.Create;
{$ENDIF}

  FMasterValList := TSortedVarlistEh.Create;
  FMasterValList.Clear;
  FExtraFilters := TMemTableFiltersEh.Create(Self, TMemTableFilterItemEh);

  {$IFDEF FPC}
  {$ELSE}
  FWinControl := TWinControl.Create(nil);
  FWndMethod := FWinControl.WindowProc;
  FWinControl.WindowProc := WinProg;
  FWinControl.ParentWindow := Application.Handle;
  {$ENDIF}
end;

destructor TCustomMemTableEh.Destroy;
begin
  {$IFDEF FPC}
  {$ELSE}
  FreeAndNil(FWinControl);
  {$ENDIF}
  Close;
  FreeAndNil(FMasterValList);
  TreeList.Active := False;
  FreeAndNil(FFilterExpr);
  FreeAndNil(FParams);
  FDetailFieldList.Clear;
  FreeAndNil(FDetailFieldList);
  if ExternalMemData = nil then
    ClearRecords;
  FreeAndNil(FRecordsView);
  FreeAndNil(FMasterDataLink);
  FreeAndNil(FTreeList);
  FreeAndNil(FIndexDefs);
  FreeAndNil(FRecordCache);
  FreeAndNil(FDetailRecList);
  FreeAndNil(FInternMemTableData);
  FreeAndNil(FInstantBuffers);
  FreeAndNil(FExtraFilters);
  DataDriver := nil;
  inherited Destroy;
  FreeAndNil(FEventReceivers);
end;

function GetParentForm(Component: TComponent): TCustomForm;
begin
  while (Component.Owner <> nil) and not (Component is TCustomForm) do
    Component := Component.Owner;
  if Component is TCustomForm then
    Result := TCustomForm(Component) else
    Result := nil;
end;

procedure TCustomMemTableEh.UpdateDesigner;
var
  ParentForm: TCustomForm;
begin
  if (csDesigning in ComponentState) and not (csUpdating in ComponentState) then
  begin
    ParentForm := GetParentForm(Self);
    if Assigned(ParentForm) and Assigned(ParentForm.Designer) then
      ParentForm.Designer.Modified;
  end;
end;

{ Field Management }

procedure TCustomMemTableEh.InitFieldDefsFromFields;
var
  I: Integer;
  F: TField;

  procedure CreateFieldDefs(Fields: TFields; FieldDefs: TFieldDefs);
  var
    I: Integer;
    F: TField;
    FieldDef: TFieldDef;
  begin
    for I := 0 to Fields.Count - 1 do
    begin
      F := Fields[I];
      if F.FieldKind in [fkData, fkInternalCalc] then
      begin
        FieldDef := FieldDefs.AddFieldDef;
        FieldDef.Name := F.FieldName;
        FieldDef.DataType := F.DataType;
        FieldDef.Size := F.Size;
        FieldDef.InternalCalcField := (F.FieldKind = fkInternalCalc);
        if F.Required then
          FieldDef.Attributes := [faRequired];
        if F.ReadOnly then
          FieldDef.Attributes := FieldDef.Attributes + [faReadonly];
        if (F.DataType = ftBCD) and (F is TBCDField) then
          FieldDef.Precision := TBCDField(F).Precision
        else if (F.DataType = ftFMTBcd) and (F is TFMTBCDField) then
          FieldDef.Precision := TFMTBCDField(F).Precision;
      end;
    end;
  end;

begin
  if FieldDefs.Count = 0 then
  begin
    FAutoIncrementFieldName := '';
    for I := 0 to FieldCount - 1 do
    begin
      F := Fields[I];
      if (F.FieldKind in fkStoredFields) and not (F.DataType in ftSupported) then
        ErrorFmt(SUnknownFieldType, [F.DisplayName]);
      {$IFDEF FPC}
      {$ELSE}
      if F.AutoGenerateValue = arAutoInc then
        FAutoIncrementFieldName := F.FieldName;
      {$ENDIF}
    end;
  end;

  { Create FieldDefs from persistent fields if needed }
  if FieldDefs.Count = 0 then
  begin
    FieldDefs.BeginUpdate;
    try
      CreateFieldDefs(Fields, FieldDefs);
    finally
      FieldDefs.EndUpdate;
    end;
  end;

end;

procedure TCustomMemTableEh.WinProg(var Message: TMessage);
begin
  FWndMethod(Message);
  if Message.Msg = WM_USER then
  begin
    if Assigned(DataDriver) and DataDriver.ConnectionIsPostponed then
      DataDriver.AddPostponedActivationDataSet(Self)
    else
    begin
      Active := True;
    end;
  end;
end;

procedure TCustomMemTableEh.Loaded;
begin
  FInLoaded := True;
  try
    inherited Loaded;
    if TreeList.FLoadingActive then
      TreeList.Active := TreeList.FLoadingActive;
  finally
    FInLoaded := False;
  end;
end;

procedure TCustomMemTableEh.SetActive(Value: Boolean);
begin
  {$IFDEF FPC}
  inherited SetActive(Value);
  {$ELSE}
  if Value <> Active then
  begin
    if FInLoaded and Value
{$IFDEF DESIGNTIME}
      and (csDesigning in ComponentState)
{$ENDIF}
    then
    begin
      PostMessage(FWinControl.Handle, WM_USER, 0, 0);
    end else
    begin
      inherited SetActive(Value);
    end;
  end;
  {$ENDIF}
end;

{ Buffer Manipulation }

procedure TCustomMemTableEh.InitBufferPointers(GetProps: Boolean);
begin
  FRecBufSize := -1;
end;

procedure TCustomMemTableEh.ClearRecords;
begin
  RecordsView.MemTableData.RecordsList.Clear;
  RecordsView.MemTableData.AutoIncrement.Reset;
  FRecordPos := -1;
  FInstantReadCurRowNum := -1;
end;

{$IFDEF EH_LIB_12}
function TCustomMemTableEh.IndexToBuffer(I: Integer): {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF};
begin
  Result := {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}(I + 1);
end;
{$ELSE}
function TCustomMemTableEh.IndexToBuffer(I: Integer): {$IFDEF CIL}TRecordBuffer{$ELSE}PChar{$ENDIF};
begin
{$IFDEF CIL}
  Result := TRecordBuffer(I + 1);
{$ELSE}
{$HINTS OFF}
  Result := PChar(I + 1);
{$HINTS ON}
{$ENDIF}
end;
{$ENDIF}

function TCustomMemTableEh.BufferToIndex(
  {$IFDEF EH_LIB_12}
  Buf: {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}
  {$ELSE}
  Buf: {$IFDEF CIL}TRecordBuffer{$ELSE}PChar{$ENDIF}
  {$ENDIF}
  ): Integer;
begin
{$IFDEF EH_LIB_17}
  Result := Integer(Buf) - 1;
{$ELSE}
{$HINTS OFF}
{$WARNINGS OFF}
  Result := Integer(Buf) - 1; 
{$WARNINGS ON}
{$HINTS ON}
{$ENDIF}
end;

{$IFDEF EH_LIB_12}
function TCustomMemTableEh.BufferToRecBuf(Buf: {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}): TMTRecBuf;
{$ELSE}
function TCustomMemTableEh.BufferToRecBuf(Buf: {$IFDEF CIL}TRecordBuffer{$ELSE}PChar{$ENDIF}): TMTRecBuf;
{$ENDIF}
begin
  Result := TMTRecBuf(FRecordCache[BufferToIndex(Buf)]);
end;

{$IFDEF EH_LIB_12}
  {$IFDEF NEXTGEN}
function TCustomMemTableEh.AllocRecBuf: TRecBuf;
  {$ELSE}
function TCustomMemTableEh.AllocRecordBuffer: TRecordBuffer;
  {$ENDIF}
{$ELSE}
function TCustomMemTableEh.AllocRecordBuffer: {$IFDEF CIL}TRecordBuffer{$ELSE}PChar{$ENDIF};
{$ENDIF}

  procedure ClearBuffer(RecBuf: TMTRecBuf);
  begin
    RecBuf.SetLength(FieldCount);
  end;

{$IFDEF EH_LIB_12}
  function InitializeBuffer(I: Integer): {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF};
{$ELSE}
  function InitializeBuffer(I: Integer): {$IFDEF CIL}TRecordBuffer{$ELSE}PChar{$ENDIF};
{$ENDIF}
  begin
    TMTRecBuf(FRecordCache[I]).InUse := True;
    TMTRecBuf(FRecordCache[I]).RecordNumber := -2;
    ClearBuffer(TMTRecBuf(FRecordCache[I]));
    Result := IndexToBuffer(I);
  end;

var
  RecBuf: TMTRecBuf;
  I, NewIndex: Integer;
begin
  for I := 0 to FRecordCache.Count - 1 do
    if not TMTRecBuf(FRecordCache[I]).InUse then
    begin
      Result := InitializeBuffer(I);
      Exit;
    end;

  RecBuf := TMTRecBuf.Create;
  ClearBuffer(RecBuf);
  RecBuf.RecordStatus := -2;
  RecBuf.RecView := nil;
  RecBuf.MemRec := nil;
  NewIndex := FRecordCache.Add(RecBuf);
  Result := InitializeBuffer(NewIndex);
end;

{$IFDEF EH_LIB_12}
  {$IFDEF NEXTGEN}
procedure TCustomMemTableEh.FreeRecBuf(var Buffer: TRecBuf);
  {$ELSE}
procedure TCustomMemTableEh.FreeRecordBuffer(var Buffer: TRecordBuffer);
  {$ENDIF}
{$ELSE}
procedure TCustomMemTableEh.FreeRecordBuffer(var Buffer: {$IFDEF CIL}TRecordBuffer{$ELSE}PChar{$ENDIF});
{$ENDIF}
var
  I: Integer;
begin

  I := BufferToIndex(Buffer);
  if (I = FRecordCache.Count - 1) and (BufferCount < FRecordCache.Count - 2) then
  begin
    FRecordCache.Count := I;
  end else
  begin
    TMTRecBuf(FRecordCache[I]).InUse := False;
    TMTRecBuf(FRecordCache[I]).RecordNumber := -1;
    TMTRecBuf(FRecordCache[I]).Clear;
    TMTRecBuf(FRecordCache[I]).RecView := nil;
    TMTRecBuf(FRecordCache[I]).MemRec := nil;
    TMTRecBuf(FRecordCache[I]).UseMemRec := False;
  end;

{$IFDEF NEXTGEN}
  Buffer := 0;
{$ELSE}
  Buffer := nil;
{$ENDIF}
end;

{$IFDEF EH_LIB_12}
{$IFDEF EH_LIB_17}
procedure TCustomMemTableEh.ClearCalcFields(Buffer: {$IFDEF NEXTGEN}NativeInt{$ELSE}PByte{$ENDIF});
{$ELSE}
procedure TCustomMemTableEh.ClearCalcFields(Buffer: TRecordBuffer);
{$ENDIF}
{$ELSE}
procedure TCustomMemTableEh.ClearCalcFields(Buffer: {$IFDEF CIL}TRecordBuffer{$ELSE}PChar{$ENDIF});
{$ENDIF}
var
  I: Integer;
  cfi: ICalcFieldEh;
  f: TFIeld;
begin
  if CalcFieldsSize > 0 then
    for I := 0 to Fields.Count - 1 do
    begin
      f := Fields[I];
      if (f.FieldKind in [fkCalculated, fkLookup]) and
         not Supports(f, ICalcFieldEh, cfi)
      then
{$IFDEF EH_LIB_17}
        BufferToRecBuf({$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}(Buffer)).Value[f] := Null;
{$ELSE}
        BufferToRecBuf(Buffer).Value[f] := Null;
{$ENDIF}
    end;
end;

{$IFDEF EH_LIB_12}
procedure TCustomMemTableEh.InternalInitRecord(Buffer: {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF});
{$ELSE}
procedure TCustomMemTableEh.InternalInitRecord(Buffer: {$IFDEF CIL}TRecordBuffer{$ELSE}PChar{$ENDIF});
{$ENDIF}
begin
  BufferToRecBuf(Buffer).Clear;
  BufferToRecBuf(Buffer).RecView := nil;
  BufferToRecBuf(Buffer).MemRec := nil;
  BufferToRecBuf(Buffer).UseMemRec := False;
end;

{$IFDEF EH_LIB_12}
procedure TCustomMemTableEh.InitRecord(Buffer: {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF});
{$ELSE}
procedure TCustomMemTableEh.InitRecord(Buffer: {$IFDEF CIL}TRecordBuffer{$ELSE}PChar{$ENDIF});
{$ENDIF}
var
  mtrb: TMTRecBuf;
begin
  inherited InitRecord(Buffer);

  mtrb := BufferToRecBuf(Buffer);
  mtrb.BookmarkData.MemRec := nil;
  mtrb.BookmarkData.RecViewIndex := -1;
  mtrb.BookmarkFlag := bfInserted;
  mtrb.RecordNumber := -1;
end;

{$IFDEF EH_LIB_12}
function TCustomMemTableEh.GetCurrentRecord(Buffer: {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}): Boolean;
{$ELSE}
function TCustomMemTableEh.GetCurrentRecord(Buffer: {$IFDEF CIL}TRecordBuffer{$ELSE}PChar{$ENDIF}): Boolean;
{$ENDIF}
begin
  Result := False;
end;

{$IFDEF EH_LIB_12}
procedure TCustomMemTableEh.RecordToBuffer(MemRec: TMemoryRecordEh;
  DataValueVersion: TDataValueVersionEh;
  Buffer: {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}; RecIndex: Integer);
{$ELSE}
procedure TCustomMemTableEh.RecordToBuffer(MemRec: TMemoryRecordEh;
  DataValueVersion: TDataValueVersionEh;
  Buffer: {$IFDEF CIL}TRecordBuffer{$ELSE}PChar{$ENDIF}; RecIndex: Integer);
{$ENDIF}
var
  RecBuf: TMTRecBuf;
begin

  RecBuf := BufferToRecBuf(Buffer);
  RecBuf.RecordNumber := RecIndex;
  RecBuf.BookmarkFlag := bfCurrent;
  RecBuf.MemRec := MemRec;
  RecBuf.RecView := nil;
  RecBuf.BookmarkData.MemRec := MemRec;
  RecBuf.BookmarkData.RecViewIndex := RecIndex;

{ TODO : Implement InSortedListIndex otherwise all the time we enter the FixBookmarkDataCache update. }
  if RecIndex >= 0 then
    RecBuf.BookmarkData.InSortedListIndex := RecordsView.RecordView[RecIndex].InSortedListIndex
  else
    RecBuf.BookmarkData.InSortedListIndex := -1;

    RecBuf.UseMemRec := True;

  GetCalcFields(Buffer);
end;

{$IFDEF EH_LIB_12}
procedure TCustomMemTableEh.SetMemoryRecordData(Buffer: {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF};
  Rec: TMemoryRecordEh);
{$ELSE}
procedure TCustomMemTableEh.SetMemoryRecordData(Buffer: {$IFDEF CIL}TRecordBuffer{$ELSE}PChar{$ENDIF};
  Rec: TMemoryRecordEh);
{$ENDIF}
var
  i: Integer;
begin
  if State = dsFilter then
    Error(SNotEditing);
  for i := 0 to FieldCount-1 do
    if Fields[i].FieldNo > 0 then
      Rec.Value[Fields[i].FieldNo-1, dvvValueEh] :=
        BufferToRecBuf(Buffer).Value[Fields[i]];
end;

{$IFDEF EH_LIB_12}
procedure TCustomMemTableEh.SetRecViewLookupBuffer(Buffer: {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF};
  RecView: TMemRecViewEh);
{$ELSE}
procedure TCustomMemTableEh.SetRecViewLookupBuffer(Buffer: {$IFDEF CIL}TRecordBuffer{$ELSE}PChar{$ENDIF};
  RecView: TMemRecViewEh);
{$ENDIF}
var
  i: Integer;
  cfi: ICalcFieldEh;
begin
  for i := 0 to FieldCount-1 do
    if Supports(Fields[i], ICalcFieldEh, cfi) and cfi.CanModifyWithoutEditMode then
      RecView.LookupBuffer[i] := BufferToRecBuf(Buffer).Value[Fields[i]];
end;

{$IFDEF EH_LIB_12}
procedure TCustomMemTableEh.CopyBuffer(FromBuf, ToBuf: {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF});
{$ELSE}
procedure TCustomMemTableEh.CopyBuffer(FromBuf, ToBuf: {$IFDEF CIL}TRecordBuffer{$ELSE}PChar{$ENDIF});
{$ENDIF}
var
  i: Integer;
  FromRecBuf, ToRecBuf: TMTRecBuf;
begin
  FromRecBuf := BufferToRecBuf(FromBuf);
  ToRecBuf := BufferToRecBuf(ToBuf);
  ToRecBuf.BookmarkData := FromRecBuf.BookmarkData;
  ToRecBuf.BookmarkFlag := FromRecBuf.BookmarkFlag;
  ToRecBuf.RecordStatus := FromRecBuf.RecordStatus;
  ToRecBuf.RecordNumber := FromRecBuf.RecordNumber;
  ToRecBuf.NewTreeNodeExpanded := FromRecBuf.NewTreeNodeExpanded;
  ToRecBuf.NewTreeNodeHasChildren := FromRecBuf.NewTreeNodeHasChildren;
  ToRecBuf.RecView := FromRecBuf.RecView;
  ToRecBuf.MemRec := FromRecBuf.MemRec;

  ToRecBuf.SetLength(Length(FromRecBuf.Values));
  for i := 0 to Length(ToRecBuf.Values)-1 do
    ToRecBuf.Values[i] := FromRecBuf.Values[i];

  ToRecBuf.UseMemRec := FromRecBuf.UseMemRec;
end;

procedure TCustomMemTableEh.VarValueToFieldValue(VarValue: Variant;
  FieldBuffer: {$IFDEF CIL}TObject{$ELSE}Pointer{$ENDIF}; Field: TField);
begin
end;

function TCustomMemTableEh.FieldValueToVarValue(
  FieldBuffer: {$IFDEF CIL}TObject{$ELSE}Pointer{$ENDIF}; Field: TField): Variant;
begin
  Result := Unassigned;
end;

{$IFDEF EH_LIB_12}
function TCustomMemTableEh.GetRecord(Buffer: {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF};
  GetMode: TGetMode; DoCheck: Boolean): TGetResult;
{$ELSE}
function TCustomMemTableEh.GetRecord(Buffer: {$IFDEF CIL}TRecordBuffer{$ELSE}PChar{$ENDIF};
  GetMode: TGetMode; DoCheck: Boolean): TGetResult;
{$ENDIF}
begin
  Result := grOk;
  case GetMode of
    gmPrior:
      if FRecordPos <= 0 then
      begin
        Result := grBOF;
        FRecordPos := -1;
        FInstantReadCurRowNum := 0;
      end else
        Dec(FRecordPos);
    gmCurrent:
      if (FRecordPos < 0) or (FRecordPos >= RecordsView.ViewItemsCount) then
        Result := grError;
    gmNext:
      begin
        if FRecordPos >= FRecordsView.ViewItemsCount - 1 then
        begin
          BeginRecordsViewUpdate;
          try
            if FetchAllOnOpen
              then DoFetchRecords(-1)
              else DoFetchRecords(1);
          finally
            EndRecordsViewUpdate(False);
          end;
        end;
        if FRecordPos >= FRecordsView.ViewItemsCount - 1 then
        begin
          FRecordPos := FRecordsView.ViewItemsCount;
          Result := grEOF
        end else
          Inc(FRecordPos);
      end;
  end;
  if FRecordPos >= 0 then
    FInstantReadCurRowNum := FRecordPos;
  if Result = grOk then
  begin
    RecordToBuffer(FRecordsView.ViewRecord[FRecordPos], dvvValueEh, Buffer, FRecordPos);
    BufferToRecBuf(Buffer).MemRec := FRecordsView.ViewRecord[FRecordPos];
    if FRecordsView.ViewAsTreeList
      then BufferToRecBuf(Buffer).RecView := FRecordsView.MemoryTreeList.VisibleExpandedItem[FRecordPos]
      else BufferToRecBuf(Buffer).RecView := TMemRecViewEh(FRecordsView.MemoryViewList[FRecordPos]);
  end else if (Result = grError) and DoCheck then
    Error(SMemNoRecords);
end;

procedure TCustomMemTableEh.Resync(Mode: TResyncMode);
begin
  if FRecordsViewUpdating = 0
    then inherited Resync(Mode)
    else FRecordsViewUpdated := True;
end;

function TCustomMemTableEh.GetRecordSize: Word;
begin
  Result := FRecBufSize;
end;

function TCustomMemTableEh.GetActiveRecBuf(var RecBuf: TMTRecBuf; IsForWrite: Boolean): Boolean;

{$IFDEF EH_LIB_12}
  function GetOldValuesBuffer: {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF};
{$ELSE}
  function GetOldValuesBuffer: {$IFDEF CIL}TRecordBuffer{$ELSE}PChar{$ENDIF};
{$ENDIF}
  begin
    UpdateCursorPos;
    if not (GetBookmarkFlag(ActiveBuffer) in [bfBOF, bfEOF, bfInserted]) then
    begin
      Result := {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}(TempBuffer);
      RecordToBuffer(FRecordsView.ViewRecord[FRecordPos], dvvOldValueEh, Result, FRecordPos);
    end else
{$IFDEF NEXTGEN}
      Result := 0;
{$ELSE}
      Result := nil;
{$ENDIF}
  end;

{$IFDEF EH_LIB_12}
  function GetCurValuesBuffer: {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF};
{$ELSE}
  function GetCurValuesBuffer: {$IFDEF CIL}TRecordBuffer{$ELSE}PChar{$ENDIF};
{$ENDIF}
  begin
    UpdateCursorPos;
    if not (GetBookmarkFlag(ActiveBuffer) in [bfBOF, bfEOF, bfInserted]) then
    begin
      Result := {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}(TempBuffer);
      RecordToBuffer(FRecordsView.ViewRecord[FRecordPos], dvvCurValueEh, Result, FRecordPos)
    end else
{$IFDEF NEXTGEN}
      Result := 0;
{$ELSE}
      Result := nil;
{$ENDIF}
  end;

var
{$IFDEF EH_LIB_12}
  Buffer: {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF};
{$ELSE}
  Buffer: {$IFDEF CIL}TRecordBuffer{$ELSE}PChar{$ENDIF};
{$ENDIF}
begin
  if FInstantReadMode and not IsForWrite then
    RecBuf := BufferToRecBuf(InstantBuffer)
  else
    case State of
      dsBrowse, dsBlockRead:
        if IsEmpty
          then RecBuf := nil
          else RecBuf := BufferToRecBuf({$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}(ActiveBuffer));
      dsOldValue:
        begin
          Buffer := GetOldValuesBuffer;
{$IFDEF NEXTGEN}
          if Buffer <> 0 then
{$ELSE}
          if Buffer <> nil then
{$ENDIF}
          begin
            RecBuf := BufferToRecBuf(Buffer);
            if RecBuf = nil then
              RecBuf := BufferToRecBuf({$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}(ActiveBuffer))
          end else
            RecBuf := nil;
        end;
      dsCurValue:
        begin
          Buffer := GetCurValuesBuffer;
{$IFDEF NEXTGEN}
          if Buffer <> 0 then
{$ELSE}
          if Buffer <> nil then
{$ENDIF}
          begin
            RecBuf := BufferToRecBuf(Buffer);
            if RecBuf = nil then
              RecBuf := BufferToRecBuf({$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}(ActiveBuffer))
          end else
            RecBuf := nil;
        end;
      dsEdit, dsInsert, dsNewValue: RecBuf := BufferToRecBuf({$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}(ActiveBuffer));
      dsCalcFields: RecBuf := BufferToRecBuf(CalcBuffer);
      dsFilter: RecBuf := BufferToRecBuf({$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}(TempBuffer));
      dsInternalCalc: RecBuf := BufferToRecBuf({$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}(InstantBuffer));
      else
        RecBuf := nil;
    end;
  Result := RecBuf <> nil;
end;

{ Field Data }

{$IFDEF EH_LIB_17}

procedure TCustomMemTableEh.VarValueToValueBuffer(Field: TField; var Value: Variant;
  Buffer: TValueBuffer; NativeFormat: Boolean);

  procedure CurrToBuffer(const C: Currency);
  var
    LBuff: TValueBuffer;
  begin
    if NativeFormat then
    begin
      SetLength(LBuff, SizeOf(Currency));
      CurrencyToBytes(C, LBuff);
      DataConvert(Field, LBuff, Buffer, True)
    end
    else
      CurrencyToBytes(C, Buffer);
  end;

{$IFDEF EH_LIB_22}
{$ELSE}
var
  TempBuff: TValueBuffer;
{$ENDIF}
begin
  case Field.DataType of
    ftGuid, ftFixedChar, ftString:
      begin
        StringToStringValueBuffer(Value, Buffer, Field.DataSize);
      end;
    ftWideString:
      begin
        StringToWideStringValueBuffer(Value, Buffer, Field.DataSize);
      end;
    ftSmallint:
      SmallIntToBytes(Value, Buffer);
    ftWord:
      WordToBytes(Value, Buffer);
    ftAutoInc, ftInteger:
      IntegerToBytes(Value, Buffer);
    ftFloat, ftCurrency:
      DoubleToBytes(Value, Buffer);
    ftBCD:
      begin
        CurrencyToBytes(Value, Buffer);
        if NativeFormat then
          DataConvert(Field, Buffer, Buffer, True);
      end;
    ftBoolean:
      WordBoolToBytes(Value, Buffer);
    ftDate, ftTime, ftDateTime:
      begin
        DoubleToBytes(Value, Buffer);
        if NativeFormat then
          DataConvert(Field, Buffer, Buffer, True);
      end;
    ftBytes, ftVarBytes:
      begin
        VariantToBytes(Value, Buffer);
        if NativeFormat then
          DataConvert(Field, Buffer, Buffer, True);
      end;
    ftInterface:
      begin
{$IFDEF EH_LIB_22}
         TDBBitConverter.UnsafeFromInterface(IInterface(TVarData(Value).VUnknown), Buffer);
{$ELSE}
        TempBuff := BytesOf(@Value, SizeOf(IUnknown));
        Move(TempBuff[0], Buffer[0], SizeOf(IUnknown));
{$ENDIF}
      end;
    ftIDispatch:
      begin
{$IFDEF EH_LIB_22}
         TDBBitConverter.UnsafeFromInterface(IInterface(TVarData(Value).VUnknown), Buffer);
{$ELSE}
        TempBuff := BytesOf(@Value, SizeOf(IDispatch));
        Move(TempBuff[0], Buffer[0], SizeOf(IDispatch));
{$ENDIF}
      end;
    ftLargeInt:
      begin
        if PDecimal(@Value)^.sign > 0 then
          LargeIntToBytes(-1*PDecimal(@Value)^.Lo64, Buffer)
        else
          LargeIntToBytes(PDecimal(@Value)^.Lo64, Buffer);
      end;
    ftTimeStamp:
{$IFDEF EH_LIB_21}
      SQLTimeStampToBytes(VarToSQLTimeStamp(Value), Buffer);
{$ELSE}
      if NativeFormat
        then DataConvert(Field, @Value, Buffer, True)
        else TBitConverter.FromSqlTimeStamp(VarToSQLTimeStamp(Value), Buffer);
{$ENDIF}
    ftTimeStampOffset:
{$IFDEF EH_LIB_21}
      SQLTimeStampOffsetToBytes(VarToSQLTimeStampOffset(Value), Buffer);
{$ELSE}
      if NativeFormat
        then DataConvert(Field, @Value, Buffer, True)
        else TBitConverter.FromSqlTimeStampOffset(VarToSQLTimeStampOffset(Value), Buffer);
{$ENDIF}
    ftFMTBcd:
{$IFDEF EH_LIB_21}
      BcdToBytes(VarToBcd(Value), Buffer);
{$ELSE}
      if NativeFormat
        then DataConvert(Field, @Value, Buffer, True)
        else TBitConverter.FromBcd(VarToBcd(Value), Buffer);
{$ENDIF}
    ftBlob..ftTypedBinary, ftVariant, ftOraBlob, ftOraClob:
      VariantToBytes(Value, Buffer);
    ftWideMemo:
      VariantToBytes(Value, Buffer);
    ftLongWord:
      LongWordToBytes(Value, Buffer);
    ftShortint:
      ShortIntToBytes(Value, Buffer);
    ftByte:
      ByteToBytes(Value, Buffer);
    TFieldType.ftExtended:
      ExtendedToBytes(Value, Buffer);
    TFieldType.ftSingle:
      SingleToBytes(Value, Buffer);
  else
    DatabaseErrorFmt(EhLibLanguageConsts.UnsupportedFieldTypeEh, [FieldTypeNames[Field.DataType],
      Field.DisplayName]);
  end;
end;
{$ENDIF}

{$IFDEF NEXTGEN}
{$ELSE}
procedure TCustomMemTableEh.VarValueToPointerBuffer(Field: TField; var Value: Variant;
  Buffer: {$IFDEF CIL}TRecordBuffer{$ELSE}Pointer{$ENDIF}; NativeFormat: Boolean);
{$IFDEF CIL}
var
  B: TBytes;
  Len: Integer;
  TimeStamp: TTimeStamp;
  D: Double;
begin
  case Field.DataType of
    ftWideString:
    begin
      B := WideBytesOf(Value.ToString);
      Len := Length(B);
      if Len > Field.Size * 2 then
      begin
        SetLength(B, Field.Size * 2);
        Len := Field.Size * 2;
      end;
      SetLength(B, Len + 2);
      B[Len - 1] := 0;
      B[Len] := 0; 
      Marshal.Copy(B, 0, Buffer, Len + 2);
    end;
    ftString, ftGuid:
    begin
      B := BytesOf(Value.ToString);
      Len := Length(B);
      if Len > Field.Size then
      begin
        SetLength(B, Field.Size);
        Len := Field.Size;
      end;
      SetLength(B, Len + 1);
      B[Len] := 0; 
      Marshal.Copy(B, 0, Buffer, Len + 1);
    end;
    ftFixedChar:
    begin
      B := BytesOf(System.String.Create(CharArray(Value)));
      Len := Length(B);
      if Len > Field.Size then
      begin
        SetLength(B, Field.Size);
        Len := Field.Size;
      end;
      SetLength(B, Len + 1);
      B[Len] := 0; 
      Marshal.Copy(B, 0, Buffer, Len + 1);
    end;
    ftSmallint, ftWord:
      Marshal.WriteInt16(Buffer, SmallInt(Value));
    ftAutoInc, ftInteger:
      Marshal.WriteInt32(Buffer, Integer(Value));
    ftLargeInt:
      Marshal.WriteInt64(Buffer, Int64(Value));
    ftBoolean:
      if Boolean(Value) then
        Marshal.WriteInt16(Buffer, 1)
      else
        Marshal.WriteInt16(Buffer, 0);
    ftFloat, ftCurrency:
      Marshal.WriteInt64(Buffer, BitConverter.DoubleToInt64Bits(Value));
    ftBCD:
      if NativeFormat then
        Marshal.Copy(TBcd.ToBytes(Value), 0, Buffer, SizeOfTBCD)
      else
        Marshal.WriteInt64(Buffer, System.Decimal.ToOACurrency(System.Decimal(Value)));
    ftDate, ftTime, ftDateTime:
      if NativeFormat then
      begin
        TimeStamp := DateTimeToTimeStamp(TDateTime(Value));
        case Field.DataType of
          ftDate:
            Marshal.WriteInt32(Buffer, TimeStamp.Date);
         ftTime:
           Marshal.WriteInt32(Buffer, TimeStamp.Time);
         ftDateTime:
           begin
             D := TimeStampToMSecs(TimeStamp);
             Marshal.WriteInt64(Buffer, BitConverter.DoubleToInt64Bits(D));
           end;
        end;
      end
      else
        Marshal.WriteInt64(Buffer, BitConverter.DoubleToInt64Bits(Double(Value)));
    ftBytes:
      Marshal.Copy(TBytes(TObject(Value)), 0, Buffer,
        Length(TBytes(TObject(Value))));
    ftVarBytes:
      begin
        Len := Length(TBytes(TObject(Value)));
        if NativeFormat then
        begin
          Marshal.WriteInt16(Buffer, Len);
          Marshal.Copy(TBytes(TObject(Value)), 0, IntPtr(Integer(Buffer.ToInt32 + 2)), Len);
        end else
          Marshal.Copy(TBytes(TObject(Value)), 0, Buffer, Len);
      end;
    ftTimeStamp:
      Marshal.StructureToPtr(TObject(Value), Buffer, False);
    ftFMTBCD:
      Marshal.Copy(TBcd.ToBytes(Value), 0, Buffer, SizeOfTBCD);
    else
      DatabaseErrorFmt(SUnsupportedFieldTypeEh, [FieldTypeNames[Field.DataType], Field.DisplayName]);
  end;
end;

{$ELSE} 

{$IFDEF FPC}
var
  DataSize: Integer;
{$ELSE}
{$ENDIF}

begin
  case Field.DataType of
    ftGuid, ftFixedChar, ftString:
      begin
{$IFDEF NEXTGEN}
{ TODO : Make an implementation for NEXTGEN. }
{$ELSE}
  {$IFDEF FPC}
        DataSize := Field.DataSize;
        Move(PAnsiChar(VarToAnsiStr(Value))^, Buffer^, DataSize);
  {$ELSE}
        PAnsiChar(Buffer)[Field.Size] := #0;
        StrLCopy(PAnsiChar(Buffer), PAnsiChar(VarToAnsiStr(Value)), Field.Size);
{$ENDIF}
{$ENDIF}
      end;
    ftWideString:
      begin
{$IFDEF EH_LIB_10}
  {$IFDEF NEXTGEN}
{ TODO : Make an implementation for NEXTGEN. }
  {$ELSE}
        WStrCopy(PWideChar(Buffer), PWideChar(VarToWideStr(Value)));
  {$ENDIF}
{$ELSE}
   {$IFDEF FPC}
        WStrCopy(PWideChar(Buffer), PWideChar(VarToWideStr(Value)));
   {$ELSE}
        WideString(Buffer^) := Value;
   {$ENDIF}
{$ENDIF}
      end;
    ftSmallint:
        SmallInt(Buffer^) := Value;
    ftWord:
        Word(Buffer^) := Value;
    ftAutoInc, ftInteger:
      Integer(Buffer^) := Value;
    ftFloat, ftCurrency:
        Double(Buffer^) := Value;
    ftBCD:
      begin
        {$IFDEF FPC}
        Currency(Buffer^) := Value;
        {$ELSE}
        Currency(Buffer^) := Value;
        if NativeFormat then
          DataConvert(Field, Buffer, Buffer, True);
        {$ENDIF}
      end;
    ftBoolean:
      WordBool(Buffer^) := Value;
    ftDate, ftTime, ftDateTime:
      begin
        {$IFDEF FPC}
        TDateTime(Buffer^) := Value;
        //if NativeFormat then
        //  DataConvert(Field, Buffer, Buffer, True);
        {$ELSE}
        TDateTime(Buffer^) := Value;
        if NativeFormat then
          DataConvert(Field, Buffer, Buffer, True);
        {$ENDIF}
      end;
    ftBytes, ftVarBytes:
      begin
        Variant(Buffer^) := Value;
        if NativeFormat then
          DataConvert(Field, Buffer, Buffer, True);
      end;
    ftInterface: IUnknown(Buffer^) := Value;
    ftIDispatch: IDispatch(Buffer^) := Value;
    ftLargeInt: LargeInt(Buffer^) := Value;
    ftTimeStamp:
      if NativeFormat
        then DataConvert(Field, @Value, Buffer, True)
      {$IFDEF FPC}
          ;
      {$ELSE}
        else TSQLTimeStamp(Buffer^) := VarToSQLTimeStamp(Value);
      {$ENDIF}
    ftFMTBcd:
    {$IFDEF FPC}
      TBcd(Buffer^) := VarToBcd(Value);
    {$ELSE}
      if NativeFormat
        then DataConvert(Field, @Value, Buffer, True)
        else TBcd(Buffer^) := VarToBcd(Value);
    {$ENDIF}
    ftBlob..ftTypedBinary, ftVariant, ftOraBlob, ftOraClob: Variant(Buffer^) := Value;
{$IFDEF EH_LIB_10}
    ftWideMemo: Variant(Buffer^) := Value;
{$ENDIF}
{$IFDEF EH_LIB_12}
    ftLongWord:
      LongWord(Buffer^) := Value;
    ftShortint:
      ShortInt(Buffer^) := Value;
    ftByte:
      Byte(Buffer^) := Value;
{$ENDIF}
  else
    DatabaseErrorFmt(EhLibLanguageConsts.UnsupportedFieldTypeEh, [FieldTypeNames[Field.DataType],
      Field.DisplayName]);
  end;
end;
{$ENDIF} 

{$ENDIF} 

{$IFDEF EH_LIB_17}
 {$IFDEF EH_LIB_18}
function TCustomMemTableEh.GetFieldData(Field: TField;
  var Buffer: TValueBuffer; NativeFormat: Boolean): Boolean;
 {$ELSE}
function TCustomMemTableEh.GetFieldData(Field: TField;
  Buffer: TValueBuffer; NativeFormat: Boolean): Boolean;
 {$ENDIF}
var
  RecBuf: TMTRecBuf;
  OutValue: Variant;
begin
  Result := GetActiveRecBuf(RecBuf);
  if not Result then Exit;

{$IFDEF FPC}
{$ELSE}
  if Field.FieldKind = fkAggregate then
    OutValue := GetAggregateValue(Field)
  else
{$ENDIF}
  begin
    if State = dsOldValue
      then OutValue := RecBuf.OldValue[Field]
      else OutValue := RecBuf.Value[Field];
    if Assigned(FOnGetFieldValue) then
      FOnGetFieldValue(Self, Field, OutValue);
  end;

  if VarIsNull(OutValue) or VarIsEmpty(OutValue) then
    Result := False
  else if Buffer <> nil then
    VarValueToValueBuffer(Field, OutValue, Buffer, NativeFormat);
end;
{$ENDIF}

{$IFDEF EH_LIB_17}
 {$IFDEF EH_LIB_18}
function TCustomMemTableEh.GetFieldData(Field: TField; var Buffer: TValueBuffer): Boolean;
 {$ELSE}
function TCustomMemTableEh.GetFieldData(Field: TField; Buffer: TValueBuffer): Boolean;
 {$ENDIF}
begin
  Result := GetFieldData(Field, Buffer, True);
end;
{$ENDIF}


{$IFDEF EH_LIB_17}
 {$IFDEF EH_LIB_18}
function TCustomMemTableEh.GetFieldData(FieldNo: Integer; var Buffer: TValueBuffer): Boolean;
 {$ELSE}
function TCustomMemTableEh.GetFieldData(FieldNo: Integer; Buffer: TValueBuffer): Boolean;
 {$ENDIF}
begin
  Result := GetFieldData(FieldByNumber(FieldNo), Buffer);
end;
{$ELSE}
  {$IFDEF FPC}
  {$ELSE}
  {$ENDIF}
{$ENDIF}


{$IFDEF NEXTGEN}
{$ELSE}
function TCustomMemTableEh.GetFieldData(Field: TField; Buffer: {$IFDEF CIL}TRecordBuffer{$ELSE}Pointer{$ENDIF}): Boolean;
begin
  Result := GetFieldData(Field, Buffer, True);
end;
{$ENDIF}

{$IFDEF FPC}
{$ELSE}
{$ENDIF}

{$IFDEF NEXTGEN}
{$ELSE}
function TCustomMemTableEh.GetFieldData(Field: TField;
  Buffer: {$IFDEF CIL}TRecordBuffer{$ELSE}Pointer{$ENDIF}; NativeFormat: Boolean): Boolean;
var
  OutValue: Variant;
  RecBuf: TMTRecBuf;
begin
  Result := GetActiveRecBuf(RecBuf);
  if not Result then Exit;

{$IFDEF FPC}
{$ELSE}
  if Field.FieldKind = fkAggregate then
    OutValue := GetAggregateValue(Field)
  else
{$ENDIF}
  begin
    if State = dsOldValue
      then OutValue := RecBuf.OldValue[Field]
      else OutValue := RecBuf.Value[Field];
    if Assigned(FOnGetFieldValue) then
      FOnGetFieldValue(Self, Field, OutValue);
  end;

  if VarIsNull(OutValue) then
    Result := False
  else if Buffer <> nil then
     VarValueToPointerBuffer(Field, OutValue, Buffer, NativeFormat);
end;
{$ENDIF}

function TCustomMemTableEh.GetFieldValue(Field: TField; var Value: Variant): Boolean;
var
  RecBuf: TMTRecBuf;
  OutValue: Variant;
begin
  Value := Null;
  Result := GetActiveRecBuf(RecBuf);
  if not Result then Exit;

  OutValue := RecBuf.Value[Field];
  if Assigned(FOnGetFieldValue) then
    FOnGetFieldValue(Self, Field, OutValue);

  if VarIsNull(OutValue)
    then Result := False
    else Value := OutValue;
end;

function TCustomMemTableEh.GetFieldDisplayText(Field: TField): String;
var
  RecBuf: TMTRecBuf;
  OutValue: Variant;
  HasData: Boolean;
begin
  if Assigned(Field.OnGetText) or
    not (Field.DataType in [ftString, ftMemo, ftFmtMemo, ftFixedChar,
                       ftWideString
{$IFDEF EH_LIB_10}
                       , ftFixedWideChar, ftWideMemo
{$ENDIF}
                       ]) then
  begin
    Result := Field.DisplayText;
  end else
  begin
    HasData := GetActiveRecBuf(RecBuf);

    if not HasData then
      OutValue := Null
    else
      OutValue := RecBuf.Value[Field];

    if VarIsEmpty(OutValue) or VarIsNull(OutValue) then
      Result := ''
    else
      Result := VarToStr(OutValue);
  end;
end;

function TCustomMemTableEh.GetFieldDataAsObject(Field: TField; var Value: TObject): Boolean;
var
  RecBuf: TMTRecBuf;
  OutValue: Variant;
begin
  Value := nil;
  Result := GetActiveRecBuf(RecBuf);
  if not Result then Exit;

  OutValue := RecBuf.Value[Field];
  if Assigned(FOnGetFieldValue) then
    FOnGetFieldValue(Self, Field, OutValue);

  if VarIsNull(OutValue)
    then Result := False
    else Value := VariantToRefObject(OutValue);
end;

{$IFNDEF NEXTGEN}

procedure TCustomMemTableEh.SetFieldData(Field: TField;
  Buffer: {$IFDEF CIL}TValueBuffer{$ELSE}Pointer{$ENDIF});
begin
  SetFieldData(Field, Buffer, True);
end;

procedure TCustomMemTableEh.SetFieldData(Field: TField;
  Buffer: {$IFDEF CIL}TValueBuffer{$ELSE}Pointer{$ENDIF}; NativeFormat: Boolean);
var
  RecBuf: TMTRecBuf;
  v: Variant;

{$IFDEF CIL}
  procedure BufferToVar(var Data: Variant);
  var
    B: TBytes;
    Len: Smallint;
  begin
    case Field.DataType of
      ftWideString:
        Data := Variant(Marshal.PtrToStringUni(Buffer));
      ftString, ftGuid, ftFixedChar:
        Data := Variant(Marshal.PtrToStringAnsi(Buffer));
      ftSmallint, ftWord:
        Data := Variant(Marshal.ReadInt16(Buffer));
      ftAutoInc, ftInteger:
        Data := Variant(Marshal.ReadInt32(Buffer));
      ftLargeInt:
        Data := Variant(Marshal.ReadInt64(Buffer));
      ftBoolean:
        if Marshal.ReadInt16(Buffer) <> 0 then
          Data := Variant(True)
        else
          Data := Variant(False);
      ftFloat, ftCurrency:
        Data := Variant(BitConverter.Int64BitsToDouble(Marshal.ReadInt64(Buffer)));
      ftBCD:
        if NativeFormat then
        begin
          SetLength(B, SizeOfTBCD);
          Marshal.Copy(Buffer, B, 0, SizeOfTBCD);
          Data := Variant(TBcd.FromBytes(B));
        end
        else
          Data := System.Decimal.FromOACurrency(Marshal.ReadInt64(Buffer));
      ftDate, ftTime, ftDateTime:
        if NativeFormat then
        begin
          case Field.DataType of
            ftDate:
              Data := System.DateTime.Create(0).AddDays(Marshal.ReadInt32(Buffer));
            ftTime:
              Data := System.DateTime.Create(0).AddMilliseconds(
                Marshal.ReadInt32(Buffer));
            ftDateTime:
              Data := System.DateTime.Create(0).AddMilliseconds(
                BitConverter.Int64BitsToDouble(Marshal.ReadInt64(Buffer)));
          end;
        end
        else 
          Data := System.DateTime.FromOADate(BitConverter.Int64BitsToDouble(
            Marshal.ReadInt64(Buffer)));
      ftBytes:
      begin
        SetLength(B, Field.Size);
        Marshal.Copy(Buffer, B, 0, Field.Size);
        Data := Variant(B);
      end;
      ftTimeStamp:
        Data := Variant(Marshal.PtrToStructure(Buffer, TypeOf(TSQLTimeStamp)));
      ftFMTBCD:
      begin
        SetLength(B, SizeOfTBCD);
        Marshal.Copy(Buffer, B, 0, SizeOfTBCD);
        Data := Variant(TBcd.FromBytes(B));
      end;
      ftVarBytes:
        if NativeFormat then
        begin
          Len := Marshal.ReadInt16(Buffer);
          SetLength(B, Len);
          Marshal.Copy(IntPtr(Integer(Buffer.ToInt32 + 2)), B, 0, Len);
          Data := Variant(B);
        end else
        begin
          {note, we cant support VarBytes if not length prefixed}
          DatabaseErrorFmt(SUnsupportedFieldTypeEh, [FieldTypeNames[ftVarBytes],
              Field.DisplayName]);
          Data := nil; 
        end
      else
      begin
        {note, we cant support blob types in this way}
        DatabaseErrorFmt(SUnsupportedFieldTypeEh, [FieldTypeNames[Field.DataType],
            Field.DisplayName]);
        Data := nil; 
      end;
    end;
  end;
{$ELSE}

  procedure BufferToVar(var Data: Variant);
  begin
    case Field.DataType of
      ftString, ftFixedChar, ftGuid:
        Data := AnsiString(PAnsiChar(Buffer));
      ftWideString:
{$IFDEF EH_LIB_10}
        Data := WideString(PWideChar(Buffer));
{$ELSE}
    {$IFDEF FPC}
        Data := WideString(PWideChar(Buffer));
    {$ELSE}
        Data := WideString(Buffer^);
    {$ENDIF}
{$ENDIF}
      ftAutoInc, ftInteger:
        Data := LongInt(Buffer^);
      ftSmallInt:
        Data := SmallInt(Buffer^);
      ftWord:
        Data := Word(Buffer^);
      ftBoolean:
        Data := WordBool(Buffer^);
      ftFloat, ftCurrency:
        Data := Double(Buffer^);
      ftBlob, ftMemo, ftGraphic, ftVariant, ftOraBlob, ftOraClob:
        Data := Variant(Buffer^);
      ftInterface:
        Data := IUnknown(Buffer^);
      ftIDispatch:
        Data := IDispatch(Buffer^);
      ftDate, ftTime, ftDateTime:
        if NativeFormat
          then DataConvert(Field, Buffer, @TVarData(Data).VDate, False)
          else Data := TDateTime(Buffer^);
      ftBCD:
        {$IFDEF FPC}
           Data := Currency(Buffer^);
        {$ELSE}
          if NativeFormat
            then DataConvert(Field, Buffer, @TVarData(Data).VCurrency, False)
            else Data := Currency(Buffer^);
        {$ENDIF}
      ftBytes, ftVarBytes:
        if NativeFormat
          then DataConvert(Field, Buffer, @Data, False)
          else Data := Variant(Buffer^);
{$IFDEF EH_LIB_10}
      ftWideMemo: Data := Variant(Buffer^);
{$ENDIF}
      ftLargeInt:
          Data := Int64(Buffer^);
      ftTimeStamp:
        if NativeFormat then
          DataConvert(Field, Buffer, @Data, False)
      {$IFDEF FPC}
          ;
      {$ELSE}
          else Data :=  VarSQLTimeStampCreate(TSQLTimeStamp(Buffer^));
      {$ENDIF}

      ftFMTBcd:
      {$IFDEF FPC}
        Data := VarFMTBcdCreate(TBcd(Buffer^));
      {$ELSE}
        if NativeFormat
          then DataConvert(Field, Buffer, @Data, False)
          else Data := VarFMTBcdCreate(TBcd(Buffer^));
      {$ENDIF}

{$IFDEF EH_LIB_12}
      ftLongWord:
        Data := LongWord(Buffer^);
      ftShortint:
        Data := ShortInt(Buffer^);
      ftByte:
        Data := Byte(Buffer^);
{$ENDIF}
      else
        DatabaseErrorFmt(EhLibLanguageConsts.UnsupportedFieldTypeEh, [FieldTypeNames[Field.DataType],
          Field.DisplayName]);
    end;
  end;

{$ENDIF}

begin
  if not (Field.FieldKind in [fkCalculated, fkLookup]) and
     not (State in dsWriteModes)
  then DatabaseError(SNotEditing, Self);
  if (Field.FieldKind in [fkData, fkInternalCalc]) and
      Field.ReadOnly and not (State in [dsSetKey, dsFilter])
  then
      {$IFDEF FPC}
    DatabaseErrorFmt(SReadOnlyField, [Field.DisplayName]);
      {$ELSE}
    DatabaseErrorFmt(SFieldReadOnly, [Field.DisplayName]);
      {$ENDIF}

  if not GetActiveRecBuf(RecBuf, True) then Exit;

  Field.Validate(Buffer);

  if Buffer = nil
    then v := Null
    else BufferToVar(v);

  CheckFieldDataVarValue(Field, v);

  if Assigned(FOnSetFieldValue) then
    FOnSetFieldValue(Self, Field, v);

  RecBuf.Value[Field] := v;

  if not (State in [dsCalcFields, dsInternalCalc, dsFilter, dsNewValue]) then
{$IFDEF CIL}
    DataEvent(deFieldChange, Field);
{$ELSE}
    DataEvent(deFieldChange, TDataEventInfoTypeEh(Field));
{$ENDIF}
end;

{$ENDIF !NEXTGEN}

{$IFDEF EH_LIB_17}

{$IFDEF NEXTGEN}

function StringValueBufferToString(Buffer: TValueBuffer): String;
begin
  Result := TMarshal.ReadStringAsAnsi(TPtrWrapper.Create(Buffer));
end;

function WideStringValueBufferToString(Buffer: TValueBuffer): String;
begin
  Result := TMarshal.ReadStringAsUnicode(TPtrWrapper.Create(Buffer));
end;

{$ELSE}

function StringValueBufferToString(Buffer: TValueBuffer): String;
begin
  Result := String(AnsiString(PAnsiChar(Buffer)));
end;

function WideStringValueBufferToString(Buffer: TValueBuffer): String;
begin
 {$IFDEF EH_LIB_10}
 Result := WideString(PWideChar(Buffer));
 {$ELSE}
 Result := WideString(Buffer^);
 {$ENDIF}
end;

{$ENDIF}

procedure TCustomMemTableEh.SetFieldData(Field: TField;
  Buffer: TValueBuffer; NativeFormat: Boolean);

var
  RecBuf: TMTRecBuf;
  v: Variant;

  procedure BufferToVar(var Data: Variant);
  var
    LUnknown: IUnknown;
    LDispatch: IDispatch;
  begin
    case Field.DataType of
      ftString, ftFixedChar, ftGuid:
        Data := StringValueBufferToString(Buffer);
      ftWideString:
        Data := WideStringValueBufferToString(Buffer);
      ftAutoInc, ftInteger:
        Data := BytesToInteger(Buffer);
      ftSmallInt:
        Data := BytesToSmallInt(Buffer);
      ftWord:
        Data := BytesToWord(Buffer);
      ftBoolean:
        Data := BytesToWordBool(Buffer);
      ftFloat, ftCurrency:
        Data := BytesToDouble(Buffer);
      ftBlob, ftGraphic, ftVariant, ftOraBlob, ftOraClob:
        Data := BytesToVariant(Buffer);
      ftMemo:
        begin
          Data := BytesToVariant(Buffer);
        end;
      ftInterface:
        begin
          Move(Buffer[0], LUnknown, SizeOf(IUnknown));
          Data := LUnknown;
        end;
      ftIDispatch:
        begin
          Move(Buffer[0], LDispatch, SizeOf(IDispatch));
          Data := LDispatch;
        end;
      ftDate, ftTime, ftDateTime:
        begin
          if NativeFormat then
            DataConvert(Field, Buffer, Buffer, False);
          Data := BytesToDouble(Buffer);
        end;
      ftBCD:
        begin
          if NativeFormat then
            DataConvert(Field, Buffer, Buffer, False);
          Data := BytesToCurrency(Buffer);
        end;
      ftBytes, ftVarBytes:
        begin
          if NativeFormat then
            DataConvert(Field, Buffer, Buffer, False);
          Move(Buffer[0], Data, SizeOf(OleVariant));
        end;
{$IFDEF EH_LIB_10}
      ftWideMemo:
        Data := BytesToVariant(Buffer);
{$ENDIF}
      ftLargeInt:
        Data := BytesToLargeInt(Buffer);
      ftTimeStamp:
{$IFDEF EH_LIB_21}
        Data := VarSQLTimeStampCreate(BytesToSqlTimeStamp(Buffer));
{$ELSE}
        if NativeFormat
          then DataConvert(Field, Buffer, @Data, True)
          else Data := VarSQLTimeStampCreate(TBitConverter.ToSqlTimeStamp(Buffer));
{$ENDIF}
      ftTimeStampOffset:
{$IFDEF EH_LIB_21}
        Data := VarSQLTimeStampOffsetCreate(BytesToSqlTimeStampOffset(Buffer));
{$ELSE}
        if NativeFormat
          then DataConvert(Field, Buffer, @Data, True)
          else Data := VarSQLTimeStampOffsetCreate(TBitConverter.ToSqlTimeStampOffset(Buffer));
{$ENDIF}
      ftFMTBcd:
{$IFDEF EH_LIB_21}
        Data := VarFMTBcdCreate(BytesToBcd(Buffer));
{$ELSE}
        if NativeFormat
          then DataConvert(Field, Buffer, @Data, True)
          else Data := VarFMTBcdCreate(BytesToBcd(Buffer));
{$ENDIF}
      ftLongWord:
        Data := BytesToLongWord(Buffer);
      ftShortint:
        Data := BytesToShortInt(Buffer);
      ftByte:
        Data := BytesToByte(Buffer);
      TFieldType.ftExtended:
        Data := BytesToExtended(Buffer);
      TFieldType.ftSingle:
        Data := BytesToSingle(Buffer);
      else
        DatabaseErrorFmt(EhLibLanguageConsts.UnsupportedFieldTypeEh, [FieldTypeNames[Field.DataType],
          Field.DisplayName]);
    end;
  end;

begin
  if not (Field.FieldKind in [fkCalculated, fkLookup, fkInternalCalc]) and
     not (State in dsWriteModes)
  then
    DatabaseError(SNotEditing, Self);
  if (Field.FieldKind in [fkData, fkInternalCalc]) and
      Field.ReadOnly and not (State in [dsSetKey, dsFilter]) then
    DatabaseErrorFmt(SFieldReadOnly, [Field.DisplayName]);

  if not GetActiveRecBuf(RecBuf, True) then Exit;

  Field.Validate(Buffer);

  if Buffer = nil
    then v := Null
    else BufferToVar(v);

  CheckFieldDataVarValue(Field, v);

  if Assigned(FOnSetFieldValue) then
    FOnSetFieldValue(Self, Field, v);

  RecBuf.Value[Field] := v;

  if not (State in [dsCalcFields, dsInternalCalc, dsFilter, dsNewValue]) then
{$IFDEF CIL}
    DataEvent(deFieldChange, Field);
{$ELSE}
    //DataEvent(deFieldChange, Longint(Field));
    DataEvent(deFieldChange, TDataEventInfoTypeEh(Field));
{$ENDIF}
end;

procedure TCustomMemTableEh.SetFieldData(Field: TField; Buffer: TValueBuffer);
begin
  SetFieldData(Field, Buffer, True);
end;

{$ENDIF} 

procedure TCustomMemTableEh.CheckFieldDataVarValue(Field: TField; var VarValue: Variant);
var
  DecSize: Currency;
  MaxPrecNum: Double;
  i: Integer;
  CurVal: Currency;
  CurBcd, OutBCD: TBcd;
  FmtBCDField: TFmtBCDField;
begin
  if VarIsNull(VarValue) then Exit;

  if Field.DataType = ftBCD then
  begin
    if (Field as TBCDField).Precision > 0 then
    begin
      MaxPrecNum := 1;
      for i := 0 to (Field as TBCDField).Precision-1-Field.Size do
        MaxPrecNum := MaxPrecNum * 10;
      if Double(VarValue) > MaxPrecNum then
        raise EBcdOverflowException.Create(SBcdOverflow);
      if Field.Size < 4 then
      begin
        DecSize := 1;
        for i := 0 to Field.Size-1 do
          DecSize := DecSize * 10;

        CurVal := VarValue * DecSize;
        CurVal := Round(CurVal);
        CurVal := CurVal / DecSize;
        VarValue := CurVal;
      end;
    end;
  end else if Field.DataType = ftFMTBcd then
  begin
    FmtBCDField := (Field as TFmtBCDField);
    if (FmtBCDField.Precision > 0) and (VarValue <> 0) then
    begin
      CurBcd := VarToBcd(VarValue * 1); 
      {$IFDEF FPC}
      if BcdPrecision(CurBcd) - BCDScale(CurBcd) > FmtBCDField.Precision - FmtBCDField.Size then
        raise EBcdOverflowException.Create(SBcdOverflow);
      {$ELSE}
      if BcdPrecision(CurBcd) > FmtBCDField.Precision - FmtBCDField.Size then
        raise EBcdOverflowException.Create(SBcdOverflow);
      {$ENDIF}

      NormalizeBcd(CurBcd, OutBCD, FmtBCDField.Precision, Field.Size);
      VarValue := VarFMTBcdCreate(OutBCD);
    end;
  end;
end;

procedure TCustomMemTableEh.SetFieldDataAsObject(Field: TField; Value: TObject);
var
  RecBuf: TMTRecBuf;
  v: Variant;
begin
  if not (State in dsWriteModes) then DatabaseError(SNotEditing, Self);
  if not GetActiveRecBuf(RecBuf, True) then Exit;

  if Value = nil
    then v := Null
    else v := RefObjectToVariant(Value);

  if Assigned(FOnSetFieldValue) then
    FOnSetFieldValue(Self, Field, v);

  RecBuf.Value[Field] := v;

  if not (State in [dsCalcFields, dsInternalCalc, dsFilter, dsNewValue]) then
{$IFDEF CIL}
    DataEvent(deFieldChange, Field);
{$ELSE}
    DataEvent(deFieldChange, TDataEventInfoTypeEh(Field));
{$ENDIF}
end;

{ Filter }

procedure TCustomMemTableEh.RecreateFilterExpr;
begin
  if Filtered
    then FFilterExpr.ParseExpression(Filter)
    else FFilterExpr.ParseExpression('');
end;

procedure TCustomMemTableEh.DestroyFilterExpr;
begin
  FFilterExpr.ParseExpression('');
end;

procedure TCustomMemTableEh.SetFilterText(const Value: string);
begin
  if Active and Filtered then
  begin
    if Value <> Filter then
    begin
      inherited SetFilterText(Value);
      RecreateFilterExpr;
      InternalRefreshFilter;
      CursorPosChanged;
      UpdateCursorPos;
      First;
    end;
  end else
    inherited SetFilterText(Value);
end;

procedure TCustomMemTableEh.SetFiltered(Value: Boolean);
begin
  if Active then
  begin
    CheckBrowseMode;
    if Filtered <> Value then
    begin
      inherited SetFiltered(Value);
      RecreateFilterExpr;
      InternalRefreshFilter;
      CursorPosChanged;
      UpdateCursorPos;
      First;
    end;
  end
  else inherited SetFiltered(Value);
end;

procedure TCustomMemTableEh.SetOnFilterRecord(const Value: TFilterRecordEvent);
begin
  if Active then
  begin
    CheckBrowseMode;
    inherited SetOnFilterRecord(Value);
    if Filtered then
      InternalRefreshFilter;
  end
  else inherited SetOnFilterRecord(Value);
end;

procedure TCustomMemTableEh.SetOptions(const Value: TMemTableOptionsEh);
begin
  if FOptions <> Value then
  begin
    FOptions := Value;
    if mtoTextFieldsCaseInsensitive in FOptions
      then FilterOptions := FilterOptions + [foCaseInsensitive]
      else FilterOptions := FilterOptions - [foCaseInsensitive];
    RecordsView.SortOrderCaseInsensitive := mtoTextFieldsCaseInsensitive in FOptions;
  end;
end;

function TCustomMemTableEh.IsRecordInFilter(Rec: TMemoryRecordEh; Node: TMemRecViewEh): Boolean;
var
  SaveState: TDataSetState;
  DetV, MasV: Variant;
begin
  Result := True;
  SaveState := dsInactive;
  if not IsCursorOpen then Exit;
  if (Filtered and (Assigned(OnFilterRecord) or (Filter <> '')) ) or
      FDetailMode or
      (ExtraFilters.ActiveFilterCount > 0) then
  begin
    try
      {$IFDEF FPC}
      {$ELSE}
      if Assigned(OnFilterRecord) or ExtraFilters.HasEventActiveFilter then
      {$ENDIF}
      begin
        SaveState := SetTempState(dsFilter);
        RecordToBuffer(Rec, dvvValueEh, {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}(TempBuffer), -1);
        BufferToRecBuf({$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}(TempBuffer)).RecView := Node;
        BufferToRecBuf({$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}(TempBuffer)).NeedUpdateCalcFields := True;
        try
          GetCalcFields(TempBuffer);
        finally
        end;
      end;

      if FFilterExpr.HasData then
      {$IFDEF FPC}
        Result := FFilterExpr.IsCurRecordBufInFilter(TempBuffer);
      {$ELSE}
        Result := FFilterExpr.IsCurRecordInFilter(Rec);
      {$ENDIF}

      if Result and Filtered and Assigned(OnFilterRecord) then
        OnFilterRecord(Self, Result);

      if Result and FDetailMode and (MasterDetailSide in [mdsOnSelfEh, mdsOnSelfAfterProviderEh]) then
      begin
        if FDetailRecListActive then
          Result := (FDetailRecList.IndexOf(Rec) >= 0)
        else begin
          DetV := Rec.DataValues[FDetailFields, dvvValueEh];
          MasV := MasterSource.DataSet.FieldValues[MasterFields];
          Result := VarEquals(DetV, MasV);
        end;
      end;

      if Result and (ExtraFilters.ActiveFilterCount > 0) then
        Result := ExtraFilters.IsCurRecordInFilter(Rec);
    except
      on EAbort do
        raise
      else
        Application.HandleException(Self);
    end;

    {$IFDEF FPC}
    {$ELSE}
    if Assigned(OnFilterRecord) or ExtraFilters.HasEventActiveFilter then
    {$ENDIF}
      RestoreState(SaveState);
  end;
end;

function TCustomMemTableEh.GetPrefilteredList: TObjectList;
begin
  if FDetailRecListActive
    then Result := FDetailRecList
    else Result := nil;
end;

function TCustomMemTableEh.GetStatusFilter: TUpdateStatusSet;
begin
  Result := RecordsView.StatusFilter;
end;

procedure TCustomMemTableEh.SetStatusFilter(const Value: TUpdateStatusSet);
begin
  RecordsView.StatusFilter := Value;
end;

function TCustomMemTableEh.ApplyExtraFilter(const FilterStr: String;
  FilterProc: TFilterRecordEvent): TObject;
var
  fi: TMemTableFilterItemEh;
begin
  fi := ExtraFilters.Add;
  fi.Filter := FilterStr;
  fi.OnFilterRecord := FilterProc;
  fi.Active := True;
  Result := ExtraFilters[ExtraFilters.Count-1];
end;

function TCustomMemTableEh.RevokeExtraFilter(FilterObject: TObject): Boolean;
var
  FilterIndex: Integer;
begin
  Result := False;
  FilterIndex := ExtraFilters.IndexOfFilter(TMemTableFilterItemEh(FilterObject));
  if FilterIndex >= 0 then
  begin
    ExtraFilters.Delete(FilterIndex);
    Result := True;
  end;
end;

function TCustomMemTableEh.ResetExtraFilter(FilterObject: TObject;
  const FilterStr: String; FilterProc: TFilterRecordEvent): Boolean;
var
  FilterIndex: Integer;
begin
  Result := False;
  FilterIndex := ExtraFilters.IndexOfFilter(TMemTableFilterItemEh(FilterObject));
  if FilterIndex >= 0 then
  begin
    if ExtraFilters[FilterIndex].Filter <> FilterStr then
    begin
      ExtraFilters[FilterIndex].Filter := FilterStr;
      ExtraFilters[FilterIndex].OnFilterRecord := FilterProc;
    end else if @ExtraFilters[FilterIndex].OnFilterRecord <> @FilterProc then
    begin
      ExtraFilters[FilterIndex].OnFilterRecord := FilterProc;
    end else
      ExtraFilters[FilterIndex].FilterProcChanged;
    Result := True;
  end;
end;

procedure TCustomMemTableEh.ViewDataEvent(MemRec: TMemoryRecordEh; Index:
  Integer; Action: TRecordsListNotification);
var
  ARowNum: Integer;

  procedure ViewDataEventToMTEvent;
  var
    MTEvent: TMTViewEventTypeEh;
  begin
    if not ( Action in
      [rlnRecAddedEh, rlnRecChangedEh, rlnRecDeletedEh, rlnListChangedEh] )
    then
      Exit;
    MTEvent := mtViewDataChangedEh;
    if Action = rlnListChangedEh then
    begin
      ClearBuffers;
      Resync([]);
      MTViewDataEvent(-1, MTEvent, -1);
    end else
    begin
      case Action of
        rlnRecAddedEh: MTEvent := mtRowInsertedEh;
        rlnRecChangedEh: MTEvent := mtRowChangedEh;
        rlnRecDeletedEh: MTEvent := mtRowDeletedEh;
      end;
      ARowNum := ViewRecordIndexToViewRowNum(Index);
      MTViewDataEvent(ARowNum, MTEvent, -1);
    end;
  end;

begin
  if Active then
  begin
    ViewDataEventToMTEvent;
    Resync([]);
  end;
end;

procedure TCustomMemTableEh.ViewRecordMovedEvent(MemRec: TMemoryRecordEh; OldIndex, NewIndex: Integer);
var
  ARowNum, OldRowNum: Integer;
begin
  if Active and not ControlsDisabled then
  begin
    ARowNum := ViewRecordIndexToViewRowNum(NewIndex);
    OldRowNum := ViewRecordIndexToViewRowNum(OldIndex);
    MTViewDataEvent(ARowNum, mtRowMovedEh, OldRowNum);
  end;
end;

procedure TCustomMemTableEh.MTApplyUpdates(AMemTableData: TMemTableDataEh);
begin
  InternalApplyUpdates(AMemTableData, -1);
end;

procedure TCustomMemTableEh.MTStructChanged(AMemTableData: TMemTableDataEh);
var
  OldDataDriver: TDataDriverEh;
begin
  OldDataDriver := nil;
  if Active then
  begin
    if DataDriver <> nil then
    begin
      OldDataDriver := DataDriver;
      DataDriver := nil;
    end;
    try
      if Active then
      begin
        Close;
        if (DataDriver <> nil) or (RecordsView.MemTableData.DataStruct.Count > 0) then
          Open;
      end;
    finally
      if OldDataDriver <> nil then
        DataDriver := OldDataDriver;
    end;
  end;
end;

procedure TCustomMemTableEh.MTCalcLookupBuffer(Item: TMemoryRecordEh;
  RecView: TMemRecViewEh);
var
  I: Integer;
  SaveState: TDataSetState;
  IsHaveLookup: Boolean;
  f: TField;
begin
  IsHaveLookup := False;
  for I := 0 to Fields.Count - 1 do
  begin
    f := Fields[I];
    if f.FieldKind in [fkCalculated, fkLookup] then
      IsHaveLookup := True;
  end;

  if (IsHaveLookup = False) or not IsCursorOpen then Exit;

  SaveState := SetTempState(dsFilter);
  try
    RecView.SetLookupBufferLength(FieldCount);
    RecordToBuffer(Item, dvvValueEh, {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}(TempBuffer), -1);
    BufferToRecBuf({$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}(TempBuffer)).RecView := RecView;
    BufferToRecBuf({$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}(TempBuffer)).NeedUpdateCalcFields := True;
    BufferToRecBuf({$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}(TempBuffer)).RecordNumber := FRecordsView.IndexOfRec(Item);
    try
      GetCalcFields(TempBuffer);
    finally
    end;
  finally
    RestoreState(SaveState);
  end;
end;

procedure TCustomMemTableEh.SetReadOnly(const Value: Boolean);
begin
  if FReadOnly <> Value then
  begin
    FReadOnly := Value;
    DataEvent(deDataSetChange, {$IFDEF CIL}nil{$ELSE}0{$ENDIF});
  end;
end;

{ Blobs }

function TCustomMemTableEh.GetBlobData(Field: TField; Buffer: TMTRecBuf): TMemBlobData;
begin
  if VarIsNull(Buffer.Value[Field])
    then Result := ''
    else Result := Buffer.Value[Field];
end;

procedure TCustomMemTableEh.SetBlobData(Field: TField; Buffer: TMTRecBuf; Value: TMemBlobData);
begin
  if (Buffer = BufferToRecBuf({$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}(ActiveBuffer))) then
  begin
    if State = dsFilter then
      Error(SNotEditing);
    Buffer.Value[Field] := Value;
  end;
end;

procedure TCustomMemTableEh.CloseBlob(Field: TField);
begin
end;

function TCustomMemTableEh.CreateBlobStream(Field: TField; Mode: TBlobStreamMode): TStream;
begin
  Result := TMemBlobStreamEh.Create(Field as TBlobField, Mode);
end;

{ Bookmarks }

function TCustomMemTableEh.BookmarkToRec(Bookmark: TUniBookmarkEh): TMemoryRecordEh;
begin
{$IFDEF EH_LIB_12}
  Result := TBookmarkDataEh((@Bookmark[0])^).MemRec;
{$ELSE}
  {$IFDEF FPC}
  Result := TBookmarkDataEh((@Bookmark[0])^).MemRec;
  {$ELSE}
  Result := TBookmarkDataEh((@Bookmark[1])^).MemRec;
{$ENDIF}
{$ENDIF}
end;

function TCustomMemTableEh.RecToBookmark(Rec: TMemoryRecordEh): TUniBookmarkEh;
{$IFDEF EH_LIB_12}
var
  PR: PByte;
  bmd: TBookmarkDataEh;
begin
  bmd.MemRec := Rec;
  bmd.RecViewIndex := -1;
  SetLength(Result, BookmarkSize);
  PR := PByte(Result);
  Move(bmd, PR^, BookmarkSize);
end;
{$ELSE}
var
  PR: PChar;
  bmd: TBookmarkDataEh;
begin
  bmd.MemRec := Rec;
  bmd.RecViewIndex := -1;
  Result := NilBookmarkEh;
  SetLength(Result, BookmarkSize);
  PR := PChar(Result);
  Move(bmd, PR^, SizeOf(Integer));
end;
{$ENDIF}

function TCustomMemTableEh.BookmarkToRecNo(Bookmark: TBookmark): Integer;
var
  pbmd: PBookmarkDataEh;
begin
  pbmd := PBookmarkDataEh(Bookmark);
  if (pbmd.RecViewIndex >= 0) and
     (pbmd.RecViewIndex < RecordsView.Count) and
     (RecordsView[pbmd.RecViewIndex] = pbmd.MemRec)
  then
    Result := pbmd.RecViewIndex + 1
  else
    Result := RecordsView.IndexOfRec(pbmd.MemRec) + 1;
end;

function TCustomMemTableEh.UniBookmarkToRecNo(Bookmark: TUniBookmarkEh): Integer;
begin
  Result := BookmarkToRecNo(TBookmark(Bookmark));
end;

{$IFDEF NEXTGEN}
{$ELSE}
function TCustomMemTableEh.BookmarkStrToRecNo(Bookmark: TBookmarkStr): Integer;
begin
  Result := BookmarkToRecNo(TBookmark(Bookmark));
end;
{$ENDIF}

procedure TCustomMemTableEh.FixBookmarkDataCache({$IFDEF CIL}const{$ENDIF} Bookmark: TBookmark);
var
  RecIdx: Integer;
  pbmd: PBookmarkDataEh;
begin
  pbmd := PBookmarkDataEh(Bookmark);
  if (pbmd.RecViewIndex >= 0) and
     (pbmd.RecViewIndex < RecordsView.Count) and
     (RecordsView[pbmd.RecViewIndex] = pbmd.MemRec)
{ TODO : implement this part. }
  then
  else
  begin
    RecIdx := RecordsView.IndexOfRec(pbmd.MemRec);
    if RecIdx >= 0
      then pbmd.RecViewIndex := RecIdx
      else pbmd.RecViewIndex := -1;
    RecIdx := RecordsView.IndexOfSortedListRec(pbmd.MemRec);
    if RecIdx >= 0
      then pbmd.InSortedListIndex := RecIdx
      else pbmd.InSortedListIndex := -1;
  end;
end;

function TCustomMemTableEh.BookmarkValid({$IFDEF CIL}const{$ENDIF} Bookmark: TBookmark): Boolean;
var
  pbmd: PBookmarkDataEh;
begin
  if Bookmark = nil then
    Result := False
  else
  begin
    FixBookmarkDataCache(Bookmark);
    pbmd := PBookmarkDataEh(Bookmark);
    if pbmd.InSortedListIndex >= 0
      then Result := True
      else Result := False;
  end;
end;

function TCustomMemTableEh.BookmarkInVisibleView({$IFDEF CIL}const{$ENDIF} Bookmark: TUniBookmarkEh): Boolean;
var
  Bkmrk: TBookmark;
begin
  Bkmrk := TBookmark(Bookmark);
  if BookmarkValid(Bkmrk) and (PBookmarkDataEh(Bkmrk).RecViewIndex >= 0)
    then Result := True
    else Result := False;
end;

function TCustomMemTableEh.UniBookmarkValid(Bookmark: TUniBookmarkEh): Boolean;
begin
  Result := BookmarkValid(TBookmark(Bookmark));
end;

{$IFDEF NEXTGEN}
{$ELSE}
function TCustomMemTableEh.BookmarkStrValid({$IFDEF CIL}const{$ENDIF} Bookmark: TBookmarkStr): Boolean;
begin
  Result := BookmarkValid(TBookmark(Bookmark));
end;
{$ENDIF}

function TCustomMemTableEh.CompareBookmarks({$IFDEF CIL}const{$ENDIF} Bookmark1, Bookmark2: TBookmark): Integer;
var
  pbmd1, pbmd2: PBookmarkDataEh;
begin
  if (Bookmark1 = nil) and (Bookmark2 = nil) then
    Result := 0
  else if (Bookmark1 <> nil) and (Bookmark2 = nil) then
    Result := 1
  else if (Bookmark1 = nil) and (Bookmark2 <> nil) then
    Result := -1
  else
  begin
    FixBookmarkDataCache(Bookmark1);
    FixBookmarkDataCache(Bookmark2);
    pbmd1 := PBookmarkDataEh(Bookmark1);
    pbmd2 := PBookmarkDataEh(Bookmark2);

    if pbmd1.InSortedListIndex > pbmd2.InSortedListIndex then
      Result := 1
    else if pbmd1.InSortedListIndex < pbmd2.InSortedListIndex then
      Result := -1
    else Result := 0;
  end;
end;

function TCustomMemTableEh.GetBookmark: TBookmark;
{$IFDEF CIL}
{$ENDIF}
begin
  if FInstantReadMode then
  begin
{$IFDEF CIL}
{$ELSE}
{$IFDEF TBookMarkAsTBytes}
    Result := nil;
    SetLength(Result, BookmarkSize);
{$ELSE}
    GetMem(Result, BookmarkSize);
{$ENDIF}
    GetBookmarkData(InstantBuffer, Result);
{$ENDIF}
  end else
    Result := inherited GetBookmark;
end;

{$IFDEF NEXTGEN}
{$ELSE}
function TCustomMemTableEh.GetBookmarkStr: TBookmarkStr;
{$IFDEF CIL}
var
  TempPtr: intPtr;
{$ENDIF}
begin
  if FInstantReadMode then
  begin
{$IFDEF CIL}
    TempPtr := Marshal.AllocHGlobal(BookmarkSize);
    try
      InitializeBuffer(TempPtr, BookmarkSize, 0);
      GetBookmarkData(InstantBuffer, TempPtr);
      Result := Marshal.PtrToStringAnsi(TempPtr, BookmarkSize);
    finally
      Marshal.FreeHGlobal(TempPtr);
    end;
{$ELSE}
    SetLength(Result, BookmarkSize);
    GetBookmarkData(InstantBuffer, Pointer(Result));
{$ENDIF}
  end else
    Result := inherited GetBookmarkStr;
end;
{$ENDIF}

{$IFDEF EH_LIB_17}
procedure TCustomMemTableEh.GetBookmarkData(Buffer: {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}; Data: TBookmark);
begin
  Move(BufferToRecBuf(Buffer).BookmarkData, Data[0], BookmarkSize);
end;
{$ELSE}
procedure TCustomMemTableEh.GetBookmarkData(
{$IFDEF CIL}
  Buffer: TRecordBuffer; var Bookmark: TBookmark
{$ELSE}
{$IFDEF EH_LIB_12}
  Buffer: TRecordBuffer; Data: Pointer
{$ELSE}
  Buffer: PChar; Data: Pointer
{$ENDIF}
{$ENDIF}
  );
begin
{$IFDEF EH_LIB_12}
  Move(BufferToRecBuf(Buffer).BookmarkData, Data^, BookmarkSize);
{$ELSE}
  Move(BufferToRecBuf(Buffer).BookmarkData, Data^, BookmarkSize);
{$ENDIF}
end;
{$ENDIF}

{$IFDEF EH_LIB_17}
procedure TCustomMemTableEh.SetBookmarkData(Buffer: {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}; Data: TBookmark);
var
  bmd: TBookmarkDataEh;
begin
  Move(Data[0], bmd, BookmarkSize);
  BufferToRecBuf(Buffer).BookmarkData := bmd;
end;
{$ELSE}
procedure TCustomMemTableEh.SetBookmarkData(
{$IFDEF CIL}
  Buffer: TRecordBuffer; const Bookmark: TBookmark
{$ELSE}
{$IFDEF EH_LIB_12}
  Buffer: TRecordBuffer; Data: Pointer
{$ELSE}
  Buffer: PChar; Data: Pointer
{$ENDIF}
{$ENDIF}
  );
begin
{$IFDEF CIL}
  BufferToRecBuf(Buffer).Bookmark := Marshal.ReadInt32(BookMark);
{$ELSE}
{$IFDEF EH_LIB_12}
  Move(Data^, BufferToRecBuf(Buffer).BookmarkData, BookmarkSize);
{$ELSE}
  Move(Data^, BufferToRecBuf(Buffer).BookmarkData, BookmarkSize);
{$ENDIF}
{$ENDIF}
end;
{$ENDIF}

function TCustomMemTableEh.GetBookmarkFlag(
{$IFDEF EH_LIB_12}
  Buffer: {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}): TBookmarkFlag;
{$ELSE}
  Buffer: {$IFDEF CIL}TRecordBuffer{$ELSE}PChar{$ENDIF}): TBookmarkFlag;
{$ENDIF}
begin
  Result := BufferToRecBuf(Buffer).BookmarkFlag;
end;

procedure TCustomMemTableEh.SetBookmarkFlag(
{$IFDEF EH_LIB_12}
  Buffer: {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}; Value: TBookmarkFlag);
{$ELSE}
  Buffer: {$IFDEF CIL}TRecordBuffer{$ELSE}PChar{$ENDIF}; Value: TBookmarkFlag);
{$ENDIF}
begin
  BufferToRecBuf(Buffer).BookmarkFlag := Value;
end;

procedure TCustomMemTableEh.InternalGotoBookmarkData(var BookmarkData: TBookmarkDataEh);
var
  ARecIdx: Integer;
  ARec: TMemoryRecordEh;
begin
  ARec := BookmarkData.MemRec;
  ARecIdx := RecordsView.IndexOfRec(ARec);
  if (ARecIdx >= 0) and (ARecIdx < FRecordsView.ViewItemsCount)
    then FRecordPos := ARecIdx
    {$IFDEF FPC}
    else DatabaseError(SNoSuchRecord, Self);
    {$ELSE}
    else DatabaseError(SRecordNotFound, Self);
    {$ENDIF}
  FInstantReadCurRowNum := FRecordPos;
end;

procedure TCustomMemTableEh.BookmarkToBookmarkData(Bookmark: TBookmark; var BookmarkData: TBookmarkDataEh);
begin
{$IFDEF TBookMarkAsTBytes}
  Move(Bookmark[0], BookmarkData, BookmarkSize);
{$ELSE}
  Move(Bookmark^, BookmarkData, BookmarkSize);
{$ENDIF}
end;

{$IFDEF EH_LIB_17}
procedure TCustomMemTableEh.InternalGotoBookmark(Bookmark: TBookmark);
{$ELSE}
{$IFDEF EH_LIB_12}
procedure TCustomMemTableEh.InternalGotoBookmark(Bookmark: Pointer);
{$ELSE}
{$IFDEF FPC}
procedure TCustomMemTableEh.InternalGotoBookmark(Bookmark: Pointer);
{$ELSE}
procedure TCustomMemTableEh.InternalGotoBookmark({$IFDEF CIL}const{$ENDIF} Bookmark: TBookmark);
{$ENDIF}
{$ENDIF}
{$ENDIF}
var
  BookmarkData: TBookmarkDataEh;
begin
  BookmarkToBookmarkData(Bookmark, BookmarkData);
  InternalGotoBookmarkData(BookmarkData);
end;

function TCustomMemTableEh.InstantReadIndexOfBookmark(Bookmark: TUniBookmarkEh): Integer;
{$IFDEF CIL}
var
  TempPtr: IntPtr;
{$ENDIF}
begin
{$IFDEF CIL}
  try
    TempPtr := Marshal.StringToHGlobalAnsi(Bookmark);
    Result := IndexOfBookmark(TempPtr);
  finally
    Marshal.FreeHGlobal(TempPtr);
  end;
{$ELSE}
  Result := IndexOfBookmark(TBookmark(Bookmark));
{$ENDIF}
end;

function TCustomMemTableEh.IndexOfBookmark(Bookmark: TBookmark): Integer;
begin
  if Bookmark = nil then
    Result := -1
  else
    Result := BookmarkToRecNo(Bookmark) - 1;
end;

{ Navigation }

{$IFDEF EH_LIB_12}
procedure TCustomMemTableEh.InternalSetToRecord(Buffer: {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF});
{$ELSE}
procedure TCustomMemTableEh.InternalSetToRecord(Buffer: {$IFDEF CIL}TRecordBuffer{$ELSE}PChar{$ENDIF});
{$ENDIF}
begin
{$IFDEF CIL}
{$ELSE}
  InternalGotoBookmarkData(BufferToRecBuf(Buffer).BookmarkData);
{$ENDIF}
end;

procedure TCustomMemTableEh.InternalFirst;
begin
  FRecordPos := -1;
  FInstantReadCurRowNum := 0;
end;

procedure TCustomMemTableEh.InternalLast;
begin
  BeginRecordsViewUpdate;
  try
    DoFetchRecords(-1);
  finally
    EndRecordsViewUpdate(False);
  end;
  FRecordPos := FRecordsView.ViewItemsCount;
  if State in dsEditModes
    then FInstantReadCurRowNum := FRecordsView.ViewItemsCount 
    else FInstantReadCurRowNum := FRecordPos - 1;
end;

{ Data Manipulation }

{$IFDEF EH_LIB_17}
procedure TCustomMemTableEh.InternalAddRecord(Buffer: {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}; Append: Boolean);
{$ELSE}
procedure TCustomMemTableEh.InternalAddRecord(Buffer: {$IFDEF CIL}TRecordBuffer{$ELSE}Pointer{$ENDIF}; Append: Boolean);
{$ENDIF}
var
  RecPos: Integer;
  ARec: TMemoryRecordEh;
begin

  if Append then
  begin
    ARec := FRecordsView.NewRecord;
    try
      SetMemoryRecordData(Buffer, ARec);
      FRecordsView.AddRecord(ARec);
    except
      ARec.Free;
      raise;
    end;
    FRecordPos := FRecordsView.IndexOfRec(ARec);
  end else
  begin
    ARec := FRecordsView.NewRecord;
    try
      SetMemoryRecordData(Buffer, ARec);
      if FRecordPos = -1
        then RecPos := 0
        else RecPos := FRecordPos;
      FRecordsView.InsertRecord(RecPos, ARec);
    except
      ARec.Free;
      raise;
    end;

    if not CachedUpdates then
      try
        InternalApplyUpdates(FRecordsView.MemTableData, -1);
      except
        FRecordsView.CancelUpdates;
        raise;
      end;
    FRecordPos := FRecordsView.IndexOfRec(ARec);
  end;
  if FRecordPos >= 0 then
    SetRecViewLookupBuffer(Buffer, FRecordsView.RecordView[FRecordPos]);
  if csDesigning in ComponentState then
    UpdateDesigner;
end;

procedure TCustomMemTableEh.InternalCancel;
var
  RecBuf: TMTRecBuf;
begin
  BeginRecordsViewUpdate;
  try
  if (State = dsEdit) and (FRecordsView.ViewRecord[FRecordPos].EditState = resEditEh) then
    FRecordsView.ViewRecord[FRecordPos].Cancel;
  if not CachedUpdates and FRecordsView.MemTableData.RecordsList.HasCachedChanges then
    CancelUpdates;
  finally
    EndRecordsViewUpdate(False);
  end;
  if (State = dsEdit) then
  begin
    RecBuf := BufferToRecBuf({$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}(ActiveBuffer));
    RecBuf.UseMemRec := True;
  end;
end;

procedure TCustomMemTableEh.InternalEdit;
var
  RecBuf: TMTRecBuf;
begin
  RecBuf := BufferToRecBuf({$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}(ActiveBuffer));
  RecBuf.NeedUpdateCalcFields := True;
  inherited InternalEdit;
end;

procedure TCustomMemTableEh.InternalPost;
var
  ARec: TMemoryRecordEh;
begin
  inherited InternalPost;
  BeginRecordsViewUpdate;
  try
    UpdateCursorPos;
    if State = dsEdit then
    begin
      ARec := FRecordsView.ViewRecord[FRecordPos];
      ARec.Edit;
      SetMemoryRecordData({$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}(ActiveBuffer), ARec);
      ARec.Post;
      if not CachedUpdates then
        InternalApplyUpdates(FRecordsView.MemTableData, -1);
      FRecordPos := FRecordsView.IndexOfRec(ARec);
      if FRecordPos >= 0 then
        SetRecViewLookupBuffer({$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}(ActiveBuffer), FRecordsView.RecordView[FRecordPos]);
    end else
      InternalAddRecord(ActiveBuffer, Eof);
  finally
    EndRecordsViewUpdate(False);
  end;
  if csDesigning in ComponentState then
    UpdateDesigner;
end;

procedure TCustomMemTableEh.InternalDelete;
begin
  BeginRecordsViewUpdate;
  try
    FRecordsView.DeleteRecord(FRecordPos);
    if not CachedUpdates then
      try
        InternalApplyUpdates(FRecordsView.MemTableData, -1);
      except
        FRecordsView.CancelUpdates;
        raise;
      end;

    if FRecordPos >= FRecordsView.ViewItemsCount then
      Dec(FRecordPos);
  finally
    EndRecordsViewUpdate(False);
  end;
end;

procedure TCustomMemTableEh.CreateFields;
var
  I: Integer;
  Field: TField;
  DataField: TMTDataFieldEh;
  fd: TFieldDef;

  procedure SetKeyFields;
  var
    Pos, j: Integer;
    KeyFields, FieldName: string;
  begin
    KeyFields := PSGetKeyFields;
    Pos := 1;
    while Pos <= Length(KeyFields) do
    begin
      FieldName := ExtractFieldName(KeyFields, Pos);
      for j := 0 to FieldCount - 1 do
        if AnsiCompareText(FieldName, Fields[j].FieldName) = 0 then
        begin
          Fields[j].ProviderFlags := Fields[j].ProviderFlags + [pfInKey];
          break;
        end;
    end;
  end;

begin
  {$IFDEF FPC}
  {$ELSE}
  if ObjectView then
  begin
    for I := 0 to FieldDefs.Count - 1 do
    begin
      if not ((faHiddenCol in FieldDefs[I].Attributes) and not FIeldDefs.HiddenFields) then
        FieldDefs[I].CreateField(Self);
    end;
  end else
{$ENDIF}
  begin
    {$IFDEF FPC}
    for I := 0 to FieldDefs.Count - 1 do
    {$ELSE}
    for I := 0 to FieldDefList.Count - 1 do
    {$ENDIF}
    begin
      Field := nil;
      {$IFDEF FPC}
      fd := FieldDefs[I];
      {$ELSE}
      fd := FieldDefList[I];
      {$ENDIF}
      if {(DataType <> ftUnknown) and}
        {$IFDEF FPC}
        {$ELSE}
        not (fd.DataType in ObjectFieldTypes) and
        {$ENDIF}
        not ((faHiddenCol in fd.Attributes) and
        not FIeldDefs.HiddenFields)
      then
      {$IFDEF FPC}
        Field := fd.CreateField(Self);
      {$ELSE}
        Field := fd.CreateField(Self, nil, FieldDefList.Strings[I]);
      {$ENDIF}
      if (Field <> nil) then
      begin
        {$IFDEF FPC}
        DataField :=  FRecordsView.MemTableData.DataStruct.FieldByName(FieldDefs.Items[I].Name);
        {$ELSE}
        DataField :=  FRecordsView.MemTableData.DataStruct.FieldByName(FieldDefList.Strings[I]);
        {$ENDIF}
        if DataField <> nil then
          DataField.AssignPropsTo(Field);
      end;
    end;
  end;
  SetKeyFields;
end;

procedure TCustomMemTableEh.OpenCursor(InfoQuery: Boolean);
begin
  if not InfoQuery then
  begin
    if  DataDriver <> nil then
    begin
      if (MasterSource <> nil) and (MasterDetailSide in [mdsOnProviderEh, mdsOnSelfAfterProviderEh]) then
        SetParamsFromCursor;
      FDataSetReader := FDataDriver.GetDataReader;
      if FDataSetReader <> nil then
        FDataSetReader.FreeNotification(Self);
    end;
    if DataDriver <> nil then
    begin
      if not (mtoPersistentStructEh in Options) then
      begin
        if FieldCount = 0
          then DataDriver.BuildDataStruct(FRecordsView.MemTableData.DataStruct)
          else FRecordsView.MemTableData.DataStruct.BuildStructFromFields(Fields)
      end else
        FRecordsView.MemTableData.ResetRecords;
    end else
    begin
      if FRecordsView.MemTableData.IsEmpty then
        DatabaseError('MemTable doesn''t have data.', Self);
    end;
    CreateIndexesFromDefs;
    FActive := True;
  end;
  inherited OpenCursor(InfoQuery);
  if not InfoQuery then
  begin
    InternalRefreshFilter;
    Resync([]);
  end;
end;

procedure TCustomMemTableEh.InternalOpen;
begin
  BookmarkSize := SizeOf(TBookmarkDataEh);
  FieldDefs.Updated := False;
  FieldDefs.Update;
  if DefaultFields then
    CreateFields;
  BindFields(True);
  if FieldCount = 0 then
    DatabaseError('No fields defined. Cannot create dataset.');
  InitBufferPointers(True);
  InternalFirst;
  UpdateDetailMode(False);
  RecreateFilterExpr;
  FRecordsView.UpdateFields;
  FRecordsView.Aggregates.Reset;
  FRecordsView.SortOrder := FSortOrder;
  if (ExternalMemData = nil) and InternalCalcFields then
  begin
    FRecordsView.MemTableData.OnFieldCalculation := CalcInternalFieldProg;
    FRecordsView.MemTableData.RecordsList.Indexes.UpdateIndexes;
  end else
    FRecordsView.MemTableData.OnFieldCalculation := nil;
end;

procedure TCustomMemTableEh.InternalClose;
begin
  FMasterValList.Clear;
  FActive := False;
  DestroyFilterExpr;
  FAutoInc := 1;
  FRecordsView.Aggregates.Reset;
  BindFields(False);
  if DefaultFields then
    DestroyFields;

  FDataSetReader := nil;
  if DataDriver <> nil then
    DataDriver.ConsumerClosed(Self);
end;

procedure TCustomMemTableEh.InternalHandleException;
begin
  Application.HandleException(Self);
end;

procedure TCustomMemTableEh.InternalInitFieldDefs;
var
  TempMemTableData: TMemTableDataEh;
begin
  if not FActive and (csDesigning in ComponentState) and (DataDriver <> nil) then
  begin
    TempMemTableData := TMemTableDataEh.Create(nil);
    DataDriver.BuildDataStruct(TempMemTableData.DataStruct);
    TempMemTableData.DataStruct.BuildFieldDefsFromStruct(FieldDefs);
    TempMemTableData.Free;
  end else
    FRecordsView.MemTableData.DataStruct.BuildFieldDefsFromStruct(FieldDefs);
end;

procedure TCustomMemTableEh.InitFieldDefs;
begin
  inherited InitFieldDefs;
end;

function TCustomMemTableEh.IsCursorOpen: Boolean;
begin
  Result := FActive;
end;

{ Informational }

function TCustomMemTableEh.GetRecordCount: Integer;
begin
  CheckActive;
  Result := FRecordsView.ViewItemsCount;
end;

function TCustomMemTableEh.GetRecNo: Integer;
var
  RecBuf: TMTRecBuf;
begin
  CheckActive;
  Result := -1;
  if not GetActiveRecBuf(RecBuf)
    then Exit
    else Result := RecBuf.RecordNumber + 1;
end;

procedure TCustomMemTableEh.SetRecNo(Value: Integer);
begin
  if (Value > 0) and (Value <= FRecordsView.ViewItemsCount) then
  begin
    DoBeforeScroll;
    FRecordPos := Value - 1;
    Resync([]);
    DoAfterScroll;
  end;
end;

function TCustomMemTableEh.IsSequenced: Boolean;
begin
  Result := True;
end;

function TCustomMemTableEh.FindRec(const KeyFields: string;
  const KeyValues: Variant; Options: TLocateOptions; StartRecIndex: Integer = 0;
  TryUseIndex: Boolean = True): Integer;

var
  Fields: TFieldListEh;
  I, RecIndex: Integer;
  UseRecordBuffer: Boolean;
  MTIndex: TMTIndexEh;
  FieldNo: Integer;
  AField: TField;

  function CompareField(Field: TField; Value: Variant): Boolean;
  var
    S,VS: string;
  begin
    if (loPartialKey in Options) or
       (Field.DataType in [ftString, ftWideString, ftMemo, ftFmtMemo {$IFDEF EH_LIB_10} ,ftWideMemo {$ENDIF}]) then
    begin
      S := Field.AsString;
      VS := VarToStr(Value);
      if (loPartialKey in Options) then
{$IFDEF CIL}
        Borland.Delphi.System.Delete(S, Length(VS) + 1, MaxInt);
{$ELSE}
        System.Delete(S, Length(VS) + 1, MaxInt);
{$ENDIF}
      if (loCaseInsensitive in Options) then
        Result := AnsiCompareText(S, VS) = 0
      else
        Result := AnsiCompareStr(S, VS) = 0;
    end
    else
      Result := VarEquals(Field.Value, Value);
  end;

  function CompareRecord: Boolean;
  var
    I: Integer;
  begin
    if Fields.Count = 0 then
      Result := False
    else if Fields.Count = 1 then
      Result := CompareField(TField(Fields.First), KeyValues)
    else begin
      Result := True;
      for I := 0 to Fields.Count - 1 do
        Result := Result and CompareField(TField(Fields[I]), KeyValues[I]);
    end;
  end;

  function CompareRecValues(const RecData: TRecDataValues; const VarValues: Variant): Boolean;
  var
    I: Integer;
  begin
    if Fields.Count = 0 then
      Result := False
    else if Fields.Count = 1 then
      Result := VarEquals(RecData[TField(Fields.First).FieldNo-1], VarValues)
    else begin
      Result := True;
      for I := 0 to Fields.Count - 1 do
        Result := Result and VarEquals(RecData[TField(Fields[I]).FieldNo-1], VarValues[I]);
    end;
  end;

  function VarEqualsAsRefObjectField(const V1, V2: Variant): Boolean;
  var
    RefObj1, RefObj2: TObject;
  begin
    RefObj1 := VariantToRefObject(V1);
    RefObj2 := VariantToRefObject(V2);
    Result := (RefObj1 = RefObj2)
  end;


begin
  Result := -1;
  UseRecordBuffer := False;
  MTIndex := nil;
  Fields := TFieldListEh.Create;
  try
    GetFieldList(Fields, KeyFields);

    if Options <> [] then
      UseRecordBuffer := True
    else
      for I := 0 to Fields.Count-1 do
        if TField(Fields[I]).FieldNo <= 0 then
        begin
          UseRecordBuffer := True;
          Break;
        end;

    if not UseRecordBuffer and TryUseIndex then
      MTIndex := FRecordsView.MemTableData.RecordsList.Indexes.GetIndexForFields(KeyFields);

    if UseRecordBuffer then
    begin
      for I := StartRecIndex to RecordCount-1 do
      begin
        InstantReadEnter(I);
        try
          if CompareRecord then
          begin
            Result := I;
            Break;
          end;
        finally
          InstantReadLeave;
        end;
      end
    end else
    begin
      if MTIndex <> nil then
      begin
        if MTIndex.FindRecordIndexByKey(KeyValues, RecIndex) then
          Result := FRecordsView.IndexOfRec(FRecordsView.MemTableData.RecordsList[RecIndex])
      end else
      begin
        AField := TField(Fields.First);
        FieldNo := AField.FieldNo-1;
        for I := StartRecIndex to FRecordsView.Count-1 do
        begin
          if Fields.Count = 1 then
          begin
            if (AField is TRefObjectField) then
            begin
              if VarEqualsAsRefObjectField(
                   TMemoryRecordEhCrack(FRecordsView.Rec[i]).Data[FieldNo],
                   KeyValues)
              then
              begin
                Result := I;
                Break;
              end;
            end else if VarEquals(
                          TMemoryRecordEhCrack(FRecordsView.Rec[i]).Data[FieldNo],
                          KeyValues)
            then
            begin
              Result := I;
              Break;
            end
          end else if CompareRecValues(TMemoryRecordEhCrack(FRecordsView.Rec[i]).Data,
                                   KeyValues)
          then
            begin
              Result := I;
              Break;
            end
        end;
      end;
    end;

    while (Result = -1) and (DataDriver <> nil) and not DataDriver.ProviderEOF do
    begin
      BeginRecordsViewUpdate;
      try
        DoFetchRecords(1);
      finally
        EndRecordsViewUpdate(False);
      end;

      InstantReadEnter(RecordCount-1);
      try
        if CompareRecord then
          Result := RecordCount-1;
      finally
        InstantReadLeave;
      end;
    end;

  finally
    Fields.Free;
  end;
end;

function TCustomMemTableEh.FindRecord(Restart, GoForward: Boolean): Boolean;
begin
  Result := False;
  DatabaseError('FindRecord is not supported');
end;

function TCustomMemTableEh.Locate(const KeyFields: string;
  const KeyValues: Variant; Options: TLocateOptions): Boolean;
var
  FindedRecPos: Integer;
begin

  Result := False;

  CheckBrowseMode;
  if BOF and EOF then Exit;

  FindedRecPos := FindRec(KeyFields, KeyValues, Options);
  if FindedRecPos <> -1 then
  begin
    BeginRecordsViewUpdate;
    DoBeforeScroll;
    FRecordPos := FindedRecPos;
    Result := True;
    Resync([rmExact, rmCenter]);
    EndRecordsViewUpdate(True);
    DoAfterScroll;
  end;
end;

function TCustomMemTableEh.Lookup(const KeyFields: string;
  const KeyValues: Variant; const ResultFields: string): Variant;
var
  FindedRecPos: Integer;
begin
  Result := Unassigned;

  FRecordsView.CatchChanged := False;

  FindedRecPos := FindRec(KeyFields, KeyValues, []);
  if FindedRecPos <> -1 then
  begin
    InstantReadEnter(FindedRecPos);
    try
      Result := FieldValues[ResultFields];
    finally
      InstantReadLeave;
    end;
  end;

  if FRecordsView.CatchChanged then
    Resync([]);
end;

function TCustomMemTableEh.LookupAll(const KeyFields: string;
  const KeyValues: Variant; const ResultFields: string; Options: TLocateOptions): Variant;
var
  FindedRecPos: Integer;
  RecIndex: Integer;
  TmpVar: Variant;
begin
  Result := Unassigned;

  FRecordsView.CatchChanged := False;

  RecIndex := 0;

  while True do
  begin
    FindedRecPos := FindRec(KeyFields, KeyValues, [], RecIndex, False);
    if FindedRecPos <> -1 then
    begin
      InstantReadEnter(FindedRecPos);
      try
        if VarIsClear(Result) then
          Result := FieldValues[ResultFields]
        else
        begin
          if VarIsArray(Result) then
          begin
            VarArrayRedim(Result, VarArrayHighBound(Result, 1) + 1);
            Result[VarArrayHighBound(Result, 1)] := FieldValues[ResultFields];
          end else
          begin
            TmpVar := Result;
            Result := VarArrayCreate([0, 1], varVariant);
            Result[0] := TmpVar;
            Result[VarArrayHighBound(Result, 1)] := FieldValues[ResultFields];
          end;
        end;
      finally
        InstantReadLeave;
      end;
      RecIndex := FindedRecPos + 1;
    end else
      Break;
  end;

  if FRecordsView.CatchChanged then
    Resync([]);
end;

{ Table Manipulation }

procedure TCustomMemTableEh.EmptyTable;
begin
  if Active then
  begin
    BeginRecordsViewUpdate;
    try
      CheckBrowseMode;
      ClearBuffers;
      ClearRecords;
    finally
      EndRecordsViewUpdate(True);
    end;
  end;
end;

procedure TCustomMemTableEh.DestroyTable;
begin
  Close;
  FRecordsView.MemTableData.DestroyTable;
end;

procedure TCustomMemTableEh.CopyStructure(Source: TDataSet);

  procedure CheckDataTypes(FieldDefs: TFieldDefs);
  var
    I: Integer;
  begin
    for I := FieldDefs.Count - 1 downto 0 do
    begin
      if not (FieldDefs.Items[I].DataType in ftSupported) then
        FreeObjectEh(FieldDefs.Items[I])
      else
      {$IFDEF FPC}
      {$ELSE}
         CheckDataTypes(FieldDefs[I].ChildDefs);
      {$ENDIF}
    end;
  end;

var
  I: Integer;
begin
  CheckInactive;
  for I := FieldCount - 1 downto 0 do
    FreeObjectEh(Fields[I]);
  if (Source = nil) then Exit;
  Source.FieldDefs.Update;
  FieldDefs := Source.FieldDefs;
  CheckDataTypes(FieldDefs);
end;

procedure TCustomMemTableEh.FetchRecord(DataSet: TDataSet);
var
  ARec: TMemoryRecordEh;
  i: Integer;
  Field: TField;
begin
  CheckBrowseMode;

  ARec := FRecordsView.NewRecord;

  for i := 0 to FieldCount-1 do
    if Fields[i].FieldNo > 0 then
    begin
      Field := DataSet.FindField(Fields[i].FieldName);
      if Field <> nil then
        ARec.Value[Fields[i].FieldNo-1, dvvValueEh] := Field.Value;
    end;

  FRecordsView.MemTableData.RecordsList.FetchRecord(ARec);
end;

procedure AssignRecord(Source, Destinate: TDataSet);
var
  i: Integer;
  Field: TField;
begin
  for i := 0 to Destinate.FieldCount-1 do
    if Destinate.Fields[i].FieldNo > 0 then
    begin
      Field := Source.FindField(Destinate.Fields[i].FieldName);
      if Field <> nil then
        Destinate.Fields[i].Value := Field.Value;
    end;
end;

function TCustomMemTableEh.LoadFromDataSet(Source: TDataSet; RecordCount: Integer;
  Mode: TLoadMode; UseCachedUpdates: Boolean): Integer;
var
  DatasetFeatures: TDatasetFeaturesEh;
begin
  DatasetFeatures := GetDatasetFeaturesForDataSet(Source);
  if DatasetFeatures <> nil
    then Result := DatasetFeatures.WriteDataSetToMemTable(Source, Self, RecordCount, Mode, UseCachedUpdates)
    else Result := DefaultLoadFromDataSet(Source, RecordCount, Mode, UseCachedUpdates);
end;

function TCustomMemTableEh.DefaultLoadFromDataSet(Source: TDataSet; RecordCount: Integer;
  Mode: TLoadMode; UseCachedUpdates: Boolean): Integer;

  procedure AssignLoadRecord(Source, Destinate: TDataSet);
  var
    i: Integer;
    Field: TField;
  begin
    for i := 0 to Destinate.FieldCount-1 do
      if Destinate.Fields[i].FieldNo > 0 then
      begin
        Field := Source.FindField(Destinate.Fields[i].FieldName);
        if (Mode = lmAppend) and (
        {$IFDEF FPC}
        {$ELSE}
            (Destinate.Fields[i].AutoGenerateValue = arAutoInc) or
        {$ENDIF}
            (Destinate.Fields[i] is TAutoIncField)
            )
        then
          Continue;
        if Field <> nil then
          Destinate.Fields[i].Value := Field.Value;
      end;
  end;

  procedure LoadFetchRecord(DataSet: TDataSet; FieldsIndArr: array of integer);
  var
    ARec: TMemoryRecordEh;
    i: Integer;
    Field: TField;
  begin
    ARec := FRecordsView.NewRecord;

    for i := 0 to FieldCount-1 do
      if Fields[i].FieldNo > 0 then
      begin
       if FieldsIndArr[i] >= 0 then
         Field := DataSet.Fields[FieldsIndArr[i]]
       else
         Field := nil;

        if (Mode = lmAppend) and
          (
          {$IFDEF FPC}
          {$ELSE}
             (Fields[i].AutoGenerateValue = arAutoInc) or
          {$ENDIF}
            (Fields[i] is TAutoIncField) )
        then
          ARec.Value[Fields[i].FieldNo-1, dvvValueEh] := FRecordsView.MemTableData.AutoIncrement.Promote
        else if Field <> nil then
          ARec.Value[Fields[i].FieldNo-1, dvvValueEh] := Field.Value;
      end;

    FRecordsView.MemTableData.RecordsList.FetchRecord(ARec);
  end;

var
  FieldsIndArr: array of integer;
  SourceActive: Boolean;
  MovedCount: Integer;
  i : Integer;
  Field: TField;
begin
  Result := 0;
  if Source = Self then Exit;
  SourceActive := Source.Active;
  Source.DisableControls;
  try
    DisableControls;
    try
      Source.Open;
      Source.CheckBrowseMode;
      Source.UpdateCursorPos;
      if Mode in [lmCopyStructureOnly, lmCopy] then
      begin
        Close;
        FRecordsView.MemTableData.DestroyTable;
        FRecordsView.MemTableData.DataStruct.BuildStructFromFields(Source.Fields);
        FieldDefs.Update;
      end;
      if lmCopyStructureOnly = Mode then
        Exit;
      if not Active then Open;
      CheckBrowseMode;
      if RecordCount > 0 then
        MovedCount := RecordCount
      else
      begin
        Source.First;
        MovedCount := MaxInt;
      end;

      if (Source.IsEmpty or Source.EOF) then Exit;

      SetLength(FieldsIndArr, FieldCount);
      for i := 0 to FieldCount-1 do
      begin
        Field := Source.FindField(Fields[i].FieldName);
        if Field = nil then
          FieldsIndArr[i] := -1
        else
          FieldsIndArr[i] := Field.Index;
      end;

      try
        while not Source.EOF do
        begin
          if UseCachedUpdates and CachedUpdates then
          begin
            Append;
            AssignLoadRecord(Source, Self);
            Post;
          end else
            LoadFetchRecord(Source, FieldsIndArr);
          Inc(Result);
          if Result >= MovedCount then Break;
          Source.Next;
        end;
      finally
        First;
      end;
    finally
      EnableControls;
    end;
  finally
    if not SourceActive then
      Source.Close;
    Source.EnableControls;
  end;
end;

function TCustomMemTableEh.LoadFromMemTableEh(Source: TCustomMemTableEh;
  RecordCount: Integer; Mode: TLoadMode; LoadOptions: TMemTableLoadOptionsEh): Integer;
var
  FromRec, ToRec: Integer;
  i, j: Integer;
  NewRec: TMemoryRecordEh;
  WasActive: Boolean;
  FieldName: String;
  DataField: TMTDataFieldEh;
  SourceRec: TMemoryRecordEh;
  Field: TField;
begin
  Result := 0;
  WasActive := Active;

  DisableControls;
  try
  if Mode in [lmCopy, lmCopyStructureOnly] then
  begin
    Close;
    FRecordsView.MemTableData.DestroyTable;
    FRecordsView.MemTableData.DataStruct.Assign(Source.RecordsView.MemTableData.DataStruct);
    for i := 0 to Source.FieldCount-1 do
    begin
      DataField := FRecordsView.MemTableData.DataStruct.FindField(Source.Fields[i].FieldName);
      if DataField <> nil then
      begin
        DataField.DisplayLabel := Source.Fields[i].DisplayLabel;
        DataField.Alignment := Source.Fields[i].Alignment;
        DataField.Visible := Source.Fields[i].Visible;
      end;
    end;
  end;

  if lmCopyStructureOnly = Mode then
  begin
    FromRec := 0;
    ToRec := -1;
  end else if RecordCount > 0 then
  begin
    if tloDisregardFilterEh in LoadOptions then
    begin
      FromRec := Source.RecordsView.MemTableData.RecordsList.IndexOf(Source.Rec);
      ToRec := FromRec + RecordCount - 1;
      if ToRec > Source.RecordsView.MemTableData.RecordsList.Count-1 then
        ToRec := Source.RecordsView.MemTableData.RecordsList.Count-1;
    end else
    begin
      if Source.RecordsView.ViewAsTreeList
        then FromRec := Source.RecordsView.MemoryTreeList.AccountableItems.IndexOf(Source.RecView)
        else FromRec := Source.RecordsView.IndexOfRec(Source.Rec);
      ToRec := FromRec + RecordCount - 1;
      if Source.RecordsView.ViewAsTreeList then
      begin
        if ToRec > Source.RecordsView.MemoryTreeList.AccountableItems.Count-1 then
          ToRec := Source.RecordsView.MemoryTreeList.AccountableItems.Count-1;
      end else if ToRec > Source.RecordsView.Count-1 then
        ToRec := Source.RecordsView.Count-1;
    end;
  end else
  begin
    FromRec := 0;
    if tloDisregardFilterEh in LoadOptions then
      ToRec := Source.RecordsView.MemTableData.RecordsList.Count-1
    else if Source.RecordsView.ViewAsTreeList then
      ToRec := Source.RecordsView.MemoryTreeList.AccountableItems.Count-1
    else
      ToRec := Source.RecordsView.Count-1;
  end;

  RecordsView.MemTableData.RecordsList.BeginUpdate;
  try
  if tloDisregardFilterEh in LoadOptions then
    for i := FromRec to ToRec do
    begin
      NewRec := RecordsView.MemTableData.RecordsList.NewRecord;
      for j := 0 to Source.RecordsView.MemTableData.DataStruct.Count-1 do
        if Mode = lmAppend then
        begin
          FieldName := Source.RecordsView.MemTableData.DataStruct[j].FieldName;
          if RecordsView.MemTableData.DataStruct.FindField(FieldName) <> nil then
            NewRec.DataValues[Source.RecordsView.MemTableData.DataStruct[j].FieldName, dvvValueEh] :=
              Source.RecordsView.MemTableData.RecordsList[i].Value[j, dvvValueEh];
        end else
          NewRec.Value[j, dvvValueEh] :=
            Source.RecordsView.MemTableData.RecordsList[i].Value[j, dvvValueEh];
      if tloUseCachedUpdatesEh in LoadOptions
        then RecordsView.AddRecord(NewRec)
        else RecordsView.MemTableData.RecordsList.FetchRecord(NewRec);
      Inc(Result);
    end
  else
    for i := FromRec to ToRec do
    begin
      NewRec := RecordsView.MemTableData.RecordsList.NewRecord;
      if Source.RecordsView.ViewAsTreeList
        then SourceRec := Source.RecordsView.MemoryTreeList.AccountableItem[i].Rec
        else SourceRec := Source.RecordsView[i];

      for j := 0 to Source.RecordsView.MemTableData.DataStruct.Count-1 do
        if Mode = lmAppend then
        begin
          FieldName := Source.RecordsView.MemTableData.DataStruct[j].FieldName;
          if RecordsView.MemTableData.DataStruct.FindField(FieldName) <> nil then
          begin
            NewRec.DataValues[Source.RecordsView.MemTableData.DataStruct[j].FieldName, dvvValueEh] :=
              SourceRec.Value[j, dvvValueEh];
          end;
        end else
          NewRec.Value[j, dvvValueEh] := SourceRec.Value[j, dvvValueEh];
      if tloUseCachedUpdatesEh in LoadOptions
        then RecordsView.AddRecord(NewRec)
        else RecordsView.MemTableData.RecordsList.FetchRecord(NewRec);
      Inc(Result);
    end;
  finally
    RecordsView.MemTableData.RecordsList.EndUpdate;
  end;
  if tloOpenOnLoad in LoadOptions then
    Open
  else if WasActive <> Active then
    Active := WasActive;

  if Active then
    for i := 0 to Source.FieldCount-1 do
    begin
      Field := FindField(Source.Fields[i].FieldName);
      if Field <> nil then Field.Index := Source.Fields[i].Index;
    end;
  finally
    EnableControls;
  end;
end;

function TCustomMemTableEh.SaveToDataSet(Dest: TDataSet; RecordCount: Integer): Integer;
var
  MovedCount: Integer;
begin
  Result := 0;
  if Dest = Self then Exit;
  CheckBrowseMode;
  UpdateCursorPos;
  Dest.DisableControls;
  try
    DisableControls;
    try
      if not Dest.Active
        then Dest.Open
        else Dest.CheckBrowseMode;
      if RecordCount > 0 then
        MovedCount := RecordCount
      else
      begin
        First;
        MovedCount := MaxInt;
      end;
      try
        while not EOF do
        begin
          Dest.Append;
          AssignRecord(Self, Dest);
          Dest.Post;
          Inc(Result);
          if Result >= MovedCount then Break;
          Next;
        end;
      finally
        Dest.First;
      end;
    finally
      EnableControls;
    end;
  finally
    Dest.EnableControls;
  end;
end;

procedure TCustomMemTableEh.SaveToFile(const FileName: string = '';
  Format: TDfmStreamFormatEh = dfmTextEh);
var
  fs: TFileStream;
begin
  fs := TFileStream.Create(FileName, fmCreate);
  SaveToStream(fs, Format);
  fs.Free;
end;

procedure TCustomMemTableEh.LoadFromFile(const FileName: string = '');
var
  fs: TFileStream;
begin
  fs := TFileStream.Create(FileName, fmOpenRead);
  try
    LoadFromStream(fs);
  finally
    fs.Free;
  end;
end;

procedure TCustomMemTableEh.SaveToStream(Stream: TStream; Format: TDfmStreamFormatEh = dfmTextEh);
var
  ss: TStringStream;
begin
  FRecordsView.MemTableData.StoreStructInStream := True;
  FRecordsView.MemTableData.StoreRecordsInStream := True;
  if Format = dfmTextEh then
  begin
    ss := TStringStream.Create('');
    ss.WriteComponent(RecordsView.MemTableData);
    ss.Position := 0;
    ObjectBinaryToText(ss, Stream);
    ss.Free;
  end else
    Stream.WriteComponent(RecordsView.MemTableData);
end;

procedure TCustomMemTableEh.LoadFromStream(Stream: TStream);
var
  ms: TMemoryStream;
  OldActive: Boolean;
begin
  OldActive := Active;
  if TestStreamFormat(Stream) = sofUnknown then
    raise Exception.Create('Invalid stream format.');

  if TestStreamFormat(Stream) = sofText then
  begin
    ms := TMemoryStream.Create;
    try
      ObjectTextToBinary(Stream, ms);
      ms.Position := 0;
      DestroyTable;
      ms.ReadComponent(RecordsView.MemTableData);
    finally
      ms.Free;
    end;
  end else
  begin
    DestroyTable;
    Stream.ReadComponent(RecordsView.MemTableData);
  end;

  Active := OldActive;
end;

procedure TCustomMemTableEh.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if AComponent = ExternalMemData then
      ExternalMemData := nil;
    if AComponent = FDataSetReader then
      FDataSetReader := nil;
    if AComponent = FDataDriver then
      DataDriver := nil;
  end;
end;

procedure TCustomMemTableEh.InternalRefresh;
begin
  DisableControls;
  try
  if DataDriver <> nil then
  begin
    DataDriver.RefreshReader;

    if (MasterSource <> nil) and (MasterDetailSide in [mdsOnProviderEh, mdsOnSelfAfterProviderEh]) then
      SetParamsFromCursor;
    FDataSetReader := FDataDriver.GetDataReader;
    if FDataSetReader <> nil then
      FDataSetReader.FreeNotification(Self);

    BeginRecordsViewUpdate;
    try
      ClearRecords;
      if FetchAllOnOpen
        then DoFetchRecords(-1)
        else DoFetchRecords(1);
    finally
      EndRecordsViewUpdate(False);
    end;
  end;
  InternalRefreshFilter;
  finally
    EnableControls;
  end;
end;

procedure TCustomMemTableEh.InternalRefreshFilter;
var
  MTIndex: TMTIndexEh;
begin
  FDetailRecListActive := False;
  if FDetailMode then
  begin
    MTIndex := FRecordsView.MemTableData.RecordsList.Indexes.GetIndexForFields(DetailFields);
    if MTIndex <> nil then
    begin
      FDetailRecList.Clear;
      MTIndex.FillMatchedRecsList(FMasterValues, FDetailRecList);
{ TODO : Get indexes from FRecordsView }
      FDetailRecListActive := True;
    end;
  end;
  BeginRecordsViewUpdate;
  try
    
    FRecordsView.RefreshFilteredRecsList(True);
    FRecordsView.RefreshFilteredRecsTreeList;
    
  finally
    EndRecordsViewUpdate(False);
  end;
  FDetailRecListActive := False;
  ClearBuffers;
  InternalFirst;
  GetNextRecord;
  GetNextRecords;
  MTViewDataEvent(-1, mtViewDataChangedEh, -1);
  DataEvent(deDataSetChange, 0);
end;

procedure TCustomMemTableEh.UpdateDetailMode(AutoRefresh: Boolean);
var
  NewDetailMode: Boolean;
begin
  NewDetailMode := False;
  if Fields.Count > 0 then
  begin
    FDetailFieldList.Clear;
    GetFieldList(FDetailFieldList, DetailFields);
    if MasterDetailSide in [mdsOnSelfEh, mdsOnSelfAfterProviderEh] then
    begin
      if (FDetailFieldList.Count > 0) and FMasterDataLink.Active and
        (FMasterDataLink.Fields.Count > 0)
      then
        NewDetailMode := True;
    end else if FMasterDataLink.Active then
      NewDetailMode := True;
  end;
  if NewDetailMode <> FDetailMode then
  begin
    FDetailMode := NewDetailMode;
    if not FDetailMode then
      FMasterValues := Unassigned
    else
      if MasterDetailSide in [mdsOnSelfEh, mdsOnSelfAfterProviderEh] then
      FMasterValues := MasterSource.DataSet.FieldValues[MasterFields];
    if AutoRefresh then
      if MasterDetailSide in [mdsOnProviderEh, mdsOnSelfAfterProviderEh]
        then RefreshParams
        else InternalRefreshFilter;
  end;
end;

procedure TCustomMemTableEh.MasterChange(Sender: TObject);
var
  OldDetailMode: Boolean;
begin
  OldDetailMode := FDetailMode;
  UpdateDetailMode(False);
  case  MasterDetailSide of
    mdsOnProviderEh:
      RefreshParams;
    mdsOnSelfEh:
      begin
        if (OldDetailMode <> FDetailMode) or
          (FDetailMode and not VarEquals(FMasterValues, MasterSource.DataSet.FieldValues[MasterFields])) then
        begin
          FMasterValues := MasterSource.DataSet.FieldValues[MasterFields];
          InternalRefreshFilter;
          Resync([]);
        end;
      end;
    mdsOnSelfAfterProviderEh:
      begin
        if (OldDetailMode <> FDetailMode) or
          (FDetailMode and not VarEquals(FMasterValues, MasterSource.DataSet.FieldValues[MasterFields])) then
        begin
          FMasterValues := MasterSource.DataSet.FieldValues[MasterFields];
          RefreshParams;
        end;
      end;
  end;
end;

function TCustomMemTableEh.GetCanModify: Boolean;
begin
  Result := not ReadOnly;
end;

procedure TCustomMemTableEh.DoOnNewRecord;
var
  i: Integer;
begin
  for i := 0 to Fields.Count-1 do
    if (Fields[i].DefaultExpression <> '') and Fields[i].CanModify then
      Fields[i].Text := Fields[i].DefaultExpression;
  if FDetailMode {and (MasterDetailSide = mdsOnSelfEh)} then
    FieldValues[FDetailFields] := MasterSource.DataSet.FieldValues[MasterFields];
  inherited DoOnNewRecord;
end;

procedure TCustomMemTableEh.SetParams(const Value: TParams);
begin
  FParams.Assign(Value);
end;

procedure TCustomMemTableEh.SetMasterDetailSide(const Value: TMasterDetailSideEh);
begin
  if (FMasterDetailSide <> Value) then
  begin
    FMasterDetailSide := Value;
    UpdateDetailMode(False);
    if FDetailMode and Active then
      if MasterDetailSide = mdsOnProviderEh then
      begin
        Close;
        Open;
      end else
        InternalRefreshFilter;
  end;
end;

procedure TCustomMemTableEh.SetParamsFromCursor;
var
  DataSet: TDataSet;
begin
  if MasterSource <> nil then
  begin
    DataSet := MasterSource.DataSet;
    if DataSet.Active and (DataSet.State <> dsSetKey) and (DataDriver <> nil) then
    begin
      DataDriver.SetReaderParamsFromCursor(DataSet);
      if MasterDetailSide=mdsOnSelfAfterProviderEh then
        FMasterValList.Add(TSortedVarItemEh.Create(Dataset.FieldValues[MasterFields]));
    end;
  end;
end;

procedure TCustomMemTableEh.RefreshParams;
var
  DataSet: TDataSet;
begin
  DisableControls;
  try
    if MasterSource <> nil then
    begin
      DataSet := MasterSource.DataSet;
      if DataSet <> nil then
      begin
        if DataSet.Active and (DataSet.State <> dsSetKey) and (DataDriver <> nil) then
        begin
          case  MasterDetailSide of
            mdsOnProviderEh:
              if DataDriver.RefreshReaderParamsFromCursor(DataSet) then
              begin
                Close;
                Open;
              end;
            mdsOnSelfAfterProviderEh:
              begin
                if  not FMasterValList.VarInList(Dataset.FieldValues[MasterFields]) then
                begin
                  DoFetchRecords(-1);
                  DataDriver.ConsumerClosed(Self);
                  SetParamsFromCursor;
                  FDataSetReader := FDataDriver.GetDataReader;
                  if FDataSetReader <> nil then
                    FDataSetReader.FreeNotification(Self);
                end;
                InternalRefreshFilter;
              end;
          end;
        end;
      end;
    end;
  finally
    EnableControls;
  end;
end;

procedure TCustomMemTableEh.FetchParams;
begin
end;

procedure TCustomMemTableEh.RefreshRecord;
var
  MemRec: TMemoryRecordEh;
begin
  CheckActive;
  UpdateCursorPos;
  if (DataDriver <> nil) and (RecordCount > 0) then
  begin
    MemRec := RecordsView.ViewRecord[FRecordPos];
    DataDriver.RefreshRecord(MemRec);

    MemRec.UpdateCalculatedFields;

    BufferToRecBuf({$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}(ActiveBuffer)).NeedUpdateCalcFields := True;
    GetCalcFields(ActiveBuffer);
    RefreshInternalCalcFields(ActiveBuffer);

    Resync([]);
  end;
end;

procedure TCustomMemTableEh.RevertRecord;
begin
  Cancel;
  CheckBrowseMode;
  UpdateCursorPos;
  if IsEmpty then
    raise Exception.Create('There are no records.');
  if FRecordsView.ViewAsTreeList
    then 
    else FRecordsView.RevertRecord(RecNo-1);
  Resync([]);
end;

function TCustomMemTableEh.UpdateStatus: TUpdateStatus;
begin
  CheckActive;
  if RecNo > 0
    then Result := FRecordsView.ViewRecord[RecNo-1].UpdateStatus
    else Result := usUnmodified;
end;

procedure TCustomMemTableEh.CalcInternalFieldProg(MemRec: TMemoryRecordEh;
  var FieldValues: TVariantArrayEh);
var
  OldState: TDataSetState;
  i: Integer;
begin
  OldState := SetTempState(dsInternalCalc);
  try
    InstantReadEnter(MemRec, -1);
    try
      BufferToRecBuf(InstantBuffer).NeedUpdateCalcFields := True;
      CalculateFields(InstantBuffer);

      for i := 0 to FieldCount-1 do
        if (Fields[i].FieldNo > 0) and (Fields[i].FieldKind = fkInternalCalc) then
          FieldValues[Fields[i].FieldNo-1] := Fields[i].Value;
    finally
      InstantReadLeave;
    end;
  finally
    RestoreState(OldState);
  end;
end;

{$IFDEF EH_LIB_12}
procedure TCustomMemTableEh.RefreshInternalCalcFields(Buffer: {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF});
{$ELSE}
procedure TCustomMemTableEh.RefreshInternalCalcFields(Buffer: PChar);
{$ENDIF}
begin
  CalculateFields(Buffer);
end;

{$IFDEF EH_LIB_17}
procedure TCustomMemTableEh.CalculateFields(Buffer: {$IFDEF NEXTGEN}NativeInt{$ELSE}PByte{$ENDIF});
{$ELSE}
{$IFDEF CIL}
procedure TCustomMemTableEh.CalculateFields(Buffer: TRecordBuffer);
{$ELSE}
{$IFDEF EH_LIB_12}
procedure TCustomMemTableEh.CalculateFields(Buffer: TRecordBuffer);
{$ELSE}
procedure TCustomMemTableEh.CalculateFields(Buffer: PChar);
{$ENDIF}
{$ENDIF}
{$ENDIF}
var
  RecBuf: TMTRecBuf;
  I: Integer;
begin
{$IFDEF EH_LIB_12}
  FCalcBuffer := {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}(Buffer);
  RecBuf := BufferToRecBuf({$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}(Buffer));
{$ELSE}
  FCalcBuffer := PChar(Buffer);
  RecBuf := BufferToRecBuf(PChar(Buffer));
{$ENDIF}

  if RecBuf.NeedUpdateCalcFields or not RecBuf.UseMemRec then
  begin
{$IFDEF EH_LIB_17}
    ClearCalcFields({$IFDEF NEXTGEN}NativeInt{$ELSE}PByte{$ENDIF}(CalcBuffer));
{$ELSE}
    ClearCalcFields(CalcBuffer);
{$ENDIF}
    for I := 0 to Fields.Count - 1 do
      if Fields[I].FieldKind = fkLookup then
        Fields[I].Value := CalcLookupValue(Fields[I]);
    DoOnCalcFields;
    RecBuf.NeedUpdateCalcFields := False;
  end;
end;

function TCustomMemTableEh.CalcLookupValue(AField: TField): Variant;
begin
  if AField.LookupCache then
    Result := AField.LookupList.ValueOfKey(FieldValues[AField.KeyFields])
  else if (AField.LookupDataSet <> nil) and AField.LookupDataSet.Active then
    Result := AField.LookupDataSet.Lookup(AField.LookupKeyFields,
      FieldValues[AField.KeyFields], AField.LookupResultField)
  else
    Result := Null;
end;

procedure TCustomMemTableEh.CancelUpdates;
begin
  FRecordsView.CancelUpdates;
  Resync([]);
end;

procedure TCustomMemTableEh.DataEvent(Event: TDataEvent; Info: TDataEventInfoTypeEh);
begin
  if Active and {FOldControlsDisabled and} not ControlsDisabled then
  begin
    if FMTViewDataEventInactiveCount > 0 then
    begin
      FMTViewDataEventInactiveCount := 0;
      MTViewDataEvent(FInactiveEventRowNum, FInactiveEvent, FInactiveEventOldRowNum);
    end;
  end;
  case Event of
    deDataSetChange: ;
    deLayoutChange:
      FRecordsView.UpdateAllLookupBuffer;
    deFieldListChange:
      begin
        if Active and not (csLoading in ComponentState) then
        begin
          FRecordsView.Aggregates.Reset;
          Resync([]);
        end;
        BindCalFields;
      end;
    deUpdateState:
      if (State = dsInsert) and (FStateInsert = False) then
      begin
        FStateInsert := True;
        MTViewDataEvent(InstantReadCurRow, mtRowInsertedEh, -1);
        FStateInsertRowNum := InstantReadCurRow;
      end else if (State = dsBrowse) and (FStateInsert = True) then
      begin
        FStateInsert := False;
        if TreeList.Active then
          MTViewDataEvent(-1, mtViewDataChangedEh, -1)
        else
          MTViewDataEvent(FStateInsertRowNum, mtRowDeletedEh, -1);
        FStateInsertRowNum := -1;
      end;
  end;
  inherited DataEvent(Event, Info);
  if Active and not FOldActive then
    MTViewDataEvent(-1, mtViewDataChangedEh, -1);
  FOldControlsDisabled := ControlsDisabled;
  FOldActive := Active;
end;

procedure TCustomMemTableEh.CreateIndexesFromDefs;
var
  I: Integer;
  Index: TMTIndexEh;
begin
  for I := 0 to IndexDefs.Count - 1 do
  begin
    Index := FRecordsView.MemTableData.RecordsList.Indexes.Add;
    Index.Fields := IndexDefs[i].Fields;
    Index.Unique := ixUnique in IndexDefs[i].Options;
    Index.Primary := ixPrimary in IndexDefs[i].Options;
  end;
  for I := 0 to IndexDefs.Count - 1 do
    FRecordsView.MemTableData.RecordsList.Indexes.Items[i].Active := True;
end;

function TCustomMemTableEh.CreateMemTableData: TMemTableDataEh;
begin
  Result := TMemTableDataEh.Create(Self);
end;

procedure TCustomMemTableEh.CreateDataSet;
begin
  CheckInactive;
  if Fields.Count > 0 then FieldDefs.Clear;
  InitFieldDefsFromFields;
  FRecordsView.MemTableData.DestroyTable;
  FRecordsView.MemTableData.DataStruct.BuildStructFromFieldDefs(FieldDefs);
  SetExtraStructParams;
  CreateIndexesFromDefs;
  Open;
end;

procedure TCustomMemTableEh.SetExtraFilters(const Value: TMemTableFiltersEh);
begin
  FExtraFilters.Assign(Value);
end;

procedure TCustomMemTableEh.SetExtraStructParams;
var
  i: Integer;
begin
  for i := 0 to FRecordsView.MemTableData.DataStruct.Count - 1 do
  begin
    if FRecordsView.MemTableData.DataStruct[i].FieldName = FAutoIncrementFieldName then
      FRecordsView.MemTableData.DataStruct[i].AutoIncrement := True;
  end;
end;

procedure TCustomMemTableEh.GetChildren(Proc: TGetChildProc; Root: TComponent);
begin
  inherited GetChildren(Proc, Root);
  if (DataDriver = nil) and (ExternalMemData = nil) and not FRecordsView.MemTableData.IsEmpty then
  begin
    FRecordsView.MemTableData.StoreStructInStream := True;
    FRecordsView.MemTableData.StoreRecordsInStream := True;
    Proc(FRecordsView.MemTableData)
  end else if (DataDriver <> nil) and (ExternalMemData = nil) and (mtoPersistentStructEh in Options) then
  begin
    FRecordsView.MemTableData.StoreStructInStream := True;
    FRecordsView.MemTableData.StoreRecordsInStream := False;
    Proc(FRecordsView.MemTableData)
  end else
  begin
    FRecordsView.MemTableData.StoreStructInStream := True;
    FRecordsView.MemTableData.StoreRecordsInStream := True;
  end;
end;

procedure TCustomMemTableEh.AncestorNotFound(Reader: TReader;
  const ComponentName: string; ComponentClass: TPersistentClass;
  var Component: TComponent);
begin
  if (ComponentName = 'MemTableData') and (Reader.Root <> nil) then
    Component := FRecordsView.MemTableData;
end;

procedure TCustomMemTableEh.CreateComponent(Reader: TReader;
  ComponentClass: TComponentClass; var Component: TComponent);
begin
  if ComponentClass.InheritsFrom(TMemTableDataEh) then
    Component := FRecordsView.MemTableData;
end;

procedure TCustomMemTableEh.ReadState(Reader: TReader);
var
  OldOnCreateComponent: TCreateComponentEvent;
  OldOnAncestorNotFound: TAncestorNotFoundEvent;
begin
  OldOnCreateComponent := Reader.OnCreateComponent;
  OldOnAncestorNotFound := Reader.OnAncestorNotFound;
  Reader.OnCreateComponent := CreateComponent;
  Reader.OnAncestorNotFound := AncestorNotFound;

  try
    inherited ReadState(Reader);
  finally
    Reader.OnCreateComponent := OldOnCreateComponent;
    Reader.OnAncestorNotFound := OldOnAncestorNotFound;
  end;
end;

{$IFDEF FPC}
{$ELSE}
procedure TCustomMemTableEh.ResetAggField(Field: TField);
var
  I: Integer;
  Agg: TMTAggregateEh;
  AggF: TAggregateField;
begin
  for I := 0 to AggFields.Count - 1 do
    if AggFields[I] = Field then
    begin
      AggF := AggFields[I] as TAggregateField;
      Agg := TMTAggregateEh(AggF.Handle);
      if Agg <> nil then
      begin
        FRecordsView.Aggregates.BeginUpdate;
        Agg.Assign(AggF);
        FRecordsView.Aggregates.EndUpdate;
        Agg.Reset;
        Agg.Recalc;
        if Active then
          DataEvent(deDataSetChange, {$IFDEF CIL}nil{$ELSE}0{$ENDIF});
      end;
    end;
end;

function TCustomMemTableEh.GetAggregateValue(Field: TField): Variant;
var
 Agg: TMTAggregateEh;
 RecBuf: TMTRecBuf;
begin
  Result := Null;
  if AggregatesActive and GetActiveRecBuf(RecBuf) then
  begin
    Agg := TMTAggregateEh(TAggregateField(Field).Handle);
    if Agg <> nil then
      Result := Agg.Value;
  end;
end;

procedure TCustomMemTableEh.SetAggregatesActive(const Value: Boolean);
begin
  if AggregatesActive <> Value then
  begin
    FRecordsView.Aggregates.Active := Value;
    if Active then
    begin
      if AggFields.Count > 0 then
      begin
        UpdateCursorPos;
        Resync([]);
      end;
    end;
  end;
end;
{$ENDIF}

function TCustomMemTableEh.GetAggregatesActive: Boolean;
begin
  Result := FRecordsView.Aggregates.Active;
end;

function TCustomMemTableEh.CreateDeltaDataSet: TCustomMemTableEh;
begin
  Result := TCustomMemTableEh.Create(nil);
  Result.FieldDefs := FieldDefs;
  Result.CachedUpdates := True;
  Result.CreateDataSet;
end;

procedure TCustomMemTableEh.BindCalFields;
var
  i, k: Integer;
begin
  SetLength(FCalcFieldIndexes, Fields.Count);
  k := 0;
  for i := 0  to Fields.Count-1 do
    if Fields[i].FieldKind in [fkCalculated, fkLookup] then
    begin
      FCalcFieldIndexes[i] := k;
      Inc(k)
    end else
      FCalcFieldIndexes[i] := -1;
end;

procedure TCustomMemTableEh.BindFields(Binding: Boolean);
begin
  inherited BindFields(Binding);
end;

procedure TCustomMemTableEh.SetDataDriver(const Value: TDataDriverEh);
var
  ConsumerItfs: IDataDriverConsumerEh;
  {$IFDEF FPC}
  {$ELSE}
  Msg: TCMChanged;
  {$ENDIF}
begin
  if Value <> FDataDriver then
  begin

    if (Value <> nil) and (ExternalMemData <> nil) then
      raise Exception.Create('Assigning to DataDriver is not allowed if ExternalMemData is assigned');

    ConsumerItfs := nil;
    if Assigned(FDataDriver) then
      if Supports(TObject(FDataDriver), IDataDriverConsumerEh, ConsumerItfs) then
        ConsumerItfs.DataDriverConsumer := nil;
    FDataDriver := Value;
    if Assigned(FDataDriver) then
    begin
      { If another dataset already references this updateobject, then
        remove the reference }
      if Supports(TObject(FDataDriver), IDataDriverConsumerEh, ConsumerItfs) then
      begin
        if Assigned(ConsumerItfs.DataDriverConsumer) and
          (ConsumerItfs.DataDriverConsumer is TMemTableEh) and
          (ConsumerItfs.DataDriverConsumer <> Self)
        then
          (ConsumerItfs.DataDriverConsumer as TMemTableEh).DataDriver := nil;
        ConsumerItfs.DataDriverConsumer := Self;
      end;
      DriverStructChanged;
      FRecordsView.OnApplyUpdates := MTApplyUpdates;
    end else
    begin
      if FRecordsView <> nil then
        FRecordsView.OnApplyUpdates := nil;
    end;

    if Value <> nil then Value.FreeNotification(Self);

    {$IFDEF FPC}
    {$ELSE}
    if not (csLoading in ComponentState) and (csDesigning in ComponentState) then
    begin
      Msg.Msg := CM_CHANGED;
      {$IFDEF CIL}
      {$ELSE}
      Msg.Unused := 0;
      Msg.Child := nil;
      {$ENDIF}
      Msg.Result := 0;
      if (Owner is TWinControl) then
        TWinControl(Owner).Broadcast(Msg);
    end;
    {$ENDIF}

  end;
end;

function TCustomMemTableEh.GetUpdateError: TUpdateErrorEh;
var
  RecBuf: TMTRecBuf;
begin
  CheckActive;
  Result := nil;
  if GetActiveRecBuf(RecBuf) and (RecBuf.RecordNumber >= 0)
  then
    Result := FRecordsView.ViewRecord[RecBuf.RecordNumber].UpdateError;
end;

function TCustomMemTableEh.GetAutoIncrement: TAutoIncrementEh;
begin
  Result := RecordsView.MemTableData.AutoIncrement
end;

procedure TCustomMemTableEh.SetAutoIncrement(const Value: TAutoIncrementEh);
begin
  RecordsView.MemTableData.AutoIncrement.Assign(Value);
end;

function TCustomMemTableEh.GetTreeNodeHasChields: Boolean;
var
  RecBuf: TMTRecBuf;
begin
  CheckActive;
  Result := False;
  if GetActiveRecBuf(RecBuf) and (RecBuf.RecView <> nil) then
    Result := TMemRecViewEh(RecBuf.RecView).NodeHasVisibleChildren;
end;

function TCustomMemTableEh.GetTreeNodeLevel: Integer;
var
  RecBuf: TMTRecBuf;
begin
  CheckActive;
  Result := -1;
  if GetActiveRecBuf(RecBuf) and (RecBuf.RecView <> nil) then
    Result := TMemRecViewEh(RecBuf.RecView).NodeLevel;
end;

function TCustomMemTableEh.GetPrevVisibleTreeNodeLevel: Integer;
begin
  CheckActive;
  Result := -1;
  if RecordsView.ViewAsTreeList and (RecNo > 1) then
    Result := RecordsView.MemoryTreeList.VisibleExpandedItem[RecNo-2].NodeLevel;
end;

function TCustomMemTableEh.GetNextVisibleTreeNodeLevel: Integer;
begin
  CheckActive;
  Result := -1;
  if RecNo < RecordCount then
    Result := RecordsView.MemoryTreeList.VisibleExpandedItem[RecNo].NodeLevel;
end;

function TCustomMemTableEh.MemTableIsTreeList: Boolean;
begin
  Result := RecordsView.ViewAsTreeList;
end;

function TCustomMemTableEh.IsInOperatorSupported: Boolean;
begin
  {$IFDEF FPC}
  Result := False;
  {$ELSE}
  Result := True;
  {$ENDIF} 
end;

function TCustomMemTableEh.ParentHasNextSibling(ParenLevel: Integer): Boolean;
var
  RecBuf: TMTRecBuf;
  TreeNode, CurNode: TMemRecViewEh;
begin
  CheckActive;
  Result := False;
  TreeNode := nil;
  if ParenLevel <= 0 then
    Exit;
  if GetActiveRecBuf(RecBuf) and (RecBuf.RecView <> nil) then
    TreeNode := RecBuf.RecView;
  if TreeNode = nil then
    Exit;
  CurNode := TreeNode;
  while ParenLevel < TreeNode.NodeLevel do
  begin
    CurNode := CurNode.NodeParent;
    Inc(ParenLevel);
  end;
  if RecordsView.MemoryTreeList.GetNextVisibleSibling(CurNode) <> nil
    then Result := True
    else Result := False;
end;

function TCustomMemTableEh.ParentHasPriorSibling(ParenLevel: Integer): Boolean;
var
  RecBuf: TMTRecBuf;
  TreeNode, CurNode: TMemRecViewEh;
begin
  CheckActive;
  Result := False;
  TreeNode := nil;
  if ParenLevel <= 0 then
    Exit;
  if GetActiveRecBuf(RecBuf) and (RecBuf.RecView <> nil) then
    TreeNode := RecBuf.RecView;
  if TreeNode = nil then
    Exit;
  CurNode := TreeNode;
  while ParenLevel < TreeNode.NodeLevel do
  begin
    CurNode := CurNode.NodeParent;
    Inc(ParenLevel);
  end;
  if RecordsView.MemoryTreeList.GetPriorVisibleSibling(CurNode) <> nil
    then Result := True
    else Result := False;
end;

function TCustomMemTableEh.IMemTableSetTreeNodeExpanded(RowNum: Integer; Value: Boolean): Integer;
var
  RecBuf: TMTRecBuf;
  TreeNode, ActiveTreeNode: TMemRecViewEh;
  FindedRecPos: Integer;
  ActiveHided: Boolean;
  AllowExpansion: Boolean;
begin
  CheckActive;
  Result := -1;
  if GetActiveRecBuf(RecBuf) and (RecBuf.RecView <> nil)
    then ActiveTreeNode := RecBuf.RecView
    else ActiveTreeNode := nil;
  InstantReadEnter(RowNum);
  try
    if GetActiveRecBuf(RecBuf) and (RecBuf.RecView <> nil) then
    begin
      TreeNode := RecBuf.RecView;
    end else
      Exit;
  finally
    InstantReadLeave;
  end;

  AllowExpansion := True;

  if AllowExpansion
    then TreeNode.NodeExpanded := Value
    else Exit;

  RecordsView.MemoryTreeList.BuildVisibleItems;
  ActiveHided := False;
  if ActiveTreeNode <> nil then
    while (FRecordsView.IndexOfRec(ActiveTreeNode.Rec) = -1) and (ActiveTreeNode.NodeLevel > 1) do
    begin
      ActiveTreeNode := TMemRecViewEh(ActiveTreeNode.NodeParent);
      ActiveHided := True;
    end;
  if ActiveHided then
  begin
    FindedRecPos := FRecordsView.IndexOfRec(ActiveTreeNode.Rec);
    if FindedRecPos <> -1 then
      Result := FindedRecPos + 1;
  end;
  Resync([]);
  if Active then
    DoAfterScroll;
end;

function TCustomMemTableEh.IMemTableGetTreeNodeExpanded(RowNum: Integer): Boolean;
begin
  Result := False;
end;

function TCustomMemTableEh.GetTreeNodeExpanded(RowNum: Integer): Boolean;
begin
  Result := False;
end;

function TCustomMemTableEh.GetTreeNodeExpandedProp: Boolean;
begin
  Result := GetTreeNodeExpanded;
end;

procedure TCustomMemTableEh.MTDisableControls;
begin
  DisableControls;
end;

procedure TCustomMemTableEh.MTEnableControls(ForceUpdateState: Boolean);
begin
  if ControlsDisabled then
  begin
    MTViewDataEvent(-1, mtViewDataChangedEh, -1);
    if ForceUpdateState then
      DataEvent(deDisabledStateChange, -1);
  end;
  EnableControls;
end;

function TCustomMemTableEh.GetTreeNodeHasChildren: Boolean;
var
  RecBuf: TMTRecBuf;
begin
  CheckActive;
  Result := False;
  if GetActiveRecBuf(RecBuf) and (RecBuf.RecView <> nil) then
    Result := RecBuf.RecView.NodeHasChildren;
end;

function TCustomMemTableEh.GetTreeNodeHasVisibleChildren: Boolean;
var
  RecBuf: TMTRecBuf;
begin
  CheckActive;
  Result := False;
  if GetActiveRecBuf(RecBuf) and (RecBuf.RecView <> nil) then
    Result := RecBuf.RecView.NodeHasVisibleChildren;
end;

procedure TCustomMemTableEh.SetTreeNodeHasVisibleChildren(const Value: Boolean);
var
  RecBuf: TMTRecBuf;
begin
  CheckActive;
  if GetActiveRecBuf(RecBuf) then
    if (RecBuf.RecView <> nil) then
    begin
      RecBuf.RecView.NodeHasVisibleChildren := Value;
      Resync([]);
    end else
      RecBuf.NewTreeNodeHasChildren := Value;
end;

function TCustomMemTableEh.GetTreeNodeExpanded: Boolean;
var
  RecBuf: TMTRecBuf;
begin
  CheckActive;
  Result := False;
  if GetActiveRecBuf(RecBuf) and (RecBuf.RecView <> nil) then
    Result := RecBuf.RecView.NodeExpanded;
end;

procedure TCustomMemTableEh.SetTreeNodeExpanded(const Value: Boolean);
var
  RecBuf: TMTRecBuf;
  AllowExpansion: Boolean;
  TreeNode: TMemRecViewEh;
begin
  CheckActive;
  if GetActiveRecBuf(RecBuf) then 
    if (RecBuf.RecView <> nil) then
    begin
      TreeNode := RecBuf.RecView;
      AllowExpansion := True;
      if not TreeNode.NodeExpanded and Value and Assigned(OnTreeNodeExpanding) then
        OnTreeNodeExpanding(Self, RecBuf.RecordNumber+1, AllowExpansion);
      if AllowExpansion then
        RecBuf.RecView.NodeExpanded := Value;
      Resync([]);
    end else
      RecBuf.NewTreeNodeExpanded := Value;
end;

function TCustomMemTableEh.TreeViewNodeExpanding(Sender: TBaseTreeNodeEh): Boolean;
var
  RecBuf: TMTRecBuf;
  ActiveTreeNode: TMemRecViewEh;
  ARecNo: Integer;
  MemSender: TMemRecViewEh;
begin
  MemSender := TMemRecViewEh(Sender);
  Result := True;
  if not MemSender.NodeExpanded and Assigned(OnRecordsViewTreeNodeExpanding) then
    OnRecordsViewTreeNodeExpanding(Self, MemSender, Result);
  if Active and not MemSender.NodeExpanded and Assigned(OnTreeNodeExpanding) then
  begin
    if GetActiveRecBuf(RecBuf) and (RecBuf.RecView <> nil)
      then ActiveTreeNode := RecBuf.RecView
      else ActiveTreeNode := nil;
    if Sender = ActiveTreeNode then
      OnTreeNodeExpanding(Self, RecBuf.RecordNumber + 1, Result)
    else
    begin
      ARecNo := FRecordsView.MemoryTreeList.VisibleExpandedItems.IndexOf(MemSender);
      InstantReadEnter(ARecNo);
      try
        OnTreeNodeExpanding(Self, RecBuf.RecordNumber + 1, Result);
      finally
        InstantReadLeave;
      end;
    end;
  end;
end;

procedure TCustomMemTableEh.TreeViewNodeExpanded(Sender: TBaseTreeNodeEh);
var
  MemSender: TMemRecViewEh;
begin
  MemSender := TMemRecViewEh(Sender);

  if Active then
  begin
    if ControlsDisabled then
    begin
      RecordsView.MemoryTreeList.VisibleItemsBecomeObsolete;
      MTViewDataEvent(-1, mtViewDataChangedEh, -1);
      if Assigned(OnRecordsViewTreeNodeExpanded) and MemSender.NodeExpanded then
        OnRecordsViewTreeNodeExpanded(Self, MemSender)
      else if Assigned(OnRecordsViewTreeNodeCollapsed) and not MemSender.NodeExpanded then
        OnRecordsViewTreeNodeCollapsed(Self, MemSender);
    end else
    begin
      RecordsView.MemoryTreeList.BuildVisibleItems;
      Resync([]);
      DoAfterScroll;
      MTViewDataEvent(-1, mtViewDataChangedEh, -1);
      if Assigned(OnRecordsViewTreeNodeExpanded) and MemSender.NodeExpanded then
        OnRecordsViewTreeNodeExpanded(Self, MemSender)
      else if Assigned(OnRecordsViewTreeNodeCollapsed) and not MemSender.NodeExpanded then
        OnRecordsViewTreeNodeCollapsed(Self, MemSender);
    end;
  end;
end;

function TCustomMemTableEh.CompareTreeNodes(Rec1, Rec2: TBaseTreeNodeEh; ParamSort: TObject): Integer;
begin
  Result := CompareRecords(TMemRecViewEh(Rec1).Rec, TMemRecViewEh(Rec2).Rec, ParamSort);
end;

function TCustomMemTableEh.GetTreeNodeChildCount: Integer;
var
  RecBuf: TMTRecBuf;
begin
  CheckActive;
  Result := -1;
  if GetActiveRecBuf(RecBuf) and (RecBuf.RecView <> nil) then
    Result := RecBuf.RecView.VisibleNodesCount;
end;

function TCustomMemTableEh.GetTreeNode: TMemRecViewEh;
var
  RecBuf: TMTRecBuf;
begin
  CheckActive;
  Result := nil;
  if GetActiveRecBuf(RecBuf) and (RecBuf.RecView <> nil) then
    Result := RecBuf.RecView;
end;

function TCustomMemTableEh.GetIndexDefs: TIndexDefs;
begin
  if FIndexDefs = nil then
    FIndexDefs := TIndexDefs.Create(Self);
  Result := FIndexDefs;
end;

procedure TCustomMemTableEh.SetIndexDefs(Value: TIndexDefs);
begin
  IndexDefs.Assign(Value);
end;

procedure TCustomMemTableEh.UpdateIndexDefs;
begin
  if (csDesigning in ComponentState) and (IndexDefs.Count > 0) then Exit;
  if Active and not IndexDefs.Updated then
  begin
    FieldDefs.Update;
    IndexDefs.Clear;
    IndexDefs.Updated := True;
  end;
end;

function TCustomMemTableEh.PSGetIndexDefs(IndexTypes: TIndexOptions): TIndexDefs;
begin
  Result := inherited GetIndexDefs(IndexDefs, IndexTypes);
end;

function TCustomMemTableEh.PSGetKeyFields: string;
begin
  {$IFDEF FPC}
  Result := '';
  {$ELSE}
  Result := inherited PSGetKeyFields;
  {$ENDIF}
end;

function TCustomMemTableEh.GetSortOrder: String;
begin
  Result := FSortOrder;
end;

procedure TCustomMemTableEh.SetSortOrder(const Value: String);
begin
  if FSortOrder <> Value then
  begin
    FSortOrder := Value;
    UpdateSortOrder;
  end;
end;

procedure TCustomMemTableEh.UpdateSortOrder;
begin
  if Active
    then FRecordsView.SortOrder := FSortOrder
    else FRecordsView.SortOrder := '';
end;

procedure TCustomMemTableEh.SortByFields(const SortByStr: string);
begin
  DoOrderBy(SortByStr);
end;

procedure TCustomMemTableEh.SortWithExternalProc(
  OrderValueProc: TGetOrderVarValueProcEh; DescDirections: TExternalSortDataArrEh);
var
  FOrderByList: TMTOrderByList;
  OByItem: TOrderByItemEh;
  i, j: Integer;
  v: Variant;
begin
  FOrderByList := TMTOrderByList.Create(True);
  for i := 0 to Length(DescDirections)-1 do
  begin
    OByItem := TOrderByItemEh.Create;
    OByItem.FieldIndex := -1;
    OByItem.Desc := DescDirections[i].Desc;
    OByItem.CaseIns := foCaseInsensitive in FilterOptions;
    OByItem.ExtObjIndex := i;
    OByItem.DataType := DescDirections[i].DataType;
    FOrderByList.Add(OByItem);
  end;

  SetLength(FSortingValues, FRecordsView.MemTableData.RecordsList.Count);
  for i := 0 to Length(FSortingValues)-1 do
  begin
    try
      InstantReadEnter(FRecordsView.MemTableData.RecordsList[i], -1);
      if Length(DescDirections) > 1 then
      begin
        FSortingValues[i] := VarArrayCreate([0, Length(DescDirections) - 1], varVariant);
        for j := 0 to Length(DescDirections) - 1 do
        begin
          v := Null;
          OrderValueProc(v, j);
          FSortingValues[i][j] := v;
        end;
      end else
      begin
        v := Null;
        OrderValueProc(v, 0);
        FSortingValues[i] := v;
      end;
    finally
      InstantReadLeave;
    end;
  end;

  FGetOrderVarValueProc := OrderValueProc;
  try
    SortData(FOrderByList);
  finally
    FOrderByList.Free;
    FGetOrderVarValueProc := nil;
  end;
end;

function TCustomMemTableEh.ParseOrderByStr(const OrderByStr: String): TObject;
var
  FieldName, Token: String;
  FromIndex: Integer;
  Desc: Boolean;
  OByItem: TOrderByItemEh;
  Field: TField;
begin
  Result := TMTOrderByList.Create(True);
  try
    FromIndex := 1;
    FieldName := TOrderByList(Result).GetToken(OrderByStr, FromIndex);
    if FieldName = '' then Exit;
    Field := FindField(FieldName);
    if Field = nil then
      raise Exception.Create(' Field - "' + FieldName + '" not found.');
    Desc := False;
    while True do
    begin
      Token := TOrderByList(Result).GetToken(OrderByStr, FromIndex);
      if AnsiUpperCase(Token) = 'ASC' then
        Continue
      else if AnsiUpperCase(Token) = 'DESC' then
      begin
        Desc := True;
        Continue
      end else if (Token = ';') or (Token = ',') or (Token = '') then

      else
        raise Exception.Create(' Invalid token - "' + Token + '"');

      OByItem := TOrderByItemEh.Create;
      if Field <> nil then
      begin
        OByItem.FieldIndex := Field.Index;
        OByItem.DataType := Field.DataType;
      end else
      begin
        OByItem.FieldIndex := -1;
        OByItem.DataType := ftUnknown;
      end;
      OByItem.Desc := Desc;
      OByItem.CaseIns := foCaseInsensitive in FilterOptions;
      TOrderByList(Result).Add(OByItem);

      FieldName := TOrderByList(Result).GetToken(OrderByStr, FromIndex);
      if FieldName = '' then Break;
      Field := FindField(FieldName);
      if Field = nil then
        raise Exception.Create(' Field - "' + FieldName + '" not found.');
      Desc := False;
    end;
  except
    Result.Free;
    raise;
  end;
end;

procedure TCustomMemTableEh.DoOrderBy(const OrderByStr: String);
var
  FOrderByList: TObject;
begin
  if OrderByStr = '' then Exit;
  FOrderByList := ParseOrderByStr(OrderByStr);
  try
    SortData(FOrderByList);
  finally
    FOrderByList.Free;
  end;
end;

procedure TCustomMemTableEh.SortData(ParamSort: TObject);
begin
  if Active and (FRecordsView <> nil) and (FRecordsView.ViewItemsCount > 0) {and (OrderByList.Count > 0)} then
  begin
    CheckBrowseMode;
    if FInstantReadMode then
      raise Exception.Create('Sort data in InstantReadMode is not allowed.');
    try
      if FRecordsView.ViewAsTreeList
        then FRecordsView.MemoryTreeList.SortData(CompareTreeNodes, ParamSort, True)
        else FRecordsView.MemTableData.RecordsList.SortData(CompareRecords, ParamSort);
      ClearBuffers;
    finally
    end;
{$IFDEF FPC}
    First;
{$ELSE}
    Resync([]);
{$ENDIF}
  end;
end;

function TCustomMemTableEh.CompareRecords(Rec1, Rec2: TMemoryRecordEh; ParamSort: TObject): Integer;
var
  AOrderByList: TOrderByList;

  function CheckUseRecordBuffer: Boolean;
  var
    I: Integer;
    Field: TField;
  begin
    Result := False;
    if Assigned(FGetOrderVarValueProc) then
      Result := True
    else
      for I := 0 to AOrderByList.Count-1 do
      begin
        if AOrderByList is TMTOrderByList then
        begin
          Field := Fields[AOrderByList[I].FieldIndex];
          if Field.FieldNo <= 0 then
          begin
            Result := True;
            Break;
          end;
        end;
      end;
  end;

  function GetFieldValues(Rec: TMemoryRecordEh): Variant;
  var
    I: Integer;
    UseRecordBuffer: Boolean;
    RecViewIdx: Integer;
  begin
    UseRecordBuffer := CheckUseRecordBuffer;

    if UseRecordBuffer then
    begin
      if Assigned(FGetOrderVarValueProc) then
      begin
        Result := FSortingValues[Rec.Index];
      end else
      begin
        try
          RecViewIdx := RecordsView.IndexOfRec(Rec);
          if RecViewIdx >= 0
            then InstantReadEnter(RecordsView.RecordView[RecViewIdx], -1)
            else InstantReadEnter(Rec, -1);

          if AOrderByList.Count > 1 then
          begin
            Result := VarArrayCreate([0, Fields.Count - 1], varVariant);
            for I := 0 to AOrderByList.Count - 1 do
              Result[I] := Fields[AOrderByList[I].FieldIndex].Value;
          end else
            Result := Fields[AOrderByList[0].FieldIndex].Value;

        finally
          InstantReadLeave;
        end;
      end;
    end else
    begin
      if AOrderByList.Count > 1 then
      begin
        Result := VarArrayCreate([0, Fields.Count - 1], varVariant);
        for I := 0 to AOrderByList.Count - 1 do
          if AOrderByList is TMTOrderByList then
            Result[I] := Rec.Value[Fields[AOrderByList[I].FieldIndex].FieldNo-1, dvvValueEh]
          else
            Result[I] := Rec.Value[AOrderByList[I].FieldIndex, dvvValueEh]
      end else
        if AOrderByList is TMTOrderByList then
          Result := Rec.Value[Fields[AOrderByList[0].FieldIndex].FieldNo-1, dvvValueEh]
        else
          Result := Rec.Value[AOrderByList[0].FieldIndex, dvvValueEh]
    end;
  end;

  function VarCompareValueWithString(const Data1, Data2: Variant): TVariantRelationship;
  
  var
    vt1, vt2: TVarType;
    s1, s2: String;
    r: Integer;
  begin
    vt1 := VarType(Data1);
    vt2 := VarType(Data2);
    if ((vt1 = varString) and (vt2 = varString)) or
{$IFDEF EH_LIB_12}
       ((vt1 = varUString) and (vt2 = varUString)) or
{$ENDIF}
       ((vt1 = varOleStr) and (vt2 = varOleStr))
    then
    begin
      s1 := VarToStr(Data1);
      s2 := VarToStr(Data2);
      r := AnsiCompareStr(s1,s2);
      if (r = 0) then
        Result := vrEqual
      else if  (r < 0) then
        Result := vrLessThan
      else
        Result := vrGreaterThan;
    end else
    begin
      Result := VarCompareValue(Data1, Data2);
    end;
  end;

  function CompareQuickVarValues(const Data1, Data2: Variant): Integer;
  const
    RelInrResults: array [TVariantRelationship] of Integer = (0, -1, 1, 0);
  var
    VarRel: TVariantRelationship;
  begin
    if VarIsEmpty(Data1) or VarIsNull(Data1) then
      if VarIsEmpty(Data2) or VarIsNull(Data2) then
        Result := 0
      else
        Result := -1
    else
      if VarIsEmpty(Data2) or VarIsNull(Data2) then
        Result := 1
{      else if (VarType(Data1) = varOleStr) and (VarType(Data1) = varOleStr) then
 /        Result := AnsiStrIComp(TVarData(Data1).VOleStr, TVarData(Data2).VOleStr)
        Result := WideCompareStr(TVarData(Data1).VOleStr, TVarData(Data2).VOleStr)}
      else
      begin
        VarRel := VarCompareValueWithString(Data1, Data2);
        Result := RelInrResults[VarRel];
      end;
  end;

  function CompareSimpleSortVarValues(const Data1, Data2: Variant; CaseInsensitive: Boolean): Integer;
  var
    CmpResult: Integer;
  begin
    if VarIsEmpty(Data1) or VarIsNull(Data1) then
      if VarIsEmpty(Data2) or VarIsNull(Data2) then
        Result := 0
      else
        Result := -1
    else
      if VarIsEmpty(Data2) or VarIsNull(Data2) then
        Result := 1
      else
      begin
        CmpResult := CompareQuickVarValues(Data1, Data2);
        if (not CaseInsensitive and (CmpResult = 0)) or
              (    CaseInsensitive and (AnsiCompareText(Data1, Data2) = 0)) then
          Result := 0
        else if (not CaseInsensitive and (CmpResult < 0)) or
                (    CaseInsensitive and (AnsiCompareText(Data1, Data2) < 0)) then
          Result := -1
        else
          Result := 1;
      end;
  end;

  function CompareSortItem(const Data1, Data2: Variant; OrderByItem: TOrderByItemEh): Integer;
  var
    CaseInsensitive: Boolean;
  begin
    if AOrderByList is TMTOrderByList then
      CaseInsensitive := OrderByItem.CaseIns and
        (OrderByItem.DataType in
          [ftString, ftMemo, ftFmtMemo, ftFixedChar, ftWideString, ftOraClob])
    else
      CaseInsensitive := OrderByItem.CaseIns and
        (OrderByItem.DataType in
          [ftString, ftMemo, ftFmtMemo, ftFixedChar, ftWideString, ftOraClob]);
    Result := CompareSimpleSortVarValues(Data1, Data2, CaseInsensitive);
    if OrderByItem.Desc then
      if Result = -1 then Result := 1
      else if Result = 1 then Result := -1;
  end;

var
  Data1, Data2: Variant;
  I: Integer;
  CaseInsensitive: Boolean;
  Fildex: Integer;
begin
  Result := 0;
  AOrderByList := TOrderByList(ParamSort);
  if (AOrderByList <> nil) and (AOrderByList.Count > 0) and (Fields.Count > 0) then
  begin
    if not CheckUseRecordBuffer then
    begin
        for I := 0 to AOrderByList.Count - 1 do
        begin
          if (AOrderByList[I].FieldIndex >= 0) and Active then
          begin
            CaseInsensitive := AOrderByList[I].CaseIns and
              (Fields[AOrderByList[I].FieldIndex].DataType in
               [ftString, ftMemo, ftFmtMemo, ftFixedChar, ftWideString, ftOraClob]);
            Fildex := Fields[AOrderByList[I].FieldIndex].FieldNo-1
          end else
          begin
            CaseInsensitive := AOrderByList[I].CaseIns and
               (RecordsView.MemTableData.DataStruct[AOrderByList[I].MTFieldIndex].DataType in
                [ftString, ftMemo, ftFmtMemo, ftFixedChar, ftWideString, ftOraClob]);
            Fildex := AOrderByList[I].MTFieldIndex;
          end;
          Result := CompareSimpleSortVarValues(
                        Rec1.Value[Fildex, dvvValueEh],
                        Rec2.Value[Fildex, dvvValueEh],
                        CaseInsensitive);
          if AOrderByList[I].Desc then
            if Result = -1 then Result := 1
            else if Result = 1 then Result := -1;
          if Result <> 0 then
            Exit;
        end;
        Result := Rec1.Index - Rec2.Index;
    end else
    begin
        Data1 := GetFieldValues(Rec1);
        Data2 := GetFieldValues(Rec2);

        if AOrderByList.Count > 1 then
        begin
          for I := 0 to AOrderByList.Count - 1 do
          begin
            Result := CompareSortItem(Data1[I], Data2[I], AOrderByList[I]);
            if Result <> 0 then
              Exit;
          end;
        end else
          Result := CompareSortItem(Data1, Data2, AOrderByList[0]);
        if Result = 0 then
          Result := Rec1.Index - Rec2.Index;
    end;
  end else
    Result := Rec1.Index - Rec2.Index;
end;

function TCustomMemTableEh.GetDataFieldsCount: Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to FieldCount-1 do
    if Fields[i].FieldNo > 0 then
      Inc(Result);
end;

procedure TCustomMemTableEh.InstantReadEnter(RecView: TMemRecViewEh; RowNum: Integer);
begin

{$IFDEF EH_LIB_17}
  {$IFDEF NEXTGEN}
  FInstantBuffers.Add(AllocRecBuf);
  {$ELSE}
  FInstantBuffers.Add(AllocRecordBuffer);
  {$ENDIF}
{$ELSE}
  FInstantBuffers.Add(TObject(AllocRecordBuffer));
{$ENDIF}

  FInstantReadMode := True;
  BufferToRecBuf(InstantBuffer).NeedUpdateCalcFields := True;

  RecordToBuffer(RecView.Rec, dvvValueEh, InstantBuffer, RowNum);
  BufferToRecBuf(InstantBuffer).RecView := RecView;
  BufferToRecBuf(InstantBuffer).RecordNumber := RowNum;
  BufferToRecBuf(InstantBuffer).MemRec := RecView.Rec;
end;

procedure TCustomMemTableEh.InstantReadEnter(MemRec: TMemoryRecordEh; RowNum: Integer);
begin
{$IFDEF EH_LIB_17}
  {$IFDEF NEXTGEN}
  FInstantBuffers.Add(AllocRecBuf);
  {$ELSE}
  FInstantBuffers.Add(AllocRecordBuffer);
  {$ENDIF}
{$ELSE}
  FInstantBuffers.Add(TObject(AllocRecordBuffer));
{$ENDIF}

  FInstantReadMode := True;
  BufferToRecBuf(InstantBuffer).NeedUpdateCalcFields := True;

  RecordToBuffer(MemRec, dvvValueEh, InstantBuffer, RowNum);
  BufferToRecBuf(InstantBuffer).RecView := nil;
  BufferToRecBuf(InstantBuffer).RecordNumber := RowNum;
  BufferToRecBuf(InstantBuffer).MemRec := MemRec;
end;

procedure TCustomMemTableEh.InstantReadEnter(RowNum: Integer);
var
  RecBuf: TMTRecBuf;
begin
{$IFDEF EH_LIB_17}
  {$IFDEF NEXTGEN}
  FInstantBuffers.Add(AllocRecBuf);
  {$ELSE}
  FInstantBuffers.Add(AllocRecordBuffer);
  {$ENDIF}
{$ELSE}
  FInstantBuffers.Add(TObject(AllocRecordBuffer));
{$ENDIF}

  FInstantReadMode := True;
  if (State in [dsEdit, dsInsert]) and (RowNum = FInstantReadCurRowNum) then
  begin
    CopyBuffer({$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}(ActiveBuffer), InstantBuffer);
    if State = dsInsert then
    begin
      RecBuf := BufferToRecBuf(InstantBuffer);
      RecBuf.RecordNumber := -1;
      RecBuf.RecView := nil;
      RecBuf.MemRec := nil;
      RecBuf.BookmarkData.MemRec := nil;
      RecBuf.BookmarkData.RecViewIndex := -1;
    end;
  end else if FRecordsView.ViewItemsCount = 0 then
  begin
    InternalInitRecord(InstantBuffer);
  end else
  begin
    if (State = dsInsert) and (RowNum > FInstantReadCurRowNum) then
      Dec(RowNum);
    if BufferToRecBuf(InstantBuffer).RecordNumber <> RowNum then
    begin
      RecordToBuffer(FRecordsView.ViewRecord[RowNum], dvvValueEh, InstantBuffer, RowNum);
      RecBuf := BufferToRecBuf(InstantBuffer);
      if FRecordsView.ViewAsTreeList
        then RecBuf.RecView := TMemRecViewEh(FRecordsView.MemoryTreeList.VisibleExpandedItems[RowNum])
        else RecBuf.RecView := TMemRecViewEh(FRecordsView.MemoryViewList[RowNum]);
      RecBuf.RecordNumber := RowNum;
      RecBuf.MemRec := FRecordsView.ViewRecord[RowNum];
      RecBuf.BookmarkData.MemRec := RecBuf.MemRec;
      RecBuf.BookmarkData.RecViewIndex := RecBuf.RecordNumber;
    end;
  end;
end;

procedure TCustomMemTableEh.InstantReadLeave;
var
{$IFDEF CIL}
  Buffer: TRecordBuffer;
{$ELSE}
{$IFDEF EH_LIB_12}
  Buffer: {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF};
{$ELSE}
  Buffer: PChar;
{$ENDIF}
{$ENDIF}
begin
  if FInstantBuffers.Count = 0 then
    raise Exception.Create('TCustomMemTableEh not in instant read mode.');
{$IFDEF CIL}
  Buffer := TRecordBuffer(FInstantBuffers[FInstantBuffers.Count-1]);
{$ELSE}
{$IFDEF EH_LIB_12}
  Buffer := {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}(FInstantBuffers[FInstantBuffers.Count-1]);
{$ELSE}
  Buffer := PChar(FInstantBuffers[FInstantBuffers.Count-1]);
{$ENDIF}
{$ENDIF}
  {$IFDEF NEXTGEN}
  FreeRecBuf(Buffer);
  {$ELSE}
  FreeRecordBuffer(Buffer);
  {$ENDIF}
  FInstantBuffers.Delete(FInstantBuffers.Count-1);
  FInstantReadMode := (FInstantBuffers.Count > 0);
end;

function TCustomMemTableEh.InstantReadViewRow: Integer;
begin
  if FInstantBuffers.Count = 0 then
    Result := InstantReadCurRow
  else
  begin
    Result := BufferToRecBuf(GetInstantBuffer).RecordNumber;
    if State = dsInsert then
    begin
      if Result = -1 then
        Result := FInstantReadCurRowNum
      else if Result >= FInstantReadCurRowNum then
        Inc(Result);
    end;
  end;
end;

{$IFDEF CIL}
function TCustomMemTableEh.GetInstantBuffer: TRecordBuffer;
{$ELSE}
{$IFDEF EH_LIB_12}
function TCustomMemTableEh.GetInstantBuffer: {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF};
{$ELSE}
function TCustomMemTableEh.GetInstantBuffer: PChar;
{$ENDIF}
{$ENDIF}
begin
{$IFDEF NEXTGEN}
  Result := 0;
{$ELSE}
  Result := nil;
{$ENDIF}
  if FInstantBuffers.Count > 0 then
{$IFDEF CIL}
    Result := TRecordBuffer(FInstantBuffers[FInstantBuffers.Count-1]);
{$ELSE}
{$IFDEF EH_LIB_12}
    Result := {$IFDEF NEXTGEN}TRecBuf{$ELSE}TRecordBuffer{$ENDIF}(FInstantBuffers[FInstantBuffers.Count-1]);
{$ELSE}
    Result := PChar(FInstantBuffers[FInstantBuffers.Count-1]);
{$ENDIF}
{$ENDIF}
end;

procedure TCustomMemTableEh.InternalInsert;
begin
  if GetBookmarkFlag(ActiveBuffer) = bfEOF then
  begin
    if (DataDriver <> nil) and not DataDriver.ProviderEOF then
    begin
      Resync([]);
      raise Exception.Create('Attempt to append a record before all records have been read from DataDriver.');
    end;
    FInstantReadCurRowNum := FRecordsView.ViewItemsCount;
  end;
end;

function TCustomMemTableEh.GetInstantReadCurRowNum: Integer;
begin
  UpdateCursorPos;
  Result := FInstantReadCurRowNum;
end;

function TCustomMemTableEh.InstantReadRowCount: Integer;
begin
  if FRecordsViewUpdating = 0 then
    UpdateCursorPos;
  Result := RecordCount;
  if State = dsInsert then
    Inc(Result);
end;

function TCustomMemTableEh.GetRec: TMemoryRecordEh;
var
  RecBuf: TMTRecBuf;
begin
  CheckActive;
  Result := nil;
  if not GetActiveRecBuf(RecBuf)
    then Exit
    else Result := RecBuf.MemRec;
end;

function TCustomMemTableEh.GetRecView: TMemRecViewEh;
var
  RecBuf: TMTRecBuf;
begin
  CheckActive;
  Result := nil;
  if not GetActiveRecBuf(RecBuf)
    then Exit
    else Result := RecBuf.RecView;
end;

function TCustomMemTableEh.GetRecObject: TObject;
begin
  Result := GetRec;
end;

function TCustomMemTableEh.GotoRec(Rec: TMemoryRecordEh): Boolean;
begin
  Result := SetToRec(Rec);
end;

function TCustomMemTableEh.HasCachedChanges: Boolean;
begin
  Result := RecordsView.MemTableData.RecordsList.HasCachedChanges;
end;

function TCustomMemTableEh.SetToRec(Rec: TObject): Boolean;
var
  i: Integer;
begin
  CheckActive;
  Result := False;
  for i := 0 to RecordsView.ViewItemsCount-1 do
    if RecordsView.ViewRecord[i] = Rec then
    begin
      RecNo := i+1;
      Result := True;
      Exit;
    end;
end;

function TCustomMemTableEh.DoFetchRecords(Count: Integer): Integer;
var
  NeedRecordCount: Longint;
begin
  Result := 0;

  if DataDriver <> nil then
  begin
    NeedRecordCount := FRecordsView.ViewItemsCount + Count;
    Result := DataDriver.ReadData(RecordsView.MemTableData, Count);
    if (FRecordsView.ViewItemsCount < NeedRecordCount) and not DataDriver.ProviderEOF then
      
      while not DataDriver.ProviderEOF and (FRecordsView.ViewItemsCount < NeedRecordCount) do
        Result := Result + DataDriver.ReadData(RecordsView.MemTableData, 1);
    Exit;
  end;
end;

function TCustomMemTableEh.FetchRecords(Count: Integer): Integer;
begin
  Result := 0;
  if not Active then Exit;
  BeginRecordsViewUpdate;
  try
    Result := RecordsView.MemTableData.FetchRecords(Count);
  finally
    if Result > 0
      then EndRecordsViewUpdate(True)
      else EndRecordsViewUpdate(False);
  end;
end;

procedure TCustomMemTableEh.SetDetailFields(const Value: String);
begin
  FDetailFields := Value;
  UpdateDetailMode(True);
end;

procedure TCustomMemTableEh.SetMasterFields(const Value: String);
begin
  FMasterDataLink.FieldNames := Value;
  UpdateDetailMode(True);
end;

function TCustomMemTableEh.GetMasterFields: String;
begin
  Result := FMasterDataLink.FieldNames;
end;

procedure TCustomMemTableEh.SetMasterSource(const Value: TDataSource);
begin
  FMasterDataLink.DataSource := Value;
  UpdateDetailMode(True);
end;

function TCustomMemTableEh.GetMasterSource: TDataSource;
begin
  Result := FMasterDataLink.DataSource;
end;

function TCustomMemTableEh.InternalApplyUpdates(AMemTableData: TMemTableDataEh; MaxErrors: Integer): Integer;
begin
  Result := 0;
  if DataDriver <> nil then
  begin
    Result := DataDriver.ApplyUpdates(AMemTableData);
  end else
    FRecordsView.MergeChangeLog;
end;

function TCustomMemTableEh.ApplyUpdates(MaxErrors: Integer): Integer;
begin
  CheckActive;
  Result := InternalApplyUpdates(FRecordsView.MemTableData, MaxErrors);
  UpdateCursorPos;
  Resync([]);
end;

procedure TCustomMemTableEh.MergeChangeLog;
begin
  FRecordsView.MergeChangeLog;
end;

function TCustomMemTableEh.GetCachedUpdates: Boolean;
begin
  Result := FRecordsView.MemTableData.RecordsList.CachedUpdates;
end;

procedure TCustomMemTableEh.SetCachedUpdates(const Value: Boolean);
begin
  FRecordsView.MemTableData.RecordsList.CachedUpdates := Value;
end;

{$IFDEF FPC}
{$ELSE}
procedure TCustomMemTableEh.DefChanged(Sender: TObject);
begin
  FStoreDefs := True;
end;
{$ENDIF}

function TCustomMemTableEh.GetFieldValueList(const AFieldName: String): IMemTableDataFieldValueListEh;
var
  mtfv: TMemTableDataFieldValueListEh;
  dsfv:  TDatasetFieldValueListEh;
  Field: TField;
begin
  Field := FindField(AFieldName);
  if Field = nil then Exit;
  if Field.FieldKind = fkLookup then
  begin
    dsfv := TDatasetFieldValueListEh.Create;
    dsfv.FieldName := Field.LookupResultField;
    dsfv.DataSet := Field.LookupDataSet;
    Result := dsfv;
  end else
  begin
    mtfv := TMemTableDataFieldValueListEh.Create(Self);
    mtfv.FieldName := AFieldName;
    mtfv.DataObject := RecordsView.MemTableData;
    Result := mtfv;
  end;
end;

procedure TCustomMemTableEh.GetAggregatedValuesForRange(FromBM, ToBM: TUniBookmarkEh;
  const FieldName: String; var ResultArr: TAggrResultArr; AggrFuncs: TAggrFunctionsEh);
var
  FromRN, ToRN: Integer;
  i: Integer;
  v: Variant;
  VarTypeNum: Integer;
  FieldIndex: Integer;
begin
  ResultArr[agfSumEh] := Null;
  ResultArr[agfCountEh] := 0;
  ResultArr[agfAvg] := Null;
  ResultArr[agfMin] := Null;
  ResultArr[agfMax] := Null;
  if not Active then Exit;
  if FromBM <> NilBookmarkEh then
    if UniBookmarkValid(FromBM)
      then FromRN := UniBookmarkToRecNo(FromBM)
      else Exit
  else
    FromRN := 1;
  if ToBM <> NilBookmarkEh then
    if UniBookmarkValid(ToBM)
      then ToRN := UniBookmarkToRecNo(ToBM)
      else Exit
  else
    ToRN := RecordCount;

  if (FieldName = '') and (AggrFuncs = [agfCountEh]) then
  begin
    for i := FromRN-1 to ToRN-1 do
      ResultArr[agfCountEh] := ResultArr[agfCountEh] + 1;
    Exit;  
  end;

  if FRecordsView.MemTableData.DataStruct.FindField(FieldName) = nil then
    Exit;
  VarTypeNum := FRecordsView.MemTableData.DataStruct.FieldByName(FieldName).GetVarDataType;
  FieldIndex := FRecordsView.MemTableData.DataStruct.FieldIndex(FieldName);
  for i := FromRN-1 to ToRN-1 do
  begin
    v := FRecordsView.RecordView[i].Rec.Value[FieldIndex, dvvValueEh];
    if not VarIsNullEh(v) then
    begin
      if (agfCountEh in AggrFuncs) or (agfAvg in AggrFuncs) then
        ResultArr[agfCountEh] := ResultArr[agfCountEh] + 1;
      if (VarTypeNum in [varSmallint, varInteger, varSingle, varDouble, varCurrency,
         varShortInt, varWord, varInt64, varLongWord,
         varByte, varDate]) or (VarTypeNum = varFMTBcd) then
      begin
        if ((agfSumEh in AggrFuncs) or (agfAvg in AggrFuncs)) and
           (VarTypeNum <> varDate)
        then
          if VarIsNullEh(ResultArr[agfSumEh])
            then ResultArr[agfSumEh] := v
            else ResultArr[agfSumEh] := ResultArr[agfSumEh] + v;

        if agfMin in AggrFuncs then
          if VarIsNullEh(ResultArr[agfMin]) then
            ResultArr[agfMin] := v
          else if ResultArr[agfMin] > v then
            ResultArr[agfMin] := v;

        if agfMax in AggrFuncs then
          if VarIsNullEh(ResultArr[agfMax]) then
            ResultArr[agfMax] := v
          else if ResultArr[agfMax] < v then
            ResultArr[agfMax] := v;
      end
    end;
  end;

  if agfAvg in AggrFuncs then
    if not VarIsNullEh(ResultArr[agfSumEh]) then
      ResultArr[agfAvg] := ResultArr[agfSumEh] / ResultArr[agfCountEh];
end;

procedure TCustomMemTableEh.SetExternalMemData(Value: TCustomMemTableEh);
var
  WasActive: Boolean;
begin
  if FExternalMemData <> Value then
  begin
    if Value = Self then
      raise Exception.Create('Circular datalinks are not allowed');
    if (Value <> nil) and (DataDriver <> nil) then
      raise Exception.Create('Assigning to ExternalMemData is not allowed if DataDriver is assigned');
    WasActive := Active;
    if not (csLoading in ComponentState) then
      Close;
    if Value = nil then
      FRecordsView.MemTableData := FInternMemTableData
    else
    begin
      FRecordsView.MemTableData := Value.FInternMemTableData;
      Value.FreeNotification(Self);
    end;
    FExternalMemData := Value;
    if WasActive and not (csDestroying in ComponentState) then
      Open;
  end;
end;

procedure TCustomMemTableEh.BeginRecordsViewUpdate;
begin
  Inc(FRecordsViewUpdating);
end;

procedure TCustomMemTableEh.EndRecordsViewUpdate(AutoResync: Boolean);
begin
  if FRecordsViewUpdating > 0 then
    Dec(FRecordsViewUpdating);
  if AutoResync and (FRecordsViewUpdating = 0) and FRecordsViewUpdated then
  begin
    FRecordsViewUpdated := False;
    if not (State in [dsEdit, dsInsert]) then
      Resync([]);
  end;
end;

function TCustomMemTableEh.MoveRecord(FromIndex, ToIndex: Longint;
  TreeLevel: Integer; CheckOnly: Boolean): Boolean;
var
  {ToMemRec, }CurRec, FromRec : TMemoryRecordEh;
  FromNode, PrevNode, NextNode: TMemRecViewEh;
  RefParentValue: Variant;
  NewPos: Integer;

  function InsertAfter(FromNode, AfterNode: TMemRecViewEh): Boolean;
  var
    IndexInParentNode: Integer;
  begin
    Result := True;
    RefParentValue := AfterNode.Rec.DataValues[TreeList.RefParentFieldName, dvvValueEh];
    if AfterNode.Rec.Index > FromNode.Rec.Index
      then IndexInParentNode := AfterNode.Rec.Index
      else IndexInParentNode := AfterNode.Rec.Index + 1;

    if Assigned(FOnRecordsViewCheckMoveNode) then
      Result := FOnRecordsViewCheckMoveNode(Self, FromNode, AfterNode.NodeParent, IndexInParentNode);
    if not Result then Exit;

    if CheckOnly then
      Result := not RecordsView.MemoryTreeList.CheckReferenceLoop(FromNode.Rec, RefParentValue)
    else
    begin
      FromRec := FromNode.Rec;
      FromRec.Edit;
      FromRec.DataValues[TreeList.RefParentFieldName, dvvValueEh] := RefParentValue;
      FromRec.Post;

      if AfterNode.Rec.Index > FromNode.Rec.Index
        then RecordsView.MemTableData.RecordsList.Move(FromRec.Index, AfterNode.Rec.Index)
        else RecordsView.MemTableData.RecordsList.Move(FromRec.Index, AfterNode.Rec.Index+1);
    end;
  end;

  function InsertBefore(FromNode, BeforeNode: TMemRecViewEh): Boolean;
  var
    IndexInParentNode: Integer;
  begin
    RefParentValue := BeforeNode.Rec.DataValues[TreeList.RefParentFieldName, dvvValueEh];
    Result := True;

    if BeforeNode.Rec.Index > FromNode.Rec.Index
      then IndexInParentNode := BeforeNode.Rec.Index - 1
      else IndexInParentNode := BeforeNode.Rec.Index;

    if Assigned(FOnRecordsViewCheckMoveNode) then
      Result := FOnRecordsViewCheckMoveNode(Self, FromNode, BeforeNode.NodeParent, IndexInParentNode);
    if not Result then Exit;

    if CheckOnly then
      Result := not RecordsView.MemoryTreeList.CheckReferenceLoop(FromNode.Rec, RefParentValue)
    else
    begin
      FromRec := FromNode.Rec;
      FromRec.Edit;
      FromRec.DataValues[TreeList.RefParentFieldName, dvvValueEh] := RefParentValue;
      FromRec.Post;

      if BeforeNode.Rec.Index > FromNode.Rec.Index
        then RecordsView.MemTableData.RecordsList.Move(FromRec.Index, BeforeNode.Rec.Index-1)
        else RecordsView.MemTableData.RecordsList.Move(FromRec.Index, BeforeNode.Rec.Index);
    end;
  end;

  function InsertChild(FromNode, ParentNode: TMemRecViewEh): Boolean;
  begin
    Result := True;
    RefParentValue := ParentNode.Rec.DataValues[TreeList.KeyFieldName, dvvValueEh];

    if Assigned(FOnRecordsViewCheckMoveNode) then
      Result := FOnRecordsViewCheckMoveNode(Self, FromNode, ParentNode, 0);
    if not Result then Exit;

    if CheckOnly then
      Result := not RecordsView.MemoryTreeList.CheckReferenceLoop(FromNode.Rec, RefParentValue)
    else
    begin
      FromRec := FromNode.Rec;
      FromRec.Edit;
      FromRec.DataValues[TreeList.RefParentFieldName, dvvValueEh] := RefParentValue;
      FromRec.Post;
    end;
  end;
begin
  Result := True;
  if not Active or (FromIndex > FRecordsView.ViewItemsCount) or
    (ToIndex > FRecordsView.ViewItemsCount)
  then
    Exit;
  if TreeList.Active then
  begin
    if not CheckOnly then
      BeginRecordsViewUpdate;
    try
      CurRec := TMemoryRecordEh(GetRec);
      FromNode := RecordsView.MemoryTreeList[FromIndex];
      FromRec := RecordsView.MemoryTreeList[FromIndex].Rec;
      if FromIndex < ToIndex then
      begin
        PrevNode := RecordsView.MemoryTreeList[ToIndex];
        if ToIndex+1 < RecordsView.ViewItemsCount-1
          then NextNode := RecordsView.MemoryTreeList[ToIndex+1]
          else NextNode := nil;
      end else
      begin
        if ToIndex > 0
          then PrevNode := RecordsView.MemoryTreeList[ToIndex-1]
          else PrevNode := nil;
        NextNode := RecordsView.MemoryTreeList[ToIndex];
      end;

      if (PrevNode <> nil) and (TreeLevel = PrevNode.NodeLevel) then
        Result := Result and InsertAfter(FromNode, PrevNode)
      else if (NextNode <> nil) and (TreeLevel = NextNode.NodeLevel) then
        Result := Result and InsertBefore(FromNode, NextNode)
      else if (PrevNode <> nil) and (TreeLevel > PrevNode.NodeLevel) then
        Result := Result and InsertChild(FromNode, PrevNode)
      else if (PrevNode <> nil) and (TreeLevel < PrevNode.NodeLevel) then
      begin
        while PrevNode.NodeLevel > TreeLevel do
        begin
          if PrevNode.NodeParent = PrevNode.NodeOwner.Root then
            Exit;
          PrevNode := PrevNode.NodeParent;
        end;
        Result := Result and InsertAfter(FromNode, PrevNode);
      end;

      if CheckOnly then
        Exit;
      NewPos := FRecordsView.IndexOfRec(CurRec);
      if NewPos > -1 then
        FRecordPos := NewPos;

    finally
      EndRecordsViewUpdate(True);
    end;
  end else
  begin
    CurRec := TMemoryRecordEh(GetRec);
    if CheckOnly then
      Exit;
    RecordsView.MemTableData.RecordsList.Move(
      RecordsView.ViewRecord[FromIndex].Index,
      RecordsView.ViewRecord[ToIndex].Index);
    NewPos := FRecordsView.IndexOfRec(CurRec);
    if NewPos > -1 then
      FRecordPos := NewPos;
    Resync([]);
    { TODO : Resync to RecordList to event and back to MemTable }
  end;
end;

function CompareBookmarkStr(List: TBMListEh; ADataSet: TDataSet; Index1, Index2: Integer): Integer;
begin
  Result := DataSetCompareBookmarks(ADataSet, List[Index1], List[Index2]);
end;

function TCustomMemTableEh.MoveRecords(BookmarkList: TBMListEh; ToRecNo: Longint;
  TreeLevel: Integer; CheckOnly: Boolean): Boolean;
var
  i, RecIndex: Integer;
  RecList: TObjectListEh;
  ToIndex: Integer;
begin
  ToIndex := ToRecNo - 1;
  Result := True;
  RecList := TObjectListEh.Create;
  try
    for i := 0 to BookmarkList.Count-1 do
    begin
{$IFDEF TBookMarkAsTBytes}
      RecIndex := BookmarkToRecNo(BookmarkList[i]) - 1;
{$ELSE}
      RecIndex := BookmarkStrToRecNo(BookmarkList[i]) - 1;
{$ENDIF}
      RecList.Add(RecordsView.ViewRecord[RecIndex]);
    end;

    if not CheckOnly then
      BeginRecordsViewUpdate;
    try
      for i := RecList.Count-1 downto 0 do
      begin
        RecIndex := RecordsView.IndexOfRec(TMemoryRecordEh(RecList[i]));
        if (i < RecList.Count-1) and (RecIndex < ToIndex) then
          Dec(ToIndex);
        Result := Result and MoveRecord(RecIndex, ToIndex, TreeLevel, CheckOnly);
      end;
      if CheckOnly then
        Exit;
      for i := RecList.Count-1 downto 0 do
      begin
        BookmarkList[i] := RecToBookmark(TMemoryRecordEh(RecList[i]));
      end;
{$IFDEF CIL}
{$ELSE}
      TBMListCrackEh(BookmarkList).CustomSort(Self, @CompareBookmarkStr);
{$ENDIF}
    finally
      if not CheckOnly then
        EndRecordsViewUpdate(True);
    end;

  finally
    RecList.Free;
  end;
end;

function TCustomMemTableEh.GetDataSource: TDataSource;
begin
  Result := FMasterDataLink.DataSource;
end;

function TCustomMemTableEh.GetFieldClass(FieldType: TFieldType): TFieldClass;
begin
  if FieldType = ftUnknown
    then Result := TRefObjectField
    else Result := inherited GetFieldClass(FieldType);
end;

procedure TCustomMemTableEh.DriverStructChanged;
begin
  DataEvent(dePropertyChange, {$IFDEF CIL}nil{$ELSE}0{$ENDIF});
end;

procedure TCustomMemTableEh.RegisterEventReceiver(AComponent: TPersistent);
begin
  if FEventReceivers.IndexOf(AComponent) < 0 then
  begin
    FEventReceivers.Add(AComponent);
    if (AComponent is TComponent) then
      TComponent(AComponent).FreeNotification(Self);
  end;
end;

procedure TCustomMemTableEh.UnregisterEventReceiver(AComponent: TPersistent);
begin
  FEventReceivers.Remove(AComponent);
end;

procedure TCustomMemTableEh.MTViewDataEvent(RowNum: Integer;
  Event: TMTViewEventTypeEh; OldRowNum: Integer);
var
  i: Integer;
  IntEventReceiver: IMTEventReceiverEh;
begin
  if Active then
  begin
    if ControlsDisabled then
    begin
      if FMTViewDataEventInactiveCount < 2 then
        Inc(FMTViewDataEventInactiveCount);
      if FMTViewDataEventInactiveCount = 1 then
      begin
        FInactiveEventRowNum := RowNum;
        FInactiveEvent := Event;
        FInactiveEventOldRowNum := OldRowNum;
      end else
      begin
        FInactiveEventRowNum := -1;
        FInactiveEvent := mtViewDataChangedEh;
        FInactiveEventOldRowNum := -1;
      end;
    end else
    begin
      FMTViewDataEventInactiveCount := 0;
      for i := 0 to FEventReceivers.Count-1 do
      begin
        if Supports(FEventReceivers[i], IMTEventReceiverEh, IntEventReceiver) then
          IntEventReceiver.MTViewDataEvent(RowNum, Event, OldRowNum);
      end;
      FMTViewDataEventInactiveCount := 0;
      if (FStateInsert = True) and
         (FStateInsertRowNum >= RowNum) and
         (Event = mtRowInsertedEh)
      then
        FStateInsertRowNum := FStateInsertRowNum + 1;
    end;
  end;
end;

function TCustomMemTableEh.ViewRecordIndexToViewRowNum(ViewRecordIndex: Integer): Integer;
begin
  Result := ViewRecordIndex;
  if FStateInsert and (Result >= FInstantReadCurRowNum) then
    Inc(Result);
end;

function TCustomMemTableEh.GetLikeWildcardForOneCharacter: String;
begin
  Result := '_';
end;

function TCustomMemTableEh.GetLikeWildcardForSeveralCharacters: String;
begin
  Result := '%';
end;

procedure TCustomMemTableEh.FilterAbort;
begin
  FRecordsView.FilterAborted := True;
end;

{ TMemBlobStreamEh }

constructor TMemBlobStreamEh.Create(Field: TBlobField; Mode: TBlobStreamMode);
begin
  inherited Create;
  FField := Field;
  FFieldNo := FField.FieldNo - 1;
  FDataSet := FField.DataSet as TCustomMemTableEh;
  FFieldData := Null;
  FData := Null;
  if not FDataSet.GetActiveRecBuf(FBuffer) then Exit;
  if Mode <> bmRead then
  begin
    if FField.ReadOnly then
    {$IFDEF FPC}
    DatabaseErrorFmt(SReadOnlyField, [FField.DisplayName], FDataSet);
    {$ELSE}
    DatabaseErrorFmt(SFieldReadOnly, [FField.DisplayName], FDataSet);
    {$ENDIF}

    if not (FDataSet.State in [dsEdit, dsInsert]) then
      DatabaseError(SNotEditing, FDataSet);
  end;
  if Mode = bmWrite
    then Truncate
    else ReadBlobData;
end;

destructor TMemBlobStreamEh.Destroy;
{$IFDEF EH_LIB_17}
var
  BytesBuffer: TBytes;
{$ENDIF}
begin
  if FModified then
  try
{$IFDEF CIL}
    FField.Modified := True;
    FDataSet.DataEvent(deFieldChange, TObject(FField));
{$ELSE}

  {$IFDEF EH_LIB_17}
    SetLength(BytesBuffer, SizeOf(Variant));
    VariantToBytes(FData, BytesBuffer);
    FDataSet.SetFieldData(FField, BytesBuffer);
  {$ELSE}
    FDataSet.SetFieldData(FField, @FData);
  {$ENDIF}
    FField.Modified := True;
    FDataSet.DataEvent(deFieldChange, TDataEventInfoTypeEh(FField));
{$ENDIF} 
  except
    ApplicationHandleException(Self);
  end;
  inherited Destroy;
end;

procedure TMemBlobStreamEh.ReadBlobData;
begin
{$IFDEF CIL}
{$ELSE}
  FDataSet.GetFieldValue(FField, FFieldData);
{$ENDIF}
  if not VarIsNull(FFieldData) then
  begin
    if VarType(FFieldData) = varOleStr then
    begin
{$IFDEF EH_LIB_10}
      if FField.BlobType = ftWideMemo then
        Size := Length(WideString(FFieldData)) * sizeof(widechar)
      else
{$ENDIF}
      begin
        { Convert OleStr into a pascal string (format used by TBlobField) }
        FFieldData := string(FFieldData);
        Size := Length(FFieldData);
      end;
    end else if VarType(FFieldData) = varString then
        Size := Length(FFieldData)
{$IFDEF EH_LIB_12}
    else if VarType(FFieldData) = varUString then
        Size := ByteLength(FFieldData)
{$ENDIF}
    else
      Size := VarArrayHighBound(FFieldData, 1) + 1;
    FFieldData := Null;
  end;
end;

{$IFDEF CIL}
function TMemBlobStreamEh.Realloc(var NewCapacity: Longint): TBytes;
{$ELSE}
{$IFDEF FPC}
  function TMemBlobStreamEh.Realloc(var NewCapacity: PtrInt): Pointer;
{$ELSE}
  {$IFDEF EH_LIB_28}
function TMemBlobStreamEh.Realloc(var NewCapacity: NativeInt): Pointer;
  {$ELSE}
  function TMemBlobStreamEh.Realloc(var NewCapacity: System.Longint): Pointer;
{$ENDIF}
{$ENDIF}

{$ENDIF}

  procedure VarAlloc(var V: Variant; Field: TFieldType);
  var
{$IFDEF EH_LIB_10}
    W: WideString;
{$ENDIF}
    S: AnsiString;
  begin
    if Field in [ftMemo, ftFmtMemo, ftFixedChar, ftOraClob] then
    begin
      if not VarIsNull(V) then S := AnsiString(V);
      SetLength(S, NewCapacity);
      V := S;
    end else
{$IFDEF EH_LIB_10}
    if Field in [ftWideMemo, ftFixedWideChar] then
    begin
      if not VarIsNull(V) then W := WideString(V);
      SetLength(W, NewCapacity div 2);
      V := W;
    end else
{$ENDIF}
    begin
{$IFDEF CIL}
      if VarIsEmpty(V) or VarIsNull(V)
        then V := VarArrayCreate([0, NewCapacity-1], varByte)
       ;
{$ELSE}
{$IFDEF EH_LIB_12}
      if VarIsEmpty(V) or VarIsNull(V)
        then V := VarArrayCreate([0, NewCapacity-1], varByte)
        else VarArrayRedim(V, NewCapacity-1);
{$ELSE}
      if not VarIsNull(V) then S := string(V);
      SetLength(S, NewCapacity);
      V := S;
{$ENDIF}
{$ENDIF}
    end;
  end;

begin
{$IFDEF CIL}
  SetLength(Result, NewCapacity);
{$ELSE}
  Result := Memory;
  if NewCapacity <> Capacity then
  begin
    if VarIsArray(FData) then VarArrayUnlock(FData);
    if NewCapacity = 0 then
    begin
      FData := Null;
      Result := nil;
    end else
    begin
      if VarIsNull(FFieldData)
        then VarAlloc(FData, FField.DataType)
        else FData := FFieldData;
      if VarIsArray(FData)
        then Result := VarArrayLock(FData)
        else Result := TVarData(FData).VString;
    end;
  end;
{$ENDIF}
end;

{$IFDEF CIL}
function TMemBlobStreamEh.Write(const Buffer: array of Byte; Offset, Count: Longint): Longint;
{$ELSE}
function TMemBlobStreamEh.Write(const Buffer; Count: integerD12): integerD12;
{$ENDIF}
begin
  Result := inherited Write(Buffer, Count);
  FModified := True;
end;

procedure TMemBlobStreamEh.Truncate;
begin
  Clear;
  FModified := True;
end;


{ TMemTableTreeListEh }

constructor TMemTableTreeListEh.Create(AMemTable: TCustomMemTableEh);
begin
  inherited Create;
  FMemTable := AMemTable;
  FullBuildCheck := True;
end;

function TMemTableTreeListEh.GetActive: Boolean;
begin
  if csLoading in FMemTable.ComponentState
    then Result := FLoadingActive
    else Result := FMemTable.RecordsView.ViewAsTreeList;
end;

procedure TMemTableTreeListEh.SetActive(const Value: Boolean);
begin
  if csLoading in FMemTable.ComponentState then
    FLoadingActive := Value
  else
  begin
    FMemTable.DisableControls;
    try
      FMemTable.RecordsView.ViewAsTreeList := Value;
    finally
      FMemTable.EnableControls;
    end;
    if FMemTable.Active then
    begin
      FMemTable.UpdateCursorPos;
      FMemTable.Resync([]);
    end;
  end;  
end;

function TMemTableTreeListEh.GetKeyFieldName: String;
begin
  Result := FMemTable.RecordsView.TreeViewKeyFieldName;
end;

procedure TMemTableTreeListEh.SetKeyFieldName(const Value: String);
begin
  FMemTable.RecordsView.TreeViewKeyFieldName := Value;
end;

function TMemTableTreeListEh.GetRefParentFieldName: String;
begin
  Result := FMemTable.RecordsView.TreeViewRefParentFieldName;
end;

procedure TMemTableTreeListEh.SetRefParentFieldName(const Value: String);
begin
  FMemTable.RecordsView.TreeViewRefParentFieldName := Value;
end;

function TMemTableTreeListEh.GetDefaultNodeExpanded: Boolean;
begin
  Result := FMemTable.RecordsView.MemoryTreeList.DefaultNodeExpanded;
end;

function TMemTableTreeListEh.GetDefaultNodeHasChildren: Boolean;
begin
  Result := FMemTable.RecordsView.MemoryTreeList.DefaultNodeHasChildren;
end;

procedure TMemTableTreeListEh.SetDefaultNodeExpanded(const Value: Boolean);
begin
  FMemTable.RecordsView.MemoryTreeList.DefaultNodeExpanded := Value;
end;

procedure TMemTableTreeListEh.SetDefaultNodeHasChildren(const Value: Boolean);
begin
  FMemTable.RecordsView.MemoryTreeList.DefaultNodeHasChildren := Value;
end;

procedure TMemTableTreeListEh.FullCollapse;
begin
  FMemTable.DisableControls;
  try
    FMemTable.RecordsView.MemoryTreeList.Collapse(nil, True);
    FMemTable.RecordsView.MemoryTreeList.BuildVisibleItems;
  finally
    FMemTable.Resync([]);
    FMemTable.EnableControls;
{$IFDEF CIL}
{$ELSE}
    if FMemTable.Active then
      FMemTable.DoAfterScroll;
{$ENDIF}
  end;
end;

procedure TMemTableTreeListEh.FullExpand;
begin
  FMemTable.DisableControls;
  try
    FMemTable.RecordsView.MemoryTreeList.Expand(nil, True);
    FMemTable.RecordsView.MemoryTreeList.BuildVisibleItems;
  finally
    FMemTable.Resync([]);
    FMemTable.EnableControls;
  end;
end;

function TMemTableTreeListEh.Locate(const KeyFields: string;
  const KeyValues: Variant; Options: TLocateOptions): Boolean;
var
  i: Integer;
  TreeList: TMemoryTreeListEh;
  RecView, RecViewFound: TMemRecViewEh;

  function StringValueEqual(DataStr, FindStr: String): Boolean;
  begin
    if (loPartialKey in Options) then
{$IFDEF CIL}
      Borland.Delphi.System.Delete(DataStr, Length(FindStr) + 1, MaxInt);
{$ELSE}
      System.Delete(DataStr, Length(FindStr) + 1, MaxInt);
{$ENDIF}
    if (loCaseInsensitive in Options) then
      Result := AnsiCompareText(DataStr, FindStr) = 0
    else
      Result := AnsiCompareStr(DataStr, FindStr) = 0;
  end;
  
begin
  Result := False;
  RecViewFound := nil;
  FMemTable.CheckBrowseMode;
  if FMemTable.BOF and FMemTable.EOF then Exit;
  TreeList := FMemTable.RecordsView.MemoryTreeList;
  for i := 0 to TreeList.AccountableCount - 1 do
  begin
    if (Options <> []) and (Pos(';', KeyFields) = 0) then
      Result := StringValueEqual(
                  VarToStr(TreeList.AccountableItem[i].Rec.DataValues[KeyFields,dvvValueEh]),
                  VarToStr(KeyValues))
    else
      Result := VarEquals(TreeList.AccountableItem[i].Rec.DataValues[KeyFields,dvvValueEh], KeyValues);
    if Result then
    begin
      RecViewFound := TreeList.AccountableItem[i];
      Break;
    end;
  end;
  if Result then
  begin
    RecView := RecViewFound.NodeParent;
    while RecView.Rec <> nil do
    begin
      RecView.NodeExpanded := True;
      RecView := RecView.NodeParent;
    end;
    FMemTable.SetToRec(RecViewFound.Rec);
  end;
end;

function TMemTableTreeListEh.GetFullBuildCheck: Boolean;
begin
  Result := FMemTable.RecordsView.MemoryTreeList.FullBuildCheck;
end;

procedure TMemTableTreeListEh.SetFullBuildCheck(const Value: Boolean);
begin
  FMemTable.RecordsView.MemoryTreeList.FullBuildCheck := Value;
end;

procedure TMemTableTreeListEh.SetFilterNodeIfParentVisible(const Value: Boolean);
begin
  FMemTable.RecordsView.MemoryTreeList.FilterNodeIfParentVisible := Value;
end;

function TMemTableTreeListEh.GetFilterNodeIfParentVisible: Boolean;
begin
  Result := FMemTable.RecordsView.MemoryTreeList.FilterNodeIfParentVisible;
end;

{ TMemTableDataFieldValueListEh }

constructor TMemTableDataFieldValueListEh.Create(ADataSet: TDataSet);
begin
  inherited Create;
  FValues := TStringList.Create;
  FValues.Duplicates := dupIgnore;
  FDataObsoleted := True;
  FNotificator := TRecordsListNotificatorEh.Create(nil);
  FNotificator.OnDataEvent := MTDataEvent;
  FFilterExpr := TDataSetExprParserEh.Create(ADataSet, dsptFilterEh);
  FDataSet := ADataSet;
end;

destructor TMemTableDataFieldValueListEh.Destroy;
begin
  FreeAndNil(FFilterExpr);
  FreeAndNil(FValues);
  FreeAndNil(FNotificator);
  inherited Destroy;
end;

function TMemTableDataFieldValueListEh.GetValues: TStrings;
begin
  if FDataObsoleted then
    RefreshValues;
  Result := FValues;
end;

procedure TMemTableDataFieldValueListEh.RecordListChanged;
begin
  FDataObsoleted := True;
end;

procedure TMemTableDataFieldValueListEh.RefreshValues;
var
  i, k: Integer;
  DataField: TMTDataFieldEh;
  Idx: TMTIndexEh;
  s, s1: String;
  MemTableData: TMemTableDataEh;
  RecordsView: TRecordsViewEh;
  sl: TStringList;
begin
  FValues.Clear;
  if DataObject = nil then Exit;
  if DataObject is TMemTableDataEh then
  begin
    MemTableData := TMemTableDataEh(DataObject);
    DataField := MemTableData.DataStruct.FindField(FieldName);
    if DataField = nil then Exit;
    if not (DataField.DataType in ftSupportedAsStrEh) then Exit;
    if DataField.DataType in [ftString, ftWideString] then
    begin
      FValues.Sorted := True;
      FValues.CaseSensitive := not (foCaseInsensitive in FDataSet.FilterOptions);
      for i := 0 to MemTableData.RecordsList.Count-1 do
      begin
        if not FFilterExpr.HasData or FFilterExpr.IsCurRecordInFilter(MemTableData.RecordsList[i]) then
          FValues.Add(VarToStr(MemTableData.RecordsList[i].DataValues[FieldName, dvvValueEh]))
      end;
    end else
    begin
      Idx := TMTIndexEh.CreateApart(MemTableData.RecordsList);
      try
        Idx.Fields := FieldName;
        Idx.Active := True;
        FValues.Sorted := False;
        k := 0;
        if Idx.Count > 0 then
        begin
          for i := 0 to Idx.Count-1 do
          begin
            k := i;
            if not FFilterExpr.HasData or
              FFilterExpr.IsCurRecordInFilter(MemTableData.RecordsList[Idx.Item[i].RecIndex]) then
            begin
              s := VarToStrEh(Idx.KeyValue[i]);
              FValues.Add(s);
              Break;
            end;
          end;
        end;
        for i := k+1 to Idx.Count-1 do
        begin
          if not FFilterExpr.HasData or
            FFilterExpr.IsCurRecordInFilter(MemTableData.RecordsList[Idx.Item[i].RecIndex]) then
          begin
            s1 := VarToStrEh(Idx.KeyValue[i]);
            if s <> s1 then
            begin
              s := s1;
              FValues.Add(s);
            end;
          end;
        end;
      finally
        Idx.Free;
      end;
    end;
  end
  else if DataObject is TRecordsViewEh then
  begin
    RecordsView := TRecordsViewEh(DataObject);
    sl := TStringList.Create;
    DataField := RecordsView.MemTableData.DataStruct.FindField(FieldName);
    for i := 0 to RecordsView.Count-1 do
      sl.Add(VarToStr(RecordsView.Rec[i].Value[DataField.Index, dvvValueEh]));
    sl.Sort;
    for i := 0 to sl.Count-1 do
    begin
      s1 := sl[i];
      if s <> s1 then
      begin
        s := s1;
        FValues.Add(s);
      end;
    end;
  end;
  FDataObsoleted := False;
end;

procedure TMemTableDataFieldValueListEh.RefreshVarValues;
var
  i, k, vi: Integer;
  DataField: TMTDataFieldEh;
  Idx: TMTIndexEh;
  MemTableData: TMemTableDataEh;
begin
  if DataObject = nil then Exit;
  if DataObject is TMemTableDataEh then
  begin
    MemTableData := TMemTableDataEh(DataObject);
    DataField := MemTableData.DataStruct.FindField(FieldName);
    if DataField = nil then Exit;
    if not (DataField.DataType in ftSupportedAsStrEh) then Exit;
    if DataField.DataType in [ftString, ftWideString] then
    begin
      SetLength(FVarValues, MemTableData.RecordsList.Count);
      vi := 0;
      for i := 0 to MemTableData.RecordsList.Count-1 do
      begin
        if not FFilterExpr.HasData or FFilterExpr.IsCurRecordInFilter(MemTableData.RecordsList[i]) then
        begin
          FVarValues[vi] := MemTableData.RecordsList[i].DataValues[FieldName, dvvValueEh];
          Inc(vi);
        end;
      end;
      SetLength(FVarValues, vi);
    end else
    begin
      SetLength(FVarValues, MemTableData.RecordsList.Count);
      Idx := TMTIndexEh.CreateApart(MemTableData.RecordsList);
      try
        Idx.Fields := FieldName;
        Idx.Active := True;
        k := 0;
        vi := 0;
        if Idx.Count > 0 then
        begin
          for i := 0 to Idx.Count-1 do
          begin
            k := i;
            if not FFilterExpr.HasData or
              FFilterExpr.IsCurRecordInFilter(MemTableData.RecordsList[Idx.Item[i].RecIndex]) then
            begin
              FVarValues[vi] := Idx.KeyValue[i];
              Inc(vi);
              Break;
            end;
          end;
        end;
        for i := k+1 to Idx.Count-1 do
        begin
        end;
        SetLength(FVarValues, vi);
      finally
        Idx.Free;
      end;
    end;
  end
  else if DataObject is TRecordsViewEh then
  begin
  end;
  FDataObsoleted := False;
end;

procedure TMemTableDataFieldValueListEh.SetFieldName(const Value: String);
begin
  if FFieldName <> Value then
  begin
    FDataObsoleted := True;
    FFieldName := Value;
    RefreshValues;
  end;
end;

procedure TMemTableDataFieldValueListEh.MTDataEvent(
  MemRec: TMemoryRecordEh; Index: Integer;
  Action: TRecordsListNotification);
begin
  RecordListChanged;
end;

function TMemTableDataFieldValueListEh.GetDataObject: TComponent;
begin
  Result := FNotificator.DataObject;
end;

procedure TMemTableDataFieldValueListEh.SetDataObject(const Value: TComponent);
begin
  FNotificator.DataObject := Value;
end;

procedure TMemTableDataFieldValueListEh.SetFilter(const Filter: String);
begin
  if FFilter <> Filter then
  begin
    FFilterExpr.ParseExpression(Filter);
    FDataObsoleted := True;
    FFilter := Filter;
  end;
end;

{ TRefObjectField }

class procedure TRefObjectField.CheckTypeSize(Value: Integer);
begin
  { No validation }
end;

constructor TRefObjectField.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

function TRefObjectField.GetValue: TObject;
begin
  if DataSet = nil then DatabaseErrorFmt('SDataSetMissing', [DisplayName]);
  TMemTableEh(DataSet).GetFieldDataAsObject(Self, Result);
end;

procedure TRefObjectField.SetValue(const Value: TObject);
begin
  if DataSet = nil then DatabaseErrorFmt('SDataSetMissing', [DisplayName]);
  TMemTableEh(DataSet).SetFieldDataAsObject(Self, Value);
end;

function TRefObjectField.GetAsVariant: Variant;
begin
  Result := RefObjectToVariant(Value);
end;

procedure TRefObjectField.SetVarValue(const Value: Variant);
begin
  SetValue(VariantToRefObject(Value));
end;

{ TSortedVarItemEh }

constructor TSortedVarItemEh.Create(NewValue:variant);
begin
  inherited Create;
  Value := NewValue;
end;

function  TSortedVarlistEh.VarInList(Value:variant):boolean;
var
  Index: Integer;
begin
  Result:=  FindValueIndex(Value,Index);
end;

function  TSortedVarlistEh.FindValueIndex(Value: Variant; var Index: Integer):boolean;
var
  L, H, I: Integer;
  C: TVariantRelationship;
begin
  Result := False;
  L := 0;
  H := Count - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    C := DBVarCompareValue(TSortedVarItemEh(Items[i]).Value, Value);
    if C = vrNotEqual then
      raise Exception.Create('TSortedVarlistEh.FindKeyValueIndex: values is not comparable.');
    if C = vrLessThan then
      L := I + 1
    else
    begin
      H := I - 1;
      if C = vrEqual then
      begin
        Result := True;
        {if Duplicates <> dupAccept then} L := I;
      end;
    end;
  end;
  Index := L;
end;

function TSortedVarlistEh.Add(AObject: TSortedVarItemEh): IntegerD12;
var AIndex:integer;
begin
// Repacked version
//  FindValueIndex(AObject.Value,Result);
  FindValueIndex(AObject.Value,AIndex);
  Result := AIndex;
  inherited Insert(Result, AObject);
end;

procedure TSortedVarlistEh.Insert(Index: IntegerD12; AObject: TSortedVarItemEh);
begin
  Add(AObject);
end;

{ TMTStringFieldEh }

function TMTStringFieldEh.CanModifyWithoutEditMode: Boolean;
begin
  Result := (FieldKind in [fkCalculated]) and (DataSet is TCustomMemTableEh);
end;

procedure TMTStringFieldEh.Clear;
begin
  if FieldKind in [fkCalculated, fkLookup] then
    SetData(nil)
  else
    inherited Clear;
end;

{ TMemTableFilterItemEh }

constructor TMemTableFilterItemEh.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FFilterExpr := TDataSetExprParserEh.Create(MemTableFilters.MemTable, dsptFilterEh);
end;

destructor TMemTableFilterItemEh.Destroy;
begin
  FreeAndNil(FFilterExpr);
  inherited Destroy;
end;

function TMemTableFilterItemEh.Filtered: Boolean;
begin
  Result := Active and ((Filter <> '') or Assigned(OnFilterRecord));
end;

function TMemTableFilterItemEh.IsCurRecordInFilter(Rec: TMemoryRecordEh): Boolean;
begin
  if FFilterExpr.HasData
    then Result := FFilterExpr.IsCurRecordInFilter(Rec)
    else Result := True;

  if Active and Assigned(OnFilterRecord) then
    OnFilterRecord(MemTableFilters.MemTable, Result);
end;

function TMemTableFilterItemEh.MemTableFilters: TMemTableFiltersEh;
begin
  Result := TMemTableFiltersEh(Collection);
end;

procedure TMemTableFilterItemEh.RecreateFilterExpr;
begin
  if Active and (Filter <> '') and MemTableFilters.MemTable.Active
    then FFilterExpr.ParseExpression(Filter)
    else FFilterExpr.ParseExpression('');
end;

procedure TMemTableFilterItemEh.SetActive(Value: Boolean);
begin
  if FActive <> Value then
  begin
    FActive := Value;
    Changed(False);
  end;
end;

procedure TMemTableFilterItemEh.SetFilter(const Value: String);
begin
  if FFilter <> Value then
  begin
    FFilter := Value;
    if Active then
      Changed(False);
  end;
end;

procedure TMemTableFilterItemEh.SetOnFilterRecord(Value: TFilterRecordEvent);
begin
  if @FOnFilterRecord <> @Value then
  begin
    FOnFilterRecord := Value;
    if Active then
      Changed(False);
  end;
end;

procedure TMemTableFilterItemEh.FilterProcChanged;
begin
  if Active then
    Changed(False);
end;

{ TMemTableFiltersEh }

constructor TMemTableFiltersEh.Create(AMemTable: TCustomMemTableEh; FilterItemClass: TMemTableFilterItemEhClass);
begin
  inherited Create(FilterItemClass);
  FMemTable := AMemTable;
  FActiveFilterItems := TObjectListEh.Create;
end;

destructor TMemTableFiltersEh.Destroy;
begin
  FreeAndNil(FActiveFilterItems);
  inherited Destroy;
end;

function TMemTableFiltersEh.GetActiveFilterCount: Integer;
begin
  Result := FActiveFilterItems.Count;
end;

function TMemTableFiltersEh.Add: TMemTableFilterItemEh;
begin
  Result := TMemTableFilterItemEh(inherited Add);
end;

function TMemTableFiltersEh.GetActiveFilterItem(
  Index: Integer): TMemTableFilterItemEh;
begin
  Result := TMemTableFilterItemEh(FActiveFilterItems[Index]);
end;

function TMemTableFiltersEh.GetFilterItem(Index: Integer): TMemTableFilterItemEh;
begin
  Result := TMemTableFilterItemEh(inherited Items[Index]);
end;

procedure TMemTableFiltersEh.SetFilterItem(Index: Integer; Value: TMemTableFilterItemEh);
begin
  Items[Index] := Value;
end;

function TMemTableFiltersEh.GetOwner: TPersistent;
begin
  Result := FMemTable;
end;

function TMemTableFiltersEh.HasTextActiveFilter: Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to Count-1 do
  begin
    if Items[i].Active and (Items[i].Filter <> '') then
    begin
      Result := True;
      Exit;
    end;
  end;
end;

function TMemTableFiltersEh.IndexOfFilter(FilterItem: TMemTableFilterItemEh): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to Count-1 do
    if Items[i] = FilterItem then
    begin
      Result := i;
      Exit;
    end;
end;

function TMemTableFiltersEh.IsCurRecordInFilter(Rec: TMemoryRecordEh): Boolean;
var
  i: Integer;
begin
  Result := True;
  for i := 0 to Count-1 do
    if Items[i].Filtered then
    begin
      Result := Items[i].IsCurRecordInFilter(Rec);
      if not Result then
        Exit;
    end;
end;

function TMemTableFiltersEh.HasEventActiveFilter: Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to Count-1 do
    if Items[i].Active and (Assigned(Items[i].OnFilterRecord)) then
    begin
      Result := True;
      Exit;
    end;
end;

procedure TMemTableFiltersEh.RecreateFilterExpr;
var
  i: Integer;
begin
  for i := 0 to Count-1 do
    Items[i].RecreateFilterExpr;
end;

procedure TMemTableFiltersEh.Update(Item: TCollectionItem);
var
  i, a: Integer;
  ActiveChanged: Boolean;

  procedure RefreshDataSet;
  begin
    if MemTable.Active and not (csDestroying in MemTable.ComponentState) then
    begin
      MemTable.InternalRefreshFilter;
      MemTable.Resync([]);
    end;
  end;
begin
  inherited Update(Item);
  if Item <> nil then
    ActiveChanged := True
  else
  begin
    a := 0;
    ActiveChanged := False;
    for i := 0 to Count-1 do
    begin
      if Items[i].Filtered then
      begin
        Inc(a);
        if (a >= FActiveFilterItems.Count) or (FActiveFilterItems[a] <> Items[i]) then
        begin
          ActiveChanged := True;
          Break;
        end;
      end;
    end;
    if a <> FActiveFilterItems.Count then
      ActiveChanged := True;
  end;
  if ActiveChanged then
  begin
    FActiveFilterItems.Clear;
    RecreateFilterExpr;
    for i := 0 to Count-1 do
      if Items[i].Filtered then
        FActiveFilterItems.Add(Items[i]);
    RefreshDataSet;
  end;
end;

end.
