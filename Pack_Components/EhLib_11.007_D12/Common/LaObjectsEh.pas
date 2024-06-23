{*******************************************************}
{                                                       }
{                       EhLib 11.0                      }
{                      LaObjectsEh                      }
{                                                       }
{    Copyright (c) 2022-2022 by Dmitry V. Bolshakov     }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit LaObjectsEh;

interface

{$SCOPEDENUMS ON}

uses
  Messages, Types, Classes, SysUtils, Variants,
  {$IFDEF FPC}
  EhLibLCL, LCLType, LCLIntf,
  {$ELSE}
  EhLibVCL, Windows,
  {$ENDIF}
  Generics.Collections, DB, Math,
  ToolCtrlsEh,
  Graphics, Controls, Forms, Dialogs;

type
  TLaMargins = class;
  TLaObjectEh = class;
  TLaHostDataLink = class;
  TLaHostWinControl = class;
  TLaHost = class;
  TLaHintInfoEventArgs = class;

  TLaHorzAlignment = (Left, Center, Right, Stretch);
  TLaVertAlignment = (Top, Center, Bottom, Stretch);
  TLaOrientation = (Vertical, Horizontal);

  IRefObjectInterface = interface
    ['{29465A0A-BB57-49C2-9443-DEA693BABD84}']
    function GetObject: TObject;
  end;

  TLaObjectGetHintInfoEvent = procedure(Sender: TLaObjectEh; EventArgs: TLaHintInfoEventArgs) of object;

{ TInterfacedRefObject }

  TInterfacedRefObject = class(TInterfacedObject, IRefObjectInterface)
  private
    FRefObject: TObject;
    FOwnsObject: Boolean;
  public
    constructor Create(ARefObject: TObject; AOwnsObject: Boolean);
    destructor Destroy; override;

    function GetObject: TObject;
  end;

  TLaObjectList = TList<TLaObjectEh>;

{ TLaChildrenEnumerable }

  TLaChildrenEnumerable = class(TEnumerable<TLaObjectEh>)
  private
    FChildren: TLaObjectList;
  protected
    function DoGetEnumerator: TEnumerator<TLaObjectEh>; override;
    function GetChildCount: Integer; virtual;
    function GetChild(AIndex: Integer): TLaObjectEh; virtual;
  public
    constructor Create(const AChildren: TLaObjectList);
    destructor Destroy; override;
    property Count: Integer read GetChildCount;
    function IndexOf(const Obj: TLaObjectEh): Integer; virtual;
    property Items[Index: Integer]: TLaObjectEh read GetChild; default;
  end;

{ TLaMargins }

  TLaMargins = class(TPersistent)
  private
    FLaObject: TLaObjectEh;
    FLeft, FTop, FRight, FBottom: TMarginSize;
    procedure SetMargin(Index: Integer; Value: TMarginSize);
  protected
    procedure Change; virtual;
    procedure AssignTo(Dest: TPersistent); override;
    property LaObject: TLaObjectEh read FLaObject;
  public
    constructor Create(ALaObject: TLaObjectEh); virtual;

    procedure SetBounds(ALeft, ATop, ARight, ABottom: Integer);

  published
    property Left: TMarginSize index 0 read FLeft write SetMargin default 0;
    property Top: TMarginSize index 1 read FTop write SetMargin default 0;
    property Right: TMarginSize index 2 read FRight write SetMargin default 0;
    property Bottom: TMarginSize index 3 read FBottom write SetMargin default 0;
  end;

{ TLaObject }

  TLaObjectEh = class(TComponent)
  private
    FMargins: TLaMargins;
    FLocation: TPoint;
    FSize: TSize;

    FChildren: TLaObjectList;
    FChildrenEnumerable: TLaChildrenEnumerable;
    FNeededSize: TSize;
    FVertAlignment: TLaVertAlignment;
    FHorzAlignment: TLaHorzAlignment;
    FLayoutRect: TRect;
    FHint: String;
    FOnGetHintInfo: TLaObjectGetHintInfoEvent;
    FOnClick: TNotifyEvent;
    FIsInQueryLayout: Boolean;
    FIsInPerformLayout: Boolean;
    FClipRect: TRect;
    FMaxWidth: Integer;
    FMaxHeight: Integer;

    function GetChildrenCount: Integer;
    procedure SetParent(const Value: TLaObjectEh);
    function GetRefSelf: TLaObjectEh;
    procedure SetMargins(const Value: TLaMargins);

    procedure CalcHozrAlignment(OfferedSize, PerfedSize: TSize; out AlignedPos: Integer; out AlignedSize: Integer);
    procedure CalcVertAlignment(OfferedSize, PerfedSize: TSize; out AlignedPos: Integer; out AlignedSize: Integer);
    function GetText: String;
    procedure SetMaxHeight(const Value: Integer);
    procedure SetMaxWidth(const Value: Integer);

  protected
    FParent: TLaObjectEh;
    FLaHost: TLaHost;

    function GetDataSet: TDataSet;

    procedure MarginsChanged; virtual;
    procedure DoAddObject(const AObject: TLaObjectEh); virtual;
    procedure DoDeleteChildren; virtual;
    procedure DoRemoveObject(const AObject: TLaObjectEh); virtual;
    procedure ParentChanged; virtual;
    procedure MouseEnter; virtual;
    procedure MouseLeave; virtual;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
    procedure MouseClick(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); virtual;

    procedure PerformDraw(ARect: TRect; ACanvas: TCanvas; ParentInWindowRect: TRect);
    procedure ParentDependenciesChanged; virtual;
    procedure UpdateChildDependencies;

  public
    constructor Create(AOwner: TComponent); override;
    constructor CreateWith(AOwner: TComponent; ALaHost: TLaHost); overload;
    constructor CreateWith(AOwner: TComponent; AParentObject: TLaObjectEh); overload;
    constructor CreateWith(AOwnerAndParent: TLaObjectEh); overload;

    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;

    function CreateCopy(Owner: TComponent): TLaObjectEh;

    function IsChild(AObject: TLaObjectEh): Boolean;
    procedure AddObject(const AObject: TLaObjectEh);

    procedure Draw(ARect: TRect; ACanvas: TCanvas); virtual;

    function QueryLayout(QuerySize: TSize; ACanvas: TCanvas): TSize;
    function PerformLayout(PerfRect: TRect; ACanvas: TCanvas): TSize;

    function DoQueryLayout(QuerySize: TSize; ACanvas: TCanvas): TSize; virtual;
    function DoPerformLayout(PerfSize: TSize; ACanvas: TCanvas): TSize; virtual;

    procedure RemoveObject(const AObject: TLaObjectEh); overload;
    procedure DeleteChildren;
    procedure FillHintInfo(HintInfo: TLaHintInfoEventArgs);
    procedure Invalidate;

    function GetElementByName(ElementName: String): TLaObjectEh;

    //procedure LayoutAndDraw

    property ChildrenCount: Integer read GetChildrenCount;
    property Children: TLaChildrenEnumerable read FChildrenEnumerable;
    //property Data: TValue read GetData write SetData;
    property Parent: TLaObjectEh read FParent write SetParent;
    property LaHost: TLaHost read FLaHost;
    property RefSelf: TLaObjectEh read GetRefSelf; //SelfRef //This
    //property SelfInstance: TLaObject read GetSelfInstance;
    //property ItSelf: TLaObject read GetItself;
    property IsInQueryLayout: Boolean read FIsInQueryLayout;
    property IsInPerformLayout: Boolean read FIsInPerformLayout;

  public
    property Location: TPoint read FLocation;
    property Size: TSize read FSize;
    property NeededSize: TSize read FNeededSize;
    property LayoutRect: TRect read FLayoutRect;
    property ClipRect: TRect read FClipRect;

    property Margins: TLaMargins read FMargins write SetMargins;
    property HorzAlignment: TLaHorzAlignment read FHorzAlignment write FHorzAlignment default TLaHorzAlignment.Stretch;
    property VertAlignment: TLaVertAlignment read FVertAlignment write FVertAlignment default TLaVertAlignment.Stretch;
    property Hint: String read FHint write FHint;
    property Text: String read GetText;
    property MaxWidth: Integer read FMaxWidth write SetMaxWidth;
    property MaxHeight: Integer read FMaxHeight write SetMaxHeight;

    property OnGetHintInfo: TLaObjectGetHintInfoEvent read FOnGetHintInfo write FOnGetHintInfo;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;

  end;

  TLaObjectClass = class of TLaObjectEh;

