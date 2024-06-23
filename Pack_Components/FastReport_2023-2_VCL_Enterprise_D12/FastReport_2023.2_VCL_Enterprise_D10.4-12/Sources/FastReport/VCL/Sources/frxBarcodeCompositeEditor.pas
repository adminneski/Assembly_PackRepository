
{******************************************}
{                                          }
{             FastReport VCL               }
{         Composite Barcode Editor         }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxBarcodeCompositeEditor;

interface

{$I frx.inc}

uses
{$IFNDEF NONWINFPC}
  Windows,
{$ENDIF}	
  Classes, Types, Menus, Graphics, Controls, frxClass, frxBarcode, frxCustomEditors, frxBarcodeComposite
{$IFDEF OFF2DBARS}, frxBarcode2D{$ENDIF}, frxInPlaceEditors;

type
  TfrxBaseEvent = class
  private
    FRect: TRect;
  public
    constructor Create(vRect: TRect);
    function IsInRect(vPoint: TPoint): Boolean;
    procedure Execute(c: TfrxBarCodeCompositeView); virtual; abstract;
  end;

  TfrxBaseInternalEvent = class(TfrxBaseEvent)
  protected
    FView: TfrxView;
  public
    constructor Create(vRect: TRect; AView: TfrxView);
    procedure Execute(c: TfrxBarCodeCompositeView); override; abstract;
  end;

  TfrxSwitchPosEvent = class(TfrxBaseInternalEvent)
  public
    procedure Execute(c: TfrxBarCodeCompositeView); override;
  end;

  TfrxListEvents = class
  private
    FList: TList;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure Add(vBaseEvent: TfrxBaseEvent);
    function FindEventInPoint(vPoint: TPoint): TfrxBaseEvent;
  end;

  TfrxInPlaceBarcodeCompositePresetEditor = class(TfrxInPlaceCustomListBoxEditor)
  protected
    function ListBoxClicked(Sender: TObject): Boolean; override;
    function IsFillListBox: Boolean; override;
    procedure ListBoxDrawItem(ACanvas: TCanvas; AControl: TWinControl; AIndex: Integer; ARect: TRect;
      AState: TfrOwnerDrawState); override;
    function IsDropDownButtonVisible: Boolean; override;
    procedure DrawButton(ACanvas: TCanvas; ARect: TRect); override;
  public
    constructor Create(AClassRef: TfrxComponentClass; AOwner: TWinControl); override;
  end;

  TfrxInPlaceBarcodeCompositeBaseTypeEditor = class(TfrxInPlaceCustomListBoxEditor)
  private
    FItemsList: TStringList;
  protected
    procedure FreeListItems;
    function IsFillListBox: Boolean; override;
    function IsDropDownButtonVisible: Boolean; override;
    procedure ListBoxDrawItem(ACanvas: TCanvas; AControl: TWinControl; AIndex: Integer; ARect: TRect;
      AState: TfrOwnerDrawState); override;
    procedure DrawButton(ACanvas: TCanvas; ARect: TRect); override;
    function GetImageIndex: Integer; virtual; abstract;
  public
    constructor Create(aClassRef: TfrxComponentClass; aOwner: TWinControl); override;
    destructor Destroy; override;
  end;

  TfrxInPlaceBarcodeCompEditor = class(TfrxInPlaceBarcodeCompositeBaseTypeEditor)
  private
    FShowGUI: Boolean;
    FListEvents: TfrxListEvents;
    FLastMousePos: TPoint;
    FLastComponent: TfrxComponent;
    procedure DrawGUI(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended);
    function CheckGUIClick(X, Y: Integer; Button: TMouseButton; Shift: TShiftState;
      var EventParams: TfrxInteractiveEventsParams): Boolean;
  protected
    function ListBoxClicked(Sender: TObject): Boolean; override;
    function GetButtonTopLeft: TPoint; override;
    function GetImageIndex: Integer; override;
  public
    constructor Create(aClassRef: TfrxComponentClass; aOwner: TWinControl); override;
    destructor Destroy; override;
    procedure DrawCustomEditor(aCanvas: TCanvas; aRect: TRect); override;
    procedure InitializeUI(var EventParams: TfrxInteractiveEventsParams); override;
    procedure FinalizeUI(var EventParams: TfrxInteractiveEventsParams); override;
    function DoMouseUp(X, Y: Integer; Button: TMouseButton;
      Shift: TShiftState; var EventParams: TfrxInteractiveEventsParams): Boolean; override;
    function DoMouseMove(X, Y: Integer; Shift: TShiftState;
      var EventParams: TfrxInteractiveEventsParams): Boolean; override;
  end;

  TfrxInPlaceBarcodeCompositeAddEditor = class(TfrxInPlaceBarcodeCompositeBaseTypeEditor)
  protected
    function ListBoxClicked(Sender: TObject): Boolean; override;
    function GetButtonTopLeft: TPoint; override;
    function GetImageIndex: Integer; override;
  end;

  TfrxBarCodeCustomTypeEditor = class(TfrxViewEditor)
  protected
    procedure CreateBarTypesSubmenu(AParentItem: TMenuItem);
  end;

  TfrxBarCodeCompositeEditor = class(TfrxBarCodeCustomTypeEditor)
  private
    procedure CreatePreset(PresetB: TMenuItem);
  public
    procedure GetMenuItems; override;
    function Execute(Tag: Integer; Checked: Boolean): Boolean; override;
  end;

