
{******************************************}
{                                          }
{             FastReport VCL               }
{             Evaluate dialog              }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxEvaluateForm;

interface

{$I frx.inc}

uses
  {$IFNDEF FPC}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, fs_iinterpreter, frxBaseForm
  {$IFDEF FPC}
  ,LCLType
  {$ENDIF}
{$IFDEF DELPHI6}
, Variants
{$ENDIF};

type
  TfrxEvaluateForm = class(TfrxBaseForm)
    Label1: TLabel;
    ExpressionE: TEdit;
    Label2: TLabel;
    ResultM: TMemo;
    OkB: TButton;
    CancelB: TButton;
    procedure ExpressionEKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FScript: TfsScript;
    FIsWatch: Boolean;
  public
    procedure UpdateResouces; override;
    property IsWatch: Boolean read FIsWatch write FIsWatch;
    property Script: TfsScript read FScript write FScript;
  end;


implementation

{$IFDEF FPC}
{$R *.lfm}
{$ELSE}
{$R *.DFM}
{$ENDIF}

uses frxRes;


procedure TfrxEvaluateForm.ExpressionEKeyPress(Sender: TObject; var Key: Char);
var
  v: Variant;
  s: String;
begin
  if IsWatch then Exit;
  if Key = #13 then
  begin
    v := FScript.Evaluate(ExpressionE.Text);
    s := VarToStr(v);
    if TVarData(v).VType = varBoolean then
      if Boolean(v) = True then
        s := 'True' else
        s := 'False'
    else if (TVarData(v).VType = varString) or (TVarData(v).VType = varOleStr)
    {$IFDEF DELPHI12} or (TVarData(v).VType = varOleStr){$ENDIF} then
      s := '''' + v + ''''
    else if v = Null then
      s := 'Null';
    ResultM.Text := s;
    ExpressionE.SelectAll;
  end
  else if Key = #27 then
    Close;
end;

procedure TfrxEvaluateForm.FormShow(Sender: TObject);
begin
  ExpressionE.SelectAll;
  ResultM.Text := '';
  if IsWatch then
  begin
    OkB.Visible := True;
    CancelB.Visible := True;
    ResultM.Visible := False;
    Label2.Visible := False;
    ClientHeight := OkB.Top + OkB.Height + 4;
  end;
end;

procedure TfrxEvaluateForm.UpdateResouces;
begin
  inherited;
  Caption := frxGet(5500);
  Label1.Caption := frxGet(5501);
  Label2.Caption := frxGet(5502);
  OkB.Caption := frxGet(1);
  CancelB.Caption := frxGet(2);
end;

procedure TfrxEvaluateForm.FormCreate(Sender: TObject);
begin
  if UseRightToLeftAlignment then
    FlipChildren(True);
end;

procedure TfrxEvaluateForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    ModalResult := mrCancel;
  if Key = VK_F1 then
    frxResources.Help(Self);
end;

end.
