unit Gobt_DBCheckBoxStr;

interface

uses
   Windows, SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
   Variants, Forms, Dialogs, StdCtrls, ExtCtrls, DB, DBGrids, Grids, Mask,
   Buttons, DBCtrls, Spin, TypInfo;

type
   // Componente GoDBCheckStr.
   TGoDBCheckStr = class(TCustomCheckBox)
   private
      FDataLink: TFieldDataLink;
      FValueCheck: string;
      FValueUncheck: string;
      FPaintControl: TPaintControl;
      FPosition: Integer;
      procedure DataChange(Sender: TObject);
      function GetDataField: string;
      function GetDataSource: TDataSource;
      function GetField: TField;
      function GetFieldState: TCheckBoxState;
      function GetReadOnly: Boolean;
      procedure SetDataField(const Value: string);
      procedure SetDataSource(Value: TDataSource);
      procedure SetReadOnly(Value: Boolean);
      procedure SetValueCheck(const Value: string);
      procedure SetValueUncheck(const Value: string);
      procedure SetPosition(Value: Integer);
      procedure UpdateData(Sender: TObject);
      function ValueMatch(const ValueList, Value: string): Boolean;
      procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
      procedure CMExit(var Message: TCMExit); message CM_EXIT;
      procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
   protected
      procedure Toggle; override;
      procedure KeyPress(var Key: Char); override;
      procedure Notification(AComponent: TComponent; Operation: TOperation); override;
      //    procedure WndProc(var Message: TMessage); override;
      function TrocaTxtPos(Text, Troca: string; Posicao: Integer): string;
   public
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      property Checked;
      property Field: TField read GetField;
      property State;
   published
      property Align;
      property Alignment;
      property AllowGrayed;
      property Caption;
      property Color;
      property Ctl3D;
      property DataField: string read GetDataField write SetDataField;
      property DataSource: TDataSource read GetDataSource write SetDataSource;
      property DragCursor;
      property DragMode;
      property Enabled;
      property Font;
      property ParentColor;
      property ParentCtl3D;
      property ParentFont;
      property ParentShowHint;
      property PopupMenu;
      property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
      property ShowHint;
      property TabOrder;
      property TabStop;
      property ValueChecked: string read FValueCheck write SetValueCheck;
      property ValueUnchecked: string read FValueUncheck write SetValueUncheck;
      property Visible;
      property Position: Integer read FPosition write SetPosition;
      property OnClick;
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
      property OnStartDrag;
   end;

implementation
// TGoDBCheckStr
constructor TGoDBCheckStr.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   ControlStyle := ControlStyle + [csReplicatable];
   State := cbUnchecked;
   Fposition := 0;
   FValueCheck := 'S'; // STextTrue;
   FValueUncheck := 'N'; // STextFalse;
   FDataLink := TFieldDataLink.Create;
   FDataLink.Control := Self;
   FDataLink.OnDataChange := DataChange;
   FDataLink.OnUpdateData := UpdateData;
   FPaintControl := TPaintControl.Create(Self, 'BUTTON');
   FPaintControl.Ctl3DButton := True;
end;

destructor TGoDBCheckStr.Destroy;
begin
   FPaintControl.Free;
   FDataLink.Free;
   FDataLink := nil;
   inherited Destroy;
end;

procedure TGoDBCheckStr.Notification(AComponent: TComponent;
   Operation: TOperation);
begin
   inherited Notification(AComponent, Operation);
   if (Operation = opRemove) and (FDataLink <> nil) and
      (AComponent = DataSource) then DataSource := nil;
end;

function TGoDBCheckStr.GetFieldState: TCheckBoxState;
var
   Text: string;
begin
   if FDatalink.Field <> nil then
   begin
      if FDataLink.Field.IsNull then
         Result := cbGrayed
      else if FDataLink.Field.DataType = ftBoolean then
      begin
         if FDataLink.Field.AsBoolean then
            Result := cbChecked
         else
            Result := cbUnchecked;
      end
      else
      begin
         Result := cbGrayed;
         if FPosition > 0 then
         begin
            if Copy(FDataLink.Field.Text, FPosition, 1) = 'S' then
               Result := cbChecked
            else
               Result := cbUnchecked;
         end
         else
         begin
            Text := FDataLink.Field.Text;
            if ValueMatch(FValueCheck, Text) then
               Result := cbChecked
            else if ValueMatch(FValueUncheck, Text) then
               Result := cbUnchecked;
         end;
      end;
   end
   else
      Result := cbUnchecked;
