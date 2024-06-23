
{******************************************}
{                                          }
{             FastReport VCL               }
{         TeeChart Add-In Object           }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxChart;

interface

{$I frx.inc}
{$I frTeeChartVer.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Menus, Controls,
  frCoreClasses, frxClass, frThreading,
{$IFDEF DELPHI16}
  VCLTee.TeeProcs, VCLTee.TeEngine, VCLTee.Chart, VCLTee.Series, VCLTee.TeCanvas
{$ELSE}
  TeeProcs, TeEngine, Chart, Series, TeCanvas
{$ENDIF}
{$IFDEF DELPHI16}
 {$IFDEF TeeChartPro}, VCLTEE.TeeEdit{$IFNDEF TeeChart4}, VCLTEE.TeeEditCha{$ENDIF} {$ENDIF}
{$ELSE}
 {$IFDEF TeeChartPro}, TeeEdit{$IFNDEF TeeChart4}, TeeEditCha{$ENDIF} {$ENDIF}
{$ENDIF}
{$IFDEF DELPHI6}
, Variants
{$ENDIF};


type
{$IFDEF DELPHI16}
/// <summary>
///   The TfrxChartBoxObject lets you use the Chart component in your report.
///   TfrxChartObject is an empty component. It is used to add the frxChart.pas
///   file to the "uses" list. The main component is TfrxChartView.
/// </summary>
[ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxChartObject = class(TComponent);  // fake component
  TChartClass = class of TCustomChart;

  /// <summary>
  ///   Data type of the series: DB data, band data or fixed data.
  /// </summary>
  TfrxSeriesDataType = (dtDBData, dtBandData, dtFixedData);
  /// <summary>
  ///   Sort type of the series data.
  /// </summary>
  TfrxSeriesSortOrder = (soNone, soAscending, soDescending);
  /// <summary>
  ///   The X-axis data type: text, numeric, date.
  /// </summary>
  TfrxSeriesXType = (xtText, xtNumber, xtDate);
  TSeriesClass = class of TChartSeries;
  /// <summary>
  ///   Series types.
  /// </summary>
  TfrxChartSeries = (csLine, csArea, csPoint, csBar, csHorizBar,
    csPie, csGantt, csFastLine, csArrow, csBubble, csChartShape, csHorizArea,
    csHorizLine, csPolar, csRadar, csPolarBar, csGauge, csSmith, csPyramid,
    csDonut, csBezier, csCandle, csVolume, csPointFigure, csHistogram,
    csHorizHistogram, csErrorBar, csError, csHighLow, csFunnel, csBox,
    csHorizBox, csSurface, csContour, csWaterFall, csColorGrid, csVector3D,
    csTower, csTriSurface, csPoint3D, csBubble3D, csMyPoint, csBarJoin, csBar3D,
    //new
    csPolarContourSeries, csEquiVolumeSeries, csCircularGauge, csClockGauge,
    csNumericGauge, csBigCandle, csDeltaPoint, TImageBar, TImagePoint,
    csWindRose, csErrorPoint3D, csErrorPoint, csEqualizer, csPolarGrid,
    csOrg, csKagi, csRenko, csTagCloud, csHighLowLine, csVolumePipe, csTreeMap,
    csKnobGauge, csRose, csTernary
    );


  /// <summary>
  ///   The TfrxSeriesItem class represents one series.
  /// </summary>
  TfrxSeriesItem = class(TfrCollectionItem)
  private
    FDataBand: TfrxDataBand;
    FDataSet: TfrxDataSet;
    FDataSetName: String;
    FDataType: TfrxSeriesDataType;
    FSortOrder: TfrxSeriesSortOrder;
    FTopN: Integer;
    FTopNCaption: String;
    FSource1: String;
    FSource2: String;
    FSource3: String;
    FSource4: String;
    FSource5: String;
    FSource6: String;
    FSource7: String;
    FSource8: String;
    FSource9: String;
    FSource10: String;
    FXType: TfrxSeriesXType;
    FValues1: String;
    FValues2: String;
    FValues3: String;
    FValues4: String;
    FValues5: String;
    FValues6: String;
    FValues7: String;
    FValues8: String;
    FValues9: String;
    FValues10: String;
    Fsl1: TStringList;
    Fsl2: TStringList;
    Fsl3: TStringList;
    Fsl4: TStringList;
    Fsl5: TStringList;
    Fsl6: TStringList;
    Fsl7: TStringList;
    Fsl8: TStringList;
    Fsl9: TStringList;
    Fsl10: TStringList;
    FValueIndex1: Integer;
    FValueIndex2: Integer;
    FValueIndex3: Integer;
    FValueIndex4: Integer;
    FValueIndex5: Integer;
    FValueIndex6: Integer;
    FValueIndex7: Integer;
    FValueIndex8: Integer;
    FValueIndex9: Integer;
    FValueIndex10: Integer;
    procedure FillSeries(Series: TChartSeries);
    procedure SetDataSet(const Value: TfrxDataSet);
    procedure SetDataSetName(const Value: String);
    function GetDataSetName: String;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    function IsUniqueNameStored: Boolean; override;
  published
    /// <summary>
    ///   Type of series data.
    /// </summary>
    property DataType: TfrxSeriesDataType read FDataType write FDataType;
    /// <summary>
    ///   Band which the series is connected to. Used if DataType = dtBandData.
    /// </summary>
    property DataBand: TfrxDataBand read FDataBand write FDataBand;
    /// <summary>
    ///   Dataset which is series connected to. This property is used if
    ///   property DataType = dtDBData.
    /// </summary>
    property DataSet: TfrxDataSet read FDataSet write SetDataSet;
    property DataSetName: String read GetDataSetName write SetDataSetName;
    /// <summary>
    ///   Sort order of series data.
    /// </summary>
    property SortOrder: TfrxSeriesSortOrder read FSortOrder write FSortOrder;
    /// <summary>
    ///   Show TopN values. Sum of other values shows as a separate value with
    ///   caption set in the TopNCaption property.
    /// </summary>
    property TopN: Integer read FTopN write FTopN;
    /// <summary>
    ///   Show TopN values. Sum of other values shows as a separate value with
    ///   caption set in the TopNCaption property.
    /// </summary>
    property TopNCaption: String read FTopNCaption write FTopNCaption;
    /// <summary>
    ///   The X-axis data type: text, numeric, date.
    /// </summary>
    property XType: TfrxSeriesXType read FXType write FXType;

    { source expressions }
    /// <summary>
    ///   Datasource1 for axis values. This property may contain an expression
    ///   or list of fixed data (in case DataType property is dtFixedData).
    /// </summary>
    property Source1: String read FSource1 write FSource1;
    /// <summary>
    ///   Datasource2 for axis values. This property may contain an expression
    ///   or list of fixed data (in case DataType property is dtFixedData).
    /// </summary>
    property Source2: String read FSource2 write FSource2;
    /// <summary>
    ///   Datasource3 for axis values. This property may contain an expression
    ///   or list of fixed data (in case DataType property is dtFixedData).
    /// </summary>
    property Source3: String read FSource3 write FSource3;
    /// <summary>
    ///   Datasource4 for axis values. This property may contain an expression
    ///   or list of fixed data (in case DataType property is dtFixedData).
    /// </summary>
    property Source4: String read FSource4 write FSource4;
    /// <summary>
    ///   Datasource5 for axis values. This property may contain an expression
    ///   or list of fixed data (in case DataType property is dtFixedData).
    /// </summary>
    property Source5: String read FSource5 write FSource5;
    /// <summary>
    ///   Datasource6 for axis values. This property may contain an expression
    ///   or list of fixed data (in case DataType property is dtFixedData).
    /// </summary>
    property Source6: String read FSource6 write FSource6;
    /// <summary>
    ///   Datasource7 for axis values. This property may contain an expression
    ///   or list of fixed data (in case DataType property is dtFixedData).
    /// </summary>
    property Source7: String read FSource7 write FSource7;
    /// <summary>
    ///   Datasource8 for axis values. This property may contain an expression
    ///   or list of fixed data (in case DataType property is dtFixedData).
    /// </summary>
    property Source8: String read FSource8 write FSource8;
    /// <summary>
    ///   Datasource9 for axis values. This property may contain an expression
    ///   or list of fixed data (in case DataType property is dtFixedData).
    /// </summary>
    property Source9: String read FSource9 write FSource9;
    /// <summary>
    ///   Datasource10 for axis values. This property may contain an expression
    ///   or list of fixed data (in case DataType property is dtFixedData).
    /// </summary>
    property Source10: String read FSource10 write FSource10;

    { ready values. For internal use only. }
    property Values1: String read FValues1 write FValues1;
    property Values2: String read FValues2 write FValues2;
    property Values3: String read FValues3 write FValues3;
    property Values4: String read FValues4 write FValues4;
    property Values5: String read FValues5 write FValues5;
    property Values6: String read FValues6 write FValues6;
    property Values7: String read FValues7 write FValues7;
    property Values8: String read FValues8 write FValues8;
    property Values9: String read FValues9 write FValues9;
    property Values10: String read FValues10 write FValues10;

    { backward compatibility }
    property XSource: String read FSource1 write FSource1;
    property YSource: String read FSource2 write FSource2;
    property XValues: String read FValues1 write FValues1;
    property YValues: String read FValues2 write FValues2;

    { deprecated V5 }
    property InheritedName: String read GetInheritedName write SetInheritedName stored False;
  end;

  /// <summary>
  ///   The TfrxSeriesData class represents collection of series.
  /// </summary>
  TfrxSeriesData = class(TfrCollection)
  private
    FReport: TfrxReport;
    function GetSeries(Index: Integer): TfrxSeriesItem;
  public
    constructor Create(Report: TfrxReport);
    /// <summary>
    ///   Adds a new item to the collection.
    /// </summary>
    function Add: TfrxSeriesItem;
    /// <summary>
    ///   List of series.
    /// </summary>
    property Items[Index: Integer]: TfrxSeriesItem read GetSeries; default;
  end;


  /// <summary>
  ///   The TfrxChartView component represents a chart. The component uses
  ///   TeeChart library to render charts. It may show several series on one
  ///   chart. The series settings are stored in the SeriesData collection.
  /// </summary>
  TfrxChartView = class(TfrxView)
  private
    FChart: TCustomChart;
    FSeriesData: TfrxSeriesData;
    FIgnoreNulls: Boolean;
    FLockFillSeries: Boolean;
    FSeriesFilled: Boolean;
    FSavedColor: TColor;
    FHlIndex: Integer;
    FClickedVal1: String;
    FClickedVal2: String;
    FClickedVal3: String;
    FClickedVal4: String;
    FClickedVal5: String;
    FClickedVal6: String;
    FClickedVal7: String;
    FClickedVal8: String;
    FClickedVal9: String;
    FClickedVal10: String;
    FHighlightColor: TColor;
    FPenWidth: Integer;
{$IFDEF DELPHI12}
    FPenStyle: TPenStyle;
{$ENDIF}
    FSeriesIndex: Integer;
    FMouseDown: Boolean;
    FMouseOffsetX: Extended;
    FMouseOffsetY: Extended;
    FMacroLoaded: Boolean;
    FEMF: TMetafile;
    //FChart: TCustomChart;
    procedure FillChart;
    procedure ReadData(Stream: TStream);
    procedure ReadData1(Reader: TReader);
    procedure ReadData2(Reader: TReader);
    procedure WriteData(Stream: TStream);
    procedure WriteData1(Writer: TWriter);
    procedure WriteData2(Writer: TWriter);
    function CreateMetafile: TMetafile;
    function ResetHighlightSelection: Boolean;
    procedure DrawOnMetaFile;
    procedure ResetClickedValues;
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure CreateChart; virtual;
    class function GetChartClass: TChartClass; virtual;
    function CheckMoveSelector(X, Y: Extended): Boolean;
    procedure ReaderError(Reader: TReader; const Message: string;
      var Handled: Boolean);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DoMouseMove(X, Y: Integer; Shift: TShiftState;
      var EventParams: TfrxInteractiveEventsParams); override;
    procedure DoMouseEnter(aPreviousObject: TfrxComponent;
      var EventParams: TfrxInteractiveEventsParams); override;
    procedure DoMouseLeave(aNextObject: TfrxComponent;
      var EventParams: TfrxInteractiveEventsParams); override;
    procedure DoMouseUp(X, Y: Integer; Button: TMouseButton;
      Shift: TShiftState;
      var EventParams: TfrxInteractiveEventsParams); override;
    function DoMouseDown(X, Y: Integer; Button: TMouseButton;
      Shift: TShiftState; var EventParams: TfrxInteractiveEventsParams)
      : Boolean; override;
    function DoMouseWheel(Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint;
      var EventParams: TfrxInteractiveEventsParams): Boolean; override;
    class function GetDescription: String; override;
    procedure Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended); override;
    procedure AfterPrint; override;
    procedure GetData; override;
    procedure BeforeStartReport; override;
    procedure OnNotify(Sender: TObject); override;
    procedure ClearSeries;
    procedure AddSeries(Series: TfrxChartSeries);
    procedure UpdateSeriesData;

    procedure SaveContentToDictionary(aReport: TfrxReport; PostProcessor: TfrxPostProcessor); override;
    procedure ProcessDictionary(aItem: TfrxMacrosItem; aReport: TfrxReport; PostProcessor: TfrxPostProcessor); override;
    function LoadContentFromDictionary(aReport: TfrxReport; aItem: TfrxMacrosItem): Boolean; override;

    /// <summary>
    ///   Reference to internal TChart object.
    /// </summary>
    property Chart: TCustomChart read FChart;
    /// <summary>
    ///   Settings of the series.
    /// </summary>
    property SeriesData: TfrxSeriesData read FSeriesData;
    property HighlightIndex: Integer read FHLIndex;
    property ClickedVal1: String read FClickedVal1;
    property ClickedVal2: String read FClickedVal2;
    property ClickedVal3: String read FClickedVal3;
    property ClickedVal4: String read FClickedVal4;
    property ClickedVal5: String read FClickedVal5;
    property ClickedVal6: String read FClickedVal6;
    property ClickedVal7: String read FClickedVal7;
    property ClickedVal8: String read FClickedVal8;
    property ClickedVal9: String read FClickedVal9;
    property ClickedVal10: String read FClickedVal10;
  published
    property IgnoreNulls: Boolean read FIgnoreNulls write FIgnoreNulls default False;
    property HighlightColor: TColor read FHighlightColor write FHighlightColor default clHotLight;
    property FillType;
    property Fill;
    property Cursor;
    property Frame;
    property Editable default [ferAllowInPreview];
    property TagStr;
    property URL;
    property Processing;
  end;


implementation

uses
  frxChartHelpers, frxChartRTTI,
{$IFNDEF NO_EDITORS}
  frxChartEditor,
{$ENDIF}
  frxChartInPlaceEditor,
  frxChartClipboard,
  frxDsgnIntf, frxUtils, frxRes, Math
{$IFNDEF NO_CRITICAL_SECTION}
  , SyncObjs
{$ENDIF};

{$IFNDEF NO_CRITICAL_SECTION}
var
  frxCSChart: TCriticalSection;
{$ENDIF}


{ TfrxSeriesItem }

procedure TfrxSeriesItem.SetDataSet(const Value: TfrxDataSet);
begin
  FDataSet := Value;
  if FDataSet = nil then
    FDataSetName := '' else
    FDataSetName := FDataSet.UserName;
end;

procedure TfrxSeriesItem.SetDataSetName(const Value: String);
begin
  FDataSetName := Value;
  if FDataSetName = '' then
    FDataSet := nil
  else  if TfrxSeriesData(Collection).FReport <> nil then
    FDataSet := TfrxSeriesData(Collection).FReport.FindDataSet(FDataSet, FDataSetName);
end;

function TfrxSeriesItem.GetDataSetName: String;
begin
  if FDataSet = nil then
    Result := FDataSetName else
    Result := FDataSet.UserName;
end;

function TfrxSeriesItem.IsUniqueNameStored: Boolean;
begin
  Result := True;
end;


constructor TfrxSeriesItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  Fsl1 := TStringList.Create;
  Fsl2 := TStringList.Create;
  Fsl3 := TStringList.Create;
  Fsl4 := TStringList.Create;
  Fsl5 := TStringList.Create;
  Fsl6 := TStringList.Create;
  Fsl7 := TStringList.Create;
  Fsl8 := TStringList.Create;
  Fsl9 := TStringList.Create;
  Fsl10 := TStringList.Create;
end;

destructor TfrxSeriesItem.Destroy;
begin
  Fsl1.Free;
  Fsl2.Free;
  Fsl3.Free;
  Fsl4.Free;
  Fsl5.Free;
  Fsl6.Free;
  Fsl7.Free;
  Fsl8.Free;
  Fsl9.Free;
  Fsl10.Free;

  inherited;
end;

procedure TfrxSeriesItem.FillSeries(Series: TChartSeries);
var
  i: Integer;
  v1, v2, v3, v4, v5, v6, v7, v8, v9, v10: String;
  Helper: TfrxSeriesHelper;

  procedure Sort;
  var
    i, idx, iStart, SortOrd: Integer;
    d, mMax: Double;
    s: String;
  begin
    if Fsl1.Count <> Fsl2.Count then exit;

   {bug fix, stringList sort all negative values as string }
    if FSortOrder = soAscending then  SortOrd := 1
    else SortOrd := -1;
    iStart := 0;

    while Fsl2.Count > iStart do
    begin
      idx := 0;
      mMax := MaxDouble * SortOrd;
      for i := iStart to Fsl2.Count - 1 do
      begin
        s := Fsl2[i];
        if not frxIsValidFloat(s) then d := 0
        else d := frxStrToFloat(s);
        if d * SortOrd < mMax * SortOrd then
        begin
          mMax := d;
          idx := i;
        end;
      end;
      Fsl1.Move(idx,iStart);
      Fsl2.Move(idx,iStart);
      if idx < Fsl3.Count then Fsl3.Move(idx, iStart);
      if idx < Fsl4.Count then Fsl4.Move(idx, iStart);
      if idx < Fsl5.Count then Fsl5.Move(idx, iStart);
      if idx < Fsl6.Count then Fsl6.Move(idx, iStart);
      if idx < Fsl7.Count then Fsl7.Move(idx, iStart);
      if idx < Fsl8.Count then Fsl8.Move(idx, iStart);
      if idx < Fsl9.Count then Fsl9.Move(idx, iStart);
      if idx < Fsl10.Count then Fsl10.Move(idx, iStart);
      inc(iStart);
    end;
  end;

  procedure MakeTopN;
  var
    i: Integer;
    d: Double;
  begin
    if Fsl1.Count <> Fsl2.Count then exit;
    { for future using
    if FSortOrder <> soNone then Sort;}

    FSortOrder := soDescending;
    Sort;
    d := 0;
    for i := Fsl2.Count - 1 downto FTopN - 1 do
    begin
      d := d + frxStrToFloat(Fsl2[i]);
      Fsl1.Delete(i);
      Fsl2.Delete(i);
      if i < Fsl3.Count then Fsl3.Delete(i);
      if i < Fsl4.Count then Fsl4.Delete(i);
      if i < Fsl5.Count then Fsl5.Delete(i);
      if i < Fsl6.Count then Fsl6.Delete(i);
      if i < Fsl7.Count then Fsl7.Delete(i);
      if i < Fsl8.Count then Fsl8.Delete(i);
      if i < Fsl9.Count then Fsl9.Delete(i);
      if i < Fsl10.Count then Fsl10.Delete(i);
    end;

    Fsl1.Add(FTopNCaption);
    Fsl2.Add(FloatToStr(d));
  end;

begin
  Fsl1.Clear;
  Fsl2.Clear;
  Fsl3.Clear;
  Fsl4.Clear;
  Fsl5.Clear;
  Fsl6.Clear;
  Fsl7.Clear;
  Fsl8.Clear;
  Fsl9.Clear;
  Fsl10.Clear;

  Series.Clear;

  v1 := FValues1;
  if (v1 <> '') and (v1[1] = ';') then
    Delete(v1, 1, 1);
  v2 := FValues2;
  if (v2 <> '') and (v2[1] = ';') then
    Delete(v2, 1, 1);
  v3 := FValues3;
  if (v3 <> '') and (v3[1] = ';') then
    Delete(v3, 1, 1);
  v4 := FValues4;
  if (v4 <> '') and (v4[1] = ';') then
    Delete(v4, 1, 1);
  v5 := FValues5;
  if (v5 <> '') and (v5[1] = ';') then
    Delete(v5, 1, 1);
  v6 := FValues6;
  if (v6 <> '') and (v6[1] = ';') then
    Delete(v6, 1, 1);
  v7 := FValues7;
  if (v7 <> '') and (v7[1] = ';') then
    Delete(v7, 1, 1);
  v8 := FValues8;
  if (v8 <> '') and (v8[1] = ';') then
    Delete(v8, 1, 1);
  v9 := FValues9;
  if (v9 <> '') and (v9[1] = ';') then
    Delete(v9, 1, 1);
  v10 := FValues10;
  if (v10 <> '') and (v10[1] = ';') then
    Delete(v10, 1, 1);

  frxSetCommaText(v1, Fsl1);
  frxSetCommaText(v2, Fsl2);
  frxSetCommaText(v3, Fsl3);
  frxSetCommaText(v4, Fsl4);
  frxSetCommaText(v5, Fsl5);
  frxSetCommaText(v6, Fsl6);
  frxSetCommaText(v7, Fsl7);
  frxSetCommaText(v8, Fsl8);
  frxSetCommaText(v9, Fsl9);
  frxSetCommaText(v10, Fsl10);

  Helper := frxFindSeriesHelper(Series);

  try
    if Fsl2.Count > 0 then
    begin
      if (FTopN > 0) and (FTopN < Fsl2.Count) then
        MakeTopN
      else if FSortOrder <> soNone then
        Sort;

      for i := 0 to Fsl2.Count - 1 do
      begin
        if i < Fsl1.Count then v1 := Fsl1[i] else v1 := '';
        if i < Fsl2.Count then v2 := Fsl2[i] else v2 := '';
        if i < Fsl3.Count then v3 := Fsl3[i] else v3 := '';
        if i < Fsl4.Count then v4 := Fsl4[i] else v4 := '';
        if i < Fsl5.Count then v5 := Fsl5[i] else v5 := '';
        if i < Fsl6.Count then v6 := Fsl6[i] else v6 := '';
        if i < Fsl7.Count then v7 := Fsl7[i] else v7 := '';
        if i < Fsl8.Count then v8 := Fsl8[i] else v8 := '';
        if i < Fsl9.Count then v9 := Fsl9[i] else v9 := '';
        if i < Fsl10.Count then v10 := Fsl10[i] else v10 := '';
        Helper.AddValues(Series, v1, v2, v3, v4, v5, v6, v7, v8 ,v9, v10, FXType)

      end;
    end;

  finally
    Helper.Free;
  end;
end;

{ TfrxSeriesData }

constructor TfrxSeriesData.Create(Report: TfrxReport);
begin
  inherited Create(TfrxSeriesItem);
  FReport := Report;
end;

function TfrxSeriesData.Add: TfrxSeriesItem;
begin
  Result := TfrxSeriesItem(inherited Add);
end;

function TfrxSeriesData.GetSeries(Index: Integer): TfrxSeriesItem;
begin
  Result := TfrxSeriesItem(inherited Items[Index]);
end;


{ TfrxChartView }

constructor TfrxChartView.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  frThreadSynchronize(CreateChart);
  FSeriesData := TfrxSeriesData.Create(Report);
  FHlIndex := -1;
  FSeriesIndex := -1;
  FPenWidth := 0;
  Editable := [ferAllowInPreview];
end;

destructor TfrxChartView.Destroy;
begin
  FChart.Free;
  inherited Destroy;
  FSeriesData.Free;
end;

class function TfrxChartView.GetDescription: String;
begin
  Result := frxResources.Get('obChart');
end;

function TfrxChartView.LoadContentFromDictionary(aReport: TfrxReport;
  aItem: TfrxMacrosItem): Boolean;
var
  i, ItemIdx: Integer;
  function LoadValue(s: String): String;
  begin
    Result := s;
    if TryStrToInt(s, ItemIdx) then
    begin
      Result := aItem.Item[ItemIdx];
    end;
  end;
begin
  Result := False;
  if (aItem = nil) or FMacroLoaded then Exit;
  FMacroLoaded := True;
  for i := FSeriesData.Count - 1 downto 0 do
  begin
    FSeriesData[i].FValues1 := LoadValue(FSeriesData[i].FValues1);
    FSeriesData[i].FValues2 := LoadValue(FSeriesData[i].FValues2);
    FSeriesData[i].FValues3 := LoadValue(FSeriesData[i].FValues3);
    FSeriesData[i].FValues4 := LoadValue(FSeriesData[i].FValues4);
    FSeriesData[i].FValues5 := LoadValue(FSeriesData[i].FValues5);
    FSeriesData[i].FValues6 := LoadValue(FSeriesData[i].FValues6);
    FSeriesData[i].FValues7 := LoadValue(FSeriesData[i].FValues7);
    FSeriesData[i].FValues8 := LoadValue(FSeriesData[i].FValues8);
    FSeriesData[i].FValues9 := LoadValue(FSeriesData[i].FValues9);
    FSeriesData[i].FValues10 := LoadValue(FSeriesData[i].FValues10);
  end;

end;

procedure TfrxChartView.ProcessDictionary(aItem: TfrxMacrosItem; aReport: TfrxReport; PostProcessor: TfrxPostProcessor);
var
  i: Integer;
  procedure SetItemByIndex(aIndex: Integer; aContent: WideString);
  begin
    aItem.Item[aIndex] := aContent;
  end;
begin
  for i := FSeriesData.Count - 1 downto 0 do
  begin
    SetItemByIndex(FSeriesData[i].FValueIndex10, FSeriesData[i].FValues10);
    SetItemByIndex(FSeriesData[i].FValueIndex9, FSeriesData[i].FValues9);
    SetItemByIndex(FSeriesData[i].FValueIndex8, FSeriesData[i].FValues8);
    SetItemByIndex(FSeriesData[i].FValueIndex7, FSeriesData[i].FValues7);
    SetItemByIndex(FSeriesData[i].FValueIndex6, FSeriesData[i].FValues6);
    SetItemByIndex(FSeriesData[i].FValueIndex5, FSeriesData[i].FValues5);
    SetItemByIndex(FSeriesData[i].FValueIndex4, FSeriesData[i].FValues4);
    SetItemByIndex(FSeriesData[i].FValueIndex3, FSeriesData[i].FValues3);
    SetItemByIndex(FSeriesData[i].FValueIndex2, FSeriesData[i].FValues2);
    SetItemByIndex(FSeriesData[i].FValueIndex1, FSeriesData[i].FValues1);
  end;
end;

procedure TfrxChartView.Notification(AComponent: TComponent; Operation: TOperation);
var
  i: Integer;
begin
  inherited;
  if Operation = opRemove then
  begin
    for i := 0 to FSeriesData.Count - 1 do
      if AComponent is TfrxDataSet then
      begin
        if FSeriesData[i].DataSet = AComponent then
          FSeriesData[i].DataSet := nil;
      end
      else if AComponent is TfrxBand then
      begin
        if FSeriesData[i].DataBand = AComponent then
          FSeriesData[i].DataBand := nil;
      end;
  end;
end;


procedure TfrxChartView.ReaderError(Reader: TReader; const Message: string;
  var Handled: Boolean);
begin
  Handled := Pos('PROPERTY', UpperCase(Message)) > 0;
end;

class function TfrxChartView.GetChartClass: TChartClass;
begin
  Result := TChart;
end;

procedure TfrxChartView.CreateChart;
begin
  FChart := GetChartClass.Create(nil);
  with FChart do
  begin
    Color := clWhite;
    BevelInner := bvNone;
    BevelOuter := bvNone;
//{$IFDEF DELPHI19}
//    if FChart.ParentWindow = 0 then
//      FChart.ParentWindow := frxParentForm.Handle;
//{$ENDIF}
    Name := 'Chart';
    Frame.Visible := False;
    View3DOptions.Rotation := 0;
    Title.Text.Text := '';
  end;
  FHlIndex := -1;
  FSeriesIndex := -1;
  FPenWidth := 0;
  if IsSelected and (Report <> nil) and (Report.Designer <> nil) then
    TfrxCustomDesigner(Report.Designer).ReloadObjects;
end;

function TfrxChartView.CreateMetafile: TMetafile;
var
  PrinterHandle: THandle;
  aScaleX, aScaleY: Extended;
begin
  PrinterHandle := GetDC(0);
  try
    GetDisplayScale(PrinterHandle, False, aScaleX, aScaleY);
  finally
    ReleaseDC(0, PrinterHandle);
  end;
  Result := TMetafile.Create;
//  if aScaleX > 1 then
//    aScaleX := 1;
//  if aScaleY > 1 then
//    aScaleY := 1;
  Result.Width := Round(Width * aScaleX);
  Result.Height := Round(Height * aScaleY);
end;

procedure TfrxChartView.DefineProperties(Filer: TFiler);
var
  SaveEvent: TReaderError;
begin
  inherited;
  SaveEvent := nil;
  ResetHighlightSelection;
  if Filer is TReader then
  begin
    SaveEvent := TReader(Filer).OnError;
    TReader(Filer).OnError := ReaderError;
  end;
  try
    Filer.DefineBinaryProperty('Chart', ReadData, WriteData, True);
    Filer.DefineProperty('ChartElevation', ReadData1, WriteData1, True);
    Filer.DefineProperty('SeriesData', ReadData2, WriteData2, True);
  finally
    if Assigned(SaveEvent) then
      TReader(Filer).OnError := SaveEvent;
  end;
end;

procedure TfrxChartView.ReadData(Stream: TStream);
var
  Reader: TReader;
begin
{$IFNDEF NO_CRITICAL_SECTION}
  frxCSChart.Enter;
  try
{$ENDIF}
    FChart.Free;
{$IFNDEF NO_CRITICAL_SECTION}
  finally
    frxCSChart.Leave;
  end;
{$ENDIF}
  frThreadSynchronize(CreateChart);
//  Stream.ReadComponent(FChart);

  Reader := TReader.Create(Stream, 4096);
  Reader.OnError := ReaderError;
  try
    Reader.ReadRootComponent(FChart);
  finally
    Reader.Free;
  end;
  FSeriesFilled := False;
end;

procedure TfrxChartView.WriteData(Stream: TStream);
begin
  Stream.WriteComponent(FChart);
end;

procedure TfrxChartView.ReadData1(Reader: TReader);
begin
  FChart.View3DOptions.Elevation := Reader.ReadInteger;
end;

procedure TfrxChartView.WriteData1(Writer: TWriter);
begin
  Writer.WriteInteger(FChart.View3DOptions.Elevation);
end;

procedure TfrxChartView.ReadData2(Reader: TReader);
begin
  frxReadCollection(FSeriesData, Reader, Self);
end;

procedure TfrxChartView.ResetClickedValues;
begin
  FClickedVal1 := '';
  FClickedVal2 := '';
  FClickedVal3 := '';
  FClickedVal4 := '';
  FClickedVal5 := '';
  FClickedVal6 := '';
  FClickedVal7 := '';
  FClickedVal8 := '';
  FClickedVal9 := '';
  FClickedVal10 := '';
end;

function TfrxChartView.ResetHighlightSelection: Boolean;
begin
  Result := False;
  if FHlIndex <> -1 then
  begin
    FChart.Series[FSeriesIndex].ValueColor[FHlIndex] := FSavedColor;
    if FPenWidth > 0 then
    begin
    //TODO D7
{$IFDEF DELPHI12}
      FChart.Series[FSeriesIndex].Pen.Style := FPenStyle;
      FChart.Series[FSeriesIndex].Pen.Width := FPenWidth;
{$ENDIF}
      FPenWidth := 0;
    end;
    FHlIndex := -1;
    FSeriesIndex := -1;
    Result := True;
  end;
end;

procedure TfrxChartView.SaveContentToDictionary(aReport: TfrxReport;
  PostProcessor: TfrxPostProcessor);
var
  i: Integer;

  function AddValue(var sValue: String): Integer;
  begin
    Result := PostProcessor.Add('', Name, sValue, Processing.ProcessAt, Self,
      (Processing.ProcessAt <> paDefault), False);
    if Result <> -1 then
      sValue := IntToStr(Result)
    else
      sValue := '';
  end;
begin

  for i := 0 to FSeriesData.Count - 1 do
  begin
    FSeriesData[i].FValues1 := FSeriesData[i].FSource1;
    FSeriesData[i].FValues2 := FSeriesData[i].FSource2;
    FSeriesData[i].FValues3 := FSeriesData[i].FSource3;
    FSeriesData[i].FValues4 := FSeriesData[i].FSource4;
    FSeriesData[i].FValues5 := FSeriesData[i].FSource5;
    FSeriesData[i].FValues6 := FSeriesData[i].FSource6;
    FSeriesData[i].FValues7 := FSeriesData[i].FSource7;
    FSeriesData[i].FValues8 := FSeriesData[i].FSource8;
    FSeriesData[i].FValues9 := FSeriesData[i].FSource9;
    FSeriesData[i].FValues10 := FSeriesData[i].FSource10;
    FSeriesData[i].FValueIndex1 := AddValue(FSeriesData[i].FValues1);
    FSeriesData[i].FValueIndex2 := AddValue(FSeriesData[i].FValues2);
    FSeriesData[i].FValueIndex3 := AddValue(FSeriesData[i].FValues3);
    FSeriesData[i].FValueIndex4 := AddValue(FSeriesData[i].FValues4);
    FSeriesData[i].FValueIndex5 := AddValue(FSeriesData[i].FValues5);
    FSeriesData[i].FValueIndex6 := AddValue(FSeriesData[i].FValues6);
    FSeriesData[i].FValueIndex7 := AddValue(FSeriesData[i].FValues7);
    FSeriesData[i].FValueIndex8 := AddValue(FSeriesData[i].FValues8);
    FSeriesData[i].FValueIndex9 := AddValue(FSeriesData[i].FValues9);
    FSeriesData[i].FValueIndex10 := AddValue(FSeriesData[i].FValues10);
  end;
end;


procedure TfrxChartView.UpdateSeriesData;
begin
  FSeriesFilled := False;
end;

procedure TfrxChartView.WriteData2(Writer: TWriter);
begin
  frxWriteCollection(FSeriesData, Writer, Self);
end;

procedure TfrxChartView.FillChart;
var
  i: Integer;
begin
  if FLockFillSeries or (IsDesigning and FSeriesFilled) then Exit;

  for i := 0 to FSeriesData.Count - 1 do
  begin
    if IsDesigning then
      FChart.Series[i].FillSampleValues(5)
    else
      FSeriesData[i].FillSeries(FChart.Series[i]);
  end;
  FSeriesFilled := True;
end;

procedure TfrxChartView.Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX,
  OffsetY: Extended);