{ TLaHostDataLink }

  TLaHostDataLink = class(TDataLink)
  private
    FLaHost: TLaHost;
  protected
    procedure DataSetChanged; override;
    procedure RecordChanged(Field: TField); override;
  public
    constructor Create(ALaHost: TLaHost);
    destructor Destroy; override;
  end;

  ILaHostWinControl = interface
    ['{D0533ACB-1810-4438-AE07-12D05677BC74}']
    procedure InvalidateLaHost(ALaHost: TLaHost);
  end;

{ TLaHost }

  TLaHost = class(TComponent)
  private
    FLaObject: TLaObjectEh;
    FDesignBacklightObject: TLaObjectEh;
    FLaHostWinControl: ILaHostWinControl;
    FDataLink: TLaHostDataLink;
    FLastMousePos: TPoint;
    FMouseOverObjList: TList<TLaObjectEh>;
    FNewMouseOverObjList: TList<TLaObjectEh>;
    FMouseDownObj: TLaObjectEh;
    procedure SetLaObjectProp(const Value: TLaObjectEh);
    procedure SetDesignBacklightObjectProp(const Value: TLaObjectEh);
    procedure DrawDesignBacklightInTree(ALaObject: TLaObjectEh; ARect: TRect; ACanvas: TCanvas);
    procedure SetDataSource(const Value: TDataSource);
    function GetDataSource: TDataSource;
    procedure GetLaObjectsAtPoint(APoint: TPoint; ObjList: TList<TLaObjectEh>);
    procedure GetChildObjectsAtPoint(AParentObject: TLaObjectEh; APoint: TPoint; ObjList: TList<TLaObjectEh>);

  protected
    function GetDataSet: TDataSet;
    function GetChildObjectAtPoint(AParentObject: TLaObjectEh; APoint: TPoint): TLaObjectEh;

    procedure ProcessMouseMove(Shift: TShiftState; X, Y: Integer);
    procedure ProcessMouseLeave;
    procedure ProcessMouseEnter;
    procedure ProcessMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ProcessMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

    procedure DrawVisualTree(ARect: TRect; ACanvas: TCanvas);
    procedure DrawVisualObjectTree(ALaObject: TLaObjectEh; ACanvas: TCanvas; ARect: TRect; ParentInWindowRect: TRect);
    //procedure DrawDesignBacklight;
    procedure DataChanged; virtual;
    procedure PerformLayout(ARect: TRect; ACanvas: TCanvas);

    property LaHostWinControl: ILaHostWinControl read FLaHostWinControl write FLaHostWinControl;

  public
    constructor Create(AOwner: TComponent); override;
    constructor CreateWith(AOwner: TComponent; ALaHostWinControl: ILaHostWinControl);
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;
    function SetLaObject(ALaObject: TLaObjectEh): TLaObjectEh;
    function GetLaObjectAtPoint(APoint: TPoint): TLaObjectEh;
    function LaObjectInHostRect(ALaObject: TLaObjectEh): TRect;
    function CreateCopy(AOwner: TComponent): TLaHost;

    procedure LayoutAndDraw(ARect: TRect; ACanvas: TCanvas);
    procedure UpdateLayout(ARect: TRect; ACanvas: TCanvas);
    procedure Invalidate; virtual;

  published
    property LaObject: TLaObjectEh read FLaObject write SetLaObjectProp;
    property DesignBacklightObject: TLaObjectEh read FDesignBacklightObject write SetDesignBacklightObjectProp;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
  end;

{ TLaHostWinControl }

  TLaHostWinControl = class(TGraphicControl, ILaHostWinControl)
  private
    //FLaObject: TLaObject;
    FLaHost: TLaHost;
    function GetLaObject: TLaObjectEh;
    function GetHintInfo(TopChild: TLaObjectEh): TLaHintInfoEventArgs;
    function GetDataSource: TDataSource;

    procedure SetLaObjectProp(const Value: TLaObjectEh);
    procedure SetDataSource(const Value: TDataSource);

    procedure CMHintShow(var Message: TCMHintShow); message CM_HINTSHOW;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
  protected
    procedure Paint; override;

    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;

    procedure InvalidateLaHost(ALaHost: TLaHost);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function GetDataSet: TDataSet;

//    function GetRender: TRenderElement;
//    function SetLaObject(ALaObject: TLaObject): TLaObject;
  published
    property LaObject: TLaObjectEh read GetLaObject write SetLaObjectProp;
    property LaHost: TLaHost read FLaHost;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    //property Position
  end;

{ TLaHintInfoEventArgs }

  TLaHintInfoEventArgs = class(TPersistent)
  private
    FHandled: Boolean;
    FLaObject: TLaObjectEh;
    FHintText: String;
    FHintObject: TLaObjectEh;
    FHideTimeout: Integer;

  public
    procedure InitEventArgs(ALaObject: TLaObjectEh);

    property LaObject: TLaObjectEh read FLaObject;
    property HintText: String read FHintText write FHintText;
    property HintObject: TLaObjectEh read FHintObject write FHintObject;
    property HideTimeout: Integer read FHideTimeout write FHideTimeout;
    property Handled: Boolean read FHandled write FHandled;
  end;

implementation

uses LaHintWindows;

{$IFDEF FPC}
const
  clWebSandyBrown     = TColor($60A4F4);
{$ELSE}
{$ENDIF}

{ TInterfacedRefObject }

constructor TInterfacedRefObject.Create(ARefObject: TObject;
  AOwnsObject: Boolean);
begin
  FRefObject := ARefObject;
  FOwnsObject := AOwnsObject;
end;

destructor TInterfacedRefObject.Destroy;
begin
  if (FOwnsObject) then
    FreeAndNil(FRefObject);
end;

