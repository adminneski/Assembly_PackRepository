program InteractiveReportDemo;

uses
  Forms,
  uInteractiveReport in 'uInteractiveReport.pas' {frmInteractiveReport},
  uDemoMain in '..\..\Core\uDemoMain.pas' {frmDemoMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmInteractiveReport, frmInteractiveReport);
  Application.Run;
end.
