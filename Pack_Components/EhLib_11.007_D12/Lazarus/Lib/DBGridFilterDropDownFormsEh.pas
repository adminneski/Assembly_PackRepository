{*******************************************************}
{                                                       }
{                       EhLib 10.2                      }
{           FilterDropDownFormsEh component             }
{                                                       }
{     Copyright (c) 2014-2022 by Dmitry V. Bolshakov    }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit DBGridFilterDropDownFormsEh;

interface

uses
  Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  {$IFDEF EH_LIB_17} System.UITypes, {$ENDIF}
  {$IFDEF FPC}
    EhLibLCL, DBGridsEh, LMessages, LCLType,
    {$IFDEF FPC_CROSSP}
    {$ELSE}
      Windows,
    {$ENDIF}
  {$ELSE}
    EhLibVCL, DBGridEh, Windows, UxTheme,
  {$ENDIF}
  DropDownFormEh, Dialogs, DynVarsEh, ToolCtrlsEh, DBCtrlsEh, GridsEh,
  StdCtrls, ExtCtrls, Themes, Types,
  DBGridEhGrouping,
  StrUtils, Buttons, FilterDropDownFormsEh;

type
  TDDFormFilterPopupListboxItemEh = class;

{ TDBGridMenuButtonEh }

  TDBGridMenuButtonEh = class(TMenuButtonEh)
    procedure Paint; override;
    procedure DrawSortMarker(ARect: TRect); virtual;
  public
    FSortState: TSortMarkerEh;
  end;

  TDBGridFilterDropDownForm = class(TFilterDropDownForm)
  published
    procedure CustomDropDownFormEhCreate(Sender: TObject);

  private
    FClearColumnFilterButton: TDBGridMenuButtonEh;
    FClearFilterButton: TDBGridMenuButtonEh;
    FColumn: TColumnEh;
    FCustomFilterButton: TDBGridMenuButtonEh;
    FLineMenuButton1: TDBGridMenuButtonEh;
    FLineMenuButton2: TDBGridMenuButtonEh;
    FLineMenuButton3: TDBGridMenuButtonEh;
    FLineMenuButton4: TDBGridMenuButtonEh;
    FSortButton1: TDBGridMenuButtonEh;
    FSortButton2: TDBGridMenuButtonEh;

    procedure MenuButtonClick(Sender: TObject); virtual;
    procedure WMSettingChange(var Message: TMessage); message WM_SETTINGCHANGE;

  protected
    FAutoSelectAllOnFilterSearching: Boolean;

    {$IFDEF FPC}
    {$ELSE}
    function CanResize(var NewWidth, NewHeight: Integer): Boolean; override;
    {$ENDIF}

    procedure UpdateAutoselectedAction;
    procedure SearchEditUserChanged; override;
    procedure SelectAllClicked(NewState: Boolean); override;
    procedure DataItemsStateUserChanged; override;
  public
    function CheckSelectedValues: Boolean; override;
    function SelectedValuesFilterLimit: Integer; virtual;

    procedure InitOpening; override;
    procedure RealignControls; override;

    property Column: TColumnEh read FColumn write FColumn;

    property SortButton1: TDBGridMenuButtonEh read FSortButton1;
    property SortButton2: TDBGridMenuButtonEh read FSortButton2;
    property LineMenuButton1: TDBGridMenuButtonEh read FLineMenuButton1;

    property ClearFilterButton: TDBGridMenuButtonEh read FClearFilterButton;
    property CustomFilterButton: TDBGridMenuButtonEh read FCustomFilterButton;
    property LineMenuButton2: TDBGridMenuButtonEh read FLineMenuButton2;
    property LineMenuButton3: TDBGridMenuButtonEh read FLineMenuButton3;
    property LineMenuButton4: TDBGridMenuButtonEh read FLineMenuButton4;
  end;

{ TDDFormFilterPopupListboxItemEh }

  TDDFormFilterPopupListboxItemEh = class(TCustomListboxItemEh)
  protected
    function GetColumn(Listbox: TCustomListboxEh): TColumnEh;
    function GetGroupLevel(Listbox: TCustomListboxEh): TGridDataGroupLevelEh;
    function FilterForm(Listbox: TCustomListboxEh): TFilterDropDownForm;
  end;

