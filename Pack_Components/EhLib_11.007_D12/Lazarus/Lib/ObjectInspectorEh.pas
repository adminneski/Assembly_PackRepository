{*******************************************************}
{                                                       }
{                        EhLib 10.2                     }
{                                                       }
{                  TDBVertGrid component                }
{                                                       }
{    Copyright (c) 2013-2022 by Dmitry V. Bolshakov     }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit ObjectInspectorEh;

interface

{$SCOPEDENUMS ON}

uses
  SysUtils, Classes, Controls, Graphics,
  MemTreeEh, Contnrs,
  {$IFDEF FPC}
    EhLibLCL, LMessages, LCLType,
    {$IFDEF FPC_CROSSP}
      LCLIntf,
    {$ELSE}
      Windows, Win32Extra, UxTheme,
    {$ENDIF}
  {$ELSE}
    EhLibVCL, StdCtrls, Windows,
  {$ENDIF}
  Messages,
  TypInfo, DBAxisGridsEh, GridsEh, ToolCtrlsEh,
  Themes,
{$IFDEF EH_LIB_16} System.UITypes, {$ENDIF}
{$IFDEF EH_LIB_17} System.Generics.Collections, {$ENDIF}
{$IFDEF EH_LIB_13} Rtti, {$ENDIF} //RAD Studio 2010
  Variants, Forms;

type
  TPropTreeListEh = class;
  TObjectInspectorEh = class;
  TInspectorInplaceEditEh = class;

  TPropDataAccessWayEh = (TypeInfo, Rtti);

{ TPropTreeNodeEh }

  TPropTreeNodeEh = class(TBaseTreeNodeEh)
  private
    FColorList: TStrings;
    FInstance: TObject;
    FIsCompmentSubrops: Boolean;
    FIsSetValue: Boolean;
    FPropInfo: PPropInfo;
    FPropName: String;
    FPropStrValue: String;
    FSetIndex: Integer;
    FTypeInfo: PTypeInfo;

    function GetItem(const Index: Integer): TPropTreeNodeEh; reintroduce;
    function GetNodeOwner: TPropTreeListEh;
    function GetNodeParent: TPropTreeNodeEh;
    function GetVisibleItem(const Index: Integer): TPropTreeNodeEh;

    procedure SetNodeParent(const Value: TPropTreeNodeEh);

  protected
    procedure GetColorStrProc(const S: string);

  public
    constructor Create; override;
    destructor Destroy; override;

    function GetFontStyle: TFontStyles;
    function GetEditStyle: TEditStyle;

    procedure Collapse;
    procedure Expand;
    procedure GetListValues(Items: TStrings);
    procedure RefreshValue;
    procedure SetValueAsString(const SValue: String);

    property Expanded;
    property HasChildren;
    property Instance: TObject read FInstance write FInstance;
    property IsCompmentSubrops: Boolean read FIsCompmentSubrops;
    property IsSetValue: Boolean read FIsSetValue write FIsSetValue;
    property Items[const Index: Integer]: TPropTreeNodeEh read GetItem; default;
    property Owner: TPropTreeListEh read GetNodeOwner;
    property Parent: TPropTreeNodeEh read GetNodeParent write SetNodeParent;
    property PropInfo: PPropInfo read FPropInfo write FPropInfo;
    property PropName: String read FPropName write FPropName;
    property PropStrValue: String read FPropStrValue write FPropStrValue;
    property SetIndex: Integer read FSetIndex write FSetIndex;
    property TypeInfo: PTypeInfo read FTypeInfo write FTypeInfo;
    property VisibleItem[const Index: Integer]: TPropTreeNodeEh read GetVisibleItem;
  end;

  TPropTreeNodeClassEh = class of TPropTreeNodeEh;

{ TPropTreeListEh }

  TPropTreeListEh = class(TTreeListEh)
  private
    FVisibleExpandedItems: TObjectList;
    FVisibleItemsObsolete: Boolean;
    FObjInspector: TObjectInspectorEh;
    function GetRoot: TPropTreeNodeEh;

  protected
    function GetVisibleCount: Integer;
    function GetVisibleExpandedItem(const Index: Integer): TPropTreeNodeEh; virtual;

  public
    constructor Create(ItemClass: TPropTreeNodeClassEh; ObjInspector: TObjectInspectorEh);
    destructor Destroy; override;

    procedure BuildVisibleItems;
    procedure VisibleItemsBecomeObsolete;
    procedure RefreshAllValues;

    property ObjectInspector: TObjectInspectorEh read FObjInspector;
    property Root: TPropTreeNodeEh read GetRoot;
    property VisibleExpandedCount: Integer read GetVisibleCount;
    property VisibleExpandedItem[const Index: Integer]: TPropTreeNodeEh read GetVisibleExpandedItem; default;
    property VisibleExpandedItems: TObjectList read FVisibleExpandedItems;
    property VisibleItemsObsolete: Boolean read FVisibleItemsObsolete;
  end;

{ TObjectInspectorEh }

  TObjectInspectorEh = class(TCustomGridEh)
  private
    FEditChangedThroughEnChangeCode: Boolean;
    FLabelColWidth: Integer;
    FLayoutLock: Integer;
    FObservableObject: TObject;
    FPropTreeList: TPropTreeListEh;
    FRowCaptionFont: TFont;
    FPropDataAccessWay: TPropDataAccessWayEh;

    function GetComponent: TObject;
    function GetLabelColWidth: Integer;
    function GetInplaceEdit: TInspectorInplaceEditEh;

    procedure SetComponent(const Value: TObject);
    procedure SetLabelColWidth(const Value: Integer);

    procedure CMHintShow(var Message: TCMHintShow); message CM_HINTSHOW;
    procedure CMHintsShowPause(var Message: TCMHintShowPause); message CM_HINTSHOWPAUSE;

    procedure WMCommand(var Message: TWMCommand); message WM_COMMAND;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;

  protected
    function AcquireLayoutLock: Boolean;
    function CreateEditor: TInplaceEdit; override;
    function IsSmoothVertScroll: Boolean; override;

    procedure BeginLayout;
    procedure CalcSizingState(X, Y: Integer; var State: TGridStateEh; var Index: Longint; var SizingPos, SizingOfs: Integer); override;
    procedure CellMouseClick(const Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; const ACellRect: TRect; const GridMousePos, CellMousePos: TPoint); override;
    procedure CellMouseDown(const Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; const ACellRect: TRect; const GridMousePos, CellMousePos: TPoint); override;
    procedure ColWidthsChanged; override;
    procedure ComponentChanged;
    procedure DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState); override;
    procedure DrawDataCell(ACol, ARow: Longint; AreaCol, AreaRow: Longint; ARect: TRect; AState: TGridDrawState); virtual;
    procedure DrawLabelCell(ACol, ARow: Longint; AreaCol, AreaRow: Longint; ARect: TRect; AState: TGridDrawState); virtual;
    procedure EndLayout;
    procedure InternalLayout;
    procedure LayoutChanged;
    procedure RowCaptionFontChanged(Sender: TObject);
    procedure ScrollBarMessage(ScrollBar, ScrollCode, Pos: Integer; UseRightToLeft: Boolean); override;
    procedure UpdateRowCount;
    procedure UpdateRowHeights;

{ Inplace Editor }
    function GetEditStyle(ACol, ARow: Longint): TEditStyle; override;
    function GetEditText(ACol, ARow: Longint): string; override;
    procedure CurrentCellMoved(OldCurrent: TGridCoord); override;
    procedure SetEditText(ACol, ARow: Longint; const Value: string); override;
    procedure UpdateText(EditorChanged: Boolean); override;

    procedure EditButtonClick;
    procedure GetPickListItems(ACol, ARow: Integer; Items: TStrings);

    function GetClassPropListAsArray(AClass: TClass): TPropListArray;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function GetTreeNodeAt(ARow: Integer): TPropTreeNodeEh;

    property LabelColWidth: Integer read GetLabelColWidth write SetLabelColWidth default 64;
    property PropTreeList: TPropTreeListEh read FPropTreeList;
    property InplaceEditor: TInspectorInplaceEditEh read GetInplaceEdit;

  published
    property PropDataAccessWay: TPropDataAccessWayEh read FPropDataAccessWay write FPropDataAccessWay;
    property Component: TObject read GetComponent write SetComponent;
    property ParentFont;
    property Options;
  end;

