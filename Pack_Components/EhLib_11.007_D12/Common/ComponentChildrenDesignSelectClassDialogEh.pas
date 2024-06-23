{*******************************************************}
{                                                       }
{                       EhLib 10.2                      }
{               TSelectImpExpClassForm form             }
{                                                       }
{   Copyright (c) 2015-2022 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit ComponentChildrenDesignSelectClassDialogEh;

interface

uses
  Windows, Messages, SysUtils, Variants, Contnrs,
  Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls;

type
  TSelectImpExpClassForm = class(TForm)
    bOk: TButton;
    bCancel: TButton;
    Bevel1: TBevel;
    ListBox1: TListBox;
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    procedure UpdateState;
  end;

var
  SelectImpExpClassForm: TSelectImpExpClassForm;

function SelectComponentChildEhClass(MasterComponentClass: TComponentClass): TComponentClass;

implementation

{$R *.dfm}

uses ComponentChildrenDesignEditorsEh;

function SelectComponentChildEhClass(MasterComponentClass: TComponentClass): TComponentClass;
var
  i: Integer;
  DesignService: TCompChildrenDesignServiceClassEh;
  CList: TClassList;
begin
  Result := nil;
  if SelectImpExpClassForm = nil then
    SelectImpExpClassForm := TSelectImpExpClassForm.Create(Application);

  SelectImpExpClassForm.ListBox1.Items.Clear;

  CList := TClassList.Create;
  DesignService := GetDesignServiceByClass(MasterComponentClass);
  DesignService.GetChildClasses(CList);

  for i := 0 to CList.Count-1 do
    SelectImpExpClassForm.ListBox1.Items.AddObject(
      TComponentClass(CList[i]).ClassName,
      TObject(CList[i]));

  SelectImpExpClassForm.UpdateState;

  if SelectImpExpClassForm.ShowModal = mrOk then
  begin
    Result := TComponentClass(
      SelectImpExpClassForm.ListBox1.Items.Objects[SelectImpExpClassForm.ListBox1.ItemIndex]);
  end;
  CList.Free;
end;

procedure TSelectImpExpClassForm.ListBox1Click(Sender: TObject);
begin
  UpdateState;
end;

procedure TSelectImpExpClassForm.ListBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  UpdateState;
end;

procedure TSelectImpExpClassForm.UpdateState;
begin
  bOk.Enabled := (ListBox1.ItemIndex >= 0);
end;

end.
