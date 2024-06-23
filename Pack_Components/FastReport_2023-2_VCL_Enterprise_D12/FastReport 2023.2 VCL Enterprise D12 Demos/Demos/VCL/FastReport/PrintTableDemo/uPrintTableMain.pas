unit uPrintTableMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uDemoMain,
  frxClass, StdCtrls, frxCross, frCoreClasses, DBClient, DB, ImgList, ActnList,
  Menus;

type
  TfrmPrintTableMain = class(TfrmDemoMain)
    Button1: TButton;
    frxCrossObject1: TfrxCrossObject;
    frxReport1: TfrxReport;
    cdsData: TClientDataSet;
    procedure Button1Click(Sender: TObject);
    procedure frxReport1BeforePrint(Sender: TfrxReportComponent);
    procedure FormCreate(Sender: TObject);
  protected
    function GetCaption: string; override;
  end;

var
  frmPrintTableMain: TfrmPrintTableMain;

implementation

{$R *.DFM}

procedure TfrmPrintTableMain.Button1Click(Sender: TObject);
begin
  frxReport1.ShowReport;
end;

procedure TfrmPrintTableMain.FormCreate(Sender: TObject);
begin
  cdsData.LoadFromFile('..\..\Data\Customers.cds');
end;

procedure TfrmPrintTableMain.frxReport1BeforePrint(Sender: TfrxReportComponent);
var
  ACrossView: TfrxCrossView;
  I, J: Integer;
begin
  if Sender is TfrxCrossView then
  begin
    ACrossView := TfrxCrossView(Sender);

    cdsData.First;
    I := 0;
    while not cdsData.Eof do
    begin
      for J := 0 to cdsData.Fields.Count - 1 do
        ACrossView.AddValue([I], [cdsData.Fields[J].DisplayLabel], [cdsData.Fields[J].AsString]);
      cdsData.Next;
      Inc(I);
    end;
  end;
end;

function TfrmPrintTableMain.GetCaption: string;
begin
  Result := 'Print a Table ' + inherited GetCaption;
end;

end.
