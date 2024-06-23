{*******************************************************}
{                                                       }
{                      EhLib 10.2                       }
{                     Tool controls                     }
{                                                       }
{      Copyright (c) 2001-2022 by Dmitry V. Bolshakov   }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit ButtonsEh;

interface

uses
  Contnrs, ActnList, GraphUtil, Variants, Types, Themes, Messages,
  {$IFDEF EH_LIB_17} System.Generics.Collections, System.UITypes, UIConsts, {$ENDIF}
  {$IFDEF FPC}
    EhLibLCL, LMessages, LCLType, Calendar, LCLIntf, WSLCLClasses,

    {$IFDEF FPC_CROSSP}
    {$ELSE}
      CommCtrl, Win32Extra, UxTheme,
    {$ENDIF}

    {$IFDEF FPC_WINDOWS}
      Windows, Win32WSForms, Win32Int, Win32WSControls,
    {$ELSE}
    {$ENDIF}

  {$ELSE}
    EhLibVCL, Mask, ComCtrls, CommCtrl, Windows, UxTheme,
  {$ENDIF}
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DateUtils, FmtBcd,
  Db, DBCtrls,
  //Buttons,
  ExtCtrls, Menus,
  Imglist, StrUtils, DynVarsEh, EhLibImageReses;

type
  TButtonImagesEh = class;
  TButtonGlyph = class;

{ TCustomSpeedButtonEh }

  TButtonStateEh = (bsNormalEh, bsHotEh, bsPressedEh, bsDisabledEh);
  TNumGlyphsEh = 1..4;
  TButtonLayoutEh = (blGlyphLeftEh, blGlyphRightEh, blGlyphTopEh, blGlyphBottomEh);

  TButtonDownEventEh = procedure(Sender: TObject;
    var AutoRepeat: Boolean; var Handled: Boolean) of object;

  TCustomSpeedButtonEh = class(TGraphicControl)
  private
    //FExternalEditButtonImages: TEditButtonImagesEh;
    FInternalEditButtonImages: TButtonImagesEh;
    FAutoRepeat: Boolean;
    FOnPaint: TNotifyEvent;
    FRepeatTimer: TTimer;
    FForegroundScaleFactor: Double;
    FResourceImageItem: TResourceImageItemEh;
    FFlat: Boolean;
    FTransparent: Boolean;
    FButtonGlyph: TButtonGlyph;
    FLayout: TButtonLayoutEh;
    FMargin: Integer;
    FSpacing: Integer;
    FLocalDragging: Boolean;
    FOnDown: TButtonDownEventEh;

    procedure TimerExpired(Sender: TObject);
    procedure SetFlat(const Value: Boolean);
    procedure SetTransparent(const Value: Boolean);
    function GetGlyph: TBitmap;
    function GetNumGlyphs: TNumGlyphsEh;
    function HasCustomGlyph: Boolean;
    procedure SetGlyph(const Value: TBitmap);
    procedure SetLayout(const Value: TButtonLayoutEh);
    procedure SetMargin(const Value: Integer);
    procedure SetNumGlyphs(Value: TNumGlyphsEh);
    procedure SetSpacing(const Value: Integer);
    procedure UpdateTracking;
    procedure ResetTimer(Interval: Cardinal);

    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure CMSysColorChange(var Message: TMessage); message CM_SYSCOLORCHANGE;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMButtonPressed(var Message: TMessage); message CM_BUTTONPRESSED;

  protected
    FState: TButtonStateEh;
    FMouseInControl: Boolean;

    function GetButtonImages: TButtonImagesEh; virtual;
    function GetCustomGlyphSize: TSize; virtual;

    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Paint; override;
    procedure GlyphChanged(Sender: TObject); virtual;
    procedure DrawCustomGlyph(Canvas: TCanvas; const GlyphPos: TPoint); virtual;
    procedure ButtonDown(var AutoRepeat: Boolean); virtual;

    function GetPalette: HPALETTE; override;
    procedure Loaded; override;
    procedure UpdateState; virtual;

    property Flat: Boolean read FFlat write SetFlat default False;
    property Transparent: Boolean read FTransparent write SetTransparent default True;
  public
    constructor Create(AOwner: TComponent); override; //reintroduce;
    destructor Destroy; override;

    function  GetButtonTheme: TThemedButton; virtual;
    function IsCustomGlyph: Boolean; virtual;

    procedure DefaultPaint; virtual;
    {$IFDEF FPC}
    procedure PaintBackground(out PaintRect: TRect; out PressOffset: TPoint; out ThemeDetails: TThemedElementDetails); virtual; reintroduce;
    {$ELSE}
    procedure PaintBackground(out PaintRect: TRect; out PressOffset: TPoint; out ThemeDetails: TThemedElementDetails); virtual;
    {$ENDIF}
    procedure PaintForeground(PaintRect: TRect; PressOffset: TPoint; ThemeDetails: TThemedElementDetails); virtual;

    property Canvas;
    property AutoRepeat: Boolean read FAutoRepeat write FAutoRepeat;
    property State: TButtonStateEh read FState;
    property OnPaint: TNotifyEvent read FOnPaint write FOnPaint;

    //property ExternalEditButtonImages: TEditButtonImagesEh read FExternalEditButtonImages write FExternalEditButtonImages;
    property ButtonImages: TButtonImagesEh read GetButtonImages;
    property ForegroundScaleFactor: Double read FForegroundScaleFactor write FForegroundScaleFactor;
    property ResourceImageItem: TResourceImageItemEh read FResourceImageItem write FResourceImageItem;

    property Glyph: TBitmap read GetGlyph write SetGlyph stored HasCustomGlyph;
    property Layout: TButtonLayoutEh read FLayout write SetLayout default blGlyphLeftEh;
    property Margin: Integer read FMargin write SetMargin default -1;
    property NumGlyphs: TNumGlyphsEh read GetNumGlyphs write SetNumGlyphs default 1;
    property Spacing: Integer read FSpacing write SetSpacing default 4;
    property MouseInControl: Boolean read FMouseInControl;
    property LocalDragging: Boolean read FLocalDragging;

    property OnDown: TButtonDownEventEh read FOnDown write FOnDown;
  end;

