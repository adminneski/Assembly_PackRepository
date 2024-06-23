unit Narte_DBLookup;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.DBCtrls,
  Gobt_ButtonAdvanced, Vcl.Mask,Data.DB, Vcl.ExtCtrls,Vcl.Menus;


const
  scAltDown = scAlt + vk_Down;
  scF3 = VK_F3;
type

  TFrameDBLookup = class(TFrame)
    Panel: TPanel;
    DBLookup: TDBEdit;
    GoButtonAdvanced: TGoButtonAdvanced;
    Panel_DBLookupText: TPanel;
    DBLookupText: TDBText;
    DataSource_Lookup: TDataSource;
    DataSource: TDataSource;
    procedure DataSource_LookupDataChange(Sender: TObject; Field: TField);
    procedure DataSourceStateChange(Sender: TObject);
    procedure DBLookupKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBLookupExit(Sender: TObject);
    procedure DataSourceDataChange(Sender: TObject; Field: TField);
    procedure DBLookupChange(Sender: TObject);
  private
  { Private declarations }
    FDataSet: TDataSet;
    //
    FLookupDataSet : TDataSet;
    FLookupColor: TColor;
    FButtonClick: TNotifyEvent;
    FClickKey: TShortCut;
    function GetDataField: string;
    procedure SetDataField(const Value: string);
    procedure SetDataSet(const Value: TDataSet);
    //
    procedure SetLookupColor(const Value: TColor);
    function GetLookupDataField: string;
    procedure SetLookupDataField(const Value: string);
    procedure SetLookupDataSet(const Value: TDataSet);

  protected
    procedure PaintWindow(DC: HDC); override;

    procedure OnButtonClickEvent(Sender: TObject);
  published
  { published declarations }
    property ClickKey: TShortCut read FClickKey write FClickKey default scAltDown;
    property DataField: string read GetDataField write SetDataField;
    property DataSet: TDataSet read FDataSet write SetDataSet;

    property LookupDataSet: TDataSet read FLookupDataSet write SetLookupDataSet;
    property LookupDataField: string read GetLookupDataField write SetLookupDataField;
    property LookupColor : TColor read FLookupColor write SetLookupColor;

    property OnButtonClick: TNotifyEvent read FButtonClick write FButtonClick;
  public
    { Public declarations }
     constructor Create(AOwner: TComponent); override;
  end;

implementation


{$R *.dfm}

{ TFrameDBLookup }

constructor TFrameDBLookup.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Self.FClickKey := scF3;
  Self.ParentBackground := false;
  Self.Color := clWindow;
  Self.Font.Name := 'Arial';
  Self.Font.Size := 12;
  Self.Height := 26;

  FLookupColor := clSilver;

  GoButtonAdvanced.OnClick := OnButtonClickEvent;

  DataSource.AutoEdit := false;
  DataSource_Lookup.AutoEdit := false;
  DBLookup.DataSource := DataSource;
  DBLookupText.DataSource := DataSource_Lookup;


end;

procedure TFrameDBLookup.DataSourceDataChange(Sender: TObject; Field: TField);
begin
  //Limpa Dataset Lookup quando Nullo DBLookup
  if DataSource.DataSet.State in [dsEdit,dsInsert] then
  begin
    if TFrameDBLookup(Self).DBLookup.Field.Text.Length = 0 then
    begin
      if not DataSource_Lookup.DataSet.IsEmpty then
        DataSource_Lookup.DataSet.Append;
      Panel_DBLookupText.Caption := '';
    end;
  end;
end;

procedure TFrameDBLookup.DataSourceStateChange(Sender: TObject);
begin
  if DataSource.DataSet.State in [dsInsert,dsEdit] then
   GoButtonAdvanced.Enabled := true
  else
   GoButtonAdvanced.Enabled := false;
  //Limpa Dataset Lookup quando Nullo DBLookup
  if DataSource.DataSet.State in [dsBrowse] then
  begin
    if TFrameDBLookup(Self).DBLookup.Field.IsNull then
    begin
      if not DataSource_Lookup.DataSet.IsEmpty then
        DataSource_Lookup.DataSet.Append;
      Panel_DBLookupText.Caption := '';
    end;
  end
  else
  if DataSource.DataSet.State in [dsInsert] then
  begin
    if not DataSource_Lookup.DataSet.IsEmpty then
      DataSource_Lookup.DataSet.Append;
    Panel_DBLookupText.Caption := '';
  end;
