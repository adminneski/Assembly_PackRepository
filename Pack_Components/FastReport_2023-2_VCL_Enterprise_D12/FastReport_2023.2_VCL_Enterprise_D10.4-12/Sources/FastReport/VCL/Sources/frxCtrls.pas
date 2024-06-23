{***************************************************}
{                                                   }
{             FastReport VCL                        }
{              Tool controls                        }
{                                                   }
{         Copyright (c) 1998-2021                   }
{            by Fast Reports Inc.                   }
{                                                   }
{                                                   }
{  Flat ComboBox, FontComboBox v1.2                 }
{  For Delphi 2,3,4,5. Freeware.                    }
{                                                   }
{  Copyright (c) 1999 by:                           }
{    Dmitry Statilko (dima_misc@hotbox.ru)          }
{    - Main idea and realisation of Flat ComboBox   }
{      inherited from TCustomComboBox               }
{                                                   }
{    Vladislav Necheporenko (vlad_n@ua.fm)          }
{    - Help in bug fixes                            }
{    - Adaptation to work on Delphi 2               }
{    - MRU list in FontComboBox that stored values  }
{      in regitry                                   }
{    - Font preview box in FontComboBox             }
{    - New look style, like in Office XP            }
{                                                   }
{***************************************************}

unit frxCtrls;

interface

{$I frx.inc}

uses
  {$IFNDEF NONWINFPC}Windows, CommCtrl, Registry, ActiveX,{$ENDIF}
  {$IFDEF FPC}LCLType, LMessages, LCLIntf, LazHelper, LazarusPackageIntf,{$ENDIF}
  Messages, Types, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Variants,
  StdCtrls, ExtCtrls, Buttons, IniFiles,
  frGraphics, frDPIAwareUtils, frxDPIAwareBaseControls, frxClass, frCore, frTypes;