var
  rgn: HRGN;
  sDC: Integer;

  procedure PrintChart;
  begin
    FEMF := CreateMetafile;
    try
      frThreadSynchronize(DrawOnMetaFile);
      Canvas.StretchDraw(Rect(FX, FY, FX1, FY1), FEMF);
    finally
      FEMF.Free;
      FEMF := nil;
    end;
  end;

begin
  sDC := 0; rgn := 0; // To prevent warnings
  BeginDraw(Canvas, ScaleX, ScaleY, OffsetX, OffsetY);

  DrawBackground;
  if IsDesigning or ((Processing.ProcessAt <> paDefault) and FMacroLoaded) or (Processing.ProcessAt = paDefault) then
    FillChart;
  FChart.BufferedDisplay := True;
//  if Color = clTransparent then
//    FChart.Color := clWhite else
//    FChart.Color := Color;
  if not IsPrinting and not FObjAsMetafile then
  begin
    sDC := SaveDC(Canvas.Handle);

    rgn := CreateRectRgn(0, 0, MaxInt, MaxInt);
    GetClipRgn(Canvas.Handle, rgn);
    IntersectClipRect(Canvas.Handle,
      Round(FX),
      Round(FY),
      Round(FX1),
      Round(FY1));
  end;

  try
    if IsDesigning then
      FChart.DrawToMetaCanvas(Canvas, Rect(FX, FY, FX1, FY1))
    else
      PrintChart;

  finally
    if not IsPrinting and not FObjAsMetafile then
    begin
      SelectClipRgn(Canvas.Handle, rgn);
      DeleteObject(rgn);
      RestoreDC(Canvas.Handle, sDC);
    end;
  end;
  if not FObjAsMetafile then
    DrawFrame;
  if IsDesigning and IsSelected then
    frxImages.MainButtonImages.Draw(Canvas, FX, FY, 110);
