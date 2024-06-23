unit Dlg.ShowXML;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Winapi.WebView2, Winapi.ActiveX, Vcl.Edge, Vcl.ExtCtrls;

type
  TDlgShowXML = class(TForm)
    EdgeBrowser: TEdgeBrowser;
    pnMSG: TPanel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FReportFileName :String;
  public
    { Public declarations }
    property ReportFileName: String read FReportFileName write FReportFileName;
  end;

var
  DlgShowXML: TDlgShowXML;

implementation

{$R *.dfm}

procedure TDlgShowXML.FormShow(Sender: TObject);
begin
  Self.Height := 768;
  Self.Width  := 1280;
  //
  if Pos('DeployReport',ReportFileName) > 0 then
  begin
    pnMSG.Color := clTeal;
    pnMSG.Caption := 'Schema Compare';
  end;
  if Pos('Publish',ReportFileName) > 0 then
  begin
    pnMSG.Color := clWebOrangeRed;
    pnMSG.Caption := 'Schema Synchronize';
  end;
  EdgeBrowser.Navigate(ExtractFilePath(ParamStr(0))+'DAC\'+ReportFileName);
end;

end.
