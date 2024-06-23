unit Gobt_BlockProgressBar;

interface

uses
  Classes, Windows, Forms, Dialogs, Controls, Graphics, Messages, ExtCtrls,
  SysUtils, Math;

const

  MAJ_VER = 1; // Major version nr.
  MIN_VER = 3; // Minor version nr.
  REL_VER = 6; // Release nr.
  BLD_VER = 15; // Build nr.

type
  TGradientDirection = (gdHorizontal, gdVertical);

  TBlockAppearance = class(TPersistent)
  private
    FSteps: Integer;
    FDirection: TGradientDirection;
    FOnChange: TNotifyEvent;
    FBorderColor: TColor;
    FBackGroundColor: TColor;
    FBlockColor: TColor;
    FBlockColorTo: TColor;
    FBlockColorActive: TColor;
    FBlockColorActiveTo: TColor;
    FBlockBorderColor: TColor;
    FBlockBorderColorActive: TColor;
    procedure SetBlockColor(const Value: TColor);
    procedure SetBlockColorTo(const Value: TColor);
    procedure SetDirection(const Value: TGradientDirection);
    procedure SetSteps(const Value: Integer);
    procedure Changed;
    procedure SetBlockBorderColor(const Value: TColor);
    procedure SetBackGroundColor(const Value: TColor);
    procedure SetBlockBorderColorActive(const Value: TColor);
    procedure SetBlockColorActive(const Value: TColor);
    procedure SetBlockColorActiveTo(const Value: TColor);
    procedure SetBorderColor(const Value: TColor);
  protected
    property Steps: Integer read FSteps write SetSteps default 64;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  public
    constructor Create;
    procedure Assign(Source: TPersistent); override;
  published
    property BackGroundColor: TColor read FBackGroundColor write SetBackGroundColor default clNone;
    property BorderColor: TColor read FBorderColor write SetBorderColor default clNone;
    property BlockBorderColor: TColor read FBlockBorderColor write SetBlockBorderColor default clNone;
    property BlockBorderColorActive: TColor read FBlockBorderColorActive write SetBlockBorderColorActive default $00EECF00;
    property BlockColor: TColor read FBlockColor write SetBlockColor default clAqua;
    property BlockColorTo: TColor read FBlockColorTo write SetBlockColorTo default clNone;
    property BlockColorActive: TColor read FBlockColorActive write SetBlockColorActive default clNone;
    property BlockColorActiveTo: TColor read FBlockColorActiveTo write SetBlockColorActiveTo default clNone;
    property Direction: TGradientDirection read FDirection write SetDirection default gdHorizontal;
  end;

  {$IFDEF DELPHIXE2_LVL}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
  {$ENDIF}
  TGoBlockProgressBar = class(TGraphicControl)
  private
    FOnMouseLeave: TNotifyEvent;
    FOnMouseEnter: TNotifyEvent;
    FBlockCount: Integer;
    FAppearance: TBlockAppearance;
    FPadding: Integer;
    FTimer: TTimer;
    FBlockHeight: Integer;
    FBlockWidth: Integer;
    FCol: Integer;
    FRow: Integer;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure OnAppearanceChanged(Sender: TObject);
    procedure OnTimer(Sender: TObject);
    function GetVersion: string;
    procedure SetVersion(const Value: string);
    procedure SetAppearance(const Value: TBlockAppearance);
    procedure SetBlockCount(const Value: Integer);
    procedure SetPadding(const Value: Integer);
    function GetInterval: Cardinal;
    procedure SetInterval(const Value: Cardinal);
  protected
    procedure Loaded; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Paint; override;
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;

    procedure DrawBlock(ACol, ARow: Integer);
    procedure DrawBlocks;

    procedure UpdateBlockSize;
    function GetBlocksRect: TRect;
    function GetBlockRect(ACol, ARow: Integer): TRect;
    procedure InvalidateBlock(ACol, ARow: Integer);

    procedure IncreaseByOne;
    property BlockCount: Integer read FBlockCount write SetBlockCount;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    function GetVersionNr: Integer;
    procedure Step;
  published
    property Align;
    property Anchors;
    property Constraints;
    property Enabled;
    property Font;
    property ParentFont;
    property ParentShowHint;
    property ParentBiDiMode;
    property PopupMenu;
    property ShowHint;
    property Visible;
    property Version: string read GetVersion write SetVersion stored false;
    property Appearance: TBlockAppearance read FAppearance write SetAppearance;
    property Padding: Integer read FPadding write SetPadding;
    property Interval: Cardinal read GetInterval write SetInterval default 120;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
  end;