end;

procedure TfrxChartView.DrawOnMetaFile;
var
  EMFCanvas: TMetafileCanvas;
  cWidth, cHeight: Integer;
begin
  if not Assigned(FEMF) then Exit;  
  cWidth := Round(Width);
  cHeight := Round(Height);
  if FEMF.Width / Width > 1 then
  begin
    cWidth := FEMF.Width;
    cHeight := FEMF.Height;
  end;
  EMFCanvas := TMetafileCanvas.Create(FEMF, 0);
  // EMF.Transparent := True;
  EMFCanvas.Lock;
  try
    FChart.DrawToMetaCanvas(EMFCanvas, Rect(0, 0, cWidth, cHeight));
  finally
    EMFCanvas.Unlock;
    EMFCanvas.Free;
  end;
end;

procedure TfrxChartView.AfterPrint;
var
  i: Integer;
begin
  for i := 0 to FSeriesData.Count - 1 do
    with FSeriesData[i] do
    begin
      Values1 := '';
      Values2 := '';
      Values3 := '';
      Values4 := '';
      Values5 := '';
      Values6 := '';
      Values7 := '';
      Values8 := '';
      Values9 := '';
      Values10 := '';
    end;
end;

procedure TfrxChartView.GetData;
var
  i: Integer;
  function ConvertVarToStr(Val: Variant): String;
  begin
    if not FIgnoreNulls and VarIsNull(Val) then
      Result := '0'
    else
      Result := VarToStr(Val)
  end;
