program TeeChartProDemo;

{$I frx.inc}

uses
  Forms,
  uTeeChartPro in 'uTeeChartPro.pas' {frmTeeChartProMain},
  udmTeeChartPro in 'udmTeeChartPro.pas' {dmTeeChartPro: TdmTeeChartPro},
  uDemoMain in '..\..\Core\uDemoMain.pas';

{$R *.RES}

begin
{$IfDef Delphi10}
  ReportMemoryLeaksOnShutdown := True;
{$EndIf}
  Application.Initialize;
  Application.CreateForm(TfrmTeeChartProMain, frmTeeChartProMain);
  Application.CreateForm(TdmTeeChartPro, dmTeeChartPro);
  Application.Run;
end.
