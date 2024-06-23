unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, SMDBGrid, Db, DBClient;

type
  TfrmMain = class(TForm)
    cdsCountry: TClientDataSet;
    dSrcCountry: TDataSource;
    dbgCountry: TSMDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure dbgCountryCellClick(Column: TColumn);
  private
    { Private declarations }
    procedure AddButtonColumn(const FieldName: string);
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.DFM}
{$R winxp.res}

procedure TfrmMain.AddButtonColumn(const FieldName: string);
var
  col: TSMDBButtonColumn;
begin
  col := TSMDBButtonColumn.Create(dbgCountry.Columns);
  try
//    col.Name := 'col' + IntToStr(dbgCountry.Columns.Count);
    col.FieldName := FieldName;
    col.Title.Caption := 'Info';
    col.Width := 120;
//    col.Font.Style := [fsBold];
  except
  end
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  AddButtonColumn('Name');
end;

procedure TfrmMain.dbgCountryCellClick(Column: TColumn);
begin
  if (Column is TSMDBButtonColumn) then
    ShowMessage('You clicked at ' + cdsCountry.FieldByName(Column.FieldName).AsString)
end;

end.
