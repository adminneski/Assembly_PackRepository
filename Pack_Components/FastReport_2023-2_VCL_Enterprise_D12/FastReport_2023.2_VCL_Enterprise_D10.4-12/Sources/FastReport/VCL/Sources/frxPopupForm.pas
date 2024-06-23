
{******************************************}
{                                          }
{             FastReport VCL               }
{     Parent form for pop-up controls      }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxPopupForm;

interface

{$I frx.inc}

uses
  SysUtils,
  {$IFNDEF FPC}
  Windows, Messages,
  {$ENDIF}
  Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, frxBaseForm
  {$IFDEF FPC}
  , LResources, LCLType, LCLIntf, LCLProc
  {$ENDIF}
{$IFDEF DELPHI6}
, Variants
{$ENDIF};
  

type
  TfrxPopupForm = class(TfrxBaseForm)
    procedure FormDeactivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private
    FResizable: Boolean;
{$IFNDEF FPC}
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
{$ENDIF}
    procedure SetResizable(const Value: Boolean);
    { Private declarations }
  public
    property Resizable: Boolean read FResizable write SetResizable;
    { Public declarations }
  end;

var
  frxPopupFormCloseTime: UInt = 0;


implementation

{$IFNDEF FPC}
{$R *.DFM}
{$ELSE}
{$R *.lfm}
{$ENDIF}


procedure TfrxPopupForm.FormDeactivate(Sender: TObject);
begin
  frxPopupFormCloseTime := GetTickCount;
  Close;
end;

procedure TfrxPopupForm.SetResizable(const Value: Boolean);
begin
  FResizable := Value;
  Resize;
end;

{$IFNDEF FPC}
procedure TfrxPopupForm.WMNCHitTest(var Message: TWMNCHitTest);
begin
  Message.Result := HTCLIENT;
  inherited;
  if not FResizable then Exit;
  if (Message.XPos >= Left + Width - 4) and (Message.XPos <= Left + Width) then
    Message.Result := HTRIGHT;
  if (Message.YPos >= Top + Height - 4) and (Message.YPos <= Top + Height) then
  begin
    if Message.Result = HTRIGHT then
      Message.Result := HTBOTTOMRIGHT
    else
      Message.Result := HTBOTTOM;
  end;
end;
{$ENDIF}

procedure TfrxPopupForm.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  if ModalResult = mrNone then
    CloseAction := caFree;
end;

end.