{ TInspectorInplaceEditEh }

  TOnGetPickListItems = procedure(ACol, ARow: Integer; Items: TStrings) of Object;

  TInspectorInplaceEditEh = class(TInplaceEdit)
  private
    FActiveList: TWinControl;
    FButtonWidth: Integer;
    FDropDownRows: Integer;
    FEditStyle: TEditStyle;
    FListVisible: Boolean;
    FMouseInControl: Boolean;
    FOnEditButtonClick: TNotifyEvent;
    FOnGetPickListitems: TOnGetPickListItems;
    FPickList: TComboBoxPopupListboxEh;
    FPickListLoaded: Boolean;
    FPressed: Boolean;
    FTracking: Boolean;

    function GetGrid: TObjectInspectorEh;
    function GetPickList: TComboBoxPopupListboxEh;

    {$IFDEF FPC}
    {$ELSE}
    procedure CMCancelMode(var Message: TCMCancelMode); message CM_CANCELMODE;
    {$ENDIF}
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;

    procedure WMCancelMode(var Message: TMessage); message WM_CANCELMODE;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMSetCursor(var Message: TWMSetCursor); message WM_SETCURSOR;

  protected
    function ButtonRect: TRect;
    function GetEditCoreBounds: TRect; override;
    function OverButton(const P: TPoint): Boolean;

    procedure BoundsChanged; override;
    procedure Change; override;
    procedure CloseUp(Accept: Boolean); dynamic;
    procedure DblClick; override;
    procedure DoDropDownKeys(var Key: Word; Shift: TShiftState); virtual;
    procedure DoEditButtonClick; virtual;
    procedure DoGetPickListItems; dynamic;
    procedure DropDown; dynamic;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure ListMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure LoseFocus(NewFocusWnd: HWND); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure PaintWindow(DC: HDC); override;
    procedure StopTracking;
    procedure TrackButton(X,Y: Integer);
    procedure UpdateContents; override;
    procedure WndProc(var Message: TMessage); override;

  public
    constructor Create(Owner: TComponent); override;

    procedure RestoreContents;

    property ActiveList: TWinControl read FActiveList write FActiveList;
    property ButtonWidth: Integer read FButtonWidth write FButtonWidth;
    property DropDownRows: Integer read FDropDownRows write FDropDownRows;
    property EditStyle: TEditStyle read FEditStyle;
    property Grid: TObjectInspectorEh read GetGrid;
    property ListVisible: Boolean read FListVisible write FListVisible;
    property PickList: TComboBoxPopupListboxEh read GetPickList;
    property PickListLoaded: Boolean read FPickListLoaded write FPickListLoaded;
    property Pressed: Boolean read FPressed;

    property OnEditButtonClick: TNotifyEvent read FOnEditButtonClick write FOnEditButtonClick;
    property OnGetPickListitems: TOnGetPickListItems read FOnGetPickListitems write FOnGetPickListitems;
  end;


procedure ShowObjectInspectorForm(Component: TObject; FormBounds: TRect;
  NewForm: Boolean = False);

var
  ObjectInspectorForm: TCustomForm;

implementation

uses Types, DBCtrls;


function GetPropValueAsString(Instance: TObject; APropInfo: PPropInfo): String;
var
  APropType: PTypeInfo;
  ATypeKind: TTypeKind;

  function SetAsString(Value: Longint): String;
  var
    I: Integer;
    BaseType: PTypeInfo;
  begin
{$IFDEF CIL}
    BaseType := GetTypeData(APropType).CompType;
{$ELSE}
  {$IFDEF FPC}
    BaseType := GetTypeData(APropType)^.CompType;
  {$ELSE}
    BaseType := GetTypeData(APropType)^.CompType^;
  {$ENDIF}
{$ENDIF}
    Result := '[';
    for I := 0 to SizeOf(TIntegerSet) * 8 - 1 do
      if I in TIntegerSet(Value) then
      begin
        if Length(Result) <> 1 then Result := Result + ',';
        Result := Result + GetEnumName(BaseType, I);
      end;
    Result := Result + ']';
  end;

  function IntPropAsString(IntType: PTypeInfo; Value: Longint): String;
  var
    Ident: string;
    IntToIdent: TIntToIdent;
  begin
    Ident := '';
    IntToIdent := FindIntToIdent(IntType);
    if Assigned(IntToIdent) and IntToIdent(Value, Ident) then
      Result := Ident
    else
      Result := IntToStr(Value);
  end;

  function CollectionAsString(Collection: TCollection): String;
  begin
    Result := '(' + Collection.ClassName + ')';
  end;

  function OrdPropAsString: String;
  var
    Value: Longint;
  begin
    Value := GetOrdProp(Instance, APropInfo);
    case PropType_GetKind(APropType) of
      tkInteger:
        Result := IntPropAsString(PropInfo_getPropType(APropInfo), Value);
      tkChar:
        Result := Chr(Value);
      tkSet:
        Result := SetAsString(Value);
      tkEnumeration:
        Result := GetEnumName(APropType, Value);
    end;
  end;

  function FloatPropAsString: String;
  var
    Value: Extended;
  begin
    Value := GetFloatProp(Instance, APropInfo);
    Result := FloatToStr(Value);
  end;

  function Int64PropAsString: String;
  var
    Value: Int64;
  begin
    Value := GetInt64Prop(Instance, APropInfo);
    Result := IntToStr(Value);
  end;

  function StrPropAsString: String;
  begin
{$IFDEF NEXTGEN}
    Result := String(GetStrProp(Instance, APropInfo));
{$ELSE}
    Result := String(GetWideStrProp(Instance, APropInfo));
{$ENDIF}
  end;

  function MethodPropAsString: String;
  var
    Value: TMethod;
  begin
    Value := GetMethodProp(Instance, APropInfo);
    if Value.Code = nil then
      Result := ''
    else
      Result := Instance.MethodName(Value.Code);
  end;

  function ObjectPropAsString: String;
  var
    Value: TObject;
  begin
    Value := GetObjectProp(Instance, APropInfo);
    if Value = nil
      then Result := ''
      else Result := '(' + Value.ClassName + ')';
  end;

  function VariantPropAsString: String;
  var
    Value: Variant;
  begin
    Value := GetVariantProp(Instance, APropInfo);
    Result := VarToStr(Value);
  end;

  function InterfacePropAsString: String;
  var
    Intf: IInterface;
    Value: TComponent;
    SR: IInterfaceComponentReference;
  begin
    Result := '';
    try
      Intf := GetInterfaceProp(Instance, APropInfo);
    except
      Intf := nil;
    end;
    if Intf = nil then
    begin
      Result := '';
    end
    else if Supports(Intf, IInterfaceComponentReference, SR) then
    begin
      Value := SR.GetComponent;
      Result := Value.Name;
    end;
  end;

  function StrPropAsBool: String;
  var
    Value: Longint;
  begin
    Value := GetOrdProp(Instance, APropInfo);
    Result := BooleanIdents[Boolean(Value)];
  end;

  function RecordPropAsString: String;
  {$IFDEF EH_LIB_13} //RAD Studio 2010
  var
    FContext : TRttiContext;
//    APropType: PTypeInfo;
    FType    : TRttiType;
    FProp    : TRttiProperty;
    RttiValue: TValue;
    ItemVal: TValue;
    tp: TRttiProperty;
    {$IFDEF FPC}
    {$ELSE}
    tf: TRttiField;
    {$ENDIF}
  begin
    //Instance: TObject; APropInfo: PPropInfo
    FContext := TRttiContext.Create;
