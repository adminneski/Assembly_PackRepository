
{******************************************}
{                                          }
{             FastReport VCL               }
{              Picture editor              }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxEditPicture;

interface

{$I frx.inc}

uses
  SysUtils,
{$IFNDEF FPC}
  Windows, Messages,
{$ENDIF}
  Classes, Graphics, Controls,
  Forms, Dialogs, Buttons, ExtCtrls, ComCtrls, frxBaseForm,
{$IFDEF FPC}
  LCLType, LazHelper,
{$ELSE}
  StdCtrls, ToolWin, frxCtrls, frxDock,
{$ENDIF}
{$IFDEF DELPHI6}
  Variants,
{$ENDIF}
  frTypes;

type
  TfrxPictureEditorForm = class(TfrxBaseForm)
    ToolBar: TToolBar;
    LoadB: TToolButton;
    ClearB: TToolButton;
    OkB: TToolButton;
    Box: TScrollBox;
    ToolButton1: TToolButton;
    CancelB: TToolButton;
    Image: TImage;
    StatusBar: TStatusBar;
    CopyB: TToolButton;
    PasteB: TToolButton;
    procedure ClearBClick(Sender: TObject);
    procedure LoadBClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure OkBClick(Sender: TObject);
    procedure CancelBClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CopyBClick(Sender: TObject);
    procedure PasteBClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FStatusBarOldWindowProc: TWndMethod;
    procedure StatusBarWndProc(var Message: TMessage);
    { Private declarations }
    procedure UpdateImage;
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

uses frxClass, {$IFNDEF FPC}frxUtils,{$ENDIF} frxRes, ClipBrd {$IFDEF OPENPICTUREDLG}, ExtDlgs {$ENDIF}, frPictureGraphics;
{$IFNDEF FPC}
type
  THackWinControl = class(TWinControl);
{$ENDIF}
type
  THackPicture = class(TPicture);

{ TfrxPictureEditorForm }

procedure TfrxPictureEditorForm.UpdateFormPPI(aNewPPI: Integer);
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

procedure TfrxPictureEditorForm.UpdateImage;
begin
  if (Image.Picture.Graphic = nil) or Image.Picture.Graphic.Empty then
    StatusBar.Panels[0].Text := frxResources.Get('piEmpty')
  else
  begin
    StatusBar.Panels[0].Text := Format('%d x %d',
      [Image.Picture.Width, Image.Picture.Height]);
    Image.Stretch := (Image.Picture.Width > Image.Width) or
      (Image.Picture.Height > Image.Height);
  end;
end;

procedure TfrxPictureEditorForm.UpdateResouces;
begin
  inherited;
  Caption := frxGet(4000);
  LoadB.Hint := frxGet(4001);
  CopyB.Hint := frxGet(4002);
  PasteB.Hint := frxGet(4003);
  ClearB.Hint := frxGet(4004);
  CancelB.Hint := frxGet(2);
  OkB.Hint := frxGet(1);
end;

procedure TfrxPictureEditorForm.FormShow(Sender: TObject);
begin
{$IFDEF UseTabset}
  Box.BevelKind := bkFlat;
{$ELSE}
  Box.BorderStyle := bsSingle;
{$IFDEF DELPHI7}
  Box.ControlStyle := Box.ControlStyle + [csNeedsBorderPaint];
{$ENDIF}
{$ENDIF}
  UpdateImage;
end;

procedure TfrxPictureEditorForm.ClearBClick(Sender: TObject);
begin
  Image.Picture.Assign(nil);
  UpdateImage;
end;

procedure TfrxPictureEditorForm.LoadBClick(Sender: TObject);
var
{$IFDEF OPENPICTUREDLG}
  OpenDlg: TOpenPictureDialog;
{$ELSE}
  OpenDlg: TOpenDialog;
{$ENDIF}
begin
{$IFDEF OPENPICTUREDLG}
  OpenDlg := TOpenPictureDialog.Create(nil);
{$ELSE}
  OpenDlg := TOpenDialog.Create(nil);
{$ENDIF}
  OpenDlg.Options := [];
  OpenDlg.Filter := frxResources.Get('ftPictures') + ' (' + GetGraphicFormats.BuildFormatsString(stExtension) + ')|'
  + GetGraphicFormats.BuildFormatsString(stExtension, ';') + '|' + frxResources.Get('ftAllFiles') + '|*.*';
  if OpenDlg.Execute then
    Image.Picture.LoadFromFile(OpenDlg.FileName);
  OpenDlg.Free;
  UpdateImage;
end;

procedure TfrxPictureEditorForm.OkBClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TfrxPictureEditorForm.CancelBClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrxPictureEditorForm.FormCreate(Sender: TObject);
begin
  FStatusBarOldWindowProc := StatusBar.WindowProc;
  StatusBar.WindowProc := StatusBarWndProc;

  if UseRightToLeftAlignment then
    FlipChildren(True);
end;

procedure TfrxPictureEditorForm.CopyBClick(Sender: TObject);
var
  Graphic: TGraphic;
  GHelper: TfrxCustomGraphicFormatClass;

  function IsTextData: Boolean;
  begin
    GHelper := GetGraphicFormats.FindByGraphic(TGraphicClass(Graphic.ClassType));
    Result := Assigned(GHelper) and GHelper.IsTextData(Graphic);
  end;
begin
  if Image.Picture = nil then
    Exit;

  Graphic := Image.Picture.Graphic;
  if Assigned(Graphic) and IsTextData then
    Clipboard.AsText := GHelper.GetTextData(Graphic)
  else
    Clipboard.Assign(Image.Picture);
end;

procedure TfrxPictureEditorForm.PasteBClick(Sender: TObject);
var
  Stream: TStringStream;
begin
  if Clipboard.HasFormat(CF_BITMAP) or Clipboard.HasFormat(CF_METAFILEPICT) or
    Clipboard.HasFormat(CF_PICTURE) then
  begin
    Image.Picture.Assign(Clipboard);
    UpdateImage;
  end
  else if Clipboard.HasFormat(CF_TEXT) then
  begin
    Stream := TStringStream.Create(Clipboard.AsText);
    try
      THackPicture(Image.Picture).LoadFromStream(Stream);
    finally
      Stream.Free;
    end;
    UpdateImage;
  end
  else
    ShowMessage(frxResources.Get('erInvalidImg'));
end;

procedure TfrxPictureEditorForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    frxResources.Help(Self);
end;

procedure TfrxPictureEditorForm.StatusBarWndProc(var Message: TMessage);
begin
  {$IFNDEF FPC}
  if Message.Msg = WM_SYSCOLORCHANGE then
    DefWindowProc(StatusBar.Handle,Message.Msg,Message.WParam,Message.LParam)
  else
    FStatusBarOldWindowProc(Message);
  {$ENDIF}
end;

end.

