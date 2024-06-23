{*******************************************************}
{                                                       }
{                       EhLib 11.0                      }
{                     LaHintWindows                    }
{                                                       }
{    Copyright (c) 2022-2022 by Dmitry V. Bolshakov     }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit LaHintWindows;

interface

{$SCOPEDENUMS ON}

uses
  Types, Classes,
  Messages, SysUtils, Variants,
  {$IFDEF FPC}
  EhLibLCL,
  {$ELSE}
  EhLibVCL, Windows,
  {$ENDIF}
  Generics.Collections, DB,
  //RenderEngineEh,
  LaObjectsEh,
  ToolCtrlsEh, DBAxisGridsEh,
  ImgList, Themes, GraphUtil,
  Graphics, Controls, Forms, Dialogs;

type

  TLaHintWindowEh = class(THintWindowEh)
  private
    FLaHost: TLaHostWinControl;
    //FDataHintParams: TDBAxisGridDataHintParamsEh;
    procedure PaintBackground;
  protected
    procedure Paint; override;

  public
    constructor Create(AOwner: TComponent); override;

    procedure ActivateHint(Rect: TRect; const AHint: string); override;
    procedure ActivateHintData(Rect: TRect; const AHint: string; AData: TCustomData); override;
    function CalcHintRect(MaxWidth: Integer; const AHint: string; AData: TCustomData): TRect; override;
  end;

implementation

{$IFDEF FPC}
uses DBGridsEh;
{$ELSE}
uses DBGridEh;
{$ENDIF}

type
  TCustomDBGridEhCrack = class(TCustomDBGridEh);

type
  TDBGridEhLaHostWinControl = class(TLaHostWinControl)
  protected
    procedure Paint; override;
  public
    DataRowNum: Integer;
    Grid: TCustomDBGridEh;
  end;

{ TDBGridEhLaHostWinControl }

procedure TDBGridEhLaHostWinControl.Paint;
var
  Grid: TCustomDBGridEhCrack;
begin
  if DataRowNum >= 0 then
  begin
    Grid := TCustomDBGridEhCrack(Self.Grid);
    Grid.InstantReadRecordEnter(DataRowNum);
    try
      inherited Paint;
    finally
      Grid.InstantReadRecordLeave;
    end;
  end else
  begin
    inherited Paint;
  end;
end;

{ TLaHintWindow }

constructor TLaHintWindowEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FLaHost := TDBGridEhLaHostWinControl.Create(Self);
  FLaHost.Align := alClient;
  FLaHost.Parent := Self;
//  FLaHost.DataSource := DataSource1;
//  FLaHost.ShowHint := True;
end;

procedure TLaHintWindowEh.ActivateHint(Rect: TRect; const AHint: string);
begin
  inherited ActivateHint(Rect, AHint);
end;

procedure TLaHintWindowEh.ActivateHintData(Rect: TRect; const AHint: string; AData: TCustomData);
begin
  inherited ActivateHintData(Rect, AHint, AData);
end;

function TLaHintWindowEh.CalcHintRect(MaxWidth: Integer; const AHint: string; AData: TCustomData): TRect;
var
  DataHintParams: TDBGridEhDataHintParams;
  Grid: TCustomDBGridEhCrack;
begin
  if (AData <> nil) and
     (TObject(AData) is TDBGridEhDataHintParams) and
     (TDBGridEhDataHintParams(AData).LaHintObject <> nil) then
  begin
    DataHintParams := TDBGridEhDataHintParams(AData);
    Grid := TCustomDBGridEhCrack(DataHintParams.Grid);
    FLaHost.Visible := True;
    FLaHost.LaObject := DataHintParams.LaHintObject;
    FLaHost.DataSource := Grid.DataSource;

    TDBGridEhLaHostWinControl(FLaHost).DataRowNum := DataHintParams.DataRowNum;
    TDBGridEhLaHostWinControl(FLaHost).Grid := Grid;

    Grid.InstantReadRecordEnter(DataHintParams.DataRowNum);
    try
      FLaHost.LaObject.QueryLayout(RectSize(Screen.WorkAreaRect), Canvas);
    finally
      Grid.InstantReadRecordLeave;
    end;

    Result := Rect(0, 0, FLaHost.LaObject.NeededSize.cx, FLaHost.LaObject.NeededSize.cy);
    Inc(Result.Right, 2);
    Inc(Result.Bottom, 0);
  end
  else
  begin
    FLaHost.LaObject := nil;
    FLaHost.Visible := False;
    Result := inherited CalcHintRect(MaxWidth, AHint, AData);
  end;
end;

procedure TLaHintWindowEh.Paint;
begin
  if (FLaHost.LaObject <> nil) then
    PaintBackground
  else
    inherited Paint;
end;

procedure TLaHintWindowEh.PaintBackground;
var
  R: TRect;
{$IFDEF EH_LIB_16}
  ClipRect: TRect;
  LColor: TColor;
  LStyle: TCustomStyleServices;
  LDetails: TThemedElementDetails;
  LGradientStart, LGradientEnd: TColor;
{$ELSE}
//  LStyle: TThemeServices;
{$ENDIF}
//  LTextColor: TColor;
begin
  R := ClientRect;
  {$IFDEF EH_LIB_16}
  LStyle := StyleServices;
//  LTextColor := Screen.HintFont.Color;
  if LStyle.Enabled then
  begin
    ClipRect := R;
    InflateRect(R, 4, 4);
    if TOSVersion.Check(6) and LStyle.IsSystemStyle then
    begin
      // Paint Windows gradient background
      LStyle.DrawElement(Canvas.Handle, LStyle.GetElementDetails(tttStandardNormal), R, ClipRect);
    end
    else
    begin
      LDetails := LStyle.GetElementDetails(thHintNormal);
      if LStyle.GetElementColor(LDetails, ecGradientColor1, LColor) and (LColor <> clNone) then
        LGradientStart := LColor
      else
        LGradientStart := clInfoBk;
      if LStyle.GetElementColor(LDetails, ecGradientColor2, LColor) and (LColor <> clNone) then
        LGradientEnd := LColor
      else
        LGradientEnd := clInfoBk;
//      if LStyle.GetElementColor(LDetails, ecTextColor, LColor) and (LColor <> clNone) then
//        LTextColor := LColor
//      else
//        LTextColor := Screen.HintFont.Color;
      GradientFillCanvas(Canvas, LGradientStart, LGradientEnd, R, gdVertical);
    end;
    R := ClipRect;
  end;
  {$ELSE}
//  LStyle := ThemeServices;
  {$ENDIF}

//  Inc(R.Left, 2);
//  Inc(R.Top, 2);
//  Canvas.Font.Color := LTextColor;
//  DrawText(Canvas.Handle, Caption, -1, R, DT_LEFT or DT_NOPREFIX or
//    DT_WORDBREAK or DrawTextBiDiModeFlagsReadingOnly);
end;

end.
