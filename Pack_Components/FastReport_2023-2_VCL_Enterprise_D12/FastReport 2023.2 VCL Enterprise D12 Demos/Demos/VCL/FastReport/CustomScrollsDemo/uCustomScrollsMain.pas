unit uCustomScrollsMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, frxClass, frxPreview, frCoreClasses,
  uDemoMain, ExtCtrls, XPMan, ImgList, ActnList, Menus;

type
  TfrmCustomScrollsMain = class(TfrmDemoMain)
    frxPreview: TfrxPreview;
    frxReport: TfrxReport;
    HScroll: TScrollBar;
    VScroll: TScrollBar;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure HScrollScroll(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
    procedure VScrollScroll(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
    procedure frxPreviewOnScrollPosChange(Sender: TObject; Orientation: TfrxScrollerOrientation; var Value: Integer);
    procedure frxPreviewOnScrollMaxChange(Sender: TObject; Orientation: TfrxScrollerOrientation; Value: Integer);
  protected
    function GetCaption: string; override;
  end;

var
  frmCustomScrollsMain: TfrmCustomScrollsMain;

implementation

{$R *.dfm}

procedure TfrmCustomScrollsMain.FormCreate(Sender: TObject);
begin
  frxReport.Preview := frxPreview;
  frxReport.PrepareReport();
end;

procedure TfrmCustomScrollsMain.HScrollScroll(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
  frxPreview.Workspace.HorzPosition := ScrollPos;
end;

procedure TfrmCustomScrollsMain.VScrollScroll(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
  frxPreview.Workspace.VertPosition := ScrollPos;
end;

procedure TfrmCustomScrollsMain.frxPreviewOnScrollMaxChange(Sender: TObject; Orientation: TfrxScrollerOrientation; Value: Integer);
begin
  if (Orientation = frsVertical) then
  begin
    if (VScroll <> nil) then //not needed under Lazarus
      VScroll.Max := Value;
  end
  else
    if (HScroll <> nil) then //not needed under Lazarus
      HScroll.Max := Value;
end;

procedure TfrmCustomScrollsMain.frxPreviewOnScrollPosChange(Sender: TObject; Orientation: TfrxScrollerOrientation; var Value: Integer);
begin
  if (Orientation = frsVertical) then
  begin
    if (VScroll <> nil) then //not needed under Lazarus
      VScroll.Position := Value;
  end
  else
    if (HScroll <> nil) then //not needed under Lazarus
      HScroll.Position := Value;
end;

function TfrmCustomScrollsMain.GetCaption: string;
begin
  Result := 'Custom Scroll Demo';
end;

end.
