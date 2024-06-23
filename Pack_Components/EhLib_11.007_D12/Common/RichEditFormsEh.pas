{*******************************************************}
{                                                       }
{                       EhLib 10.2                      }
{             Design time Rich Edit window              }
{                                                       }
{   Copyright (c) 1998-2022 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

unit RichEditFormsEh;

{$I EhLib.Inc}

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls, ImgList,
{$IFDEF EH_LIB_17} System.UITypes, {$ENDIF}
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Menus, ComCtrls, ClipBrd,
  DropDownFormEh, DynVarsEh, ToolCtrlsEh, ToolWin;

type
  TRichEditWinEh = class(TCustomDropDownFormEh)
    MainMenu: TMainMenu;
    FileNewItem: TMenuItem;
    FileOpenItem: TMenuItem;
    FileSaveItem: TMenuItem;
    FileSaveAsItem: TMenuItem;
    FilePrintItem: TMenuItem;
    FileExitItem: TMenuItem;
    EditUndoItem: TMenuItem;
    EditCutItem: TMenuItem;
    EditCopyItem: TMenuItem;
    EditPasteItem: TMenuItem;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    PrintDialog: TPrintDialog;
    Ruler: TPanel;
    FontDialog1: TFontDialog;
    FirstInd: TLabel;
    LeftInd: TLabel;
    RulerLine: TBevel;
    RightInd: TLabel;
    N5: TMenuItem;
    miEditFont: TMenuItem;
    Editor: TRichEdit;
    StatusBar: TStatusBar;
    StandardToolBar: TToolBar;
    OpenButton: TToolButton;
    SaveButton: TToolButton;
    PrintButton: TToolButton;
    ToolButton5: TToolButton;
    UndoButton: TToolButton;
    CutButton: TToolButton;
    CopyButton: TToolButton;
    PasteButton: TToolButton;
    ToolButton10: TToolButton;
    FontName: TComboBox;
    FontSizeOld: TEdit;
    ToolButton11: TToolButton;
    UpDown1: TUpDown;
    BoldButton: TToolButton;
    ItalicButton: TToolButton;
    UnderlineButton: TToolButton;
    ToolButton16: TToolButton;
    LeftAlign: TToolButton;
    CenterAlign: TToolButton;
    RightAlign: TToolButton;
    ToolButton20: TToolButton;
    BulletsButton: TToolButton;
    ToolbarImages: TImageList;
    Bevel1: TBevel;
    Panel1: TPanel;
    Panel2: TPanel;
    OKButton: TButton;
    CancelButton: TButton;
    ToolButton1: TToolButton;
    tbSelectFont: TToolButton;
    FontSize: TComboBox;

    procedure SelectionChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ShowHint(Sender: TObject);
    procedure FileOpen(Sender: TObject);
    procedure FileSave(Sender: TObject);
    procedure FileSaveAs(Sender: TObject);
    procedure FilePrint(Sender: TObject);
    procedure FileExit(Sender: TObject);
    procedure EditUndo(Sender: TObject);
    procedure EditCut(Sender: TObject);
    procedure EditCopy(Sender: TObject);
    procedure EditPaste(Sender: TObject);
    procedure SelectFont(Sender: TObject);
    procedure RulerResize(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure BoldButtonClick(Sender: TObject);
    procedure ItalicButtonClick(Sender: TObject);
    procedure FontSizeOldChange(Sender: TObject);
    procedure AlignButtonClick(Sender: TObject);
    procedure FontNameChange(Sender: TObject);
    procedure UnderlineButtonClick(Sender: TObject);
    procedure BulletsButtonClick(Sender: TObject);
    procedure RulerItemMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RulerItemMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FirstIndMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LeftIndMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RightIndMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure RichEditChange(Sender: TObject);
    procedure EditorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CustomDropDownFormEhInitForm(Sender: TCustomDropDownFormEh;
      DynParams: TDynVarsEh);
    procedure OKButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure CustomDropDownFormEhReturnParams(Sender: TCustomDropDownFormEh;
      DynParams: TDynVarsEh);
    procedure FontSizeChange(Sender: TObject);
  private
    FFileName: string;
    FUpdating: Boolean;
    FDragOfs: Integer;
    FDragging: Boolean;
    FPassParams: TDropDownPassParamsEh;
    function CurrText: TTextAttributes;
    procedure GetFontNames;
    procedure SetupRuler;
    procedure SetEditRect;
    procedure UpdateCursorPos;
    procedure WMDropFiles(var Msg: TWMDropFiles); message WM_DROPFILES;
    procedure PerformFileOpen(const AFileName: string);
    procedure SetModified(Value: Boolean);
  protected
    procedure SetInDynParams(DynParams: TDynVarsEh); override;
    procedure GetOutDynParams(var DynParams: TDynVarsEh); override;
  public
    class function GetGlobalRef: TCustomDropDownFormEh; override;
  end;


var
  RichEditWinEh: TRichEditWinEh;

function GetRichEditTextAsRtfText(RichEdit: TRichEdit): String;
procedure SetRichEditTextAsRtfText(RichEdit: TRichEdit; const Data: String);

implementation

uses RichEdit, ShellAPI;

resourcestring
  sOverWrite = 'OK to overwrite %s';
  sModified = 'Modified';
  sColRowInfo = 'Line: %3d   Col: %3d';

const
  RulerAdj = 4 / 3;
  GutterWid = 6;

{$R *.DFM}

function GetRichEditTextAsRtfText(RichEdit: TRichEdit): String;
var
  Stream: TStringStream;
begin
  Stream := TStringStream.Create('');
  try
    RichEdit.Lines.SaveToStream(Stream);
    Result := Stream.DataString;
  finally
    Stream.Free;
  end;
end;

procedure SetRichEditTextAsRtfText(RichEdit: TRichEdit; const Data: String);
const
  RTFHeader = '{\rtf';  { Do not localize }
  URTFHeader = '{urtf'; { Do not localize }
var
  Stream: TStringStream;
begin
  if (Pos(RTFHeader, Data) = 1) or (Pos(URTFHeader, Data) = 1) then
  begin
    Stream := TStringStream.Create(Data);
    try
      RichEdit.Lines.LoadFromStream(Stream);
    finally
      Stream.Free;
    end;
  end
  else
    RichEdit.Text := Data;
end;

class function TRichEditWinEh.GetGlobalRef: TCustomDropDownFormEh;
begin
  if RichEditWinEh = nil then
    Application.CreateForm(TRichEditWinEh, RichEditWinEh);
  Result := RichEditWinEh;
end;

procedure TRichEditWinEh.CustomDropDownFormEhInitForm(
  Sender: TCustomDropDownFormEh; DynParams: TDynVarsEh);
begin
  if DynParams.Count = 0 then
    FPassParams := pspByFieldNamesEh
  else if DynParams.Count = 1 then
  begin
    FPassParams := pspFieldValueEh;
    SetRichEditTextAsRtfText(Editor, DynParams.Items[0].AsString);
  end else
  begin
    FPassParams := pspRecordValuesEh;
    SetRichEditTextAsRtfText(Editor, DynParams.Items[0].AsString);
  end;

  OKButton.Enabled := not ReadOnly;
  Editor.ReadOnly := ReadOnly;
end;

procedure TRichEditWinEh.CustomDropDownFormEhReturnParams(
  Sender: TCustomDropDownFormEh; DynParams: TDynVarsEh);
begin
  DynParams.Items[0].AsString := GetRichEditTextAsRtfText(Editor);
end;

procedure TRichEditWinEh.SelectionChange(Sender: TObject);
var
  pa: TParaAttributes;
begin
  pa := Editor.Paragraph;
  try
    FUpdating := True;
    FirstInd.Left := Trunc(pa.FirstIndent * RulerAdj) - 4 + GutterWid;
    LeftInd.Left := Trunc((pa.LeftIndent + pa.FirstIndent) * RulerAdj) - 4 + GutterWid;
    RightInd.Left := Ruler.ClientWidth - 6 - Trunc((pa.RightIndent + GutterWid) * RulerAdj);
    BoldButton.Down := fsBold in Editor.SelAttributes.Style;
    ItalicButton.Down := fsItalic in Editor.SelAttributes.Style;
    UnderlineButton.Down := fsUnderline in Editor.SelAttributes.Style;
    BulletsButton.Down := Boolean(pa.Numbering);
    FontSize.Text := IntToStr(Editor.SelAttributes.Size);
    FontName.Text := Editor.SelAttributes.Name;
    case Ord(pa.Alignment) of
      0: LeftAlign.Down := True;
      1: RightAlign.Down := True;
      2: CenterAlign.Down := True;
    end;
    UpdateCursorPos;
  finally
    FUpdating := False;
  end;
end;

function TRichEditWinEh.CurrText: TTextAttributes;
begin
  Result := Editor.SelAttributes;
end;

{$IFDEF CIL}
procedure TRichStrEditDlgEh.GetFontNames;
var
  i: Integer;
  InstalledFonts: System.Drawing.Text.InstalledFontCollection;
begin
  FontName.Items.BeginUpdate;
  try
    FontName.Items.Clear;
    InstalledFonts := System.Drawing.Text.InstalledFontCollection.Create;
    for i := 0 to Length(InstalledFonts.Families) - 1 do
      FontName.Items.Add(InstalledFonts.Families[i].Name);
  finally
    FontName.Items.EndUpdate;
  end;
end;
{$ELSE}
function EnumFontsProc(var LogFont: TLogFont; var TextMetric: TTextMetric;
  FontType: Integer; Data: Pointer): Integer; stdcall;
begin
  TStrings(Data).Add(LogFont.lfFaceName);
  Result := 1;
end;

procedure TRichEditWinEh.GetFontNames;
var
  DC: HDC;
begin
  DC := GetDC(0);
  try
    EnumFonts(DC, nil, @EnumFontsProc, Pointer(FontName.Items));
  finally
    ReleaseDC(0, DC);
  end;
  FontName.Sorted := True;
end;
{$ENDIF}

procedure TRichEditWinEh.SetupRuler;
var
  I: Integer;
  S: String;
begin
  SetLength(S, 201);
  I := 1;
  while I < 200 do
  begin
    S[I] := #9;
    S[I + 1] := '|';
    Inc(I, 2);
  end;
  Ruler.Caption := S;
end;

procedure TRichEditWinEh.SetEditRect;
var
  R: TRect;
begin
  R := Rect(GutterWid, 0, Editor.ClientWidth - GutterWid, Editor.ClientHeight);
{$IFDEF CIL}
  SendStructMessage(Editor.Handle, EM_SETRECT, 0, R);
{$ELSE}
  SendMessage(Editor.Handle, EM_SETRECT, 0, LPARAM(@R));
{$ENDIF}
end;

procedure TRichEditWinEh.SetInDynParams(DynParams: TDynVarsEh);
begin
  inherited SetInDynParams(DynParams);
  SetRichEditTextAsRtfText(Editor, DynParams.Items[0].AsString);
end;

procedure TRichEditWinEh.GetOutDynParams(var DynParams: TDynVarsEh);
begin
  inherited GetOutDynParams(DynParams);
  DynParams.Items[0].AsString := GetRichEditTextAsRtfText(Editor);
end;

{ Event Handlers }

procedure TRichEditWinEh.FormCreate(Sender: TObject);
begin
  GetFontNames;
  SetupRuler;
  SelectionChange(Self);

  CurrText.Name := TFontName(DefFontData.Name);
  CurrText.Size := -MulDiv(DefFontData.Height, 72, Screen.PixelsPerInch);
end;

procedure TRichEditWinEh.ShowHint(Sender: TObject);
begin
  if Length(Application.Hint) > 0 then
  begin
    StatusBar.SimplePanel := True;
    StatusBar.SimpleText := Application.Hint;
  end
  else StatusBar.SimplePanel := False;
end;

procedure TRichEditWinEh.PerformFileOpen(const AFileName: string);
begin
  Editor.Lines.LoadFromFile(AFileName);
  Editor.SetFocus;
  Editor.Modified := False;
  SetModified(False);
end;

procedure TRichEditWinEh.FileOpen(Sender: TObject);
begin
  if OpenDialog.Execute then
  begin
    PerformFileOpen(OpenDialog.FileName);
    Editor.ReadOnly := ofReadOnly in OpenDialog.Options;
  end;
end;

procedure TRichEditWinEh.FileSave(Sender: TObject);
begin
  FileSaveAs(Sender)
end;

procedure TRichEditWinEh.FileSaveAs(Sender: TObject);
begin
  if SaveDialog.Execute then
  begin
    if not (AnsiUpperCase(Copy(SaveDialog.FileName, Length(SaveDialog.FileName) - 3, 4)) = '.RTF') then
      SaveDialog.FileName := SaveDialog.FileName + '.rtf';
    if FileExists(SaveDialog.FileName) then
      if MessageDlg(Format(sOverWrite, [SaveDialog.FileName]),
        mtConfirmation, mbYesNoCancel, 0) <> idYes then Exit;
    Editor.Lines.SaveToFile(SaveDialog.FileName);
    Editor.Modified := False;
    SetModified(False);
  end;
end;

procedure TRichEditWinEh.FilePrint(Sender: TObject);
begin
  if PrintDialog.Execute then
    Editor.Print(FFileName);
end;

procedure TRichEditWinEh.FileExit(Sender: TObject);
begin
  Close;
end;

procedure TRichEditWinEh.EditUndo(Sender: TObject);
begin
  if Editor.HandleAllocated then
    SendMessage(Editor.Handle, EM_UNDO, 0, 0);
end;

procedure TRichEditWinEh.EditCut(Sender: TObject);
begin
  Editor.CutToClipboard;
end;

procedure TRichEditWinEh.EditCopy(Sender: TObject);
begin
  Editor.CopyToClipboard;
end;

procedure TRichEditWinEh.EditPaste(Sender: TObject);
begin
  Editor.PasteFromClipboard;
end;

procedure TRichEditWinEh.SelectFont(Sender: TObject);
begin
  KeepFormVisible := True;
  FontDialog1.Font.Assign(Editor.SelAttributes);
  if FontDialog1.Execute then
    CurrText.Assign(FontDialog1.Font);
  SelectionChange(Self);
  Editor.SetFocus;
  KeepFormVisible := False;
end;

procedure TRichEditWinEh.RulerResize(Sender: TObject);
begin
  RulerLine.Width := Ruler.ClientWidth - (RulerLine.Left * 2);
end;

procedure TRichEditWinEh.FormResize(Sender: TObject);
begin
  SetEditRect;
  SelectionChange(Sender);
end;

procedure TRichEditWinEh.FormPaint(Sender: TObject);
begin
  SetEditRect;
end;

procedure TRichEditWinEh.BoldButtonClick(Sender: TObject);
begin
  if FUpdating then Exit;
  if BoldButton.Down then
    CurrText.Style := CurrText.Style + [fsBold]
  else
    CurrText.Style := CurrText.Style - [fsBold];
end;

procedure TRichEditWinEh.ItalicButtonClick(Sender: TObject);
begin
  if FUpdating then Exit;
  if ItalicButton.Down then
    CurrText.Style := CurrText.Style + [fsItalic]
  else
    CurrText.Style := CurrText.Style - [fsItalic];
end;

procedure TRichEditWinEh.FontSizeOldChange(Sender: TObject);
begin
  if FUpdating then Exit;
  CurrText.Size := StrToInt(FontSize.Text);
end;

procedure TRichEditWinEh.AlignButtonClick(Sender: TObject);
begin
  if FUpdating then Exit;
  Editor.Paragraph.Alignment := TAlignment(TControl(Sender).Tag);
end;

procedure TRichEditWinEh.FontNameChange(Sender: TObject);
begin
  if FUpdating then Exit;
  CurrText.Name := FontName.Items[FontName.ItemIndex];
end;

procedure TRichEditWinEh.UnderlineButtonClick(Sender: TObject);
begin
  if FUpdating then Exit;
  if UnderlineButton.Down then
    CurrText.Style := CurrText.Style + [fsUnderline]
  else
    CurrText.Style := CurrText.Style - [fsUnderline];
end;

procedure TRichEditWinEh.BulletsButtonClick(Sender: TObject);
begin
  if FUpdating then Exit;
  Editor.Paragraph.Numbering := TNumberingStyle(BulletsButton.Down);
end;

{ Ruler Indent Dragging }

procedure TRichEditWinEh.RulerItemMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FDragOfs := (TLabel(Sender).Width div 2);
  TLabel(Sender).Left := TLabel(Sender).Left + X - FDragOfs;
  FDragging := True;
end;

procedure TRichEditWinEh.RulerItemMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if FDragging then
    TLabel(Sender).Left := TLabel(Sender).Left + X - FDragOfs
end;

procedure TRichEditWinEh.FirstIndMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FDragging := False;
  Editor.Paragraph.FirstIndent := Trunc((FirstInd.Left + FDragOfs - GutterWid) / RulerAdj);
  LeftIndMouseUp(Sender, Button, Shift, X, Y);
end;

procedure TRichEditWinEh.LeftIndMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FDragging := False;
  Editor.Paragraph.LeftIndent := Trunc((LeftInd.Left + FDragOfs - GutterWid) / RulerAdj) - Editor.Paragraph.FirstIndent;
  SelectionChange(Sender);
end;

procedure TRichEditWinEh.RightIndMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FDragging := False;
  Editor.Paragraph.RightIndent := Trunc((Ruler.ClientWidth - RightInd.Left + FDragOfs - 2) / RulerAdj) - 2 * GutterWid;
  SelectionChange(Sender);
end;

procedure TRichEditWinEh.UpdateCursorPos;
var
  CharPos: TPoint;
begin
  CharPos.Y := SendMessage(Editor.Handle, EM_EXLINEFROMCHAR, 0, LPARAM(Editor.SelStart));
  CharPos.X := (Editor.SelStart -
    SendMessage(Editor.Handle, EM_LINEINDEX, CharPos.Y, 0));
  Inc(CharPos.Y);
  Inc(CharPos.X);
  StatusBar.Panels[1].Text := Format(sColRowInfo, [CharPos.Y, CharPos.X]);

  CopyButton.Enabled := Editor.SelLength > 0;
  EditCopyItem.Enabled := CopyButton.Enabled;
  CutButton.Enabled := CopyButton.Enabled;
  EditCutItem.Enabled := CopyButton.Enabled;

end;

procedure TRichEditWinEh.FormShow(Sender: TObject);
begin
  if Editor.Lines.Text <> '' then
  begin
    Editor.DefAttributes.Name := Editor.SelAttributes.Name;
    Editor.DefAttributes.Size := Editor.SelAttributes.Size;
  end else
  begin
    Editor.DefAttributes.Name := TFontName(DefFontData.Name);
    Editor.DefAttributes.Size := -MulDiv(DefFontData.Height, 72, Screen.PixelsPerInch);
  end;

  UpdateCursorPos;
  DragAcceptFiles(Handle, True);
  RichEditChange(nil);
  Editor.SetFocus;
end;

procedure TRichEditWinEh.WMDropFiles(var Msg: TWMDropFiles);
var
  CFileName: array[0..MAX_PATH] of Char;
begin
  try
{$IFDEF CIL}
  { TODO : To do DropFile }
{$ELSE}
    if DragQueryFile(Msg.Drop, 0, CFileName, MAX_PATH) > 0 then
    begin
      PerformFileOpen(CFileName);
      Msg.Result := 0;
    end;
{$ENDIF}
  finally
    DragFinish(Msg.Drop);
  end;
end;

procedure TRichEditWinEh.RichEditChange(Sender: TObject);
begin
  SetModified(Editor.Modified);
end;

procedure TRichEditWinEh.SetModified(Value: Boolean);
begin
  if Value
    then StatusBar.Panels[2].Text := sModified
    else StatusBar.Panels[2].Text := '';
end;

procedure TRichEditWinEh.OKButtonClick(Sender: TObject);
begin
  ModalResult := mrOk;
  if DropDownMode then
    Close;
end;

procedure TRichEditWinEh.CancelButtonClick(Sender: TObject);
begin
  ModalResult := mrCancel;
  if DropDownMode then
    Close;
end;

procedure TRichEditWinEh.FontSizeChange(Sender: TObject);
begin
  if FUpdating then Exit;
  CurrText.Size := StrToInt(FontSize.Text);
end;

procedure TRichEditWinEh.EditorKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then Close;
end;

initialization
  RegisterClass(TRichEditWinEh);
end.
