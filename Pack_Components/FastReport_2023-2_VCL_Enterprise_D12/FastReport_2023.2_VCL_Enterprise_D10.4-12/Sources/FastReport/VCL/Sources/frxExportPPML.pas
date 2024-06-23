unit frxExportPPML;

interface

{$I frx.inc}

uses
{$IFNDEF Linux}
  Windows,
{$ELSE}
  LCLType, LCLIntf, LCLProc,
{$ENDIF}
  Messages, frxExportBaseDialog, SysUtils, Classes, Graphics, frxClass, frxExportMatrix, Math, frxBarcod, frxBarcode, frxBarcode2D,
  frxBarcodeMaxiCode, frxTableObject, frxRes, frxImageConverter, frxStorage, frxExportPS, frxExportPPMLDialog, frxExportPPMLDocument, frxExportPSHelper;

type

{$IFDEF DELPHI16}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxPPMLExport = class(TfrxPSExport)
  public
    constructor Create(AOwner: TComponent); override;
    class function GetDescription: String; override;
    class function ExportDialogClass: TfrxBaseExportDialogClass; override;
    procedure StartPage(Page: TfrxReportPage; Index: Integer); override;
    procedure FinishPage(Page: TfrxReportPage; Index: Integer); override;
    procedure Finish; override;
end;


implementation

uses
  frxUtils, frHashUtils;

constructor TfrxPPMLExport.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  DefaultExt := GetStr('PPMLExtension');
  FilterDesc := GetStr('PPMLFilter');
end;

procedure TfrxPPMLExport.StartPage(Page: TfrxReportPage; Index: Integer);
var
  pageBorder: TfrxCustomMemoView;
begin
  if(Index = 0) then
    ps := PPMLDocument.Create(fileNameWOext, page.PaperWidth, page.PaperHeight); //Units.Millimeters
  ps.AddPage();
  // page borders
  if (page.Frame.Typ <> []) then
  begin
    pageBorder := TfrxCustomMemoView.Create(nil);
    pageBorder.Frame := page.Frame;
    pageBorder.Left := 0;
    pageBorder.Top := 0;
    pageBorder.Width := page.Width - MmToDp(page.RightMargin + page.LeftMargin);
    pageBorder.Height := page.Height - MmToDp(page.BottomMargin + page.TopMargin);
    AddTextObject(ps, pageBorder, true);
    FreeAndNil(pageBorder);
  end;

  if (FPath <> '') then
    pageFileName := FPath + fileNameWOext + IntToStr(Index) + extension
  else
    pageFileName := '';
end;

procedure TfrxPPMLExport.FinishPage(Page: TfrxReportPage; Index: Integer);
begin
  ps.Finish();
end;

procedure TfrxPPMLExport.Finish;
begin
  if (DirectoryExists(FPath) and (FileName <> '')) then
  begin
    if (FHasMultipleFiles) then
      ps.Save(pageFileName)
    else
      ps.Save(Stream);
  end
  else
  if (FPath = '') then
    ps.Save(Stream);
  FreeAndNil(ps);
  ps := nil;
  Stream := nil;
end;

class function TfrxPPMLExport.GetDescription: String;
begin
  Result := frxResources.Get('PPMLexport');
  if Result = '' then
    Result := 'PPML Export ...';
end;

class function TfrxPPMLExport.ExportDialogClass: TfrxBaseExportDialogClass;
begin
  Result := TfrxExportPPMLDialog;
end;

end.