//    APropType := PropInfo_getPropType(APropInfo);

    FType := FContext.GetType(Instance.ClassType);
    FProp := FType.GetProperty(String(APropInfo.Name));
    RttiValue := FProp.GetValue(Instance);

    Result := '';
    for tp in FProp.PropertyType.GetProperties do
    begin
      ItemVal := tp.GetValue(RttiValue.GetReferenceToRawData);
      if Result = ''
        then Result := ItemVal.ToString
        else Result := Result + ', ' + ItemVal.ToString;
    end;

    {$IFDEF FPC}
    {$ELSE}
    for tf in FProp.PropertyType.GetFields do
    begin
      ItemVal:= tf.GetValue(RttiValue.GetReferenceToRawData);
      if Result = ''
        then Result := ItemVal.ToString
        else Result := Result + ', ' + ItemVal.ToString;
    end;
    {$ENDIF}

    //RttiValue.TryAsType<TPoint>(Val);
    FContext.Free;
  end;
  {$ELSE}
  begin
    Result := '';
  end;
  {$ENDIF}

begin

  APropType := PropInfo_getPropType(APropInfo);
  ATypeKind := PropType_getKind(APropType);
  case ATypeKind of
    tkInteger, tkChar, tkEnumeration, tkSet:
      Result := OrdPropAsString;
    tkFloat:
      Result := FloatPropAsString;
    tkString, tkLString, tkWString:
      Result := StrPropAsString;
    tkClass:
      Result := ObjectPropAsString;
    tkMethod:
      Result := MethodPropAsString;
    tkVariant:
      Result := VariantPropAsString;
    tkInt64:
      Result := Int64PropAsString;
    tkInterface:
      Result := InterfacePropAsString;
{$IFDEF EH_LIB_12}
    tkUString:
      Result := StrPropAsString;
{$ENDIF}
{$IFDEF FPC}
    tkBool:
       Result := StrPropAsBool;
{$ELSE}
{$ENDIF}
     tkRecord:
        Result := RecordPropAsString;
  else
    Result := '?';
  end;
end;

type
  TObjectInspectorFormEh = class(TCustomForm)
    procedure DoClose(var Action: TCloseAction); override;
  end;

procedure TObjectInspectorFormEh.DoClose(var Action: TCloseAction);
begin
  Action := caFree;
  if Self = ObjectInspectorForm then
    ObjectInspectorForm := nil;
end;

procedure ShowObjectInspectorForm(Component: TObject; FormBounds: TRect;
  NewForm: Boolean = False);
var
  Form: TObjectInspectorFormEh;
  FObjIns: TObjectInspectorEh;
{$IFDEF EH_LIB_26} 
  LPPI: Integer;
{$ENDIF}
begin
  if NewForm or (ObjectInspectorForm = nil) then
  begin
    Form := TObjectInspectorFormEh.CreateNew(Application);
    Form.ParentFont := True;
{$IFDEF EH_LIB_26} 
    LPPI := Screen.PixelsPerInch;
    Form.ScaleForPPI(LPPI);
{$ENDIF}

    FObjIns := TObjectInspectorEh.Create(Form);
    FObjIns.Parent := Form;
    FObjIns.Left := 100;
    FObjIns.Top := 100;
    FObjIns.Anchors := [akLeft, akTop, akRight, akBottom];
    FObjIns.Flat := True;
    FObjIns.ParentFont := True;
    FObjIns.LabelColWidth := 100;
    FObjIns.Options := [goFixedVertLineEh, goVertLineEh, goEditingEh, goAlwaysShowEditorEh];
    FObjIns.Align := alClient;
    FObjIns.Name := 'ObjectInspectorEh';
    if not NewForm then
      ObjectInspectorForm := Form;
  end else
    Form := TObjectInspectorFormEh(ObjectInspectorForm);

  TObjectInspectorEh(Form.FindComponent('ObjectInspectorEh')).Component := Component;
  if Component <> nil then
  begin
    if Component is TComponent then
      Form.Caption := TComponent(Component).Name + ': ';
    Form.Caption := Form.Caption + Component.ClassName
  end else
    Form.Caption := '';
  Form.SetBounds(FormBounds.Left, FormBounds.Top,
    FormBounds.Right-FormBounds.Left, FormBounds.Bottom-FormBounds.Top);
  Form.Show;
end;

{$IFDEF FPC}
function GetRttiPropListAsArray(AClass: TClass): TPropListArray;
begin
  Result := nil;
end;

{$ELSE} //FPC

{$IFDEF EH_LIB_13} //RAD Studio 2010
function GetRttiPropListAsArray(AClass: TClass): TPropListArray;
var
  LContext: TRttiContext;
  LType: TRttiType;
  RttiProps: TArray<TRttiProperty>;
  I, J: Integer;
  PInfo: PPropInfo;
  PTpInfo: PTypeInfo;
begin
  LContext := TRttiContext.Create;
  try
    LType := LContext.GetType(AClass);

    RttiProps := LType.GetProperties();
    SetLength(Result, Length(RttiProps));

    J := 0;
    for I := 0 to Length(RttiProps) - 1 do
    begin
      PInfo := PPropInfoEx(RttiProps[I].Handle).Info;
      PTpInfo := PropInfo_getPropType(PInfo);
      if (PTpInfo.Kind <> tkMethod) then
      begin
        Result[J] := PInfo;
        Inc(J);
      end;
    end;

    SetLength(Result, J);

  finally
    LContext.Free;
  end;
end;
{$ELSE}  //RAD Studio 2010
function GetRttiPropListAsArray(AClass: TClass): TPropListArray;
begin
  Result := nil;
end;
{$ENDIF} //RAD Studio 2010

{$ENDIF} // ELSE FPC

{ TObjectInspectorEh }

constructor TObjectInspectorEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FDesignOptionsBoost := [goColSizingEh];
  FRowCaptionFont := TFont.Create;
  FRowCaptionFont.OnChange := RowCaptionFontChanged;

  FPropTreeList := TPropTreeListEh.Create(TPropTreeNodeEh, Self);

  BeginLayout;
  FixedRowCount := 0;
  inherited RowCount := 1;
  inherited ColCount := 2;
  LabelColWidth := 64;
  EndLayout;
  ShowHint := True;
end;

destructor TObjectInspectorEh.Destroy;
begin
  FreeAndNil(FRowCaptionFont);
  FreeAndNil(FPropTreeList);
  inherited Destroy;
end;

procedure TObjectInspectorEh.DrawCell(ACol, ARow: Integer; ARect: TRect; AState: TGridDrawState);
var
  AreaCol, AreaRow: Integer;
begin
  AreaCol := ACol;
  AreaRow := ARow;
  if ACol = 0 then
    DrawLabelCell(ACol, ARow, AreaCol, AreaRow, ARect, AState)
  else
  begin
    Dec(AreaCol);
    DrawDataCell(ACol, ARow, AreaCol, AreaRow, ARect, AState);
  end;
end;

procedure TObjectInspectorEh.DrawDataCell(ACol, ARow, AreaCol,
  AreaRow: Integer; ARect: TRect; AState: TGridDrawState);
var
  S: String;
  VFrameOffs: Byte;
  HFrameOffs: Byte;
  TreeNode: TPropTreeNodeEh;
begin
  Canvas.Brush.Color := Color; 
  Canvas.FillRect(ARect);
  if AreaRow < PropTreeList.VisibleExpandedCount then
  begin
    Canvas.Font := Font;
    TreeNode := PropTreeList.VisibleExpandedItem[AreaRow];
    S := TreeNode.PropStrValue;

    HFrameOffs := 2;
    if Flat
      then VFrameOffs := 1
      else VFrameOffs := 2;

    if (TreeNode.Parent.Instance <> nil) and
       (TreeNode.PropInfo <> nil) and
       IsStoredProp(TreeNode.Parent.Instance, TreeNode.PropInfo)
    then
    {$IFDEF FPC}
      ;
    {$ELSE}
      if not IsDefaultPropertyValue(TreeNode.Parent.Instance, TreeNode.PropInfo, nil) then
         Canvas.Font.Style := Canvas.Font.Style + [fsBold];
    {$ENDIF}

    WriteTextEh(Canvas, ARect, False, HFrameOffs, VFrameOffs,
      S, taLeftJustify, tlCenter, False,
      False, 0, 0, False, True);
  end;
end;

procedure TObjectInspectorEh.DrawLabelCell(ACol, ARow, AreaCol,
  AreaRow: Integer; ARect: TRect; AState: TGridDrawState);
