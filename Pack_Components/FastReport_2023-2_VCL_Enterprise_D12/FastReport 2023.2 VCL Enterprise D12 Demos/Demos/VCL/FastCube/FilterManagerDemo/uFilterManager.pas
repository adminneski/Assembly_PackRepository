unit uFilterManager;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ToolWin, ComCtrls, fcxSliceGridToolbar, fcxComponent,
  fcxZone, fcxCustomGrid, fcxSliceGrid, fcxSlice, fcxFilters,
  fcxCube, ExtCtrls, fcxCustomToolbar, fcxControl, uDemoMain, XPMan, ImgList, ActnList, Menus, fcxFSInterpreter;

type
  TfrmFilterManagerMain = class(TfrmDemoMain)
    Panel1: TPanel;
    fcxCube1: TfcxCube;
    fcxFilterManager1: TfcxFilterManager;
    fcxFilterManager2: TfcxFilterManager;
    fcxSlice1: TfcxSlice;
    fcxSlice2: TfcxSlice;
    fcxSlice3: TfcxSlice;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    fcxSliceGrid1: TfcxSliceGrid;
    fcxSliceGridToolbar1: TfcxSliceGridToolbar;
    fcxSliceGridToolbar2: TfcxSliceGridToolbar;
    fcxSliceGrid2: TfcxSliceGrid;
    fcxSliceGridToolbar3: TfcxSliceGridToolbar;
    fcxSliceGrid3: TfcxSliceGrid;
    fcxSliceGridToolbar4: TfcxSliceGridToolbar;
    fcxSliceGrid4: TfcxSliceGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Button1: TButton;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Splitter3: TSplitter;
    procedure Button1Click(Sender: TObject);
    procedure Splitter2Moved(Sender: TObject);
    procedure Splitter3Moved(Sender: TObject);
  end;

var
  frmFilterManagerMain: TfrmFilterManagerMain;

implementation

{$R *.dfm}

procedure TfrmFilterManagerMain.Button1Click(Sender: TObject);
begin
  fcxCube1.LoadFromFile('2_0_sample_1.mdc');
  fcxSlice1.LoadFromFile('Slice1.mds');
  fcxSlice2.LoadFromFile('Slice2.mds');
  fcxSlice3.LoadFromFile('Slice3.mds');
end;

procedure TfrmFilterManagerMain.Splitter2Moved(Sender: TObject);
begin
  if Panel4.Width <> Panel7.Width then
    Panel7.Width := Panel4.Width
end;

procedure TfrmFilterManagerMain.Splitter3Moved(Sender: TObject);
begin
  if Panel4.Width <> Panel7.Width then
    Panel4.Width := Panel7.Width
end;

end.