{ TDDFormListboxItemEhSort }

  TDDFormListboxItemEhSort = class(TDDFormFilterPopupListboxItemEh)
  protected
    FSortState: TSortMarkerEh;
  public
    constructor Create(ASortState: TSortMarkerEh);

    function IsDataItem: Boolean; override;
    procedure Execute(Sender: TCustomListboxEh; ItemIndex: Integer; InItemPos: TPoint; Shift: TShiftState); override;
  end;

{ TDDFormListboxItemEhSpec }

  TPopupListboxItemEhSpecType = (ptFilterSpecItemClearFilter,
    ptFilterSpecItemClearColumnFilter, ptFilterSpecItemDialog, ptFilterApply);

  TDDFormListboxItemEhSpec = class(TDDFormFilterPopupListboxItemEh)
  protected
    FType: TPopupListboxItemEhSpecType;
  public
    constructor Create(AType: TPopupListboxItemEhSpecType);

    function IsDataItem: Boolean; override;
    procedure Execute(Sender: TCustomListboxEh; ItemIndex: Integer; InItemPos: TPoint; Shift: TShiftState); override;
  end;

var
  DBGridFilterDropDownForm: TDBGridFilterDropDownForm;

  ListboxItemEhSortAsc: TDDFormListboxItemEhSort;
  ListboxItemEhSortDes: TDDFormListboxItemEhSort;

  ListboxItemEhClearFilter: TDDFormListboxItemEhSpec;
  ListboxItemEhClearColumnFilter: TDDFormListboxItemEhSpec;
  ListboxItemEhDialog: TDDFormListboxItemEhSpec;
  ListboxItemEhApplyFilter: TDDFormListboxItemEhSpec;

  DBGridFilterDropDownFormProc: function : TDBGridFilterDropDownForm = nil;

function GetDefaultDBGridFilterDropDownForm: TDBGridFilterDropDownForm;

implementation

uses Menus, DBGridEhToolCtrls, DBGridEhSimpleFilterDlg, EhLibLangConsts,
  DBUtilsEh;

{$R *.dfm}

function GetDefaultDBGridFilterDropDownForm: TDBGridFilterDropDownForm;
begin
  if DBGridFilterDropDownForm = nil then
    DBGridFilterDropDownForm := TDBGridFilterDropDownForm.Create(Application);
  Result := DBGridFilterDropDownForm;
end;

type
  TCustomDBGridEhCrack = class(TCustomDBGridEh);
  TSTColumnFilterEhCrack = class(TSTColumnFilterEh);

{ TDBGridFilterDropDownForm }

