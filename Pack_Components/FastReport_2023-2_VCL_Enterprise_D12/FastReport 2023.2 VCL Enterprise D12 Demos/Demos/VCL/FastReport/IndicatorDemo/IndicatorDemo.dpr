program IndicatorDemo;

uses
  Forms,
  uIndicator in 'uIndicator.pas' {frmIndicator},
  uDemoMain in '..\..\Core\uDemoMain.pas' {frmDemoMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmIndicator, frmIndicator);
  Application.Run;
end.