{$IFDEF OFF2DBARS}
  TfrxBarCodeInternalEditor = class(TfrxBarCodeCustomTypeEditor)
  public
    procedure GetMenuItems; override;
    function Execute(ATag: Integer; Checked: Boolean): Boolean; override;
  end;

  function CheckIs2D(c: TfrxComponent): Boolean;
{$ENDIF}

implementation

uses
  SysUtils, frxDsgnIntf, frxBarcodeBaseBarPresset, frxUtils, frxRes;

type
  TfrxBarcodeConstructionStruct = class(TObject)
  protected
    FClassRef: TfrxComponentClass;
    FFlag: Integer;
  public
    constructor Create(AClassRef: TfrxComponentClass; AFlag: Integer);
  end;

  TfrxBarCodeCompositeViewHack = class(TfrxBarCodeCompositeView);

{ TfrxBaseEvent }

constructor TfrxBaseEvent.Create(vRect: TRect);
begin
  FRect := vRect;
end;

function TfrxBaseEvent.IsInRect(vPoint: TPoint): Boolean;
begin
  Result :=
    (vPoint.x >= FRect.Left) and
    (vPoint.x <= FRect.Right) and
    (vPoint.y >= FRect.Top) and
    (vPoint.y <= FRect.Bottom);
end;

{ TfrxBaseInternalEvent }

constructor TfrxBaseInternalEvent.Create(vRect: TRect; AView: TfrxView);
begin
  inherited Create(vRect);
  FView := AView;
end;

{ TfrxSwitchPosEvent }

procedure TfrxSwitchPosEvent.Execute(c: TfrxBarCodeCompositeView);
var
  LIndex: Integer;
begin
  LIndex := c.Objects.IndexOf(FView);
  if LIndex >= 0 then
    c.Objects.Exchange(LIndex, LIndex + 1);
end;

{ TfrxListEvents }

constructor TfrxListEvents.Create;
begin
  FList := TList.Create;
end;

destructor TfrxListEvents.Destroy;
begin
  Clear;
  FreeAndNil(FList);
end;

procedure TfrxListEvents.Clear;
var
  i: Integer;
begin
  for i := 0 to FList.Count - 1 do
    TfrxBaseEvent(FList[i]).Free;
  FList.Clear;
end;

procedure TfrxListEvents.Add(vBaseEvent: TfrxBaseEvent);
begin
  FList.Add(vBaseEvent);
end;

function TfrxListEvents.FindEventInPoint(vPoint: TPoint): TfrxBaseEvent;
var
  i: Integer;
  BaseEvent: TfrxBaseEvent;
begin
  Result := nil;
  for i := 0 to FList.Count - 1 do
  begin
    BaseEvent := FList[i];
    if BaseEvent.IsInRect(vPoint) then
    begin
      Result := BaseEvent;
      break;
    end;
  end;
end;

{ TfrxInPlaceBarcodeCompEditor }

procedure TfrxInPlaceBarcodeCompEditor.DrawGUI(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended);
var
  i: Integer;
  frxCurBarView, frxNextBarView: TfrxReportComponent;
  vRect: TRect;
  Size, HalfSize: Integer;
  LObjects: TList;