procedure TDBGridFilterDropDownForm.CustomDropDownFormEhCreate(Sender: TObject);
begin
  inherited CustomDropDownFormEhCreate(Sender);

  FSortButton1 := TDBGridMenuButtonEh.Create(Self);
  FSortButton1.Parent := Self;
  FSortButton1.Caption := EhLibLanguageConsts.STFilterListItem_SortingByAscend;
  FSortButton1.ActionItem := ListboxItemEhSortAsc;
  FSortButton1.OnClick := MenuButtonClick;
  FSortButton1.Height := FMenuItemHeight;
  FSortButton1.FCaptionMargin := FLeftMargin;
  FSortButton1.FSortState := smUpEh;
  FSortButton1.FDropDownForm := Self;

  FSortButton2 := TDBGridMenuButtonEh.Create(Self);
  FSortButton2.Parent := Self;
  FSortButton2.Caption := EhLibLanguageConsts.STFilterListItem_SortingByDescend;
  FSortButton2.ActionItem := ListboxItemEhSortDes;
  FSortButton2.OnClick := MenuButtonClick;
  FSortButton2.Height := FMenuItemHeight;
  FSortButton2.FCaptionMargin := FLeftMargin;
  FSortButton2.FSortState := smDownEh;
  FSortButton2.FDropDownForm := Self;

  FLineMenuButton1 := TDBGridMenuButtonEh.Create(Self);
  FLineMenuButton1.Parent := Self;
  FLineMenuButton1.Caption := cLineCaption;
  FLineMenuButton1.Enabled := False;
  FLineMenuButton1.Height := 5;
  FLineMenuButton1.FCaptionMargin := FLeftMargin;
  FLineMenuButton1.FDropDownForm := Self;

  FClearFilterButton := TDBGridMenuButtonEh.Create(Self);
  FClearFilterButton.Parent := Self;
  FClearFilterButton.Caption := EhLibLanguageConsts.STFilterListItem_ClearFilter;
  FClearFilterButton.ActionItem := ListboxItemEhClearFilter;
  FClearFilterButton.OnClick := MenuButtonClick;
  FClearFilterButton.Height := FMenuItemHeight;
  FClearFilterButton.FCaptionMargin := FLeftMargin;
  FClearFilterButton.FDropDownForm := Self;

  FClearColumnFilterButton := TDBGridMenuButtonEh.Create(Self);
  FClearColumnFilterButton.Parent := Self;
  FClearColumnFilterButton.Caption := EhLibLanguageConsts.STFilterListItem_ClearFilterInColumn;
  FClearColumnFilterButton.ActionItem := ListboxItemEhClearColumnFilter;
  FClearColumnFilterButton.OnClick := MenuButtonClick;
  FClearColumnFilterButton.Height := FMenuItemHeight;
  FClearColumnFilterButton.FCaptionMargin := FLeftMargin;
  FClearColumnFilterButton.FDropDownForm := Self;

  FCustomFilterButton := TDBGridMenuButtonEh.Create(Self);
  FCustomFilterButton.Parent := Self;
  FCustomFilterButton.Caption := EhLibLanguageConsts.STFilterListItem_CustomFilter;
  FCustomFilterButton.ActionItem := ListboxItemEhDialog;
  FCustomFilterButton.OnClick := MenuButtonClick;
  FCustomFilterButton.Height := FMenuItemHeight;
  FCustomFilterButton.FCaptionMargin := FLeftMargin;
  FCustomFilterButton.FDropDownForm := Self;

  FLineMenuButton2 := TDBGridMenuButtonEh.Create(Self);
  FLineMenuButton2.Parent := Self;
  FLineMenuButton2.Caption := cLineCaption;
  FLineMenuButton2.Enabled := False;
  FLineMenuButton2.Height := 5;
  FLineMenuButton2.FCaptionMargin := FLeftMargin;
  FLineMenuButton2.FDropDownForm := Self;

  FLineMenuButton2.Align := alTop;
  FCustomFilterButton.Align := alTop;
  FClearColumnFilterButton.Align := alTop;
  FClearFilterButton.Align := alTop;
  FLineMenuButton1.Align := alTop;
  FSortButton2.Align := alTop;
  FSortButton1.Align := alTop;
end;

procedure TDBGridFilterDropDownForm.InitOpening;
begin
  inherited InitOpening;
  FAutoSelectAllOnFilterSearching := True;
end;

procedure TDBGridFilterDropDownForm.RealignControls;
var
  FLTop: Integer;
  SearchEditTop: Integer;
