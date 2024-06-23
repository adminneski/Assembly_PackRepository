{*******************************************************}
{                                                       }
{                      EhLib 10.2                       }
{                                                       }
{        Find dialog for TDBGridEh component            }
{                                                       }
{    Copyright (c) 2011-2022 by Dmitry V. Bolshakov     }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit DBGridEhSimpleFilterDlg;

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Messages, Types, Variants,
  {$IFDEF FPC}
    EhLibLCL, LCLType, DBGridsEh, MaskEdit, LMessages,
  {$ELSE}
    EhLibVCL, DBGridEh, Mask, Windows,
  {$ENDIF}
  StdCtrls, ExtCtrls, DBCtrlsEh, LanguageResManEh,
  ToolCtrlsEh;

type
  TDBGridEhSimpleFilterDialog = class(TForm)
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Bevel1: TBevel;
    rbAnd: TRadioButton;
    rbOr: TRadioButton;
    Label2: TLabel;
    Label3: TLabel;
    bOk: TButton;
    bCancel: TButton;
    DBComboBoxEh1: TDBComboBoxEh;
    DBComboBoxEh2: TDBComboBoxEh;
    DBDateTimeEditEh1: TDBDateTimeEditEh;
    DBDateTimeEditEh2: TDBDateTimeEditEh;
    DBNumberEditEh1: TDBNumberEditEh;
    DBNumberEditEh2: TDBNumberEditEh;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure DBComboBoxEh1Change(Sender: TObject);
  private
    procedure CMBiDiModeChanged(var Message: TMessage); message CM_BIDIMODECHANGED;
    procedure WMSettingChange(var Message: TMessage); message WM_SETTINGCHANGE;
  protected
    procedure ResourceLanguageChanged; virtual;
  public
    FieldValueList: IMemTableDataFieldValueListEh;
    Column: TColumnEh;
    ChildrenRightToLeft: Boolean;
    procedure Init;
    procedure InitSignComboBox(ComboBox: TComboBox);
    procedure InitValuesComboBox(ComboBox: TDBComboBoxEh; Pos: TPoint);
    procedure FillColumnValueList(Items: TStrings);
    procedure FillDialogFromColumnFilter(STFilter: TSTColumnFilterEh);
    procedure FillDialogFromColumnFilter1(Operator: TSTFilterOperatorEh; Operand: Variant; OperatorComboBox: TComboBox; OperandComboBox: TDBComboBoxEh);
    procedure SetFilterFromDialog;
    procedure SetFilterFromDialog1(out FilterString: String; OperatorComboBox: TComboBox; OperandComboBox: TDBComboBoxEh);
  end;

var
  DBGridEhSimpleFilterDialog: TDBGridEhSimpleFilterDialog;

function StartDBGridEhColumnFilterDialog(Column: TColumnEh): Boolean;

implementation

uses DBUtilsEh, EhLibLangConsts;

{$R *.dfm}

type
  TCustomDBGridEhCrack = class(TCustomDBGridEh) end;

{
0  ''
1  '='        
2  '<>'       
3  '>'        
4  '>='       
5  '<'        
6  '<='       
7  '%~'       
8  'Not %~'   
9  '~%'       
10 'Not ~%'   
11 '%~%'      
12 'Not %~%'  
13 '~'        
14 'Not ~'    
15 'In'       
16 'Not In'   
17 'Null'     
18 'Not Null' 
}

function CharAtPos(const S: String; Pos: Integer): Char;
begin
  if (Length(S) < Pos) or (Pos < 1) then
    Result := #0
  else
    Result := S[Pos];
end;

function StartDBGridEhColumnFilterDialog(Column: TColumnEh): Boolean;
begin
  if DBGridEhSimpleFilterDialog = nil then
    DBGridEhSimpleFilterDialog := TDBGridEhSimpleFilterDialog.Create(Application);

  DBGridEhSimpleFilterDialog.Column := Column;
  DBGridEhSimpleFilterDialog.Init;
  Result := False;
  if DBGridEhSimpleFilterDialog.ShowModal = mrOk then
    Result := True;
