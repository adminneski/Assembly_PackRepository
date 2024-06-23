{*******************************************************}
{                                                       }
{                      EhLib 10.2                       }
{                                                       }
{          TDBGridEhCustomizeColumnsDialog              }
{                                                       }
{    Copyright (c) 2021-2022 by Dmitry V. Bolshakov     }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit DBGridEhCustomizeColumnsDialogs;

interface

uses
  Messages, SysUtils, Variants, Classes, Graphics, Types,
  {$IFDEF FPC}
    EhLibLCL, LCLType, DBGridsEh, LMessages,
  {$ELSE}
    EhLibVCL, DBGridEh, Windows,
  {$ENDIF}
  LanguageResManEh, Contnrs,
  Controls, Forms, Dialogs, ExtCtrls, StdCtrls, DBGridEhGrouping,
  ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, GridsEh, DBAxisGridsEh,
  MemTableDataEh, DB, MemTableEh, Buttons, ButtonsEh;

type
  TDBGridEhCustomizeColumnsDialog = class(TForm)
    Panel1: TPanel;
    PanelVisibleColumns: TPanel;
    PanelHiddenColumns: TPanel;
    bOk: TButton;
    bCancel: TButton;
    Label1: TLabel;
    GridVisibleColumns: TDBGridEh;
    Label2: TLabel;
    GridHiddenColumns: TDBGridEh;
    MemTableEh1: TMemTableEh;
    MemTableEh2: TMemTableEh;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    bSetWidth: TSpeedButtonEh;
    bMoveUp: TSpeedButtonEh;
    bMoveDown: TSpeedButtonEh;
    bHide: TSpeedButtonEh;
    bShow: TSpeedButtonEh;
    PanelButtons: TPanel;
    procedure FormResize(Sender: TObject);
    procedure bHideClick(Sender: TObject);
    procedure bShowClick(Sender: TObject);
    procedure bSetWidthClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure bMoveDownClick(Sender: TObject);
    procedure bMoveUpClick(Sender: TObject);
    procedure GridVisibleColumnsCellMouseClick(Grid: TCustomGridEh;
      Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
      var Processed: Boolean);
    procedure GridHiddenColumnsCellMouseClick(Grid: TCustomGridEh;
      Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
      var Processed: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure GridVisibleColumnsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GridHiddenColumnsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
  private
    procedure CMBiDiModeChanged(var Message: TMessage); message CM_BIDIMODECHANGED;
    procedure WMSettingChange(var Message: TMessage); message WM_SETTINGCHANGE;
  protected
    procedure ResourceLanguageChanged; virtual;

    procedure GetInitColumnsList(ADBGrid: TCustomDBGridEh; ColList: TList); virtual;
    function GetColumnName(Col: TColumnEh): String; virtual;

  public
    DBGrid: TCustomDBGridEh;
    ChildrenRightToLeft: Boolean;
    FormSize: TSize;
    Activated: Boolean;
    ColList: TList;
    FullColIndexList: TObjectList;

    function IndexOfFullColIndexList(Col: TColumnEh): Integer;
    procedure InitDialog(ADBGrid: TCustomDBGridEh; AFormSize: TSize); virtual;
    procedure AssignBackColumnSettings(ColumnSettingsMemTable: TMemTableEh; ADBGrid: TCustomDBGridEh); virtual;
  end;

var
  DBGridEhCustomizeColumnsDialog: TDBGridEhCustomizeColumnsDialog;

function ShowDBGridEhCustomizeColumnsDialog(DBGrid: TCustomDBGridEh; var FormSize: TSize; CustomizeColumnsDialogClass: TFormClass = nil): Boolean;

implementation

uses EhLibImageReses, EhLibLangConsts;

{$R *.dfm}

type
  TColIndex = class(TObject)
  public
    Column: TColumnEh;
    ColumnIndex: Integer;

    constructor Create(AColumn: TColumnEh);
  end;

{ TColIndex }

constructor TColIndex.Create(AColumn: TColumnEh);
begin
  Column := AColumn;
  ColumnIndex := AColumn.Index;
end;

function ShowDBGridEhCustomizeColumnsDialog(DBGrid: TCustomDBGridEh;
  var FormSize: TSize; CustomizeColumnsDialogClass: TFormClass = nil): Boolean;
var
  CustomizeColumnsDialog: TDBGridEhCustomizeColumnsDialog;
begin
  if (CustomizeColumnsDialogClass = nil) then
    CustomizeColumnsDialogClass := TDBGridEhCustomizeColumnsDialog;

  CustomizeColumnsDialog := CustomizeColumnsDialogClass.Create(Application) as TDBGridEhCustomizeColumnsDialog;

  CustomizeColumnsDialog.InitDialog(DBGrid, FormSize);
  Result := CustomizeColumnsDialog.ShowModal = mrOk;
  FormSize := CustomizeColumnsDialog.FormSize;

  CustomizeColumnsDialog.Free;
end;

procedure TDBGridEhCustomizeColumnsDialog.FormCreate(Sender: TObject);
begin
  ColList := TList.Create;
  FullColIndexList := TObjectList.Create(True);
  {$IFDEF FPC}
  MemTableEh1.Filter := 'Visible';
  MemTableEh2.Filter := 'not Visible';
  {$ELSE}
  MemTableEh1.Filter := '[Visible] = True';
  MemTableEh2.Filter := '[Visible] = False';
  {$ENDIF}

  bMoveDown.ResourceImageItem := EhLibImageResources.CustomizeColumnsDialogDown;
  bMoveUp.ResourceImageItem := EhLibImageResources.CustomizeColumnsDialogUp;
  bHide.ResourceImageItem := EhLibImageResources.CustomizeColumnsDialogRight;
  bShow.ResourceImageItem := EhLibImageResources.CustomizeColumnsDialogLeft;
  bSetWidth.ResourceImageItem := EhLibImageResources.CustomizeColumnsDialogSetColWidth;

  ResourceLanguageChanged;
end;

procedure TDBGridEhCustomizeColumnsDialog.FormDestroy(Sender: TObject);
begin
  FreeAndNil(ColList);
  FreeAndNil(FullColIndexList);
end;

function TDBGridEhCustomizeColumnsDialog.GetColumnName(Col: TColumnEh): String;
begin
  Result := Col.Title.Caption;
  Result := StringReplace(Result, '|', ' - ', [rfReplaceAll]);
end;

function TDBGridEhCustomizeColumnsDialog.IndexOfFullColIndexList(
  Col: TColumnEh): Integer;
var
  I: Integer;
  ColIndexObj: TColIndex;
begin
  Result := -1;
  for I := 0 to FullColIndexList.Count-1 do
  begin
    ColIndexObj := TColIndex(FullColIndexList[I]);
    if (ColIndexObj.Column = Col) then
    begin
      Result := I;
      Exit;
    end;
  end;
end;

procedure TDBGridEhCustomizeColumnsDialog.InitDialog(ADBGrid: TCustomDBGridEh;
  AFormSize: TSize);
var
  I: Integer;
  Col: TColumnEh;
begin
  DBGrid := ADBGrid;
  FormSize := AFormSize;
  if (FormSize.cx <> 0) and (FormSize.cy <> 0) then
  begin
    Width := FormSize.cx;
    Height := FormSize.cy;
  end;

  MemTableEh1.DisableControls;
  MemTableEh2.DisableControls;
  MemTableEh1.EmptyTable;


  for I := 0 to DBGrid.Columns.Count-1 do
  begin
    FullColIndexList.Add(TColIndex.Create(DBGrid.Columns[I]));
  end;

  GetInitColumnsList(ADBGrid, ColList);

  for I := 0 to ColList.Count-1 do
  begin
    Col := TColumnEh(ColList[I]);
    MemTableEh1.Append;
    MemTableEh1.FieldByName('ColumnName').AsString := GetColumnName(Col);
    MemTableEh1.FieldByName('Width').AsInteger := Col.Width;
    MemTableEh1.FieldByName('Visible').AsBoolean := Col.Visible;
    MemTableEh1.FieldByName('RefColumn').AsVariant := RefObjectToVariant(Col);
    MemTableEh1.FieldByName('OldIndex').AsInteger := Col.Index;
    MemTableEh1.Post;
  end;

  MemTableEh1.First;
  MemTableEh1.EnableControls;
  MemTableEh2.EnableControls;

  bSetWidth.Enabled := (dghColumnResize in ADBGrid.OptionsEh);
  bMoveDown.Enabled := (dghColumnMove in ADBGrid.OptionsEh);
  bMoveUp.Enabled := (dghColumnMove in ADBGrid.OptionsEh);
end;

procedure TDBGridEhCustomizeColumnsDialog.GetInitColumnsList(ADBGrid: TCustomDBGridEh; ColList: TList);
var
  I: Integer;
begin
  for I := 0 to DBGrid.Columns.Count-1 do
    ColList.Add(DBGrid.Columns[I]);
end;

procedure TDBGridEhCustomizeColumnsDialog.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if (ModalResult = mrOk) then
  begin
    AssignBackColumnSettings(MemTableEh1, DBGrid);
    FullColIndexList.Clear;
    ColList.Clear;
  end;
end;

procedure TDBGridEhCustomizeColumnsDialog.AssignBackColumnSettings(ColumnSettingsMemTable: TMemTableEh;
  ADBGrid: TCustomDBGridEh);
var
  I: Integer;
  Rec: TMemoryRecordEh;
  Col: TColumnEh;
  FullColListIdx: Integer;
  OldColumnIndex: Integer;
begin
  ADBGrid.Columns.BeginUpdate;
  try
    for I := 0 to MemTableEh1.RecordsView.MemTableData.RecordsList.Count-1 do
    begin
      Rec := MemTableEh1.RecordsView.MemTableData.RecordsList[i];
      Col := TColumnEh(VariantToRefObject(Rec.DataValues['RefColumn', dvvValueEh]));
      Col.Width := Integer(Rec.DataValues['Width', dvvValueEh]);
      Col.Visible := Boolean(Rec.DataValues['Visible', dvvValueEh]);
      Col.Index := I;
    end;

    for I := 0 to ADBGrid.Columns.Count - 1 do
    begin
      Col := ADBGrid.Columns[i];
      if (ColList.IndexOf(Col) = -1) then
      begin
        FullColListIdx := IndexOfFullColIndexList(Col);
        OldColumnIndex := TColIndex(FullColIndexList[FullColListIdx]).ColumnIndex;
        Col.Index := OldColumnIndex;
      end;
    end;

  finally
    ADBGrid.Columns.EndUpdate;
  end;
end;

procedure TDBGridEhCustomizeColumnsDialog.bHideClick(Sender: TObject);
var
  I: Integer;
  Rec: TMemoryRecordEh;
begin
  if (MemTableEh1.IsEmpty) then Exit;

  MemTableEh1.DisableControls;
  MemTableEh2.DisableControls;

  if (GridVisibleColumns.SelectedRows.Count = 0) then
  begin
      Rec := MemTableEh1.Rec;
      Rec.Edit;
      Rec.DataValues['Visible', dvvValueEh] := False;
      Rec.Post;
  end else
  begin
    for I := 0 to GridVisibleColumns.SelectedRows.Count-1 do
    begin
      Rec := MemTableEh1.BookmarkToRec(GridVisibleColumns.SelectedRows[I]);
      Rec.Edit;
      Rec.DataValues['Visible', dvvValueEh] := False;
      Rec.Post;
    end;
    GridVisibleColumns.SelectedRows.Clear;
  end;

  MemTableEh1.EnableControls;
  MemTableEh2.EnableControls;

  GridVisibleColumns.SumList.RecalcAll;
end;

procedure TDBGridEhCustomizeColumnsDialog.bShowClick(Sender: TObject);
var
  I: Integer;
  Rec: TMemoryRecordEh;
begin
  if (MemTableEh2.IsEmpty) then Exit;

  MemTableEh1.DisableControls;
  MemTableEh2.DisableControls;

  if (GridHiddenColumns.SelectedRows.Count = 0) then
  begin
      Rec := MemTableEh2.Rec;
      Rec.Edit;
      Rec.DataValues['Visible', dvvValueEh] := True;
      Rec.Post;
  end else
  begin
    for I := 0 to GridHiddenColumns.SelectedRows.Count-1 do
    begin
      Rec := MemTableEh2.BookmarkToRec(GridHiddenColumns.SelectedRows[I]);
      Rec.Edit;
      Rec.DataValues['Visible', dvvValueEh] := True;
      Rec.Post;
    end;
    GridHiddenColumns.SelectedRows.Clear;
  end;

  MemTableEh1.EnableControls;
  MemTableEh2.EnableControls;

  GridVisibleColumns.SumList.RecalcAll;
end;

procedure TDBGridEhCustomizeColumnsDialog.bMoveDownClick(Sender: TObject);
var
  MoveRows: TList;
  I: Integer;
  Rec: TMemoryRecordEh;
  MaxIndex: Integer;
  NextIndex: Integer;
  FromIndex: Integer;
  LastSelRowMB: TUniBookmarkEh;
begin
  if (MemTableEh1.IsEmpty) then Exit;

  MoveRows := TList.Create;
  try

  if (GridVisibleColumns.SelectedRows.Count = 0) then
    GridVisibleColumns.SelectedRows.CurrentRowSelected := True;

  LastSelRowMB := NilBookmarkEh;
  for I := 0 to GridVisibleColumns.SelectedRows.Count-1 do
  begin
    Rec := MemTableEh1.BookmarkToRec(GridVisibleColumns.SelectedRows[I]);
    MoveRows.Add(Rec);
    if (I = GridVisibleColumns.SelectedRows.Count-1) then
      LastSelRowMB := GridVisibleColumns.SelectedRows[I];
  end;

  MaxIndex := -1;
  for I := 0 to MoveRows.Count-1 do
  begin
    Rec := TMemoryRecordEh(MoveRows[I]);
    if (Rec.Index > MaxIndex) then
      MaxIndex := Rec.Index;
  end;

  NextIndex := MaxIndex + 1;
  if NextIndex >= MemTableEh1.RecordsView.MemTableData.RecordsList.Count then
    Exit;

  for I := MoveRows.Count-1 downto 0 do
  begin
    Rec := TMemoryRecordEh(MoveRows[I]);
    FromIndex := Rec.Index;
    MemTableEh1.RecordsView.MemTableData.RecordsList.Move(FromIndex, NextIndex);
    NextIndex := NextIndex - 1;
  end;

  finally
    MoveRows.Free;
  end;

  if (LastSelRowMB <> NilBookmarkEh) then
    MemTableEh1.Bookmark := LastSelRowMB;
end;

procedure TDBGridEhCustomizeColumnsDialog.bMoveUpClick(Sender: TObject);
var
  MoveRows: TList;
  I: Integer;
  Rec: TMemoryRecordEh;
  MinIndex: Integer;
  NextIndex: Integer;
  FromIndex: Integer;
  FirstSelRowMB: TUniBookmarkEh;
begin
  if (MemTableEh1.IsEmpty) then Exit;

  MoveRows := TList.Create;
  try

  if (GridVisibleColumns.SelectedRows.Count = 0) then
    GridVisibleColumns.SelectedRows.CurrentRowSelected := True;

  FirstSelRowMB := NilBookmarkEh;
  for I := 0 to GridVisibleColumns.SelectedRows.Count-1 do
  begin
    Rec := MemTableEh1.BookmarkToRec(GridVisibleColumns.SelectedRows[I]);
    MoveRows.Add(Rec);
    if (I = 0) then
      FirstSelRowMB := GridVisibleColumns.SelectedRows[I];
  end;

  MinIndex := MaxInt;
  for I := 0 to MoveRows.Count-1 do
  begin
    Rec := TMemoryRecordEh(MoveRows[I]);
    if (Rec.Index < MinIndex) then
      MinIndex := Rec.Index;
  end;

  NextIndex := MinIndex - 1;
  if NextIndex < 0 then
    Exit;

  for I := 0 to MoveRows.Count-1 do
  begin
    Rec := TMemoryRecordEh(MoveRows[I]);
    FromIndex := Rec.Index;
    MemTableEh1.RecordsView.MemTableData.RecordsList.Move(FromIndex, NextIndex);
    NextIndex := NextIndex + 1;
  end;

  finally
    MoveRows.Free;
  end;

  if (FirstSelRowMB <> NilBookmarkEh) then
    MemTableEh1.Bookmark := FirstSelRowMB;
end;

procedure TDBGridEhCustomizeColumnsDialog.bSetWidthClick(Sender: TObject);
var
  NewWidthAsStr: String;
  Rec: TMemoryRecordEh;
  I: Integer;
  NewWidth: Integer;
begin
  if (MemTableEh1.IsEmpty) then Exit;

  if (GridVisibleColumns.SelectedRows.Count > 0) then
    Rec := MemTableEh1.BookmarkToRec(GridVisibleColumns.SelectedRows[0])
  else
    Rec := MemTableEh1.Rec;

  NewWidthAsStr := VarToStr(Rec.DataValues['Width', dvvValueEh]);

  if (InputQuery(EhLibLanguageConsts.DBGridEhCustomizeColumnsDialog_EnterNumericalValue,
                 EhLibLanguageConsts.DBGridEhCustomizeColumnsDialog_EnterColumnWidthS,
                 NewWidthAsStr)) then
  begin
    NewWidth := StrToInt(NewWidthAsStr);

    if (GridVisibleColumns.SelectedRows.Count > 0) then
    begin
      MemTableEh1.DisableControls;
      try
      for I := 0 to GridVisibleColumns.SelectedRows.Count-1 do
      begin
        Rec := MemTableEh1.BookmarkToRec(GridVisibleColumns.SelectedRows[I]);
        Rec.Edit;
        Rec.DataValues['Width', dvvValueEh] := NewWidth;
        Rec.Post;
      end;
      finally
        MemTableEh1.EnableControls;
      end;
    end else
    begin
      MemTableEh1.Rec.Edit;
      MemTableEh1.Rec.DataValues['Width', dvvValueEh] := NewWidth;
      MemTableEh1.Rec.Post;
    end;
  end;
end;

procedure TDBGridEhCustomizeColumnsDialog.ResourceLanguageChanged;
begin
  Caption := EhLibLanguageConsts.DBGridEhCustomizeColumnsDialog_Caption;
  Label1.Caption := EhLibLanguageConsts.DBGridEhCustomizeColumnsDialog_VisibleColumns;
  Label2.Caption := EhLibLanguageConsts.DBGridEhCustomizeColumnsDialog_HiddenColumns;

  GridVisibleColumns.Columns[0].Title.Caption := EhLibLanguageConsts.DBGridEhCustomizeColumnsDialog_ColumnName;
  GridVisibleColumns.Columns[1].Title.Caption := EhLibLanguageConsts.DBGridEhCustomizeColumnsDialog_ColumnWidth;

  GridHiddenColumns.Columns[0].Title.Caption := EhLibLanguageConsts.DBGridEhCustomizeColumnsDialog_ColumnName;

  bSetWidth.Hint := EhLibLanguageConsts.DBGridEhCustomizeColumnsDialog_SetWidth_Hint;
  bSetWidth.ShowHint := True;

  bMoveUp.Hint := EhLibLanguageConsts.DBGridEhCustomizeColumnsDialog_MoveUp_Hint;
  bMoveUp.ShowHint := True;
  bMoveDown.Hint := EhLibLanguageConsts.DBGridEhCustomizeColumnsDialog_MoveDown_Hint;
  bMoveDown.ShowHint := True;

  bHide.Hint := EhLibLanguageConsts.DBGridEhCustomizeColumnsDialog_Hide_Hint;
  bHide.ShowHint := True;
  bShow.Hint := EhLibLanguageConsts.DBGridEhCustomizeColumnsDialog_Show_Hint;
  bShow.ShowHint := True;

  bOk.Caption := EhLibLanguageConsts.OKButtonEh;
  bCancel.Caption := EhLibLanguageConsts.CancelButtonEh;
end;

procedure TDBGridEhCustomizeColumnsDialog.CMBiDiModeChanged(
  var Message: TMessage);
begin
  inherited;
  ResourceLanguageChanged;
end;

procedure TDBGridEhCustomizeColumnsDialog.WMSettingChange(
  var Message: TMessage);
begin
  inherited;
  if UseRightToLeftAlignment and not ChildrenRightToLeft then
  begin
    ChildrenRightToLeft := True;
    FlipChildren(True);
  end else if not UseRightToLeftAlignment and ChildrenRightToLeft then
  begin
    ChildrenRightToLeft := False;
    FlipChildren(True);
  end;
end;

procedure TDBGridEhCustomizeColumnsDialog.FormResize(Sender: TObject);
var
  SidePanelWidth: Integer;
begin
  SidePanelWidth := (Panel1.Width - PanelButtons.Width) div 2;
  PanelVisibleColumns.Width := SidePanelWidth;
  PanelHiddenColumns.Width := SidePanelWidth;
  if (Activated) then
  begin
    FormSize.cx := Width;
    FormSize.cy := Height;
  end;
end;

procedure TDBGridEhCustomizeColumnsDialog.FormActivate(Sender: TObject);
begin
  Activated := True;
end;

procedure TDBGridEhCustomizeColumnsDialog.GridVisibleColumnsCellMouseClick(
  Grid: TCustomGridEh; Cell: TGridCoord; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer; var Processed: Boolean);
begin
  if (ssDouble in Shift) then
  begin
    GridVisibleColumns.SelectedRows.Clear;
    GridVisibleColumns.SelectedRows.CurrentRowSelected := True;
    bHideClick(nil);
    Processed := True;
  end;
end;

procedure TDBGridEhCustomizeColumnsDialog.GridVisibleColumnsKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RIGHT) and (ssCtrl in Shift) then
    bHideClick(nil);
end;

procedure TDBGridEhCustomizeColumnsDialog.GridHiddenColumnsKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_LEFT) and (ssCtrl in Shift) then
    bShowClick(nil);
end;

procedure TDBGridEhCustomizeColumnsDialog.GridHiddenColumnsCellMouseClick(
  Grid: TCustomGridEh; Cell: TGridCoord; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer; var Processed: Boolean);
begin
  if (ssDouble in Shift) then
  begin
    GridHiddenColumns.SelectedRows.Clear;
    GridHiddenColumns.SelectedRows.CurrentRowSelected := True;
    bShowClick(nil);
    Processed := True;
  end;
end;

end.
