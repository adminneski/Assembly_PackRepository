program PrintArrayDemo;

uses
  Forms,
  uDemoMain in '..\..\Core\uDemoMain.pas',
  uPrintArrayMain in 'uPrintArrayMain.pas' {frmPrintArrayMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrintArrayMain, frmPrintArrayMain);
  Application.Run;
end.