begin
  Size := 16 * Round(ScaleX);
  HalfSize := Round(Size / 2);
  FListEvents.Clear;
  LObjects := FComponent.Objects;
  case (TfrxBarCodeCompositeView(FComponent).ContentType) of
    ctRightToLeft:
      for i := 0 to LObjects.Count - 2 do
      begin
        frxCurBarView := LObjects[i];
        frxNextBarView := LObjects[i + 1];
        vRect := Rect(Round((FComponent.AbsLeft + (frxCurBarView.Left + frxCurBarView.Width + frxNextBarView.Left) / 2 + OffsetX) * ScaleX) - HalfSize,
          Round((FComponent.AbsTop + FComponent.Height / 2 + OffsetY) * ScaleY) - HalfSize,
          Round((FComponent.AbsLeft + (frxCurBarView.Left + frxCurBarView.Width + frxNextBarView.Left) / 2 + OffsetX) * ScaleX) + HalfSize,
          Round((FComponent.AbsTop + FComponent.Height / 2 + OffsetY) * ScaleY) + HalfSize);
        FListEvents.Add(TfrxSwitchPosEvent.Create(vRect, LObjects[i]));
        frxImages.MainButtonImages.Draw(Canvas, vRect.Left, vRect.top, 131);
      end;
  end;
end;

function TfrxInPlaceBarcodeCompEditor.CheckGUIClick(X, Y: Integer; Button: TMouseButton; Shift: TShiftState;
      var EventParams: TfrxInteractiveEventsParams): Boolean;
var
  baseEvent: TfrxBaseEvent;
begin
  Result := False;
  if (EventParams.EventSender = esPreview) then Exit;
  baseEvent := FListEvents.FindEventInPoint(Point(X, Y));
  Result := baseEvent <> nil;
  if (Result) then
  begin
    baseEvent.Execute(TfrxBarCodeCompositeView(FComponent));
    FComponent.Report.Designer.SelectedObjects.Clear;
    FComponent.Report.Designer.SelectedObjects.Add(Self);
    FComponent.Report.Designer.ReloadObjects(False);
  end;
end;

constructor TfrxInPlaceBarcodeCompEditor.Create(aClassRef: TfrxComponentClass; aOwner: TWinControl);
begin
  inherited;
  FListEvents := TfrxListEvents.Create;
  FShowGUI := False;
end;

destructor TfrxInPlaceBarcodeCompEditor.Destroy;
begin
  FreeAndNil(FListEvents);
  inherited;
end;

procedure TfrxInPlaceBarcodeCompEditor.DrawCustomEditor(aCanvas: TCanvas; aRect: TRect);
begin
  inherited;
  if (not FShowGUI) then
    Exit;
  DrawGUI(aCanvas, FScale, FScale, FOffsetX, FOffsetY);
end;

procedure TfrxInPlaceBarcodeCompEditor.InitializeUI(var EventParams: TfrxInteractiveEventsParams);
begin
  inherited;
  FShowGUI := True;
end;

function TfrxInPlaceBarcodeCompEditor.ListBoxClicked(Sender: TObject): Boolean;
var
  LConstructParam: TfrxBarcodeConstructionStruct;
  LCompositeView: TfrxBarCodeCompositeViewHack;
  LIndex: Integer;
begin
  Result := False;
  if (FComponent is TfrxBarCodeCompositeView) and (ListItems.Objects[ListItemIndex] is TfrxBarcodeConstructionStruct) then
  begin
    LConstructParam := TfrxBarcodeConstructionStruct(ListItems.Objects[ListItemIndex]);
    LCompositeView := TfrxBarCodeCompositeViewHack(FComponent);
    LIndex := LCompositeView.Objects.IndexOf(FLastComponent);
    if LIndex >= 0 then
    begin
     FreeAndNil(FLastComponent);
     FLastComponent := LCompositeView.AddInternalBarcode(LConstructParam.FClassRef, LConstructParam.FFlag);
     LCompositeView.Objects.Exchange(LIndex, LCompositeView.Objects.Count - 1);
    end;
    Result := True;
  end;
end;

procedure TfrxInPlaceBarcodeCompEditor.FinalizeUI(var EventParams: TfrxInteractiveEventsParams);
begin
  inherited;
  FShowGUI := False;
end;

function TfrxInPlaceBarcodeCompEditor.GetButtonTopLeft: TPoint;
var
  LButtonSize: Integer;
  LRect: TRect;
  I: Integer;
  LView: TfrxView;