function TInterfacedRefObject.GetObject: TObject;
begin
  Result := FRefObject;
end;

{ TLaMargins }

constructor TLaMargins.Create(ALaObject: TLaObjectEh);
begin
  inherited Create;
  FLaObject := ALaObject;
  FLeft := 0;
  FTop := 0;
  FRight := 0;
  FBottom := 0;
end;

procedure TLaMargins.AssignTo(Dest: TPersistent);
begin
  if Dest is TLaMargins then
  begin
    with TLaMargins(Dest) do
    begin
      FLeft := Self.FLeft;
      FTop := Self.FTop;
      FRight := Self.FRight;
      FBottom := Self.FBottom;
      Change;
    end
  end else
  begin
    inherited AssignTo(Dest);
  end;
end;

procedure TLaMargins.Change;
begin
  if (FLaObject <> nil) then
    FLaObject.MarginsChanged;
end;

procedure TLaMargins.SetBounds(ALeft, ATop, ARight, ABottom: Integer);
begin
  if (FLeft <> ALeft) or
     (FTop <> ATop) or
     (FRight <> ARight) or
     (FBottom <> ABottom) then
  begin
    FLeft := ALeft;
    FTop := ATop;
    FRight := ARight;
    FBottom := ABottom;
    Change;
  end;
end;

procedure TLaMargins.SetMargin(Index: Integer; Value: TMarginSize);
begin
  if (Value > 1024) then
    raise Exception.Create('SetMargin: Value > 1024');

  case Index of
    0:
      if Value <> FLeft then
      begin
        FLeft := Value;
        Change;
      end;
    1:
      if Value <> FTop then
      begin
        FTop := Value;
        Change;
      end;
    2:
      if Value <> FRight then
      begin
        FRight := Value;
        Change;
      end;
    3:
      if Value <> FBottom then
      begin
        FBottom := Value;
        Change;
      end;
  end;
end;

{ TLaChildrenEnumerable }

constructor TLaChildrenEnumerable.Create(const AChildren: TLaObjectList);
begin
  inherited Create;
  FChildren := AChildren;
end;

destructor TLaChildrenEnumerable.Destroy;
begin
  FChildren := nil;
  inherited;
end;

function TLaChildrenEnumerable.DoGetEnumerator: TEnumerator<TLaObjectEh>;
begin
  Result := FChildren.GetEnumerator;
end;

function TLaChildrenEnumerable.GetChild(AIndex: Integer): TLaObjectEh;
begin
  Result := FChildren[AIndex];
end;

function TLaChildrenEnumerable.GetChildCount: Integer;
begin
  if FChildren <> nil
    then Result := FChildren.Count
    else Result := 0;
end;

function TLaChildrenEnumerable.IndexOf(const Obj: TLaObjectEh): Integer;
begin
  if FChildren <> nil
    then Result := FChildren.IndexOf(Obj)
    else Result := -1;
end;

{ TLaObject }

//constructor TLaObject.Create(AOwner: TComponent; AParent: TLaObject);
//begin
//  Create(AOwner);
//
//end;
//
//constructor TLaObject.Create(AOwner: TComponent;  ALaHostWinControl: TLaHostWinControl);
//begin
//  Create(AOwner);
//  ALaHostWinControl.LaObject := Self;
//end;

constructor TLaObjectEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FHorzAlignment := TLaHorzAlignment.Stretch;
  FVertAlignment := TLaVertAlignment.Stretch;
  FMargins := TLaMargins.Create(Self);
  FMaxWidth := -1;
  FMaxHeight := -1;
end;

constructor TLaObjectEh.CreateWith(AOwner: TComponent; ALaHost: TLaHost);
begin
  Create(AOwner);
  ALaHost.LaObject := Self;
end;

constructor TLaObjectEh.CreateWith(AOwner: TComponent; AParentObject: TLaObjectEh);
begin
  Create(AOwner);
  Parent := AParentObject;
end;

constructor TLaObjectEh.CreateWith(AOwnerAndParent: TLaObjectEh);
begin
  CreateWith(AOwnerAndParent, AOwnerAndParent);
end;


destructor TLaObjectEh.Destroy;
begin
  FreeAndNil(FMargins);

  if FParent <> nil then
    FParent.RemoveObject(Self);
  DeleteChildren;
  if FChildrenEnumerable <> nil then
    FChildrenEnumerable.Free;
  inherited Destroy;
end;

function TLaObjectEh.GetRefSelf: TLaObjectEh;
begin
  Result := Self;
end;

procedure TLaObjectEh.DoAddObject(const AObject: TLaObjectEh);
begin
  if FChildren = nil then
  begin
    FChildren := TLaObjectList.Create;
    FChildren.Capacity := 10;
    FChildrenEnumerable := TLaChildrenEnumerable.Create(FChildren);
  end;
  AObject.FParent := Self;
  FChildren.Add(AObject);
  AObject.ParentChanged;
end;

procedure TLaObjectEh.DoRemoveObject(const AObject: TLaObjectEh);
var
  Idx: Integer;
begin
  if FChildren = nil then
    Exit;

  Idx := FChildren.IndexOf(AObject);
  if Idx >= 0 then
  begin
    AObject.FParent := nil;
    FChildren.Delete(Idx);
    AObject.ParentChanged;
  end;
end;

procedure TLaObjectEh.AddObject(const AObject: TLaObjectEh);
begin
  if (AObject <> nil) and (AObject.Parent <> Self) then
  begin
    if AObject.Parent <> nil then
      AObject.Parent := nil;
    DoAddObject(AObject);
  end;
end;

procedure TLaObjectEh.RemoveObject(const AObject: TLaObjectEh);
begin
  if AObject <> nil then
    DoRemoveObject(AObject);
end;

procedure TLaObjectEh.SetParent(const Value: TLaObjectEh);
begin
  if Value = Self then
    Exit;
  if FParent <> Value then
  begin
    if IsChild(Value) then
       raise EInvalidOperation.Create('SCannotCreateCircularDependence');
    if FParent <> nil then
      FParent.RemoveObject(Self);
    if Value <> nil then
      Value.AddObject(Self)
    else
      FParent := Value;
  end;
end;

function TLaObjectEh.GetText: String;
begin
  Result := ClassName;
end;

procedure TLaObjectEh.Invalidate;
begin
  if (Parent <> nil) then
    Parent.Invalidate
  else if (LaHost <> nil) then
    LaHost.Invalidate;
end;

function TLaObjectEh.IsChild(AObject: TLaObjectEh): Boolean;
begin
  Result := False;
  while not Result and (AObject <> nil) do
  begin
    Result := AObject.Equals(Self);
    if not Result then
      AObject := AObject.Parent;
  end;
end;

procedure TLaObjectEh.DeleteChildren;
begin
  DoDeleteChildren;
end;

procedure TLaObjectEh.DoDeleteChildren;
var
  I: Integer;
  Child: TLaObjectEh;
