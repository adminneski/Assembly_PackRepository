unit Gobt_DBToggleSwitch;

interface
  uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls,ComCtrls, ShlObj, ActiveX, Vcl.DBCtrls, Data.DB, Vcl.WinXCtrls,
  StrUtils;
type

 TGoDBToggleSwitch = class(TCustomToggleSwitch)
   private
      { Private declarations }
      FFieldDataLink: TFieldDataLink;
      function GetDataField: string;
      function GetDataSource: TDataSource;
      procedure SetDataSource(Value: TDataSource);
      procedure SetDataField(const Value: string);

      procedure SetReadOnly(Value: Boolean);
      function GetReadOnly: Boolean;

      procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
      procedure CMExit(var Message: TWMNoParams); message CM_EXIT;
   protected
      { Protected declarations }
      procedure DataChange(Sender: TObject);
      procedure ChangeState; override;


   public
      { Public declarations }
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
   published
      { Published declarations }
      property DataField: string read GetDataField write SetDataField;
      property DataSource: TDataSource read GetDataSource write SetDataSource;
      // Inherited Properties & Events
      property Action;
      property Align;
      property Alignment;
      property Anchors;
      property AutoSize;
      property BiDiMode;
      property Color;
      property Constraints;
      property DisabledColor;
      property DoubleBuffered;
      property DragCursor;
      property DragKind;
      property DragMode;
      property Enabled;
      property Font;
      property FrameColor;
      property Height;
      property HelpContext;
      property Hint;
      property ParentBiDiMode;
      property ParentColor;
      property ParentCtl3D;
      property ParentDoubleBuffered;
      property ParentFont;
      property ParentShowHint;
      property PopupMenu;
      //property ReadOnly;
      property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
      property ShowHint;
      property ShowStateCaption;
      property State;
      property StateCaptions;
      property StyleElements;
      property SwitchHeight;
      property SwitchWidth;
      property TabOrder;
      property TabStop;
      property ThumbColor;
      property ThumbWidth;
      property Visible;
      property Width;

      property OnClick;
      property OnContextPopup;
      property OnDragDrop;
      property OnDragOver;
      property OnEndDock;
      property OnEndDrag;
      property OnEnter;
      property OnExit;
      property OnKeyDown;
      property OnKeyPress;
      property OnKeyUp;
      property OnMouseActivate;
      property OnMouseDown;
      property OnMouseEnter;
      property OnMouseLeave;
      property OnMouseMove;
      property OnMouseUp;
      property OnStartDock;
      property OnStartDrag;
   end;


implementation


{ TGobt_DBToggleSwitch }



procedure TGoDBToggleSwitch.ChangeState;
begin
  //
  if FFieldDataLink.DataSource.AutoEdit then
   FFieldDataLink.DataSource.Edit
  else
   FFieldDataLink.ReadOnly := true;
  //
  if not (FFieldDataLink.DataSet.State in [dsEdit,dsInsert])then
    Exit;
  //
  inherited;
  if FFieldDataLink.DataSet.State in [dsInsert,dsEdit] then
  begin
    case State of
      tssOff: FFieldDataLink.DataSet.FieldByName(FFieldDataLink.FieldName).Text := 'N';
      tssOn:  FFieldDataLink.DataSet.FieldByName(FFieldDataLink.FieldName).Text := 'S';
    end;
  end;


end;


procedure TGoDBToggleSwitch.CMEnter(var Message: TCMEnter);
begin
  inherited;
//
end;

procedure TGoDBToggleSwitch.CMExit(var Message: TWMNoParams);
begin
   try
      FFieldDataLink.UpdateRecord;
   except
      on Exception do SetFocus;
   end;
   DoExit;
   inherited;
end;

constructor TGoDBToggleSwitch.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
//   Self.Button.Width := 21;
   FFieldDataLink := TFieldDataLink.Create;
   FFieldDataLink.Control := Self;
   FFieldDataLink.OnDataChange := DataChange;
   StateCaptions.CaptionOn  := 'Sim';
   StateCaptions.CaptionOff := 'Não';
end;

procedure TGoDBToggleSwitch.DataChange(Sender: TObject);
begin
  inherited;
  //  ReadOnly := not FFieldDataLink.Editing;
  if FFieldDataLink.DataSet.State in [dsInsert,dsEdit] then
  begin
    if FFieldDataLink.DataSet.FieldByName(FFieldDataLink.FieldName).Value = Null then
    begin
      case State of
        tssOff: FFieldDataLink.DataSet.FieldByName(FFieldDataLink.FieldName).AsVariant := 'N';
        tssOn:  FFieldDataLink.DataSet.FieldByName(FFieldDataLink.FieldName).AsVariant := 'S';
      end;
    end;
  end;
  //
  if FFieldDataLink.Field <> nil then
  begin
    if FFieldDataLink.Field.AsString = 'S' then
    State := tssOn else   State := tssOff;
  end;
end;


destructor TGoDBToggleSwitch.Destroy;
begin
   FFieldDataLink.OnDataChange := nil;
//   FFieldDataLink.OnUpdateData := nil;
   FFieldDataLink.Free;
   FFieldDataLink := nil;
   inherited Destroy;
end;


function TGoDBToggleSwitch.GetDataField: string;
begin
   Result := FFieldDataLink.FieldName;
end;


function TGoDBToggleSwitch.GetReadOnly: Boolean;
begin
  Result := FFieldDataLink.ReadOnly;
end;

procedure TGoDBToggleSwitch.SetDataField(const Value: string);
begin
   FFieldDataLink.FieldName := Value;
end;

function TGoDBToggleSwitch.GetDataSource: TDataSource;
begin
   Result := FFieldDataLink.DataSource;
end;

procedure TGoDBToggleSwitch.SetDataSource(Value: TDataSource);
begin
   FFieldDataLink.DataSource := Value;
end;

procedure TGoDBToggleSwitch.SetReadOnly(Value: Boolean);
begin
  FFieldDataLink.ReadOnly := Value;
end;

end.