var
  S: String;
  VFrameOffs: Byte;
  HFrameOffs: Byte;
  TextRect: TRect;
  TreeSignRect: TRect;
  TreeNode: TPropTreeNodeEh;
  TreeElement: TTreeElementEh;
begin
  if Row = ARow
    then Canvas.Brush.Color := cl3DLight
    else Canvas.Brush.Color := Color; 
  Canvas.FillRect(ARect);
  TextRect := ARect;
  if AreaRow < PropTreeList.VisibleExpandedCount then
  begin
    Canvas.Font := Font;
    TreeNode := PropTreeList.VisibleExpandedItem[AreaRow];
    S := TreeNode.PropName;
    Inc(TextRect.Left, DefaultRowHeight * TreeNode.Level);

    if TreeNode.HasChildren then
    begin
      TreeSignRect := TextRect;
      TreeSignRect.Right := TreeSignRect.Left;
      TreeSignRect.Left := TreeSignRect.Left - DefaultRowHeight;
      if TreeNode.Expanded
        then TreeElement := tehMinus
        else TreeElement := tehPlus;
      Canvas.Pen.Color := clWindowText;
      DrawTreeElement(Canvas, TreeSignRect, TreeElement, False, ScaleFactor, ScaleFactor,
        UseRightToLeftAlignment, False, tvgsThemedEh);
    end;

    HFrameOffs := 0;
    if Flat
      then VFrameOffs := 1
      else VFrameOffs := 2;

    if TreeNode.Instance is TComponent then
      Canvas.Font.Color := clMaroon
    else if TreeNode.IsCompmentSubrops then
      Canvas.Font.Color := clGreen;

    WriteTextEh(Canvas, TextRect, False, HFrameOffs, VFrameOffs,
      S, taLeftJustify, tlCenter, False,
      False, 0, 0, False, True);
  end;
end;

procedure TObjectInspectorEh.BeginLayout;
begin
  Inc(FLayoutLock);
end;

procedure TObjectInspectorEh.EndLayout;
begin
  if FLayoutLock > 0 then
  begin
    try
      try
        if FLayoutLock = 1 then
          InternalLayout;
      finally
      end;
    finally
      if FLayoutLock > 0 then
        Dec(FLayoutLock);
    end;
  end;
end;

procedure TObjectInspectorEh.RowCaptionFontChanged(Sender: TObject);
begin
  LayoutChanged;
end;

function TObjectInspectorEh.GetLabelColWidth: Integer;
begin
  Result := FLabelColWidth;
end;

procedure TObjectInspectorEh.SetLabelColWidth(const Value: Integer);
begin
  if Value <> FLabelColWidth then
  begin
    FLabelColWidth := Value;
    LayoutChanged;
  end;
end;

procedure TObjectInspectorEh.InternalLayout;
var
  WinWidth: Integer;
begin
  if (csLoading in ComponentState) or
     (csDestroying in ComponentState)
  then
    Exit;

  try
    LockPaint;

    if ([csLoading, csDestroying] * ComponentState) <> [] then Exit;

    ColCount := 2;
    inherited FixedColCount := 1;

    ColWidths[0] := LabelColWidth;

    WinWidth := HorzAxis.GridClientLen;

    ColWidths[1] := WinWidth - ColWidths[0]-2;

    UpdateRowCount;
    UpdateRowHeights;

    InvalidateEditor;
    Invalidate;

  finally
    UnlockPaint;
    UpdateBoundaries;
  end;
end;

procedure TObjectInspectorEh.LayoutChanged;
begin
  if AcquireLayoutLock then
    EndLayout;
end;

function TObjectInspectorEh.AcquireLayoutLock: Boolean;
begin
  Result := FLayoutLock = 0;
  if Result then BeginLayout;
end;

procedure TObjectInspectorEh.UpdateRowCount;
begin
  if Component = nil
    then RowCount := 1
    else RowCount := PropTreeList.VisibleExpandedCount;
end;

procedure TObjectInspectorEh.UpdateRowHeights;
var
  CanvasHandleAllocated: Boolean;
  i: Integer;
begin
  CanvasHandleAllocated := True;
  if not Canvas.HandleAllocated then
  begin
    Canvas.Handle := GetDC(0);
    CanvasHandleAllocated := False;
  end;
  try

    DefaultRowHeight := Canvas.TextHeight('Wg') + 2;
    for i := 0 to RowCount-1 do
      RowHeights[i] := DefaultRowHeight;

  finally
    if not CanvasHandleAllocated then
    begin
      ReleaseDC(0, Canvas.Handle);
      Canvas.Handle := 0;
    end;
  end;
end;

function TObjectInspectorEh.GetComponent: TObject;
begin
  Result := FObservableObject;
end;

procedure TObjectInspectorEh.SetComponent(const Value: TObject);
begin
  if Value <> FObservableObject then
  begin
    FObservableObject := Value;
    ComponentChanged;
  end;
end;

procedure TObjectInspectorEh.WMSize(var Message: TWMSize);
begin
  inherited;
  LayoutChanged;
  UpdateEdit;
end;

procedure TObjectInspectorEh.CalcSizingState(X, Y: Integer;
  var State: TGridStateEh; var Index, SizingPos, SizingOfs: Integer);
begin
  inherited CalcSizingState(X, Y, State, Index, SizingPos, SizingOfs);
  if (HorzAxis.FixedBoundary - 4 {- VertLineWidth} < X) and (HorzAxis.FixedBoundary + 4 > X) then
  begin
    State := gsColSizingEh;
    SizingPos := HorzAxis.FixedBoundary;
    SizingOfs := HorzAxis.FixedBoundary - X - 1;
    Index := 0;
  end;
end;

procedure TObjectInspectorEh.ColWidthsChanged;
begin
  inherited ColWidthsChanged;
  if AcquireLayoutLock then
  try
    if LabelColWidth <> ColWidths[0] then
    begin
      LabelColWidth := ColWidths[0];
      LayoutChanged;
    end;

  finally
    EndLayout;
    UpdateEdit;
  end;
end;

procedure TObjectInspectorEh.ComponentChanged;
var
  PropList: TPropListArray;
  NewNode: TPropTreeNodeEh;
  i: Integer;
begin
  PropList := nil;
  PropTreeList.Clear;
  PropTreeList.Root.Instance := Component;

  if Component <> nil then
  begin
    //PropList := GetPropListAsArray(Component.ClassInfo, tkProperties);
     PropList := GetClassPropListAsArray(Component.ClassType);

    for i := 0 to Length(PropList)-1 do
    begin
      NewNode := TPropTreeNodeEh(PropTreeList.AddChild('', nil, nil));
      NewNode.PropInfo := PropList[i];
      NewNode.TypeInfo := PropInfo_getPropType(NewNode.PropInfo);

{$IFDEF NEXTGEN}
      NewNode.PropName := PropList[i].NameFld.ToString;
{$ELSE}
      NewNode.PropName := String(PropList[i].Name);
{$ENDIF}

      NewNode.PropStrValue := GetPropValueAsString(Component, PropList[i]);
      if (NewNode.TypeInfo.Kind = tkSet) or
         ((NewNode.TypeInfo.Kind = tkClass) and (NewNode.PropStrValue <> '')) or
         (NewNode.TypeInfo.Kind = tkRecord)
      then
        NewNode.HasChildren := True
      else
        NewNode.HasChildren := False;

      if (NewNode.TypeInfo.Kind = tkClass)
//        or (NewNode.TypeInfo.Kind = tkRecord)
      then
        NewNode.Instance := GetObjectProp(Component, NewNode.PropInfo)
      else
        NewNode.Instance := nil;

      PropTreeList.VisibleItemsBecomeObsolete;
    end;
  end;
  LayoutChanged;
end;

function TObjectInspectorEh.IsSmoothVertScroll: Boolean;
begin
  Result := True;
end;

procedure TObjectInspectorEh.ScrollBarMessage(ScrollBar, ScrollCode,
  Pos: Integer; UseRightToLeft: Boolean);
begin
  if ScrollCode = SB_THUMBTRACK then
    ScrollCode := SB_THUMBPOSITION;
  inherited ScrollBarMessage(ScrollBar, ScrollCode, Pos, UseRightToLeft);
