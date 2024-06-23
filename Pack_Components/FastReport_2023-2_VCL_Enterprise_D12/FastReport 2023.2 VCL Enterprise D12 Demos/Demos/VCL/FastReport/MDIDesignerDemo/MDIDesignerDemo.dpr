program MDIDesignerDemo;

uses
  Forms,
  uMDIDesigner in 'uMDIDesigner.PAS' {frmMDIDesigner},
  dmMDIDesigner in 'dmMDIDesigner.pas' {ReportData: TDataModule},
  uDemoMain in '..\..\Core\uDemoMain.pas' {frmDemoMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TReportData, ReportData);
  Application.CreateForm(TfrmMDIDesigner, frmMDIDesigner);
  Application.Run;
end.
