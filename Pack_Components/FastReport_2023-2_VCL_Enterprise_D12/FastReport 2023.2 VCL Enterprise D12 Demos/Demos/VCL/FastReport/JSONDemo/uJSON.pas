unit uJSON;

interface

{$I frx.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, StdCtrls,
  Forms, Dialogs, DateUtils, ComCtrls, ExtCtrls, pngimage, XPMan, ImgList, ActnList, Menus,
{$IFDEF DELPHI16}
  VCLTee.CandleCh, VCLTee.TeeEquiVolume,
{$ENDIF}
  frxClass, frxJSON, frxTransportHTTP, frxDesgn, frxChart, frxExportBaseDialog, frxExportPDF,
  uDemoMain, frCoreClasses;

type
  TfrmJSONMain = class(TfrmDemoMain)
    frxReport1: TfrxReport;
    JSON_DS: TfrxUserDataSet;
    ButtonConnectToJSON: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ComboBoxName: TComboBox;
    ComboBoxResolution: TComboBox;
    DateTimePickerFrom: TDateTimePicker;
    Label4: TLabel;
    DateTimePickerTo: TDateTimePicker;
    ButtonShowReport: TButton;
    Image1: TImage;
    Label5: TLabel;
    StatusBar1: TStatusBar;
    Button1: TButton;
    frxDesigner1: TfrxDesigner;
    frxChartObject1: TfrxChartObject;
    frxPDFExport1: TfrxPDFExport;
    procedure ButtonConnectToJSONClick(Sender: TObject);
    procedure ButtonShowReportClick(Sender: TObject);
    procedure StatusBar1DrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel; const Rect: TRect);
    procedure JSON_DSGetValue(const VarName: string; var Value: Variant);
    procedure Button1Click(Sender: TObject);
    procedure DateTimePickerFromChange(Sender: TObject);
    procedure DateTimePickerToChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ComboBoxNameChange(Sender: TObject);
  private
    FJSON: TfrxJSON;
    FRes: string;
    FSymbol: string;
    FJSONArrayT, FJSONArrayC, FJSONArrayO, FJSONArrayH, FJSONArrayL, FJSONArrayV: TfrxJSONArray;
  end;

var
  frmJSONMain: TfrmJSONMain;

implementation

{$R *.dfm}

procedure TfrmJSONMain.Button1Click(Sender: TObject);
begin
  if (FRes = '') then
    ButtonConnectToJSON.Click;
  frxReport1.DesignReport();
end;

procedure TfrmJSONMain.ButtonConnectToJSONClick(Sender: TObject);
var
  ATransportHTTP: TfrxTransportHTTP;
  AResolution, AFromCandlesHistory, AToCandlesHistory: string;
  AStringStream: TStringStream;
