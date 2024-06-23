unit AX_Ctrls;

interface

uses
  SysUtils, Classes, Controls, Windows, StdCtrls, Graphics, Messages;

type
  THack = class(TControl);

  TaxCustomControl = class(TCustomControl)
  private
    { Private declarations }
    FShowAccelChar: Boolean;
    FTransparent: Boolean;
    FWordWrap: Boolean;
    FEllipsisPosition: TEllipsisPosition;
    FLayout: TTextLayout;
    FAlignment: TAlignment;
    procedure DoDrawText(var Rect: TRect; Flags: Longint; Text: String);
    procedure DoDrawNormalText(DC: HDC; const Text: UnicodeString;
      var TextRect: TRect; TextFlags: Cardinal);
    procedure SetShowAccelChar(const Value: Boolean);
    procedure SetTransparent(const Value: Boolean);
    procedure SetWordWrap(const Value: Boolean);
    procedure SetEllipsisPosition(const Value: TEllipsisPosition);
    procedure SetLayout(const Value: TTextLayout);
    procedure SetAlignment(const Value: TAlignment);
    procedure SetLeftIndent(const Value: Integer);
    procedure SetTopIndent(const Value: Integer);
    procedure SetRightIndent(const Value: Integer);
    procedure SetBottomIndent(const Value: Integer);
    procedure AdjustBounds; dynamic;
    procedure SetAutoSize(const Value: Boolean);
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
  protected
    { Protected declarations }
    FLeftIndent: Integer;
    FTopIndent: Integer;
    FRightIndent: Integer;
    FBottomIndent: Integer;
    FAutoSize: Boolean;
    procedure PaintText(ACanvas: TCanvas; ARect: TRect);
    procedure Paint; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property ShowAccelChar: Boolean read FShowAccelChar write SetShowAccelChar;
    property Transparent: Boolean read FTransparent write SetTransparent;
    property WordWrap: Boolean read FWordWrap write SetWordWrap;
    property EllipsisPosition: TEllipsisPosition read FEllipsisPosition write SetEllipsisPosition;
    property Layout: TTextLayout read FLayout write SetLayout;
    property Alignment: TAlignment read FAlignment write SetAlignment;
    property LeftIndent: Integer read FLeftIndent write SetLeftIndent;
    property TopIndent: Integer read FTopIndent write SetTopIndent;
    property RightIndent: Integer read FRightIndent write SetRightIndent;
    property BottomIndent: Integer read FBottomIndent write SetBottomIndent;
    property AutoSize: Boolean read FAutoSize write SetAutoSize;
    property ParentColor;
    property Color;
    property Caption;
    property Font;
    property Align;
    property ParentFont;
    property TabOrder;
    property ParentBackground;
    property OnClick;
    property Hint;
  published
    { Published declarations }
  end;

//procedure Register;

implementation

//procedure Register;
//begin
//  RegisterComponents('AX Comps', [TaxCustomControl]);
//end;

{ TaxCustomControl }

