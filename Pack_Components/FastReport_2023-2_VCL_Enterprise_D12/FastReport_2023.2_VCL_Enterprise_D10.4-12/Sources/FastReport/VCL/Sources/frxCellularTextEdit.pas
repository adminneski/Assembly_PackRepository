unit frxCellularTextEdit;

{$I frx.inc}

//debug define
//{$DEFINE DEBUGCLR}
//testdefine
{$DEFINE DOUBLEWORK}

interface

uses
{$IFNDEF FPC}
  Windows, WideStrings,
{$ELSE}
  LCLType, LMessages, LazHelper, LCLIntf,
{$ENDIF}
  Classes, Types, SysUtils, Forms, Controls, Messages, StdCtrls, Graphics, Dialogs, 
  frCoreClasses, frUnicodeUtils, frxCellularTextObject, frxTableObject, frxClass, frTypes;

type

  TfrxCellTag = class;

{ Table Helper }

  TfrxCellularTableObject = class(TfrxTableObject)
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function CreateTableRow: TfrxCustomTableRow; override;
  end;

  TfrxCellularTableRow = class(TfrxTableRow)
  public
    function CreateTableCell(Index: Integer; bSetUniqueName: Boolean = False): TObject; override;
  end;

  TfrxCellularTableCell = class(TfrxTableCell)
  protected
    procedure SetIsSelected(const Value: Boolean); override;
    function GetPoint: TPoint;
  public
    frxCelluralTag: TfrxCellTag;

    destructor Destroy; override;
    procedure CreateCellTag(Ln, LinesCount, sTextCount, IDX, I: Integer); override;
  end;

{ Tag Class }
  TfrxCellType = (ctBottom, ctLeft, ctRight, ctString);

  TfrxCellTag = class
  public
    Value: Integer;
    sType: TfrxCellType;
    constructor Create(vsType: TfrxCellType); overload;
    constructor Create(vsType: TfrxCellType; vValue: Integer); overload;
  end;

{ Hack CellView }

  THackfrxCellularText = class(TfrxCellularText)
  public
    //procedure BuildTable(aTable: TfrxTableObject); override;
  end;

{ Cell Editor }

  TfrxCellularTextControl = class(TCustomControl)
  private
    FCellularText: TfrxCellularText;
    FTable: TfrxTableObject;
    FZoom: Extended;
    FSelStart: TPoint;
    FSelEnd: TPoint;
    FIsMouseDown: Boolean;
    FFakeList: TWideStrings;
    FMemo: TMemo;

    procedure SetZoom(zm: Extended);
    procedure SetCellularText(const Value: TfrxCellularText);
    procedure SetSelStart(vSelStart: TPoint);
    procedure SetSelEnd(vSelEnd: TPoint);
    procedure SetModified(const Value: Boolean);
    function GetModified: Boolean;

    procedure MemoSelToSelfSel;
    procedure SelfSelToMemo;

    function ListToFakeToPoint(val: Integer): TPoint;
    function PointToFakeToList(vPoint: TPoint): Integer;

    procedure ClearSelection;
    procedure RebuildTable;
    procedure ValidatePoint(var vPoint: TPoint);

    procedure SendMassageToMemo(var Message: TMessage);
  protected
    procedure WndProc(var Message: TMessage); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;

    property Zoom: Extended read FZoom write SetZoom;
    property CellularText: TfrxCellularText read FCellularText write SetCellularText;
    property Modified: Boolean read GetModified write SetModified;
    property SelStart: TPoint read FSelStart write SetSelStart;
    property SelEnd: TPoint read FSelEnd write SetSelEnd;
    property FakeLines: TWideStrings read FFakeList;

    property OnKeyPress;
    property OnKeyDown;
    property Color;
   {$IFNDEF FPC}
    property Ctl3D;
   {$ENDIF}
  end;

{ Point Helpers }
  function ComparePoint(a, b: TPoint): Boolean;
  procedure CheckBufSwap(var vSelStart, vSelEnd: TPoint);

implementation

{ Table Helper }

{ TfrxCellularTableObject }

constructor TfrxCellularTableObject.Create(AOwner: TComponent);
begin
  inherited;
  FSelectList := TList.Create;
end;

destructor TfrxCellularTableObject.Destroy;
begin
  FreeAndNil(FSelectList);
  inherited;
end;

class function TfrxCellularTableObject.CreateTableRow: TfrxCustomTableRow;
begin
  Result := TfrxCellularTableRow.Create(nil);
end;

{ TfrxCellularTableRow }

