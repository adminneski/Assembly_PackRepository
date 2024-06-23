
{******************************************}
{                                          }
{             FastReport v5.0              }
{              Picture editor              }
{                                          }
{         Copyright (c) 1998-2020          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit frxHTMLEditor;

interface

{$I frx.inc}

{$IfNDef FPC}
  {$Define UseMetaFile }
{$EndIf}

uses
  SysUtils,
  {$IFNDEF FPC}
  Windows, Messages,
  {$ENDIF}
  Classes, Graphics, Controls, Forms, Dialogs, Buttons, ExtCtrls, ComCtrls,
  frxClass, frxBaseFormEditorDataTree, frxHTML, frxHtmlViewer

  {$IFDEF FPC}
  , LCLType, LazHelper, StdCtrls, ColorBox, frxCtrls
  {$ELSE}
  , StdCtrls , ToolWin, frxCtrls, frxDock
  {$ENDIF}
  ;

type
  TfrxHTMLEditorForm = class(TfrxBaseFormEditorDataTree)
    MainToolBar: TToolBar;
    LoadB: TToolButton;
    OkB: TToolButton;
    ToolButton1: TToolButton;
    CancelB: TToolButton;
    PageControl1: TPageControl;
    SourceTabSheet: TTabSheet;
    HTMLTabSheet: TTabSheet;
    SourceToolBar: TToolBar;
    ExprB: TToolButton;
    AggregateB: TToolButton;
    WordWrapB: TToolButton;
    HTMLPaintBox: TPaintBox;
    HTMLToolBar: TToolBar;
    WidthToolButton: TToolButton;
    ControlSizeToolButton: TToolButton;
    DefaultTabSheet: TTabSheet;
    DefBackgroundColorBox: TColorBox;
    DefBackgroundLabel: TLabel;
    DefFontColorColorBox: TColorBox;
    DefFontColorLabel: TLabel;
    DefFontNameLabel: TLabel;
    DefFontNameComboBox: TfrxFontComboBox;
    DefFontSizeLabel: TLabel;
    DefFontSizeComboBox: TfrxComboBox;
    DefHotSpotColorColorBox: TColorBox;
    DefHotSpotColorLabel: TLabel;
    DefPreFontNameComboBox: TfrxFontComboBox;
    DefPreFontNameLabel: TLabel;
    MarginWidthLabel: TLabel;
    MarginWidthEdit: TEdit;
    MarginWidthUpDown: TUpDown;
    MarginHeightEdit: TEdit;
    MarginHeightUpDown: TUpDown;
    MarginHeightLabel: TLabel;
    OpenDialog: TOpenDialog;
    procedure CancelBClick(Sender: TObject);
    procedure LoadBClick(Sender: TObject);
    procedure OkBClick(Sender: TObject);

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    procedure MemoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure WordWrapBClick(Sender: TObject);
    procedure AggregateBClick(Sender: TObject);
    procedure ExprBClick(Sender: TObject);
    procedure HTMLPaintBoxPaint(Sender: TObject);
    procedure WidthToolButtonClick(Sender: TObject);
    procedure DefFontSizeComboBoxKeyPress(Sender: TObject; var Key: Char);
    procedure ExprMemoDragDrop(Sender, Source: TObject; X, Y: Integer);

    procedure SetViewerByForm;
    procedure SetFormByViewer;
  private
    FHtmlView: TfrxHtmlView;
    FViewer: TfrxHtmlViewer;
    FMemo: TMemo;
    FGraphic: TGraphic;
    FFileName: String;

    procedure SetHtmlView(const AHtmlView: TfrxHtmlView);
  protected
    procedure OnDataTreeDblClick(Sender: TObject); override;
  public
    procedure UpdateResouces; override;
    procedure UpdateFormPPI(aNewPPI: Integer); override;

    property HtmlView: TfrxHtmlView write SetHtmlView;
  end;

implementation

{$R *.dfm}

uses
  ClipBrd, Math,
  frxRes, frxDsgnIntf, frxCustomEditors, frxUnicodeCtrls, frxEditSysMemo, frxHelpers;

const
  mpAllowExpressions = 1;

type
  TfrxHTMLEditor = class(TfrxViewEditor)
  private
  public
    function Edit: Boolean; override;
    function HasEditor: Boolean; override;
    procedure GetMenuItems; override;
    function Execute(Tag: Integer; Checked: Boolean): Boolean; override;
  end;

{ TfrxHTMLEditor }

function TfrxHTMLEditor.Edit: Boolean;
var
  Form: TfrxHTMLEditorForm;
begin
  Form := TfrxHTMLEditorForm.Create(Designer);
  try
    Form.HtmlView := TfrxHtmlView(Component);
    Result := Form.ShowModal = mrOk;
  finally
    Form.Free;
  end;
end;

function TfrxHTMLEditor.Execute(Tag: Integer; Checked: Boolean): Boolean;
var
  i: Integer;
  c: TfrxComponent;
  v: TfrxHtmlView;
begin
  Result := inherited Execute(Tag, Checked);

  for i := 0 to Designer.SelectedObjects.Count - 1 do
  begin
    c := Designer.SelectedObjects[i];
    if (c is TfrxHtmlView) and not (rfDontModify in c.Restrictions) then
    begin
      v := TfrxHtmlView(c);
      case Tag of
        mpAllowExpressions: v.AllowExpressions := Checked;
      end;
      Result := True;
    end;
  end;
end;

procedure TfrxHTMLEditor.GetMenuItems;
var
  v: TfrxHtmlView;
begin
  AddItem(frxResources.Get('mvHyperlink'), 50);
  AddItem('-', -1);
  v := TfrxHtmlView(Component);
  AddItem(frxResources.Get('mvExpr'), mpAllowExpressions, v.AllowExpressions);

  inherited GetMenuItems;
end;

function TfrxHTMLEditor.HasEditor: Boolean;
begin
  Result := True;
end;

{ TfrxHTMLEditorForm }

procedure TfrxHTMLEditorForm.AggregateBClick(Sender: TObject);
begin
  with TfrxSysMemoEditorForm.Create(Owner) do
  begin
    AggregateOnly := True;
    if ShowModal = mrOk then
      FMemo.SelText := Text;
    Free;
  end;
end;

procedure TfrxHTMLEditorForm.CancelBClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrxHTMLEditorForm.DefFontSizeComboBoxKeyPress(Sender: TObject; var Key: Char);
begin
  case Key of
    Chr(VK_BACK), '0'..'9':
      ;
  else
    key := Chr(0);
  end;
end;

procedure TfrxHTMLEditorForm.ExprMemoDragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  MemoDragDrop(FMemo, FDataTree, X, Y, FHtmlView.ExpressionDelimiters);
end;

procedure TfrxHTMLEditorForm.ExprBClick(Sender: TObject);
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
    s1 := FHtmlView.ExpressionDelimiters;
    s2 := Copy(s1, Pos(',', s1) + 1, 255);
    s1 := Copy(s1, 1, Pos(',', s1) - 1);
    if (s[1] = '<') and (s[Length(s)] = '>') and (BracketCount = 1) then
      s := Copy(s, 2, Length(s) - 2);
    FMemo.SelText := s1 + s + s2;
  end;
end;

procedure TfrxHTMLEditorForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FGraphic.Free;
end;

procedure TfrxHTMLEditorForm.FormCreate(Sender: TObject);
begin
  if UseRightToLeftAlignment then
    FlipChildren(True);

  PageControl1.ActivePage := SourceTabSheet;
end;

procedure TfrxHTMLEditorForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
    frxResources.Help(Self);
end;

procedure TfrxHTMLEditorForm.FormShow(Sender: TObject);
begin
  FMemo := TUnicodeMemo.Create(Self);

  with FMemo do
  begin
    Parent := SourceTabSheet;
    Align := alClient;
    ScrollBars := ssBoth;
    TabOrder := 1;
    OnKeyDown := MemoKeyDown;
    OnDragOver := ExprMemoDragOver;
    OnDragDrop := ExprMemoDragDrop;
  end;

  Icon := TForm(Owner).Icon;
  WordWrapBClick(nil);

  with TfrxCustomDesigner(Owner) do
    if UseObjectFont then
    begin
      FMemo.Font.Name := 'Courier New';
      FMemo.Font.Size := 12;
    end
    else
    begin
      FMemo.Font.Name := MemoFontName;
      FMemo.Font.Size := MemoFontSize;
    end;

  SetFormByViewer;

  FMemo.SetFocus;
  {$IFNDEF FPC}
  FMemo.Perform(EM_SETSEL, 0, 0);
  FMemo.Perform(EM_SCROLLCARET, 0, 0);
  {$ENDIF}
end;

procedure TfrxHTMLEditorForm.HTMLPaintBoxPaint(Sender: TObject);
var
  PictureHeight, ControlWidth, ControlHeight: Integer;
  OldText: WideString;
  OldDefBackground, OldDefFontColor, OldDefHotSpotColor: TColor;
  OldDefFontName, OldDefPreFontName: TFontName;
  OldMarginWidth, OldMarginHeight: Integer;
  OldDefFontSize: Double;
begin
  OldText := FViewer.Text;
  OldDefBackground := FViewer.DefBackground;
  OldDefFontColor := FViewer.DefFontColor;
  OldDefFontName := FViewer.DefFontName;
  OldDefFontSize := FViewer.DefFontSize;
  OldDefHotSpotColor := FViewer.DefHotSpotColor;
  OldDefPreFontName := FViewer.DefPreFontName;
  OldMarginWidth := FViewer.MarginWidth;
  OldMarginHeight := FViewer.MarginHeight;

  try
    SetViewerByForm;

    if WidthToolButton.Down then
      FViewer.Width := Round(FHtmlView.Width)
    else
      FViewer.Width := HTMLPaintBox.Width;

    PictureHeight := Min(HTMLPaintBox.Height,
                     FViewer.FullDisplaySize(FViewer.Width).cy);

    FGraphic.Free;
  {$IfDef UseMetaFile}
    FGraphic := FViewer.MakeMetaFile(0, FViewer.Width, FViewer.Width, PictureHeight);
  {$Else}
    FGraphic := FViewer.MakeBitmap(0, FViewer.Width, FViewer.Width, PictureHeight);
  {$EndIf}


    HTMLPaintBox.Canvas.Lock;
    try
      HTMLPaintBox.Canvas.Draw(0, 0, FGraphic);

      if ControlSizeToolButton.Down then
      begin
        HTMLPaintBox.Canvas.Pen.Style := psDot;
        ControlHeight := Round(FHtmlView.Height);
        ControlWidth := Round(FHtmlView.Width);
        HTMLPaintBox.Canvas.MoveTo(ControlWidth, 0);
        HTMLPaintBox.Canvas.LineTo(ControlWidth, ControlHeight);
        HTMLPaintBox.Canvas.LineTo(0           , ControlHeight);
      end;
    finally
      HTMLPaintBox.Canvas.Unlock;
    end;

  finally
    FViewer.LoadFromString(OldText, FFileName);
    FViewer.DefBackground := OldDefBackground;
    FViewer.DefFontColor := OldDefFontColor;
    FViewer.DefFontName := OldDefFontName;
    FViewer.DefFontSize := OldDefFontSize;
    FViewer.DefHotSpotColor := OldDefHotSpotColor;
    FViewer.DefPreFontName := OldDefPreFontName;
    FViewer.MarginWidth := OldMarginWidth;
    FViewer.MarginHeight := OldMarginHeight;
  end;
end;

procedure TfrxHTMLEditorForm.LoadBClick(Sender: TObject);
begin
  if OpenDialog.Execute then
  begin
    FMemo.Lines.LoadFromFile(OpenDialog.FileName);
    FFileName := OpenDialog.FileName;
  end;
end;

procedure TfrxHTMLEditorForm.MemoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = Ord('A')) and (Shift = [ssCtrl]) then
    FMemo.SelectAll;
