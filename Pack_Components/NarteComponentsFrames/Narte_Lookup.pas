unit Narte_Lookup;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.DBCtrls,
  Gobt_ButtonAdvanced, Vcl.Mask,Data.DB, Vcl.ExtCtrls,Vcl.Menus;


const
  scAltDown = scAlt + vk_Down;
  scF3 = VK_F3;
type

  TFrameLookup = class(TFrame)
    Panel: TPanel;
    GoButtonAdvanced: TGoButtonAdvanced;
    Panel_DBLookupText: TPanel;
    DBLookupText: TDBText;
    DataSource_Lookup: TDataSource;
    FEditLookup: TEdit;
    procedure DataSource_LookupDataChange(Sender: TObject; Field: TField);
    procedure FrameEnter(Sender: TObject);
    procedure DBLookupExit(Sender: TObject);
    procedure FEditLookupKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FEditLookupExit(Sender: TObject);
  private
  { Private declarations }
    FLookupDataSet : TDataSet;
    FLookupColor: TColor;
    FButtonClick: TNotifyEvent;
    FClickKey: TShortCut;
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
    //
    property LookupDataSet: TDataSet read FLookupDataSet write SetLookupDataSet;
    property LookupDataField: string read GetLookupDataField write SetLookupDataField;
    property LookupColor : TColor read FLookupColor write SetLookupColor;

    property EditLookup: TEdit read FEditLookup write FEditLookup;

    property OnButtonClick: TNotifyEvent read FButtonClick write FButtonClick;
  public
    { Public declarations }
     constructor Create(AOwner: TComponent); override;
  end;

implementation


{$R *.dfm}

{ TFrameDBLookup }

constructor TFrameLookup.Create(AOwner: TComponent);
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

  DataSource_Lookup.AutoEdit := false;
  DBLookupText.DataSource := DataSource_Lookup;


  FEditLookup.SetSubComponent(True);
  FEditLookup.Text := '';
end;

procedure TFrameLookup.DataSource_LookupDataChange(Sender: TObject;
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
    if Length(FEditLookup.Text) > 0 then
    begin
      Panel_DBLookupText.Caption := '   > > >  Registro não encontrado  < < <';
    end
    else
    begin
     Panel_DBLookupText.Caption := ' ';
    end;
  end;
end;



procedure TFrameLookup.DBLookupExit(Sender: TObject);
begin
  if Pos('> > >  Registro não encontrado  < < <',Panel_DBLookupText.Caption) > 0 then
  begin
    FEditLookup.SetFocus;
  end;

end;


//type
//  TCrackWin = class(TWinControl);


procedure TFrameLookup.FEditLookupExit(Sender: TObject);
begin
  if Length(FEditLookup.Text) > 0 then
  begin
    DBLookupText.Visible := true;
  end
  else
  if Length(FEditLookup.Text) = 0 then
  begin
    DBLookupText.Visible := false;
    Panel_DBLookupText.Caption := ' ';
  end;
end;

procedure TFrameLookup.FEditLookupKeyDown(Sender: TObject; var Key: Word;
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

procedure TFrameLookup.FrameEnter(Sender: TObject);
begin
  TFrameLookup(Self).FEditLookup.SetFocus;
end;

function TFrameLookup.GetLookupDataField: string;
begin
  Result := DBLookupText.DataField;
end;

procedure TFrameLookup.OnButtonClickEvent(Sender: TObject);
begin
  if Assigned(FButtonClick) then
   FButtonClick(Self);
end;

procedure TFrameLookup.PaintWindow(DC: HDC);
var
  I : Integer;
begin
  inherited;
  //Paint
  FEditLookup.Color := Self.Color;
  DBLookupText.Color := FLookupColor;
  FEditLookup.Font := Self.Font;
  DBLookupText.Font := Self.Font;
  //
  Panel_DBLookupText.Color := FLookupColor;
end;

procedure TFrameLookup.SetLookupColor(const Value: TColor);
begin
  FLookupColor := Value;
end;

procedure TFrameLookup.SetLookupDataField(const Value: string);
begin
  DBLookupText.DataField := Value;
end;

procedure TFrameLookup.SetLookupDataSet(const Value: TDataSet);
begin
  if Value <> nil then
  Begin
    FLookupDataSet := Value;
    DataSource_Lookup.DataSet := FLookupDataSet;
  End;
end;

end.
