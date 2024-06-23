program CustomReportDataDemo;

uses
  Forms,
  uCustomReportData in 'uCustomReportData.pas' {frmCustomReportDataMain},
  uDemoMain in '..\..\Core\uDemoMain.pas' {frmDemoMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmCustomReportDataMain, frmCustomReportDataMain);
  Application.Run;
end.