begin
  inherited;
  for i := 0 to FSeriesData.Count - 1 do
    with FSeriesData[i] do
      if (DataType = dtDBData) and (DataSet <> nil) then
      begin
        Values1 := '';
        Values2 := '';
        Values3 := '';
        Values4 := '';
        Values5 := '';
        Values6 := '';
        Values7 := '';
        Values8 := '';
        Values9 := '';
        Values10 := '';

        DataSet.First;
        while not DataSet.Eof do
        begin
          if Source1 <> '' then
            Values1 := Values1 + ';' + VarToStr(Report.Calc(Source1));
          if Source2 <> '' then
            Values2 := Values2 + ';' + ConvertVarToStr(Report.Calc(Source2));
          if Source3 <> '' then
            Values3 := Values3 + ';' + ConvertVarToStr(Report.Calc(Source3));
          if Source4 <> '' then
            Values4 := Values4 + ';' + ConvertVarToStr(Report.Calc(Source4));
          if Source5 <> '' then
            Values5 := Values5 + ';' + ConvertVarToStr(Report.Calc(Source5));
          if Source6 <> '' then
            Values6 := Values6 + ';' + ConvertVarToStr(Report.Calc(Source6));
          if Source7 <> '' then
            Values7 := Values7 + ';' + ConvertVarToStr(Report.Calc(Source7));
          if Source8 <> '' then
            Values8 := Values8 + ';' + ConvertVarToStr(Report.Calc(Source8));
          if Source9 <> '' then
            Values9 := Values9 + ';' + ConvertVarToStr(Report.Calc(Source9));
          if Source10 <> '' then
            Values10 := Values10 + ';' + ConvertVarToStr(Report.Calc(Source10));
          DataSet.Next;
        end;
      end
      else if DataType = dtFixedData then
      begin
        Values1 := Source1;
        Values2 := Source2;
        Values3 := Source3;
        Values4 := Source4;
        Values5 := Source5;
        Values6 := Source6;
        Values7 := Source7;
        Values8 := Source8;
        Values9 := Source9;
        Values10 := Source10;
      end
