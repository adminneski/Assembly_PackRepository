
{******************************************}
{                                          }
{             FastReport VCL               }
{            Highlight editor              }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxEditHighlight;

interface

{$I frx.inc}

uses
  {$IFNDEF FPC}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, frxClass, ExtCtrls, Buttons, frxCtrls, frxBaseForm
  {$IFDEF FPC}
  , LResources, LCLType
  {$ENDIF}
{$IFDEF DELPHI6}
, Variants
{$ENDIF};
  

type
  TfrxHighlightEditorForm = class(TfrxBaseForm)
    OKB: TButton;
    CancelB: TButton;
    ConditionsGB: TGroupBox;
    HighlightsLB: TListBox;
    AddB: TButton;
    DeleteB: TButton;
    EditB: TButton;
    StyleGB: TGroupBox;
    FrameB: TSpeedButton;
    FrameCB: TCheckBox;
    FillCB: TCheckBox;
    FillB: TSpeedButton;
    FontCB: TCheckBox;
    FontB: TSpeedButton;
    VisibleCB: TCheckBox;
    UpB: TSpeedButton;
    DownB: TSpeedButton;
    FontDialog1: TFontDialog;
    PaintBox1: TPaintBox;
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure AddBClick(Sender: TObject);
    procedure EditBClick(Sender: TObject);
    procedure DeleteBClick(Sender: TObject);
    procedure HighlightsLBClick(Sender: TObject);
    procedure FrameCBClick(Sender: TObject);
    procedure FillCBClick(Sender: TObject);
    procedure FontCBClick(Sender: TObject);
    procedure VisibleCBClick(Sender: TObject);
    procedure FrameBClick(Sender: TObject);
    procedure FillBClick(Sender: TObject);
    procedure FontBClick(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure UpBClick(Sender: TObject);
    procedure DownBClick(Sender: TObject);
  private
    FMemoView: TfrxCustomMemoView;
    FHighlights: TfrxHighlightCollection;
    FCurHighlight: TfrxHighlight;
    procedure UpdateHighlights;
    procedure UpdateControls;
    procedure Change;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure UpdateResouces; override;
    procedure UpdateFormPPI(aNewPPI: Integer); override;
    property MemoView: TfrxCustomMemoView read FMemoView write FMemoView;
  end;


implementation

{$IFNDEF FPC}
{$R *.DFM}
{$ELSE}
{$R *.lfm}
{$ENDIF}

uses frxRes, frxEditFrame, frxEditFill, frxUtils, frDPIAwareUtils;


constructor TfrxHighlightEditorForm.Create(AOwner: TComponent);
begin
  FHighlights := TfrxHighlightCollection.Create;
  inherited;
  SetLength(FHostedControls, 2);
  FHostedControls[0] := ConditionsGB;
  FHostedControls[1] := StyleGB;
end;

destructor TfrxHighlightEditorForm.Destroy;
begin
  FHighlights.Free;
  inherited;
end;

procedure TfrxHighlightEditorForm.FormCreate(Sender: TObject);
begin
  if UseRightToLeftAlignment then
    FlipChildren(True);
end;

procedure TfrxHighlightEditorForm.FormShow(Sender: TObject);
begin
  FHighlights.Assign(FMemoView.Highlights);
  // skip default empty highlight condition
  if (FHighlights.Count = 1) and (FHighlights[0].Condition = '') then
    FHighlights.Clear;

  UpdateHighlights;
  // this will reset to -1 if no highlights
{$IFDEF FPC}
  if HighlightsLB.Count > 0 then
{$ELSE}
{$ENDIF}
  HighlightsLB.ItemIndex := 0;
  HighlightsLBClick(nil);
end;

procedure TfrxHighlightEditorForm.FormHide(Sender: TObject);
begin
  if ModalResult = mrOk then
  begin
    // create default empty highlight condition
    if FHighlights.Count = 0 then
      FHighlights.Add;
    FMemoView.Highlights.Assign(FHighlights);
  end;
end;

procedure TfrxHighlightEditorForm.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
    frxResources.Help(Self);
end;

procedure TfrxHighlightEditorForm.UpdateHighlights;
var
  i: Integer;
begin
  HighlightsLB.Items.Clear;
  for i := 0 to FHighlights.Count - 1 do
  begin
    HighlightsLB.Items.AddObject(FHighlights[i].Condition, FHighlights[i]);
  end;
end;

procedure TfrxHighlightEditorForm.UpdateResouces;
begin
  inherited;
  Caption := frxGet(4600);
  ConditionsGB.Caption := frxGet(4601);
  AddB.Caption := frxGet(4602);
  DeleteB.Caption := frxGet(4603);
  EditB.Caption := frxGet(4604);
  StyleGB.Caption := frxGet(4605);
  FrameB.Caption := frxGet(4606);
  FillB.Caption := frxGet(4607);
  FontB.Caption := frxGet(4608);
  VisibleCB.Caption := frxGet(4609);
  OKB.Caption := frxGet(1);
  CancelB.Caption := frxGet(2);
end;

procedure TfrxHighlightEditorForm.UpdateControls;
var
  e: Boolean;
begin
  e := FCurHighlight <> nil;
  DeleteB.Enabled := e;
  EditB.Enabled := e;
  UpB.Enabled := e;
  DownB.Enabled := e;
  FrameCB.Enabled := e;
  FillCB.Enabled := e;
  FontCB.Enabled := e;
  VisibleCB.Enabled := e;

  if e then
  begin
    FrameCB.Checked := FCurHighlight.ApplyFrame;
    FillCB.Checked := FCurHighlight.ApplyFill;
    FontCB.Checked := FCurHighlight.ApplyFont;
    VisibleCB.Checked := FCurHighlight.Visible;
    FrameB.Enabled := FCurHighlight.ApplyFrame;
    FillB.Enabled := FCurHighlight.ApplyFill;
    FontB.Enabled := FCurHighlight.ApplyFont;
    UpB.Enabled := HighlightsLB.ItemIndex > 0;
    DownB.Enabled := HighlightsLB.ItemIndex < HighlightsLB.Items.Count - 1;
  end
  else
  begin
    FrameB.Enabled := e;
    FillB.Enabled := e;
    FontB.Enabled := e;
  end;
end;

procedure TfrxHighlightEditorForm.UpdateFormPPI(aNewPPI: Integer);
begin
  inherited;
  frxImages.SetSpeedButtonGlyph(FrameB, 36);
  frxImages.SetSpeedButtonGlyph(FillB, 38);
  frxImages.SetSpeedButtonGlyph(FontB, 59);
  frxImages.SetSpeedButtonGlyph(UpB, 100);
  frxImages.SetSpeedButtonGlyph(DownB, 101);
end;

procedure TfrxHighlightEditorForm.Change;
begin
  PaintBox1.Repaint;
end;

procedure TfrxHighlightEditorForm.HighlightsLBClick(Sender: TObject);
var
  i: Integer;
begin
  i := HighlightsLB.ItemIndex;
  if i = -1 then
    FCurHighlight := nil
  else
    FCurHighlight := TfrxHighlight(HighlightsLB.Items.Objects[i]);
  UpdateControls;
  Change;
end;

procedure TfrxHighlightEditorForm.AddBClick(Sender: TObject);
var
  s: String;
  hl: TfrxHighlight;
begin
  s := TfrxCustomDesigner(Owner).InsertExpression('Value = 0');
  if s <> '' then
  begin
    hl := TfrxHighlight(FHighlights.Add);
    hl.Condition := s;
    HighlightsLB.Items.AddObject(s, hl);
    HighlightsLB.ItemIndex := HighlightsLB.Items.Count - 1;
    HighlightsLBClick(nil);
  end;
end;

procedure TfrxHighlightEditorForm.DeleteBClick(Sender: TObject);
var
  i: Integer;
begin
  i := HighlightsLB.ItemIndex;
  if i = -1 then
    Exit;
  TfrxHighlight(HighlightsLB.Items.Objects[i]).Free;
  HighlightsLB.Items.Delete(i);
  if i >= HighlightsLB.Items.Count then
    Dec(i);
  HighlightsLB.ItemIndex := i;
  HighlightsLBClick(nil);
end;

procedure TfrxHighlightEditorForm.EditBClick(Sender: TObject);
var
  i: Integer;
  s: String;
  hl: TfrxHighlight;
begin
  i := HighlightsLB.ItemIndex;
  if i = -1 then
    Exit;
  hl := TfrxHighlight(HighlightsLB.Items.Objects[i]);
  s := TfrxCustomDesigner(Owner).InsertExpression(hl.Condition);
  if s <> '' then
  begin
    hl.Condition := s;
    HighlightsLB.Items[i] := s;
  end;
end;

procedure TfrxHighlightEditorForm.UpBClick(Sender: TObject);
var
  i: Integer;
begin
  i := HighlightsLB.ItemIndex;
  HighlightsLB.Items.Move(i, i - 1);
  HighlightsLB.ItemIndex := i - 1;
  FCurHighlight.Index := i - 1;
  UpdateControls;
end;

procedure TfrxHighlightEditorForm.DownBClick(Sender: TObject);
var
  i: Integer;
begin
  i := HighlightsLB.ItemIndex;
  HighlightsLB.Items.Move(i, i + 1);
  HighlightsLB.ItemIndex := i + 1;
  FCurHighlight.Index := i + 1;
  UpdateControls;
end;

procedure TfrxHighlightEditorForm.FrameCBClick(Sender: TObject);
begin
  FCurHighlight.ApplyFrame := FrameCB.Checked;
  FrameB.Enabled := FCurHighlight.ApplyFrame;
  Change;
end;

procedure TfrxHighlightEditorForm.FillCBClick(Sender: TObject);
begin
  FCurHighlight.ApplyFill := FillCB.Checked;
  FillB.Enabled := FCurHighlight.ApplyFill;
  Change;
end;

procedure TfrxHighlightEditorForm.FontCBClick(Sender: TObject);
begin
  FCurHighlight.ApplyFont := FontCB.Checked;
  FontB.Enabled := FCurHighlight.ApplyFont;
  Change;
end;

procedure TfrxHighlightEditorForm.VisibleCBClick(Sender: TObject);
begin
  FCurHighlight.Visible := VisibleCB.Checked;
  Change;
end;

procedure TfrxHighlightEditorForm.FrameBClick(Sender: TObject);
begin
  with TfrxFrameEditorForm.Create(nil) do
  begin
    Frame := FCurHighlight.Frame;
    if ShowModal = mrOk then
    begin
      FCurHighlight.Frame := Frame;
      Change;
    end;
    Free;
  end;
end;

procedure TfrxHighlightEditorForm.FillBClick(Sender: TObject);
begin
  with TfrxFillEditorForm.Create(nil) do
  begin
    Fill := FCurHighlight.Fill;
    if ShowModal = mrOk then
    begin
      FCurHighlight.Fill := Fill;
      Change;
    end;
    Free;
  end;
end;

procedure TfrxHighlightEditorForm.FontBClick(Sender: TObject);
var
  ctx: FRX_DPI_AWARENESS_CONTEXT;
begin
  FontDialog1.Font := FCurHighlight.Font;
  { awoid common Dialogs bug with HiDPi Per monitor v2 }
  ctx := frxGetThreadDpiAwarenessContext;
  frxSetThreadDpiAwarenessContext(FRX_DPI_AWARENESS_CONTEXT_UNAWARE_GDISCALED);
  try
    if not FontDialog1.Execute then
      Exit;
  finally
    frxSetThreadDpiAwarenessContext(ctx);
  end;
  FCurHighlight.Font := FontDialog1.Font;
  Change;
end;

procedure TfrxHighlightEditorForm.PaintBox1Paint(Sender: TObject);
var
  m: TfrxMemoView;
  lScale: Single;
begin
  PaintBox1.Canvas.FillRect(Rect(0, 0, PaintBox1.Width - 1, PaintBox1.Height - 1));
  if FCurHighlight <> nil then
  begin
    lScale := CurrentFormPPI / frx_DefaultPPI;
    m := TfrxMemoView.Create(nil);
    m.Text := 'Sample';
    m.HAlign := haCenter;
    m.VAlign := vaCenter;
    m.ApplyHighlight(FCurHighlight);
    m.SetBounds(2, 2, Round(PaintBox1.Width / lScale) - 4, Round(PaintBox1.Height / lScale) - 4);
    m.Draw(PaintBox1.Canvas, lScale, lScale, 0, 0);
    m.Free;
  end;
end;

end.

