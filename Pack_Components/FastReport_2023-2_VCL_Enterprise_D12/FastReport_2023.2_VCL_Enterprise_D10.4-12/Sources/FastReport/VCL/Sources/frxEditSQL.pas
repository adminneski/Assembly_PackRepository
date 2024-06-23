
{******************************************}
{                                          }
{             FastReport VCL               }
{               SQL editor                 }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxEditSQL;

interface

{$I frx.inc}

uses
  SysUtils,
  {$IFNDEF FPC}
  Windows, Messages,
  {$ENDIF}
  Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, ToolWin, frxSynMemo,
  frxCustomDB, frxBaseForm
  {$IFDEF FPC}
  , LResources, LCLType
  {$ENDIF}
{$IFDEF DELPHI6}
, Variants
{$ENDIF}
{$IFNDEF WITHOUTQBUILDER}
, fqbClass
{$ENDIF};


type
  TfrxSQLEditorForm = class(TfrxBaseLoadSavePrefForm)
    ToolBar: TToolBar;
    OkB: TToolButton;
    CancelB: TToolButton;
    QBB: TToolButton;
    ParamsB: TToolButton;
    ToolButton2: TToolButton;
    CBPanel: TPanel;
    CBDialect: TComboBox;
    TBEditDialect: TToolButton;
    ToolButton3: TToolButton;
    LDialect: TLabel;
    TBSaveDialect: TToolButton;
    TBLoadDialect: TToolButton;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    procedure OkBClick(Sender: TObject);
    procedure CancelBClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MemoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormHide(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure QBBClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ParamsBClick(Sender: TObject);
    procedure TBEditDialectClick(Sender: TObject);
    procedure CBDialectChange(Sender: TObject);
    procedure TBSaveDialectClick(Sender: TObject);
    procedure TBLoadDialectClick(Sender: TObject);
  private
    { Private declarations }
    FMemo: TfrxSyntaxMemo;
    FQuery: TfrxCustomQuery;
{$IFNDEF WITHOUTQBUILDER}
    FQBEngine: TfqbEngine;
{$ENDIF}
    FSaveSQL: TStrings;
    FSaveSchema: String;
    FSaveParams: TfrxParams;
    procedure UpdateDialectsCB;
  public
    { Public declarations }
    procedure UpdateResouces; override;
    procedure UpdateFormPPI(aNewPPI: Integer); override;
    property Query: TfrxCustomQuery read FQuery write FQuery;
  end;


implementation

{$IFNDEF FPC}
{$R *.DFM}
{$ELSE}
{$R *.lfm}
{$ENDIF}

uses frxClass, frxRes, frxEditQueryParams, frxEditSQLDialect, frxUtils, IniFiles;

const SettingSection = 'Form.TfrxSQLEditorForm';


procedure TfrxSQLEditorForm.CBDialectChange(Sender: TObject);
begin
  if CBDialect.ItemIndex = FMemo.SynDialectStyles.ActiveIndex + 1 then Exit;
  FMemo.SynDialectStyles.ActiveIndex := CBDialect.ItemIndex - 1;
{$IFDEF FPC}
  frxUpdateControl(FMemo);
{$ELSE}
  FMemo.Repaint;
{$ENDIF}
end;

procedure TfrxSQLEditorForm.FormCreate(Sender: TObject);
begin
{$IFDEF FR_COM}
  Icon.Handle := LoadIcon(hInstance, 'SDESGNICON');
{$ENDIF}
  FSaveSQL := TStringList.Create;
  FSaveParams := TfrxParams.Create;

  FMemo := TfrxSyntaxMemo.Create(Self);
  with FMemo do
  begin
    Parent := Self;
    Align := alClient;
    Syntax := 'SQL';
    ShowGutter := True;
    GutterWidth := 30;
{ an example of using default AttributeStyles }
{    with TfrxAttributeStyle(AttributeStyles.Add) do
    begin
      FontColor := clRed;
      AttrType := caKeyword;
      FontStyle := [fsBold];
      Keywords.Add('select');
    end;

    with TfrxAttributeStyle(AttributeStyles.Add) do
    begin
      FontColor := clRed;
      AttrType := caText;
      FontStyle := [fsBold];
      Keywords.Add('id');
    end;
}
{$IFDEF UseTabset}
    BevelKind := bkFlat;
{$ELSE}
    BorderStyle := bsSingle;
{$ENDIF}
    Color := clWindow;
    OnKeyDown := MemoKeyDown;
{$I frxEditSQL.inc}
  end;
{$IFNDEF WITHOUTQBUILDER}
  QBB.Visible := True;
{$ENDIF}

  if UseRightToLeftAlignment then
    FlipChildren(True);
end;

procedure TfrxSQLEditorForm.FormDestroy(Sender: TObject);
begin
  FSaveSQL.Free;
  FSaveParams.Free;
end;

procedure TfrxSQLEditorForm.FormShow(Sender: TObject);
begin
  FSaveSQL.Assign(Query.SQL);
  FSaveParams.Assign(Query.Params);
  FSaveSchema := Query.SQLSchema;
{$IFNDEF WITHOUTQBUILDER}
  try
    FQBEngine := Query.QBEngine;
  except
  end;
{$ENDIF}
  FMemo.Lines.Assign(Query.SQL);
  FMemo.LoadFromIni(Query.Report.IniFile, SettingSection, '');
  UpdateDialectsCB;
  FMemo.SetFocus;
end;

procedure TfrxSQLEditorForm.FormHide(Sender: TObject);
begin
  if ModalResult = mrOk then
  begin
    Query.SQL.Assign(FMemo.Lines);
  end
  else
  begin
    Query.SQL.Assign(FSaveSQL);
    Query.Params.Assign(FSaveParams);
    Query.SQLSchema := FSaveSchema;
  end;
  FMemo.SaveToIni(Query.Report.IniFile, SettingSection, '');
{$IFNDEF WITHOUTQBUILDER}
  if FQBEngine <> nil then
    FQBEngine.Free;
{$ENDIF}
end;

procedure TfrxSQLEditorForm.OkBClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TfrxSQLEditorForm.CancelBClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrxSQLEditorForm.MemoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = vk_Return) and (ssCtrl in Shift) then
    ModalResult := mrOk
  else if Key = vk_Escape then
    ModalResult := mrCancel
  else if Key = VK_F1 then
    frxResources.Help(Self);
