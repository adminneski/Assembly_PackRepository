{*******************************************************}
{                                                       }
{                       EhLib 10.2                      }
{                    MemoEdit Dialog                    }
{                                                       }
{     Copyright (c) 2013-2022 by Dmitry V. Bolshakov    }
{                                                       }
{*******************************************************}

unit MemoEditFormsEh;

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms, Types,
  DropDownFormEh, Dialogs, Buttons, ExtCtrls, StdCtrls, DynVarsEh, ToolCtrlsEh;

type
  TMemoEditWinEh = class(TCustomDropDownFormEh)
    Memo1: TMemo;
    Panel1: TPanel;
    sbOk: TSpeedButton;
    sbCancel: TSpeedButton;
    Bevel1: TBevel;
    procedure sbOkClick(Sender: TObject);
    procedure sbCancelClick(Sender: TObject);
    procedure CustomDropDownFormEhReturnParams(Sender: TCustomDropDownFormEh;
      DynParams: TDynVarsEh);
    procedure CustomDropDownFormEhInitForm(Sender: TCustomDropDownFormEh;
      DynParams: TDynVarsEh);
    procedure CustomDropDownFormEhCreate(Sender: TObject);
  private
    FPassParams: TDropDownPassParamsEh;
  public
    class function GetGlobalRef: TCustomDropDownFormEh; override;
  end;

function DefaultShowMemoEditDialogEh(var Text: String; var FormPos: TRect; ReadOnly: Boolean): Boolean;

type
  TShowMemoEditDialogEhProg = function(var Text: String; var FormPos: TRect; ReadOnly: Boolean): Boolean;

var
  MemoEditWinEh: TMemoEditWinEh;

  ShowMemoEditDialogEhProg: TShowMemoEditDialogEhProg;

  DefaultMemoEditDropDownFormClassEh: TCustomDropDownFormEh;

implementation

uses EhLibLangConsts;

{$R *.dfm}

function DefaultShowMemoEditDialogEh(var Text: String; var FormPos: TRect; ReadOnly: Boolean): Boolean;
var
  AForm: TMemoEditWinEh;
  FDynParamsInteractorItfs: IDynParamsInteractableEh;
  DDParams: TDynVarsEh;
  OutDDParams: TDynVarsEh;
begin
  Result := False;
  AForm := TMemoEditWinEh(TMemoEditWinEh.GetGlobalRef);

  if Supports(AForm, IDynParamsInteractableEh, FDynParamsInteractorItfs) then
  begin
    DDParams := TDynVarsEh.Create(nil);
    try
    DDParams.CreateDynVar('', Text);
    FDynParamsInteractorItfs.SetInDynParams(DDParams);
    AForm.ReadOnly := ReadOnly;

    if TMemoEditWinEh.GetGlobalRef.ShowModal = mrOk then
    begin
      FDynParamsInteractorItfs.GetOutDynParams(OutDDParams);
      Text := VarToStr(OutDDParams.Items[0].Value);
      Result := True;
    end;
    finally
      DDParams.Free;
    end;
  end;
end;

procedure TMemoEditWinEh.CustomDropDownFormEhReturnParams(
  Sender: TCustomDropDownFormEh; DynParams: TDynVarsEh);
begin
  DynParams.Items[0].AsString := Memo1.Lines.Text;
end;

procedure TMemoEditWinEh.CustomDropDownFormEhCreate(Sender: TObject);
begin
  inherited;
  sbOk.Caption := EhLibLanguageConsts.OKButtonEh;
  sbCancel.Caption := EhLibLanguageConsts.CancelButtonEh;
  Caption := EhLibLanguageConsts.MemoEditWin_Caption; 
end;

procedure TMemoEditWinEh.CustomDropDownFormEhInitForm(
  Sender: TCustomDropDownFormEh; DynParams: TDynVarsEh);
begin
  if DynParams.Count = 0 then
    FPassParams := pspByFieldNamesEh
  else if DynParams.Count = 1 then
  begin
    FPassParams := pspFieldValueEh;
    Memo1.Lines.Text := DynParams.Items[0].AsString;
  end else
  begin
    FPassParams := pspRecordValuesEh;
    Memo1.Lines.Text := DynParams.Items[0].AsString;
  end;

  sbOk.Enabled := not ReadOnly;
  Memo1.ReadOnly := ReadOnly;
end;

class function TMemoEditWinEh.GetGlobalRef: TCustomDropDownFormEh;
begin
  if MemoEditWinEh = nil then
    Application.CreateForm(TMemoEditWinEh, MemoEditWinEh);
  Result := MemoEditWinEh;
end;

procedure TMemoEditWinEh.sbOkClick(Sender: TObject);
begin
  ModalResult := mrOk;
  if DropDownMode then
    Close;
end;

procedure TMemoEditWinEh.sbCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
  if DropDownMode then
    Close;
end;

initialization
  if GetClass(TMemoEditWinEh.ClassName) = nil then
    RegisterClass(TMemoEditWinEh);
  ShowMemoEditDialogEhProg := @DefaultShowMemoEditDialogEh;
end.
