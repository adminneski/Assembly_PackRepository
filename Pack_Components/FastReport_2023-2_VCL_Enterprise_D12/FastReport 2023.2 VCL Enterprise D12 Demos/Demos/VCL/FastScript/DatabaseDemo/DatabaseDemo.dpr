program DatabaseDemo;

uses
  Forms,
  uDatabase in 'uDatabase.pas' {frmDatabaseMain},
  uDemoMain in '..\..\Core\uDemoMain.pas' {frmDemoMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmDatabaseMain, frmDatabaseMain);
  Application.Run;
end.