begin
  frxReport1.LoadFromFile('ChartJSON.fr3');
  JSON_DS.RangeEnd := reCount;
  FSymbol := ComboBoxName.Items[ComboBoxName.ItemIndex];
  AResolution := ComboBoxResolution.Items[ComboBoxResolution.ItemIndex];
  AFromCandlesHistory := IntToStr(DateTimeToUnix(DateTimePickerFrom.DateTime));
  AToCandlesHistory := IntToStr(DateTimeToUnix(DateTimePickerTo.DateTime));

  ATransportHTTP := TfrxTransportHTTP.Create(nil);
  try
    FRes := ATransportHTTP.Get('https://api.bcs.ru/udfdatafeed/v1/history?symbol=' +
      FSymbol +
      '&resolution=' + AResolution +
      '&from=' + AFromCandlesHistory +
      '&to=' + AToCandlesHistory);

    if (FRes = '') or (pos('"s":"ok"', FRes) = 0) then
    begin
      StatusBar1.Font.Color := clRed;
      StatusBar1.SimpleText := 'Error loading JSON';
      AStringStream := TStringStream.Create('', TEncoding.UTF8);
      try
        AStringStream.LoadFromFile('JSON/' + FSymbol + '.json');
        FRes:= AStringStream.DataString;
      finally
        AStringStream.Free;
      end;
      StatusBar1.SimpleText := 'Successful JSON loading from file ' + FSymbol + '.json';
    end
    else
    begin
      StatusBar1.Font.Color := clGreen;
      StatusBar1.SimpleText := 'Successful JSON(' + FSymbol + ') loading';
    end;
    FJSON := TfrxJSON.Create(FRes);
    if FJSON.IsValid then
    begin
      StatusBar1.SimpleText := StatusBar1.SimpleText + ' /JSON is Valid';
      if FJSON.IsNameExists('t') then
        FJSONArrayT := TfrxJSONArray.Create(FJSON.ObjectByName('t'));

      FJSONArrayC := TfrxJSONArray.Create(FJSON.ObjectByName('c'));
      FJSONArrayO := TfrxJSONArray.Create(FJSON.ObjectByName('o'));
      FJSONArrayH := TfrxJSONArray.Create(FJSON.ObjectByName('h'));
      FJSONArrayL := TfrxJSONArray.Create(FJSON.ObjectByName('l'));
      FJSONArrayV := TfrxJSONArray.Create(FJSON.ObjectByName('v'));

      JSON_DS.Fields.Clear;
      JSON_DS.Fields.Add('Ticker');
      JSON_DS.Fields.Add('Date');
      JSON_DS.Fields.Add('Time');
      JSON_DS.Fields.Add('Open');
      JSON_DS.Fields.Add('Close');
      JSON_DS.Fields.Add('High');
      JSON_DS.Fields.Add('Low');
      JSON_DS.Fields.Add('Vol');
      JSON_DS.RangeEndCount := FJSONArrayT.Count;
    end
    else
      StatusBar1.SimpleText := StatusBar1.SimpleText + ' /JSON is Invalid';
  finally
    ATransportHTTP.Free;
  end;
end;

procedure TfrmJSONMain.ButtonShowReportClick(Sender: TObject);
begin
  if (FRes = '') then ButtonConnectToJSON.Click;
    frxReport1.ShowReport();
end;

procedure TfrmJSONMain.ComboBoxNameChange(Sender: TObject);
begin
  ButtonConnectToJSON.Click;
end;

procedure TfrmJSONMain.DateTimePickerFromChange(Sender: TObject);
begin
  ButtonConnectToJSON.Click;
end;

procedure TfrmJSONMain.DateTimePickerToChange(Sender: TObject);
begin
  ButtonConnectToJSON.Click;
end;

procedure TfrmJSONMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(FJSON);
  FreeAndNil(FJSONArrayT);
  FreeAndNil(FJSONArrayC);
  FreeAndNil(FJSONArrayO);
  FreeAndNil(FJSONArrayH);
  FreeAndNil(FJSONArrayL);
  FreeAndNil(FJSONArrayV);
end;

procedure TfrmJSONMain.JSON_DSGetValue(const VarName: string; var Value: Variant);
var
  Item, Time: string;
begin
  Item := FJSONArrayT.GetString(JSON_DS.RecNo);
  DateTimeToString(Time, 't', UnixToDateTime(StrToInt64(Item)));
  if VarName = 'Ticker' then
  begin
     Value := FSymbol;
     Exit;
  end
  else if VarName = 'Date' then
  begin
    Value := DateToStr(UnixToDateTime(StrToInt64(Item))) + ' ' + Time;
    Exit;
  end
  else if VarName = 'Time' then
  begin
    Value := Time;
    Exit;
  end
  else if VarName = 'Open' then
    Item := FJSONArrayO.GetString(JSON_DS.RecNo)
  else if VarName = 'Close' then
    Item := FJSONArrayC.GetString(JSON_DS.RecNo)
  else if VarName = 'High' then
    Item := FJSONArrayH.GetString(JSON_DS.RecNo)
  else if VarName = 'Low' then
    Item := FJSONArrayL.GetString(JSON_DS.RecNo)
  else if VarName = 'Vol' then
    Item := FJSONArrayV.GetString(JSON_DS.RecNo);

  Value := Item;
end;

procedure TfrmJSONMain.StatusBar1DrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
  if Panel = StatusBar.Panels[0] then
  begin
    StatusBar.Canvas.Font.Color := clRed;
    StatusBar.Canvas.TextOut(Rect.left, Rect.Top, StatusBar.Panels[0].Text);
  end;
end;

end.
