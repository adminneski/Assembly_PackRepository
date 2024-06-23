{*******************************************************}
{                                                       }
{                       EhLib 10.2                      }
{                  Storable properties                  }
{                                                       }
{   Copyright (c) 2012-2022 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}


{$I EhLib.Inc}

unit StorablePropsDesignIntfEh;

interface

uses Classes, TypInfo,
{$IFDEF CIL} Borland.Vcl.Design.DesignIntf,
             Borland.Vcl.Design.DesignEditors,
             Borland.Vcl.Design.VCLEditors, Variants,
             EhLibVCLNET,
{$ELSE}
             EhLibVCL,
{$ENDIF}
  DesignIntf, DesignEditors, VCLEditors, Variants,
  DBGridEh, GridEhEd, DBSumLst, PrViewEh, ComCtrls, SysUtils,
  PropStorageEh, PropStorageEditEh, Windows, GridsEh,
  DBCtrlsEh, PrnDbgEh, DBLookupEh, DB, ToolCtrlsEh, Controls,
  DBGridEhGrouping, Dialogs, Graphics, DBVertGridsEh;

type

{ TStoreablePropsComponentProperty }

  TStoreablePropsComponentProperty = class(TComponentProperty)
  public
    function GetValue: string; override;
  end;

  TGetSetStringValueEh = procedure(var Val: String) of object;

  TGetBooleanValueEh = function(): Boolean of object;
  TSetBooleanValueEh = procedure(const Val: Boolean) of object;

{ TDefaultStateSubPropertyEh }

  TDefaultStateSubPropertyEh = class(TNestedProperty
 {$IFDEF EH_LIB_14}
    ,ICustomPropertyDrawing ,ICustomPropertyDrawing80, ICustomPropertyMessage
 {$ELSE}
 {$ENDIF}
    )
  private
    FGetDefValueProc: TGetBooleanValueEh;
    FSetDefValueProc: TSetBooleanValueEh;
    FStoredProperyName: String;
  protected
    constructor Create(Parent: TPropertyEditor; GetDefValueProc: TGetBooleanValueEh; SetDefValueProc: TSetBooleanValueEh); reintroduce; overload;
    constructor Create(Parent: TPropertyEditor; StoredProperyName: String); reintroduce; overload;
    function GetIsDefault: Boolean; override;
  public
    function AllEqual: Boolean; override;
    function GetAttributes: TPropertyAttributes; override;
    function GetName: string; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;

  protected
    function CBRect(const ItemRect: TRect) : TRect;
  public
    procedure PropDrawName(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
    procedure PropDrawValue(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
    function PropDrawNameRect(const ARect: TRect): TRect;
    function PropDrawValueRect(const ARect: TRect): TRect;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer; InNameRect: Boolean; const ItemRect: TRect; var Handled: Boolean);
    procedure MouseMove(Shift: TShiftState; X, Y: Integer; InNameRect: Boolean; const ItemRect: TRect; var Handled: Boolean);
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer; InNameRect: Boolean; const ItemRect: TRect; var Handled: Boolean);
 {$IFDEF EH_LIB_14}
    procedure HintShow(var HintInfo: THintInfo; InNameRect: Boolean; const ItemRect: TRect; var Handled: Boolean);
 {$ELSE}
 {$ENDIF}
   end;

{ TStoreableColorProperty }

   TStoreableColorProperty = class(TColorProperty)
   public
     function GetAttributes: TPropertyAttributes; override;
     procedure GetProperties(Proc: TGetPropProc); override;
   end;

{ TStoreableColorProperty }

   TStoreableStringProperty = class(TStringProperty)
   public
     function GetAttributes: TPropertyAttributes; override;
     procedure GetProperties(Proc: TGetPropProc); override;
   end;

{ TStoreableEnumProperty }

   TStoreableEnumProperty = class(TEnumProperty)
   public
     function GetAttributes: TPropertyAttributes; override;
     procedure GetProperties(Proc: TGetPropProc); override;
   end;