end;

procedure TObjectInspectorEh.CellMouseClick(const Cell: TGridCoord;
  Button: TMouseButton; Shift: TShiftState; const ACellRect: TRect;
  const GridMousePos, CellMousePos: TPoint);
var
  TreeNode: TPropTreeNodeEh;
begin
  inherited CellMouseClick(Cell, Button, Shift, ACellRect, GridMousePos, CellMousePos);

  if (Cell.Y < PropTreeList.VisibleExpandedCount) and (Cell.X = 0) and (ssDouble in Shift) then
  begin
    TreeNode := PropTreeList.VisibleExpandedItem[Cell.Y];

    if TreeNode.HasChildren then
    begin
      if TreeNode.Expanded
        then TreeNode.Collapse
        else TreeNode.Expand;
    end;
  end;
end;

procedure TObjectInspectorEh.CellMouseDown(const Cell: TGridCoord;
  Button: TMouseButton; Shift: TShiftState; const ACellRect: TRect;
  const GridMousePos, CellMousePos: TPoint);
var
  TreeNode: TPropTreeNodeEh;
  LeftTreeBorder, RightTreeBorder: Integer;
begin
  inherited CellMouseDown(Cell, Button, Shift, ACellRect, GridMousePos, CellMousePos);

  if (Cell.Y < PropTreeList.VisibleExpandedCount) and (Cell.X = 0) then
  begin
    Row := Cell.Y;
    TreeNode := PropTreeList.VisibleExpandedItem[Cell.Y];

    if TreeNode.HasChildren then
    begin
      LeftTreeBorder := DefaultRowHeight * (TreeNode.Level-1);
      RightTreeBorder := DefaultRowHeight * (TreeNode.Level);

      if (CellMousePos.X > LeftTreeBorder) and (CellMousePos.X < RightTreeBorder) then
        if TreeNode.Expanded
          then TreeNode.Collapse
          else TreeNode.Expand;
    end;
  end;
end;

function TObjectInspectorEh.GetEditStyle(ACol, ARow: Integer): TEditStyle;
var
  TreeNode: TPropTreeNodeEh;
begin
  Result := esSimple;
  if ARow < PropTreeList.VisibleExpandedCount then
  begin
    TreeNode := PropTreeList.VisibleExpandedItem[ARow];
    Result := TreeNode.GetEditStyle;
  end;
end;

function TObjectInspectorEh.GetEditText(ACol, ARow: Integer): string;
var
  TreeNode: TPropTreeNodeEh;
begin
  if ARow < PropTreeList.VisibleExpandedCount then
  begin
    TreeNode := PropTreeList.VisibleExpandedItem[ARow];
    Result := TreeNode.PropStrValue;
  end else
    Result := '';
end;

procedure TObjectInspectorEh.SetEditText(ACol, ARow: Integer; const Value: string);
var
  TreeNode: TPropTreeNodeEh;
begin
  if ARow < PropTreeList.VisibleExpandedCount then
  begin
    TreeNode := PropTreeList.VisibleExpandedItem[ARow];
    if TreeNode.PropStrValue <> Value then
    begin
      TreeNode.SetValueAsString(Value);
      PropTreeList.RefreshAllValues;
      InplaceEditor.UpdateContents;
      Invalidate;
    end;
  end;
end;

function TObjectInspectorEh.CreateEditor: TInplaceEdit;
begin
  Result := TInspectorInplaceEditEh.Create(Self);
end;

procedure TObjectInspectorEh.EditButtonClick;
begin

end;

procedure TObjectInspectorEh.GetPickListItems(ACol, ARow: Integer; Items: TStrings);
var
  TreeNode: TPropTreeNodeEh;
begin
  Items.Clear;
  if ARow < PropTreeList.VisibleExpandedCount then
  begin
    TreeNode := PropTreeList.VisibleExpandedItem[ARow];
    TreeNode.GetListValues(Items);
  end;
end;

procedure TObjectInspectorEh.CurrentCellMoved(OldCurrent: TGridCoord);
begin
  InvalidateRow(OldCurrent.Y);
  InvalidateRow(Row);
end;

function TObjectInspectorEh.GetTreeNodeAt(ARow: Integer): TPropTreeNodeEh;
begin
  if ARow < PropTreeList.VisibleExpandedCount
    then Result := PropTreeList.VisibleExpandedItem[ARow]
    else Result := nil;
end;

procedure TObjectInspectorEh.WMCommand(var Message: TWMCommand);
{$IFDEF FPC_CROSSP}
begin
  inherited;
end;
{$ELSE}
begin
  if Message.NotifyCode = EN_CHANGE then
    FEditChangedThroughEnChangeCode := True;
  try
    inherited;
  finally
    FEditChangedThroughEnChangeCode := False;
  end;
end;
{$ENDIF} 

procedure TObjectInspectorEh.UpdateText(EditorChanged: Boolean);
begin
  if not FEditChangedThroughEnChangeCode then
    inherited UpdateText(EditorChanged);
end;

function TObjectInspectorEh.GetInplaceEdit: TInspectorInplaceEditEh;
begin
  Result := TInspectorInplaceEditEh(inherited InplaceEditor);
end;

procedure TObjectInspectorEh.CMHintShow(var Message: TCMHintShow);
var
  Cell: TGridCoord;
  S: String;
  ACellRect, TextRect: TRect;
  TreeNode: TPropTreeNodeEh;
  ATextWidth: Integer;
  phi: PHintInfo;

begin
  Cell := MouseCoord(HitTest.X, HitTest.Y);
  if (Cell.X < 0) or (Cell.Y < 0) then Exit;
  if Cell.X = 0 then
  begin
    if Cell.Y < PropTreeList.VisibleExpandedCount then
    begin
      ACellRect := CellRect(Cell.X, Cell.Y);
      TreeNode := PropTreeList.VisibleExpandedItem[Cell.Y];
      S := TreeNode.PropName;
      TextRect := ACellRect;
      Inc(TextRect.Left, DefaultRowHeight * TreeNode.Level);
      Canvas.Font := Font;
      ATextWidth := Canvas.TextWidth(S);
      if TextRect.Right < TextRect.Left + ATextWidth then
      begin
        phi := PHintInfo(Message.HintInfo);
        phi.CursorRect := ACellRect;
        phi.HintPos := ClientToScreen(TextRect.TopLeft);
        phi.HintPos.X := phi.HintPos.X - 3;
        phi.HintPos.Y := phi.HintPos.Y - 3;
        phi.HintStr := S;
      end;
    end;
  end else
    inherited;
end;

procedure TObjectInspectorEh.CMHintsShowPause(var Message: TCMHintShowPause);
var
  Cell: TGridCoord;
begin
  Cell := MouseCoord(HitTest.X, HitTest.Y);
  if (Cell.X < 0) or (Cell.Y < 0) then Exit;
  if Cell.X = 0 then
    Message.Pause^ := 0
  else
    inherited;
end;

function TObjectInspectorEh.GetClassPropListAsArray(AClass: TClass): TPropListArray;
begin
  if (PropDataAccessWay = TPropDataAccessWayEh.TypeInfo) then
  begin
    Result := GetPropListAsArray(AClass.ClassInfo, tkProperties);
  end else
  begin
    Result := GetRttiPropListAsArray(AClass);
  end;
end;

{ TPropTreeNodeEh }

constructor TPropTreeNodeEh.Create;
begin
  inherited Create;
end;

destructor TPropTreeNodeEh.Destroy;
begin
  inherited Destroy;
end;

procedure TPropTreeNodeEh.Collapse;
begin
  Expanded := False;
  Owner.VisibleItemsBecomeObsolete;
  Owner.ObjectInspector.LayoutChanged;
end;

procedure TPropTreeNodeEh.Expand;
var
  PropList: TPropListArray;
  NewNode: TPropTreeNodeEh;
  i: Integer;
  Component: TObject;
  ASetTypeData: PTypeData;
  SetAsIntValue: Longint;
  Coll: TCollection;
