
{******************************************}
{                                          }
{             FastReport VCL               }
{         Exports Registration unit        }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxeReg;

{$I frx.inc}
{$R *.dcr}  //Repacked Version Line added
interface


procedure Register;

implementation

uses
{$IFNDEF Linux}
  Windows, Messages,
{$ENDIF}
SysUtils, Classes, Graphics, Controls, Forms, frxReg,
frxExportImage, frxExportText,
{$IFNDEF FPC}
  {$IFNDEF DELPHI6}
    DsgnIntf,
  {$ELSE}
    DesignIntf, DesignEditors,
  {$ENDIF}
  {$IFNDEF ACADEMIC_ED}
    {$IFNDEF RAD_ED}
      frxExportXML, frxExportXLS, frxExportMail, frxExportHTMLDiv, frxExportZPL, frxExportPS, frxExportPPML,
      frxExportODF, frxExportDBF, frxExportBIFF, frxExportDOCX, frxExportPPTX, frxExportXLSX, frxExportSVG,
    {$ENDIF}
    frxExportHTML,
      {$IFNDEF DELPHI12}frxExportTXT, {$ENDIF}
    frxExportRTF, frxExportPDF,
  {$ENDIF}
{$ELSE}
  PropEdits, LazarusPackageIntf, LResources, frxExportTXT,
 {$IFNDEF ACADEMIC_ED}
  frxExportHTML, frxExportHTMLDiv, frxExportODF,
  frxExportXML, frxExportRTF, frxExportDBF, frxPreProgramClass, frxExportPDF, frxExportDOCX, frxExportPPTX,
  frxExportXLSX, frxExportZPL, frxExportPS, frxExportPPML,
 {$ENDIF}
{$ENDIF}
  frxExportCSV;

{-----------------------------------------------------------------------}

procedure Register;
begin
RegisterComponents(frxDefaultProductPage + ' Exports',
  [TfrxBMPExport, TfrxJPEGExport, TfrxTIFFExport, TfrxPNGExport, TfrxSimpleTextExport, TfrxCSVExport,
{$IFNDEF FPC}
  TfrxEMFExport,
  {$IFNDEF ACADEMIC_ED}
    {$IFNDEF RAD_ED}
      TfrxXLSExport, TfrxXMLExport, TfrxMailExport,
        {$IFNDEF DELPHI12}
		  TfrxTXTExport,
		{$ENDIF}
	  TfrxODSExport, TfrxODTExport, TfrxDBFExport, TfrxBIFFExport, TfrxDOCXExport, TfrxPPTXExport, TfrxXLSXExport, TfrxHTML4DivExport, TfrxHTML5DivExport, TfrxSVGExport, TfrxZPLExport, TfrxPSExport, TfrxPPMLExport, 
	{$ENDIF}
    TfrxPDFExport, TfrxHTMLExport, TfrxRTFExport,
  {$ENDIF}
  TfrxGIFExport
{$ELSE}
  TfrxTXTExport
 {$IFNDEF ACADEMIC_ED}
  , TfrxHTMLExport, TfrxHTML4DivExport, TfrxHTML5DivExport, TfrxODSExport, TfrxODTExport,
  TfrxXMLExport, TfrxRTFExport, TfrxDBFExport, TfrxPDFExport, TfrxDOCXExport, TfrxPPTXExport, TfrxXLSXExport, TfrxZPLExport, TfrxPSExport, TfrxPPMLExport
 {$ENDIF}
{$ENDIF}
]);
end;

{$IFDEF FPC}
initialization
{$INCLUDE frxeReg.lrs}
{$ENDIF}


end.
