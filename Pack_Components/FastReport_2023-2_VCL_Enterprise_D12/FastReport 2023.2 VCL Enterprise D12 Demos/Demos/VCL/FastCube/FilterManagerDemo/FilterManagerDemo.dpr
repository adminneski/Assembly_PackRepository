program FilterManagerDemo;

uses
  Forms,
  uFilterManager in 'uFilterManager.pas' {frmFilterManagerMain},
  uDemoMain in '..\..\Core\uDemoMain.pas' {frmDemoMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmFilterManagerMain, frmFilterManagerMain);
  Application.Run;
end.
