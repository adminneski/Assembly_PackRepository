program JSONDemo;

uses
  Forms,
  uJSON in 'uJSON.pas' {frmJSONMain},
  uDemoMain in '..\..\Core\uDemoMain.pas' {frmDemoMain};

{$R *.res}

begin
{$IfDef Delphi10}
  ReportMemoryLeaksOnShutdown := True;
{$EndIf}
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmJSONMain, frmJSONMain);
  Application.Run;
end.
