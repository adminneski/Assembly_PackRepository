program MasterDetailUDSDemo;

uses
  Forms,
  uMasterDetailUDS in 'uMasterDetailUDS.pas' {frmMasterDetailUDS},
  uDemoMain in '..\..\Core\uDemoMain.pas' {frmDemoMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMasterDetailUDS, frmMasterDetailUDS);
  Application.Run;
end.