end;

procedure TfrxChartView.BeforeStartReport;
var
  i: Integer;
begin
  for i := 0 to FSeriesData.Count - 1 do
    with FSeriesData[i] do
    begin
      Values1 := '';
      Values2 := '';
      Values3 := '';
      Values4 := '';
      Values5 := '';
      Values6 := '';
      Values7 := '';
      Values8 := '';
      Values9 := '';
      Values10 := '';
    end;
  Report.Engine.NotifyList.Add(Self);
end;

procedure TfrxChartView.OnNotify(Sender: TObject);
var
  i: Integer;
  function ConvertVarToStr(Val: Variant): String;
  begin
    if FIgnoreNulls and VarIsNull(Val) then
      Result := '0'
    else
      Result := VarToStr(Val)
  end;
begin
  inherited;
  for i := 0 to FSeriesData.Count - 1 do
    with FSeriesData[i] do
      if (DataType = dtBandData) and (DataBand = Sender) then
      begin
        Report.CurObject := Self.Name;
        if Source1 <> '' then
          Values1 := Values1 + ';' + VarToStr(Report.Calc(Source1));
        if Source2 <> '' then
          Values2 := Values2 + ';' + ConvertVarToStr(Report.Calc(Source2));
        if Source3 <> '' then
          Values3 := Values3 + ';' + ConvertVarToStr(Report.Calc(Source3));
        if Source4 <> '' then
          Values4 := Values4 + ';' + ConvertVarToStr(Report.Calc(Source4));
        if Source5 <> '' then
          Values5 := Values5 + ';' + ConvertVarToStr(Report.Calc(Source5));
        if Source6 <> '' then
          Values6 := Values6 + ';' + ConvertVarToStr(Report.Calc(Source6));
        if Source7 <> '' then
          Values7 := Values7 + ';' + ConvertVarToStr(Report.Calc(Source7));
        if Source8 <> '' then
          Values8 := Values8 + ';' + ConvertVarToStr(Report.Calc(Source8));
        if Source9 <> '' then
          Values9 := Values9 + ';' + ConvertVarToStr(Report.Calc(Source9));
        if Source10 <> '' then
          Values10 := Values10 + ';' + ConvertVarToStr(Report.Calc(Source10));
      end;
