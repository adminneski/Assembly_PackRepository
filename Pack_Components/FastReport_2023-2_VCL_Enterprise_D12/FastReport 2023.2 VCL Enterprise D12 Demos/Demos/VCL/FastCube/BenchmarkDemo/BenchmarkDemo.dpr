program BenchmarkDemo;

uses
  Forms,
  uDemoMain in '..\..\Core\uDemoMain.pas' {frmDemoMain},
  uBenchmark in 'uBenchmark.pas' {frmBenchmarkMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmBenchmarkMain, frmBenchmarkMain);
  Application.Run;
end.
