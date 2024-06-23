program RESTClient_Demo;

uses
  Vcl.Forms,
  Frm_Main in 'Frm_Main.pas' {FrmMain},
  GOX.Code.RESTRequest in '..\GOX.Code.RESTRequest.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