begin
  FDrawButton := False;
  FLastComponent := nil;
  Result := Point(0, 0);
  if not FShowGUI then Exit;

  LButtonSize := GetButtonSize;
  for I := 0 to FComponent.Objects.Count - 1 do
  if TObject(FComponent.Objects[I]) is TfrxView then
  begin
    LView := TfrxView(FComponent.Objects[I]);
    if LView.IsContain((FLastMousePos.X - FOffsetX)  / FScale , (FLastMousePos.Y - FOffsetY) / FScale) then
    begin
      LRect := Rect(Round(LView.AbsLeft), Round(LView.AbsTop), Round(LView.AbsLeft + LView.Width), Round(LView.AbsTop + LView.Height));
      Result := Point(LRect.Left + (LRect.Right - LRect.Left) div 2 - LButtonSize div 2, LRect.Top + (LRect.Bottom - LRect.Top) div 2 - LButtonSize div 2);
      FDrawButton := FShowGUI;
      FLastComponent := LView;
    end;
  end;
end;

function TfrxInPlaceBarcodeCompEditor.GetImageIndex: Integer;
begin
  Result := 141;
end;

function TfrxInPlaceBarcodeCompEditor.DoMouseMove(X, Y: Integer; Shift: TShiftState;
  var EventParams: TfrxInteractiveEventsParams): Boolean;
begin
  Result := inherited DoMouseMove(X, Y, Shift, EventParams);
  FLastMousePos := Point(X, Y);
end;

function TfrxInPlaceBarcodeCompEditor.DoMouseUp(X, Y: Integer; Button: TMouseButton;
      Shift: TShiftState; var EventParams: TfrxInteractiveEventsParams): Boolean;
begin
  inherited DoMouseUp(X, Y, Button, Shift, EventParams);
  Result := CheckGuiClick(X, Y, Button, Shift, EventParams);
end;

{ TfrxBarCodeCompositeEditor }

const
  frxCodeClearAction = 49;
  frxOffsetLinearActions = 100; //[100-199] list 1d barcode
  frxOffset2DActions = 200; //[200-299] list 2d barcode
  frxOffsetPresetActions = 300; //[300-MaxInt] list presets

procedure TfrxBarCodeCompositeEditor.CreatePreset(PresetB: TMenuItem);
var
  i: Integer;
  BCP: TfrxBaseBarPreset;
begin
  for i := 1 to frxBarcodeBarPresetList.Count - 1 do
  begin
    BCP := frxBarcodeBarPresetList.List[i];
    AddItem(BCP.Name, frxOffsetPresetActions + i, False, PresetB);
  end;
end;

procedure TfrxBarCodeCompositeEditor.GetMenuItems;
var
  PresetB, AddB: TMenuItem;
begin
  PresetB := AddItem(frxGet(3512), 0);
  CreatePreset(PresetB);
  AddB := AddItem(frxGet(3804), 0);
  CreateBarTypesSubmenu(AddB);
  AddItem(frxGet(3805), frxCodeClearAction, False);
  AddItem('-', -1);
  inherited;
end;

function TfrxBarCodeCompositeEditor.Execute(Tag: Integer; Checked: Boolean): Boolean;
var
  i: Integer;
  LComponent: TfrxComponent;
  LBarView: TfrxBarCodeCompositeView;
  BCP: TfrxBaseBarPreset;
  LObjects: TList;
begin
  Result := inherited Execute(Tag, Checked);
  if (Tag = 0) then
    Exit;
  LObjects := TList.Create;
  try
    for i := 0 to Designer.SelectedObjects.Count - 1 do
    begin
      LComponent := TfrxComponent(Designer.SelectedObjects[i]);
      if (LComponent is TfrxBarCodeCompositeView) and
        not(rfDontModify in LComponent.Restrictions) then
        LObjects.Add(LComponent);
    end;

    for i := 0 to LObjects.Count - 1 do
    begin
      LBarView := TfrxBarCodeCompositeView(LObjects[i]);
      if Tag >= frxOffsetPresetActions then
      begin
        //LBarView.DrawPreset.PresetClass := '';
        BCP := frxBarcodeBarPresetList.List[Tag - frxOffsetPresetActions];
        BCP.SetPresset(LBarView);
      end
      else
{$IFDEF OFF2DBARS}
      if Tag >= frxOffset2DActions then
          LBarView.Add2DBarcode(Tag - frxOffset2DActions)
        else
{$ENDIF}
      if Tag >= frxOffsetLinearActions then
        LBarView.AddLinearBarcode(Tag - frxOffsetLinearActions)
       else
         case Tag of
           frxCodeClearAction:
           begin
             LBarView.Clear;
             Designer.ReloadObjects(False);
           end;
         end;
    end;
    Result := LObjects.Count > 0;
  finally
    LObjects.Free;
  end;