end;

procedure TGoDBCheckStr.DataChange(Sender: TObject);
begin
   State := GetFieldState;
end;

procedure TGoDBCheckStr.UpdateData(Sender: TObject);
var
   S: string;
begin
   if State = cbGrayed then
      FDataLink.Field.Clear
   else if FDataLink.Field.DataType = ftBoolean then
      FDataLink.Field.AsBoolean := Checked
   else
   begin
      if Checked then
         S := FValueCheck
      else
         S := FValueUncheck;
      //
      if FPosition > 0 then
         FDataLink.Field.Text := TrocaTxtPos(FDataLink.Field.Text, S, FPosition)
      else
         FDataLink.Field.Text := ExtractFieldName(S, FPosition);
   end;
end;

function TGoDBCheckStr.ValueMatch(const ValueList, Value: string): Boolean;
begin
   Result := False;
   while FPosition <= Length(ValueList) do
      if AnsiCompareText(ExtractFieldName(ValueList, FPosition), Value) = 0 then
      begin
         Result := True;
         Break;
      end;
end;

procedure TGoDBCheckStr.Toggle;
begin
   if FDataLink.Edit then
   begin
      inherited Toggle;
      FDataLink.Modified;
   end;
end;

function TGoDBCheckStr.GetDataSource: TDataSource;
begin
   Result := FDataLink.DataSource;
end;

procedure TGoDBCheckStr.SetDataSource(Value: TDataSource);
begin
   FDataLink.DataSource := Value;
   if Value <> nil then
      Value.FreeNotification(Self);
end;

function TGoDBCheckStr.GetDataField: string;
begin
   Result := FDataLink.FieldName;
end;

procedure TGoDBCheckStr.SetDataField(const Value: string);
begin
   FDataLink.FieldName := Value;
end;

function TGoDBCheckStr.GetReadOnly: Boolean;
begin
   Result := FDataLink.ReadOnly;
end;

procedure TGoDBCheckStr.SetReadOnly(Value: Boolean);
begin
   FDataLink.ReadOnly := Value;
end;

function TGoDBCheckStr.GetField: TField;
begin
   Result := FDataLink.Field;
end;

procedure TGoDBCheckStr.KeyPress(var Key: Char);
begin
   inherited KeyPress(Key);
   case Key of
      #8, ' ':
         FDataLink.Edit;
      #27:
         FDataLink.Reset;
   end;
end;

procedure TGoDBCheckStr.SetValueCheck(const Value: string);
begin
   FValueCheck := Value;
   DataChange(Self);
end;

procedure TGoDBCheckStr.SetValueUncheck(const Value: string);
begin
   FValueUncheck := Value;
   DataChange(Self);
end;
{
procedure TGoDBCheckStr.WndProc(var Message: TMessage);
begin
  with Message do
    if (Msg = WM_CREATE) or (Msg = WM_WINDOWPOSCHANGED) or
      (Msg = CM_TEXTCHANGED) or (Msg = CM_FONTCHANGED) then
      FPaintControl.DestroyHandle;
  //
  if Focused then
     Color := clWhite
  else
     Color := clBtnFace;
  inherited;
end;
}

procedure TGoDBCheckStr.WMPaint(var Message: TWMPaint);
begin
   if not (csPaintCopy in ControlState) then
      inherited
   else
   begin
      SendMessage(FPaintControl.Handle, BM_SETCHECK, Ord(GetFieldState), 0);
      SendMessage(FPaintControl.Handle, WM_PAINT, Message.DC, 0);
   end;
end;

procedure TGoDBCheckStr.CMExit(var Message: TCMExit);
begin
   try
      FDataLink.UpdateRecord;
   except
      SetFocus;
      raise;
   end;
   inherited;
end;

procedure TGoDBCheckStr.CMGetDataLink(var Message: TMessage);
begin
   Message.Result := Integer(FDataLink);
end;

procedure TGoDBCheckStr.SetPosition(Value: Integer);
begin
   FPosition := Value;
end;

function TGoDBCheckStr.TrocaTxtPos(Text, Troca: string; Posicao: Integer): string;
var
   axI: Integer;
begin
   if Length(Text) < Position then
      for axI := 1 to Position - Length(Text) do
         Text := Text + ' ';
   //
   Delete(Text, Posicao, Length(Troca));
   Insert(Troca, Text, Posicao);
   Result := Text;
end;

end.