begin
  inherited RealignControls;

  if (dghAutoSortMarking in Column.Grid.OptionsEh) and Column.Title.TitleButton then
  begin
    FSortButton1.Visible := True;
    FSortButton2.Visible := True;
    FLineMenuButton1.Visible := True;

    FSortButton1.Top := 0;
    FSortButton2.Top := FSortButton1.Top + FSortButton1.Height;
    FLineMenuButton1.Top := FSortButton2.Top + FSortButton2.Height;
    FClearFilterButton.Top := FLineMenuButton1.Top + FLineMenuButton1.Height;
    FClearColumnFilterButton.Top := FClearFilterButton.Top + FClearFilterButton.Height;
    FCustomFilterButton.Top := FClearColumnFilterButton.Top + FClearColumnFilterButton.Height;
    FLineMenuButton2.Top := FCustomFilterButton.Top + FCustomFilterButton.Height;

  end else
  begin
    FSortButton1.Visible := False;
    FSortButton2.Visible := False;
    FLineMenuButton1.Visible := False;

    FClearFilterButton.Top := 0;
    FClearColumnFilterButton.Top := FClearFilterButton.Top + FClearFilterButton.Height;
    FCustomFilterButton.Top := FClearColumnFilterButton.Top + FClearColumnFilterButton.Height;
    FLineMenuButton2.Top := FCustomFilterButton.Top + FCustomFilterButton.Height;

  end;

  SearchEditTop := FLineMenuButton2.Top + FLineMenuButton2.Height + 5;

  if UseRightToLeftAlignment then
  begin
    SearchEdit.SetBounds(
      5, SearchEditTop,
      ClientWidth - FLeftMargin - 5, SearchEdit.Height);

    FLTop := SearchEdit.Top + SearchEdit.Height + 5;
    FilterList.SetBounds(
      5, FLTop,
      ClientWidth - FLeftMargin - SearchEdit.Left, Panel1.Top - FLTop);
  end else
  begin
    SearchEdit.SetBounds(
      FLeftMargin, FLineMenuButton2.Top + FLineMenuButton2.Height + 5,
      ClientWidth - 5 - SearchEdit.Left, SearchEdit.Height);

    FLTop := SearchEdit.Top + SearchEdit.Height + 5;
    FilterList.SetBounds(
      FLeftMargin, FLTop,
      ClientWidth - 5 - SearchEdit.Left, Panel1.Top - FLTop);
  end;

  {$IFDEF EH_LIB_9}
  {$ELSE}
    {$IFDEF FPC}
    {$ELSE}
  Panel1.ParentBackground := False;
    {$ENDIF}
  {$ENDIF}
end;

procedure TDBGridFilterDropDownForm.MenuButtonClick(Sender: TObject);
var
  MenuButton: TMenuButtonEh;
begin
  MenuButton := TMenuButtonEh(Sender);
  if MenuButton.ActionItem <> nil then
  begin
    ModalResult := mrCancel;
    Close;
    MenuButton.ActionItem.Execute(FilterList, -1, Point(0,0), []);
  end;
end;

{$IFDEF FPC}
{$ELSE}
function TDBGridFilterDropDownForm.CanResize(var NewWidth,
  NewHeight: Integer): Boolean;
var
  CheckNewHeight: Integer;
  HeightDelta: Integer;
begin
  Result := inherited CanResize(NewWidth, NewHeight);
  if (FilterList <> nil) and (HandleAllocated) then
  begin
    HeightDelta := NewHeight - Height;
    CheckNewHeight := (FilterList.ClientHeight + HeightDelta) mod FilterList.DefaultRowHeight;
    NewHeight := NewHeight - CheckNewHeight;

    Result := True;
  end;
end;
{$ENDIF}

procedure TDBGridFilterDropDownForm.WMSettingChange(var Message: TMessage);
begin
  inherited;
  FCustomFilterButton.Caption := EhLibLanguageConsts.STFilterListItem_CustomFilter;
  FSortButton1.Caption := EhLibLanguageConsts.STFilterListItem_SortingByAscend;
  FSortButton2.Caption := EhLibLanguageConsts.STFilterListItem_SortingByDescend;
  FClearFilterButton.Caption := EhLibLanguageConsts.STFilterListItem_ClearFilter;
  FClearColumnFilterButton.Caption := EhLibLanguageConsts.STFilterListItem_ClearFilterInColumn;
  FCustomFilterButton.Caption := EhLibLanguageConsts.STFilterListItem_CustomFilter;
end;

procedure TDBGridFilterDropDownForm.UpdateAutoselectedAction;
begin
  if FAutoSelectAllOnFilterSearching and
     (SearchEdit.Text <> '') and
     (FilterList.Items.Count < SelectedValuesFilterLimit) then
  begin
    ClearAllSelected;
    SelectFilteredStateForRows(True);
  end;
end;

procedure TDBGridFilterDropDownForm.SearchEditUserChanged;
begin
  inherited SearchEditUserChanged;
  UpdateAutoselectedAction;
end;

