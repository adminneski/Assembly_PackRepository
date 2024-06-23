{***************************************************************************}
{ TAdvBadge component                                                       }
{ for Delphi & C++Builder                                                   }
{                                                                           }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright � 2015                                               }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{                                                                           }
{ The source code is given as is. The author is not responsible             }
{ for any possible damage done due to the use of this code.                 }
{ The component can be freely used in any application. The complete         }
{ source code remains property of the author and may not be distributed,    }
{ published, given or sold in any form as such. No parts of the source      }
{ code can be included in any other component or application without        }
{ written authorization of the author.                                      }
{***************************************************************************}

unit Gobt_Badge;

interface

uses
  Windows, Classes, Messages, Controls, Graphics, StdCtrls, Buttons,
  Gobt_ButtonAdvanced;

const
  MAJ_VER = 1; // Major version nr.
  MIN_VER = 1; // Minor version nr.
  REL_VER = 0; // Release nr.
  BLD_VER = 0; // Build nr.

  // version history
  // v1.0.0.0 : First release
  // v1.0.0.1 : Fixed : Issue with badge size initialization
  // v1.0.0.2 : Improved : badge text vertical positioning
  // v1.0.0.3 : Fixed : Issue with setting badge at runtime with modified badge color
  // v1.1.0.0 : New : TAdvMetroTile added

type
  TGobtBadge = class(TCustomControl)
  private
    FColor: TColor;
    FText: string;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure SetColor(const Value: TColor);
    procedure SetText(const Value: string);
  protected
    procedure Paint; override;
    procedure CreateWnd; override;
    procedure DoSetRegion;
    procedure DoMeasure; virtual;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Color: TColor read FColor write SetColor default clRed;
    property Font;
    property Text: string read FText write SetText;
    property OnClick;
  end;

  TGobt_BadgeButton = class(TButton)
  private
    FBadgeCtrl: TGobtBadge;
    FBadgeColor: TColor;
    FBadge: string;
    FBadgeTextColor: TColor;
    FOnBadgeClick: TNotifyEvent;
    procedure SetBadge(const Value: string);
    procedure SetBadgeColor(const Value: TColor);
    procedure SetBadgeTextColor(const Value: TColor);
    procedure CreateBadge;
    procedure UpdateBadge;
    procedure BadgeClick(Sender: TObject);
  protected
    procedure DoBadgeClick; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
  published
    property Badge: string read FBadge write SetBadge;
    property BadgeColor: TColor read FBadgeColor write SetBadgeColor default clRed;
    property BadgeTextColor: TColor read FBadgeTextColor write SetBadgeTextColor default clWhite;
    property OnBadgeClick: TNotifyEvent read FOnBadgeClick write FOnBadgeClick;
  end;

  TGobt_BadgeLabel = class(TStaticText)
  private
    FBadgeCtrl: TGobtBadge;
    FBadgeColor: TColor;
    FBadge: string;
    FBadgeTextColor: TColor;
    FOnBadgeClick: TNotifyEvent;
    procedure SetBadge(const Value: string);
    procedure SetBadgeColor(const Value: TColor);
    procedure SetBadgeTextColor(const Value: TColor);
    procedure CreateBadge;
    procedure UpdateBadge;
    procedure BadgeClick(Sender: TObject);
  protected
    procedure DoBadgeClick; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
  published
    property Badge: string read FBadge write SetBadge;
    property BadgeColor: TColor read FBadgeColor write SetBadgeColor default clRed;
    property BadgeTextColor: TColor read FBadgeTextColor write SetBadgeTextColor default clWhite;
    property OnBadgeClick: TNotifyEvent read FOnBadgeClick write FOnBadgeClick;
  end;

  TGobt_BadgeSpeedButton = class(TSpeedButton)
  private
    FBadgeCtrl: TGobtBadge;
    FBadgeColor: TColor;
    FBadge: string;
    FBadgeTextColor: TColor;
    FOnBadgeClick: TNotifyEvent;
    procedure SetBadge(const Value: string);
    procedure SetBadgeColor(const Value: TColor);
    procedure SetBadgeTextColor(const Value: TColor);
    procedure CreateBadge;
    procedure UpdateBadge;
    procedure BadgeClick(Sender: TObject);
  protected
    procedure DoBadgeClick; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
  published
    property Badge: string read FBadge write SetBadge;
    property BadgeColor: TColor read FBadgeColor write SetBadgeColor default clRed;
    property BadgeTextColor: TColor read FBadgeTextColor write SetBadgeTextColor default clWhite;
    property OnBadgeClick: TNotifyEvent read FOnBadgeClick write FOnBadgeClick;
  end;


