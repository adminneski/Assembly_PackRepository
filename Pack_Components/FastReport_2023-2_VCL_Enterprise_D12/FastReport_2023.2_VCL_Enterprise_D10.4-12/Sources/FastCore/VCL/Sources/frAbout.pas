{******************************************}
{                                          }
{          FastReport VCL/FMX/LCL          }
{              Core Library                }
{                                          }
{         Copyright (c) 1998-2022          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frAbout;

interface

{$I frVer.inc}

uses
{$IFNDEF FPC}
  Windows, Messages,
{$ENDIF}
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, frBaseForm,
{$IFDEF FPC}
  LCLType, LCLIntf,
{$ENDIF}
  frCore;

type
  TfrxAboutForm = class(TfrBaseForm)
    Button1: TButton;
    Label2: TLabel;
    Label3: TLabel;
    Image1: TImage;
    Bevel2: TBevel;
    Label5: TLabel;
    Shape1: TShape;
    Label1: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure LabelClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  public
    procedure UpdateResouces; override;
  end;

procedure frShowAboutForm(AOwner: TComponent);

implementation

uses
{$IFNDEF FPC}
  frUtils, ShellApi,
{$ENDIF}
{$IFDEF FR_COM}
  Registry,
{$ENDIF}
  frResources;

{$IFDEF FPC}
{$R *.lfm}
{$ELSE}
{$R *.DFM}
{$ENDIF}

procedure frShowAboutForm(AOwner: TComponent);
begin
  with TfrxAboutForm.Create(AOwner) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TfrxAboutForm.FormCreate(Sender: TObject);
begin
  if UseRightToLeftAlignment then
    FlipChildren(True);
end;

procedure TfrxAboutForm.LabelClick(Sender: TObject);
begin
  {$IFDEF FPC}
  if TLabel(Sender).Tag = 1 then
    LCLIntf.OpenURL(TLabel(Sender).Caption)
  else
  if TLabel(Sender).Tag = 2 then
  begin
    LCLIntf.OpenURL('mailto:' + TLabel(Sender).Caption);
  end;
  {$ELSE}
  case TLabel(Sender).Tag of
    1: ShellExecute(GetDesktopWindow, 'open',
      PChar(TLabel(Sender).Caption), nil, nil, sw_ShowNormal);
    2: ShellExecute(GetDesktopWindow, 'open',
      PChar('mailto:' + TLabel(Sender).Caption), nil, nil, sw_ShowNormal);
  end;
  {$ENDIF}
end;

procedure TfrxAboutForm.UpdateResouces;
begin
  inherited;
  Caption := frStringResources.Get(2600);
  Label4.Caption := frStringResources.Get(2601);
  Label6.Caption := frStringResources.Get(2602);
  Label8.Caption := frStringResources.Get(2603);
  Label2.Caption := 'Version ' + FR_VERSION;
  Label10.Caption := String(#174);
  Label3.Caption := '(c) 1998-' + FormatDateTime('YYYY', Now) + ' by Alexander Tzyganenko, Fast Reports Inc.';
end;

procedure TfrxAboutForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    ModalResult := mrCancel;
end;

initialization
  frStringResources.AddOrSet('2600', 'About FastReport');
  frStringResources.AddOrSet('2601', 'Visit our webpage for more info:');
  frStringResources.AddOrSet('2602', 'Sales:');
  frStringResources.AddOrSet('2603', 'Support:');

end.