implementation

//----------------------------------------------------------------- DrawGradient

procedure DrawGradient(Canvas: TCanvas; FromColor, ToColor: TColor; Steps: Integer; R: TRect; Direction: Boolean);
var
  diffr, startr, endr: Integer;
  diffg, startg, endg: Integer;
  diffb, startb, endb: Integer;
  rstepr, rstepg, rstepb, rstepw: Real;
  i, stepw: Word;

begin
  if Direction then
    R.Right := R.Right - 1
  else
    R.Bottom := R.Bottom - 1;

  if Steps = 0 then
    Steps := 1;

  FromColor := ColorToRGB(FromColor);
  ToColor := ColorToRGB(ToColor);

  startr := (FromColor and $0000FF);
  startg := (FromColor and $00FF00) shr 8;
  startb := (FromColor and $FF0000) shr 16;
  endr := (ToColor and $0000FF);
  endg := (ToColor and $00FF00) shr 8;
  endb := (ToColor and $FF0000) shr 16;

  diffr := endr - startr;
  diffg := endg - startg;
  diffb := endb - startb;

  rstepr := diffr / steps;
  rstepg := diffg / steps;
  rstepb := diffb / steps;

  if Direction then
    rstepw := (R.Right - R.Left) / Steps
  else
    rstepw := (R.Bottom - R.Top) / Steps;

  with Canvas do
  begin
    for i := 0 to steps - 1 do
    begin
      endr := startr + Round(rstepr * i);
      endg := startg + Round(rstepg * i);
      endb := startb + Round(rstepb * i);
      stepw := Round(i * rstepw);
      Pen.Color := endr + (endg shl 8) + (endb shl 16);
      Brush.Color := Pen.Color;
      if Direction then
        Rectangle(R.Left + stepw, R.Top, R.Left + stepw + Round(rstepw) + 1, R.Bottom)
      else
        Rectangle(R.Left, R.Top + stepw, R.Right, R.Top + stepw + Round(rstepw) + 1);
    end;
  end;
end;

//------------------------------------------------------------------------------

{ TSplitterAppearance }

constructor TBlockAppearance.Create;
begin
  inherited;
  FBlockColor := $00EECF00;
  FBlockColorTo := clNone;
  FBlockColorActive := clNone;
  FBlockColorActiveTo := clNone;
  FBlockBorderColor := clNone;
  FBlockBorderColorActive := clNone;
  FBorderColor := clNone;
  FBackGroundColor := clNone; // Transparent
  FSteps := 64;
  FDirection := gdHorizontal;
end;

//------------------------------------------------------------------------------

procedure TBlockAppearance.Assign(Source: TPersistent);
begin
  if (Source is TBlockAppearance) then
  begin
    FBlockBorderColor := (Source as TBlockAppearance).BlockBorderColor;
    FBlockColor := (Source as TBlockAppearance).BlockColor;
    FBlockColorTo := (Source as TBlockAppearance).BlockColorTo;
    FBlockBorderColorActive := (Source as TBlockAppearance).BlockBorderColorActive;
    FBlockColorActive := (Source as TBlockAppearance).BlockColorActive;
    FBlockColorActiveTo := (Source as TBlockAppearance).BlockColorActiveTo;
    FBorderColor := (Source as TBlockAppearance).BorderColor;
    FBackGroundColor := (Source as TBlockAppearance).BackGroundColor;
    FDirection := (Source as TBlockAppearance).Direction;
    FSteps := (Source as TBlockAppearance).Steps;
  end;
end;

//------------------------------------------------------------------------------