type
{$IFDEF DELPHI16}
[ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxCustomFilterEdit = class(TfrxDPIAwareBasePanel)
  private
    FFrameIsActive: Boolean;
    FClearBtnActive: Boolean;
    FEdit: TEdit;
    FBitmapActive: TBitmap;
    FBitmapUnactive: TBitmap;
    FOnFilterChanged: TNotifyEvent;
    FFilterColor: TColor;
    procedure DoFocus(Sender: TObject);
    procedure DoLostFocus(Sender: TObject);
    procedure DoTextChange(Sender: TObject);
    procedure UpdateSize;
    procedure SetFilterColor(const Value: TColor);
  protected
{$IFNDEF Linux}
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
{$ENDIF}
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure PaintBorder;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
  public
    procedure Paint; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property FilterColor: TColor read FFilterColor write SetFilterColor;
    property BitmapActive: TBitmap read FBitmapActive;
    property BitmapUnactive: TBitmap read FBitmapUnactive;
    property EditControl: TEdit read FEdit;
    property OnFilterChanged: TNotifyEvent read FOnFilterChanged write FOnFilterChanged;
  end;

{$IFDEF DELPHI16}
[ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxFilterEdit = class(TfrxCustomFilterEdit)
  published
    property Align;
    property Alignment;
    property Anchors;
    property AutoSize;
    property BitmapActive;
    property BitmapUnactive;
    property Constraints;
    property UseDockManager default True;
    property DockSite;
    property DoubleBuffered;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property EditControl;
    property FullRepaint;
    property ParentBiDiMode;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnConstrainedResize;
    property OnContextPopup;
    property OnDockDrop;
    property OnDockOver;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetSiteInfo;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
  end;

TfrxChangeItemEvent = function(var ANewText: string; const AOldText: string; const AItemIndex: integer): Boolean of Object;

{$IFDEF DELPHI16}
[ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxCustomComboBox = class(TCustomComboBox)
  private
    FButtonWidth: Integer;
    msMouseInControl: Boolean;
    FListInstance: Pointer;
    FDefListProc: Pointer;
    FSolidBorder: Boolean;
    FReadOnly: Boolean;
    FEditOffset: Integer;
    FListWidth: Integer;
    FCurrentPPI: Integer;
    FEditedItemIndex: Integer;
    FOnChangeItem: TfrxChangeItemEvent;
    FEditableItems: Boolean;
    {$IFDEF FPC}
    procedure SelectAllWhenClicked(Sender: TObject);
  protected
    procedure DoPPIChanged(aNewPPI: Integer); virtual;
    {$ELSE}
    FChildHandle: HWND;
    FListHandle: HWND;
    FUpDropdown: Boolean;
    procedure ListWndProc(var Message: TMessage);
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
    procedure WMDpiChanged(var Message: TMessage); message FRX_WM_DPICHANGED_AFTERPARENT;
    procedure PaintButton(ButtonStyle: Integer);
    procedure PaintBorder(DC: HDC; const SolidBorder: Boolean);
    procedure PaintDisabled;
    function GetSolidBorder: Boolean;
    function GetListHeight: Integer;
   protected
    procedure ComboWndProc(var Message: TMessage; ComboWnd: HWnd; ComboProc: Pointer); override;
    procedure WndProc(var Message: TMessage); override;
    procedure CreateWnd; override;
    procedure DrawImage(DC: HDC; Index: Integer; R: TRect); dynamic;
    procedure DoPPIChanged(aNewPPI: Integer); virtual;
    {$ENDIF}
    procedure Change; override;
    procedure SetItemIndex(const Value: Integer); override;
    procedure CMEnabledChanged(var Msg: TMessage); message CM_ENABLEDCHANGED;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure SetReadOnly(Value: Boolean);
    procedure SetListWidth(const Value: Integer);
    function DoChangeItem(const ANewText: string; const AOldText: string; const AItemIndex: integer): Boolean;
    procedure SetEditableItems(const Value: Boolean);
  protected
    {$IFDEF FPC}
    OnlyMask: Boolean;
    {$ENDIF}
    procedure CreateParams(var Params: TCreateParams); override;
    procedure KeyPress(var Key: Char); override;
    function GetScale: Single;
    property ListWidth: Integer read FListWidth write SetListWidth;
    property ReadOnly: Boolean read FReadOnly write SetReadOnly default False;
    property SolidBorder: Boolean read FSolidBorder;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    {$IFNDEF FPC}
    procedure Resize; override;
    {$ENDIF}
    property EditableItems: Boolean read FEditableItems write SetEditableItems;
    property OnChangeItem: TfrxChangeItemEvent read FOnChangeItem write FOnChangeItem;
  end;

{$IFDEF DELPHI16}
[ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxComboBox = class(TfrxCustomComboBox)
  published
    property Color;
    property DragMode;
    property DragCursor;
    property DropDownCount;
    property Enabled;
    property Font;
    property ItemHeight;
    property Items;
    property ListWidth;
    property MaxLength;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Sorted;
    property TabOrder;
    property TabStop;
    property Text;
    property ReadOnly;
    property Visible;
    property ItemIndex;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawItem;
    property OnDropDown;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnStartDrag;
{$IFDEF DELPHI4}
    property Anchors;
    property BiDiMode;
    property Constraints;
    property DragKind;
    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
{$ENDIF}
  end;

{$IFDEF DELPHI16}
[ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxFontPreview = class(TWinControl)
  private
    FPanel: TPanel;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetDefaultFontSize(aNewPPI: Integer);
  end;

{$IFDEF DELPHI16}
[ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxFontComboBox = class(TfrxCustomComboBox)
  private
    {$IFNDEF FPC}
    frFontViewForm: TfrxFontPreview;
    {$ENDIF}
    FRegKey: String;
    FTrueTypeBMP: TBitmap;
    FDeviceBMP: TBitmap;
    FOnClick: TNotifyEvent;
    FUpdate: Boolean;
    FShowMRU: Boolean;
    Numused: Integer;
    FIni: TCustomIniFile;
    {$IFNDEF FPC}
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
    {$ENDIF}
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMFontChange(var Message: TMessage); message CM_FONTCHANGE;
    procedure SetRegKey(Value: String);
  protected
    procedure Loaded; override;
    procedure Init;
    procedure Reset;
    procedure Click; override;
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
    procedure DrawImage(DC: HDC; Index: Integer; R: TRect); {$IFNDEF FPC}  override; {$ENDIF}
    procedure DoPPIChanged(aNewPPI: Integer); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure PopulateList; virtual;
    property IniFile: TCustomIniFile read FIni write FIni;
  published
    property ShowMRU: Boolean read FShowMRU write FShowMRU default True;
    property MRURegKey: String read FRegKey write SetRegKey;
    property Text;
    property Color;
    property DragMode;
    property DragCursor;
    property DropDownCount;
    property Enabled;
    property Font;
{$IFDEF DELPHI4}
    property Anchors;
    property BiDiMode;
    property Constraints;
    property DragKind;
    property ParentBiDiMode;
{$ENDIF}
    property ItemHeight;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnChange;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDropDown;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnStartDrag;
{$IFDEF DELPHI4}
    property OnEndDock;
    property OnStartDock;
{$ENDIF}
  end;

{$IFDEF DELPHI16}
[ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxComboEdit = class(TComboBox)
  private
    FPanel: TWinControl;
    FButton: TSpeedButton;
    FButtonEnabled: Boolean;
    FOnButtonClick: TNotifyEvent;
    {$IFDEF FPC}
    {$IFNDEF NONWINFPC}
    function GetEditHandle: HWND;
    {$ENDIF}
    {$ENDIF}
    function GetGlyph: TBitmap;
    procedure SetGlyph(Value: TBitmap);
    function GetButtonHint: String;
    procedure SetButtonHint(Value: String);
    procedure SetButtonEnabled(Value: Boolean);
    procedure ButtonClick(Sender: TObject);
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure SetPos;
  public
    constructor Create(AOwner: TComponent); override;
    procedure CreateWnd; override;
    procedure KeyPress(var Key: Char); override;
    {$IFDEF FPC}
    {$IFNDEF NONWINFPC}
    property EditHandle: HWND read GetEditHandle;
    {$ENDIF}
    {$ENDIF}
  published
    property Glyph: TBitmap read GetGlyph write SetGlyph;
    property ButtonEnabled: Boolean read FButtonEnabled write SetButtonEnabled default True;
    property ButtonHint: String read GetButtonHint write SetButtonHint;
    property OnButtonClick: TNotifyEvent read FOnButtonClick write FOnButtonClick;
  end;

  TfrxScrollMaxChangeEvent = procedure(Sender: TObject; Orientation: TfrxScrollerOrientation; Value: Integer) of Object;
  TfrxScrollPosChangeEvent = procedure(Sender: TObject; Orientation: TfrxScrollerOrientation; var Value: Integer) of Object;

  TfrxScrollWin = class(TCustomControl)
  private
    FBorderStyle: TBorderStyle;
    FHorzPage: Integer;
    FHorzPosition: Integer;
    FHorzRange: Integer;
    FLargeChange: Integer;
    FSmallChange: Integer;
    FVertPage: Integer;
    FVertPosition: Integer;
    FVertRange: Integer;
    FHideScrolls: Boolean;
    FOnScrollMaxChange: TfrxScrollMaxChangeEvent;
    FOnScrollPosChange: TfrxScrollPosChangeEvent;
    procedure SetHideScrolls(b: Boolean);
    function GetLongPosition(DefValue: Integer; Code: Word): Integer;
    procedure SetHorzPosition(Value: Integer);
    procedure SetHorzRange(Value: Integer);
    procedure SetPosition(Value: Integer; Code: Word);
    procedure SetVertPosition(Value: Integer);
    procedure SetVertRange(Value: Integer);
    procedure UpdateScrollBar(Max, Page, Pos: Integer; Code: Word);
    procedure WMEraseBackground(var Message: TMessage); message WM_ERASEBKGND;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMHScroll(var Message: TWMHScroll); message WM_HSCROLL;
    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;
    procedure SetHorzPage(const Value: Integer);
    procedure SetVertPage(const Value: Integer);
    procedure SetBorderStyle(const Value: TBorderStyle);
  protected
    FfrCurrentPPI: Integer;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure OnHScrollChange(Sender: TObject); virtual;
    procedure OnVScrollChange(Sender: TObject); virtual;
    procedure WMDpiChanged(var Message: TMessage); message FRX_WM_DPICHANGED_AFTERPARENT;
    procedure DoPPIChanged(aNewPPI: Integer); virtual;
    function GetScale: Single;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Paint; override;
    function GetScaledFontSize: Integer;
    procedure SetScaledFontSize(Value: Integer);
    {$IFNDEF FPC}
    property BevelKind;
    {$ENDIF}
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle;
    property HorzPage: Integer read FHorzPage write SetHorzPage;
    property HorzPosition: Integer read FHorzPosition write SetHorzPosition;
    property HorzRange: Integer read FHorzRange write SetHorzRange;
    property LargeChange: Integer read FLargeChange write FLargeChange;
    property SmallChange: Integer read FSmallChange write FSmallChange;
    property VertPage: Integer read FVertPage write SetVertPage;
    property VertPosition: Integer read FVertPosition write SetVertPosition;
    property VertRange: Integer read FVertRange write SetVertRange;
    property HideScrolls: Boolean read FHideScrolls write SetHideScrolls;
    property OnScrollMaxChange: TfrxScrollMaxChangeEvent read FOnScrollMaxChange write FOnScrollMaxChange;
    property OnScrollPosChange: TfrxScrollPosChangeEvent read FOnScrollPosChange write FOnScrollPosChange;
  end;

   function frxBlend(C1, C2: TColor; W1: Integer): TColor;
{$IFDEF FPC}
//  procedure Register;
{$ENDIF}

implementation

{$R *.res}
{$IFDEF DELPHI6}
{$WARN SYMBOL_DEPRECATED OFF}
{$ENDIF}

uses frxPrinter, frxUtils;

const
  fr01cm = 3.77953;
  fr01in = 96 / 10;

type
  THackScrollBar = class(TScrollBar);


{ Additional functions }

function Min(val1, val2: Word): Word;
begin
  Result := val1;
  if val1 > val2 then
    Result := val2;
end;

function GetFontMetrics(Font: TFont): TTextMetric;
var
  DC: HDC;
  SaveFont: HFont;
begin
  DC := GetDC(0);
  SaveFont := SelectObject(DC, Font.Handle);
  GetTextMetrics(DC, Result);
  SelectObject(DC, SaveFont);
  ReleaseDC(0, DC);
end;

function GetFontHeight(Font: TFont): Integer;
begin
  Result := GetFontMetrics(Font).tmHeight;
end;

function frxBlend(C1, C2: TColor; W1: Integer): TColor;
var
  W2, A1, A2, D, F, G: Integer;
begin
  if C1 < 0 then C1 := GetSysColor(C1 and $FF);
  if C2 < 0 then C2 := GetSysColor(C2 and $FF);

  if W1 >= 100 then D := 1000
  else D := 100;

  W2 := D - W1;
  F := D div 2;

  A2 := C2 shr 16 * W2;
  A1 := C1 shr 16 * W1;
  G := (A1 + A2 + F) div D and $FF;
  Result := G shl 16;

  A2 := (C2 shr 8 and $FF) * W2;
  A1 := (C1 shr 8 and $FF) * W1;
  G := (A1 + A2 + F) div D and $FF;
  Result := Result or G shl 8;

  A2 := (C2 and $FF) * W2;
  A1 := (C1 and $FF) * W1;
  G := (A1 + A2 + F) div D and $FF;
  Result := Result or G;
end;

{ TfrxCustomFilterEdit }

procedure TfrxCustomFilterEdit.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  FFrameIsActive := True;
  {$IFDEF FPC}
  {$note FIXME TfrxCustomComboBox.CMMouseEnter}
  {$ELSE}
  if Enabled then
  begin
    PaintBorder;
    Invalidate;
  end;
  {$ENDIF}
end;

procedure TfrxCustomFilterEdit.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  FFrameIsActive := False;
  {$IFDEF FPC}
  {$note FIXME TfrxCustomComboBox.CMMouseLeave}
  {$ELSE}
  if Enabled and not FEdit.Focused then
  begin
    PaintBorder;
    Invalidate;
  end;
  {$ENDIF}
end;

constructor TfrxCustomFilterEdit.Create(AOwner: TComponent);
begin
  inherited;
{$IFNDEF FPC}
  BevelKind := bkNone;
{$ENDIF}
  BevelInner := bvNone;
  BevelOuter := bvNone;
  BorderStyle := bsSingle;
  BorderWidth := 1;
  FEdit := TEdit.Create(nil);
  FEdit.Parent := Self;
  FEdit.BorderStyle := bsNone;
  FEdit.OnEnter := DoFocus;
  FEdit.OnExit := DoLostFocus;
  FEdit.OnChange := DoTextChange;
  Color := clWindow;
  FilterColor := clWindow;
  FBitmapActive := TBitmap.Create;
  FBitmapUnactive := TBitmap.Create;
end;

destructor TfrxCustomFilterEdit.Destroy;
begin
  FreeAndNil(FBitmapActive);
  FreeAndNil(FBitmapUnactive);
  FreeAndNil(FEdit);
  inherited;
end;

procedure TfrxCustomFilterEdit.DoFocus(Sender: TObject);
begin
  FFrameIsActive := True;
  PaintBorder;
  Invalidate;
end;

procedure TfrxCustomFilterEdit.DoLostFocus(Sender: TObject);
begin
  FFrameIsActive := False;
  PaintBorder;
  Invalidate;
end;

procedure TfrxCustomFilterEdit.DoTextChange(Sender: TObject);
var
  bTextIsEmpty: Boolean;
begin
  bTextIsEmpty := FEdit.Text <> '';
  if bTextIsEmpty <> FClearBtnActive then
  begin
    FClearBtnActive := bTextIsEmpty;
    UpdateSize;
    Invalidate;
  end;
  if Assigned(FOnFilterChanged) then
    FOnFilterChanged(Sender);
end;

procedure TfrxCustomFilterEdit.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  if (X > 1) and (X < Height) then
    FEdit.Clear;
end;

procedure TfrxCustomFilterEdit.Paint;
var
  aRect: TRect;
  btnWidth, Offset: Integer;
  LG: {$IFDEF FPC}TLogBrush{$ELSE}LOGBRUSH{$ENDIF};
  hP: HPEN;
  OldPen: HGDIOBJ;
  SerchIcon: TBitmap;
begin
  inherited;
  aRect := GetClientRect;
  Canvas.Brush.Style := bsSolid;
  Canvas.Brush.Color := FFilterColor;
  Offset := Round(4 * GetScale);
  Canvas.FillRect(aRect);
  btnWidth := ((aRect.Bottom - aRect.Top) - Offset * 2) div 2 * 2;

  LG.lbStyle := BS_SOLID;
  LG.lbColor := 0;// black;
  LG.lbHatch := 0;

  hP := ExtCreatePen(PS_GEOMETRIC or PS_ENDCAP_ROUND, Round(GetScale),
    LG, 0, nil);
  try
    OldPen := SelectObject(Canvas.Handle, hP);
    Canvas.MoveTo(Offset, Offset);
    Canvas.LineTo(btnWidth + Offset, btnWidth + Offset);
    Canvas.MoveTo(Offset, btnWidth + Offset);
    Canvas.LineTo(btnWidth + Offset, Offset);
    Canvas.Brush.Color := clBlack;
    SelectObject(Canvas.Handle, OldPen);
  finally
    DeleteObject(hP);
  end;
  Offset := 0;
  btnWidth := ((aRect.Bottom - aRect.Top) - Offset * 2) div 2 * 2;
  if FFrameIsActive then
    SerchIcon := FBitmapActive
  else
    SerchIcon := FBitmapUnactive;
  Canvas.StretchDraw(Rect((aRect.Right - aRect.Left - btnWidth + 1), 1, (aRect.Right - aRect.Left - btnWidth + 1) + btnWidth, btnWidth), SerchIcon);
end;

procedure TfrxCustomFilterEdit.PaintBorder;
var
  R: TRect;
  DC: HDC;
begin
  DC := GetWindowDC(Handle);
  try
    GetWindowRect(Handle, R);
    OffsetRect(R, -R.Left, -R.Top);
    InflateRect(R, 0, 0);
    if FFrameIsActive then
      FrameRect(DC, R, GetSysColorBrush(COLOR_HIGHLIGHT))
    else
      FrameRect(DC, R, GetSysColorBrush(COLOR_WINDOW));
  finally
    ReleaseDC(Handle, DC);
  end;
end;

procedure TfrxCustomFilterEdit.SetFilterColor(const Value: TColor);
begin
  FFilterColor := Value;
  Color := Value;
  EditControl.Color := Color;
end;

procedure TfrxCustomFilterEdit.UpdateSize;
var
  nOffset: Integer;
begin
  nOffset := Round(2 * GetScale);
  FClearBtnActive := FEdit.Text <> '';
  if FClearBtnActive then
    FEdit.SetBounds(Height, nOffset, Width - Height * 2, Height - 1)
  else
    FEdit.SetBounds(1, nOffset, Width - Height, Height - 1);
end;

{$IFNDEF Linux}
procedure TfrxCustomFilterEdit.WMNCPaint(var Message: TWMNCPaint);
var
  R: TRect;
  DC: HDC;
begin
  DC := GetWindowDC(Handle);
  try
    GetWindowRect(Handle, R);
    OffsetRect(R, -R.Left, -R.Top);
    InflateRect(R, 0, 0);
    FillRect(DC, R, GetSysColorBrush(Color))
  finally
    ReleaseDC(Handle, DC);
  end;
  PaintBorder;
end;
{$ENDIF}

procedure TfrxCustomFilterEdit.WMSize(var Message: TWMSize);
begin
  inherited;
  UpdateSize;
end;

{ TfrxCustomComboBox }

constructor TfrxCustomComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  {$IFDEF FPC}
  FListInstance := nil;
  OnClick := SelectAllWhenClicked;
  {$IFDEF FPC}
  OnlyMask := False;
  {$ENDIF}
  {$ELSE}
  FListInstance := MakeObjectInstance(ListWndProc);
  {$ENDIF}
  FDefListProc := nil;
  ItemHeight := GetFontHeight(Font);
  Width := 100;
  FEditOffset := 0;
  FCurrentPPI := Screen.PixelsPerInch;
  FButtonWidth := Round(11 * FCurrentPPI / frx_DefaultPPI);
end;

destructor TfrxCustomComboBox.Destroy;
begin
  inherited Destroy;
  {$IFNDEF FPC}
  FreeObjectInstance(FListInstance);
  {$ENDIF}
end;

function TfrxCustomComboBox.DoChangeItem(const ANewText,
  AOldText: string; const AItemIndex: integer): Boolean;
var
  LText: string;
begin
  Result := True;
  LText := ANewText;
  if Assigned(FOnChangeItem) then
    Result := FOnChangeItem(LText, AOldText, AItemIndex);

  if Result then
    Items[AItemIndex] := LText;
end;

procedure TfrxCustomComboBox.DoPPIChanged(aNewPPI: Integer);
begin
  FButtonWidth := MulDiv(11, aNewPPI, FCurrentPPI);
  FListWidth := MulDiv(FListWidth, aNewPPI, FCurrentPPI);
end;

procedure TfrxCustomComboBox.SetEditableItems(const Value: Boolean);
begin
  FEditableItems := Value;
  if Value then
    AutoComplete := False;
end;

procedure TfrxCustomComboBox.SetItemIndex(const Value: Integer);
begin
  inherited;
  FEditedItemIndex := -1;
end;

procedure TfrxCustomComboBox.SetListWidth(const Value: Integer);
begin
  FListWidth := MulDiv(Value, FCurrentPPI, frx_DefaultPPI);
end;

procedure TfrxCustomComboBox.SetReadOnly(Value: Boolean);
begin
  if FReadOnly <> Value then
  begin
    FReadOnly := Value;
    {$IFDEF FPC}
    inherited ReadOnly := Value;
    {$ELSE}
    if HandleAllocated then
      SendMessage(EditHandle, EM_SETREADONLY, Ord(Value), 0);
    {$ENDIF}
  end;
end;

procedure TfrxCustomComboBox.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  {$IFNDEF FPC}
  with Params do
    Style := (Style and not CBS_DROPDOWNLIST) or CBS_OWNERDRAWFIXED or CBS_DROPDOWN;
  {$ENDIF}
end;

function TfrxCustomComboBox.GetScale: Single;
begin
  Result := FCurrentPPI / frx_DefaultPPI;
end;

{$IFNDEF FPC}
procedure TfrxCustomComboBox.CreateWnd;
begin
  inherited;
  SendMessage(EditHandle, EM_SETREADONLY, Ord(FReadOnly), 0);
  // Desiding, which of the handles is DropDown list handle...
  if FChildHandle <> EditHandle then
    FListHandle := FChildHandle;
  //.. and superclassing it
  FDefListProc := Pointer(GetWindowLong(FListHandle, GWL_WNDPROC));
  SetWindowLong(FListHandle, GWL_WNDPROC, frInteger(FListInstance));
end;

procedure TfrxCustomComboBox.ListWndProc(var Message: TMessage);
var
  p: TPoint;

  procedure CallDefaultProc;
  begin
    with Message do
      Result := CallWindowProc(FDefListProc, FListHandle, Msg, WParam, LParam);
  end;

begin
  case Message.Msg of
    LB_SETTOPINDEX:
      begin
        if ItemIndex > DropDownCount then
          CallDefaultProc;
      end;
    WM_WINDOWPOSCHANGING:
      with TWMWindowPosMsg(Message).WindowPos^ do
      begin
        // calculating the size of the drop down list
        if FListWidth <> 0 then
          cx := FListWidth else
          cx := Width;
        cy := GetListHeight;
        p.x := cx;
        p.y := cy + GetFontHeight(Font) + 6;
        p := ClientToScreen(p);
        FUpDropdown := False;
        if p.y > Screen.Height then //if DropDownList showing below
          begin
            FUpDropdown := True;
          end;
      end;
    else
      CallDefaultProc;
  end;
end;

procedure TfrxCustomComboBox.WndProc(var Message: TMessage);
begin
  case Message.Msg of
    WM_SETTEXT:
      Invalidate;
     WM_PARENTNOTIFY:
       if LoWord(Message.wParam)=WM_CREATE then begin
         if FDefListProc <> nil then
           begin
             // This check is necessary to be sure that combo is created, not
             // RECREATED (somehow CM_RECREATEWND does not work)
             SetWindowLong(FListHandle, GWL_WNDPROC, frInteger(FDefListProc));
             FDefListProc := nil;
             FChildHandle := Message.lParam;
           end
          else
           begin
             // WM_Create is the only event I found where I can get the ListBox handle.
             // The fact that combo box usually creates more then 1 handle complicates the
             // things, so I have to have the FChildHandle to resolve it later (in CreateWnd).
             if FChildHandle = 0 then
               FChildHandle := Message.lParam
             else
               FListHandle := Message.lParam;
           end;
       end;
    WM_WINDOWPOSCHANGING:
      {$IFDEF FPC}
      {$warning MoveWindow can't be used here - we have resize loop and crash.}
      {$ELSE}
      MoveWindow(EditHandle, 3+FEditOffset, 3, Width-FButtonWidth-8-FEditOffset,
        Height-6, True);
      {$ENDIF}
  end;
  inherited;
end;

procedure TfrxCustomComboBox.WMDpiChanged(var Message: TMessage);
var
  NewPPI: Integer;
begin
  Inherited;
  NewPPI := frxGetDpiForWindow(Handle);
  if NewPPI = FCurrentPPI then Exit;
  DoPPIChanged(NewPPI);
  FCurrentPPI := NewPPI;
end;

procedure TfrxCustomComboBox.WMPaint(var Message: TWMPaint);
var
  PS, PSE: TPaintStruct;
begin
  BeginPaint(Handle,PS);
  try
    if Enabled then
    begin
      DrawImage(PS.HDC, ItemIndex ,Rect(3, 3, FEditOffset + 3, Height - 3));
      if GetSolidBorder then
      begin
        PaintBorder(PS.HDC, True);
        if DroppedDown then
          PaintButton(2)
        else
          PaintButton(1);
      end else
      begin
        PaintBorder(PS.HDC, False);
        PaintButton(0);
      end;
    end else
    begin
      {$IFNDEF FPC}
      BeginPaint(EditHandle, PSE);
      try
        PaintDisabled;
      finally
        EndPaint(EditHandle, PSE);
      end;
      {$ENDIF}
    end;
  finally
    EndPaint(Handle,PS);
  end;
  Message.Result := 0;
end;

procedure TfrxCustomComboBox.DrawImage(DC: HDC; Index: Integer; R: TRect);
begin
  if FEditOffset > 0 then
   FillRect(DC, R, GetSysColorBrush(COLOR_WINDOW));
end;

procedure TfrxCustomComboBox.ComboWndProc(var Message: TMessage; ComboWnd: HWnd;
  ComboProc: Pointer);
var
  DC: HDC;
begin
  inherited;
  if (ComboWnd = EditHandle) then
    case Message.Msg of
      WM_SETFOCUS:
        begin
          DC:=GetWindowDC(Handle);
          PaintBorder(DC,True);
          PaintButton(1);
          ReleaseDC(Handle,DC);
        end;
      WM_KILLFOCUS:
        begin
          DC:=GetWindowDC(Handle);
          PaintBorder(DC,False);
          PaintButton(0);
          ReleaseDC(Handle,DC);
        end;
    end;
end;

procedure TfrxCustomComboBox.CNCommand(var Message: TWMCommand);
begin
  inherited;
  if (Message.NotifyCode in [CBN_CLOSEUP]) then
    PaintButton(1);
end;

procedure TfrxCustomComboBox.PaintBorder(DC: HDC; const SolidBorder: Boolean);
var
  R: TRect;
begin
  GetWindowRect(Handle, R);
  OffsetRect(R, -R.Left, -R.Top);
  if SolidBorder then
    FrameRect(DC, R, GetSysColorBrush(COLOR_HIGHLIGHT))
  else
    FrameRect(DC, R, GetSysColorBrush(COLOR_BTNFACE));
  InflateRect(R, -1, -1);
  FrameRect(DC, R, GetSysColorBrush(COLOR_WINDOW));
  InflateRect(R, -1, -1);
  R.Right:=R.Right - FButtonWidth - 2;
  FrameRect(DC, R, GetSysColorBrush(COLOR_WINDOW));
end;

procedure TfrxCustomComboBox.PaintButton(ButtonStyle: Integer);
var
  R: TRect;
  DC: HDC;

  procedure FillButton(DC: HDC; R: TRect; Color: TColor);
  var
    Brush, SaveBrush: HBRUSH;
  begin
    Brush := CreateSolidBrush(ColorToRGB(Color));
    SaveBrush := SelectObject(DC, Brush);
    FillRect(DC, R, Brush);
    SelectObject(DC, SaveBrush);
    DeleteObject(Brush);
  end;

  procedure PaintButtonLine(DC: HDC; Color: TColor);
  var
    Pen, SavePen: HPEN;
    R: TRect;
  begin
    GetWindowRect(Handle, R);
    OffsetRect (R, -R.Left, -R.Top);
    InflateRect(R, -FButtonWidth - 4, -1);
    Pen := CreatePen(PS_SOLID, 1, ColorToRGB(Color));
    SavePen := SelectObject(DC, Pen);
    MoveToEx(DC, R.Right, R.Top, nil);
    LineTo(DC, R.Right, R.Bottom);
    SelectObject(DC, SavePen);
    DeleteObject(Pen);
  end;

begin
  DC := GetWindowDC(Handle);
  //X := Trunc(FButtonWidth / 2) + Width - FButtonWidth - 4;
  //Y := Trunc((Height - 4) / 2) + 1;

  SetRect(R, Width - FButtonWidth - 3, 1, Width - 1, Height - 1);
  if ButtonStyle = 0 then //No 3D border
  begin
    FillButton(DC, R, clBtnFace);
    FrameRect(DC, R, GetSysColorBrush(COLOR_WINDOW));
    PaintButtonLine(DC, clWindow);
    frxDrawArrow(Canvas, R, clBtnText);
  end;
  if ButtonStyle = 1 then //3D up border
  begin
    FillButton(DC, R, frxBlend(clHighlight, clWindow, 30));
    PaintButtonLine(DC, clHighlight);
    frxDrawArrow(Canvas, R, clBtnText);
  end;
  if ButtonStyle = 2 then //3D down border
  begin
    FillButton(DC, R, frxBlend(clHighlight, clWindow, 50));
    PaintButtonLine(DC, clHighlight);
    frxDrawArrow(Canvas, R, clCaptionText);
  end;
  ReleaseDC(Handle, DC);
end;

procedure TfrxCustomComboBox.PaintDisabled;
var
  R: TRect;
  Brush, SaveBrush: HBRUSH;
  DC: HDC;
  BtnShadowBrush: HBRUSH;
begin
  BtnShadowBrush := GetSysColorBrush(COLOR_BTNSHADOW);
  DC := GetWindowDC(Handle);
  Brush := CreateSolidBrush(GetSysColor(COLOR_BTNFACE));
  SaveBrush := SelectObject(DC, Brush);
  FillRect(DC, ClientRect, Brush);
  SelectObject(DC, SaveBrush);
  DeleteObject(Brush);
  GetWindowRect(Handle, R);
  OffsetRect(R, -R.Left, -R.Top);
  FrameRect(DC, R, BtnShadowBrush);
  SetRect(R, Width - FButtonWidth - 3, 1, Width - 1, Height - 1);
  frxDrawArrow(Canvas, R, clGrayText);
  ReleaseDC(Handle,DC);
end;

procedure TfrxCustomComboBox.Resize;
var
  m: TMessage;
begin
  inherited;
  m.Msg := FRX_WM_DPICHANGED_AFTERPARENT;
  WMDpiChanged(m);
end;

function TfrxCustomComboBox.GetSolidBorder: Boolean;
begin
  Result := ((csDesigning in ComponentState)) or
    (DroppedDown or (GetFocus = {$IFDEF FPC}Handle{$ELSE}EditHandle{$ENDIF}) or msMouseInControl);
end;

function TfrxCustomComboBox.GetListHeight: Integer;
begin
  Result := ItemHeight * Min(DropDownCount, Items.Count) + 2;
  if (DropDownCount <= 0) or (Items.Count = 0) then
    Result := ItemHeight + 2;
end;
{$ELSE}
procedure TfrxCustomComboBox.SelectAllWhenClicked(Sender: TObject);
begin
  SelectAll;
end;
{$ENDIF}
procedure TfrxCustomComboBox.Change;
begin
  inherited;
  if ItemIndex >= 0 then
    FEditedItemIndex := -1;
end;

procedure TfrxCustomComboBox.CMEnabledChanged(var Msg: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TfrxCustomComboBox.CMMouseEnter(var Message: TMessage);
var
  DC: HDC;
begin
  inherited;
  msMouseInControl := True;
  {$IFDEF FPC}
  {$note FIXME TfrxCustomComboBox.CMMouseEnter}
  {$ELSE}
  if Enabled and not (GetFocus = EditHandle) and not DroppedDown then
  begin
    DC:=GetWindowDC(Handle);
    PaintBorder(DC, True);
    PaintButton(1);
    ReleaseDC(Handle, DC);
  end;
  {$ENDIF}
end;

procedure TfrxCustomComboBox.CMMouseLeave(var Message: TMessage);
var
  DC: HDC;
begin
  inherited;
  msMouseInControl := False;
  {$IFDEF FPC}
  {$note FIXME TfrxCustomComboBox.CMMouseLeave}
  {$ELSE}
  if Enabled  and not (GetFocus = EditHandle) and not DroppedDown then
  begin
    DC:=GetWindowDC(Handle);
    PaintBorder(DC, False);
    PaintButton(0);
    ReleaseDC(Handle, DC);
  end;
  {$ENDIF}
end;

procedure TfrxCustomComboBox.KeyPress(var Key: Char);
var
 sPos: Integer;
 {$IFDEF FPC}
 Mask: boolean;
 i: Integer;
 Bufstr: String;
 {$ELSE}
 sLen: Integer;
 {$ENDIF}
begin

  if FEditableItems and (FEditedItemIndex >= 0) and (Key = #13)
    and DoChangeItem(Text, Items[FEditedItemIndex],  FEditedItemIndex) then
    ItemIndex := FEditedItemIndex;

  if FEditedItemIndex < 0 then
    FEditedItemIndex := ItemIndex;

  inherited KeyPress(Key);
  {$IFDEF FPC}
  if(Key=#8) then exit;
  Bufstr := AnsiUpperCase(Text);
  Delete(Bufstr, SelStart+1, SelLength);
  Bufstr := Bufstr + AnsiUpperCase(Key);
  Mask := false;
  for i:= 0 to Items.Count-1 do
    if(Pos(Bufstr, AnsiUpperCase(Items[i]))=1) then
    begin
      sPos := Bufstr.Length;
      ItemIndex:=i;
      Click();
      SelStart := sPos;
      SelLength := Length(Text)-sPos;
      Mask := True;
      break;
    end;
  if (Mask) or (OnlyMask) then
    Key := #0;
  {$ELSE}
  if (ItemIndex >= 0) and (ItemIndex < Items.Count) then
  begin
    sPos := SelStart;
    sLen := SelLength;
    Text := Items[ItemIndex];
    SelStart := sPos;
    SelLength := sLen;
  end;
  {$ENDIF}
end;

procedure TfrxCustomComboBox.CMFontChanged(var Message: TMessage);
begin
  inherited;
  ItemHeight := GetFontHeight(Font);
  {$IFNDEF FPC}
  RecreateWnd;
  {$ENDIF}
end;

{ TfrxFontComboBox }

function CreateBitmap(ResName: PChar): TBitmap;
begin
   Result := TBitmap.Create;
   Result.Handle := LoadBitmap(HInstance, ResName);
   if Result.Handle = 0 then
   begin
     Result.Free;
     Result := nil;
   end;
end;

function EnumFontsProc(var LogFont: TLogFont; var TextMetric: TTextMetric;
  FontType: Integer; Data: Pointer): Integer; stdcall;
begin
  if (TStrings(Data).IndexOf(LogFont.lfFaceName) < 0) then
    TStrings(Data).AddObject(LogFont.lfFaceName, TObject(FontType));
  Result := 1;
end;

constructor TfrxFontComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  {$IFNDEF FPC}
  if not (csDesigning in ComponentState) then
    frFontViewForm := TfrxFontPreview.Create(Self);
  {$ENDIF}
  Width := 150;
  DoPPIChanged(Screen.PixelsPerInch);
  FShowMRU := True;
  Numused := -1;
  MRURegKey := '';
  FIni := nil;
end;

destructor TfrxFontComboBox.Destroy;
begin
  FTrueTypeBMP.Free;
  FDeviceBMP.Free;
  if FIni <> nil then
    Fini.Free;
  {$IFNDEF FPC}
  if not (csDesigning in ComponentState) then
    frFontViewForm.Destroy;
  {$ENDIF}
  inherited Destroy;
end;

procedure TfrxFontComboBox.DoPPIChanged(aNewPPI: Integer);
begin
  inherited;
  FreeAndNil(FTrueTypeBMP);
  FreeAndNil(FDeviceBMP);
  FTrueTypeBMP := CreateBitmap('FRXTRUETYPE_FNT');
  FDeviceBMP := CreateBitmap('FRXDEVICE_FNT');
  ScaleBitmap(FTrueTypeBMP, aNewPPI);
  ScaleBitmap(FDeviceBMP, aNewPPI);
  DropDownCount := 12;
  {$IFNDEF FPC}
  FEditOffset := FTrueTypeBMP.Width;
  FReadOnly := True;
  {$ELSE}
  OnlyMask := True;
  {$ENDIF}
end;

procedure TfrxFontComboBox.Loaded;
begin
  inherited Loaded;
  if csDesigning in ComponentState then exit;
  FUpdate := True;
  try
    PopulateList;
    if Items.IndexOf(Text) = -1 then
      ItemIndex:=0;
  finally
    FUpdate := False;
  end;
end;

procedure TfrxFontComboBox.SetRegKey(Value: String);
begin
  if Value = '' then
    FRegKey := '\Software\Fast Reports\MRUFont' else
    FRegKey := Value;
end;

procedure TfrxFontComboBox.PopulateList;
var
  LFont: TLogFont;
  DC: HDC;
//  {$IFNDEF NONWINFPC}
 // Reg: TRegistry;
//  {$ENDIF}
  s: String;
  i: Integer;
  str: TStringList;
begin
  Sorted:=True;
  Items.BeginUpdate;
  str := TStringList.Create;
  str.Sorted := True;
  try
    Clear;
    DC := GetDC(0);
    try
      FillChar(LFont, sizeof(LFont), 0);
      LFont.lfCharset := DEFAULT_CHARSET;
      {$IFDEF FPC}
      EnumFontFamiliesEx(DC, @LFont, FontEnumExProc(@EnumFontsProc), PtrUInt(str), 0);
      {$ELSE}
      EnumFontFamiliesEx(DC, LFont, @EnumFontsProc, frInteger(str), 0);
      {$ENDIF}
    finally
      ReleaseDC(0, DC);
    end;
    if frxPrinters.HasPhysicalPrinters then
    try
      FillChar(LFont, sizeof(LFont), 0);
      LFont.lfCharset := DEFAULT_CHARSET;
      if frxPrinters.Printer <> nil then
      begin

        {$IFDEF NONWINFPC}
        DC := GetDC(0);
        try
          EnumFontFamiliesEx(DC, @LFont, FontEnumExProc(@EnumFontsProc), PtrUInt(str), 0);
        finally
          ReleaseDC(0, DC);
        end;
        {$ELSE}
        EnumFontFamiliesEx(frxPrinters.Printer.Canvas.Handle,
          {$IFDEF FPC}@LFont{$ELSE}LFont{$ENDIF}, @EnumFontsProc, frInteger(str), 0);
        {$ENDIF}
      end;
    except;
    end;
  finally
    Items.Assign(str);
    Items.EndUpdate;
  end;
  str.Free;
  Sorted := False;
 // {$IFNDEF NONWINFPC}
  if (FShowMRU) and (FIni <> nil) then
  begin
    NumUsed := -1;
    Items.BeginUpdate;
    //Reg:=TRegistry.Create;
    try
      //Reg.OpenKey(FRegKey, True);
      for i := 4 downto 0 do
      begin
        s := Fini.ReadString('MRUFont', 'Font' + IntToStr(i), '');
        if (s <> '') and (Items.IndexOf(s) <> -1) then
        begin
          Items.InsertObject(0, s, TObject(Fini.ReadInteger('MRUFont', 'FontType' + IntToStr(i), 0)));
          Inc(Numused);
        end else
        begin
          Fini.WriteString('MRUFont', 'Font' + IntToStr(i), '');
          Fini.WriteInteger('MRUFont', 'FontType' + IntToStr(i), 0);
        end;
      end;
    finally
      Items.EndUpdate;
    end;
  end;
  //{$ENDIF}
end;

procedure TfrxFontComboBox.DrawImage(DC: HDC; Index: Integer; R: TRect);
var
  C: TCanvas;
  Bitmap: TBitmap;
begin
  inherited;
  Index := Items.IndexOf(Text);
  if Index = -1 then exit;
  C := TCanvas.Create;
  C.Handle := DC;
  if (Integer(Items.Objects[Index]) and TRUETYPE_FONTTYPE) <> 0 then
    Bitmap := FTrueTypeBMP
  else if (Integer(Items.Objects[Index]) and DEVICE_FONTTYPE) <> 0 then
    Bitmap := FDeviceBMP
  else
    Bitmap := nil;
  if Bitmap <> nil then
  begin
    C.Brush.Color := clWindow;
    C.BrushCopy(Bounds(R.Left, (R.Top + R.Bottom - Bitmap.Height)
     div 2, Bitmap.Width, Bitmap.Height), Bitmap, Bounds(0, 0, Bitmap.Width,
     Bitmap.Height), Bitmap.TransparentColor);
  end;
  C.Free;
end;


procedure TfrxFontComboBox.DrawItem(Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
var
  Bitmap: TBitmap;
  BmpWidth: Integer;
  Text: array[0..255] of Char;
{$IFNDEF FPC}
  tWidth: Integer;
{$ENDIF}
begin
 {$IFNDEF FPC}
 if odSelected in State then
 begin
   frFontViewForm.SetDefaultFontSize(FCurrentPPI);
   frFontViewForm.FPanel.Caption := Self.Items[index];
   frFontViewForm.FPanel.Font.Name := Self.Items[index];
   { use one of the Icon's bitmaps to calculate size of text }
   { we do not use it to output any text, so it shouldn't impact draw }
   FTrueTypeBMP.Canvas.Font.Assign(frFontViewForm.FPanel.Font);
   tWidth := FTrueTypeBMP.Canvas.TextWidth(frFontViewForm.FPanel.Caption);
   if tWidth > frFontViewForm.Width then
     frFontViewForm.FPanel.Font.Height := Round(frFontViewForm.FPanel.Font.Height / (tWidth / frFontViewForm.Width));
 end;
 {$ENDIF}
 with Canvas do
 begin
   BmpWidth  := 15;
   FillRect(Rect);
   if (Integer(Items.Objects[Index]) and TRUETYPE_FONTTYPE) <> 0 then
     Bitmap := FTrueTypeBMP
   else if (Integer(Items.Objects[Index]) and DEVICE_FONTTYPE) <> 0 then
     Bitmap := FDeviceBMP
   else
     Bitmap := nil;

   if Bitmap <> nil then
   begin
     BmpWidth := Bitmap.Width;
     BrushCopy(Bounds(Rect.Left+1 , (Rect.Top + Rect.Bottom - Bitmap.Height)
       div 2, Bitmap.Width, Bitmap.Height), Bitmap, Bounds(0, 0, Bitmap.Width,
       Bitmap.Height), Bitmap.TransparentColor);
   end;
   StrPCopy(Text, Items[Index]);
   Rect.Left := Rect.Left + BmpWidth + 2;
   DrawText(Canvas.Handle, Text, StrLen(Text), Rect,
{$IFDEF DELPHI4}
   DrawTextBiDiModeFlags(DT_SINGLELINE or DT_VCENTER or DT_NOPREFIX));
{$ELSE}
   DT_SINGLELINE or DT_VCENTER or DT_NOPREFIX);
{$ENDIF}
   if (Index = Numused) then
   begin
     Pen.Color := clBtnShadow;
     MoveTo(0,Rect.Bottom - 2);
     LineTo(width, Rect.Bottom - 2);
   end;
   if (Index = Numused + 1) and (Numused <> -1) then
   begin
     Pen.Color := clBtnShadow;
     MoveTo(0, Rect.Top);
     LineTo(width, Rect.Top);
   end;
 end;
end;

procedure TfrxFontComboBox.CMFontChanged(var Message: TMessage);
begin
  inherited;
  Init;
end;

procedure TfrxFontComboBox.CMFontChange(var Message: TMessage);
begin
  inherited;
  Reset;
end;

procedure TfrxFontComboBox.Init;
begin
  if GetFontHeight(Font) > FTrueTypeBMP.Height then
    ItemHeight := GetFontHeight(Font)
  else
    ItemHeight := FTrueTypeBMP.Height + 1;
  {$IFNDEF NONWINFPC}
  {$IFDEF FPC}
  // if HandleAllocated then
  //  RecreateWnd(Self);
  {$ELSE}
  RecreateWnd;
  {$ENDIF}
  {$ENDIF}
end;

procedure TfrxFontComboBox.Click;
begin
 inherited Click;
 if not (csReading in ComponentState) then
   if not FUpdate and Assigned(FOnClick) then FOnClick(Self);
end;

procedure TfrxFontComboBox.Reset;
begin
  if csDesigning in ComponentState then exit;
  FUpdate := True;
  try
    PopulateList;
    if Items.IndexOf(Text) = -1 then
      ItemIndex := 0;
  finally
    FUpdate := False;
  end;
end;
{$IFNDEF FPC}
procedure TfrxFontComboBox.CNCommand(var Message: TWMCommand);
var
  pnt:TPoint;
  ind, i, sWidth:integer;
  m: TMonitor;
  //{$IFNDEF NONWINFPC}
  //Reg: TRegistry;
  //{$ENDIF}
begin
  inherited;
  if (Message.NotifyCode in [CBN_CLOSEUP]) then
  begin
    frFontViewForm.Visible := False;
    ind := itemindex;
    if (ItemIndex = -1) or (ItemIndex = 0) then exit;
    if FShowMRU then
    begin
      Items.BeginUpdate;
      if Items.IndexOf(Items[ind]) <= Numused then
      begin
        Items.Move(Items.IndexOf(Items[ind]), 0);
        ItemIndex := 0;
      end else
      begin
        Items.InsertObject(0, Items[ItemIndex], Items.Objects[ItemIndex]);
        Itemindex := 0;
        if Numused < 4 then
          Inc(Numused)
        else
          Items.Delete(5);
      end;
      Items.EndUpdate;
     // {$IFNDEF NONWINFPC}
      //Reg := TRegistry.Create;
      if (FIni <> nil) then
      begin
        //Reg.OpenKey(FRegKey,True);
        for i := 0 to 4 do
          if i <= Numused then
          begin
           FIni.WriteString('MRUFont', 'Font' + IntToStr(i), Items[i]);
           FIni.WriteInteger('MRUFont', 'FontType' + IntToStr(i), Integer(Items.Objects[i]));
         end else
         begin
           FIni.WriteString('MRUFont', 'Font' + IntToStr(i), '');
           Fini.WriteInteger('MRUFont', 'FontType' + IntToStr(i), 0);
         end;
      end;
    end;
  end;
  if (Message.NotifyCode in [CBN_DROPDOWN]) then
  begin
    {$IFDEF NONWINFPC}
    {$note TfrxFontComboBox.CNCommand fix LB_SETCURSEL}
    {$ELSE}
    if ItemIndex < 5 then
      PostMessage(FListHandle, LB_SETCURSEL, 0, 0);
    {$ENDIF}
    pnt.x := Self.Left + Self.Width;
    pnt.y := Self.Top + Self.Height;
    pnt := Parent.ClientToScreen(pnt);
    frFontViewForm.Top := pnt.y;
    frFontViewForm.Left := pnt.x + 1;
    m := Screen.MonitorFromWindow(Self.Handle, mdNearest);
    if Assigned(m) then
      sWidth := m.WorkareaRect.Right
    else
      sWidth := Screen.Width;

    if frFontViewForm.Left + frFontViewForm.Width > sWidth then
    begin
      pnt.x := Self.Left;
      pnt := Parent.ClientToScreen(pnt);
      frFontViewForm.Left := pnt.x - frFontViewForm.Width - 1;
    end;
    if FUpDropdown then
    begin
      pnt.y := Self.Top;
      pnt := Parent.ClientToScreen(pnt);
      frFontViewForm.Top := pnt.y - frFontViewForm.Height;
    end;
    frFontViewForm.Visible := True;
  end;
end;
{$ENDIF}


{ TfrxFontPreview }

constructor TfrxFontPreview.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width := 200;
  Height := 50;
  Visible := False;
  Parent := AOwner as TWinControl;

  FPanel := TPanel.Create(Self);
  with FPanel do
  begin
    Parent := Self;
    Color := clWindow;
    {$IFNDEF FPC}
    Ctl3D := False;
    ParentCtl3D := False;
    {$ENDIF}
    BorderStyle := bsSingle;
    BevelInner := bvNone;
    BevelOuter := bvNone;
    Font.Color := clWindowText;
    Font.Size := 18;
    Align := alClient;
  end;
end;

destructor TfrxFontPreview.Destroy;
begin
  FPanel.Free;
  FPanel := nil;
  inherited Destroy;
end;

procedure TfrxFontPreview.SetDefaultFontSize(aNewPPI: Integer);
begin
  FPanel.Font.Size := 18;
  FPanel.Font.Height := MulDiv(FPanel.Font.Height, aNewPPI, frx_DefaultPPI);
end;

procedure TfrxFontPreview.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams( Params);
    with Params do begin
      Style := WS_POPUP or WS_CLIPCHILDREN;
      ExStyle := WS_EX_TOOLWINDOW;
      {$IFNDEF NONWINFPC}
      WindowClass.Style := WindowClass.Style or CS_SAVEBITS;
      {$ENDIF}
    end;
end;


{ TfrxComboEdit }

constructor TfrxComboEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Style := csSimple;
  Height := 21;
  FPanel := TPanel.Create(Self);
  FPanel.Parent := Self;
  FPanel.SetBounds(Width - Height + 2, 2, Height - 4, Height - 4);
  FButton := TSpeedButton.Create(Self);
  FButton.Parent := FPanel;
  FButton.SetBounds(0, 0, FPanel.Width, FPanel.Height);
  FButton.OnClick := ButtonClick;
  FButtonEnabled := True;
end;

procedure TfrxComboEdit.SetPos;
begin
  {$IFDEF NONWINFPC}
  {$note FIXME TfrxComboEdit.SetPos}
  {$ELSE}
  SetWindowPos(EditHandle, 0, 0, 0, Width - Height - 4, ItemHeight,
    SWP_NOMOVE or SWP_NOZORDER or SWP_NOACTIVATE)
  {$ENDIF}
end;

procedure TfrxComboEdit.CreateWnd;
begin
  inherited CreateWnd;
  SetPos;
end;

procedure TfrxComboEdit.WMSize(var Message: TWMSize);
begin
  inherited;
  FPanel.SetBounds(Width - Height + 2, 2, Height - 4, Height - 4);
end;

procedure TfrxComboEdit.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  FButton.Enabled := Enabled;
end;

procedure TfrxComboEdit.KeyPress(var Key: Char);
begin
  if (Key = Char(vk_Return)) or (Key = Char(vk_Escape)) then
    GetParentForm(Self).Perform(CM_DIALOGKEY, Byte(Key), 0);
  inherited KeyPress(Key);
end;

function TfrxComboEdit.GetGlyph: TBitmap;
begin
  Result := FButton.Glyph;
end;

{$IFDEF FPC}
{$IFNDEF NONWINFPC}
function TfrxComboEdit.GetEditHandle: HWND;
begin
  Result := LazHelper.GetComboEditHandle(Handle);
end;
{$ENDIF}
{$ENDIF}

procedure TfrxComboEdit.SetGlyph(Value: TBitmap);
begin
  FButton.Glyph := Value;
end;

function TfrxComboEdit.GetButtonHint: String;
begin
  Result := FButton.Hint;
end;

procedure TfrxComboEdit.SetButtonHint(Value: String);
begin
  FButton.Hint := Value;
end;

procedure TfrxComboEdit.SetButtonEnabled(Value: Boolean);
begin
  FButtonEnabled := Value;
  FButton.Enabled := Value;
end;

procedure TfrxComboEdit.ButtonClick(Sender: TObject);
begin
  SetFocus;
  if Assigned(FOnButtonClick) then
    FOnButtonClick(Self);
end;


{ TfrxScrollWin }

constructor TfrxScrollWin.Create(AOwner: TComponent);
begin
  inherited;
  FSmallChange := 1;
  FLargeChange := 10;
  FHorzPage := 0;
  FVertPage := 0;
  FHideScrolls := False;
{$IFDEF DELPHI7}
  ControlStyle := ControlStyle + [csNeedsBorderPaint];
{$ENDIF}
  FfrCurrentPPI := Screen.PixelsPerInch;
{$IFDEF DELPHI24}
  FCurrentPPI := FfrCurrentPPI;
{$ENDIF}
end;

procedure TfrxScrollWin.CreateParams(var Params: TCreateParams);
const
  BorderStyles: array[TBorderStyle] of DWORD = (0, WS_BORDER);
begin
  inherited;
  with Params do
  begin
    Style := Style or WS_CLIPCHILDREN or BorderStyles[FBorderStyle];
    if (not HideScrolls) then
      Style := Style or WS_HSCROLL or WS_VSCROLL;
    if {$IFNDEF FPC}Ctl3D and {$ENDIF} NewStyleControls and (FBorderStyle = bsSingle) then
    begin
      Style := Style and not WS_BORDER;
      ExStyle := ExStyle or WS_EX_CLIENTEDGE;
    end;
  end;
end;

procedure TfrxScrollWin.DoPPIChanged(aNewPPI: Integer);
begin

end;

procedure TfrxScrollWin.SetBorderStyle(const Value: TBorderStyle);
begin
  FBorderStyle := Value;
  {$IFNDEF NONWINFPC}
  {$IFDEF FPC}
  // if HandleAllocated then
  //  RecreateWnd(Self);
  {$ELSE}
  RecreateWnd;
  {$ENDIF}
  {$ENDIF}
end;

procedure TfrxScrollWin.WMDpiChanged(var Message: TMessage);
var
  NewPPI: Integer;
begin
  Inherited;
  NewPPI := frxGetDpiForWindow(Handle);
  if NewPPI = FfrCurrentPPI then Exit;
  DoPPIChanged(NewPPI);
  FfrCurrentPPI := NewPPI;
end;

procedure TfrxScrollWin.WMEraseBackground(var Message: TMessage);
begin
end;

procedure TfrxScrollWin.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := DLGC_WANTARROWS or DLGC_WANTTAB or DLGC_WANTALLKEYS;
end;

procedure TfrxScrollWin.SetHideScrolls(b: Boolean);
begin
  if (FHideScrolls <> b) then
  begin
    ShowScrollBar(Self.Handle, SB_BOTH, not b);
    ShowScrollBar(Self.Handle, SB_HORZ, not b);
    ShowScrollBar(Self.Handle, SB_VERT, not b);
    FHideScrolls := b;
  end;
end;

function TfrxScrollWin.GetLongPosition(DefValue: Integer; Code: Word): Integer;
var
  {$IFNDEF NONWINFPC}
  ScrollInfo: Windows.TScrollInfo;
  {$ELSE}
  ScrollInfo: TScrollInfo;
  {$ENDIF}
begin
  {$IFDEF FPC}
  FillChar(ScrollInfo, SizeOf(ScrollInfo), #0);
  {$ENDIF}
  ScrollInfo.cbSize := SizeOf(TScrollInfo);
  ScrollInfo.fMask := SIF_TRACKPOS;
  Result := DefValue;
  {$IFDEF NONWINFPC}
  if LCLIntf.GetScrollInfo(Handle, Code, ScrollInfo) then
  {$ELSE}
  if FlatSB_GetScrollInfo(Handle, Code, Windows.TScrollInfo(ScrollInfo)) then
  {$ENDIF}
    Result := ScrollInfo.nTrackPos;
end;

function TfrxScrollWin.GetScale: Single;
begin
  Result := FfrCurrentPPI / frx_DefaultPPI;
end;

function TfrxScrollWin.GetScaledFontSize: Integer;
var
  f: TFont;
begin
  { used to scale back font before saving }
  f := TFont.Create;
  try
    f.Assign(Font);
    f.Height := MulDiv(f.Height, Font.PixelsPerInch, FfrCurrentPPI);
    Result := f.Size;
  finally
    f.Free;
  end;
end;

procedure TfrxScrollWin.SetHorzPage(const Value: Integer);
begin
  FHorzPage := Value;
  HorzRange := HorzRange;
end;

procedure TfrxScrollWin.SetHorzPosition(Value: Integer);
begin
  if Assigned(FOnScrollPosChange) then
    FOnScrollPosChange(Self, frsHorizontal, Value);
  if Value > FHorzRange - FHorzPage then
    Value := FHorzRange - FHorzPage;
  if Value < 0 then
    Value := 0;
  if Value <> FHorzPosition then
  begin
    FHorzPosition := Value;
    SetPosition(Value, SB_HORZ);
    OnHScrollChange(Self);
  end;
end;

procedure TfrxScrollWin.SetHorzRange(Value: Integer);
begin
  if Assigned(FOnScrollMaxChange) and (Value - FHorzPage >= 0) then
    FOnScrollMaxChange(Self, frsHorizontal, Value - FHorzPage);
  FHorzRange := Value;
  UpdateScrollBar(Value, HorzPage, HorzPosition, SB_HORZ);
end;

procedure TfrxScrollWin.SetVertPage(const Value: Integer);
begin
  FVertPage := Value;
  VertRange := VertRange;
end;

procedure TfrxScrollWin.SetVertPosition(Value: Integer);
begin
  if Assigned(FOnScrollPosChange) then
    FOnScrollPosChange(Self, frsVertical, Value);
  if Value > FVertRange - FVertPage then
    Value := FVertRange - FVertPage;
  if Value < 0 then
    Value := 0;
  if Value <> FVertPosition then
  begin
    FVertPosition := Value;
    SetPosition(Value, SB_VERT);
    OnVScrollChange(Self);
  end;
end;

procedure TfrxScrollWin.SetVertRange(Value: Integer);
begin
  if Assigned(FOnScrollMaxChange) and (Value - FVertPage>=0) then
    FOnScrollMaxChange(Self, frsVertical, Value - FVertPage);
  FVertRange := Value;
  UpdateScrollBar(Value, VertPage, VertPosition, SB_VERT);
end;

procedure TfrxScrollWin.SetPosition(Value: Integer; Code: Word);
begin
  {$IFDEF NONWINFPC}
  LCLIntf.SetScrollPos(Handle, Code, Value, True);
  {$ELSE}
  FlatSB_SetScrollPos(Handle, Code, Value, True);
  {$ENDIF}
end;

procedure TfrxScrollWin.SetScaledFontSize(Value: Integer);
var
  f: TFont;
begin
  { used to scale back font before saving }
  f := TFont.Create;
  try
    f.Assign(Font);
    f.Size := Value;
    Font.Height := MulDiv(f.Height, FfrCurrentPPI, Font.PixelsPerInch);
  finally
    f.Free;
  end;
end;

procedure TfrxScrollWin.UpdateScrollBar(Max, Page, Pos: Integer; Code: Word);
var
  ScrollInfo:{$IFNDEF NONWINFPC}Windows.{$ENDIF}TScrollInfo;
begin
  if HideScrolls then
    Exit;
  {$IFDEF FPC}
  FillChar(ScrollInfo, SizeOf(ScrollInfo), #0);
  {$ENDIF}
  ScrollInfo.cbSize := SizeOf(ScrollInfo);
  ScrollInfo.fMask := SIF_ALL;
  ScrollInfo.nMin := 0;
  if Max < Page then
    Max := 0;
  ScrollInfo.nMax := Max;
  ScrollInfo.nPage := Page;
  ScrollInfo.nPos := Pos;
  ScrollInfo.nTrackPos := Pos;
  {$IFDEF NONWINFPC}
  LCLIntf.setScrollInfo(Handle, Code, ScrollInfo, True);
  {$ELSE}
  FlatSB_SetScrollInfo(Handle, Code, Windows.TScrollInfo(ScrollInfo), True);
  {$ENDIF}
end;

procedure TfrxScrollWin.Paint;
begin
  with Canvas do
  begin
    Brush.Color := Color;
    FillRect(Rect(0, 0, ClientWidth, ClientHeight));
  end;
end;

procedure TfrxScrollWin.WMHScroll(var Message: TWMHScroll);
begin
  case Message.ScrollCode of
    SB_LINEUP: HorzPosition := HorzPosition - FSmallChange;
    SB_LINEDOWN: HorzPosition := HorzPosition + FSmallChange;
    SB_PAGEUP: HorzPosition := HorzPosition - FLargeChange;
    SB_PAGEDOWN: HorzPosition := HorzPosition + FLargeChange;
    SB_THUMBPOSITION, SB_THUMBTRACK:
      HorzPosition := GetLongPosition(Message.Pos, SB_HORZ);
    SB_TOP: HorzPosition := 0;
    SB_BOTTOM: HorzPosition := HorzRange;
  end;
end;

procedure TfrxScrollWin.WMVScroll(var Message: TWMVScroll);
begin
  case Message.ScrollCode of
    SB_LINEUP: VertPosition := VertPosition - FSmallChange;
    SB_LINEDOWN: VertPosition := VertPosition + FSmallChange;
    SB_PAGEUP: VertPosition := VertPosition - FLargeChange;
    SB_PAGEDOWN: VertPosition := VertPosition + FLargeChange;
    SB_THUMBPOSITION, SB_THUMBTRACK:
      VertPosition := GetLongPosition(Message.Pos, SB_VERT);
    SB_TOP: VertPosition := 0;
    SB_BOTTOM: VertPosition := VertRange;
  end;
end;

procedure TfrxScrollWin.OnHScrollChange(Sender: TObject);
begin
end;

procedure TfrxScrollWin.OnVScrollChange(Sender: TObject);
begin
end;


{$IFDEF FPC}
{procedure RegisterUnitfrxCtrls;
begin
  RegisterComponents('Fast Report 6',[TfrxComboBox,
    TfrxFontComboBox, TfrxComboEdit,
    TfrxScrollWin
   ]);
end;

procedure Register;
begin
  RegisterUnit('frxCtrls',@RegisterUnitfrxCtrls);
end;}
{$ENDIF}

end.
