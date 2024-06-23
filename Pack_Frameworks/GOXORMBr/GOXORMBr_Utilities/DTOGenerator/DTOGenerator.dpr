program DTOGenerator;

uses
  Vcl.Forms,
  Frm_Connection in 'Frm_Connection.pas' {FrmConnection},
  Frm_Principal in 'Frm_Principal.pas' {FrmPrincipal};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
