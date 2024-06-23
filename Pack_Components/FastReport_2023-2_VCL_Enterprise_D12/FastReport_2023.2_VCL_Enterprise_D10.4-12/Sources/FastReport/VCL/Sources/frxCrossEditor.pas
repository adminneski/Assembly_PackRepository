
{******************************************}
{                                          }
{             FastReport VCL               }
{              Cross editor                }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxCrossEditor;

interface

{$I frx.inc}

uses
  {$IFNDEF FPC}
  Windows, Messages,
  {$ENDIF}
  Types, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ImgList, Menus, ComCtrls, Buttons, ToolWin, ExtCtrls, frxDock,
  frxCross, frxClass, frxCtrls, frxCustomEditors, Variants, frxBaseForm
  {$IFDEF FPC}
  , LResources, LCLType, LMessages, LazHelper
  {$ENDIF}
{$IFDEF DELPHI16}
, System.UITypes
{$ENDIF}
;

type
  TfrxCrossEditor = class(TfrxViewEditor)
  public
    function Edit: Boolean; override;
    function HasEditor: Boolean; override;
  end;

  TfrxCrossEditorForm = class(TfrxBaseForm)
    FuncPopup: TPopupMenu;
    Func1MI: TMenuItem;
    Func2MI: TMenuItem;
    Func3MI: TMenuItem;
    Func4MI: TMenuItem;
    Func5MI: TMenuItem;
    Func6MI: TMenuItem;
    SortPopup: TPopupMenu;
    Sort1MI: TMenuItem;
    Sort2MI: TMenuItem;
    Sort3MI: TMenuItem;
    StylePopup: TPopupMenu;
    Sep1: TMenuItem;
    SaveStyleMI: TMenuItem;
    Sort4MI: TMenuItem;
    DimensionsL: TGroupBox;
    RowsL: TLabel;
    ColumnsL: TLabel;
    CellsL: TLabel;
    RowsE: TEdit;
    ColumnsE: TEdit;
    CellsE: TEdit;
    UpDown1: TUpDown;
    UpDown2: TUpDown;
    UpDown3: TUpDown;
    DatasetL: TGroupBox;
    DatasetCB: TComboBox;
    FieldsLB: TListBox;
    StructureL: TGroupBox;
    Shape2: TShape;
    Shape1: TShape;
    OptionsL: TGroupBox;
    RowHeaderCB: TCheckBox;
    ColumnHeaderCB: TCheckBox;
    RowTotalCB: TCheckBox;
    ColumnTotalCB: TCheckBox;
    TitleCB: TCheckBox;
    CornerCB: TCheckBox;
    AutoSizeCB: TCheckBox;
    BorderCB: TCheckBox;
    DownAcrossCB: TCheckBox;
    PlainCB: TCheckBox;
    JoinCB: TCheckBox;
    Box: TScrollBox;
    PaintBox: TPaintBox;
    ToolBar: TToolBar;
    StyleB: TToolButton;
    RepeatCB: TCheckBox;
    OkB: TButton;
    CancelB: TButton;
    SwapB: TSpeedButton;
    RowsLB: TListBox;
    ColumnsLB: TListBox;
    CellsLB: TListBox;
    procedure FormCreate(Sender: TObject);
    procedure CancelBClick(Sender: TObject);
    procedure OkBClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure DatasetCBClick(Sender: TObject);
    procedure DatasetCBDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure FieldsLBDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure LBDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure CellsLBDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure LBDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure LBDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure LBMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LBClick(Sender: TObject);
    procedure CBClick(Sender: TObject);
    procedure FuncMIClick(Sender: TObject);
    procedure CellsLBMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SortMIClick(Sender: TObject);
    procedure SwapBClick(Sender: TObject);
    procedure DimensionsChange(Sender: TObject);
    procedure LBDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PaintBoxPaint(Sender: TObject);
    procedure SaveStyleMIClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    FCross: TfrxCustomCrossView;
    FCurList: TListBox;
    FFuncNames: array[TfrxCrossFunction] of String;
    FImages: TImageList;
    FSortNames: array[TfrxCrossSortOrder] of String;
    FStyleSheet: TfrxStyleScheme;
    FTempCross: TfrxDBCrossView;
    FUpdating: Boolean;
    FSubTotOffset: Integer;

    FBtnColumnsLB: TRect;
    FBtnRowsLB: TRect;
    FBtnCellsLB: TRect;
    FBitmapWidth: Integer;
    procedure ReflectChanges(ChangesFrom: TObject; UpdateText: Boolean = True);
    procedure CreateStyleMenu;
    procedure StyleClick(Sender: TObject);
  protected
    procedure AfterPPIMessage; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure UpdateFormPPI(aNewPPI: Integer); override;
    property Cross: TfrxCustomCrossView read FCross write FCross;
  end;


implementation
{$IFNDEF FPC}
{$R *.DFM}
{$ELSE}
{$R *.lfm}
{$ENDIF}

uses
  frxDsgnIntf, frxEditFormat, frxEditHighlight, frxEditMemo,
  frxEditFrame, frxDesgnCtrls, frxRes, frxUtils;

const
  CrossStyles =