procedure TaxCustomControl.PaintText(ACanvas: TCanvas; ARect: TRect);
const
  Alignments: array[TAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
  WordWraps: array[Boolean] of Word = (0, DT_WORDBREAK);
var
  CalcRect: TRect;
  DrawStyle: Longint;
begin
  with ACanvas do
  begin
    ARect := ClientRect;
    if not FTransparent then
    begin
      Brush.Color := Color;
      Brush.Style := bsSolid;
//      if not (csGlassPaint in ControlState) then
        FillRect(ARect)
//      else
//        FillGlassRect(ACanvas, ARect);
    end
    else
       Brush.Style := bsClear;

    { DoDrawText takes care of BiDi alignments }
    DrawStyle := DT_EXPANDTABS or WordWraps[FWordWrap] or Alignments[FAlignment];
    { Calculate vertical layout }

    SetRect(ARect, ARect.Left   + FLeftIndent,
                   ARect.Top    + FTopIndent,
                   ARect.Right  - FRightIndent,
                   ARect.Bottom - FBottomIndent);
    if FLayout <> tlTop then
    begin
      CalcRect := ARect;
      DoDrawText(CalcRect, DrawStyle or DT_CALCRECT, Caption);
      if FLayout = tlBottom then
         OffsetRect(ARect, 0, Height - CalcRect.Bottom)
      else
         OffsetRect(ARect, 0, (Height - CalcRect.Bottom) div 2);
    end;
    DoDrawText(ARect, DrawStyle, Caption);
  end;
end;

procedure TaxCustomControl.DoDrawText(var Rect: TRect; Flags: Integer; Text: String);
const
  EllipsisStr = '...';
  Ellipsis: array[TEllipsisPosition] of Longint = (0, DT_PATH_ELLIPSIS, DT_END_ELLIPSIS, DT_WORD_ELLIPSIS);
var
  DText: string;
  NewRect: TRect;
  Height, Delim: Integer;
begin
  if (Flags and DT_CALCRECT <> 0) and
     ((Text = '') or FShowAccelChar and (Text[1] = '&') and (Length(Text) = 1)) then
    Text := Text + ' ';

  if Text <> '' then
  begin
    if not FShowAccelChar then
       Flags := Flags or DT_NOPREFIX;

    Flags := DrawTextBiDiModeFlags(Flags);
    Canvas.Font := Font;
    if (FEllipsisPosition <> epNone) and not FAutoSize then
    begin
      DText := Text;
      Flags := Flags and not DT_EXPANDTABS;
      Flags := Flags or Ellipsis[epEndEllipsis];
      if FWordWrap and (FEllipsisPosition in [epEndEllipsis, epWordEllipsis]) then
      begin
        repeat
          NewRect := Rect;
          Dec(NewRect.Right, Canvas.TextWidth(EllipsisStr));
          DoDrawNormalText(Canvas.Handle, DText, NewRect, Flags or DT_CALCRECT);
          Height := NewRect.Bottom - NewRect.Top;
          if (Height > Rect.Bottom) and (Height > Canvas.Font.Height) then
          begin
            Delim := LastDelimiter(' '#9, Text);
            if Delim = 0 then
               Delim := Length(Text);
            Dec(Delim);
  {$IF NOT DEFINED(CLR)}
            if ByteType(Text, Delim) = mbLeadByte then
              Dec(Delim);
  {$ENDIF}
            Text := Copy(Text, 1, Delim);
            DText := Text + EllipsisStr;
            if Text = '' then
              Break;
          end else
            Break;
        until False;
      end;
      if Text <> '' then
         Text := DText;
    end;
    if Enabled then
       DoDrawNormalText(Canvas.Handle, Text, Rect, Flags)
    else
    begin
      OffsetRect(Rect, 1, 1);
      Canvas.Font.Color := clBtnHighlight;
      DoDrawNormalText(Canvas.Handle, Text, Rect, Flags);
      OffsetRect(Rect, -1, -1);
      Canvas.Font.Color := clBtnShadow;
      DoDrawNormalText(Canvas.Handle, Text, Rect, Flags);
    end;
  end;
end;

procedure TaxCustomControl.Paint;
var
  LRect: TRect;
begin
  with Canvas do
  begin
    LRect := ClientRect;
    PaintText(Canvas, LRect);
  end;
end;

procedure TaxCustomControl.SetAlignment(const Value: TAlignment);
begin
  if Value <> FAlignment then
  begin
    FAlignment := Value;
    Invalidate;
  end;
end;

procedure TaxCustomControl.SetAutoSize(const Value: Boolean);
begin
  if Value <> FAutoSize then
  begin
     FAutoSize := Value;
     FEllipsisPosition := epNone;
     AdjustBounds;
  end;
end;

procedure TaxCustomControl.SetBottomIndent(const Value: Integer);
begin
  if Value <> FBottomIndent then
  begin
    FBottomIndent := Value;
    Invalidate;
  end;
end;

//procedure TaxCustomControl.SetColor(const Value: TColor);
//begin
//  if Value <> FColor then
//  begin
//    FColor := Value;
//    Invalidate;
//  end;
//end;

procedure TaxCustomControl.SetEllipsisPosition(const Value: TEllipsisPosition);
begin
  if Value <> FEllipsisPosition then
  begin
    FEllipsisPosition := Value;
    Invalidate;
  end;
end;

//procedure TaxCustomControl.SetFont(const Value: TFont);
//begin
//  if Value <> FFont then
//  begin
//    FFont.Assign(Value);
//    Invalidate;
//  end;
//end;

procedure TaxCustomControl.SetLayout(const Value: TTextLayout);
begin
  if Value <> FLayout then
  begin
    FLayout := Value;
    Invalidate;
  end;
end;

procedure TaxCustomControl.SetLeftIndent(const Value: Integer);
begin
  if Value <> FLeftIndent then
  begin
    FLeftIndent := Value;
    Invalidate;
  end;
end;

procedure TaxCustomControl.SetRightIndent(const Value: Integer);
begin
  if Value <> FRightIndent then
  begin
    FRightIndent := Value;
    Invalidate;
  end;
end;

procedure TaxCustomControl.SetShowAccelChar(const Value: Boolean);
begin
  if Value <> FShowAccelChar then
  begin
    FShowAccelChar := Value;
    Invalidate;
  end;
end;

//procedure TaxCustomControl.SetText(const Value: WideString);
//begin
//  if Value <> FText then
//  begin
//    FText := Value;
//    Invalidate;
//  end;
//end;

procedure TaxCustomControl.SetTopIndent(const Value: Integer);
begin
  if Value <> FTopIndent then
  begin
    FTopIndent := Value;
    Invalidate;
  end;
end;

procedure TaxCustomControl.SetTransparent(const Value: Boolean);
begin
  if Value <> FTransparent then
  begin
    FTransparent := Value;
    Invalidate;
  end;
end;

procedure TaxCustomControl.SetWordWrap(const Value: Boolean);
begin
  if Value <> FWordWrap then
  begin
    FWordWrap := Value;
    AdjustBounds;
    Invalidate;
  end;
end;

procedure TaxCustomControl.AdjustBounds;
const
  WordWraps: array[Boolean] of Word = (0, DT_WORDBREAK);
var
  DC: HDC;
  X: Integer;
  Rect: TRect;
  AAlignment: TAlignment;
  iBottom: Integer;
begin
  if not (csReading in ComponentState) and FAutoSize then
  begin
    Rect := ClientRect;
    DC := GetDC(0);
    try
      Canvas.Handle := DC;
      DoDrawText(Rect, (DT_EXPANDTABS or DT_CALCRECT or MASK_TF_COMPOSITED) or WordWraps[FWordWrap], Caption);
      Canvas.Handle := 0;
    finally
      ReleaseDC(0, DC);
    end;
    X := Left;
    AAlignment := FAlignment;
    if UseRightToLeftAlignment then
       ChangeBiDiModeAlignment(AAlignment);
    if AAlignment = taRightJustify then
       Inc(X, Width - Rect.Right);

    iBottom := Rect.Bottom + FBottomIndent;
    if iBottom < 32 then
       iBottom := 35;

    SetBounds(X, Top, Rect.Right, iBottom);
  end;
end;

procedure TaxCustomControl.CMFontChanged(var Message: TMessage);
begin
  inherited;
  AdjustBounds;
end;

procedure TaxCustomControl.CMTextChanged(var Message: TMessage);
begin
  Invalidate;
  AdjustBounds;
end;

constructor TaxCustomControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FLeftIndent := 0;
  FTopIndent := 0;
  FRightIndent := 0;
  FBottomIndent := 0;
  ParentColor := False;
  ParentFont := True;
  ParentBackground := False;
  Color := clWindow;
  Width := 75;
  Height := 35;
end;

destructor TaxCustomControl.Destroy;
begin

  inherited Destroy;
end;

procedure TaxCustomControl.DoDrawNormalText(DC: HDC; const Text: UnicodeString;
  var TextRect: TRect; TextFlags: Cardinal);
begin
  DrawTextW(DC, Text, Length(Text), TextRect, TextFlags);
end;

end.