end;

{ TfrxBarCodeInternalEditor }

{$IFDEF OFF2DBARS}
const
  frxSwitchCodeTypeAction = 100;

procedure TfrxBarCodeInternalEditor.GetMenuItems;
var
  LMenuItem: TMenuItem;
begin
  LMenuItem := AddItem(frxGet(3502), 0);
  CreateBarTypesSubmenu(LMenuItem);
  AddItem('-', -1);
  inherited;
end;

function TfrxBarCodeInternalEditor.Execute(ATag: Integer; Checked: Boolean): Boolean;
var
  i, LIndex: Integer;
  LIBarView: IfrxBarCodeInternal;
  LCompositeView: TfrxBarCodeCompositeViewHack;
  LObjects: TList;
  LComponent: TfrxComponent;
  LComponentClass: TfrxComponentClass;
begin
  Result := inherited Execute(ATag, Checked);
  LObjects := TList.Create;
  try
    for i := 0 to Designer.SelectedObjects.Count - 1 do
    begin
      LComponent := TfrxComponent(Designer.SelectedObjects[i]);
      if ((LComponent is TfrxBarCodeInternalView) or (LComponent is TfrxBarCodeInternal2DView)) and
        not(rfDontModify in LComponent.Restrictions) then
        LObjects.Add(LComponent);
    end;
    for i := 0 to LObjects.Count - 1 do
    begin
      LComponent := LObjects[i];
      LIBarView := LComponent as IfrxBarCodeInternal;
      LCompositeView := TfrxBarCodeCompositeViewHack(LIBarView.BarParent);
      LIBarView := nil;
      LIndex := LCompositeView.Objects.IndexOf(LComponent);
      LComponentClass := nil;
      if LIndex >= 0 then
      begin
{$IFDEF OFF2DBARS}
        if ATag >= frxOffset2DActions then
        begin
          LComponentClass := TfrxBarCodeInternal2DView;
          ATag := ATag - frxOffset2DActions;
        end
        else
{$ENDIF}
          if ATag >= frxOffsetLinearActions then
          begin
            LComponentClass := TfrxBarCodeInternalView;
            ATag := ATag - frxOffsetLinearActions;
          end;
        if Assigned(LComponentClass) then
        begin
          Designer.ClearLastActiveObject;
          LComponent.Free;
          LComponent := LCompositeView.AddInternalBarcode(LComponentClass, ATag);
          LCompositeView.Objects.Exchange(LIndex,
            LCompositeView.Objects.Count - 1);
          Result := True;
          if Component = LObjects[i] then
            Component := LComponent;
          LObjects[i] := nil;
        end;
      end;
    end;
  finally
    if Result then
      Designer.ReloadObjects(False);
    LObjects.Free;
  end;
end;

{ support }

function CheckIs2D(c: TfrxComponent): Boolean;
begin
  Result := (c is TfrxBarCodeInternal2DView);
end;
{$ENDIF}

{ TfrxInPlaceBarcodeCompositePresetEditor }

constructor TfrxInPlaceBarcodeCompositePresetEditor.Create(AClassRef: TfrxComponentClass; AOwner: TWinControl);
begin
  inherited;
  FButtonSize := 18;
end;

procedure TfrxInPlaceBarcodeCompositePresetEditor.DrawButton(ACanvas: TCanvas; ARect: TRect);
var
  LRect: TRect;
begin
  LRect := GetButtonRect;
  ACanvas.Brush.Color := clWhite;
  ACanvas.FillRect(LRect);
  InflateRect(LRect, -1, - 1);
  ACanvas.Brush.Color := clBlack;
  ACanvas.FillRect(LRect);
  InflateRect(LRect, -1, - 1);
  ACanvas.Brush.Color := clWhite;
  ACanvas.FillRect(LRect);
  frxDrawArrow(ACanvas, LRect, clBlack, FDrawDropDown);
end;


function TfrxInPlaceBarcodeCompositePresetEditor.IsDropDownButtonVisible: Boolean;
begin
  Result := frxBarcodeBarPresetList.Count > 0;