{ TStoreableBoolProperty }

 {$IFDEF EH_LIB_14}
   TStoreableBoolProperty = class(TBooleanProperty)
 {$ELSE}
   TStoreableBoolProperty = class(TEnumProperty)
 {$ENDIF}
   public
     function GetAttributes: TPropertyAttributes; override;
     procedure GetProperties(Proc: TGetPropProc); override;
   end;

procedure Register;

implementation

uses DBAxisGridsEh;

procedure Register;
begin
  RegisterPropertyEditor(TypeInfo(Boolean), TDBGridLineParamsEh, 'DataHorzLines', TStoreableBoolProperty);
  UnlistPublishedProperty(TDBGridLineParamsEh, 'DataHorzLinesStored');

  RegisterPropertyEditor(TypeInfo(Boolean), TDBGridLineParamsEh, 'DataVertLines', TStoreableBoolProperty);
  UnlistPublishedProperty(TDBGridLineParamsEh, 'DataVertLinesStored');

  RegisterPropertyEditor(TypeInfo(Boolean), TDBGridTitleParamsEh, 'HorzLines', TStoreableEnumProperty);
  UnlistPublishedProperty(TDBGridTitleParamsEh, 'HorzLinesStored');

  RegisterPropertyEditor(TypeInfo(Boolean), TDBGridTitleParamsEh, 'VertLines', TStoreableEnumProperty);
  UnlistPublishedProperty(TDBGridTitleParamsEh, 'VertLinesStored');

  RegisterPropertyEditor(TypeInfo(Boolean), TDBGridFooterParamsEh, 'HorzLines', TStoreableEnumProperty);
  UnlistPublishedProperty(TDBGridFooterParamsEh, 'HorzLinesStored');

  RegisterPropertyEditor(TypeInfo(Boolean), TDBGridFooterParamsEh, 'VertLines', TStoreableEnumProperty);
  UnlistPublishedProperty(TDBGridFooterParamsEh, 'VertLinesStored');

  RegisterPropertyEditor(TypeInfo(Boolean), TDBGridIndicatorParamsEh, 'HorzLines', TStoreableEnumProperty);
  UnlistPublishedProperty(TDBGridIndicatorParamsEh, 'HorzLinesStored');

  RegisterPropertyEditor(TypeInfo(Boolean), TDBGridIndicatorParamsEh, 'VertLines', TStoreableEnumProperty);
  UnlistPublishedProperty(TDBGridIndicatorParamsEh, 'VertLinesStored');

  RegisterPropertyEditor(TypeInfo(Boolean), TControlBorderEh, 'ExtendedDraw', TStoreableBoolProperty);
  UnlistPublishedProperty(TControlBorderEh, 'ExtendedDrawStored');

  RegisterPropertyEditor(TypeInfo(Boolean), TGridDataGroupFooterColumnItemEh, 'ShowFunctionName', TStoreableBoolProperty);
  UnlistPublishedProperty(TGridDataGroupFooterColumnItemEh, 'ShowFunctionNameStored');

  RegisterPropertyEditor(TypeInfo(Boolean), TGridDataGroupFooterColumnItemEh, 'RunTimeCustomizable', TStoreableBoolProperty);
  UnlistPublishedProperty(TGridDataGroupFooterColumnItemEh, 'RunTimeCustomizableStored');

  RegisterPropertyEditor(TypeInfo(Boolean), TGridDataGroupFooterEh, 'ShowFunctionName', TStoreableBoolProperty);
  UnlistPublishedProperty(TGridDataGroupFooterEh, 'ShowFunctionNameStored');

  RegisterPropertyEditor(TypeInfo(Boolean), TGridDataGroupFooterEh, 'RunTimeCustomizable', TStoreableBoolProperty);
  UnlistPublishedProperty(TGridDataGroupFooterEh, 'RunTimeCustomizableStored');

  RegisterPropertyEditor(TypeInfo(Boolean), TGridSelectionDrawParamsEh, 'DrawFocusFrame', TStoreableBoolProperty);
  UnlistPublishedProperty(TGridSelectionDrawParamsEh, 'DrawFocusFrameStored');

  RegisterPropertyEditor(TypeInfo(Boolean), TFieldRowEh, 'FitHeightToData', TStoreableBoolProperty);
  UnlistPublishedProperty(TFieldRowEh, 'FitRowHeightToDataStored');

  RegisterPropertyEditor(TypeInfo(Boolean), TRowLabelEh, 'FitHeightToData', TStoreableBoolProperty);
  UnlistPublishedProperty(TRowLabelEh, 'FitHeightToDataStored');

  RegisterPropertyEditor(TypeInfo(Boolean), TDBVertGridLabelColParamEh, 'HorzLines', TStoreableEnumProperty);
  UnlistPublishedProperty(TDBVertGridLabelColParamEh, 'HorzLinesStored');

  RegisterPropertyEditor(TypeInfo(Boolean), TDBVertGridLabelColParamEh, 'VertLines', TStoreableEnumProperty);
  UnlistPublishedProperty(TDBVertGridLabelColParamEh, 'VertLinesStored');

