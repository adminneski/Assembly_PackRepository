
{******************************************}
{                                          }
{             FastReport VCL               }
{              PDFView editor              }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxEditPDF;

interface

{$I frx.inc}

uses
  SysUtils,
{$IFNDEF FPC}
  Windows, Messages,
{$ENDIF}
  Classes, Graphics, Controls,
  Forms, Dialogs, Buttons, ExtCtrls, ComCtrls, frxBaseForm, frxDsgnIntf, frxCustomEditors,
  frxPDFViewer,
{$IFDEF FPC}
  LCLType, LazHelper,
{$ELSE}
  StdCtrls , ToolWin, frxCtrls , frxDock,
{$ENDIF}
{$IFDEF DELPHI6}
  Variants,
{$ENDIF}
  frTypes;

type
  TfrxPDFEditor = class(TfrxViewEditor)
  public
    function Edit: Boolean; override;
    function HasEditor: Boolean; override;
    {procedure GetMenuItems; override;
    function Execute(Tag: Integer; Checked: Boolean): Boolean; override;}//TODO
  end;

  TfrxPDFEditorForm = class(TfrxBaseForm)
    ToolBar: TToolBar;
    LoadB: TToolButton;
    ClearB: TToolButton;
    OkB: TToolButton;
    Box: TScrollBox;
    ToolButton1: TToolButton;
    CancelB: TToolButton;
    Image: TImage;
    StatusBar: TStatusBar;
    LeftB: TToolButton;
    RightB: TToolButton;
    procedure ClearBClick(Sender: TObject);
    procedure LoadBClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure OkBClick(Sender: TObject);
    procedure CancelBClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LeftBClick(Sender: TObject);
    procedure RightBClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FStatusBarOldWindowProc: TWndMethod;
    procedure StatusBarWndProc(var Message: TMessage);
    { Private declarations }
    procedure UpdateImage;
  public
    { Public declarations }
    PDFView, OrigPDFView: TfrxPDFView;
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

function TfrxPDFEditor.Edit: Boolean;
begin
  with TfrxPDFEditorForm.Create(Designer) do
  begin
    OrigPDFView := TfrxPDFView(Component);
    Result := ShowModal = mrOk;
    if PDFView.isOneToOne then
      OrigPDFView.PDFDocument.PageIndex := 0;
    Free;
  end;
end;

function TfrxPDFEditor.HasEditor: Boolean;
begin
  Result := True;
end;

{procedure TfrxPDFEditor.GetMenuItems;
begin
  //TODO
end;

function TfrxPDFEditor.Execute(Tag: Integer; Checked: Boolean): Boolean;
begin
  //TODO
end;}

{ TfrxPictureEditorForm }

procedure TfrxPDFEditorForm.UpdateFormPPI(aNewPPI: Integer);
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

procedure TfrxPDFEditorForm.UpdateImage;
begin
  LeftB.Enabled := (PDFView.PDFDocument.PageIndex > 0);
  RightB.Enabled := (PDFView.PDFDocument.PageIndex < PDFView.PDFDocument.PageCount - 1);
  Image.Canvas.FillRect(Image.Canvas.ClipRect);
  PDFView.EditorDraw(Image.Canvas, Image.Canvas.ClipRect);
  if (PDFView.PDFDocument.PageCount = 0) then
    StatusBar.Panels[0].Text := frxResources.Get('piEmpty')
  else
  begin
    StatusBar.Panels[0].Text := Format(frxResources.Get('clPageOf'),
      [PDFView.PDFDocument.PageIndex + 1, PDFView.PDFDocument.PageCount]);
    Image.Stretch := (Image.Picture.Width > Image.Width) or
      (Image.Picture.Height > Image.Height);
  end;
end;

procedure TfrxPDFEditorForm.UpdateResouces;
begin
  inherited;
  Caption := frxGet(4005);
  LoadB.Hint := frxGet(4001);
  LeftB.Hint := frxGet(137);
  RightB.Hint := frxGet(139);
  ClearB.Hint := frxGet(4004);
  CancelB.Hint := frxGet(2);
  OkB.Hint := frxGet(1);
end;

procedure TfrxPDFEditorForm.FormShow(Sender: TObject);
begin
{$IFDEF UseTabset}
  Box.BevelKind := bkFlat;
{$ELSE}
  Box.BorderStyle := bsSingle;
{$IFDEF DELPHI7}
  Box.ControlStyle := Box.ControlStyle + [csNeedsBorderPaint];
{$ENDIF}
{$ENDIF}
  PDFView.Password := OrigPDFView.Password;
  frxAssignPDF(OrigPDFView, PDFView);
  UpdateImage;
end;

procedure TfrxPDFEditorForm.FormHide(Sender: TObject);
begin
  if ModalResult = mrOk then
    frxAssignPDF(PDFView, OrigPDFView);
end;

procedure TfrxPDFEditorForm.ClearBClick(Sender: TObject);
begin
  PDFView.ClearPDF;
  UpdateImage;
end;

procedure TfrxPDFEditorForm.LoadBClick(Sender: TObject);
var
  OpenDlg: TOpenDialog;
begin
  OpenDlg := TOpenDialog.Create(nil);
  OpenDlg.Options := [];
  OpenDlg.Filter := frxResources.Get('ftPDF') + ' (*.pdf)|*.pdf';
  if OpenDlg.Execute then
  begin
    ClearB.Click;
    PDFView.LoadFromFile(OpenDlg.FileName);
  end;
  OpenDlg.Free;
  UpdateImage;
end;

procedure TfrxPDFEditorForm.OkBClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TfrxPDFEditorForm.CancelBClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrxPDFEditorForm.FormCreate(Sender: TObject);
begin
  FStatusBarOldWindowProc := StatusBar.WindowProc;
  StatusBar.WindowProc := StatusBarWndProc;
  PDFView := TfrxPDFView.Create(Self);

  if UseRightToLeftAlignment then
    FlipChildren(True);
end;

procedure TfrxPDFEditorForm.LeftBClick(Sender: TObject);
begin
  PDFView.PDFDocument.PageIndex := PDFView.PDFDocument.PageIndex - 1;
  UpdateImage;
end;

procedure TfrxPDFEditorForm.RightBClick(Sender: TObject);
begin
  PDFView.PDFDocument.PageIndex := PDFView.PDFDocument.PageIndex + 1;
  UpdateImage;
end;

procedure TfrxPDFEditorForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    frxResources.Help(Self);
end;

procedure TfrxPDFEditorForm.StatusBarWndProc(var Message: TMessage);
begin
  {$IFNDEF FPC}
  if Message.Msg = WM_SYSCOLORCHANGE then
    DefWindowProc(StatusBar.Handle,Message.Msg,Message.WParam,Message.LParam)
  else
    FStatusBarOldWindowProc(Message);
  {$ENDIF}
end;

initialization

frxComponentEditors.Register(TfrxPDFView, TfrxPDFEditor);

end.