begin
  PropList := nil;
  if Count = 0 then
  begin
    if (TypeInfo.Kind = tkClass) and (PropStrValue <> '') then
    begin
      if Parent.Instance is TCollection
        then Component := Instance
        else Component := GetObjectProp(Parent.Instance, PropInfo);
      if Component is TCollection then
      begin
        Coll := Component as TCollection;
        for i := 0 to Coll.Count-1 do
        begin
          NewNode := TPropTreeNodeEh(Owner.AddChild('', Self, nil));
          NewNode.PropInfo := nil;
          NewNode.TypeInfo := Coll.ItemClass.ClassInfo;
          NewNode.PropName := 'Item['+IntToStr(i)+']';
          NewNode.PropStrValue := '('+Coll.ItemClass.ClassName+')';
          NewNode.HasChildren := True;
          NewNode.Instance := Coll.Items[i];
        end;
      end else if Component <> nil then
      begin
        //PropList := GetPropListAsArray(Component.ClassInfo, tkProperties);
        PropList := Owner.ObjectInspector.GetClassPropListAsArray(Component.ClassType);

        for i := 0 to Length(PropList)-1 do
        begin
          NewNode := TPropTreeNodeEh(Owner.AddChild('', Self, nil));
          NewNode.PropInfo := PropList[i];
          NewNode.TypeInfo := PropInfo_getPropType(NewNode.PropInfo);

{$IFDEF NEXTGEN}
          NewNode.PropName := PropList[i].NameFld.ToString;
{$ELSE}
          NewNode.PropName := String(PropList[i].Name);
{$ENDIF}

          NewNode.PropStrValue := GetPropValueAsString(Component, PropList[i]);
          if (NewNode.TypeInfo.Kind = tkSet) or
             ((NewNode.TypeInfo.Kind = tkClass) and (NewNode.PropStrValue <> ''))
          then
            NewNode.HasChildren := True
          else
            NewNode.HasChildren := False;
          if NewNode.TypeInfo.Kind = tkClass then
            NewNode.Instance := GetObjectProp(Component, NewNode.PropInfo);
          if Component is TComponent then
            NewNode.FIsCompmentSubrops := True;
        end;
      end;
    end else if TypeInfo.Kind = tkSet then
    begin
      {$IFDEF FPC}
      ASetTypeData := GetTypeData(GetTypeData(TypeInfo)^.CompType);
      {$ELSE}
      ASetTypeData := GetTypeData(GetTypeData(TypeInfo)^.CompType^);
      {$ENDIF}
      SetAsIntValue := GetOrdProp(Parent.Instance, PropInfo);

      for I := ASetTypeData.MinValue to ASetTypeData.MaxValue do
      begin
        NewNode := TPropTreeNodeEh(Owner.AddChild('', Self, nil));
        NewNode.PropInfo := nil;
        NewNode.TypeInfo := nil;
        {$IFDEF FPC}
        NewNode.PropName := GetEnumName(GetTypeData(TypeInfo)^.CompType, I);
        {$ELSE}
        NewNode.PropName := GetEnumName(GetTypeData(TypeInfo)^.CompType^, I);
        {$ENDIF}
        NewNode.PropStrValue := BooleanIdents[I in TIntegerSet(SetAsIntValue)];
        NewNode.HasChildren := False;
        NewNode.IsSetValue := True;
        NewNode.SetIndex := I;
      end;
      
    end;
  end;
  Expanded := True;
  Owner.VisibleItemsBecomeObsolete;
  Owner.ObjectInspector.LayoutChanged;
end;

function TPropTreeNodeEh.GetItem(const Index: Integer): TPropTreeNodeEh;
begin
  Result := TPropTreeNodeEh(inherited Items[Index]);
end;

function TPropTreeNodeEh.GetNodeOwner: TPropTreeListEh;
begin
  Result := TPropTreeListEh(inherited Owner);
end;

function TPropTreeNodeEh.GetNodeParent: TPropTreeNodeEh;
begin
  Result := TPropTreeNodeEh(inherited Parent);
end;

function TPropTreeNodeEh.GetVisibleItem(const Index: Integer): TPropTreeNodeEh;
begin
  Result := TPropTreeNodeEh(inherited VisibleItems[Index])
end;

procedure TPropTreeNodeEh.SetNodeParent(const Value: TPropTreeNodeEh);
begin
  inherited Parent := Value;
end;

function TPropTreeNodeEh.GetEditStyle: TEditStyle;
begin
  Result := esSimple;
  if (TypeInfo <> nil) and (TypeInfo.Kind = tkEnumeration) then
    Result := esPickList
  else if IsSetValue then
    Result := esPickList
  else if TypeInfo = System.TypeInfo(TColor) then
    Result := esPickList
  {$IFDEF FPC}
  else if (TypeInfo <> nil) and (TypeInfo.Kind = tkBool) then
    Result := esPickList;
  {$ELSE}
  ;
  {$ENDIF}
end;

procedure TPropTreeNodeEh.GetListValues(Items: TStrings);
var
  ASetTypeData: PTypeData;
  I: Integer;
  S: String;
begin
  if IsSetValue then
  begin
    Items.Add('True');
    Items.Add('False');
  {$IFDEF FPC}
  end else if TypeInfo.Kind in [tkEnumeration, tkBool] then
  {$ELSE}
  end else if TypeInfo.Kind = tkEnumeration then
  {$ENDIF}
  begin
    ASetTypeData := GetTypeData(TypeInfo);

    for I := ASetTypeData.MinValue to ASetTypeData.MaxValue do
    begin
      S := GetEnumName(TypeInfo, I);
      Items.Add(S);
    end;
  end else if TypeInfo = System.TypeInfo(TColor) then
  begin
    FColorList := Items;
    GetColorValues(GetColorStrProc);
  end;
end;

function TPropTreeNodeEh.GetFontStyle: TFontStyles;
begin
  Result := [];
  {$IFDEF FPC}
  {$ELSE}
  if (Parent.Instance <> nil) and
     (PropInfo <> nil) and
     IsStoredProp(Parent.Instance, PropInfo)
     and not IsDefaultPropertyValue(Parent.Instance, PropInfo, nil)
  then
    Result := [fsBold];
  {$ENDIF}
end;

procedure TPropTreeNodeEh.SetValueAsString(const SValue: String);
var
  S: TIntegerSet;
  NewValue: Longint;
begin
  if IsSetValue then
  begin
    Integer(S) :=  StringToSet(Parent.PropInfo, Parent.PropStrValue);
    if CompareText(SValue, BooleanIdents[True]) = 0 then
      Include(S, SetIndex)
    else
      Exclude(S, SetIndex);
    Parent.SetValueAsString(SetToString(Parent.PropInfo, Integer(S)));
  end else if TypeInfo = System.TypeInfo(TColor) then
  begin
    if IdentToColor(SValue, NewValue) then
      SetPropValue(Parent.Instance, PropName, NewValue)
    else
      SetPropValue(Parent.Instance, PropName, StrToInt(SValue))
  end else if TypeInfo.Kind in [tkInteger, tkInt64] then
    SetPropValue(Parent.Instance, PropName, StrToInt(SValue))
  else if TypeInfo.Kind in [tkFloat] then
    SetPropValue(Parent.Instance, PropName, StrToFloat(SValue))
  else
    SetPropValue(Parent.Instance, PropName, SValue);

  PropStrValue := SValue;
end;

procedure TPropTreeNodeEh.GetColorStrProc(const S: string);
begin
  FColorList.Add(S);
end;

procedure TPropTreeNodeEh.RefreshValue;
begin
  if IsSetValue then
  else if PropInfo <> nil then
    PropStrValue := GetPropValueAsString(Parent.Instance, PropInfo);
end;

{ TPropTreeListEh }

constructor TPropTreeListEh.Create(ItemClass: TPropTreeNodeClassEh;
  ObjInspector: TObjectInspectorEh);
begin
  inherited Create(ItemClass);
  FObjInspector := ObjInspector;
  FVisibleExpandedItems := TObjectListEh.Create;
end;

destructor TPropTreeListEh.Destroy;
begin
  FreeAndNil(FVisibleExpandedItems);
  inherited Destroy;
end;

procedure TPropTreeListEh.BuildVisibleItems;
var
  CurNode: TBaseTreeNodeEh;