end;

procedure TfrxChartView.AddSeries(Series: TfrxChartSeries);
var
  sc: TSeriesClass;
  s: TChartSeries;
  b: Boolean;
begin
  sc := frxChartSeries[Integer(Series)];
  s := TChartSeries(sc.NewInstance);
  s.Create(Chart);
  Chart.AddSeries(s);
  SeriesData.Add;

  with Chart do
  begin
    b := not (s is TPieSeries);
    View3DOptions.Orthogonal := b;
    AxisVisible := b;
    View3DWalls := b;
  end;
end;

function TfrxChartView.CheckMoveSelector(X, Y: Extended): Boolean;
begin
  Result := (AbsLeft <= X) and (AbsLeft + Width >= X) and (AbsTop <= Y) and (AbsTop + 20 >= Y);
end;

procedure TfrxChartView.ClearSeries;
begin
  FSeriesIndex := -1;
  FHlIndex := -1;
{$IFNDEF NO_CRITICAL_SECTION}
  frxCSChart.Enter;
  try
{$ENDIF}
    FChart.Free;
{$IFNDEF NO_CRITICAL_SECTION}
  finally
    frxCSChart.Leave;
  end;
{$ENDIF}
  frThreadSynchronize(CreateChart);
  SeriesData.Clear;
end;

