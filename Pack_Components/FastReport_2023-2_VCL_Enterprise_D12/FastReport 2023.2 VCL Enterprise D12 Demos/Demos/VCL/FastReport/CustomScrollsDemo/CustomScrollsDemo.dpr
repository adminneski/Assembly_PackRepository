program CustomScrollsDemo;

uses
  Forms,
  uCustomScrollsMain in 'uCustomScrollsMain.pas' {frmCustomScrollsMain},
  uDemoMain in '..\..\Core\uDemoMain.pas' {frmDemoMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmCustomScrollsMain, frmCustomScrollsMain);
  Application.CreateForm(TfrmDemoMain, frmDemoMain);
  Application.Run;
end.
