program ToolsDataTierApplication;

uses
  Vcl.Forms,
  Frm.Main in 'Frm.Main.pas' {FrmMain},
  GOX.SQLPackage in '..\..\Neski_Tools_Frameworks\GOXCodePack\GOX_SQLPackage\GOX.SQLPackage.pas',
  Dlg.ShowXML in 'Dlg.ShowXML.pas' {DlgShowXML},
  Dlg.ShowCMD in 'Dlg.ShowCMD.pas' {DlgShowCMD};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TDlgShowXML, DlgShowXML);
  Application.CreateForm(TDlgShowCMD, DlgShowCMD);
  Application.Run;
end.
