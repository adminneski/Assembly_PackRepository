
{******************************************}
{                                          }
{             FastReport VCL               }
{         GPS Exchange Format File         }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxGPXFileFormat;

{$I frx.inc}

interface

uses
  frXML, Classes, frxMapHelpers, frxAnaliticGeometry, Contnrs;

type
  TGPXAnyPoint = class(TTaggedElement)
  private
    FLatitude: Double;
    FLongitude: Double;
  protected
  public
    constructor Create(Lat, Lon: Double);

    property Latitude: Double read FLatitude;
    property Longitude: Double read FLongitude;
  end;

  TGPXTrackSegment = class(TTaggedElement)
  private
    FTrackPoints: TObjectList;
  public
    constructor Create;
    destructor Destroy; override;
    procedure GetSegmentPoints(out DPA: TDoublePointArray);
  end;

  TGPXTrack = class(TTaggedElement)
  private
    FTrackSegments: TObjectList;

    function GetShapeType: TShapeType;
    function GetCount: integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure GetSegmentPoints(iTrackSegment: Integer; out DPA: TDoublePointArray);

    property Count: integer read GetCount;
    property ShapeType: TShapeType read GetShapeType;
  end;

  TGPXFile = class
  private
    FXmin: Double;
    FYmin: Double;
    FXmax: Double;
    FYmax: Double;
    function GetCountOfTracks: Integer;
    function GetCountOfWayPoints: Integer;
    function GetWayPoints(Index: integer): TGPXAnyPoint;
    function GetTracks(Index: integer): TGPXTrack;
  protected
    FWayPoints: TObjectList;
    FTracks: TObjectList;
    FValidBounds: Boolean;

    procedure Load(const FileName: string);
    procedure LoadBounds(XMLItem: TfrXMLItem);
    procedure LoadMetadata(XMLItem: TfrXMLItem);
    function fnLoadAnyPoint(XMLItem: TfrXMLItem): TGPXAnyPoint;
    function fnLoadTrack(XMLItem: TfrXMLItem): TGPXTrack;
    function fnLoadTrackSegment(XMLItem: TfrXMLItem): TGPXTrackSegment;
    function fnLoadRoute(XMLItem: TfrXMLItem): TGPXTrack;
    procedure ParseItem(XMLItem: TfrXMLItem);
  public
    constructor Create(const FileName: string);
    destructor Destroy; override;
    function IsValidBounds: Boolean;

    property Xmin: Double read FXmin;
    property Ymin: Double read FYmin;
    property Xmax: Double read FXmax;
    property Ymax: Double read FYmax;

    property CountOfWayPoints: Integer read GetCountOfWayPoints;
    property WayPoints[Index: integer]: TGPXAnyPoint read GetWayPoints;
    property CountOfTracks: Integer read GetCountOfTracks;
    property Tracks[Index: integer]: TGPXTrack read GetTracks;
  end;

implementation

uses
  SysUtils, Math, frxUtils;

{ TGPXAnyPoint }

constructor TGPXAnyPoint.Create(Lat, Lon: Double);
begin
  inherited Create;

  FLatitude := Lat;
  FLongitude := Lon;
end;

{ TGPXFile }

constructor TGPXFile.Create(const FileName: string);
begin
  FWayPoints := TObjectList.Create;
  FTracks := TObjectList.Create;
  FValidBounds := False;

  Load(FileName);
end;

destructor TGPXFile.Destroy;
begin
  FWayPoints.Free;
  FTracks.Free;

  inherited;
end;

function TGPXFile.fnLoadRoute(XMLItem: TfrXMLItem): TGPXTrack;
var
  loName: String;
  i: Integer;
  TrackSegment: TGPXTrackSegment;
begin
  Result := TGPXTrack.Create;
  TrackSegment := TGPXTrackSegment.Create;
  for i := 0 to XMLItem.Count - 1 do
    with XMLItem.Items[i] do
    begin
      loName := AnsiLowerCase(Name);
      if loName = 'rtept' then
        TrackSegment.FTrackPoints.Add(fnLoadAnyPoint(XMLItem.Items[i]))
      else
        Result.AddTag(Name, Value);
    end;
  Result.FTrackSegments.Add(TrackSegment)
end;

function TGPXFile.fnLoadTrack(XMLItem: TfrXMLItem): TGPXTrack;
var
  loName: String;
  i: Integer;
begin
  Result := TGPXTrack.Create;
  for i := 0 to XMLItem.Count - 1 do
    with XMLItem.Items[i] do
    begin
      loName := AnsiLowerCase(Name);
      if loName = 'trkseg' then
        Result.FTrackSegments.Add(fnLoadTrackSegment(XMLItem.Items[i]))
      else
        Result.AddTag(Name, Value);
    end;
end;

function TGPXFile.fnLoadTrackSegment(XMLItem: TfrXMLItem): TGPXTrackSegment;
var
  loName: String;
  i: Integer;
begin
  Result := TGPXTrackSegment.Create;
  for i := 0 to XMLItem.Count - 1 do
    with XMLItem.Items[i] do
    begin
      loName := AnsiLowerCase(Name);
      if loName = 'trkpt' then
        Result.FTrackPoints.Add(fnLoadAnyPoint(XMLItem.Items[i]))
      else
        Result.AddTag(Name, Value);
    end;
