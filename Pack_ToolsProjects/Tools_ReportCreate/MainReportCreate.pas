unit MainReportCreate;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms,
  Dialogs, StdCtrls, ShellApi, frxClass, frxServerClient,
  frxGZip, frxDCtrl, frxChBox, frxCross, frxRich, frxChart,
  frxOLE, frxBarcode, ExtCtrls, frxExportPDF, frxExportImage,
  frxExportRTF, frxExportXML, frxExportXLS, frxExportHTML,StrUtils,
  {$IFNDEF Delphi12}frxExportTXT, {$ENDIF} frxGradient, Graphics, ComCtrls, Menus, ImgList
{$IFDEF Delphi6}
, Variants
{$ENDIF}
, frxExportMail, frxExportText, frxExportCSV, System.ImageList,
  frxExportBaseDialog, Vcl.Imaging.pngimage, frxFDComponents;

type
  TFrmMainReportCreate = class(TForm)
    frxServerConnection1: TfrxServerConnection;
    TestBtn: TButton;
    Log: TMemo;
    Rep: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Port: TEdit;
    Threads: TEdit;
    Label6: TLabel;
    frxBarCodeObject1: TfrxBarCodeObject;
    frxOLEObject1: TfrxOLEObject;
    frxChartObject1: TfrxChartObject;
    frxRichObject1: TfrxRichObject;
    frxCrossObject1: TfrxCrossObject;
    frxCheckBoxObject1: TfrxCheckBoxObject;
    frxDialogControls1: TfrxDialogControls;
    Label7: TLabel;
    Login: TEdit;
    Label8: TLabel;
    Password: TEdit;
    StopBtn: TButton;
    Label9: TLabel;
    Label10: TLabel;
    Image1: TImage;
    frxGradientObject1: TfrxGradientObject;
    frxHTMLExport1: TfrxHTMLExport;
    frxXLSExport1: TfrxXLSExport;
    frxXMLExport1: TfrxXMLExport;
    frxRTFExport1: TfrxRTFExport;
    frxBMPExport1: TfrxBMPExport;
    frxJPEGExport1: TfrxJPEGExport;
    frxTIFFExport1: TfrxTIFFExport;
    frxPDFExport1: TfrxPDFExport;
    Host: TEdit;
    ReportsTree: TTreeView;
    Description: TMemo;
    Label16: TLabel;
    Panel5: TPanel;
    Label17: TLabel;
    ConnectBtn: TButton;
    Panel9: TPanel;
    Label18: TLabel;
    PopupMenu1: TPopupMenu;
    Clear1: TMenuItem;
    frxReportClient1: TfrxReportClient;
    ImageList1: TImageList;
    frxCSVExport1: TfrxCSVExport;
    frxSimpleTextExport1: TfrxSimpleTextExport;
    frxMailExport1: TfrxMailExport;
    Panel1: TPanel;
    DesignBtn: TButton;
    frxFDComponents: TfrxFDComponents;
    Panel2: TPanel;
    Label11: TLabel;
    edtPARAM1: TEdit;
    edtPARAM2: TEdit;
    edtPARAM3: TEdit;
    edtPARAM4: TEdit;
    edtPARAMVALUE1: TEdit;
    edtPARAMVALUE2: TEdit;
    edtPARAMVALUE3: TEdit;
    edtPARAMVALUE4: TEdit;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    procedure TestBtnClick(Sender: TObject);
    procedure ShowBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure StopBtnClick(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure ListBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ConnectBtnClick(Sender: TObject);
    procedure Clear1Click(Sender: TObject);
    procedure ReportsTreeChange(Sender: TObject; Node: TTreeNode);
    procedure ReportsTreeCustomDrawItem(Sender: TCustomTreeView;
      Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure ExportBtnClick(Sender: TObject);
    procedure DesignBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    ThreadList: TList;
    ReportsList: TStringList;
    procedure ClearThreads;
  public
    const FAppName = 'REPORTCREATE';

    procedure AddFunctionFastReport;
    function  OnUserFunctionFastReport(const MethodName: string; var Params: Variant): Variant;
  end;

  TfrxClientTestThread = class (TThread)
  protected
    procedure Execute; override;
  private
    CountRep: Integer;
    ErrorsCount: Integer;
    Log: TMemo;
    ThreadID: Integer;
    FConnection: TfrxServerConnection;
    FRepName: String;
    procedure AppendLog;
    procedure FinishLog;
  public

    Report: TfrxReportClient;
    Done: Boolean;
    constructor Create(C: TfrxServerConnection; RepName: String;Id: Integer; Rep: Integer; L: TMemo);


  end;

var
  FrmMainReportCreate: TFrmMainReportCreate;

implementation

{$R *.dfm}

procedure TFrmMainReportCreate.TestBtnClick(Sender: TObject);
var
  i, j, k: Integer;
  Thread: TfrxClientTestThread;
  s: String;
begin
  frxServerConnection1.Host := Host.Text;
  frxServerConnection1.Port := StrToInt(Port.Text);
  frxServerConnection1.Login := Login.Text;
  frxServerConnection1.Password := Password.Text;
//  if (Length(ProxyHost.Text) > 0) then
//  begin
//    frxServerConnection1.ProxyHost := ProxyHost.Text;
//    frxServerConnection1.ProxyPort := StrToInt(ProxyPort.Text);
//  end;
  ClearThreads;
  j := StrToInt(Threads.Text);
  k := StrToInt(Rep.Text);
  i := Integer(ReportsTree.Selected.Data);
  if i <> -1 then
  begin
    Log.Lines.Add('Start test');
    s := ReportsList[i + 1];
    for i := 1 to j do
    begin
      Thread := TfrxClientTestThread.Create(frxServerConnection1, s, i, k, Log);
      ThreadList.Add(Thread);
    end;
  end;
end;

procedure TFrmMainReportCreate.ShowBtnClick(Sender: TObject);
begin
  //
end;


procedure TFrmMainReportCreate.FormCreate(Sender: TObject);
begin
  ThreadList := TList.Create;
  ReportsList := TStringList.Create;
  try
//    FDBConnection := TDatabaseConnection.Create;
//    if (FAppName).FDConnection.Connected then
//    begin
//      frxFDComponents.DefaultDatabase := TDatabaseConnection.Get(FAppName).FDConnection;
//    end;
  except on E: Exception do
   ShowMessage(E.Message);
  end;

  //Configura procedimentos para Usar Funcition Internas
  AddFunctionFastReport;
  frxReportClient1.OnUserFunction := OnUserFunctionFastReport;

end;

procedure TFrmMainReportCreate.FormShow(Sender: TObject);
begin
  frxReportClient1.Variables.AddVariable('Neski','FIL_CODIGO','001');
  ConnectBtn.Click;
end;

procedure TFrmMainReportCreate.ClearThreads;
var
  i: Integer;
begin
  for i := 0 to ThreadList.Count - 1 do
    if Assigned(TfrxClientTestThread(ThreadList[i])) then
    begin
      TfrxClientTestThread(ThreadList[i]).Terminate;
      TfrxClientTestThread(ThreadList[i]).Free;
    end;
  ThreadList.Clear;
end;

procedure TFrmMainReportCreate.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ReportsList.Free;
  ClearThreads;
  ThreadList.Free;
end;

procedure TFrmMainReportCreate.StopBtnClick(Sender: TObject);
begin
  ClearThreads;
end;

procedure TFrmMainReportCreate.ListBox1DblClick(Sender: TObject);
begin
  ShowBtnClick(Sender);
end;

procedure TFrmMainReportCreate.ListBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
    ShowBtnClick(Sender);
end;

function TFrmMainReportCreate.OnUserFunctionFastReport(const MethodName: string;
  var Params: Variant): Variant;
begin
  if UpperCase(MethodName) = Uppercase('QuotedStr') then
    Result := QuotedStr(Params[0]);
end;

procedure TFrmMainReportCreate.ConnectBtnClick(Sender: TObject);
var
  t: Cardinal;
  tf: Double;
  s, s1: String;
  AccessFlag: Boolean;
  i: Integer;
  Node: TTreeNode;
  TopNode: TTreeNode;
  OldName: String;

begin
  ReportsTree.Items.Clear;
  ReportsList.Clear;
  Log.Clear;

  frxServerConnection1.Host := Host.Text;
  frxServerConnection1.Port := StrToInt(Port.Text);
  frxServerConnection1.Login := Login.Text;
  frxServerConnection1.Password := Password.Text;
//  if (Length(ProxyHost.Text) > 0) then
//  begin
//    frxServerConnection1.ProxyHost := ProxyHost.Text;
//    frxServerConnection1.ProxyPort := StrToInt(ProxyPort.Text);
//  end;
  t := GetTickCount;
  Log.Lines.Text := Log.Lines.Text +
    frxReportClient1.GetServerVariable('SERVER_NAME');
  tf := (GetTickCount - t) / 1000;
  if frxReportClient1.Errors.Count = 0 then
  begin
    Log.Lines.Text := Log.Lines.Text +
      'Version: ' + frxReportClient1.GetServerVariable('SERVER_SOFTWARE');
    Log.Lines.Text := Log.Lines.Text +
      'From: ' + frxReportClient1.GetServerVariable('SERVER_LAST_UPDATE');
    Log.Lines.Text := Log.Lines.Text +
      'Uptime: ' + frxReportClient1.GetServerVariable('SERVER_UPTIME');
    Log.Lines.Add('Ping:' + FloatToStr(tf) + 'ms.');
  end;
  Log.Lines.AddStrings(frxReportClient1.Errors);

  AccessFlag :=  frxReportClient1.Errors.Count = 0;

  if AccessFlag then
  begin
    ReportsList.Text := frxReportClient1.GetServerVariable('SERVER_REPORTS_LIST');
    if ReportsList.Count > 0 then
    begin
      ReportsTree.Items.BeginUpdate;
      TopNode := nil;
      Oldname := '';
      for i := 0 to (ReportsList.Count div 3) - 1 do
      begin
        s := ReportsList[(i * 3) + 1];
        s := StringReplace(StringReplace(s, ExtractFileName(s), '', []), '\', ' ', [rfReplaceAll]);
        if s <> OldName then
        begin
          if s = '' then
            s1 := 'Reports'
          else
            s1 := s;
          Node := ReportsTree.Items.AddChild(nil, s1);
          Node.Data := Pointer(-1);
          Node.ImageIndex := 0;
          TopNode := Node;
          OldName := s;
        end;
        Node := ReportsTree.Items.AddChild(TopNode, ReportsList[i * 3]);
        Node.Data := Pointer((i * 3));
        Node.ImageIndex := 1;
      end;
      ReportsTree.Items.EndUpdate;
      ReportsTree.TopItem := ReportsTree.Items[0];
      ReportsTree.Selected := ReportsTree.Items[0];
      ReportsTree.SetFocus;
    end else
      Log.Lines.Add('Nothing reports is available or information restricted.');
  end;
end;

procedure TFrmMainReportCreate.DesignBtnClick(Sender: TObject);
var
  LReport,xx : TfrxReport;
  LPathReport : String;
  LIDX : Integer;
begin
  try
    if ReportsTree.Items.Count > 0 then
    begin
      LReport := TfrxReport.Create(Self);
      LIDX := Integer(ReportsTree.Selected.Data);
      if LIDX <> -1 then
      begin
        LPathReport := frxReportClient1.GetServerVariable('ReportsPathServer');
        if copy(LPathReport,1,2) = '.\' then
          LPathReport := ExtractFileDir(ExtractShortPathName(ParamStr(0)))+Copy(LPathReport,2,Length(LPathReport))
        else
          LPathReport := frxReportClient1.GetServerVariable('ReportsPathServer');
        //
        LPathReport := LPathReport+ReportsList[LIDX + 1];
        LPathReport := StringReplace(LPathReport, #$D#$A,'',[rfReplaceAll]);

        frxReportClient1.Report.LoadFromFile(LPathReport);
        //Variables
        frxReportClient1.Variables.Clear;
        frxReportClient1.Variables[edtPARAM1.Text] := QuotedStr(edtPARAMVALUE1.Text);
        frxReportClient1.Variables[edtPARAM2.Text] := QuotedStr(edtPARAMVALUE2.Text);
        frxReportClient1.Variables[edtPARAM3.Text] := QuotedStr(edtPARAMVALUE3.Text);
        frxReportClient1.Variables[edtPARAM4.Text] := QuotedStr(edtPARAMVALUE4.Text);
        //
        frxReportClient1.Report.DesignReport;
      end;
    end;
  finally
    LReport.Free;
  end;
end;

procedure TFrmMainReportCreate.AddFunctionFastReport;
begin
  with frxReportClient1 do
  begin
    AddFunction('function QuotedStr(Valor : String):String', 'NESKI', 'Coloca Aspas em Valores String');
  end;
end;

procedure TFrmMainReportCreate.Clear1Click(Sender: TObject);
begin
  Log.Clear;
end;

procedure TFrmMainReportCreate.ReportsTreeChange(Sender: TObject; Node: TTreeNode);
var
  i: Integer;
begin
  i := Integer(Node.Data);
  if i <> -1 then
    Description.Text := ReportsList[i + 2]
  else
    Description.Text := Node.Text;
//  ShowBtn.Enabled := i <> -1;
//  ExportBtn.Enabled := ShowBtn.Enabled;
//  TestBtn.Enabled := ShowBtn.Enabled;
end;

procedure TFrmMainReportCreate.ReportsTreeCustomDrawItem(Sender: TCustomTreeView;
  Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  if Node.Count <> 0 then
    ReportsTree.Canvas.Font.Style := [fsBold];
end;

procedure TFrmMainReportCreate.ExportBtnClick(Sender: TObject);
begin
end;

{ TfrxClientTestThread }

constructor TfrxClientTestThread.Create(C: TfrxServerConnection; RepName: String;
    Id: Integer; Rep: Integer; L: TMemo);
begin
  inherited Create(True);
  ErrorsCount := 0;
  ThreadId := Id;
  CountRep := Rep;
  FConnection := C;
  FRepName := RepName;
  Log := L;
  Done := False;
  Resume;
end;

procedure TfrxClientTestThread.Execute;
var
 i: Integer;
begin
  Done := False;
  Report := TfrxReportClient.Create(nil);
  Report.EngineOptions.EnableThreadSafe := True;
  Report.ShowProgress := true;
  Report.EngineOptions.SilentMode := False;
  Report.Connection := FConnection;
  Report.ReportName := FRepName;
  i := 0;
  while (i < CountRep) and (not Terminated) do
  begin
    Report.Clear;
    Report.PrepareReport;
    Synchronize(AppendLog);
    ErrorsCount := ErrorsCount + Report.Errors.Count;
    Inc(i);
  end;
  Synchronize(FinishLog);
  Report.Free;
  Done := True;
end;

procedure TfrxClientTestThread.AppendLog;
begin
  if Assigned(Log) and (Report.Errors.Count > 0) then
  begin
    Log.Lines.Add('Thread#' + IntToStr(ThreadID));
    Log.Lines.AddStrings(Report.Errors);
  end;
end;

procedure TfrxClientTestThread.FinishLog;
begin
  if Assigned(Log) and (not Terminated) then
    Log.Lines.Add('Thread#' + IntToStr(ThreadID) + ' finished. Errors:' + IntToStr(ErrorsCount));
end;

end.