function TfrxCellularTableRow.CreateTableCell(Index: Integer; bSetUniqueName: Boolean = False): TObject;
begin
  Result := TfrxCellularTableCell.Create(Self);
  TfrxCellularTableCell(Result).FIndex := Index;
end;

{ TfrxCellTableCell }

procedure TfrxCellularTableCell.SetIsSelected(const Value: Boolean);
var
  t: TfrxCellularTableObject;
  idx: Integer;
begin
  inherited;
  t := ParentTable as TfrxCellularTableObject;
  if Assigned(t) then
  begin
    idx := t.FSelectList.IndexOf(Self);
    if (idx > 0) and not Value then
    begin
      t.FSelectList.Remove(Self);
      FSelectList := nil;
    end
    else if (idx < 0) and Value then
    begin
      t.FSelectList.Add(Self);
      FSelectList := t.FSelectList;
    end;
  end;
end;

function TfrxCellularTableCell.GetPoint: TPoint;
begin
  Result := Point(Self.Index, Self.ParentRow.Index);
end;

destructor TfrxCellularTableCell.Destroy;
begin
  frxCelluralTag.Free;
  inherited;
end;

procedure TfrxCellularTableCell.CreateCellTag(Ln, LinesCount, sTextCount, IDX, I: Integer);
begin
  if (Ln > LinesCount) then
    Self.frxCelluralTag := TfrxCellTag.Create(ctBottom)
  else
  if (sTextCount > IDX - I) and (IDX - I >= 0) then
    Self.frxCelluralTag := TfrxCellTag.Create(ctString, IDX - I)
  else
  if (IDX - I >= 0) then
  begin
    Self.frxCelluralTag := TfrxCellTag.Create(ctRight, IDX - sTextCount - i);
   {$IFDEF DEBUGCLR}
    Self.Color := clRed;
    Self.Text := IntToStr(IDX - sTextCount - i);
   {$ENDIF}
  end
  else
  begin
    Self.frxCelluralTag := TfrxCellTag.Create(ctLeft, IDX - i + 1);
   {$IFDEF DEBUGCLR}
    Self.Color := clGreen;
    Self.Text := IntToStr(IDX - i + 1);
   {$ENDIF}
  end;
end;

{ Tag Class }

constructor TfrxCellTag.Create(vsType: TfrxCellType);
begin
  sType := vsType;
end;

constructor TfrxCellTag.Create(vsType: TfrxCellType; vValue: Integer);
begin
  sType := vsType;
  Value := vValue;
end;

{ TfrxCellularTextControl }

constructor TfrxCellularTextControl.Create(AOwner: TComponent);
begin
  inherited;
  FFakeList := TfrWideStringList.Create;
  FMemo := TMemo.Create(Self);
  FMemo.Parent := Self;
  FMemo.Visible := False;
  FCellularText := TfrxCellularText.Create(nil);
  FTable := TfrxCellularTableObject.Create(nil);
  FZoom := 1;
end;

destructor TfrxCellularTextControl.Destroy;
begin
  FreeAndNil(FCellularText);
  FreeAndNil(FTable);
  FreeAndNil(FMemo);
  FreeAndNil(FFakeList);
  inherited;
end;

procedure TfrxCellularTextControl.SetZoom(zm: Extended);
begin
  FZoom := zm;
end;

procedure TfrxCellularTextControl.SetCellularText(const Value: TfrxCellularText);
begin
  FCellularText.AssignAll(Value);
  RebuildTable;
  FMemo.Text := FCellularText.Text;
  FMemo.SelStart := 0;
  SelStart := Point(0, 0);
end;

procedure TfrxCellularTextControl.SetSelStart(vSelStart: TPoint);
begin
  ValidatePoint(vSelStart);
  FSelStart := vSelStart;
  FSelEnd := vSelStart;
  ClearSelection;
  FTable.Cells[FSelStart.X, FSelStart.Y].IsSelected := True;
  Invalidate;
end;

procedure TfrxCellularTextControl.SetModified(const Value: Boolean);
begin
  FMemo.Modified := Value;
end;

function TfrxCellularTextControl.GetModified: Boolean;
begin
  Result := FMemo.Modified;
end;

procedure TfrxCellularTextControl.MemoSelToSelfSel;
begin
  SelStart := ListToFakeToPoint(FMemo.SelStart);
  if (FMemo.SelLength <> 0) then
    SelEnd := ListToFakeToPoint(FMemo.SelStart + FMemo.SelLength)
  else
    SelEnd := SelStart;
end;