begin
  if FChildren <> nil then
  begin
    while FChildren.Count > 0 do
    begin
      I := FChildren.Count - 1;
      Child := FChildren[I];
      FChildren.Delete(I);
      Child.FParent := nil;
      //Child.SetRoot(nil);
      //Child.DisposeOf;
      Child.Free;
    end;
    FreeAndNil(FChildren);
    FreeAndNil(FChildrenEnumerable);
  end;
end;

procedure TLaObjectEh.PerformDraw(ARect: TRect; ACanvas: TCanvas; ParentInWindowRect: TRect);
var
  RecHandle: HRgn;
  AWinClipRect: TRect;
begin
  AWinClipRect := FClipRect;
  OffsetRect(AWinClipRect, ParentInWindowRect.Left, ParentInWindowRect.Top);
  RecHandle := SelectClipRectangleEh(ACanvas, AWinClipRect);
  Draw(ARect, ACanvas);
  RestoreClipRectangleEh(ACanvas, RecHandle);
end;

procedure TLaObjectEh.Draw(ARect: TRect; ACanvas: TCanvas);
begin
end;

procedure TLaObjectEh.FillHintInfo(HintInfo: TLaHintInfoEventArgs);
begin
  if (not HintInfo.Handled) then
  begin
    if (Hint <> '') then
    begin
      HintInfo.HintText := Hint;
      HintInfo.Handled := True;
    end;
  end;

  if (Assigned(OnGetHintInfo)) then
    OnGetHintInfo(Self, HintInfo);
end;

function TLaObjectEh.GetChildrenCount: Integer;
begin
  if FChildrenEnumerable <> nil
    then Result := FChildrenEnumerable.Count
    else Result := 0;
end;

function TLaObjectEh.GetDataSet: TDataSet;
begin
  if (Parent <> nil) then
    Result := Parent.GetDataSet
  else if (FLaHost <> nil) then
    Result := FLaHost.GetDataSet
  else
    Result := nil;
end;

procedure TLaObjectEh.ParentChanged;
begin
end;

procedure TLaObjectEh.ParentDependenciesChanged;
begin

end;

procedure TLaObjectEh.UpdateChildDependencies;
var
  I: Integer;
  Child: TLaObjectEh;
begin
  for I := 0 to ChildrenCount - 1 do
  begin
    Child := Children[I];
    Child.ParentDependenciesChanged;
    Child.UpdateChildDependencies;
  end;
end;

function TLaObjectEh.QueryLayout(QuerySize: TSize; ACanvas: TCanvas): TSize;
begin
  FIsInQueryLayout := True;

  if (MaxWidth >= 0) and (QuerySize.cx > MaxWidth) then
    QuerySize.cx := MaxWidth;
  if (MaxHeight >= 0) and (QuerySize.cy > MaxHeight) then
    QuerySize.cy := MaxHeight;

  QuerySize.cx := QuerySize.cx - Margins.Left - Margins.Right;
  QuerySize.cy := QuerySize.cy + Margins.Top + Margins.Bottom;
  if (QuerySize.cx < 0) then QuerySize.cx := 0;
  if (QuerySize.cy < 0) then QuerySize.cy := 0;

  FNeededSize := DoQueryLayout(QuerySize, ACanvas);

  FNeededSize.cx := FNeededSize.cx + Margins.Left + Margins.Right;
  FNeededSize.cy := FNeededSize.cy + Margins.Top + Margins.Bottom;

  Result := FNeededSize;
  FIsInQueryLayout := False;
end;

//function TLaObject.CalcPerformSize(OfferedSize: TSize): TSize;
//begin
//  Result.cx := OfferedSize.cx;
//
//  if (VertAlignment <> TLaVertAlignment.Stretch) and
//     (NeededSize.cy < OfferedSize.cy)
//  then
//    Result.cy := NeededSize.cy
//  else
//    Result.cy := OfferedSize.cy
//end;

function TLaObjectEh.PerformLayout(PerfRect: TRect; ACanvas: TCanvas): TSize;
//var
//  ALocation;
var
  LayoutRect: TRect;
  AlignedPos: TPoint;
  PerfedSize: TSize;
  //PerfSize: TSize;
  PerfedResultSize: TSize;
begin
  FIsInPerformLayout := True;

  if (MaxWidth >= 0) and (RectWidth(PerfRect) > MaxWidth) then
    PerfRect.Right := PerfRect.Left + MaxWidth;
  if (MaxHeight >= 0) and (RectHeight(PerfRect) > MaxHeight) then
    PerfRect.Bottom := PerfRect.Top + MaxHeight;

  FClipRect := PerfRect;
  LayoutRect := PerfRect;

  LayoutRect.Left := LayoutRect.Left + Margins.Left;
  LayoutRect.Top := LayoutRect.Top + Margins.Top;
  LayoutRect.Right := LayoutRect.Right - Margins.Right;
  LayoutRect.Bottom := LayoutRect.Bottom - Margins.Bottom;

  //PerfSize := CalcPerformSize(RectSize(ObjectRect));

  PerfedSize := DoPerformLayout(RectSize(LayoutRect), ACanvas);
  CalcHozrAlignment(RectSize(LayoutRect), PerfedSize, AlignedPos.X, PerfedResultSize.cx);
  CalcVertAlignment(RectSize(LayoutRect), PerfedSize, AlignedPos.Y, PerfedResultSize.cy);

  FLocation.X := LayoutRect.Left + AlignedPos.X;
  FLocation.Y := LayoutRect.Top + AlignedPos.Y;

  FLayoutRect.Left := FLocation.X - Margins.Left;
  FLayoutRect.Top := FLocation.Y - Margins.Top;
  FLayoutRect.Right := FLayoutRect.Left + PerfedSize.cx + Margins.Left + Margins.Right;
  FLayoutRect.Bottom := FLayoutRect.Top + PerfedSize.cy + Margins.Top + Margins.Bottom;

  //FLocation := PerfRect.Location;
  FSize := PerfedResultSize;
  Result := FSize;
  Result.cx := Result.cx + Margins.Left + Margins.Right;
  Result.cy := Result.cy + Margins.Top + Margins.Bottom;
  FIsInPerformLayout := False;
end;

function TLaObjectEh.DoPerformLayout(PerfSize: TSize; ACanvas: TCanvas): TSize;
begin
  Result := PerfSize;
end;

function TLaObjectEh.DoQueryLayout(QuerySize: TSize; ACanvas: TCanvas): TSize;
begin
  QuerySize := CreateSize(0, 0);
  Result := QuerySize;
end;

procedure TLaObjectEh.CalcVertAlignment(OfferedSize, PerfedSize: TSize;
  out AlignedPos: Integer; out AlignedSize: Integer);
begin
  AlignedPos := 0;

  case VertAlignment of
    TLaVertAlignment.Top:
      begin
        AlignedPos := 0;
        AlignedSize := PerfedSize.cy;
      end;
    TLaVertAlignment.Center:
      begin
        AlignedPos := (OfferedSize.cy - PerfedSize.cy) div 2;
        AlignedSize := PerfedSize.cy;
      end;

    TLaVertAlignment.Bottom:
      begin
        AlignedPos := OfferedSize.cy - PerfedSize.cy;
        AlignedSize := PerfedSize.cy;
      end;

    TLaVertAlignment.Stretch:
      begin
        AlignedPos := 0;
        if OfferedSize.cy > PerfedSize.cy
          then AlignedSize := OfferedSize.cy
          else AlignedSize := PerfedSize.cy;
      end;
  end;
