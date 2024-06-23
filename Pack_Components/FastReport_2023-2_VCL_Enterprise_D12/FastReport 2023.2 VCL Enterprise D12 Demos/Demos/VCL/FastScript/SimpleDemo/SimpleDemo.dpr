program SimpleDemo;

uses
  Forms,
  uSimple in 'uSimple.pas' {frmSimpleMain},
  uDemoMain in '..\..\Core\uDemoMain.pas' {frmDemoMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmSimpleMain, frmSimpleMain);
  Application.CreateForm(TfrmDemoMain, frmDemoMain);
  Application.Run;
end.