'<?xml version="1.0" encoding="utf-8"?>' +
'<stylesheet>' +
'<style Name="White">' +
'<item Name="cellheader" Color="16777215" Font.Color="0" Font.Style="0" Frame.Typ="15"/>' +
'<item Name="cell" Color="16777215" Font.Color="0" Font.Style="0" Frame.Typ="15"/>' +
'<item Name="column" Color="16777215" Font.Color="0" Font.Style="0" Frame.Typ="15"/>' +
'<item Name="colgrand" Color="16777215" Font.Color="0" Font.Style="1" Frame.Typ="15"/>' +
'<item Name="coltotal" Color="16777215" Font.Color="0" Font.Style="1" Frame.Typ="15"/>' +
'<item Name="row" Color="16777215" Font.Color="0" Font.Style="0" Frame.Typ="15"/>' +
'<item Name="rowgrand" Color="16777215" Font.Color="0" Font.Style="1" Frame.Typ="15"/>' +
'<item Name="rowtotal" Color="16777215" Font.Color="0" Font.Style="1" Frame.Typ="15"/>' +
'<item Name="corner" Color="16777215" Font.Color="0" Font.Style="0" Frame.Typ="15"/>' +
'</style>' +
'<style Name="Gray">' +
'<item Name="cellheader" Color="14211288" Font.Color="0" Font.Style="0" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="cell" Color="15790320" Font.Color="0" Font.Style="0" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="column" Color="14211288" Font.Color="0" Font.Style="0" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="colgrand" Color="14211288" Font.Color="0" Font.Style="1" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="coltotal" Color="14211288" Font.Color="0" Font.Style="1" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="row" Color="14211288" Font.Color="0" Font.Style="0" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="rowgrand" Color="14211288" Font.Color="0" Font.Style="1" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="rowtotal" Color="14211288" Font.Color="0" Font.Style="1" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="corner" Color="14211288" Font.Color="0" Font.Style="0" Frame.Color="16777215" Frame.Typ="15"/>' +
'</style>' +
'<style Name="Orange">' +
'<item Name="cellheader" Color="4643583" Font.Color="0" Font.Style="0" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="cell" Color="10218495" Font.Color="0" Font.Style="0" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="column" Color="4643583" Font.Color="0" Font.Style="0" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="colgrand" Color="4643583" Font.Color="0" Font.Style="1" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="coltotal" Color="4643583" Font.Color="0" Font.Style="1" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="row" Color="4643583" Font.Color="0" Font.Style="0" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="rowgrand" Color="4643583" Font.Color="0" Font.Style="1" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="rowtotal" Color="4643583" Font.Color="0" Font.Style="1" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="corner" Color="4643583" Font.Color="0" Font.Style="0" Frame.Color="16777215" Frame.Typ="15"/>' +
'</style>' +
'<style Name="Green">' +
'<item Name="cellheader" Color="42107" Font.Color="0" Font.Style="0" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="cell" Color="53918" Font.Color="0" Font.Style="0" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="column" Color="42107" Font.Color="0" Font.Style="0" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="colgrand" Color="42107" Font.Color="0" Font.Style="1" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="coltotal" Color="42107" Font.Color="0" Font.Style="1" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="row" Color="42107" Font.Color="0" Font.Style="0" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="rowgrand" Color="42107" Font.Color="0" Font.Style="1" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="rowtotal" Color="42107" Font.Color="0" Font.Style="1" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="corner" Color="42107" Font.Color="0" Font.Style="0" Frame.Color="16777215" Frame.Typ="15"/>' +
'</style>' +
'<style Name="Green and Orange">' +
'<item Name="cellheader" Color="52376" Font.Color="0" Font.Style="0" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="cell" Color="52479" Font.Color="0" Font.Style="0" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="column" Color="52376" Font.Color="0" Font.Style="0" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="colgrand" Color="52376" Font.Color="0" Font.Style="1" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="coltotal" Color="52376" Font.Color="0" Font.Style="1" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="row" Color="52376" Font.Color="0" Font.Style="0" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="rowgrand" Color="52376" Font.Color="0" Font.Style="1" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="rowtotal" Color="52376" Font.Color="0" Font.Style="1" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="corner" Color="52376" Font.Color="0" Font.Style="0" Frame.Color="16777215" Frame.Typ="15"/>' +
'</style>' +
'<style Name="Blue">' +
'<item Name="cellheader" Color="16629143" Font.Color="0" Font.Style="0" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="cell" Color="16700346" Font.Color="0" Font.Style="0" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="column" Color="16629143" Font.Color="0" Font.Style="0" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="colgrand" Color="16629143" Font.Color="0" Font.Style="1" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="coltotal" Color="16629143" Font.Color="0" Font.Style="1" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="row" Color="16629143" Font.Color="0" Font.Style="0" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="rowgrand" Color="16629143" Font.Color="0" Font.Style="1" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="rowtotal" Color="16629143" Font.Color="0" Font.Style="1" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="corner" Color="16629143" Font.Color="0" Font.Style="0" Frame.Color="16777215" Frame.Typ="15"/>' +
'</style>' +
'<style Name="Blue and White">' +
'<item Name="cellheader" Color="16629143" Font.Color="0" Font.Style="0" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="cell" Color="536870911" Font.Color="0" Font.Style="0" Frame.Color="14211288" Frame.Typ="15"/>' +
'<item Name="column" Color="16629143" Font.Color="0" Font.Style="0" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="colgrand" Color="16629143" Font.Color="0" Font.Style="1" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="coltotal" Color="16629143" Font.Color="0" Font.Style="1" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="row" Color="16629143" Font.Color="0" Font.Style="0" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="rowgrand" Color="16629143" Font.Color="0" Font.Style="1" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="rowtotal" Color="16629143" Font.Color="0" Font.Style="1" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="corner" Color="16629143" Font.Color="0" Font.Style="0" Frame.Color="16777215" Frame.Typ="15"/>' +
'</style>' +
'<style Name="Gray and Orange">' +
'<item Name="cellheader" Color="8421504" Font.Color="16777215" Font.Style="0" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="cell" Color="52479" Font.Color="0" Font.Style="0" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="column" Color="8421504" Font.Color="16777215" Font.Style="0" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="coltotal" Color="8421504" Font.Color="16777215" Font.Style="1" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="colgrand" Color="8421504" Font.Color="16777215" Font.Style="1" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="row" Color="8421504" Font.Color="16777215" Font.Style="0" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="rowtotal" Color="8421504" Font.Color="16777215" Font.Style="1" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="rowgrand" Color="8421504" Font.Color="16777215" Font.Style="1" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="corner" Color="8421504" Font.Color="16777215" Font.Style="0" Frame.Color="16777215" Frame.Typ="15"/>' +
'</style>' +
'<style Name="Blue and Orange">' +
'<item Name="cellheader" Color="16629143" Font.Color="0" Font.Style="0" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="cell" Color="7000063" Font.Color="0" Font.Style="0" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="column" Color="16629143" Font.Color="0" Font.Style="0" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="colgrand" Color="16629143" Font.Color="0" Font.Style="1" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="coltotal" Color="16629143" Font.Color="0" Font.Style="1" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="row" Color="16629143" Font.Color="0" Font.Style="0" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="rowgrand" Color="16629143" Font.Color="0" Font.Style="1" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="rowtotal" Color="16629143" Font.Color="0" Font.Style="1" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="corner" Color="16629143" Font.Color="0" Font.Style="0" Frame.Color="16777215" Frame.Typ="15"/>' +
'</style>' +
'<style Name="Orange and White">' +
'<item Name="cellheader" Color="7000063" Font.Color="0" Font.Style="0" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="cell" Color="536870911" Font.Color="0" Font.Style="0" Frame.Color="14211288" Frame.Typ="15"/>' +
'<item Name="column" Color="7000063" Font.Color="0" Font.Style="0" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="colgrand" Color="7000063" Font.Color="0" Font.Style="1" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="coltotal" Color="7000063" Font.Color="0" Font.Style="1" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="row" Color="7000063" Font.Color="0" Font.Style="0" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="rowgrand" Color="7000063" Font.Color="0" Font.Style="1" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="rowtotal" Color="7000063" Font.Color="0" Font.Style="1" Frame.Color="16777215" Frame.Typ="15"/>' +
'<item Name="corner" Color="7000063" Font.Color="0" Font.Style="0" Frame.Color="16777215" Frame.Typ="15"/>' +
'</style>' +
'</stylesheet>';

