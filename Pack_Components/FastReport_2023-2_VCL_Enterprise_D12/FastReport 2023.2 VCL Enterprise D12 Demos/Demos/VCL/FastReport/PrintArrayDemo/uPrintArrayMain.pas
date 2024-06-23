unit uPrintArrayMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uDemoMain,
  frxClass, StdCtrls, frCoreClasses, ImgList, ActnList, Menus, XPMan;

type
  TfrmPrintArrayMain = class(TfrmDemoMain)
    ArrayDS: TfrxUserDataSet;
    frxReport1: TfrxReport;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure frxReport1GetValue(VarName: String; var Value: Variant);
  protected
    function GetCaption: string; override;
  end;

var
  frmPrintArrayMain: TfrmPrintArrayMain;

implementation

{$R *.DFM}

var
  ar: array[0..9] of Integer = (0,1,2,3,4,5,6,7,8,9);

procedure TfrmPrintArrayMain.Button1Click(Sender: TObject);
begin
  ArrayDS.RangeEnd := reCount;
  ArrayDS.RangeEndCount := 10;
  frxReport1.ShowReport;
end;

procedure TfrmPrintArrayMain.frxReport1GetValue(VarName: String; var Value: Variant);
begin
  if CompareText(VarName, 'element') = 0 then
    Value := ar[ArrayDS.RecNo];
end;

function TfrmPrintArrayMain.GetCaption: string;
begin
  Result := 'Print an Array Demo';
end;

end.
