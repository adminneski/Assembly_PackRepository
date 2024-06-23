program ZPLDemo;

uses
  Forms,
  uZPLMain in 'uZPLMain.pas' {frmZPL},
  uDemoMain in '..\..\Core\uDemoMain.pas' {frmDemoMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmZPL, frmZPL);
  Application.Run;
end.