{ TSpeedButtonEh }

  TSpeedButtonEh = class(TCustomSpeedButtonEh)
  public

  published
    property Flat;
    property Caption;

    property Action;
    property Align;
    //property AllowAllUp;
    property Anchors;
    property BiDiMode;
    property Constraints;

    property Enabled;

    property Font;
    property Glyph;
    property Layout;
    property Margin;
    property NumGlyphs;
    property ParentFont;
    property ParentShowHint;
    property ParentBiDiMode;
    property PopupMenu;

    property ShowHint;

    property Spacing;
    property Transparent;
    property Visible;
{$IFDEF EH_LIB_17}
    property StyleElements;
{$ENDIF}

    property OnClick;
    property OnDblClick;
{$IFDEF EH_LIB_9}
    property OnMouseActivate;
{$ENDIF}
    property OnMouseDown;
{$IFDEF EH_LIB_10}
    property OnMouseEnter;
    property OnMouseLeave;
{$ENDIF}
    property OnMouseMove;
    property OnMouseUp;

  end;

  { TGlyphList }

  TGlyphList = class(TImageList)
  private
    Used: TBits;
    FCount: Integer;
    function AllocateIndex: Integer;
  public
    constructor CreateSize(AWidth, AHeight: Integer);
    destructor Destroy; override;
    function AddMasked(Image: TBitmap; MaskColor: TColor): Integer;
    procedure Delete(Index: Integer);
    property Count: Integer read FCount;
  end;

  { TButtonGlyph }

  TButtonGlyph = class
  private
    FOriginal: TBitmap;
    FGlyphList: TGlyphList;
    FIndexs: array[TButtonStateEh] of Integer;
    FTransparentColor: TColor;
    FNumGlyphs: TNumGlyphsEh;
    FPaintOnGlass: Boolean;
    FThemeDetails: TThemedElementDetails;
    FThemesEnabled: Boolean;
    FOnChange: TNotifyEvent;
    FThemeTextColor: Boolean;
    FButton: TCustomSpeedButtonEh;
    //FImages: TCustomImageList;
    //FImageIndex: TImageIndex;
    //FDisabledImageIndex: TImageIndex;
    //FHotImageIndex: TImageIndex;
    //FPressedImageIndex: TImageIndex;
    //FSelectedImageIndex: TImageIndex;
    //FWicBuffer: TWicImage;
    //FWicBufferDisabled: TWicImage;

    function CreateButtonGlyph(State: TButtonStateEh): Integer;

    procedure DoChange;
    //procedure SetImages(Value: TCustomImageList);
    procedure GlyphChanged(Sender: TObject);
    procedure SetGlyph(Value: TBitmap);
    procedure SetNumGlyphs(Value: TNumGlyphsEh);
    procedure Invalidate;
  public
    constructor Create(AButton: TCustomSpeedButtonEh);
    destructor Destroy; override;
    { return the text rectangle }
    function Draw(Canvas: TCanvas; const Client: TRect; const Offset: TPoint): TRect;

    procedure CalcButtonLayout(Canvas: TCanvas; const Client: TRect; const Offset: TPoint; const Caption: string; Layout: TButtonLayoutEh; Margin, Spacing: Integer; var GlyphPos: TPoint; var TextBounds: TRect; BiDiFlags: Longint);
    procedure DrawButtonGlyph(Canvas: TCanvas; const GlyphPos: TPoint; State: TButtonStateEh; Transparent: Boolean);
    procedure DrawButtonText(Canvas: TCanvas; const Caption: string; TextBounds: TRect; State: TButtonStateEh; Flags: Longint);

    property Glyph: TBitmap read FOriginal write SetGlyph;
    property NumGlyphs: TNumGlyphsEh read FNumGlyphs write SetNumGlyphs;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property Button: TCustomSpeedButtonEh read FButton;
  end;

{ TButtonImagesEh }

  TButtonImagesEh = class(TPersistent)
  private
    FNormalIndex: TImageIndex;
    FHotImages: TCustomImageList;
    FDisabledIndex: TImageIndex;
    FPressedImages: TCustomImageList;
    FHotIndex: TImageIndex;
    FNormalImages: TCustomImageList;
    FPressedIndex: TImageIndex;
    FDisabledImages: TCustomImageList;
    procedure SetDisabledImages(const Value: TCustomImageList);
    procedure SetDisabledIndex(const Value: TImageIndex);
    procedure SetHotImages(const Value: TCustomImageList);
    procedure SetHotIndex(const Value: TImageIndex);
    procedure SetNormalImages(const Value: TCustomImageList);
    procedure SetNormalIndex(const Value: TImageIndex);
    procedure SetPressedImages(const Value: TCustomImageList);
    procedure SetPressedIndex(const Value: TImageIndex);
  protected

    procedure ImagesStateChanged; virtual;
    procedure RefComponentChanged(RefComponent: TComponent); virtual;

  public
    constructor Create;
    destructor Destroy; override;

    function GetStateImages(EditButtonState: TButtonStateEh): TCustomImageList;
    function GetStateIndex(EditButtonState: TButtonStateEh): Integer;

    procedure Assign(Source: TPersistent); override;

  published
    property NormalImages: TCustomImageList read FNormalImages write SetNormalImages;
    property HotImages: TCustomImageList read FHotImages write SetHotImages;
    property PressedImages: TCustomImageList read FPressedImages write SetPressedImages;
    property DisabledImages: TCustomImageList read FDisabledImages write SetDisabledImages;

    property NormalIndex: TImageIndex read FNormalIndex write SetNormalIndex default 0;
    property HotIndex: TImageIndex read FHotIndex write SetHotIndex default 0;
    property PressedIndex: TImageIndex read FPressedIndex write SetPressedIndex default 0;
    property DisabledIndex: TImageIndex read FDisabledIndex write SetDisabledIndex default 0;

  end;

implementation

uses ToolCtrlsEh;

{TCustomSpeedButtonEh}

constructor TCustomSpeedButtonEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FInternalEditButtonImages := TButtonImagesEh.Create;
  FForegroundScaleFactor := 1;
  FButtonGlyph := TButtonGlyph.Create(Self);
  FButtonGlyph.OnChange := GlyphChanged;

  SetBounds(0, 0, 23, 22);
  ControlStyle := [csCaptureMouse, csDoubleClicks];
  ParentFont := True;
  Color := clBtnFace;
  FSpacing := 4;
  FMargin := -1;
  FLayout := blGlyphLeftEh;
  FTransparent := True;
end;

destructor TCustomSpeedButtonEh.Destroy;
begin
  FreeAndNil(FRepeatTimer);
  FreeAndNil(FInternalEditButtonImages);
  FreeAndNil(FButtonGlyph);
  inherited Destroy;
end;

procedure TCustomSpeedButtonEh.UpdateState;
var
  OldState: TButtonStateEh;
begin
  OldState := FState;
  if not Enabled then
  begin
    FState := bsDisabledEh;
    FLocalDragging := False;
  end
  else
  begin
    if (MouseInControl) then
      FState := bsHotEh
    else if (FLocalDragging) then
      FState := bsPressedEh
    else
      FState := bsNormalEh;
  end;

  if (FState <> OldState) then
    Invalidate;
end;

procedure TCustomSpeedButtonEh.UpdateTracking;
var
  P: TPoint;
  AMouseInControl: Boolean;
begin
  if FFlat then
  begin
    if Enabled then
    begin
      GetCursorPos(P);
      AMouseInControl := not (FindDragTarget(P, True) = Self);
      if (AMouseInControl) and (FState = bsNormalEh) then
        FState := bsHotEh;

      if AMouseInControl then
        Perform(CM_MOUSELEAVE, 0, 0)
      else
        Perform(CM_MOUSEENTER, 0, 0);
    end;
  end;
