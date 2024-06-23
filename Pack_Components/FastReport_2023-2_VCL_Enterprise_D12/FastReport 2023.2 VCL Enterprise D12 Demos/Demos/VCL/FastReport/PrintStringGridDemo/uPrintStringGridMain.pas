unit uPrintStringGridMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  frxClass, StdCtrls, Grids, frxCross, frCoreClasses,
  uDemoMain, XPMan, ImgList, ActnList, Menus;

type
  TfrmPrintStringGridMain = class(TfrmDemoMain)
    Button1: TButton;
    StringGrid1: TStringGrid;
    frxCrossObject1: TfrxCrossObject;
    frxReport1: TfrxReport;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure frxReport1BeforePrint(c: TfrxReportComponent);
  protected
    function GetCaption: string; override;
  end;

var
  frmPrintStringGridMain: TfrmPrintStringGridMain;

implementation

{$R *.DFM}

procedure TfrmPrintStringGridMain.FormCreate(Sender: TObject);
var
  i, j: Integer;
begin
  for i := 1 to 16 do
    for j := 1 to 16 do
      StringGrid1.Cells[i - 1, j - 1] := IntToStr(i * j);
end;

procedure TfrmPrintStringGridMain.Button1Click(Sender: TObject);
begin
  frxReport1.ShowReport;
end;

procedure TfrmPrintStringGridMain.frxReport1BeforePrint(c: TfrxReportComponent);
var
  Cross: TfrxCrossView;
  i, j: Integer;
begin
  if c is TfrxCrossView then
  begin
    Cross := TfrxCrossView(c);
    for i := 1 to 16 do
      for j := 1 to 16 do
        Cross.AddValue([i], [j], [StringGrid1.Cells[i - 1, j - 1]]);
  end;
end;

function TfrmPrintStringGridMain.GetCaption: string;
begin
  Result := 'Print a String Grid Demo';
end;

end.