procedure TBlockAppearance.Changed;
begin
  if Assigned(OnChange) then
    OnChange(Self);
end;

//------------------------------------------------------------------------------

procedure TBlockAppearance.SetDirection(
  const Value: TGradientDirection);
begin
  if (FDirection <> Value) then
  begin
    FDirection := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TBlockAppearance.SetSteps(const Value: Integer);
begin
  if (FSteps <> Value) then
  begin
    FSteps := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TBlockAppearance.SetBorderColor(const Value: TColor);
begin
  if (FBorderColor <> Value) then
  begin
    FBorderColor := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TBlockAppearance.SetBackGroundColor(const Value: TColor);
begin
  if (FBackGroundColor <> Value) then
  begin
    FBackGroundColor := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TBlockAppearance.SetBlockBorderColor(const Value: TColor);
begin
  if (FBlockBorderColor <> Value) then
  begin
    FBlockBorderColor := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TBlockAppearance.SetBlockBorderColorActive(
  const Value: TColor);
begin
  if (FBlockBorderColorActive <> Value) then
  begin
    FBlockBorderColorActive := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TBlockAppearance.SetBlockColor(const Value: TColor);
begin
  if (FBlockColor <> Value) then
  begin
    FBlockColor := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TBlockAppearance.SetBlockColorActive(const Value: TColor);
begin
  if (FBlockColorActive <> Value) then
  begin
    FBlockColorActive := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TBlockAppearance.SetBlockColorActiveTo(const Value: TColor);
begin
  if (FBlockColorActiveTo <> Value) then
  begin
    FBlockColorActiveTo := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TBlockAppearance.SetBlockColorTo(const Value: TColor);
begin
  if (FBlockColorTo <> Value) then
  begin
    FBlockColorTo := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

constructor TGoBlockProgressBar.Create(AOwner: TComponent);
begin
  inherited;
  FBlockCount := 3;
  FPadding := 4;
  FAppearance := TBlockAppearance.Create;
  FAppearance.OnChange := OnAppearanceChanged;
  FTimer := TTimer.Create(Self);
  FTimer.Enabled := False;
  FTimer.Interval := 120;
  FTimer.OnTimer := OnTimer;
  FBlockHeight := 0;
  FBlockWidth := 0;
  FCol := FBlockCount - 1;
  FRow := FBlockCount - 1;
  Width := 50;
  Height := 50;
end;

//------------------------------------------------------------------------------

destructor TGoBlockProgressBar.Destroy;
begin
  FAppearance.Free;
  if Assigned(FTimer) then
    FTimer.Free;
  inherited;
end;

//------------------------------------------------------------------------------

procedure TGoBlockProgressBar.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  FTimer.Enabled := Enabled;
end;

//------------------------------------------------------------------------------

procedure TGoBlockProgressBar.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  if Assigned(FOnMouseEnter) then
  begin
    FOnMouseEnter(Self);
  end;  
end;

//------------------------------------------------------------------------------

procedure TGoBlockProgressBar.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  if Assigned(FOnMouseLeave) then
  begin
    FOnMouseLeave(Self);
  end;
end;

//------------------------------------------------------------------------------

function TGoBlockProgressBar.GetVersionNr: Integer;
begin
  Result := MakeLong(MakeWord(BLD_VER,REL_VER),MakeWord(MIN_VER,MAJ_VER));
end;

//------------------------------------------------------------------------------

procedure TGoBlockProgressBar.Loaded;
begin
  inherited;
  UpdateBlockSize;
  if not (csDesigning in ComponentState) then
  begin
    FCol := FBlockCount-1;
    FRow := FBlockCount-1;
    FTimer.Enabled := Enabled;
  end;
end;

//------------------------------------------------------------------------------

procedure TGoBlockProgressBar.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;

end;

//------------------------------------------------------------------------------

procedure TGoBlockProgressBar.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;

end;

//------------------------------------------------------------------------------

procedure TGoBlockProgressBar.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;

end;

//------------------------------------------------------------------------------

procedure TGoBlockProgressBar.Notification(AComponent: TComponent;
  AOperation: TOperation);