end;

procedure TCustomSpeedButtonEh.Loaded;
begin
  inherited Loaded;
  UpdateState;
  FButtonGlyph.CreateButtonGlyph(State);
end;

procedure TCustomSpeedButtonEh.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  AAutoRepeat: Boolean;
begin
  inherited MouseDown (Button, Shift, X, Y);

  if (Button = mbLeft) and Enabled then
  begin
    FState := bsPressedEh;
    Invalidate;
    FLocalDragging := True;

    AAutoRepeat := AutoRepeat;
    ButtonDown(AAutoRepeat);
    if AAutoRepeat then
      ResetTimer(InitRepeatPause);
  end;

  if AutoRepeat then
  begin
  end;
end;

procedure TCustomSpeedButtonEh.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  NewState: TButtonStateEh;
begin
  inherited MouseMove(Shift, X, Y);
  if FLocalDragging then
  begin
    NewState := bsHotEh;
    if (X >= 0) and
       (X < ClientWidth) and
       (Y >= 0) and
       (Y <= ClientHeight) then
    begin
      NewState := bsPressedEh;
    end;

    if NewState <> FState then
    begin
      FState := NewState;
      Invalidate;
    end;
  end
  else if not FMouseInControl then
  begin
    UpdateTracking;
  end;
end;

procedure TCustomSpeedButtonEh.MouseUp(Button: TMouseButton; Shift: TShiftState;
                                  X, Y: Integer);
var
  DoClick: Boolean;
begin
  inherited MouseUp(Button, Shift, X, Y);
  if FLocalDragging then
  begin
    FLocalDragging := False;
    DoClick := (X >= 0) and (X < ClientWidth) and (Y >= 0) and (Y <= ClientHeight);

    { Redraw face in-case mouse is captured }
//    FState := bsNormalEh;
//    FMouseInControl := False;
//    if DoClick and not (FState in [bsPressedEh]) then
//      Invalidate;

    if DoClick then Click;
    UpdateTracking;
    UpdateState;
  end;

  if FRepeatTimer <> nil then
    FRepeatTimer.Enabled  := False;
end;

procedure TCustomSpeedButtonEh.ButtonDown(var AutoRepeat: Boolean);
var
  Handled: Boolean;
begin
  if Assigned(FOnDown) {and (FButtonNum > 0)} then
    FOnDown(Self, AutoRepeat, Handled);
end;

procedure TCustomSpeedButtonEh.ResetTimer(Interval: Cardinal);
begin
  if FRepeatTimer = nil then
  begin
    FRepeatTimer := TTimer.Create(Self);
    FRepeatTimer.OnTimer := TimerExpired;
  end;
  //FRepeatTimer.Interval := InitRepeatPause;
  //FRepeatTimer.Enabled  := True;

  if FRepeatTimer.Enabled = False then
  begin
    FRepeatTimer.Interval := Interval;
    FRepeatTimer.Enabled := True;
  end
  else if Interval <> FRepeatTimer.Interval then
  begin
    FRepeatTimer.Enabled := False;
    FRepeatTimer.Interval := Interval;
    FRepeatTimer.Enabled := True;
  end;
end;

procedure TCustomSpeedButtonEh.TimerExpired(Sender: TObject);
var
  AAutoRepeat: Boolean;
begin
  FRepeatTimer.Interval := RepeatPause;
  if (FState = bsPressedEh) and MouseCapture then
  begin
    try
      //Click;
      AAutoRepeat := AutoRepeat;
      if State = bsPressedEh then
        ButtonDown(AAutoRepeat);
      if not AutoRepeat then
        FRepeatTimer.Enabled := False;
    except
      FRepeatTimer.Enabled := False;
      raise;
    end;
  end;
end;

procedure TCustomSpeedButtonEh.Paint;
begin
  if Assigned(OnPaint)
    then OnPaint(Self)
    else DefaultPaint;
end;

procedure TCustomSpeedButtonEh.DefaultPaint;
var
  PaintRect: TRect;
  PressOffset: TPoint;
  ThemeDetails: TThemedElementDetails;
begin
  PaintBackground(PaintRect, PressOffset, ThemeDetails);
  PaintForeground(PaintRect, PressOffset, ThemeDetails);
end;

procedure TCustomSpeedButtonEh.PaintBackground(out PaintRect: TRect; out PressOffset: TPoint; out ThemeDetails: TThemedElementDetails);
const
  DownStyles: array[Boolean] of Integer = (BDR_RAISEDINNER, BDR_SUNKENOUTER);
  FillStyles: array[Boolean] of Integer = (BF_MIDDLE, 0);
var
  DrawFlags: Integer;
  Button: TThemedButton;
  ToolButton: TThemedToolBar;
begin
  PressOffset := Point(0, 0);

  Canvas.Font := Self.Font;

  if ThemeServices.ThemesEnabled then
  begin
    if Transparent
{$IFDEF EH_LIB_16}
      then StyleServices.DrawParentBackground(0, Canvas.Handle, nil, True)
{$ELSE}
      then ThemeServices.DrawParentBackground(0, Canvas.Handle, nil, True)
{$ENDIF}
      else
        PerformEraseBackground(Self, Canvas.Handle);

    if not Enabled then
      Button := tbPushButtonDisabled
    else
      if FState in [bsPressedEh] then
        Button := tbPushButtonPressed
      else
        if FState = bsHotEh then
          Button := tbPushButtonHot
        else
          Button := tbPushButtonNormal;

    ToolButton := ttbToolbarDontCare;
    if Flat then
    begin
      case Button of
        tbPushButtonDisabled:
          Toolbutton := ttbButtonDisabled;
        tbPushButtonPressed:
          Toolbutton := ttbButtonPressed;
        tbPushButtonHot:
          Toolbutton := ttbButtonHot;
        tbPushButtonNormal:
          Toolbutton := ttbButtonNormal;
      end;
    end;

    PaintRect := ClientRect;
    if ToolButton = ttbToolbarDontCare then
    begin
      ThemeDetails := ThemeServices.GetElementDetails(Button);
      ThemeServices.DrawElement(Canvas.Handle, ThemeDetails, PaintRect);
      PaintRect := ThemeServices.ContentRect(Canvas.Handle, ThemeDetails, PaintRect);
    end
    else
    begin
      ThemeDetails := ThemeServices.GetElementDetails(ToolButton);
      ThemeServices.DrawElement(Canvas.Handle, ThemeDetails, PaintRect);
      PaintRect := ThemeServices.ContentRect(Canvas.Handle, ThemeDetails, PaintRect);
    end;

    if Button = tbPushButtonPressed then
    begin
      {$IFDEF FPC_CROSSP}
      {$ELSE}
      if (ToolButton <> ttbToolbarDontCare) and not CheckWin32Version(6) then
        Canvas.Font.Color := StyleServices.GetSystemColor(clHighlightText);
      {$ENDIF}
      PressOffset := Point(1, 0);
    end
    else
      PressOffset := Point(0, 0);

  end else 
  begin
    ThemeDetails.Element := teButton;
    ThemeDetails.Part := -1;
    ThemeDetails.State := -1;

    PaintRect := Rect(0, 0, Width, Height);
    if not Flat then
    begin
      DrawFlags := DFCS_BUTTONPUSH or DFCS_ADJUSTRECT;
      if FState in [bsPressedEh] then
        DrawFlags := DrawFlags or DFCS_PUSHED;
      DrawFrameControl(Canvas.Handle, PaintRect, DFC_BUTTON, DrawFlags);
    end
    else
    begin
      if (FState in [bsPressedEh]) or
        (FState = bsHotEh) or
        (csDesigning in ComponentState)
      then
        DrawEdge(Canvas.Handle, PaintRect, DownStyles[FState in [bsPressedEh]],
          FillStyles[Transparent] or BF_RECT)
      else if not Transparent then
      begin
        Canvas.Brush.Color := Color;
        Canvas.FillRect(PaintRect);
      end;
      InflateRect(PaintRect, -1, -1);
    end;
    if FState in [bsPressedEh] then
    begin
      PressOffset.X := 1;
      PressOffset.Y := 1;
    end
    else
    begin
      PressOffset.X := 0;
      PressOffset.Y := 0;
    end;
  end;
