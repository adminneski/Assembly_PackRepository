program PrintStringListDemo;

uses
  Forms,
  uPrintStringListMain in 'uPrintStringListMain.pas' {frmPrintStringListMain},
  uDemoMain in '..\..\Core\uDemoMain.pas' {frmDemoMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrintStringListMain, frmPrintStringListMain);
  Application.Run;
end.