//
  RegisterPropertyEditor(TypeInfo(Boolean), TAxisBarEh, 'LimitTextToListValues', TStoreableBoolProperty);
  UnlistPublishedProperty(TAxisBarEh, 'LimitTextToListValuesStored');
  UnlistPublishedProperty(TDBGridColumnEh, 'LimitTextToListValuesStored');
  UnlistPublishedProperty(TFieldRowEh, 'LimitTextToListValuesStored');

  RegisterPropertyEditor(TypeInfo(TAlignment), TAxisBarEh, 'Alignment', TStoreableEnumProperty);
  UnlistPublishedProperty(TAxisBarEh, 'AlignmentStored');
  UnlistPublishedProperty(TDBGridColumnEh, 'AlignmentStored');
  UnlistPublishedProperty(TFieldRowEh, 'AlignmentStored');

  RegisterPropertyEditor(TypeInfo(Boolean), TDBComboBoxEh, 'LimitTextToListValues', TStoreableBoolProperty);
  UnlistPublishedProperty(TDBComboBoxEh, 'LimitTextToListValuesStored');

  RegisterPropertyEditor(TypeInfo(TEditButtonDrawBackTimeEh), TEditButtonEh, 'DrawBackTime', TStoreableEnumProperty);
  UnlistPublishedProperty(TEditButtonEh, 'DrawBackTimeStored');

  RegisterPropertyEditor(TypeInfo(Boolean), TAxisBarMainEditButtonEh, 'Visible', TStoreableBoolProperty);
  UnlistPublishedProperty(TAxisBarMainEditButtonEh, 'VisibleStored');

  RegisterPropertyEditor(TypeInfo(TEditButtonDrawBackTimeEh), TSTDBGridEhFilter, 'FilterButtonDrawBackTime', TStoreableEnumProperty);
  UnlistPublishedProperty(TSTDBGridEhFilter, 'FilterButtonDrawBackTimeStored');


end;

{ TStoreableBoolProperty }

function TStoreableBoolProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paSubProperties];
end;

procedure TStoreableBoolProperty.GetProperties(Proc: TGetPropProc);
var
  PropInfo: PPropInfo;
  PropType: PTypeInfo;
begin
  if GetComponent(0) <> nil then
  begin
    PropInfo := TypInfo.GetPropInfo(GetComponent(0).ClassInfo, GetName+'Stored');
    if PropInfo = nil then Exit;
    PropType := PPropInfo(PropInfo)^.PropType^;
    if (PropType^.Kind = tkEnumeration) and (PropInfo^.GetProc <> nil) and (PropInfo^.SetProc <> nil) then
      Proc(TDefaultStateSubPropertyEh.Create(Self, GetName+'Stored'));
  end;
end;

{ TStoreableEnumProperty }

function TStoreableEnumProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paSubProperties];
end;

