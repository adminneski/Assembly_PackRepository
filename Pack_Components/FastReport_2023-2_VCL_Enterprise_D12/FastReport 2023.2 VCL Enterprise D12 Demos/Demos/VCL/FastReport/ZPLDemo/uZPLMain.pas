unit uZPLMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, ComCtrls,
  frxClass, frxExportBaseDialog, frxExportZPL, IniFiles, frxPrinter, Printers, WinSpool,
  uDemoMain;

const
  ConfigFileName = 'config.ini';

type
  TfrmZPL = class(TfrmDemoMain)
    LSelect_Printer: TLabel;
    Printers: TComboBox;
    ShowZPL: TButton;
    Print: TButton;
    PageControl1: TPageControl;
    Reports: TTabSheet;
    ZPL_text: TTabSheet;
    DesignR: TButton;
    SelectR: TButton;
    ShowR: TButton;
    ZPS: TGroupBox;
    LDensity: TLabel;
    LPrinter_Init: TLabel;
    LPrinter_Finish: TLabel;
    LPage_Init: TLabel;
    LFont_Scale: TLabel;
    LFont: TLabel;
    LCode_Page: TLabel;
    Density: TComboBox;
    PrinterInit: TEdit;
    CodePage: TEdit;
    PrinterFinish: TEdit;
    PageInit: TEdit;
    FontScale: TEdit;
    Font: TEdit;
    PrintAB: TCheckBox;
    Memo1: TMemo;
    LoadFF: TButton;
    LRepName: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure SelectRClick(Sender: TObject);
    procedure DesignRClick(Sender: TObject);
    procedure ShowRClick(Sender: TObject);
    procedure ShowZPLClick(Sender: TObject);
    procedure PrintClick(Sender: TObject);
    procedure LoadFFClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FIsPreparedReport: Boolean;
    FPreview: Boolean;
    FReportFileName: String;
    procedure LoadIni();
    procedure SaveIni();
  protected
    function GetCaption: string; override;
  end;

var
  frmZPL: TfrmZPL;

implementation

{$R *.dfm}

procedure TfrmZPL.DesignRClick(Sender: TObject);
var
  AReport: TfrxReport;
begin
  if not FIsPreparedReport then
  begin
    AReport := TfrxReport.Create(Self);
    try
      AReport.LoadFromFile(FReportFileName);
      AReport.DesignReport();
    finally
      AReport.Free;
    end;
  end;
end;

procedure TfrmZPL.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SaveIni();
end;

procedure TfrmZPL.FormCreate(Sender: TObject);
begin
  Inherited;
  Density.ItemIndex := 1;
  Printers.Items.Assign(frxPrinters.Printers);
  if Printers.Items.Count > 0 then
  begin
    Print.Enabled := True;
    Printers.ItemIndex := 0;
  end;
  FIsPreparedReport := false;
  FPreview := false;
  LoadIni;
end;

function TfrmZPL.GetCaption: string;
begin
  Result := 'ZPL Demo';
end;

procedure TfrmZPL.LoadFFClick(Sender: TObject);
var
  AOpenDialog: TOpenDialog;
begin
  AOpenDialog := TOpenDialog.Create(Self);
  try
    AOpenDialog.InitialDir := ExtractFileDir(ParamStr(0));
    AOpenDialog.Filter := 'ZPL File (*.zpl)|*.zpl|Text File (*.txt)|*.txt;';
    if AOpenDialog.Execute() then
      Memo1.Lines.LoadFromFile(AOpenDialog.FileName)
  finally
    AOpenDialog.Free;
  end;
end;

procedure TfrmZPL.PrintClick(Sender: TObject);
var
  AReport: TfrxReport;
  AExpert: TfrxZPLExport;
  AStream: TMemoryStream;
