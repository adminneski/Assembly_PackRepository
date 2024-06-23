unit FastQueryBuilder;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  StdCtrls, fqbClass, DB, ComCtrls, DBTables, Dialogs,
  Buttons, fqbBDEEngine, uDemoMain, XPMan, ImgList, ActnList, Menus;
                               
type
  TfrmFastQueryBuilderMain = class(TfrmDemoMain)
    Button1: TButton;
    Memo1: TMemo;
    fqbBDEEngine1: TfqbBDEEngine;
    fqbDialog1: TfqbDialog;
    procedure Button1Click(Sender: TObject);
  end;

var
  frmFastQueryBuilderMain: TfrmFastQueryBuilderMain;

implementation

{$R *.dfm}

procedure TfrmFastQueryBuilderMain.Button1Click(Sender: TObject);
begin
  fqbDialog1.SQL := Memo1.Lines.Text;
  if fqbDialog1.Execute then
  begin
    Memo1.Lines.Clear;
    Memo1.Lines.Text := fqbDialog1.SQL;
  end
end;

end.
