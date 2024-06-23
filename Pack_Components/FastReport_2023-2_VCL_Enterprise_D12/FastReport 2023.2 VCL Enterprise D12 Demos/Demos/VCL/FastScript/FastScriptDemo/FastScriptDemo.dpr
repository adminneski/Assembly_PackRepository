program FastScriptDemo;

uses
  Forms,
  uFastScript in 'uFastScript.pas' {frmFastScriptMain},
  uFastScriptEvalute in 'uFastScriptEvalute.pas' {Form2};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmFastScriptMain, frmFastScriptMain);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