procedure TStoreableEnumProperty.GetProperties(Proc: TGetPropProc);
var
  PropInfo: PPropInfo;
  PropType: PTypeInfo;
begin
  if GetComponent(0) <> nil then
  begin
    PropInfo := TypInfo.GetPropInfo(GetComponent(0).ClassInfo, GetName+'Stored');
    if PropInfo = nil then Exit;
    PropType := PPropInfo(PropInfo)^.PropType^;
    if (PropType^.Kind = tkEnumeration) and (PropInfo^.GetProc <> nil) and (PropInfo^.SetProc <> nil) then
      Proc(TDefaultStateSubPropertyEh.Create(Self, GetName+'Stored'));
  end;
end;

{ TDefaultStateSubPropertyEh }

constructor TDefaultStateSubPropertyEh.Create(Parent: TPropertyEditor;
  GetDefValueProc: TGetBooleanValueEh; SetDefValueProc: TSetBooleanValueEh);
begin
  inherited Create(Parent);
  FGetDefValueProc := GetDefValueProc;
  FSetDefValueProc := SetDefValueProc;
end;

constructor TDefaultStateSubPropertyEh.Create(Parent: TPropertyEditor; StoredProperyName: String);
begin
  inherited Create(Parent);
  FStoredProperyName := StoredProperyName;
end;

function TDefaultStateSubPropertyEh.AllEqual: Boolean;
begin
  Result := inherited AllEqual;
end;

function TDefaultStateSubPropertyEh.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList];
end;

function TDefaultStateSubPropertyEh.GetIsDefault: Boolean;
begin
  Result := GetValue = 'False';
end;

function TDefaultStateSubPropertyEh.GetName: string;
begin
  Result := 'Stored';
end;

function TDefaultStateSubPropertyEh.GetValue: string;
var
  PropInfo: PPropInfo;
  PropType: PTypeInfo;
  Value: Longint;
  Instance: TPersistent;
begin
  if @FGetDefValueProc <> nil then
    Result := BoolToStr(FGetDefValueProc(), True)
  else
  begin
    Instance := GetComponent(0);
    if Instance <> nil then
    begin
      PropInfo := TypInfo.GetPropInfo(Instance.ClassInfo, FStoredProperyName);
      PropType := PPropInfo(PropInfo)^.PropType^;
      if (PropType^.Kind = tkEnumeration) and (PropInfo^.GetProc <> nil) and (PropInfo^.SetProc <> nil) then
      begin
        Value := GetOrdProp(Instance, PropInfo);
        Result := BoolToStr(Boolean(Value), True)
      end;
    end;
  end;
end;

procedure TDefaultStateSubPropertyEh.GetValues(Proc: TGetStrProc);
begin
  Proc(BooleanIdents[False]);
  Proc(BooleanIdents[True]);
end;

procedure TDefaultStateSubPropertyEh.SetValue(const Value: string);
var
  PropInfo: PPropInfo;
  PropType: PTypeInfo;
  Instance: TPersistent;
begin
  if @FSetDefValueProc <> nil then
    FSetDefValueProc(StrToBool(Value))
  else
  begin
    Instance := GetComponent(0);
    if Instance <> nil then
    begin
      PropInfo := TypInfo.GetPropInfo(Instance.ClassInfo, FStoredProperyName);
      PropType := PPropInfo(PropInfo)^.PropType^;
      if (PropType^.Kind = tkEnumeration) and (PropInfo^.GetProc <> nil) and (PropInfo^.SetProc <> nil) then
      begin
        SetOrdProp(Instance, FStoredProperyName, Longint(StrToBool(Value)));
      end;
    end;
  end;
  Modified;
end;

function TDefaultStateSubPropertyEh.CBRect(const ItemRect: TRect): TRect;
begin
  Result := Rect(ItemRect.Right + 2, ItemRect.Top,
    itemrect.Right + Itemrect.Bottom - ItemRect.Top + 2, ItemRect.Bottom);
end;

