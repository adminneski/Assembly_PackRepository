
{******************************************}
{                                          }
{             FastReport VCL               }
{          Report Server engine            }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxServerReports;

{$I frx.inc}
{$IFDEF DELPHI12}
{$WARNINGS OFF}
{$ENDIF}

interface

uses
  {$IFNDEF Linux}
  Windows, ActiveX,
  {$ENDIF}
  SysUtils, Classes, Graphics, frxClass, frxExportHTML, frxExportRTF, StdCtrls,
  frxExportText, frxExportCSV, frxExportPDF, frxExportXML, frxExportImage, frxVariables, frxExportHTMLDiv,
  frXML, frxServerForms, frxServerCache, frxDCtrl, frxServerUtils, frxNetUtils, frxExportHelpers,
  frUnicodeUtils, frxServerLog, frxExportODF, frxServerPrinter, frxServerTemplates, frxImageConverter
  {$IFDEF LCLGTK2}
  , gdk2
  {$ENDIF}
  {$IFNDEF FPC}
  , frxExportBIFF
  {$ENDIF};

type
  TfrxReportSession = class(TThread)
  private
    FPath: String;
    FBasePath: String;
    FSessionId: String;
    FReportPath: String;
    FPageRange: String;
    FFormat: TfrxServerFormat;
    FMainDocument: String;
    FName: String;
    FVariables: TfrxVariables;
    FReportErrors: Boolean;
    FError: String;
    FResultPage: String;
    FReport: TfrxReport;
    FHTMLExport: TfrxHTMLExport;
    FHTMLDivExport: TfrxHTML5DivExport;
    FXMLExport: TfrxXMLExport;
    FRTFExport: TfrxRTFExport;
    FTXTExport: TfrxSimpleTextExport;
    FJPGExport: TfrxJPEGExport;
    FBMPExport: TfrxBMPExport;
    FTIFFExport: TfrxTIFFExport;
    FPDFExport: TfrxPDFExport;
    FCSVExport: TfrxCSVExport;
    FODSExport: TfrxODSExport;
    FODTExport: TfrxODTExport;
  {$IFNDEF FPC}
    FGIFExport: TfrxGIFExport;
    FXLSExport: TfrxBIFFExport;
  {$ENDIF}
    FParentThread: TThread;
    CurPage: TfrxDialogPage;
    FParentReportServer: TComponent;
    FCached: Boolean;
    FNativeClient: Boolean;
    FStream: TMemoryStream;
    FCacheId: String;
    FPassword: String;
    FAuth: Boolean;
    FMessage: String;
    FPageNav: Boolean;
    FMultipage: Boolean;
    FUserLogin: String;
    FUserGroup: String;
    Fvarstr: String;
    FMime: String;
    FPrint: Boolean;
    FReportTitle: String;
    FmPage: String;
    FIsFP3: Boolean;

    procedure DoExports;
    procedure DoError;
    procedure DoFillForm;
    procedure DoSaveForm;
    procedure ShowReportDialog(Page: TfrxDialogPage);
    procedure DoAfterBuildReport;
    function ExtractReportName(const FileName: String): String;
    procedure SetNavTemplate(const ReportName: String; Multipage: Boolean;
      PicsInSameFolder: Boolean;
      Prefix: String; TotalPages: Integer; var Template: String);
    procedure SetMainTemplate(const Title: String; const FrameFolder: String;
      Multipage: Boolean; Navigator: Boolean; var Template: String);
    procedure SetToolbarTemplate(CurrentPage: Integer; TotalPages: Integer; Multipage: Boolean; Navigator: Boolean; var Template: String);
//    procedure SetExportImage(Image: TGraphic; PicType: TfrxPictureType; var FileName: String);
    function GetResultFileName(const ext: String): String;
    function GetNavRequest(PageN: String): String;
    function GetExportButton(expName: String; exp: String): String;
  protected
    procedure Execute; override;
{$IFDEF DELPHI17}
    procedure TerminatedSet; override;
{$ENDIF}
  public
    Active: Boolean;
    Continue: Boolean;
    DialogActive: Boolean;
    Readed: Boolean;
    constructor Create;
    destructor Destroy; override;
    procedure TerminateReport;

    property FileName: String read FName write FName;
    property ReportTitle: String read FReportTitle;
    property Format: TfrxServerFormat read FFormat write FFormat;
    property IndexFileName: String read FMainDocument write FMainDocument;
    property PageRange: String read FPageRange write FPageRange;
    property ParentThread: TThread read FParentThread write FParentThread;
    property ReportPath: String read FReportPath write FReportPath;
    property ResultPage: String read FResultPage;
    property RootPath: String read FBasePath write FBasePath;
    property SessionId: String read FSessionId write FSessionId;
    property CacheId: String read FCacheId write FCacheId;
    property Variables: TfrxVariables read FVariables write FVariables;
    property ParentReportServer: TComponent read FParentReportServer write FParentReportServer;
    property NativeClient: Boolean read FNativeClient write FNativeClient;
    property Stream: TMemoryStream read FStream write FStream;
    property Password: String read FPassword write FPassword;
    property Auth: Boolean read FAuth;
    property ReportMessage: String read FMessage;
    property mPage: String read FmPage write FmPage;

    property PageNav: Boolean read FPageNav write FPageNav;
    property Multipage: Boolean read FMultipage write FMultipage;
    property UserLogin: String read FUserLogin write FUserLogin;
    property UserGroup: String read FUserGroup write FUserGroup;
    property Mime: String read FMime;
    property Print: Boolean read FPrint write FPrint;
    property IsFP3: Boolean read FIsFP3 write FIsFP3;
  end;

  function Serv_HyperlinkToStr(HL: TfrxHyperlink; ParentDetailURL: String): String;

implementation

uses frxServer, frxXMLSerializer, frxServerConfig, frxRes, frxMutex;

{ TfrxReportSession }

