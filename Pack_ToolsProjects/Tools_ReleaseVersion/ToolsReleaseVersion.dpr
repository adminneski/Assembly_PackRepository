program ToolsReleaseVersion;

uses
  Vcl.Forms,
  Frm.Tools.ReleaseVersion in 'Frm.Tools.ReleaseVersion.pas' {FrmToolsReleaseVersion};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:=True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmToolsReleaseVersion, FrmToolsReleaseVersion);
  Application.Run;
end.
