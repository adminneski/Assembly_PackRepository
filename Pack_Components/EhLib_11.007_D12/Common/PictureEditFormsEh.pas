{*******************************************************}
{                                                       }
{                       EhLib 10.2                     }
{                    PictureEdit Dialog                 }
{                                                       }
{     Copyright (c) 2013-2022 by Dmitry V. Bolshakov    }
{                                                       }
{*******************************************************}

unit PictureEditFormsEh;

{$I EhLib.Inc}

interface

uses
  Messages,
  {$IFDEF FPC}
    EhLibLCL, LMessages, LCLType, LCLIntf,
    {$IFDEF FPC_CROSSP}
    {$ELSE}
      Windows,
    {$ENDIF}
  {$ELSE}
    EhLibVCL, Windows,
  {$ENDIF}
  Classes, Graphics, Forms, Controls, Dialogs, Buttons,
  ToolCtrlsEh, LanguageResManEh,
  StdCtrls, ExtCtrls, ExtDlgs, DBCtrlsEh;

type

  TDialogAllowedEditOperationEh = (dealopCutEh, dealopCopyEh, dealopPasteEh,
    dealopLoadEh, dealopSaveEh, dealopClearEh, dealopZoomingEh, dealopShiftEh);

  TDialogAllowedEditOperationsEh = set of TDialogAllowedEditOperationEh;

const
  DialogAllowedEditOperationsAll = [dealopCutEh, dealopCopyEh, dealopPasteEh,
    dealopLoadEh, dealopSaveEh, dealopClearEh, dealopZoomingEh, dealopShiftEh];

type

{ TCustomPictureEditorDialog }

  TCustomPictureEditorDialog = class(TForm)
  public
    function Edit(Picture: TPicture; AllowsOperations: TDialogAllowedEditOperationsEh = DialogAllowedEditOperationsAll): Boolean; virtual;
  end;

  TCustomPictureEditorDialogClass = class of TCustomPictureEditorDialog;

{ TPictureEditorDialog }

  TPictureEditorDialog = class(TCustomPictureEditorDialog)
    OpenDialog: TOpenPictureDialog;
    SaveDialog: TSavePictureDialog;
    OKButton: TButton;
    CancelButton: TButton;
    GroupBox1: TGroupBox;
    Load: TButton;
    Save: TButton;
    Clear: TButton;
    bCut: TButton;
    bCopy: TButton;
    bPaste: TButton;
    bZoomIn: TButton;
    bZoomOut: TButton;
    bReset: TButton;
    ImageShape: TShape;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure LoadClick(Sender: TObject);
    procedure SaveClick(Sender: TObject);
    procedure ClearClick(Sender: TObject);
    procedure ImagePaintBoxPaint(Sender: TObject);
    procedure bCutClick(Sender: TObject);
    procedure bCopyClick(Sender: TObject);
    procedure bPasteClick(Sender: TObject);
    procedure bResetClick(Sender: TObject);
    procedure bZoomOutClick(Sender: TObject);
    procedure bZoomInClick(Sender: TObject);
  private
    Image: TDBImageEh;
    procedure WMSettingChange(var Message: TMessage); message WM_SETTINGCHANGE;
  protected
    procedure ResourceLanguageChanged; virtual;
  public

    function Edit(Picture: TPicture; AllowsOperations: TDialogAllowedEditOperationsEh = DialogAllowedEditOperationsAll): Boolean; override;
  end;

function DefaultShowPictureEditDialogEh(Picture: TPicture): Boolean;

type
  TShowPictureEditDialogEhProg = function (Picture: TPicture): Boolean;

var
  PictureEditorDialog: TCustomPictureEditorDialog;
  DefaultDBImageEhEditDialogClass: TCustomPictureEditorDialogClass;
  ShowPictureEditDialogEhProg: TShowPictureEditDialogEhProg;

implementation

uses TypInfo, SysUtils, EhLibLangConsts;

{$R *.dfm}

{ TCustomPictureEditorDialog }

function TCustomPictureEditorDialog.Edit(Picture: TPicture;
  AllowsOperations: TDialogAllowedEditOperationsEh = DialogAllowedEditOperationsAll): Boolean;
begin
  Result := False;
end;

function DefaultShowPictureEditDialogEh(Picture: TPicture): Boolean;
begin
  if PictureEditorDialog = nil then
    PictureEditorDialog := DefaultDBImageEhEditDialogClass.Create(Application);

  Result := PictureEditorDialog.Edit(Picture);
end;

{ TPictureEditorDlg }

procedure TPictureEditorDialog.FormCreate(Sender: TObject);
begin
  Save.Enabled := False;
  Image := TDBImageEh.Create(Self);
  Image.Parent := ImageShape.Parent;
  Image.SetBounds(ImageShape.Left, ImageShape.Top, ImageShape.Width, ImageShape.Height);
  Image.Anchors := ImageShape.Anchors;
  Image.Color := clMoneyGreen;
  ResourceLanguageChanged;
end;

procedure TPictureEditorDialog.ResourceLanguageChanged;
begin
  Caption := EhLibLanguageConsts.PictureEditorDialog_Caption; 
  Load.Caption := EhLibLanguageConsts.PictureEditorDialog_Load; 
  Save.Caption := EhLibLanguageConsts.PictureEditorDialog_Save ; 
  Clear.Caption := EhLibLanguageConsts.PictureEditorDialog_Clear; 
  bCut.Caption := EhLibLanguageConsts.PictureEditorDialog_Cut; 
  bCopy.Caption := EhLibLanguageConsts.PictureEditorDialog_Copy; 
  bPaste.Caption := EhLibLanguageConsts.PictureEditorDialog_Paste; 
  bZoomIn.Caption := EhLibLanguageConsts.PictureEditorDialog_ZoomIn; 
  bZoomOut.Caption := EhLibLanguageConsts.PictureEditorDialog_ZoomOut; 
  bReset.Caption := EhLibLanguageConsts.PictureEditorDialog_Reset; 