procedure TDBGridFilterDropDownForm.SelectAllClicked(NewState: Boolean);
begin
  inherited SelectAllClicked(NewState);
  if (NewState = False)
    then FAutoSelectAllOnFilterSearching := True
    else FAutoSelectAllOnFilterSearching := False;
end;

procedure TDBGridFilterDropDownForm.DataItemsStateUserChanged;
begin
  inherited DataItemsStateUserChanged;
  FAutoSelectAllOnFilterSearching := False;
end;

function TDBGridFilterDropDownForm.CheckSelectedValues: Boolean;
var
  ListValuesLimit: Integer;
  I: Integer;
  SelectedVals: Integer;
  Msg: String;
begin
  Result := True;
  ListValuesLimit := SelectedValuesFilterLimit;
  if ListValuesLimit > 0 then
  begin
    SelectedVals := 0;

    for I := 0 to Length(ListValuesCheckingState) - 1 do
    begin
      if (ListValuesCheckingState[I]) then
        Inc(SelectedVals);
    end;

    if SelectedVals > ListValuesLimit then
    begin
      Result := False;
      KeepFormVisible := True;
      Msg := Format(EhLibLanguageConsts.FilterListValuesLimitExceeded, [ListValuesLimit]);
      ShowMessage(Msg);
      KeepFormVisible := False;
    end;
  end;
end;

function TDBGridFilterDropDownForm.SelectedValuesFilterLimit: Integer;
var
  DatasetFeatures: TDatasetFeaturesEh;
begin
  Result := -1;
  if (Column.Grid.DataSource <> nil) and (Column.Grid.DataSource.DataSet <> nil) then
  begin
    DatasetFeatures := GetDatasetFeaturesForDataSet(Column.Grid.DataSource.DataSet);
    if DatasetFeatures <> nil then
    begin
      Result := DatasetFeatures.GetFilterListValuesLimit(Column.Grid, Column.Grid.DataSource.DataSet);
    end;
  end;
end;

{ TDDFormFilterPopupListboxItemEh }

function TDDFormFilterPopupListboxItemEh.FilterForm(Listbox: TCustomListboxEh): TFilterDropDownForm;
begin
  Result := TFilterDropDownForm(Listbox.Owner);
end;

function TDDFormFilterPopupListboxItemEh.GetColumn(Listbox: TCustomListboxEh): TColumnEh;
begin
  Result := TDBGridFilterDropDownForm(Listbox.Owner).Column;
end;

function TDDFormFilterPopupListboxItemEh.GetGroupLevel(
  Listbox: TCustomListboxEh): TGridDataGroupLevelEh;
begin
  Result := nil;
end;

{ TDDFormListboxItemEhSort }

constructor TDDFormListboxItemEhSort.Create(ASortState: TSortMarkerEh);
begin
  inherited Create;
  FSortState := ASortState;
end;

procedure TDDFormListboxItemEhSort.Execute(Sender: TCustomListboxEh;
  ItemIndex: Integer; InItemPos: TPoint; Shift: TShiftState);
begin
  if GetGroupLevel(Sender) <> nil then
  begin
    if FSortState = smDownEh then
      GetGroupLevel(Sender).SortOrder := soAscEh
    else if FSortState = smUpEh then
      GetGroupLevel(Sender).SortOrder := soDescEh;
  end else
  begin
    GetColumn(Sender).Title.SortMarker := FSortState;
    TCustomDBGridEhCrack(GetColumn(Sender).Grid).DoSortMarkingChanged;
  end;
end;

function TDDFormListboxItemEhSort.IsDataItem: Boolean;
begin
  Result := False;
end;

{ TDDFormListboxItemEhSpec }

constructor TDDFormListboxItemEhSpec.Create(AType: TPopupListboxItemEhSpecType);
begin
  inherited Create;
  FType := AType;
end;

procedure TDDFormListboxItemEhSpec.Execute(Sender: TCustomListboxEh;
  ItemIndex: Integer; InItemPos: TPoint; Shift: TShiftState);
var
  Grid: TCustomDBGridEhCrack;
  ColumnFilter: TSTColumnFilterEhCrack;
