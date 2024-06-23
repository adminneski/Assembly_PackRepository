
{******************************************}
{                                          }
{             FastReport VCL               }
{             ListBox editor               }
{                                          }
{         Copyright (c) 1998-2022          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxListControlEditor;

interface

{$I frx.inc}

uses
{$IFNDEF FPC}
  Windows, Messages, WideStrings,
{$ELSE}
  LResources, LCLType, LMessages, LazHelper,
{$ENDIF}
  SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, ToolWin,
  frCoreClasses, frxClass,
  frxEditFormat, frxEditHighlight, frxBaseFormEditorDataTree, frxListControl;

type
  TfrxListControlEditorForm = class(TfrxBaseFormEditorDataTree)
    MainToolBar: TToolBar;
    LoadB: TToolButton;
    ToolButton1: TToolButton;
    CancelB: TToolButton;
    OkB: TToolButton;
    PageControl1: TPageControl;
    TextTS: TTabSheet;
    ToolBar: TToolBar;
    ExprB: TToolButton;
    AggregateB: TToolButton;
    OpenDialog: TOpenDialog;
    procedure FormShow(Sender: TObject);
    procedure MemoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ExprBClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AggregateBClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ExprMemoDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure LoadBClick(Sender: TObject);
    procedure CancelBClick(Sender: TObject);
    procedure OkBClick(Sender: TObject);
  private
    FMemo: TMemo;
    FListControlView: TfrxCustomListControlView;

    procedure SetListControlView(const Value: TfrxCustomListControlView);
  protected
    procedure OnDataTreeDblClick(Sender: TObject); override;
  public
    procedure UpdateResouces; override;
    procedure UpdateFormPPI(aNewPPI: Integer); override;

    property ListControlView: TfrxCustomListControlView read FListControlView write SetListControlView;
  end;

implementation

{$R *.dfm}

uses
  IniFiles, frUnicodeUtils, frxEditSysMemo, frxRes, frxUnicodeCtrls,
  frxDsgnIntf, frxListBox, frxComboBox;

type
  TfrxItemsProperty = class(TfrxClassProperty)
  public
    function GetAttributes: TfrxPropertyAttributes; override;
    function Edit: Boolean; override;
  end;

{ TfrxListControlEditorForm }

procedure TfrxListControlEditorForm.FormShow(Sender: TObject);
begin
  FMemo := TUnicodeMemo.Create(Self);

  with FMemo do
  begin
    Parent := TextTS;
    Align := alClient;
    ScrollBars := ssBoth;
    TabOrder := 1;
    OnKeyDown := MemoKeyDown;
    OnDragOver := ExprMemoDragOver;
    OnDragDrop := ExprMemoDragDrop;
    WordWrap := False;
  end;

  Icon := TForm(Owner).Icon;

  with TfrxCustomDesigner(Owner) do
    if UseObjectFont then
    begin
      FMemo.Font := FListControlView.Font;
      FMemo.Font.Color := clBlack;
      FMemo.Font.Height := FListControlView.Font.Height;
    end
    else
    begin
      FMemo.Font.Name := MemoFontName;
      FMemo.Font.Size := MemoFontSize;
    end;

  TUnicodeMemo(FMemo).Text := FListControlView.Items.Text;

  FMemo.SetFocus;
  {$IFNDEF FPC}
  FMemo.Perform(EM_SETSEL, 0, 0);
  FMemo.Perform(EM_SCROLLCARET, 0, 0);
  {$ENDIF}
end;

procedure TfrxListControlEditorForm.LoadBClick(Sender: TObject);
begin
  if OpenDialog.Execute then
    FMemo.Lines.LoadFromFile(OpenDialog.FileName);
end;

procedure TfrxListControlEditorForm.CancelBClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrxListControlEditorForm.ExprBClick(Sender: TObject);
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
    s1 := FListControlView.ExpressionDelimiters;
    s2 := Copy(s1, Pos(',', s1) + 1, 255);
    s1 := Copy(s1, 1, Pos(',', s1) - 1);
    if (s[1] = '<') and (s[Length(s)] = '>') and (BracketCount = 1) then
      s := Copy(s, 2, Length(s) - 2);
    FMemo.SelText := s1 + s + s2;
  end;
end;

procedure TfrxListControlEditorForm.MemoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = Ord('A')) and (Shift = [ssCtrl]) then
    FMemo.SelectAll;
end;

procedure TfrxListControlEditorForm.ExprMemoDragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  MemoDragDrop(FMemo, FDataTree, X, Y, FListControlView.ExpressionDelimiters);
end;

procedure TfrxListControlEditorForm.OkBClick(Sender: TObject);
begin
  ModalResult := mrOk;

  FListControlView.Items.Text := FMemo.Text;
end;

procedure TfrxListControlEditorForm.OnDataTreeDblClick(Sender: TObject);
begin
  FMemo.SelText := GetExpText(FDataTree.GetFieldName, FMemo.Lines[FMemo.CaretPos.Y], FListControlView.ExpressionDelimiters, FMemo.CaretPos.X);
end;

procedure TfrxListControlEditorForm.SetListControlView(const Value: TfrxCustomListControlView);
begin
  FListControlView := Value;
end;

procedure TfrxListControlEditorForm.UpdateFormPPI(aNewPPI: Integer);

  procedure UpdateToolbarPPI(Toolbar: TToolBar);
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

begin
  UpdateToolbarPPI(MainToolBar);
  UpdateToolbarPPI(ToolBar);
end;

procedure TfrxListControlEditorForm.UpdateResouces;
begin
  inherited UpdateResouces;

  TranslateControlsByTag(Self);

  LoadB.Hint := frxGet(3951);
  CancelB.Hint := frxGet(2);
  OkB.Hint := frxGet(1);
  ExprB.Hint := frxGet(3961);
  AggregateB.Hint := frxGet(3962);
end;

procedure TfrxListControlEditorForm.FormCreate(Sender: TObject);
begin
  if UseRightToLeftAlignment then
    FlipChildren(True);

  PageControl1.ActivePage := TextTS;
end;

procedure TfrxListControlEditorForm.AggregateBClick(Sender: TObject);
begin
  with TfrxSysMemoEditorForm.Create(Owner) do
  begin
    AggregateOnly := True;
    if ShowModal = mrOk then
      FMemo.SelText := Text;
    Free;
  end;
end;

procedure TfrxListControlEditorForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
    frxResources.Help(Self);
end;

{ TfrxItemsProperty }

function TfrxItemsProperty.Edit: Boolean;
begin
  with TfrxListControlEditorForm.Create(Designer) do
    try
      ListControlView := TfrxCustomListControlView(Component);
      Result := ShowModal = mrOk;
    finally
      Free;
    end;
end;

function TfrxItemsProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paDialog, paReadOnly];
end;

initialization

frxPropertyEditors.Register(TypeInfo(TWideStrings), TfrxCustomListControlView, 'Items', TfrxItemsProperty);

end.

