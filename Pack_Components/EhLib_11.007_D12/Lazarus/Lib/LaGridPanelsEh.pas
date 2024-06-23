{*******************************************************}
{                                                       }
{                       EhLib 11.0                      }
{                     LaGridPanelsEh                    }
{                                                       }
{    Copyright (c) 2022-2022 by Dmitry V. Bolshakov     }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit LaGridPanelsEh;

interface

{$SCOPEDENUMS ON}

uses
  Types, Classes, Math, Messages, SysUtils, Variants,
  {$IFDEF FPC}
  EhLibLCL,
  {$ELSE}
  EhLibVCL,
  {$ENDIF}
  Generics.Collections, DB,
  LaObjectsEh, LaControlsEh,
  ImgList, Graphics, Controls, Forms, Dialogs;

type
  TLaSizeStyleEh = (Pixel, Weight, Auto);

  TLaGridPanelEh = class;

  EGridPanelException = class(Exception);

  TCellItem = class(TCollectionItem)
  private
    FSizeStyle: TLaSizeStyleEh;
    FValue: Double;
    FSize: Integer;
    FNeededSize: Integer;
    FAutoAdded: Boolean;
  protected
    procedure AssignTo(Dest: TPersistent); override;
    procedure SetSizeStyle(Value: TLaSizeStyleEh);
    procedure SetValue(Value: Double);

    property Size: Integer read FSize write FSize;
    property AutoAdded: Boolean read FAutoAdded write FAutoAdded;
  public
    constructor Create(Collection: TCollection); override;
  published
    property SizeStyle: TLaSizeStyleEh read FSizeStyle write SetSizeStyle default TLaSizeStyleEh.Weight;
    property Value: Double read FValue write SetValue;
  end;

  TRowItem = class(TCellItem);

  TColumnItem = class(TCellItem);

  TCellCollection = class(TOwnedCollection)
  protected
    function GetAttrCount: Integer; override;
    function GetAttr(Index: Integer): string; override;
    function GetItemAttr(Index, ItemIndex: Integer): string; override;
    function GetItem(Index: Integer): TCellItem;
    procedure SetItem(Index: Integer; Value: TCellItem);
    procedure Update(Item: TCollectionItem); override;
  public
    function Owner: TLaGridPanelEh;
    procedure EquallySplitPercentuals;
    property Items[Index: Integer]: TCellItem read GetItem write SetItem; default;
  end;

  TCellSpan = 1..MaxInt;

  TRowCollection = class(TCellCollection)
  protected
    function GetItem(Index: Integer): TRowItem;
    procedure SetItem(Index: Integer; Value: TRowItem);

    function GetItemAttr(Index, ItemIndex: Integer): string; override;
    procedure Notify(Item: TCollectionItem; Action: Classes.TCollectionNotification); override;
  public
    constructor Create(AOwner: TPersistent);
    function Add: TRowItem;
    property Items[Index: Integer]: TRowItem read GetItem write SetItem; default;
  end;

  TColumnCollection = class(TCellCollection)
  protected
    function GetItem(Index: Integer): TColumnItem;
    procedure SetItem(Index: Integer; Value: TColumnItem);

    function GetItemAttr(Index, ItemIndex: Integer): string; override;
    procedure Notify(Item: TCollectionItem; Action: Classes.TCollectionNotification); override;
  public
    constructor Create(AOwner: TPersistent);
    function Add: TColumnItem;
    property Items[Index: Integer]: TColumnItem read GetItem write SetItem; default;
  end;

  TControlItem = class(TCollectionItem)
  private
    FControl: TLaObjectEh;
    FColumn: Integer;
    FRow: Integer;
    FColumnSpan: TCellSpan;
    FRowSpan: TCellSpan;
    FPushed: Integer;
    function GetGridPanel: TLaGridPanelEh;
    function GetPushed: Boolean;
    procedure SetColumn(Value: Integer);
    procedure SetColumnSpan(Value: TCellSpan);
    procedure SetControl(Value: TLaObjectEh);
    procedure SetRow(Value: Integer);
    procedure SetRowSpan(Value: TCellSpan);
  protected
    procedure AssignTo(Dest: TPersistent); override;
    procedure InternalSetLocation(AColumn, ARow: Integer; APushed: Boolean; MoveExisting: Boolean);
    property GridPanel: TLaGridPanelEh read GetGridPanel;
    property Pushed: Boolean read GetPushed;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure SetLocation(AColumn, ARow: Integer; APushed: Boolean = False);
  published
    property Control: TLaObjectEh read FControl write SetControl;

    property Column: Integer read FColumn write SetColumn;
    property ColumnSpan: TCellSpan read FColumnSpan write SetColumnSpan default 1;

    property Row: Integer read FRow write SetRow;
    property RowSpan: TCellSpan read FRowSpan write SetRowSpan default 1;
  end;

  TControlCollection = class(TOwnedCollection)
  protected
    function GetControl(AColumn, ARow: Integer): TLaObjectEh;
    function GetControlItem(AColumn, ARow: Integer): TControlItem;
    function GetItem(Index: Integer): TControlItem;
    procedure SetControl(AColumn, ARow: Integer; Value: TLaObjectEh);
    procedure SetItem(Index: Integer; Value: TControlItem);
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(AOwner: TPersistent);
    function Add: TControlItem;

    procedure AddControl(AControl: TLaObjectEh; AColumn: Integer = -1; ARow: Integer = -1);
    procedure RemoveControl(AControl: TLaObjectEh);

    function IndexOf(AControl: TLaObjectEh): Integer;
    function Owner: TLaGridPanelEh;

    property Controls[AColumn, ARow: Integer]: TLaObjectEh read GetControl write SetControl;
    property ControlItems[AColumn, ARow: Integer] : TControlItem read GetControlItem;
    property Items[Index: Integer]: TControlItem read GetItem write SetItem; default;
  end;

//  TExpandStyle = (emAddRows, emAddColumns, emFixedSize);

  TLaGridPanelEh = class(TLaControlEh)
  private
    FRowCollection: TRowCollection;
    FColumnCollection: TColumnCollection;
    FControlCollection: TControlCollection;
    FRecalcCellSizes: Boolean;
    FRecalcCellSizesDisabled: Integer;
    FRecalcCellPercentsDisabled: Boolean;
    FClientSize: TSize;
    FGridQuerySize: TSize;
    FGridQrCalcedSize: TSize;

    FDummyColumnWidth: Integer;
    FDummyRowHeight: Integer;
    FDummyNeededColumnWidth: Integer;
    FDummyNeededRowHeight: Integer;

//    FExpandStyle: TExpandStyle;
//    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;
//    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    function GetCellCount: Integer;
    function GetCellSizes(AColumn, ARow: Integer): TSize;
    function GetCellRect(AColumn, ARow: Integer): TRect;
    function GetColumnSpanIndex(AColumn, ARow: Integer): Integer;
    function GetRowSpanIndex(AColumn, ARow: Integer): Integer;
    function GetRecalcCellSizesEnabled: Boolean;
    function GetRecalcCellPercentsEnabled: Boolean;
//    function GetControlBounds(AControl: TLaObject; AUseExplicitSize: Boolean; var AIntPos: TRect): TRect;

    procedure SetColumnCollection(const Value: TColumnCollection);
    procedure SetControlCollection(const Value: TControlCollection);
    procedure SetRowCollection(const Value: TRowCollection);
    procedure RecalcCellDimensions(const APanelSize: TSize; ACanvas: TCanvas);
    procedure CMControlChange(var Message: TCMControlChange); message CM_CONTROLCHANGE;
    function GetColLayoutCount: Integer;
    function GetRowLayoutCount: Integer;
//    procedure OfferCellSize(AColumn, ARow: Integer; ACellNeededSize: TSize);
    procedure InitNeededSize(AInitSize: TSize);
    procedure PrepareForRecalcCellDimensions;
//    procedure ArrangeControl(AControl: TLaObject; const ParentSize: TPoint; AAlign: TAlign; AAlignInfo: TAlignInfo; var Rect: TRect; UpdateAnchorOrigin: Boolean);
    //procedure FlipChildren(AllLevels: Boolean);
    //procedure GetChildren(Proc: TGetChildProc; Root: TComponent);
  protected
    function AutoAddColumn: TColumnItem;
    function AutoAddRow: TRowItem;
    function CellToCellIndex(AColumn, ARow: Integer): Integer;

    procedure CellIndexToCell(AIndex: Integer; var AColumn, ARow: Integer);
//    procedure AlignControls(AControl: TLaObject; var Rect: TRect); //override;
//    procedure Loaded; override;
//    procedure Paint; override;
    procedure RemoveEmptyAutoAddColumns;
    procedure RemoveEmptyAutoAddRows;
    //procedure UpdateControlOriginalParentSize(AControl: TControl; var AOriginalParentSize: TPoint); override;
    //procedure ControlChange(Inserting: Boolean; Child: TControl); override;
  public

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;
    function DoQueryLayoutClientArea(QuerySize: TSize; ACanvas: TCanvas): TSize; override;
    function DoPerformLayoutClientArea(ClientRect: TRect; ACanvas: TCanvas): TSize; override;

    procedure BeginUpdate;
    procedure EndUpdate;
    //procedure ScaleForPPI(NewPPI: Integer); override;
    //procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    function IsColumnEmpty(AColumn: Integer): Boolean;
    function IsRowEmpty(ARow: Integer): Boolean;

    procedure UpdateControlsColumn(AColumn: Integer);
    procedure UpdateControlsRow(ARow: Integer);

    //procedure FlipChildren(AllLevels: Boolean); override;
    property ColumnSpanIndex[AColumn, ARow: Integer]: Integer read GetColumnSpanIndex;
    property CellCount: Integer read GetCellCount;
    property CellSize[AColumn, ARow: Integer]: TSize read GetCellSizes;
    property CellRect[AColumn, ARow: Integer]: TRect read GetCellRect;
    property ColLayoutCount: Integer read GetColLayoutCount;
    property RowLayoutCount: Integer read GetRowLayoutCount;
    property RecalcCellSizesEnabled: Boolean read GetRecalcCellSizesEnabled;
    property RecalcCellPercentsEnabled: Boolean read GetRecalcCellPercentsEnabled;
    property ControlCollection: TControlCollection read FControlCollection write SetControlCollection;
    //property ExpandStyle: TExpandStyle read FExpandStyle write FExpandStyle default emAddRows;
    property ColumnCollection: TColumnCollection read FColumnCollection write SetColumnCollection;
    property RowCollection: TRowCollection read FRowCollection write SetRowCollection;
    property RowSpanIndex[AColumn, ARow: Integer]: Integer read GetRowSpanIndex;
    property ClientSize: TSize read FClientSize;
  end;

