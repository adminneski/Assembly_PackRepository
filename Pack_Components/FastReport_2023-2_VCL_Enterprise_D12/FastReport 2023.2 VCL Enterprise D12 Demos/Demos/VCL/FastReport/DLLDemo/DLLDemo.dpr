program DLLDemo;

uses
  Forms,
  uCallDLL in 'uCallDLL.pas' {frmCallDLL},
  uDemoMain in '..\..\Core\uDemoMain.pas' {frmDemoMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmCallDLL, frmCallDLL);
  Application.Run;
end.