procedure TfrxCellularTextControl.SelfSelToMemo;
begin
  FMemo.SelStart := PointToFakeToList(SelStart);
  FMemo.SelLength := PointToFakeToList(SelEnd) - FMemo.SelStart;
  {$IFDEF DOUBLEWORK}
  MemoSelToSelfSel;
  {$ENDIF}
end;

function TfrxCellularTextControl.ListToFakeToPoint(val: Integer): TPoint;
var
  i, posy, posx, valx, len: Integer;
begin
  posy := 0;
  for i := 0 to FakeLines.Count - 1 do
    if (Integer(FakeLines.Objects[i]) > val) then
    begin
      posy := i;
      break;
    end;

  len := 1;
  if (i <> 0) then
    len := len + Integer(FakeLines.Objects[i - 1]);

  valx := val - len - (Length(FakeLines[posy]) - Length(TrimLeft(FakeLines[posy])));

  posx := -1;
  if (posy >= FTable.RowCount) then
    posx := FTable.ColumnCount - 1
  else
  if (valx >= 0) then
  begin
    for i := 0 to FTable.ColumnCount - 1 do
      if (TfrxCellularTableCell(FTable.Cells[i, posy]).frxCelluralTag.sType = ctString) then
        if (TfrxCellularTableCell(FTable.Cells[i, posy]).frxCelluralTag.Value = valx) then
        begin
          posx := i;
          break;
        end;

    if (posx = -1) then
      for i := FTable.ColumnCount - 1 downto 0  do
        case (TfrxCellularTableCell(FTable.Cells[i, posy]).frxCelluralTag.sType) of
          ctString, ctRight:
          begin
            posx := i;
            break;
          end;
        end;
  end;
  Result := Point(posx, posy);
end;

function TfrxCellularTextControl.PointToFakeToList(vPoint: TPoint): Integer;
begin
  Result := 1;
  if (vPoint.Y > 0) then
    Result := Result + Integer(FakeLines.Objects[vPoint.Y - 1]);
  case (TfrxCellularTableCell(FTable.Cells[vPoint.X, vPoint.Y]).frxCelluralTag.sType) of
    ctString:
      Result := Result + TfrxCellularTableCell(FTable.Cells[vPoint.X, vPoint.Y]).frxCelluralTag.Value
        + Length(FakeLines[vPoint.Y]) - Length(TrimLeft(FakeLines[vPoint.Y]));
    ctRight, ctLeft:
      Result := Integer(FakeLines.Objects[vPoint.Y]) - 1;
  end;
end;

procedure TfrxCellularTextControl.SetSelEnd(vSelEnd: TPoint);
var
  vSelStart: TPoint;
  i, j: Integer;
begin
  ValidatePoint(vSelEnd);
  if ComparePoint(FSelEnd, vSelEnd) then
    Exit;
  FSelEnd := vSelEnd;
  vSelStart:= FSelStart;
  ClearSelection;
  CheckBufSwap(vSelStart, vSelEnd);

  if (vSelStart.Y = vSelEnd.Y) then
  begin
    for j := vSelStart.X to vSelEnd.X do
      FTable.Cells[j, vSelStart.Y].IsSelected := True;
  end
  else
  begin
    for j := vSelStart.X to FTable.ColumnCount - 1 do
      FTable.Cells[j, vSelStart.Y].IsSelected := True;
    for i := vSelStart.Y + 1 to vSelEnd.Y - 1 do
      for j := 0 to FTable.ColumnCount - 1 do
        FTable.Cells[j, i].IsSelected := True;
    for j := 0 to vSelEnd.X do
      FTable.Cells[j, vSelEnd.Y].IsSelected := True;
  end;
  Invalidate;
end;

procedure TfrxCellularTextControl.ClearSelection;
var
  x, y: Integer;
begin
  for x := 0 to FTable.ColumnCount - 1 do
    for y := 0 to FTable.RowCount - 1 do
      FTable.Cells[x, y].IsSelected := False;
end;

procedure TfrxCellularTextControl.RebuildTable;
var
  aCellHeight: Extended;
  sText: WideString;
  ColColumn: Integer;
begin
  FTable.Clear;
  FFakeList.Clear;
  THackfrxCellularText(FCellularText).BuildArray(FTable, aCellHeight, FFakeList, sText, ColColumn);
  THackfrxCellularText(FCellularText).BuildTableFromArray(FTable, aCellHeight, FFakeList, sText, ColColumn);
end;

procedure TfrxCellularTextControl.ValidatePoint(var vPoint: TPoint);
var
  val: Integer;
