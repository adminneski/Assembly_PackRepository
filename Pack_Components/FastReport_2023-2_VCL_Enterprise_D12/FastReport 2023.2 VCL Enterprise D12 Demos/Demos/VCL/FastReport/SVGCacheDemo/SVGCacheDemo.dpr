program SVGCacheDemo;

uses
  Forms,
  uSVGCache in 'uSVGCache.pas' {frmSVGCache},
  uDemoMain in '..\..\Core\uDemoMain.pas' {frmDemoMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmSVGCache, frmSVGCache);
  Application.Run;
end.