begin
  Grid := TCustomDBGridEhCrack(GetColumn(Sender).Grid);
  case FType of
    ptFilterSpecItemClearFilter:
      begin
        Grid.ClearFilter;
        Grid.SetDataFilter;
      end;
    ptFilterSpecItemClearColumnFilter:
      begin
        GetColumn(Sender).STFilter.ExpressionStr := '';
        Grid.SetDataFilter;
      end;
    ptFilterSpecItemDialog:
      begin
        if StartDBGridEhColumnFilterDialog(GetColumn(Sender)) then
        begin
          if GetColumn(Sender).Grid.STFilter.InstantApply then
            Grid.SetDataFilter;
        end;
        Grid.SetFocus;
        Exit;
      end;
    ptFilterApply:
      begin
        ColumnFilter := TSTColumnFilterEhCrack(GetColumn(Sender).STFilter);
        ColumnFilter.UpdateFilterFromValuesCheckingState(
          FilterForm(Sender).BaseList, FilterForm(Sender).ListValuesCheckingState);
        Grid.SetDataFilter;
      end;
  end;
end;

function TDDFormListboxItemEhSpec.IsDataItem: Boolean;
begin
  Result := False;
end;

{ TDBGridMenuButtonEh }

procedure TDBGridMenuButtonEh.DrawSortMarker(ARect: TRect);
var
  SortMarkerIdx: Integer;
  Grid: TCustomDBGridEh;
  smSize: TSize;
  SMRect: TRect;
begin
  case FSortState of
    smDownEh: SortMarkerIdx := 0;
    smUpEh: SortMarkerIdx := 1;
  else SortMarkerIdx := -1;
  end;
  if (SortMarkerIdx >= 0) {and (ColorToRGB(Sender.Color) = ColorToRGB(clWindow))} then
    SortMarkerIdx := SortMarkerIdx + 3;
  if SortMarkerIdx <> -1 then
  begin
    Grid := TDBGridFilterDropDownForm(FDropDownForm).FColumn.Grid;
    smSize := Grid.Style.GetSortMarkerSize(Canvas, Grid.TitleParams.SortMarkerStyle);
    SMRect := Rect((ARect.Left + ARect.Right - smSize.cx) div 2,
                   (ARect.Bottom + ARect.Top - smSize.cy) div 2,
                   0, 0);
    SMRect.Right := SMRect.Left + smSize.cx - 1;
    SMRect.Bottom := SMRect.Top + smSize.cy - 1;
    Grid.Style.DrawSortMarker(Canvas, Grid.TitleParams.SortMarkerStyle,
      TDBGridFilterDropDownForm(FDropDownForm).FColumn, FSortState, False, SMRect);
  end;
end;

procedure TDBGridMenuButtonEh.Paint;
begin
  inherited Paint;
  if FSortState <> smNoneEh then
  begin
    if Parent.UseRightToLeftAlignment
      then DrawSortMarker(Rect(Width-Height, 0, Width, Height))
      else DrawSortMarker(Rect(0, 0, Height, Height));
  end;
end;

initialization
  ListboxItemEhSortAsc := TDDFormListboxItemEhSort.Create(smUpEh);
  ListboxItemEhSortDes := TDDFormListboxItemEhSort.Create(smDownEh);

  ListboxItemEhClearFilter := TDDFormListboxItemEhSpec.Create(ptFilterSpecItemClearFilter);
  ListboxItemEhClearColumnFilter := TDDFormListboxItemEhSpec.Create(ptFilterSpecItemClearColumnFilter);
  ListboxItemEhDialog := TDDFormListboxItemEhSpec.Create(ptFilterSpecItemDialog);

  DBGridFilterDropDownFormProc := @GetDefaultDBGridFilterDropDownForm;
finalization
  FreeAndNil(ListboxItemEhSortAsc);
  FreeAndNil(ListboxItemEhSortDes);
  FreeAndNil(ListboxItemEhClearFilter);
  FreeAndNil(ListboxItemEhClearColumnFilter);
  FreeAndNil(ListboxItemEhDialog);
end.