begin
  FVisibleExpandedItems.Clear;
  CurNode := GetFirstVisible;
  while CurNode <> nil do
  begin
    FVisibleExpandedItems.Add(CurNode);
    CurNode := GetNextVisible(CurNode, True);
  end;

  FVisibleItemsObsolete := False;
end;

function TPropTreeListEh.GetVisibleCount: Integer;
begin
  if FVisibleItemsObsolete then
    BuildVisibleItems;
  Result := FVisibleExpandedItems.Count;
end;

function TPropTreeListEh.GetVisibleExpandedItem(const Index: Integer): TPropTreeNodeEh;
begin
  if FVisibleItemsObsolete then
    BuildVisibleItems;
  if (Index < 0) or (Index > FVisibleExpandedItems.Count-1) then
  begin
    Result := nil;
    Exit;
  end;
  Result := TPropTreeNodeEh(FVisibleExpandedItems.Items[Index]);
end;

procedure TPropTreeListEh.VisibleItemsBecomeObsolete;
begin
  FVisibleItemsObsolete := True;
end;

function TPropTreeListEh.GetRoot: TPropTreeNodeEh;
begin
  Result := TPropTreeNodeEh(inherited Root);
end;

procedure TPropTreeListEh.RefreshAllValues;
var
  CurNode: TBaseTreeNodeEh;
begin
  CurNode := GetFirst;
  while CurNode <> nil do
  begin
    TPropTreeNodeEh(CurNode).RefreshValue;
    CurNode := GetNext(CurNode);
  end;
end;

{ TInspectorInplaceEditEh }

constructor TInspectorInplaceEditEh.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  FButtonWidth := GetSystemMetrics(SM_CXVSCROLL);
  FEditStyle := esSimple;
end;

procedure TInspectorInplaceEditEh.BoundsChanged;
begin
  inherited BoundsChanged;
end;

function TInspectorInplaceEditEh.GetEditCoreBounds: TRect;
begin
  SetRect(Result, 2, 1, Width - 2, Height);
  if EditStyle <> esSimple then
    if not Grid.UseRightToLeftAlignment then
      Dec(Result.Right, ButtonWidth)
    else
      Inc(Result.Left, ButtonWidth - 2);
end;