begin
  if (vPoint.X < 0) then
    vPoint.X := 0;
  if (vPoint.Y < 0) then
    vPoint.Y := 0;

  if (vPoint.Y >= FTable.RowCount) then
    vPoint.Y := FTable.RowCount - 1;
  if (vPoint.X >= FTable.ColumnCount) then
    vPoint.X := FTable.ColumnCount - 1;

  case (TfrxCellularTableCell(FTable.Cells[vPoint.X, vPoint.Y]).frxCelluralTag.sType) of
    ctRight:
    begin
      if (vPoint.X > 0) then
      begin
        val := TfrxCellularTableCell(FTable.Cells[vPoint.X, vPoint.Y]).frxCelluralTag.Value;
        if (val > 0) then
        begin
          vPoint.X := vPoint.X - val;
          ValidatePoint(vPoint);
        end;
      end;
    end;
    ctLeft:
    begin
      if (vPoint.X < FTable.ColumnCount - 1) then
      begin
        val := TfrxCellularTableCell(FTable.Cells[vPoint.X, vPoint.Y]).frxCelluralTag.Value;
        vPoint.X := vPoint.X - val + 1;
        if (vPoint.X >= FTable.ColumnCount - 1) then
          vPoint.X := FTable.ColumnCount - 1;
        ValidatePoint(vPoint);
      end;
    end;
    ctBottom:
    begin
      vPoint.Y := FakeLines.Count - 1;
      if (vPoint.Y < 0) then
        vPoint.Y := 0;
      vPoint.X := Length(FakeLines[vPoint.Y]);
      if (vPoint.X = FTable.ColumnCount) then
        vPoint.X := vPoint.X - 1;
      if not (TfrxCellularTableCell(FTable.Cells[vPoint.X, vPoint.Y]).frxCelluralTag.sType in [ctBottom, ctString]) then
        ValidatePoint(vPoint);
    end;
  end;
end;

procedure TfrxCellularTextControl.SendMassageToMemo(var Message: TMessage);
begin
  FMemo.Dispatch(Message);
  FCellularText.Text := FMemo.Text;
  RebuildTable;
  MemoSelToSelfSel;
  Invalidate;
end;

procedure TfrxCellularTextControl.WndProc(var Message: TMessage);
//https://docs.microsoft.com/en-us/windows/win32/inputdev/keyboard-input-notifications
//https://docs.microsoft.com/ru-ru/windows/win32/dlgbox/wm-getdlgcode
begin
  inherited;
  if (Message.Msg = WM_ACTIVATE) or (Message.Msg = WM_CHAR) or
     (Message.Msg = WM_KEYDOWN) or (Message.Msg = WM_KEYUP) or
     (Message.Msg = WM_KILLFOCUS) or (Message.Msg = WM_SETFOCUS) or
     (Message.Msg = WM_SYSKEYDOWN) or (Message.Msg = WM_SYSKEYUP) or
     (Message.Msg = WM_GetDlgCode) then
       SendMassageToMemo(Message);
end;

procedure TfrxCellularTextControl.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  c: TfrxComponent;
begin
  inherited;
  FIsMouseDown := True;
  ClearSelection;
  c := FTable.GetContainedComponent(X / FZoom, Y / FZoom);
  if c is TfrxCellularTableCell then
    SelStart := TfrxCellularTableCell(c).GetPoint;
end;

procedure TfrxCellularTextControl.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  c: TfrxComponent;
begin
  inherited;
  if FIsMouseDown then
  begin
    c := FTable.GetContainedComponent(X / FZoom, Y / FZoom);
    if c is TfrxCellularTableCell then
      SelEnd := TfrxCellularTableCell(c).GetPoint;
  end;
end;

procedure TfrxCellularTextControl.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  FIsMouseDown := False;
  SelfSelToMemo;
end;

procedure TfrxCellularTextControl.Paint;
begin
  inherited;
  FTable.Draw(Canvas, FZoom, FZoom, 0, 0);
end;

{ Point Helpers }

function ComparePoint(a, b: TPoint): Boolean;
begin
  Result := (a.X = b.X) and (a.Y = b.Y);
end;

procedure CheckBufSwap(var vSelStart, vSelEnd: TPoint);
var
  buf: TPoint;
begin
  if (vSelStart.Y > vSelEnd.Y) or ((vSelStart.Y = vSelEnd.Y) and (vSelStart.X > vSelEnd.X)) then
  begin
    buf := vSelStart;
    vSelStart := vSelEnd;
    vSelEnd := buf;
  end;
end;

end.

