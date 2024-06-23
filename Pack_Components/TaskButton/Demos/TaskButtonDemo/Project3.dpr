program Project3;

uses
  Vcl.Forms,
  Unit3 in 'Unit3.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
//  NeverSleepOnMMThreadContention := True;
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
