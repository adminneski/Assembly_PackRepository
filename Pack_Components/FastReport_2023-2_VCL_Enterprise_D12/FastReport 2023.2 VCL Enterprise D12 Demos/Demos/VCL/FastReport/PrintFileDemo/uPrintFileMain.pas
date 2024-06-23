unit uPrintFileMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  frxClass, StdCtrls, frCoreClasses,
  uDemoMain;

type
  TfrmPrintFileMain = class(TfrmDemoMain)
    Button1: TButton;
    frxReport1: TfrxReport;
    procedure Button1Click(Sender: TObject);
    procedure frxReport1GetValue(VarName: String; var Value: Variant);
  protected
    function GetCaption: string; override;
  end;

var
  frmPrintFileMain: TfrmPrintFileMain;

implementation

{$R *.DFM}

var
  ar: array[0..9] of Integer = (0,1,2,3,4,5,6,7,8,9);

procedure TfrmPrintFileMain.Button1Click(Sender: TObject);
begin
  frxReport1.ShowReport;
end;

procedure TfrmPrintFileMain.frxReport1GetValue(VarName: String; var Value: Variant);
var
  sl: TStringList;
begin
  if CompareText(VarName, 'file') = 0 then
  begin
    sl := TStringList.Create;
    sl.LoadFromFile('uPrintFileMain.pas');
    Value := sl.Text;
    sl.Free;
  end;
end;

function TfrmPrintFileMain.GetCaption: string;
begin
  Result := 'Print a File Demo';
end;

end.
