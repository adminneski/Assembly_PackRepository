unit uDynamicTable;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  frxClass, StdCtrls, frxTableObject, frxDBSet, DB, ADODB, frCoreClasses,
  uDemoMain, XPMan, ImgList, ActnList, Menus;

type
  TfrmDynamicTable = class(TfrmDemoMain)
    Button1: TButton;
    frxReport1: TfrxReport;
    frxReportTableObject1: TfrxReportTableObject;
    ADOTable1: TADOTable;
    frxDBDataset1: TfrxDBDataset;
    procedure Button1Click(Sender: TObject);
    function frxReport1ObjectManualBuild(
      ReportObject: TfrxReportComponent): Boolean;
  protected
    function GetCaption: string; override;
  end;

var
  frmDynamicTable: TfrmDynamicTable;

implementation

{$R *.DFM}

procedure TfrmDynamicTable.Button1Click(Sender: TObject);
begin
  frxReport1.ShowReport;
end;

function TfrmDynamicTable.frxReport1ObjectManualBuild(
  ReportObject: TfrxReportComponent): Boolean;
var
  DS: TfrxDBDataset;
  TableObject: TfrxTableObject;
begin
  Result := False; // when return false the report engine will try to use script event
  if not(ReportObject is TfrxTableObject) then Exit;
  TableObject := TfrxTableObject(ReportObject);
  DS := TfrxDBDataset(frxReport1.GetDataset('Country'));
  DS.First;
  TableObject.TableBuilder.PrintRow(0, tbHeader);
  TableObject.TableBuilder.PrintColumns;
  while not DS.Eof do
  begin
    TableObject.TableBuilder.PrintRow(1);
    TableObject.TableBuilder.PrintColumns;
    DS.Next;
  end;
  Result := True; 
end;

function TfrmDynamicTable.GetCaption: string;
begin
  Result := 'Dynamic Table Demo';
end;

end.
