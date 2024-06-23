unit uInvoice;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  frxClass, StdCtrls, frxExportBaseDialog, frxExportPDF, frxRich, frxUtils,
  frxTableObject, uDemoMain, frCoreClasses;


type
  TfrmInvoice = class(TfrmDemoMain)
    CreateButton: TButton;
    SelectLabel: TLabel;
    XmlEdit: TEdit;
    SelectButton: TButton;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    frxReport1: TfrxReport;
    frxPDFExport1: TfrxPDFExport;
    procedure CreateButtonClick(Sender: TObject);
    procedure SelectButtonClick(Sender: TObject);
  protected
    function GetCaption: string; override;
  end;

var
  frmInvoice: TfrmInvoice;

implementation

uses
  frxExportPDFHelpers;

{$R *.DFM}

procedure TfrmInvoice.CreateButtonClick(Sender: TObject);
begin
  if      not FileExists(XmlEdit.Text) then
    frxErrorMsg('XML file does not exist!')
  else if not FileExists('Invoice.fr3') then
    frxErrorMsg('Report file does not exist!')
  else if SaveDialog1.Execute then
  begin
    frxPDFExport1.PDFStandard := psPDFA_3a;
    frxPDFExport1.OpenAfterExport := True;
    frxPDFExport1.AddEmbeddedXML('ZUGFeRD-invoice.xml', 'ZUGFeRD invoice', Now,
      TFileStream.Create(XmlEdit.Text, fmOpenRead));
    frxPDFExport1.FileName := SaveDialog1.FileName;
    frxPDFExport1.ShowDialog := False;

    frxReport1.LoadFromFile('Invoice.fr3');
    frxReport1.PrepareReport;
    frxReport1.Export(frxPDFExport1);
  end;
end;

function TfrmInvoice.GetCaption: string;
begin
  Result := 'Invoice Demo';
end;

procedure TfrmInvoice.SelectButtonClick(Sender: TObject);
begin
  OpenDialog1.FileName := XmlEdit.Text;
  if OpenDialog1.Execute then
    XmlEdit.Text :=  OpenDialog1.FileName;
end;

end.