end;

procedure TDBGridEhSimpleFilterDialog.FormCreate(Sender: TObject);
begin
  Font.Name := String(DefFontData.Name);
  ResourceLanguageChanged;
  ChildrenRightToLeft := False;
end;

procedure TDBGridEhSimpleFilterDialog.FillDialogFromColumnFilter1(
  Operator: TSTFilterOperatorEh; Operand: Variant;
  OperatorComboBox: TComboBox; OperandComboBox: TDBComboBoxEh);
var
  StartMultyChar, EndMultyChar: Boolean;
begin
  StartMultyChar := False;
  EndMultyChar := False;
  OperandComboBox.Text := Column.STFilter.GetOperandAsString(Operator, Operand);

  case Operator of
    foNon:
      OperatorComboBox.ItemIndex := OperatorComboBox.Items.IndexOfObject(__TObject(0));
    foEqual:
      OperatorComboBox.ItemIndex := OperatorComboBox.Items.IndexOfObject(__TObject(1));
    foNotEqual:
      OperatorComboBox.ItemIndex := OperatorComboBox.Items.IndexOfObject(__TObject(2));
    foGreaterThan:
      OperatorComboBox.ItemIndex := OperatorComboBox.Items.IndexOfObject(__TObject(3));
    foLessThan:
      OperatorComboBox.ItemIndex := OperatorComboBox.Items.IndexOfObject(__TObject(5));
    foGreaterOrEqual:
      OperatorComboBox.ItemIndex := OperatorComboBox.Items.IndexOfObject(__TObject(4));
    foLessOrEqual:
      OperatorComboBox.ItemIndex := OperatorComboBox.Items.IndexOfObject(__TObject(6));
    foLike:
      begin
        OperatorComboBox.ItemIndex := OperatorComboBox.Items.IndexOfObject(__TObject(13));
        if (CharAtPos(OperandComboBox.Text, 1) = '%') and
          (CharAtPos(OperandComboBox.Text, 2) <> '%')
        then
          StartMultyChar := True;
        if (CharAtPos(OperandComboBox.Text, Length(OperandComboBox.Text)) = '%') and
          (CharAtPos(OperandComboBox.Text, Length(OperandComboBox.Text)-1) <> '%')
        then
          EndMultyChar := True;
        if StartMultyChar and EndMultyChar then
        begin
          OperatorComboBox.ItemIndex := OperatorComboBox.Items.IndexOfObject(__TObject(11));
          OperandComboBox.Text := Copy(OperandComboBox.Text, 2, Length(OperandComboBox.Text)-2);
        end else if StartMultyChar then
        begin
          OperatorComboBox.ItemIndex := OperatorComboBox.Items.IndexOfObject(__TObject(9));
          OperandComboBox.Text := Copy(OperandComboBox.Text, 2, Length(OperandComboBox.Text)-1);
        end else if EndMultyChar then
        begin
          OperatorComboBox.ItemIndex := OperatorComboBox.Items.IndexOfObject(__TObject(7));
          OperandComboBox.Text := Copy(OperandComboBox.Text, 1, Length(OperandComboBox.Text)-1);
        end;
      end;
    foNotLike:
      begin
        OperatorComboBox.ItemIndex := OperatorComboBox.Items.IndexOfObject(__TObject(14));
        if (CharAtPos(OperandComboBox.Text, 1) = '%') and
          (CharAtPos(OperandComboBox.Text, 2) <> '%')
        then
          StartMultyChar := True;
        if (CharAtPos(OperandComboBox.Text, Length(OperandComboBox.Text)) = '%') and
          (CharAtPos(OperandComboBox.Text, Length(OperandComboBox.Text)-1) <> '%')
        then
          EndMultyChar := True;
        if StartMultyChar and EndMultyChar then
        begin
          OperatorComboBox.ItemIndex := OperatorComboBox.Items.IndexOfObject(__TObject(12));
          OperandComboBox.Text := Copy(OperandComboBox.Text, 2, Length(OperandComboBox.Text)-2);
        end else if StartMultyChar then
        begin
          OperatorComboBox.ItemIndex := OperatorComboBox.Items.IndexOfObject(__TObject(10));
          OperandComboBox.Text := Copy(OperandComboBox.Text, 2, Length(OperandComboBox.Text)-1);
        end else if EndMultyChar then
        begin
          OperatorComboBox.ItemIndex := OperatorComboBox.Items.IndexOfObject(__TObject(8));
          OperandComboBox.Text := Copy(OperandComboBox.Text, 1, Length(OperandComboBox.Text)-1);
        end;
      end;
    foIn:
      OperatorComboBox.ItemIndex := OperatorComboBox.Items.IndexOfObject(__TObject(15));
    foNotIn:
      OperatorComboBox.ItemIndex := OperatorComboBox.Items.IndexOfObject(__TObject(16));
    foNull:
      OperatorComboBox.ItemIndex := OperatorComboBox.Items.IndexOfObject(__TObject(17));
    foNotNull:
      OperatorComboBox.ItemIndex := OperatorComboBox.Items.IndexOfObject(__TObject(18));
  end;
