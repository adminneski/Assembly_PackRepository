program ToolsCreateReportServer;

uses
  Forms,
  MainReportCreate in 'MainReportCreate.pas' {FrmMainReportCreate},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Neski Report Create Server';
  Application.CreateForm(TFrmMainReportCreate, FrmMainReportCreate);
  Application.Run;
end.
