program UserDatasetDemo;

uses
  Forms,
  uUserDataset in 'uUserDataset.pas' {frmUserDataset},
  uDemoMain in '..\..\Core\uDemoMain.pas' {frmDemoMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmUserDataset, frmUserDataset);
  Application.Run;
end.