type
  THackWinControl = class(TWinControl);


{ TfrxCrossEditor }

function TfrxCrossEditor.Edit: Boolean;
begin
  with TfrxCrossEditorForm.Create(Designer) do
  begin
    Cross := TfrxCustomCrossView(Component);
    Result := ShowModal = mrOk;
    Free;
  end;
end;

function TfrxCrossEditor.HasEditor: Boolean;
begin
  Result := True;
end;


{ TfrxCrossEditorForm }

constructor TfrxCrossEditorForm.Create(AOwner: TComponent);
var
  TempStream: TStringStream;
begin
  inherited;
  FBitmapWidth := 20;
  FStyleSheet := TfrxStyleScheme.Create;
  if FileExists(ExtractFilePath(Application.ExeName) + 'crossstyles.xml') then
    FStyleSheet.LoadFromFile(ExtractFilePath(Application.ExeName) + 'crossstyles.xml')
  else
  begin
    TempStream := TStringStream.Create(CrossStyles{$IFDEF DELPHI12}, TEncoding.UTF8{$ENDIF});
    FStyleSheet.LoadFromStream(TempStream);
    TempStream.Free;
  end;
  FSubTotOffset := 0;
  FImages := TImageList.Create(nil);
  FTempCross := TfrxDBCrossView.Create(nil);
  FFuncNames[cfNone] := frxResources.Get('crNone');
  FFuncNames[cfSum] := frxResources.Get('crSum');
  FFuncNames[cfMin] := frxResources.Get('crMin');
  FFuncNames[cfMax] := frxResources.Get('crMax');
  FFuncNames[cfAvg] := frxResources.Get('crAvg');
  FFuncNames[cfCount] := frxResources.Get('crCount');
  FSortNames[soAscending] := frxResources.Get('crAsc');
  FSortNames[soDescending] := frxResources.Get('crDesc');
  FSortNames[soNone] := frxResources.Get('crNone');
  FSortNames[soGrouping] := frxResources.Get('crGroup');
{$IFNDEF FPC}
{$IFDEF DELPHI5}
  StylePopup.AutoHotKeys := maManual;
{$ENDIF}
{$ENDIF}
end;

destructor TfrxCrossEditorForm.Destroy;
begin
  FImages.Free;
  FStyleSheet.Free;
  FTempCross.Free;
  inherited;