begin
  SaveIni;
  if PageControl1.TabIndex = 0 then
  begin
    if FReportFileName = '' then
      SelectR.Click
    else
    begin
      AReport := TfrxReport.Create(Self);
      try
        AExpert := TfrxZPLExport.Create(Self);
        try
          if not FIsPreparedReport then
          begin
            AReport.LoadFromFile(FReportFileName);
            AReport.PrepareReport();
          end
          else
            AReport.PreviewPages.LoadFromFile(FReportFileName);
          AExpert.ZplDensity := TZplDensity(Density.ItemIndex);
          AExpert.PrinterInit := PrinterInit.Text;
          AExpert.PrinterFinish := PrinterFinish.Text;
          AExpert.CodePage := CodePage.Text;
          AExpert.PageInit := PageInit.Text;
          AExpert.FontScale := StrToFloat(FontScale.Text);
          AExpert.PrinterFont := Font.Text;
          AExpert.PrintAsBitmap := PrintAB.Checked;
          AStream := TMemoryStream.Create();
          try
            AExpert.Stream := AStream;
            AReport.Export(AExpert);
            AStream.Position := 0;
            Memo1.Lines.LoadFromStream(AStream);
          finally
            AStream.Free;
          end;
          if not FPreview then
            WriteToPrinter(Printers.ItemIndex, Printers.Text, Memo1.Text);
        finally
          AExpert.Free;
        end;
      finally
        AReport.Free;
      end;
    end;
  end
  else
  begin
    WriteToPrinter(Printers.ItemIndex, Printers.Text, Memo1.Text);
  end;
end;

procedure TfrmZPL.SelectRClick(Sender: TObject);
var
  AOpenDialog: TOpenDialog;
begin
  AOpenDialog := TOpenDialog.Create(Self);
  try
    AOpenDialog.InitialDir := ExtractFileDir(ParamStr(0));
    AOpenDialog.Filter := 'Report File (*.fr3)|*.fr3|Prepared Report File (*.fp3)|*.fp3;';
    if AOpenDialog.Execute() then
    begin
      FReportFileName := AOpenDialog.FileName;
      LRepName.Caption := ExtractFileName(FReportFileName);
      LRepName.Visible := True;
      FIsPreparedReport := (ExtractFileExt(FReportFileName) = '.fp3');
      DesignR.Enabled := not FIsPreparedReport;
      ShowR.Enabled := true;
    end;
  finally
    AOpenDialog.Free;
  end;
end;

procedure TfrmZPL.ShowRClick(Sender: TObject);
var
  AReport: TfrxReport;
begin
  AReport := TfrxReport.Create(Self);
  try
    if not FIsPreparedReport then
    begin
      AReport.LoadFromFile(FReportFileName);
      AReport.PrepareReport();
    end
    else
      AReport.PreviewPages.LoadFromFile(FReportFileName);
    AReport.ShowPreparedReport;
  finally
    AReport.Free;
  end;
end;

procedure TfrmZPL.ShowZPLClick(Sender: TObject);
begin
  FPreview := True;
  Print.Click();
  FPreview := False;
  PageControl1.TabIndex := 1;
end;

procedure TfrmZPL.LoadIni();
var
  AIni: TIniFile;
begin
  AIni := TIniFile.Create(ExtractFileDir(Application.ExeName) + '\' + ConfigFileName);
  try
    Density.ItemIndex := AIni.ReadInteger('Settings', 'Density', 1);
    PrinterInit.Text := AIni.ReadString('Settings', 'PrinterInit', '');
    CodePage.Text := AIni.ReadString('Settings', 'CodePage', '^PW464^LS0');
    PrinterFinish.Text := AIni.ReadString('Settings', 'PrinterFinish', '');
    PageInit.Text := AIni.ReadString('Settings', 'PageInit', '');
    FontScale.Text := AIni.ReadString('Settings', 'FontScale', '1,00');
    Font.Text := AIni.ReadString('Settings', 'Font', 'U');
    PrintAB.Checked := AIni.ReadBool('Settings', 'PrintAB', True);
  finally
    AIni.Free;
  end;
end;

procedure TfrmZPL.SaveIni();
var
  AIni: TIniFile;
begin
  AIni := TIniFile.Create(ExtractFileDir(Application.ExeName) + '\' + ConfigFileName);
  try
    AIni.WriteInteger('Settings', 'Density', Density.ItemIndex);
    AIni.WriteString ('Settings', 'PrinterInit', PrinterInit.Text);
    AIni.WriteString ('Settings', 'CodePage', CodePage.Text);
    AIni.WriteString ('Settings', 'PrinterFinish', PrinterFinish.Text);
    AIni.WriteString ('Settings', 'PageInit', PageInit.Text);
    AIni.WriteString ('Settings', 'FontScale', FontScale.Text);
    AIni.WriteString ('Settings', 'Font', Font.Text);
    AIni.WriteBool   ('Settings', 'PrintAB', PrintAB.Checked);
  finally
    AIni.Free;
  end;
end;

end.
