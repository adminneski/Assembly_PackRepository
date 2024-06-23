
{******************************************}
{                                          }
{             FastReport VCL               }
{         TeeChart series helpers          }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxChartHelpers;

interface

{$I frx.inc}
{$I frTeeChartVer.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Menus, Controls, frxChart,
{$IFDEF DELPHI16}
  VCLTee.TeeProcs, VCLTee.TeEngine, VCLTee.Chart, VCLTee.Series, VCLTee.TeCanvas, VCLTee.GanttCh, VCLTee.TeeShape,
  VCLTee.BubbleCh, VCLTee.ArrowCha
{$IFDEF TeeChartPro}
, VCLTee.TeePolar,
{$IFNDEF TeeChart4}
  VCLTee.TeeSmith, VCLTee.TeePyramid, VCLTee.TeeDonut, VCLTee.TeeFunnel, VCLTee.TeeBoxPlot, VCLTee.TeeTriSurface,
{$ENDIF}
  VCLTee.TeeBezie, VCLTee.OHLChart, VCLTee.CandleCh, VCLTee.StatChar, VCLTee.ErrorBar,
  VCLTee.TeeSurfa, VCLTee.TeePoin3, VCLTee.MyPoint, VCLTee.Bar3D
{$IFDEF TeeChart7Series}
, VCLTee.TeeGauges, VCLTee.TeePointFigure
{$ENDIF}
{$IFDEF TeeChartSeriesEx}
, VCLTee.TeePolarContour
, VCLTee.TeeEquiVolume, VCLTee.TeeCircularGauge,VCLTee.TeeLinearGauge
, VCLTee.TeeNumericGauge, VCLTee.BigCandl
, VCLTee.TeeCalendar, VCLTee.ImaPoint, VCLTee.ImageBar
, VCLTee.TeeErrorPoint, VCLTee.TeeEqualizerSeries
, VCLTee.TeeRose, VCLTee.TeePolarGrid, VCLTee.TeeOrgSeries, VCLTee.TeeTreeMapSeries
{$IFDEF TeeChart8Series}
, VCLTee.TeeVolumePipe,VCLTee.TeeHighLowLine
,VCLTee.TeeTagCloud
, VCLTee.TeeKagiSeries, VCLTee.TeeRenkoSeries
{$ENDIF}
{$IFDEF TeeChart9Series}
, VCLTee.TeeKnobGauge, VCLTee.TeeTernary
{$ENDIF}
{$ENDIF}
{$ENDIF}
{$ELSE}
  TeeProcs, TeEngine, Chart, Series, TeCanvas, GanttCh, TeeShape,
  BubbleCh, ArrowCha
{$IFDEF TeeChartPro}
, TeePolar,
{$IFNDEF TeeChart4}
  TeeSmith, TeePyramid, TeeDonut, TeeFunnel, TeeBoxPlot, TeeTriSurface,{$ENDIF}
  TeeBezie, OHLChart, CandleCh, StatChar, ErrorBar, 
  TeeSurfa, TeePoin3, MyPoint, Bar3D
{$IFDEF TeeChart7Series}
, TeeGauges, TeePointFigure
{$ENDIF}
{$IFDEF TeeChartSeriesEx}
, TeePolarContour
, TeeEquiVolume, TeeCircularGauge,TeeLinearGauge, TeeNumericGauge, BigCandl
, TeeCalendar, ImaPoint, ImageBar
, TeeErrorPoint, TeeEqualizerSeries
, TeeRose, TeePolarGrid, TeeOrgSeries, TeeTreeMapSeries
{$IFDEF TeeChart8Series}
, TeeVolumePipe, TeeHighLowLine, TeeTagCloud
, TeeKagiSeries, TeeRenkoSeries
{$ENDIF}
{$IFDEF TeeChart9Series}
, TeeKnobGauge, TeeTernary
{$ENDIF}
{$ENDIF}
{$ENDIF}
{$ENDIF}
{$IFDEF DELPHI6}
, Variants
{$ENDIF};


type
  TfrxSeriesHelper = class(TObject)
  public
    function GetParamNames: String; virtual; abstract;
    procedure AddValues(Series: TChartSeries; const v1, v2, v3, v4, v5, v6: String;
      XType: TfrxSeriesXType); overload; virtual; abstract;
    procedure AddValues(Series: TChartSeries; const v1, v2, v3, v4, v5, v6, v7,
      v8, v9, v10: String; XType: TfrxSeriesXType); overload; virtual;
  end;

  TfrxStdSeriesHelper = class(TfrxSeriesHelper)
  public
    function GetParamNames: String; override;
    procedure AddValues(Series: TChartSeries; const v1, v2, v3, v4, v5, v6: String;
      XType: TfrxSeriesXType); override;
  end;

  TfrxPieSeriesHelper = class(TfrxSeriesHelper)
  public
    function GetParamNames: String; override;
    procedure AddValues(Series: TChartSeries; const v1, v2, v3, v4, v5, v6: String;
      XType: TfrxSeriesXType); override;
  end;

  TfrxGanttSeriesHelper = class(TfrxSeriesHelper)
  public
    function GetParamNames: String; override;
    procedure AddValues(Series: TChartSeries; const v1, v2, v3, v4, v5, v6: String;
      XType: TfrxSeriesXType); override;
  end;

  TfrxArrowSeriesHelper = class(TfrxSeriesHelper)
  public
    function GetParamNames: String; override;
    procedure AddValues(Series: TChartSeries; const v1, v2, v3, v4, v5, v6: String;
      XType: TfrxSeriesXType); override;
  end;

  TfrxBubbleSeriesHelper = class(TfrxSeriesHelper)
  public
    function GetParamNames: String; override;
    procedure AddValues(Series: TChartSeries; const v1, v2, v3, v4, v5, v6: String;
      XType: TfrxSeriesXType); override;
  end;

{$IFDEF TeeChartPro}
  TfrxPolarSeriesHelper = class(TfrxSeriesHelper)
  public
    function GetParamNames: String; override;
    procedure AddValues(Series: TChartSeries; const v1, v2, v3, v4, v5, v6: String;
      XType: TfrxSeriesXType); override;
  end;

  TfrxGaugeSeriesHelper = class(TfrxSeriesHelper)
  public
    function GetParamNames: String; override;
    procedure AddValues(Series: TChartSeries; const v1, v2, v3, v4, v5, v6: String;
      XType: TfrxSeriesXType); override;
  end;

  TfrxSmithSeriesHelper = class(TfrxSeriesHelper)
  public
    function GetParamNames: String; override;
    procedure AddValues(Series: TChartSeries; const v1, v2, v3, v4, v5, v6: String;
      XType: TfrxSeriesXType); override;
  end;

  TfrxCandleSeriesHelper = class(TfrxSeriesHelper)
  public
    function GetParamNames: String; override;
    procedure AddValues(Series: TChartSeries; const v1, v2, v3, v4, v5, v6: String;
      XType: TfrxSeriesXType); override;
  end;

  TfrxErrorSeriesHelper = class(TfrxSeriesHelper)
  public
    function GetParamNames: String; override;
    procedure AddValues(Series: TChartSeries; const v1, v2, v3, v4, v5, v6: String;
      XType: TfrxSeriesXType); override;
  end;

  TfrxHiLoSeriesHelper = class(TfrxSeriesHelper)
  public
    function GetParamNames: String; override;
    procedure AddValues(Series: TChartSeries; const v1, v2, v3, v4, v5, v6: String;
      XType: TfrxSeriesXType); override;
  end;

  TfrxFunnelSeriesHelper = class(TfrxSeriesHelper)
  public
    function GetParamNames: String; override;
    procedure AddValues(Series: TChartSeries; const v1, v2, v3, v4, v5, v6: String;
      XType: TfrxSeriesXType); override;
  end;

  TfrxSurfaceSeriesHelper = class(TfrxSeriesHelper)
  public
    function GetParamNames: String; override;
    procedure AddValues(Series: TChartSeries; const v1, v2, v3, v4, v5, v6: String;
      XType: TfrxSeriesXType); override;
  end;

  TfrxVector3DSeriesHelper = class(TfrxSeriesHelper)
  public
    function GetParamNames: String; override;
    procedure AddValues(Series: TChartSeries; const v1, v2, v3, v4, v5, v6: String;
      XType: TfrxSeriesXType); override;
  end;

  TfrxBubble3DSeriesHelper = class(TfrxSeriesHelper)
  public
    function GetParamNames: String; override;
    procedure AddValues(Series: TChartSeries; const v1, v2, v3, v4, v5, v6: String;
      XType: TfrxSeriesXType); override;
  end;

  TfrxBar3DSeriesHelper = class(TfrxSeriesHelper)
  public
    function GetParamNames: String; override;
    procedure AddValues(Series: TChartSeries; const v1, v2, v3, v4, v5, v6: String;
      XType: TfrxSeriesXType); override;
  end;

{$IFDEF TeeChartSeriesEx}
  TfrxPolarGridSeriesHelper = class(TfrxSeriesHelper)
  public
    function GetParamNames: String; override;
    procedure AddValues(Series: TChartSeries; const v1, v2, v3, v4, v5, v6: String;
      XType: TfrxSeriesXType); override;
  end;

  TfrxPolarContourSeriesHelper = class(TfrxSeriesHelper)
  public
    function GetParamNames: String; override;
    procedure AddValues(Series: TChartSeries; const v1, v2, v3, v4, v5, v6: String;
      XType: TfrxSeriesXType); override;
  end;

  TfrxOrgSeriesHelper = class(TfrxSeriesHelper)
  public
    function GetParamNames: String; override;
    procedure AddValues(Series: TChartSeries; const v1, v2, v3, v4, v5, v6: String;
      XType: TfrxSeriesXType); override;
  end;

  TfrxTreeMapSeriesHelper = class(TfrxSeriesHelper)
  public
    function GetParamNames: String; override;
    procedure AddValues(Series: TChartSeries; const v1, v2, v3, v4, v5, v6: String;
      XType: TfrxSeriesXType); override;
  end;

  TfrxErrorPointSeriesHelper = class(TfrxSeriesHelper)
  public
    function GetParamNames: String; override;
    procedure AddValues(Series: TChartSeries; const v1, v2, v3, v4, v5, v6, v7,
      v8, v9, v10: String; XType: TfrxSeriesXType); override;
  end;

  TfrxErrorPoint3DSeriesHelper = class(TfrxSeriesHelper)
  public
    function GetParamNames: String; override;
    procedure AddValues(Series: TChartSeries; const v1, v2, v3, v4, v5, v6, v7,
      v8, v9, v10: String; XType: TfrxSeriesXType); override;
  end;

   TfrxTernarySeriesHelper = class(TfrxSeriesHelper)
  public
    function GetParamNames: String; override;
    procedure AddValues(Series: TChartSeries; const v1, v2, v3, v4, v5, v6: String;
      XType: TfrxSeriesXType); override;
  end;

  TfrxEqualizerSeriesHelper = class(TfrxSeriesHelper)
  public
    function GetParamNames: String; override;
    procedure AddValues(Series: TChartSeries; const v1, v2, v3, v4, v5, v6: String;
      XType: TfrxSeriesXType); override;
  end;

  TfrxNumericGaugeSeriesHelper = class(TfrxSeriesHelper)
  public
    function GetParamNames: String; override;
    procedure AddValues(Series: TChartSeries; const v1, v2, v3, v4, v5, v6: String;
      XType: TfrxSeriesXType); override;
  end;
{$ENDIF}
{$ENDIF}

  TfrxSeriesHelperClass = class of TfrxSeriesHelper;


const
{$IFDEF TeeChartPro}
{$IFDEF TeeChartSeriesEx}
  frxNumSeries = 70;
{$ELSE}
  frxNumSeries = 44;
{$ENDIF}
{$ELSE}
{$IFDEF DELPHI11}
  frxNumSeries = 13;
{$ELSE}
  frxNumSeries = 11;
{$ENDIF}
{$ENDIF}
  frxChartSeries: array[0..frxNumSeries - 1] of TSeriesClass =
    (TLineSeries, TAreaSeries, TPointSeries,
     TBarSeries, THorizBarSeries, TPieSeries,
     TGanttSeries, TFastLineSeries, TArrowSeries,
     TBubbleSeries, TChartShape
{$IFNDEF TeeChartPro}
{$IFDEF DELPHI11}
     , THorizAreaSeries, THorizLineSeries
{$ENDIF}
{$ENDIF}
{$IFDEF TeeChartPro}
   , {$IFDEF TeeChart7Series}THorizAreaSeries{$ELSE}nil{$ENDIF},{$IFNDEF TeeChart4}THorizLineSeries{$ELSE}nil{$ENDIF},TPolarSeries,
     TRadarSeries,{$IFDEF TeeChart7Series}TPolarBarSeries{$ELSE}nil{$ENDIF},{$IFDEF TeeChart7Series}TGaugeSeries{$ELSE}nil{$ENDIF},
     {$IFNDEF TeeChart4}TSmithSeries, TPyramidSeries, TDonutSeries{$ELSE}nil, nil, nil{$ENDIF},
     TBezierSeries, TCandleSeries, TVolumeSeries,
     {$IFDEF TeeChart7Series}TPointFigureSeries{$ELSE}nil{$ENDIF},{$IFNDEF TeeChart4}THistogramSeries{$ELSE}nil{$ENDIF},{$IFDEF TeeChart7Series}THorizHistogramSeries{$ELSE}nil{$ENDIF},
     TErrorBarSeries, TErrorSeries,{$IFNDEF TeeChart4}THighLowSeries{$ELSE}nil{$ENDIF},
     {$IFNDEF TeeChart4}TFunnelSeries, TBoxSeries, THorizBoxSeries{$ELSE}nil, nil, nil{$ENDIF},
     TSurfaceSeries, TContourSeries,{$IFNDEF TeeChart4}TWaterFallSeries,TColorGridSeries{$ELSE}nil, nil{$ENDIF},
	   {$IFDEF TeeChart7Series}TVector3DSeries{$ELSE}nil{$ENDIF},{$IFDEF TeeChart7Series}TTowerSeries{$ELSE}nil{$ENDIF},{$IFNDEF TeeChart4}TTriSurfaceSeries{$ELSE}nil{$ENDIF},
	   TPoint3DSeries, {$IFDEF TeeChart7Series}TBubble3DSeries{$ELSE}nil{$ENDIF}, TMyPointSeries,
	   {$IFNDEF TeeChart4}TBarJoinSeries{$ELSE}nil{$ENDIF}, TBar3DSeries
{$IFDEF TeeChartSeriesEx}
     , TPolarContourSeries, TEquiVolumeSeries, TCircularGauge,
     TClockGauge, TNumericGauge, TBigCandleSeries,
     TDeltaPointSeries, TImageBarSeries, TImagePointSeries,
     TWindRoseSeries, TErrorPoint3DSeries, TErrorPointSeries,
     TEqualizerSeries,
{$IFDEF TeeChart10Series}
     TBeeSwarmSeries
{$ELSE}
     nil
{$ENDIF}
{$IFDEF TeeChart8Series}
    , TPolarGridSeries, TOrgSeries, TKagiSeries
    , TRenkoSeries, TTagCloudSeries, THighLowLineSeries
    , TVolumePipeSeries
{$ELSE}
    , nil, nil, nil
    , nil, nil, nil
    , nil
{$ENDIF}
{$IFDEF TeeChart9Series}
    , TTreeMapSeries, TKnobGauge, TRoseSeries
    , TTernarySeries, TDarvasSeries
{$ELSE}
    , nil,nil,nil
    , nil, nil
{$ENDIF}
{$ENDIF}
{$ENDIF}
    );

  frxSeriesHelpers: array[0..frxNumSeries - 1] of TfrxSeriesHelperClass =
    (TfrxStdSeriesHelper, TfrxStdSeriesHelper, TfrxStdSeriesHelper,
     TfrxStdSeriesHelper, TfrxStdSeriesHelper, TfrxPieSeriesHelper,
     TfrxGanttSeriesHelper, TfrxStdSeriesHelper, TfrxArrowSeriesHelper,
     TfrxBubbleSeriesHelper, TfrxStdSeriesHelper
{$IFNDEF TeeChartPro}
{$IFDEF DELPHI11}
     , TfrxStdSeriesHelper, TfrxStdSeriesHelper
{$ENDIF}
{$ENDIF}
{$IFDEF TeeChartPro}
     , TfrxStdSeriesHelper, TfrxStdSeriesHelper, TfrxPolarSeriesHelper,
     TfrxPolarSeriesHelper, TfrxPolarSeriesHelper, TfrxGaugeSeriesHelper,
     TfrxSmithSeriesHelper, TfrxStdSeriesHelper, TfrxPieSeriesHelper,
     TfrxStdSeriesHelper, TfrxCandleSeriesHelper, TfrxStdSeriesHelper,
     TfrxCandleSeriesHelper, TfrxStdSeriesHelper, TfrxStdSeriesHelper,
     TfrxErrorSeriesHelper, TfrxErrorSeriesHelper, TfrxHiLoSeriesHelper,
     TfrxFunnelSeriesHelper, TfrxStdSeriesHelper, TfrxStdSeriesHelper,
     TfrxSurfaceSeriesHelper, TfrxSurfaceSeriesHelper, TfrxSurfaceSeriesHelper,
     TfrxSurfaceSeriesHelper, TfrxVector3DSeriesHelper, TfrxSurfaceSeriesHelper,
     TfrxSurfaceSeriesHelper, TfrxSurfaceSeriesHelper, TfrxBubble3DSeriesHelper,
     TfrxStdSeriesHelper, TfrxStdSeriesHelper, TfrxBar3DSeriesHelper
{$IFDEF TeeChartSeriesEx}
     , TfrxPolarContourSeriesHelper, TfrxCandleSeriesHelper, TfrxStdSeriesHelper,
     TfrxStdSeriesHelper, TfrxNumericGaugeSeriesHelper, TfrxCandleSeriesHelper,
     TfrxStdSeriesHelper, TfrxStdSeriesHelper, TfrxStdSeriesHelper,
     TfrxPolarContourSeriesHelper, TfrxErrorPoint3DSeriesHelper, TfrxErrorPointSeriesHelper,
     TfrxEqualizerSeriesHelper, TfrxStdSeriesHelper,
     TfrxPolarGridSeriesHelper, TfrxOrgSeriesHelper, TfrxStdSeriesHelper,
     TfrxStdSeriesHelper, TfrxStdSeriesHelper, TfrxHiLoSeriesHelper,
     TfrxStdSeriesHelper, TfrxTreeMapSeriesHelper, TfrxStdSeriesHelper,
     TfrxPolarContourSeriesHelper, TfrxTernarySeriesHelper, TfrxCandleSeriesHelper
{$ENDIF}
{$ENDIF}
    );


function frxFindSeriesHelper(Series: TChartSeries): TfrxSeriesHelper;


implementation

uses frxDsgnIntf, frxUtils, frxRes;


function CheckNulls(Value: String): Boolean;
begin
  Result := (UpperCase(Value) = 'NULL') or (Value = '');
end;

function frxFindSeriesHelper(Series: TChartSeries): TfrxSeriesHelper;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to frxNumSeries - 1 do
    if Series.ClassType = frxChartSeries[i] then
    begin
      Result := TfrxSeriesHelper(frxSeriesHelpers[i].NewInstance);
      Result.Create;
      break;
    end;

  if Result = nil then
    Result := TfrxStdSeriesHelper.Create;
end;

{ TfrxStdSeriesHelper }

procedure TfrxStdSeriesHelper.AddValues(Series: TChartSeries; const v1, v2,
  v3, v4, v5, v6: String; XType: TfrxSeriesXType);
var
  d: Double;
  Color: TColor;
  s: String;
begin
  d := 0;
  Color := clTeeColor;
  if v4 <> '' then
    try
      Color := StringToColor(v4);
    except
    end;
  if CheckNulls(v2) then
  begin
    Series.AddNull(v1);
    Exit;
  end;
  if Series.YValues.DateTime then
    d := StrToDateTime(v2)
  else if frxIsValidFloat(v2) then
    d := frxStrToFloat(v2);
  if v3 <> '' then
    s := v3
  else
    s := v1;
  case XType of
    xtText:
      Series.Add(d, v1, Color);
    xtNumber:
      Series.AddXY(frxStrToFloat(s), d, v1, Color);
    xtDate:
      Series.AddXY(StrToDateTime(s), d, v1, Color);
  end;
end;

function TfrxStdSeriesHelper.GetParamNames: String;
begin
  Result := 'Label;Y;X (optional);Color (optional)';
end;


{ TfrxPieSeriesHelper }

procedure TfrxPieSeriesHelper.AddValues(Series: TChartSeries; const v1, v2,
  v3, v4, v5, v6: String; XType: TfrxSeriesXType);
var
  d: Double;
  c: TColor;
begin
  if CheckNulls(v2) then
  begin
    Series.AddNull(v1);
    Exit;
  end;

  if Series.YValues.DateTime then
    d := StrToDateTime(v2)
  else
    d := frxStrToFloat(v2);

  c := clTeeColor;
  if v3 <> '' then
  try
    c := StringToColor(v3);
  except
  end;

  Series.Add(d, v1, c);
end;

function TfrxPieSeriesHelper.GetParamNames: String;
begin
  Result := 'Label;Pie;Color (optional)';
end;


{ TfrxGanttSeriesHelper }

procedure TfrxGanttSeriesHelper.AddValues(Series: TChartSeries; const v1,
  v2, v3, v4, v5, v6: String; XType: TfrxSeriesXType);
var
  d1, d2: Double;
begin
  if CheckNulls(v2) or CheckNulls(v3) or CheckNulls(v4) then
  begin
    Series.AddNull(v1);
    Exit;
  end;

  if TGanttSeries(Series).StartValues.DateTime then
    d1 := StrToDateTime(v2)
  else
    d1 := frxStrToFloat(v2);
  if TGanttSeries(Series).EndValues.DateTime then
    d2 := StrToDateTime(v3)
  else
    d2 := frxStrToFloat(v3);
  TGanttSeries(Series).AddGantt(d1, d2, frxStrToFloat(v4), v1);
  if v5 <> '' then
    TGanttSeries(Series).NextTask[TGanttSeries(Series).NextTask.Count - 1] := StrToInt(v5);
end;

function TfrxGanttSeriesHelper.GetParamNames: String;
begin
  Result := 'Label;Start;End;Y;Next task';
end;


{ TfrxArrowSeriesHelper }

procedure TfrxArrowSeriesHelper.AddValues(Series: TChartSeries; const v1,
  v2, v3, v4, v5, v6: String; XType: TfrxSeriesXType);
var
  Color: TColor;
begin
  if CheckNulls(v2) or CheckNulls(v3) or
    CheckNulls(v4) or CheckNulls(v5) then
  begin
    Series.AddNull(v1);
    Exit;
  end;
  Color := clTeeColor;
  if v6 <> '' then
    try
      Color := StringToColor(v6);
    except
    end;
  if XType = xtDate then
    TArrowSeries(Series).AddArrow(StrToDateTime(v2), frxStrToFloat(v3),
      StrToDateTime(v4), frxStrToFloat(v5), v1, Color)
  else
    TArrowSeries(Series).AddArrow(frxStrToFloat(v2), frxStrToFloat(v3),
      frxStrToFloat(v4), frxStrToFloat(v5), v1, Color);
end;

function TfrxArrowSeriesHelper.GetParamNames: String;
begin
  Result := 'Label;X0;Y0;X1;Y1;Color (optional)';
end;


{ TfrxBubbleSeriesHelper }

procedure TfrxBubbleSeriesHelper.AddValues(Series: TChartSeries; const v1,
  v2, v3, v4, v5, v6: String; XType: TfrxSeriesXType);
var
  Color: TColor;
begin
  if CheckNulls(v2) or CheckNulls(v3) or CheckNulls(v4) then
  begin
    Series.AddNull(v1);
    Exit;
  end;
  Color := clTeeColor;
  if v5 <> '' then
    try
      Color := StringToColor(v5);
    except
    end;
  if XType = xtDate then
    TBubbleSeries(Series).AddBubble(StrToDateTime(v2), frxStrToFloat(v3),
    frxStrToFloat(v4), v1, Color)
  else
    TBubbleSeries(Series).AddBubble(frxStrToFloat(v2), frxStrToFloat(v3),
    frxStrToFloat(v4), v1, Color);
end;

function TfrxBubbleSeriesHelper.GetParamNames: String;
begin
  Result := 'Label;X;Y;Radius;Color (optional)';
end;


{$IFDEF TeeChartPro}
{ TfrxPolarSeriesHelper }

procedure TfrxPolarSeriesHelper.AddValues(Series: TChartSeries; const v1,
  v2, v3, v4, v5, v6: String; XType: TfrxSeriesXType);
var
  Color: TColor;
begin
  if CheckNulls(v2) or CheckNulls(v3) then
  begin
    Series.AddNull(v1);
    Exit;
  end;
  Color := clTeeColor;
  if v4 <> '' then
    try
      Color := StringToColor(v4);
    except
    end;
  Series.AddXY(frxStrToFloat(v2), frxStrToFloat(v3), v1, Color);
end;

function TfrxPolarSeriesHelper.GetParamNames: String;
begin
  Result := 'Label;Angle;Value;Color (optional)';
end;

{ TfrxGaugeSeriesHelper }

procedure TfrxGaugeSeriesHelper.AddValues(Series: TChartSeries; const v1,
  v2, v3, v4, v5, v6: String; XType: TfrxSeriesXType);
var
  Color: TColor;
begin
  if CheckNulls(v2) then
  begin
    Series.AddNull(v1);
    Exit;
  end;
  Color := clTeeColor;
  if v3 <> '' then
    try
      Color := StringToColor(v3);
    except
    end;
  Series.Clear;
  Series.Add(frxStrToFloat(v2), v1, Color);
end;

function TfrxGaugeSeriesHelper.GetParamNames: String;
begin
  Result := 'Label (optional);Value;Color (optional)';
end;


{ TfrxSmithSeriesHelper }

procedure TfrxSmithSeriesHelper.AddValues(Series: TChartSeries; const v1,
  v2, v3, v4, v5, v6: String; XType: TfrxSeriesXType);
begin
{$IFNDEF TeeChart4}
  if CheckNulls(v2) or CheckNulls(v3) then
  begin
    Series.AddNull(v1);
    Exit;
  end;
  TSmithSeries(Series).AddPoint(frxStrToFloat(v2), frxStrToFloat(v3), v1);
{$ENDIF}
end;

function TfrxSmithSeriesHelper.GetParamNames: String;
begin
  Result := 'Label;Resistance;Reactance';
end;


{ TfrxCandleSeriesHelper }

procedure TfrxCandleSeriesHelper.AddValues(Series: TChartSeries; const v1,
  v2, v3, v4, v5, v6: String; XType: TfrxSeriesXType);
begin
  TOHLCSeries(Series).AddOHLC(StrToDateTime(v1),
    frxStrToFloat(v2), frxStrToFloat(v3), frxStrToFloat(v4), frxStrToFloat(v5){$IFDEF TeeChart9Series}, v6{$ENDIF});
end;

function TfrxCandleSeriesHelper.GetParamNames: String;
begin
  Result := 'Date;Open;High;Low;Close'{$IFDEF TeeChart9Series} + ';Label'{$ENDIF};
end;


{ TfrxErrorSeriesHelper }

procedure TfrxErrorSeriesHelper.AddValues(Series: TChartSeries; const v1,
  v2, v3, v4, v5, v6: String; XType: TfrxSeriesXType);
begin
  if CheckNulls(v2) or CheckNulls(v3) or CheckNulls(v4) then
  begin
    Series.AddNull(v1);
    Exit;
  end;
  TCustomErrorSeries(Series).AddErrorBar(frxStrToFloat(v2), frxStrToFloat(v3),
    frxStrToFloat(v4), v1);
end;

function TfrxErrorSeriesHelper.GetParamNames: String;
begin
  Result := 'Label;X;Y;Error';
end;


{ TfrxHiLoSeriesHelper }

procedure TfrxHiLoSeriesHelper.AddValues(Series: TChartSeries; const v1,
  v2, v3, v4, v5, v6: String; XType: TfrxSeriesXType);
begin
{$IFNDEF TeeChart4}
  if CheckNulls(v2) or CheckNulls(v3) or CheckNulls(v4) then
  begin
    Series.AddNull(v1);
    Exit;
  end;
  THighLowSeries(Series).AddHighLow(frxStrToFloat(v2), frxStrToFloat(v3),
    frxStrToFloat(v4), v1);
{$ENDIF}
end;

function TfrxHiLoSeriesHelper.GetParamNames: String;
begin
  Result := 'Label;X;High;Low';
end;


{ TfrxFunnelSeriesHelper }

procedure TfrxFunnelSeriesHelper.AddValues(Series: TChartSeries; const v1,
  v2, v3, v4, v5, v6: String; XType: TfrxSeriesXType);
{$IFNDEF TeeChart4}
var
  Color: TColor;
{$ENDIF}
begin
{$IFNDEF TeeChart4}
  if CheckNulls(v2) or CheckNulls(v3) then
  begin
    Series.AddNull(v1);
    Exit;
  end;
  Color := clTeeColor;
  if v4 <> '' then
    try
      Color := StringToColor(v4);
    except
    end;
  TFunnelSeries(Series).AddSegment(frxStrToFloat(v2), frxStrToFloat(v3), v1, Color);
{$ENDIF}
end;

function TfrxFunnelSeriesHelper.GetParamNames: String;
begin
  Result := 'Label;Quote;Opportunity;Color (optional)';
end;


{ TfrxSurfaceSeriesHelper }

procedure TfrxSurfaceSeriesHelper.AddValues(Series: TChartSeries; const v1,
  v2, v3, v4, v5, v6: String; XType: TfrxSeriesXType);
var
  Color: TColor;
begin
  if CheckNulls(v2) or CheckNulls(v3) or CheckNulls(v4) then
  begin
    Series.AddNull(v1);
    Exit;
  end;
  Color := clTeeColor;
  if v5 <> '' then
    try
      Color := StringToColor(v5);
    except
    end;
{$IFDEF TeeChart4}
  TCustom3DSeries(Series).AddXYZ(Round(frxStrToFloat(v2)), frxStrToFloat(v3),
    Round(frxStrToFloat(v4)), v1, Color);
{$ELSE}
  TCustom3DSeries(Series).AddXYZ(frxStrToFloat(v2), frxStrToFloat(v3),
    frxStrToFloat(v4), v1, Color);
{$ENDIF}
end;

function TfrxSurfaceSeriesHelper.GetParamNames: String;
begin
  Result := 'Label;X;Y;Z;Color (optional)';
end;


{ TfrxVector3DSeriesHelper }

procedure TfrxVector3DSeriesHelper.AddValues(Series: TChartSeries;
  const v1, v2, v3, v4, v5, v6: String; XType: TfrxSeriesXType);
begin
{$IFDEF TeeChart7Series}
  TVector3DSeries(Series).AddVector(frxStrToFloat(v1), frxStrToFloat(v2),
    frxStrToFloat(v3), frxStrToFloat(v4), frxStrToFloat(v5), frxStrToFloat(v6));
{$ENDIF}
end;

function TfrxVector3DSeriesHelper.GetParamNames: String;
begin
  Result := 'X1;Y1;Z1;X2;Y2;Z2';
end;


{ TfrxBubble3DSeriesHelper }

procedure TfrxBubble3DSeriesHelper.AddValues(Series: TChartSeries;
  const v1, v2, v3, v4, v5, v6: String; XType: TfrxSeriesXType);
{$IFDEF TeeChart7Series}
var
  Color: TColor;
{$ENDIF}
begin
{$IFDEF TeeChart7Series}
  if CheckNulls(v2) or CheckNulls(v3) or
    CheckNulls(v4) or CheckNulls(v5) then
  begin
    Series.AddNull(v1);
    Exit;
  end;
  Color := clTeeColor;
  if v6 <> '' then
    try
      Color := StringToColor(v6);
    except
    end;
  TBubble3DSeries(Series).AddBubble(frxStrToFloat(v2), frxStrToFloat(v3),
    frxStrToFloat(v4), frxStrToFloat(v5), v1, Color);
{$ENDIF}
end;

function TfrxBubble3DSeriesHelper.GetParamNames: String;
begin
  Result := 'Label;X;Y;Z;Radius;Color (optional)';
end;


{ TfrxBar3DSeriesHelper }

procedure TfrxBar3DSeriesHelper.AddValues(Series: TChartSeries; const v1,
  v2, v3, v4, v5, v6: String; XType: TfrxSeriesXType);
var
  Color: TColor;
begin
  if CheckNulls(v2) or CheckNulls(v3) or CheckNulls(v4) then
  begin
    Series.AddNull(v1);
    Exit;
  end;
  Color := clTeeColor;
  if v5 <> '' then
    try
      Color := StringToColor(v5);
    except
    end;
  TBar3DSeries(Series).AddBar(frxStrToFloat(v2), frxStrToFloat(v3),
    frxStrToFloat(v4), v1, Color);
end;

function TfrxBar3DSeriesHelper.GetParamNames: String;
begin
  Result := 'Label;X;Y;Offset;Color (optional)';
end;

{$IFDEF TeeChartSeriesEx}

{ TfrxPolarGridSeriesHelper }

procedure TfrxPolarGridSeriesHelper.AddValues(Series: TChartSeries; const v1,
  v2, v3, v4, v5, v6: String; XType: TfrxSeriesXType);
begin
  if CheckNulls(v2) or CheckNulls(v3) then
  begin
    Series.AddNull(v1);
    Exit;
  end;
  TPolarGridSeries(Series).AddCell(StrToInt(v2), StrToInt(v3), frxStrToFloat(v1));
end;

function TfrxPolarGridSeriesHelper.GetParamNames: String;
begin
  Result := 'Value;Sector;Track';
end;

{ TfrxPolarContourSeriesHelper }

procedure TfrxPolarContourSeriesHelper.AddValues(Series: TChartSeries; const v1,
  v2, v3, v4, v5, v6: String; XType: TfrxSeriesXType);
begin
  if CheckNulls(v2) or CheckNulls(v3) then
  begin
    Series.AddNull(v1);
    Exit;
  end;
  TPolarContourSeries(Series).AddXYZ(StrToInt(v2), frxStrToFloat(v3), StrToInt(v1));
end;

function TfrxPolarContourSeriesHelper.GetParamNames: String;
begin
  Result := 'Label;Angle;Radius;';
end;

{ TfrxOrgSeriesHelper }

procedure TfrxOrgSeriesHelper.AddValues(Series: TChartSeries; const v1,
  v2, v3, v4, v5, v6: String; XType: TfrxSeriesXType);
var
  Color: TColor;
begin
  if CheckNulls(v2) or CheckNulls(v3) then
  begin
    Series.AddNull(v1);
    Exit;
  end;
  Color := clTeeColor;
  if v4 <> '' then
    try
      Color := StringToColor(v4);
    except
    end;
  TOrgSeries(Series).AddXY(frxStrToFloat(v2), frxStrToFloat(v3), v1, Color);
end;

function TfrxOrgSeriesHelper.GetParamNames: String;
begin
  Result := 'Label;X;Y;Color (optional);';
end;

{ TfrxTreeMapSeriesHelper }

procedure TfrxTreeMapSeriesHelper.AddValues(Series: TChartSeries; const v1,
  v2, v3, v4, v5, v6: String; XType: TfrxSeriesXType);
var
  Color: TColor;
begin
  if CheckNulls(v2) or CheckNulls(v3) then
  begin
    Series.AddNull(v1);
    Exit;
  end;
  Color := clTeeColor;
  if v4 <> '' then
    try
      Color := StringToColor(v4);
    except
    end;
  TTreeMapSeries(Series).AddXY(frxStrToFloat(v2), frxStrToFloat(v3), v1, Color);
end;

function TfrxTreeMapSeriesHelper.GetParamNames: String;
begin
  Result := 'Label;X;Y;Color (optional);';
end;

{ TfrxErrorPointSeriesHelper }

procedure TfrxErrorPointSeriesHelper.AddValues(Series: TChartSeries; const v1,
  v2, v3, v4, v5, v6, v7, v8, v9, v10: String; XType: TfrxSeriesXType);
var
  Color: TColor;
begin
  if CheckNulls(v2) or CheckNulls(v3) or CheckNulls(v4)or CheckNulls(v5)
  or CheckNulls(v6) then
  begin
    Series.AddNull(v1);
    Exit;
  end;
  Color := clTeeColor;
 if v8 <> '' then
    try
      Color := StringToColor(v8);
    except
    end;
  TErrorPointSeries(Series).Add(frxStrToFloat(v2),frxStrToFloat(v3), frxStrToFloat(v4),
      frxStrToFloat(v5), frxStrToFloat(v6), frxStrToFloat(v7), v1, Color);
end;

function TfrxErrorPointSeriesHelper.GetParamNames: String;
begin
  Result := 'Label;X;Y;Left Error;Right Error;Top Error;Bottom Error;Color (optional)';
end;

{ TfrxErrorPoint3DSeriesHelper }

procedure TfrxErrorPoint3DSeriesHelper.AddValues(Series: TChartSeries; const v1,
  v2, v3, v4, v5, v6, v7, v8, v9, v10: String; XType: TfrxSeriesXType);
var
  Color: TColor;
begin
  if CheckNulls(v2) or CheckNulls(v3) or CheckNulls(v4)or CheckNulls(v5)
  or CheckNulls(v6) then
  begin
    Series.AddNull(v1);
    Exit;
  end;
  Color := clTeeColor;

  TErrorPoint3DSeries(Series).Add(frxStrToFloat(v2),frxStrToFloat(v3), frxStrToFloat(v4),
      frxStrToFloat(v5), frxStrToFloat(v6), frxStrToFloat(v7),frxStrToFloat(v8),
      frxStrToFloat(v9),frxStrToFloat(v10), v1, Color);
end;

function TfrxErrorPoint3dSeriesHelper.GetParamNames: String;
begin
  Result := 'Label;X;Y;Z;Left Error;Right Error;Top Error;Bottom Error;Front Error;Back Error';
end;

{ TfrxTernarySeriesHelper }

procedure TfrxTernarySeriesHelper.AddValues(Series: TChartSeries;
  const v1, v2, v3, v4, v5, v6: String; XType: TfrxSeriesXType);
{$IFDEF TeeChart9Series}
var
  Color: TColor;
{$ENDIF}
begin
{$IFDEF TeeChart9Series}
  if CheckNulls(v2) or CheckNulls(v3) or
     CheckNulls(v4) or CheckNulls(v5) or CheckNulls(v6) then
  begin
    Series.AddNull(v1);
    Exit;
  end;
  Color := clTeeColor;

  TTernarySeries(Series).AddBubbleXYZWeight(frxStrToFloat(v2), frxStrToFloat(v3),
    frxStrToFloat(v4), frxStrToFloat(v5), frxStrToFloat(v6), v1, Color);
{$ENDIF}
end;

function TfrxTernarySeriesHelper.GetParamNames: String;
begin
  Result := 'Label;X;Y;Z;Radius;Weight';
end;


{ TfrxEqualizerSeriesHelper }

procedure TfrxEqualizerSeriesHelper.AddValues(Series: TChartSeries;
  const v1, v2, v3, v4, v5, v6: String; XType: TfrxSeriesXType);
{$IFDEF TeeChart7Series}
var
  Color: TColor;
{$ENDIF}
begin
{$IFDEF TeeChart7Series}
  if CheckNulls(v2) then
  begin
    Series.AddNull(v1);
    Exit;
  end;
  Color := clTeeColor;
  if v3 <> '' then
    try
      Color := StringToColor(v6);
    except
    end;
  TEqualizerSeries(Series).AddBar(frxStrToFloat(v2), v1, Color);
{$ENDIF}
end;

function TfrxEqualizerSeriesHelper.GetParamNames: String;
begin
  Result := 'Label;Bar;Color (optional);';
end;

{ TfrxNumericGaugeSeriesHelper }

procedure TfrxNumericGaugeSeriesHelper.AddValues(Series: TChartSeries; const v1,
  v2, v3, v4, v5, v6: String; XType: TfrxSeriesXType);
var
  Color: TColor;
begin
  if CheckNulls(v2) then
  begin
    Series.AddNull(v1);
    Exit;
  end;
  Color := clTeeColor;
  if v3 <> '' then
    try
      Color := StringToColor(v3);
    except
    end;
  TNumericGauge(Series).Add(frxStrToFloat(v2), v1, Color);
end;

function TfrxNumericGaugeSeriesHelper.GetParamNames: String;
begin
  Result := 'Label;Value;Color (optional);';
end;

{$ENDIF}
{$ENDIF}

{ TfrxSeriesHelper }

procedure TfrxSeriesHelper.AddValues(Series: TChartSeries; const v1, v2, v3, v4,
  v5, v6, v7, v8, v9, v10: String; XType: TfrxSeriesXType);
begin
  AddValues(Series, v1, v2, v3, v4, v5, v6, XType);
end;

end.