end;

procedure TfrxCrossEditorForm.FormCreate(Sender: TObject);
begin
  Caption := frxGet(4300);
  DatasetL.Caption := frxGet(4301);
  DimensionsL.Caption := frxGet(4302);
  RowsL.Caption := frxGet(4303);
  ColumnsL.Caption := frxGet(4304);
  CellsL.Caption := frxGet(4305);
  StructureL.Caption := frxGet(4306);
  RowHeaderCB.Caption := frxGet(4307);
  ColumnHeaderCB.Caption := frxGet(4308);
  RowTotalCB.Caption := frxGet(4309);
  ColumnTotalCB.Caption := frxGet(4310);
  SwapB.Hint := frxGet(4311);
  Func1MI.Caption := frxGet(4322);
  Func2MI.Caption := frxGet(4323);
  Func3MI.Caption := frxGet(4324);
  Func4MI.Caption := frxGet(4325);
  Func5MI.Caption := frxGet(4326);
  Func6MI.Caption := frxGet(4327);
  Sort1MI.Caption := frxGet(4328);
  Sort2MI.Caption := frxGet(4329);
  Sort3MI.Caption := frxGet(4330);
  Sort4MI.Caption := frxGet(4331);
  TitleCB.Caption := frxGet(4314);
  CornerCB.Caption := frxGet(4315);
  AutoSizeCB.Caption := frxGet(4317);
  BorderCB.Caption := frxGet(4318);
  DownAcrossCB.Caption := frxGet(4319);
  RepeatCB.Caption := frxGet(4316);
  PlainCB.Caption := frxGet(4320);
  JoinCB.Caption := frxGet(4321);
  StyleB.Caption := frxGet(4312);
  SaveStyleMI.Caption := frxGet(4313);
  OkB.Caption := frxGet(1);
  CancelB.Caption := frxGet(2);

{$IFDEF UseTabset}
  Box.BevelKind := bkFlat;
{$ELSE}
  Box.BorderStyle := bsSingle;
{$IFDEF DELPHI7}
  Box.ControlStyle := Box.ControlStyle + [csNeedsBorderPaint];
{$ENDIF}
{$ENDIF}
  CreateStyleMenu;
  StylePopup.Images := FImages;

  if UseRightToLeftAlignment then
    FlipChildren(True);
end;

procedure TfrxCrossEditorForm.FormShow(Sender: TObject);

  procedure SelectDataset;
  begin
    DatasetCB.ItemIndex := DatasetCB.Items.IndexOfObject(FCross.DataSet);
    if DatasetCB.ItemIndex = -1 then
      DatasetCB.ItemIndex := 0;
    DatasetCBClick(nil);
  end;

  procedure SelectFields;
  var
    i: Integer;
  begin
    for i := 0 to FCross.RowFields.Count - 1 do
      RowsLB.Items.Add(FCross.RowFields[i]);

    for i := 0 to FCross.ColumnFields.Count - 1 do
      ColumnsLB.Items.Add(FCross.ColumnFields[i]);

    CellsLB.Items := FCross.CellFields;
  end;

begin
  FTempCross.Assign(FCross);
  FCross.Report.GetDataSetList(DatasetCB.Items);
  SelectDataset;
  SelectFields;

  FUpdating := True;

  if FCross is TfrxCrossView then
  begin
    ColumnsLB.DragMode := dmManual;
    RowsLB.DragMode := dmManual;
    CellsLB.DragMode := dmManual;
    SwapB.Visible := False;
    DimensionsL.Visible := True;
    RowsE.Text := IntToStr(FCross.RowLevels);
    ColumnsE.Text := IntToStr(FCross.ColumnLevels);
    CellsE.Text := IntToStr(FCross.CellLevels);
  end
  else
    DatasetL.Visible := True;

  TitleCB.Checked := FCross.ShowTitle;
  CornerCB.Checked := FCross.ShowCorner;
  ColumnHeaderCB.Checked := FCross.ShowColumnHeader;
  RowHeaderCB.Checked := FCross.ShowRowHeader;
  ColumnTotalCB.Checked := FCross.ShowColumnTotal;
  RowTotalCB.Checked := FCross.ShowRowTotal;

  AutoSizeCB.Checked := FCross.AutoSize;
  BorderCB.Checked := FCross.Border;
  DownAcrossCB.Checked := FCross.DownThenAcross;
  RepeatCB.Checked := FCross.RepeatHeaders;
  PlainCB.Checked := FCross.PlainCells;
  JoinCB.Checked := FCross.JoinEqualCells;

  StyleB.Visible := not FCross.DotMatrix;

  FUpdating := False;
end;

procedure TfrxCrossEditorForm.FormHide(Sender: TObject);
begin
  if ModalResult = mrCancel then
    FCross.Assign(FTempCross);
end;

procedure TfrxCrossEditorForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    frxResources.Help(Self);
end;

procedure TfrxCrossEditorForm.CreateStyleMenu;
var
  i: Integer;
  sl: TStringList;
  m: TMenuItem;
  b: TBitmap;
  Style: TfrxStyles;