end;

procedure TCustomSpeedButtonEh.PaintForeground(PaintRect: TRect;
  PressOffset: TPoint; ThemeDetails: TThemedElementDetails);
begin

  FButtonGlyph.FPaintOnGlass := False;
  FButtonGlyph.FThemeDetails := ThemeDetails;
{$IFDEF EH_LIB_11} //Borland Developer Studio 2007
  FButtonGlyph.FThemesEnabled := ThemeControl(Self);
{$ELSE}
  FButtonGlyph.FThemesEnabled := True;
{$ENDIF}
{$IFDEF EH_LIB_17}
  FButtonGlyph.FThemeTextColor := seFont in StyleElements;
{$ELSE}
  FButtonGlyph.FThemeTextColor := False;
{$ENDIF}
  FButtonGlyph.Draw(Canvas, PaintRect, PressOffset);
  //DrawTextBiDiModeFlags(0)
//  DrawButtonText(Canvas, Caption, PaintRect, FState, 0);
end;

function TCustomSpeedButtonEh.IsCustomGlyph: Boolean;
var
  ADrawImages: TCustomImageList;
  AImageIndex: Integer;
begin
  ADrawImages := ButtonImages.GetStateImages(State);
  AImageIndex := ButtonImages.GetStateIndex(State);
  if (ADrawImages <> nil) and (AImageIndex >= 0) then
  begin
    Result := True;
  end else if (ResourceImageItem <> nil) then
  begin
    Result := True;
  end else
  begin
    Result := False;
  end;
end;

function TCustomSpeedButtonEh.GetCustomGlyphSize: TSize;
var
  ADrawImages: TCustomImageList;
  AImageIndex: Integer;
  MaxSize: TSize;
  Graphic: TGraphic;
  {$IFDEF EH_LIB_26} //10.3
begin
  {$ELSE}
   ScaleFactor: Single;
begin
  ScaleFactor := 1;
  {$ENDIF}
  ADrawImages := ButtonImages.GetStateImages(State);
  AImageIndex := ButtonImages.GetStateIndex(State);
  if (ADrawImages <> nil) and (AImageIndex >= 0) then
  begin
    Result.cx := ADrawImages.Width;
    Result.cy := ADrawImages.Height;
  end else if (ResourceImageItem <> nil) then
  begin
    MaxSize.cx := Width;
    MaxSize.cy := Height;
    Graphic := ResourceImageItem.GetGraphic(MaxSize, ScaleFactor, State = bsDisabledEh, False);
    Result.cx := Graphic.Width;
    Result.cy := Graphic.Height;
  end else
  begin
    Result.cx := 0;
    Result.cy := 0;
  end;
end;

procedure TCustomSpeedButtonEh.DrawCustomGlyph(Canvas: TCanvas; const GlyphPos: TPoint);
var
  ADrawImages: TCustomImageList;
  AImageIndex: Integer;
  Image: TGraphic;
  Size: TSize;
  ADrawRect: TRect;
  GlyphSize: TSize;
begin
  ADrawImages := ButtonImages.GetStateImages(State);
  AImageIndex := ButtonImages.GetStateIndex(State);
  if (ADrawImages <> nil) and (AImageIndex >= 0) then
  begin
    ADrawRect.Left := GlyphPos.X;
    ADrawRect.Top := GlyphPos.Y;
    GlyphSize := GetCustomGlyphSize;
    ADrawRect.Right := ADrawRect.Left + GlyphSize.cx;
    ADrawRect.Bottom := ADrawRect.Top + GlyphSize.cy;

    DrawClipped(ADrawImages, nil, Canvas, ADrawRect, AImageIndex,
      0, 0, taCenter, ADrawRect, ForegroundScaleFactor);
  end else if (ResourceImageItem <> nil) then
  begin
    ADrawRect.Left := GlyphPos.X;
    ADrawRect.Top := GlyphPos.Y;
    GlyphSize := GetCustomGlyphSize;
    ADrawRect.Right := ADrawRect.Left + GlyphSize.cx;
    ADrawRect.Bottom := ADrawRect.Top + GlyphSize.cy;
    Size.cx := ClientWidth;
    Size.cy := ClientHeight;

    Image := ResourceImageItem.GetGraphic(Size, ForegroundScaleFactor, not Enabled, False);
    DrawClipped(nil, Image, Canvas, ADrawRect, -1, 0, 0, taCenter, ADrawRect, 1);
  end;
end;

function TCustomSpeedButtonEh.GetButtonTheme: TThemedButton;
begin
  Result := tbPushButtonPressed;
end;

function TCustomSpeedButtonEh.GetButtonImages: TButtonImagesEh;
begin
  Result := FInternalEditButtonImages;
end;

procedure TCustomSpeedButtonEh.SetFlat(const Value: Boolean);
begin
  if Value <> FFlat then
  begin
    FFlat := Value;
    Invalidate;
  end;
end;

procedure TCustomSpeedButtonEh.SetTransparent(const Value: Boolean);
begin
  if Value <> FTransparent then
  begin
    FTransparent := Value;
    if Value
      then ControlStyle := ControlStyle - [csOpaque]
      else ControlStyle := ControlStyle + [csOpaque];
    Invalidate;
  end;
end;

function TCustomSpeedButtonEh.GetGlyph: TBitmap;
begin
  Result := FButtonGlyph.Glyph;
end;

procedure TCustomSpeedButtonEh.SetGlyph(const Value: TBitmap);
begin
  FButtonGlyph.Glyph := Value;
  Invalidate;
end;

function TCustomSpeedButtonEh.GetNumGlyphs: TNumGlyphsEh;
begin
  Result := FButtonGlyph.NumGlyphs;
