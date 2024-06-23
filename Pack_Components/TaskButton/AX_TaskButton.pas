unit AX_TaskButton;

interface

uses Windows, Messages, Classes, SysUtils, Controls, ImgList, Graphics,
     ActnList, Math, StdCtrls, Types;

type
//  TtskBoundLines = set of (blLeft, blTop, blRight, blBottom);
//  TtskDrawState = set of (dsDefault, dsHotLight, dsFocused, dsSelected);

  TaxTaskButton = class(TCustomControl)
  private
    FFocused: Boolean;
    FFocusedMouse: Boolean;
    FPressed: Boolean;
    FImageindex: Integer;
    FCommandLinkHint: String;
    FColors: array[0..4] of TColor;
    FUseShadow: Boolean;
    FTransparent: Boolean;
    FNormal: TCustomImageList;
    FDisabled: TCustomImageList;
    FHot: TCustomImageList;
    function GetColor( index: Integer ): TColor;
    procedure SetColor( index: Integer; AValue: TColor );
    procedure SetUseShadow( AValue: Boolean );
    procedure SetTransparent( AValue: Boolean );
    procedure SetImages( index: Integer; AValue: TCustomImageList);
    procedure SetImageindex( AValue: Integer );
    procedure GradVertical(Canvas: TCanvas; Rect: TRect; FromColor, ToColor: TColor);
    procedure SetCommandLinkHint(const AValue: String);
  protected
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); override;
    procedure CMTextChanged(var message: Tmessage); message CM_TEXTCHANGED;
    procedure CMDialogChar( var message: TCMDialogChar ); message cm_DialogChar;
    procedure CMMouseEnter( var message: Tmessage ); message CM_MOUSEENTER;
    procedure CMMouseLeave( var message: Tmessage ); message CM_MOUSELEAVE;
    procedure CMEnabledChanged( var message: Tmessage ); message CM_ENABLEDCHANGED;
    procedure WMSetFocus(var message: Tmessage); message WM_SETFOCUS;
    procedure WMKillFocus(var message: Tmessage); message WM_KILLFOCUS;
    procedure WMKeyDown(var Message: TMessage); message WM_KEYDOWN;
    procedure WMKeyUp(var Message: TMessage); message WM_KEYUP;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure CMFocusChanged(var Message: TCMFocusChanged); message CM_FOCUSCHANGED;
    procedure Notification( AComponent: TComponent; Operation: TOperation ); override;
    procedure Paint; override;
    procedure MouseDown( Button: TMouseButton; Shift: TShiftState; X, Y: Integer ); override;
    procedure MouseUp( Button: TMouseButton; Shift: TShiftState; X, Y: Integer ); override;
    procedure DoDrawText(var Rect: TRect; Flags: Longint; Text: String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Color: TColor index 0 read GetColor write SetColor;
    property BorderColor: TColor index 3 read GetColor write SetColor;
    property ShadowColor: TColor index 4 read GetColor write SetColor;
    property UseShadow: Boolean read FUseShadow write SetUseShadow;
    property Transparent: Boolean read FTransparent write SetTransparent;

    property Normal: TCustomImageList index 0 read FNormal write SetImages;
    property Disabled: TCustomImageList index 1 read FDisabled write SetImages;
    property Hot: TCustomImageList index 2 read FHot write SetImages;

    property Imageindex: Integer read FImageindex write SetImageindex;
    property CommandLinkHint: String read FCommandLinkHint write SetCommandLinkHint;

    property Caption;
    property Action;
    property OnClick;
    property Enabled;
    property Font;
    property TabStop;
    property Width;
    property Height;
    property TabOrder;
  end;

procedure Register;

implementation

uses Forms;

procedure Register;
begin
  RegisterComponents('AX Comps', [TaxTaskButton]);
end;

constructor TaxTaskButton.Create( AOwner: TComponent );
begin
  inherited Create(AOwner);
  Width := 150;
  Height := 35;
  Font.Size := 14;
  Font.Color := clNavy;
  TabStop := True;

  FColors[0] := clWhite;
  FColors[1] := TColor($D8ACB0);
  FColors[2] := TColor($C7879F);
  FColors[3] := clSilver;
  FColors[4] := clBtnShadow;

  FUseShadow := True;
  FTransparent := True;

  FImageindex := -1;
  FFocused := false;
  FFocusedMouse := false;
end;

destructor TaxTaskButton.Destroy;
begin
  inherited Destroy;
end;

procedure TaxTaskButton.SetImageindex( AValue: Integer );
begin
  if FImageindex <> AValue then
  begin
    FImageindex := AValue;
    Invalidate;
  end;
end;

procedure TaxTaskButton.SetImages( index: Integer; AValue: TCustomImageList );
begin
  case index of
    0: FNormal := AValue;
    1: FDisabled := AValue;
    2: FHot := AValue;
  end;
  Invalidate;
end;

procedure TaxTaskButton.Notification( AComponent: TComponent; Operation: TOperation );
begin
  inherited Notification(AComponent, Operation);
  if (csDestroying In ComponentState) then Exit;

  if AComponent is TCustomImageList then
  begin
    case Operation of
      opRemove:
      begin
        if AComponent = FNormal then FNormal := nil;
        if AComponent = FDisabled then FDisabled := nil;
        if AComponent = FHot then FHot := nil;
      end;
    end;
  end;
end;

Function TaxTaskButton.GetColor( index: Integer ): TColor;
begin
  Result := FColors[index];
end;

procedure TaxTaskButton.SetColor( index: Integer; AValue: TColor );
begin
  if GetColor(index) <> AValue then
  begin
    FColors[index] := AValue;
    Invalidate;
  end;
end;

procedure TaxTaskButton.SetCommandLinkHint(const AValue: String);
begin
  if FCommandLinkHint <> AValue then
  begin
    FCommandLinkHint := AValue;
    Invalidate;
  end;
end;

procedure TaxTaskButton.SetTransparent( AValue: Boolean );
begin
  if FTransparent <> AValue then
  begin
    FTransparent := AValue;
    Invalidate;
  end;
end;

procedure TaxTaskButton.SetUseShadow( AValue: Boolean );
begin
  if FUseShadow <> AValue then
  begin
    FUseShadow := AValue;
    Invalidate;
  end;
end;

procedure TaxTaskButton.CMEnabledChanged( var message: Tmessage );
begin
  inherited;
  Invalidate;
end;

procedure TaxTaskButton.CMMouseLeave( var message: Tmessage );
begin
  inherited;
  FFocusedMouse := false;
  Invalidate;
end;

procedure TaxTaskButton.CMMouseEnter( var message: Tmessage );
begin
  inherited;
  FFocusedMouse := true;
  Invalidate;
end;

procedure TaxTaskButton.MouseDown( Button: TMouseButton; Shift: TShiftState; X, Y: Integer );
begin
  inherited MouseDown( Button, Shift, X, Y );
  FPressed := True;
  Invalidate;
end;

procedure TaxTaskButton.MouseUp( Button: TMouseButton; Shift: TShiftState; X, Y: Integer );
begin
  inherited MouseUp( Button, Shift, X, Y );
  FPressed := False;
  Invalidate;
end;

procedure TaxTaskButton.CMDialogChar( var message: TCMDialogChar );
begin
  inherited;
  with message do
  begin
    if IsAccel(CharCode, Caption) then
       Click;
  end;
end;

procedure TaxTaskButton.Paint;
var
  AImageRect, ALabelRect, ARect, ACalcRect: TRect;
  AImageList: TCustomImageList;
  ShadowBitmap: TBitmap;
  IX, IY: Integer;
  Flags: Longint;
  FlagsLink: Longint;
  Text: string;
  LHeightText: Integer;
begin
  // Area de desenho do componente
  ARect := ClientRect;
  with Canvas do
  begin
     Brush.Style := bsSolid;
     // Define a cor da font
     Font.Assign( Self.Font );
     // Definição de cores do botão
     // O ponteiro do mouse está no componente
     if FFocusedMouse then
     begin
        Font.Color := clBlue;
        GradVertical(Canvas, ARect, clWhite, TColor($00F5F5F5));
        if FFocused then
           DrawFocusRect(Rect (3, 3, Width -3, Height -3))
        else
        begin
           Brush.Color := BorderColor;
           FrameRect( Rect (1, 1, Width -1, Height -1) );
        end;
     end
     else
        Brush.Color := Color;

     // Mouse com focu ou pressionado
     if (FPressed) and (FFocusedMouse) then
     begin
        GradVertical(Canvas, ARect, TColor($00F5F5F5), TColor($00F5F5F5));
        Brush.Color := clGray;
        FrameRect( Rect (1, 1, Width -1, Height -1) );
     end;
     // Componente com focus
     if FFocused and (not(csDesigning in ComponentState)) and (Enabled) then
     begin
       if FPressed then
       begin
         if Assigned(FHot) then
            AImageList := FHot
         else
            AImageList := FNormal;
       end
       else
         AImageList := FNormal;

       Brush.Style := bsClear;
       FillRect(ARect);
       InflateRect(ARect, -1, -1);
       Brush.Color := BorderColor;
       FrameRect(ARect);
       DrawFocusRect(Rect(3, 3, Width -3, Height -3));
     end
     else
     begin
       AImageList := FNormal;
       if not Transparent then
          FillRect(ARect);
     end;
     if not Enabled then
        AImageList := FDisabled;

     // *** Check Images ****
     if Assigned(AImageList) and (FImageindex >= 0) then
     begin
       AImageRect.Left := 0;
       AImageRect.Right := AImageList.Width;
       AImageRect.Top := 0;
       AImageRect.Bottom := AImageList.Height;
     end
     else
       AImageRect := Bounds(0,0,0,0);

     // *** Calc total size ***
     IX := AImageRect.Right - AImageRect.Left;
     IY := AImageRect.Bottom - AImageRect.Top;

     AImageRect.Left   := 5;
     AImageRect.Top    := 5;
     AImageRect.Right  := AImageRect.Left + IX;
     AImageRect.Bottom := AImageRect.Top  + IY;

     // *** Draw Caption ***
     Text  := Caption;
     Flags := 0;
     if Text <> '' then
     begin
       Brush.Style := bsClear;

       Flags := DT_LEFT or DT_END_ELLIPSIS or DT_EXPANDTABS;
       Flags := DrawTextBiDiModeFlags(Flags);

       ALabelRect := ClientRect;
       SetRect(ALabelRect, ALabelRect.Left + AImageRect.Right,
                           ALabelRect.Top,
                           ALabelRect.Right,
                           ALabelRect.Bottom);
       OffsetRect(ALabelRect, 5, 3);

       if FPressed then
       begin
         Inc(ALabelRect.Top);
         Inc(ALabelRect.Left);
         Inc(ALabelRect.Bottom);
         Inc(ALabelRect.Right);
       end;
       if not Enabled then
          Font.Color := clBtnHighlight;

       DoDrawText(ALabelRect, Flags, Text);
       LHeightText := TextHeight(Text);

       Font.Size := 8;
       FlagsLink := DT_LEFT or DT_WORDBREAK or DT_EXPANDTABS;
       ACalcRect := ClientRect;
       SetRect(ACalcRect, ACalcRect.Left + AImageRect.Right,
                          ACalcRect.Top,
                          ACalcRect.Right,
                          ACalcRect.Bottom);
       OffsetRect(ACalcRect, 5, 3);
       DoDrawText(ACalcRect, FlagsLink or DT_CALCRECT, FCommandLinkHint);
       OffsetRect(ACalcRect, 0, LHeightText +1);
       DoDrawText(ACalcRect, FlagsLink, FCommandLinkHint);
     end;

     // *** Draw Image ***
     if Assigned(AImageList) and (FImageindex >= 0) then
     begin
       if (not FPressed) and (FFocused) and (not(csDesigning in ComponentState)) then
       begin
         if UseShadow then
         begin
           Brush.Color := ShadowColor;
           Brush.Style := bsSolid;

           ShadowBitmap := TBitmap.Create;
           try
             ShadowBitmap.Width := AImageList.Width;
             ShadowBitmap.Height := AImageList.Height;

             AImageList.ImageType := itMask;
             AImageList.Draw(ShadowBitmap.Canvas, 0, 0, FImageindex);

             DrawState(Handle,
                       Brush.Handle,
                       nil,
                       Integer(ShadowBitmap.Handle),
                       0,
                       AImageRect.Left + 1,
                       AImageRect.Top + 1,
                       0,
                       0,
                       DST_BITMAP or DSS_MONO);
           finally
             ShadowBitmap.Free;
           end;
         end;
         AImageList.ImageType := itImage;
         AImageList.Draw(Canvas, AImageRect.Left, AImageRect.Top, FImageindex);
       end
       else
       begin
         AImageList.ImageType := itImage;
         AImageList.Draw(Canvas, AImageRect.Left +1, AImageRect.Top +1, FImageindex);
       end;
     end;
  end;
end;

procedure TaxTaskButton.CMTextChanged(var message: Tmessage);
begin
  Invalidate;
end;

procedure TaxTaskButton.ActionChange(Sender: TObject; CheckDefaults: Boolean);
begin
  inherited ActionChange(Sender, CheckDefaults);
  if Sender is TCustomAction then
    with TCustomAction(Sender) do
    begin
      if not CheckDefaults or (Self.HelpContext = 0) then
        Self.HelpContext := HelpContext;
    {$IFDEF Delphi6}
      if not CheckDefaults or (Self.HelpKeyword = '') then
        Self.HelpKeyword := HelpKeyword;
      if not CheckDefaults then
        Self.HelpType := HelpType;
    {$ENDIF}
      if not CheckDefaults or (Self.Imageindex = 0) then
        Self.Imageindex := Imageindex;
    end;
end;

procedure TaxTaskButton.WMSetFocus(var message: Tmessage);
begin
  if not FFocused then
  begin
    FFocused := true;
    Invalidate;
  end;
end;

procedure TaxTaskButton.WMKeyDown(var Message: TMessage);
begin
  if (not FPressed) and ((Message.WParam = VK_RETURN) or (Message.WParam = VK_SPACE)) then
  Begin
    FPressed := true;
    Invalidate;
  end;
  inherited;
end;

procedure TaxTaskButton.WMKeyUp(var Message: TMessage);
begin
  if FPressed then
  begin
    FPressed := False;
    Invalidate;
    if Assigned(OnClick) then
       OnClick(Self);
  end;
  inherited;
end;

procedure TaxTaskButton.WMKillFocus(var message: Tmessage);
begin
  if FFocused then
  begin
    FFocused := False;
    Invalidate;
  end;
end;

procedure TaxTaskButton.CMEnter(var Message: TCMEnter);
begin
  inherited;
  FFocused := True;
  Invalidate;
end;

procedure TaxTaskButton.CMExit(var Message: TCMExit);
begin
  inherited;
  FFocused := False;
  Invalidate;
end;

procedure TaxTaskButton.CMFocusChanged(var Message: TCMFocusChanged);
begin
  inherited;
  Invalidate;
end;

procedure TaxTaskButton.DoDrawText(var Rect: TRect; Flags: Longint; Text: String);
var
  LText: string;
begin
  LText := Text;

  if LText <> '' then
  begin
    if (Flags and DT_CALCRECT <> 0) and (LText = '') or ((LText[1] = '&') and (Length(LText) > 1)) then
       LText := LText + ' ';

    with Canvas do
    begin
      Flags := DrawTextBiDiModeFlags(Flags);
      Font.Assign(Font);

      if Enabled then
         DrawTextW(Handle, LText, Length(LText), Rect, Flags)
      else
      begin
        OffsetRect(Rect, 1, 1);
        Font.Color := clBtnHighlight;
        DrawTextW(Handle, LText, Length(LText), Rect, Flags);

        OffsetRect(Rect, -1, -1);
        Font.Color := clBtnShadow;
        DrawTextW(Handle, LText, Length(LText), Rect, Flags);
      end;
    end;
  end;
end;

procedure TaxTaskButton.GradVertical(Canvas:TCanvas; Rect:TRect; FromColor, ToColor:TColor) ;
var
  Y:integer;
  dr,dg,db:Extended;
  C1,C2:TColor;
  r1,r2,g1,g2,b1,b2:Byte;
  R,G,B:Byte;
  cnt:Integer;
begin
   C1 := FromColor;
   R1 := GetRValue(C1) ;
   G1 := GetGValue(C1) ;
   B1 := GetBValue(C1) ;

   C2 := ToColor;
   R2 := GetRValue(C2) ;
   G2 := GetGValue(C2) ;
   B2 := GetBValue(C2) ;

   dr := (R2-R1) / Rect.Bottom-Rect.Top;
   dg := (G2-G1) / Rect.Bottom-Rect.Top;
   db := (B2-B1) / Rect.Bottom-Rect.Top;

   cnt := 0;
   for Y := Rect.Top to Rect.Bottom-1 do
   begin
      R := R1+Ceil(dr*cnt) ;
      G := G1+Ceil(dg*cnt) ;
      B := B1+Ceil(db*cnt) ;

      Canvas.Pen.Color := RGB(R,G,B) ;
      Canvas.MoveTo(Rect.Left,Y) ;
      Canvas.LineTo(Rect.Right,Y) ;
      Inc(cnt) ;
   end;
end;

end.