constructor TfrxReportSession.Create;
var
  s: string;
begin
  inherited Create(True);
  Active := True;
  try
    FReport := TfrxReport.Create(nil);
    FReport.Engine.OnRunDialog := ShowReportDialog;
    FReport.EngineOptions.SilentMode := True;
    FReport.EngineOptions.EnableThreadSafe := True;
    FReport.EngineOptions.UseFileCache := ServerConfig.GetBool('server.reports.usefilecache');
    FReport.EngineOptions.MaxMemSize := StrToInt(ServerConfig.CheckValue('server.reports.maxmemsize', '10'));
    FReport.EngineOptions.TempDir := ServerConfig.CheckValue('server.reports.temp', '');
    s := frxGetAbsPathDir(ServerConfig.GetValue('server.reports.scripts'), ServerConfig.ConfigFolder);
    FReport.Script.IncludePath.Add(s);
    FReport.ShowProgress := False;
    FmPage := '';
  except
    on E:Exception do
    begin
      FReport := nil;
      FError := 'TfrxReport create error. ' + E.Message;
      DoError;
    end;
  end;
end;

destructor TfrxReportSession.Destroy;
begin
  Terminate;
  PMessages;
  while DialogActive do
  begin
    Sleep(10);
    PMessages;
  end;
  if Assigned(FReport) then
  try
    FReport.Free;
  except
    on e: Exception do
    begin
      FError := 'TfrxReport destroy error ' + e.Message;
      DoError;
    end;
  end;
  inherited;
end;

procedure TfrxReportSession.Execute;
var
  i: Integer;
  VName: AnsiString;
  VValue: Variant;
  s: AnsiString;
  FResPrep, FindPage, IsInCache: Boolean;