end;

procedure TLaObjectEh.CalcHozrAlignment(OfferedSize, PerfedSize: TSize;
  out AlignedPos: Integer; out AlignedSize: Integer);
begin
  //Result := 0;

  case HorzAlignment of
    TLaHorzAlignment.Left:
      begin
        AlignedPos := 0;
        AlignedSize := PerfedSize.cx;
      end;
    TLaHorzAlignment.Center:
      begin
        AlignedPos := (OfferedSize.cx - PerfedSize.cx) div 2;
        AlignedSize := PerfedSize.cx;
      end;

    TLaHorzAlignment.Right:
      begin
        AlignedPos := OfferedSize.cx - PerfedSize.cx;
        AlignedSize := PerfedSize.cx;
      end;

    TLaHorzAlignment.Stretch:
      begin
        AlignedPos := 0;
        if OfferedSize.cx > PerfedSize.cx
          then AlignedSize := OfferedSize.cx
          else AlignedSize := PerfedSize.cx;
      end;
  end;
end;

procedure TLaObjectEh.SetMargins(const Value: TLaMargins);
begin
  FMargins.Assign(Value);
end;

procedure TLaObjectEh.MarginsChanged;
begin

end;

function TLaObjectEh.CreateCopy(Owner: TComponent): TLaObjectEh;
begin
  Result := TLaObjectClass(Self.ClassType).Create(Owner);
  Result.Assign(Self);
end;

procedure TLaObjectEh.Assign(Source: TPersistent);
var
  I: Integer;
  Child: TLaObjectEh;
  SrcObject: TLaObjectEh;
begin
  if (Source is TLaObjectEh) then
  begin
    SrcObject := TLaObjectEh(Source);

    Name := SrcObject.Name;
    Margins := SrcObject.Margins;
    HorzAlignment := SrcObject.HorzAlignment;
    VertAlignment := SrcObject.VertAlignment;
    Hint := SrcObject.Hint;

    OnGetHintInfo := SrcObject.OnGetHintInfo;

    for I := 0 to SrcObject.ChildrenCount - 1 do
    begin
      Child := SrcObject.Children[I];
      AddObject(Child.CreateCopy(Owner));
    end;
  end;
end;

function TLaObjectEh.GetElementByName(ElementName: String): TLaObjectEh;
var
  I: Integer;
  Child: TLaObjectEh;
begin
  Result := nil;
  for I := 0 to ChildrenCount - 1 do
  begin
    Child := Children[I];
    if (Child.Name = ElementName) then
    begin
      Result := Child;
      Exit;
    end;
    Result := Child.GetElementByName(ElementName);
    if Result <> nil then
      Exit;
  end;
end;

procedure TLaObjectEh.MouseEnter;
begin

end;

procedure TLaObjectEh.MouseLeave;
begin

end;

procedure TLaObjectEh.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
end;

procedure TLaObjectEh.MouseClick(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Assigned(OnClick)) then
    OnClick(Self);
end;

procedure TLaObjectEh.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin

end;

procedure TLaObjectEh.SetMaxHeight(const Value: Integer);
begin
  if (FMaxHeight <> Value) then
  begin
    FMaxHeight := Value;
  end;
end;

procedure TLaObjectEh.SetMaxWidth(const Value: Integer);
begin
  if (FMaxWidth <> Value) then
  begin
    FMaxWidth := Value;
  end;
end;

{ TLaHostWinControl }

constructor TLaHostWinControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FLaHost := TLaHost.Create(nil);
  FLaHost.LaHostWinControl := Self;
end;

destructor TLaHostWinControl.Destroy;
begin
  FreeAndNil(FLaHost);
  inherited Destroy;
end;

//function TLaHostWinControl.GetRender: TRenderElement;
//var
//  RenderContext: TRenderContextEh;
//  RootRenderGroup: TRenderGroup;
//begin
//  RenderContext := TRenderContextEh.Create(Canvas);
//  RootRenderGroup := TRenderGroup.Create;
//  RenderContext.SetParentRenderGroup(RootRenderGroup);
//  LaControl.InternalRender(RenderContext);
//  RenderContext.Free;
//
//  Result := RootRenderGroup;
//end;

procedure TLaHostWinControl.Paint;
//var
//  RenderElt: TRenderElement;
begin
  //  inherited Paint;
  Canvas.Brush.Style := bsClear;
  if LaObject <> nil then
  begin
    LaHost.LayoutAndDraw(Rect(0, 0, Width, Height), Canvas);
//    RenderElt := GetRender;
//    RenderElt.PaintTo(Canvas, Rect(0, 0, Width, Height));
    //LayoutAndDraw
    //LaObject.Draw(Rect(0, 0, Width, Height), Canvas);
  end;
end;

function TLaHostWinControl.GetDataSet: TDataSet;
begin
  if (DataSource <> nil) and (DataSource.DataSet <> nil) then
    Result := DataSource.DataSet
  else
    Result := nil;
end;

function TLaHostWinControl.GetLaObject: TLaObjectEh;
begin
  Result := FLaHost.LaObject;
end;

procedure TLaHostWinControl.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  if LaObject <> nil then
    LaHost.ProcessMouseDown(Button, Shift, X, Y);
end;

procedure TLaHostWinControl.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseMove(Shift, X, Y);
  if LaObject <> nil then
    LaHost.ProcessMouseMove(Shift, X, Y);
end;

procedure TLaHostWinControl.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  if LaObject <> nil then
    LaHost.ProcessMouseUp(Button, Shift, X, Y);
end;

procedure TLaHostWinControl.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  LaHost.ProcessMouseEnter;
end;

procedure TLaHostWinControl.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  LaHost.ProcessMouseLeave;
end;

function TLaHostWinControl.GetDataSource: TDataSource;
begin
  if (FLaHost <> nil)
    then Result := FLaHost.DataSource
    else Result := nil;
end;

procedure TLaHostWinControl.SetDataSource(const Value: TDataSource);
begin
  if (DataSource <> Value) then
  begin
    FLaHost.DataSource := Value;
  end;
end;

procedure TLaHostWinControl.SetLaObjectProp(const Value: TLaObjectEh);
begin
  if (FLaHost.LaObject <> Value) then
  begin
    FLaHost.LaObject := Value;
    Invalidate;
  end;
end;

function TLaHostWinControl.GetHintInfo(TopChild: TLaObjectEh): TLaHintInfoEventArgs;
var
//  HintInfo: TLaHintInfoEventArgs;
  AParent: TLaObjectEh;
begin
  if (TopChild = nil) then Exit(nil);

  Result := TLaHintInfoEventArgs.Create;
  Result.InitEventArgs(TopChild);

  AParent := TopChild;

  while not Result.Handled and
        (AParent <> nil) do
  begin
    AParent.FillHintInfo(Result); //TLaHintInfoEventArgs;

    AParent := AParent.Parent;
    //OnHintOpening
  end;
end;

