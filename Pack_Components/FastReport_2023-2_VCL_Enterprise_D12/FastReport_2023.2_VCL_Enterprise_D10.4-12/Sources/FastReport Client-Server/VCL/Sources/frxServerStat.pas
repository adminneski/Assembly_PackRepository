
{******************************************}
{                                          }
{             FastReport VCL               }
{        HTTP Report Server Statistic      }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxServerStat;

{$I frx.inc}

interface

uses
  SysUtils, Classes;

type
  TfrxServerStatistic = class(TPersistent)
  private
    FStartTime: TDateTime;
    function GetCurrentReportsCount: Integer;
    function GetCurrentSessionsCount: Integer;
    function GetMaxReportsCount: Integer;
    function GetMaxSessionsCount: Integer;
    function GetTotalErrors: Integer;
    function GetTotalReportsCount: Integer;
    function GetTotalSessionsCount: Integer;
    function GetUpTimeDays: Integer;
    function GetUpTimeHours: Integer;
    function GetUpTimeMins: Integer;
    function GetUpTimeSecs: Integer;
    function GetTotalCacheHits: Integer;
    function GetFormatUpTime: String;
    function GetCacheCount: Integer;
  public
    constructor Create;
  published
    property CurrentReportsCount: Integer read GetCurrentReportsCount;
    property CurrentSessionsCount: Integer read GetCurrentSessionsCount;
    property MaxReportsCount: Integer read GetMaxReportsCount;
    property MaxSessionsCount: Integer read GetMaxSessionsCount;
    property TotalErrors: Integer read GetTotalErrors;
    property TotalReportsCount: Integer read GetTotalReportsCount;
    property TotalSessionsCount: Integer read GetTotalSessionsCount;
    property UpTimeDays: Integer read GetUpTimeDays;
    property UpTimeHours: Integer read GetUpTimeHours;
    property UpTimeMins: Integer read GetUpTimeMins;
    property UpTimeSecs: Integer read GetUpTimeSecs;
    property TotalCacheHits: Integer read GetTotalCacheHits;
    property CurrentCacheCount: Integer read GetCacheCount;
    property FormatUpTime: String read GetFormatUpTime;
  end;

var
   ServerStatistic: TfrxServerStatistic;

implementation

uses frxServer, frxServerLog, frxServerCache;

{ TfrxServerStatistic }

function TfrxServerStatistic.GetCurrentReportsCount: Integer;
begin
  Result := LogWriter.CurrentReports;
end;

function TfrxServerStatistic.GetCurrentSessionsCount: Integer;
begin
  Result := LogWriter.CurrentSessions;
end;

function TfrxServerStatistic.GetMaxReportsCount: Integer;
begin
  Result := LogWriter.MaxReports;
end;

function TfrxServerStatistic.GetMaxSessionsCount: Integer;
begin
  Result := LogWriter.MaxSessions;
end;

function TfrxServerStatistic.GetTotalReportsCount: Integer;
begin
  Result := LogWriter.TotalReports;
end;

function TfrxServerStatistic.GetTotalSessionsCount: Integer;
begin
  Result := LogWriter.TotalSessions;
end;

function TfrxServerStatistic.GetTotalErrors: Integer;
begin
  Result := LogWriter.ErrorsCount;
end;

constructor TfrxServerStatistic.Create;
begin
  FStartTime := Now;
end;

function TfrxServerStatistic.GetUpTimeDays: Integer;
begin
  Result := Trunc(Now - FStartTime);
end;

function TfrxServerStatistic.GetUpTimeHours: Integer;
begin
  Result := StrToInt(FormatDateTime('h', Frac(Now - FStartTime)));
end;

function TfrxServerStatistic.GetUpTimeMins: Integer;
begin
  Result := StrToInt(FormatDateTime('n', Frac(Now - FStartTime)));
end;

function TfrxServerStatistic.GetUpTimeSecs: Integer;
begin
  Result := StrToInt(FormatDateTime('s', Frac(Now - FStartTime)));
end;

function TfrxServerStatistic.GetTotalCacheHits: Integer;
begin
  Result := LogWriter.TotalCacheHits;
end;

function TfrxServerStatistic.GetFormatUpTime: String;
begin
 Result := IntToStr(UpTimeDays) + ' days ' +
    IntToStr(UpTimeHours) + ' hours ' +
    IntToStr(UpTimeMins) + ' minutes ' +
    IntToStr(UpTimeSecs) + ' seconds'
end;

function TfrxServerStatistic.GetCacheCount: Integer;
begin
  Result := ReportCache.Heap.Count;
end;

end.