begin
  sl := TStringList.Create;
  FStyleSheet.GetList(sl);

  FImages.Clear;
  b := TBitmap.Create;
  b.Width := 16;
  b.Height := 16;
  frxImages.MainButtonImages.Draw(b.Canvas, 0, 0, 2);
  FImages.Add(b, nil);

  { create thumbnail images for each style }
  for i := 0 to sl.Count - 1 do
  begin
    Style := FStyleSheet[i];
    with b.Canvas do
    begin
      Brush.Color := Style.Find('column').Color;
      if Brush.Color = clNone then
        Brush.Color := clWhite;
      FillRect(Rect(0, 0, 16, 8));
      Brush.Color := Style.Find('cell').Color;
      if Brush.Color = clNone then
        Brush.Color := clWhite;
      FillRect(Rect(0, 8, 16, 16));
      Pen.Color := clSilver;
      Brush.Style := bsClear;
      Rectangle(0, 0, 16, 16);
    end;
    FImages.Add(b, nil);
  end;

  while StylePopup.Items[0] <> Sep1 do
    StylePopup.Items[0].Free;

  for i := sl.Count - 1 downto 0 do
  begin
    m := TMenuItem.Create(StylePopup);
    m.Caption := sl[i];
    m.ImageIndex := i + 1;
    m.OnClick := StyleClick;
    StylePopup.Items.Insert(0, m);
  end;
  
  b.Free;
  sl.Free;
end;

procedure TfrxCrossEditorForm.ReflectChanges(ChangesFrom: TObject; UpdateText: Boolean);
var
  i, j, OldCellLevels: Integer;
  s: String;
  OldCellFields: TStringList;
begin
  OldCellFields := TStringList.Create;
  OldCellFields.Assign(FCross.CellFields);
  OldCellLevels := FCross.CellLevels;
  if DatasetCB.ItemIndex = -1 then
    FCross.DataSet := nil else
    FCross.DataSet := TfrxCustomDBDataSet(DatasetCB.Items.Objects[DatasetCB.ItemIndex]);
  if FCross is TfrxDBCrossView then
  begin
    FCross.RowFields := RowsLB.Items;
    FCross.ColumnFields := ColumnsLB.Items;
    FCross.CellFields := CellsLB.Items;
  end;
  FCross.RowLevels := FCross.RowFields.Count;
  FCross.ColumnLevels := FCross.ColumnFields.Count;
  FCross.CellLevels := FCross.CellFields.Count;

  if ChangesFrom = nil then // change all
  begin
    if FCross.CellLevels = 1 then
      if UpdateText then
        FCross.CornerMemos[0].Text := FCross.CellFields[0]
    else
    begin
      FCross.CornerMemos[0].Text := '';
      FCross.CornerMemos[2].Text := 'Data';
    end;

    if UpdateText then
      for i := 0 to FCross.RowLevels do
        for j := 0 to FCross.CellLevels - 1 do
          FCross.CellHeaderMemos[i * FCross.CellLevels + j].Text := FCross.CellFields[j];

    s := '';
    for i := 0 to FCross.ColumnLevels - 1 do
      s := s + FCross.ColumnFields[i] + ', ';
    if s <> '' then
      SetLength(s, Length(s) - 2);
    if UpdateText then
      FCross.CornerMemos[1].Text := s;

    if UpdateText then
      for i := 0 to FCross.RowLevels - 1 do
        FCross.CornerMemos[i + 3].Text := FCross.RowFields[i];
  end
  else if (ChangesFrom = RowsLB) or (ChangesFrom = RowsE) then
  begin
    if UpdateText then
      for i := 0 to FCross.RowLevels do
        for j := 0 to FCross.CellLevels - 1 do
          FCross.CellHeaderMemos[i * FCross.CellLevels + j].Text := FCross.CellFields[j];

    if UpdateText then
      for i := 0 to FCross.RowLevels - 1 do
        FCross.CornerMemos[i + 3].Text := FCross.RowFields[i];
  end
  else if (ChangesFrom = ColumnsLB) or (ChangesFrom = ColumnsE) then
  begin
    s := '';
    for i := 0 to FCross.ColumnLevels - 1 do
      s := s + FCross.ColumnFields[i] + ', ';
    if s <> '' then
      SetLength(s, Length(s) - 2);
    if UpdateText then
      FCross.CornerMemos[1].Text := s;
  end
  else if (ChangesFrom = CellsLB) or (ChangesFrom = CellsE) or (OldCellLevels <> FCross.CellLevels) then
  begin
    if FCross.CellLevels = 1 then
      if UpdateText then
        FCross.CornerMemos[0].Text := FCross.CellFields[0]
    else
    begin
      FCross.CornerMemos[0].Text := '';
      FCross.CornerMemos[2].Text := 'Data';
    end;

    if UpdateText then
      for i := 0 to FCross.RowLevels do
        for j := 0 to FCross.CellLevels - 1 do
          if (OldCellLevels <> FCross.CellLevels) or (FCross.CellFields[j] <> OldCellFields[j]) or (FCross.CellHeaderMemos[i * FCross.CellLevels + j].Text = '') then
            FCross.CellHeaderMemos[i * FCross.CellLevels + j].Text := FCross.CellFields[j];
  end;

  OldCellFields.Free;
  PaintBoxPaint(nil);
end;

procedure TfrxCrossEditorForm.DatasetCBClick(Sender: TObject);
var
  ds: TfrxCustomDBDataSet;
