program PrintTableDemo;

uses
  Forms,
  uPrintTableMain in 'uPrintTableMain.pas' {frmPrintTableMain},
  uDemoMain in '..\..\Core\uDemoMain.pas' {frmDemoMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrintTableMain, frmPrintTableMain);
  Application.Run;
end.
