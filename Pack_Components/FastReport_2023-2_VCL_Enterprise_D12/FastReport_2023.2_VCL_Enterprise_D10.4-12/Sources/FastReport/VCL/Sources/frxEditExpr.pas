
{******************************************}
{                                          }
{             FastReport VCL               }
{            Expression Editor             }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxEditExpr;

interface

{$I frx.inc}

uses
  {$IFNDEF FPC}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, frxClass, ExtCtrls, Buttons, frxDataTree, frxBaseForm
  {$IFDEF FPC}
  , LCLType
  {$ELSE}
  , ImgList
  {$ENDIF}
{$IFDEF DELPHI6}
, Variants
{$ENDIF};


type
  TfrxExprEditorForm = class(TfrxBaseLoadSavePrefForm)
    ExprMemo: TMemo;
    Panel1: TPanel;
    OkB: TButton;
    CancelB: TButton;
    Splitter1: TSplitter;
    Panel2: TPanel;
    ExprL: TLabel;
    Panel: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure ExprMemoDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ExprMemoDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormResize(Sender: TObject);
  private
    FDataTree: TfrxDataTreeForm;
    FReport: TfrxReport;
    procedure OnDataTreeDblClick(Sender: TObject);
  public
    procedure UpdateResouces; override;
    procedure UpdateFormPPI(aNewPPI: Integer); override;
  end;


implementation
{$IFDEF FPC}
{$R *.lfm}
{$ELSE}
{$R *.DFM}
{$ENDIF}

uses frxBaseFormEditorDataTree, frxRes;

var
  lastPosition: TPoint;

{$IFNDEF FPC}
type
  THackWinControl = class(TWinControl);
{$ENDIF}


{ TfrxExprEditorForm }

procedure TfrxExprEditorForm.FormCreate(Sender: TObject);
begin
{$IFDEF UseTabset}
  ExprMemo.BevelKind := bkFlat;
{$ELSE}
  ExprMemo.BorderStyle := bsSingle;
{$ENDIF}

  FReport := TfrxCustomDesigner(Owner).Report;
  FDataTree := TfrxDataTreeForm.Create(Self);
  FDataTree.Report := FReport;
  FDataTree.OnDblClick := OnDataTreeDblClick;
  FDataTree.SetControlsParent(Panel);
  FDataTree.HintPanel.Height := 60;
  FDataTree.UpdateItems;

  if UseRightToLeftAlignment then
    FlipChildren(True);
end;

procedure TfrxExprEditorForm.FormShow(Sender: TObject);
begin
  FDataTree.SetLastPosition(lastPosition);
end;

procedure TfrxExprEditorForm.FormHide(Sender: TObject);
begin
  lastPosition := FDataTree.GetLastPosition;
end;

procedure TfrxExprEditorForm.OnDataTreeDblClick(Sender: TObject);
begin
  ExprMemo.SelText := FDataTree.GetFieldName;
  ExprMemo.SetFocus;
end;

procedure TfrxExprEditorForm.UpdateFormPPI(aNewPPI: Integer);
begin
  inherited;
  FDataTree.UpdateFormPPI(aNewPPI);
  FDataTree.SendPPIMessage(FDataTree, aNewPPI);
end;

procedure TfrxExprEditorForm.UpdateResouces;
begin
  inherited;
  Caption := frxGet(4400);
  ExprL.Caption := frxGet(4401);
  OkB.Caption := frxGet(1);
  CancelB.Caption := frxGet(2);
end;

procedure TfrxExprEditorForm.ExprMemoDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := (FDataTree.GetFieldName <> '');
end;

procedure TfrxExprEditorForm.ExprMemoDragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  MemoDragDrop(ExprMemo, FDataTree, X, Y, '');
end;

procedure TfrxExprEditorForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    frxResources.Help(Self);
end;

procedure TfrxExprEditorForm.FormResize(Sender: TObject);
begin
  FDataTree.UpdateSize;
end;

end.