procedure TfrxChartView.DoMouseMove(X, Y: Integer; Shift: TShiftState;
      var EventParams: TfrxInteractiveEventsParams);
var
  i, Index, SeriesIndex: Integer;
begin
  Index := -1;
  if (FChart.SeriesCount = 0) then Exit;
  if FChart.ParentWindow = 0 then
    FChart.ParentWindow := frxParentForm.Handle;
  SeriesIndex := -1;
  for i  := FChart.SeriesCount - 1 downto 0 do
  begin
    if EventParams.EventSender = esDesigner then
      Index := FChart.Series[i].Clicked(FX + Round(X - AbsLeft * FScaleX), FY + Round(Y - AbsTop * FScaleY))
    else
      Index := FChart.Series[i].Clicked(Round(X / FScaleX - AbsLeft), Round(Y / FScaleY - AbsTop));
    SeriesIndex := i;
    if Index <> -1 then Break;
  end;

  if (Index <> -1) and (Index = FHlIndex) and (FSeriesIndex = SeriesIndex) then
      Exit;

  EventParams.Refresh := ResetHighlightSelection or EventParams.Refresh;
  if Index <> - 1 then
  begin
    FSeriesIndex := SeriesIndex;
    FSavedColor := FChart.Series[FSeriesIndex].ValueColor[Index];
    FHlIndex := Index;
    if EventParams.EventSender = esDesigner then
    begin
    //TODO D7
{$IFDEF DELPHI12}
      FPenStyle := FChart.Series[FSeriesIndex].Pen.Style;
      FPenWidth := FChart.Series[FSeriesIndex].Pen.Width;
      FChart.Series[FSeriesIndex].Pen.Style := psDash;
      FChart.Series[FSeriesIndex].Pen.Width := 3;
{$ENDIF}
    end
    else
    begin
      if not Hyperlink.IsEmpty then
        FChart.Series[FSeriesIndex].ValueColor[Index] := FHighlightColor;
      if SeriesData[FSeriesIndex].Fsl1.Count > Index then
        FClickedVal1 := SeriesData[FSeriesIndex].Fsl1[Index];
      if SeriesData[FSeriesIndex].Fsl2.Count > Index then
        FClickedVal2 := SeriesData[FSeriesIndex].Fsl2[Index];
      if SeriesData[FSeriesIndex].Fsl3.Count > Index then
        FClickedVal3 := SeriesData[FSeriesIndex].Fsl3[Index];
      if SeriesData[FSeriesIndex].Fsl4.Count > Index then
        FClickedVal4 := SeriesData[FSeriesIndex].Fsl4[Index];
      if SeriesData[FSeriesIndex].Fsl5.Count > Index then
        FClickedVal5 := SeriesData[FSeriesIndex].Fsl5[Index];
      if SeriesData[FSeriesIndex].Fsl6.Count > Index then
        FClickedVal6 := SeriesData[FSeriesIndex].Fsl6[Index];
      if SeriesData[FSeriesIndex].Fsl7.Count > Index then
        FClickedVal7 := SeriesData[FSeriesIndex].Fsl7[Index];
      if SeriesData[FSeriesIndex].Fsl8.Count > Index then
        FClickedVal8 := SeriesData[FSeriesIndex].Fsl8[Index];
      if SeriesData[FSeriesIndex].Fsl9.Count > Index then
        FClickedVal9 := SeriesData[FSeriesIndex].Fsl9[Index];
      if SeriesData[FSeriesIndex].Fsl10.Count > Index then
        FClickedVal10 := SeriesData[FSeriesIndex].Fsl10[Index];
    end;
    EventParams.Refresh := not Hyperlink.IsEmpty;
  end
  else
    ResetClickedValues;

  if {(i <> -1) or } not FMouseDown or not FChart.View3D then
  Exit;
