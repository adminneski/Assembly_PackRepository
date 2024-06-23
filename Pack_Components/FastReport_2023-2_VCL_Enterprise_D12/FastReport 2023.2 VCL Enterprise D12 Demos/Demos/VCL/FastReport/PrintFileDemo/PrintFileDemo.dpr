program PrintFileDemo;

uses
  Forms,
  uDemoMain in '..\..\Core\uDemoMain.pas' {frmDemoMain},
  uPrintFileMain in 'uPrintFileMain.pas' {frmPrintFileMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrintFileMain, frmPrintFileMain);
  Application.Run;
end.
