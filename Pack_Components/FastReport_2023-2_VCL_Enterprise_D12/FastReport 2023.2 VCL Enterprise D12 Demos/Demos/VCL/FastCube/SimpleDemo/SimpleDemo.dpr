program SimpleDemo;

uses
  Forms,
  uSimple in 'uSimple.pas' {frmSimpleMain},
  uDemoMain in '..\..\Core\uDemoMain.pas' {frmDemoMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmSimpleMain, frmSimpleMain);
  Application.Run;
end.