begin
  if DatasetCB.ItemIndex = -1 then Exit;
  ds := TfrxCustomDBDataSet(DatasetCB.Items.Objects[DatasetCB.ItemIndex]);
  ds.GetFieldList(FieldsLB.Items);
  RowsLB.Clear;
  ColumnsLB.Clear;
  CellsLB.Clear;
  if Sender <> nil then
    ReflectChanges(nil);
end;

procedure TfrxCrossEditorForm.LBDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := (Source is TListBox) and (TListBox(Source).Items.Count > 0);
end;

procedure TfrxCrossEditorForm.LBDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  s: String;
  i: Integer;
  SourceLB, SenderLB: TListBox;
begin
  SourceLB := TListBox(Source);
  SenderLB := TListBox(Sender);
  if SourceLB.ItemIndex = -1 then Exit;
  if (Source = Sender) and (Source <> FieldsLB) then
  begin
    i := SourceLB.ItemAtPos(Point(X, Y), True);
    if i = -1 then
      i := SourceLB.Items.Count - 1;
    SourceLB.Items.Exchange(SourceLB.ItemIndex, i);
  end
  else if Source <> Sender then
  begin
    s := SourceLB.Items[SourceLB.ItemIndex];
    if Source <> FieldsLB then
      SourceLB.Items.Delete(SourceLB.Items.IndexOf(s));
    if (Sender <> FieldsLB) and (SenderLB.Items.Count < 64) then
      SenderLB.Items.Add(s);
  end;

  ReflectChanges(Source);
  ReflectChanges(Sender);
end;

procedure TfrxCrossEditorForm.LBClick(Sender: TObject);
begin
  if Sender <> FieldsLB then
    FieldsLB.ItemIndex := -1;
  if Sender <> RowsLB then
    RowsLB.ItemIndex := -1;
  if Sender <> ColumnsLB then
    ColumnsLB.ItemIndex := -1;
  if Sender <> CellsLB then
    CellsLB.ItemIndex := -1;
end;

procedure TfrxCrossEditorForm.LBDblClick(Sender: TObject);
var
  lb: TListBox;
  s: String;
begin
  lb := TListBox(Sender);
  if lb.ItemIndex = -1 then
    exit;
  s := Cross.Report.Designer.InsertExpression(lb.Items[lb.ItemIndex]);
  if s <> '' then
  begin
    lb.Items[lb.ItemIndex] := s;
    ReflectChanges(Sender);
  end;
end;

procedure TfrxCrossEditorForm.AfterPPIMessage;
begin
  inherited;
  FormResize(Self);
end;

procedure TfrxCrossEditorForm.CancelBClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrxCrossEditorForm.OkBClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TfrxCrossEditorForm.LBMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Memo: TfrxCustomMemoView;
  sort: TfrxCrossSortOrder;
  i: Integer;
  pt: TPoint;
  r: TRect;
begin
  FCurList := TListBox(Sender);
  if FCurList = RowsLB then
    r := FBtnRowsLB
  else
    r := FBtnColumnsLB;
  if (X > r.Left - FSubTotOffset + 4) and (X < r.Right - FSubTotOffset + 4) then
  begin
    if FCurList = RowsLB then
      Memo := FCross.RowTotalMemos[FCurList.ItemIndex + 1] else
      Memo := FCross.ColumnTotalMemos[FCurList.ItemIndex + 1];
    Memo.Visible := not Memo.Visible;
  end;

  if (X > r.Left) and (X < r.Right) then
  begin
    if FCurList = RowsLB then
      sort := FCross.RowSort[FCurList.ItemIndex] else
      sort := FCross.ColumnSort[FCurList.ItemIndex];

    for i := 0 to SortPopup.Items.Count - 1 do
      if SortPopup.Items[i].Tag = Integer(sort) then
         SortPopup.Items[i].Checked := True;
    pt := FCurList.ClientToScreen(Point(X, Y));
    SortPopup.Popup(pt.X, pt.Y);
  end;

  FCurList.Invalidate;
  ReflectChanges(Sender, False);
end;

procedure TfrxCrossEditorForm.CBClick(Sender: TObject);
begin
  if FUpdating then Exit;

  FCross.ShowTitle := TitleCB.Checked;
  FCross.ShowCorner := CornerCB.Checked;
  FCross.ShowColumnHeader := ColumnHeaderCB.Checked;
  FCross.ShowRowHeader := RowHeaderCB.Checked;
  FCross.ShowColumnTotal := ColumnTotalCB.Checked;
  FCross.ShowRowTotal := RowTotalCB.Checked;

  FCross.AutoSize := AutoSizeCB.Checked;
  FCross.Border := BorderCB.Checked;
  FCross.DownThenAcross := DownAcrossCB.Checked;
  FCross.RepeatHeaders := RepeatCB.Checked;
  FCross.PlainCells := PlainCB.Checked;
  FCross.JoinEqualCells := JoinCB.Checked;
  ReflectChanges(Sender, False);
end;

procedure TfrxCrossEditorForm.DimensionsChange(Sender: TObject);
begin
  if FUpdating then Exit;

  case TControl(Sender).Tag of
    0: FCross.RowLevels := StrToInt(RowsE.Text);
    1: FCross.ColumnLevels := StrToInt(ColumnsE.Text);
    2: FCross.CellLevels := StrToInt(CellsE.Text);
  end;

  RowsLB.Items := FCross.RowFields;
  ColumnsLB.Items := FCross.ColumnFields;
  CellsLB.Items := FCross.CellFields;

  ReflectChanges(Sender);