end;

procedure TfrxHTMLEditorForm.OkBClick(Sender: TObject);
begin
  ModalResult := mrOk;
  SetViewerByForm;
end;

procedure TfrxHTMLEditorForm.SetFormByViewer;
begin
  TUnicodeMemo(FMemo).Text := FViewer.Text;
  DefBackgroundColorBox.Selected := FViewer.DefBackground;
  DefFontColorColorBox.Selected := FViewer.DefFontColor;
  DefFontNameComboBox.Text := FViewer.DefFontName;
  DefFontSizeComboBox.Text := IntToStr(Round(FViewer.DefFontSize * Screen.PixelsPerInch / 96.0));
  DefHotSpotColorColorBox.Selected := FViewer.DefHotSpotColor;
  DefPreFontNameComboBox.Text := FViewer.DefPreFontName;
  MarginWidthUpDown.Position := FViewer.MarginWidth;
  MarginHeightUpDown.Position := FViewer.MarginHeight;
end;

procedure TfrxHTMLEditorForm.SetHtmlView(const AHtmlView: TfrxHtmlView);
begin
  FHtmlView := AHtmlView;
  FViewer := FHtmlView.HtmlViewer;
end;

procedure TfrxHTMLEditorForm.OnDataTreeDblClick(Sender: TObject);
begin
  if PageControl1.TabIndex = 0 then
    FMemo.SelText := GetExpText(FDataTree.GetFieldName, FMemo.Lines[FMemo.CaretPos.Y], FHtmlView.ExpressionDelimiters, FMemo.CaretPos.X);
