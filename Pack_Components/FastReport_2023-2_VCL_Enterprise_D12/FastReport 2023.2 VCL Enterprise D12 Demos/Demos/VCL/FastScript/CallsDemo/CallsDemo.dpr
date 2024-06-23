program CallsDemo;

uses
  Forms,
  uCalls in 'uCalls.pas' {frmCalls},
  uDemoMain in '..\..\Core\uDemoMain.pas' {frmDemoMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmCallsMain, frmCallsMain);
  Application.Run;
end.
