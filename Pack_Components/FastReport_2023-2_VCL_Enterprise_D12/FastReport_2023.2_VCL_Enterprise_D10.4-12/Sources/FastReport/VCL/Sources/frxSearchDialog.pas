
{******************************************}
{                                          }
{             FastReport VCL               }
{              Search dialog               }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxSearchDialog;

interface

{$I frx.inc}

uses
  {$IFNDEF FPC}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, frxBaseForm
  {$IFDEF FPC}
  , LResources, LCLType
  {$ENDIF}
  ;

type
  TfrxSearchDialog = class(TfrxBaseForm)
    ReplacePanel: TPanel;
    ReplaceL: TLabel;
    ReplaceE: TEdit;
    Panel2: TPanel;
    TextL: TLabel;
    TextE: TEdit;
    Panel3: TPanel;
    OkB: TButton;
    CancelB: TButton;
    SearchL: TGroupBox;
    CaseCB: TCheckBox;
    TopCB: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
  private
  public
    procedure UpdateResouces; override;
    procedure UpdateFormPPI(aNewPPI: Integer); override;
  end;


implementation

uses frxRes;

{$IFNDEF FPC}
{$R *.DFM}
{$ELSE}
{$R *.lfm}
{$ENDIF}

var
  LastText: String;

procedure TfrxSearchDialog.FormCreate(Sender: TObject);
begin
  if UseRightToLeftAlignment then
    FlipChildren(True);
end;

procedure TfrxSearchDialog.FormShow(Sender: TObject);
begin
  TextE.Text := LastText;
end;

procedure TfrxSearchDialog.UpdateFormPPI(aNewPPI: Integer);
begin
  inherited;

end;

procedure TfrxSearchDialog.UpdateResouces;
begin
  inherited;
  Caption := frxGet(300);
  TextL.Caption := frxGet(301);
  SearchL.Caption := frxGet(302);
  ReplaceL.Caption := frxGet(303);
  TopCB.Caption := frxGet(304);
  CaseCB.Caption := frxGet(305);
  OkB.Caption := frxGet(1);
  CancelB.Caption := frxGet(2);
end;

procedure TfrxSearchDialog.FormHide(Sender: TObject);
begin
  if ModalResult = mrOk then
    LastText := TextE.Text;
end;

procedure TfrxSearchDialog.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    frxResources.Help(Self);
end;

procedure TfrxSearchDialog.FormActivate(Sender: TObject);
begin
  TextE.SetFocus;
  TextE.SelectAll;
end;

end.

