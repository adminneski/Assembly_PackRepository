unit uFastReportMain;

interface

//{$I frx.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
{$IFDEF DELPHI22}
  System.ImageList,
{$ENDIF}
  StdCtrls, Db, frxDesgn, frxClass, frxDCtrl,
  frxRich, frxBarcode, ImgList, ComCtrls, ExtCtrls, frxOLE,
  frxCross, frxDMPExport, frxExportImage, frxExportRTF,
  frxExportXML, frxExportHTML, frxGZip, frxExportPDF,
  frxChBox, frxExportText, frxExportCSV, frxExportMail,
  frxADOComponents, frxCrypt, frxExportODF, frxPrinter,
  frxExportHTMLDiv, frxExportXLSX, frxExportPPTX, frxExportDOCX,
  frxExportBIFF, frxChart, frxExportSVG, frxTableObject, frxMap,
  frxExportHelpers, frxExportBaseDialog, Variants, frxCellularTextObject,
  frxExportPPML, frxExportPS, frxExportZPL, frxSaveFilterFRX, frxHTML,
  frxPDFViewer, frCoreClasses, uDemoMain, System.ImageList;

type
  TfrmFastReportMain = class(TfrmDemoMain)
    frxDesigner1: TfrxDesigner;
    frxBarCodeObject1: TfrxBarCodeObject;
    frxRichObject1: TfrxRichObject;
    frxDialogControls1: TfrxDialogControls;
    ImageList1: TImageList;
    Image1: TImage;
    Label1: TLabel;
    Label3: TLabel;
    frxOLEObject1: TfrxOLEObject;
    frxCrossObject1: TfrxCrossObject;
    frxDotMatrixExport1: TfrxDotMatrixExport;
    frxBMPExport1: TfrxBMPExport;
    frxJPEGExport1: TfrxJPEGExport;
    frxTIFFExport1: TfrxTIFFExport;
    frxHTMLExport1: TfrxHTMLExport;
    frxXMLExport1: TfrxXMLExport;
    frxRTFExport1: TfrxRTFExport;
    frxGZipCompressor1: TfrxGZipCompressor;
    frxPDFExport1: TfrxPDFExport;
    Label4: TLabel;
    frxCheckBoxObject1: TfrxCheckBoxObject;
    frxMailExport1: TfrxMailExport;
    frxCSVExport1: TfrxCSVExport;
    frxGIFExport1: TfrxGIFExport;
    frxSimpleTextExport1: TfrxSimpleTextExport;
    frxADOComponents1: TfrxADOComponents;
    frxCrypt1: TfrxCrypt;
    GroupBox1: TGroupBox;
    Tree: TTreeView;
    GroupBox2: TGroupBox;
    DescriptionM: TMemo;
    DesignB: TButton;
    PreviewB: TButton;
    Label5: TLabel;
    Label7: TLabel;
    Label2: TLabel;
    FileNameL: TLabel;
    Shape1: TShape;
    frxODSExport1: TfrxODSExport;
    frxODTExport1: TfrxODTExport;
    frxReport1: TfrxReport;
    frxDOCXExport1: TfrxDOCXExport;
    frxPPTXExport1: TfrxPPTXExport;
    frxXLSXExport1: TfrxXLSXExport;
    frxHTML5DivExport1: TfrxHTML5DivExport;
    frxBIFFExport1: TfrxBIFFExport;
    frxChartObject1: TfrxChartObject;
    frxSVGExport1: TfrxSVGExport;
    frxZPLExport1: TfrxZPLExport;
    frxPSExport1: TfrxPSExport;
    frxPPMLExport1: TfrxPPMLExport;
    frxPNGExport1: TfrxPNGExport;
    procedure DesignBClick(Sender: TObject);
    procedure TreeCustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure PreviewBClick(Sender: TObject);
    procedure TreeChange(Sender: TObject; Node: TTreeNode);
    procedure FormShow(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { IOTransport declarations }
    WPath: String;
  protected
    function GetCaption: string; override;
  public
    { Public declarations }
  end;

var
  frmFastReportMain: TfrmFastReportMain;

implementation

uses
  udmFastReport, ShellApi, frCore, frxIOTransportMail, frxIOTransportFTP, frxIOTransportDropbox,
  frxIOTransportOneDrive, frxIOTransportBoxCom, frxIOTransportGoogleDrive, frxIOTransportGMail, frxIOTransportOutlook,
  frxIOTransportYandexDisk, frxGaugeView, frxGaugeDialogControl, frxZipCode, DateUtils, frBaseGraphicsTypes;

{$R *.DFM}

procedure TfrmFastReportMain.FormCreate(Sender: TObject);
begin
  TfrxMailIOTransport.Create(Self);
  TfrxFTPIOTransport.Create(Self);
  TfrxDropboxIOTransport.Create(Self).Name := 'DBOX';
  TfrxOneDriveIOTransport.Create(Self).Name := 'ODRIVE';
  TfrxBoxComIOTransport.Create(Self).Name := 'BOX';
  TfrxGoogleDriveIOTransport.Create(Self).Name := 'GDRIVE';
  TfrxGMailIOTransport.Create(Self).Name := 'GMAIL';
  TfrxYandexDiskIOTransport.Create(Self).Name := 'YADISK';
  TfrxOutlookIOTransport.Create(Self).Name := 'OUTLOOK';
  TfrxSaveFRX.Create(Self);
end;

procedure TfrmFastReportMain.FormShow(Sender: TObject);
begin
  WPath := ExtractFilePath(Application.ExeName) + 'Data\';
  Tree.Items[0].Item[0].Selected := True;
  Label2.Caption := 'VCL ' + FR_VERSION;
  Label4.Caption := #174;
  Label5.Caption := '(C) 1998-' + IntToStr(YearOf(Now)) + ' by Fast Reports Inc.';
end;

function TfrmFastReportMain.GetCaption: string;
begin
  Result := 'FastReport VCL ' + FR_VERSION + ' Demo';
end;

procedure TfrmFastReportMain.DesignBClick(Sender: TObject);
begin
  frxReport1.DesignReport;
end;

procedure TfrmFastReportMain.PreviewBClick(Sender: TObject);
begin
  frxReport1.ShowReport;
end;

procedure TfrmFastReportMain.TreeCustomDrawItem(Sender: TCustomTreeView;
  Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  if Node.Count <> 0 then
    Tree.Canvas.Font.Style := [fsBold];
end;

procedure TfrmFastReportMain.TreeChange(Sender: TObject; Node: TTreeNode);
begin
  if Node.StateIndex = -1 then
  begin
    Tree.FullCollapse;
    Node[0].Selected := True;
  end
  else
  begin
    DesignB.Enabled := True;
    PreviewB.Enabled := True;
    if Node.StateIndex = 151 then
      frxReport1.EngineOptions.DestroyForms := False
    else if Node.StateIndex = 309 then
    begin
      frxReport1.PictureCacheOptions.CachedImagesBuildType := tbtOriginal;
      frxReport1.PictureCacheOptions.OriginalQualityReducer.MinWidth := 64;
      frxReport1.PictureCacheOptions.OriginalQualityReducer.MinHeight := 64;
      frxReport1.PictureCacheOptions.OriginalQualityReducer.ReducePercent := 70;
    end
    else
    begin
      frxReport1.EngineOptions.DestroyForms := True;
      frxReport1.PictureCacheOptions.CachedImagesBuildType := tbtNone;
      frxReport1.PictureCacheOptions.OriginalQualityReducer.MinWidth := 0;
      frxReport1.PictureCacheOptions.OriginalQualityReducer.MinHeight := 0;
      frxReport1.PictureCacheOptions.OriginalQualityReducer.ReducePercent := 0;
    end;
    frxReport1.LoadFromFile(WPath + IntToStr(Node.StateIndex) + '.fr3');
    frxReport1.PreviewOptions.Buttons := frxReport1.PreviewOptions.Buttons + [pbInplaceEdit ,pbSelection, pbCopy, pbPaste];
    frxReport1.PreviewOptions.AllowPreviewEdit := True;
    FileNameL.Caption := ' Report file: ' + IntToStr(Node.StateIndex) + '.fr3';
    DescriptionM.Lines := frxReport1.ReportOptions.Description;
  end;
end;

procedure TfrmFastReportMain.Label3Click(Sender: TObject);
begin
  ShellExecute(GetDesktopWindow, 'open',
    PChar(TLabel(Sender).Caption), nil, nil, sw_ShowNormal);
end;

end.


