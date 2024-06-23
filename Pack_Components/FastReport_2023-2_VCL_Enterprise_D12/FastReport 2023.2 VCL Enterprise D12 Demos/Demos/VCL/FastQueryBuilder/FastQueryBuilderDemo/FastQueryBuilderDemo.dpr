program FastQueryBuilderDemo;

uses
  Forms,
  FastQueryBuilder in 'FastQueryBuilder.pas' {frmFastQueryBuilderMain},
  uDemoMain in '..\..\Core\uDemoMain.pas' {frmDemoMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmFastQueryBuilderMain, frmFastQueryBuilderMain);
  Application.CreateForm(TfrmDemoMain, frmDemoMain);
  Application.Run;
end.