end;

function TPictureEditorDialog.Edit(Picture: TPicture;
  AllowsOperations: TDialogAllowedEditOperationsEh): Boolean;
begin
  Result := False;
  Image.Picture.Assign(Picture);
  bCut.Enabled := (dealopCutEh in AllowsOperations);
  bCopy.Enabled := (dealopCopyEh in AllowsOperations);
  bPaste.Enabled := (dealopPasteEh in AllowsOperations);
  Load.Enabled := (dealopLoadEh in AllowsOperations);
  Save.Enabled := (dealopSaveEh in AllowsOperations);
  Clear.Enabled := (dealopClearEh in AllowsOperations);
  bZoomIn.Enabled := (dealopZoomingEh in AllowsOperations);
  bZoomOut.Enabled := (dealopZoomingEh in AllowsOperations);
  bReset.Enabled := (dealopShiftEh in AllowsOperations) or (dealopZoomingEh in AllowsOperations);

  if ShowModal = mrOk then
  begin
    Result := True;
    Picture.Assign(Image.Picture);
  end;
end;

procedure TPictureEditorDialog.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Image);
end;

procedure TPictureEditorDialog.LoadClick(Sender: TObject);
begin
  if OpenDialog.Execute then
  begin
    Image.Picture.LoadFromFile(OpenDialog.Filename);
    Save.Enabled := (Image.Picture.Graphic <> nil) and not Image.Picture.Graphic.Empty;
    Clear.Enabled := (Image.Picture.Graphic <> nil) and not Image.Picture.Graphic.Empty;
  end;
end;

procedure TPictureEditorDialog.SaveClick(Sender: TObject);
begin
  if Image.Picture.Graphic <> nil then
  begin
    SaveDialog.DefaultExt := GraphicExtension(TGraphicClass(Image.Picture.Graphic.ClassType));
    SaveDialog.Filter := GraphicFilter(TGraphicClass(Image.Picture.Graphic.ClassType));
    if SaveDialog.Execute then
      Image.Picture.SaveToFile(SaveDialog.Filename);
  end;
end;

procedure TPictureEditorDialog.ImagePaintBoxPaint(Sender: TObject);
var
  DrR: TRect;
  SNone: string;
  pb: TPaintBox;
begin
  pb := TPaintBox(Sender);
  pb.Canvas.Brush.Color := pb.Color;
  DrR := ClientRect;
  if Image.Picture.Width > 0 then
  begin
    if (Image.Picture.Width > DrR.Right - DrR.Left) or
       (Image.Picture.Height > DrR.Bottom - DrR.Top) then
    begin
      if Image.Picture.Width > Image.Picture.Height then
        DrR.Bottom := Top + MulDiv(Image.Picture.Height, DrR.Right - DrR.Left, Image.Picture.Width)
      else
        DrR.Right := Left + MulDiv(Image.Picture.Width, DrR.Bottom - DrR.Top, Image.Picture.Height);
      pb.Canvas.StretchDraw(DrR, Image.Picture.Graphic);
    end
    else
      pb.Canvas.Draw(DrR.Left + (DrR.Right - DrR.Left - Image.Picture.Width) div 2,
        DrR.Top + (DrR.Bottom - DrR.Top - Image.Picture.Height) div 2,
        Image.Picture.Graphic);
  end else
  begin
    SNone := 'srNone';
    pb.Canvas.TextOut(DrR.Left + (DrR.Right - DrR.Left - Canvas.TextWidth(SNone)) div 2,
      DrR.Top + (DrR.Bottom - DrR.Top - Canvas.TextHeight(SNone)) div 2,
      SNone);
  end;
end;

procedure TPictureEditorDialog.bCopyClick(Sender: TObject);
begin
  Image.CopyToClipboard;
end;

procedure TPictureEditorDialog.bCutClick(Sender: TObject);
begin
  Image.CutToClipboard;
end;

procedure TPictureEditorDialog.bPasteClick(Sender: TObject);
begin
  Image.PasteFromClipboard;
end;

procedure TPictureEditorDialog.bZoomInClick(Sender: TObject);
begin
  Image.TemporaryZoomTo(Image.Zoom + 10);
end;

procedure TPictureEditorDialog.bZoomOutClick(Sender: TObject);
begin
  Image.TemporaryZoomTo(Image.Zoom - 10);
end;

procedure TPictureEditorDialog.bResetClick(Sender: TObject);
begin
  Image.ResetZoom;
  Image.ResetPos;
end;

procedure TPictureEditorDialog.ClearClick(Sender: TObject);
begin
  Image.Picture.Graphic := nil;
  Save.Enabled := False;
  Clear.Enabled := False;
end;

procedure TPictureEditorDialog.WMSettingChange(var Message: TMessage);
begin
  inherited;
  ResourceLanguageChanged;
end;

initialization
  DefaultDBImageEhEditDialogClass := TPictureEditorDialog;
  ShowPictureEditDialogEhProg := @DefaultShowPictureEditDialogEh;
end.