end;

procedure TDBGridEhSimpleFilterDialog.FillDialogFromColumnFilter(STFilter: TSTColumnFilterEh);
var
  AnExpression: TSTFilterExpressionEh;
begin
  AnExpression := STFilter.Expression;
  if STFilter.ListSource = nil then
    STFilter.CheckRecodeKeyList(AnExpression, False);
  FillDialogFromColumnFilter1(
    AnExpression.Operator1, AnExpression.Operand1,
    ComboBox1, DBComboBoxEh1
    );
  rbOr.Checked := (AnExpression.Relation = foOR);
  rbAnd.Checked := not rbOr.Checked;
  FillDialogFromColumnFilter1(
    AnExpression.Operator2, AnExpression.Operand2,
    ComboBox2, DBComboBoxEh2
    );
end;

procedure TDBGridEhSimpleFilterDialog.InitSignComboBox(ComboBox: TComboBox);
var
  CanLike: Boolean;
  CanCheckForGreaterLess: Boolean;
begin
  CanLike := True;
  CanCheckForGreaterLess := True;

  if (Column.Field <> nil) and
     (STFldTypeMapEh[Column.Field.DataType] in [botNumber, botDateTime, botBoolean])
  then
  begin
    CanLike := False
  end else if Column.STFilter.ListIsLookup then
  begin
    CanLike := False;
    CanCheckForGreaterLess := False;
  end;

  ComboBox.Items.Clear;
  ComboBox.Items.AddObject('',                 __TObject(0));
  ComboBox.Items.AddObject(EhLibLanguageConsts.SimpFilter_equals,           __TObject(1));
  ComboBox.Items.AddObject(EhLibLanguageConsts.SimpFilter_does_not_equal,   __TObject(2));

  if CanCheckForGreaterLess then
  begin
    ComboBox.Items.AddObject(EhLibLanguageConsts.SimpFilter_is_greate_than,   __TObject(3));
    ComboBox.Items.AddObject(EhLibLanguageConsts.SimpFilter_is_greate_than_or_equall_to, __TObject(4));
    ComboBox.Items.AddObject(EhLibLanguageConsts.SimpFilter_is_less_than,     __TObject(5));
    ComboBox.Items.AddObject(EhLibLanguageConsts.SimpFilter_is_less_than_or_equall_to, __TObject(6));
  end;

  if CanLike then
  begin
    {$IFDEF FPC}
    {$ELSE}
    ComboBox.Items.AddObject(EhLibLanguageConsts.SimpFilter_begins_with,      __TObject(7));
    ComboBox.Items.AddObject(EhLibLanguageConsts.SimpFilter_does_not_begin_with, __TObject(8));
    ComboBox.Items.AddObject(EhLibLanguageConsts.SimpFilter_ends_with,        __TObject(9));
    ComboBox.Items.AddObject(EhLibLanguageConsts.SimpFilter_does_not_end_with,__TObject(10));
    ComboBox.Items.AddObject(EhLibLanguageConsts.SimpFilter_contains,         __TObject(11));
    ComboBox.Items.AddObject(EhLibLanguageConsts.SimpFilter_does_not_contain, __TObject(12));
    ComboBox.Items.AddObject(EhLibLanguageConsts.SimpFilter_like,             __TObject(13));
    ComboBox.Items.AddObject(EhLibLanguageConsts.SimpFilter_not_like,         __TObject(14));
    {$ENDIF}
  end;

  ComboBox.Items.AddObject(EhLibLanguageConsts.SimpFilter_in_list,          __TObject(15));
  ComboBox.Items.AddObject(EhLibLanguageConsts.SimpFilter_not_in_list,      __TObject(16));
  ComboBox.Items.AddObject(EhLibLanguageConsts.SimpFilter_is_blank,         __TObject(17));
  ComboBox.Items.AddObject(EhLibLanguageConsts.SimpFilter_is_not_blank,     __TObject(18));

  ComboBox.DropDownCount := ComboBox.Items.Count;