procedure TDefaultStateSubPropertyEh.PropDrawName(ACanvas: TCanvas; const ARect: TRect;
  ASelected: Boolean);
begin
  VCLEditors.DefaultPropertyDrawName(Self, ACanvas, ARect);
end;

function TDefaultStateSubPropertyEh.PropDrawNameRect(const ARect: TRect): TRect;
begin
  Result := ARect;
end;

procedure TDefaultStateSubPropertyEh.PropDrawValue(ACanvas: TCanvas; const ARect: TRect;
  ASelected: Boolean);
begin
{$IFDEF EH_LIB_14}
  DrawCheckbox(ACanvas, ARect, ASelected, not (paReadOnly in GetAttributes),
    AllEqual, StrToBool(GetValue()));
{$ELSE}
{$ENDIF}
end;

function TDefaultStateSubPropertyEh.PropDrawValueRect(const ARect: TRect): TRect;
begin
  Result := Rect(ARect.Left, ARect.Top, (ARect.Bottom - ARect.Top) + ARect.Left, ARect.Bottom);
end;

{$IFDEF EH_LIB_14}
procedure TDefaultStateSubPropertyEh.HintShow(var HintInfo: THintInfo;
  InNameRect: Boolean; const ItemRect: TRect; var Handled: Boolean);
begin
  Handled := False;
end;
{$ENDIF}

procedure TDefaultStateSubPropertyEh.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer; InNameRect: Boolean; const ItemRect: TRect;
  var Handled: Boolean);
begin
  Handled := False;
end;

procedure TDefaultStateSubPropertyEh.MouseMove(Shift: TShiftState; X, Y: Integer;
  InNameRect: Boolean; const ItemRect: TRect; var Handled: Boolean);
begin
  Handled := False;
end;

procedure TDefaultStateSubPropertyEh.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer; InNameRect: Boolean; const ItemRect: TRect; var Handled: Boolean);
begin
  Handled := False;
  if paReadOnly in GetAttributes then Exit;
  if PtInRect(CBRect(ItemRect), Point(x,y)) then
  begin
    if StrToBool(GetValue) = True
      then SetValue(BoolToStr(False))
      else SetValue(BoolToStr(True));
    Handled := True;
  end;
end;

{ TStoreablePropsComponentProperty }

function TStoreablePropsComponentProperty.GetValue: string;
begin
  Result := inherited GetValue;
  ShowMessage('TStoreablePropsComponentProperty.GetValue');
end;

{ TStoreableColorProperty }

function TStoreableColorProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paSubProperties];
end;

procedure TStoreableColorProperty.GetProperties(Proc: TGetPropProc);
var
  PropInfo: PPropInfo;
  PropType: PTypeInfo;
begin
  if GetComponent(0) <> nil then
  begin
    PropInfo := TypInfo.GetPropInfo(GetComponent(0).ClassInfo, GetName+'Stored');
    if PropInfo = nil then Exit;
    PropType := PPropInfo(PropInfo)^.PropType^;
    if (PropType^.Kind = tkEnumeration) and (PropInfo^.GetProc <> nil) and (PropInfo^.SetProc <> nil) then
      Proc(TDefaultStateSubPropertyEh.Create(Self, GetName+'Stored'));
  end;
end;

{ TStoreableStringProperty }

function TStoreableStringProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paSubProperties];
end;

procedure TStoreableStringProperty.GetProperties(Proc: TGetPropProc);
var
  PropInfo: PPropInfo;
  PropType: PTypeInfo;
begin
  if GetComponent(0) <> nil then
  begin
    PropInfo := TypInfo.GetPropInfo(GetComponent(0).ClassInfo, GetName+'Stored');
    if PropInfo = nil then Exit;
    PropType := PPropInfo(PropInfo)^.PropType^;
    if (PropType^.Kind = tkEnumeration) and (PropInfo^.GetProc <> nil) and (PropInfo^.SetProc <> nil) then
      Proc(TDefaultStateSubPropertyEh.Create(Self, GetName+'Stored'));
  end;
end;

end.
