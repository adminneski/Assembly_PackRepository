unit uFastScript;

interface

{$I fs.inc}

uses
  Windows,
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls, ImgList, ExtCtrls, ToolWin, fs_iinterpreter,
  fs_iformsrtti, fs_igraphicsrtti, fs_iclassesrtti, fs_synmemo, fs_tree,
  fs_ipascal, fs_icpp, fs_ijs, fs_ibasic;

type
  TfrmFastScriptMain = class(TForm)
    OpenDialog1: TOpenDialog;
    ToolBar1: TToolBar;
    LoadBtn: TToolButton;
    RunBtn: TToolButton;
    ImageList1: TImageList;
    Panel1: TPanel;
    Label2: TLabel;
    LangCB: TComboBox;
    ToolButton1: TToolButton;
    fsScript1: TfsScript;
    frClassesRTTI1: TfsClassesRTTI;
    frGraphicsRTTI1: TfsGraphicsRTTI;
    frFormsRTTI1: TfsFormsRTTI;
    Status: TMemo;
    Splitter1: TSplitter;
    EvaluateB: TToolButton;
    Memo: TfsSyntaxMemo;
    fsTree1: TfsTree;
    Splitter2: TSplitter;
    fsPascal1: TfsPascal;
    fsCPP1: TfsCPP;
    fsJScript1: TfsJScript;
    fsBasic1: TfsBasic;
    Bevel1: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure LoadBtnClick(Sender: TObject);
    procedure RunBtnClick(Sender: TObject);
    procedure LangCBClick(Sender: TObject);
    procedure EvaluateBClick(Sender: TObject);
    procedure fsScript1RunLine(Sender: TfsScript; const UnitName, SourcePos: String);
  private
    FRunning: Boolean;
    FStopped: Boolean;
  end;

var
  frmFastScriptMain: TfrmFastScriptMain;

implementation

  {$R *.dfm}

uses
  fs_iTools, uFastScriptEvalute, Variants;

function MSecsBetween(AStopTime, AStartTime: TDateTime): Int64;
var
  LStartMs, LStopMs: Comp;
begin
  LStopMs := TimeStampToMSecs(DateTimeToTimeStamp(AStopTime));
  LStartMs := TimeStampToMSecs(DateTimeToTimeStamp(AStartTime));
  Result := Trunc(LStopMs - LStartMs);
end;

procedure TfrmFastScriptMain.FormCreate(Sender: TObject);
begin
  fsGlobalUnit.AddForm(frmFastScriptMain);
  fsGetLanguageList(LangCB.Items);
  LangCB.ItemIndex := LangCB.Items.IndexOf('PascalScript');
end;

procedure TfrmFastScriptMain.LoadBtnClick(Sender: TObject);
var
  LStr: string;
begin
  OpenDialog1.InitialDir := ExtractFilePath(Application.ExeName) + 'Samples';
  LStr := LangCB.Items[LangCB.ItemIndex];
  if LStr = 'PascalScript' then
    OpenDialog1.FilterIndex := 1
  else if LStr = 'C++Script' then
    OpenDialog1.FilterIndex := 2
  else if LStr = 'JScript' then
    OpenDialog1.FilterIndex := 3
  else if LStr = 'BasicScript' then
    OpenDialog1.FilterIndex := 4;
  if OpenDialog1.Execute then
    Memo.Lines.LoadFromFile(OpenDialog1.FileName);
end;

procedure TfrmFastScriptMain.LangCBClick(Sender: TObject);
var
  LStr: string;
begin
  LStr := LangCB.Items[LangCB.ItemIndex];
  if LStr = 'PascalScript' then
    Memo.SyntaxType := stPascal
  else if LStr = 'C++Script' then
    Memo.SyntaxType := stCPP
  else if LStr= 'JScript' then
    Memo.SyntaxType := stJS
  else if LStr = 'BasicScript' then
    Memo.SyntaxType := stVB
  else
    Memo.SyntaxType := stText;
  Memo.SetFocus;
end;

procedure TfrmFastScriptMain.RunBtnClick(Sender: TObject);
var
  LStartTime: TDateTime;
  LPoint: TPoint;
begin
  if FRunning then
  begin
    if Sender = RunBtn then
      fsScript1.OnRunLine := nil;
    FStopped := False;
    Exit;
  end;

  fsScript1.Clear;
  fsScript1.Lines := Memo.Lines;
  fsScript1.SyntaxType := LangCB.Items[LangCB.ItemIndex];
  fsScript1.Parent := fsGlobalUnit;

  if not fsScript1.Compile then
  begin
    Memo.SetFocus;
    LPoint:= fsPosToPoint(fsScript1.ErrorPos);
    Memo.SetPos(LPoint.X, LPoint.Y);
    if fsScript1.ErrorUnit = '' then
      Status.Text := fsScript1.ErrorMsg else
      Status.Text := fsScript1.ErrorUnit + ': ' + fsScript1.ErrorMsg;
    Exit;
  end
  else
    Status.Text := 'Compiled OK, Running...';

  LStartTime := Now;
  Application.ProcessMessages;

  if Sender = RunBtn then
    fsScript1.OnRunLine := nil else
    fsScript1.OnRunLine := fsScript1RunLine;

  FRunning := True;
  try
    fsScript1.Execute;
  finally
    FRunning := False;
    Status.Text := 'Exception in the program';
  end;

  Status.Text := 'Executed in ' + IntToStr(MSecsBetween(Now, LStartTime)) + ' ms';
end;

procedure TfrmFastScriptMain.EvaluateBClick(Sender: TObject);
begin
  Form2.ShowModal;
end;

procedure TfrmFastScriptMain.fsScript1RunLine(Sender: TfsScript; const UnitName,
  SourcePos: String);
var
  LPoint: TPoint;
begin
  { enable main window to allow debugging of modal forms }
  EnableWindow(Handle, True);
  SetFocus;

  LPoint := fsPosToPoint(SourcePos);
  Memo.SetPos(LPoint.X, LPoint.Y);

  FStopped := True;
  while FStopped do
    Application.ProcessMessages;
end;

end.

