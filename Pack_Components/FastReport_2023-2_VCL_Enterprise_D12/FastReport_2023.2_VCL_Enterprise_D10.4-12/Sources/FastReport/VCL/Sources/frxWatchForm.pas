
{******************************************}
{                                          }
{             FastReport VCL               }
{            Watches toolwindow            }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxWatchForm;

interface

{$I frx.inc}

uses
  {$IFNDEF FPC}
  Windows, Messages,
  {$ELSE}
  LCLType,
  {$ENDIF}
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, ComCtrls,
  CheckLst, StdCtrls, ToolWin, Variants, Grids,
  fs_iinterpreter, frxBaseForm, frxDock;

type
  TfrxWatchForm = class({$IFDEF FPC}TfrxBaseForm{$ELSE}TfrxDockForm{$ENDIF})
    ToolBar1: TToolBar;
    AddB: TToolButton;
    DeleteB: TToolButton;
    EditB: TToolButton;
    WatchLBCB: TCheckListBox;
    ListTB: TTabControl;
    WatchLB: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure AddBClick(Sender: TObject);
    procedure DeleteBClick(Sender: TObject);
    procedure EditBClick(Sender: TObject);
    procedure WatchLBCBClickCheck(Sender: TObject);
    procedure ListTBChange(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    FScript: TfsScript;
    FScriptRunning: Boolean;
    FWatches: TStrings;
    function CalcWatch(const s: String): String;
  public
    procedure SetColor(const Value: TColor);
    procedure UpdateWatches;
    procedure UpdateResouces; override;
    procedure UpdateFormPPI(aNewPPI: Integer); override;
    property Script: TfsScript read FScript write FScript;
    property ScriptRunning: Boolean read FScriptRunning write FScriptRunning;
    property Watches: TStrings read FWatches;
  end;


implementation
{$IFDEF FPC}
{$R *.lfm}
{$ELSE}
{$R *.DFM}
{$ENDIF}

uses frxRes, frxEvaluateForm, Math;
{$IFNDEF FPC}
type
  THackWinControl = class(TWinControl);
{$ENDIF}


procedure TfrxWatchForm.FormCreate(Sender: TObject);
begin
  FWatches := TStringList.Create;
{$IFDEF UseTabset}
  WatchLBCB.BevelKind := bkFlat;
{$ELSE}
  WatchLBCB.BorderStyle := bsSingle;
{$ENDIF}

  if UseRightToLeftAlignment then
    FlipChildren(True);
end;

procedure TfrxWatchForm.FormDestroy(Sender: TObject);
begin
  FWatches.Free;
end;

procedure TfrxWatchForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    frxResources.Help(Self);
end;

procedure TfrxWatchForm.AddBClick(Sender: TObject);
begin
  with TfrxEvaluateForm.Create(Owner) do
  begin
    IsWatch := True;
    if ShowModal = mrOk then
    begin
      //Watches.Add(ExpressionE.Text);
      Watches.AddObject(ExpressionE.Text, TObject(1));
      UpdateWatches;
    end;
    Free;
  end;
end;

procedure TfrxWatchForm.DeleteBClick(Sender: TObject);
begin
  if WatchLBCB.ItemIndex <> -1 then
  begin
    Watches.Delete(WatchLBCB.ItemIndex);
    UpdateWatches;
  end;
end;

procedure TfrxWatchForm.EditBClick(Sender: TObject);
begin
  if WatchLBCB.ItemIndex <> -1 then
    with TfrxEvaluateForm.Create(Owner) do
    begin
      IsWatch := True;
      ExpressionE.Text := Watches[WatchLBCB.ItemIndex];
      if ShowModal = mrOk then
      begin
        Watches[WatchLBCB.ItemIndex] := ExpressionE.Text;
        UpdateWatches;
      end;
      Free;
    end;
end;

function TfrxWatchForm.CalcWatch(const s: String): String;
var
  v: Variant;
begin
  if (FScript <> nil) and (FScriptRunning) then
  begin
    v := FScript.Evaluate(s);
    Result := VarToStr(v);
    if TVarData(v).VType = varBoolean then
      if Boolean(v) = True then
        Result := 'True' else
        Result := 'False'
    else if (TVarData(v).VType = varString) or (TVarData(v).VType = varOleStr)
    {$IFDEF DELPHI12}or (TVarData(v).VType = varUString){$ENDIF} then
      Result := '''' + v + ''''
    else if v = Null then
      Result := 'Null';
  end
  else
    Result := frxGet(6590);
end;

procedure TfrxWatchForm.UpdateFormPPI;

  procedure AssignToolbarSize(aToolB: TToolBar; aImgList: TImageList);
  begin
    aToolB.ButtonWidth := aImgList.Width;
    aToolB.ButtonHeight := aImgList.Height;
  end;
begin
  inherited;
  Toolbar1.Images := frxImages.MainButtonImages;
  AssignToolbarSize(ToolBar1, frxImages.MainButtonImages);
end;

procedure TfrxWatchForm.UpdateResouces;
begin
  inherited;
  Caption := frxGet(2481);
  AddB.Hint := frxGet(5901);
  DeleteB.Hint := frxGet(5902);
  EditB.Hint := frxGet(5903);
  ListTB.Tabs[0] := frxGet(6591);
  ListTB.Tabs[1] := frxGet(6592);
  WatchLB.Cells[0, 0] := frxResources.Get('qpName');
  WatchLB.Cells[1, 0] := frxGet(3002);
  WatchLB.Cells[2, 0] := frxResources.Get('qpValue');
end;

procedure TfrxWatchForm.UpdateWatches;
  procedure FillWatches;
  var
  i: Integer;
  begin
    WatchLBCB.Items.BeginUpdate;
    WatchLBCB.Items.Clear;
    for i := 0 to Watches.Count - 1 do
    begin
      if Watches.Objects[i] = TObject(1) then
        WatchLBCB.Items.Add(Watches[i] + ': ' + CalcWatch(Watches[i]))
      else
        WatchLBCB.Items.Add(Watches[i] + ': ' + frxGet(6589));
{$IFDEF FPC}
      WatchLBCB.Checked[i] := Boolean(PtrInt(Watches.Objects[i]));
{$ELSE}
      WatchLBCB.Checked[i] := Boolean(Watches.Objects[i]);
{$ENDIF}
    end;
    WatchLBCB.Items.EndUpdate;
  end;

  procedure FillLocal;
  var
    i: Integer;
    v: TfsVariable;
    lst: TStrings;
  begin
    WatchLB.RowCount := 1;
    WatchLB.Rows[1].Clear;
    if Assigned(Script) and Assigned(Script.ProgRunning) then
      for i := 0 to Script.ProgRunning.Count - 1 do
      begin
        if Script.ProgRunning.Items[i] is TfsVariable then
        begin
          WatchLB.RowCount := WatchLB.RowCount + 1;
          lst := WatchLB.Rows[WatchLB.RowCount - 1];
          lst.BeginUpdate;
          lst.Clear;
          v := TfsVariable(Script.ProgRunning.Items[i]);
          lst.AddObject(v.Name, v);
          lst.AddObject(v.TypeName, v);
          lst.AddObject(VarToStr(v.Value), v);
          lst.EndUpdate;
        end;
      end;
    if WatchLB.RowCount = 1 then
      WatchLB.RowCount := 2;
    WatchLB.FixedRows := 1;
  end;
begin
  AddB.Enabled := (ListTB.TabIndex = 0);
  DeleteB.Enabled := AddB.Enabled;
  EditB.Enabled := AddB.Enabled;
  WatchLB.Visible := (ListTB.TabIndex = 1);
  WatchLBCB.Visible := (ListTB.TabIndex = 0);
  if ListTB.TabIndex = 0 then
    FillWatches
  else
    FillLocal;
end;

procedure TfrxWatchForm.WatchLBCBClickCheck(Sender: TObject);
var
  Bool: Boolean;
begin
  if (WatchLBCB.ItemIndex <> -1) then
  begin
{$IFDEF FPC}
    Bool := Boolean(PtrInt(Watches.Objects[WatchLBCB.ItemIndex]));
    Watches.Objects[WatchLBCB.ItemIndex] := TObject(PtrInt(not Bool));
{$ELSE}
    Bool := Boolean(Watches.Objects[WatchLBCB.ItemIndex]);
    Watches.Objects[WatchLBCB.ItemIndex] := TObject(not Bool);
{$ENDIF}
    UpdateWatches;
  end;
end;

procedure TfrxWatchForm.ListTBChange(Sender: TObject);
begin
  UpdateWatches;
end;

procedure TfrxWatchForm.SetColor(const Value: TColor);
begin
  WatchLBCB.Color := Value;
  WatchLB.Color := Value;
{$IFDEF DELPHI19}
  WatchLB.StyleElements := [seFont, seBorder];
{$ENDIF}
  WatchLB.Options := WatchLB.Options + [goColSizing];
end;

procedure TfrxWatchForm.FormResize(Sender: TObject);
begin
  WatchLB.ColWidths[2] := WatchLB.Width -  WatchLB.ColWidths[0] -  WatchLB.ColWidths[1];
end;

end.