procedure TLaHostWinControl.CMHintShow(var Message: TCMHintShow);
var
  CursorPos: TPoint;
  TopChild: TLaObjectEh;
  HintInfo: TLaHintInfoEventArgs;
begin
  inherited;

  CursorPos := Message.HintInfo^.CursorPos;
  //CursorPos := ScreenToClient(CursorPos);
  //HintPos.Offset(LaHost.Left)

  TopChild := LaHost.GetLaObjectAtPoint(CursorPos);

  HintInfo := GetHintInfo(TopChild);

  if (TopChild <> nil) and (HintInfo.HintText <> '') then
  begin
    Message.HintInfo^.HintWindowClass := TLaHintWindowEh;
    Message.HintInfo^.HintStr := GetShortHint(HintInfo.HintText);
    Message.HintInfo^.HintData := HintInfo.HintObject;
    Message.HintInfo^.CursorRect := LaHost.LaObjectInHostRect(TopChild);
  end;

  HintInfo.Free;
end;

procedure TLaHostWinControl.InvalidateLaHost(ALaHost: TLaHost);
begin
  Invalidate;
end;

//function TLaHostWinControl.SetLaObject(ALaObject: TLaObject): TLaObject;
//begin
//  LaObject := ALaObject;
//  Result := LaObject;
//end;

{ TLaHost }

constructor TLaHost.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDataLink := TLaHostDataLink.Create(Self);
  FMouseOverObjList := TList<TLaObjectEh>.Create;
  FNewMouseOverObjList := TList<TLaObjectEh>.Create;
end;

constructor TLaHost.CreateWith(AOwner: TComponent;
  ALaHostWinControl: ILaHostWinControl);
begin
  Create(AOwner);
  FLaHostWinControl := ALaHostWinControl;
end;

destructor TLaHost.Destroy;
begin
  FreeAndNil(FDataLink);
  FreeAndNil(FMouseOverObjList);
  FreeAndNil(FNewMouseOverObjList);
  inherited Destroy;
end;

procedure TLaHost.LayoutAndDraw(ARect: TRect; ACanvas: TCanvas);
var
  ARectSize: TSize;
  CanvasOrg: TPoint;
  NewCanvasOrg: TPoint;
  NewOrg: TPoint;
  ChildRect: TRect;
begin
  ARectSize := RectSize(ARect);
  LaObject.QueryLayout(ARectSize, ACanvas);
  PerformLayout(ARect, ACanvas);

  SetMapMode(ACanvas.Handle, mm_Anisotropic);
  DrawVisualTree(ARect, ACanvas);

  if DesignBacklightObject <> nil then
  begin
    NewOrg := LaObject.Location;
    GetWindowOrgEx(ACanvas.Handle, CanvasOrg);

    NewCanvasOrg := Point(CanvasOrg.X - NewOrg.X, CanvasOrg.Y - NewOrg.Y);
    SetWindowOrgEx(ACanvas.Handle, NewCanvasOrg.X, NewCanvasOrg.Y, nil);
    try
      ChildRect := Rect(0, 0, LaObject.Size.cx, LaObject.Size.cy);
      DrawDesignBacklightInTree(LaObject, ChildRect, ACanvas);
    finally
      if (CanvasOrg.X <> NewCanvasOrg.X) or (CanvasOrg.X <> NewCanvasOrg.Y) then
        SetWindowOrgEx(ACanvas.Handle, CanvasOrg.X, CanvasOrg.Y, nil);
    end;

//    DrawDesignBacklightInTree(LaObject, ObjectRect, ACanvas);
  end;
end;

procedure TLaHost.PerformLayout(ARect: TRect; ACanvas: TCanvas);
begin
  OffsetRect(ARect, -ARect.Left, -ARect.Top);
  LaObject.PerformLayout(ARect, ACanvas);
end;

procedure TLaHost.UpdateLayout(ARect: TRect; ACanvas: TCanvas);
begin
  LaObject.QueryLayout(RectSize(ARect), ACanvas);
  PerformLayout(ARect, ACanvas);
end;

procedure TLaHost.DrawVisualTree(ARect: TRect; ACanvas: TCanvas);
var
  CanvasOrg: TPoint;
  NewOrg: TPoint;
  ChildRect: TRect;
  NewCanvasOrg: TPoint;
begin
  NewOrg := LaObject.Location;

  GetWindowOrgEx(ACanvas.Handle, CanvasOrg);

  NewCanvasOrg := Point(CanvasOrg.X - ARect.Left - NewOrg.X, CanvasOrg.Y - ARect.Top - NewOrg.Y);
  SetWindowOrgEx(ACanvas.Handle, NewCanvasOrg.X, NewCanvasOrg.Y, nil);

  ChildRect := Rect(0, 0, LaObject.Size.cx, LaObject.Size.cy);
  DrawVisualObjectTree(LaObject, ACanvas, ChildRect, ARect);

  if (CanvasOrg.X <> NewCanvasOrg.X) or (CanvasOrg.X <> NewCanvasOrg.Y) then
    SetWindowOrgEx(ACanvas.Handle, CanvasOrg.X, CanvasOrg.Y, nil);
end;

procedure TLaHost.DrawVisualObjectTree(ALaObject: TLaObjectEh; ACanvas: TCanvas; ARect: TRect; ParentInWindowRect: TRect);
var
  I: Integer;
  ChildObject: TLaObjectEh;
  NewOrg: TPoint;
  CanvasOrg: TPoint;
  NewCanvasOrg: TPoint;
  ADrawRect: TRect;
  ChildRect: TRect;
  //ChildInWindowRect: TRect;
  NewParentInWindowRect: TRect;
begin
//  ADrawRect := Rect(ARect.Left + ALaObject.Margins.Left,
//                      ARect.Top + ALaObject.Margins.Top,
//                      ARect.Right - ALaObject.Margins.Right,
//                      ARect.Bottom - ALaObject.Margins.Bottom);
  ADrawRect := ARect;

  ALaObject.PerformDraw(ADrawRect, ACanvas, ParentInWindowRect);

  NewParentInWindowRect.Left := ParentInWindowRect.Left + ALaObject.Location.X;
  NewParentInWindowRect.Top := ParentInWindowRect.Top + ALaObject.Location.Y;
  NewParentInWindowRect.Right := ParentInWindowRect.Left + RectWidth(ARect);
  NewParentInWindowRect.Bottom := ParentInWindowRect.Top + RectHeight(ARect);

  for I := 0 to ALaObject.ChildrenCount - 1 do
  begin
    ChildObject := ALaObject.Children[I];
    NewOrg := ChildObject.Location;
    GetWindowOrgEx(ACanvas.Handle, CanvasOrg);
    NewCanvasOrg := Point(CanvasOrg.X - NewOrg.X, CanvasOrg.Y - NewOrg.Y);
    SetWindowOrgEx(ACanvas.Handle, NewCanvasOrg.X, NewCanvasOrg.Y, nil);
    try
      ChildRect := Rect(0, 0, ChildObject.Size.cx, ChildObject.Size.cy);
      //ChildInWindowRect := ChildRect;
      //OffsetRect(ChildInWindowRect, InWindowRect.Left, InWindowRect.Top);
      DrawVisualObjectTree(ChildObject, ACanvas, ChildRect, NewParentInWindowRect);
    finally
      if (CanvasOrg.X <> NewCanvasOrg.X) or (CanvasOrg.X <> NewCanvasOrg.Y) then
        SetWindowOrgEx(ACanvas.Handle, CanvasOrg.X, CanvasOrg.Y, nil);
    end;
  end;