end;

function TGPXFile.fnLoadAnyPoint(XMLItem: TfrXMLItem): TGPXAnyPoint;
var
  lat, lon: Double;
  i: Integer;
begin
  lat := frxStrToFloat(XMLItem.Prop['lat']);
  lon := frxStrToFloat(XMLItem.Prop['lon']);
  Result := TGPXAnyPoint.Create(lat, lon);
  for i := 0 to XMLItem.Count - 1 do
    with XMLItem.Items[i] do
      Result.AddTag(Name, Value);
end;

function TGPXFile.GetCountOfTracks: Integer;
begin
  Result := FTracks.Count;
end;

function TGPXFile.GetCountOfWayPoints: Integer;
begin
  Result := FWayPoints.Count;
end;

function TGPXFile.GetTracks(Index: integer): TGPXTrack;
begin
  Result := TGPXTrack(FTracks[Index]);
end;

function TGPXFile.GetWayPoints(Index: integer): TGPXAnyPoint;
begin
  Result := TGPXAnyPoint(FWayPoints[Index]);
end;

function TGPXFile.IsValidBounds: Boolean;
begin
  Result := FValidBounds;
end;

procedure TGPXFile.Load(const FileName: string);
var
  MapXMLDocument: TfrxMapXMLDocument;
  Item: TfrXMLItem;
begin
  MapXMLDocument := TfrxMapXMLDocument.Create;
  Item := nil;
  try
    MapXMLDocument.InitMapXMLFile(FileName);
    repeat
      Item := TfrXMLItem.Create;
      if MapXMLDocument.IsReadItem(Item) then
        ParseItem(Item)
      else
        Break;
      Item.Free;
    until False;
  finally
    Item.Free;
    MapXMLDocument.DoneMapXMLFile;
    MapXMLDocument.Free;
  end;
end;

procedure TGPXFile.LoadBounds(XMLItem: TfrXMLItem);
begin
  if FValidBounds then
  begin
    FXmin := Min(FXmin, frxStrToFloat(XMLItem.Prop['minlon']));
    FYmin := Min(FYmin, frxStrToFloat(XMLItem.Prop['minlat']));
    FXmax := Max(FXmax, frxStrToFloat(XMLItem.Prop['maxlon']));
    FYmax := Max(FYmax, frxStrToFloat(XMLItem.Prop['maxlat']));
  end
  else
  begin
    FXmin := frxStrToFloat(XMLItem.Prop['minlon']);
    FYmin := frxStrToFloat(XMLItem.Prop['minlat']);
    FXmax := frxStrToFloat(XMLItem.Prop['maxlon']);
    FYmax := frxStrToFloat(XMLItem.Prop['maxlat']);
    FValidBounds := True;
  end;
end;

procedure TGPXFile.LoadMetadata(XMLItem: TfrXMLItem);
var
  loName: String;
  i: Integer;
begin
  for i := 0 to XMLItem.Count - 1 do
    with XMLItem.Items[i] do
    begin
      loName := AnsiLowerCase(Name);
      if loName = 'bounds' then
        LoadBounds(XMLItem.Items[i]);
    end;
end;

procedure TGPXFile.ParseItem(XMLItem: TfrXMLItem);
var
  loName: String;
begin
  loName := AnsiLowerCase(XMLItem.Name);
  if      loName = 'bounds' then
    LoadBounds(XMLItem)
  else if loName = 'metadata' then
    LoadMetadata(XMLItem)
  else if loName = 'wpt' then
    FWayPoints.Add(fnLoadAnyPoint(XMLItem))
  else if loName = 'trk' then
    FTracks.Add(fnLoadTrack(XMLItem))
  else if loName = 'rte' then
    FTracks.Add(fnLoadRoute(XMLItem));
end;

{ TGPXTrack }

constructor TGPXTrack.Create;
begin
  inherited Create;
  FTrackSegments := TObjectList.Create;
end;

destructor TGPXTrack.Destroy;
begin
  FTrackSegments.Free;

  inherited;
end;

function TGPXTrack.GetCount: integer;
begin
  Result := FTrackSegments.Count;
end;

procedure TGPXTrack.GetSegmentPoints(iTrackSegment: Integer; out DPA: TDoublePointArray);
begin
  TGPXTrackSegment(FTrackSegments[iTrackSegment]).GetSegmentPoints(DPA);
end;

function TGPXTrack.GetShapeType: TShapeType;
begin
  if Count = 1 then Result := stPolyLine
  else              Result := stMultiPolyLine
end;

{ TGPXTrackSegment }

constructor TGPXTrackSegment.Create;
begin
  inherited Create;
  FTrackPoints := TObjectList.Create;
end;

destructor TGPXTrackSegment.Destroy;
begin
  FTrackPoints.Free;

  inherited;
end;

procedure TGPXTrackSegment.GetSegmentPoints(out DPA: TDoublePointArray);
var
  iPoint: Integer;
begin
  SetLength(DPA, FTrackPoints.Count);
  for iPoint := 0 to High(DPA) do
    with TGPXAnyPoint(FTrackPoints[iPoint]) do
      DPA[iPoint] := DoublePoint(Longitude, Latitude);
end;

end.