begin
  inherited;

end;

//------------------------------------------------------------------------------

procedure TGoBlockProgressBar.Paint;
begin
  inherited;
  if (Appearance.BackGroundColor <> clNone) then
  begin
    Canvas.Brush.Color := Appearance.BackGroundColor;
    Canvas.Pen.Color := Appearance.BackGroundColor;
    Canvas.Rectangle(ClientRect);
  end;

  if (Appearance.BorderColor <> clNone) then
  begin
    Canvas.Brush.Style := bsClear;
    Canvas.Pen.Color := Appearance.BorderColor;
    Canvas.Rectangle(ClientRect);
  end;

  DrawBlocks;
end;

//------------------------------------------------------------------------------

procedure TGoBlockProgressBar.SetBounds(ALeft, ATop, AWidth,
  AHeight: Integer);
begin
  inherited;
  UpdateBlockSize;
end;

//------------------------------------------------------------------------------

function TGoBlockProgressBar.GetVersion: string;
var
  vn: Integer;
begin
  vn := GetVersionNr;
  Result := IntToStr(Hi(Hiword(vn)))+'.'+IntToStr(Lo(Hiword(vn)))+'.'+IntToStr(Hi(Loword(vn)))+'.'+IntToStr(Lo(Loword(vn)));
end;

//------------------------------------------------------------------------------

procedure TGoBlockProgressBar.SetVersion(const Value: string);
begin

end;

procedure TGoBlockProgressBar.Step;
begin
  IncreaseByOne;
end;

//------------------------------------------------------------------------------

procedure TGoBlockProgressBar.SetAppearance(const Value: TBlockAppearance);
begin
  FAppearance.Assign(Value);
end;

//------------------------------------------------------------------------------

procedure TGoBlockProgressBar.SetBlockCount(const Value: Integer);
begin
  if (FBlockCount <> Value) and (Value > 1) then
  begin
    FBlockCount := Value;
    UpdateBlockSize;
  end;
end;

//------------------------------------------------------------------------------

procedure TGoBlockProgressBar.OnAppearanceChanged(Sender: TObject);
begin
  Invalidate;
end;

//------------------------------------------------------------------------------

procedure TGoBlockProgressBar.DrawBlock(ACol, ARow: Integer);
var
  R: TRect;
  clr, ClrTo, BrClr: TColor;
begin
  if (ACol >= FBlockCount) or (ARow >= FBlockCount) then
    Exit;

  if (ACol = FCol) and (ARow = FRow) then
  begin
    Clr := Appearance.BlockColorActive;
    ClrTo := Appearance.BlockColorActiveTo;
    BrClr := Appearance.BlockBorderColorActive;
  end
  else
  begin
    Clr := Appearance.BlockColor;
    ClrTo := Appearance.BlockColorTo;
    BrClr := Appearance.BlockBorderColor;
  end;

  R := GetBlockRect(ACol, ARow);
  if (ClrTo <> clNone) then
  begin
    DrawGradient(Canvas, Clr, ClrTo, Appearance.Steps, R, Appearance.Direction = gdHorizontal);
  end
  else if (Clr <> clNone) then
  begin
    Canvas.Brush.Color := Clr;
    Canvas.Pen.Color := Clr;
    Canvas.Rectangle(R);
  end;

  if (BrClr <> clNone) then
  begin
    Canvas.Brush.Style := bsClear;
    Canvas.Pen.Color := BrClr;
    Canvas.Rectangle(R);
  end;
end;

//------------------------------------------------------------------------------

procedure TGoBlockProgressBar.DrawBlocks;
var
  c, r: Integer;
begin
  for c := 0 to FBlockCount-1 do
  begin
    for r := 0 to FBlockCount-1 do
    begin
      DrawBlock(c, r);
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TGoBlockProgressBar.UpdateBlockSize;
var
  R: TRect;
begin
  R := GetBlocksRect;
  FBlockWidth := ((R.Right - R.Left) - ((FBlockCount-1) * Padding)) div FBlockCount;
  FBlockHeight := ((R.Bottom - R.Top) - ((FBlockCount-1) * Padding)) div FBlockCount;