begin
  if FReport <> nil then
  begin
    LogWriter.StatAddCurrentReport;
    FResultPage := '';
    DialogActive := False;
    Readed := False;
    FCached := True;
    FAuth := False;

    {$IFNDEF Linux}
    CoInitialize(nil);
    {$ENDIF}
    try
      if Assigned(FReport) then
      begin
        FPath := FBasePath + FSessionId;
        try
          if not IsFP3 then
          begin
          if Assigned(TfrxReportServer(FParentReportServer).OnGetReport) then
            TfrxReportServer(FParentReportServer).OnGetReport(ExtractReportName(FName), FReport, FUserLogin)
          else if FileExists(FName) then
            try
             {$IFDEF LCLGTK2}  //TODO: single-threaded build and export. improve.
             try
              gdk_threads_enter;
             {$ENDIF}
              FReport.LoadFromFile(FName);
             {$IFDEF LCLGTK2}
             finally
              gdk_threads_leave;
             end;
             {$ENDIF}
            except
              on E: Exception do
              begin
                FError := 'Report load error. ' + E.Message;
                DoError;
              end;
            end
          else
          begin
            FError := 'Report not found: ' + FName;
            DoError;
          end;
          end;
        except
          on E: Exception do
          begin
            FError := 'Report load error: ' + FName + E.Message;
            DoError;
          end;
        end;
        if FReport.ReportOptions.Password <> '' then
          s := FPassword
        else
          s := '';
        if Terminated then
          Exit;

        if FReport.ReportOptions.Password = s then
        begin
          if not FIsFP3 then
          begin
          Fvarstr := '';
          if Assigned(FVariables) then
          begin
            for i := 0 to FVariables.Count - 1 do
            begin
              VName := FVariables.Items[i].Name;
              VValue := TfrxVariable(FVariables.Items[i]).Value;
              if FReport.ScriptLanguage = 'PascalScript' then
                VValue := QuotedStr(StringReplace(UnQuoteStr(VValue), '''', '''''', [rfReplaceAll]))
              else
                VValue := '"' + StringReplace(UnQuoteStr(VValue), '''', '""', [rfReplaceAll]) + '"';
              FReport.Variables[VName] := VValue;
              Fvarstr := Fvarstr + '&' + VName + '=' + Str2HTML(UnQuoteStr(TfrxVariable(FVariables.Items[i]).Value));
            end;
          end;

          if FUserLogin <> '' then
          begin
            FReport.Variables['AUTHLOGIN'] := QuotedStr(FUserLogin);
            FReport.Variables['AUTHGROUP'] := QuotedStr(FUserGroup);
          end
          else
          begin
            FReport.Variables['AUTHLOGIN'] := QuotedStr('');
            FReport.Variables['AUTHGROUP'] := QuotedStr('');
          end;

          FReport.ReportOptions.ConnectionName :=
            ServerConfig.GetValue('server.database.connection');
          end;

          if IsFP3 then
            IsInCache := ReportCache.GetCachedStream(FReport, ExtractReportName(FName),
              nil, '')
          else
            IsInCache := ReportCache.GetCachedStream(FReport, ExtractReportName(FName),
              FReport.Variables, FCacheId);

          if not IsInCache then
            try
              if IsFP3 then
              begin
                FReport.PreviewPages.LoadFromStream(FStream);
                FResPrep := True;
              end
              else
                FResPrep := False;
              try
               if not IsFP3 then
               begin
               {$IFDEF LCLGTK2}  //TODO: single-threaded build and export. improve.
               try
                gdk_threads_enter;
               {$ENDIF}
                 FindPage := False;
                 if (mPage <> '') then
                 begin
                   for i := 0 to FReport.PagesCount - 1 do
                     if (FReport.Pages[i].Name = FmPage) then
                     begin
                       FResPrep := FReport.PrepareScript(nil);
                       FResPrep := FReport.PreparePage(FReport.Pages[i])and not Terminated;
                       FindPage := True;
                       break;
                     end;
                 end;
                 if (not FindPage) then
                   FResPrep := FReport.PrepareReport and not Terminated;
               {$IFDEF LCLGTK2}
               finally
                gdk_threads_leave;
               end;
               {$ENDIF}
               end;
              except
                on E: Exception do
                begin
                  FError := 'Report not prepared: ' + E.Message;
                  DoError;
                end;
              end;
              if FResPrep then
              begin
                if IsFP3 then
                ReportCache.AddReport(FReport, ExtractReportName(FName),
                  nil, '', '')
                else
                if FCached then
                  ReportCache.AddReport(FReport, ExtractReportName(FName),
                    FReport.Variables, '', FSessionId)
                else
                  ReportCache.AddReport(FReport, ExtractReportName(FName),
                    FReport.Variables, FSessionId, FSessionId);
              end
              else if not Terminated then
              begin
                FError := 'Report prepare error: ' + FReport.Errors.Text;
                DoError;
              end;
            except
              on E: Exception do
              begin
                FError := 'Report prepare exception: ' + FReport.Errors.Text +
                  E.Message;
                DoError;
              end;
            end;

          if not Terminated and Assigned(TfrxReportServer(FParentReportServer).OnAfterBuildReport) then
            DoAfterBuildReport;

          if (not FReportErrors) and (not DialogActive) and (not Terminated)
          then
          begin
            try
             {$IFDEF LCLGTK2}  //TODO: single-threaded build and export. improve.
              Synchronize(DoExports);
             {$ELSE}
              DoExports();
             {$ENDIF}
            except
              on E: Exception do
              begin
                FError := 'Export error: ' + E.Message;
                DoError;
              end;
            end;
          end;

        end
        else
        begin
          FAuth := True;
          FReport.Errors.Add('Authentification required')
        end;
      end;
    finally
      if not Terminated then
        FMessage := FReport.Errors.Text;
      LogWriter.StatRemoveCurrentReport;
      Active := False;
      Sleep(3000);
    end;
  end;
end;

procedure TfrxReportSession.DoExports;
var
  s, lExt: string;
  i: Integer;
  crit: TfrxMutex;

  function GetExtensionAndMimeFromType(aFormat: TfrxServerFormat): String;
  begin
    case aFormat of
      sfHTM: FMime := ServerConfig.GetValue('server.exports.html.mimetype');
      sfXML:
        begin
          FMime := ServerConfig.GetValue('server.exports.xml.mimetype');
          Result := ServerConfig.GetValue('server.exports.xml.extension');
        end;
      sfXLS:
        begin
          FMime := 'application/vnd.ms-excel';
          Result := 'xls';
        end;
      sfRTF:
        begin
          FMime := ServerConfig.GetValue('server.exports.rtf.mimetype');
          Result := 'rtf';
        end;
      sfCSV:
        begin
          FMime := ServerConfig.GetValue('server.exports.csv.mimetype');
          Result := 'csv';
        end;
      sfTXT:
        begin
          FMime := ServerConfig.GetValue('server.exports.txt.mimetype');
          Result := 'txt';
        end;
      sfPDF:
        begin
          FMime := ServerConfig.GetValue('server.exports.pdf.mimetype');
          Result := 'pdf';
        end;
      sfJPG:
        begin
          FMime := ServerConfig.GetValue('server.exports.jpg.mimetype');
          Result := 'jpg';
        end;
      sfBMP:
        begin
          FMime := ServerConfig.GetValue('server.exports.bmp.mimetype');
          Result := 'bmp';
        end;
      sfTIFF:
        begin
          FMime := ServerConfig.GetValue('server.exports.tiff.mimetype');
          Result := 'tif';
        end;
      sfGIF:
        begin
          FMime := ServerConfig.GetValue('server.exports.gif.mimetype');
          Result := 'gif';
        end;
      sfFRP:
        begin
          FMime := ServerConfig.GetValue('server.exports.fp3.mimetype');
          FMime := 'application/fastreport';
          Result := 'fp3';
        end;
      sfODS:
        begin
          FMime := ServerConfig.GetValue('server.exports.ods.mimetype');
          Result := 'ods';
        end;
      sfODT:
        begin
          FMime := ServerConfig.GetValue('server.exports.odt.mimetype');
          Result := 'odt';
        end;
      sfHTMD: FMime := ServerConfig.GetValue('server.exports.html.mimetype');
    end;
  end;


  procedure BuildExport(aExport: TfrxCustomExportFilter; aExt: String);
  begin
    aExport.Stream := TFileStream.Create(FPath + FResultPage, fmCreate);
    try
      FReport.Export(aExport);
      if IsFP3 then
        ResultCache.AddFileFormat(aExport.Stream, FFormat, FName + '.' + aExt, nil, FSessionId, '');
    finally
      aExport.Stream.Free;
      aExport.Stream := nil;
    end;
  end;

  procedure CloseCrit();
  begin
    crit.Unlock;
    crit.Free;
  end;

begin
  if (IsFP3 and ((FFormat = sfHTM) or (FFormat = sfHTMD))) then
    Exit;

  lExt := GetExtensionAndMimeFromType(FFormat);
  FResultPage := GetResultFileName(lExt);

  if IsFP3 then
  begin
    crit := TfrxMutex.Create(SessionId + lExt);
    crit.Lock;
    ResultCache.UpdExpTime(FName + '.' + lExt, nil, FSessionId, FFormat);
    if FileExists(FPath + FResultPage) then
    begin
      CloseCrit();
      Exit;
    end;
  end;

  if (FFormat = sfXML) and (ServerConfig.GetBool('server.exports.xml.active')) then
  begin
    FXMLExport := TfrxXMLExport.Create(nil);
    try
      FXMLExport.ShowDialog := False;
      FXMLExport.ShowProgress := False;
      FXMLExport.PageNumbers := FPageRange;
      FXMLExport.UseFileCache := FReport.EngineOptions.UseFileCache;
      FXMLExport.SuppressPageHeadersFooters := ServerConfig.GetBool('server.exports.xml.continuous');
      FXMLExport.EmptyLines := ServerConfig.GetBool('server.exports.xml.emptylines');
      FXMLExport.ExportPageBreaks := ServerConfig.GetBool('server.exports.xml.pagebreaks');
      FXMLExport.ExportStyles := ServerConfig.GetBool('server.exports.xml.styles');
      FXMLExport.Wysiwyg := ServerConfig.GetBool('server.exports.xml.wysiwyg');
      FXMLExport.Background := ServerConfig.GetBool('server.exports.xml.background');
      s := ServerConfig.GetValue('server.exports.xml.splitype');
      if s = 'pages' then
        FXMLExport.Split := ssRPages
      else if s = 'printonprev' then
        FXMLExport.Split := ssPrintOnPrev
      else if s = 'rowscount' then
        FXMLExport.Split := ssRowsCount
      else
        FXMLExport.Split := ssNotSplit;
      FXMLExport.RowsCount := ServerConfig.GetNumber('server.exports.xml.splitrowscount');
      BuildExport(FXMLExport, lExt);
    finally
      FXMLExport.Free;
    end
 {$IFNDEF FPC}
  end else if (FFormat = sfXLS) then
  begin
    FXLSExport := TfrxBIFFExport.Create(nil);
    try
      FXLSExport.ShowDialog := False;
      FXLSExport.ShowProgress := False;
      FXLSExport.PageNumbers := FPageRange;
      FXLSExport.UseFileCache := FReport.EngineOptions.UseFileCache;
      BuildExport(FXLSExport, lExt);
    finally
      FXLSExport.Free;
    end
 {$ENDIF}
  end else if (FFormat = sfODS) and (ServerConfig.GetBool('server.exports.ods.active')) then
  begin
    FODSExport := TfrxODSExport.Create(nil);
    try
      FODSExport.ShowDialog := False;
      FODSExport.ShowProgress := False;
      FODSExport.PageNumbers := FPageRange;
      FODSExport.UseFileCache := FReport.EngineOptions.UseFileCache;
      FODSExport.SuppressPageHeadersFooters := ServerConfig.GetBool('server.exports.ods.continuous');
      FODSExport.EmptyLines := ServerConfig.GetBool('server.exports.ods.emptylines');
      FODSExport.ExportPageBreaks := ServerConfig.GetBool('server.exports.ods.pagebreaks');
      FODSExport.Wysiwyg := ServerConfig.GetBool('server.exports.ods.wysiwyg');
      FODSExport.Background := ServerConfig.GetBool('server.exports.ods.background');
      BuildExport(FODSExport, lExt);
    finally
      FODSExport.Free;
    end
  end else if (FFormat = sfODT) and (ServerConfig.GetBool('server.exports.odt.active')) then
  begin
    FODTExport := TfrxODTExport.Create(nil);
    try
      FODTExport.ShowDialog := False;
      FODTExport.ShowProgress := False;
      FODTExport.PageNumbers := FPageRange;
      FODTExport.UseFileCache := FReport.EngineOptions.UseFileCache;
      FODTExport.SuppressPageHeadersFooters := ServerConfig.GetBool('server.exports.odt.continuous');
      FODTExport.EmptyLines := ServerConfig.GetBool('server.exports.odt.emptylines');
      FODTExport.ExportPageBreaks := ServerConfig.GetBool('server.exports.odt.pagebreaks');
      FODTExport.Wysiwyg := ServerConfig.GetBool('server.exports.odt.wysiwyg');
      FODTExport.Background := ServerConfig.GetBool('server.exports.odt.background');
      BuildExport(FODTExport, lExt);
    finally
      FODTExport.Free;
    end
  end else if (FFormat = sfRTF) and (ServerConfig.GetBool('server.exports.rtf.active')) then
  begin
    FRTFExport := TfrxRTFExport.Create(nil);
    try
      FRTFExport.ShowDialog := False;
      FRTFExport.ShowProgress := False;
      FRTFExport.PageNumbers := FPageRange;
      FRTFExport.UseFileCache := FReport.EngineOptions.UseFileCache;
      FRTFExport.ExportPageBreaks := ServerConfig.GetBool('server.exports.rtf.pagebreaks');
      FRTFExport.ExportPictures := ServerConfig.GetBool('server.exports.rtf.pictures');
      FRTFExport.Wysiwyg := ServerConfig.GetBool('server.exports.rtf.wysiwyg');
      BuildExport(FRTFExport, lExt);
    finally
      FRTFExport.Free;
    end
  end else if (FFormat = sfCSV) and (ServerConfig.GetBool('server.exports.csv.active')) then
  begin
    FCSVExport := TfrxCSVExport.Create(nil);
    try
      FCSVExport.ShowDialog := False;
      FCSVExport.ShowProgress := False;
      FCSVExport.PageNumbers := FPageRange;
      FCSVExport.UseFileCache := FReport.EngineOptions.UseFileCache;
      FCSVExport.OEMCodepage := ServerConfig.GetBool('server.exports.csv.oemcodepage');
      FCSVExport.Separator := ServerConfig.CheckValue('server.exports.csv.separator', ';');
      BuildExport(FCSVExport, lExt);
    finally
      FCSVExport.Free;
    end
  end else if (FFormat = sfTXT) and (ServerConfig.GetBool('server.exports.txt.active'))  then
  begin
    FTXTExport := TfrxSimpleTextExport.Create(nil);
    try
      FTXTExport.ShowDialog := False;
      FTXTExport.ShowProgress := False;
      FTXTExport.PageNumbers := FPageRange;
      FTXTExport.UseFileCache := FReport.EngineOptions.UseFileCache;
      FTXTExport.PageBreaks := ServerConfig.GetBool('server.exports.txt.pagebreaks');
      FTXTExport.OEMCodepage := ServerConfig.GetBool('server.exports.txt.oemcodepage');
      BuildExport(FTXTExport, lExt);
    finally
      FTXTExport.Free;
    end
  end else if (FFormat = sfJPG) and (ServerConfig.GetBool('server.exports.jpg.active')) then
  begin
    FJPGExport := TfrxJPEGExport.Create(nil);
    try
      FJPGExport.ShowDialog := False;
      FJPGExport.PageNumbers := FPageRange;
      FJPGExport.UseFileCache := FReport.EngineOptions.UseFileCache;
      FJPGExport.CropImages := ServerConfig.GetBool('server.exports.jpg.crop');
      FJPGExport.Monochrome := ServerConfig.GetBool('server.exports.jpg.monochrome');
      FJPGExport.JPEGQuality := StrToInt(ServerConfig.CheckValue('server.exports.jpg.quality', '80'));
      FJPGExport.Resolution := StrToInt(ServerConfig.CheckValue('server.exports.jpg.resolution', '72'));
      FJPGExport.SeparateFiles := not ServerConfig.GetBool('server.exports.jpg.singlefile');
      BuildExport(FJPGExport, lExt);
    finally
      FJPGExport.Free;
    end
  end else if (FFormat = sfBMP) and (ServerConfig.GetBool('server.exports.bmp.active')) then
  begin
    FBMPExport := TfrxBMPExport.Create(nil);
    try
      FBMPExport.ShowDialog := False;
      FBMPExport.PageNumbers := FPageRange;
      FBMPExport.UseFileCache := FReport.EngineOptions.UseFileCache;
      FBMPExport.CropImages := ServerConfig.GetBool('server.exports.bmp.crop');
      FBMPExport.Monochrome := ServerConfig.GetBool('server.exports.bmp.monochrome');
      FBMPExport.Resolution := StrToInt(ServerConfig.CheckValue('server.exports.bmp.resolution', '72'));
      FBMPExport.SeparateFiles := not ServerConfig.GetBool('server.exports.bmp.singlefile');
      BuildExport(FBMPExport, lExt);
    finally
      FBMPExport.Free;
    end
 {$IFNDEF FPC}
  end else if (FFormat = sfGIF) and (ServerConfig.GetBool('server.exports.gif.active')) then
  begin
    FGIFExport := TfrxGIFExport.Create(nil);
    try
      FGIFExport.ShowDialog := False;
      FGIFExport.PageNumbers := FPageRange;
      FGIFExport.UseFileCache := FReport.EngineOptions.UseFileCache;
      FGIFExport.CropImages := ServerConfig.GetBool('server.exports.gif.crop');
      FGIFExport.Resolution := StrToInt(ServerConfig.CheckValue('server.exports.gif.resolution', '72'));
      FGIFExport.SeparateFiles := not ServerConfig.GetBool('server.exports.gif.singlefile');
      BuildExport(FGIFExport, lExt);
    finally
      FGIFExport.Free;
    end
{$ENDIF}
  end else if (FFormat = sfTIFF) and (ServerConfig.GetBool('server.exports.tiff.active')) then
  begin
    FTIFFExport := TfrxTIFFExport.Create(nil);
    try
      FTIFFExport.ShowDialog := False;
      FTIFFExport.PageNumbers := FPageRange;
      FTIFFExport.UseFileCache := FReport.EngineOptions.UseFileCache;
      FTIFFExport.CropImages := ServerConfig.GetBool('server.exports.tiff.crop');
      FTIFFExport.Monochrome := ServerConfig.GetBool('server.exports.tiff.monochrome');
      FTIFFExport.Resolution := StrToInt(ServerConfig.CheckValue('server.exports.tiff.resolution', '72'));
      FTIFFExport.SeparateFiles := not ServerConfig.GetBool('server.exports.tiff.singlefile');
      BuildExport(FTIFFExport, lExt);
    finally
      FTIFFExport.Free;
    end
  end else if (FFormat = sfPDF) and (ServerConfig.GetBool('server.exports.pdf.active')) then
  begin
    FPDFExport := TfrxPDFExport.Create(nil);
    try
      FPDFExport.ShowDialog := False;
      FPDFExport.PageNumbers := FPageRange;
      FPDFExport.EmbeddedFonts := ServerConfig.GetBool('server.exports.pdf.embeddedfonts');
      FPDFExport.Background := ServerConfig.GetBool('server.exports.pdf.background');
      FPDFExport.UseFileCache := FReport.EngineOptions.UseFileCache;
      FPDFExport.Outline := ServerConfig.GetBool('server.exports.pdf.outline') and FReport.PreviewOptions.OutlineVisible;
      FPDFExport.HTMLTags := ServerConfig.GetBool('server.exports.pdf.htmltags');
      FPDFExport.PrintOptimized := ServerConfig.GetBool('server.exports.pdf.printoptimized');
      BuildExport(FPDFExport, lExt);
    finally
      FPDFExport.Free;
    end
  end else if (FFormat = sfFRP) and (ServerConfig.GetBool('server.exports.fp3.active')) then
  begin
    FReport.PreviewPages.SaveToFile(FPath + FResultPage);
  end else
  // default output
  if (ServerConfig.GetBool('server.exports.html.active')) then
  begin
  if (FFormat = sfHTM) then
  begin
    FHTMLExport := TfrxHTMLExport.Create(nil);
    try
      FHTMLExport.ShowDialog := False;
      FHTMLExport.ShowProgress := False;
      FHTMLExport.AbsLinks := True;
      FHTMLExport.Server := True;
      FHTMLExport.PageNumbers := FPageRange;
      FHTMLExport.FixedWidth := ServerConfig.GetBool('server.exports.html.fixedwidth');
      FHTMLExport.PicsInSameFolder := ServerConfig.GetBool('server.exports.html.allinonefolder');
      FHTMLExport.Multipage := FMultipage;
      FHTMLExport.Navigator := FPageNav;
      s := ServerConfig.GetValue('server.exports.html.picsformat');
      if s = 'png' then FHTMLExport.PictureType := gpPNG else
      if s = 'bmp' then FHTMLExport.PictureType := gpBMP else
      {$IFDEF FPC}
        FHTMLExport.PictureType := gpJPG;
      {$ELSE}
        if s = 'jpeg' then FHTMLExport.PictureType := gpJPG else
      if s = 'gif' then FHTMLExport.PictureType := gpGIF else
      if s = 'emf' then FHTMLExport.PictureType := gpEMF else
      FHTMLExport.PictureType := gpWMF;
      {$ENDIF}
      FHTMLExport.ExportPictures := ServerConfig.GetBool('server.exports.html.pictures');
      FHTMLExport.ExportStyles := ServerConfig.GetBool('server.exports.html.styles');
      FHTMLExport.Background := ServerConfig.GetBool('server.exports.html.background');
      FHTMLExport.UseFileCache := FReport.EngineOptions.UseFileCache;
      FHTMLExport.ReportPath := frxGetAbsPathDir(ServerConfig.GetValue('server.reports.path'), ServerConfig.ConfigFolder);
      FHTMLExport.URLTarget := ServerConfig.GetValue('server.exports.html.urltarget');
      FHTMLExport.UseTemplates := True;

      if FPrint then
      begin
        FHTMLExport.Print := true;
        FHTMLExport.Navigator := false;
        FHTMLExport.Multipage := false;
      end;

      if Assigned(FParentReportServer) then
      begin

        if TfrxReportServer(FParentReportServer).PrintPDF then
          FHTMLExport.PrintLink := 'result?report=' + Str2HTML(ExtractReportName(FName)) +
            '&format=PDF&pagerange=' + FPageRange +
            '&cacheid=' + FSessionId;

        FHTMLExport.OnGetNavTemplate := SetNavTemplate;
        FHTMLExport.OnGetMainTemplate := SetMainTemplate;
        FHTMLExport.OnGetToolbarTemplate := SetToolbarTemplate;
        //FHTMLExport.OnExportImage := SetExportImage;
      end;

      FHTMLExport.RefreshLink := 'result?report=' + Str2HTML(ExtractReportName(FName)) + '&multipage=' + IntToStr(ord(FHTMLExport.Multipage));

      if Assigned(FVariables) then
      begin
        for i := 0 to FVariables.Count - 1 do
          FHTMLExport.PrintLink := FHTMLExport.PrintLink + '&' +
            UnQuoteStr(Str2HTML(FVariables.Items[i].Name)) + '=' +
            UnQuoteStr(Str2HTML(FVariables.Items[i].Value));
        for i := 0 to FVariables.Count - 1 do
          FHTMLExport.RefreshLink := FHTMLExport.RefreshLink + '&' +
            UnQuoteStr(Str2HTML(FVariables.Items[i].Name)) + '=' +
            UnQuoteStr(Str2HTML(FVariables.Items[i].Value));
      end;

      FHTMLExport.OnProcessHyperLink := @Serv_HyperlinkToStr;
      FHTMLExport.ParentDetailURL := Str2HTML(ExtractReportName(FName));

      s := ServerConfig.GetValue('server.http.indexfile');
      FResultPage := PathDelim + s;
      FHTMLExport.FileName := FPath + FResultPage;
      FReport.Export(FHTMLExport);

      if (not FHTMLExport.Navigator) and FHTMLExport.Multipage then
        FResultPage := PathDelim + ChangeFileExt(s, '.1.html')

    finally
      FHTMLExport.Free;
    end;
  end
  else
  begin
    FHTMLDivExport := TfrxHTML5DivExport.Create(nil);
    try
      FMime := ServerConfig.GetValue('server.exports.html.mimetype');
      FHTMLDivExport.ShowDialog := False;
      FHTMLDivExport.ShowProgress := False;
      FHTMLDivExport.Server := True;
      FHTMLDivExport.PageNumbers := FPageRange;
      FHTMLDivExport.Multipage := FMultipage;
      FHTMLDivExport.Navigation := FPageNav;
      s := ServerConfig.GetValue('server.exports.html.picsformat');
      if s = 'png' then FHTMLDivExport.PictureFormat := pfPNG else
      if s = 'bmp' then FHTMLDivExport.PictureFormat := pfBMP else
      {$IFDEF FPC}
        FHTMLDivExport.PictureFormat := pfJPG;
      {$ELSE}
        if s = 'jpeg' then FHTMLDivExport.PictureFormat := pfJPG else
          FHTMLDivExport.PictureFormat := pfEMF;
      {$ENDIF}
      FHTMLDivExport.UseFileCache := FReport.EngineOptions.UseFileCache;
      FHTMLDivExport.UseTemplates := True;

      if FPrint then
      begin
        FHTMLDivExport.Print := true;
        FHTMLDivExport.Navigation := false;
        FHTMLDivExport.Multipage := false;
      end;

      if Assigned(FParentReportServer) then
      begin
        FHTMLDivExport.OnGetNavTemplate := SetNavTemplate;
        FHTMLDivExport.OnGetMainTemplate := SetMainTemplate;
        FHTMLDivExport.OnGetToolbarTemplate := SetToolbarTemplate;
      end;

      FHTMLDivExport.OnProcessHyperLink := @Serv_HyperlinkToStr;
      FHTMLDivExport.ParentDetailURL := Str2HTML(ExtractReportName(FName));

      s := ServerConfig.GetValue('server.http.indexfile');
      FResultPage := PathDelim + s;
      FHTMLDivExport.FileName := FPath + FResultPage;
      FReport.Export(FHTMLDivExport);

      if (not FHTMLDivExport.Navigation) and FHTMLDivExport.Multipage then
        FResultPage := PathDelim + ChangeFileExt(s, '.1.html')

    finally
      FHTMLDivExport.Free;
    end;
  end;
  end;
  if IsFP3 then
    CloseCrit();
end;

{procedure TfrxReportSession.SetExportImage(Image: TGraphic; PicType: TfrxPictureType; var FileName: String);
begin
  // to-do
end;}

procedure TfrxReportSession.DoError;
begin
  FReportErrors := True;
  FReport.Errors.Add(FError);
  LogWriter.Write(ERROR_LEVEL, DateTimeToStr(Now) + #9 + FSessionId + #9'report session error: ' + FError);
  LogWriter.ErrorReached;
end;

procedure TfrxReportSession.ShowReportDialog(Page: TfrxDialogPage);
begin
  CurPage := Page;
  FCached := False;
  DoSaveForm;
  Continue := False;
  DialogActive := True;
  FReport.DoNotifyEvent(Page, Page.OnActivate);
  while (not Continue) and (not Terminated) do
  begin
    Sleep(1);
    PMessages;
  end;
  DoFillForm;
  DialogActive := False;
  FReport.DoNotifyEvent(Page, Page.OnDeactivate);
  while (not Readed) and (not Terminated) do
  begin
    Sleep(1);
    PMessages;
  end;
  Sleep(300);
end;

{$IFDEF DELPHI17}
procedure TfrxReportSession.TerminatedSet;
begin
  inherited;
  TerminateReport;
end;
{$ENDIF}

procedure TfrxReportSession.TerminateReport;
begin
  if not Terminated then
    Terminate;
  if Assigned(FReport) then
    FReport.Engine.StopReport;
end;

procedure TfrxReportSession.DoFillForm;
var
  i, j: Integer;
  Control: TfrxDialogControl;
  s: AnsiString;
  Reader: TfrxXMLSerializer;
begin
  if FNativeClient and (FStream.Size > 0) then
  begin
    FStream.Position := 0;
    Reader := TfrxXMLSerializer.Create(FStream);
    try
      Reader.Owner := FReport;
      try
        Reader.ReadRootComponent(CurPage, nil);
      except
        on E:Exception do
        begin
          FError := 'Dialog form error: ' + e.Message;
          DoError;
        end;
      end;
    finally
      Reader.Free;
    end
  end
  else if (not Terminated) and Assigned(FVariables) then
  begin
    for i := 0 to CurPage.AllObjects.Count - 1 do
    begin
       Control := TfrxDialogControl(CurPage.AllObjects[i]);
       if Control.Parent <> nil then
         s := Control.Parent.Name + '_' + Control.Name
       else
         s:= Control.Name;
       j := FVariables.IndexOf(s);
       if (j = -1) and (Control.Parent <> nil) and (Pos('_', s) > 0) then
         j := FVariables.IndexOf(Control.Parent.Name);
       if j <> -1 then
       begin
         s := FVariables.Items[j].Value;
         s := UnQuoteStr(s);
         if Control is TfrxEditControl then
           TfrxEditControl(Control).Text := s;
         if Control is TfrxDateEditControl then
           TfrxDateEditControl(Control).Date := StrToDate(s);
         if (Control is TfrxCheckBoxControl) then
         begin
           if (Pos(Control.Name, s) > 0) then
             TfrxCheckBoxControl(Control).Checked := True
           else
             TfrxCheckBoxControl(Control).Checked := False;
         end;
         if (Control is TfrxRadioButtonControl) then
         begin
           if (Pos(Control.Name, s) > 0) then
             TfrxRadioButtonControl(Control).Checked := True
           else
             TfrxRadioButtonControl(Control).Checked := False;
         end;
         if Control is TfrxMemoControl then
           TfrxMemoControl(Control).Text := s;
         if Control is TfrxComboBoxControl then
           TfrxComboBoxControl(Control).ItemIndex := StrToInt(s);
       end else
       begin
         if Control is TfrxCheckBoxControl then
           TfrxCheckBoxControl(Control).Checked := False;
         if Control is TfrxRadioButtonControl then
           TfrxRadioButtonControl(Control).Checked := False;
       end;
    end;
  end;
end;

procedure TfrxReportSession.DoSaveForm;
var
  WebForm: TfrxWebForm;
  f: TFileStream;
begin
  if not FNativeClient then
  begin
    WebForm := TfrxWebForm.Create(CurPage, FSessionId);
    try
      WebForm.ReportName := ExtractReportName(FReport.FileName);
      WebForm.Prepare;
      FResultPage := PathDelim + 'form.html';
      WebForm.SaveFormToFile(FPath + FResultPage);
    finally
      WebForm.Free;
    end;
  end
  else begin
    FResultPage := PathDelim + 'result.frm';
    f := TFileStream.Create(FPath + FResultPage, fmCreate);
    try
      CurPage.SaveToStream(f);
    finally
      {$IFNDEF Linux}
      FlushFileBuffers(f.Handle);
      {$ELSE}
      FileFlush(f.Handle);
      {$ENDIF}
      f.Free;
    end;
  end;
end;

procedure TfrxReportSession.DoAfterBuildReport;
begin
  TfrxReportServer(ParentReportServer).OnAfterBuildReport(FName, FVariables, FUserLogin);
end;

function TfrxReportSession.ExtractReportName(const FileName: String): String;
begin
  Result := StringReplace(FileName, frxGetAbsPathDir(ServerConfig.GetValue('server.reports.path'), ServerConfig.ConfigFolder), '', [])
end;


procedure TfrxReportSession.SetNavTemplate(const ReportName: String;
  Multipage: Boolean; PicsInSameFolder: Boolean; Prefix: String; TotalPages: Integer;
  var Template: String);
begin
  Template := '';
end;

procedure TfrxReportSession.SetToolbarTemplate(CurrentPage: Integer; TotalPages: Integer; Multipage: Boolean; Navigator: Boolean; var Template: String);
var
  FTemplate: TfrxServerTemplate;
  navigation, s, id: String;
begin
  Template := '';
  if Navigator then
  begin
    FTemplate := TfrxServerTemplate.Create;
    try
      FTemplate.SetTemplate('toolbar');
      navigation := '';

      navigation := navigation + '<div class="td divider">&nbsp;</div>' +
        '<ul class="td nav">' +
        '<li><input class="nav export_button" type="button" value=""/>' +
        '<ul class="round">' +
        GetExportButton('Acrobat PDF', 'PDF') +
        GetExportButton('Rich Text', 'RTF') +
        GetExportButton('Open Document Text', 'ODT') +
        GetExportButton('Open Document Spreadsheet', 'ODS') +
        GetExportButton('Excel table', 'XLS') +
        GetExportButton('XML table', 'XML') +
        GetExportButton('Comma separated text', 'CSV') +
        GetExportButton('Plain text', 'TXT') +
        GetExportButton('FastReport prepared', 'FP3') +
        '</ul></li></ul>';

      // print
      navigation := navigation + '<div class="td divider">&nbsp;</div>' +
        '<ul class="td nav"><li><input class="nav print_button" type="button" value="" title="Print" onclick="' +
        'window.open(window.location + ''&print=1'', ''_blank'')"/></li></ul>';

      // refresh
      navigation := navigation + '<div class="td divider">&nbsp;</div>' +
        '<ul class="td nav"><li><input class="nav refresh_button" type="button" value="" title="Refresh" onclick="' +
        'window.location.reload(true)"/></li></ul>';

      if (TotalPages > 1) and Multipage then
      begin
         if CurrentPage = 1 then
           s := 'disabled=disabled'
         else
          s := '';
         navigation := navigation + '<div class="td divider">&nbsp;</div><input class="td nav first_button" type="button" name="first" value="" ' +
         s +
         ' title="First" onclick="' +
         GetNavRequest('1') +'"/>';

         navigation := navigation + '<div class="td divider">&nbsp;</div><input class="td nav prev_button" type="button" name="prev" value="" ' +
         s +
         ' title="Previous" onclick="' +
         GetNavRequest(IntToStr(CurrentPage - 1)) +'"/>';

         id := 'FrReportPageN';
         s := '<input class="td input center" type="text" name="page" value="' +
            IntToStr(CurrentPage) + '" ' +
            'size="4" onchange="' +
            GetNavRequest(''' + document.getElementById(''FrReportPageN'').value + ''') +
            '" title="Enter page" id="' + id + '"/>';

         navigation := navigation + s + '<div class="td delim">/</div>';

         s := '<input class="td input center" type="text" value="' +
         IntToStr(TotalPages) + '" size="4" readonly="readonly" title="Total pages"/>';

         navigation := navigation + s;

         if CurrentPage = TotalPages then
           s := 'disabled=disabled'
         else
          s := '';
         navigation := navigation + '<input class="td nav next_button" type="button" name="next" value="" ' +
         s +
         ' title="Next" onclick="' +
         GetNavRequest(IntToStr(CurrentPage + 1)) +'"/>';

         navigation := navigation + '<div class="td divider">&nbsp;</div><input class="td nav last_button" type="button" name="last" value="" ' +
         s +
         ' title="Last" onclick="' +
         GetNavRequest(IntToStr(TotalPages)) +'"/>';
      end;

      FTemplate.Variables.AddVariable('navigation', navigation);
      FTemplate.Variables.AddVariable('reportid', '<input type="hidden" name="object" value="' + FSessionId + '"/>');
      FTemplate.Prepare;
      Template := FTemplate.TemplateStrings.Text;
    finally
      FTemplate.Free;
    end;
  end;
end;

function TfrxReportSession.GetNavRequest(PageN: String): String;
begin
  result := 'frRequestServer(''/' + FSessionId + '/index.' + PageN + '.html'')';
end;

function TfrxReportSession.GetExportButton(expName: String; exp: String): String;
begin
  result := '<li class="menuitem"><input class="menutext" type="button" name="format" value="' + expName + '" onclick="window.open(window.location + ''&format=' +
    exp + ''')"/></li>';
end;


procedure TfrxReportSession.SetMainTemplate(const Title,
  FrameFolder: String; Multipage: Boolean; Navigator: Boolean; var Template: String);
var
  FTemplate: TfrxServerTemplate;
  s: String;
begin
  Template := '';
  FReportTitle := Title;
  FTemplate := TfrxServerTemplate.Create;
  try
    FTemplate.SetTemplate('index');
    FTemplate.Variables.AddVariable('TITLE', Title);
    FTemplate.Variables.AddVariable('SESSION', FSessionId);
    if Multipage then
      s := '1.html'
    else
    if Navigator then
      s := 'main.html'
    else
      s := 'html';
    FTemplate.Variables.AddVariable('INDEX', '/' + FSessionId + '/index.' + s);
    FTemplate.Prepare;
    Template := FTemplate.TemplateStrings.Text;
  finally
    FTemplate.Free;
  end;
end;

function TfrxReportSession.GetResultFileName(const ext: String): String;
begin
  if IsFP3 then
    Result := PathDelim + FName + '.' + ext
  else
   Result := PathDelim +  StringReplace(StringReplace(StringReplace(ExtractFileName(ExtractReportName(FName)),
    '.fr3', '', [rfReplaceAll]), '.', '_', [rfReplaceAll]), ' ', '_', [rfReplaceAll]) +
    '_' + FormatDateTime('YYYYMMDDHHMM', Now) + '.' + ext;
end;

function Serv_HyperlinkToStr(HL: TfrxHyperlink; ParentDetailURL: String): String;

  function EraseQ(s: String): String;
  begin
    Result := StringReplace(s,'''','',[rfReplaceAll]);
  end;

begin
  Result := '';
  if HL = nil then
    Exit;
  if HL.Kind in [hkDetailReport, hkDetailPage] then
  begin
    Result := Result + 'result?report=';
    if (HL.DetailReport <> '') then
      Result := Result + HL.DetailReport
    else
      Result := Result + ParentDetailURL;
    Result := Result + '&mPage=' + HL.DetailPage;
    Result := Result + '&' + HL.ReportVariable + '=' + EraseQ(HL.Value);
  end;
end;

end.