end;

procedure TfrxHTMLEditorForm.SetViewerByForm;
begin
  FViewer.DefBackground := DefBackgroundColorBox.Selected;
  FViewer.DefFontColor := DefFontColorColorBox.Selected;
  FViewer.DefFontName := DefFontNameComboBox.Text;
  FViewer.DefFontSize := StrToInt(DefFontSizeComboBox.Text);
  FViewer.DefHotSpotColor := DefHotSpotColorColorBox.Selected;
  FViewer.DefPreFontName := DefPreFontNameComboBox.Text;
  FViewer.MarginWidth := MarginWidthUpDown.Position;
  FViewer.MarginHeight := MarginHeightUpDown.Position;
  FViewer.LoadFromString(FMemo.Text, FFileName); // Must be last
end;

procedure TfrxHTMLEditorForm.WidthToolButtonClick(Sender: TObject);
begin
  HTMLPaintBox.Invalidate;
end;

procedure TfrxHTMLEditorForm.UpdateFormPPI(aNewPPI: Integer);

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
  UpdateToolbarPPI(SourceToolBar);
  UpdateToolbarPPI(HTMLToolBar);
end;

procedure TfrxHTMLEditorForm.UpdateResouces;
begin
  inherited UpdateResouces;

  TranslateControlsByTag(Self);
//  Caption := frxGet(3850);
  LoadB.Hint := frxGet(3851);
  CancelB.Hint := frxGet(2);
  OkB.Hint := frxGet(1);

//  SourceTabSheet.Caption := frxGet(3860);
  ExprB.Hint := frxGet(3861);
  AggregateB.Hint := frxGet(3862);
  WordWrapB.Hint := frxGet(3864);

//  HTMLTabSheet.Caption := frxGet(3870);
  WidthToolButton.Hint := frxGet(3871);
  ControlSizeToolButton.Hint := frxGet(3872);

//  DefaultTabSheet.Caption := frxGet(3880);
end;

procedure TfrxHTMLEditorForm.WordWrapBClick(Sender: TObject);
var
  s: {$IFDEF FPCUNICODE}String{$ELSE}WideString{$ENDIF};
begin
  s := TUnicodeMemo(FMemo).Text;

  FMemo.WordWrap := WordWrapB.Down;
  if FMemo.WordWrap then
    FMemo.ScrollBars := ssVertical
  else
    FMemo.ScrollBars := ssBoth;

  TUnicodeMemo(FMemo).Text := s;
end;

initialization

  frxComponentEditors.Register(TfrxHtmlView, TfrxHTMLEditor);

end.