//todo D7
{$IFDEF DELPHI12}
  FChart.Aspect.Orthogonal := false;
  FChart.Aspect.RotationFloat := Round(FChart.Aspect.RotationFloat - (X - FMouseOffsetX) / 10) mod 360;
  FChart.Aspect.ElevationFloat := Round(FChart.Aspect.ElevationFloat - (Y - FMouseOffsetY) / 10) mod 360;
  EventParams.Refresh := True;
{$ENDIF}
end;

procedure TfrxChartView.DoMouseUp(X, Y: Integer;
  Button: TMouseButton; Shift: TShiftState;
  var EventParams: TfrxInteractiveEventsParams);
begin
  inherited;
  FMouseDown := False;
  EventParams.Modified := True;
end;

function TfrxChartView.DoMouseWheel(Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint;
  var EventParams: TfrxInteractiveEventsParams): Boolean;
begin
  Result := inherited DoMouseWheel(Shift, WheelDelta, MousePos, EventParams);
  if {(i <> -1) or } not FMouseDown then
  Exit;
{$IFDEF DELPHI12}
  FChart.Aspect.Orthogonal := false;
  FChart.Aspect.ZoomFloat := Round(FChart.Aspect.ZoomFloat - WheelDelta / 10) mod 360;
  EventParams.Refresh := True;
{$ENDIF}
  Result := True;
end;

function TfrxChartView.DoMouseDown(X, Y: Integer;
  Button: TMouseButton; Shift: TShiftState;
  var EventParams: TfrxInteractiveEventsParams): Boolean;
var
  i, j: Integer;
begin
  Result := inherited DoMouseDown(X, Y, Button, Shift, EventParams);
  if (EventParams.EventSender = esPreview) then
  begin
   FMouseDown := True;
   FMouseOffsetX := X;
   FMouseOffsetY := Y;
   Result := FChart.View3D;
   Exit;
  end;
  if (FX + 4 >= X) or (FX1 - 4 <= X) or (FY + 4 >= Y) or (FY1 - 4 <= Y) or
    (EventParams.EventSender <> esDesigner) or (FChart.SeriesCount = 0) or
    (EventParams.EventSender <> esDesigner) or CheckMoveSelector(X / FScaleX,
    Y / FScaleY) or not IsSelected then Exit;
  if FChart.ParentWindow = 0 then
    FChart.ParentWindow := frxParentForm.Handle;
  EventParams.SelectionList.ClearInspectorList;
  i := -1;
  for j := 0 to FChart.SeriesCount - 1 do
  begin
    i := FChart.Series[j].Clicked(FX + Round(X - AbsLeft * FScaleX),
    FY + Round(Y - AbsTop * FScaleY));
    if i <> - 1 then
    begin
      EventParams.SelectionList.Add(FChart.Series[j]);
      break;
    end;
  end;
  if (i = -1) then
    EventParams.SelectionList.Add(FChart);
  Result := True;
end;

procedure TfrxChartView.DoMouseEnter(aPreviousObject: TfrxComponent;
      var EventParams: TfrxInteractiveEventsParams);
begin
  { don't update series for interactive Chart }
//  if EventParams.EventSender = esPreview then
  FLockFillSeries := FSeriesFilled;
end;

procedure TfrxChartView.DoMouseLeave(aNextObject: TfrxComponent;
      var EventParams: TfrxInteractiveEventsParams);
begin
  Inherited;
  ResetHighlightSelection;
  FLockFillSeries := False;
  FMouseDown := False;
end;

initialization
{$IFNDEF TeeChartStd}
{$IFNDEF TeeChartStd7}
{$IFNDEF TeeChartStd8}
{$IFNDEF TeeChartStd9}
{$IFNDEF TeeChart4}
  RegisterTeeStandardSeries;
{$ENDIF}
{$ENDIF}
{$ENDIF}
{$ENDIF}
{$ENDIF}
{$IFDEF DELPHI16}
  StartClassGroup(TControl);
  ActivateClassGroup(TControl);
  GroupDescendentsWith(TfrxChartObject, TControl);
{$ENDIF}
{$IFNDEF NO_CRITICAL_SECTION}
  frxCSChart := TCriticalSection.Create;
{$ENDIF}
  frxObjects.RegisterObject1(TfrxChartView, nil, '', '', 0, 25);

finalization
{$IFNDEF NO_CRITICAL_SECTION}
  frxCSChart.Free;
{$ENDIF}
  frxObjects.UnRegister(TfrxChartView);

end.