end;

function TfrxInPlaceBarcodeCompositePresetEditor.IsFillListBox: Boolean;
var
  i: Integer;
  LBCP: TfrxBaseBarPreset;
  LList: TStrings;
begin
  LList := ListItems;
  LList.BeginUpdate;
  try
    LList.Clear;
    for i := 1 to frxBarcodeBarPresetList.Count - 1 do
    begin
      LBCP := frxBarcodeBarPresetList.List[i];
      LList.AddObject(LBCP.Name, LBCP);
    end;
  finally
    LList.EndUpdate;
    Result := frxBarcodeBarPresetList.Count > 0;
  end;
end;

procedure TfrxInPlaceBarcodeCompositePresetEditor.ListBoxDrawItem(ACanvas: TCanvas; AControl: TWinControl; AIndex: Integer; ARect: TRect;
      AState: TfrOwnerDrawState);
begin
  ACanvas.FillRect(ARect);
  frxImages.ObjectImages.Draw(ACanvas, ARect.Left, ARect.Top, 23);
  ACanvas.TextOut(ARect.Left + frxImages.ObjectImages.Width + 4, ARect.Top + 1, ListItems[AIndex]);
end;

function TfrxInPlaceBarcodeCompositePresetEditor.ListBoxClicked(Sender: TObject): Boolean;
begin
  Result := False;
  if (FComponent is TfrxBarCodeCompositeView) and (ListItems.Objects[ListItemIndex] is TfrxBaseBarPreset) then
  begin
    TfrxBaseBarPreset(ListItems.Objects[ListItemIndex]).SetPresset(FComponent as TfrxBarCodeCompositeView);
    Result := True;
  end;
end;

{ TfrxInPlaceBarcodeCompositeAddEditor }

function TfrxInPlaceBarcodeCompositeAddEditor.GetButtonTopLeft: TPoint;
begin
  Result := Point(FRect.Right - GetButtonSize, FRect.Bottom - GetButtonSize)
end;

function TfrxInPlaceBarcodeCompositeAddEditor.GetImageIndex: Integer;
begin
  Result := 142;
end;

function TfrxInPlaceBarcodeCompositeAddEditor.ListBoxClicked(Sender: TObject): Boolean;
var
  LConstructParam: TfrxBarcodeConstructionStruct;
  LCompositeView: TfrxBarCodeCompositeViewHack;
begin
  Result := False;
  if (FComponent is TfrxBarCodeCompositeView) and (ListItems.Objects[ListItemIndex] is TfrxBarcodeConstructionStruct) then
  begin
    LConstructParam := TfrxBarcodeConstructionStruct(ListItems.Objects[ListItemIndex]);
    LCompositeView := TfrxBarCodeCompositeViewHack(FComponent);
    LCompositeView.AddInternalBarcode(LConstructParam.FClassRef, LConstructParam.FFlag);
    Result := True;
  end;
end;

{ TfrxBarcodeConstructionStruct }

constructor TfrxBarcodeConstructionStruct.Create(AClassRef: TfrxComponentClass; AFlag: Integer);
begin
  if AClassRef.InheritsFrom(TfrxBarCodeView) then
    FClassRef := TfrxBarCodeInternalView
  else if AClassRef.InheritsFrom(TfrxBarcode2DView) then
    FClassRef := TfrxBarCodeInternal2DView
  else
    raise Exception.Create('Invalid Barcode class.');
  FFlag := AFlag;
end;

{ TfrxInPlaceBarcodeCompositeBaseTypeEditor }

constructor TfrxInPlaceBarcodeCompositeBaseTypeEditor.Create(aClassRef: TfrxComponentClass; aOwner: TWinControl);
begin
  inherited;
  FItemsList := TStringList.Create;
  FButtonSize := 18;
end;

destructor TfrxInPlaceBarcodeCompositeBaseTypeEditor.Destroy;
begin
  FreeListItems;
  FreeAndNil(FItemsList);
  inherited;
end;

procedure TfrxInPlaceBarcodeCompositeBaseTypeEditor.DrawButton(ACanvas: TCanvas; ARect: TRect);
var
  LRect: TRect;
begin
  LRect := GetButtonRect;
  ACanvas.Brush.Color := clWhite;
  ACanvas.FillRect(LRect);
  ACanvas.Brush.Color := clBlack;
  ACanvas.Pen.Color := clBlack;
  ACanvas.Pen.Width := 1;
