
{******************************************}
{                                          }
{             FastReport VCL               }
{             TStrings editor              }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxEditStrings;

interface

{$I frx.inc}

uses
  SysUtils,
  {$IFNDEF FPC}
  Windows, Messages,
  {$ENDIF}
  Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, frxBaseForm
  {$IFDEF FPC}
  , LCLType
  {$ELSE}
  , ToolWin
  {$ENDIF}
{$IFDEF DELPHI6}
, Variants
{$ENDIF};
  

type
  TfrxStringsEditorForm = class(TfrxBaseLoadSavePrefForm)
    ToolBar: TToolBar;
    OkB: TToolButton;
    CancelB: TToolButton;
    Memo: TMemo;
    procedure OkBClick(Sender: TObject);
    procedure CancelBClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MemoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure UpdateResouces; override;
    procedure UpdateFormPPI(aNewPPI: Integer); override;
  end;


implementation

{$IFDEF FPC}
{$R *.lfm}
{$ELSE}
{$R *.DFM}
{$ENDIF}

uses frxClass, frxRes;


procedure TfrxStringsEditorForm.OkBClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TfrxStringsEditorForm.UpdateFormPPI(aNewPPI: Integer);
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

procedure TfrxStringsEditorForm.UpdateResouces;
begin
  inherited;
  Caption := frxGet(4800);
  CancelB.Hint := frxGet(2);
  OkB.Hint := frxGet(1);
end;

procedure TfrxStringsEditorForm.CancelBClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrxStringsEditorForm.FormCreate(Sender: TObject);
begin
  if UseRightToLeftAlignment then
    FlipChildren(True);
end;

procedure TfrxStringsEditorForm.MemoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = vk_Return) and (ssCtrl in Shift) then
    ModalResult := mrOk
  else if Key = vk_Escape then
    ModalResult := mrCancel;
end;

procedure TfrxStringsEditorForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    frxResources.Help(Self);
end;

end.

