
{******************************************}
{                                          }
{             FastReport VCL               }
{           DisplayFormat editor           }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxEditFormat;

interface

{$I frx.inc}

uses
  {$IFNDEF FPC}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, frxClass, frxBaseForm
  {$IFDEF FPC}
  , LResources, LCLType
  {$ENDIF}
{$IFDEF DELPHI6}
, Variants
{$ENDIF};


type
  TfrxFormatEditorForm = class(TfrxBaseForm)
    OkB: TButton;
    CancelB: TButton;
    CategoryLB: TListBox;
    FormatLB: TListBox;
    GroupBox1: TGroupBox;
    FormatStrL: TLabel;
    SeparatorL: TLabel;
    FormatE: TEdit;
    SeparatorE: TEdit;
    ComboBox1: TComboBox;
    ExpressionL: TLabel;
    CategoryL: TLabel;
    FormatL: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure CategoryLBClick(Sender: TObject);
    procedure FormatLBDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure FormatLBClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ComboBox1Change(Sender: TObject);
  private
    { Private declarations }
    FMemo: TfrxCustomMemoView;
    FMemoText: WideString;
    FFormats: TfrxFormatCollection;
    FCurFormat: TfrxFormat;
    procedure FillFormats;
    procedure SetMemo(Value: TfrxCustomMemoView);
    procedure UpdateCurFormat;
    procedure UpdateControls;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure UpdateResouces; override;
    property Memo: TfrxCustomMemoView read FMemo write SetMemo;
    property MemoText: WideString read FMemoText write FMemoText;
  end;


implementation

{$IFNDEF FPC}
{$R *.DFM}
{$ELSE}
{$R *.lfm}
{$ENDIF}

uses frxRes, frxUtils;

const
  CategoryNames: array[0..3] of String =
    ('fkText', 'fkNumber', 'fkDateTime', 'fkBoolean');


constructor TfrxFormatEditorForm.Create(AOwner: TComponent);
begin
  inherited;
  FFormats := TfrxFormatCollection.Create;
  SetLength(FHostedControls, 7);
  FHostedControls[0] := CategoryL;
  FHostedControls[1] := CategoryLB;
  FHostedControls[2] := FormatL;
  FHostedControls[3] := FormatLB;
  FHostedControls[4] := GroupBox1;
  FHostedControls[5] := ComboBox1;
  FHostedControls[6] := ExpressionL;
end;

destructor TfrxFormatEditorForm.Destroy;
begin
  FFormats.Free;
  inherited;
end;

procedure TfrxFormatEditorForm.FormShow(Sender: TObject);

  procedure FillCategory;
  var
    i: Integer;
  begin
    CategoryLB.Items.Clear;
    for i := 0 to 3 do
      CategoryLB.Items.Add(frxResources.Get(CategoryNames[i]));
  end;

begin
  FillFormats;
  FillCategory;
  ComboBox1.ItemIndex := 0;
  FCurFormat := FFormats[0];
  UpdateControls;
end;

procedure TfrxFormatEditorForm.FormHide(Sender: TObject);
begin
  if ModalResult = mrOk then
  begin
    UpdateCurFormat;
    FMemo.Formats.Assign(FFormats);
  end;
end;

procedure TfrxFormatEditorForm.CategoryLBClick(Sender: TObject);
var
  i, n: Integer;
  s: String;
begin
  FormatLB.Items.Clear;
  n := CategoryLB.ItemIndex;
  FormatE.Enabled := n > 0;
  FormatStrL.Enabled := n > 0;
  SeparatorE.Enabled := n = 1;
  SeparatorL.Enabled := n = 1;

  if (n = 0) or (n = 4) or (n = -1) then
    Exit;

  for i := 1 to 10 do
  begin
    s := frxResources.Get(CategoryNames[n] + IntToStr(i));
    if Pos('fk', s) = 0 then
      FormatLB.Items.Add(s);
  end;
end;

procedure TfrxFormatEditorForm.FormatLBClick(Sender: TObject);
var
  s: String;
begin
  if FormatLB.ItemIndex = -1 then
    Exit;
  s := FormatLB.Items[FormatLB.ItemIndex];
  FormatE.Text := Copy(s, Pos(';', s) + 1, 255);
end;

procedure TfrxFormatEditorForm.FormatLBDrawItem(Control: TWinControl;
  Index: Integer; ARect: TRect; State: TOwnerDrawState);
var
  s: String;