procedure TInspectorInplaceEditEh.DoDropDownKeys(var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_UP, VK_DOWN:
      if ssAlt in Shift then
      begin
        if ListVisible then CloseUp(True) else DropDown;
        Key := 0;
      end;
    VK_RETURN, VK_ESCAPE:
      if ListVisible and not (ssAlt in Shift) then
      begin
        CloseUp(Key = VK_RETURN);
        Key := 0;
      end;
  end;
end;

procedure TInspectorInplaceEditEh.DoEditButtonClick;
begin
  Grid.EditButtonClick;
end;

procedure TInspectorInplaceEditEh.DoGetPickListItems;
begin
  if not PickListLoaded then
  begin
    Grid.GetPickListItems(Grid.Col, Grid.Row, PickList.Items);
    PickListLoaded := (PickList.Items.Count > 0);
  end;
end;

function TInspectorInplaceEditEh.GetPickList: TComboBoxPopupListboxEh;
var
  PopupListbox: TComboBoxPopupListboxEh;
begin
  if not Assigned(FPickList) then
  begin
    PopupListbox := TComboBoxPopupListboxEh.Create(Self);
    PopupListbox.Visible := False;
    PopupListbox.OnMouseUp := ListMouseUp;
    PopupListbox.ItemHeight := 11;
    FPickList := PopupListBox;
  end;
  Result := FPickList;
end;

procedure TInspectorInplaceEditEh.DropDown;
var
  P: TPoint;
begin
  if not ListVisible then
  begin
    ActiveList.Width := Width;
    if ActiveList = FPickList then
    begin
      DoGetPickListItems;
      PickList.Color := Color;
      PickList.Font := Font;
      PickList.ItemHeight := PickList.GetTextHeight;
      if (DropDownRows > 0) and (PickList.Items.Count >= DropDownRows) then
        PickList.Height := DropDownRows * PickList.ItemHeight + 4
      else
        PickList.Height := PickList.Items.Count * PickList.ItemHeight + 4;
      if Text = '' then
        PickList.ItemIndex := -1
      else
        PickList.ItemIndex := PickList.Items.IndexOf(Text);
    end;
    P := AlignDropDownWindow(Self, ActiveList, daLeft);

    PickList.SetBounds(P.X, P.Y, ActiveList.Width, ActiveList.Height);
    PickList.Show;

    FListVisible := True;
    Invalidate;
    SetFocus;
  end;
end;

procedure TInspectorInplaceEditEh.CloseUp(Accept: Boolean);
var
  ListValue: Variant;
begin
  if ListVisible and (ActiveList = FPickList) then
  begin
    if GetCapture <> 0 then SendMessage(GetCapture, WM_CANCELMODE, 0, 0);
    if PickList.ItemIndex <> -1 then
{$IFDEF CLR}
      ListValue := PickList.Items[PickList.ItemIndex]
    else
      ListValue := Unassigned;
{$ELSE}
      ListValue := PickList.Items[PickList.ItemIndex];
{$ENDIF}
    FPickList.Hide;
    FListVisible := False;
    Invalidate;
    if Accept then
      if (not VarIsEmpty(ListValue) or VarIsNull(ListValue))
         and (VarToStr(ListValue) <> Text) then
      begin
        { Here we store the new value directly in the edit control so that
          we bypass the CMTextChanged method on TCustomMaskedEdit.  This
          preserves the old value so that we can restore it later by calling
          the Reset method. }
{$IFDEF CLR}
        Perform(WM_SETTEXT, 0, VarToStr(ListValue));
{$ELSE}
  {$IFDEF FPC_CROSSP}
  {$ELSE}
        Perform(WM_SETTEXT, 0, LPARAM(String(ListValue)));
  {$ENDIF}
{$ENDIF}
        Modified := True;
        Grid.SetEditText(Grid.Col, Grid.Row, VarToStr(ListValue));
      end;
  end;
end;

procedure TInspectorInplaceEditEh.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if (EditStyle = esEllipsis) and (Key = VK_RETURN) and (Shift = [ssCtrl]) then
  begin
    DoEditButtonClick;
    KillMessage(Handle, WM_CHAR);
  end
  else
    inherited KeyDown(Key, Shift);
  if (Key = VK_RETURN) and (Shift = []) then
    Grid.UpdateText(True);
end;

procedure TInspectorInplaceEditEh.ListMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    CloseUp(PtInRect(ActiveList.ClientRect, Point(X, Y)));
end;

procedure TInspectorInplaceEditEh.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  if (Button = mbLeft) and (EditStyle <> esSimple) and
    OverButton(Point(X,Y)) then
  begin
    if ListVisible then
      CloseUp(False)
    else
    begin
      MouseCapture := True;
      FTracking := True;
      TrackButton(X, Y);
      if Assigned(ActiveList) then
        DropDown;
    end;
  end;
  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TInspectorInplaceEditEh.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  ListPos: TPoint;
begin
  if FTracking then
  begin
    TrackButton(X, Y);
    if ListVisible then
    begin
      ListPos := ActiveList.ScreenToClient(ClientToScreen(Point(X, Y)));
      if PtInRect(ActiveList.ClientRect, ListPos) then
      begin
        StopTracking;
        SendMessage(ActiveList.Handle, WM_LBUTTONDOWN, 0, PointToLParam(ListPos));
        Exit;
      end;
    end;
  end;
  inherited MouseMove(Shift, X, Y);
end;

procedure TInspectorInplaceEditEh.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  WasPressed: Boolean;
begin
  WasPressed := Pressed;
  StopTracking;
  if (Button = mbLeft) and (EditStyle = esEllipsis) and WasPressed then
    DoEditButtonClick;
  inherited MouseUp(Button, Shift, X, Y);
end;

procedure TInspectorInplaceEditEh.PaintWindow(DC: HDC);
var
  R: TRect;
  Flags: Integer;
  {$IFDEF FPC_CROSSP}
  {$ELSE}
  W, X, Y: Integer;
  {$ENDIF}
  Details: TThemedElementDetails;
begin
  if EditStyle <> esSimple then
  begin
    R := ButtonRect;
    Flags := 0;
    case EditStyle of
      esPickList:
        begin
          if ThemeServices.ThemesEnabled then
          begin
            if ActiveList = nil then
              Details := ThemeServices.GetElementDetails(tcDropDownButtonDisabled)
            else
              if Pressed then
                Details := ThemeServices.GetElementDetails(tcDropDownButtonPressed)
              else
                if FMouseInControl then
                  Details := ThemeServices.GetElementDetails(tcDropDownButtonHot)
                else
                  Details := ThemeServices.GetElementDetails(tcDropDownButtonNormal);
            ThemeServices.DrawElement(DC, Details, R);
          end
          else
          begin
            if ActiveList = nil then
              Flags := DFCS_INACTIVE
            else if Pressed then
              Flags := DFCS_FLAT or DFCS_PUSHED;
            DrawFrameControl(DC, R, DFC_SCROLL, Flags or DFCS_SCROLLCOMBOBOX);
          end;
        end;
      esEllipsis:
        begin
          if ThemeServices.ThemesEnabled then
          begin
            if Pressed then
              Details := ThemeServices.GetElementDetails(tbPushButtonPressed)
            else
              if FMouseInControl then
                Details := ThemeServices.GetElementDetails(tbPushButtonHot)
              else
                Details := ThemeServices.GetElementDetails(tbPushButtonNormal);
            ThemeServices.DrawElement(DC, Details, R);
          end
          else
          begin
            if Pressed then Flags := BF_FLAT;
            DrawEdge(DC, R, EDGE_RAISED, BF_RECT or BF_MIDDLE or Flags);
          end;

          {$IFDEF FPC_CROSSP}
          {$ELSE}
          X := R.Left + ((R.Right - R.Left) shr 1) - 1 + Ord(Pressed);
          Y := R.Top + ((R.Bottom - R.Top) shr 1) - 1 + Ord(Pressed);
          W := ButtonWidth shr 3;
          if W = 0 then W := 1;
          PatBlt(DC, X, Y, W, W, BLACKNESS);
          PatBlt(DC, X - (W * 2), Y, W, W, BLACKNESS);
          PatBlt(DC, X + (W * 2), Y, W, W, BLACKNESS);
          {$ENDIF} 
        end;
    end;
    ExcludeClipRect(DC, R.Left, R.Top, R.Right, R.Bottom);
  end;
  inherited PaintWindow(DC);
end;

procedure TInspectorInplaceEditEh.LoseFocus(NewFocusWnd: HWND);
begin
  inherited LoseFocus(NewFocusWnd);
  CloseUp(False);
end;

procedure TInspectorInplaceEditEh.StopTracking;
begin
  if FTracking then
  begin
    TrackButton(-1, -1);
    FTracking := False;
    MouseCapture := False;
  end;
end;

procedure TInspectorInplaceEditEh.TrackButton(X,Y: Integer);
var
  NewState: Boolean;
  R: TRect;
begin
  R := ButtonRect;
  NewState := PtInRect(R, Point(X, Y));
  if Pressed <> NewState then
  begin
    FPressed := NewState;
    InvalidateRect(Handle, @R, False);
  end;
end;

procedure TInspectorInplaceEditEh.UpdateContents;
var
  TreeNode: TPropTreeNodeEh;
begin
  ActiveList := nil;
  PickListLoaded := False;
  FEditStyle := Grid.GetEditStyle(Grid.Col, Grid.Row);
  if EditStyle = esPickList then
    ActiveList := PickList;

  TreeNode := Grid.GetTreeNodeAt(Grid.Row);
  if TreeNode <> nil then
  begin
    Font.Style := TreeNode.GetFontStyle;
  end;
  inherited UpdateContents;
end;

procedure TInspectorInplaceEditEh.RestoreContents;
begin
  Reset;
  Grid.UpdateText(True);
end;

{$IFDEF FPC}
{$ELSE}
procedure TInspectorInplaceEditEh.CMCancelMode(var Message: TCMCancelMode);
begin
  if (Message.Sender <> Self) and (Message.Sender <> ActiveList) then
    CloseUp(False);
end;
{$ENDIF}

procedure TInspectorInplaceEditEh.WMCancelMode(var Message: TMessage);
begin
  StopTracking;
  inherited;
end;

procedure TInspectorInplaceEditEh.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;
end;

function TInspectorInplaceEditEh.ButtonRect: TRect;
begin
  if not Grid.UseRightToLeftAlignment then
    Result := Rect(Width - ButtonWidth, 0, Width, Height)
  else
    Result := Rect(0, 0, ButtonWidth, Height);
end;

function TInspectorInplaceEditEh.OverButton(const P: TPoint): Boolean;
begin
  Result := PtInRect(ButtonRect, P);
end;

procedure TInspectorInplaceEditEh.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
  if (EditStyle <> esSimple) and OverButton(Point(Message.XPos, Message.YPos)) then
    Exit;
  inherited;
end;

procedure TInspectorInplaceEditEh.WMPaint(var Message: TWMPaint);
begin
  {$IFDEF FPC}
  inherited;
  {$ELSE}
  PaintHandler(Message);
  {$ENDIF}
end;

procedure TInspectorInplaceEditEh.WMSetCursor(var Message: TWMSetCursor);
begin
  inherited;
end;

procedure TInspectorInplaceEditEh.WndProc(var Message: TMessage);
var
  TheChar: Word;
begin
  case Message.Msg of
    wm_KeyDown, wm_SysKeyDown, wm_Char:
      if EditStyle = esPickList then
      begin
        TheChar := TWMKey(Message).CharCode;
        DoDropDownKeys(TheChar, KeyDataToShiftState(TWMKey(Message).KeyData));
        TWMKey(Message).CharCode := TheChar;
        if (TWMKey(Message).CharCode <> 0) and ListVisible then
        begin
          SendMessage(ActiveList.Handle, Message.Msg, Message.WParam, Message.LParam);
          Exit;
        end;
      end
  end;
  inherited;
end;

procedure TInspectorInplaceEditEh.Change;
begin
  Grid.FEditChangedThroughEnChangeCode := True;
  try
    inherited Change;
  finally
    Grid.FEditChangedThroughEnChangeCode := False;
  end;
end;

procedure TInspectorInplaceEditEh.DblClick;
var
  Index: Integer;
  ListValue: string;
begin
  if (EditStyle = esSimple) or Assigned(Grid.OnDblClick) then
    inherited
  else if (EditStyle = esPickList) and (ActiveList = PickList) then
  begin
    DoGetPickListItems;
    if PickList.Items.Count > 0 then
    begin
      Index := PickList.Items.IndexOf(Text);
      if Index >= 0
        then PickList.ItemIndex := Index
        else PickList.ItemIndex := 0;
      Index := PickList.ItemIndex + 1;
      if Index >= PickList.Items.Count then
        Index := 0;
      PickList.ItemIndex := Index;
      ListValue := PickList.Items[PickList.ItemIndex];
{$IFDEF CLR}
      Perform(WM_SETTEXT, 0, ListValue);
{$ELSE}
    {$IFDEF FPC_CROSSP}
    {$ELSE}
      Perform(WM_SETTEXT, 0, LPARAM(ListValue));
    {$ENDIF}
{$ENDIF}
      Modified := True;
      Grid.SetEditText(Grid.Col, Grid.Row, ListValue);
      SelectAll;
    end;
  end
  else if EditStyle = esEllipsis then
    DoEditButtonClick;
end;

procedure TInspectorInplaceEditEh.CMMouseEnter(var Message: TMessage);
begin
  inherited;

  if ThemeServices.ThemesEnabled and not FMouseInControl then
  begin
    FMouseInControl := True;
    Invalidate;
  end;
end;

procedure TInspectorInplaceEditEh.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  if ThemeServices.ThemesEnabled and FMouseInControl then
  begin
    FMouseInControl := False;
    Invalidate;
  end;
end;

function TInspectorInplaceEditEh.GetGrid: TObjectInspectorEh;
begin
  Result := TObjectInspectorEh(inherited Grid);
end;

end.
