program SignWithoutDialogDemo;

uses
  Forms,
  uDemoMain in '..\..\Core\uDemoMain.pas' {frmDemoMain},
  uSignWithoutDialog in 'uSignWithoutDialog.pas' {frmSignWithoutDialog};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmSignWithoutDialog, frmSignWithoutDialog);
  Application.Run;
end.