begin
  with FormatLB do
  begin
    Canvas.FillRect(ARect);
    s := Items[Index];
    if Pos(';', s) <> 0 then
      s := Copy(s, 1, Pos(';', s) - 1);
    Canvas.TextOut(ARect.Left + 2, ARect.Top, s);
  end;
end;

procedure TfrxFormatEditorForm.FormCreate(Sender: TObject);
begin
  if UseRightToLeftAlignment then
    FlipChildren(True);
end;

procedure TfrxFormatEditorForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    frxResources.Help(Self);
end;

procedure TfrxFormatEditorForm.FillFormats;
var
  i, j, nFormats: Integer;
  s, s1, dc1, dc2: WideString;
  fmt: TfrxFormat;
  hasFormats: Boolean;
begin
  FFormats.Assign(FMemo.Formats);
  ComboBox1.Items.Clear;

  s := MemoText;
  i := 1;
  dc1 := FMemo.ExpressionDelimiters;
  dc2 := Copy(dc1, Pos(',', dc1) + 1, 255);
  dc1 := Copy(dc1, 1, Pos(',', dc1) - 1);
  nFormats := 0;
  if Pos(dc1, s) <> 0 then
  begin
    repeat
      while (i < Length(s)) and (Copy(s, i, Length(dc1)) <> dc1) do Inc(i);

      s1 := frxGetBrackedVariableW(s, dc1, dc2, i, j);
      if i <> j then
      begin
        Delete(s, i, j - i + 1);
        j := 0;
        if nFormats < FFormats.Count then
          fmt := FFormats[nFormats]
        else
          fmt := TfrxFormat.Create(FFormats);
        ComboBox1.Items.AddObject(dc1 + s1 + dc2, fmt);
        Inc(nFormats);
      end;
    until i = j;
  end;

  while nFormats < FFormats.Count do
    FFormats.Delete(FFormats.Count - 1);

  hasFormats := nFormats > 0;
  ComboBox1.Enabled := hasFormats;
  ExpressionL.Enabled := hasFormats;

  if not hasFormats then
  begin
    FFormats.Add;
    FFormats[0].Assign(FMemo.DisplayFormat);
    FCurFormat := FFormats[0];
  end;
end;

procedure TfrxFormatEditorForm.SetMemo(Value: TfrxCustomMemoView);
begin
  FMemo := Value;
  FMemoText := FMemo.Text;
end;

procedure TfrxFormatEditorForm.UpdateCurFormat;
var
  s: String;
begin
  if FCurFormat = nil then Exit;

  FCurFormat.Kind := TfrxFormatKind(CategoryLB.ItemIndex);
  if FCurFormat.Kind = fkText then
    FCurFormat.FormatStr := ''
  else
    FCurFormat.FormatStr := FormatE.Text;
  s := SeparatorE.Text;
  if s = '' then
    FCurFormat.DecimalSeparator := ''
  else
    FCurFormat.DecimalSeparator := s[1];
  if FCurFormat.Kind = fkText then
    begin
      FCurFormat.DecimalSeparator := '';
      FCurFormat.ThousandSeparator := '';
    end;
end;

procedure TfrxFormatEditorForm.UpdateResouces;
begin
  inherited;
  Caption := frxGet(4500);
  CategoryL.Caption := frxGet(4501);
  FormatL.Caption := frxGet(4502);
  FormatStrL.Caption := frxGet(4503);
  SeparatorL.Caption := frxGet(4504);
  ExpressionL.Caption := frxGet(4401);
  OkB.Caption := frxGet(1);
  CancelB.Caption := frxGet(2);
end;

procedure TfrxFormatEditorForm.UpdateControls;

  procedure FindFormat;
  var
    i: Integer;
    s: String;
  begin
    for i := 0 to FormatLB.Items.Count - 1 do
    begin
      s := FormatLB.Items[i];
      if Copy(s, Pos(';', s) + 1, 255) = FCurFormat.FormatStr then
        FormatLB.ItemIndex := i;
    end;
  end;

begin
  CategoryLB.ItemIndex := Integer(FCurFormat.Kind);
  CategoryLBClick(Self);
  FindFormat;
  FormatE.Text := FCurFormat.FormatStr;
  SeparatorE.Text := FCurFormat.DecimalSeparator;
end;

procedure TfrxFormatEditorForm.ComboBox1Change(Sender: TObject);
begin
  UpdateCurFormat;
  FCurFormat := TfrxFormat(ComboBox1.Items.Objects[ComboBox1.ItemIndex]);
  UpdateControls;
end;

end.
