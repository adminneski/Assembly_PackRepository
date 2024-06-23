program EmbedDesignerDemo;

uses
  Forms,
  uEmbedDesigner in 'uEmbedDesigner.pas' {frmEmbedDesigner},
  uDemoMain in '..\..\Core\uDemoMain.pas' {frmDemoMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmEmbedDesigner, frmEmbedDesigner);
  Application.Run;
end.
