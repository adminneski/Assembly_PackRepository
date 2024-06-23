{******************************************}
{                                          }
{             FastReport VCL               }
{              Support Hint                }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxHint;

interface

{$I frx.inc}

uses
{$IFDEF FPC}
  LCLIntf, LazHelper,
{$ELSE}
  Messages,
{$ENDIF}
  Forms, Types, Classes, Graphics, Controls, frUnicodeUtils, frxGraphicUtils;

const
  HINT_TEXT_SIZE_HEADER = 12;
  HINT_HEADER_PREFIX_COLOR = clMoneyGreen;
  HINT_HEADER_COLOR = $A36215;
  HINT_TEXT_SIZE = 9;
  HINT_PADDING = 10;

type

  TfrxHintShowEvent = procedure(var Msg: TCMHintShow) of object;

  TBaseHintData = class
  private
    FHeaderPrefix: String;
    FHeaderText: String;
    FMultiPaint: Boolean;
    function GetFullText: String;
  public
    constructor Create(vHeaderPrefix, vHeaderText: String; vMultiPaint: Boolean);
    property FullText: String read GetFullText;
    property HeaderPrefix: String read FHeaderPrefix;
    property HeaderText: String read FHeaderText;
    property MultiPaint: Boolean read FMultiPaint;
  end;

  TBaseHintWindow = class(THintWindow)
  protected
    FBaseHintData: TBaseHintData;
    FDrawTextHeader: TfrxDrawText;
    FDrawTextPlain: TfrxDrawText;
    FHeaderHeight: Integer;
    FHintS: String;
    procedure PaintHeader;
    procedure PaintText;
    procedure SetPlainTextOptions; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ActivateHint(vRect: TRect; const AHint: string); override;
    procedure ResetText;
    procedure SetupDrawText(FDrawText: TfrxDrawText; Color: TColor; FontSize: Integer; TopPos: Integer);
    {$IFNDEF FPC}
    procedure ActivateHintData(vRect: TRect; const AHint: string; AData: Pointer); override;
    {$ELSE}
    function CalcHintRect(MaxWidth: Integer; const AHint: string;
      AData: Pointer): TRect; override;
    {$ENDIF}
    procedure Paint; override;
  end;

implementation

uses
  SysUtils, frxClass, frxUtils
{$IFDEF Delphi10}
  , WideStrings
{$ENDIF}
  ;

{ TSynHintData }

constructor TBaseHintData.Create(vHeaderPrefix, vHeaderText: String; vMultiPaint: Boolean);
begin
  FHeaderPrefix := vHeaderPrefix;
  FHeaderText := vHeaderText;
  FMultiPaint := vMultiPaint;
end;

function TBaseHintData.GetFullText: String;
begin
  if (FHeaderPrefix <> '') then
    Result := '<font color="#' + ColorText(HINT_HEADER_PREFIX_COLOR) + '">' + FHeaderPrefix + '</font>' + FHeaderText
  else
    Result := FHeaderText;
end;

{ TSynHintWindow }

constructor TBaseHintWindow.Create(AOwner: TComponent);
begin
  inherited;
  FBaseHintData := nil;
  FDrawTextHeader := TfrxDrawText.Create;
  FDrawTextPlain := TfrxDrawText.Create;
end;

destructor TBaseHintWindow.Destroy;
begin
  FBaseHintData.Free;
  FDrawTextHeader.Free;
  FDrawTextPlain.Free;
  inherited;
end;

procedure TBaseHintWindow.SetPlainTextOptions;
begin
  FDrawTextPlain.SetOptions(True, True, False, True, False, True, 0);
end;

procedure TBaseHintWindow.PaintHeader;
var
  BufRect: TRect;
begin
  BufRect := ClientRect;
  BufRect.Bottom := FHeaderHeight;
  Canvas.Brush.Color := HINT_HEADER_COLOR;
  Canvas.FillRect(BufRect);

  FDrawTextHeader.DrawText(Canvas, haLeft, vaTop);
end;

procedure TBaseHintWindow.PaintText;
var
  BufRect: TRect;
begin
  BufRect := ClientRect;
  BufRect.Top := FHeaderHeight;
  Canvas.Brush.Color := clWhite;
  Canvas.FillRect(BufRect);

  FDrawTextPlain.DrawText(Canvas, haLeft, vaTop);
end;

procedure TBaseHintWindow.ActivateHint(vRect: TRect; const AHint: string);
var
  WHeader, WText, WMax: Integer;
{$IFDEF FPC}
  cp: TPoint;
{$ENDIF}
begin
  WHeader := Round(FDrawTextHeader.CalcWidth);
  WText := Round(FDrawTextPlain.CalcWidth);
  if (WHeader > WText) then
    WMax := WHeader
  else
    WMax := WText;
  ResetText;

{$IFDEF FPC}
  GetCursorPos(cp);
  vRect.Left := cp.X;
  vRect.Top := cp.Y + 10;
{$ENDIF}

  vRect.Right := vRect.Left + WMax + 2 + HINT_PADDING * 2;
  vRect.Bottom := vRect.Top + FHeaderHeight + Round(FDrawTextPlain.CalcHeight) + HINT_PADDING * 2;
  BoundsRect := vRect;
  inherited;
end;

procedure TBaseHintWindow.ResetText;
var
  WideStrings: TWideStrings;
begin
  WideStrings := TWideStringList.Create;
  WideStrings.Text := FBaseHintData.FullText;
  FDrawTextHeader.SetText(WideStrings);
  WideStrings.Text := FHintS;
  FDrawTextPlain.SetText(WideStrings);
  WideStrings.Free;
end;

procedure TBaseHintWindow.SetupDrawText(FDrawText: TfrxDrawText; Color: TColor; FontSize: Integer; TopPos: Integer);
var
  Rect2: TRect;
begin
  Canvas.Font.Color := Color;
  Canvas.Font.Size := FontSize;
  FDrawText.SetFont(Canvas.Font);

  Rect2 := Rect(HINT_PADDING, TopPos, Screen.Width div 2, 0);
  FDrawText.SetDimensions(1, 1, 1, Rect2, Rect2);
end;

{$IFNDEF FPC}
procedure TBaseHintWindow.ActivateHintData(vRect: TRect; const AHint: string; AData: Pointer);
{$ELSE}
function TBaseHintWindow.CalcHintRect(MaxWidth: Integer; const AHint: string; AData: Pointer): TRect;
{$ENDIF}
begin
  FreeAndNil(FBaseHintData);
  FBaseHintData := AData;
  FHintS := AHint;

  SetupDrawText(FDrawTextHeader, clWhite, HINT_TEXT_SIZE_HEADER, 0);
  FDrawTextHeader.SetOptions(True, True, False, True, False, True, 0);
  ResetText;
  FHeaderHeight := Round(FDrawTextHeader.CalcHeight) + HINT_PADDING;
  SetupDrawText(FDrawTextPlain, clBlack, HINT_TEXT_SIZE, FHeaderHeight + HINT_PADDING);
  SetPlainTextOptions;
  ResetText;

  inherited;
end;

procedure TBaseHintWindow.Paint;
begin
  if (FBaseHintData.MultiPaint) then
    ResetText;
  PaintHeader;
  PaintText;
end;

end.
