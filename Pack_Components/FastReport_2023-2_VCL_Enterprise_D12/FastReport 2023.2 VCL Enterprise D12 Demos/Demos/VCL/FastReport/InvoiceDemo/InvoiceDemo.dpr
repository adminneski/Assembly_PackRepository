program InvoiceDemo;

uses
  Forms,
  uInvoice in 'uInvoice.pas' {frmInvoice},
  uDemoMain in '..\..\Core\uDemoMain.pas' {frmDemoMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmInvoice, frmInvoice);
  Application.CreateForm(TfrmDemoMain, frmDemoMain);
  Application.Run;
end.
