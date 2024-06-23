{*******************************************************}
{                                                       }
{                        EhLib 10.2                     }
{                                                       }
{                     TPlannerItemForm                  }
{                                                       }
{   Copyright (c) 2014-2022 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit PlannerItemDialog;

interface

uses
  {$IFDEF FPC}
    EhLibLCL, LMessages, LCLType, MaskEdit,
  {$ELSE}
    EhLibVCL, DBConsts, RTLConsts, Mask, Windows,
  {$ENDIF}
  Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls,
  DBCtrlsEh, PlannersEh, PlannerDataEh,
  DateUtils, ToolCtrlsEh, LanguageResManEh,
  ComCtrls, ExtCtrls;

type
  TPlannerItemForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Bevel1: TBevel;
    bvlAfterResource: TBevel;
    AllDayCheck: TCheckBox;
    OKButton: TButton;
    CancelButton: TButton;
    eTitle: TDBEditEh;
    cbStartTimeEdit: TDBComboBoxEh;
    cbFinishTimeEdit: TDBComboBoxEh;
    eBody: TDBMemoEh;
    Bevel3: TBevel;
    cbxRecource: TDBComboBoxEh;
    bevelAfterDateTime: TBevel;
    StartDateEdit: TDBDateTimeEditEh;
    EndDateEdit: TDBDateTimeEditEh;
    StartTimeEdit: TDBDateTimeEditEh;
    FinishTimeEdit: TDBDateTimeEditEh;
    procedure cbStartTimeEditEnter(Sender: TObject);
    procedure cbStartTimeEditChange(Sender: TObject);
    procedure StartDateEditEnter(Sender: TObject);
    procedure StartDateEditChange(Sender: TObject);
    procedure StartTimeEditChange(Sender: TObject);
    procedure StartTimeEditEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    FDeltaTime: TDateTime;
    FDeltaDate: TDateTime;
    procedure CMBiDiModeChanged(var Message: TMessage); message CM_BIDIMODECHANGED;
    procedure WMSettingChange(var Message: TMessage); message WM_SETTINGCHANGE;

  protected
    procedure ResourceLanguageChanged; virtual;

  public
    ChildrenRightToLeft: Boolean;

    function FormStarDate: TDateTime;
    function FormEndDate: TDateTime;

    procedure InitForm(Planner: TPlannerControlEh; Item: TPlannerDataItemEh);
  end;

var
  PlannerItemForm: TPlannerItemForm;

function EditPlanItem(Planner: TPlannerControlEh; Item: TPlannerDataItemEh): Boolean;
procedure EditNewItem(Planner: TPlannerControlEh);

implementation

uses EhLibLangConsts;

{$R *.dfm}

function EditPlanItem(Planner: TPlannerControlEh; Item: TPlannerDataItemEh): Boolean;
var
  AForm: TPlannerItemForm;
  FDummyCheckPlanItem, FOldPlanItemState: TPlannerDataItemEh;
  ErrorText: String;
  CheckChange: Boolean;
begin
  Result := False;
  AForm := TPlannerItemForm.Create(Application);
  try
    AForm.InitForm(Planner, Item);
    if AForm.ShowModal = mrOK then
    begin
      FDummyCheckPlanItem := Item.Source.CreateTmpPlannerItem;
      FOldPlanItemState := Item.Source.CreateTmpPlannerItem;
      try
        FDummyCheckPlanItem.Assign(Item);
        FDummyCheckPlanItem.Title := AForm.eTitle.Text;
        FDummyCheckPlanItem.Body := AForm.eBody.Text;
        FDummyCheckPlanItem.StartTime := AForm.FormStarDate;
        FDummyCheckPlanItem.EndTime := AForm.FormEndDate;
        FDummyCheckPlanItem.AllDay := AForm.AllDayCheck.Checked;
        if Item.Source.Resources.Count > 0 then
        begin
          if AForm.cbxRecource.ItemIndex >= 0 then
            FDummyCheckPlanItem.ResourceID := AForm.cbxRecource.KeyItems[AForm.cbxRecource.ItemIndex];
        end;
        FDummyCheckPlanItem.EndEdit(True);

        ErrorText := '';
        CheckChange :=
          Planner.CheckPlannerItemInteractiveChanging(
            Planner.ActivePlannerView, Item, FDummyCheckPlanItem, ErrorText);

        if CheckChange then
        begin
          FOldPlanItemState.Assign(Item);
          Item.BeginEdit;
          Item.Assign(FDummyCheckPlanItem);
          Item.EndEdit(True);
          Planner.PlannerItemInteractiveChanged(Planner.ActivePlannerView, Item, FOldPlanItemState);
          Result := True;
        end else
        begin
          ShowMessage(ErrorText);
          Result := False;
        end;
      finally
        FDummyCheckPlanItem.Free;
        FOldPlanItemState.Free;
      end;
    end;
  finally
    AForm.Free;
  end;
end;

procedure EditNewItem(Planner: TPlannerControlEh);
var
  StartTime, EndTime: TDateTime;
  PlanItem: TPlannerDataItemEh;
  AResource: TPlannerResourceEh;
begin
  if Planner.NewItemParams(StartTime, EndTime, AResource) then
  begin
    PlanItem := Planner.PlannerDataSource.NewItem;
    PlanItem.Title := 'New Item';
    PlanItem.Body := '';
    PlanItem.AllDay := False;
    PlanItem.StartTime := StartTime;
    PlanItem.EndTime := EndTime;
    if PlanItem.Source.Resources.Count > 0 then
      PlanItem.Resource := AResource;
    if EditPlanItem(Planner, PlanItem) then
    begin
      PlanItem.EndEdit(True);
    end else
      PlanItem.EndEdit(False);
  end;
end;

{ TPlannerItemForm }

procedure TPlannerItemForm.FormCreate(Sender: TObject);
begin
  ResourceLanguageChanged;
end;

procedure TPlannerItemForm.StartDateEditEnter(Sender: TObject);
begin
  if not VarIsNull(StartDateEdit.Value) and not VarIsNull(EndDateEdit.Value) then
    try
      FDeltaDate := VarToDateTime(EndDateEdit.Value) - VarToDateTime(StartDateEdit.Value);
    except
      on EConvertError do FDeltaTime := 0;
    end
  else
    FDeltaDate := -1;
end;

procedure TPlannerItemForm.StartDateEditChange(Sender: TObject);
begin
 if (FDeltaDate >= 0) and not VarIsNull(StartDateEdit.Value) then
   EndDateEdit.Value := StartDateEdit.Value + FDeltaDate;
end;

procedure TPlannerItemForm.StartTimeEditChange(Sender: TObject);
begin
 if FDeltaTime <> 0 then
   FinishTimeEdit.Value := StartTimeEdit.Value + FDeltaTime;
end;

procedure TPlannerItemForm.StartTimeEditEnter(Sender: TObject);
begin
  if (not VarIsNull(StartTimeEdit.Value)) and (not VarIsNull(FinishTimeEdit.Value)) then
    try
      FDeltaTime := FinishTimeEdit.Value - StartTimeEdit.Value;
    except
      on EConvertError do FDeltaTime := 0;
    end;
end;

procedure TPlannerItemForm.cbStartTimeEditEnter(Sender: TObject);
begin
  if (cbStartTimeEdit.Text <> '') and (cbFinishTimeEdit.Text <> '') then
    try
      FDeltaTime := StrToTime(cbFinishTimeEdit.Text) - StrToTime(cbStartTimeEdit.Text)
    except
      on EConvertError do FDeltaTime := 0;
    end;
end;

function TPlannerItemForm.FormStarDate: TDateTime;
begin
  Result := Trunc(VarToDateTime(StartDateEdit.Value)) + TimeOf(VarToDateTime(StartTimeEdit.Value));
end;

function TPlannerItemForm.FormEndDate: TDateTime;
begin
  Result := DateOf(VarToDateTime(EndDateEdit.Value)) + TimeOf(VarToDateTime(FinishTimeEdit.Value));
end;

procedure TPlannerItemForm.cbStartTimeEditChange(Sender: TObject);
var
  s: String;
  ATime: TDateTime;

  function IsDigit(c: Char): Boolean;
  begin
    Result := CharInSetEh(c, ['0','1','2','3','4','5','6','7','8','9',' '])
  end;

begin
  s := cbStartTimeEdit.Text;
  if (Length(s) = 5) and
     IsDigit(s[1]) and
     IsDigit(s[2]) and
     (s[3] = ':') and
     IsDigit(s[4]) and
     IsDigit(s[5])
  then
   if FDeltaTime <> 0 then
   begin
     ATime := StrToTime(cbStartTimeEdit.Text);
     cbFinishTimeEdit.Text := FormatDateTime('HH:MM', ATime + FDeltaTime);
   end;
end;

procedure TPlannerItemForm.InitForm(Planner: TPlannerControlEh; Item: TPlannerDataItemEh);
var
  i: Integer;
  Delta: Integer;
begin
  eTitle.Text := Item.Title;
  eBody.Text := Item.Body;

  StartDateEdit.OnChange := nil;
  StartDateEdit.Value := Item.StartTime;
  StartDateEdit.OnChange := StartDateEditChange;

  EndDateEdit.Value := Item.EndTime;
  AllDayCheck.Checked := Item.AllDay;

  StartTimeEdit.Value := TimeOf(Item.StartTime);
  FinishTimeEdit.Value := TimeOf(Item.EndTime);

  if (Item.Source.Resources.Count > 0) then
  begin
    for i := 0 to Item.Source.Resources.Count-1 do
    begin
      cbxRecource.Items.Add(Item.Source.Resources[i].Name);
      cbxRecource.KeyItems.Add(VarToStr(Item.Source.Resources[i].ResourceID));
    end;
    cbxRecource.ItemIndex := cbxRecource.KeyItems.IndexOf(VarToStr(Item.ResourceID));
  end else
  begin
    cbxRecource.Visible := False;
    bvlAfterResource.Visible := False;
    Delta := eBody.Top - (bevelAfterDateTime.Top + bevelAfterDateTime.Height);
    eBody.SetBounds(eBody.Left, bevelAfterDateTime.Top + bevelAfterDateTime.Height,
                    eBody.Width, eBody.Height + Delta);
  end;

  OKButton.Enabled := not Item.ReadOnly and (paoChangePlanItemEh in Planner.AllowedOperations);

  AllDayCheck.Enabled := OKButton.Enabled;
  eTitle.ReadOnly := not OKButton.Enabled;
  cbStartTimeEdit.ReadOnly := not OKButton.Enabled;
  cbFinishTimeEdit.ReadOnly := not OKButton.Enabled;
  eBody.ReadOnly := not OKButton.Enabled;
  cbxRecource.ReadOnly := not OKButton.Enabled;
  StartDateEdit.ReadOnly := not OKButton.Enabled;
  EndDateEdit.ReadOnly := not OKButton.Enabled;
  StartTimeEdit.ReadOnly := not OKButton.Enabled;
  FinishTimeEdit.ReadOnly := not OKButton.Enabled;
end;

procedure TPlannerItemForm.ResourceLanguageChanged;
begin
  Caption := EhLibLanguageConsts.PlannerItemForm_Caption;
  Label1.Caption := EhLibLanguageConsts.PlannerItemForm_Item_Title; 
  Label2.Caption := EhLibLanguageConsts.PlannerItemForm_Item_StartTime; 
  Label3.Caption := EhLibLanguageConsts.PlannerItemForm_Item_EndTime; 
  AllDayCheck.Caption := EhLibLanguageConsts.PlannerItemForm_AllDayCheck; 
  cbxRecource.ControlLabel.Caption := EhLibLanguageConsts.PlannerItemForm_Resource; 
  OKButton.Caption := EhLibLanguageConsts.OKButtonEh;
  CancelButton.Caption := EhLibLanguageConsts.CancelButtonEh;
end;

procedure TPlannerItemForm.WMSettingChange(var Message: TMessage);
begin
  inherited;
  ResourceLanguageChanged;
end;

procedure TPlannerItemForm.CMBiDiModeChanged(var Message: TMessage);

const
  TopRightAnchors = [akRight, akTop];
  TopLeftAnchors = [akLeft, akTop];
  BottomRightAnchors = [akRight, akBottom];
  BottomLeftAnchors = [akLeft, akBottom];

  procedure SetControlAnchors(RightToLeft: Boolean);
  begin
    if RightToLeft then
      begin
        Label1.Anchors := TopRightAnchors;
        Label2.Anchors := TopRightAnchors;
        Label3.Anchors := TopRightAnchors;
        StartDateEdit.Anchors := TopRightAnchors;
        StartTimeEdit.Anchors := TopRightAnchors;
        cbStartTimeEdit.Anchors := TopRightAnchors;
        EndDateEdit.Anchors := TopRightAnchors;
        FinishTimeEdit.Anchors := TopRightAnchors;
        cbFinishTimeEdit.Anchors := TopRightAnchors;
        AllDayCheck.Anchors := TopRightAnchors;

        OKButton.Anchors := BottomLeftAnchors;
        CancelButton.Anchors := BottomLeftAnchors;
      end
    else
      begin
        Label1.Anchors := TopLeftAnchors;
        Label2.Anchors := TopLeftAnchors;
        Label3.Anchors := TopLeftAnchors;
        StartDateEdit.Anchors := TopLeftAnchors;
        StartTimeEdit.Anchors := TopLeftAnchors;
        cbStartTimeEdit.Anchors := TopLeftAnchors;
        EndDateEdit.Anchors := TopLeftAnchors;
        FinishTimeEdit.Anchors := TopLeftAnchors;
        cbFinishTimeEdit.Anchors := TopLeftAnchors;
        AllDayCheck.Anchors := TopLeftAnchors;

        OKButton.Anchors := BottomRightAnchors;
        CancelButton.Anchors := BottomRightAnchors;
      end;
  end;

begin
  inherited;
  if UseRightToLeftAlignment and not ChildrenRightToLeft then
  begin
    ChildrenRightToLeft := True;
    cbxRecource.ControlLabelLocation.Position := lpRightTextBaselineEh;
    FlipChildren(True);
  end else if not UseRightToLeftAlignment and ChildrenRightToLeft then
  begin
    ChildrenRightToLeft := False;
    cbxRecource.ControlLabelLocation.Position := lpLeftTextBaselineEh;
    FlipChildren(True);
  end;
  SetControlAnchors(UseRightToLeftAlignment);
end;

end.