end;

procedure TFrameDBLookup.DataSource_LookupDataChange(Sender: TObject;
  Field: TField);
begin
  if DataSource_Lookup.DataSet.RecordCount > 0 then
  begin
    DBLookupText.Visible := true;
    Panel_DBLookupText.Caption := '';
  end
  else
  begin
    DBLookupText.Visible := false;
    if Length(DBLookup.Text) > 0 then
    begin
      Panel_DBLookupText.Caption := '   > > >  Registro não encontrado  < < <';
    end
    else
    begin
     Panel_DBLookupText.Caption := ' ';
    end;
  end;
end;



procedure TFrameDBLookup.DBLookupChange(Sender: TObject);
begin
  //Se Valor estiver EmBranco Força 0
  if Length(Trim(DBLookup.Text)) = 0 then
  begin
   DBLookup.Text := '0';
   DBLookup.SelectAll;
  end;
  //

end;

procedure TFrameDBLookup.DBLookupExit(Sender: TObject);
begin
end;
//type
//  TCrackWin = class(TWinControl);

procedure TFrameDBLookup.DBLookupKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
// Polaris
//var
//  Form: TCustomForm;
begin
{Comentado para refazer uma estudo}

//  // Polaris
//  Form := GetParentForm(Self);
//  if (ssCtrl in Shift) then
//    case Key of
//      VK_RETURN:
//        if (Form <> nil) { and Form.KeyPreview } then
//        begin
//          TCrackWin(Form).KeyDown(Key, Shift);
//          Key := 0;
//        end;
//      VK_TAB:
//        if (Form <> nil) { and Form.KeyPreview } then
//        begin
//          TCrackWin(Form).KeyDown(Key, Shift);
//          Key := 0;
//        end;
//    end;

  // Original
  inherited KeyDown(Key, Shift);

  if (FClickKey = ShortCut(Key, Shift)) and (GoButtonAdvanced.Enabled = true) then
  begin
    GoButtonAdvanced.Click;
    Key := 0;
  end;

end;

function TFrameDBLookup.GetDataField: string;
begin
  Result := DBLookup.DataField;
end;

function TFrameDBLookup.GetLookupDataField: string;
begin
  Result := DBLookupText.DataField;
end;

procedure TFrameDBLookup.OnButtonClickEvent(Sender: TObject);
begin
  if Assigned(FButtonClick) then
   FButtonClick(Self);
end;

procedure TFrameDBLookup.PaintWindow(DC: HDC);
var
  I : Integer;
begin
  inherited;
  //Paint
  DBLookup.Color := Self.Color;
  DBLookupText.Color := FLookupColor;
  DBLookup.Font := Self.Font;
  DBLookupText.Font := Self.Font;
  //
  Panel_DBLookupText.Color := FLookupColor;
end;

procedure TFrameDBLookup.SetLookupColor(const Value: TColor);
begin
  FLookupColor := Value;
end;

procedure TFrameDBLookup.SetDataField(const Value: string);
begin
  DBLookup.DataField := Value;
end;

procedure TFrameDBLookup.SetLookupDataField(const Value: string);
begin
  DBLookupText.DataField := Value;
end;

procedure TFrameDBLookup.SetDataSet(const Value: TDataSet);
begin
  if Value <> nil then
  begin
    FDataSet := Value;
    DataSource.DataSet := FDataSet;
  end
  else
  begin
    FDataSet := nil;
    DataSource.DataSet := nil;
  end;
end;

procedure TFrameDBLookup.SetLookupDataSet(const Value: TDataSet);
begin
  if Value <> nil then
  Begin
    FLookupDataSet := Value;
    DataSource_Lookup.DataSet := FLookupDataSet;
  End
  else
  begin
    FLookupDataSet := nil;
    DataSource_Lookup.DataSet := nil;
  end;
end;

end.
