program DemoWhatsZap;

uses
  Vcl.Forms,
  Frm_Main in 'Frm_Main.pas' {FrmMain},
  GOX.WhatsZap.Singleton in 'GOX.WhatsZap.Singleton.pas',
  GOX.Core.Zap.Api.WaMe in 'Core\GOX.Core.Zap.Api.WaMe.pas',
  GOX.Core.Zap.Api.ZApi in 'Core\GOX.Core.Zap.Api.ZApi.pas',
  GOX.Core.Zap.Emojis in 'Core\GOX.Core.Zap.Emojis.pas',
  GOX.Core.Zap.Interfaces in 'Core\GOX.Core.Zap.Interfaces.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
  //
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
