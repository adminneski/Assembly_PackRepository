
{******************************************}
{                                          }
{             FastReport VCL               }
{              Password form               }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxPassw;

interface

{$I frx.inc}

uses
  {$IFNDEF FPC}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, frxBaseForm
  {$IFDEF FPC}
  , LResources
  {$ENDIF}
{$IFDEF DELPHI6}
, Variants
{$ENDIF};
  

type
  TfrxPasswordForm = class(TfrxBaseForm)
    OkB: TButton;
    CancelB: TButton;
    PasswordE: TEdit;
    PasswordL: TLabel;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
  private
  public
    procedure UpdateResouces; override;
  end;


implementation

{$IFNDEF FPC}
{$R *.dfm}
{$ELSE}
{$R *.lfm}
{$ENDIF}

uses frxRes;


procedure TfrxPasswordForm.FormCreate(Sender: TObject);
begin
  if UseRightToLeftAlignment then
    FlipChildren(True);
end;

procedure TfrxPasswordForm.UpdateResouces;
begin
  inherited;
  Caption := frxGet(5000);
  PasswordL.Caption := frxGet(5001);
  OkB.Caption := frxGet(1);
  CancelB.Caption := frxGet(2);
end;

end.