implementation

const
  sCannotAddFixedSize = 'Cannot add columns or rows while expand style is fixed size';
//  sCannotAddToEmpty = 'Cannot add a control to GridPanel with empty rows and columns';
  sInvalidSpan = '''%d'' is not a valid span';
  sInvalidRowIndex = 'Row index, %d, out of bounds';
  sInvalidColumnIndex = 'Column index, %d, out of bounds';
  sInvalidControlItem = 'ControlItem.Control cannot be set to owning GridPanel';
//  sCannotDeleteColumn = 'Cannot delete a column that contains controls';
//  sCannotDeleteRow = 'Cannot delete a row that contains controls';
  sCellMember = 'Member';
  sCellSizeType = 'Size Type';
  sCellValue = 'Value';
  sCellAutoSize = 'Auto';
  sCellPercentSize = 'Percent';
  sCellAbsoluteSize = 'Absolute';
  sCellColumn = 'Column%d';
  sCellRow = 'Row%d';

{ TLaGridPanelEh }

//function TLaGridPanelEh.GetControlBounds(AControl: TLaObject; AUseExplicitSize: Boolean;
//  var AIntPos: TRect): TRect;
//var
//  Owned: TControl;
//  I: Integer;
//  R: TRect;
//begin
//  if AUseExplicitSize then
//    Result := TRect.Create(TPoint.Create(AControl.Margins.ControlLeft, AControl.Margins.ControlTop),
//      AControl.Margins.ExplicitWidth, AControl.Margins.ExplicitHeight)
//  else
//    Result := TRect.Create(TPoint.Create(AControl.Margins.ControlLeft, AControl.Margins.ControlTop),
//      AControl.Margins.ControlWidth, AControl.Margins.ControlHeight);
//  AIntPos := Result;
//  for I := 0 to AControl.ComponentCount - 1 do
//    if AControl.Components[I] is TControl then
//    begin
//      Owned := TControl(AControl.Components[I]);
//      if (csSubComponent in Owned.ComponentStyle) and
//         (Owned.Parent = AControl.Parent) then
//      begin
//        if AUseExplicitSize then
//          R := TRect.Create(TPoint.Create(Owned.Margins.ControlLeft, Owned.Margins.ControlTop),
//            Owned.Margins.ExplicitWidth, Owned.Margins.ExplicitHeight)
//        else
//          R := TRect.Create(TPoint.Create(Owned.Margins.ControlLeft, Owned.Margins.ControlTop),
//            Owned.Margins.ControlWidth, Owned.Margins.ControlHeight);
//        UnionRect(Result, Result, R);
//      end;
//    end;
//  AIntPos.Offset(-Result.Left, -Result.Top);
//end;

//procedure TLaGridPanelEh.ArrangeControl(AControl: TLaObject; const ParentSize: TPoint;
//  AAlign: TAlign; AAlignInfo: TAlignInfo; var Rect: TRect; UpdateAnchorOrigin: Boolean);
//begin
//
//end;

//procedure TLaGridPanelEh.AlignControls(AControl: TLaObject; var Rect: TRect);
//
//  procedure ArrangeControlInCell(AControl: TLaObject; CellRect: TRect; const AlignInfo: TAlignInfo);
////  var
////    Bounds, NewBounds, IntPos: TRect;
////    AnchorSubset: TAnchors;
//  begin
////    if AControl.Align <> alNone then
////        ArrangeControl(AControl, Point(CellRect.Right - CellRect.Left, CellRect.Bottom - CellRect.Top),
////          AControl.Align, AlignInfo, CellRect, True)
////    else
////    begin
////      Bounds := GetControlBounds(AControl, True, IntPos);
////      AnchorSubset := AControl.Anchors * [akLeft, akRight];
////      if AnchorSubset = [akLeft] then
////        NewBounds.Left := CellRect.Left
////      else if AnchorSubset = [akRight] then
////        NewBounds.Left := Max(CellRect.Left, CellRect.Right - Bounds.Width)
////      else
////        NewBounds.Left := Max(CellRect.Left, CellRect.Left + ((CellRect.Right - CellRect.Left) - Bounds.Width) div 2);
////      NewBounds.Right := NewBounds.Left + Min(CellRect.Right - CellRect.Left, Bounds.Width);
////      AnchorSubset := AControl.Anchors * [akTop, akBottom];
////      if AnchorSubset = [akTop] then
////        NewBounds.Top := CellRect.Top
////      else if AnchorSubset = [akBottom] then
////        NewBounds.Top := Max(CellRect.Top, CellRect.Bottom - Bounds.Height)
////      else
////        NewBounds.Top := Max(CellRect.Top, CellRect.Top + ((CellRect.Bottom - CellRect.Top) - Bounds.Height) div 2);
////      NewBounds.Bottom := NewBounds.Top + Min(CellRect.Bottom - CellRect.Top, Bounds.Height);
////      AControl.Margins.SetControlBounds(NewBounds.Left + IntPos.Left, NewBounds.Top + IntPos.Top, IntPos.Width, IntPos.Height, True);
////    end;
//  end;
//
//  procedure AdjustCellRect(var Rect: TRect);
//  begin
//    Inc(Rect.Left, Padding.Left);
//    Inc(Rect.Top, Padding.Top);
//    Dec(Rect.Right, Padding.Right);
//    Dec(Rect.Bottom, Padding.Bottom);
//  end;
//
//  procedure ArrangeControls;
//  var
//    I, J, K: Integer;
//    CellRect: TRect;
//    SpanRect: TRect;
//    ControlItem: TControlItem;
//    AlignInfo: TAlignInfo;
//  begin
//    AlignInfo.ControlIndex := 0;
//    AlignInfo.AlignList := TList.Create;
//    try
//      CellRect.Top := Rect.Top;
//      for J := 0 to FRowCollection.Count - 1 do
//      begin
//        CellRect.Left := Rect.Left;
//        CellRect.Bottom := CellRect.Top + FRowCollection[J].Size;
//        for I := 0 to FColumnCollection.Count - 1 do
//        begin
//          ControlItem := FControlCollection.ControlItems[I, J];
//          CellRect.Right := CellRect.Left + FColumnCollection[I].Size;
//          if (ControlItem <> nil) and (ControlItem.Control <> nil) and
//             (ControlItem.Column = I) and (ControlItem.Row = J) then
//          begin
//            AlignInfo.AlignList.Clear;
//            AlignInfo.AlignList.Add(ControlItem.Control);
////            AlignInfo.Align := ControlItem.Control.Align;
//            SpanRect := CellRect;
//            if ControlItem.ColumnSpan > 1 then
//              for K := I + 1 to Min(I + ControlItem.ColumnSpan - 1, FColumnCollection.Count - 1) do
//                Inc(SpanRect.Right, FColumnCollection[K].Size);
//            if ControlItem.RowSpan > 1 then
//              for K := J + 1 to Min(J + ControlItem.RowSpan - 1, FRowCollection.Count - 1 ) do
//                Inc(SpanRect.Bottom, FRowCollection[K].Size);
//            AdjustCellRect(SpanRect);
//            ArrangeControlInCell(ControlItem.Control, SpanRect, AlignInfo);
//          end;
//          CellRect.Left := CellRect.Right;
//        end;
//        CellRect.Top := CellRect.Bottom;
//      end;
//    finally
//      AlignInfo.AlignList.Free;
//    end;
//  end;
//
//begin
//  //AdjustClientRect(Rect);
//  if FRecalcCellSizes then
//    RecalcCellDimensions(Rect);
////  if ControlCount > 0 then
////    ArrangeControls;
//end;

function TLaGridPanelEh.AutoAddColumn: TColumnItem;
begin
  Result := FColumnCollection.Add;
  //Result.SizeStyle := TSizeStyle.Auto;
  Result.SizeStyle := TLaSizeStyleEh.Weight;
  Result.Value := 1;
  Result.AutoAdded := True;
end;

//procedure TLaGridPanelEh.ScaleForPPI(NewPPI: Integer);
//var
//  I: Integer;
//begin
//  if newPPI = 0 then
//    newPPI := GetCurrentPPIScreen;
//  if newPPI <> FCurrentPPI then
//  begin
//    for I := 0 to FRowCollection.Count - 1 do
//    begin
//      FRowCollection.Items[I].Size := MulDiv(FRowCollection.Items[I].Size, NewPPI, FCurrentPPI);
//      if FRowCollection.Items[I].SizeStyle = ssAbsolute then
//        FRowCollection.Items[I].FValue := FRowCollection.Items[I].Size;
//    end;
//    for I := 0 to FColumnCollection.Count - 1 do
//    begin
//      FColumnCollection.Items[I].Size := MulDiv(FColumnCollection.Items[I].Size, NewPPI, FCurrentPPI);
//      if FColumnCollection.Items[I].SizeStyle = ssAbsolute then
//        FColumnCollection.Items[I].FValue := FColumnCollection.Items[I].Size;
//    end;
//    for I := 0 to FControlCollection.Count - 1 do
//      if FControlCollection.Items[I].FControl <> nil then
//        FControlCollection.Items[I].FControl.ScaleForPPI(NewPPI);
//    inherited ScaleForPPI(NewPPI);
//  end;
//end;

function TLaGridPanelEh.AutoAddRow: TRowItem;
begin
  Result := FRowCollection.Add;
  //Result.SizeStyle := TSizeStyle.Auto;
  Result.SizeStyle := TLaSizeStyleEh.Weight;
  Result.Value := 1;
  Result.AutoAdded := True;
end;

procedure TLaGridPanelEh.CellIndexToCell(AIndex: Integer; var AColumn, ARow: Integer);
begin
  AColumn := AIndex div FRowCollection.Count;
  ARow := AIndex mod FRowCollection.Count;
//  if FExpandStyle in [emAddColumns, emFixedSize] then
//  begin
//    AColumn := AIndex div FRowCollection.Count;
//    ARow := AIndex mod FRowCollection.Count;
//  end else
//  begin
//    ARow := AIndex div FColumnCollection.Count;
//    AColumn := AIndex mod FColumnCollection.Count;
//  end;
end;

function TLaGridPanelEh.CellToCellIndex(AColumn, ARow: Integer): Integer;
begin
  Result := ColumnSpanIndex[AColumn, ARow];
//  if FExpandStyle in [emAddColumns, emFixedSize] then
//    Result := ColumnSpanIndex[AColumn, ARow]
//  else
//    Result := RowSpanIndex[AColumn, ARow];
end;

procedure TLaGridPanelEh.CMControlChange(var Message: TCMControlChange);
begin

end;

constructor TLaGridPanelEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FRowCollection := TRowCollection.Create(Self);
  FColumnCollection := TColumnCollection.Create(Self);
  FControlCollection := TControlCollection.Create(Self);
  FRecalcCellSizes := True;
//  FRowCollection.Add;
//  FRowCollection.Add;
//  FColumnCollection.Add;
//  FColumnCollection.Add;
end;

//procedure TLaGridPanelEh.ControlChange(Inserting: Boolean; Child: TControl);
//begin
//  inherited ControlChange(Inserting, Child);
//  if not (csLoading in ComponentState) then
//    if Inserting and (Child.Parent = Self) and not (
//         (csSubComponent in Child.ComponentStyle)
//         (Child.Owner <> nil) and (Child.Owner is TControl) and
//         (TControl(Child.Owner).Parent = Self)) then
//    begin
//      DisableAlign;
//      try
//        Child.Anchors := [];
//        FControlCollection.AddControl(Child);
//      finally
//        EnableAlign;
//      end;
//    end else
//      FControlCollection.RemoveControl(Child);
//end;

//procedure TLaGridPanelEh.CMControlChange(var Message: TCMControlChange);
//begin
//  inherited;
//  if not (csLoading in ComponentState) then
//    if Message.Inserting and (Message.Control.Parent = Self) and not (
//         (csSubComponent in Message.Control.ComponentStyle) and
//         (Message.Control.Owner <> nil) and (Message.Control.Owner is TControl) and
//         (TControl(Message.Control.Owner).Parent = Self)) then
//    begin
//      DisableAlign;
//      try
//        Message.Control.Anchors := [];
//        FControlCollection.AddControl(Message.Control);
//      finally
//        EnableAlign;
//      end;
//    end else
//      FControlCollection.RemoveControl(Message.Control);
//end;

destructor TLaGridPanelEh.Destroy;
begin
  inherited Destroy;
  FreeAndNil(FRowCollection);
  FreeAndNil(FColumnCollection);
  FreeAndNil(FControlCollection);
end;

function TLaGridPanelEh.DoQueryLayoutClientArea(QuerySize: TSize; ACanvas: TCanvas): TSize;
//var
//  I: Integer;
//  ACellSize: TSize;
//  CtlItem: TControlItem;
//  ControlNeededSize: TSize;
begin
  RecalcCellDimensions(QuerySize, ACanvas);
  InitNeededSize(QuerySize);
  Result := FGridQrCalcedSize;

//  for I := 0 to ControlCollection.Count - 1 do
//  begin
//    CtlItem := ControlCollection[I];
//    ACellSize := CellSize[CtlItem.Column, CtlItem.Row];
//    ControlNeededSize := CtlItem.Control.QueryLayout(ACellSize, ACanvas);
//    OfferCellSize(CtlItem.Column, CtlItem.Row, ControlNeededSize);
//  end;

//  if ColumnCollection.Count > 0 then
//  begin
//    Result.cx := 0;
//    for I := 0 to ColumnCollection.Count - 1 do
//    begin
//      Result.cx := Result.cx + ColumnCollection[I].FNeededSize;
//    end;
//  end else
//  begin
//    Result.cx := FGridQrCalcedSize.cx;
//  end;
//
//  if RowCollection.Count > 0 then
//  begin
//    Result.cy := 0;
//    for I := 0 to RowCollection.Count - 1 do
//    begin
//      Result.cy := Result.cy + RowCollection[I].FNeededSize;
//    end;
//  end else
//  begin
//    Result.cy := FGridQrCalcedSize.cy;
//  end;

//  Result := QuerySize;
end;

function TLaGridPanelEh.DoPerformLayoutClientArea(ClientRect: TRect; ACanvas: TCanvas): TSize;
var
  I: Integer;
  ACellRect: TRect;
  CtlItem: TControlItem;
begin
  RecalcCellDimensions(RectSize(ClientRect), ACanvas);
  //ColumnCollection.Upd
  FClientSize.cx := RectWidth(ClientRect);
  FClientSize.cy := RectHeight(ClientRect);

  for I := 0 to ControlCollection.Count - 1 do
  begin
    CtlItem := ControlCollection[I];
    ACellRect := CellRect[CtlItem.Column, CtlItem.Row];
    CtlItem.Control.PerformLayout(ACellRect, ACanvas);
  end;

  Result.cx := RectWidth(ClientRect);
  Result.cy := RectHeight(ClientRect);
end;

function TLaGridPanelEh.GetCellCount: Integer;
begin
  Result := FRowCollection.Count * FColumnCollection.Count;
end;

procedure TLaGridPanelEh.InitNeededSize(AInitSize: TSize);
var
  I: Integer;
  Sz: Integer;
begin
//  FGridQuerySize.cx := 0; //??
//  FGridQuerySize.cy := 0; //??
  FGridQuerySize.cx := AInitSize.cx;
  FGridQuerySize.cy := AInitSize.cy;
//  FGridQrCalcedSize.cx := 0;
//  FGridQrCalcedSize.cy := 0;

  FDummyNeededColumnWidth := FDummyColumnWidth;
  if ColumnCollection.Count > 0 then
  begin
    FGridQrCalcedSize.cx := 0;
    for I := 0 to ColumnCollection.Count - 1 do
    begin
      Sz := ColumnCollection[I].FSize;
      ColumnCollection[I].FNeededSize := Sz;
      FGridQrCalcedSize.cx := FGridQrCalcedSize.cx + Sz;
    end;
  end
  else
  begin
    FGridQrCalcedSize.cx := FDummyNeededColumnWidth;
  end;

  FDummyNeededRowHeight := FDummyRowHeight;
  if RowCollection.Count > 0 then
  begin
    FGridQrCalcedSize.cy := 0;
    for I := 0 to RowCollection.Count - 1 do
    begin
      Sz := RowCollection[I].FSize;
      RowCollection[I].FNeededSize := Sz;
      FGridQrCalcedSize.cy := FGridQrCalcedSize.cy + Sz;
    end;
  end
  else
  begin
    FGridQrCalcedSize.cy := FDummyNeededRowHeight;
  end;
end;

//procedure TLaGridPanelEh.OfferCellSize(AColumn, ARow: Integer; ACellNeededSize: TSize);
//var
//  ColItem: TColumnItem;
//  RowItem: TRowItem;
//begin
//  if (AColumn = -1) then
//  begin
//    if (FGridQrCalcedSize.cx < ACellNeededSize.cx) then
//      FGridQrCalcedSize.cx := ACellNeededSize.cx;
//  end
//  else if AColumn >= 0 then
//  begin
//    ColItem := FColumnCollection[AColumn];
//    if (ColItem.SizeStyle = TLaSizeStyleEh.Auto) and
//       (ColItem.Size < ACellNeededSize.cx)
//    then
//      ColItem.Size := ACellNeededSize.cx;
//  end;
//
//  if (ARow = -1) then
//  begin
//    if (FGridQrCalcedSize.cy < ACellNeededSize.cy) then
//      FGridQrCalcedSize.cy := ACellNeededSize.cy;
//  end
//  else if ARow >= 0 then
//  begin
//    RowItem := FRowCollection[ARow];
//    if (RowItem.SizeStyle = TLaSizeStyleEh.Auto) and
//       (RowItem.Size < ACellNeededSize.cy)
//    then
//      RowItem.Size := ACellNeededSize.cy;
//  end;
//end;

function TLaGridPanelEh.GetCellRect(AColumn, ARow: Integer): TRect;
var
  I: Integer;
  ACellSize: TSize;
begin
  Result.Left := 0;
  Result.Top := 0;
  for I := 0 to AColumn - 1 do
    Inc(Result.Left, FColumnCollection[I].Size);
  for I := 0 to ARow - 1 do
    Inc(Result.Top, FRowCollection[I].Size);
  ACellSize := CellSize[AColumn, ARow];
  Result.BottomRight := Point(ACellSize.cx, ACellSize.cy);
  Inc(Result.Bottom, Result.Top);
  Inc(Result.Right, Result.Left);
end;

function TLaGridPanelEh.GetCellSizes(AColumn, ARow: Integer): TSize;
begin
  if (AColumn = -1) then
  begin
    if (IsInQueryLayout)
      then Result.cx := FGridQuerySize.cx
      else Result.cx := FClientSize.cx;
  end else
  begin
    Result.cx := FColumnCollection[AColumn].Size;
  end;

  if (ARow = -1) then
  begin
    if (IsInQueryLayout)
      then Result.cy := FGridQuerySize.cy
      else Result.cy := FClientSize.cy;
  end else
  begin
    Result.cy := FRowCollection[ARow].Size;
  end;

//  Result := TSize.Create(FColumnCollection[AColumn].Size, FRowCollection[ARow].Size);
end;

//procedure TLaGridPanelEh.GetChildren(Proc: TGetChildProc; Root: TComponent);
//var
//  I: Integer;
//  ControlItem: TControlItem;
//begin
//  for I := 0 to FControlCollection.Count - 1 do
//  begin
//    ControlItem := TControlItem(FControlCollection.Items[I]);
//    if (ControlItem.Control <> nil) and (ControlItem.Control.Owner = Root) then
//      Proc(ControlItem.Control);
//  end;
//end;

function TLaGridPanelEh.GetColumnSpanIndex(AColumn, ARow: Integer): Integer;
begin
  Result := AColumn + (ARow * FColumnCollection.Count);
end;

function TLaGridPanelEh.GetRowSpanIndex(AColumn, ARow: Integer): Integer;
begin
  Result := ARow + (AColumn * FRowCollection.Count);
end;

function TLaGridPanelEh.IsColumnEmpty(AColumn: Integer): Boolean;
var
  I: Integer;
begin
  Result := False;
  if (AColumn > -1) and (AColumn < FColumnCollection.Count) then
  begin
    for I := 0 to FRowCollection.Count -1 do
      if ControlCollection.Controls[AColumn, I] <> nil then
        Exit;
    Result := True;
  end else
    raise EGridPanelException.CreateFmt(sInvalidColumnIndex, [AColumn]);
end;

function TLaGridPanelEh.IsRowEmpty(ARow: Integer): Boolean;
var
  I: Integer;
begin
  Result := False;
  if (ARow > -1) and (ARow < FRowCollection.Count) then
  begin
    for I := 0 to FColumnCollection.Count -1 do
      if ControlCollection.Controls[I, ARow] <> nil then
        Exit;
    Result := True;
  end else
    raise EGridPanelException.CreateFmt(sInvalidRowIndex, [ARow]);
end;

//procedure TLaGridPanelEh.Loaded;
//var
//  LItem: TCollectionItem;
//begin
//  inherited Loaded;
//  for LItem in ControlCollection do
//  begin
//    with TControlItem(LItem) do
//      TControlItem(LItem).InternalSetLocation(Column, Row, False, True);
//  end;
//end;

//procedure TLaGridPanelEh.Paint;
//var
//  I: Integer;
//  LinePos, Size: Integer;
//  ClientRect: TRect;
//begin
//  inherited;
//  if csDesigning in ComponentState then
//  begin
//    LinePos := 0;
//    Canvas.Pen.Style := psDot;
//    Canvas.Pen.Color := clBlack;
//    ClientRect := GetClientRect;
//    for I := 0 to FColumnCollection.Count - 2 do
//    begin
//      Size := FColumnCollection[I].Size;
//      Canvas.MoveTo(LinePos + Size, ClientRect.Top);
//      Canvas.LineTo(LinePos + Size, ClientRect.Bottom);
//      Inc(LinePos, Size);
//    end;
//    LinePos := 0;
//    for I := 0 to FRowCollection.Count - 2 do
//    begin
//      Size := FRowCollection[I].Size;
//      Canvas.MoveTo(ClientRect.Left, LinePos + Size);
//      Canvas.LineTo(ClientRect.Right, LinePos + Size);
//      Inc(LinePos, Size);
//    end;
//  end;
//end;

procedure TLaGridPanelEh.RecalcCellDimensions(const APanelSize: TSize; ACanvas: TCanvas);
var
  I: Integer;
  XSize, YSize: Integer;
  ColItem: TCellItem;
  RowItem: TCellItem;
  SumXWeight, SumYWeight: Double;
  WeightXSize, WeightYSize: Integer;
//  RemainXSize, RemainYSize: Integer;
  ACellAutoSize: TSize;

  function CalcCellAutoSize(Col, Row: Integer): TSize;
  var
    I: Integer;
    CtlItem: TControlItem;
    ACellSize: TSize;
    ControlNeededSize: TSize;
  begin
    Result.cx := 0;
    Result.cy := 0;
    for I := 0 to ControlCollection.Count - 1 do
    begin
      CtlItem := ControlCollection[I];
      if (Col = CtlItem.Column) and (Row = CtlItem.Row) then
      begin
        ACellSize := CellSize[CtlItem.Column, CtlItem.Row];
        ControlNeededSize := CtlItem.Control.QueryLayout(ACellSize, ACanvas);
        if ControlNeededSize.cx > Result.cx then
          Result.cx := ControlNeededSize.cx;
        if ControlNeededSize.cy > Result.cy then
          Result.cy := ControlNeededSize.cy;
      end;
    end;
  end;

  function CalcAutoSizedColWidth(Col: Integer): Integer;
  var
    R: Integer;
  begin
    Result := 0;
    for R := 0 to FRowCollection.Count - 1 do
    begin
      ACellAutoSize := CalcCellAutoSize(Col, R);

      if (ACellAutoSize.cx > Result) then
        Result := ACellAutoSize.cx;
    end;
  end;

  function CalcAutoSizedRowHeight(Row: Integer): Integer;
  var
    C: Integer;
  begin
    Result := 0;
    for C := 0 to FColumnCollection.Count - 1 do
    begin
      ACellAutoSize := CalcCellAutoSize(C, Row);

      if (ACellAutoSize.cy > Result) then
        Result := ACellAutoSize.cy;
    end;
  end;

begin
  if not RecalcCellSizesEnabled then
    Exit;

  PrepareForRecalcCellDimensions();

  XSize := APanelSize.cx;
  YSize := APanelSize.cy;
//  RemainXSize := XSize;
//  RemainYSize := YSize;

  WeightXSize := 0;
  WeightYSize := 0;
  SumXWeight := 0;
  SumYWeight := 0;

  //Columns
  //Columns Pixel
  if FColumnCollection.UpdateCount = 0 then
  begin
    if FColumnCollection.Count > 0 then
    begin
      for I := 0 to FColumnCollection.Count - 1 do
      begin
        ColItem := FColumnCollection[I];
        if ColItem.SizeStyle = TLaSizeStyleEh.Pixel then
        begin
          ColItem.FSize := Trunc(ColItem.Value);
          Dec(XSize, ColItem.FSize);
        end
        else if ColItem.SizeStyle = TLaSizeStyleEh.Auto then
        begin
          ColItem.FSize := CalcAutoSizedColWidth(I);
          Dec(XSize, ColItem.FSize);
        end
        else if (ColItem.SizeStyle = TLaSizeStyleEh.Weight) then
        begin
          SumXWeight := SumXWeight + ColItem.Value;
        end;
      end;
    end else
    begin
      FDummyColumnWidth := CalcAutoSizedColWidth(-1);
      Dec(XSize, FDummyColumnWidth);
    end;

    WeightXSize := XSize;
    if WeightXSize < 0 then
      WeightXSize := 0;
  end;

  //Columns with Weight
  if FColumnCollection.UpdateCount = 0 then
  begin
    for I := 0 to FColumnCollection.Count - 1 do
    begin
      ColItem := FColumnCollection[I];
      if ColItem.SizeStyle = TLaSizeStyleEh.Weight then
      begin
        ColItem.Size := Round(ColItem.Value * WeightXSize / SumXWeight);
      end;
    end;
  end;

  //Rows
  //Rows Pixel
  if FRowCollection.UpdateCount = 0 then
  begin
    if FRowCollection.Count > 0 then
    begin
      for I := 0 to FRowCollection.Count - 1 do
      begin
        RowItem := FRowCollection[I];
        if RowItem.SizeStyle = TLaSizeStyleEh.Pixel then
        begin
          RowItem.FSize := Trunc(RowItem.Value);
          Dec(YSize, RowItem.FSize)
        end
        else if RowItem.SizeStyle = TLaSizeStyleEh.Auto then
        begin
          RowItem.FSize := CalcAutoSizedRowHeight(I);
          Dec(YSize, RowItem.FSize);
        end
        else if (RowItem.SizeStyle = TLaSizeStyleEh.Weight) then
        begin
          SumYWeight := SumYWeight + RowItem.Value;
        end;
      end;
    end else
    begin
      FDummyRowHeight := CalcAutoSizedRowHeight(-1);
      Dec(YSize, FDummyRowHeight);
    end;

    WeightYSize := YSize;
    if WeightYSize < 0 then
      WeightYSize := 0;
  end;

  //Rows with Weight
  if FRowCollection.UpdateCount = 0 then
  begin
    for I := 0 to FRowCollection.Count - 1 do
    begin
      RowItem := FRowCollection[I];
      if RowItem.SizeStyle = TLaSizeStyleEh.Weight then
      begin
        RowItem.Size := Round(RowItem.Value * WeightYSize / SumYWeight);
      end;
    end;
  end;

//  for I := 0 to FColumnCollection.Count - 1 do
//  begin
//    for J := 0 to FRowCollection.Count - 1 do
//    begin
//      RowItem := FRowCollection[I];
//
//      if (ColItem.SizeStyle = TLaSizeStyleEh.Auto) or
//         (RowItem.SizeStyle = TLaSizeStyleEh.Auto) then
//      begin
//        ACellAutoSize := CalcCellAutoSize(I, J);
//
//        if (ColItem.SizeStyle = TLaSizeStyleEh.Auto) then
//        begin
//          ColItem.FSize := ACellAutoSize.cx;
//          Dec(YSize, ColItem.FSize);
//        end;
//
//        if (RowItem.SizeStyle = TLaSizeStyleEh.Auto) then
//        begin
//          ColItem.FSize := ACellAutoSize.cx;
//          Dec(YSize, ColItem.FSize);
//        end;
//      end;
//    end;
//  end;

  FRecalcCellSizes := False;
  FRecalcCellPercentsDisabled := False;
end;

procedure TLaGridPanelEh.PrepareForRecalcCellDimensions;
var
  I: Integer;
  ColItem: TCellItem;
  RowItem: TCellItem;
begin

  for I := 0 to FColumnCollection.Count - 1 do
  begin
    ColItem := FColumnCollection[I];
//    if ColItem.SizeStyle = TLaSizeStyleEh.Auto then
    ColItem.FSize := 0;
  end;

  for I := 0 to FRowCollection.Count - 1 do
  begin
    RowItem := FRowCollection[I];
//    if RowItem.SizeStyle = TLaSizeStyleEh.Auto then
    RowItem.FSize := 0;
  end;
end;

procedure TLaGridPanelEh.RemoveEmptyAutoAddColumns;
var
  I: Integer;
begin
  for I := FColumnCollection.Count - 1 downto 0 do
  begin
    if FColumnCollection[I].AutoAdded and IsColumnEmpty(I)
      then FColumnCollection.Delete(I)
      else Exit;
  end;
end;

procedure TLaGridPanelEh.RemoveEmptyAutoAddRows;
var
  I: Integer;
begin
  for I := FRowCollection.Count - 1 downto 0 do
  begin
    if FRowCollection[I].AutoAdded and IsRowEmpty(I)
      then FRowCollection.Delete(I)
      else Exit;
  end;
end;

procedure TLaGridPanelEh.SetControlCollection(const Value: TControlCollection);
begin
  FControlCollection.Assign(Value);
end;

procedure TLaGridPanelEh.SetRowCollection(const Value: TRowCollection);
begin
  FRowCollection.Assign(Value);
end;

procedure TLaGridPanelEh.SetColumnCollection(const Value: TColumnCollection);
begin
  FColumnCollection.Assign(Value);
end;

procedure TLaGridPanelEh.UpdateControlsColumn(AColumn: Integer);
var
  I, J: Integer;
  AControlItem: TControlItem;
begin
  for I := AColumn + 1 to FColumnCollection.Count - 1 do
    for J := 0 to FRowCollection.Count - 1 do
    begin
      AControlItem := FControlCollection.ControlItems[I, J];
      if (AControlItem <> nil) and
         (AControlItem.Column = I) and
         (AControlItem.Row = J)
      then
        AControlItem.SetColumn(AControlItem.Column - 1);
    end;
end;

procedure TLaGridPanelEh.UpdateControlsRow(ARow: Integer);
var
  I, J: Integer;
  AControlItem: TControlItem;
begin
  for I := 0 to FColumnCollection.Count - 1 do
    for J := ARow + 1 to FRowCollection.Count - 1 do
    begin
      AControlItem := FControlCollection.ControlItems[I, J];
      if (AControlItem <> nil) and
         (AControlItem.Column = I) and
         (AControlItem.Row = J)
      then
        AControlItem.SetRow(AControlItem.Row - 1);
    end;
end;

//procedure TLaGridPanelEh.UpdateControlOriginalParentSize(AControl: TControl; var AOriginalParentSize: TPoint);
//var
//  Rect: TRect;
//  Index: Integer;
//  ControlItem: TControlItem;
//begin
//  if FRecalcCellSizes and HandleAllocated then
//  begin
//    Rect := GetClientRect;
//    AdjustClientRect(Rect);
//    RecalcCellDimensions(Rect);
//  end;
//  Index := FControlCollection.IndexOf(AControl);
//  if Index > -1 then
//  begin
//    ControlItem := FControlCollection[Index];
//    AOriginalParentSize := CellSize[ControlItem.Column, ControlItem.Row]
//  end else
//    inherited UpdateControlOriginalParentSize(AControl, AOriginalParentSize);
//end;

//procedure TLaGridPanelEh.WMWindowPosChanged(var Message: TWMWindowPosChanged);
//begin
//  inherited;
//  FRecalcCellSizes := True;
//end;

//procedure TLaGridPanelEh.WMSize(var Message: TWMSize);
//begin
//  FRecalcCellPercentsDisabled := True;
//  inherited;
//end;

function TLaGridPanelEh.GetRecalcCellSizesEnabled: Boolean;
begin
  Result := FRecalcCellSizesDisabled = 0;
end;

function TLaGridPanelEh.GetRecalcCellPercentsEnabled: Boolean;
begin
  Result := not FRecalcCellPercentsDisabled;
end;

procedure TLaGridPanelEh.BeginUpdate;
begin
  Inc(FRecalcCellSizesDisabled);
  FColumnCollection.BeginUpdate;
  FRowCollection.BeginUpdate;
end;

procedure TLaGridPanelEh.EndUpdate;
begin
  if FRecalcCellSizesDisabled > 0 then
  begin
    FColumnCollection.EndUpdate;
    FRowCollection.EndUpdate;
    Dec(FRecalcCellSizesDisabled);
    if FRecalcCellSizesDisabled = 0 then
    begin
      FRecalcCellSizes := True;
//      Invalidate;
//      Realign;
    end;
  end;
end;

function TLaGridPanelEh.GetColLayoutCount: Integer;
begin
  if (ColumnCollection.Count = 0)
    then Result := 1
    else Result := ColumnCollection.Count;
end;

function TLaGridPanelEh.GetRowLayoutCount: Integer;
begin
  if (RowCollection.Count = 0)
    then Result := 1
    else Result := RowCollection.Count;
end;

procedure TLaGridPanelEh.Assign(Source: TPersistent);
var
  i: Integer;
  SrcCtlItem: TControlItem;
  CtlItem: TControlItem;
  CtlIndex: Integer;
begin
  inherited Assign(Source);

  if (Source is TLaGridPanelEh) then
  begin
    ColumnCollection :=  TLaGridPanelEh(Source).ColumnCollection;
    RowCollection := TLaGridPanelEh(Source).RowCollection;

    ControlCollection.Clear;
    for i := 0 to TLaGridPanelEh(Source).ControlCollection.Count - 1 do
    begin
      SrcCtlItem := TLaGridPanelEh(Source).ControlCollection[i];
      CtlItem := ControlCollection.Add;
      CtlIndex := TLaGridPanelEh(Source).Children.IndexOf(SrcCtlItem.Control);
      ctlItem.Column := SrcCtlItem.Column;
      ctlItem.ColumnSpan := SrcCtlItem.ColumnSpan;
      ctlItem.Row := SrcCtlItem.Row;
      ctlItem.RowSpan := SrcCtlItem.RowSpan;
      ctlItem.Control := Children[CtlIndex];
    end;
  end;
end;


//procedure TLaGridPanelEh.FlipChildren(AllLevels: Boolean);
//var
//  I, J, K: Integer;
//  LCol: TCellItem;
//  LCtrl: TControl;
//begin
//  DisableAlign;
//  try
//    for I := 0 to ColumnCollection.Count div 2 - 1 do
//    begin
//      J := ColumnCollection.Count div 2 + I;
//      LCol := ColumnCollection[J];
//      ColumnCollection[I].Index := J;
//      LCol.Index := I;
//    end;
//    for I := 0 to ColumnCollection.Count div 2 - 1 do
//    begin
//      J := ColumnCollection.Count div 2 + I;
//      for K := 0 to RowCollection.Count - 1 do
//      begin
//        LCtrl := ControlCollection.Controls[J, K];
//        ControlCollection.Controls[J, K] := ControlCollection.Controls[I, K];
//        ControlCollection.Controls[I, K] := LCtrl;
//      end;
//    end;
//    for I := 0 to ColumnCollection.Count - 1 do
//      for K := 0 to RowCollection.Count - 1 do
//        if ControlCollection.Controls[I, K] <> nil then
//          ControlCollection.Controls[I, K].Perform(CM_ALLCHILDRENFLIPPED, 0, 0);
//  finally
//    EnableAlign;
//  end;
//  if AllLevels then
//    for I := 0 to ControlCount - 1 do
//      if Controls[I] is TWinControl then
//        TWinControl(Controls[I]).FlipChildren(True);
//end;

{ TCellItem }

constructor TCellItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FSizeStyle := TLaSizeStyleEh.Weight;
end;

procedure TCellItem.AssignTo(Dest: TPersistent);
var
  DestCellItem: TCellItem;
begin
  if Dest is TCellItem then
  begin
    DestCellItem := TCellItem(Dest);
    //with TCellItem(Dest) do
    begin
      DestCellItem.FSizeStyle := Self.FSizeStyle;
      DestCellItem.FValue := Self.FValue;
      DestCellItem.FSize := Self.FSize;
    end;
  end;
end;

procedure TCellItem.SetSizeStyle(Value: TLaSizeStyleEh);
begin
  if Value <> FSizeStyle then
  begin
    FSizeStyle := Value;
    Changed(False);
  end;
end;

procedure TCellItem.SetValue(Value: Double);
begin
  if Value <> FValue then
  begin
    if FSizeStyle = TLaSizeStyleEh.Pixel then
    begin
      FSize := Trunc(Value);
      FValue := FSize;
    end else
      FValue := Value;
    Changed(False);
  end;
end;

{ TCellCollection }

function TCellCollection.GetAttr(Index: Integer): string;
begin
  case Index of
    0: Result := sCellMember;
    1: Result := sCellSizeType;
    2: Result := sCellValue;
  else
    Result := '';
  end;
end;

function TCellCollection.GetAttrCount: Integer;
begin
  Result := 3;
end;

function TCellCollection.GetItem(Index: Integer): TCellItem;
begin
  Result := TCellItem(inherited GetItem(Index));
end;

function TCellCollection.GetItemAttr(Index, ItemIndex: Integer): string;

  function GetSizeStyleString(Index: Integer): string;
  var
    CellItem: TCellItem;
  begin
    CellItem := Items[Index];
    //with Items[Index] do
      case CellItem.SizeStyle of
        TLaSizeStyleEh.Pixel: Result := sCellAbsoluteSize;
        TLaSizeStyleEh.Weight: Result := sCellPercentSize;
        //TSizeStyle.Auto: Result := sCellAutoSize;
      else
        Result := '';
      end;
  end;

  function GetValueString(Index: Integer): string;
  var
    CellItem: TCellItem;
  begin
    CellItem := Items[Index];
    //with Items[Index] do
    if CellItem.SizeStyle = TLaSizeStyleEh.Pixel then
      Result := IntToStr(Trunc(CellItem.Value))
    else if CellItem.SizeStyle = TLaSizeStyleEh.Weight then
      Result := Format('%3.2f%%', [CellItem.Value]) // do not localize
    else Result := sCellAutoSize;
  end;

begin
  case Index of
    1: Result := GetSizeStyleString(ItemIndex);
    2: Result := GetValueString(ItemIndex);
  else
    Result := '';
  end;
end;

function TCellCollection.Owner: TLaGridPanelEh;
begin
  Result := GetOwner as TLaGridPanelEh;
end;

procedure TCellCollection.SetItem(Index: Integer; Value: TCellItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TCellCollection.Update(Item: TCollectionItem);
begin
  inherited;
  if Owner <> nil then
  begin
    //with Owner do
    begin
      Owner.FRecalcCellSizes := True;
      //Invalidate;
      //Realign;
    end;
  end;
end;

procedure TCellCollection.EquallySplitPercentuals;
var
  I: Integer;
  CellItem: TCellItem;
begin
  BeginUpdate;
  try
    for I := 0 to Count - 1 do
    begin
      CellItem := Items[I];
    //  with Items[I] do
      if CellItem.SizeStyle = TLaSizeStyleEh.Weight then
      begin
        CellItem.Size := 0;
        CellItem.Value := 0;
      end;
    end;
  finally
    EndUpdate;
  end;
end;

{ TRowCollection }

constructor TRowCollection.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner, TRowItem);
end;

function TRowCollection.Add: TRowItem;
begin
  Result := TRowItem(inherited Add);
end;

function TRowCollection.GetItemAttr(Index, ItemIndex: Integer): string;
begin
  if Index = 0 then
    Result := Format(sCellRow, [ItemIndex])
  else
    Result := inherited GetItemAttr(Index, ItemIndex);
end;

procedure TRowCollection.Notify(Item: TCollectionItem;
  Action: Classes.TCollectionNotification);
begin
  inherited Notify(Item, Action);
//  if (Action = System.Classes.TCollectionNotification.cnExtracting) and
//     ([csDestroying, csUpdating] * Owner.ComponentState = []) then
//    if not Owner.IsRowEmpty(Item.Index) and not (csReading in Owner.ComponentState) then
//      raise EGridPanelException.Create(sCannotDeleteRow)
//    else
//      Owner.UpdateControlsRow(Item.Index);
end;

function TRowCollection.GetItem(Index: Integer): TRowItem;
begin
  Result := TRowItem(inherited Items[Index]);
end;

procedure TRowCollection.SetItem(Index: Integer; Value: TRowItem);
begin
  inherited Items[Index] := Value;
end;

{ TColumnCollection }

constructor TColumnCollection.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner, TColumnItem);
end;

function TColumnCollection.Add: TColumnItem;
begin
  Result := TColumnItem(inherited Add);
end;

function TColumnCollection.GetItemAttr(Index, ItemIndex: Integer): string;
begin
  if Index = 0 then
    Result := Format(sCellColumn, [ItemIndex])
  else
    Result := inherited GetItemAttr(Index, ItemIndex);
end;

procedure TColumnCollection.Notify(Item: TCollectionItem;
  Action: Classes.TCollectionNotification);
begin
  inherited Notify(Item, Action);
//  if (Action = System.Classes.TCollectionNotification.cnExtracting) and
//     ([csDestroying, csUpdating] * Owner.ComponentState = []) then
//    if not Owner.IsColumnEmpty(Item.Index) and not (csReading in Owner.ComponentState) then
//      raise EGridPanelException.Create(sCannotDeleteColumn)
//    else
//      Owner.UpdateControlsColumn(Item.Index);
end;

function TColumnCollection.GetItem(Index: Integer): TColumnItem;
begin
  Result := TColumnItem(inherited Items[Index]);
end;

procedure TColumnCollection.SetItem(Index: Integer; Value: TColumnItem);
begin
  inherited Items[Index] := Value;
end;

{ TControlCollection }

function TControlCollection.Add: TControlItem;
begin
  Result := TControlItem(inherited Add);
end;

procedure TControlCollection.AddControl(AControl: TLaObjectEh; AColumn, ARow: Integer);

  procedure PlaceInCell(ControlItem: TControlItem);
//  var
//    I, J: Integer;
  begin
    //with ControlItem do
    try
      ControlItem.Control := AControl;
      ControlItem.FRow := ARow;
      ControlItem.FColumn := AColumn;

//      if (ARow = -1) and (AColumn > -1) then
//      begin
//        for I := 0 to Owner.RowCollection.Count - 1 do
//        begin
//          if Controls[AColumn, I] = nil then
//          begin
//            ControlItem.Row := I;
//            ControlItem.Column := AColumn;
//            Exit;
//          end;
//        end;
//        AColumn := -1;
//      end;
//
//      if (AColumn = -1) and (ARow > -1) then
//      begin
//        for I := 0 to Owner.ColumnCollection.Count - 1 do
//        begin
//          if Controls[I, ARow] = nil then
//          begin
//            ControlItem.Column := I;
//            ControlItem.Row := ARow;
//            Exit;
//          end;
//        end;
//        ARow := -1;
//      end;
//
//      if (AColumn > -1) and (ARow > -1) then
//      begin
//        if Controls[AColumn, ARow] = nil then
//        begin
//          ControlItem.Column := AColumn;
//          ControlItem.Row := ARow;
//          Exit;
//        end;
//        AColumn := -1;
//        ARow := -1;
//      end;
//
//      if (ARow = -1) and (AColumn = -1) then
//      begin
//        for J := 0 to Owner.RowCollection.Count - 1 do
//        begin
//          for I := 0 to Owner.ColumnCollection.Count - 1 do
//          begin
//            if Controls[I, J] = nil then
//            begin
//              ControlItem.Row := J;
//              ControlItem.Column := I;
//              Exit;
//            end;
//          end;
//        end;
//      end;

//      if (Row = -1) or (Column = -1) then
//      begin
//        if (Owner <> nil) and (Owner.ExpandStyle <> emFixedSize) then
//        begin
//          if Owner.ExpandStyle = emAddRows then
//            Owner.AutoAddRow
//          else
//            Owner.AutoAddColumn;
//          PlaceInCell(ControlItem);
//        end else
//          raise EGridPanelException.Create(sCannotAddFixedSize);
//       end;
    except
      ControlItem.Control := nil;
      Free;
      raise;
    end;
  end;

begin
//  if (Owner.RowCollection.Count = 0) and (Owner.ExpandStyle = emAddColumns) or
//     (Owner.ColumnCollection.Count = 0) and (Owner.ExpandStyle = emAddRows)
//  then
//    raise EGridPanelException.Create(sCannotAddToEmpty);
  if IndexOf(AControl) < 0 then
    PlaceInCell(Add);
end;

constructor TControlCollection.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner, TControlItem);
end;

function TControlCollection.GetControl(AColumn, ARow: Integer): TLaObjectEh;
var
  ControlItem: TControlItem;
begin
  ControlItem := GetControlItem(AColumn, ARow);
  if ControlItem <> nil then
    Result := ControlItem.Control
  else
    Result := nil;
end;

function TControlCollection.GetControlItem(AColumn, ARow: Integer): TControlItem;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    Result := TControlItem(Items[I]);
    if (ARow >= Result.Row) and (ARow <= Result.Row + Result.RowSpan - 1) and
      (AColumn >= Result.Column) and (AColumn <= Result.Column + Result.ColumnSpan - 1) then
      Exit;
  end;
  Result := nil;
end;

function TControlCollection.GetItem(Index: Integer): TControlItem;
begin
  Result := TControlItem(inherited GetItem(Index));
end;

function TControlCollection.IndexOf(AControl: TLaObjectEh): Integer;
begin
  for Result := 0 to Count - 1 do
    if TControlItem(Items[Result]).Control = AControl then
      Exit;
  Result := -1;
end;

function TControlCollection.Owner: TLaGridPanelEh;
begin
  Result := TLaGridPanelEh(GetOwner);
end;

procedure TControlCollection.RemoveControl(AControl: TLaObjectEh);
var
  I: Integer;
begin
  for I := Count - 1 downto 0 do
    if Items[I].Control = AControl then
    begin
      Items[I].Control := nil;
      Delete(I);
      Exit;
    end;
end;

procedure TControlCollection.SetControl(AColumn, ARow: Integer; Value: TLaObjectEh);
var
  Index: Integer;
  ControlItem: TControlItem;
begin
  if Owner <> nil then
  begin
    if (AColumn < 0) or (AColumn >= Owner.ColumnCollection.Count) then
      raise EGridPanelException.CreateFmt(sInvalidColumnIndex, [AColumn]);
    if (ARow < 0) or (ARow >= Owner.RowCollection.Count) then
      raise EGridPanelException.CreateFmt(sInvalidRowIndex, [ARow]);
    Index := IndexOf(Value);
    if Index > -1 then
    begin
      ControlItem := Items[Index];
      ControlItem.FColumn := AColumn;
      ControlItem.FRow := ARow;
    end else
    begin
      AddControl(Value, AColumn, ARow);
    end;
  end;
end;

procedure TControlCollection.SetItem(Index: Integer; Value: TControlItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TControlCollection.Update(Item: TCollectionItem);
begin
  inherited;
  if Owner <> nil then
  begin
    Owner.FRecalcCellSizes := True;
//    Owner.Invalidate;
//    Owner.Realign;
  end;
end;

{ TControlItem }

procedure TControlItem.AssignTo(Dest: TPersistent);
var
  DestItCtl: TControlItem;
begin
  if Dest is TControlItem then
  begin
    //with TControlItem(Dest) do
    DestItCtl := TControlItem(Dest);
    begin
      DestItCtl.FControl := Self.Control;
      DestItCtl.FRow := Self.Row;
      DestItCtl.FColumn := Self.Column;
      DestItCtl.FRowSpan := Self.RowSpan;
      DestItCtl.FColumnSpan := Self.ColumnSpan;
      DestItCtl.Changed(False);
    end;
  end;
end;

constructor TControlItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FRowSpan := 1;
  FColumnSpan := 1;
  FColumn := -2;
  FRow := -2;
end;

destructor TControlItem.Destroy;
//var
//  LControl: TControl;
begin
//  if Assigned(FControl) and not (csLoading in GridPanel.ComponentState) and
//     not (csUpdating in GridPanel.ComponentState) and
//     not (csDestroying in GridPanel.ComponentState) then
//  begin
//    LControl := FControl;
//    FControl := nil;
//    GridPanel.RemoveControl(LControl);
//    LControl.Free;
//  end;
  inherited Destroy;
end;

function TControlItem.GetGridPanel: TLaGridPanelEh;
var
  Owner: TControlCollection;
begin
  Owner := TControlCollection(GetOwner);
  if Owner <> nil
    then Result := Owner.Owner
    else Result := nil;
end;

procedure TControlItem.SetControl(Value: TLaObjectEh);
begin
  if FControl <> Value then
  begin
//{$IF DEFINED(CLR)}
//    if Assigned(Value) and Value.Equals(GridPanel) then
//{$ELSE}
    if Value = GridPanel then
//{$ENDIF}
      raise EGridPanelException.Create(sInvalidControlItem);
    FControl := Value;
    Changed(False);
  end;
end;

procedure TControlItem.SetColumn(Value: Integer);
begin
  if FColumn <> Value then
  begin
//    if not (csLoading in GridPanel.ComponentState) then
//    begin
//      if (Value < 0)or (Value > GridPanel.ColumnCollection.Count - 1) then
//        raise EGridPanelException.CreateFmt(sInvalidColumnIndex, [Value]);
//      InternalSetLocation(Value, FRow, False, True);
//    end
//    else
//      FColumn := Value;
    InternalSetLocation(Value, FRow, False, True);
  end;
end;

procedure TControlItem.SetRow(Value: Integer);
begin
  if FRow <> Value then
  begin
//    if not (csLoading in GridPanel.ComponentState) then
//    begin
//      if (Value < 0) or (Value > GridPanel.RowCollection.Count - 1) then
//        raise EGridPanelException.CreateFmt(sInvalidRowIndex, [Value]);
//      InternalSetLocation(FColumn, Value, False, True);
//    end
//    else
//      FRow := Value;
    InternalSetLocation(FColumn, Value, False, True);
  end;
end;

type
  TNewLocationRec = record
    ControlItem: TControlItem;
    NewColumn, NewRow: Integer;
    Pushed: Boolean;
  end;
  TNewLocationRecs = array of TNewLocationRec;

  TNewLocations = class
  private
    FNewLocations: TNewLocationRecs;
    FCount: Integer;
  public
    function AddNewLocation(AControlItem: TControlItem; ANewColumn, ANewRow: Integer; APushed: Boolean = False): Integer;
    procedure ApplyNewLocations;
    property Count: Integer read FCount;
    property NewLocations: TNewLocationRecs read FNewLocations;
  end;

function TNewLocations.AddNewLocation(AControlItem: TControlItem; ANewColumn, ANewRow: Integer; APushed: Boolean): Integer;
begin
  if FCount = Length(FNewLocations) then
    SetLength(FNewLocations, Length(FNewLocations) + 10);
  Result := FCount;
  Inc(FCount);
  //with FNewLocations[Result] do
  begin
    FNewLocations[Result].ControlItem := AControlItem;
    FNewLocations[Result].NewColumn := ANewColumn;
    FNewLocations[Result].NewRow := ANewRow;
    FNewLocations[Result].Pushed := APushed;
  end;
end;

procedure TNewLocations.ApplyNewLocations;
var
  I: Integer;
begin
  for I := 0 to FCount - 1 do
  begin
    //with FNewLocations[I] do
      if FNewLocations[I].ControlItem <> nil then
        FNewLocations[I].ControlItem.InternalSetLocation(
          FNewLocations[I].NewColumn,
          FNewLocations[I].NewRow,
          FNewLocations[I].Pushed,
          False);
  end;
end;

procedure TControlItem.SetRowSpan(Value: TCellSpan);
var
  I, Delta: Integer;
  Collection: TControlCollection;
  ControlItem: TControlItem;
  NumToAdd, NumRows, MoveBy: Integer;
//  LColumn, LRow, IndexDelta: Integer;
//  Span: TCellSpan;
  NewLocations: TNewLocations;
begin
  if FRowSpan <> Value then
  begin
    if Value < 1 then
      raise EGridPanelException.CreateFmt(sInvalidSpan, [Value]);
    Collection := TControlCollection(GetOwner);
    if Collection = nil then Exit;
//    GridPanel.DisableAlign;
    try
      NewLocations := TNewLocations.Create;
      try
        if FRowSpan > Value then
        begin
          Delta := FRowSpan - Value;
          FRowSpan := Value;
//          if GridPanel.ExpandStyle in [emAddRows, emFixedSize] then
//          begin
            NumRows := GridPanel.RowCollection.Count;
            // Move the controls below up to fill in the space.
            for I := FRow + FRowSpan + Delta to NumRows - 1 do
            begin
              ControlItem := Collection.ControlItems[FColumn, I];
              if ControlItem <> nil then
                if ControlItem.Pushed then
                  NewLocations.AddNewLocation(ControlItem, FColumn, I - Delta, False)
                else
                  Break;
            end;
            NewLocations.ApplyNewLocations;
            GridPanel.RemoveEmptyAutoAddRows;
//          end else
//          begin
//            // Scan forward in row primary order, removing Delta from position of each
//            // control item, unwrapping where nessesary, until the last control is reached
//            // or a non "pushed" control is found.
//            for I := GridPanel.RowSpanIndex[FColumn, FRow] to GridPanel.CellCount - 1 do
//            begin
//              GridPanel.CellIndexToCell(I, LColumn, LRow);
//              ControlItem := Collection.ControlItems[LColumn, LRow];
//              if ControlItem <> nil then
//              begin
//                if ControlItem.Pushed then
//                begin
//                  if (ControlItem.Column = LColumn) and (ControlItem.Row = LRow) then
//                  begin
//                    GridPanel.CellIndexToCell(I - Delta, LColumn, LRow);
//                    if (LRow > 0) and (LRow + ControlItem.RowSpan > GridPanel.RowCollection.Count) then
//                    begin
//                      Inc(Delta, (LRow + ControlItem.RowSpan) - GridPanel.RowCollection.Count);
//                      GridPanel.CellIndexToCell(I - Delta, LColumn, LRow);
//                    end;
//                    NewLocations.AddNewLocation(ControlItem, LColumn, LRow, False);
//                  end;
//                end else if ControlItem <> Self then
//                  Break
//                else
//                  NewLocations.AddNewLocation(ControlItem, LColumn, LRow, False);
//              end;
//            end;
//            NewLocations.ApplyNewLocations;
//            GridPanel.RemoveEmptyAutoAddRows;
//          end;
        end else
        begin
          NumRows := GridPanel.RowCollection.Count;
          Delta := Value - FRowSpan;
          // first check if there is room down to expand and if so remove those
          // rows from the Delta
          for I := Min(FRow + FRowSpan, NumRows) to Min(FRow + Value - 1, NumRows - 1) do
            if Collection.Controls[FColumn, I] = nil then
              Dec(Delta)
            else
              Break;
          MoveBy := Delta;
          // Now find out how many rows to add, if any
          for I := NumRows - 1 downto NumRows - MoveBy do
            if Collection.Controls[FColumn, I] = nil then
              Dec(Delta)
            else
              Break;
          NumToAdd := Delta;
          // Add the rows
//          if GridPanel.ExpandStyle in [emAddRows, emFixedSize] then
//          begin
            if {(GridPanel.ExpandStyle = emFixedSize) and} (NumToAdd > 0) then
              raise EGridPanelException.Create(sCannotAddFixedSize);
            while NumToAdd > 0 do
            begin
              GridPanel.AutoAddRow;
              Dec(NumToAdd);
            end;
            NumRows := GridPanel.RowCollection.Count;
            for I := NumRows - 1 downto NumRows - Delta do
            begin
              ControlItem := Collection.ControlItems[FColumn, I - MoveBy];
              if (ControlItem <> nil) and (ControlItem <> Self) then
                NewLocations.AddNewLocation(ControlItem, FColumn, I, True);
            end;
            NewLocations.ApplyNewLocations;
//          end
//          else if (NumToAdd + MoveBy) > 0 then
//          begin
//            IndexDelta := Max(NumToAdd, Min(MoveBy, NumRows));
//            for I := GridPanel.RowSpanIndex[FColumn, FRow] to GridPanel.CellCount - 1 do
//            begin
//              GridPanel.CellIndexToCell(I, LColumn, LRow);
//              ControlItem := Collection.ControlItems[LColumn, LRow];
//              if (ControlItem <> nil) and (ControlItem.Column = LColumn) and (ControlItem.Row = LRow) then
//              begin
//                if ControlItem = Self then
//                begin
//                  Span := Value;
//                  LColumn := FColumn;
//                  LRow := FRow;
//                end else
//                begin
//                  Span := ControlItem.RowSpan;
//                  GridPanel.CellIndexToCell(I + IndexDelta, LColumn, LRow);
//                end;
//                if LRow + Span > GridPanel.RowCollection.Count then
//                begin
//                  if LRow > 0 then
//                  begin
//                    Inc(IndexDelta, GridPanel.RowCollection.Count - LRow);
//                    GridPanel.CellIndexToCell(I + IndexDelta - NumToAdd, LColumn, LRow);
//                  end else if ControlItem <> Self then
//                  begin
//                    Inc(IndexDelta, Min(Span, GridPanel.RowCollection.Count));
//                    GridPanel.CellIndexToCell(I + IndexDelta, LColumn, LRow);
//                  end else if (ControlItem = Self) and (LRow = 0) then
//                    Exit;
//                end;
//                NumToAdd := 0;
//                NewLocations.AddNewLocation(ControlItem, LColumn, LRow, True);
//              end;
//            end;
//            for I := 0 to NewLocations.Count - 1 do
//              if NewLocations.NewLocations[I].NewColumn > GridPanel.ColumnCollection.Count - 1 then
//                GridPanel.AutoAddColumn;
//            NewLocations.ApplyNewLocations;
//          end;
          FRowSpan := Value;
        end;
        Changed(False);
      finally
        NewLocations.Free;
      end;
    finally
//      GridPanel.EnableAlign;
    end;
  end;
end;

procedure TControlItem.SetColumnSpan(Value: TCellSpan);
var
  I, Delta: Integer;
  Collection: TControlCollection;
  ControlItem: TControlItem;
  NumToAdd, NumColumns, MoveBy: Integer;
//  LColumn, LRow, IndexDelta: Integer;
//  Span: TCellSpan;
  NewLocations: TNewLocations;
begin
  if FColumnSpan <> Value then
  begin
    if Value < 1 then
      raise EGridPanelException.CreateFmt(sInvalidSpan, [Value]);
    Collection := TControlCollection(GetOwner);
    if Collection = nil then Exit;
//    GridPanel.DisableAlign;
    try
      NewLocations := TNewLocations.Create;
      try
        if FColumnSpan > Value then
        begin
          Delta := FColumnSpan - Value;
          FColumnSpan := Value;
//          if GridPanel.ExpandStyle in [emAddColumns, emFixedSize] then
//          begin
            NumColumns := GridPanel.ColumnCollection.Count;
            // Move the controls to the right back to fill in the space.
            for I := FColumn + FColumnSpan + Delta to NumColumns - 1 do
            begin
              ControlItem := Collection.ControlItems[I, FRow];
              if ControlItem <> nil then
                if ControlItem.Pushed then
                  NewLocations.AddNewLocation(ControlItem, I - Delta, FRow, False)
                else
                  Break;
            end;
            NewLocations.ApplyNewLocations;
            GridPanel.RemoveEmptyAutoAddColumns;
//          end else
//          begin
//            // Scan forward in column primary order, removing Delta from position of each
//            // control item, unwrapping where nessesary, until the last control is reached
//            // or a non "pushed" control is found.
//            for I := GridPanel.ColumnSpanIndex[FColumn, FRow] to GridPanel.CellCount - 1 do
//            begin
//              GridPanel.CellIndexToCell(I, LColumn, LRow);
//              ControlItem := Collection.ControlItems[LColumn, LRow];
//              if ControlItem <> nil then
//              begin
//                if ControlItem.Pushed then
//                begin
//                  if (ControlItem.Column = LColumn) and (ControlItem.Row = LRow) then
//                  begin
//                    GridPanel.CellIndexToCell(I - Delta, LColumn, LRow);
//                    if (LColumn > 0) and (LColumn + ControlItem.ColumnSpan > GridPanel.ColumnCollection.Count) then
//                    begin
//                      Inc(Delta, (LColumn + ControlItem.ColumnSpan) - GridPanel.ColumnCollection.Count);
//                      GridPanel.CellIndexToCell(I - Delta, LColumn, LRow);
//                    end;
//                    NewLocations.AddNewLocation(ControlItem, LColumn, LRow, False);
//                  end;
//                end else if ControlItem <> Self then
//                  Break
//                else
//                  NewLocations.AddNewLocation(ControlItem, LColumn, LRow, False);
//              end;
//            end;
//            NewLocations.ApplyNewLocations;
//            GridPanel.RemoveEmptyAutoAddRows;
//          end;
        end else
        begin
          NumColumns := GridPanel.ColumnCollection.Count;
          Delta := Value - FColumnSpan;
          // first check if there is room to the right to expand and if so remove those
          // columns from the Delta
          for I := Min(FColumn + FColumnSpan, NumColumns) to Min(FColumn + Value - 1, NumColumns - 1) do
            if Collection.Controls[I, FRow] = nil then
              Dec(Delta)
            else
              Break;
          MoveBy := Delta;
          // Now find out how many columns to add, if any
          for I := NumColumns - 1 downto NumColumns - MoveBy do
            if Collection.Controls[I, FRow] = nil then
              Dec(Delta)
            else
              Break;
          NumToAdd := Delta;
          // Add the columns
//          if GridPanel.ExpandStyle in [emAddColumns, emFixedSize] then
//          begin
            if {(GridPanel.ExpandStyle = emFixedSize) and} (NumToAdd > 0) then
              raise EGridPanelException.Create(sCannotAddFixedSize);
            while NumToAdd > 0 do
            begin
              GridPanel.AutoAddColumn;
              Dec(NumToAdd);
            end;
            NumColumns := GridPanel.ColumnCollection.Count;
            for I := NumColumns - 1 downto NumColumns - Delta do
            begin
              ControlItem := Collection.ControlItems[I - MoveBy, FRow];
              if (ControlItem <> nil) and (ControlItem <> Self) then
                NewLocations.AddNewLocation(ControlItem, I, FRow, True);
            end;
            NewLocations.ApplyNewLocations;
//          end
//          else if (NumToAdd + MoveBy) > 0 then
//          begin
//            IndexDelta := Max(NumToAdd, Min(MoveBy, NumColumns));
//            for I := GridPanel.ColumnSpanIndex[FColumn, FRow] to GridPanel.CellCount - 1 do
//            begin
//              GridPanel.CellIndexToCell(I, LColumn, LRow);
//              ControlItem := Collection.ControlItems[LColumn, LRow];
//              if (ControlItem <> nil) and (ControlItem.Column = LColumn) and (ControlItem.Row = LRow) then
//              begin
//                if ControlItem = Self then
//                begin
//                  Span := Value;
//                  LColumn := FColumn;
//                  LRow := FRow;
//                end else
//                begin
//                  Span := ControlItem.ColumnSpan;
//                  GridPanel.CellIndexToCell(I + IndexDelta, LColumn, LRow);
//                end;
//                if LColumn + Span > GridPanel.ColumnCollection.Count then
//                begin
//                  if LColumn > 0 then
//                  begin
//                    Inc(IndexDelta, GridPanel.ColumnCollection.Count - LColumn);
//                    GridPanel.CellIndexToCell(I + IndexDelta - NumToAdd, LColumn, LRow);
//                  end else if ControlItem <> Self then
//                  begin
//                    Inc(IndexDelta, Min(Span, GridPanel.ColumnCollection.Count));
//                    GridPanel.CellIndexToCell(I + IndexDelta, LColumn, LRow);
//                  end else if (ControlItem = Self) and (LColumn = 0) then
//                    Exit;
//                end;
//                NumToAdd := 0;
//                NewLocations.AddNewLocation(ControlItem, LColumn, LRow, True);
//              end;
//            end;
//            for I := 0 to NewLocations.Count - 1 do
//              if NewLocations.NewLocations[I].NewRow > GridPanel.RowCollection.Count - 1 then
//                GridPanel.AutoAddRow;
//            NewLocations.ApplyNewLocations;
//          end;
          FColumnSpan := Value;
        end;
        Changed(False);
      finally
        NewLocations.Free;
      end;
    finally
//      GridPanel.EnableAlign;
    end;
  end;
end;

procedure TControlItem.InternalSetLocation(AColumn, ARow: Integer; APushed, MoveExisting: Boolean);
var
  Collection: TControlCollection;
  CurrentItem: TControlItem;
begin
  if (AColumn <> FColumn) or (ARow <> FRow) then
  begin
    if MoveExisting then
    begin
      Collection := TControlCollection(GetOwner);
      if Collection <> nil then
        CurrentItem := Collection.ControlItems[AColumn, ARow]
      else
        CurrentItem := nil;
      if CurrentItem <> nil then
        CurrentItem.InternalSetLocation(FColumn, FRow, False, False);
    end;
    FColumn := AColumn;
    FRow := ARow;
    if APushed then
      Inc(FPushed)
    else if FPushed > 0 then
      Dec(FPushed);
    Changed(False);
  end;
end;

procedure TControlItem.SetLocation(AColumn, ARow: Integer; APushed: Boolean);
begin
  InternalSetLocation(AColumn, ARow, APushed, True);
end;

function TControlItem.GetPushed: Boolean;
begin
  Result := FPushed > 0;
end;

end.
