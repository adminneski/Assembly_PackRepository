
{******************************************}
{                                          }
{             FastReport VCL               }
{          Inherit error dialog            }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxInheritError;

interface

{$I frx.inc}

uses
  {$IFNDEF FPC}
  Windows, Messages, ImgList,
  {$ELSE}
  LResources,
  {$ENDIF}
  SysUtils, Classes, Graphics, Controls, Forms, Variants,
  Dialogs, StdCtrls, ExtCtrls, frxBaseForm;


type
  TfrxInheritErrorForm = class(TfrxBaseForm)
    OkB: TButton;
    CancelB: TButton;
    MessageL: TLabel;
    DeleteRB: TRadioButton;
    RenameRB: TRadioButton;
    PaintBox1: TPaintBox;
    ImageList1: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure UpdateResouces; override;
  end;


implementation

{$IFNDEF FPC}
{$R *.dfm}
{$ELSE}
{$R *.lfm}
{$ENDIF}

uses frxRes;

procedure TfrxInheritErrorForm.FormCreate(Sender: TObject);
begin
  if UseRightToLeftAlignment then
    FlipChildren(True);
end;

procedure TfrxInheritErrorForm.PaintBox1Paint(Sender: TObject);
begin
  with PaintBox1 do
  begin
    Canvas.Brush.Color := Color;
    Canvas.FillRect(Rect(0, 0, PaintBox1.Width, PaintBox1.Height));
    ImageList1.Draw(Canvas, (PaintBox1.Width - ImageList1.Width) div 2, (PaintBox1.Height - ImageList1.Height) div 2, 0);
  end;
end;

procedure TfrxInheritErrorForm.UpdateResouces;
begin
  inherited;
  Caption := frxGet(6000);
  OkB.Caption := frxGet(1);
  CancelB.Caption := frxGet(2);
  MessageL.Caption := frxGet(6001);
  DeleteRB.Caption := frxGet(6002);
  RenameRB.Caption := frxGet(6003);
end;

end.