implementation

uses
  EXGDIP, SysUtils;

type
  TWinCtrl = class(TWinControl)
  public
    procedure PaintCtrls(DC: HDC; First: TControl);
  end;

{ TGobtBadge }

procedure TGobtBadge.CMFontChanged(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

constructor TGobtBadge.Create(AOwner: TComponent);
begin
  inherited;
  Width := 20;
  Height := 20;
  FColor := clRed;
  Text := '1';
  Font.Color := clWhite;
  DoubleBuffered := true;
end;

procedure TGobtBadge.CreateWnd;
begin
  inherited;
  DoMeasure;
  DoSetRegion;
end;

procedure TGobtBadge.DoMeasure;
var
  graphics: TGPGraphics;
  gpfont: TGPFont;
  sf: TGPStringFormat;
  sizer: TGPRectF;
  NewWidth, NewHeight: integer;
begin
  if HandleAllocated then
  begin
    graphics := TGPGraphics.Create(Canvas.Handle);
    graphics.SetSmoothingMode(SmoothingModeAntiAlias);
    graphics.SetTextRenderingHint(TextRenderingHintClearTypeGridFit);

    gpfont := graphics.MakeFont(Font);

    sf := TGPStringFormat.Create(0);

    graphics.MeasureString(Text, Length(Text), gpFont, MakePointF(0, 0), sf, sizer);

    NewWidth := Round(sizer.Width + sizer.Width/5);
    NewHeight := Round(sizer.Height + sizer.Height/5);

    if NewWidth < NewHeight then
      NewWidth := NewHeight;

    sf.Free;
    gpFont.Free;
    graphics.Free;

    if (NewWidth <> Width) or (NewHeight <> Height) then
    begin
      Width := NewWidth;
      Height := NewHeight;
      DoSetRegion;
    end;
  end;
end;

procedure TGobtBadge.DoSetRegion;
var
  rgn: THandle;
begin
  rgn := CreateRoundRectRgn(0,0,Width+1,Height+1,Round(Height/2.5),Round(Height/2.5));
//  rgn := CreateEllipticRgnIndirect(Rect(0, 0, Width + 1, Height + 1));
  SetWindowRgn(Handle, rgn, true);
  DeleteObject(rgn);
end;

procedure DrawRoundRectangle(graphic: TGPGraphics; R: TRect; Radius: Integer; Clr: TColor);
var
  path: TGPGraphicsPath;
  l, t, w, h, d: Integer;
  gpbrush: TGPBrush;
begin
  if not Assigned(graphic) then
    Exit;

  path := TGPGraphicsPath.Create;
  try
    l := R.Left;
    t := R.Top;
    w := R.Right;
    h := R.Bottom;
    d := Radius shl 1;
    path.AddArc(l, t, d, d, 180, 90); // topleft
    path.AddLine(l + radius, t, l + w - radius, t); // top
    path.AddArc(l + w - d, t, d, d, 270, 90); // topright
    path.AddLine(l + w, t + radius, l + w, t + h - radius); // right
    path.AddArc(l + w - d, t + h - d, d, d, 0, 90); // bottomright
    path.AddLine(l + w - radius, t + h, l + radius, t + h); // bottom
    path.AddArc(l, t + h - d, d, d, 90, 90); // bottomleft
    path.AddLine(l, t + h - radius, l, t + radius); // left
    path.CloseFigure();

    gpbrush := TGPSolidBrush.Create(MakeColor(255, Clr));

    try
      graphic.FillPath(gpbrush,path);
    finally
      gpbrush.Free;
    end;

  finally
    path.Free;
  end;
end;

procedure TGobtBadge.Paint;
var
  graphics: TGPGraphics;
  gpbrush: TGPBrush;
  gpfont: TGPFont;
  dr: TGPRectF;
  stringformat: TGPStringFormat;

begin
  graphics := TGPGraphics.Create(Canvas.Handle);

  try
    graphics.SetSmoothingMode(SmoothingModeAntiAlias);
    graphics.SetTextRenderingHint(TextRenderingHintClearTypeGridFit);

    DrawRoundRectangle(graphics, Rect(1,1,Width - 2, Height - 2), Round(Height/2.5), Color);

    gpbrush := TGPSolidBrush.Create(MakeColor(255,Font.Color));

    gpfont := graphics.MakeFont(Font);

    stringFormat := TGPStringFormat.Create(0);

    try
      dr.X := 1;
      dr.Y := 2;
      dr.Width := Width - 2;
      dr.Height := Height - 2;

      stringFormat.SetAlignment(StringAlignmentCenter);
      stringFormat.SetLineAlignment(StringAlignmentCenter);

      graphics.DrawString(Text, Length(Text), gpFont, dr, stringformat, gpbrush);

    finally
      stringformat.Free;
      gpbrush.Free;
    end;

  finally
    graphics.Free;
  end;
end;

procedure TGobtBadge.SetColor(const Value: TColor);
begin
  if (FColor <> Value) then
  begin
    FColor := Value;
    Invalidate;
  end;
end;

procedure TGobtBadge.SetText(const Value: string);
begin
  if (FText <> Value) then
  begin
    FText := Value;

    DoMeasure;

    Invalidate;
  end;
end;

procedure TGobtBadge.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
  Message.Result := 1;
end;

procedure TGobtBadge.WMPaint(var Message: TWMPaint);
var
  DC, MemDC: HDC;
  MemBitmap, OldBitmap: HBITMAP;
  PS: TPaintStruct;
  {$IFNDEF DELPHI_UNICODE}
  dbl: boolean;
  {$ENDIF}
  p: TPoint;
  i: integer;
begin
  if Assigned(Parent) then
  begin
    DC := Message.DC;
    if (DC <> 0) then
    begin
      {$IFNDEF DELPHI_UNICODE}
      dbl := Parent.DoubleBuffered;
      Parent.DoubleBuffered := false;
      {$ENDIF}
      i := SaveDC(DC);
      p := ClientOrigin;
      Windows.ScreenToClient(Parent.Handle, p);
      p.x := -p.x;
      p.y := -p.y;
      MoveWindowOrg(DC, p.x, p.y);
      SendMessage(Parent.Handle, WM_ERASEBKGND, DC, 0);
      SendMessage(Parent.Handle, WM_PAINT, DC, 0);
      if (Parent is TWinCtrl) then
        (Parent as TWinCtrl).PaintCtrls(DC, nil);
      RestoreDC(DC, i);
      {$IFNDEF DELPHI_UNICODE}
      Parent.DoubleBuffered := dbl;
      {$ENDIF}
    end;
  end;

  if not FDoubleBuffered or (Message.DC <> 0) then
  begin
    if not (csCustomPaint in ControlState) and (ControlCount = 0) then
      inherited
    else
      PaintHandler(Message);
  end
  else
  begin
    DC := GetDC(0);
    MemBitmap := CreateCompatibleBitmap(DC, ClientRect.Right, ClientRect.Bottom);
    ReleaseDC(0, DC);
    MemDC := CreateCompatibleDC(0);
    OldBitmap := SelectObject(MemDC, MemBitmap);
    try
      DC := BeginPaint(Handle, PS);
      Perform(WM_ERASEBKGND, MemDC, MemDC);
      Message.DC := MemDC;
      WMPaint(Message);
      Message.DC := 0;
      BitBlt(DC, 0, 0, ClientRect.Right, ClientRect.Bottom, MemDC, 0, 0, SRCCOPY);
      EndPaint(Handle, PS);
    finally
      SelectObject(MemDC, OldBitmap);
      DeleteDC(MemDC);
      DeleteObject(MemBitmap);
    end;
  end;
end;

{ TWinCtrl }

procedure TWinCtrl.PaintCtrls(DC: HDC; First: TControl);
begin
  PaintControls(DC, First);
end;

{ TGobt_ButtonBadge }

procedure TGobt_BadgeButton.BadgeClick(Sender: TObject);
begin
  DoBadgeClick;
end;

constructor TGobt_BadgeButton.Create(AOwner: TComponent);
begin
  inherited;
  FBadge := '';
  FBadgeColor := clRed;
  FBadgeTextColor := clWhite;
  FBadgeCtrl := nil;
end;

procedure TGobt_BadgeButton.CreateBadge;
begin
  FBadgeCtrl := TGobtBadge.Create(Self);
  FBadgeCtrl.Parent := Self.Parent;
  FBadgeCtrl.OnClick := BadgeClick;
  UpdateBadge;
end;

procedure TGobt_BadgeButton.DoBadgeClick;
begin
  if Assigned(OnBadgeClick) then
    OnBadgeClick(Self);
end;

procedure TGobt_BadgeButton.SetBadge(const Value: string);
begin
  if (FBadge <> Value) then
  begin
    FBadge := Value;
    if (Value <> '') then
    begin
      if not Assigned(FBadgeCtrl) then
        CreateBadge;
      FBadgeCtrl.Color := BadgeColor;
      FBadgeCtrl.Font.Color := BadgeTextColor;
      FBadgeCtrl.Text := Value;
    end
    else
    begin
      if Assigned(FBadgeCtrl) then
      begin
        FBadgeCtrl.Free;
        FBadgeCtrl := nil;
      end;
    end;
  end;
end;

procedure TGobt_BadgeButton.SetBadgeColor(const Value: TColor);
begin
  if (FBadgeColor <> Value) then
  begin
    FBadgeColor := Value;
    if (FBadge <> '') then
    begin
      if not Assigned(FBadgeCtrl) then
        CreateBadge;
      FBadgeCtrl.Color := Value;
    end;
  end;
end;

procedure TGobt_BadgeButton.SetBadgeTextColor(const Value: TColor);
begin
  if (FBadgeTextColor <> Value) then
  begin
    FBadgeTextColor := Value;
    if (FBadge <> '') then
    begin
      if not Assigned(FBadgeCtrl) then
        CreateBadge;
      FBadgeCtrl.Font.Color := Value;
    end;
  end;
end;

procedure TGobt_BadgeButton.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited;
  UpdateBadge;
end;

procedure TGobt_BadgeButton.UpdateBadge;
begin
  if Assigned(FBadgeCtrl) then
  begin
    FBadgeCtrl.Left := Left + Width - 10;
    FBadgeCtrl.Top := Top - 10;
  end;
end;

{ TGobt_BadgeLabel }

procedure TGobt_BadgeLabel.BadgeClick(Sender: TObject);
begin
  DoBadgeClick;
end;

constructor TGobt_BadgeLabel.Create(AOwner: TComponent);
begin
  inherited;
  FBadge := '';
  FBadgeColor := clRed;
  FBadgeTextColor := clWhite;
  FBadgeCtrl := nil;
end;

procedure TGobt_BadgeLabel.CreateBadge;
begin
  FBadgeCtrl := TGobtBadge.Create(Self);
  FBadgeCtrl.Parent := Self.Parent;
  FBadgeCtrl.OnClick := BadgeClick;
  UpdateBadge;
end;

procedure TGobt_BadgeLabel.DoBadgeClick;
begin
  if Assigned(OnBadgeClick) then
    OnBadgeClick(Self);
end;

procedure TGobt_BadgeLabel.SetBadge(const Value: string);
begin
  if (FBadge <> Value) then
  begin
    FBadge := Value;
    if (Value <> '') then
    begin
      if not Assigned(FBadgeCtrl) then
        CreateBadge;
      FBadgeCtrl.Color := BadgeColor;
      FBadgeCtrl.Font.Color := BadgeTextColor;
      FBadgeCtrl.Text := Value;
    end
    else
    begin
      if Assigned(FBadgeCtrl) then
      begin
        FBadgeCtrl.Free;
        FBadgeCtrl := nil;
      end;
    end;
  end;
end;

procedure TGobt_BadgeLabel.SetBadgeColor(const Value: TColor);
begin
  if (FBadgeColor <> Value) then
  begin
    FBadgeColor := Value;
    if (FBadge <> '') then
    begin
      if not Assigned(FBadgeCtrl) then
        CreateBadge;
      FBadgeCtrl.Color := Value;
    end;
  end;
end;

procedure TGobt_BadgeLabel.SetBadgeTextColor(const Value: TColor);
begin
  if (FBadgeTextColor <> Value) then
  begin
    FBadgeTextColor := Value;
    if (FBadge <> '') then
    begin
      if not Assigned(FBadgeCtrl) then
        CreateBadge;
      FBadgeCtrl.Font.Color := Value;
    end;
  end;
end;

procedure TGobt_BadgeLabel.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited;
  UpdateBadge;
end;

procedure TGobt_BadgeLabel.UpdateBadge;
begin
  if Assigned(FBadgeCtrl) then
  begin
    FBadgeCtrl.Left := Left + Width - 8;
    FBadgeCtrl.Top := Top - 14;
  end;
end;

{ TGobt_BadgeSpeedButton }

procedure TGobt_BadgeSpeedButton.BadgeClick(Sender: TObject);
begin
  DoBadgeClick;
end;

constructor TGobt_BadgeSpeedButton.Create(AOwner: TComponent);
begin
  inherited;
  FBadge := '';
  FBadgeColor := clRed;
  FBadgeTextColor := clWhite;
  FBadgeCtrl := nil;
end;

procedure TGobt_BadgeSpeedButton.CreateBadge;
begin
  FBadgeCtrl := TGobtBadge.Create(Self);
  FBadgeCtrl.Parent := Self.Parent;
  FBadgeCtrl.OnClick := BadgeClick;
  UpdateBadge;
end;

procedure TGobt_BadgeSpeedButton.DoBadgeClick;
begin
  if Assigned(OnBadgeClick) then
    OnBadgeClick(Self);
end;

procedure TGobt_BadgeSpeedButton.SetBadge(const Value: string);
begin
  if (FBadge <> Value) then
  begin
    FBadge := Value;
    if (Value <> '') then
    begin
      if not Assigned(FBadgeCtrl) then
        CreateBadge;
      FBadgeCtrl.Color := BadgeColor;
      FBadgeCtrl.Font.Color := BadgeTextColor;
      FBadgeCtrl.Text := Value;
    end
    else
    begin
      if Assigned(FBadgeCtrl) then
      begin
        FBadgeCtrl.Free;
        FBadgeCtrl := nil;
      end;
    end;
  end;
end;

procedure TGobt_BadgeSpeedButton.SetBadgeColor(const Value: TColor);
begin
  if (FBadgeColor <> Value) then
  begin
    FBadgeColor := Value;
    if (FBadge <> '') then
    begin
      if not Assigned(FBadgeCtrl) then
        CreateBadge;
      FBadgeCtrl.Color := Value;
    end;
  end;
end;

procedure TGobt_BadgeSpeedButton.SetBadgeTextColor(const Value: TColor);
begin
  if (FBadgeTextColor <> Value) then
  begin
    FBadgeTextColor := Value;
    if (FBadge <> '') then
    begin
      if not Assigned(FBadgeCtrl) then
        CreateBadge;
      FBadgeCtrl.Font.Color := Value;
    end;
  end;
end;

procedure TGobt_BadgeSpeedButton.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited;
  UpdateBadge;
end;

procedure TGobt_BadgeSpeedButton.UpdateBadge;
begin
  if Assigned(FBadgeCtrl) then
  begin
    FBadgeCtrl.Left := Left + Width - 8;
    FBadgeCtrl.Top := Top - 10;
  end;
end;



end.
