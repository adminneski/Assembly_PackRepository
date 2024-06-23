
{******************************************}
{                                          }
{             FastReport VCL               }
{               Memo editor                }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxEditMemo;

interface

{$I frx.inc}

uses
  SysUtils, {$IFNDEF FPC}Windows, Messages,{$ENDIF} Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, ToolWin, frxClass,
  frxEditFormat, frxEditHighlight, frxBaseFormEditorDataTree
{$IFDEF FPC}
  , LResources, LCLType, LMessages
{$ENDIF}

{$IFDEF DELPHI6}
, Variants
{$ENDIF};
  

type
  TfrxMemoEditorForm = class(TfrxBaseFormEditorDataTree)
    PageControl1: TPageControl;
    TextTS: TTabSheet;
    FormatTS: TTabSheet;
    HighlightTS: TTabSheet;
    ToolBar: TToolBar;
    ExprB: TToolButton;
    AggregateB: TToolButton;
    WordWrapB: TToolButton;
    OkB: TButton;
    CancelB: TButton;
    procedure FormShow(Sender: TObject);
    procedure WordWrapBClick(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure MemoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ExprBClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AggregateBClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PageControl1Change(Sender: TObject);
    procedure ExprMemoDragDrop(Sender, Source: TObject; X, Y: Integer);
  private
    FFormat: TfrxFormatEditorForm;
    FHighlight: TfrxHighlightEditorForm;
    FMemoView: TfrxCustomMemoView;
    FIsUnicode: Boolean;
    FText: {$IFDEF FPCUNICODE}String{$ELSE}WideString{$ENDIF};
  protected
    procedure LoadFormPreferences(PreferencesStorage: TObject; DefPreferencesStorage: TObject); override;
    procedure SaveFormPreferences(PreferencesStorage: TObject; DefPreferencesStorage: TObject); override;
    procedure OnDataTreeDblClick(Sender: TObject); override;
  public
    Memo: TMemo;
    procedure UpdateResouces; override;
    procedure UpdateFormPPI(aNewPPI: Integer); override;
    property MemoView: TfrxCustomMemoView read FMemoView write FMemoView;
    property Text: {$IFDEF FPCUNICODE}String{$ELSE}WideString{$ENDIF} read FText write FText;
  end;


implementation

{$IFNDEF FPC}
{$R *.DFM}
{$ELSE}
{$R *.lfm}
{$ENDIF}

uses frxEditSysMemo, IniFiles, frxRes, frxUnicodeCtrls, frUnicodeUtils;


{ TfrxMemoEditorForm }

procedure TfrxMemoEditorForm.FormShow(Sender: TObject);
begin
  FIsUnicode := (FMemoView.Font.Charset = DEFAULT_CHARSET) or FMemoView.UseDefaultCharset;

  if FIsUnicode then
    Memo := TUnicodeMemo.Create(Self)
  else
    Memo := TMemo.Create(Self);

  with Memo do
  begin
    Parent := TextTS;
    Align := alClient;
    ScrollBars := ssBoth;
    TabOrder := 1;
    OnKeyDown := MemoKeyDown;
    OnDragOver := ExprMemoDragOver;
    OnDragDrop := ExprMemoDragDrop;
  end;

  FFormat := TfrxFormatEditorForm.Create(Owner);
  FFormat.Memo := MemoView;
  FFormat.MemoText := MemoView.Text;
  FFormat.HostControls(FormatTS);

  FHighlight := TfrxHighlightEditorForm.Create(Owner);
  FHighlight.MemoView := MemoView;
  FHighlight.HostControls(HighlightTS);

  Icon := TForm(Owner).Icon;
  WordWrapBClick(nil);

  with TfrxCustomDesigner(Owner) do
  begin
    if UseObjectFont then
    begin
      Memo.Font := FMemoView.Font;
      Memo.Font.Color := clBlack;
      Memo.Font.Height := FMemoView.Font.Height;
    end
    else
    begin
      Memo.Font.Name := MemoFontName;
      Memo.Font.Size := MemoFontSize;
    end;
  end;

  if FIsUnicode then
    TUnicodeMemo(Memo).Text := FMemoView.Text
  else
{$IFDEF FPC}
    Memo.Text := FMemoView.Text;
{$ELSE}
{$IFDEF DELPHI12}
    Memo.Text := FMemoView.Text;
{$ELSE}
    Memo.Text := _UnicodeToAnsi(FMemoView.Text, FMemoView.Font.Charset);
{$ENDIF}
{$ENDIF}

  Memo.SetFocus;
  {$IFNDEF FPC}
  Memo.Perform(EM_SETSEL, 0, 0);
  Memo.Perform(EM_SCROLLCARET, 0, 0);
  {$ENDIF}

  PageControl1.SetBounds(0, 0, PageControl1.Parent.ClientWidth, PageControl1.Parent.ClientHeight - OkB.Height - 8);
  OkB.Left := OkB.Parent.ClientWidth - OkB.Width - CancelB.Width - 8;
  CancelB.Left := CancelB.Parent.ClientWidth - CancelB.Width - 4;
  OkB.Top := OkB.Parent.ClientHeight - OkB.Height - 4;
  CancelB.Top := OkB.Top;
end;

procedure TfrxMemoEditorForm.LoadFormPreferences(PreferencesStorage: TObject; DefPreferencesStorage: TObject);
var
  Ini: TCustomIniFile;
  lName: String;
begin
  inherited;
  if not(PreferencesStorage is TCustomIniFile) then Exit;
  Ini :=  TCustomIniFile(PreferencesStorage);
  lName := GetFormSectionName;
  WordWrapB.Down := Ini.ReadBool(lName, 'WordWrap', False);
end;

procedure TfrxMemoEditorForm.FormHide(Sender: TObject);
begin
  if FIsUnicode then
    FText := TUnicodeMemo(Memo).Text
  else
{$IFDEF FPC}
   FText := Memo.Text;
{$ELSE}

{$IFDEF DELPHI12}
    FText := Memo.Text;
{$ELSE}
    FText := AnsiToUnicode(Memo.Text, FMemoView.Font.Charset);
{$ENDIF}
{$ENDIF}

  FFormat.UnhostControls(ModalResult);
  FFormat.Free;
  FHighlight.UnhostControls(ModalResult);
  FHighlight.Free;
end;

procedure TfrxMemoEditorForm.ExprBClick(Sender: TObject);
var
  s, s1, s2: String;

  function BracketCount: Integer;
  var
    i: Integer;
  begin
    Result := 0;
    for i := 1 to Length(s) do
      if s[i] = '<' then
        Inc(Result);
  end;

begin
  s := TfrxCustomDesigner(Owner).InsertExpression('');
  if s <> '' then
  begin
    s1 := MemoView.ExpressionDelimiters;
    s2 := Copy(s1, Pos(',', s1) + 1, 255);
    s1 := Copy(s1, 1, Pos(',', s1) - 1);
    if (s[1] = '<') and (s[Length(s)] = '>') and (BracketCount = 1) then
      s := Copy(s, 2, Length(s) - 2);
    Memo.SelText := s1 + s + s2;
  end;
end;

procedure TfrxMemoEditorForm.WordWrapBClick(Sender: TObject);
var
  s: {$IFDEF FPCUNICODE}String{$ELSE}WideString{$ENDIF};
begin
  s := '';
  if FIsUnicode then
    s := TUnicodeMemo(Memo).Text;

  Memo.WordWrap := WordWrapB.Down;
  if Memo.WordWrap then
    Memo.ScrollBars := ssVertical
  else
    Memo.ScrollBars := ssBoth;

  if FIsUnicode then
    TUnicodeMemo(Memo).Text := s;
end;

procedure TfrxMemoEditorForm.MemoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = vk_Return) and (ssCtrl in Shift) then
    ModalResult := mrOk
  else if Key = vk_Escape then
    ModalResult := mrCancel
  else if (Key = Ord('A')) and (Shift = [ssCtrl]) then
    Memo.SelectAll;