end;

procedure TfrxCrossEditorForm.FuncMIClick(Sender: TObject);
begin
  if CellsLB.ItemIndex = -1 then Exit;
  FCross.CellFunctions[CellsLB.ItemIndex] := TfrxCrossFunction(TControl(Sender).Tag);
  CellsLB.Invalidate;
  {$IFNDEF FPC}
  CellsLB.EndDrag(False);
  {$ENDIF}
end;

procedure TfrxCrossEditorForm.CellsLBMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i: Integer;
  f: TfrxCrossFunction;
  pt: TPoint;
begin
  if CellsLB.ItemIndex = -1 then Exit;
  if (X > FBtnCellsLB.Left) and (X < FBtnCellsLB.Right) then
  begin
    f := FCross.CellFunctions[CellsLB.ItemIndex];
    for i := 0 to FuncPopup.Items.Count - 1 do
      if FuncPopup.Items[i].Tag = Integer(f) then
         FuncPopup.Items[i].Checked := True;
    pt := CellsLB.ClientToScreen(Point(X, Y));
    FuncPopup.Popup(pt.X, pt.Y);
  end;
end;

procedure TfrxCrossEditorForm.SortMIClick(Sender: TObject);
begin
  if FCurList.ItemIndex = -1 then Exit;
  if FCurList = ColumnsLB then
    FCross.ColumnSort[FCurList.ItemIndex] := TfrxCrossSortOrder(TControl(Sender).Tag) else
    FCross.RowSort[FCurList.ItemIndex] := TfrxCrossSortOrder(TControl(Sender).Tag);
  FCurList.Invalidate;
  {$IFNDEF FPC}
  FCurList.EndDrag(False);
  {$ENDIF}
end;

procedure TfrxCrossEditorForm.SwapBClick(Sender: TObject);
var
  sl: TStrings;
begin
  sl := TStringList.Create;
  sl.Assign(RowsLB.Items);
  FUpdating := True;
  RowsLB.Items := ColumnsLB.Items;
  ColumnsLB.Items := sl;
  sl.Free;
  FUpdating := False;
  ReflectChanges(nil);
  RowsLB.Repaint;
  ColumnsLB.Repaint;
end;

procedure TfrxCrossEditorForm.UpdateFormPPI(aNewPPI: Integer);
begin
  inherited;
  FBitmapWidth := frxImages.MainButtonImages.Width + 4;
end;

procedure TfrxCrossEditorForm.StyleClick(Sender: TObject);
var
  Style: TfrxStyles;
begin
  Style := FStyleSheet.Find(TMenuItem(Sender).Caption);
  if Style <> nil then
    FCross.ApplyStyle(Style);
  PaintBoxPaint(nil);
end;

procedure TfrxCrossEditorForm.SaveStyleMIClick(Sender: TObject);
var
  s: String;
  Style: TfrxStyles;
begin
  s := '';
  s := InputBox(frxGet(4313), frxResources.Get('crStName'), s);
  if s <> '' then
  begin
    Style := FStyleSheet.Find(s);
    if Style = nil then
      Style := FStyleSheet.Add;
    Style.Name := s;
    FCross.GetStyle(Style);
    FStyleSheet.SaveToFile(ExtractFilePath(Application.ExeName) + 'crossstyles.xml');
    CreateStyleMenu;
  end;
end;

procedure TfrxCrossEditorForm.PaintBoxPaint(Sender: TObject);
begin
  with PaintBox.Canvas do
  begin
    Brush.Color := clWindow;
    FillRect(Rect(0, 0, PaintBox.Width, PaintBox.Height));
  end;
  FCross.DrawCross(PaintBox.Canvas, CurrentFormPPI / frx_DefaultPPI, CurrentFormPPI / frx_DefaultPPI, 0, 0);
end;

procedure TfrxCrossEditorForm.DatasetCBDrawItem(Control: TWinControl;
  Index: Integer; ARect: TRect; State: TOwnerDrawState);
begin
  DatasetCB.Canvas.FillRect(ARect);
  frxImages.MainButtonImages.Draw(DatasetCB.Canvas, ARect.Left, ARect.Top, 53);
  DatasetCB.Canvas.TextOut(FBitmapWidth, ARect.Top + 1, DatasetCB.Items[Index]);
end;

procedure TfrxCrossEditorForm.FieldsLBDrawItem(Control: TWinControl;
  Index: Integer; ARect: TRect; State: TOwnerDrawState);
begin
  FieldsLB.Canvas.FillRect(ARect);
  frxImages.MainButtonImages.Draw(FieldsLB.Canvas, ARect.Left, ARect.Top + 2, 54);
  FieldsLB.Canvas.TextOut(ARect.Left + FBitmapWidth, ARect.Top + 1, FieldsLB.Items[Index]);
end;

procedure TfrxCrossEditorForm.LBDrawItem(Control: TWinControl;
  Index: Integer; ARect: TRect; State: TOwnerDrawState);
var
  HasSubtotal: Boolean;
  str: String;
  lOffset, DefOffset: Integer;
  RetctWidth, TopOffset: Integer;
  TextTop: Integer;
  r: TRect;