end;

procedure TDBGridEhSimpleFilterDialog.InitValuesComboBox(ComboBox: TDBComboBoxEh; Pos: TPoint);
begin
  ComboBox.Left := Pos.X;
  ComboBox.Top := Pos.Y;
  ComboBox.Visible := True;
  ComboBox.Items.Clear;
  if Column.GetCurrentFieldValueList <> nil then
    FillColumnValueList(ComboBox.Items);
  ComboBox.Text := '';
end;

procedure TDBGridEhSimpleFilterDialog.FillColumnValueList(Items: TStrings);
var
  AGetValues: TStrings;
  i: Integer;
  lp: TDBGridColumnLookupDataEh;
  VarValue: Variant;
begin
  AGetValues := Column.GetCurrentFieldValueList.GetValues;

  Items.BeginUpdate;
  try
    for i := 0 to AGetValues.Count - 1 do
    begin
      if Column.LookupParams.LookupActive and
         (TCustomDBGridEhCrack(Column.Grid).MemTableSupport) and
         (Pos(';',Column.LookupParams.KeyFieldNames) = 0) then
      begin
        lp := Column.LookupParams;
        VarValue := AGetValues[i];
        if (Length(lp.LookupKeyFields) > 0) and
           not IsFieldTypeString(lp.LookupKeyFields[0].DataType) and
           (AGetValues[i] = '')
        then
          VarValue := Null;

        if lp.LookupDataSet.Locate(lp.LookupKeyFieldNames, VarValue, []) then
          Items.AddObject(lp.LookupDataSet.FieldValues[lp.LookupDisplayFieldName], nil)
        else if VarIsNull(VarValue) then
          Items.AddObject('', nil);
      end else
      begin
        Items.AddObject(AGetValues[i], nil);
      end;
    end;
  finally
    Items.EndUpdate;
  end;
end;

procedure TDBGridEhSimpleFilterDialog.Init;
begin
  InitSignComboBox(ComboBox1);
  InitSignComboBox(ComboBox2);
  InitValuesComboBox(DBComboBoxEh1, Point(Edit1.Left, Edit1.Top));
  InitValuesComboBox(DBComboBoxEh2, Point(Edit2.Left, Edit2.Top));

  FillDialogFromColumnFilter(Column.STFilter);
end;

