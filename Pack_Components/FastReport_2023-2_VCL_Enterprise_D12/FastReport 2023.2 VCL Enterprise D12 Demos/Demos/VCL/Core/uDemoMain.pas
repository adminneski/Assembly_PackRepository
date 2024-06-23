unit uDemoMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  frCore, frBaseForm,
  Dialogs, ImgList, ActnList, Menus, XPMan, System.ImageList, System.Actions;

type
  TfrmDemoMain = class(TfrBaseForm)
    mmMain: TMainMenu;
    alMain: TActionList;
    ilMain: TImageList;
    File1: TMenuItem;
    Help1: TMenuItem;
    Exit1: TMenuItem;
    aExit: TAction;
    Gotosite1: TMenuItem;
    aGoToSite: TAction;
    XPManifest1: TXPManifest;
    AboutFastReport1: TMenuItem;
    aShowAbout: TAction;
    procedure aExitExecute(Sender: TObject);
    procedure aGoToSiteExecute(Sender: TObject);
    procedure aShowAboutExecute(Sender: TObject);
  protected
    procedure DoShow; override;

    function GetCaption: string; virtual;
  public
  end;

var
  frmDemoMain: TfrmDemoMain;

implementation

uses
  frAbout;

{$R *.dfm}

procedure TfrmDemoMain.aExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TfrmDemoMain.aGoToSiteExecute(Sender: TObject);
begin
  frShellExecute('https://www.fast-report.com');
end;

procedure TfrmDemoMain.aShowAboutExecute(Sender: TObject);
begin
  frShowAboutForm(Self);
end;

procedure TfrmDemoMain.DoShow;
begin
  inherited DoShow;
  Caption := Format('%s - Fast Reports, Inc.', [GetCaption]);
end;

function TfrmDemoMain.GetCaption: string;
begin
  Result := 'Demo';
end;

end.
