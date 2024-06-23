program ToolsSQLServer2019ExpressInstall;

uses
  Vcl.Forms,
  Frm_Main in 'Frm_Main.pas' {FrmMAIN},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Carbon');
  Application.CreateForm(TFrmMAIN, FrmMAIN);
  Application.Run;
end.
