unit uPrintStringListMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  frxClass, StdCtrls, frCoreClasses,
  uDemoMain, XPMan, ImgList, ActnList, Menus;

type
  TfrmPrintStringListMain = class(TfrmDemoMain)
    Button1: TButton;
    StringDS: TfrxUserDataSet;
    frxReport1: TfrxReport;
    procedure Button1Click(Sender: TObject);
    procedure frxReport1GetValue(const VarName: String; var Value: Variant);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FStringList: TStringList;
  protected
    function GetCaption: string; override;
  end;

var
  frmPrintStringListMain: TfrmPrintStringListMain;

implementation

{$R *.DFM}

procedure TfrmPrintStringListMain.FormCreate(Sender: TObject);
begin
  FStringList := TStringList.Create;
  FStringList.Add('1');
  FStringList.Add('2');
  FStringList.Add('3');
  FStringList.Add('4');
  FStringList.Add('5');
  FStringList.Add('6');
  FStringList.Add('7');
  FStringList.Add('8');
  FStringList.Add('9');
end;

procedure TfrmPrintStringListMain.FormDestroy(Sender: TObject);
begin
  FStringList.Free;
end;

procedure TfrmPrintStringListMain.Button1Click(Sender: TObject);
begin
  StringDS.RangeEnd := reCount;
  StringDS.RangeEndCount := FStringList.Count;
  frxReport1.ShowReport;
end;

procedure TfrmPrintStringListMain.frxReport1GetValue(const VarName: String; var Value: Variant);
begin
  if CompareText(VarName, 'element') = 0 then
    Value := FStringList[StringDS.RecNo];
end;

function TfrmPrintStringListMain.GetCaption: string;
begin
  Result := 'Print a String List Demo';
end;

end.