procedure TDBGridEhSimpleFilterDialog.SetFilterFromDialog1(
  out FilterString: String; OperatorComboBox: TComboBox;
  OperandComboBox: TDBComboBoxEh);
var
  Oper: Integer;
  SValue: String;
begin
  FilterString := '';
  if OperatorComboBox.ItemIndex < 0 then
    OperatorComboBox.ItemIndex := 0;
  Oper := Integer(OperatorComboBox.Items.Objects[OperatorComboBox.ItemIndex]);
  case Oper of
    0: FilterString := '';
    1: FilterString := '=';  
    2: FilterString := '<>'; 
    3: FilterString := '>';  
    4: FilterString := '>='; 
    5: FilterString := '<';  
    6: FilterString := '<='; 

    7: FilterString := '~';  
    8: FilterString := '!~'; 
    9: FilterString := '~';  
    10: FilterString := '!~';  
    11: FilterString := '~';   
    12: FilterString := '!~';  
    13: FilterString := '~';   
    14: FilterString := '!~';  

    15: FilterString := 'in';  
    16: FilterString := '!in'; 

    17: FilterString := '=Null';  
    18: FilterString := '<>Null'; 
  end;
  SValue := OperandComboBox.Text;

  if Oper in [7,8,11,12] then
    SValue := SValue + '%';
  if Oper in [9,10,11,12] then
    SValue := '%' + SValue;

  if (Column.STFilter.Expression.ExpressionType = botString) and
     (Oper in [1..14])
  then
    SValue := '''' + SValue + '''';

  if Oper in [15,16] then
    SValue := '(' + SValue + ')';
  if not (Oper in [17,18]) and (SValue <> '') then
    FilterString := FilterString + SValue;
end;

procedure TDBGridEhSimpleFilterDialog.SetFilterFromDialog;
var
  FilterString1, FilterString2: String;
begin
  SetFilterFromDialog1(FilterString1, ComboBox1, DBComboBoxEh1);
  SetFilterFromDialog1(FilterString2, ComboBox2, DBComboBoxEh2);
  if FilterString2 <> '' then
  begin
    if rbOr.Checked
      then Column.STFilter.ExpressionStr := FilterString1 + ' OR ' + FilterString2
      else Column.STFilter.ExpressionStr := FilterString1 + ' AND ' + FilterString2
  end else
    Column.STFilter.ExpressionStr := FilterString1;
end;

procedure TDBGridEhSimpleFilterDialog.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := False;
  if ModalResult = mrOk then
    SetFilterFromDialog;
  CanClose := True;
end;

procedure TDBGridEhSimpleFilterDialog.DBComboBoxEh1Change(Sender: TObject);
begin
end;

procedure TDBGridEhSimpleFilterDialog.WMSettingChange(var Message: TMessage);
begin
  inherited;
  ResourceLanguageChanged;
end;

procedure TDBGridEhSimpleFilterDialog.CMBiDiModeChanged(var Message: TMessage);
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

procedure TDBGridEhSimpleFilterDialog.ResourceLanguageChanged;
begin
  Caption := EhLibLanguageConsts.DBGridEhSimpleFilterDialog_Caption; 
  Label1.Caption := EhLibLanguageConsts.DBGridEhSimpleFilterDialog_ShowRecordsWhere; 
  Label2.Caption := EhLibLanguageConsts.DBGridEhSimpleFilterDialog_OneCharWildcardInfo; 
  Label3.Caption := EhLibLanguageConsts.DBGridEhSimpleFilterDialog_SeveralCharsWildcardInfo; 
  rbOr.Caption := EhLibLanguageConsts.DBGridEhSimpleFilterDialog_Or_Caption; 
  rbAnd.Caption := EhLibLanguageConsts.DBGridEhSimpleFilterDialog_And_Caption; 

  bOk.Caption := EhLibLanguageConsts.OKButtonEh;
  bCancel.Caption := EhLibLanguageConsts.CancelButtonEh;
end;

end.
