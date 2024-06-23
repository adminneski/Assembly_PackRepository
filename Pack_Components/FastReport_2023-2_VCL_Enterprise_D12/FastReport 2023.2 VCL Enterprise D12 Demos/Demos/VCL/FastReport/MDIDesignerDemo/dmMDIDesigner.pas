unit dmMDIDesigner;

interface

uses
  SysUtils, Classes, frxClass, frxDBSet, DB, DBClient, frCoreClasses;

type
  TReportData = class(TDataModule)
    animalsDB: TfrxDBDataset;
    biolifeDB: TfrxDBDataset;
    clientsBD: TfrxDBDataset;
    customerDB: TfrxDBDataset;
    cdsAnimals: TClientDataSet;
    cdsBiolife: TClientDataSet;
    cdsClents: TClientDataSet;
    cdsCustomers: TClientDataSet;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ReportData: TReportData;

implementation

{$R *.dfm}

end.