end;

procedure TLaHost.DrawDesignBacklightInTree(ALaObject: TLaObjectEh; ARect: TRect; ACanvas: TCanvas);
var
  I: Integer;
  ChildObject: TLaObjectEh;
  NewOrg: TPoint;
  CanvasOrg: TPoint;
  NewCanvasOrg: TPoint;
  ALayoutRect: TRect;
  AMargRect: TRect;
//  ObjRect: TRect;
  ChildRect: TRect;
begin
  if (ALaObject = DesignBacklightObject) then
  begin
    ALayoutRect := Rect(ARect.Left - ALaObject.Margins.Left,
                      ARect.Top - ALaObject.Margins.Top,
                      ARect.Right + ALaObject.Margins.Right,
                      ARect.Bottom + ALaObject.Margins.Bottom);
    //ObjRect := ALaObject.LayoutRect;
    //FillRectEh(ACanvas, ADrawRect, clSkyBlue, 128);
    AMargRect := Rect(ALayoutRect.Left, ALayoutRect.Top, ALayoutRect.Right, ARect.Top);
    FillRectEh(ACanvas, AMargRect, clWebSandyBrown, 128);

    AMargRect := Rect(ALayoutRect.Left, ARect.Bottom, ALayoutRect.Right, ALayoutRect.Bottom);
    FillRectEh(ACanvas, AMargRect, clWebSandyBrown, 128);

    AMargRect := Rect(ALayoutRect.Left, ARect.Top, ARect.Left, ARect.Bottom);
    FillRectEh(ACanvas, AMargRect, clWebSandyBrown, 128);

    AMargRect := Rect(ARect.Right, ARect.Top, ALayoutRect.Right, ARect.Bottom);
    FillRectEh(ACanvas, AMargRect, clWebSandyBrown, 128);

    FillRectEh(ACanvas, ARect, clSkyBlue, 128);
  end;

//  ADrawRect := Rect(ARect.Left + ALaObject.Margins.Left,
//                      ARect.Top + ALaObject.Margins.Top,
//                      ARect.Right - ALaObject.Margins.Right,
//                      ARect.Bottom - ALaObject.Margins.Bottom);

  for I := 0 to ALaObject.ChildrenCount - 1 do
  begin
    ChildObject := ALaObject.Children[I];
    NewOrg := ChildObject.Location;
    GetWindowOrgEx(ACanvas.Handle, CanvasOrg);

    NewCanvasOrg := Point(CanvasOrg.X - NewOrg.X, CanvasOrg.Y - NewOrg.Y);
    SetWindowOrgEx(ACanvas.Handle, NewCanvasOrg.X, NewCanvasOrg.Y, nil);
    try
      ChildRect := Rect(0, 0, ChildObject.Size.cx, ChildObject.Size.cy);
      DrawDesignBacklightInTree(ChildObject, ChildRect, ACanvas);
    finally
      if (CanvasOrg.X <> NewCanvasOrg.X) or (CanvasOrg.X <> NewCanvasOrg.Y) then
        SetWindowOrgEx(ACanvas.Handle, CanvasOrg.X, CanvasOrg.Y, nil);
    end;
  end;

end;

procedure TLaHost.Invalidate;
begin
  if (LaHostWinControl <> nil) then
    LaHostWinControl.InvalidateLaHost(Self);
end;

function TLaHost.SetLaObject(ALaObject: TLaObjectEh): TLaObjectEh;
begin
  LaObject := ALaObject;
  Result := LaObject;
end;

procedure TLaHost.SetLaObjectProp(const Value: TLaObjectEh);
begin
  FLaObject := Value;
  if Value <> nil then
    Value.FLaHost := Self;
end;

procedure TLaHost.SetDesignBacklightObjectProp(const Value: TLaObjectEh);
begin
  FDesignBacklightObject := Value;
  if (LaHostWinControl <> nil) then
    LaHostWinControl.InvalidateLaHost(Self);
end;

function TLaHost.GetDataSet: TDataSet;
begin
  if (DataSource <> nil)
    then Result := DataSource.DataSet
    else Result := nil;
end;

function TLaHost.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

function TLaHost.GetLaObjectAtPoint(APoint: TPoint): TLaObjectEh;
var
  InObjectPos: TPoint;
  ObjectRect: TRect;
  ChildResult: TLaObjectEh;
begin
  Result := nil;
  if (LaObject = nil) then Exit;

  ObjectRect := Rect(LaObject.Location.X,
                     LaObject.Location.Y,
                     LaObject.Location.X + LaObject.Size.cx,
                     LaObject.Location.Y + LaObject.Size.cy);

  if RectContains(ObjectRect, APoint) then
  begin
    Result := LaObject;
    InObjectPos.X := APoint.X - LaObject.Location.X;
    InObjectPos.Y := APoint.Y - LaObject.Location.Y;
    ChildResult := GetChildObjectAtPoint(LaObject, InObjectPos);
    if (ChildResult <> nil) then
      Result := ChildResult;
  end;
end;

function TLaHost.GetChildObjectAtPoint(AParentObject: TLaObjectEh; APoint: TPoint): TLaObjectEh;
var
  I: Integer;
  InObjectPos: TPoint;
  ObjectRect: TRect;
  ChildObject: TLaObjectEh;
  ChildResult: TLaObjectEh;
begin
  Result := nil;
//  if (APoint.X >= 0) and
//     (APoint.Y >= 0) and
//     (APoint.X < AParentObject.Size.cx) and
//     (APoint.Y < AParentObject.Size.cy)
//  then
//    Result := AParentObject;

  for I := 0 to AParentObject.ChildrenCount - 1 do
  begin
    ChildObject := AParentObject.Children[I];
    ObjectRect := Rect(ChildObject.Location.X,
                       ChildObject.Location.Y,
                       ChildObject.Location.X + ChildObject.Size.cx,
                       ChildObject.Location.Y + ChildObject.Size.cy);

    if RectContains(ObjectRect, APoint) then
    begin
      Result := ChildObject;
      InObjectPos.X := APoint.X - ChildObject.Location.X;
      InObjectPos.Y := APoint.Y - ChildObject.Location.Y;
      ChildResult := GetChildObjectAtPoint(ChildObject, InObjectPos);
      if (ChildResult <> nil) then
        Result := ChildResult;
    end;
  end;
end;

procedure TLaHost.GetLaObjectsAtPoint(APoint: TPoint; ObjList: TList<TLaObjectEh>);
var
  InObjectPos: TPoint;
  ObjectRect: TRect;
