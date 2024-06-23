program FastReportDemo;

//{$I frx.inc}

uses
  Forms,
  uFastReportMain in 'uFastReportMain.pas' {frmFastReportMain},
  udmFastReport in 'udmFastReport.pas' {ReportData: TDataModule},
  uDemoMain in '..\..\Core\uDemoMain.pas' {frmDemoMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmFastReportMain, frmFastReportMain);
  Application.CreateForm(TReportData, ReportData);
  Application.CreateForm(TfrmDemoMain, frmDemoMain);
  Application.Run;
end.
