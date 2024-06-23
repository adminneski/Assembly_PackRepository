{*******************************************************}
{                                                       }
{         Delphi VCL Extensions (RX)                    }
{                                                       }
{         Copyright (c) 1995, 1996 AO ROSNO             }
{         Copyright (c) 1997, 1998 Master-Bank          }
{                                                       }
{*******************************************************}

unit RXDBCtrl;

{$I RX.INC}
{$R-}

interface

uses
  Windows, Registry, SysUtils,
  Messages, Classes, Controls, Forms, Grids, Graphics, Buttons, Menus,
  StdCtrls, Mask, IniFiles, rxToolEdit, DB,
  {$IFNDEF RX_D3} DBTables, {$ENDIF} rxDateUtil, DBCtrls;

type

{$IFDEF RX_D12}
  TBookmarkType = TBookmark;
{$ELSE}
  TBookmarkType = TBookmarkStr;
{$ENDIF}

{ TRxDBComboEdit }

  TRxDBComboEdit = class(TCustomComboEdit)
  private
    FDataLink: TFieldDataLink;
{$IFDEF WIN32}
    FCanvas: TControlCanvas;
{$ENDIF}
    FFocused: Boolean;
    procedure DataChange(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetFocused(Value: Boolean);
    procedure SetReadOnly(Value: Boolean);
    procedure UpdateData(Sender: TObject);
    procedure WMCut(var Message: TMessage); message WM_CUT;
    procedure WMPaste(var Message: TMessage); message WM_PASTE;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
{$IFDEF WIN32}
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
{$ENDIF}
  protected
    procedure Change; override;
    function EditCanModify: Boolean; override;
    function GetReadOnly: Boolean; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure Reset; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
{$IFDEF RX_D4}
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
{$ENDIF}
    property Button;
    property Field: TField read GetField;
  published
    property Align;
    property AutoSelect;
    property BorderStyle;
    property ButtonHint;
    property CharCase;
    property ClickKey;
    property Color;
    property Ctl3D;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DirectInput;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property GlyphKind;
    property Glyph;
    property ButtonWidth;
    property HideSelection;
{$IFDEF RX_D4}
    property Anchors;
    property BiDiMode;
    property Constraints;
    property DragKind;
    property ParentBiDiMode;
{$ENDIF}
{$IFDEF WIN32}
  {$IFNDEF VER90}
    property ImeMode;
    property ImeName;
  {$ENDIF}
{$ENDIF}
    property MaxLength;
    property NumGlyphs;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnButtonClick;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
{$IFDEF WIN32}
    property OnStartDrag;
{$ENDIF}
{$IFDEF RX_D5}
    property OnContextPopup;
{$ENDIF}
{$IFDEF RX_D4}
    property OnEndDock;
    property OnStartDock;
{$ENDIF}
  end;

{ TDBDateEdit }

  TDBDateEdit = class(TCustomDateEdit)
  private
    FInReset: Boolean;
    FDataLink: TFieldDataLink;
{$IFDEF WIN32}
    FCanvas: TControlCanvas;
{$ENDIF}
    procedure DataChange(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetReadOnly(Value: Boolean);
    procedure UpdateData(Sender: TObject);
    procedure AfterPopup(Sender: TObject; var Date: TDateTime; var Action: Boolean);
    procedure WMCut(var Message: TMessage); message WM_CUT;
    procedure WMPaste(var Message: TMessage); message WM_PASTE;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
{$IFDEF WIN32}
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
{$ENDIF}
  protected
{$IFDEF WIN32}
    procedure AcceptValue(const Value: Variant); override;
{$ENDIF}
    procedure ApplyDate(Value: TDateTime); override;
    function GetReadOnly: Boolean; override;
    procedure Change; override;
    function EditCanModify: Boolean; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Reset; override;

   procedure SetDate(Value: TDateTime); override;
   function IsValidDate(Value: TDateTime): Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure UpdateMask; override;
{$IFDEF RX_D4}
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
{$ENDIF}
    property Field: TField read GetField;
  published
    property Align;

    property AutoSelect;
    property BorderStyle;
    property ButtonHint;
    property CharCase;
    property ClickKey;
    property Color;
    property Ctl3D;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DirectInput;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property GlyphKind;
    property Glyph;
    property ButtonWidth;
    property HideSelection;
{$IFDEF RX_D4}
    property Anchors;
    property BiDiMode;
    property Constraints;
    property DragKind;
    property ParentBiDiMode;
{$ENDIF}
{$IFDEF WIN32}
  {$IFNDEF VER90}
    property ImeMode;
    property ImeName;
  {$ENDIF}
{$ENDIF}
    property MaxLength;
    property NumGlyphs;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnButtonClick;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
{$IFDEF WIN32}
    property OnStartDrag;
{$ENDIF}
{$IFDEF RX_D5}
    property OnContextPopup;
{$ENDIF}
{$IFDEF RX_D4}
    property OnEndDock;
    property OnStartDock;
{$ENDIF}
  end;

implementation

uses RxResConst {$IFDEF RX_D6} ,Variants {$ENDIF};

{$R *.RES}


{ TRxDBComboEdit }

procedure ResetMaxLength(DBEdit: TRxDBComboEdit);
var
  F: TField;
begin
  with DBEdit do
    if (MaxLength > 0) and (DataSource <> nil) and
      (DataSource.DataSet <> nil) then
    begin
      F := DataSource.DataSet.FindField(DataField);
      if Assigned(F) and (F.DataType = ftString) and
        (F.Size = MaxLength) then MaxLength := 0;
    end;
end;

constructor TRxDBComboEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF WIN32}
  ControlStyle := ControlStyle + [csReplicatable];
{$ENDIF}
  inherited ReadOnly := True;
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData := UpdateData;
  AlwaysEnable := True;
end;

destructor TRxDBComboEdit.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
{$IFDEF WIN32}
  FCanvas.Free;
{$ENDIF}
  inherited Destroy;
end;

procedure TRxDBComboEdit.Loaded;
begin
  inherited Loaded;
  ResetMaxLength(Self);
  if (csDesigning in ComponentState) then DataChange(Self);
end;

procedure TRxDBComboEdit.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

procedure TRxDBComboEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if (Key = VK_DELETE) or ((Key = VK_INSERT) and (ssShift in Shift)) then
    FDataLink.Edit;
end;

procedure TRxDBComboEdit.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  if (Key >= #32) and (FDataLink.Field <> nil) and
    not FDataLink.Field.IsValidChar(Key) then
  begin
    MessageBeep(0);
    Key := #0;
  end;
  case Key of
    ^H, ^V, ^X, #32..High(Char):
      if not FDataLink.Edit then
        Key := #0;
    #27:
      begin
        FDataLink.Reset;
        SelectAll;
        Key := #0;
      end;
  end;
end;

function TRxDBComboEdit.EditCanModify: Boolean;
begin
  Result := FDataLink.Edit;
end;

procedure TRxDBComboEdit.Reset;
begin
  FDataLink.Reset;
  SelectAll;
end;

procedure TRxDBComboEdit.SetFocused(Value: Boolean);
begin
  if FFocused <> Value then begin
    FFocused := Value;
    if (Alignment <> taLeftJustify) and not IsMasked then Invalidate;
    FDataLink.Reset;
  end;
end;

procedure TRxDBComboEdit.Change;
begin
  FDataLink.Modified;
  inherited Change;
end;

function TRxDBComboEdit.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TRxDBComboEdit.SetDataSource(Value: TDataSource);
begin
{$IFDEF RX_D4}
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
{$ENDIF}
    FDataLink.DataSource := Value;
{$IFDEF WIN32}
  if Value <> nil then Value.FreeNotification(Self);
{$ENDIF}
end;

function TRxDBComboEdit.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

procedure TRxDBComboEdit.SetDataField(const Value: string);
begin
  if not (csDesigning in ComponentState) then ResetMaxLength(Self);
  FDataLink.FieldName := Value;
end;

function TRxDBComboEdit.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TRxDBComboEdit.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

function TRxDBComboEdit.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TRxDBComboEdit.DataChange(Sender: TObject);
begin
  if FDataLink.Field <> nil then
  begin
    if Alignment <> FDataLink.Field.Alignment then
    begin
      EditText := '';  {forces update}
      Alignment := FDataLink.Field.Alignment;
    end;
    EditMask := FDataLink.Field.EditMask;
    if not (csDesigning in ComponentState) then
    begin
      if (FDataLink.Field.DataType in [ftString, ftWideString]) and (MaxLength = 0) then
        MaxLength := FDataLink.Field.Size;
    end;
    if FFocused and FDataLink.CanModify then
      Text := FDataLink.Field.Text
    else
    begin
      EditText := FDataLink.Field.DisplayText;
      if FDataLink.Editing then
         Modified := True;
    end;
  end else
  begin
    Alignment := taLeftJustify;
    EditMask := '';
    if csDesigning in ComponentState then
      EditText := Name else
      EditText := '';
  end;
end;

procedure TRxDBComboEdit.EditingChange(Sender: TObject);
begin
  inherited ReadOnly := not FDataLink.Editing;
end;

procedure TRxDBComboEdit.UpdateData(Sender: TObject);
begin
  ValidateEdit;
  FDataLink.Field.Text := Text;
end;

procedure TRxDBComboEdit.WMPaste(var Message: TMessage);
begin
  if FDataLink.Edit then
  inherited;
end;

procedure TRxDBComboEdit.WMCut(var Message: TMessage);
begin
  if FDataLink.Edit then
  inherited;
end;

procedure TRxDBComboEdit.CMEnter(var Message: TCMEnter);
begin
  SetFocused(True);
  inherited;
  if FDataLink.CanModify then
    inherited ReadOnly := False;
end;

procedure TRxDBComboEdit.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SelectAll;
    if CanFocus then SetFocus;
    raise;
  end;
  SetFocused(False);
  CheckCursor;
  DoExit;
end;

{$IFDEF WIN32}
procedure TRxDBComboEdit.WMPaint(var Message: TWMPaint);
var
  S: string;
begin
  if (csPaintCopy in ControlState) and (FDataLink.Field <> nil) then
  begin
    S := FDataLink.Field.DisplayText;
    case CharCase of
      ecUpperCase: S := AnsiUpperCase(S);
      ecLowerCase: S := AnsiLowerCase(S);
    end;
  end
  else S := EditText;
  if not PaintComboEdit(Self, S, Alignment, True, FCanvas, Message) then
    inherited;
end;

procedure TRxDBComboEdit.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;
{$ENDIF}

{$IFDEF RX_D4}
function TRxDBComboEdit.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;

function TRxDBComboEdit.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TRxDBComboEdit.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;
{$ENDIF}

{ TDBDateEdit }

constructor TDBDateEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF WIN32}
  ControlStyle := ControlStyle + [csReplicatable];
{$ENDIF}
  inherited ReadOnly := True;
    FInReset := False;
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData := UpdateData;
  Self.OnAcceptDate := AfterPopup;
  AlwaysEnable := True;
  UpdateMask;
end;

destructor TDBDateEdit.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
{$IFDEF WIN32}
  FCanvas.Free;
{$ENDIF}
  inherited Destroy;
end;

procedure TDBDateEdit.AfterPopup(Sender: TObject; var Date: TDateTime;
  var Action: Boolean);
begin
  Action := Action and (DataSource <> nil) and (DataSource.DataSet <> nil) and
    DataSource.DataSet.CanModify;
  if Action then Action := EditCanModify;
end;

procedure TDBDateEdit.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

procedure TDBDateEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if not ReadOnly and ((Key = VK_DELETE) or ((Key = VK_INSERT)
    and (ssShift in Shift))) then
      FDataLink.Edit;
end;

procedure TDBDateEdit.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  if CharInSet(Key, [#32..#255]) and (FDataLink.Field <> nil) and
    not CharInSet(Key, ['0'..'9']) and (Key <> {$IFDEF RX_D15}FormatSettings.{$ENDIF}DateSeparator) then
  begin
    Beep;
    Key := #0;
  end;

  case Key of
    ^H, ^V, ^X, '0'..'9':
      if not FDataLink.Edit then
        Key := #0;
    #27:
      begin
        Reset;
        Key := #0;
      end;
  end;
end;

function TDBDateEdit.EditCanModify: Boolean;
begin
  Result := FDataLink.Edit;
end;

procedure TDBDateEdit.Reset;
begin
  FInReset := True;
  FDataLink.Reset;
  SelectAll;
  FInReset := False;
end;

function TDBDateEdit.IsValidDate(Value: TDateTime): Boolean;
begin
  Result := FDateAutoBetween;
  if not Result then
    if (not FInReset) and FDataLink.Editing then try
      if (Value <> NullDate) then begin
        if ((MinDate <> NullDate) and (MaxDate <> NullDate) and
           ((Value < MinDate) or (Value > MaxDate)))
        then raise Exception.CreateFmt(LoadStr(SDateOutOfRange),[FormatDateTime(GetDateFormat, Value),FormatDateTime(GetDateFormat, MinDate), FormatDateTime(GetDateFormat, MaxDate)])
        else if ((MinDate <> NullDate) and (Value < MinDate))
          then  raise Exception.CreateFmt(LoadStr(SDateOutOfMin),[FormatDateTime(GetDateFormat, Value),FormatDateTime(GetDateFormat,MinDate)])
          else if ((MaxDate <> NullDate) and (Value > MaxDate))
            then  raise Exception.CreateFmt(LoadStr(SDateOutOfMax),[FormatDateTime(GetDateFormat, Value),FormatDateTime(GetDateFormat,MaxDate)]);
      end;
      Result := True;
    except
      Reset;
      raise;
    end;
end;

procedure TDBDateEdit.SetDate(Value: TDateTime);
begin
  IsValidDate(Value);
  inherited SetDate(Value);
end;

procedure TDBDateEdit.Change;
begin
  if not Formatting then FDataLink.Modified;
  inherited Change;
end;

function TDBDateEdit.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TDBDateEdit.SetDataSource(Value: TDataSource);
begin
{$IFDEF RX_D4}
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
{$ENDIF}
    FDataLink.DataSource := Value;
{$IFDEF WIN32}
  if Value <> nil then Value.FreeNotification(Self);
{$ENDIF}
end;

function TDBDateEdit.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

procedure TDBDateEdit.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

function TDBDateEdit.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TDBDateEdit.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

function TDBDateEdit.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TDBDateEdit.UpdateMask;
begin
  UpdateFormat;
  UpdatePopup;
  DataChange(nil);
end;

procedure TDBDateEdit.DataChange(Sender: TObject);
begin
  if FDataLink.Field <> nil then
  begin
    if Alignment <> FDataLink.Field.Alignment then
    begin
      EditText := '';  {forces update}
      Alignment := FDataLink.Field.Alignment;
    end;
    EditMask := GetDateMask;
    inherited SetDate(FDataLink.Field.AsDateTime);
  end
  else
  begin
    if csDesigning in ComponentState then
    begin
      EditMask := '';
      EditText := Name;
    end
    else
    begin
      EditMask := GetDateMask;
      if DefaultToday then
         Date := SysUtils.Date
      else
         Date := NullDate;
    end;
  end;
end;

procedure TDBDateEdit.EditingChange(Sender: TObject);
begin
  inherited ReadOnly := not FDataLink.Editing;
  if FDataLink.Editing and DefaultToday and (FDataLink.Field <> nil) and
    (FDataLink.Field.AsDateTime = NullDate) then
    FDataLink.Field.AsDateTime := SysUtils.Now;
end;

procedure TDBDateEdit.UpdateData(Sender: TObject);
var
  D: TDateTime;
begin
  ValidateEdit;
  D := Self.Date;
  if D <> NullDate then begin
    if Int(FDataLink.Field.AsDateTime) <> D then
      FDataLink.Field.AsDateTime := D + Frac(FDataLink.Field.AsDateTime)
  end
  else FDataLink.Field.Clear;
end;

{$IFDEF WIN32}
procedure TDBDateEdit.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

procedure TDBDateEdit.WMPaint(var Message: TWMPaint);
var
  S: string;
  Separator: string;
begin
  if (csPaintCopy in ControlState) and (FDataLink.Field <> nil) then begin
    if FDataLink.Field.IsNull then begin
      S := GetDateFormat;
      Separator := {$IFDEF RX_D15}FormatSettings.{$ENDIF}DateSeparator;
      S := StringReplace(StringReplace(StringReplace(StringReplace(S, '/', {$IFDEF RX_D15}FormatSettings.{$ENDIF}DateSeparator, [rfReplaceAll]),
        'Y', ' ', [rfReplaceAll]), 'M', ' ', [rfReplaceAll]), 'D', ' ', [rfReplaceAll]);
    end
    else
      S := FormatDateTime(GetDateFormat, FDataLink.Field.AsDateTime);
  end else S := EditText;
  if not PaintComboEdit(Self, S, Alignment, True, FCanvas, Message) then
    inherited;
end;

procedure TDBDateEdit.AcceptValue(const Value: Variant);
begin
  if VarIsNull(Value) or VarIsEmpty(Value) then FDataLink.Field.Clear
  else FDataLink.Field.AsDateTime :=
    VarToDateTime(Value) + Frac(FDataLink.Field.AsDateTime);
  DoChange;
end;
{$ENDIF}

procedure TDBDateEdit.ApplyDate(Value: TDateTime);
begin
  {Codigo modificado Jeickson para quando digitar T nao entrar em edição quando autoedit false}
  if FDataLink.DataSet.State in [dsInsert, dsEdit] then
  begin
    FDataLink.Edit;
    inherited ApplyDate(Value);
  end
  else
  if FDataLink.DataSource.AutoEdit = true then
  begin
    FDataLink.Edit;
    inherited ApplyDate(Value);
  end;

{Codigo Original}
//  FDataLink.Edit;
//  inherited ApplyDate(Value);
end;

procedure TDBDateEdit.WMPaste(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TDBDateEdit.WMCut(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TDBDateEdit.CMEnter(var Message: TCMEnter);
begin
  inherited;
end;

procedure TDBDateEdit.CMExit(var Message: TCMExit);
begin
  try
    if not (csDesigning in ComponentState) and CheckOnExit then
      CheckValidDate;
    FDataLink.UpdateRecord;
  except
    SelectAll;
    if CanFocus then SetFocus;
    raise;
  end;
  CheckCursor;
  DoExit;
end;

{$IFDEF RX_D4}
function TDBDateEdit.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;

function TDBDateEdit.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TDBDateEdit.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;
{$ENDIF}

end.