end;

//------------------------------------------------------------------------------

function TGoBlockProgressBar.GetBlockRect(ACol, ARow: Integer): TRect;
begin
  Result := Rect(-1, -1, -1, -1);
  if (ACol < FBlockCount) and (ARow < FBlockCount) then
  begin
    Result := GetBlocksRect;
    Result.Left := Result.Right -  (ACol * FPadding) - ((ACol+1) * FBlockWidth);
    Result.Right := Result.Left + FBlockWidth;
    Result.Top := Result.Bottom -  (ARow * FPadding) - ((ARow+1) * FBlockHeight);
    Result.Bottom := Result.Top + FBlockHeight;
  end;
end;

//------------------------------------------------------------------------------

function TGoBlockProgressBar.GetBlocksRect: TRect;
begin
  Result := ClientRect;
  InflateRect(Result, -2, -2);
  if (Appearance.BorderColor <> clNone) then
  begin
    InflateRect(Result, -1, -1);
  end;
end;

//------------------------------------------------------------------------------

procedure TGoBlockProgressBar.SetPadding(const Value: Integer);
begin
  if (FPadding <> Value) and (Value > 0) then
  begin
    FPadding := Value;
    UpdateBlockSize;
    Invalidate;
  end;
end;

//------------------------------------------------------------------------------

procedure TGoBlockProgressBar.WMSize(var Message: TWMSize);
begin
  inherited;
end;

//------------------------------------------------------------------------------

procedure TGoBlockProgressBar.OnTimer(Sender: TObject);
begin
  IncreaseByOne;
end;

//------------------------------------------------------------------------------

function TGoBlockProgressBar.GetInterval: Cardinal;
begin
  if Assigned(FTimer) then
  begin
    Result := FTimer.Interval;
  end
  else
  begin
    Result := 0;
  end;
end;

//------------------------------------------------------------------------------

procedure TGoBlockProgressBar.SetInterval(const Value: Cardinal);
begin
  if Assigned(FTimer) and (FTimer.Interval <> Value) then
  begin
    FTimer.Interval := Value;
  end;
end;

//------------------------------------------------------------------------------

procedure TGoBlockProgressBar.IncreaseByOne;
var
  OldC, Oldr: Integer;
begin
  OldC := FCol;
  OldR := FRow;

  if (FRow = FBlockCount-1) then
  begin
    if (FCol > 0) then
    begin
      Dec(FCol);
    end
    else
    begin
      Dec(FRow);
    end;
    {Dec(FCol);
    if (FCol < 0) then
    begin
      FCol := 0;
      if (FRow > 0) then
      begin
        Dec(FRow);
      end;
    end;}
  end
  else if (FCol = 0) then
  begin
    if (FRow > 0) then
    begin
      Dec(FRow);
    end
    else
    begin
      Inc(FCol);
    end;
  end
  else if (FRow = 0) then
  begin
    if (FCol < FBlockCount-1) then
    begin
      Inc(FCol);
    end
    else
    begin
      Inc(FRow);
    end;
    {Inc(FCol);
    if (FCol >= FBlockCount) then
    begin
      FCol := FBlockCount-1;
      Inc(FRow);
    end;}
  end
  else if (FCol = FBlockCount-1) then
  begin
    if (FRow < FBlockCount-1) then
    begin
      Inc(FRow);
    end
    else
    begin
      Dec(FCol);
    end;
  end;

  InvalidateBlock(OldC, OldR);
  InvalidateBlock(FCol, FRow);
end;

//------------------------------------------------------------------------------


procedure TGoBlockProgressBar.InvalidateBlock(ACol, ARow: Integer);
var
  R: TRect;
  rgn: HRGN;
begin
  R := GetBlockRect(ACol, ARow);
  rgn := CreateRectRgn(R.Left, R.Top, R.Right, R.Bottom);
  SelectClipRgn(Canvas.Handle, rgn);
  Invalidate;
  SelectClipRgn(Canvas.Handle, 0);
  DeleteObject(Rgn);
end;


end.
