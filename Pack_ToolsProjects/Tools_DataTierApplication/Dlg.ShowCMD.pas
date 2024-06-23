unit Dlg.ShowCMD;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Winapi.ShellAPI, Vcl.ExtCtrls, Gobt_ButtonAdvanced,
  Clipbrd;

type
  TDlgShowCMD = class(TForm)
    Panel1: TPanel;
    btnCopiar: TGoButtonAdvanced;
    btnPrompt: TGoButtonAdvanced;
    Panel2: TPanel;
    MemoCMDLog: TMemo;
    pnCommand: TPanel;
    Panel3: TPanel;
    CheckBox_InLine: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure btnPromptClick(Sender: TObject);
    procedure btnCopiarClick(Sender: TObject);
    procedure CheckBox_InLineClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DlgShowCMD: TDlgShowCMD;

implementation

{$R *.dfm}

procedure TDlgShowCMD.btnCopiarClick(Sender: TObject);
begin
  MemoCMDLog.SelectAll;
  Clipboard.AsText := MemoCMDLog.Text;
end;

procedure TDlgShowCMD.btnPromptClick(Sender: TObject);
begin
  ShellExecute(Self.Handle,'open',PChar('cmd.exe'),nil,PChar('C:\'),SW_SHOWNORMAL);
end;

procedure TDlgShowCMD.CheckBox_InLineClick(Sender: TObject);
begin
  if CheckBox_InLine.Checked then
  begin
    MemoCMDLog.WordWrap := false;
    MemoCMDLog.ScrollBars := TScrollStyle.ssHorizontal;
  end
  else
  begin
    MemoCMDLog.WordWrap := True;
    MemoCMDLog.ScrollBars := TScrollStyle.ssVertical;
  end;
  MemoCMDLog.SetFocus;
end;

procedure TDlgShowCMD.FormShow(Sender: TObject);
begin
  MemoCMDLog.Lines.Clear;
  MemoCMDLog.Lines.LoadFromFile(ExtractFilePath(ParamStr(0))+'DAC\LastCommand.txt');

  if Pos('/Action:Extract',MemoCMDLog.Text) > 0 then
  pnCommand.Caption := 'Command:  /Action:Extract'
  else
  if Pos('/Action:Publish',MemoCMDLog.Text) > 0 then
  pnCommand.Caption := 'Command:  /Action:Publish'
  else
  if Pos('/Action:DeployReport',MemoCMDLog.Text) > 0 then
  pnCommand.Caption := 'Command:  /Action:DeployReport'
  else
  if Pos('/Action:Export',MemoCMDLog.Text) > 0 then
  pnCommand.Caption := 'Command:  /Action:Export'
  else
  if Pos('/Action:Import',MemoCMDLog.Text) > 0 then
  pnCommand.Caption := 'Command:  /Action:Import';

end;

end.