//  ChildResult: TLaObject;
begin
  if (LaObject = nil) then Exit;

  ObjectRect := Rect(LaObject.Location.X,
                     LaObject.Location.Y,
                     LaObject.Location.X + LaObject.Size.cx,
                     LaObject.Location.Y + LaObject.Size.cy);

  if RectContains(ObjectRect, APoint) then
  begin
    ObjList.Add(LaObject);
    InObjectPos.X := APoint.X - LaObject.Location.X;
    InObjectPos.Y := APoint.Y - LaObject.Location.Y;
    GetChildObjectsAtPoint(LaObject, InObjectPos, ObjList);
  end;
end;

procedure TLaHost.GetChildObjectsAtPoint(AParentObject: TLaObjectEh; APoint: TPoint; ObjList: TList<TLaObjectEh>);
var
  I: Integer;
  InObjectPos: TPoint;
  ObjectRect: TRect;
  ChildObject: TLaObjectEh;
//  ChildResult: TLaObject;
begin
  for I := 0 to AParentObject.ChildrenCount - 1 do
  begin
    ChildObject := AParentObject.Children[I];
    ObjectRect := Rect(ChildObject.Location.X,
                       ChildObject.Location.Y,
                       ChildObject.Location.X + ChildObject.Size.cx,
                       ChildObject.Location.Y + ChildObject.Size.cy);

    if RectContains(ObjectRect, APoint) then
    begin
      ObjList.Add(ChildObject);
      InObjectPos.X := APoint.X - ChildObject.Location.X;
      InObjectPos.Y := APoint.Y - ChildObject.Location.Y;
      GetChildObjectsAtPoint(ChildObject, InObjectPos, ObjList);
    end;
  end;
end;

procedure TLaHost.SetDataSource(const Value: TDataSource);
begin
  if FDataLink.DataSource <> Value then
  begin
    FDataLink.DataSource := Value;
  end;
end;

procedure TLaHost.DataChanged;
begin
  if (LaHostWinControl <> nil) then
    LaHostWinControl.InvalidateLaHost(Self);
end;

function TLaHost.LaObjectInHostRect(ALaObject: TLaObjectEh): TRect;
var
  AParent: TLaObjectEh;
begin
  Result := Rect(ALaObject.Location.X,
                 ALaObject.Location.Y,
                 ALaObject.Location.X + ALaObject.Size.cx,
                 ALaObject.Location.Y + ALaObject.Size.cy);
  AParent := ALaObject;

  while AParent <> Self.LaObject do
  begin
    AParent := AParent.Parent;
    if (AParent = nil) then
      raise Exception.Create('TLaHost.LaObjectInHostRect: ALaObject is not in LaHost Tree.');
    OffsetRect(Result, AParent.Location.X, AParent.Location.Y);
  end;
end;

function TLaHost.CreateCopy(AOwner: TComponent): TLaHost;
begin
  Result := TLaHost.Create(AOwner);
  Result.Assign(Self);
end;

procedure TLaHost.Assign(Source: TPersistent);
begin
  if (Source is TLaHost) then
  begin
    LaObject := TLaHost(Source).LaObject.CreateCopy(Owner);
    DataSource := TLaHost(Source).DataSource;
  end;
end;

procedure TLaHost.ProcessMouseMove(Shift: TShiftState; X, Y: Integer);
var
  I: Integer;
  LastMatchIndex: Integer;
  MaxList: Integer;
  TopChild: TLaObjectEh;
  TopChildRect: TRect;
  InChildPos: TPoint;
begin
  if (FLastMousePos.X <> X) or (FLastMousePos.Y <> Y) then
  begin
    FNewMouseOverObjList.Clear;
    GetLaObjectsAtPoint(Point(X, Y), FNewMouseOverObjList);

    MaxList := Math.Max(FMouseOverObjList.Count, FNewMouseOverObjList.Count);
    LastMatchIndex := MaxList;
    for I := 0 to MaxList - 1 do
    begin
      if (I < FMouseOverObjList.Count) and
         (I < FNewMouseOverObjList.Count) and
         (FNewMouseOverObjList[i] = FMouseOverObjList[I])
      then
        DoNothing
      else
      begin
        LastMatchIndex := I;
        Break;
      end;
    end;

    for I := LastMatchIndex to FMouseOverObjList.Count - 1 do
      FMouseOverObjList[I].MouseLeave;

    for I := LastMatchIndex to FNewMouseOverObjList.Count - 1 do
      FNewMouseOverObjList[I].MouseEnter;

    FMouseOverObjList.Clear;
    FMouseOverObjList.AddRange(FNewMouseOverObjList);

    FLastMousePos := Point(X, Y);

    if (FMouseOverObjList.Count > 0) then
    begin
      TopChild := FMouseOverObjList[FMouseOverObjList.Count - 1];
      TopChildRect := LaObjectInHostRect(TopChild);
      InChildPos := Point(FLastMousePos.X - TopChildRect.Left,
                                     FLastMousePos.Y - TopChildRect.Top);
      TopChild.MouseMove(Shift, InChildPos.X, InChildPos.Y);
    end;
  end;
end;

procedure TLaHost.ProcessMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  MouseDownObjRect: TRect;
  InChildPos: TPoint;
begin
  FMouseDownObj := GetLaObjectAtPoint(Point(X, Y));
  if (FMouseDownObj <> nil) then
  begin
    MouseDownObjRect := LaObjectInHostRect(FMouseDownObj);
    InChildPos := Point(X - MouseDownObjRect.Left,
                        Y - MouseDownObjRect.Top);
    FMouseDownObj.MouseDown(Button, Shift, InChildPos.X, InChildPos.Y);
  end;
end;

procedure TLaHost.ProcessMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  AMouseUpObj: TLaObjectEh;
begin
  AMouseUpObj := GetLaObjectAtPoint(Point(X, Y));
  if (AMouseUpObj = FMouseDownObj) then
  begin
    FMouseDownObj.MouseClick(Button, Shift, X, Y);
  end;
  FMouseDownObj := nil;
end;

procedure TLaHost.ProcessMouseLeave();
var
  I: Integer;
begin
  for I := 0 to FMouseOverObjList.Count - 1 do
    FMouseOverObjList[I].MouseLeave;
  FMouseOverObjList.Clear;
  FLastMousePos := Point(-1, -1);
end;

procedure TLaHost.ProcessMouseEnter();
begin

end;

{ TLaHostDataLink }

constructor TLaHostDataLink.Create(ALaHost: TLaHost);
begin
  inherited Create;
  FLaHost := ALaHost;
end;

destructor TLaHostDataLink.Destroy;
begin

  inherited Destroy;
end;

procedure TLaHostDataLink.DataSetChanged;
begin
  inherited DataSetChanged;
  FLaHost.DataChanged;
end;

procedure TLaHostDataLink.RecordChanged(Field: TField);
begin
  inherited RecordChanged(Field);
  FLaHost.DataChanged;
end;

{ TLaHintInfoEventArgs }

procedure TLaHintInfoEventArgs.InitEventArgs(ALaObject: TLaObjectEh);
begin
  FHandled := False;
  FLaObject := ALaObject;
  FHintText := '';
  FHintObject := nil;
  FHideTimeout := 0;
end;

end.
