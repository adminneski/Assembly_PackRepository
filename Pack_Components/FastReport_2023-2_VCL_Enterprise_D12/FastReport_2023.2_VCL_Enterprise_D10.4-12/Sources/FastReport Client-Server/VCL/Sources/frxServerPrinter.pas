
{******************************************}
{                                          }
{             FastReport VCL               }
{             Server printer               }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxServerPrinter;

{$I frx.inc}
{$IFDEF DELPHI12}
{$WARNINGS OFF}
{$ENDIF}

interface

uses
     {$IFNDEF Linux}
     Windows,
     {$ENDIF}
     SysUtils, Classes, frxPrinter, frxClass, frxServerCache,
	frUnicodeUtils, SyncObjs, frxServerTemplates, frxNetUtils;

type
   TfrxServerPrintQueue = class;
   TfrxServerPrintJob = class;

   TfrxServerPrinter = class(TThread)
   private
    FQueue: TfrxServerPrintQueue;
    FTemplate: TfrxServerTemplate;
    FThreadActive: Boolean;
    procedure ProcessJobs;
   protected
     procedure Execute; override;
   public
     constructor Create;
     destructor Destroy; override;
     function GetHTML(const SessionId: String; const Report: String): String;
     procedure AddPrintJob(const SessionId: String; Printer: String; const Pages: String; Copies: Integer; Collate: Boolean; Reverse: Boolean);
     property Queue: TfrxServerPrintQueue read FQueue;
     property Template: TfrxServerTemplate read FTemplate;
   end;

   TfrxServerPrintQueue = class(TCollection)
   private
    function GetItems(Index: Integer): TfrxServerPrintJob;
   public
    constructor Create;
    destructor Destroy; override;
    property Items[Index: Integer]: TfrxServerPrintJob read GetItems;
    procedure Clear;
    function Add: TfrxServerPrintJob;
   end;

   TfrxServerPrintJob = class(TCollectionItem)
   private
    FSession: String;
    FFileName: String;
    FReport: TfrxReport;
   public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    property FileName: String read FFileName write FFileName;
    property Session: String read FSession write FSession;
    property Report: TfrxReport read FReport;
   end;

var
  PrintCS1: TCriticalSection;
  ServerPrinter: TfrxServerPrinter;

implementation

{ TfrxServerPrinter }

procedure TfrxServerPrinter.AddPrintJob(const SessionId: String;
  Printer: String; const Pages: String; Copies: Integer; Collate,
  Reverse: Boolean);
begin
  PrintCS1.Enter;
  try
    with FQueue.Add do
    begin
      if SessionId <> '' then
        ReportCache.GetCachedReportById(Report, SessionId);
      Report.FileName := 'Report Server:' + Report.ReportOptions.Name;
      Report.PrintOptions.Printer := Printer;
      Report.PrintOptions.PageNumbers := Pages;
      Report.PrintOptions.Copies := Copies;
      Report.PrintOptions.Collate := Collate;
      Report.PrintOptions.Reverse := Reverse;
    end;
  finally
    PrintCS1.Leave;
  end;
end;

constructor TfrxServerPrinter.Create;
begin
  inherited Create(False);
  FQueue := TfrxServerPrintQueue.Create;
  FTemplate := TfrxServerTemplate.Create;
{$IFNDEF DELPHI12}
  Resume;
{$ENDIF}
end;

destructor TfrxServerPrinter.Destroy;
begin
  Terminate;
  PMessages;
  while FThreadActive do
    Sleep(10);
//  PMessages;
  FTemplate.Free;
  FQueue.Free;
  inherited;
end;

procedure TfrxServerPrinter.Execute;
begin
  FThreadActive := True;
  while not Terminated do
  begin
    ProcessJobs;
    Sleep(100);
    PMessages;
  end;
  FThreadActive := False;
end;

function TfrxServerPrinter.GetHTML(const SessionId,
  Report: String): String;
var
  s: String;
  i: Integer;
begin
  Template.SetTemplate('print');
  Template.Variables.AddVariable('SESSION', SessionID);
  Template.Variables.AddVariable('REPORT', Utf8Encode(Report));
  s := '';
  for i := 0 to frxPrinters.Printers.Count - 1 do
    s := s + '<option prn' + IntToStr(i) + 'value="' + IntToStr(i) + '">' + Utf8Encode(frxPrinters.Printers[i]) + '</option>'#13#10;
  Template.Variables.AddVariable('PRINTERS', s);
  Template.Prepare;
  Result := Template.TemplateStrings.Text;
end;

procedure TfrxServerPrinter.ProcessJobs;
begin
  PrintCS1.Enter;
  try
    if FQueue.Count > 0 then
    begin
      if FQueue.Items[0].Report.PreviewPages.Count > 0 then
        FQueue.Items[0].Report.Print;
      FQueue.Items[0].Free;
    end;
  finally
    PrintCS1.Leave;
  end;
end;

{ TfrxServerPrintJob }

constructor TfrxServerPrintJob.Create(Collection: TCollection);
begin
  inherited;
  FReport := TfrxReport.Create(nil);
  FReport.ShowProgress := False;
  FReport.EngineOptions.EnableThreadSafe := True;
  FReport.PrintOptions.ShowDialog := False;
  FReport.PrintOptions.Collate := True;
  FReport.PrintOptions.Copies := 1;
  if frxPrinters.Printers.Count > 0 then
    FReport.PrintOptions.Printer := frxPrinters.Printers[0];
end;

destructor TfrxServerPrintJob.Destroy;
begin
  FReport.Free;
  inherited;
end;

{ TfrxServerPrintQueue }

function TfrxServerPrintQueue.Add: TfrxServerPrintJob;
begin
  Result := TfrxServerPrintJob.Create(Self);
end;

procedure TfrxServerPrintQueue.Clear;
begin
//
  inherited Clear;
end;

constructor TfrxServerPrintQueue.Create;
begin
  inherited Create(TfrxServerPrintJob);
end;

destructor TfrxServerPrintQueue.Destroy;
begin
//
  inherited;
end;

function TfrxServerPrintQueue.GetItems(Index: Integer): TfrxServerPrintJob;
begin
  Result := TfrxServerPrintJob(inherited Items[Index]);
end;

initialization
  PrintCS1 := TCriticalSection.Create;

finalization
  PrintCS1.Free;

end.

