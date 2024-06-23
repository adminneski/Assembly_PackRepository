program PrintStringGridDemo;

uses
  Forms,
  uPrintStringGridMain in 'uPrintStringGridMain.pas' {frmPrintStringGridMain},
  uDemoMain in '..\..\Core\uDemoMain.pas' {frmDemoMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrintStringGridMain, frmPrintStringGridMain);
  Application.Run;
end.
