unit uSignWithoutDialog;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  frxClass, StdCtrls, frxExportBaseDialog, frxExportPDF, frxUtils,
  frxTableObject, Buttons, ExtCtrls, uDemoMain, XPMan, ImgList, ActnList, Menus;


type
  TfrmSignWithoutDialog = class(TfrmDemoMain)
    Button1: TButton;
    rbOneSign: TRadioButton;
    rbTwoSign: TRadioButton;
    procedure Button1Click(Sender: TObject);
  private
    procedure SignWithOneSignature(PDFExport: TfrxPDFExport);
    procedure SignWithTwoSignatures(PDFExport: TfrxPDFExport);
  protected
    function GetCaption: string; override;
  end;

var
  frmSignWithoutDialog: TfrmSignWithoutDialog;

implementation

{$R *.DFM}

procedure TfrmSignWithoutDialog.Button1Click(Sender: TObject);
const
  FR3FileName = 'TwoSignatures.fr3';
var
  PDFExport: TfrxPDFExport;
  Report: TfrxReport;
begin
  Report := TfrxReport.Create(nil);
  try
    Report.LoadFromFile(FR3FileName);
    Report.PrepareReport;

    PDFExport := TfrxPDFExport.Create(nil);
    try
      PDFExport.Report := Report;
      PDFExport.ShowDialog := False;
      PDFExport.OpenAfterExport := True;

      if rbTwoSign.Checked then
        SignWithTwoSignatures(PDFExport)
      else
        SignWithOneSignature(PDFExport);

      PDFExport.FileName := ExtractFileName(FR3FileName) + '.pdf';
      Report.Export(PDFExport);
    finally
      PDFExport.Free;
    end;
  finally
    Report.Free;
  end;
end;

function TfrmSignWithoutDialog.GetCaption: string;
begin
  Result := 'PDF Sign Without Dialog Demo';
end;

procedure TfrmSignWithoutDialog.SignWithTwoSignatures(PDFExport: TfrxPDFExport);
var
  SD1, SD2: TSignatureData;
begin
  SD1.Name := 'DigitalSignature1';
  SD1.Location := 'Unknown';
  SD1.Reason := 'Completely unknown';
  SD1.ContactInfo := 'Absolutely unknown';
  SD1.CertificatePath := 'JohnDoe.pfx';
  SD1.CertificatePassword := '123';

  SD2.Name := 'DigitalSignature2';
  SD2.Location := 'Unknown';
  SD2.Reason := 'Completely unknown';
  SD2.ContactInfo := 'Absolutely unknown';
  SD2.CertificatePath := 'JaneDoe.pfx';
  SD2.CertificatePassword := '123';

  PDFExport.SignatureInfoList.Init;
  PDFExport.SignatureInfoList.AddData(SD1);
  PDFExport.SignatureInfoList.AddData(SD2);
end;

procedure TfrmSignWithoutDialog.SignWithOneSignature(PDFExport: TfrxPDFExport);
begin
  PDFExport.DigitalSignLocation := 'Unknown';
  PDFExport.DigitalSignReason := 'Completely unknown';
  PDFExport.DigitalSignContactInfo := 'Absolutely unknown';
  PDFExport.DigitalSignCertificatePath := 'JohnDoe.pfx';
  PDFExport.DigitalSignCertificatePassword := '123';
end;

end.
