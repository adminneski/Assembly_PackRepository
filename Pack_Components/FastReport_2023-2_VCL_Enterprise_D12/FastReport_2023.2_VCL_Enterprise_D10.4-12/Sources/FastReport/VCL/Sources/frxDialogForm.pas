
{******************************************}
{                                          }
{             FastReport VCL               }
{               Dialog form                }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxDialogForm;

interface

{$I frx.inc}

uses
{$IFNDEF FPC}
  Windows, Messages,
{$ENDIF}
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, frxBaseForm,
{$IFDEF FPC}
  LResources, LCLType, LazHelper, LMessages,
{$ENDIF}
{$IFDEF DELPHI6}
  Variants,
{$ENDIF}
  frTypes;

type

  { TfrxDialogForm }

  TfrxDialogForm = class(TfrxBaseForm)
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure DoCreateWnd;
    procedure DoDestroyWnd;
    procedure DoCreateHandle;
    procedure DoDestroyHandle;
{$IFNDEF FPC}
    procedure DoDestroyWindowHandle;
{$ENDIF}
  protected
    procedure SetParent(AParent: TWinControl); override;
    procedure ReadState(Reader: TReader); override;
    procedure CreateWnd; override;
    procedure DestroyWnd; override;
    procedure CreateHandle; override;
{$IFDEF DELPHI9}
    procedure DestroyHandle; override;
{$ENDIF}
{$IFNDEF FPC}
    procedure DestroyWindowHandle; override;
{$ENDIF}
  private
    FOnModify: TNotifyEvent;
    FThreadSafe: Boolean;
    FDialogPageControl: TComponent;
    {$IFNDEF FPC}
    procedure WMExitSizeMove(var Msg: TMessage); message WM_EXITSIZEMOVE;
    {$ELSE}
    FIsLMSizeMove: Boolean;
    procedure LMSizeMove(var Msg: TMessage); message LM_WINDOWPOSCHANGED;
    procedure LMSize(var Msg: TMessage); message LM_SIZE;
    procedure LMMOVE(var Msg: TMessage); message LM_MOVE;
    {$ENDIF}
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
  public
    constructor Create(AOwner: TComponent); override;
    {$IFDEF FPC}
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: integer); override;
    {$ENDIF}
    procedure UpdateFormPPI(aNewPPI: Integer); override;
    property OnModify: TNotifyEvent read FOnModify write FOnModify;
    property ThreadSafe: Boolean read FThreadSafe write FThreadSafe;
  end;

implementation

uses
  frxClass, frThreading;
{$IFDEF FPC}
{$R *.lfm}
{$ELSE}
{$R *.DFM}
{$ENDIF}

{$IFNDEF FPC}
procedure TfrxDialogForm.WMExitSizeMove(var Msg: TMessage);
begin
  inherited;
  if Assigned(OnModify) then
    OnModify(Self);
end;
{$ELSE}
procedure TfrxDialogForm.LMSizeMove(var Msg: TMessage);
begin
  FIsLMSizeMove := True;
  try
  inherited;
    if Assigned(OnModify) then
      OnModify(Self);

  finally
    FIsLMSizeMove := False;
  end;
end;

 { delete this ugly code when change form designer }
procedure TfrxDialogForm.LMSize(var Msg: TMessage);
begin
  FIsLMSizeMove := True;
  try
   inherited;
  finally
    FIsLMSizeMove := False;
  end;
end;

procedure TfrxDialogForm.LMMOVE(var Msg: TMessage);
var
  nWidth, nHeight: Integer;
begin
  nWidth := Width;
  nHeight := Height;
  try
    inherited;
  finally
    Width := nWidth;
    Height := nHeight;
  end;
end;
{$ENDIF}

procedure TfrxDialogForm.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := DLGC_WANTARROWS or DLGC_WANTTAB;
end;

procedure TfrxDialogForm.CreateHandle;
begin
  frThreadSynchronize(DoCreateHandle);
end;

procedure TfrxDialogForm.CreateWnd;
begin
  frThreadSynchronize(DoCreateWnd);
end;

{$IFDEF DELPHI9}
procedure TfrxDialogForm.DestroyHandle;
begin
  frThreadSynchronize(DoDestroyHandle);
end;
{$ENDIF}

{$IFNDEF FPC}
procedure TfrxDialogForm.DestroyWindowHandle;
begin
  frThreadSynchronize(DoDestroyWindowHandle);
end;
{$ENDIF}

procedure TfrxDialogForm.DestroyWnd;
begin
  frThreadSynchronize(DoDestroyWnd);
end;

procedure TfrxDialogForm.DoCreateHandle;
begin
  inherited CreateHandle;
end;

procedure TfrxDialogForm.DoCreateWnd;
begin
  inherited CreateWnd;
end;

procedure TfrxDialogForm.DoDestroyHandle;
begin
  inherited DestroyHandle;
end;

{$IFNDEF FPC}
procedure TfrxDialogForm.DoDestroyWindowHandle;
begin
  inherited DestroyWindowHandle;
end;
{$ENDIF}

procedure TfrxDialogForm.DoDestroyWnd;
begin
  inherited DestroyWnd;
end;

procedure TfrxDialogForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
{$IFDEF FPC}
  CanClose := not Self.Visible;
{$ELSE}
  CanClose := False;
{$ENDIF};
end;

procedure TfrxDialogForm.ReadState(Reader: TReader);
begin
  if not ThreadSafe then
    inherited ReadState(Reader);
end;

procedure TfrxDialogForm.SetParent(AParent: TWinControl);
var
  bufRect: TRect;
begin
  bufRect := Self.BoundsRect;
  inherited;
  Self.BoundsRect := bufRect;
end;

procedure TfrxDialogForm.UpdateFormPPI(aNewPPI: Integer);
begin
  inherited;
  if Assigned(FDialogPageControl) then
    TfrxDialogPage(FDialogPageControl).UpdateDialogPPI(aNewPPI);
end;

constructor TfrxDialogForm.Create(AOwner: TComponent);
begin
  if AOwner <> nil then
    FThreadSafe := AOwner.Tag = 318;
  if AOwner is TfrxDialogPage then
    FDialogPageControl := AOwner;
  AOwner := nil;
  inherited;
end;

{$IFDEF FPC}
procedure TfrxDialogForm.SetBounds(ALeft, ATop, AWidth, AHeight: integer);
var
  SaveOnModify: TNotifyEvent;
begin
  SaveOnModify := FOnModify;
  try
    if not FIsLMSizeMove then
      OnModify := nil;
    inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  finally
    OnModify := SaveOnModify;
  end;
end;
{$ENDIF}


end.