end;

procedure TCustomSpeedButtonEh.SetNumGlyphs(Value: TNumGlyphsEh);
begin
  if Value < 0 then
    Value := 1
  else if Value > 4 then
    Value := 4;

  if Value <> FButtonGlyph.NumGlyphs then
  begin
    FButtonGlyph.NumGlyphs := Value;
    Invalidate;
  end;
end;

function TCustomSpeedButtonEh.HasCustomGlyph: Boolean;
begin
  Result := True
end;

procedure TCustomSpeedButtonEh.SetLayout(const Value: TButtonLayoutEh);
begin
  if FLayout <> Value then
  begin
    FLayout := Value;
    Invalidate;
  end;
end;

procedure TCustomSpeedButtonEh.SetMargin(const Value: Integer);
begin
  if (Value <> FMargin) and (Value >= -1) then
  begin
    FMargin := Value;
    Invalidate;
  end;
end;

procedure TCustomSpeedButtonEh.SetSpacing(const Value: Integer);
begin
  if Value <> FSpacing then
  begin
    FSpacing := Value;
    Invalidate;
  end;
end;

procedure TCustomSpeedButtonEh.GlyphChanged(Sender: TObject);
begin
  Invalidate;
end;

function TCustomSpeedButtonEh.GetPalette: HPALETTE;
begin
  Result := Glyph.Palette;
end;

procedure TCustomSpeedButtonEh.CMEnabledChanged(var Message: TMessage);
const
  NewState: array[Boolean] of TButtonStateEh = (bsDisabledEh, bsNormalEh);
begin
  FButtonGlyph.CreateButtonGlyph(NewState[Enabled]);
  UpdateTracking;
  UpdateState;
  Repaint;
end;

procedure TCustomSpeedButtonEh.CMDialogChar(var Message: TCMDialogChar);
begin
  if IsAccel(Message.CharCode, Caption) and
     Enabled and
     Visible and
    (Parent <> nil) and
    Parent.Showing then
  begin
    Click;
    Message.Result := 1;
  end
  else
  begin
    inherited;
  end;
end;

