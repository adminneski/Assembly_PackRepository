unit uMDIDesigner;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, Menus,
  StdCtrls, Dialogs, Buttons, Messages, ExtCtrls, ComCtrls, StdActns,
  ActnList, ToolWin, ImgList, frxClass, frxDesgn, uDemoMain, XPMan;

type
  TfrxReportList = class(TObject)
  private
    FReportList: TList;
    function GetReport(Index: Integer): TfrxReport;
    function GetCount: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure ClearList;
    procedure Delete(Index: Integer);
    function CreateNewReport: TfrxReport;
    function IndexOf(Report: TfrxReport): Integer;
    property Report [Index: Integer]: TfrxReport read GetReport;
    property Count: Integer read GetCount;
  end;

  TfrmMDIDesigner = class(TfrmDemoMain)
    StatusBar: TStatusBar;
    ActionList1: TActionList;
    FileNew1: TAction;
    FileSave1: TAction;
    FileExit1: TAction;
    WindowCascade1: TWindowCascade;
    WindowTileHorizontal1: TWindowTileHorizontal;
    WindowArrangeAll1: TWindowArrange;
    WindowMinimizeAll1: TWindowMinimizeAll;
    WindowTileVertical1: TWindowTileVertical;
    ToolBar2: TToolBar;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton9: TToolButton;
    ToolButton8: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ImageList1: TImageList;
    ToolButton1: TToolButton;
    ToolButton5: TToolButton;
    PreviewReport: TAction;
    MainMenu1: TMainMenu;
    procedure FileNew1Execute(Sender: TObject);
    procedure FileExit1Execute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DestroyDesigner(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FileSave1Execute(Sender: TObject);
    procedure PreviewReportExecute(Sender: TObject);
  private
    { Private declarations }
    FReportList: TfrxReportList;
  protected
    function GetCaption: string; override;
  public
    { Public declarations }
  end;

var
  frmMDIDesigner: TfrmMDIDesigner;

implementation

{$R *.dfm}

{ TfrxReportList }

procedure TfrxReportList.ClearList;
begin
 while FReportList.Count > 0 do
 begin
  TfrxReport(FReportList[0]).Free;
  FReportList.Delete(0);
 end;
end;

constructor TfrxReportList.Create;
begin
  inherited;
  FReportList := TList.Create;
end;

function TfrxReportList.CreateNewReport: TfrxReport;
begin
  Result := TfrxReport.Create(nil);
  Result.CreateUniqueName;
  Result.PreviewOptions.MDIChild := True;
  Result.PreviewOptions.Modal := False;
  Result.EngineOptions.DestroyForms := False;
  FReportList.Add(Result);
end;

procedure TfrxReportList.Delete(Index: Integer);
begin
  if (Index < 0) or (Index >= FReportList.Count) then
    exit;
  TfrxReport(FReportList[Index]).Free;
  FReportList.Delete(Index);
end;

destructor TfrxReportList.Destroy;
begin
 ClearList;
 FReportList.Free;
 inherited;
end;

function TfrxReportList.GetCount: Integer;
begin
  Result := FReportList.Count;
end;

function TfrxReportList.GetReport(Index: Integer): TfrxReport;
begin
  if (Index < 0) or (Index >= FReportList.Count) then
    Result := nil
  else
    Result := TfrxReport(FReportList[Index]);
end;

function TfrxReportList.IndexOf(Report: TfrxReport): Integer;
begin
  Result := FReportList.IndexOf(Report);
end;


{Main Form}

procedure TfrmMDIDesigner.FileNew1Execute(Sender: TObject);
begin
  with FReportList.CreateNewReport do
  begin
    DesignReport(False, True);
    TfrxDesignerForm(Designer).OnDestroy := DestroyDesigner;
    TfrxDesignerForm(Designer).Caption := 'Designer-' + IntToStr(FReportList.Count);
  end;
end;

procedure TfrmMDIDesigner.FileExit1Execute(Sender: TObject);
begin
  Close;
end;

procedure TfrmMDIDesigner.FormCreate(Sender: TObject);
begin
  FReportList := TfrxReportList.Create;
end;

procedure TfrmMDIDesigner.FormDestroy(Sender: TObject);
begin
  FReportList.Free;
end;

function TfrmMDIDesigner.GetCaption: string;
begin
  Result := 'MDI Designer Demo';
end;

procedure TfrmMDIDesigner.DestroyDesigner(Sender: TObject);
var
  idx: Integer;
begin
  idx := FReportList.IndexOf(TfrxDesignerForm(Sender).Report);
  if FReportList.Report[idx].PreviewForm <> nil then
    FReportList.Report[idx].PreviewForm.Close;
  FReportList.Delete(idx);
end;

procedure TfrmMDIDesigner.FormClose(Sender: TObject; var Action: TCloseAction);
var
  idx: Integer;
begin
  for idx := 0 to FReportList.Count - 1 do
    TfrxDesignerForm(FReportList.Report[idx].Designer).Close;
  Action := caFree;
end;

procedure TfrmMDIDesigner.FileSave1Execute(Sender: TObject);
var
  idx: Integer;
begin
  for idx := 0 to FReportList.Count - 1 do
    TfrxDesignerForm(FReportList.Report[idx].Designer).SaveCmd.Execute;
end;

procedure TfrmMDIDesigner.PreviewReportExecute(Sender: TObject);
var
  idx: Integer;
begin
  for idx := 0 to FReportList.Count - 1 do
    FReportList.Report[idx].ShowReport;
end;

end.