end;

procedure TfrxSQLEditorForm.QBBClick(Sender: TObject);
{$IFNDEF WITHOUTQBUILDER}
var
  fqbDialog: TfqbDialog;
{$ENDIF}
begin
{$IFNDEF WITHOUTQBUILDER}
  fqbDialog := TfqbDialog.Create(nil);
  try
    fqbDialog.Engine := FQBEngine;
    fqbDialog.SchemaInsideSQL := False;
    fqbDialog.SQL := FMemo.Lines.Text;
    fqbDialog.SQLSchema := Query.SQLSchema;

    if fqbDialog.Execute then
    begin
      FMemo.Lines.Text := fqbDialog.SQL;
      Query.SQLSchema := fqbDialog.SQLSchema;
    end;
  finally
    fqbDialog.Free;
  end;
{$ENDIF}
end;

procedure TfrxSQLEditorForm.TBEditDialectClick(Sender: TObject);
begin
  with TfrxSQLDialectForm.Create(Self) do
  begin
    SynDialectStyles := FMemo.SynDialectStyles;
    ShowModal;
    UpdateDialectsCB;
    Free;
  end;
end;

procedure TfrxSQLEditorForm.TBLoadDialectClick(Sender: TObject);
var
  ini: TIniFile;
begin
  if OpenDialog.Execute then
  begin
    ini := TIniFile.Create(OpenDialog.FileName);
    try
      FMemo.SynDialectStyles.LoadFrom(SettingSection, ini);
    finally
      UpdateDialectsCB;
      ini.Free;
    end;
  end;
end;

procedure TfrxSQLEditorForm.TBSaveDialectClick(Sender: TObject);
var
  ini: TIniFile;
begin
  if SaveDialog.Execute then
  begin
    ini := TIniFile.Create(SaveDialog.FileName);
    try
      FMemo.SynDialectStyles.SaveTo(SettingSection, ini);
    finally
      ini.Free;
    end;
  end;
end;

procedure TfrxSQLEditorForm.UpdateDialectsCB;
var
  i: Integer;
begin
  CBDialect.Clear;
  CBDialect.Items.BeginUpdate;
  CBDialect.Items.Add('Default');
  for i := 0 to FMemo.SynDialectStyles.Count - 1 do
    CBDialect.Items.Add(FMemo.SynDialectStyles[i].Name);
  CBDialect.Items.EndUpdate;
  CBDialect.ItemIndex := FMemo.SynDialectStyles.ActiveIndex + 1;
end;

procedure TfrxSQLEditorForm.UpdateFormPPI(aNewPPI: Integer);
{$IFDEF FPC}
var
  i: Integer;
{$ENDIF}
begin
  inherited;
  Toolbar.Images := frxImages.MainButtonImages;
{$IFDEF FPC}
  Toolbar.ImagesWidth := Toolbar.Images.Width;
  for i := 0 to ToolBar.ButtonCount - 1 do
    ToolBar.Buttons[i].AutoSize:= true;
{$ENDIF}
  Toolbar.ButtonWidth := 0;
  Toolbar.ButtonHeight := 0;
end;

procedure TfrxSQLEditorForm.UpdateResouces;
begin
  inherited;
  Caption := frxGet(4900);
  QBB.Hint := frxGet(4901);
  ParamsB.Hint := frxGet(5714);
  CancelB.Hint := frxGet(2);
  OkB.Hint := frxGet(1);
  LDialect.Caption := frxGet(6700);
  TBEditDialect.Hint := frxGet(6701);
  TBLoadDialect.Hint := frxGet(6705);
  TBSaveDialect.Hint := frxGet(6706);
  SaveDialog.Filter := frxGet(6707);
  OpenDialog.Filter := frxGet(6707);
  UpdateDialectsCB;
end;

procedure TfrxSQLEditorForm.ParamsBClick(Sender: TObject);
begin
  Query.SQL.Assign(FMemo.Lines);
  if Query.Params.Count <> 0 then
    with TfrxParamsEditorForm.Create(Owner) do
    begin
      Params := Query.Params;
      if ShowModal = mrOk then
        Query.UpdateParams;
      Free;
    end;
end;

end.