begin
  if FUpdating then exit;
  TextTop := Round(CurrentFormPPI / frx_DefaultPPI);
  with TListBox(Control), TListBox(Control).Canvas do
  begin
    FillRect(ARect);
    TextOut(ARect.Left + 2, ARect.Top - TextTop, Items[Index]);

    if Control = RowsLB then
      str := FSortNames[FCross.RowSort[Index]] else
      str := FSortNames[FCross.ColumnSort[Index]];
    lOffset := TextWidth(str);
    DefOffset := Round(41 * CurrentFormPPI / frx_DefaultPPI);
    RetctWidth := Round(11 * CurrentFormPPI / frx_DefaultPPI);
    if lOffset < 41 * DefOffset then
      lOffset := DefOffset;
    TopOffset := (ARect.Bottom - ARect.Top - RetctWidth) div 2;
    TextOut(ARect.Right - lOffset, ARect.Top - TextTop, str);
    str := frxResources.Get('crSubtotal');
    FSubTotOffset := TextWidth(str) + 16 + RetctWidth;
    if Index <> Items.Count - 1 then
    begin
      TextOut(ARect.Right - lOffset - FSubTotOffset  + 4, ARect.Top - TextTop, str);
      Brush.Color := clWindow;
      r := Rect(ARect.Right - lOffset - FSubTotOffset - RetctWidth, ARect.Top + TopOffset, ARect.Right - lOffset - FSubTotOffset, ARect.Top + TopOffset + RetctWidth);
      if Control = RowsLB then
        HasSubtotal := FCross.RowTotalMemos[Index + 1].Visible else
        HasSubtotal := FCross.ColumnTotalMemos[Index + 1].Visible;
       frxDrawCheckBox(Canvas, r, clBlack, clGray, HasSubtotal);
    end;

    Pen.Color := clGray;
    Brush.Color := clWindow;
    FBtnRowsLB := Rect(ARect.Right - (lOffset  + 4 + RetctWidth), ARect.Top + TopOffset, ARect.Right - (lOffset + 4), ARect.Top + TopOffset + RetctWidth);
    Rectangle(FBtnRowsLB);

    if Control <> RowsLB then
      FBtnColumnsLB := FBtnRowsLB;
    frxDrawArrow(Canvas, FBtnRowsLB, clBlack);

    end;
end;

procedure TfrxCrossEditorForm.CellsLBDrawItem(Control: TWinControl;
  Index: Integer; ARect: TRect; State: TOwnerDrawState);
var
  str: String;
  lOffset, DefOffset: Integer;
  RetctWidth, TopOffset: Integer;
  TextTop: Integer;
begin
  with TListBox(Control), TListBox(Control).Canvas do
  begin
    FillRect(ARect);
    TextTop := Round(CurrentFormPPI / frx_DefaultPPI);
    str := FFuncNames[FCross.CellFunctions[Index]];
    lOffset := TextWidth(str);
    DefOffset := Round(41 * CurrentFormPPI / frx_DefaultPPI);
    RetctWidth := Round(11 * CurrentFormPPI / frx_DefaultPPI);
    if lOffset < 41 * DefOffset then
      lOffset := DefOffset;
    TopOffset := (ARect.Bottom - ARect.Top - RetctWidth) div 2;
    TextOut(ARect.Left + 2, ARect.Top - TextTop, Items[Index]);
    TextOut(ARect.Right - lOffset, ARect.Top - TextTop, str);
    Pen.Color := clGray;
    Brush.Color := clWindow;

    FBtnCellsLB := Rect(ARect.Right - (lOffset  + 4 + RetctWidth), ARect.Top + TopOffset, ARect.Right - (lOffset + 4), ARect.Top + TopOffset + RetctWidth);
    Rectangle(FBtnCellsLB);

    frxDrawArrow(Canvas, FBtnCellsLB, clBlack);
  end;
end;


procedure TfrxCrossEditorForm.FormResize(Sender: TObject);
const DefGap: Integer = 8;
begin
  {$IFNDEF FPC}
  if IsPPIChanging then Exit;
  {$ENDIF}
  ColumnsLB.Left := Shape2.Left + DefGap;
  ColumnsLB.Top := Shape2.Top;
  ColumnsLB.Width := Shape1.Width + Shape1.Left - ColumnsLB.Left;
  ColumnsLB.Height := Shape1.Top - ColumnsLB.Top - DefGap;
  CellsLB.Left := Shape2.Left + DefGap;
  CellsLB.Top := Shape1.Top + DefGap;
  CellsLB.Width := Shape1.Width + Shape1.Left - CellsLB.Left;
  CellsLB.Height := Shape2.Height + Shape2.Top - CellsLB.Top;
  RowsLB.Left := Shape1.Left;
  RowsLB.Top := Shape1.Top + DefGap;
  RowsLB.Width := Shape2.Left - DefGap - RowsLB.Left;
  RowsLB.Height := Shape2.Height + Shape2.Top - RowsLB.Top;
  SwapB.Left := Shape2.Left - DefGap - SwapB.Width;
  SwapB.Top := Shape1.Top - DefGap - SwapB.Height;
end;

initialization
  frxComponentEditors.Register(TfrxCrossView, TfrxCrossEditor);
  frxComponentEditors.Register(TfrxDBCrossView, TfrxCrossEditor);

end.