//  ACanvas.FrameRect(LRect);
  frxImages.MainButtonImages.Draw(aCanvas, LRect.Left + (GetButtonSize - 16) div 2 , LRect.Top + (GetButtonSize - 16) div 2, GetImageIndex, True);
end;

procedure TfrxInPlaceBarcodeCompositeBaseTypeEditor.FreeListItems;
var
  I: Integer;
begin
  for I := 0 to FItemsList.Count - 1 do
    FItemsList.Objects[I].Free;
  FItemsList.Clear;
end;

function TfrxInPlaceBarcodeCompositeBaseTypeEditor.IsDropDownButtonVisible: Boolean;
begin
  Result := True;
end;

function TfrxInPlaceBarcodeCompositeBaseTypeEditor.IsFillListBox: Boolean;
var
  i: Integer;
  LList: TStrings;
  LItem: TfrxObjectItem;
begin
  LList := ListItems;
  FItemsList.BeginUpdate;
  try
    FreeListItems;
    LList.Clear;
    for i := 1 to frxObjects.Count - 1 do
    begin
      LItem := frxObjects[i];
      if (LItem.CategoryName = frxBarcodeCategoryName) and Assigned(LItem.ClassRef)
      and (LItem.ClassRef.InheritsFrom(TfrxBarCodeView) or LItem.ClassRef.InheritsFrom(TfrxBarcode2DView)) then
        FItemsList.AddObject(LItem.ButtonHint, TfrxBarcodeConstructionStruct.Create(LItem.ClassRef, LItem.Flags));
    end;
  finally
    FItemsList.EndUpdate;
    Result := FItemsList.Count > 0;
    if Result then
      LList.Assign(FItemsList);
  end;
end;

procedure TfrxInPlaceBarcodeCompositeBaseTypeEditor.ListBoxDrawItem(ACanvas: TCanvas; AControl: TWinControl;
  AIndex: Integer; ARect: TRect; AState: TfrOwnerDrawState);
begin
  ACanvas.FillRect(ARect);
  frxImages.ObjectImages.Draw(ACanvas, ARect.Left, ARect.Top, 23);
  ACanvas.TextOut(ARect.Left + frxImages.ObjectImages.Width + 4, ARect.Top + 1, ListItems[AIndex]);
end;

{ TfrxBarCodeCustomTypeEditor }

procedure TfrxBarCodeCustomTypeEditor.CreateBarTypesSubmenu(AParentItem: TMenuItem);
var
  D1B: TMenuItem;
{$IFDEF OFF2DBARS}
  D2B: TMenuItem;
{$ENDIF}

  procedure AddCat(ClassType: TfrxComponentClass; MenuItemOwn: TMenuItem; TagOfset: Integer);
  var
    i: Integer;
    LItem: TfrxObjectItem;
  begin
    for i := 0 to frxObjects.Count - 1 do
    begin
      LItem := frxObjects.Items[i];
      if (LItem.ClassRef = ClassType) then
        AddItem(LItem.ButtonHint, TagOfset + LItem.Flags, False, MenuItemOwn);
    end;
  end;

begin
  D1B := AddItem(frxGet(3513), 0, False, AParentItem);
  AddCat(TfrxBarcodeView, D1B, frxOffsetLinearActions);
{$IFDEF OFF2DBARS}
  D2B := AddItem(frxGet(3514), 0, False, AParentItem);
  AddCat(TfrxBarcode2DView, D2B, frxOffset2DActions);
{$ENDIF}
end;

initialization

  frxComponentEditors.Register(TfrxBarCodeCompositeView, TfrxBarCodeCompositeEditor);
{$IFDEF OFF2DBARS}
  frxComponentEditors.Register(TfrxBarCodeInternalView, TfrxBarCodeInternalEditor);
  frxComponentEditors.Register(TfrxBarCodeInternal2DView, TfrxBarCodeInternalEditor);
{$ENDIF}
  frxRegEditorsClasses.Register(TfrxBarCodeCompositeView, [TfrxInPlaceBarcodeCompEditor, TfrxInPlaceBarcodeCompositeAddEditor, TfrxInPlaceBarcodeCompositePresetEditor], [[evDesigner], [evDesigner], [evDesigner]]);

finalization
  frxUnregisterEditorsClass(TfrxBarCodeCompositeView, TfrxInPlaceBarcodeCompEditor);

end.