end;

procedure TfrxMemoEditorForm.PageControl1Change(Sender: TObject);
begin
  if PageControl1.ActivePage = FormatTS then
  begin
    FFormat.MemoText := Memo.Lines.Text;
    FFormat.FormShow(nil);
  end;
end;

procedure TfrxMemoEditorForm.ExprMemoDragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  MemoDragDrop(Memo, FDataTree, X, Y, FMemoView.ExpressionDelimiters);
end;

procedure TfrxMemoEditorForm.SaveFormPreferences(PreferencesStorage: TObject; DefPreferencesStorage: TObject);
var
  Ini: TCustomIniFile;
  lName: String;
begin
  inherited;
  if not(PreferencesStorage is TCustomIniFile) then Exit;
  Ini :=  TCustomIniFile(PreferencesStorage);
  lName := GetFormSectionName;
  Ini.WriteBool(lName, 'WordWrap', Memo.WordWrap);
end;

procedure TfrxMemoEditorForm.OnDataTreeDblClick(Sender: TObject);
begin
  Memo.SelText := GetExpText(FDataTree.GetFieldName, Memo.Lines[Memo.CaretPos.Y], FMemoView.ExpressionDelimiters, Memo.CaretPos.X);
end;

procedure TfrxMemoEditorForm.UpdateFormPPI(aNewPPI: Integer);
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

procedure TfrxMemoEditorForm.UpdateResouces;
begin
  inherited;
  Caption := frxGet(3900);
  ExprB.Hint := frxGet(3901);
  AggregateB.Hint := frxGet(3902);
  WordWrapB.Hint := frxGet(3904);
  TextTS.Caption := frxGet(3905);
  FormatTS.Caption := frxGet(3906);
  HighlightTS.Caption := frxGet(3907);
  OkB.Caption := frxGet(1);
  CancelB.Caption := frxGet(2);
end;

procedure TfrxMemoEditorForm.FormCreate(Sender: TObject);
begin
  if UseRightToLeftAlignment then
    FlipChildren(True);
end;

procedure TfrxMemoEditorForm.AggregateBClick(Sender: TObject);
begin
  with TfrxSysMemoEditorForm.Create(Owner) do
  begin
    AggregateOnly := True;
    if ShowModal = mrOk then
      Memo.SelText := Text;
    Free;
  end;
end;

procedure TfrxMemoEditorForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    frxResources.Help(Self);
end;

end.

