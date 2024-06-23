program AdvancedDemo;

uses
  Forms,
  uAdvancedAbout in 'uAdvancedAbout.pas' {AboutForm},
  uDemoMain in '..\..\Core\uDemoMain.pas' {frmDemoMain},
  uAdvanced in 'uAdvanced.pas' {frmAdvancedMain};

{$R delphi.res}
{$R WindowsXP.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmAdvancedMain, frmAdvancedMain);
  Application.Run;
end.
