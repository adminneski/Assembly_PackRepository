unit uCustomReportData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frXML, frxXMLSerializer, frxDesgn, frxClass, StdCtrls, frxExportPDF,
  frxExportBaseDialog, frCoreClasses,
  uDemoMain, XPMan, ImgList, ActnList, Menus;

type
  TfrmCustomReportDataMain = class(TfrmDemoMain)
    frxReport1: TfrxReport;
    frxDesigner1: TfrxDesigner;
    frxPDFExport1: TfrxPDFExport;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure frxReport1SaveCustomData(XMLItem: TfrXMLItem);
    procedure frxReport1GetCustomData(XMLItem: TfrXMLItem);
    procedure FormCreate(Sender: TObject);
  protected
    function GetCaption: string; override;
  end;

var
  frmCustomReportDataMain: TfrmCustomReportDataMain;

implementation

{$R *.dfm}

procedure TfrmCustomReportDataMain.Button1Click(Sender: TObject);
begin
  frxReport1.DesignReport();
end;

procedure TfrmCustomReportDataMain.frxReport1SaveCustomData(XMLItem: TfrXMLItem);
var
  ASerializer: TfrxXMLSerializer;
begin
  // serialize and save PDF filter settings to report file
  ASerializer := TfrxXMLSerializer.Create(nil);
  try
    ASerializer.Owner := frxReport1;
    XMLItem := XMLItem.Add;
    XMLItem.Name := 'PDFExport';
    XMLItem.Text := ASerializer.ObjToXML(frxPDFExport1);
  finally
    ASerializer.Free;
  end;
end;

function TfrmCustomReportDataMain.GetCaption: string;
begin
  Result := 'Custom Report Data Demo';
end;

procedure TfrmCustomReportDataMain.FormCreate(Sender: TObject);
begin
  inherited;
  frxReport1.LoadFromFile('CustData.fr3');
end;

procedure TfrmCustomReportDataMain.frxReport1GetCustomData(XMLItem: TfrXMLItem);
var
  ASerializer: TfrxXMLSerializer;
begin
  // load saved PDF filter settings from report file
  ASerializer := TfrxXMLSerializer.Create(nil);
  try
    ASerializer.Owner := frxReport1;
    if(XMLItem.Count > 0) then
    begin
      XMLItem := XMLItem.Items[0];
      if AnsiCompareText(XMLItem.Name, 'PDFExport') = 0 then
        ASerializer.XMLToObj(XMLItem.Text, frxPDFExport1);
    end;
  finally
    ASerializer.Free;
  end;
end;

end.