procedure TCustomSpeedButtonEh.CMFontChanged(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TCustomSpeedButtonEh.CMTextChanged(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TCustomSpeedButtonEh.CMSysColorChange(var Message: TMessage);
begin
  inherited;
  FButtonGlyph.Invalidate;
  FButtonGlyph.CreateButtonGlyph(FState);
end;

procedure TCustomSpeedButtonEh.CMMouseEnter(var Message: TMessage);
//var
//  NeedRepaint: Boolean;
begin
  inherited;
  FMouseInControl := True;
  UpdateState;
//  { Don't draw a border if DragMode <> dmAutomatic since this button is meant to
//    be used as a dock client. }
//  NeedRepaint := FFlat and not FMouseInControl and Enabled and (DragMode <> dmAutomatic) and (GetCapture = 0);
//
//  { Windows XP introduced hot states also for non-flat buttons. }
//  if (NeedRepaint or ThemesEnabled) and not (csDesigning in ComponentState) then
//  begin
//    FMouseInControl := True;
//    UpdateState;
//    //FState := bsHotEh;
//    if Enabled then
//      Repaint;
//  end;
end;

procedure TCustomSpeedButtonEh.CMMouseLeave(var Message: TMessage);
//var
//  NeedRepaint: Boolean;
begin
  inherited;
  FMouseInControl := False;
  UpdateState;

//  NeedRepaint := FFlat and FMouseInControl and Enabled and not FLocalDragging;
//  { Windows XP introduced hot states also for non-flat buttons. }
//  if NeedRepaint or ThemesEnabled then
//  begin
//    FMouseInControl := False;
//    UpdateState;
//    //FState := bsNormalEh;
//    if Enabled then
//      Repaint;
//  end;
end;

procedure TCustomSpeedButtonEh.CMButtonPressed(var Message: TMessage);
begin
  inherited;
end;

{ TGlyphList }

constructor TGlyphList.CreateSize(AWidth, AHeight: Integer);
begin
  inherited CreateSize(AWidth, AHeight);
  Used := TBits.Create;
end;

destructor TGlyphList.Destroy;
begin
  Used.Free;
  inherited Destroy;
end;

function TGlyphList.AllocateIndex: Integer;
begin
  Result := Used.OpenBit;
  if Result >= Used.Size then
  begin
    Result := inherited Add(nil, nil);
    Used.Size := Result + 1;
  end;
  Used[Result] := True;
end;

function TGlyphList.AddMasked(Image: TBitmap; MaskColor: TColor): Integer;
begin
  Result := AllocateIndex;
  ReplaceMasked(Result, Image, MaskColor);
  Inc(FCount);
end;

procedure TGlyphList.Delete(Index: Integer);
begin
  if Used[Index] then
  begin
    Dec(FCount);
    Used[Index] := False;
  end;
end;

{ TButtonGlyph }

constructor TButtonGlyph.Create(AButton: TCustomSpeedButtonEh);
var
  I: TButtonStateEh;
begin
  inherited Create;
  FButton := AButton;
  FOriginal := TBitmap.Create;
  FOriginal.OnChange := GlyphChanged;
  FTransparentColor := clOlive;
  FNumGlyphs := 1;
  FPaintOnGlass := False;
  FThemesEnabled := False;
  FThemeTextColor := True;
  for I := Low(I) to High(I) do
    FIndexs[I] := -1;
end;

destructor TButtonGlyph.Destroy;
begin
  FOriginal.Free;
  Invalidate;
  inherited Destroy;
end;

procedure TButtonGlyph.DoChange;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TButtonGlyph.Invalidate;
var
  I: TButtonStateEh;
begin
  for I := Low(I) to High(I) do
  begin
    if FIndexs[I] <> -1 then FGlyphList.Delete(FIndexs[I]);
    FIndexs[I] := -1;
  end;
  FreeAndNil(FGlyphList);
end;

procedure TButtonGlyph.GlyphChanged(Sender: TObject);
begin
  if Sender = FOriginal then
  begin
    FTransparentColor := FOriginal.TransparentColor;
    Invalidate;
    DoChange;
  end;
end;

procedure TButtonGlyph.SetGlyph(Value: TBitmap);
var
  Glyphs: Integer;
begin
  Invalidate;
  FOriginal.Assign(Value);
  if (Value <> nil) and (Value.Height > 0) then
  begin
    FTransparentColor := Value.TransparentColor;
    if Value.Width mod Value.Height = 0 then
    begin
      Glyphs := Value.Width div Value.Height;
      if Glyphs > 4 then Glyphs := 1;
      SetNumGlyphs(Glyphs);
    end;
  end;
end;

procedure TButtonGlyph.SetNumGlyphs(Value: TNumGlyphsEh);
begin
  if (Value <> FNumGlyphs) and (Value > 0) then
  begin
    Invalidate;
    FNumGlyphs := Value;
    GlyphChanged(Glyph);
  end;
end;

const
  ROP_DSPDxax = $00E20746;

function TButtonGlyph.CreateButtonGlyph(State: TButtonStateEh): Integer;
var
  TmpImage, DDB, MonoBmp: TBitmap;
  IWidth, IHeight: Integer;
  IRect, ORect: TRect;
  I: TButtonStateEh;
  DestDC: HDC;
begin
  if (State = bsPressedEh) and (NumGlyphs < 3) then State := bsNormalEh;
  Result := FIndexs[State];
  if Result <> -1 then Exit;
  if (FOriginal.Width or FOriginal.Height) = 0 then Exit;
  IWidth := FOriginal.Width div FNumGlyphs;
  IHeight := FOriginal.Height;
  if FGlyphList = nil then
  begin
    //if GlyphCache = nil then GlyphCache := TGlyphCache.Create;
    //FGlyphList := GlyphCache.GetList(IWidth, IHeight);
    FGlyphList := TGlyphList.CreateSize(IWidth, IHeight);
  end;
  TmpImage := TBitmap.Create;
  try
    TmpImage.Width := IWidth;
    TmpImage.Height := IHeight;
    IRect := Rect(0, 0, IWidth, IHeight);
    TmpImage.Canvas.Brush.Color := clBtnFace;
    {$IFDEF FPC}
    {$ELSE}
    TmpImage.Palette := CopyPalette(FOriginal.Palette);
    {$ENDIF}
    I := State;
    if Ord(I) >= NumGlyphs then I := bsNormalEh;
    ORect := Rect(Ord(I) * IWidth, 0, (Ord(I) + 1) * IWidth, IHeight);
    case State of
      bsNormalEh, bsPressedEh,
      bsHotEh:
        begin
          TmpImage.Canvas.CopyRect(IRect, FOriginal.Canvas, ORect);
          if FOriginal.TransparentMode = tmFixed then
            FIndexs[State] := FGlyphList.AddMasked(TmpImage, FTransparentColor)
          else
            FIndexs[State] := FGlyphList.AddMasked(TmpImage, clDefault);
        end;
      bsDisabledEh:
        begin
          MonoBmp := nil;
          DDB := nil;
          try
            MonoBmp := TBitmap.Create;
            DDB := TBitmap.Create;
            DDB.Assign(FOriginal);
            DDB.HandleType := bmDDB;
            if NumGlyphs > 1 then
            //with TmpImage.Canvas do
            begin    { Change white & gray to clBtnHighlight and clBtnShadow }
              TmpImage.Canvas.CopyRect(IRect, DDB.Canvas, ORect);
              MonoBmp.Monochrome := True;
              MonoBmp.Width := IWidth;
              MonoBmp.Height := IHeight;

              { Convert white to clBtnHighlight }
              DDB.Canvas.Brush.Color := clWhite;
              MonoBmp.Canvas.CopyRect(IRect, DDB.Canvas, ORect);
              TmpImage.Canvas.Brush.Color := clBtnHighlight;
              DestDC := TmpImage.Canvas.Handle;
              SetTextColor(DestDC, clBlack);
              SetBkColor(DestDC, clWhite);
              BitBlt(DestDC, 0, 0, IWidth, IHeight,
                     MonoBmp.Canvas.Handle, 0, 0, ROP_DSPDxax);

              { Convert gray to clBtnShadow }
              DDB.Canvas.Brush.Color := clGray;
              MonoBmp.Canvas.CopyRect(IRect, DDB.Canvas, ORect);
              TmpImage.Canvas.Brush.Color := clBtnShadow;
              DestDC := TmpImage.Canvas.Handle;
              SetTextColor(DestDC, clBlack);
              SetBkColor(DestDC, clWhite);
              BitBlt(DestDC, 0, 0, IWidth, IHeight,
                     MonoBmp.Canvas.Handle, 0, 0, ROP_DSPDxax);

              { Convert transparent color to clBtnFace }
              DDB.Canvas.Brush.Color := ColorToRGB(FTransparentColor);
              MonoBmp.Canvas.CopyRect(IRect, DDB.Canvas, ORect);
              TmpImage.Canvas.Brush.Color := clBtnFace;
              DestDC := TmpImage.Canvas.Handle;
              SetTextColor(DestDC, clBlack);
              SetBkColor(DestDC, clWhite);
              BitBlt(DestDC, 0, 0, IWidth, IHeight,
                     MonoBmp.Canvas.Handle, 0, 0, ROP_DSPDxax);
            end
            else
            begin
              { Create a disabled version }
              //with MonoBmp do
              begin
                MonoBmp.Assign(FOriginal);
                MonoBmp.HandleType := bmDDB;
                MonoBmp.Canvas.Brush.Color := clBlack;
                MonoBmp.Width := IWidth;
                if MonoBmp.Monochrome then
                begin
                  MonoBmp.Canvas.Font.Color := clWhite;
                  MonoBmp.Monochrome := False;
                  MonoBmp.Canvas.Brush.Color := clWhite;
                end;
                MonoBmp.Monochrome := True;
              end;
              //with TmpImage.Canvas do
              begin
                TmpImage.Canvas.Brush.Color := clBtnFace;
                TmpImage.Canvas.FillRect(IRect);
                TmpImage.Canvas.Brush.Color := clBtnHighlight;
                SetTextColor(TmpImage.Canvas.Handle, clBlack);
                SetBkColor(TmpImage.Canvas.Handle, clWhite);
                BitBlt(TmpImage.Canvas.Handle, 1, 1, IWidth, IHeight,
                  MonoBmp.Canvas.Handle, 0, 0, ROP_DSPDxax);
                TmpImage.Canvas.Brush.Color := clBtnShadow;
                SetTextColor(TmpImage.Canvas.Handle, clBlack);
                SetBkColor(TmpImage.Canvas.Handle, clWhite);
                BitBlt(TmpImage.Canvas.Handle, 0, 0, IWidth, IHeight,
                  MonoBmp.Canvas.Handle, 0, 0, ROP_DSPDxax);
              end;
            end;
          finally
            DDB.Free;
            MonoBmp.Free;
          end;
          FIndexs[State] := FGlyphList.AddMasked(TmpImage, clDefault);
        end;
    end;
  finally
    TmpImage.Free;
  end;
  Result := FIndexs[State];
  {$IFDEF FPC}
  {$ELSE}
  FOriginal.Dormant;
  {$ENDIF}
end;

procedure TButtonGlyph.DrawButtonGlyph(Canvas: TCanvas; const GlyphPos: TPoint;
  State: TButtonStateEh; Transparent: Boolean);
var
  Index: Integer;
  Details: TThemedElementDetails;
  R: TRect;
  Button: TThemedButton;
{$IFDEF EH_LIB_16}
  LStyle: TCustomStyleServices;
{$ELSE}
  LStyle: TThemeServices;
{$ENDIF}
begin
  if FButton.IsCustomGlyph then
  begin
    FButton.DrawCustomGlyph(Canvas, GlyphPos);
  end else
  begin
    if FOriginal = nil then Exit;
    if (FOriginal.Width = 0) or (FOriginal.Height = 0) then Exit;
    Index := CreateButtonGlyph(State);

    if FThemesEnabled then
    begin
      {$IFDEF EH_LIB_16}
      LStyle := StyleServices;
      {$ELSE}
      LStyle := ThemeServices;
      {$ENDIF}
      R.Left := GlyphPos.X;
      R.Top := GlyphPos.Y;
      R.Right := R.Left + FOriginal.Width div FNumGlyphs;
      R.Bottom := R.Top + FOriginal.Height;
      case State of
        bsDisabledEh:
          Button := tbPushButtonDisabled;
        bsPressedEh:
          Button := tbPushButtonPressed;
      else
        // bsUp
        Button := tbPushButtonNormal;
      end;

      Details := LStyle.GetElementDetails(Button);
      {$IFDEF FPC}
      {$ELSE}
      LStyle.DrawIcon(Canvas.Handle, Details, R, FGlyphList.Handle, Index);
      {$ENDIF}
    end
    else
    begin
      //if Transparent or (State = bsExclusive) then
      if Transparent then
      begin
        {$IFDEF FPC}
        {$ELSE}
        ImageList_DrawEx(FGlyphList.Handle, Index, Canvas.Handle,
          GlyphPos.X, GlyphPos.Y, 0, 0, clNone, clNone, ILD_Transparent)
        {$ENDIF}
      end
      else
      begin
        {$IFDEF FPC}
        {$ELSE}
        ImageList_DrawEx(FGlyphList.Handle, Index, Canvas.Handle,
          GlyphPos.X, GlyphPos.Y, 0, 0, ColorToRGB(clBtnFace), clNone, ILD_Normal);
        {$ENDIF}
      end;
    end;
  end;
end;

procedure TButtonGlyph.DrawButtonText(Canvas: TCanvas; const Caption: string;
  TextBounds: TRect; State: TButtonStateEh; Flags: LongInt);

  procedure DoDrawText(DC: HDC; const Text: String; var TextRect: TRect; TextFlags: Cardinal);
{$IFDEF EH_LIB_16}
  var
    LColor: TColor;
    LFormats: TTextFormat;
    LStyle: TCustomStyleServices;
    LOptions: TStyleTextOptions;
{$ELSE}
{$ENDIF}
  begin
{$IFDEF EH_LIB_16}
    if FThemesEnabled then
    begin
      LStyle := StyleServices;
      if (State = bsDisabledEh) or (not LStyle.IsSystemStyle and FThemeTextColor) then
      begin
        if not LStyle.GetElementColor(FThemeDetails, ecTextColor, LColor) or (LColor = clNone) then
          LColor := Canvas.Font.Color;
      end
      else
        LColor := Canvas.Font.Color;

      LFormats := TTextFormatFlags(TextFlags);

      LOptions.Flags := [stfTextColor, stfGlowSize];
      LOptions.TextColor := LColor;
      LOptions.GlowSize := 20;

      if FPaintOnGlass then
        Include(LFormats, tfComposited);
      LStyle.DrawText(DC, FThemeDetails, Text, TextRect, LFormats, LOptions);
    end
    else
{$ELSE}
{$ENDIF}
      DrawTextEh(DC, Text, Length(Text), TextRect, TextFlags);
  end;

begin
  Canvas.Brush.Style := bsClear;
  if (State = bsDisabledEh) and not FThemesEnabled then
  begin
    OffsetRect(TextBounds, 1, 1);
    Canvas.Font.Color := clBtnHighlight;
    DoDrawText(Canvas.Handle, Caption, TextBounds, DT_NOCLIP or DT_CENTER or DT_VCENTER or Flags);
    OffsetRect(TextBounds, -1, -1);
    Canvas.Font.Color := clBtnShadow;
    DoDrawText(Canvas.Handle, Caption, TextBounds, DT_NOCLIP or DT_CENTER or DT_VCENTER or Flags);
  end
  else
    DoDrawText(Canvas.Handle, Caption, TextBounds, DT_NOCLIP or DT_CENTER or DT_VCENTER or Flags);
end;

procedure TButtonGlyph.CalcButtonLayout(Canvas: TCanvas; const Client: TRect;
  const Offset: TPoint; const Caption: string; Layout: TButtonLayoutEh; Margin,
  Spacing: Integer; var GlyphPos: TPoint; var TextBounds: TRect;
  BiDiFlags: LongInt);
var
  TextPos: TPoint;
  ClientSize, GlyphSize, TextSize: TPoint;
  CustomGlyphSize: TSize;
  TotalSize: TPoint;
begin
  if (BiDiFlags and DT_RIGHT) = DT_RIGHT then
    if Layout = blGlyphLeftEh then
      Layout := blGlyphRightEh
    else if Layout = blGlyphRightEh then
        Layout := blGlyphLeftEh;
  { calculate the item sizes }
  ClientSize := Point(Client.Right - Client.Left, Client.Bottom -
    Client.Top);

//  if (FImages <> nil) and (FImageIndex <> -1) then
//    GlyphSize := Point(FImages.Width, FImages.Height)
//  else
  if (FButton.IsCustomGlyph) then
  begin
    CustomGlyphSize := FButton.GetCustomGlyphSize;
    GlyphSize.X := CustomGlyphSize.cx;
    GlyphSize.Y := CustomGlyphSize.cy;
  end else if (FOriginal <> nil) and not FOriginal.Empty then
  begin
    GlyphSize := Point(FOriginal.Width div FNumGlyphs, FOriginal.Height)
  end else
    GlyphSize := Point(0, 0);

  if Length(Caption) > 0 then
  begin
    TextBounds := Rect(0, 0, Client.Right - Client.Left, 0);
    DrawTextEh(Canvas.Handle, Caption, Length(Caption), TextBounds,
      DT_CALCRECT or BiDiFlags);
    TextSize := Point(TextBounds.Right - TextBounds.Left, TextBounds.Bottom -
      TextBounds.Top);
  end
  else
  begin
    TextBounds := Rect(0, 0, 0, 0);
    TextSize := Point(0,0);
  end;

  { If the layout has the glyph on the right or the left, then both the
    text and the glyph are centered vertically.  If the glyph is on the top
    or the bottom, then both the text and the glyph are centered horizontally.}
  if Layout in [blGlyphLeftEh, blGlyphRightEh] then
  begin
    GlyphPos.Y := (ClientSize.Y - GlyphSize.Y) div 2;
    TextPos.Y := (ClientSize.Y - TextSize.Y) div 2;
  end
  else
  begin
    GlyphPos.X := (ClientSize.X - GlyphSize.X) div 2;
    TextPos.X := (ClientSize.X - TextSize.X) div 2;
  end;

  { if there is no text or no bitmap, then Spacing is irrelevant }
  if (TextSize.X = 0) or (GlyphSize.X = 0) then
    Spacing := 0;

  { adjust Margin and Spacing }
  if Margin = -1 then
  begin
    if Spacing < 0 then
    begin
      TotalSize := Point(GlyphSize.X + TextSize.X, GlyphSize.Y + TextSize.Y);
      if Layout in [blGlyphLeftEh, blGlyphRightEh] then
        Margin := (ClientSize.X - TotalSize.X) div 3
      else
        Margin := (ClientSize.Y - TotalSize.Y) div 3;
      Spacing := Margin;
    end
    else
    begin
      TotalSize := Point(GlyphSize.X + Spacing + TextSize.X, GlyphSize.Y +
        Spacing + TextSize.Y);
      if Layout in [blGlyphLeftEh, blGlyphRightEh] then
        Margin := (ClientSize.X - TotalSize.X) div 2
      else
        Margin := (ClientSize.Y - TotalSize.Y) div 2;
    end;
  end
  else
  begin
    if Spacing < 0 then
    begin
      TotalSize := Point(ClientSize.X - (Margin + GlyphSize.X), ClientSize.Y -
        (Margin + GlyphSize.Y));
      if Layout in [blGlyphLeftEh, blGlyphRightEh] then
        Spacing := (TotalSize.X - TextSize.X) div 2
      else
        Spacing := (TotalSize.Y - TextSize.Y) div 2;
    end;
  end;

  case Layout of
    blGlyphLeftEh:
      begin
        GlyphPos.X := Margin;
        TextPos.X := GlyphPos.X + GlyphSize.X + Spacing;
      end;
    blGlyphRightEh:
      begin
        GlyphPos.X := ClientSize.X - Margin - GlyphSize.X;
        TextPos.X := GlyphPos.X - Spacing - TextSize.X;
      end;
    blGlyphTopEh:
      begin
        GlyphPos.Y := Margin;
        TextPos.Y := GlyphPos.Y + GlyphSize.Y + Spacing;
      end;
    blGlyphBottomEh:
      begin
        GlyphPos.Y := ClientSize.Y - Margin - GlyphSize.Y;
        TextPos.Y := GlyphPos.Y - Spacing - TextSize.Y;
      end;
  end;

  { fixup the result variables }
  Inc(GlyphPos.X, Client.Left + Offset.X);
  Inc(GlyphPos.Y, Client.Top + Offset.Y);

  OffsetRect(TextBounds, TextPos.X + Client.Left + Offset.X, TextPos.Y + Client.Top + Offset.Y);
end;

function TButtonGlyph.Draw(Canvas: TCanvas; const Client: TRect;
  const Offset: TPoint): TRect;
var
  GlyphPos: TPoint;
  BiDiFlags: Longint;
begin
  {$IFDEF FPC}
  BiDiFlags := 0;
  {$ELSE}
  BiDiFlags := FButton.DrawTextBiDiModeFlags(0);
  {$ENDIF}
  CalcButtonLayout(Canvas, Client, Offset, FButton.Caption, FButton.Layout,
    FButton.Margin, FButton.Spacing, GlyphPos, Result, BiDiFlags);
  DrawButtonGlyph(Canvas, GlyphPos, FButton.State, FButton.Transparent);
  DrawButtonText(Canvas, FButton.Caption, Result, FButton.State, BiDiFlags);
end;

{ TButtonImagesEh }

constructor TButtonImagesEh.Create;
begin
  inherited Create;
end;

destructor TButtonImagesEh.Destroy;
begin
  inherited Destroy;
end;

procedure TButtonImagesEh.Assign(Source: TPersistent);
begin
  if Source is TButtonImagesEh then
  begin
    NormalImages := TButtonImagesEh(Source).NormalImages;
    HotImages := TButtonImagesEh(Source).HotImages;
    PressedImages := TButtonImagesEh(Source).PressedImages;
    DisabledImages := TButtonImagesEh(Source).DisabledImages;

    NormalIndex := TButtonImagesEh(Source).NormalIndex;
    HotIndex := TButtonImagesEh(Source).HotIndex;
    PressedIndex := TButtonImagesEh(Source).PressedIndex;
    DisabledIndex := TButtonImagesEh(Source).DisabledIndex;
  end else
    inherited Assign(Source);
end;

function TButtonImagesEh.GetStateImages(EditButtonState: TButtonStateEh): TCustomImageList;
begin
  case EditButtonState of
    bsNormalEh:       Result := NormalImages;
    bsHotEh:          Result := HotImages;
    bsPressedEh:      Result := PressedImages;
    bsDisabledEh:     Result := DisabledImages;
  else
    Result := nil;
  end;
  if (Result = nil) and (EditButtonState <> bsNormalEh) then
    Result := NormalImages;
end;

function TButtonImagesEh.GetStateIndex(EditButtonState: TButtonStateEh): Integer;
begin
  case EditButtonState of
    bsNormalEh:       Result := NormalIndex;
    bsHotEh:          Result := HotIndex;
    bsPressedEh:      Result := PressedIndex;
    bsDisabledEh:     Result := DisabledIndex;
  else
    Result := -1;
  end;
end;

procedure TButtonImagesEh.SetDisabledImages(const Value: TCustomImageList);
begin
  if FDisabledImages <> Value then
  begin
    FDisabledImages := Value;
    RefComponentChanged(Value);
  end;
end;

procedure TButtonImagesEh.SetDisabledIndex(const Value: TImageIndex);
begin
  if FDisabledIndex <> Value then
  begin
    FDisabledIndex := Value;
    ImagesStateChanged;
  end;
end;

procedure TButtonImagesEh.SetHotImages(const Value: TCustomImageList);
begin
  if FHotImages <> Value then
  begin
    FHotImages := Value;
    RefComponentChanged(Value);
  end;
end;

procedure TButtonImagesEh.SetHotIndex(const Value: TImageIndex);
begin
  if FHotIndex <> Value then
  begin
    FHotIndex := Value;
    ImagesStateChanged
  end;
end;

procedure TButtonImagesEh.SetNormalImages(const Value: TCustomImageList);
begin
  if FNormalImages <> Value then
  begin
    FNormalImages := Value;
    RefComponentChanged(Value);
  end;
end;

procedure TButtonImagesEh.SetNormalIndex(const Value: TImageIndex);
begin
  if FNormalIndex <> Value then
  begin
    FNormalIndex := Value;
    ImagesStateChanged;
  end;
end;

procedure TButtonImagesEh.SetPressedImages(const Value: TCustomImageList);
begin
  if FPressedImages <> Value then
  begin
    FPressedImages := Value;
    RefComponentChanged(Value);
  end;
end;

procedure TButtonImagesEh.SetPressedIndex(const Value: TImageIndex);
begin
  if FPressedIndex <> Value then
  begin
    FPressedIndex := Value;
    ImagesStateChanged;
  end;
end;

procedure TButtonImagesEh.ImagesStateChanged;
begin

end;

procedure TButtonImagesEh.RefComponentChanged(RefComponent: TComponent);
begin

end;

end.
